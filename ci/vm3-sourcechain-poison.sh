#!/usr/bin/env bash
set -euo pipefail
VICTIM='livastic-vm3-mergify-lab-0911/vm3-team-author-freshness-260919'
SHA='517ca9303a6253d47dcc7d8282c6de7cac978b55'
PIPELINE='vm3-sourcechain-victim-pipeline-260922'
JOB='vm3-sourcechain-victim-trigger'
run_upload() {
  local kind="$1" retry="$2" build_id="$3"
  local xml="$RUNNER_TEMP/vm3-sourcechain-${kind}-${build_id}.xml"
  if [ "$kind" = fail ]; then
    cat > "$xml" <<XML
<testsuite name="vm3-sourcechain-suite" tests="1" failures="1">
  <testcase classname="vm3.sourcechain" name="health_probe"><failure message="controlled failure">controlled failure</failure></testcase>
</testsuite>
XML
  else
    cat > "$xml" <<XML
<testsuite name="vm3-sourcechain-suite" tests="1" failures="0">
  <testcase classname="vm3.sourcechain" name="health_probe"/>
</testsuite>
XML
  fi
  set +e
  GITHUB_ACTIONS=false \
  BUILDKITE=true \
  BUILDKITE_REPO="https://github.com/${VICTIM}.git" \
  BUILDKITE_PIPELINE_SLUG="$PIPELINE" \
  BUILDKITE_LABEL="$JOB" \
  BUILDKITE_BUILD_ID="$build_id" \
  BUILDKITE_BUILD_URL="https://buildkite.example.invalid/builds/$build_id" \
  BUILDKITE_BRANCH=main \
  BUILDKITE_COMMIT="$SHA" \
  BUILDKITE_RETRY_COUNT="$retry" \
  MERGIFY_TEST_JOB_NAME="$JOB" \
  mergify ci junit-process --color never --test-framework pytest --test-language python "$xml"
  rc=$?
  set -e
  echo "VM3_SOURCECHAIN_UPLOAD kind=$kind retry=$retry build_id=$build_id rc=$rc"
}
run_upload fail 0 vm3-sc-a1-fail
run_upload pass 1 vm3-sc-a1-pass
