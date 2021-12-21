import sys

from fastr_adequate import fastCS
from test_parser import coverage_parser, blackbox_parser
#from example_maker import create_example_bbox_file, create_example_lines_file

# print("FASTR WRAPPER")

# Argument check
if (len(sys.argv) != 5):
    print("Usage: python3 fastr_wrapper.py <tests_folder> <coverage_file> <lines_file> <bbox_file>")
    sys.exit(1)

tests_folder = sys.argv[1]
coverage_file = "/fastr/coverage.xml"
lines_file = sys.argv[3]
bbox_file = sys.argv[4]
# print("Tests folder: " + tests_folder)
# print("Coverage file: " + coverage_file)
# print("Lines file: " + lines_file)
# print("BBOX file: " + bbox_file)

blackbox_parser(tests_folder, bbox_file)
coverage_parser(coverage_file, lines_file)

# Test examples
# create_example_bbox_file(bbox_file)
# create_example_lines_file(lines_file)


# Execute Test Reduction
# print("\n\nFAST++")
fastr_output = fastCS(bbox_file, lines_file)
# print("Output: " + str(fastr_output))
# Get only the tests that should be executed
reduced_tests = fastr_output[3]
# print("Reduced Tests: " + str(reduced_tests))

# Test index starts from 1, subtract 1 from each of them
reduced_tests = [int(x) - 1 for x in reduced_tests]

print("FAST-R Reduced Tests\n")
# Match the test index with the test names in BBOX
with open(bbox_file) as f:
    for pos, i in enumerate(f):
        if pos in reduced_tests:
            test_path = i.split()[0]
            print(str(test_path))