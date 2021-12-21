#!/bin/bash
set -e

sh -c "$*"

cd "${GITHUB_WORKSPACE}"
TESTS_INIT="${GITHUB_WORKSPACE}/${INPUT_TEST_FOLDER}/__init__.py"
test -f $TESTS_INIT || touch $TESTS_INIT

# python3 -m coverage run -m pytest
#       pytest --cov=. tests/ --cov-report xml
pytest --cov="/fastr/coverage.xml" "${GITHUB_WORKSPACE}/${INPUT_TEST_FOLDER}" --cov-report xml
# python3 -m coverage xml -o "/fastr/coverage.xml"
cd "/"

echo '::set-output name=action_echo::enabled'
python3 "/fastr/wrapper.py" "${GITHUB_WORKSPACE}/${INPUT_TEST_FOLDER}" "${GITHUB_WORKSPACE}/${INPUT_TEST_COVERAGE}" "/fastr/lines.txt" "/fastr/bbox.txt"
python3 "/fastr/wrapper.py" "${GITHUB_WORKSPACE}/${INPUT_TEST_FOLDER}" "${GITHUB_WORKSPACE}/${INPUT_TEST_COVERAGE}" "/fastr/lines.txt" "/fastr/bbox.txt" > /fastr/result.txt
RESULT=`cat /fastr/result.txt`
echo "$RESULT"

echo '::set-output name=result::'$RESULT

echo "Completed ${GITHUB_WORKFLOW}:${GITHUB_ACTION}"