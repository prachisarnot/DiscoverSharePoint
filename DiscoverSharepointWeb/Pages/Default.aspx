﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="DiscoverSharepointWeb.Pages.Default" %>
<!DOCTYPE html>
 <!--[if lt IE 7]>      <html class="no-js lt-ie9 lt-ie8 lt-ie7"> </html><![endif]-->
 <!--[if IE 7]>         <html class="no-js lt-ie9 lt-ie8"> </html><![endif]-->
 <!--[if IE 8]>         <html class="no-js lt-ie9"> </html><![endif]-->
<!--[if (gt IE 9)]> <html class="ie10"> <![endif]-->
<!--[if !(IE)]><!--> <html class=""> <!--<![endif]-->
     <head id="Head1" runat="server"> 
          <meta charset="utf-8" />
         <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
         <meta name="keywords" content="Co-authoring,Apps for SharePoint,Business Insights,Business Intelligence,Calendar,Co-authoring,Collaboration,Community Sites,Dashboard,Enterprise Content Management,Enterprise Search,Enterprise Social,Excel,Excel Web App,FAST Search,Hover Panel,Mobility,Newsfeed,Notebook,OneNote,OneNote Web App,Outlook,Outlook Web App,People Search,Power Pivot,Profile,Project Management,Project Professional,Project Sites,Refiners,SharePoint 2013,Site Mailbox,Site Newsfeed,Sites,SkyDrive Pro,Tasks,Team Sites,Timeline,Versionning,Video Search,Word,Word Web App,Hover Panel,Newsfeed,Office 365,Power View,Team Sites" /> 
         <title>Discover SharePoint</title>
         <meta name="viewport" content="width=1200"/>
         <link rel="stylesheet" type="text/css" href="../Content/normalize.css" />
         <link rel="stylesheet" type="text/css" href="../Content/main.css" />
		 <link rel="stylesheet" type="text/css" href="../Content/styles.css" />
		<link rel="stylesheet" type="text/css" href="../Content/promo-metro.css">
        <link rel="stylesheet" type="text/css" href="../Content/style.css">
         <script src="../Scripts/modernizr-2.6.2.min.js"></script>
		 <script src="../Scripts/MicrosoftAjax.js" type="text/javascript"></script>
         <script type="text/javascript"  src="../Scripts/jquery-1.8.3.min.js"></script>
		<script type="text/javascript"  src="../Scripts/SP.UI.Controls.js"></script>
        <script type="text/javascript" language="javascript"  src="../Scripts/Silverlight.js"></script>
        <script type="text/javascript" language="javascript"  src="../Scripts/history.js"></script>
	
         <script type="text/javascript">
             // "use strict";
             var isie = false;
             if (document.documentMode == 10) {
                 isie=true;
                 
             }

             var hasFlash = function() {
                 try {
                     return (typeof navigator.plugins == "undefined" || navigator.plugins.length == 0) ? !!(new ActiveXObject("ShockwaveFlash.ShockwaveFlash")) : navigator.plugins["Shockwave Flash"];
                 }
                 catch(e) { return false};
             };
             


             var capext = "txt";

             if (isie){
                 capext = "xml";
             }
             
             var hostweburl = '<asp:Literal ID="hostweb" runat="server"></asp:Literal>';
             var rec = '<asp:Literal ID="recommended" runat="server"></asp:Literal>';
             var favs = '<asp:Literal ID="favorites" runat="server"></asp:Literal>';
             var hidden = '<asp:Literal ID="hidden" runat="server"></asp:Literal>';
             var insp = '<asp:Literal ID="insharepoint" runat="server"></asp:Literal>';
             var userToken = '<asp:Literal ID="usertoken" runat="server"></asp:Literal>';
             var approved = '<asp:Literal ID="approved" runat="server"></asp:Literal>';
             var startpage = 1;
             var lastPageId = 18;
             var isIE7 = false;
             //load the SharePoint resources
             $(document).ready(function () {
                 
                 if (jQuery.browser.version == 7.0 && jQuery.browser.msie == true) {
                     alert("Your browser version is not supported. Please upgrade your browser to IE 8 or higher to run this site.");
                     isIE7 = true;
                 }
                 else {
                     if (document.documentMode > 9 || navigator.userAgent.indexOf('Chrome') > -1 || navigator.userAgent.indexOf('Firefox') > -1 ) {
                         $("#videomn").show();
                         $("#videomain").prepend('<source src="https://mediasvc08rg9b3g5vnth.blob.core.windows.net/asset-64114c7b-4aac-49e7-8759-dc99581ca9d4/SharePoint%20Vision%20Video%20v9_8000k.mp4?sv=2012-02-12&st=2013-06-19T00%3A08%3A47Z&se=2015-06-19T00%3A08%3A47Z&sr=c&si=b7947981-aed0-416a-b2e6-3177b19de5b1&sig=6VDF0MHQm%2FO3x0v84fpFsgd4scrxHC42nui048OtbOQ%3D" type="video/mp4"/><track src="../Videos/capmain.'+capext+'" label="English" kind="subtitles" srclang="en" />');
                     }
                     else {
                         if (Silverlight.isInstalled("5.0") || hasFlash() == false)
                             $("#videowmv").show();
                         else
                             $("#videoswf").show();
                     }
                    
                     if (insp) {
                         var scriptbase;
                         // The SharePoint js files URL are in the form:
                         // web_url/_layouts/15/resource
                         if (hostweburl !== null && hostweburl !== "") {
                             renderChrome();
                             scriptbase = hostweburl + "/_layouts/15/";
                             //$.getScript(scriptbase + "SP.UI.Controls.js", renderChrome);
                         }
                         addPage('1');
                         if (hidden!=null&&hidden!=""){
                             checkHidden();
                         }
                     }
                     console.log('isadmin = <asp:Literal ID="ltlTest" runat="server"></asp:Literal>');
                 }
             });

             //check recommended: 
             //TODO: integrate DB code for sharepoint users
             function checkHidden() {
                 var hidArr = parse(hidden);
                 if (hidArr.length>0){
                     $(".promo-block-2x1").each(function (index) {
                         var elem = $(this);
                         var rel = elem.find('a').attr('rel');
                         if (jQuery.inArray(rel, hidArr) >= 0) {
                             console.log('itmrel-'+rel);
                             elem.addClass('hide');
                         }else{
                             elem.removeClass('hide');
                         }
                     });


                     $(".hidesec").each(function (index) {
                         var elem = $(this);
                         var rel = elem.parent().parent().attr('rel');
                         if ($.inArray(rel, hidArr) >= 0) {
                             elem.attr('src', '../Images/admin_invisible.png').removeClass("hidesec").addClass("showsec");
                             elem.parent().parent().find('.recsec').attr('src', '../Images/admin_unchecked_invisible.png');
                         }
                     });
	
                 }else{
                     $(".promo-block-2x1").each(function (index) {
                         var elem = $(this);
                         elem.removeClass('hide');
                     });
                 }
	
                 $(".mbg").each(function (index) {
                     var elem = $(this);
                     var secrel = $(this).attr('id').split('-');
                     if ($(this).attr('rel')!='1-top'){
                         console.log($(this).hasClass('hide'));
                         console.log($(this).attr('rel'));
                         var icount = 0;
                         var pcount = 0;
                         elem.find('.promo-block-2x1').each(function (index) {
                             if ($(this).hasClass('hide')){
                                 icount++
                             }
                             pcount++;
                         });
                         if (icount == pcount){
                             elem.addClass('hide');
                             $('.m_'+secrel[0]).addClass('hide');
                         }else{
                             elem.removeClass('hide');
                             $('.m_'+secrel[0]).removeClass('hide');
                         }
                     }
                 });

		     
                 var favarr = parse(favs);
                 var recarr = parse(rec);
                 var remrec = false;
                 var remfav = false;
                 for (var i = 0; i < hidArr.length; i++) {

                     if ($.inArray(hidArr[i], favarr) >= 0) {
                         remfav = true;
                         var arrayspot=$.inArray(hidArr[i], favarr);
                         favarr.splice(arrayspot,1);
                     }

                     if ($.inArray(hidArr[i], recarr) >= 0) {
                         remrec = true;
                         var arrayspot=$.inArray(hidArr[i], recarr);
                         recarr.splice(arrayspot,1);
                     }

                 }
				

                 if (remrec){
                     var newrec = '';
                     for (var i = 0; i < recarr.length; i++) {
                         newrec+=recarr[i];
                         if (i<recarr.length-1){
                             newrec+=',';
                         }
                     }
                     rec=newrec;
                     addRec();
                 }

                 if (remfav){
                     var newfav = '';
                     for (var i = 0; i < favarr.length; i++) {
                         newfav+=favarr[i];
                         if (i<favarr.length-1){
                             newfav+=',';
                         }
                     }
                     favs=newfav;
                     addFav()
                 }
		        
	
                 <asp:Literal ID="addhiddenfunc" runat="server"></asp:Literal>
                 //addHidden();
             }


             function addPage(pageid) {
                 if (pageid == lastPageId) {
                     $("#rightshade").css({ "opacity": "1" });
                     $("#rightshade:hover").css({ "opacity": "1" });
                 }
                 else {
                     $("#rightshade").css({ "opacity": ".8" });
                     $("#rightshade:hover").css({ "opacity": ".5" });
                 }
                 var pageinfo = { 'usertoken': userToken, 'pageid': pageid };
                 $.ajax({
                     type: "POST",
                     url: "Default.aspx/addPageview",
                     data: JSON.stringify(pageinfo),
                     contentType: "application/json; charset=utf-8",
                     dataType: "json",
                     success: function (d) {
                         if (d.d != 'ok') {
                             console.log('error in addpage() ' + d.d);
                         }
                     },
                     error: function (xhr, err) { console.log("readyState: " + xhr.readyState + "\nstatus: " + xhr.status + "\nresponseText: " + xhr.responseText); }
                 });
             }

             function addVideoView(videoid) {
                 var vidinfo = { 'usertoken': userToken, 'vidid': videoid };
                 $.ajax({
                     type: "POST",
                     url: "Default.aspx/addVideoView",
                     data: JSON.stringify(vidinfo),
                     contentType: "application/json; charset=utf-8",
                     dataType: "json",
                     success: function (d) {
                         if (d.d != 'ok') {
                             console.log('error in addvideoview() ' + d.d);
                         }
                     },
                     error: function (xhr, err) { console.log("readyState: " + xhr.readyState + "\nstatus: " + xhr.status + "\nresponseText: " + xhr.responseText); }
                 });
             }

             function addVideoDL(videoid) {
                 var vidinfo = { 'usertoken': userToken, 'vidid': videoid };
                 $.ajax({
                     type: "POST",
                     url: "Default.aspx/addVideoDL",
                     data: JSON.stringify(vidinfo),
                     contentType: "application/json; charset=utf-8",
                     dataType: "json",
                     success: function (d) {
                         if (d.d != 'ok') {
                             console.log('error in addvideodl() ' + d.d);
                         }
                     },
                     error: function (xhr, err) { console.log("readyState: " + xhr.readyState + "\nstatus: " + xhr.status + "\nresponseText: " + xhr.responseText); }
                 });
             }

             function addGuideDL(guideid) {
                 var guideinfo = { 'usertoken': userToken, 'vidid': guideid };
                 $.ajax({
                     type: "POST",
                     url: "Default.aspx/addGuideDL",
                     data: JSON.stringify(guideinfo),
                     contentType: "application/json; charset=utf-8",
                     dataType: "json",
                     success: function (d) {
                         if (d.d != 'ok') {
                             console.log('error in addguidedl() ' + d.d);
                         }
                     },
                     error: function (xhr, err) { console.log("readyState: " + xhr.readyState + "\nstatus: " + xhr.status + "\nresponseText: " + xhr.responseText); }
                 });
             }

             function addRec() {
                 var guideinfo = { 'usertoken': userToken, 'rec': rec };
                 $.ajax({
                     type: "POST",
                     url: "Default.aspx/addRec",
                     data: JSON.stringify(guideinfo),
                     contentType: "application/json; charset=utf-8",
                     dataType: "json",
                     success: function (d) {
                         console.log(d.d);
                         if (d.d != 'ok') {
                             console.log('error in addrec() ' + d.d);
                         }
                     },
                     error: function (xhr, err) { console.log("readyState: " + xhr.readyState + "\nstatus: " + xhr.status + "\nresponseText: " + xhr.responseText); }
                 });
             }

             function addFav() {
                 console.log("addfav");
                 var guideinfo = { 'usertoken': userToken, 'favs': favs };
                 $.ajax({
                     type: "POST",
                     url: "Default.aspx/addFavorite",
                     data: JSON.stringify(guideinfo),
                     contentType: "application/json; charset=utf-8",
                     dataType: "json",
                     success: function (d) {
                         console.log(d.d);
                         if (d.d != 'ok') {
                             console.log('error in addfav() ' + d.d);
                         }
                     },
                     error: function (xhr, err) { console.log("readyState: " + xhr.readyState + "\nstatus: " + xhr.status + "\nresponseText: " + xhr.responseText); }
                 });
             }

             function sendFeedback(msg) {
                 modal.close();
                 var fbinfo = { 'message': msg };
                 $.ajax({
                     type: "POST",
                     url: "Default.aspx/sendFeedback",
                     data: JSON.stringify(fbinfo),
                     contentType: "application/json; charset=utf-8",
                     dataType: "json",
                     success: function (d) {
		                
                         console.log('message sent ' + d.d);
                     },
                     error: function (xhr, err) { console.log("readyState: " + xhr.readyState + "\nstatus: " + xhr.status + "\nresponseText: " + xhr.responseText); }
                 });
             }

		    

		    
             //Function to prepare the options and render the control
             function renderChrome() {
                 // The Help, Account and Contact pages receive the 
                 //   same query string parameters as the main page

                 var options = {
                     "appIconUrl": "siteicon.png",
                     "appTitle": "Discover Sharepoint",
                     "appHelpPageUrl": "Help.html?"
                         + document.URL.split("?")[1],
                     // The onCssLoaded event allows you to 
                     //  specify a callback to execute when the
                     //  chrome resources have been loaded.
                     "onCssLoaded": "chromeLoaded()",
                     "settingsLinks": [
                         {
                             "linkUrl": "#",
                             "displayName": "Admin Console"
                         },
                         {
                             "linkUrl": "javascript:showFeedback();",
                             "displayName": "Contact us"
                         }
                     ]
                 };

                 var nav = new SP.UI.Controls.Navigation(
                                         "chrome_ctrl_placeholder",
                                         options
                                     );
                 nav.setVisible(true);
		        

             }



             <asp:Literal ID="adminscripts" runat="server"></asp:Literal>

             // Function to retrieve a query string value.
             // For production purposes you may want to use
             //  a library to handle the query string.

             function getQueryStringParameter(paramToRetrieve) {
                 var params =
                     document.URL.split("?")[1].split("&");
                 var strParams = "";
                 for (var i = 0; i < params.length; i = i + 1) {
                     var singleParam = params[i].split("=");
                     if (singleParam[0] == paramToRetrieve)
                         return singleParam[1];
                 }
             }

             function chromeLoaded() {
                 // When the page has loaded the required
                 //  resources for the chrome control,
                 //  display the page body.
                 //$("body").show();
                 $("#chromeControl_bottomheader").hide();
                 // resizeWindow();
             }


</script>		
     <meta http-equiv="Content-Type" content="text/html; charset=utf-8" /></head>
     <body style="overflow:visible">


