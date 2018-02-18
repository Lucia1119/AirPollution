# complete is a function that reads a directory full of files and reports the number of completely observed cases in each data file.

# download files
# file.url="https://d396qusza40orc.cloudfront.net/rprog%2Fdata%2Fspecdata.zip"
# if (!file.exists("specdata")){
#         download.file(file.url,destfile = "rprog%2Fdata%2Fspecdata.zip")
#         unzip(zipfile = "rprog%2Fdata%2Fspecdata.zip")
# }


# define table names
FormatIdName=function(id){
        sprintf("file%03d",id)
}

FileName=function(id=1:332){
        sapply(id,FormatIdName)
}


# read tables
FormatFilePath=function(directory,id=1:332){
        sprintf(".\\%s\\%03d.csv",directory,id)
}

ReadFile=function(directory,id=1:332){
        format.filepath=FormatFilePath(directory,id)
        lapply(format.filepath,read.csv)
        #read.csv(sprintf(".\\specdata\\%03d.csv",id),stringsAsFactors = FALSE)
}


# exclude N/A from monitor
CompleteRows=function(dfList,fileName){
        na.exclude(dfList[[fileName]])
}

CompleteRowsAll=function(dfList,fileName){
        lapply(fileName,CompleteRows,dfList=dfList)
}


# count number of rows of monitors
CountRows=function(dfList,fileName){
        nrow(dfList[[fileName]])
}

CountRowsAll=function(dfList,fileName){
        sapply(fileName,CountRows,dfList=dfList)
}


# return the number of completely observed cases in selected files
complete=function(directory,id=1:332){
        read.file=ReadFile(directory,id)
        file.name=FileName(id)
        names(read.file)=file.name
        
        complete.file=CompleteRowsAll(read.file,file.name)
        names(complete.file)=file.name
        
        nobs=CountRowsAll(complete.file,file.name)
        
        data.frame(id,nobs=unname(nobs))
}