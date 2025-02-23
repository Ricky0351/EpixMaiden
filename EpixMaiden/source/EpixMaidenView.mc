using Toybox.WatchUi as Ui;
using Toybox.Graphics as Gfx;
using Toybox.System as Sys;
using Toybox.Lang as Lang;
using Toybox.Time.Gregorian as Greg;
using Toybox.ActivityMonitor as Act;
using Toybox.Activity as Acty;
using Toybox.Weather as Meteo;
using Toybox.UserProfile as Moi;

class EpixMaidenView extends Ui.WatchFace {

	var customFont=null;
	var fsyms,falpha,falpha2,falpha3,falpha4,fweather,ficon,WeatherFont;
	var TitleIron45,TitleIron46,HourIron,SecIron,TextIron;
	var h,font2, w;
	var HauteurHeure;
	var HauteurDate;
	var HauteurTitre;
	var HauteurIcon;

    function onLayout(dc) {
       /*customFont=Ui.loadResource(Rez.Fonts.customFont);
       falpha = Ui.loadResource(Rez.Fonts.MetalAlpha);
       falpha2 = Ui.loadResource(Rez.Fonts.MetalAlpha2);
       falpha3 = Ui.loadResource(Rez.Fonts.MetalAlpha3);
       falpha4 = Ui.loadResource(Rez.Fonts.MetalAlphapourcent);*/

	   WeatherFont=Ui.loadResource(Rez.Fonts.WeatherFont);
	   ficon=Ui.loadResource(Rez.Fonts.IconsFont);
	   fsyms = Ui.loadResource(Rez.Fonts.typicons22);

	   TitleIron46= Ui.loadResource(Rez.Fonts.TitleIron46);
	   TitleIron45= Ui.loadResource(Rez.Fonts.TitleIron45);
	   HourIron= Ui.loadResource(Rez.Fonts.HourIron120);
	   SecIron= Ui.loadResource(Rez.Fonts.SecIron50);
       TextIron= Ui.loadResource(Rez.Fonts.TextIron30);

    }