<div style="padding-top:4px; padding-bottom:4px; padding-left:10px; min-width:98%; background-color:rgb(80, 80, 80)"><a href="http://www.office.com/"><img src="../Images/office_logo.png" /></a></div>
       <div id="chrome_ctrl_placeholder"></div>
	 <div id="fullsite" style="position:relative;">
         
         <!--[if lt IE 7]>
            <p>You are using an outdated browser.</p>
        <![endif]-->	
		
		 <div id="preloader">
			 <div id="status">&nbsp; </div>
		 </div>
		 

		 <!-- navigation sidebars -->
		 <div id="leftshade" class="previous"></div>
		 <div id="rightshade" class="next"></div>
      <img id="leftarrow" class="previous" src="../Images/bigarrow-l.png"/>
	<img id="rightarrow" class="next" src="../Images/bigarrow-r.png"/>
		 <div id="full-page-container">	
             
			 <!-- menu wrapper-->
			 <div id="menu_wrapper" style="position:absolute;z-index:205;">	 
			 <div class="colwrap"><div class="inner">
		 
<table  id="navigation" style="width:1240px;"><tr><td><img class="homebutton" style="cursor:pointer;" src="../Images/splogo_top.png"/></td></tr><tr style="height:30px;"><td id="menut">
<ul><li rel="0" class="menu-item m_0 active fl">
<a class="m-home" href="#home"></a>
</li>
<li rel="1" class="menu-item m_1 fl">
 <h2><a class="m-general m" href="#general">Getting Started</a></h2>
</li>
<li rel="7" class="menu-item m_7 fl">
<h2><a class="m-corporateforms m" href="#corporateforms">HR & Internal Communicatons</a></h2>
</li>
<li rel="9" class="menu-item m_9 fl">
 <h2><a class="m-randd m" href="#randd">R&D, Production, & Operations</a></h2>
</li>
<li rel="11" class="menu-item m_11 fl">
<h2><a class="m-sales m" href="#Xsales">Sales & Marketing</a></h2>
</li>
<li rel="14" class="menu-item m_14 fl">
<h2><a class="m-finance m" href="#finance">Finance & Accounting</a></h2>
</li>
<li rel="15" class="menu-item m_15 fl">
<h2><a class="m-legal m" href="#legal">Legal</a></h2>
</li>
<li rel="16"class="menu-item m_16 fl">
<h2><a class="m-infotech m" href="#infotech">Information Technology</a></h2>
</li></ul>
</td></tr>
<tr style="height:0px;"><td style="position:relative;"> <div id="menupointer" style="position:absolute;bottom:-4px;z-index:800;"><img src="../Images/pointer-1.png"/></div></td></tr></table>

</div></div> </div><div style="height:0px;border-bottom:1px solid #888;z-index:500"></div><div style="position:relative;width:100%;">
			<div id="menufloat" class="footer" style="background:#fff; border-bottom:1px solid #cee3f1; position:absolute;z-index:206;top:90px; display:inline;width:100%;opacity:0.8;filter:alpha(opacity=80)"><div class="colwrap"><div class="inner"><div id="topmenu" style="position:relative;height:18px;width:1200px; padding-top:18px;"></div></div></div></div></div>
             
                 <!-- main content wrapper -->
			 <div id="main_wrapper">
	<div id="videop" style="display:none;">
        <video id="vidplayer" width="100" height="100" poster="" controls>Your browser does not support HTML5 Video.</video>
	</div>

			<div id="end" style="position:absolute;right:0px;"><div class="empowerpeople" style="height:522px;"></div><div class="darkgraybg" style="height:450px;"></div><div class="whitebg" style="height:500px;"></div></div>

				 <!-- column 1 wrapper -->

				 <div id="home" rel="0" class="column_content active clearfix c_0" style="width:100%">
<div style="height:2px;background:#888"></div>
					 <!-- column 01 visual -->
<div rel="1-top" class="mbg" id="1-main" style="height:600px;position:relative;"><div class="colwrap"><div class="inner"><table class="mntable" id="herograph">
    <tr>
    <td style="vertical-align:top;" class="homevideo"><h2 style="margin-bottom:5px;margin-top:0px;padding-top:10px">The new way to work together</h2>
    <div style="position:relative; z-index:2; clear:both; margin-top:10px;">&nbsp;&nbsp;&nbsp;<div class="videotxt" style="margin-top:-15px; margin-bottom:15px; font-size:14px; font-family:'Segoe UI Symbol'">SharePoint is about giving you and the people you work with a better way to get things done together. 
Browse through these scenarios to discover what SharePoint is and what’s in it for you.</div>
        <div id="videomn" style="display:none;position:absolute">
            <video id="videomain" width="675" height="412" poster="../Images/vision_poster.png" controls></video>
        </div>
        <div id="videowmv" style="display:none;position:absolute;width:675px;height:412px">
             <div id="mainImageWmv" width="675" height="412">
             <object data="data:application/x-silverlight-2," type="application/x-silverlight-2" width="100%" height="100%">
               <param name="source" value="http://iissmooth.webcastcenter.com/SmoothStreamingPlayer.xap"/>
               <param name="InitParams" value="DeliveryMethod=Progressive Download, mediaurl=http://www.discoversharepoint.com/videos/SharePoint Vision Video.wmv" />
             </object>
             </div>
        </div>
        <div id="videoswf" style="display:none;position:absolute">
            <%--<img id="mainImageSwf" width="675" height="412" src="../Images/vision_poster.png" />--%>
           <video id="video1" width="675" height="412" poster="../Images/vision_poster.png" controls>
            <object type="application/x-shockwave-flash" data="http://www.discoversharepoint.com/videos/SharePoint Vision Video.swf" width="675" height="412">
		        <param name="movie" value="http://www.discoversharepoint.com/videos/SharePoint Vision Video.swf" />
		        <param name="allowFullScreen" value="true" />
		        <param name="wmode" value="transparent" />
		        <param name="flashVars" value="config={'playlist':['http%3A%2F%2Fwww.discoversharepoint.com%2FImages%2Fvision_poster.png',{'url':'http%3A%2F%2Fclips.vorwaerts-gmbh.de%2Fbig_buck_bunny.mp4','autoPlay':false}]}" />
		        <img alt="Big Buck Bunny" src="../Images/vision_poster.png" width="640" height="360" title="No video playback capabilities, please download the video below" />
	        </object>
           </video>
        </div>
<%--           <object type="application/x-shockwave-flash" data=http://discoversharepointdevelopment.azurewebsite.net/videos/Module 1 - Demo 1.swf" width="675" height="412">
              <param name="movie" value="http://discoversharepointdevelopment.azurewebsite.net/videos/Module 1 - Demo 1.swf" />--%>
    <div id="dvUI" style="position:absolute;top:413px">
    <ul><li class="fl" style="padding-right:20px;"><div style="margin-right:20px;" class="dlbuttonm reg" rel="http://go.microsoft.com/fwlink/p/?LinkId=301522"><ul><li>Get the Use Case Catalog</li></ul></div></li>
        <li class="fl"><div class="dlbuttonm reg" rel="http://go.microsoft.com/fwlink/p/?LinkId=311967"><ul><li>Get the Adoption Guide</li></ul></div></li>
    </ul>
    </div>
    </div></td><td class="icholder" style="vertical-align:top;" id="rfbox"><div style="margin-bottom:10px; position:relative;">
    <div id="favmain" style="height:35px; line-height:35px; position:absolute;bottom:0px;left:45px;font-size:30px;font-weight:lighter;font-family: 'wf_SegoeUILight','wf_SegoeUI','Segoe UI Light','Segoe WP Light','Segoe UI','Segoe','Segoe WP','Tahoma','Verdana','Arial','sans-serif';">
        <a style="color:#444;" class="off" id="rec" href="#">Recommended</a>
        <a id="fav" style="color:#999;padding-left:30px;" class="on" href="#">Favorites</a>
        <img id="nextfav1" class="fav" rel="0" src="../Images/next.png"/></div></div><div class="pages-holder" style="margin-top:-10px">
                <section ID="homepage" class="page-homepage current-page page">
                    <div id="favholder" style="height:340px;"class="row-fluid">
                    </div>
                </section>
				
             </div>
             
        </td></tr></table></div></div></div>
		<!-- general -->
		<div rel="2-getstarted" id="Div1" class="mbg" style="height:600px;position:relative;"><div class="colwrap"><div class="hide-show back-button-holder" style="position:absolute;right:60px;top:60px;">
                        <div id="general" class="pull-left arrowclick">
                            <img src="../Images/arrow-wh.png"/>
                        </div>
                    </div><div class="inner"><table><tr><td style="width:20px;"></td><td class="txtholder"><div style="height:370px"></div><p style="margin-left:17px;" class="white ftext">The new SharePoint is all about<br>getting things done together.</p></td><td class="icholder"><div class="spacertop"></div><div class="pages-holder">
                <section ID="Section1" class="page-homepage current-page page">
                    <div rel="1" class="row-fluid">
                        <div class="span4 block-holder">
                            <div  class="promo-block-2x1 ic hidden hide-show">
                                <a rel="1" class="nav-link menu-item" href="#profile"></a>
                                <div class="title">Store, sync, and share your content</div>
                            </div>
                            <div  class="promo-block-2x1 ic hidden hide-show" style="font-family: 'Open Sans', sans-serif;">
                                <a rel="2" class="nav-link menu-item" href="#profile"></a>

                                <div class="title">Keep everyone on the same page</div>
                            </div>
                        </div>
<div class="span4 block-holder">
                            <div  class="promo-block-2x1 b-all ic hidden hide-show">
                                <a  rel="3" class="nav-link menu-item" href="#profile"></a>
                                

                                <div class="title">Stay on track and deliver on time</div>
                            </div>
                            <div  class="promo-block-2x1 b-all ic hidden hide-show" style="font-family: 'Open Sans', sans-serif;">
                                <a  rel="4" class="nav-link menu-item" href="#profile"></a>
                                

                                <div class="title">Find the right people</div>
                            </div>
                        </div>
 <div class="span4 block-holder">
                            <div  class="promo-block-2x1 b-all ic hidden hide-show">
                                <a rel="5" class="nav-link menu-item" href="#profile"></a>
                                

                                <div class="title">Find what you need</div>
                            </div>
                            <div  class="promo-block-2x1 b-all ic hidden hide-show" style="font-family: 'Open Sans', sans-serif;">
                                <a rel="6" class="nav-link menu-item" href="#profile"></a>
                                

                                <div class="title">Make informed decisions</div>
                            </div>
                        </div>
                    </div>
                </section>

 
            </div>
 </td></tr></table>
           
        </div></div></div>
		
		<!-- HR & Corporate Communications-->
		<div rel="4-hr" id="7-main" class="mbg" style="height:600px;position:relative;"><div class="colwrap"><div class="hide-show back-button-holder" style="position:absolute;right:60px;top:60px;">
                        <div id="corporateforms" class="pull-left arrowclick">
                            <img src="../Images/arrow-wh.png"/>
                        </div>
                    </div><div class="inner"><table><tr><td style="width:20px;"></td><td class="txtholder"><div style="height:350px"></div><p style="margin-left:17px;" class="black ftext">SharePoint helps keep your whole organization in sync.</p></td><td class="icholder"><div class="spacertop"></div><div class="pages-holder">
                <section ID="Section2" class="page-homepage current-page page">
                    <div rel="2" class="row-fluid">
                        <div class="span4 block-holder">
                            <div  class="promo-block-2x1 d-all ic hidden hide-show">
                                <a rel="7" class="nav-link" href="#profile"></a>
                                

                                <div class="title">Onboard new employees</div>
                            </div>

                        </div>
<div class="span4 block-holder">
                            <div  class="promo-block-2x1 d-all ic hidden hide-show">
                                <a rel="8"  class="nav-link" href="#profile"></a>
                                

                                <div class="title">Keep everyone informed</div>
                            </div>

                        </div>
 <div class="span4 block-holder">

                        </div>
                    </div>
                </section>

 
            </div>
 
          </td></tr></table> 
        </div></div></div>
		
		<!-- R&D, Production, Operations-->
		<div rel="5-rd" id="9-main" class="mbg" style="height:600px;position:relative;"><div class="colwrap"><div class="hide-show back-button-holder" style="position:absolute;right:60px;top:60px;">
                        <div id="randd" class="pull-left arrowclick">
                           <img src="../Images/arrow-wh.png"/>
                        </div>
                    </div><div class="inner"><table><tr><td style="width:20px;"></td><td class="txtholder"><div style="height:350px"></div><p style="margin-left:17px;" class="black ftext">SharePoint helps make processes<br>and people more productive.</p></td><td class="icholder"><div class="spacertop"></div><div class="pages-holder">
                <section ID="Section3" class="page-homepage current-page page">
                    <div rel="3" class="row-fluid">
                        <div class="span4 block-holder">
                            <div  class="promo-block-2x1 e-all ic hidden hide-show">
                                <a rel="9" class="nav-link" href="#profile"></a>
                                

                                <div style="color:#000;" class="title">Share your knowledge</div>
                            </div>

                        </div>
<div class="span4 block-holder">
                            <div  class="promo-block-2x1 e-all ic hidden hide-show">
                                <a rel="10" class="nav-link" href="#profile"></a>
                                

                                <div style="color:#000;" class="title">Boost business processes</div>
                            </div>

                        </div>
 <div class="span4 block-holder">

                        </div>
                    </div>
                </section>

 
            </div>
 </td></tr></table> 
           
        </div></div></div>
		<!-- Sales & Marketing-->
		<div rel="6-sales" id="11-main" class="mbg" style="height:600px;position:relative;"><div class="colwrap"><div class="hide-show back-button-holder" style="position:absolute;right:60px;top:60px;">
                        <div id="sales" class="pull-left arrowclick">
                            <img src="../Images/arrow-wh.png"/>
                        </div>
                    </div><div class="inner"><table><tr><td style="width:20px;"></td><td class="txtholder"><div style="height:350px"></div><p style="margin-left:17px;" class="white ftext">SharePoint helps you deliver more<br>engaging and effective customer<br>experiences.</p></td><td class="icholder"><div class="spacertop"></div></div><div class="pages-holder">
                <section ID="Section4" class="page-homepage current-page page">
                    <div rel="4" class="row-fluid">
                        <div class="span4 block-holder">
                            <div  class="promo-block-2x1 g-all ic hidden hide-show">
                                <a rel="11" class="nav-link" href="#profile"></a>
                                

                                <div class="title">Make your customers and partners happy</div>
                            </div>
 
                        </div>
<div class="span4 block-holder">
                            <div  class="promo-block-2x1 g-all ic hidden hide-show">
                                <a rel="12" class="nav-link" href="#profile"></a>
                                

                                <div class="title">Engage your audience online</div>
                            </div>
 
                        </div>
 <div class="span4 block-holder">
                            <div  class="promo-block-2x1 g-all ic hidden hide-show">
                                <a rel="13" class="nav-link" href="#profile"></a>
                                

                                <div class="title">Align your teams</div>
                            </div>
  
                        </div>
                    </div>
                </section>

 
            </div>
  </td></tr></table> 
           
        </div></div></div>
		
		<!-- Finance & Accounting-->
		<div rel="7-finance" id="14-main" class="mbg" style="height:600px;position:relative;"><div class="colwrap"><div class="hide-show back-button-holder" style="position:absolute;right:60px;top:60px;">
                        <div id="finance" class="pull-left arrowclick">
                           <img src="../Images/arrow-wh.png"/>
                        </div>
                    </div><div class="inner"><table><tr><td style="width:20px;"></td><td class="txtholder"><div style="height:350px"></div><p style="margin-left:17px;" class="black ftext">SharePoint makes it easier to crunch<br>the numbers with other people.</p></td><td class="icholder"><div class="spacertop"></div></div><div class="pages-holder">
                <section ID="Section5" class="page-homepage current-page page">
                    <div rel="5" class="row-fluid">
                        <div class="span4 block-holder">
                            <div  class="promo-block-2x1 h-all ic hidden hide-show">
                                <a rel="14" class="nav-link" href="#profile"></a>
                                

                                <div class="title">Crunch the numbers together</div>
                            </div>

                        </div>
