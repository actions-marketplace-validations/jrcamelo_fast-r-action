#!/bin/bash
set -e

echo "#################################################"

sh -c "$*"

python3 -m coverage xml -o "/fastr/coverage.xml" --source="${GITHUB_WORKSPACE}/${INPUT_TEST_FOLDER}"

echo '::set-output name=action_echo::enabled'
python3 "/fastr/wrapper.py" "${GITHUB_WORKSPACE}/${INPUT_TEST_FOLDER}" "${GITHUB_WORKSPACE}/${INPUT_TEST_COVERAGE}" "${GITHUB_WORKSPACE}/${INPUT_LINES_FILE}" "${GITHUB_WORKSPACE}/${INPUT_BBOX_FILE}"
python3 "/fastr/wrapper.py" "${GITHUB_WORKSPACE}/${INPUT_TEST_FOLDER}" "${GITHUB_WORKSPACE}/${INPUT_TEST_COVERAGE}" "${GITHUB_WORKSPACE}/${INPUT_LINES_FILE}" "${GITHUB_WORKSPACE}/${INPUT_BBOX_FILE}" > /fastr/result.txt
RESULT=`cat /fastr/result.txt`
echo "$RESULT"

echo '::set-output name=result::'$RESULT

echo "#################################################"
echo "Completed ${GITHUB_WORKFLOW}:${GITHUB_ACTION}"