    function onUpdate(dc) {
    	dc.setColor(Gfx.COLOR_BLACK, Gfx.COLOR_BLACK);
  		dc.clear();
        var clockTime = Sys.getClockTime();
   		var stats = Sys.getSystemStats();
        var hour = clockTime.hour;
		var seconds = clockTime.sec;
 		var dateinfo = Greg.info(Time.now(), Time.FORMAT_SHORT);
 		var actinfo = Act.getInfo();
        var battery = stats.battery;
        var steps = actinfo.steps;
        var StepGoal = actinfo.stepGoal;
        var settings = Sys.getDeviceSettings();
		var PlusGrand=0;

		var HauteurTitre=170;
		HauteurHeure=dc.getFontHeight(HourIron);
	    HauteurDate=dc.getFontHeight(TextIron);
		HauteurIcon=dc.getFontHeight(ficon);
		var OffsetHauteurSeconde=-25;

		// quadrillage
			var largeurText=dc.getTextWidthInPixels("IRON MAIDEN", TitleIron46);
			var XMilieuEcran=dc.getWidth()/2;
		/*	var YMilieuEcran=dc.getHeight()/2;
			dc.setColor(Gfx.COLOR_BLUE, Gfx.COLOR_WHITE);
			dc.drawRectangle(0, 0, dc.getWidth()/2, dc.getHeight());
			dc.drawRectangle(0, dc.getHeight()/2, dc.getWidth(), dc.getHeight()/2);
			dc.drawRectangle(XMilieuEcran+largeurText/2, 0, dc.getWidth(), dc.getHeight());
			dc.drawRectangle(XMilieuEcran-largeurText/2, 0, dc.getWidth(), dc.getHeight());
*/
			
			var X2=XMilieuEcran-largeurText/2+15;
			var X1=X2-35;
			var X3=XMilieuEcran+largeurText/2-15;
			var X4=X3+35;
			var Y1=dc.getHeight()/2-80;
			var Y2=dc.getHeight()/2-20;
			var Y3=dc.getHeight()/2+20;
			var Y4=dc.getHeight()/2+80;

		//heure    
			var TextHeure= hour.toString() + Lang.format("$1$",[clockTime.min.format("%02d")]);

			if (hour <10){
	        	TextHeure="0"+ TextHeure;
	        }

			var DizHeure=TextHeure.substring(0,1);
			var UnitHeure=TextHeure.substring(1,2);
			var DizMin=TextHeure.substring(2,3);
			var UnitMin=TextHeure.substring(3,4);
			//besoin de reverifier la largeur a chaque fois a cause de police metallord (sinon mettre dans onlayout)
			var largeurDizHeure=dc.getTextWidthInPixels(DizHeure, HourIron);
			var largeurUnitHeure=dc.getTextWidthInPixels(UnitHeure, HourIron);
			var largeurDizMin=dc.getTextWidthInPixels(DizMin, HourIron);
			var largeurUnitMin=dc.getTextWidthInPixels(UnitMin, HourIron);

			PlusGrand=TrouvePlusGrand(largeurDizHeure,largeurUnitHeure,largeurDizMin,largeurUnitMin);
			var RapportPositionHeure=2;
			var OffsetPositionHeure=10;
			dc.setColor(Gfx.COLOR_BLUE, Gfx.COLOR_BLACK);
			dc.drawText(dc.getWidth()/2-0.5*PlusGrand,dc.getHeight()/2-HauteurHeure/RapportPositionHeure-OffsetPositionHeure,HourIron, DizHeure,Gfx.TEXT_JUSTIFY_VCENTER | Graphics.TEXT_JUSTIFY_CENTER);
			dc.setColor(Gfx.COLOR_BLUE, Gfx.COLOR_BLACK);
			dc.drawText(dc.getWidth()/2+0.5*PlusGrand,dc.getHeight()/2-HauteurHeure/RapportPositionHeure-OffsetPositionHeure,HourIron, UnitHeure,Gfx.TEXT_JUSTIFY_VCENTER | Graphics.TEXT_JUSTIFY_CENTER);
			dc.setColor(Gfx.COLOR_BLUE, Gfx.COLOR_BLACK);
			dc.drawText(dc.getWidth()/2-0.5*PlusGrand,dc.getHeight()/2+HauteurHeure/RapportPositionHeure+OffsetPositionHeure,HourIron, DizMin,Gfx.TEXT_JUSTIFY_VCENTER | Graphics.TEXT_JUSTIFY_CENTER);
			dc.setColor(Gfx.COLOR_BLUE, Gfx.COLOR_BLACK);
			dc.drawText(dc.getWidth()/2+0.5*PlusGrand,dc.getHeight()/2+HauteurHeure/RapportPositionHeure+OffsetPositionHeure,HourIron, UnitMin,Gfx.TEXT_JUSTIFY_VCENTER | Graphics.TEXT_JUSTIFY_CENTER);

		//Secondes
			var TextSec= seconds.toString();
			System.println(TextSec);
			if (seconds <10){
	        	TextSec="0"+ TextSec;
	        }

			var DizSec=TextSec.substring(0,1);
			var UnitSec=TextSec.substring(1,2);
			System.println(DizSec);
			System.println(UnitSec);
			//besoin de reverifier la largeur a chaque fois a cause de police metallord (sinon mettre dans onlayout)
			var largeurDizSec=dc.getTextWidthInPixels(DizSec, SecIron);
			var largeurUnitSec=dc.getTextWidthInPixels(UnitSec, SecIron);
			//var largeurMax=dc.getTextWidthInPixels("9", customFont);
			PlusGrand=TrouvePlusGrand(largeurDizSec,largeurUnitSec,largeurDizSec,largeurDizSec);
			dc.setColor(Gfx.COLOR_RED, Gfx.COLOR_BLACK);
			dc.drawText(dc.getWidth()/2-0.5*PlusGrand,dc.getHeight()/2+HauteurTitre+OffsetHauteurSeconde,SecIron, DizSec,Gfx.TEXT_JUSTIFY_VCENTER | Graphics.TEXT_JUSTIFY_CENTER);
			dc.setColor(Gfx.COLOR_RED, Gfx.COLOR_BLACK);
			dc.drawText(dc.getWidth()/2+0.5*PlusGrand,dc.getHeight()/2+HauteurTitre+OffsetHauteurSeconde,SecIron, UnitSec,Gfx.TEXT_JUSTIFY_VCENTER | Graphics.TEXT_JUSTIFY_CENTER);

		//batterie vert si >=20% rouge si <33%
			//var largeurIcon=dc.getTextWidthInPixels("d", fsyms);
			if (battery >= 20) {
				dc.setColor(Gfx.COLOR_GREEN, Gfx.COLOR_BLACK);
			}
			if (battery < 20) {
			dc.setColor(Gfx.COLOR_RED, Gfx.COLOR_BLACK);
			}
			var HauteurSYMB=dc.getFontHeight(fsyms);
			dc.drawText(dc.getWidth()/2-20, dc.getHeight()/2+HauteurTitre+OffsetHauteurSeconde+30, fsyms, "d",  Gfx.TEXT_JUSTIFY_CENTER);
			dc.fillRectangle(dc.getWidth()/2-30+4, dc.getHeight()/2+HauteurTitre+OffsetHauteurSeconde+30+HauteurSYMB-6, 11*battery/100, -7);
			dc.drawText(dc.getWidth()/2+20, dc.getHeight()/2+HauteurTitre+OffsetHauteurSeconde+30, TextIron, battery.toNumber(),  Gfx.TEXT_JUSTIFY_CENTER);

         // write the date
              var months = ["JAN","FEV","MAR","AVR","MAI","JUN","JUI","AOU","SEP","OCT","NOV","DEC"];
              var weekdays = ["DIM","LUN","MAR","MER","JEU","VEN","SAM"];
			  var NumSemaine=iso_week_number(dateinfo.year,dateinfo.month,dateinfo.day);
			  var DateComplete=weekdays[dateinfo.day_of_week-1] +" "+ dateinfo.day +" " + months[dateinfo.month-1] + "  CW " + NumSemaine;

              dc.setColor(Gfx.COLOR_WHITE, Gfx.COLOR_TRANSPARENT);
              dc.drawText(dc.getWidth()/2, dc.getHeight()/2-HauteurDate/2, TextIron, DateComplete,  Gfx.TEXT_JUSTIFY_CENTER);  
        
         //Text 
         	dc.setColor(Gfx.COLOR_RED, Gfx.COLOR_TRANSPARENT);
    		dc.drawText(dc.getWidth()/2, dc.getHeight()/2-HauteurTitre, TitleIron46, "IRON MAIDEN",  Gfx.TEXT_JUSTIFY_CENTER);
    		dc.setColor(Gfx.COLOR_YELLOW, Gfx.COLOR_TRANSPARENT);
    		dc.drawText(dc.getWidth()/2, dc.getHeight()/2-HauteurTitre, TitleIron45, "IRON MAIDEN",  Gfx.TEXT_JUSTIFY_CENTER);
  		
    	
  
  /* 

		//phone connecté
		var flags = "";
		if (settings.phoneConnected) {flags = "p";}
		dc.setColor(Gfx.COLOR_BLUE, Gfx.COLOR_TRANSPARENT);
        dc.drawText(dc.getWidth()/2, dc.getHeight()/2+HauteurHeure+5, fsyms, flags,  Gfx.TEXT_JUSTIFY_CENTER);

		
*/
		
		//meteo
		afficheMeteo(dc,X2,Y1-HauteurIcon,X1);

		//sunset
		dc.setColor(Gfx.COLOR_PINK, Gfx.COLOR_TRANSPARENT);
		afficheSunset(dc,X1,Y2-HauteurIcon,X2);

		//coeur
		var BattementCoeur=Acty.getActivityInfo().currentHeartRate;
		var BattementString="";

		if(BattementCoeur!=null) {
			BattementString = BattementCoeur.toString();
		}else{
			BattementString = "0";
		}
		dc.setColor(Gfx.COLOR_DK_GRAY, Gfx.COLOR_TRANSPARENT);
		dc.drawText(X2, Y4, ficon, "3",  Gfx.TEXT_JUSTIFY_RIGHT);
		dc.setColor(Gfx.COLOR_PINK, Gfx.COLOR_TRANSPARENT);
		dc.drawText(X1, Y4-2, TextIron, BattementString,  Gfx.TEXT_JUSTIFY_RIGHT);

		// steps today
    		var PourcentGoal = steps*100/StepGoal;
			var dist2 = actinfo.distance/100000.0;

    		
		dc.setColor(Gfx.COLOR_DK_GRAY, Gfx.COLOR_TRANSPARENT);
		dc.drawText(X2+3, Y3, TextIron, "KM",  Gfx.TEXT_JUSTIFY_RIGHT);
		if (PourcentGoal<100 ){
				dc.setColor(Gfx.COLOR_RED, Gfx.COLOR_TRANSPARENT);}
			else {
				dc.setColor(Gfx.COLOR_GREEN, Gfx.COLOR_TRANSPARENT);}
		if(dist2!=null) {
		dc.drawText(X1, Y3, TextIron, dist2.format("%.1f"),  Gfx.TEXT_JUSTIFY_RIGHT);}
  
		//poids
		var poids=Moi.getProfile().weight;
		poids=poids/1000;
		var poidsstring=poids.toString();
		dc.setColor(Gfx.COLOR_DK_GRAY, Gfx.COLOR_TRANSPARENT);
		dc.drawText(X3, Y1-HauteurIcon, ficon, "@",  Gfx.TEXT_JUSTIFY_LEFT);
		dc.setColor(Gfx.COLOR_PINK, Gfx.COLOR_TRANSPARENT);
		if(poidsstring!=null) {
		dc.drawText(X4, Y1-HauteurIcon,TextIron, poidsstring , Graphics.TEXT_JUSTIFY_LEFT);}

		//body batterie
		dc.setColor(Gfx.COLOR_DK_GRAY, Gfx.COLOR_TRANSPARENT);
		dc.drawText(X3, Y2-HauteurIcon, ficon, "6",  Gfx.TEXT_JUSTIFY_LEFT);
		dc.setColor(Gfx.COLOR_PINK, Gfx.COLOR_TRANSPARENT);
		var bbIterator = Toybox.SensorHistory.getBodyBatteryHistory({:period=>1});
		var sample = bbIterator.next();
		if(sample!=null) {
		dc.drawText(X4, Y2-HauteurIcon,	TextIron, sample.data.format("%d"), Gfx.TEXT_JUSTIFY_LEFT); }

		//altitude
		var Alti=Acty.getActivityInfo().altitude;
		var AltiRound=Alti.toNumber();
		if (AltiRound<0){AltiRound=-AltiRound;}
		var AltiString="";
		//Sys.println(Alti);

		if(AltiString!=null) {
			AltiString = AltiRound.toString();
		}else{
			AltiString = "0";
		}
		dc.setColor(Gfx.COLOR_DK_GRAY, Gfx.COLOR_TRANSPARENT);
		dc.drawText(X3, Y3, ficon, ";",  Gfx.TEXT_JUSTIFY_LEFT);
		dc.setColor(Gfx.COLOR_PINK, Gfx.COLOR_TRANSPARENT);
		if (Alti>0){
		dc.drawText(X4, Y3-2, TextIron, AltiString,  Gfx.TEXT_JUSTIFY_LEFT);
		}else{
		dc.drawText(X4, Y3-2, TextIron, "-" + AltiString,  Gfx.TEXT_JUSTIFY_LEFT);	
		}

		//notifications
		var nombreNotif=settings.notificationCount;
		dc.setColor(Gfx.COLOR_DK_GRAY, Gfx.COLOR_TRANSPARENT);
		dc.drawText(X3, Y4, ficon,"5",  Gfx.TEXT_JUSTIFY_LEFT);
		dc.setColor(Gfx.COLOR_PINK, Gfx.COLOR_TRANSPARENT);
		if(nombreNotif!=null) {
		dc.drawText(X4, Y4-2, TextIron,nombreNotif,  Gfx.TEXT_JUSTIFY_LEFT);}
	
    }