<div class="span4 block-holder">

                        </div>
 <div class="span4 block-holder">
 
                        </div>
                    </div>
                </section>

 
            </div>
   </td></tr></table> 
           
        </div></div></div>
		<!-- Legal-->
		<div rel="8-legal" id="15-main" class="mbg" style="height:600px;position:relative;"><div class="colwrap"><div class="hide-show back-button-holder" style="position:absolute;right:60px;top:60px;">
                        <div id="legal" class="pull-left arrowclick">
                           <img src="../Images/arrow-wh.png"/>
                        </div>
                    </div><div class="inner"><table><tr><td style="width:20px;"></td><td class="txtholder"><div style="height:350px"></div><p style="margin-left:17px;" class="black ftext">SharePoint can help assist you in achieving<br>legal and regulatory compliance.</p></td><td class="icholder"><div class="spacertop"></div><div class="pages-holder">
                <section ID="Section6" class="page-homepage current-page page">
                    <div rel="6" class="row-fluid">
                        <div class="span4 block-holder">
                            <div class="promo-block-2x1 i-all ic hidden hide-show">
                                <a rel="15" class="nav-link" href="#profile"></a>
                                

                                <div class="title">Help meet compliance needs</div>
                            </div>

                        </div>
<div class="span4 block-holder">
  
                        </div>
 <div class="span4 block-holder">

                        </div>
                    </div>
                </section>

 
            </div>
   </td></tr></table> 
           
        </div></div></div>
<!-- Information Technology-->
		<div rel="3-it" class="mbg" id="16-main" style="height:600px;position:relative;"><div class="colwrap"><div class="hide-show back-button-holder" style="position:absolute;right:60px;top:60px;">
                        <div id="infotech" class="pull-left arrowclick">
                           <img src="../Images/arrow-wh.png"/>
                        </div>
                    </div><div class="inner"><table><tr><td style="width:20px;"></td><td class="txtholder"><div style="height:350px"></div><p style="margin-left:17px;" class="black ftext">SharePoint helps balance IT and<br>business needs.</p></td><td class="icholder"><div class="spacertop"></div><div class="pages-holder">
                <section ID="Section7" class="page-homepage current-page page">
                    <div rel="7" class="row-fluid">
                        <div class="span4 block-holder">
                            <div  class="promo-block-2x1 c-all ic hidden hide-show">
                                <a rel="16" class="nav-link menu-item" href="#profile"></a>
                                <div class="title">Provide the right support</div>
                            </div>

                        </div>
<div class="span4 block-holder">
                            <div  class="promo-block-2x1 c-all ic hidden hide-show">
                                <a rel="17" class="nav-link" href="#profile"></a>
                                

                                <div class="title">Empower people and stay in control</div>
                            </div>

                        </div>
 <div class="span4 block-holder">
 
                        </div>
                    </div>
                </section>

 
            </div>
  </td></tr></table>
           
        </div></div></div>
					 <!-- column 01 footer -->

					 <div class="footer oth">
					 <div class="contentstretch whitebg"></div>
					 <div class="colwrap"><div class="inner" id="footerinner">
					 <div class="content"><div style="height:25px;"></div>
	<table id="ftbl" style="margin:0px;position:relative;"><tr><td style="position:relative;vertical-align:top;height:60px;font-size: 13px;font-family: 'Segoe UI', Helvetica, Arial, sans-serif;" colspan="7"><table style="position:absolute;">
						<tr><td style="color:#444;width:130px;" colspan="2">Follow Us:&nbsp;&nbsp; <a style="font-size: 13px;" target="_blank" href="http://blogs.office.com/b/sharepoint/">Sharepoint Blog</a>&nbsp;&nbsp;&nbsp;&nbsp;<a style="font-size: 13px;" target="_blank" href="https://twitter.com/SharePoint"><img src="../Images/twitter_sm.png"/>&nbsp;Twitter</a>&nbsp;&nbsp;&nbsp;&nbsp;<a style="font-size: 13px;" target="_blank" href="https://www.facebook.com/MSSharePoint"><img src="../Images/facebook_sm.png"/>&nbsp;Facebook</a></td></tr>
						<tr><td style="color:#444;width:130px;">
						Find Information For:</td><td><a href="http://office.microsofKeep Everyone On The Same Paget.com/en-usStore, sync, and share your c ontentation-software-FX103479517.aspx" style="font-size: 13px;" target="_blank">Decision Makers</a>&nbsp;&nbsp;|&nbsp;&nbsp;<a style="font-size: 13px;" target="_blank" href="http://technet.microsoft.com/en-US/sharepoint/">IT Pros</a>&nbsp;&nbsp;|&nbsp;&nbsp;<a style="font-size: 13px;" target="_blank" href="http://msdn.microsoft.com/en-US/sharepoint">Developers</a>
						</td></tr>
						<tr style="height:20px;"><td colspan="2" class="footerbtm" style="vertical-align:middle;color:#666;font-size: 13px;">
						<asp:Literal ID="adminbutton" runat="server"></asp:Literal><a style="font-size: 13px;color:#666;" target="_blank" href="http://office.microsoft.com/en-us/sharepoint/sharepoint-products-and-free-trial-online-collaboration-tools-FX103789417.aspx?WT%2Eintid1=ODC_ENUS_FX103479517_XT103977432">Try or Buy</a>&nbsp;&nbsp;|&nbsp;&nbsp;<a style="font-size: 13px;color:#666;" target="_blank" href="http://go.microsoft.com/fwlink/p/?LinkId=301524">Get the adoption kit</a>&nbsp;&nbsp;|&nbsp;&nbsp;<a style="font-size: 13px;color:#666;" class="feedback" href="#">Submit Feedback</a>&nbsp;&nbsp;|&nbsp;&nbsp;<a style="font-size: 13px;color:#666;" href="eula.html" target="_blank">Terms of Use</a>&nbsp;&nbsp;|&nbsp;&nbsp;<a style="font-size: 13px;color:#666;" target="_blank" href="http://privacy.microsoft.com/en-gb/default.mspx">Privacy Statement</a>
						</td></tr>
						</table><div style="float:right;font-size: 11px;color:#222;"><div><img style="padding:5px;" src="../Images/mslogo.png"/></div><div>&nbsp;&nbsp;&copy; 2013 Microsoft</div></div></td></tr>
						</table>
						</div>
					 </div></div></div>

				 </div>

				<!-- At Work For You Section-->
				 <div id="store_sync_and_share_your_content" rel="1" class="column_content clearfix c_1">
        
		<!-- Store, sync, and share your content -->
		<div class="storesync bar"><div class="contentstretch storesync"></div><div class="colwrap"><div class="inner"><table id="firsttable" class="mntable"><tr><td class="cleft" style="width:650px;vertical-align:top;"><div style="height:50px;position:relative;"><div class="icons"></div></div><div class="rtext"><div class="textcont"><div class="white htext">Store, sync, and share your content</div><p class="white mntext">Think of SharePoint as a central hub for all your content. You can fill it up with documents, organize them how you want, and easily share them with other people. There’s only one document you have to deal with—and it’s always in the same place and it’s always up to date. Instead of lots of people creating multiple versions in different places, you can get everyone to work on the same document—even at the same time—and SharePoint will keep track of everyone’s changes in one place. You don’t even need to be at your desk to get work done together. You can keep reviewing and tweaking your content while on the go, even offline and from virtually any device.</p></div></div><table class="arrowbtn"><tr><td><div class="more white" style="display:none;"><div style="height:6px;"></div><div class="hide"></div><div class="rtoggle"><img src="../Images/down-white.png"/>&nbsp;&nbsp;Show more</div></div></td><td><div style="height:6px;"></div><div class="gguide white"><a style="color:White;" target="_blank" href="http://go.microsoft.com/fwlink/p/?LinkId=309820"><img src="../Images/down-white.png"/>&nbsp;&nbsp;Get the Guide</a></div></td></tr></table></td><td class="cmid" style="width:120px"></td><td style="vertical-align:middle;"><div style="height:50px;"></div><img class="ucimage" style="width:4800px" src="../Images/1tall_img.png"/></td></tr></table><div style="height:50px;position:relative;"></div></div></div></div>
	
		
		<!-- testimonial-->
		<div class="darkgraybg bar"><div class="contentstretch darkgraybg"></div><div style="height:35px;"></div><div class="colwraptxt"><div class="inner"><table><tr><td style="vertical-align:top;"><img src="../Images/quotes.png"/></td><td><p class="black tq2">With SharePoint 2013 combined with SkyDrive Pro, our staff can use their smartphone, tablet, or other mobile device to upload to and download from a specific project site.</p></td><td style="vertical-align:bottom;"><img src="../Images/quotes2.png"/></td></tr><tr><td></td><td><div style="position:relative;"><div style="position:absolute;top:30px;"><img src="../Images/testimonial_lady.png"/></div><div style="position:absolute;left:70px;"><h3 style="margin-top:35px;margin-bottom:10px;">Felicity McNish</h3><p class="blue tb">-Global Knowledge Manager, Woods Bagot</p></div></div></td><td></td></tr></table></div></div><div style="height:105px;"></div></div>
		<!-- use case-->
		
		<div class="whitebg bar"><div class="contentstretch whitebg"></div><div style="height:45px;"></div><div class="ucvid"><div class="inner"><table><tr><td class="cleft" style="width:582px;height:327px;position:relative;text-align:center;"><img class="cleft im" id="1.1" style="position:absolute;border: 1px solid #cccccc;" src="../Videos/1.1.png"/><img style="position:relative;cursor:pointer;" rel="1" id="https://mediasvc08rg9b3g5vnth.blob.core.windows.net/asset-ae83b936-a0c1-4f66-a112-dc041caff5bc/Module%201%20-%20Demo%201.mp4?sv=2012-02-12&st=2013-05-24T19%3A21%3A46Z&se=2015-05-24T19%3A21%3A46Z&sr=c&si=12ab52e2-fdc6-4e05-adb6-46235274ca07&sig=plQ61tO4QCdPdD282wQasOxv37s5crocctKaZpUjFWI%3D" class="videolnk cleft" src="../Images/playbtn.png"/></td><td style="width:42px;"></td><td style="vertical-align:top;" class="cright" style="width:560px;"><div class="hd">Take advantage of SkyDrive Pro so that you can sync your content with the click of a button, access it from virtually anywhere, and share it with anyone.</div><div style="height:35px;"></div><div class="dlbuttonm reg" rel="http://go.microsoft.com/fwlink/p/?LinkId=302011"><ul><li>Download video</li></ul></div></td></tr></table><div style="height:60px;"></div></div></div></div>

<div class="darkgraybg bar"><div style="border-top: 1px solid #cccccc;" class="contentstretch darkgraybg"></div><div style="height:45px;"></div><div class="ucvid"><div class="inner"><table><tr><td class="cleft" style="width:582px;height:327px;position:relative;text-align:center;"><img class="cleft im" style="position:absolute;border: 1px solid #cccccc;" src="../Videos/1.2.png"/><img style="position:relative;cursor:pointer;" rel="2" id="https://mediasvc08rg9b3g5vnth.blob.core.windows.net/asset-bf055944-2c65-469e-819f-22cddabd27e1/Module%201%20-%20Demo%202.mp4?sv=2012-02-12&st=2013-05-24T19%3A21%3A50Z&se=2015-05-24T19%3A21%3A50Z&sr=c&si=f6f4891f-01ff-46f2-bdc2-a46317e5fdf2&sig=eYnFEDaOuurVOaasK9Tiv9WIjzYfZNttoLKrln97dvA%3D" class="videolnk cleft" src="../Images/playbtn.png"/></td><td style="width:42px;"></td><td style="vertical-align:top;" class="cright" style="width:560px;"><div class="hd">Quickly loop in colleagues to work together on content—even at the same time—while everyone’s changes to a document are automatically tracked.</div><div style="height:35px;"></div><div class="dlbuttonm reg" rel="http://go.microsoft.com/fwlink/p/?LinkId=302012"><ul><li>Download video</li></ul></div></td></tr></table><div style="height:60px;"></div></div></div></div>
		
<div class="whitebg bar"><div style="border-top: 1px solid #cccccc;" class="contentstretch whitebg"></div><div style="height:45px;"></div><div class="ucvid"><div class="inner"><table><tr><td class="cleft" style="width:582px;height:327px;position:relative;text-align:center;"><img class="cleft im" style="position:absolute;border: 1px solid #cccccc;" src="../Videos/1.3.png"/><img style="position:relative;cursor:pointer;" rel="3" id="https://mediasvc08rg9b3g5vnth.blob.core.windows.net/asset-88d0a619-1b37-4b62-b5c6-f7b412ee73a9/Module%201%20-%20Demo%203.mp4?sv=2012-02-12&st=2013-05-24T19%3A21%3A53Z&se=2015-05-24T19%3A21%3A53Z&sr=c&si=0adeddf7-5e69-40ea-9354-94b92bb5ba2e&sig=Qe1Lt8wsq47XRPeAje5bXFqZSb7HQldP1axobF%2FO0AU%3D" class="videolnk cleft" src="../Images/playbtn.png"/></td><td style="width:42px;"></td><td style="vertical-align:top;" class="cright" style="width:560px;"><div class="hd">Use newsfeeds to share content, connect with people, and stay up to date with what’s going on in your organization.</div><div style="height:35px;"></div><div class="dlbuttonm reg" rel="http://go.microsoft.com/fwlink/p/?LinkId=302013"><ul><li>Download video</li></ul></div></td></tr></table><div style="height:60px;"></div></div></div></div>

					 <div class="footer oth">
						 <div style="border: 1px solid #cccccc;" class="contentstretch whitebg"></div>
						 <div class="colwrap"><div class="inner">
					 <div class="content">
					 </div></div></div>
					 </div>
		 </div>
		 
		 <div id="keep_everyone_on_the_same_page" rel="2" class="column_content clearfix c_2">
		 
		<!-- Keep Everyone On The Same Page -->
		<div class="samepage bar"><div class="contentstretch samepage"></div><div class="colwrap"><div class="inner"><table class="mntable"><tr><td class="cleft" style="width:582px;vertical-align:top;"><div style="height:50px;position:relative;"><div class="icons"></div></div><div class="rtext"><div class="textcont"><div class="white htext">Keep everyone on the same page</div><p class="white mntext">Wouldn’t it be great if you and your team had a single place where you could get work done together and stay in sync with each other? SharePoint is exactly that kind of place. It’s a home base where you and your team can share and organize your resources—like notes, documents, schedules, conversations, and much more. No more running around to find what you need or get people what they need. Just go to your team site to get what you want, and then share your stuff instantly with the whole group.</p></div></div><table class="arrowbtn"><tr><td><div class="more white" style="display:none;"><div style="height:6px;"></div><div class="hide"></div><div class="rtoggle"><img src="../Images/down-white.png"/>&nbsp;&nbsp;Show more</div></div></td><td ><div style="height:6px;"></div><div class="gguide white"><a style="color:White;" target="_blank" href="http://go.microsoft.com/fwlink/p/?LinkId=309821"><img src="../Images/down-white.png"/>&nbsp;&nbsp;Get the Guide</a></div></td></tr></table></div></td><td class="cmid" style="width:120px"></td><td style="vertical-align:middle;"><div style="height:50px;"></div><img class="ucimage" style="width:480px" src="../Images/2tall_img.png"/></td></tr></table><div style="height:50px;position:relative;"></div></div></div></div>
		
		<!-- testimonial-->
		<div class="darkgraybg bar"><div class="contentstretch darkgraybg"></div><div style="height:20px;"></div><div class="colwraptxt"><div class="inner"><table><tr><td style="vertical-align:top;"><img src="../Images/quotes.png"/></td><td><p class="black tq2">Our research shows that we can increase our productivity up to 25 percent by using social collaboration in the enterprise.</p></td><td style="vertical-align:bottom;"><img src="../Images/quotes2.png"/></td></tr><tr><td></td><td><div style="position:relative;"><div style="position:absolute;top:30px;"><img src="../Images/testimonial_person.png"/></div><div style="position:absolute;left:70px;"><h3 style="margin-top:35px;margin-bottom:10px;">Head of Content Management</h3><p class="blue tb">-Finance Services, Banking</p></div></div></td><td></td></tr></table></div></div><div style="height:105px;"></div></div>
			
		<!-- use case-->
		
		<div class="whitebg bar"><div class="contentstretch whitebg"></div><div style="height:45px;"></div><div class="ucvid"><div class="inner"><table><tr><td class="cleft" style="width:582px;height:327px;position:relative;text-align:center;"><img class="cleft im" style="position:absolute;border: 1px solid #cccccc;" src="../Videos/2.1.png"/><img style="position:relative;cursor:pointer;" rel="4" id="https://mediasvc08rg9b3g5vnth.blob.core.windows.net/asset-e40d345c-78c5-4816-9e89-d74bd991374b/Module%202%20-%20Demo%201.mp4?sv=2012-02-12&st=2013-05-24T19%3A21%3A57Z&se=2015-05-24T19%3A21%3A57Z&sr=c&si=41aa1656-dfbc-4bd7-b15b-4e0d4c24827f&sig=8mhlNtX2aKhPWXpWPyWgYD7ZvkrfMzx5gSgVHbv%2FrZM%3D" class="videolnk cleft" src="../Images/playbtn.png"/></td><td style="width:42px;"></td><td style="vertical-align:top;" class="cright" style="width:560px;"><div class="hd">Quickly set up a site where you can store, organize, and share what you need to get your work done together. Customize your site just the way you want with a whole world of apps at your fingertips.</div><div style="height:35px;"></div><div class="dlbuttonm reg" rel="http://go.microsoft.com/fwlink/p/?LinkId=302014"><ul><li>Download video</li></ul></div></td></tr></table><div style="height:60px;"></div></div></div></div>

