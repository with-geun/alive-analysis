#!/usr/bin/env node
/**
 * alive-analysis MCP Server
 *
 * Exposes your alive-analysis project to any MCP-compatible AI client:
 * Claude Code, Zed, Windsurf, Cursor, Continue, etc.
 *
 * Tools:
 *   alive_list            — list analyses with optional filters
 *   alive_get             — read full content of an analysis by ID
 *   alive_search          — full-text search across all analysis files
 *   alive_dashboard_export — export JSON for the ALIVE Dashboard visualizer
 */

import { Server } from "@modelcontextprotocol/sdk/server/index.js";
import { StdioServerTransport } from "@modelcontextprotocol/sdk/server/stdio.js";
import {
  CallToolRequestSchema,
  ListToolsRequestSchema,
} from "@modelcontextprotocol/sdk/types.js";
import * as fs from "fs";
import * as path from "path";

// ─── Config ──────────────────────────────────────────────────────────────────
// Priority: ALIVE_ANALYSES_DIR env > first CLI arg > ./analyses
const ANALYSES_DIR =
  process.env.ALIVE_ANALYSES_DIR ||
  process.argv[2] ||
  path.join(process.cwd(), "analyses");

const STAGE_NAMES = ["ASK", "LOOK", "INVESTIGATE", "VOICE", "EVOLVE"];

// ─── Types ────────────────────────────────────────────────────────────────────
interface Analysis {
  id: string;
  title: string;
  type: string;
  mode: string;
  stage: string;
  stageIndex: number;
  created: string;
  updated: string;
  status: string;
  analyst: string;
  followups: string[];
  tags: string[];
  keyFinding: string | null;
  dir?: string; // internal — not exported to dashboard JSON
}

// ─── Parsing helpers ─────────────────────────────────────────────────────────
function extractId(folderName: string): string | null {
  const m = folderName.match(/^([FQESL]-\d{4}-\d{4}-\d+)/i);
  return m ? m[1].toUpperCase() : null;
}

function parseMetaYml(metaPath: string): Partial<Analysis> {
  if (!fs.existsSync(metaPath)) return {};
  const raw = fs.readFileSync(metaPath, "utf8");

  const analystMatch = raw.match(/^analyst:\s*(.+)$/m);
  const tagsMatch = raw.match(/^tags:\s*\[(.+)\]$/m);
  const followupsMatch = raw.match(/^followups:\s*\[(.+)\]$/m);
  const kfMatch = raw.match(/^keyFinding:\s*"?(.+?)"?\s*$/m);

  return {
    analyst: analystMatch ? analystMatch[1].trim() : "",
    tags: tagsMatch
      ? tagsMatch[1].split(",").map((t) => t.trim()).filter(Boolean)
      : [],
    followups: followupsMatch
      ? followupsMatch[1].split(",").map((t) => t.trim()).filter(Boolean)
      : [],
    keyFinding: kfMatch ? kfMatch[1].trim() : null,
  };
}

