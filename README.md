# shintoanalytics


R Package om binnen een Shiny applicatie login informatie naar een database te schrijven.

## Dependencies

Een configuratie bestand in `conf/config.yml` in de Shiny applicatie directory, met wachtwoorden etc. Vraag Remko om een kopietje.



## Voorbeeld

Zie `test/` voor een voorbeeld applicatie. De configuratie moet dus ook in `test/conf` geplaatst worden.


In de UI moet er geplaatst worden,

```
shintoanalyticsDependencies()
```

(we gebruiken wat JS om browser info op te vragen).

In de server plaatsen we dit blok:

```
log_data <- shintoanalytics::log_user_data(user = "Remko", 
                         application = "testpackage", 
                         version = "0.0",
                         write_db = TRUE)
```

Het object `log_data` bevat twee reactive's, namelijk:
- `log_data$nav()` : Browser / OS / screen / etc. informatie.
- `log_data$db_response()` : Response van de DB als `write_db = TRUE` (TRUE is goed).

