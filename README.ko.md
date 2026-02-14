# alive-analysis

AI 코딩 에이전트를 위한 데이터 분석 워크플로우 킷.

**ALIVE 루프**로 분석 프로세스를 구조화하세요 — 분석을 '끝내는 것'이 아니라 '살아있게' 만드세요.

```
ASK → LOOK → INVESTIGATE → VOICE → EVOLVE
 ?      👀       🔍          📢      🌱
```

## 왜 alive-analysis인가?

Claude에게 "이 데이터 분석해줘"라고 하면 일회성 답변을 받습니다. 구조도 없고, 추적도 안 되고, 팀과 공유할 방법도 없습니다. 한 달 뒤에는 뭘 결론 내렸는지 기억도 안 납니다.

alive-analysis가 이걸 해결합니다:

| | 없을 때 | alive-analysis 사용 시 |
|--|---------|----------------------|
| 프로세스 | 매번 다른 즉석 분석 | 구조화된 ALIVE 루프, 반복 가능 |
| 추적 | 채팅 히스토리에 묻힘 | 버전 관리된 파일, 검색 가능한 아카이브 |
| 품질 | 자기 검증 없음, 놓치기 쉬움 | 단계별 체크리스트와 품질 게이트 |
| 팀 공유 | 채팅에서 복사-붙여넣기 | Git 추적 문서, 청중별 메시지 |

## 예시 결과물

Quick 분석은 이렇게 생겼습니다:

```markdown
# Quick Investigation — 가입률 비교
> ID: Q-2026-0212-001 | Type: Comparison | Status: Archived

## ASK
"온보딩 플로우 A vs B — 어느 쪽 가입 완료율이 높은가?"
프레이밍: 비교 (어느 쪽이 나은가?)

## LOOK
| 세그먼트 | Flow A | Flow B | 유저 수 (A/B)   |
|----------|--------|--------|----------------|
| 오가닉   | 34%    | 41%    | 3,200 / 2,800  |
| 유료     | 28%    | 32%    | 1,500 / 1,200  |

## INVESTIGATE
모든 세그먼트에서 Flow B가 우수 (+6-7pp(퍼센트포인트)).
심슨의 역설 없음 (전체 추세가 모든 세그먼트와 일치).

## VOICE
Flow B 출시. D7 활성화율(7일 내 재방문율)을 카운터 메트릭으로 모니터링.
신뢰도: 🟢 높음 (오가닉), 🟡 중간 (유료 — 샘플 적음)

## EVOLVE
후속 분석: 간소화된 가입이 유저 퀄리티에 영향? D30 활성화율 확인.
```

전체 예시는 [`examples/`](examples/)를 참고하세요.

## 이게 뭔가요?

alive-analysis는 다음을 도와줍니다:
- **구조화**: 분석 작업을 명확하고 반복 가능한 단계로 정리
- **추적**: 여러 분석을 병렬로 관리
- **아카이브**: 완료된 작업을 검색 가능한 요약과 함께 보관
- **품질 유지**: 내장된 체크리스트로 품질 관리

## 누구를 위한 건가요?

| | 데이터 분석가 | 비분석 직군 |
|--|--|--|
| 목표 | 심층적이고 체계적인 분석 | 가이드된 프레임워크로 빠른 분석 |
| 모드 | Full (5개 파일) | Quick (1개 파일) |
| ALIVE 루프 | 사고 프레임워크 | 분석 가이드 |
| 유형 | Investigation, Modeling, Simulation | 모든 유형 사용 가능 |
| 체크리스트 | 품질 자가 점검 | "이것만 확인하면 OK" 가드레일 |

## 빠른 시작

### 설치

```bash
# 프로젝트 디렉토리에서 실행 (alive-analysis 내부가 아님)
git clone https://github.com/with-geun/alive-analysis.git /tmp/alive-analysis
bash /tmp/alive-analysis/install.sh
```

자세한 설치 방법은 [INSTALL.md](INSTALL.md)를 참고하세요.

> **플러그인 설치**: 곧 지원 예정. 현재는 수동 설치를 이용하세요.

### 초기화 & 시작

```bash
/analysis init            # 전체 설정 (10개 질문)
/analysis init --quick    # 빠른 설정 (3개 질문)
/analysis new             # 첫 번째 분석 시작
```

### PM과 비분석 직군을 위해

North Star 메트릭이 뭔지 모르시나요? 괜찮습니다.

```bash
/analysis init --quick    # 언어, 팀 이름, 모드만 설정
/analysis new             # "Quick" 선택 → 바로 분석 시작
```

AI가 각 단계를 안내합니다. 이런 느낌입니다:

```
AI: "어떤 질문인가요? '왜 X가 발생했나' 인가요, 'X와 Y가 관련 있나' 인가요?"
나: "어제 가입률이 왜 떨어졌지?"
AI: "빠른 가설: 내부 원인 (버그, 배포) 아니면 외부 원인 (경쟁사, 플랫폼)?"
나: "어제 배포가 있었어"
AI: "플랫폼별, 유저 유형별로 데이터를 확인해볼게요..."
```

PM 워크스루 전체 예시는 [`examples/quick-investigation.md`](examples/quick-investigation.md)를 참고하세요.

## 호환성

