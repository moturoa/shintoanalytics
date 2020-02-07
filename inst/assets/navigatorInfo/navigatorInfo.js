
Shiny.addCustomMessageHandler("navigatorInfo", function(data){
  
  let win = window,
    doc = document,
    docElem = doc.documentElement,
    body = doc.getElementsByTagName('body')[0],
    x = win.innerWidth || docElem.clientWidth || body.clientWidth,
    y = win.innerHeight|| docElem.clientHeight|| body.clientHeight;
    
    
  let nav = {
   appCodeName: navigator.appCodeName,
   appName: navigator.appName,
   appVersion: navigator.appVersion,
   cookieEnabled: navigator.cookieEnabled,
   language: navigator.language,
   onLine: navigator.onLine,
   platform: navigator.platform,
   userAgent: navigator.userAgent,
   windowWidth: x,
   windowHeight: y,
   screenWidth: win.screen.width,
   screenHeight: win.screen.height
  };

  
  Shiny.setInputValue("navigatorInfo", nav);
   
  Shiny.setInputValue("bowserInfo", bowser);
}); 