    function onShow(){
	}
	
    function onHide() {
    }

    function onExitSleep() {
    }

    function onEnterSleep() {
    }

	function afficheMeteo(dc,x,y,x3){
		//https://github.com/fevieira27/MoveToBeActive/blob/main/source/MtbA_functions.mc
			var sunset, sunrise;
			var clockTime = Sys.getClockTime().hour;
			var position=null, today=null, cond=null,temp=null;
			var x2=x;
			var condName="";
			
			position = Meteo.getCurrentConditions().observationLocationPosition; // or Activity.Info.currentLocation if observation is null?
			today = Meteo.getCurrentConditions().observationTime; // or new Time.Moment(Time.now().value());
			cond=Meteo.getCurrentConditions().condition;
			
			if (Meteo.getSunset(position, today)!=null) {
				sunset = Greg.info(Meteo.getSunset(position, today), Time.FORMAT_SHORT);
				sunset = sunset.hour;
			} else {
				sunset = 18; 
			}
			
			if (Meteo.getSunrise(position, today)!=null) {
				sunrise = Greg.info(Meteo.getSunrise(position, today), Time.FORMAT_SHORT);
				sunrise = sunrise.hour;
			} else {
				sunrise = 6;
			}
			
			dc.setColor(Gfx.COLOR_DK_GRAY, Gfx.COLOR_TRANSPARENT);

			if (cond == 20) { // Cloudy
				dc.drawText(x2-1, y-1, WeatherFont, "I", Gfx.TEXT_JUSTIFY_RIGHT); // Cloudy
				if (clockTime >= sunset or clockTime < sunrise) { 
					condName="Cloudy Night";
				} else {
					condName="Cloudy Day";
				}
			} else if (cond == 0 or cond == 5) { // Clear or Windy
				if (clockTime >= sunset or clockTime < sunrise) { 
							dc.drawText(x2-2, y-1, WeatherFont, "f", Gfx.TEXT_JUSTIFY_RIGHT); // Clear Night	
							condName="Starry Night";
						} else {
							dc.drawText(x2, y-2, WeatherFont, "H", Gfx.TEXT_JUSTIFY_RIGHT); // Clear Day
							condName="Sunny Day";
						}
			} else if (cond == 1 or cond == 23 or cond == 40 or cond == 52) { // Partly Cloudy or Mostly Clear or fair or thin clouds
				if (clockTime >= sunset or clockTime < sunrise) { 
							dc.drawText(x2-1, y-2, WeatherFont, "g", Gfx.TEXT_JUSTIFY_RIGHT); // Partly Cloudy Night
							condName="Partly Cloudy";
						} else {
							dc.drawText(x2, y-2, WeatherFont, "G", Gfx.TEXT_JUSTIFY_RIGHT); // Partly Cloudy Day
							//Storage.setValue(34, "Mostly Sunny");
							condName="Mostly Sunny";
						}
			} else if (cond == 2 or cond == 22) { // Mostly Cloudy or Partly Clear
				if (clockTime >= sunset or clockTime < sunrise) { 
							dc.drawText(x2, y, WeatherFont, "h", Gfx.TEXT_JUSTIFY_RIGHT); // Mostly Cloudy Night
							condName="Overcast Night";
						} else {
							dc.drawText(x, y, WeatherFont, "B", Gfx.TEXT_JUSTIFY_RIGHT); // Mostly Cloudy Day
							condName="Mostly Cloudy";
						}
			} else if (cond == 3 or cond == 14 or cond == 15 or cond == 11 or cond == 13 or cond == 24 or cond == 25 or cond == 26 or cond == 27 or cond == 45) { // Rain or Light Rain or heavy rain or showers or unkown or chance  
				if (clockTime >= sunset or clockTime < sunrise) { 
							dc.drawText(x2, y, WeatherFont, "c", Gfx.TEXT_JUSTIFY_RIGHT); // Rain Night
							condName="Rainy Night";
						} else {
							dc.drawText(x, y, WeatherFont, "D", Gfx.TEXT_JUSTIFY_RIGHT); // Rain Day
							condName="Rainy Day";
						}
			} else if (cond == 4 or cond == 10 or cond == 16 or cond == 17 or cond == 34 or cond == 43 or cond == 46 or cond == 48 or cond == 51) { // Snow or Hail or light or heavy snow or ice or chance or cloudy chance or flurries or ice snow
				if (clockTime >= sunset or clockTime < sunrise) { 
							dc.drawText(x2, y, WeatherFont, "e", Gfx.TEXT_JUSTIFY_RIGHT); // Snow Night
							condName="Snowy Night";
						} else {
							dc.drawText(x, y, WeatherFont, "F", Gfx.TEXT_JUSTIFY_RIGHT); // Snow Day
							condName="Snowy Day";
						}
			} else if (cond == 6 or cond == 12 or cond == 28 or cond == 32 or cond == 36 or cond == 41 or cond == 42) { // Thunder or scattered or chance or tornado or squall or hurricane or tropical storm
				if (clockTime >= sunset or clockTime < sunrise) { 
							dc.drawText(x2, y, WeatherFont, "b", Gfx.TEXT_JUSTIFY_RIGHT); // Thunder Night
						} else {
							dc.drawText(x, y, WeatherFont, "C", Gfx.TEXT_JUSTIFY_RIGHT); // Thunder Day
						}
						condName="Thunderstorms";
			} else if (cond == 7 or cond == 18 or cond == 19 or cond == 21 or cond == 44 or cond == 47 or cond == 49 or cond == 50) { // Wintry Mix (Snow and Rain) or chance or cloudy chance or freezing rain or sleet
				if (clockTime >= sunset or clockTime < sunrise) { 
							dc.drawText(x2, y, WeatherFont, "d", Gfx.TEXT_JUSTIFY_RIGHT); // Snow+Rain Night
							condName="Wintry Mix Night";
						} else {
							dc.drawText(x, y, WeatherFont, "E", Gfx.TEXT_JUSTIFY_RIGHT); // Snow+Rain Day
							condName="Wintry Mix Day";
						}
			} else if (cond == 8 or cond == 9 or cond == 29 or cond == 30 or cond == 31 or cond == 33 or cond == 35 or cond == 37 or cond == 38 or cond == 39) { // Fog or Hazy or Mist or Dust or Drizzle or Smoke or Sand or sandstorm or ash or haze
				if (clockTime >= sunset or clockTime < sunrise) { 
							dc.drawText(x2, y, WeatherFont, "a", Gfx.TEXT_JUSTIFY_RIGHT); // Fog Night
							condName="Foggy Night";
				} else {
					dc.drawText(x, y, WeatherFont, "A", Gfx.TEXT_JUSTIFY_RIGHT); // Fog Day
					condName="Foggy Day";
				}       		
			}

			temp = Meteo.getCurrentConditions().temperature;
			temp=temp.format("%d");
			temp=temp + "°";
			dc.setColor(Gfx.COLOR_PINK, Gfx.COLOR_TRANSPARENT);
			dc.drawText(x3, y, TextIron, temp , Graphics.TEXT_JUSTIFY_RIGHT);
	}

