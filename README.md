![](https://badgen.net/badge/shintolabs/obsolete/red)

**Gebruik [shintoshiny](https://bitbucket.org/shintolabs/shintoshiny)**

# shintoanalytics


R Package om binnen een Shiny applicatie login informatie naar een database te schrijven.

## Dependencies

Een configuratie bestand in `conf/config.yml` in de Shiny applicatie directory, met wachtwoorden etc. Vraag Remko om een kopietje.



## Implementatie

Op het moment moeten er meerdere aanpassingen gemaakt worden aan een applicatie om de login/systeem informatie te uploaden. Zie `test/` voor een voorbeeld applicatie.


1. Eenmalig per project, of om te updaten.

```
remotes::install_bitbucket("shintolabs/shintoanalytics", auth_user = "me", password = "123")
```


2. Package laden, bv. in R/load_packages.R


```
library(shintoanalytics)
```

3. Password/database info in conf/config.yml

(in default sectie)

Password in 1Password.

```
default:

  shintoanalytics:
    dbname: "shintoanalytics"
    dbhost: "devpostgres02.postgres.database.azure.com"
    dbport: 5432
    dbuser: "shintoanalytics@devpostgres02.postgres.database.azure.com"
    dbpassword: "<<PASSWORD>>"
```

4. Dependencies laden in ui.R (meestal in dashboardBody())

```
shintoanalyticsDependencies()
```

5. Login / Systeem info uploaden (server.R)


Eerst de user opvragen. Dit kan ook op een andere manier (uiteindelijk ook via shintohttpheaders).

```
get_user <- function(session = getDefaultReactiveDomain()){
  ifelse(is_empty(session$user), 
                     "unknown",
                     session$user)
}

current_user <- get_user()
```

Dan uploaden:

```
log_data <- shintoanalytics::log_user_data(
  user = current_user, 
  application = "application name",  # <--
  version = "1.0",   # <--
  write_db = TRUE,
  write_db_local = FALSE
)
```

Het object `log_data` bevat twee reactive's, namelijk:
- `log_data$nav()` : Browser / OS / screen / etc. informatie.
- `log_data$db_response()` : Response van de DB als `write_db = TRUE` (TRUE is goed).





