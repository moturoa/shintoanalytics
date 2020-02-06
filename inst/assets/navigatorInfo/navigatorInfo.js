
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