<div class="darkgray bar"><div style="border-top: 1px solid #cccccc;" class="contentstretch darkgraybg"></div><div style="height:45px;"></div><div class="ucvid"><div class="inner"><table><tr><td class="cleft" style="width:582px;height:327px;position:relative;text-align:center;"><img class="cleft im" style="position:absolute;border: 1px solid #cccccc;" src="../Videos/2.2.png"/><img style="position:relative;cursor:pointer;" rel="5" id="https://mediasvc08rg9b3g5vnth.blob.core.windows.net/asset-c89021db-8897-4170-88a4-c17f9d534028/Module%202%20-%20Demo%202.mp4?sv=2012-02-12&st=2013-05-24T19%3A21%3A59Z&se=2015-05-24T19%3A21%3A59Z&sr=c&si=a308fa23-1a56-42a2-b81f-818be0d5f43a&sig=4fU%2FNoqz%2BkkBUT6wJtbYl%2F9YcfZTw%2BmkA%2F3YiISipQ0%3D" class="videolnk cleft" src="../Images/playbtn.png"/></td><td style="width:42px;"></td><td style="vertical-align:top;" class="cright" style="width:560px;"><div class="hd">Boost team productivity with a shared notebook that everyone on your site can work together on—even simultaneously—to capture notes from anywhere, on any device and even offline.</div><div style="height:35px;"></div><div class="dlbuttonm reg" rel="http://go.microsoft.com/fwlink/p/?LinkId=302015"><ul><li>Download video</li></ul></div></td></tr></table><div style="height:60px;"></div></div></div></div>

<div class="whitebg bar"><div style="border-top: 1px solid #cccccc;" class="contentstretch whitebg"></div><div style="height:45px;"></div><div class="ucvid"><div class="inner"><table><tr><td class="cleft" style="width:582px;height:327px;position:relative;text-align:center;"><img class="cleft im" style="position:absolute;border: 1px solid #cccccc;" src="../Videos/2.3.png"/><img style="position:relative;cursor:pointer;" rel="6" id="https://mediasvc08rg9b3g5vnth.blob.core.windows.net/asset-d96a368f-d683-4510-8a26-db7f81b12c43/Module%202%20-%20Demo%203.mp4?sv=2012-02-12&st=2013-05-24T19%3A22%3A02Z&se=2015-05-24T19%3A22%3A02Z&sr=c&si=0e6044d8-9cd5-4f25-a4af-56a8825f70fa&sig=dx9PP0ft3BRexUDun5KVCk2UvCGlbDaBUHohlxe6nGY%3D" class="videolnk cleft" src="../Images/playbtn.png"/></td><td style="width:42px;"></td><td style="vertical-align:top;" class="cright" style="width:560px;"><div class="hd">Share important information with the people you need through shared mailboxes and calendars that help you stay in sync and up to date.</div><div style="height:35px;"></div><div class="dlbuttonm reg" rel="http://go.microsoft.com/fwlink/p/?LinkId=302016"><ul><li>Download video</li></ul></div></td></tr></table><div style="height:60px;"></div></div></div></div>

					 <div class="footer oth">
						 <div style="border: 1px solid #cccccc;" class="contentstretch whitebg"></div>
						 <div class="colwrap"><div class="inner">
					 <div class="content">
					 </div></div></div>
					 </div>
		 </div>
		
		
		<!-- Stay On Track And Deliver On Time -->
		
		<div id="stay_on_track_and_deliver_on_time" rel="3" class="column_content clearfix c_3">
		
		<div class="ontrack bar"><div class="contentstretch ontrack"></div><div class="colwrap"><div class="inner"><table class="mntable"><tr><td class="cleft" style="width:582px;vertical-align:top;"><div style="height:50px;position:relative;"><div class="icons"></div></div><div class="rtext"><div class="textcont"><div class="white htext">Stay on track and deliver on time</div><p class="mntext white">Isn't life grand - when all your projects are on track and you meet all your deadlines? SharePoint can make your life a lot easier by helping you organize teamwork around common milestones. You can make sure work gets done by assigning people tasks that can be tracked and prioritized. And, you can keep an eye on important details with a real - time summary of your project that warns you about delays and keeps next steps and milestones on your radar. When it comes to really big and complicated projects, you can use Project Professional to manage task dependencies, balance resource allocations, and easily generate status reports. No need to worry - this all stays in sync with your site, where you can all continue to work together to keep your project on track.</p></div></div><table class="arrowbtn"><tr><td><div class="more white" style="display:none;"><div style="height:6px;"></div><div class="hide"></div><div class="rtoggle"><img src="../Images/down-white.png"/>&nbsp;&nbsp;Show more</div></div></td><td><div style="height:6px;"></div><div class="gguide white"><a style="color:White;" target="_blank" href="http://go.microsoft.com/fwlink/p/?LinkId=309823"><img src="../Images/down-white.png"/>&nbsp;&nbsp;Get the Guide</a></div></td></tr></table></td><td class="cmid" style="width:120px"></td><td style="vertical-align:middle;"><div style="height:50px;"></div><img class="ucimage" style="width:480px" src="../Images/3tall_img.png"/></td></tr></table><div style="height:50px;position:relative;"></div></div></div></div>
		
		
		<!-- testimonial-->
		<div class="darkgraybg bar"><div class="contentstretch darkgraybg"></div><div style="height:20px;"></div><div class="colwraptxt"><div class="inner"><table><tr><td style="vertical-align:top;"><img src="../Images/quotes.png"/></td><td><p class="black tq2">Project in combination with SharePoint; I think you have a very powerful tool there.</p></td><td style="vertical-align:bottom;"><img src="../Images/quotes2.png"/></td></tr><tr><td></td><td><div style="position:relative;"><div style="position:absolute;top:30px;"><img src="../Images/testimonial_person.png"/></div><div style="position:absolute;left:70px;"><h3 style="margin-top:35px;margin-bottom:10px;">Dr. Christian Buddendick</h3><p class="blue tb">-Head of Workplace Platform Services, Hilti Corporation</p></div></div></td><td></td></tr></table></div></div><div style="height:105px;"></div></div>
		
		<!-- use case-->
		
		<div class="whitebg bar"><div class="contentstretch whitebg"></div><div style="height:45px;"></div><div class="ucvid"><div class="inner"><table><tr><td class="cleft" style="width:582px;height:327px;position:relative;text-align:center;"><img class="cleft im" style="position:absolute;border: 1px solid #cccccc;" src="../Videos/3.1.png"/><img style="position:relative;cursor:pointer;" rel="7" id="https://mediasvc08rg9b3g5vnth.blob.core.windows.net/asset-9e9ea4cc-7cc9-4e54-8cc5-c50960ef1d76/Module%203%20-%20Demo%201.mp4?sv=2012-02-12&st=2013-05-24T19%3A03%3A17Z&se=2015-05-24T19%3A03%3A17Z&sr=c&si=b60820e8-6ee0-41ff-bbda-a4f12221d1b3&sig=CI0ETNwyUcARXYY1tncbQoJvP60qDrupmOvdqpN889c%3D" class="videolnk cleft" src="../Images/playbtn.png"/></td><td style="width:42px;"></td><td style="vertical-align:top;" class="cright" style="width:560px;"><div class="hd">Keep your project on track with an interactive timeline that lets you break your project into steps, assign tasks to people, and keep an eye on what needs to get done.</div><div style="height:35px;"></div><div class="dlbuttonm reg" rel="http://go.microsoft.com/fwlink/p/?LinkId=302017"><ul><li>Download video</li></ul></div></td></tr></table><div style="height:60px;"></div></div></div></div>

<div class="darkgraybg bar"><div style="border-top: 1px solid #cccccc;" class="contentstretch darkgraybg"></div><div style="height:45px;"></div><div class="ucvid"><div class="inner"><table><tr><td class="cleft" style="width:582px;height:327px;position:relative;text-align:center;"><img class="cleft im" style="position:absolute;border: 1px solid #cccccc;" src="../Videos/3.2.png"/><img style="position:relative;cursor:pointer;" rel="8" id="https://mediasvc08rg9b3g5vnth.blob.core.windows.net/asset-7a8c3a2e-843e-4ecf-b48e-ec14ffd23966/Module%203%20-%20Demo%202.mp4?sv=2012-02-12&st=2013-05-24T19%3A21%3A25Z&se=2015-05-24T19%3A21%3A25Z&sr=c&si=52e41a0c-6be4-44ec-a553-8f48d22ca6b9&sig=OZkNS3lOGB0P5FV9IMOt2ec5HpEVZxPUgX5oGwJxyxA%3D" class="videolnk cleft" src="../Images/playbtn.png"/></td><td style="width:42px;"></td><td style="vertical-align:top;" class="cright" style="width:560px;"><div class="hd">Take your project to the next level with Project Professional to manage task dependencies, balance resource allocations, and quickly generate status reports.</div><div style="height:35px;"></div><div class="dlbuttonm reg" rel="http://go.microsoft.com/fwlink/p/?LinkId=302018"><ul><li>Download video</li></ul></div></td></tr></table><div style="height:60px;"></div></div></div></div>

<div class="whitebg bar"><div style="border-top: 1px solid #cccccc;" class="contentstretch whitebg"></div><div style="height:45px;"></div><div class="ucvid"><div class="inner"><table><tr><td class="cleft" style="width:582px;height:327px;position:relative;text-align:center;"><img class="cleft im" style="position:absolute;border: 1px solid #cccccc;" src="../Videos/3.3.png"/><img style="position:relative;cursor:pointer;" rel="9" id="https://mediasvc08rg9b3g5vnth.blob.core.windows.net/asset-f0269dfb-8b39-4a18-9141-65acb79b5463/Module%203%20-%20Demo%203.mp4?sv=2012-02-12&st=2013-05-24T19%3A21%3A32Z&se=2015-05-24T19%3A21%3A32Z&sr=c&si=ba3bb62e-1b9c-458e-8bb5-f573f8d839f7&sig=YfEu6FPnzD0Hi1bUMqp3Att%2FHMO7pJMQM9wmtHjzM6Y%3D" class="videolnk cleft" src="../Images/playbtn.png"/></td><td style="width:42px;"></td><td style="vertical-align:top;" class="cright" style="width:560px;"><div class="hd">Stay on top of things by keeping an eye on all of your personal and assigned tasks in a single to-do list.</div><div style="height:35px;"></div><div class="dlbuttonm reg" rel="http://go.microsoft.com/fwlink/p/?LinkId=302019"><ul><li>Download video</li></ul></div></td></tr></table><div style="height:60px;"></div></div></div></div>

					 <div class="footer oth">
						 <div style="border: 1px solid #cccccc;" class="contentstretch whitebg"></div>
						 <div class="colwrap"><div class="inner">
					 <div class="content">
					 </div></div></div>
					 </div>
		 </div>
		
		
		<div id="find_the_right_people" rel="4" class="column_content clearfix c_4" >
		
		<!-- Connect with experts -->
		<div class="experts bar"><div class="contentstretch experts"></div><div class="colwrap"><div class="inner"><table class="mntable"><tr><td class="cleft" style="width:582px;vertical-align:top;"><div style="height:50px;position:relative;"><div class="icons"></div></div><div class="rtext"><div class="textcont"><div class="white htext">Find the right people</div><p class="white mntext">Things always seem to work out better when you find the right people for the job. The problem is: how do you find the right people without wasting lots of time tracking them down? SharePoint solves this problem. It gives you a single place to connect with experts across your organization, whether they’re in the office down the hall or on the other side of the globe. Now, you can quickly get the answers and information you need to make the right decisions, avoid reinventing the wheel, and improve your work.</p></div></div><table class="arrowbtn"><tr><td><div class="more white" style="display:none;"><div style="height:6px;"></div><div class="hide"></div><div class="rtoggle"><img src="../Images/down-white.png"/>&nbsp;&nbsp;Show more</div></div></td><td><div style="height:6px;"></div><div class="gguide white"><a style="color:White;" target="_blank" href="http://go.microsoft.com/fwlink/p/?LinkId=309824"><img src="../Images/down-white.png"/>&nbsp;&nbsp;Get the Guide</a></div></td></tr></table></td><td class="cmid" style="width:120px"></td><td style="vertical-align:middle;"><div style="height:50px;"></div><img class="ucimage" style="width:4800px" src="../Images/4tall_img.png"/></td></tr></table><div style="height:50px;position:relative;"></div></div></div></div>
	
		<!-- testimonial-->
		<div class="darkgraybg bar"><div class="contentstretch darkgraybg"></div><div style="height:20px;"></div><div class="colwraptxt"><div class="inner"><table><tr><td style="vertical-align:top;"><img src="../Images/quotes.png"/></td><td><p class="black tq2">With the improvements in SharePoint 2013, we can identify experts anywhere in the world who are best qualified to meet client expectations.</p></td><td style="vertical-align:bottom;"><img src="../Images/quotes2.png"/></td></tr><tr><td></td><td><div style="position:relative;"><div style="position:absolute;top:30px;"><img src="../Images/testimonial_person.png"/></div><div style="position:absolute;left:70px;"><h3 style="margin-top:35px;margin-bottom:10px;">Senior Manager</h3><p class="blue tb">-Business Technology, US Management Consulting Firm</p></div></div></td><td></td></tr></table></div></div><div style="height:105px;"></div></div>
		<!-- use case-->
		
		<div class="whitebg bar"><div class="contentstretch whitebg"></div><div style="height:45px;"></div><div class="ucvid"><div class="inner"><table><tr><td class="cleft" style="width:582px;height:327px;position:relative;text-align:center;"><img class="cleft im" style="position:absolute;border: 1px solid #cccccc;" src="../Videos/4.1.png"/><img style="position:relative;cursor:pointer;" rel="10" id="https://mediasvc08rg9b3g5vnth.blob.core.windows.net/asset-12bdc1c2-0662-43df-9292-b235a22aeba1/Module%204%20-%20Demo%201.mp4?sv=2012-02-12&st=2013-05-24T19%3A21%3A14Z&se=2015-05-24T19%3A21%3A14Z&sr=c&si=76c3686a-6485-43b8-99a7-c8e714b2f78e&sig=PtP%2BAs4ozKqWUSPWJVxWWnkjEO5vyRckTt%2Bh449CJN0%3D" class="videolnk cleft" src="../Images/playbtn.png"/></td><td style="width:42px;"></td><td style="vertical-align:top;" class="cright" style="width:560px;"><div class="hd">Connect with people and keep track of ongoing conversations across your organization with the newsfeed. Start to follow people and topics of interest, so that your newsfeed shows you only what matters.</div><div style="height:35px;"></div><div class="dlbuttonm reg" rel="http://go.microsoft.com/fwlink/p/?LinkId=302020"><ul><li>Download video</li></ul></div></td></tr></table><div style="height:60px;"></div></div></div></div>

