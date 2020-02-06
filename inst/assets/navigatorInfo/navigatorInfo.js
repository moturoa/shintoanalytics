
Shiny.addCustomMessageHandler("navigatorInfo", function(data){
  
  
  let nav = {
   appCodeName: navigator.appCodeName,
   appName: navigator.appName,
   appVersion: navigator.appVersion,
   cookieEnabled: navigator.cookieEnabled,
   language: navigator.language,
   onLine: navigator.onLine,
   platform: navigator.platform,
   userAgent: navigator.userAgent 
  };
  
  Shiny.setInputValue("navigatorInfo", nav);
   

/*
  $.browser.msie;
  $.browser.webkit;
  $.browser.mozilla;
  $.browser.version
  $.browser.android
	
	$.browser.ipad
	$.browser.iphone
	
	$.browser.linux
	$.browser.mac
	$.browser.msedge
	
	$.browser.win
	$.browser.desktop
	$.browser.mobile */
  
}); 



Shiny.addCustomMessageHandler("browserInfo", function(data){
  
  
  let nav = {
     browser_msie: $.browser.msie,
     browser_webkit: $.browser.webkit,
     browser_mozilla: $.browser.mozilla,
     browser_version: $.browser.version,
     browser_android: $.browser.android,
     browser_linux: $.browser.linux,
  	 browser_max: $.browser.mac,
  	 browser_msedge: $.browser.msedge,
  	 browser_win: $.browser.win,
  	 browser_desktop: $.browser.desktop,
  	 browser_mobile: $.browser.mobile
  };
  
  Shiny.setInputValue("browserInfo", nav);

  
}); 






Shiny.addCustomMessageHandler("bowser", function(data){
  
  
  Shiny.setInputValue("bowserOutput", bowser);

  
}); 

