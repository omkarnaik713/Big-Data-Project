import pandas as pd 
import os 
file_path = '/Users/omkarnaik/Big-Data-Project/input'

flag = 0
for file in os.listdir(file_path):
    csv_file = os.path.join(file_path, file)
    if flag == 0 :
        dataset = pd.read_csv(csv_file)
        flag = 1
    else : 
        data = pd.read_csv(csv_file)
        dataset = pd.concat([dataset,data])
print(dataset.info())