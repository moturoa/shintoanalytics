# shintoanalytics


R Package om binnen een Shiny applicatie login informatie naar een database te schrijven.

## Dependencies

Een configuratie bestand in `conf/config.yml` in de Shiny applicatie directory, met wachtwoorden etc. Vraag Remko om een kopietje.



## Voorbeeld

Zie `test/` voor een voorbeeld applicatie. De configuratie moet dus ook in `test/conf` geplaatst worden.


In de UI moet er geplaatst worden,

```
browserInfoDependencies()
```

(we gebruiken wat JS om browser info op te vragen).

In de server plaatsen we dit blok:

```
  observe({
    set_browser_info()
    nav <- input$navigatorInfo
    req(nav)
    
    
    resp <- shinto_write_user_login(user = get_user(), 
                            application = "package_test", 
                            nav = nav)
    
  })
```

Enigzins omslachtig maar het werkt.

