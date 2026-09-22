#!/usr/bin/env bash
set -euo pipefail
python3 - <<'PY'
import datetime, json, os, urllib.request, urllib.error, uuid
owner='livastic-vm3-mergify-lab-0911'
repo='vm3-team-author-freshness-260919'
head='517ca9303a6253d47dcc7d8282c6de7cac978b55'
pipeline_name='vm3-sourcechain-victim-pipeline-260922'
job_name='vm3-sourcechain-victim-trigger'
now=datetime.datetime.now(datetime.timezone.utc).replace(microsecond=0).isoformat().replace('+00:00','Z')
pipeline={
 'id':str(uuid.uuid4()),'graphql_id':'vm3-sourcechain-pipeline-probe','url':'https://api.buildkite.com/v2/organizations/vm3/pipelines/vm3-sourcechain-probe',
 'web_url':'https://buildkite.com/vm3/vm3-sourcechain-probe','name':pipeline_name,'description':None,'slug':'vm3-sourcechain-probe',
 'repository':f'git@github.com:{owner}/{repo}.git','branch_configuration':None,'default_branch':'main',
 'provider':{'id':'github','webhook_url':'','settings':{'publish_commit_status':True,'build_pull_requests':True,'build_pull_request_forks':False,'repository':f'{owner}/{repo}','trigger_mode':'code'}},
 'skip_queued_branch_builds':False,'cancel_running_branch_builds':False,
}
job_id=str(uuid.uuid4()); build_id=str(uuid.uuid4()); build_url='https://api.buildkite.com/v2/organizations/vm3/pipelines/vm3-sourcechain-probe/builds/1001'; web='https://buildkite.com/vm3/vm3-sourcechain-probe/builds/1001'
job={'id':job_id,'graphql_id':'vm3-sourcechain-job-probe','type':'script','name':job_name,'step_key':job_name,'step':{'id':'vm3-sourcechain-step','signature':None},'priority':{'number':0},'agent_query_rules':[],'state':'failed','build_url':build_url,'web_url':f'{web}#{job_id}','log_url':f'{build_url}/jobs/{job_id}/log','raw_log_url':f'{build_url}/jobs/{job_id}/log.txt','artifacts_url':'','command':'true','soft_failed':False,'exit_status':1,'signal':None,'signal_reason':None,'broken_reason':None,'artifact_paths':None,'created_at':now,'scheduled_at':now,'runnable_at':now,'concurrency_wait_time_ms':0,'started_at':now,'finished_at':now,'expired_at':None,'retried':False,'retried_in_job_id':None,'retries_count':0,'retry_source':None,'retry_type':None,'parallel_group_index':None,'parallel_group_total':None,'matrix':None,'agent':None,'retried_by':None}
build={'id':build_id,'graphql_id':'vm3-sourcechain-build-probe','url':build_url,'web_url':web,'number':1001,'state':'failed','blocked':False,'message':'VM3 sourcechain audience probe','commit':head,'branch':'main','env':{},'source':'api','creator':{'id':str(uuid.uuid4()),'name':'VM3 Source Test','email':'vm3-source@example.invalid'},'created_at':now,'scheduled_at':now,'started_at':now,'finished_at':now,'pipeline':pipeline,'jobs':[]}
payload={'event':'job.finished','job':job,'build':build,'pipeline':pipeline,'sender':{'id':str(uuid.uuid4()),'name':'VM3 Source Test'}}
url=f'https://api.mergify.com/v1/ci/{owner}/repositories/{repo}/buildkite/webhooks'
data=json.dumps(payload,separators=(',',':')).encode()
req=urllib.request.Request(url,data=data,method='POST',headers={'Content-Type':'application/json','Accept':'application/json','X-Buildkite-Token':os.environ['MERGIFY_TOKEN']})
try:
  with urllib.request.urlopen(req,timeout=20) as resp:
    print(f'VM3_SOURCECHAIN_BUILDKITE_PROBE status={resp.status}')
except urllib.error.HTTPError as exc:
  print(f'VM3_SOURCECHAIN_BUILDKITE_PROBE status={exc.code}')
PY
