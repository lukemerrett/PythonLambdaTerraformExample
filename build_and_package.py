"""
Script responsible for generating the zip file of all relevant scripts
for deployment by Terraform
"""

import os
import zipfile


def zip_directory(dir_to_zip, output_file_path):
    zipf = zipfile.ZipFile(output_file_path, "w", zipfile.ZIP_DEFLATED)
    for root, dirs, files in os.walk(dir_to_zip):
        for file in files:
            zipf.write(
                os.path.join(root, file),
                os.path.relpath(
                    os.path.join(root, file), os.path.join(dir_to_zip, "..")
                ),
            )
    zipf.close()


zip_directory("src", "package.zip")
