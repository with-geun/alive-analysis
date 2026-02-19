# Hints: INVESTIGATE Stage

## Level 1 (Direction)
You know Android is the problem, and the drop-off is at the password step. What changed on Android recently that could affect passwords?

## Level 2 (Specific)
Check the v2.8 release notes. Was there a change to password validation? Compare the error rates before and after the release.

## Level 3 (Near-answer)
v2.8 updated password validation rules (minimum 10 chars + special character). Android password error rate jumped from 6% to 72%. Server logs show 460 PWD_VALIDATION_FAIL errors. The new rules are too strict and the error message doesn't explain the new requirements clearly. This is the root cause.
