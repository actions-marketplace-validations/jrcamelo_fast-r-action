def create_example_bbox_file(bbox_file):
    # Copy the file bbox.txt in the same folder to bbox_file path
    with open("./testcov/bbox.txt") as f:
        with open(bbox_file, "w") as f2:
            for i in f:
                f2.write(i)
                
def create_example_lines_file(lines_file):
    # Copy the file lines.txt in the same folder to lines_file path
    with open("./testcov/lines.txt") as f:
        with open(lines_file, "w") as f2:
            for i in f:
                f2.write(i)