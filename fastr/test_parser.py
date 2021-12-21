import os
import xml.etree.ElementTree as ET

def coverage_parser(coverage_file, lines_file):
    # print("\n\nCOVERAGE PARSER")
    # print("Getting coverage data from " + coverage_file)
    root = ET.parse(coverage_file).getroot()

    # print("Saving lines data to " + lines_file)
    file = open(lines_file, "w")

    count_root = 0
    count_file = 0
    for test_node in root.findall(".//*[@name='tests']"):
        count_root += 1
        for test_file in test_node.find("classes"):
            count_file += 1
            coverage_line = ""
            for coverage_node in test_file.find("lines"):
                coverage_line += (coverage_node.get("number")) + " "
            if coverage_line:
                file.write(coverage_line)
                file.write("\n")
    print("Test nodes count: " + str(count_root))
    # print("Test files count: " + str(count_file))
    # print("Finished parsing coverage data")
    file.close()
    
def blackbox_parser(tests_folder, bbox_file):
    # print("\n\nBLACKBOX PARSER")
    # print("Getting tests from " + tests_folder)
    file = open(bbox_file, "w")

    count_checked = 0
    count_valid = 0
    for test_file in os.listdir(tests_folder):
        count_checked += 1
        if test_file.endswith(".py") and test_file.startswith("test"):
            count_valid += 1
            filepath = os.path.join(tests_folder, test_file)
            tc_file = open(filepath, "r")
            tc = tc_file.read().replace('\n', '')
            file.write(filepath)
            file.write(" ")
            file.write(tc)
            file.write('\n')
        else:
            continue
        
    # print("Checked files: " + str(count_checked))
    # print("Valid tests: " + str(count_valid))
    # print("Finished parsing blackbox data")
    file.close()