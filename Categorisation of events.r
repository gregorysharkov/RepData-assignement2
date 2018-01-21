dsEvents <- unique(ds$EVTYPE)
dsEvents <- gsub("WINDBLIZZARD","WIND BLIZZARD",dsEvents)
dsEvents <- gsub("TSTM","THUNDERSTORM",dsEvents)
dsEvents <- gsub("WINDBLIZZARDFREEZING","WIND BLIZZARD FREEZING",dsEvents)
dsEvents <- gsub("CHILLBLIZZARD","CHILL BLIZZARD",dsEvents)
dsEvents <- gsub("WINDHEAVY","HEAVY WIND",dsEvents)
dsEvents <- gsub("WINDWIND","WIND",dsEvents)
dsEvents <- gsub("SNOWWIND","SNOW WIND",dsEvents)
dsEvents <- gsub("FLOODINGHEAVY","FLOODING HEAVY",dsEvents)
dsEvents <- gsub("FLOODRAINWINDS","FLOOD RAIN WIND",dsEvents)
dsEvents <- gsub("FLOODRAINWIND","FLOOD RAIN WIND",dsEvents)
dsEvents <- gsub("FLOODINGFLOOD","FLOOD",dsEvents)
dsEvents <- gsub("BLIZZARDHEAVY","BLIZZARD HEAVY",dsEvents)
dsEvents <- gsub("RAINFLOODING","RAIN FLOODING",dsEvents)
dsEvents <- gsub("TORNADOS","TORNADO",dsEvents)
dsEvents <- gsub("WINDSS","WINDS",dsEvents)
dsEvents <- gsub("EXTREMERECORD","EXTREME RECORD",dsEvents)
dsEvents <- gsub("CLOUDHAIL","CLOUD HAIL",dsEvents)
dsEvents <- gsub("ICESNOW","ICE SNOW",dsEvents)
dsEvents <- gsub("SNOWBLIZZARD","SNOW BLIZZARD",dsEvents)
dsEvents <- gsub("HAILWINDS","HAIL WIND",dsEvents)
dsEvents <- gsub("HAILWIND","HAIL WIND",dsEvents)
dsEvents <- gsub("WINDHAIL","HAIL WIND",dsEvents)
dsEvents <- gsub("THUNDERSTORMW","THUNDERSTORM",dsEvents)
dsEvents <- gsub("SQUALLS","SQUALL",dsEvents)
dsEvents <- gsub("BLIZZARDFREEZING","BLIZZARD FREEZING",dsEvents)
dsEvents <- gsub("ANDBLOWING","BLOWING",dsEvents)
dsEvents <- gsub("FLOODFLOOD","FLOOD",dsEvents)
dsEvents <- gsub("FLOODFLASHFLOOD","FLOOD FLASH",dsEvents)
dsEvents <- gsub("WINDRAIN","WIND RAIN",dsEvents)
dsEvents <- gsub("WINDHVY","HEAVY WIND",dsEvents)
dsEvents <- gsub("MUDSLIDELANDSLIDE","MUDSLIDE LANDSLIDE",dsEvents)
dsEvents <- gsub("WND","WIND",dsEvents)
dsEvents <- gsub("FLDG","FLOODING",dsEvents)
dsEvents <- gsub("FLD","FLOODING",dsEvents)
dsEvents <- gsub("FLOODSTRONG","FLOOD STRONG",dsEvents)

docs <- Corpus(VectorSource(dsEvents))
docs <- tm_map(docs, content_transformer(tolower))
docs <- tm_map(docs, removePunctuation)
docs <- tm_map(docs, removeNumbers)
docs <- tm_map(docs, removeWords,stopwords("english"))
docs <- tm_map(docs, removeWords, "summary")
docs <- tm_map(docs, removeWords, "january")
docs <- tm_map(docs, removeWords, "jan")
docs <- tm_map(docs, removeWords, "february")
docs <- tm_map(docs, removeWords, "feb")
docs <- tm_map(docs, removeWords, "march")
docs <- tm_map(docs, removeWords, "mar")
docs <- tm_map(docs, removeWords, "april")
docs <- tm_map(docs, removeWords, "apr")
docs <- tm_map(docs, removeWords, "may")
docs <- tm_map(docs, removeWords, "june")
docs <- tm_map(docs, removeWords, "jun")
docs <- tm_map(docs, removeWords, "july")
docs <- tm_map(docs, removeWords, "jul")
docs <- tm_map(docs, removeWords, "august")
docs <- tm_map(docs, removeWords, "aug")
docs <- tm_map(docs, removeWords, "septembre")
docs <- tm_map(docs, removeWords, "sep")
docs <- tm_map(docs, removeWords, "october")
docs <- tm_map(docs, removeWords, "oct")
docs <- tm_map(docs, removeWords, "november")
docs <- tm_map(docs, removeWords, "nov")
docs <- tm_map(docs, removeWords, "december")
docs <- tm_map(docs, removeWords, "dec")
docs <- tm_map(docs, removeWords, "mph")

docs <- tm_map(docs, stripWhitespace)


dtm <- DocumentTermMatrix(docs)
m <- as.matrix(dtm)
distMatrix <- dist(m,method="euclidean")
groups <- hclust(distMatrix,method="ward.D")
clNum <- 10
clusterCut<- cutree(groups,k=clNum)
plot(groups,cex=0.9, hang=-3)
rect.hclust(groups,k=clNum,border = "red")

dsEvents <- data.frame(Event = unique(ds$EVTYPE))
dsEvents$Group <- clusterCut

findFreqTerms(dtm)