`SKILL.md`는 오픈 표준입니다. alive-analysis는 이를 지원하는 에이전트에서 작동합니다.

| 에이전트 | Skills | Commands | Hooks |
|---------|--------|----------|-------|
| **Claude Code** | `.claude/skills/` | `.claude/commands/` | `.claude/hooks.json` |
| **Cursor 2.4+** | `.cursor/skills/` | `.cursor/commands/` | `.cursor/hooks.json` |
| **Codex** | `.codex/skills/` | — | — |

> 설치 스크립트가 Cursor를 자동 감지하여 `.claude/`와 `.cursor/` 모두에 설치합니다. `bash install.sh --cursor`로 Cursor 전용 설치도 가능합니다. Claude Code와 Cursor는 `hooks.json` 형식이 다르지만, 설치 스크립트가 자동으로 처리합니다.

## 명령어

### 분석
| 명령어 | 설명 |
|--------|------|
| `/analysis init` | 프로젝트에 alive-analysis 초기화 |
| `/analysis new` | 새 분석 시작 (Full 또는 Quick) |
| `/analysis status` | 현재 분석 대시보드 표시 |
| `/analysis next` | 다음 ALIVE 단계로 진행 |
| `/analysis archive` | 완료된 분석 아카이브 |
| `/analysis list` | 모든 분석 목록 (활성 + 아카이브, 태그 필터) |
| `/analysis promote` | Quick 분석을 Full로 승격 |

### 실험
| 명령어 | 설명 |
|--------|------|
| `/experiment new` | 새 A/B 테스트 시작 (Full 또는 Quick) |
| `/experiment next` | 다음 실험 단계로 진행 |
| `/experiment archive` | 완료된 실험 아카이브 |

### 모니터링
| 명령어 | 설명 |
|--------|------|
| `/monitor setup` | 메트릭 등록 및 모니터 생성 |
| `/monitor check` | 하나 또는 모든 모니터 헬스체크 실행 |
| `/monitor list` | 전체 모니터 상태 대시보드 표시 |

### 모델링
| 명령어 | 설명 |
|--------|------|
| `/model register` | 배포된 모델 등록 (버전 추적) |

## ALIVE 루프

### ASK — 질문 정의
무엇을 알고 싶은가? 문제, 범위, 성공 기준을 설정합니다.

### LOOK — 데이터 관찰
데이터가 무엇을 보여주는가? 품질, 이상치, 샘플링을 확인합니다.

### INVESTIGATE — 심층 분석
왜 이런 일이 발생하는가? 가설을 세우고, 검증하고, 결과를 문서화합니다.

### VOICE — 결과 전달
어떻게 설명할 것인가? 각 청중에 맞게 메시지를 조정합니다.

### EVOLVE — 다음 질문 생성
다음에 무엇을 물어야 하는가? 회고하고, 후속 분석을 제안하고, 자동화 기회를 찾습니다.

## 분석 모드

### Full 분석
중요한 의사결정을 위한 모드. ALIVE 단계별 5개 파일과 전체 체크리스트를 생성합니다.

```
analyses/active/F-2026-0210-001_dau-drop/
├── 01_ask.md
├── 02_look.md
├── 03_investigate.md
├── 04_voice.md
├── 05_evolve.md
└── assets/
```

### Quick 분석
빠른 결과물을 위한 모드. 축약된 ALIVE 섹션과 5개 항목 체크리스트가 포함된 단일 파일.

```
analyses/active/quick_Q-2026-0210-002_retention-check.md
```

Quick 분석이 너무 커지면: `/analysis promote`

## 실험 (A/B 테스트)

ALIVE 루프를 통제 실험에 맞게 변형:

```
DESIGN → VALIDATE → ANALYZE → DECIDE → LEARN
  📐        ✅         🔬        🏁       📚
```

Full 실험은 사전 등록, 샘플 크기 계산, SRM 체크가 포함된 5개 파일을 생성합니다. Quick 실험은 저위험 테스트를 위한 단일 파일입니다.

## 메트릭 모니터링

구조화된 헬스체크와 알림으로 핵심 메트릭을 추적합니다.

```
모니터 설정 → 정기 체크 → 알림 → 조사로 에스컬레이션
```

EVOLVE에서 제안된 메트릭이 모니터링으로 자연스럽게 연결됩니다: 분석 중 메트릭을 제안한 후, `/monitor setup`으로 추적을 시작하세요.

## 커스터마이징

체크리스트는 `.analysis/checklists/`에 있습니다 — 팀 기준에 맞게 수정하세요. 변경사항은 Git으로 추적되므로 팀 규범이 자연스럽게 진화합니다.

## 로드맵

- **Phase 1** ✅: ALIVE 루프, Full/Quick 모드, 3가지 분석 유형, 체크리스트, 아카이브, 메트릭 제안 대화
- **Phase 2** ✅: A/B 테스트 실험, 메트릭 모니터링, Quick→Full 승격, 태그, 모델 레지스트리, 분석 윤리
- **Phase 3**: 팀 대시보드, 인사이트 검색, 자동 회고

## 기여하기

기여 방법은 [CONTRIBUTING.md](CONTRIBUTING.md)를 참고하세요.

## 용어집

주요 용어 설명은 [GLOSSARY.md](GLOSSARY.md)를 참고하세요.

## 라이선스

MIT