<div class="darkgraybg bar"><div style="border-top: 1px solid #cccccc;" style="border-top: 1px solid #cccccc;" class="contentstretch darkgraybg"></div><div style="height:45px;"></div><div class="ucvid"><div class="inner"><table><tr><td class="cleft" style="width:582px;height:327px;position:relative;text-align:center;"><img class="cleft im" style="position:absolute;border: 1px solid #cccccc;" src="../Videos/4.2.png"/><img style="position:relative;cursor:pointer;" rel="11" id="https://mediasvc08rg9b3g5vnth.blob.core.windows.net/asset-7965c0af-bbdb-4f0a-92dd-382c691d4e08/Module%204%20-%20Demo%202.mp4?sv=2012-02-12&st=2013-05-24T19%3A21%3A07Z&se=2015-05-24T19%3A21%3A07Z&sr=c&si=91cdd45c-0e42-42a6-a659-865d4b0d0c64&sig=5k2upHcxg3mXM0XuTxXT9xkGP%2FVmjimtRvIxcEuTlM8%3D" class="videolnk cleft" src="../Images/playbtn.png"/></td><td style="width:42px;"></td><td style="vertical-align:top;" class="cright" style="width:560px;"><div class="hd">Ask questions, share your knowledge, and connect with people through community sites where conversations are organized by categories and people are rewarded for the contributions they make.</div><div style="height:35px;"></div><div class="dlbuttonm reg" rel="http://go.microsoft.com/fwlink/p/?LinkId=302021"><ul><li>Download video</li></ul></div></td></tr></table><div style="height:60px;"></div></div></div></div>

<div class="whitebg bar"><div style="border-top: 1px solid #cccccc;" class="contentstretch whitebg"></div><div style="height:45px;"></div><div class="ucvid"><div class="inner"><table><tr><td class="cleft" style="width:582px;height:327px;position:relative;text-align:center;"><img class="cleft im" style="position:absolute;border: 1px solid #cccccc;" src="../Videos/4.3.png"/><img style="position:relative;cursor:pointer;" rel="12" id="https://mediasvc08rg9b3g5vnth.blob.core.windows.net/asset-f3e2aa87-1471-4d84-8b79-de70cb95ac57/Module%204%20-%20Demo%203.mp4?sv=2012-02-12&st=2013-05-24T19%3A03%3A55Z&se=2015-05-24T19%3A03%3A55Z&sr=c&si=05791e73-6292-44fb-8a8b-d6d0395fa369&sig=wmnc6KGR1huE4%2BvX%2F6Sl9p8QMHyUDLXfLwDWo0ER3%2Bw%3D" class="videolnk cleft" src="../Images/playbtn.png"/></td><td style="width:42px;"></td><td style="vertical-align:top;" class="cright" style="width:560px;"><div class="hd">Quickly discover experts across your organization from a single place, and find answers to your questions from existing conversations on newsfeeds or community sites.</div><div style="height:35px;"></div><div class="dlbuttonm reg" rel="http://go.microsoft.com/fwlink/p/?LinkId=302022"><ul><li>Download video</li></ul></div></td></tr></table><div style="height:60px;"></div></div></div></div>

					 <div class="footer oth">
						 <div style="border: 1px solid #cccccc;" class="contentstretch whitebg"></div>
						 <div class="colwrap"><div class="inner">
					 <div class="content">
					 </div></div></div>
					 </div>
		 </div>
		   
		   <div id="find_what_you_need" rel="5" class="column_content clearfix c_5" >
		<!-- Find What You Need -->
		<div class="findwhatyouneed bar"><div class="contentstretch findwhatyouneed"></div><div class="colwrap"><div class="inner"><table class="mntable"><tr><td class="cleft" class="cleft" style="width:582px;vertical-align:top;"><div style="height:50px;position:relative;"><div class="icons"></div></div><div class="rtext"><div class="textcont"><div class="white htext">Find what you need</div><p class="white mntext">Wouldn’t it be great if you could search for information at work just as easily as you do on the Internet? With SharePoint you can. First of all, you can do all of your searching from just one place. Second of all, you don’t have to come up with the perfect keywords to find what you need. Whether you’re looking for documents, videos, people, or conversations, SharePoint will help you save time and pinpoint exactly what you need—all from one place.</p></div></div><table class="arrowbtn"><tr><td><div class="more white" style="display:none;"><div style="height:6px;"></div><div class="hide"></div><div class="rtoggle"><img src="../Images/down-white.png"/>&nbsp;&nbsp;Show more</div></div></td><td><div style="height:6px;"></div><div class="gguide white"><a style="color:White;" target="_blank" href="http://go.microsoft.com/fwlink/p/?LinkId=309826"><img src="../Images/down-white.png"/>&nbsp;&nbsp;Get the Guide</a></div></td></tr></table></td><td class="cmid" style="width:120px"></td><td style="vertical-align:middle;"><div style="height:50px;"></div><img class="ucimage" style="width:480px" src="../Images/5tall_img.png"/></td></tr></table><div style="height:50px;position:relative;"></div></div></div></div>
	
		<!-- testimonial-->
		<div class="darkgraybg bar"><div class="contentstretch darkgraybg"></div><div style="height:20px;"></div><div class="colwraptxt"><div class="inner"><table><tr><td style="vertical-align:top;"><img src="../Images/quotes.png"/></td><td><p class="black tq2">There used to be so many places to look for information and multiple email accounts to search. Now we can quickly find the right information, the right version, and the best data.</p></td><td style="vertical-align:bottom;"><img src="../Images/quotes2.png"/></td></tr><tr><td></td><td><div style="position:relative;"><div style="position:absolute;top:30px;"><img src="../Images/testimonial_person.png"/></div><div style="position:absolute;left:70px;"><h3 style="margin-top:35px;margin-bottom:10px;">Paul Di Felice</h3><p class="blue tb">-Associate Director for Consulting and Analysis, Regional Municipality of Niagara</p></div></div></td><td></td></tr></table></div></div><div style="height:105px;"></div></div>
		<!-- use case-->
		
		<div class="whitebg bar"><div class="contentstretch whitebg"></div><div style="height:45px;"></div><div class="ucvid"><div class="inner"><table><tr><td class="cleft" style="width:582px;height:327px;position:relative;text-align:center;"><img class="cleft im" style="position:absolute;border: 1px solid #cccccc;" src="../Videos/5.1.png"/><img style="position:relative;cursor:pointer;" rel="13" id="https://mediasvc08rg9b3g5vnth.blob.core.windows.net/asset-4d68a02f-3373-439a-b9b8-0e477d202458/Module%205%20-%20Demo%201.mp4?sv=2012-02-12&st=2013-05-24T19%3A21%3A41Z&se=2015-05-24T19%3A21%3A41Z&sr=c&si=79795117-d2ce-4fa6-929d-c7f59a68e234&sig=vE6taOeJDUy4tkvzJJ6Vi%2Fk%2FA7ogZsEqd5MyBMXI5aY%3D" class="videolnk cleft" src="../Images/playbtn.png"/></td><td style="width:42px;"></td><td style="vertical-align:top;" class="cright" style="width:560px;"><div class="hd">Discover information across your organization with personalized results and recommendations from the search engine, whether you’re looking for documents, people, conversations, or even videos.</div><div style="height:35px;"></div><div class="dlbuttonm reg" rel="http://go.microsoft.com/fwlink/p/?LinkId=302023"><ul><li>Download video</li></ul></div></td></tr></table><div style="height:60px;"></div></div></div></div>
        
<div class="darkgraybg bar"><div style="border-top: 1px solid #cccccc;" class="contentstretch darkgraybg"></div><div style="height:45px;"></div><div class="ucvid"><div class="inner"><table><tr><td class="cleft" style="width:582px;height:327px;position:relative;text-align:center;"><img class="cleft im" style="position:absolute;border: 1px solid #cccccc;" src="../Videos/5.2.png"/><img style="position:relative;cursor:pointer;" rel="14" id="https://mediasvc08rg9b3g5vnth.blob.core.windows.net/asset-38f8e25a-9ed0-4e51-8592-b48d969afd0e/Module%205%20-%20Demo%202.mp4?sv=2012-02-12&st=2013-05-24T19%3A21%3A18Z&se=2015-05-24T19%3A21%3A18Z&sr=c&si=f7cc0bda-b402-4374-ba69-1700eaae55a2&sig=zKk3L7zuaa%2BDxJ2yJbrLyG2axKl8lFkRu0Ntnj4M%2FsU%3D" class="videolnk cleft" src="../Images/playbtn.png"/></td><td style="width:42px;"></td><td style="vertical-align:top;" class="cright" style="width:560px;"><div class="hd">Pinpoint the people and answers you need and fill out your profile so that others can find you: you’re an expert too.</div><div style="height:35px;"></div><div class="dlbuttonm reg" rel="http://go.microsoft.com/fwlink/p/?LinkId=302024"><ul><li>Download video</li></ul></div></td></tr></table><div style="height:60px;"></div></div></div></div>

<div class="whitebg bar"><div style="border-top: 1px solid #cccccc;" class="contentstretch whitebg"></div><div style="height:45px;"></div><div class="ucvid"><div class="inner"><table><tr><td class="cleft" style="width:582px;height:327px;position:relative;text-align:center;"><img class="cleft im" style="position:absolute;border: 1px solid #cccccc;" src="../Videos/5.3.png"/><img style="position:relative;cursor:pointer;" rel="15" id="https://mediasvc08rg9b3g5vnth.blob.core.windows.net/asset-968fa31c-d54d-48d0-b97d-f941454bd6d5/Module%205%20-%20Demo%203.mp4?sv=2012-02-12&st=2013-05-24T19%3A21%3A38Z&se=2015-05-24T19%3A21%3A38Z&sr=c&si=4d54ae04-ae5d-4576-8f7c-5ebcceb6e322&sig=rwt%2FOxVKVdVMTnMDDBwOV1SJmkrapuK65j4GgnkX2lw%3D" class="videolnk cleft" src="../Images/playbtn.png"/></td><td style="width:42px;"></td><td style="vertical-align:top;" class="cright" style="width:560px;"><div class="hd">Search for video content just as easily as any other type of content, and quickly dig deeper on the results to find exactly what you need.</div><div style="height:35px;"></div><div class="dlbuttonm reg" rel="http://go.microsoft.com/fwlink/p/?LinkId=302025"><ul><li>Download video</li></ul></div></td></tr></table><div style="height:60px;"></div></div></div></div>

					 <div class="footer oth">
						 <div style="border: 1px solid #cccccc;" class="contentstretch whitebg"></div>
						 <div class="colwrap"><div class="inner">
					 <div class="content">
					 </div></div></div>
					 </div>
		 </div>
				 
				 
				   <div id="make_informed_decisions" rel="6" class="column_content clearfix c_6" >
				   
				   
		<!-- Make informed Decisions-->
		<div class="betterdecisions bar"><div class="contentstretch betterdecisions"></div><div class="colwrap"><div class="inner"><table class="mntable"><tr><td class="cleft" style="width:582px;vertical-align:top;"><div style="height:50px;position:relative;"><div class="icons"></div></div><div class="rtext"><div class="textcont"><div class="white htext">Make informed decisions</div><p class="white mntext">Making good decisions is not always just about good judgment or experience. It’s also about collecting and making sense of lots of data. That’s where Power Pivot comes in: it lets you easily combine massive amounts of data from multiple sources and build sophisticated models out of it. But data alone isn’t enough—it needs to be expressed clearly to make a powerful impact on people. That’s what Power View is for. It lets you explore, visualize, and present data in compelling ways, and create exciting dashboards that you can quickly share with others in SharePoint. Now people can easily dig into your data to make great decisions and new discoveries.</p></div></div><table class="arrowbtn"><tr><td><div class="more white" style="display:none;"><div style="height:6px;"></div><div class="hide"></div><div class="rtoggle"><img src="../Images/down-white.png"/>&nbsp;&nbsp;Show more</div></div></td><td><div style="height:6px;"></div><div class="gguide white"><a style="color:White;" target="_blank" href="http://go.microsoft.com/fwlink/p/?LinkId=309829"><img src="../Images/down-white.png"/>&nbsp;&nbsp;Get the Guide</a></div></td></tr></table></td><td class="cmid" style="width:120px"></td><td style="vertical-align:middle;"><div style="height:50px;"></div><img class="ucimage" style="width:4800px" src="../Images/6tall_img.png"/></td></tr></table><div style="height:50px;position:relative;"></div></div></div></div>
	
<!-- testimonial-->
		<div class="darkgraybg bar"><div class="contentstretch darkgraybg"></div><div style="height:20px;"></div><div class="colwraptxt"><div class="inner"><table><tr><td style="vertical-align:top;"><img src="../Images/quotes.png"/></td><td><p class="black tq2">Power View allows executives and employees to look at their data from almost any angle at varying levels of granularity. Employees can use scorecards to easily track both time and performance metrics to be more effective in their jobs.</p></td><td style="vertical-align:bottom;"><img src="../Images/quotes2.png"/></td></tr><tr><td></td><td><div style="position:relative;"><div style="position:absolute;top:30px;"><img src="../Images/testimonial_person.png"/></div><div style="position:absolute;left:70px;"><h3 style="margin-top:35px;margin-bottom:10px;"> Paul Di Felice</h3><p class="blue tb">-Associate Director for Consulting and Analysis, Regional Municipality of Niagara</p></div></div></td><td></td></tr></table></div></div><div style="height:105px;"></div></div>
		<!-- use case-->
		
		<div class="whitebg bar"><div style="border-top: 1px solid #cccccc;" class="contentstretch whitebg"></div><div style="height:45px;"></div><div class="ucvid"><div class="inner"><table><tr><td class="cleft" style="width:582px;height:327px;position:relative;text-align:center;"><img class="cleft im" style="position:absolute;border: 1px solid #cccccc;" src="../Videos/6.1.png"/><img style="position:relative;cursor:pointer;" rel="18" id="https://mediasvc08rg9b3g5vnth.blob.core.windows.net/asset-b5982b8e-66df-47c8-b03b-20026486a4d3/Module%206%20-%20Demo%203.mp4?sv=2012-02-12&st=2013-05-24T19%3A21%3A28Z&se=2015-05-24T19%3A21%3A28Z&sr=c&si=504eb8ee-9e34-4099-94f1-713cc2d19bb1&sig=DaAwwf07rjkSvxQLHi8VGDjCqqodWLe%2BZZvS4RRqwrA%3D" class="videolnk cleft" src="../Images/playbtn.png"/></td><td style="width:42px;"></td><td style="vertical-align:top;" class="cright" style="width:560px;">
            <div class="hd">Gain valuable insights into your data with Power View so that you can ultimately make better decisions for your organization.</div>
            <div style="height:35px;"></div><div class="dlbuttonm reg" rel="http://go.microsoft.com/fwlink/p/?LinkId=302026