function parseAnalysisFolder(dir: string, status: string): Analysis | null {
  const folder = path.basename(dir);
  const id = extractId(folder);
  if (!id) return null;

  let files: string[];
  try {
    files = fs.readdirSync(dir).sort();
  } catch {
    return null;
  }

  // First markdown file (01_ask.md preferred)
  const firstFile =
    files.find((f) => f.match(/^01_.*\.md$/)) ||
    files.find((f) => f.endsWith(".md"));
  if (!firstFile) return null;

  const firstContent = fs.readFileSync(path.join(dir, firstFile), "utf8");

  // Title: strip "# STAGE — " prefix
  const titleMatch = firstContent.match(/^# (?:[A-Z]+ — )?(.+)$/m);
  const title = titleMatch ? titleMatch[1].trim() : folder;

  // Type
  const typeMatch = firstContent.match(
    /> Type:.*?(Investigation|Experiment|Simulation|Learn)/
  );
  const type = typeMatch ? typeMatch[1] : "Investigation";

  // Stage: count 01–05 files
  const stageFiles = files.filter((f) => f.match(/^0[1-5]_.*\.md$/));
  const stageIndex = Math.min(Math.max(stageFiles.length, 1), 5);
  const stage = STAGE_NAMES[stageIndex - 1];

  // Dates
  const createdMatch = firstContent.match(
    /> Created:\s*(\d{4}-\d{2}-\d{2})/
  );
  const created = createdMatch
    ? createdMatch[1]
    : new Date().toISOString().slice(0, 10);

  const lastStageFile =
    stageFiles.length > 0 ? stageFiles[stageFiles.length - 1] : firstFile;
  const lastContent = fs.readFileSync(
    path.join(dir, lastStageFile),
    "utf8"
  );
  const updatedMatch = lastContent.match(
    /> (?:Created|Updated):\s*(\d{4}-\d{2}-\d{2})/
  );
  const updated = updatedMatch ? updatedMatch[1] : created;

  const mode = folder.startsWith("quick_") ? "Quick" : "Full";

  const meta = parseMetaYml(path.join(dir, "meta.yml"));

  return {
    id,
    title,
    type,
    mode,
    stage,
    stageIndex,
    created,
    updated,
    status,
    analyst: meta.analyst ?? "",
    followups: meta.followups ?? [],
    tags: meta.tags ?? [],
    keyFinding: meta.keyFinding ?? null,
    dir,
  };
}

function loadAllAnalyses(): Analysis[] {
  const results: Analysis[] = [];

  const activeDir = path.join(ANALYSES_DIR, "active");
  if (fs.existsSync(activeDir)) {
    for (const entry of fs.readdirSync(activeDir)) {
      const full = path.join(activeDir, entry);
      if (fs.statSync(full).isDirectory()) {
        const a = parseAnalysisFolder(full, "active");
        if (a) results.push(a);
      }
    }
  }

  const archiveDir = path.join(ANALYSES_DIR, "archive");
  if (fs.existsSync(archiveDir)) {
    for (const month of fs.readdirSync(archiveDir)) {
      const monthDir = path.join(archiveDir, month);
      if (!fs.statSync(monthDir).isDirectory()) continue;
      for (const entry of fs.readdirSync(monthDir)) {
        const full = path.join(monthDir, entry);
        if (fs.statSync(full).isDirectory()) {
          const a = parseAnalysisFolder(full, "archived");
          if (a) results.push(a);
        }
      }
    }
  }

  return results;
}

// ─── MCP Server ───────────────────────────────────────────────────────────────
const server = new Server(
  { name: "alive-analysis", version: "1.3.0" },
  { capabilities: { tools: {} } }
);

server.setRequestHandler(ListToolsRequestSchema, async () => ({
  tools: [
    {
      name: "alive_list",
      description:
        "List analyses from alive-analysis project. Supports filtering by type, stage, status, analyst, and tags.",
      inputSchema: {
        type: "object",
        properties: {
          type: {
            type: "string",
            enum: ["Investigation", "Experiment", "Simulation", "Learn"],
            description: "Filter by analysis type",
          },
          stage: {
            type: "string",
            enum: ["ASK", "LOOK", "INVESTIGATE", "VOICE", "EVOLVE"],
            description: "Filter by current ALIVE stage",
          },
          status: {
            type: "string",
            enum: ["active", "archived"],
            description: "Filter by status",
          },
          analyst: {
            type: "string",
            description: "Filter by analyst name",
          },
          tags: {
            type: "array",
            items: { type: "string" },
            description: "Filter by tags (OR logic)",
          },
          limit: {
            type: "number",
            description: "Max results to return (default: 20)",
          },
        },
      },
    },
    {
      name: "alive_get",
      description:
        "Get the full content of an analysis by ID. Returns all stage files (ASK → LOOK → ...) concatenated.",
      inputSchema: {
        type: "object",
        properties: {
          id: {
            type: "string",
            description: "Analysis ID, e.g. F-2026-0303-001",
          },
        },
        required: ["id"],
      },
    },
    {
      name: "alive_search",
      description:
        "Full-text search across all analysis files. Returns matching analyses with file:line context snippets.",
      inputSchema: {
        type: "object",
        properties: {
          query: { type: "string", description: "Search query (case-insensitive)" },
          limit: {
            type: "number",
            description: "Max results (default: 10)",
          },
        },
        required: ["query"],
      },
    },
    {
      name: "alive_dashboard_export",
      description:
        "Export all analyses as JSON for the ALIVE Dashboard. Paste the output into the dashboard Load dialog.",
      inputSchema: {
        type: "object",
        properties: {
          team: {
            type: "string",
            description: "Team name for the dashboard header",
          },
        },
      },
    },
  ],
}));

server.setRequestHandler(CallToolRequestSchema, async (request) => {
  const { name, arguments: args = {} } = request.params;

  // ── alive_list ──────────────────────────────────────────────────────────────
  if (name === "alive_list") {
    let analyses = loadAllAnalyses();

    if (args.type) analyses = analyses.filter((a) => a.type === args.type);
    if (args.stage) analyses = analyses.filter((a) => a.stage === args.stage);
    if (args.status) analyses = analyses.filter((a) => a.status === args.status);
    if (args.analyst) analyses = analyses.filter((a) => a.analyst === args.analyst);
    if (Array.isArray(args.tags) && args.tags.length > 0) {
      analyses = analyses.filter((a) =>
        (args.tags as string[]).some((t) => a.tags.includes(t))
      );
    }

    const limit = (args.limit as number) || 20;
    analyses = analyses.slice(0, limit);

    if (analyses.length === 0) {
      return { content: [{ type: "text", text: "No analyses found." }] };
    }

    const header = `${"ID".padEnd(22)} ${"Type".padEnd(14)} ${"Stage".padEnd(12)} ${"Date".padEnd(12)} ${"Analyst".padEnd(10)} Title`;
    const sep = "-".repeat(100);
    const rows = analyses
      .map(
        (a) =>
          `${a.id.padEnd(22)} ${a.type.padEnd(14)} ${a.stage.padEnd(12)} ${a.created.padEnd(12)} ${(a.analyst || "—").padEnd(10)} ${a.title}`
      )
      .join("\n");

    return {
      content: [
        {
          type: "text",
          text: `Found ${analyses.length} analyses (dir: ${ANALYSES_DIR}):\n\n${header}\n${sep}\n${rows}`,
        },
      ],
    };
  }

  // ── alive_get ───────────────────────────────────────────────────────────────
  if (name === "alive_get") {
    const id = (args.id as string).toUpperCase();
    const analyses = loadAllAnalyses();
    const analysis = analyses.find((a) => a.id === id);

    if (!analysis?.dir) {
      return {
        content: [{ type: "text", text: `Analysis "${id}" not found in ${ANALYSES_DIR}.` }],
      };
    }

    const files = fs
      .readdirSync(analysis.dir)
      .filter((f) => f.endsWith(".md"))
      .sort();

    const meta = [
      `**ID:** ${analysis.id}`,
      `**Type:** ${analysis.type}`,
      `**Stage:** ${analysis.stage}`,
      `**Analyst:** ${analysis.analyst || "—"}`,
      `**Tags:** ${analysis.tags.join(", ") || "—"}`,
      `**Created:** ${analysis.created}`,
      `**Updated:** ${analysis.updated}`,
      analysis.keyFinding ? `**Key Finding:** ${analysis.keyFinding}` : null,
    ]
      .filter(Boolean)
      .join("  |  ");

    let content = `# ${analysis.title}\n\n${meta}\n\n---\n\n`;
    for (const file of files) {
      content += fs.readFileSync(path.join(analysis.dir, file), "utf8");
      content += "\n\n---\n\n";
    }

    return { content: [{ type: "text", text: content }] };
  }

  // ── alive_search ────────────────────────────────────────────────────────────
  if (name === "alive_search") {
    const query = (args.query as string).toLowerCase();
    const limit = (args.limit as number) || 10;
    const analyses = loadAllAnalyses();
    const results: string[] = [];

    for (const a of analyses) {
      if (results.length >= limit) break;

      const metaText =
        `${a.id} ${a.title} ${a.analyst} ${a.tags.join(" ")}`.toLowerCase();
      const snippets: string[] = [];

      if (a.dir) {
        const files = fs
          .readdirSync(a.dir)
          .filter((f) => f.endsWith(".md"))
          .sort();
        outer: for (const file of files) {
          const lines = fs
            .readFileSync(path.join(a.dir, file), "utf8")
            .split("\n");
          for (let i = 0; i < lines.length; i++) {
            if (lines[i].toLowerCase().includes(query)) {
              const ctx = lines
                .slice(Math.max(0, i - 1), i + 2)
                .join("\n")
                .trim();
              snippets.push(`  [${file}:${i + 1}] ${ctx}`);
              if (snippets.length >= 2) break outer;
            }
          }
        }
      }

      if (metaText.includes(query) || snippets.length > 0) {
        const badge = `**${a.id}** — ${a.title}`;
        const info = `(${a.type}, ${a.stage}, ${a.analyst || "—"}, ${a.created})`;
        results.push(`${badge} ${info}\n${snippets.join("\n")}`);
      }
    }

    if (results.length === 0) {
      return {
        content: [{ type: "text", text: `No results for "${args.query}".` }],
      };
    }

    return {
      content: [
        {
          type: "text",
          text: `Search: "${args.query}" — ${results.length} result(s)\n\n${results.join("\n\n")}`,
        },
      ],
    };
  }

  // ── alive_dashboard_export ──────────────────────────────────────────────────
  if (name === "alive_dashboard_export") {
    const analyses = loadAllAnalyses();
    const team = (args.team as string) || "My Team";

    const payload = {
      team,
      generated: new Date().toISOString().slice(0, 10),
      // Strip internal `dir` field before export
      analyses: analyses.map(({ dir, ...a }) => a),
    };

    return {
      content: [
        {
          type: "text",
          text:
            `Dashboard JSON (${analyses.length} analyses):\n\n` +
            "```json\n" +
            JSON.stringify(payload, null, 2) +
            "\n```\n\n" +
            "→ Open dashboard/alive-dashboard.html → click Load → paste this JSON.",
        },
      ],
    };
  }

  return {
    content: [{ type: "text", text: `Unknown tool: ${name}` }],
    isError: true,
  };
});

// ─── Start ────────────────────────────────────────────────────────────────────
const transport = new StdioServerTransport();
server.connect(transport);
