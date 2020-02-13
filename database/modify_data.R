
setwd("test")
db <- shintoanalytics::shinto_db_connection("shintoanalytics")

dbExecute(db, glue("delete from logins")) 

dbGetQuery(db, "select * from logins limit 1")
