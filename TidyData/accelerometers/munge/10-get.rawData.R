# download zip file, unzip & remove .zip
# first part of our TidyData process : get the RAW data


cat('\nDownloading and unzipping data.Please wait')

download.file(readLines('./DataSet.url'), destfile = './data/DataSet.zip', 
              method='curl')
# DataSet <- unzip('./data/DataSet.zip')
unzip('./data/DataSet.zip', exdir = './data')
file.remove('./data/DataSet.zip')



if (file.exists('./data/UCI HAR Dataset/'))
{cat("Downloading and unzipping has completed succesfuly")}