#!/bin/bash
set -e

echo "#################################################"
echo "Starting ${GITHUB_WORKFLOW}:${GITHUB_ACTION}"

sh -c "$*"

echo 'running1?'
echo '::set-output name=action_echo::enabled'
python3 -m fastr_wrapper test1 test2 linestest bboxtest > result.txt

echo '::set-output name=action_echo::enabled'
echo 'running3?'
echo '::set-output name=result::$(cat result.txt)'
echo '::set-output name=result::aaaaaaaaaaaaaaaa'

echo '::set-output name=action_echo::enabled'
echo 'running4?'


echo "#################################################"
echo "Completed ${GITHUB_WORKFLOW}:${GITHUB_ACTION}"