	function afficheSunset(dc,x,y,x3){
			var myTime = System.getClockTime(); 
			var sunset, sunrise;
			var position=null, today=null;
			position = Meteo.getCurrentConditions().observationLocationPosition; 
			today = Meteo.getCurrentConditions().observationTime;
			sunset = Weather.getSunset(position, today);
			sunrise = Weather.getSunrise(position, today);
			var icon, time, text="";
			sunset = Time.Gregorian.info(sunset, Time.FORMAT_SHORT);
			sunrise = Time.Gregorian.info(sunrise, Time.FORMAT_SHORT);
			if (myTime.hour > sunrise.hour and myTime.hour < sunset.hour){ 
				icon = "?";
				time = sunset;
			} else if (myTime.hour == sunrise.hour and myTime.min > sunrise.min){ 
				icon = "?";
				time = sunset;
			} else if (myTime.hour == sunset.hour and myTime.min <= sunset.min){ 
				icon = "?";
				time = sunset;
			}	else {
				icon = ">";
				time = sunrise;
			}
			dc.setColor(Gfx.COLOR_DK_GRAY, Gfx.COLOR_TRANSPARENT);
			dc.drawText(x3, y, ficon, icon, Gfx.TEXT_JUSTIFY_RIGHT);
			text=Lang.format("$1$:$2$",[time.hour.format("%02u"), time.min.format("%02u")]);
			dc.setColor(Gfx.COLOR_PINK, Gfx.COLOR_TRANSPARENT);
			dc.drawText(x, y-4, TextIron, text , Graphics.TEXT_JUSTIFY_RIGHT);
	}