"><ul><li>Download video</li></ul></div></td></tr></table><div style="height:60px;"></div></div></div></div>
		
		<div class="darkgraybg bar"><div style="border-top: 1px solid #cccccc;" class="contentstretch darkgraybg"></div><div style="height:45px;"></div><div class="ucvid"><div class="inner"><table><tr><td class="cleft" style="width:582px;height:327px;position:relative;text-align:center;"><img class="cleft im" style="position:absolute;border: 1px solid #cccccc;" src="../Videos/6.2.png"/><img style="position:relative;cursor:pointer;" rel="16" id="https://mediasvc08rg9b3g5vnth.blob.core.windows.net/asset-b063e080-0a89-4e89-a403-8dbd59d30699/Module%206%20-%20Demo%201.mp4?sv=2012-02-12&st=2013-05-24T19%3A21%3A34Z&se=2015-05-24T19%3A21%3A34Z&sr=c&si=1f4caf40-c665-4943-bf79-11b83924df51&sig=HlVR9JReWcMhVOx3D0BMLAhpOFMcGOa7XUBDPars%2FW8%3D" class="videolnk cleft" src="../Images/playbtn.png"/></td><td style="width:42px;"></td><td style="vertical-align:top;" class="cright" style="width:560px;">
    <div class="hd">Create a powerful data model from all of your relevant data sources with Power Pivot.</div>
            <div style="height:35px;"></div><div class="dlbuttonm reg" rel="http://go.microsoft.com/fwlink/p/?LinkId=302027"><ul><li>Download video</li></ul></div></td></tr></table><div style="height:60px;"></div></div></div></div>

<div class="whitebg bar"><div class="contentstretch whitebg"></div><div style="height:45px;"></div><div class="ucvid"><div class="inner"><table><tr><td class="cleft" style="width:582px;height:327px;position:relative;text-align:center;"><img class="cleft im" style="position:absolute;border: 1px solid #cccccc;" src="../Videos/6.3.png"/><img style="position:relative;cursor:pointer;" rel="17" id="https://mediasvc08rg9b3g5vnth.blob.core.windows.net/asset-eb6579e1-7288-43c6-b2a2-3166d21992ca/Module%206%20-%20Demo%202.mp4?sv=2012-02-12&st=2013-05-24T19%3A27%3A28Z&se=2015-05-24T19%3A27%3A28Z&sr=c&si=80382c76-cf96-4daf-b20f-1480a52da7e5&sig=urCi5Sqg3tK9Rs0T5akwFcUIAf4ZQej%2FQeyt3snfx9Q%3D" class="videolnk cleft" src="../Images/playbtn.png"/></td><td style="width:42px;"></td><td style="vertical-align:top;" class="cright" style="width:560px;">
            <div class="hd">Whip up a stunning dashboard with Power View so that you can visualize and share your insights with everyone you need to in SharePoint.</div>
    <div style="height:35px;"></div><div class="dlbuttonm reg" rel="http://go.microsoft.com/fwlink/p/?LinkId=302028"><ul><li>Download video</li></ul></div></td></tr></table><div style="height:60px;"></div></div></div></div>



					 <div class="footer oth">
						 <div style="border: 1px solid #cccccc;" class="contentstretch whitebg"></div>
						 <div class="colwrap"><div class="inner">
					 <div class="content">
					 </div></div></div>
					 </div>
		 </div>
				 
				 
			
				 
				 <!-- HR AND INTERNAL COMMUNICATIONS wrapper -->
				 <div id="onboard_new_employees" rel="7" class="column_content clearfix c_7" >

					 <!-- HR AND INTERNAL COMMUNICATIONS visual -->


		<!-- Onboard new employees -->
		<div class="onboarding bar"><div class="contentstretch onboarding"></div><div class="colwrap"><div class="inner"><table class="mntable"><tr><td class="cleft" style="width:582px;vertical-align:top;"><div style="height:50px;position:relative;"><div class="icons"></div></div>
            <div class="rtext"><div class="textcont"><div class="white htext">Onboard new employees</div><p class="white mntext">First days are stressful—for both new employees and the HR department. There’s a lot to learn and a lot to tell. Where do you begin? SharePoint can be the single hub for everything that a new hire needs on its first day, and beyond. You can make it easier for people to connect with their peers or mentors, understand the business, and ramp up rapidly. You can take advantage of automatic task routing and use forms built right into your site, leading to less paperwork and faster completion. Better processes, less time, smoother onboarding. What’s there to stress about?</p></div></div><table class="arrowbtn"><tr><td><div class="more white" style="display:none;"><div style="height:6px;"></div><div class="hide"></div><div class="rtoggle"><img src="../Images/down-white.png"/>&nbsp;&nbsp;Show more</div></div></td><td><div style="height:6px;"></div><div class="gguideh white"><img src="../Images/down-white.png"/>&nbsp;&nbsp;Get the Guide</div></td></tr></table></td><td class="cmid" style="width:120px"></td><td style="vertical-align:middle;"><div style="height:50px;"></div><img class="ucimage" style="width:4800px" src="../Images/9tall_img.png"/></td></tr></table><div style="height:50px;position:relative;"></div></div></div></div>
		
		<!-- testimonial-->
		<div class="darkgraybg bar"><div class="contentstretch darkgraybg"></div><div style="height:20px;"></div><div class="colwraptxt"><div class="inner"><table><tr><td style="vertical-align:top;"><img src="../Images/quotes.png"/></td><td><p class="black tq2">Electronic records not only reduce paper consumption, they also save on transportation and energy costs for moving and storing those records.</p></td><td style="vertical-align:bottom;"><img src="../Images/quotes2.png"/></td></tr><tr><td></td><td><div style="position:relative;"><div style="position:absolute;top:30px;"><img src="../Images/testimonial_person.png"/></div><div style="position:absolute;left:70px;"><h3 style="margin-top:35px;margin-bottom:10px;">Steve Folkerts</h3><p class="blue tb">-Project Manager for ECM, Regional Municipality of Niagara</p></div></div></td><td></td></tr></table></div></div><div style="height:105px;"></div></div>
		
		<!-- use case-->
		<div class="whitebg bar"><div class="contentstretch whitebg"></div><div class="ucvid"><div style="width:100%;background:#fff;text-align:center;"><img style="max-width:100%" src="../Images/comingsoon.png"/></div></div></div>


					 <div class="footer oth">
						 <div style="border: 1px solid #cccccc;" class="contentstretch whitebg"></div>
						 <div class="colwrap"><div class="inner">
					 <div class="content">
					 </div></div></div>
					 </div>
		 </div>
		 
			<!-- Keep Everyone Informed -->
			
		<div id="keep_everyone_informed" rel="8" class="column_content clearfix c_8" >
	
		<div class="informed bar"><div class="contentstretch informed"></div><div class="colwrap"><div class="inner"><table class="mntable"><tr><td class="cleft" style="width:582px;vertical-align:top;"><div style="height:50px;position:relative;"><div class="icons"></div></div><div class="rtext"><div class="textcont"><div class="white htext">Keep everyone informed</div><p class="white mntext">Your company has a unique story, but like any great tale, it needs people to make it come alive. How do you get your employees excited about your vision? How do you get them talking about ideas…and talking to each other? SharePoint makes it easy to keep everyone engaged. It’s a one-stop shop where people can find the latest news and information. It can be a great place for people to have live discussions, give real-time feedback, and share experiences. SharePoint is like a “social glue” that keeps your employees and your vision moving forward together.</p></div></div><table class="arrowbtn"><tr><td><div class="more white" style="display:none;"><div style="height:6px;"></div><div class="hide"></div><div class="rtoggle"><img src="../Images/down-white.png"/>&nbsp;&nbsp;Show more</div></div></td><td><div style="height:6px;"></div><div class="gguideh white"><img src="../Images/down-white.png"/>&nbsp;&nbsp;Get the Guide</div></td></tr></table></td><td class="cmid" style="width:120px"></td><td style="vertical-align:middle;"><div style="height:50px;"></div><img class="ucimage" style="width:4800px" src="../Images/10tall_img.png"/></td></tr></table><div style="height:50px;position:relative;"></div></div></div></div>
		
		<!-- testimonial-->
		<div class="darkgraybg bar"><div class="contentstretch darkgraybg"></div><div style="height:20px;"></div><div class="colwraptxt"><div class="inner"><table><tr><td style="vertical-align:top;"><img src="../Images/quotes.png"/></td><td><p class="black tq2">We will help people work together natively and intuitively, without having to negotiate department boundaries or navigate multiple sources of information.</p></td><td style="vertical-align:bottom;"><img src="../Images/quotes2.png"/></td></tr><tr><td></td><td><div style="position:relative;"><div style="position:absolute;top:30px;"><img src="../Images/testimonial_person.png"/></div><div style="position:absolute;left:70px;"><h3 style="margin-top:35px;margin-bottom:10px;">Head of Content Management</h3><p class="blue tb">-Finance Services, Banking</p></div></div></td><td></td></tr></table></div></div><div style="height:105px;"></div></div>
		
		<!-- use case-->
		<div class="whitebg bar"><div class="contentstretch whitebg"></div><div class="ucvid"><div style="width:100%;background:#fff;text-align:center;"><img style="max-width:100%" src="../Images/comingsoon.png"/></div></div></div>

					 <div class="footer oth">
						 <div style="border: 1px solid #cccccc;" class="contentstretch whitebg"></div>
						 <div class="colwrap"><div class="inner">
					 <div class="content">
					 </div></div></div>
					 </div>
		 </div>
				 
				  <!-- R&D, PRODUCTION, AND OPERATIONS wrapper -->
				 <div id="share_your_knowledge" rel="9" class="column_content clearfix c_9" >

					 <!-- R&D, PRODUCTION, AND OPERATIONS visual -->


		<!-- Share Your Knowledge -->
		<div class="sharepractices bar"><div class="contentstretch sharepractices"></div><div class="colwrap"><div class="inner"><table class="mntable"><tr><td class="cleft" style="width:582px;vertical-align:top;"><div style="height:50px;position:relative;"><div class="icons"></div></div><div class="rtext"><div class="textcont"><div class="black htext">Share your knowledge</div><p class="black mntext">With SharePoint, your knowledge isn’t limited to the people in your immediate circle. SharePoint lets you share what you know with as many people as you want, whether they’re in your department or in another country. So don’t let your good ideas, valuable experience, and expert knowledge go to waste. You can capture and organize best practices in one place, organize them however you need to, and refine them with your peers. Now people in your organization can easily discover what you know. And sharing works both ways, too. It’s just as easy for you to discover other groups’ best practices.</p></div></div><table class="arrowbtn"><tr><td><div class="more white" style="display:none;"><div style="height:6px;"></div><div class="hide"></div><div class="rtoggle black"><img src="../Images/down.png"/>&nbsp;&nbsp;Show more</div></div></td><td><div style="height:6px;"></div><div class="gguideh reg"><img src="../Images/down.png"/>&nbsp;&nbsp;Get the Guide</div></td></tr></table></td><td class="cmid" style="width:120px"></td><td style="vertical-align:middle;"><div style="height:50px;"></div><img class="ucimage" style="width:4800px" src="../Images/11tall_img.png"/></td></tr></table><div style="height:50px;position:relative;"></div></div></div></div>
		
		<!-- testimonial-->
		<div class="darkgraybg bar"><div class="contentstretch darkgraybg"></div><div style="height:20px;"></div><div class="colwraptxt"><div class="inner"><table><tr><td style="vertical-align:top;"><img src="../Images/quotes.png"/></td><td><p class="black tq2">We want to create a better sense of community and help employees find colleagues who might have the answers to their questions.</p></td><td style="vertical-align:bottom;"><img src="../Images/quotes2.png"/></td></tr><tr><td></td><td><div style="position:relative;"><div style="position:absolute;top:30px;"><img src="../Images/testimonial_person.png"/></div><div style="position:absolute;left:70px;"><h3 style="margin-top:35px;margin-bottom:10px;">Cedric Krouri</h3><p class="blue tb">-IT Project Manager, Aéroports de Paris</p></div></div></td><td></td></tr></table></div></div><div style="height:105px;"></div></div>
		
		<!-- use case-->
		<div class="whitebg bar"><div class="contentstretch whitebg"></div><div class="ucvid"><div style="width:100%;background:#fff;text-align:center;"><img style="max-width:100%" src="../Images/comingsoon.png"/></div></div></div>

					 <div class="footer oth">
						 <div style="border: 1px solid #cccccc;" class="contentstretch whitebg"></div>
						 <div class="colwrap"><div class="inner">
					 <div class="content">
					 </div></div></div>
					 </div>
		 </div>
		
