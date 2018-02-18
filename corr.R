# corr is a function that takes a directory of data files 
# and a threshold for complete cases and calculates the correlation between 
# sulfate and nitrate for monitor locations 
# where the number of completely observed cases is greater than the threshold. 

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



# calculate correlation of sulfate and nitrate by threshold
CalculateCorr=function(dfList,fileName,threshold){
        df=dfList[[fileName]]
        noRows=nrow(df)
        if (noRows>threshold){
                cor(df[["sulfate"]],df[["nitrate"]])
        }
        
}

CalculateCorrAll=function(dfList,fileName,threshold){
        corr.list=sapply(fileName,CalculateCorr,dfList=dfList,threshold=threshold)
        unlist(corr.list,use.names = FALSE)
}


# return a vector of correlation
corr=function(directory,id=1:332,threshold){
        read.file=ReadFile(directory,id)
        file.name=FileName(id)
        names(read.file)=file.name
        
        complete.file=CompleteRowsAll(read.file,file.name)
        names(complete.file)=file.name
        
        CalculateCorrAll(complete.file,file.name,threshold)
}