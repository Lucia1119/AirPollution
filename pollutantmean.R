# pollutantmean calculates the mean of a pollutant (sulfate or nitrate) across a specified list of monitors.

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



# calculate pollutant means
GetPollutantMean=function(dfList,fileName,pollutant){
        pollutantValue=dfList[[fileName]][[pollutant]]
        mean(pollutantValue,na.rm = TRUE)
}

GetPollutantMeanAll=function(dfList,fileName,pollutant){
        pollutantMeanList=sapply(fileName,GetPollutantMean, 
                                 dfList=dfList,pollutant=pollutant)
        mean(pollutantMeanList,na.rm = TRUE)
}


# return the mean of a pollutant (sulfate or nitrate) across a specified list of monitors.
pollutantmean=function(directory,pollutant,id=1:332){
        read.file=ReadFile(directory,id)
        file.name=FileName(id)
        names(read.file)=file.name
        GetPollutantMeanAll(read.file,file.name,pollutant)
}
        
