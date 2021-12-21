#!/bin/bash
set -e

echo "#################################################"
echo "Starting ${GITHUB_WORKFLOW}:${GITHUB_ACTION}"

sh -c "$*"

echo "#################################################"
echo  "${INPUT_TEST_FOLDER} ${INPUT_TEST_COVERAGE} ${INPUT_LINES_FILE} ${INPUT_BBOX_FILE}"

echo "#################################################"
echo "${GITHUB_WORKSPACE}"
ls "${GITHUB_WORKSPACE}"
echo "#################################################"

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