<!-- Improve and monitor business processes -->
		
		<div id="boost_business_processes" rel="10" class="column_content clearfix c_10" >
		
		<div class="improveprocesses bar"><div class="contentstretch improveprocesses"></div><div class="colwrap"><div class="inner"><table class="mntable"><tr><td class="cleft" style="width:582px;vertical-align:top;"><div style="height:50px;position:relative;"><div class="icons"></div></div><div class="rtext"><div class="textcont"><div class="black htext">Boost business processes</div><p class="black mntext">Do you ever wish you could improve your business processes and help people save time? With SharePoint you can. For example, automating recurring approval or review processes is easy and doesn’t take much time with built-in workflows. With Visio you can work with others to design and model processes that run in SharePoint. Once processes are in place, you can keep an eye on how well they’re performing for your team, department, or the entire organization. Whenever you need to you can refine your processes or create reports from them.</p></div></div><table class="arrowbtn"><tr><td><div class="more white" style="display:none;"><div style="height:6px;"></div><div class="hide"></div><div class="rtoggle black"><img src="../Images/down.png"/>&nbsp;&nbsp;Show more</div></div></td><td><div style="height:6px;"></div><div class="gguideh reg"><img src="../Images/down.png"/>&nbsp;&nbsp;Get the Guide</div></td></tr></table></td><td class="cmid" style="width:120px"></td><td style="vertical-align:middle;"><div style="height:50px;"></div><img class="ucimage" style="width:4800px" src="../Images/12tall_img.png"/></td></tr></table><div style="height:50px;position:relative;"></div></div></div></div>
		
		<!-- testimonial-->
		<div class="darkgraybg bar"><div class="contentstretch darkgraybg"></div><div style="height:20px;"></div><div class="colwraptxt"><div class="inner"><table><tr><td style="vertical-align:top;"><img src="../Images/quotes.png"/></td><td><p class="black tq2">By eliminating non-value-add manual work we are able to speed the processing, better serve our customers and manage the business growth of 25% with fewer staff.</p></td><td style="vertical-align:bottom;"><img src="../Images/quotes2.png"/></td></tr><tr><td></td><td><div style="position:relative;"><div style="position:absolute;top:30px;"><img src="../Images/testimonial_person.png"/></div><div style="position:absolute;left:70px;"><h3 style="margin-top:35px;margin-bottom:10px;">Kyle Butt</h3><p class="blue tb">-MIS Team Leader, Yokohama Tire Canada</p></div></div></td><td></td></tr></table></div></div><div style="height:105px;"></div></div>
		
		<!-- use case-->
		<div class="whitebg bar"><div class="contentstretch whitebg"></div><div class="ucvid"><div style="width:100%;background:#fff;text-align:center;"><img style="max-width:100%" src="../Images/comingsoon.png"/></div></div></div>

					 <div class="footer oth">
						 <div style="border: 1px solid #cccccc;" class="contentstretch whitebg"></div>
						 <div class="colwrap"><div class="inner">
					 <div class="content">
					 </div></div></div>
					 </div>
		 </div>
				<!-- SALES AND MARKETING wrapper -->
				 <div id="make_your_customers_happy" rel="11" class="column_content clearfix c_11" >

					 <!-- SALES AND MARKETING visual -->

		<!-- Make Your Customers And Partners Happy -->
		<div class="improvecustomer bar"><div class="contentstretch improvecustomer"></div><div class="colwrap"><div class="inner"><table class="mntable"><tr><td class="cleft" style="width:582px;vertical-align:top;"><div style="height:50px;position:relative;"><div class="icons"></div></div><div class="rtext"><div class="textcont"><div class="white htext">Make your customers and partners happy</div><p class="white mntext">People want to find what they need right away without digging around or being distracted by irrelevant content. SharePoint can help you make your customers and partners happy by giving them what they really want—relevant information, recommendations, and insights into their data. With SharePoint, you can build either simple and dedicated portals or public-facing websites so that your customers and partners get what they need.</p></div></div></div><table class="arrowbtn"><tr><td><div class="more white" style="display:none;"><div style="height:6px;"></div><div class="hide"></div><div class="rtoggle"><img src="../Images/down-white.png"/>&nbsp;&nbsp;Show more</div></div></td><td><div style="height:6px;"></div><div class="gguideh white"><img src="../Images/down-white.png"/>&nbsp;&nbsp;Get the Guide</div></td></tr></table></td><td class="cmid" style="width:120px"></td><td style="vertical-align:middle;"><div style="height:50px;"></div><img class="ucimage" style="width:4800px" src="../Images/13tall_img.png"/></td></tr></table><div style="height:50px;position:relative;"></div></div></div></div>
		
		<!-- testimonial-->
		<div class="darkgraybg bar"><div class="contentstretch darkgraybg"></div><div style="height:20px;"></div><div class="colwraptxt"><div class="inner"><table><tr><td style="vertical-align:top;"><img src="../Images/quotes.png"/></td><td><p class="black tq2">SharePoint allows our distributor network to access this vast amount of technical data 24 hours a day, 7 days a week. We don’t have to worry about copying files from different locations.</p></td><td style="vertical-align:bottom;"><img src="../Images/quotes2.png"/></td></tr><tr><td></td><td><div style="position:relative;"><div style="position:absolute;top:30px;"><img src="../Images/testimonial_person.png"/></div><div style="position:absolute;left:70px;"><h3 style="margin-top:35px;margin-bottom:10px;">Chris Russell</h3><p class="blue tb">-Director of Development, Street Crane Company Limited</p></div></div></td><td></td></tr></table></div></div><div style="height:105px;"></div></div>
		
		<!-- use case-->
		<div class="whitebg bar"><div class="contentstretch whitebg"></div><div class="ucvid"><div style="width:100%;background:#fff;text-align:center;"><img style="max-width:100%" src="../Images/comingsoon.png"/></div></div></div>

					 <div class="footer oth">
						 <div style="border: 1px solid #cccccc;" class="contentstretch whitebg"></div>
						 <div class="colwrap"><div class="inner">
					 <div class="content">
					 </div></div></div>
					 </div>
		 </div>
				 
		<div id="engage_your_audience_online" rel="12" class="column_content clearfix c_12" >
		
		<!-- Engage Your Audience Online -->
		<div class="buildonline bar"><div class="contentstretch buildonline"></div><div class="colwrap"><div class="inner"><table class="mntable"><tr><td class="cleft" style="width:582px;vertical-align:top;"><div style="height:50px;position:relative;"><div class="icons"></div></div><div class="rtext"><div class="textcont"><div class="white htext">Engage your audience online</div><p class="white mntext">People expect the same experience no matter how they access your site. To make sure they get it, SharePoint makes it possible for you to deliver a consistent, unified digital experience on laptops, smartphones, and tablets. Not only are your SharePoint sites accessible from any device, but they also deliver targeted, highly relevant content and personalized recommendations to your audience around the globe. Building a global brand is now easier than ever, and SharePoint also helps you stay in compliance with copyright and other legal requirements by ensuring consistency across all of your sites. </p></div></div><table class="arrowbtn"><tr><td><div class="more white" style="display:none;"><div style="height:6px;"></div><div class="hide"></div><div class="rtoggle"><img src="../Images/down-white.png"/>&nbsp;&nbsp;Show more</div></div></td><td><div style="height:6px;"></div><div class="gguideh white"><img src="../Images/down-white.png"/>&nbsp;&nbsp;Get the Guide</div></td></tr></table></td><td class="cmid" style="width:120px"></td><td style="vertical-align:middle;"><div style="height:50px;"></div><img class="ucimage" style="width:4800px" src="../Images/14tall_img.png"/></td></tr></table><div style="height:50px;position:relative;"></div></div></div></div>
		
		<!-- testimonial-->
		<div class="darkgraybg bar"><div class="contentstretch darkgraybg"></div><div style="height:20px;"></div><div class="colwraptxt"><div class="inner"><table><tr><td style="vertical-align:top;"><img src="../Images/quotes.png"/></td><td><p class="black tq2">SharePoint has enhanced our mobile publishing capabilities. And it adds public catalog capabilities to implement one global product catalog for a specific brand and we can use that through various sites.</p></td><td style="vertical-align:bottom;"><img src="../Images/quotes2.png"/></td></tr><tr><td></td><td><div style="position:relative;"><div style="position:absolute;top:30px;"><img src="../Images/testimonial_person.png"/></div><div style="position:absolute;left:70px;"><h3 style="margin-top:35px;margin-bottom:10px;">Alex Alexandrou</h3><p class="blue tb">-Vice President of Global IS, Web Technology, D+M Group</p></div></div></td><td></td></tr></table></div></div><div style="height:105px;"></div></div>
		
		<!-- use case-->
		<div class="whitebg bar"><div class="contentstretch whitebg"></div><div class="ucvid"><div style="width:100%;background:#fff;text-align:center;"><img style="max-width:100%" src="../Images/comingsoon.png"/></div></div></div>

					 <div class="footer oth">
						 <div style="border: 1px solid #cccccc;" class="contentstretch whitebg"></div>
						 <div class="colwrap"><div class="inner">
					 <div class="content">
					 </div></div></div>
					 </div>
		 </div>
		
		<div id="align_your_teams" rel="13" class="column_content clearfix c_13" >
		
		<!-- Make teamwork easier -->
		<div class="alignsales bar"><div class="contentstretch alignsales"></div><div class="colwrap"><div class="inner"><table class="mntable"><tr><td class="cleft" style="width:582px;vertical-align:top;"><div style="height:50px;position:relative;"><div class="icons"></div></div><div class="rtext"><div class="textcont"><div class="white htext">Align your teams</div><p class="white mntext">Deals are won and lost depending on how closely marketing and sales teams are aligned. That’s how important communication is and that’s why SharePoint gives people a better way to stay in sync. SharePoint is the place where sales representatives can access the most up-to-date marketing information, even when on the road, so that messaging is consistent. It’s also where sales and marketing teams can have conversations, share ideas, and refine content together. Best of all, they can share best practices and knowledge on customers, competitors, or sales processes so they can act on new opportunities and close deals more quickly. </p></div></div><table class="arrowbtn"><tr><td><div class="more white" style="display:none;"><div style="height:6px;"></div><div class="hide"></div><div class="rtoggle"><img src="../Images/down-white.png"/>&nbsp;&nbsp;Show more</div></div></td><td><div style="height:6px;"></div><div class="gguideh white"><img src="../Images/down-white.png"/>&nbsp;&nbsp;Get the Guide</div></td></tr></table></td><td class="cmid" style="width:120px"></td><td style="vertical-align:middle;"><div style="height:50px;"></div><img class="ucimage" style="width:4800px" src="../Images/15tall_img.png"/></td></tr></table><div style="height:50px;position:relative;"></div></div></div></div>
		
		<!-- testimonial-->
		<div class="darkgraybg bar"><div class="contentstretch darkgraybg"></div><div style="height:20px;"></div><div class="colwraptxt"><div class="inner"><table><tr><td style="vertical-align:top;"><img src="../Images/quotes.png"/></td><td><p class="black tq2">SharePoint allows us to build communities at United Airlines, around the products and services that we want to deliver to our customers.</p></td><td style="vertical-align:bottom;"><img src="../Images/quotes2.png"/></td></tr><tr><td></td><td><div style="position:relative;"><div style="position:absolute;top:30px;"><img src="../Images/testimonial_person.png"/></div><div style="position:absolute;left:70px;"><h3 style="margin-top:35px;margin-bottom:10px;">Eric Craig</h3><p class="blue tb">-Managing Director of Platform Engineering, United Airlines</p></div></div></td><td></td></tr></table></div></div><div style="height:105px;"></div></div>
		
		<!-- use case-->
		<div class="whitebg bar"><div class="contentstretch whitebg"></div><div class="ucvid"><div style="width:100%;background:#fff;text-align:center;"><img style="max-width:100%" src="../Images/comingsoon.png"/></div></div></div>

					 <div class="footer oth">
						 <div style="border: 1px solid #cccccc;" class="contentstretch whitebg"></div>
						 <div class="colwrap"><div class="inner">
					 <div class="content">
					 </div></div></div>
					 </div>
		 </div>
				 
				 <!-- FINANCE AND ACCOUNTING wrapper -->
				 <div id="crunch_the_numbers_together" rel="14" class="column_content clearfix c_14" >

					 <!-- FINANCE AND ACCOUNTING visual -->

<!-- Run the numbers better -->
		<div class="numbers bar"><div class="contentstretch numbers"></div><div class="colwrap"><div class="inner"><table class="mntable"><tr><td class="cleft" style="width:582px;vertical-align:top;"><div style="height:50px;position:relative;"><div class="icons"></div></div><div class="rtext"><div class="textcont"><div class="white htext">Crunch the numbers together</div><p class="white mntext">Crunching the numbers doesn’t have to be difficult. SharePoint lets you gather a lot of information from different people and different departments into a single spreadsheet. Best of all, you can work with more than one person—even your whole team if you want—on the same spreadsheet at the same time. Crunching the numbers together doesn’t just make your life easier, but it also helps boost productivity and can lead to more insights that can be easily shared with anyone in your organization. </p></div></div><table class="arrowbtn"><tr><td><div class="more white" style="display:none;"><div style="height:6px;"></div><div class="hide"></div><div class="rtoggle"><img src="../Images/down-white.png"/>&nbsp;&nbsp;Show more</div></div></td><td><div style="height:6px;"></div><div class="gguideh white"><img src="../Images/down-white.png"/>&nbsp;&nbsp;Get the Guide</div></td></tr></table></td><td class="cmid" style="width:120px"></td><td style="vertical-align:middle;"><div style="height:50px;"></div><img class="ucimage" style="width:480px" src="../Images/16tall_img.png"/></td></tr></table><div style="height:50px;position:relative;"></div></div></div></div>
		
		<!-- testimonial-->
		<div class="darkgraybg bar"><div class="contentstretch darkgraybg"></div><div style="height:20px;"></div><div class="colwraptxt"><div class="inner"><table><tr><td style="vertical-align:top;"><img src="../Images/quotes.png"/></td><td><p class="black tq2">We have a lot of data, and SharePoint 2013 allows us to extract value from it. Instead of just storing it, we can turn it into information and insights.</p></td><td style="vertical-align:bottom;"><img src="../Images/quotes2.png"/></td></tr><tr><td></td><td><div style="position:relative;"><div style="position:absolute;top:30px;"><img src="../Images/testimonial_person.png"/></div><div style="position:absolute;left:70px;"><h3 style="margin-top:35px;margin-bottom:10px;">Paul Di Felice</h3><p class="blue tb">-Associate Director for Consulting and Analysis, Regional Municipality of Niagara</p></div></div></td><td></td></tr></table></div></div><div style="height:105px;"></div></div>
		
		<!-- use case-->
		<div class="whitebg bar"><div class="contentstretch whitebg"></div><div class="ucvid"><div style="width:100%;background:#fff;text-align:center;"><img style="max-width:100%" src="../Images/comingsoon.png"/></div></div></div>

					 <div class="footer oth">
						 <div style="border: 1px solid #cccccc;" class="contentstretch whitebg"></div>
						 <div class="colwrap"><div class="inner">
					 <div class="content">
					 </div></div></div>
					 </div>
		 </div>
				 
				 <!-- LEGAL wrapper -->
				 <div id="help_meet_compliance_needs" rel="15" class="column_content clearfix c_15">

					 <!-- LEGAL visual -->

		<!-- Help Meet Compliance Needs -->
		<div class="retention bar"><div class="contentstretch retention"></div><div class="colwrap"><div class="inner"><table class="mntable"><tr><td class="cleft" style="width:582px;vertical-align:top;"><div style="height:50px;position:relative;"><div class="icons"></div></div><div class="rtext"><div class="textcont"><div class="white htext">Help meet compliance needs</div><p class="white mntext">Trying to make sense of all the rules, laws, and regulations you need to follow is hard enough without retrofitting your whole IT infrastructure to comply with them. You won’t run into this problem with SharePoint because it’s built to make compliance easy and straightforward. In fact, with SharePoint you can automate many of the processes for managing, protecting, and preserving critical data, and even create retention schedules to manage the entire life cycle of your organization’s digital assets. If you ever need to respond quickly to litigation or audits, you can use self-service eDiscovery to help get what you need immediately without involving IT.</p></div></div><table class="arrowbtn"><tr><td><div class="more white" style="display:none;"><div style="height:6px;"></div><div class="hide"></div><div class="rtoggle"><img src="../Images/down-white.png"/>&nbsp;&nbsp;Show more</div></div></td><td><div style="height:6px;"></div><div class="gguideh white"><img src="../Images/down-white.png"/>&nbsp;&nbsp;Get the Guide</div></td></tr></table></td><td class="cmid" style="width:120px"></td><td style="vertical-align:middle;"><div style="height:50px;"></div><img class="ucimage" style="width:480px" src="../Images/17tall_img.png"/></td></tr></table><div style="height:50px;position:relative;"></div></div></div></div>
		
		<!-- testimonial-->
		<div class="darkgraybg bar"><div class="contentstretch darkgraybg"></div><div style="height:20px;"></div><div class="colwraptxt"><div class="inner"><table><tr><td style="vertical-align:top;"><img src="../Images/quotes.png"/></td><td><p class="black tq2">The tight integration of the Office Suite with SharePoint 2013 will enable true eDiscovery which, for our enterprise, was the original goal for deployment of SharePoint system-wide.</p></td><td style="vertical-align:bottom;"><img src="../Images/quotes2.png"/></td></tr><tr><td></td><td><div style="position:relative;"><div style="position:absolute;top:30px;"><img src="../Images/testimonial_lady.png"/></div><div style="position:absolute;left:70px;"><h3 style="margin-top:35px;margin-bottom:10px;">Denise Wilson</h3><p class="blue tb">-Senior Manager, Platform Engineering, Microsoft Collaboration Services, United Airlines</p></div></div></td><td></td></tr></table></div></div><div style="height:105px;"></div></div>
		
		<!-- use case-->
		<div class="whitebg bar"><div class="contentstretch whitebg"></div><div class="ucvid"><div style="width:100%;background:#fff;text-align:center;"><img style="max-width:100%" src="../Images/comingsoon.png"/></div></div></div>

					 <div class="footer oth">
						 <div style="border: 1px solid #cccccc;" class="contentstretch whitebg"></div>
						 <div class="colwrap"><div class="inner">
					 <div class="content">
					 </div></div></div>
					 </div>
		 </div>

