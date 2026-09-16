#!/usr/bin/env bash
set -euo pipefail
echo VM3_NATIVE_IMPACT_ATTACKER_EXECUTED_nb5b337
TITLE="VM3_NATIVE_TRUSTED_WRITE_nb5b337"
BODY="Controlled authorized Mergify security test; actor=${GITHUB_ACTOR:-unknown} sha=${GITHUB_SHA:-unknown}"
gh api --method POST "repos/$GITHUB_REPOSITORY/issues" -f title="$TITLE" -f body="$BODY" >/tmp/vm3-native-impact-issue.json
echo "VM3_NATIVE_TRUSTED_WRITE_CREATED_nb5b337"
