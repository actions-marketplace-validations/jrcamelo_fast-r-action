#!/bin/bash
set -e

echo "#################################################"

sh -c "$*"

cd "${GITHUB_WORKSPACE}"
TESTS_INIT="${GITHUB_WORKSPACE}/${INPUT_TEST_FOLDER}/__init__.py"
test -f $TESTS_INIT || touch $TESTS_INIT

python3 -m coverage run -m pytest
python3 -m coverage xml -o "/fastr/coverage.xml"
cd "/"

echo '::set-output name=action_echo::enabled'
python3 "/fastr/wrapper.py" "${GITHUB_WORKSPACE}/${INPUT_TEST_FOLDER}" "${GITHUB_WORKSPACE}/${INPUT_TEST_COVERAGE}" "${GITHUB_WORKSPACE}/${INPUT_LINES_FILE}" "${GITHUB_WORKSPACE}/${INPUT_BBOX_FILE}"
python3 "/fastr/wrapper.py" "${GITHUB_WORKSPACE}/${INPUT_TEST_FOLDER}" "${GITHUB_WORKSPACE}/${INPUT_TEST_COVERAGE}" "${GITHUB_WORKSPACE}/${INPUT_LINES_FILE}" "${GITHUB_WORKSPACE}/${INPUT_BBOX_FILE}" > /fastr/result.txt
RESULT=`cat /fastr/result.txt`
echo "$RESULT"

echo '::set-output name=result::'$RESULT

echo "#################################################"
echo "Completed ${GITHUB_WORKFLOW}:${GITHUB_ACTION}"