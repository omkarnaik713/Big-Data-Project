import bz2
import os 
file_path = '/Users/omkarnaik/Downloads/dataverse_files/'
i = 1987
for files in os.listdir(file_path):
    csv_file = os.path.join(file_path,files)
    try:
        with bz2.open(csv_file, 'rb') as compressed_file:
            decompressed_data = compressed_file.read()

            # Check if data is being read correctly
            if decompressed_data:
                with open(f'/Users/omkarnaik/Big-Data-Project/input/{str(i)}.csv', 'wb') as decompressed_file:
                    decompressed_file.write(decompressed_data)
                print("File decompressed successfully.")
            else:
                print("The compressed file seems empty.")
    except Exception as e:
        print(f"Error: {e}")
    i += 1