<!--INFORMATION TECHNOLOGY  wrapper -->
				 <div id="provide_the_right_support" rel="16" class="column_content clearfix c_16" >

					 <!-- INFORMATION TECHNOLOGY visual -->

	<!-- Provide The Right Support -->
		<div class="rightsupport bar"><div class="contentstretch rightsupport"></div><div class="colwrap"><div class="inner"><table class="mntable"><tr><td class="cleft" style="width:582px;vertical-align:top;"><div style="height:50px;position:relative;"><div class="icons"></div></div><div class="rtext"><div class="textcont"><div class="white htext">Provide the right support </div><p class="white mntext">SharePoint can help you take your IT support beyond the telephone—way beyond. Think of it as a virtual helpdesk. A one-stop shop where people can get in touch with IT, browse through a shared knowledge base, and submit ticket requests to get help. The result? Quicker answers to common problems. Better system maintenance with regular health checks. And faster, more focused conversations between people and IT—all without ever being placed on hold.</p></div></div><table class="arrowbtn"><tr><td><div class="more white" style="display:none;"><div style="height:6px;"></div><div class="hide"></div><div class="rtoggle"><img src="../Images/down-white.png"/>&nbsp;&nbsp;Show more</div></div></td><td><div style="height:6px;"></div><div class="gguideh white"><img src="../Images/down-white.png"/>&nbsp;&nbsp;Get the Guide</div></td></tr></table></td><td class="cmid" style="width:120px"></td><td style="vertical-align:middle;"><div style="height:50px;"></div><img class="ucimage" style="width:4800px" src="../Images/7tall_img.png"/></td></tr></table><div style="height:50px;position:relative;"></div></div></div></div>
		
		<!-- testimonial-->
		<div class="darkgraybg bar"><div class="contentstretch darkgraybg"></div><div style="height:20px;"></div><div class="colwraptxt"><div class="inner"><table><tr><td style="vertical-align:top;"><img src="../Images/quotes.png"/></td><td><p class="black tq2">With SharePoint 2013, we can input information in one place and then deliver that information to anyone in the organization, anytime, anywhere.</p></td><td style="vertical-align:bottom;"><img src="../Images/quotes2.png"/></td></tr><tr><td></td><td><div style="position:relative;"><div style="position:absolute;top:30px;"><img src="../Images/testimonial_person.png"/></div><div style="position:absolute;left:70px;"><h3 style="margin-top:35px;margin-bottom:10px;">Ian Bell</h3><p class="blue tb">-Head of ICT, Cambridgeshire Constabulary</p></div></div></td><td></td></tr></table></div></div><div style="height:105px;"></div></div>
		<!-- use case-->
		
		<div class="whitebg bar"><div class="contentstretch whitebg"></div><div class="ucvid"><div style="width:100%;background:#fff;text-align:center;"><img style="max-width:100%" src="../Images/comingsoon.png"/></div></div></div>


					 <div class="footer oth">
						 <div style="border: 1px solid #cccccc;" class="contentstretch whitebg"></div>
						 <div class="colwrap"><div class="inner">
					 <div class="content">
					 </div></div></div>
					 </div>
		 </div>
		 
		 
			<div id="empower_people_and_stay_in_control" rel="17" class="column_content clearfix c_17" >	 
				 
		<!-- Empower People And Stay In Control -->
		<div class="empowerpeople bar"><div class="contentstretch empowerpeople"></div><div class="colwrap"><div class="inner"><table class="mntable"><tr><td class="cleft" style="width:582px;vertical-align:top;"><div style="height:50px;position:relative;"><div class="icons"></div></div><div class="rtext"><div class="textcont"><div class="white htext">Empower people and stay in control</div><p class="white mntext">It’s a common dilemma: How do you strike a balance between the needs of IT and the needs of users? IT needs centralized control over security and compliance to better manage risks. People want more flexibility in SharePoint to work together. So who’s right? With SharePoint, everyone’s right. IT can make SharePoint more open and provide a safety net so that people’s sites comply with IT controls, permissions, and policies. It’s a win-win situation.</p></div></div><table class="arrowbtn"><tr><td><div class="more white" style="display:none;"><div style="height:6px;"></div><div class="hide"></div><div class="rtoggle"><img src="../Images/down-white.png"/>&nbsp;&nbsp;Show more</div></div></td><td><div style="height:6px;"></div><div class="gguideh white"><img src="../Images/down-white.png"/>&nbsp;&nbsp;Get the Guide</div></td></tr></table></td><td class="cmid" style="width:120px"></td><td style="vertical-align:middle;"><div style="height:50px;"></div><img class="ucimage" style="width:4800px" src="../Images/8tall_img.png"/></td></tr></table><div style="height:50px;position:relative;"></div></div></div></div>
		
		<!-- testimonial-->
		<div class="darkgraybg bar"><div class="contentstretch darkgraybg"></div><div style="height:20px;"></div><div class="colwraptxt"><div class="inner"><table><tr><td style="vertical-align:top;"><img src="../Images/quotes.png"/></td><td><p class="black tq2">Site creation is automated, and we assign metadata at the site level, rather than the document level, so it's easier to use. The system integrates with our records management workflows, so documents are automatically retained and disposed of according to mandated schedules.</p></td><td style="vertical-align:bottom;"><img src="../Images/quotes2.png"/></td></tr><tr><td></td><td><div style="position:relative;"><div style="position:absolute;top:30px;"><img src="../Images/testimonial_person.png"/></div><div style="position:absolute;left:70px;"><h3 style="margin-top:35px;margin-bottom:10px;">Steve Folkerts</h3><p class="blue tb">- Project Manager for ECM, Regional Municipality of Niagara</p></div></div></td><td></td></tr></table></div></div><div style="height:105px;"></div></div>
		<!-- use case-->
		
	

<div class="whitebg bar"><div class="contentstretch whitebg"></div><div class="ucvid"><div style="width:100%;background:#fff;text-align:center;"><img style="max-width:100%" src="../Images/comingsoon.png"/></div></div></div>

					 <div class="footer oth">
						 <div style="border: 1px solid #cccccc;" class="contentstretch whitebg"></div>
						 <div class="colwrap"><div class="inner">
					 <div class="content">
					 </div></div></div>
					 </div>
		 </div>
		 
		 
 <!-- Controlpanel wrapper -->
	<div id="control_panel" style="position:absolute;top:0px;z-index:510;display:none;width:100%;">
<div class="darkbluebg" style="height:70px"></div>
					 <!-- Controlpanel visual -->
					 
		<div class="whitebg" style="height:150px;position:relative;"><div class="colwrap"><div class="inner"><table style="width:1240px;"><tr><td style="width:80%"><h2>Control Panel</h2></td><td style="position:relative;width:20%;"><div style="right:70px;position:absolute;top:6px;"><h3 id="admintitle" style="margin-top:0px;margin-bottom:8px;"><asp:Literal ID="adminname" runat="server"></asp:Literal></h3><div style="cursor:pointer;text-align:right;padding-bottom:5px;" id="settings" class="tb blue">settings</div><div style="cursor:pointer;text-align:right;" id="exitcp" class="tb blue">exit control panel</div></div>
        </td></tr></table></div></div></div>
		<div class="whitebg" style="height:400px;position:relative;border:"><div class="colwrap"><div class="inner"><table><tr><td class="txtholder" style="vertical-align:top;"><p>Feature the best use cases for your business. They could be random, or how you want people to learn about SharePoint. Make the use cases most relevant to your company really stand out!<br><br>These settings apply to all users in your organization.</p><table><tr><td><img style="padding:10px;" src="../Images/admin_hidebig.png"/></td><td class="ptext" style="width:100%;vertical-align:middle;">Not interested in people learning about a specific use case? Click the “eye” icon to hide it from the app.</td></tr><tr><td><img style="padding:10px;" src="../Images/admin_checkedbig.png"/></td><td class="ptext" style="width:100%;vertical-align:middle;">Recommend sections for people to look at.</td></tr></table></td><td class="icholder"><div style="position:relative;"><img style="position:absolute;top:-20px;right:0px;" id="nextfav2" rel="0" src="../Images/next.png"/></div><div class="pages-holder">
                <section ID="Section8" class="page-homepage current-page page">
                    <div id="favholder2" class="row-fluid">
                    </div>
                </section>
            </div></td></tr></table>
        </div></div></div>
		<!-- getstarted-->
		<div class="whitebg" style="height:500px;position:relative;"><div class="colwrap"><div style="border-top:solid 1px #222;" class="inner">
		<table style="width:1240px;"><tr><td style="vertical-align:top;width:25%;padding-right:35px;"><table><tr><td colspan="3"><h3>Get Started</h3></td></tr><tr style="vertical-align:top;" rel="1"><td><img class="hidesec" style="padding-right:3px;" src="../Images/admin_visible.png"></td><td><img class="recsec" style="padding-right:3px;" src="../Images/admin_unchecked.png"></td><td class="ptext">Store sync, and share your content</td></tr></tr><tr style="vertical-align:top;" rel="2"><td><img class="hidesec" style="padding-right:3px;" src="../Images/admin_visible.png"></td><td><img class="recsec" style="padding-right:3px;" src="../Images/admin_unchecked.png"></td><td class="ptext">Keep everyone on the same page</td></tr><tr style="vertical-align:top;" rel="3"><td><img class="hidesec" style="padding-right:3px;" src="../Images/admin_visible.png"></td><td><img class="recsec" style="padding:3px;" src="../Images/admin_unchecked.png"></td><td class="ptext">Stay on track and deliver on time</td></tr><tr style="vertical-align:top;" rel="4"><td><img class="hidesec" style="padding:3px;" src="../Images/admin_visible.png"></td><td><img class="recsec" style="padding:3px;" src="../Images/admin_unchecked.png"></td><td class="ptext">Find the right people</td></tr><tr style="vertical-align:top;" rel="5"><td><img class="hidesec" style="padding:3px;" src="../Images/admin_visible.png"></td><td><img class="recsec" style="padding:3px;" src="../Images/admin_unchecked.png"></td><td class="ptext">find what you need</td></tr><tr style="vertical-align:top;" rel="6"><td><img class="hidesec" style="padding:3px;" src="../Images/admin_visible.png"></td><td><img class="recsec" style="padding:3px;" src="../Images/admin_unchecked.png"></td><td class="ptext">Make informed decisions</td></tr></table></td><td style="vertical-align:top;width:25%;padding-right:35px;"><table><tr><td colspan="3"><h3>HR & Internal<br>Communications</h3></td></tr><tr style="vertical-align:top;" rel="7"><td><img class="hidesec" style="padding:3px;" src="../Images/admin_visible.png"></td><td><img class="recsec" style="padding:3px;" src="../Images/admin_unchecked.png"></td><td class="ptext">Onboard new employees</td></tr><tr style="vertical-align:top;" rel="8"><td><img class="hidesec" style="padding:3px;" src="../Images/admin_visible.png"></td><td><img class="recsec" style="padding:3px;" src="../Images/admin_unchecked.png"></td><td class="ptext">Keep everyone informed</td></tr><tr><td colspan="3" style="height:20px;"></td></tr><tr><td colspan="3"><h3>R&D, Production, & <br>Operations</h3></td></tr><tr style="vertical-align:top;" rel="9"><td><img class="hidesec" style="padding:3px;" src="../Images/admin_visible.png"></td><td><img class="recsec" style="padding:3px;" src="../Images/admin_unchecked.png"></td><td class="ptext">Share your knowledge</td></tr><tr style="vertical-align:top;" rel="10"><td><img class="hidesec" style="padding:3px;" src="../Images/admin_visible.png"></td><td><img class="recsec" style="padding:3px;" src="../Images/admin_unchecked.png"></td><td class="ptext">Boost business processes</td></tr></table></td><td style="vertical-align:top;width:25%;padding-right:35px;"><table><tr><td colspan="3"><h3>Sales & Marketing</h3></td></tr><tr style="vertical-align:top;" rel="11"><td><img class="hidesec" style="padding:3px;" src="../Images/admin_visible.png"></td><td><img class="recsec" style="padding:3px;" src="../Images/admin_unchecked.png"></td><td class="ptext">Make your customers and partners happy</td></tr><tr style="vertical-align:top;" rel="12"><td><img class="hidesec" style="padding:3px;" src="../Images/admin_visible.png"></td><td><img class="recsec" style="padding:3px;" src="../Images/admin_unchecked.png"></td><td class="ptext">Engage your audience online</td></tr><tr style="vertical-align:top;" rel="13"><td><img class="hidesec" style="padding:3px;" src="../Images/admin_visible.png"></td><td><img class="recsec" style="padding:3px;" src="../Images/admin_unchecked.png"></td><td class="ptext">Align your teams</td></tr><tr><td colspan="3" style="height:20px;"></td></tr><tr><td colspan="3"><h3>Finance & Accounting</h3></td></tr><tr style="vertical-align:top;" rel="14"><td><img class="hidesec" style="padding:3px;" src="../Images/admin_visible.png"></td><td><img class="recsec" style="padding:3px;" src="../Images/admin_unchecked.png"></td><td class="ptext">Crunch the numbers together</td></tr></table></td><td style="vertical-align:top;width:25%;padding-right:35px;"><table><tr><td colspan="3"><h3>Legal</h3></td></tr><tr style="vertical-align:top;" rel="15"><td><img class="hidesec" style="padding:3px;" src="../Images/admin_visible.png"></td><td><img class="recsec" style="padding:3px;" src="../Images/admin_unchecked.png"></td><td class="ptext">Help meet compliance needs</td></tr><tr><td colspan="3" style="height:20px;"></td></tr><tr><td colspan="3"><h3>Information Technology</h3></td></tr><tr style="vertical-align:top;" rel="16"><td><img class="hidesec" style="padding:3px;" src="../Images/admin_visible.png"></td><td><img class="recsec" style="padding:3px;" src="../Images/admin_unchecked.png"></td><td class="ptext">Provide the right support</td></tr><tr style="vertical-align:top;" rel="17"><td><img class="hidesec" style="padding:3px;" src="../Images/admin_visible.png"></td><td><img class="recsec" style="padding:3px;" src="../Images/admin_unchecked.png"></td><td class="ptext">Empower people and stay in control</td></tr></table></td></tr></table>
		</div></div></div>
		
		

<div class="whitebg" style="height:450px;position:relative;">
<div class="colwrap"><div style="border-top:solid 1px #222;" class="inner">
<table style="width:1240px;"><tr><td style="width:200px;">
<h3>Site Analytics</h3>
<select class="" id="analytics_type">
  <option value="0">App Installs</option>
  <option value="1">App Launches</option>
  <option value="2">Page Views</option>
  <option value="3">Video Views</option>
   <option value="4">Video Downloads</option>
   <option value="5">Guide Downloads</option>
</select>&nbsp;&nbsp;&nbsp;&nbsp;
<select rel="exampleSimple" class="analytics_months" id="analytics_months">
  <option value="0">All Months</option>
  <option value="1">January</option>
  <option value="2">February</option>
  <option value="3">March</option>
   <option value="4">April</option>
   <option value="5">May</option>
   <option value="6">June</option>
   <option value="7">July</option>
   <option value="8">August</option>
   <option value="9">September</option>
   <option value="10">October</option>
   <option value="11">November</option>
   <option value="12">December</option>
</select>&nbsp;&nbsp;&nbsp;&nbsp;
<select rel="exampleSimple" class="" id="analytics_unit">
  <option value="0">App Installs</option>
</select></td></tr><tr><td style="height:280px"><div id="exampleSimple"></div></td></tr></table></div></div></div>
				 </div>				 

         <script type="text/javascript" language="javascript"  src="../Scripts/main.js"></script>
		
	          <!-- START OF SmartSource Data Collector TAG -->
<!-- Copyright (c) 1996-2009 WebTrends Inc.  All rights reserved. -->
<!-- Version: MS.3.0.0 -->
<script src="../Scripts/wt.js" type="text/javascript"></script>

<!-- ----------------------------------------------------------------------------------- -->
<!-- Warning: The two script blocks below must remain inline. Moving them to an external -->
<!-- JavaScript include file can cause serious problems with cross-domain tracking.      -->
<!-- ----------------------------------------------------------------------------------- -->
<script type="text/javascript">
    //<![CDATA[
    var _tag=new WebTrends();
    _tag.dcsid="dcsc97avu10000kn75ujgpso2_7j5n";
    // _tag.fpcdom=".domain.com";
    _tag.dcsGetId();
    _tag.trackevents=true;
    //]]>>
</script>

<script type="text/javascript">
    //<![CDATA[
    // Add custom parameters here.
    //_tag.DCSext.param_name=param_value;
    _tag.dcsCollect();
    //]]>>
</script>

<noscript>
<div><img alt="DCSIMG" id="DCSIMG" width="1" height="1" src="http://m.webtrends.com/dcsc97avu10000kn75ujgpso2_7j5n/njs.gif?dcsuri=/nojavascript&amp;WT.js=No&amp;WT.tv=MS.3.0.0"/></div>
</noscript>
<!-- END OF SmartSource Data Collector TAG -->
	 </div></div></div><a class="maillink" target="_blank" href="#"><span></span></a><a class="fblink" target="_blank" href="#"><span></span></a></body>
 </html>
