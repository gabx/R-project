GoDir <- function (directory){
  #ask user where the directory is
  if(directory %in% list.dirs() == FALSE) 
    message(directory, " is not found \n",
            "please select one csv file in your specdata directory")    
  directory <- dirname(file.choose())
  message(directory)
}
