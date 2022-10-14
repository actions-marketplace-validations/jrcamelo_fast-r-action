#!/bin/bash
set -e

sh -c "$*"

LINES_FILE="/fastr/lines.txt"
BBOX_FILE="/fastr/bbox.txt"
COVERAGE_FILE="/fastr/coverage.xml"
if [ -z "${INPUT_TEST_COVERAGE}" ]
then
      cd "${GITHUB_WORKSPACE}"
      TESTS_INIT="${GITHUB_WORKSPACE}/${INPUT_TEST_FOLDER}/__init__.py"
      test -f $TESTS_INIT || touch $TESTS_INIT
      python3 -m pytest --cov="${GITHUB_WORKSPACE}/${INPUT_TEST_FOLDER}/.." --cov-report=xml:/fastr/coverage.xml -q > /fastr/coverage_logs.txt || echo "ERROR: FATAL FAILURE ON COVERAGE FILE GENERATION"
      # python3 -m coverage run -m pytest
      # python3 -m coverage xml -o "/fastr/coverage.xml"
else
      COVERAGE_FILE="${INPUT_TEST_COVERAGE}"
fi


cd "/"

echo '::set-output name=action_echo::enabled'
# python3 "/fastr/wrapper.py" "${GITHUB_WORKSPACE}/${INPUT_TEST_FOLDER}" "${GITHUB_WORKSPACE}/${INPUT_TEST_COVERAGE}" "/fastr/lines.txt" "/fastr/bbox.txt"
python3 "/fastr/wrapper.py" "${GITHUB_WORKSPACE}/${INPUT_TEST_FOLDER}" "${COVERAGE_FILE}" "${LINES_FILE}" "${BBOX_FILE}" > /fastr/result.txt
RESULT=`cat /fastr/result.txt`
echo "$RESULT"
cd "${GITHUB_WORKSPACE}"
xargs rm -r </fastr/result.txt

echo '::set-output name=result::'$RESULT
