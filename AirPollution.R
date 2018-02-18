# pollutantmean=function(directory,pollutant,id=1:332){}


FormatIdName=function(id){
        sprintf("file%03d",id)
}

FileName=function(id=1:332){
        sapply(id,FormatIdName)
}

FormatFilePath=function(directory,id=1:332){
        sprintf(".\\%s\\%03d.csv",directory,id)
}

ReadFile=function(directory,id=1:332){
        format.filepath=FormatFilePath(directory,id)
        sapply(format.filepath,read.csv)
        #read.csv(sprintf(".\\specdata\\%03d.csv",id),stringsAsFactors = FALSE)
}


