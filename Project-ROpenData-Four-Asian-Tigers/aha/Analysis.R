#安裝
#install.packages("ggplot2");
#install.packages("dplyr");

#清除變數
rm(list=ls(all=TRUE));

#讀入library

library(dplyr);
library(ggplot2);

#設定工作目錄
mainDir = '/Users/aha/Desktop/github/Four-Asian-Tigers/';
#setwd('/Volumes/AhaStorage/A_Project/23_R_SWIRL/');
setwd(mainDir);

#準備工作
subDir = "./img";
if(!file.exists(subDir)){
  dir.create(file.path(mainDir, subDir));
}


#讀入資料
Rawdata_HK = read.csv(stringsAsFactors=F,file='./HK/data.csv',skip=3);
Rawdata_Singapore = read.csv(stringsAsFactors=F,file='./Singapore/data.csv',skip=3);
Rawdata_Korea = read.csv(stringsAsFactors=F,file='./Korea/data.csv',skip=3);
Rawdata_China = read.csv(stringsAsFactors=F,file='./China/data.csv',skip=3);
Rawdata_USA = read.csv(stringsAsFactors=F,file='./USA/data.csv',skip=3);
Rawdata_Japan = read.csv(stringsAsFactors=F,file='./Japan/data.csv',skip=3);
Rawdata_Taiwan = read.csv(stringsAsFactors=F,file='./Taiwan.csv',skip=2);

#取出每個資料的人口, GDP(美元), 人均GDP, 年 - 南韓, 新加坡, 香港
extractCol <- function(df,year,colname){
  cols_name = paste("X",year,sep="");
  A = unlist(subset(df,select=cols_name,subset=c(Indicator.Name == colname)));
  names(A) = NULL;
  return(A);
}

extractData <- function(df,t){
  year = c(1970:2014);
  GDP = extractCol(df,year,"GDP at market prices (current US$)");
  GDP_GROWTH = extractCol(df,year,"GDP growth (annual %)");
  GDP_PER_CAP = extractCol(df,year,"GDP per capita (current US$)");
  GDP_PER_CAP_GROWTH = extractCol(df,year,"GDP per capita growth (annual %)");
  POP_GROWTH = extractCol(df,year,"Population growth (annual %)");
  POP = extractCol(df,year,"Population, total");
  ans = data.frame(year,GDP,GDP_GROWTH,GDP_PER_CAP,GDP_PER_CAP_GROWTH,POP_GROWTH,POP);
  ans = mutate(ans,type=t)
  return(ans);
}

Data_HK = extractData(Rawdata_HK,"HK")
Data_Singapore = extractData(Rawdata_Singapore,"Singapore")
Data_Korea = extractData(Rawdata_Korea,"Korean")
Data_USA = extractData(Rawdata_USA,"USA")
Data_China = extractData(Rawdata_China,"China")
Data_Japan = extractData(Rawdata_Japan,"Japan")

#取出每個資料的人口, GDP(美元), 人均GDP, 年 - 台灣
extractCol_Taiwan <- function(df){
  A = subset(df,select=c("X.","期中人口.人.","X..1","X.國內生產毛額GDP.名目值.百萬美元.","X.平均每人GDP.名目值.美元.","X..4","X..7"));
  names(A) = c("year","POP","POP_GROWTH","GDP","GDP_PER_CAP","GDP_GROWTH","GDP_PER_CAP_GROWTH");
  A = mutate(A,year=as.numeric(year),POP = as.numeric(POP),POP_GROWTH = as.numeric(POP_GROWTH),GDP = as.numeric(GDP),GDP_PER_CAP = as.numeric(GDP_PER_CAP),GDP_GROWTH = as.numeric(GDP_GROWTH),GDP_PER_CAP_GROWTH = as.numeric(GDP_PER_CAP_GROWTH));
  A = filter(A,year<=2014,year>=1970);
  A = mutate(A,type="Taiwan")
  return (A);
}

Data_Taiwan = extractCol_Taiwan(Rawdata_Taiwan);

#合併全部
Data_Total = rbind(Data_Taiwan,Data_Singapore,Data_Korea,Data_HK,Data_USA,Data_China,Data_Japan);



#畫出全部
graph_Tatol = ggplot(data=Data_Total,aes(x=year));
graph_Tatol + geom_point(aes(y=POP,colour=factor(type)));
ggsave("POP_FULL.png",path="./img");
graph_Tatol+geom_line(aes(y=GDP_GROWTH,colour=factor(type)));
ggsave("GDP_GROWTH_FULL.png",path="./img");
graph_Tatol+geom_line(aes(y=GDP_PER_CAP_GROWTH,colour=factor(type)));
ggsave("GDP_PER_CAP_GROWTH_FULL.png",path=subDir);

graph_Tatol+geom_bar(aes(y=GDP_PER_CAP_GROWTH,fill=factor(type)), position = "dodge",stat="identity");
ggsave("GDP_PER_CAP_GROWTH_FULL_Bar.png",path=subDir);

h1 = graph_Tatol+geom_point(aes(y=GDP_PER_CAP_GROWTH,colour=factor(type),size=GDP_PER_CAP_GROWTH))
h2 = h1+geom_hline(yintercept = 0)+geom_hline(yintercept = 8);
h2+geom_vline(xintercept = 1990)+geom_vline(xintercept = 2000)+geom_vline(xintercept = 2008)+geom_vline(xintercept = 1998);

ggsave("GDP_PER_CAP_GROWTH_FULL_POINT_LINE.png",path=subDir);

h1 = graph_Tatol+geom_line(aes(y=GDP_GROWTH,colour=factor(type)))
h2 = h1+geom_hline(yintercept = 0)+geom_hline(yintercept = 8);
h2+geom_vline(xintercept = 1990)+geom_vline(xintercept = 2000)+geom_vline(xintercept = 2008)+geom_vline(xintercept = 1998);

ggsave("GDP_GROWTH_FULL_POINT_LINE.png",path=subDir);


#畫部分的圖
plotRange <- function(from_year,to_year,subDir){
  w = paste(from_year,"_",to_year,sep="");
  Data_Part = filter(Data_Total,year>=from_year,year<=to_year);
  graph_Tatol = ggplot(data=Data_Part,aes(x=year));

  graph_Tatol + geom_point(aes(y=POP,colour=factor(type)));
  ggsave(paste("POP_",w,".png",sep=""),path=subDir);

  graph_Tatol+geom_line(aes(y=GDP_GROWTH,colour=factor(type)));
  ggsave(paste("GDP_GROWTH_",w,".png",sep=""),path=subDir);

  graph_Tatol+geom_line(aes(y=GDP_PER_CAP_GROWTH,colour=factor(type)));
  ggsave(paste("GDP_PER_CAP_GROWTH_",w,".png",sep=""),path=subDir);

  graph_Tatol+geom_bar(aes(y=GDP_PER_CAP_GROWTH,fill=factor(type)), position = "dodge",stat="identity");
  ggsave(paste("GDP_PER_CAP_GROWTH_",w,"_BAR.png",sep=""),path=subDir);
}

plotRange(1970,1990,subDir)
plotRange(2000,2014,subDir)