	function julian_day(year, month, day)
	{
		var a = (14 - month) / 12;
		var y = (year + 4800 - a);
		var m = (month + 12 * a - 3);
		return day + ((153 * m + 2) / 5) + (365 * y) + (y / 4) - (y / 100) + (y / 400) - 32045;
		}

		function is_leap_year(year)
		{
		if (year % 4 != 0) {
		return false;
		}
		else if (year % 100 != 0) {
		return true;
		}
		else if (year % 400 == 0) {
		return true;
		}

		return false;
	}

	function TrouvePlusGrand(Val1,Val2,Val3,Val4)
	{	
		var PlusGrand=0;
		if (Val1>Val2){PlusGrand=Val1;} else {PlusGrand=Val2;}
		if (Val3>PlusGrand){PlusGrand=Val3;}
		if (Val4>PlusGrand){PlusGrand=Val4;}
		return PlusGrand;
	}

	function initialize() {
		Ui.WatchFace.initialize();
	}

	private function getWeatherPosition()
	{
		var conditions = Weather.getCurrentConditions();
		if (conditions == null || conditions.observationLocationPosition == null) {
			return null;
		}
		var location = conditions.observationLocationPosition.toDegrees();
		if ((Math.round(location[0]) == 0 && Math.round(location[1]) == 0) ||
			Math.round(location[0]) == 180 && Math.round(location[1]) == 180) {
			return null;
		}
		return location;
	}

	function iso_week_number(year, month, day)
	{
		var first_day_of_year = julian_day(year, 1, 1);
		var given_day_of_year = julian_day(year, month, day);

		var day_of_week = (first_day_of_year + 3) % 7; // days past thursday
		var week_of_year = (given_day_of_year - first_day_of_year + day_of_week + 4) / 7;

		// week is at end of this year or the beginning of next year
		if (week_of_year == 53) {

		if (day_of_week == 6) {
		return week_of_year;
		}
		else if (day_of_week == 5 && is_leap_year(year)) {
		return week_of_year;
		}
		else {
		return 1;
		}
		}

		// week is in previous year, try again under that year
		else if (week_of_year == 0) {
		first_day_of_year = julian_day(year - 1, 1, 1);

		day_of_week = (first_day_of_year + 3) % 7;

		return (given_day_of_year - first_day_of_year + day_of_week + 4) / 7;
		}

		// any old week of the year
		else {
		return week_of_year;
		}
	}

}
