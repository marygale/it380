############################################
#####           START CLEANING         #####
############################################
setwd("C:/Users/flori/Desktop/Data Mining")
df_jams<-read.csv("jams.csv")

#delete rows with empty user_id,artist & title
df_jams<-df_jams[!(is.na(df_jams$jam_id) | df_jams$jam_id==""), ]
df_jams<-df_jams[!(is.na(df_jams$user_id) | df_jams$user_id==""), ]
df_jams<-df_jams[!(is.na(df_jams$artist) | df_jams$artist==""), ]
df_jams<-df_jams[!(is.na(df_jams$title) | df_jams$title==""), ]

#delete rows with error created date
df_jams<-df_jams[!is.na(strptime(df_jams$creation_date,format="%Y-%m-%d")),]

#remnove columns creation_date,link & spotify_uri
df_jams$creation_date <- NULL
df_jams$link <- NULL
df_jams$spotify_uri <- NULL
df_jams$jam_id <- NULL

df_jams <- df_jams[which(!grepl("[^\x01-\x7F]+", df_jams$artist)),]
df_jams <- df_jams[which(!grepl("[^\x01-\x7F]+", df_jams$title)),]

df_jams <- df_jams[which(!grepl("[^\u0001-\u007F]+", df_jams$artist)),]
df_jams <- df_jams[which(!grepl("[^\u0001-\u007F]+", df_jams$title)),]


############################################
#####            END CLEANING          #####
############################################

df_jams<-read.csv("clean_jam_a.csv")
df_jamsList <- ddply(df_jams, c("user_id"), function(df1)paste(df1$song,collapse = ","))

df_jams$artist <- NULL
df_jams$title <- NULL

#REMOVE Errors
df_jamsList <- df_jamsList[-c(1:15), ]

write.csv(df_jams,"clean_jam_a_song.csv", quote = FALSE, row.names = TRUE)

txn = read.transactions(file="clean_jam_a.csv", rm.duplicates= FALSE, format="basket",sep=",",cols=1)
txn@itemInfo$labels <- gsub("\"","",txn@itemInfo$labels)

jam_rules<-apriori(txn,parameter = list(minlen=2,sup = 0.00001, conf = 0.0001, target="rules"))
inspect(jam_rules)

df_jam_rules <- as(jam_rules,"data.frame")
df_jam_rules$confidence <- df_jam_rules$confidence * 100
df_jam_rules$support <- df_jam_rules$support * nrow(df_jam_rules)

#Split Rules LHS => RHS
df_basket <- transform(df_basket, rules = colsplit(rules, pattern = "=>", names = c("lhs","rhs")))

#Remove curly brackets {}
df_basket$rules$lhs <- gsub("[[:punct:]]", "", df_basket$rules$lhs)
df_basket$rules$rhs <- gsub("[[:punct:]]", "", df_basket$rules$rhs)

#made lhs & rhs columns character
df_basket$rules$lhs <- as.character(df_basket$rules$lhs)
df_basket$rules$rhs <- as.character(df_basket$rules$rhs)


write.csv(df_jam_rules,"jav10.csv", quote = FALSE, row.names = FALSE)