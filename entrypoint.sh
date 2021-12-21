#!/bin/bash
set -e

echo "#################################################"
echo "Starting ${GITHUB_WORKFLOW}:${GITHUB_ACTION}"

sh -c "$*"

echo "#################################################"
echo  "${INPUT_TEST_FOLDER} ${INPUT_TEST_COVERAGE} ${INPUT_LINES_FILE} ${INPUT_BBOX_FILE}"
echo "#################################################"
#ls -R "/"
echo "#################################################"
#ls -R "~/"
echo "#################################################"
echo "/"
ls "/"
echo "#################################################"
echo "#################################################"

echo '::set-output name=action_echo::enabled'
echo 'running3?'
echo '::set-output name=result::aaaaaaaaaaaaaaaa'

echo 'running1?'
echo '::set-output name=action_echo::enabled'
python3 "/fastr/wrapper.py" "${GITHUB_WORKSPACE}/${INPUT_TEST_FOLDER}" "${GITHUB_WORKSPACE}/${INPUT_TEST_COVERAGE}" "${GITHUB_WORKSPACE}/${INPUT_LINES_FILE}" "${GITHUB_WORKSPACE}/${INPUT_BBOX_FILE}" > /fastr/result.txt
echo '::set-output name=result::$(cat /fastr/result.txt)'


echo '::set-output name=action_echo::enabled'
echo 'running4?'


echo "#################################################"
echo "Completed ${GITHUB_WORKFLOW}:${GITHUB_ACTION}"