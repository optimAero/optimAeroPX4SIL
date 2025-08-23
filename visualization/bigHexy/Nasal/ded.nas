# Setup editable pages:
var bingoEF = EditableField.new("f16/settings/bingo", "%4dLBS", 4, func (v) {return v<=5700?0:-1;});
var tacanChanEF = EditableField.new("instrumentation/tacan/frequencies/selected-channel", "%-3d", 3);
var tacanBandTF = toggleableField.new(["X", "Y"], "instrumentation/tacan/frequencies/selected-channel[4]");
var ilsFrqEF = EditableField.new("instrumentation/nav[0]/frequencies/selected-mhz", "%6.2f", 6);
var ilsCrsEF = EditableField.new("f16/crs-ils", "%3d", 3);
var wingspanEF = EditableField.new("f16/avionics/gun-eegs-wingspan-ft", "%3d", 3);
var gunrngEF = EditableField.new("f16/avionics/gun-aa-max-range-ft", "%5d", 5);
var alowEF = EditableField.new("f16/settings/cara-alow", "%5d", 5);
var tfEF = EditableField.new("autopilot/settings/tf-minimums", "%4d", 4);
var mslFloorEF = EditableField.new("f16/settings/msl-floor", "%5d", 5);
var laserCodeTgpEF = EditableField.new("f16/avionics/laser-code", "%04d", 4, checkValueLaserCode);
var iffEF = EditableField.new("instrumentation/iff/channel-selection", "%4d", 4);
var iffTF = toggleableIff.new([0, 1], "instrumentation/iff/activate");
var transpEF = EditableField.new("instrumentation/transponder/id-code", "%04d", 4, checkValueTransponderCode);
var transpModeTF = toggleableTransponder.new([0, 1, 2, 3, 4, 5], "instrumentation/transponder/inputs/knob-mode");
var STPTlatFE = EditableLAT.new("f16/ded/lat", convertDegreeToStringLat);
var STPTlonFE = EditableLON.new("f16/ded/lon", convertDegreeToStringLon);
var STPTnumFE = EditableField.new("f16/ded/stpt-edit", "%3d", 3);
var STPTradFE = EditableField.new("f16/ded/stpt-rad", "%2d", 2);
var STPTaltFE = EditableField.new("f16/ded/alt", "%5d", 5);
var CRUSmodeTF = toggleableMode.new(["TOS", "RNG", "EDR"], "f16/ded/crus-mode", "f16/ded/cur-crus-mode");
var CRUSdesTosEF = EditableTime.new("f16/ded/crus-des-tos", steerpoints.getAbsoluteTOS);
#var CRUSstptEF = EditableField.new("f16/ded/crus-stpt", "%3d", 3);
var STPTtypeTF = toggleableField.new(["   ", " 2 ", " 5 ", " 6 ", " 11", " 20", " SH", " P ", " AAA"], "f16/ded/stpt-type");
var STPTauto = toggleableField.new(["AUTO", "MAN "], "f16/ded/stpt-auto");
#var STPTcolorTF = toggleableField.new(["RED", "YEL", "GRN"], "f16/ded/stpt-color");
var dlinkEF   = EditableField.new("instrumentation/datalink/channel", "%4d", 4);
var com1FrqEF = EditableField.new("instrumentation/comm[0]/frequencies/selected-mhz", "%6.2f", 6);
var com2FrqEF = EditableField.new("instrumentation/comm[1]/frequencies/selected-mhz", "%6.2f", 6);
var com1SFrqEF = EditableField.new("instrumentation/comm[0]/frequencies/standby-mhz", "%6.2f", 6);
var com2SFrqEF = EditableField.new("instrumentation/comm[1]/frequencies/standby-mhz", "%6.2f", 6);

var pTACAN = EditableFieldPage.new(0, [tacanChanEF,tacanBandTF,ilsFrqEF,ilsCrsEF]);
var pALOW  = EditableFieldPage.new(1, [alowEF,mslFloorEF,tfEF]);
var pFACK  = EditableFieldPage.new(2);
var pSTPT  = EditableFieldPage.new(3, [STPTnumFE,STPTlatFE,STPTlonFE,STPTradFE,STPTaltFE,STPTtypeTF,STPTauto]);#,STPTcolorTF
var pCRUS  = EditableFieldPage.new(4, [CRUSmodeTF, CRUSdesTosEF]);
var pTIME  = EditableFieldPage.new(5);
var pMARK  = EditableFieldPage.new(6);
var pFIX   = EditableFieldPage.new(7);
var pACAL  = EditableFieldPage.new(8);

var pLIST  = EditableFieldPage.new(100);
var pDEST  = EditableFieldPage.new(9);
var pBINGO = EditableFieldPage.new(10, [bingoEF]);
var pVIP   = EditableFieldPage.new(11);
var pNAV   = EditableFieldPage.new(12);
var pMAN   = EditableFieldPage.new(13, [wingspanEF,gunrngEF]);
var pINS   = EditableFieldPage.new(14);
var pEWS   = EditableFieldPage.new(15);
var pMODE  = EditableFieldPage.new(16);
var pVRP   = EditableFieldPage.new(17);
var pINTG  = EditableFieldPage.new(18);
var pDLNK  = EditableFieldPage.new(19, [dlinkEF]);

var pMISC  = EditableFieldPage.new(201);
var pCORR  = EditableFieldPage.new(20);
var pMAGV  = EditableFieldPage.new(21);
var pOFP   = EditableFieldPage.new(22);
var pINSM  = EditableFieldPage.new(23);
var pLASR  = EditableFieldPage.new(24, [laserCodeTgpEF]);
var pGPS   = EditableFieldPage.new(25);
var pDRNG  = EditableFieldPage.new(26);
var pBULL  = EditableFieldPage.new(27);
var pWPT   = EditableFieldPage.new(28);
var pHARM  = EditableFieldPage.new(29);

var pCNI   = EditableFieldPage.new(30);
var pCOMM1 = EditableFieldPage.new(31, [com1FrqEF, com1SFrqEF]);
var pCOMM2 = EditableFieldPage.new(32, [com2FrqEF, com2SFrqEF]);
var pIFF1   = EditableFieldPage.new(33, [transpEF,transpModeTF,iffEF,iffTF]);
var pIFF2   = EditableFieldPage.new(34);
var pIFF3   = EditableFieldPage.new(35);
var pHMCS  = EditableFieldPage.new(36);

var wp_num_lastA = nil;
var wp_num_lastO = nil;
var wp_num_lastR = nil;
#var wp_num_lastC = nil;
var wp_num_lastT = nil;
var wp_num_curr = 0;
var des_tos_last = nil;


var modeSDeci = 65535*rand();
var modeS_PERM  = "AE"~sprintf("%4X", modeSDeci);
var modeS_OPER  = sprintf("%8o", modeSDeci+11403264);

#setlistener("f16/ded/crus-des-tos", func() {
    # Gonna assume it's cheaper to just write instead of check if we need to
#    var cur_wp = steerpoints.getCurrent();
#    if (cur_wp != nil) {
#        cur_wp.desiredTOS = getprop("f16/ded/crus-des-tos");
#    }
    #var newVal = getprop("f16/ded/crus-des-tos");
    #if (cur_wp.desiredTOS != newVal) {
    #    cur_wp.desiredTOS = newVal;
    #}
#});

var dataEntryDisplay = {
	line1: nil,
	line2: nil,
	line3: nil,
	line4: nil,
	line5: nil,
	canvasNode: nil,
	canvasGroup: nil,
	chrono: aircraft.timer.new("f16/avionics/hack/elapsed-time-sec", 1, 0),
	comm: 0,
	text: ["","","","",""],
	scroll: 0,
	scrollF: 0,
	page: pCNI,
	pageLast: pCNI,
	init: func() {
		me.canvasNode = canvas.new({
			"name": "DED",
			"size": [512, 256],
			"view": [256, 128],
			"mipmapping": 1
		});

		me.canvasNode.addPlacement({"node": "poly.003", "texture": "canvas.png"});
		if (getprop("sim/variant-id") == 2) {
			me.canvasNode.setColorBackground(0.00, 0.04, 0.01, 1.00);
		} else if (getprop("sim/variant-id") == 4) {
			me.canvasNode.setColorBackground(0.00, 0.04, 0.01, 1.00);
		} else if (getprop("sim/variant-id") == 5) {
			me.canvasNode.setColorBackground(0.00, 0.04, 0.01, 1.00);
		} else if (getprop("sim/variant-id") >= 6) {
			me.canvasNode.setColorBackground(0.00, 0.04, 0.01, 1.00);
		} else {
			me.canvasNode.setColorBackground(0.01, 0.075, 0.00, 1.00);
		}

		me.canvasGroup = me.canvasNode.createGroup();
		me.canvasGroup.show();

		me.line1 = me.createText(0.2);
		me.line2 = me.createText(0.3);
		me.line3 = me.createText(0.4);
		me.line4 = me.createText(0.5);
		me.line5 = me.createText(0.6);
		#me.update();
	},

	createText: func(translationOffset) {
		var obj = me.canvasGroup.createChild("text")
			.setFontSize(13, 1)
			.setColor(0.45,0.98,0.06)
			.setAlignment("left-bottom-baseline")
			.setFont("F-16-DED.ttf")
			.setText("LINE                LINE")
			.setTranslation(50, 128*translationOffset);
		return obj;
	},

	no: "",
	update: func() {
		me.no = steerpoints.getCurrentNumber();
		if (me.no == 0) {
		  me.no = "";
		} else {
		  me.no = sprintf("%3d "~utf8.chstr(0x2195),me.no);
		}

		if (me.page == pTACAN) {
			me.updateTacan();
		} elsif (me.page == pALOW) {
			me.updateAlow();
		} elsif (me.page == pFACK) {
			me.updateFack();
		} elsif (me.page == pSTPT) {
			me.updateStpt();
		} elsif (me.page == pCRUS) {
			me.updateCrus();
		} elsif (me.page == pTIME) {
			me.updateTime();
		} elsif (me.page == pMARK) {
			me.updateMark();
		}  elsif (me.page == pFIX) {
			me.updateFix();
		} elsif (me.page == pACAL) {
			me.updateAcal();
		} elsif (me.page == pLIST) {
			me.updateList();
		} elsif (me.page == pDEST) {
			me.updateDest();
		} elsif (me.page == pBINGO) {
			me.updateBingo();
		} elsif (me.page == pVIP) {
			me.updateVIP();
		} elsif (me.page == pNAV) {
			me.updateNav();
		} elsif (me.page == pMAN) {
			me.updateMan();
		} elsif (me.page == pINS) {
			me.updateINS();
		} elsif (me.page == pEWS) {
			me.updateEWS();
		} elsif (me.page == pMODE) {
			me.updateMode();
		} elsif (me.page == pVRP) {
			me.updateVRP();
		} elsif (me.page == pINTG) {
			me.updateIntg();
		} elsif (me.page == pDLNK) {
			me.updateDlnk();
		} elsif (me.page == pMISC) {
			me.updateMisc();
		} elsif (me.page == pCORR) {
			me.updateCORR();
		} elsif (me.page == pMAGV) {
			me.updateMagv();
		} elsif (me.page == pOFP) {
			me.updateOFP();
		} elsif (me.page == pINSM) {
			me.updateINSM();
		} elsif (me.page == pLASR) {
			me.updateLaser();
		} elsif (me.page == pGPS) {
			me.updateGPS();
		} elsif (me.page == pDRNG) {
			me.updateDRNG();
		} elsif (me.page == pBULL) {
			me.updateBull();
		} elsif (me.page == pWPT) {
			me.updateWPT();
		} elsif (me.page == pHMCS) {
			me.updateHMCS();
		} elsif (me.page == pHARM) {
			me.updateHARM();
		} elsif (me.page == pCNI) {
			me.updateCNI();
		} elsif (me.page == pCOMM1) {
			me.updateComm1();
		} elsif (me.page == pCOMM2) {
			me.updateComm2();
		} elsif (me.page == pIFF1) {
			me.updateIFF1();
		} elsif (me.page == pIFF2) {
			me.updateIFF2();
		} elsif (me.page == pIFF3) {
			me.updateIFF3();
		}

		me.line1.setText(me.text[0]);
		me.line2.setText(me.text[1]);
		me.line3.setText(me.text[2]);
		me.line4.setText(me.text[3]);
		me.line5.setText(me.text[4]);

		if (me.page == pLIST) {
			me.updateListHUD();
		} elsif (me.page == pMISC) {
			me.updateMiscHUD();
		}

		me.pageLast = me.page;

		settimer(func() { me.update(); }, 0.25);
	},

	tacanMode: "REC    ",
	updateTacan: func() {
		var ilsOn  = (getprop("sim/model/f16/controls/navigation/instrument-mode-panel/mode/rotary-switch-knob") == 0 or getprop("sim/model/f16/controls/navigation/instrument-mode-panel/mode/rotary-switch-knob") == 3)?"ON ":"OFF";
		var ident = getprop("instrumentation/tacan/ident");
		var inrng = getprop("instrumentation/tacan/in-range");

		me.text[0] = sprintf("TCN %s  ILS %s",me.tacanMode,ilsOn);
		me.text[1] = sprintf("                        ");
		if (!inrng or ident == nil or ident == "") {
			me.text[2] = sprintf("               CMD STRG ", ident);
		} else {
			me.text[2] = sprintf("BCN %s        CMD STRG ", ident);
		}

		me.text[3] = sprintf("CHAN %s  FRQ  %s",pTACAN.vector[0].getText(),pTACAN.vector[2].getText());
		me.text[4] = sprintf("BAND %s(0)   CRS  %s\xc2\xb0",pTACAN.vector[1].getText(),pTACAN.vector[3].getText());
	},

	updateAlow: func() {
		me.text[0] = sprintf("         ALOW        %s ",me.no);
		me.text[1] = sprintf("                        ");
		me.text[2] = sprintf("  CARA ALOW  %sFT   ", pALOW.vector[0].getText());
		me.text[3] = sprintf("  MSL FLOOR  %sFT   ", pALOW.vector[1].getText());
		if (getprop("sim/variant-id") != 1) {
			me.text[4] = sprintf("TF ADV (MSL)  %sFT   ", pALOW.vector[2].getText());
		} else {
			me.text[4] = sprintf("                        ");
		}
	},

	updateFack: func() {
		var fails = fail.getList();
		var last = size(fails);
		me.scrollF += 0.25;
		if (me.scrollF >= last-2) me.scrollF = 0;
		var used = subvec(fails,int(me.scrollF),3);
		me.text[0] = sprintf("       F-ACK         %s ",me.no);
		me.text[1] = sprintf("                        ");
		if (size(used)>0) me.text[2] = sprintf(" %s ",used[0]);
		else me.text[2] = "";
		if (size(used)>1) me.text[3] = sprintf(" %s ",used[1]);
		else me.text[3] = "";
		if (size(used)>2) me.text[4] = sprintf(" %s ",used[2]);
		else me.text[4] = "";
	},

	updateStpt: func() {
		var TOS = "--:--:--";
		var alt = -1;
		var lat = "";
		var lon = "";
		var wp_num = getprop("f16/ded/stpt-edit");
		if (me.page != me.pageLast and steerpoints.getCurrentNumber() != 0) {
			# We just entered this page and have active route
			wp_num = steerpoints.getCurrentNumber();
			setprop("f16/ded/stpt-edit", wp_num);
		}
		if (wp_num != nil and (wp_num < 100 or (wp_num < 300 and wp_num >= 100) or (wp_num < 800 and wp_num >= 600))) {
			# Route and HSD lines
			var wp = steerpoints.getNumber(wp_num);
			if (wp != nil) {
				lat = convertDegreeToStringLat(wp.lat);
				lon = convertDegreeToStringLon(wp.lon);
				alt = wp.alt;
				if (alt == nil) {
					alt = -1;
				}
				if (wp_num < 100 and wp_num >= steerpoints.getCurrentNumber()) {
					TOS = steerpoints.getNumberTOS(wp_num);
				}
				wp_num_curr = wp_num;
				pSTPT.vector[1].skipMe = 0;#lat
				pSTPT.vector[2].skipMe = 0;#lon
				pSTPT.vector[3].skipMe = 1;#radius
				pSTPT.vector[4].skipMe = 0;#alt
				pSTPT.vector[5].skipMe = 1;#type
				#pSTPT.vector[6].skipMe = 1;#color
			} else {
				pSTPT.vector[1].skipMe = 1;
				pSTPT.vector[2].skipMe = 1;
				pSTPT.vector[3].skipMe = 1;
				pSTPT.vector[4].skipMe = 1;
				pSTPT.vector[5].skipMe = 1;
				#pSTPT.vector[6].skipMe = 1;
				wp_num_curr = 0;
			}
			me.text[4] = sprintf("      TOS  %s",TOS);
			me.text[3] = sprintf("     ELEV  % 5dFT",alt);
			me.text[1] = sprintf("      LAT  %s", lat);
			me.text[2] = sprintf("      LNG  %s", lon);
		} elsif (wp_num != nil and wp_num < 300+steerpoints.number_of_threat_circles and wp_num >= 300) {
			# Threat circles 300 to 314
			var stpt = steerpoints.getNumber(wp_num);
			if 	(stpt != nil) {
				wp_num_curr = wp_num;

				if (wp_num_lastA != stpt.lat) {
					setprop("f16/ded/lat", stpt.lat);
				} else {
					stpt.lat = getprop("f16/ded/lat");
				}
				if (wp_num_lastO != stpt.lon) {
					setprop("f16/ded/lon", stpt.lon);
				} else {
					stpt.lon = getprop("f16/ded/lon");
				}
				if (wp_num_lastR != stpt.radius) {
					setprop("f16/ded/stpt-rad", stpt.radius);
				} else {
					stpt.radius = getprop("f16/ded/stpt-rad");
				}
				#var colNum = wp_num_lastC=="RED"?0:(wp_num_lastC=="YEL"?1:2);
				#if (colNum != stpt.color) {
				#	setprop("f16/ded/stpt-color", stpt.color==0?"RED":(stpt.color==1?"YEL":"GRN"));
				#} else {
				#	stpt.color = getprop("f16/ded/stpt-color")=="RED"?0:(getprop("f16/ded/stpt-color")=="YEL"?1:2);
				#}
				if (wp_num_lastT != stpt.type) {
					setprop("f16/ded/stpt-type", stpt.type);
				} else {
					stpt.type = getprop("f16/ded/stpt-type");
				}
				pSTPT.vector[1].skipMe = 0;#lat
				pSTPT.vector[2].skipMe = 0;#lon
				pSTPT.vector[3].skipMe = 0;#radius
				pSTPT.vector[4].skipMe = 1;#alt
				pSTPT.vector[5].skipMe = 0;#type
				#pSTPT.vector[6].skipMe = 0;#color
			} elsif (stpt == nil and (getprop("f16/ded/lat") != 0 or getprop("f16/ded/lon") != 0 or getprop("f16/ded/stpt-rad") != 10 or getprop("f16/ded/stpt-type") != "   " or getprop("f16/ded/stpt-color") != 0)) {
				stpt = steerpoints.STPT.new();
				stpt.lat = getprop("f16/ded/lat");
				stpt.lon = getprop("f16/ded/lon");
				stpt.radius = getprop("f16/ded/stpt-rad");
				stpt.type = getprop("f16/ded/stpt-type");
				#stpt.color = getprop("f16/ded/stpt-color")=="RED"?0:(getprop("f16/ded/stpt-color")=="YEL"?1:2);
				steerpoints.setNumber(wp_num, stpt);
				wp_num_curr = wp_num;
				pSTPT.vector[1].skipMe = 0;#lat
				pSTPT.vector[2].skipMe = 0;#lon
				pSTPT.vector[3].skipMe = 0;#radius
				pSTPT.vector[4].skipMe = 1;#alt
				pSTPT.vector[5].skipMe = 0;#type
				#pSTPT.vector[6].skipMe = 0;#color
			} else {
				setprop("f16/ded/lat", 0);
				setprop("f16/ded/lon", 0);
				setprop("f16/ded/stpt-rad", 10);
				setprop("f16/ded/stpt-type", "   ");
				#setprop("f16/ded/stpt-color", "RED");
				wp_num_curr = 0;
				pSTPT.vector[1].skipMe = 0;#lat
				pSTPT.vector[2].skipMe = 0;#lon
				pSTPT.vector[3].skipMe = 0;#radius
				pSTPT.vector[4].skipMe = 1;#alt
				pSTPT.vector[5].skipMe = 0;#type
				#pSTPT.vector[6].skipMe = 0;#color
			}

			me.text[1] = sprintf("      LAT  %s", pSTPT.vector[1].getText());
			me.text[2] = sprintf("      LNG  %s", pSTPT.vector[2].getText());
			me.text[3] = sprintf("      RAD  %sNM", pSTPT.vector[3].getText());
			me.text[4] = sprintf("      TYP  %s", pSTPT.vector[5].getText());



			if 	(stpt != nil) {
				wp_num_lastA = stpt.lat;
				wp_num_lastO = stpt.lon;
				wp_num_lastR = stpt.radius;
				#wp_num_lastC = stpt.color==0?"RED":(stpt.color==1?"YEL":"GRN");
				wp_num_lastT = stpt.type;
			} else {
				wp_num_lastA = 0;
				wp_num_lastO = 0;
				wp_num_lastR = 10;
				#wp_num_lastC = "RED";
				wp_num_lastT = "   ";
			}
		} elsif (wp_num != nil and ((wp_num < 359 and wp_num >= 350) or (wp_num < 405 and wp_num >= 400) or (wp_num < 455 and wp_num >= 450) or (wp_num == 500) or (wp_num == steerpoints.index_of_bullseye))) {
			# Own markpoints, DLNK markpoints, WPN GPS and Bulls-eye
			var stpt = steerpoints.getNumber(wp_num);

			if 	(stpt != nil) {
				wp_num_curr = wp_num;
				if (wp_num_lastA != stpt.lat) {
					setprop("f16/ded/lat", stpt.lat);
				} else {
					stpt.lat = getprop("f16/ded/lat");
				}
				if (wp_num_lastO != stpt.lon) {
					setprop("f16/ded/lon", stpt.lon);
				} else {
					stpt.lon = getprop("f16/ded/lon");
				}
				if (wp_num_lastR != stpt.alt) {
					setprop("f16/ded/alt", stpt.alt);
				} else {
					stpt.alt = getprop("f16/ded/alt");
				}
				pSTPT.vector[1].skipMe = 0;#lat
				pSTPT.vector[2].skipMe = 0;#lon
				pSTPT.vector[3].skipMe = 1;#radius
				pSTPT.vector[4].skipMe = 0;#alt
				pSTPT.vector[5].skipMe = 1;#type
				#pSTPT.vector[6].skipMe = 1;#color
			} elsif (stpt == nil and (getprop("f16/ded/alt")!=0 or getprop("f16/ded/lat") != 0 or getprop("f16/ded/lon") != 0)) {
				stpt = steerpoints.STPT.new();
				stpt.lat = getprop("f16/ded/lat");
				stpt.lon = getprop("f16/ded/lon");
				stpt.alt = getprop("f16/ded/alt");
				steerpoints.setNumber(wp_num, stpt);
				wp_num_curr = wp_num;
				pSTPT.vector[1].skipMe = 0;#lat
				pSTPT.vector[2].skipMe = 0;#lon
				pSTPT.vector[3].skipMe = 1;#radius
				pSTPT.vector[4].skipMe = 0;#alt
				pSTPT.vector[5].skipMe = 1;#type
				#pSTPT.vector[6].skipMe = 1;#color
			} else {
				setprop("f16/ded/lat", 0);
				setprop("f16/ded/lon", 0);
				setprop("f16/ded/alt", 0);
				wp_num_curr = 0;
				pSTPT.vector[1].skipMe = 0;#lat
				pSTPT.vector[2].skipMe = 0;#lon
				pSTPT.vector[3].skipMe = 1;#radius
				pSTPT.vector[4].skipMe = 0;#alt
				pSTPT.vector[5].skipMe = 1;#type
				#pSTPT.vector[6].skipMe = 1;#color
			}

			me.text[1] = sprintf("     LAT  %s", pSTPT.vector[1].getText());
			me.text[2] = sprintf("     LNG  %s", pSTPT.vector[2].getText());
			if (wp_num == steerpoints.index_of_bullseye) {
				me.text[3] = sprintf("    ELEV  -1FT");
			} else {
				me.text[3] = sprintf("    ELEV  %sFT", pSTPT.vector[4].getText());
			}
			if (wp_num == steerpoints.getCurrentNumber()) {
				TOS = steerpoints.getCurrentTOS();
			}
			me.text[4] = sprintf("     TOS  %s", TOS);



			if 	(stpt != nil) {
				wp_num_lastA = stpt.lat;
				wp_num_lastO = stpt.lon;
				wp_num_lastR = stpt.alt;
			} else {
				wp_num_lastA = 0;
				wp_num_lastO = 0;
				wp_num_lastR = 0;
			}
		} else {
			me.text[3] = sprintf("     ELEV       FT");
			me.text[4] = sprintf("      TOS  ");
			me.text[1] = sprintf("      LAT  %s", lat);
			me.text[2] = sprintf("      LNG  %s", lon);
			wp_num_curr = 0;
			pSTPT.vector[1].skipMe = 1;#lat
			pSTPT.vector[2].skipMe = 1;#lon
			pSTPT.vector[3].skipMe = 1;#radius
			pSTPT.vector[4].skipMe = 1;#alt
			pSTPT.vector[5].skipMe = 1;#type
			#pSTPT.vector[6].skipMe = 1;#color
		}
		me.text[0] = sprintf("    STPT %s%s %s", pSTPT.vector[0].getText(), pSTPT.vector[6].getText(), me.no);
		steerpoints.autoMode = getprop("f16/ded/stpt-auto")=="AUTO"?1:0;
	},

	updateCrus: func() {
		# Source: F-16 A/B Mid-Life Update Production Tape M1: Pilot's guide to new to new capabilities & cockpit enhancements.
		# This page does not yet support HOME

        # The top right STPT number should be hidden except on the TOS page
        var tempNo = "";
        var crusMode = getprop("f16/ded/crus-mode");
        var tempCrusMode = crusMode;
        if (crusMode == "TOS") {
            tempNo = me.no;
        }

        if (CRUSmodeTF.selected) {
            tempCrusMode = "*"~tempCrusMode~"*";
        }
        if (getprop("f16/ded/cur-crus-mode") == crusMode) {
            tempCrusMode = backgroundText(tempCrusMode);
        }
        if (!CRUSmodeTF.selected) {
            tempCrusMode = " "~tempCrusMode~" ";
        }


        me.text[0] = sprintf("      CRUS  %s     %s ", tempCrusMode, tempNo);
		# me.text[0] = sprintf("     CRUS  RNG  ",me.no);
		if (crusMode == "TOS") {
		    var time = getprop("/sim/time/gmt-string");
		    var cur_wp = steerpoints.getCurrent();
		    var cur_des = steerpoints._getCurrentDesiredTOS();
		    if (des_tos_last != cur_des) {
		        if (cur_des != nil) {
		            setprop("f16/ded/crus-des-tos", cur_des);
		        } else {
		            setprop("f16/ded/crus-des-tos", -1);
		        }
            } else {
                steerpoints.setCurrentDesiredTOS(getprop("f16/ded/crus-des-tos"));
            }
            if (cur_wp == nil) {
                pCRUS.vector[1].skipMe = 1; # desiredTOS
            } else {
                pCRUS.vector[1].skipMe = 0; # desiredTOS
            }

            var TOS = CRUSdesTosEF.getText();
		    var ETA = steerpoints.getCurrentTOS();
		    var gs_num = steerpoints.getCurrentRequiredSpeed();
		    if (gs_num != nil) {
		        setprop("/f16/ded/crus-req-gs", gs_num);
            }
		    var req_gs = sprintf("%dKTS", gs_num);
		    if (cur_wp == nil) {
		        TOS = "";
		    }
		    if (gs_num == nil or cur_des == nil) {
		        req_gs = "";
		    }
            me.text[1] = sprintf("      TIME   %s", time);
            me.text[2] = sprintf("   DES TOS  %s", TOS);
            me.text[3] = sprintf("       ETA   %s", ETA);
            me.text[4] = sprintf("   REQ G/S    %s", req_gs);

            if (cur_wp != nil) {
                des_tos_last = cur_des;
            } else {
                des_tos_last = nil;
            }

		} elsif (crusMode == "RNG") {
		    # The steerpoint is currently fixed at last steerpoint, unless using a non route steerpoint
            var fuel   = "";
            var fp = flightplan();
            var maxS = "";
            var stnum = steerpoints.getCurrentNumber();
            if (fp != nil and stnum < 100) {
                var max = fp.getPlanSize();
                if (max > 0) {
                    maxS = sprintf("%3d "~utf8.chstr(0x2195),max);
                    var ete = getprop("autopilot/route-manager/ete");
                    if (ete != nil and ete > 0) {
                        var pph = getprop("engines/engine[0]/fuel-flow_pph");
                        if (pph == nil) pph = 0;
                        var remain = getprop("consumables/fuel/total-fuel-lbs")-pph*(ete/3600);
                        fuel = sprintf("% 6dLBS",remain);
                        if (size(fuel)>9) {
                            if (remain > 0) {
                                fuel = "999999LBS";
                            } else {
                                fuel = "-99999LBS";
                            }
                        }
                    }
                }
            } elsif (stnum >= 100) {
                var stpt = steerpoints.getCurrent();
                maxS = sprintf("%3d "~utf8.chstr(0x2195),stnum);
                var ete = steerpoints.getCurrentETA();
                if (ete != nil and ete > 0) {
                    var pph = getprop("engines/engine[0]/fuel-flow_pph");
                    if (pph == nil) pph = 0;
                    var remain = getprop("consumables/fuel/total-fuel-lbs")-pph*(ete/3600);
                    fuel = sprintf("% 6dLBS",remain);
                    if (size(fuel)>9) {
                        if (remain > 0) {
                            fuel = "999999LBS";
                        } else {
                            fuel = "-99999LBS";
                        }
                    }
                }
            }
            var windkts = getprop("environment/wind-speed-kt");
            var winddir = getprop("environment/wind-from-heading-deg");
            if (windkts == nil or winddir == nil) {
                windkts = -1;
                winddir = -1;
            }
            windkts = sprintf("%2dKTS",getprop("environment/wind-speed-kt"));
            winddir = sprintf("%03d\xc2\xb0",getprop("environment/wind-from-heading-deg"));
            me.text[1] = sprintf("      STPT  %s   ",maxS);
            me.text[2] = sprintf("      FUEL   %s",fuel);#fuel remaining after getting to last steerpoint at current fuel consumption.
            me.text[3] = sprintf("                        ");
            me.text[4] = sprintf("      WIND %s %s",winddir,windkts);
        } elsif (crusMode == "EDR") {
            var windkts = getprop("environment/wind-speed-kt");
            var winddir = getprop("environment/wind-from-heading-deg");
            if (windkts == nil or winddir == nil) {
                windkts = -1;
                winddir = -1;
            }
            windkts = sprintf("%2dKTS",getprop("environment/wind-speed-kt"));
            winddir = sprintf("%03d\xc2\xb0",getprop("environment/wind-from-heading-deg"));
            var toBingo = (getprop("consumables/fuel/total-fuel-lbs")-getprop("f16/settings/bingo"))/getprop("engines/engine[0]/fuel-flow_pph")*3600;

            me.text[1] = sprintf("      STPT  %s   ",me.no);
            me.text[2] = sprintf("   TO BNGO   %s",steerpoints.formatTime(toBingo));
            me.text[3] = sprintf("  OPT MACH   %s", "");
            me.text[4] = sprintf("      WIND %s %s",winddir,windkts);
        }
	},

	updateTime: func() {
		var time = getprop("/sim/time/gmt-string");
		var hackHour = int(getprop("f16/avionics/hack/elapsed-time-sec") / 3600);
		var hackMin = int((getprop("f16/avionics/hack/elapsed-time-sec") - (hackHour * 3600)) / 60);
		var hackSec = int(getprop("f16/avionics/hack/elapsed-time-sec") - (hackHour * 3600) - (hackMin * 60));
		var hackTime = sprintf("%02.0f", hackHour) ~ ":" ~ sprintf("%02.0f", hackMin) ~ ":" ~ sprintf("%02.0f", hackSec);
		var date = sprintf("%02.0f", getprop("/sim/time/utc/month")) ~ "/" ~ sprintf("%02.0f", getprop("/sim/time/utc/day")) ~ "/" ~ right(sprintf("%s", getprop("/sim/time/utc/year")), 2);
		me.text[0] = sprintf("          TIME       %s  ",me.no);
		if (getprop("f16/avionics/power-gps") and getprop("sim/variant-id") != 1 and getprop("sim/variant-id") != 3) {
			me.text[1] = sprintf("GPS SYSTEM      %s",time);
		} else {
			me.text[1] = sprintf("    SYSTEM      %s",time);
		}
		me.text[2] = sprintf("      HACK      %s", hackTime);
		me.text[3] = sprintf(" DELTA TOS      00:00:00   ");
		if (getprop("sim/variant-id") != 1 and getprop("sim/variant-id") != 3) {
			me.text[4] = sprintf("  MM/DD/YY      %s", date);
		} else {
			me.text[4] = sprintf("                          ");
		}
	},

	# the Mark page is supposed to be for creating steerpoints 26 --> 30. Until we have a list of 30 steerpoints,
	# we will make this show current position since that is what it does anyway
	markMode: "OFLY",
	markModeSelected: 0,
	updateMark: func() {
		me.markNo = 0;
		if (me.page != me.pageLast) {
			# we just entered this page, lets store this mark
			me.markNo = steerpoints.markOFLY();
			me.mark = steerpoints.getNumber(me.markNo);
		} else {
			me.markNo = steerpoints.ownMarkIndex+400;
			me.mark = steerpoints.getNumber(me.markNo);
		}

		wp_num_curr = me.markNo;
		if (me.mark != nil) {
			me.markMode = (!size(me.mark.type) or me.mark.type == "   ")?"OFLY":me.mark.type;
			lat = convertDegreeToStringLat(me.mark.lat);
			lon = convertDegreeToStringLon(me.mark.lon);
			alt = me.mark.alt;
		} else {
			me.markMode = "NULL";
			lat = "-";
			lon = "-";
			alt = 0;
		}
		
		if (me.markModeSelected) {
			me.text[0] = sprintf("        MARK *%s*  %s",me.markMode,me.no);
		} else {
			me.text[0] = sprintf("        MARK  %s   %s",me.markMode,me.no);
		}
		me.text[1] = sprintf("     LAT  %s",lat);
		me.text[2] = sprintf("     LNG  %s",lon);
		me.text[3] = sprintf("    ELEV  % 5dFT",alt);
		me.text[4] = sprintf("       #  %03d", me.markNo);
	},

	fixTakingMode: "OFLY",
	fixTakingModeSelected: 1,
	updateFix: func() {
		if (me.fixTakingModeSelected) {
			me.text[0] = sprintf("          FIX  *%s*", me.fixTakingMode);
		} else {
			me.text[0] = sprintf("          FIX   %s", me.fixTakingMode);
		}
		me.text[1] = sprintf("     STPT   %s", me.no);
		me.text[2] = sprintf("    DELTA     0.1NM", );
		me.text[3] = sprintf("SYS ACCUR     HIGH");
		me.text[4] = sprintf("GPS ACCUR     HIGH");
	},

	acalMode: "GPS",
	acalModeSelected: 1,
	updateAcal: func() {
		if (me.acalModeSelected) {
			me.text[0] = sprintf(" ACAL    *%s*      %s", me.acalMode, me.no);
		} else {
			me.text[0] = sprintf(" ACAL     %s       %s", me.acalMode, me.no);
		}
		me.text[1] = sprintf("          AUTO   ");
		me.text[2] = sprintf("                 ");
		me.text[3] = sprintf("                 ");
		me.text[4] = sprintf("                 ");
	},

	updateList: func() {
		me.text[0] = sprintf("           LIST      %s ", me.no);
		me.text[1] = sprintf(" "~utf8.chstr(0xFB51)~"DEST "~utf8.chstr(0xFB52)~"BNGO "~utf8.chstr(0xFB53)~"VIP "~utf8.chstr(0xFB6B)~"INTG ");
		me.text[2] = sprintf(" "~utf8.chstr(0xFB54)~"NAV  "~utf8.chstr(0xFB55)~"MAN  "~utf8.chstr(0xFB56)~"INS "~utf8.chstr(0xFB5E)~"DLNK ");
		me.text[3] = sprintf(" "~utf8.chstr(0xFB57)~"EWS  "~utf8.chstr(0xFB58)~"MODE "~utf8.chstr(0xFB59)~"VRP "~utf8.chstr(0xFB50)~"MISC ");
		me.text[4] = sprintf("                        ");
	},

	updateListHUD: func() {
		me.text[0] = sprintf("           LIST      %s ", me.no);
		me.text[1] = sprintf(" 1DEST 2BNGO 3VIP RINTG ");
		me.text[2] = sprintf(" 4NAV  5MAN  6INS EDLNK ");
		me.text[3] = sprintf(" 7EWS  8MODE 9VRP 0MISC ");
		me.text[4] = sprintf("                        ");
	},

	updateDest: func() {
		var lat = "";
		var lon = "";
		var alt = -1;
		var st = steerpoints.getLast();
		if (st != nil) {
			lat = convertDegreeToStringLat(st.lat);
			lon = convertDegreeToStringLon(st.lon);
			alt = st.alt;
		}
		TOS = steerpoints.getLastTOS();

		me.text[0] = sprintf("         DEST  DIR   %s",me.no);
		me.text[1] = sprintf("      LAT  %s",lat);
		me.text[2] = sprintf("      LNG  %s",lon);
		me.text[3] = sprintf("     ELEV  % 5dFT",alt);
		me.text[4] = sprintf("      TOS  %s",TOS);
	},

	updateBingo: func() {
		me.text[0] = sprintf("        BINGO        %s ",me.no);
		me.text[1] = sprintf("                        ");
		me.text[2] = sprintf("    SET    %s  ",pBINGO.vector[0].getText());
		me.text[3] = sprintf("  TOTAL    %5dLBS      ",getprop("consumables/fuel/total-fuel-lbs"));
		me.text[4] = sprintf("                        ");
	},

	VIPpage: 0,
	updateVIP: func() {
		if (me.VIPpage == 0) {
			me.text[0] = sprintf("      *VIP-TO-TGT*      ");
			me.text[1] = sprintf("      VIP      %s       ",me.no);
			me.text[2] = sprintf("     TBRG      6.9°     ");
			me.text[3] = sprintf("      RNG        55.5 NM");
			me.text[4] = sprintf("     ELEV        420FT  ");
		} elsif (me.VIPpage == 1) {
			me.text[0] = sprintf("      *VIP-TO-PUP*      ");
			me.text[1] = sprintf("      VIP      %s       ",me.no);
			me.text[2] = sprintf("     TBRG      69.0°    ");
			me.text[3] = sprintf("      RNG        51.0 NM");
			me.text[4] = sprintf("     ELEV       4200FT  ");
		}
	},

	NAVpage: 0,
	updateNav: func() {
		var days = 31 - getprop("/sim/time/utc/day");
		var GPSstatus = "";
		var keyString = "";
		if (getprop("f16/avionics/power-gps")) {
			GPSstatus = "HIGH";
			if (days == 0) {
				keyString = "EXPIRE AT 2400 HOURS";
			} else {
				keyString = "KEY VALID";
			}
		}
		if (me.NAVpage == 0) {
			me.text[0] = sprintf("     NAV STATUS      %s  ",me.no);
			me.text[1] = sprintf(" SYS ACCUR    HIGH       ");
			me.text[2] = sprintf(" GPS ACCUR    %s         ", GPSstatus);
			me.text[3] = sprintf(" MSN DUR      %s  DAYS   ", days);
			me.text[4] = sprintf(" %s", keyString);
		} elsif (me.NAVpage == 1) {
			me.text[0] = sprintf("    NAV COMMANDS     %s ",me.no);
			me.text[1] = sprintf("                        ");
			me.text[2] = sprintf("FILTER MODES  AUTO      ");
			me.text[3] = sprintf("     RESET   GPS        ");
			me.text[4] = sprintf("   ZEROIZE   GPS        ");
		}
	},

	updateMan: func() {
		me.text[0] = sprintf("      MAN            %s",me.no);
		me.text[1] = sprintf("WSPAN   %sFT",pMAN.vector[0].getText());
		me.text[2] = sprintf("      MBAL    ");
		me.text[3] = sprintf("RNG   %sFT  ",pMAN.vector[1].getText());
		me.text[4] = sprintf("TOF      5.4SEC ");
	},

	INSpage: 0,
	updateINS: func() {
		lat = convertDegreeToStringLat(getprop("position/latitude-deg"));
		lon = convertDegreeToStringLon(getprop("position/longitude-deg"));
		var rdy = "   ";
		if (getprop("f16/avionics/ins-knob") == 3) {
    		rdy = "RDY";
		}
		var hdgmag = getprop("/orientation/heading-magnetic-deg");
		if (me.INSpage == 0) {
			me.text[0] = sprintf("  INS   10.2/10 %s  %s",rdy,me.no);
			me.text[1] = sprintf("  LAT  %s",lat);
			me.text[2] = sprintf("  LNG  %s",lon);
			me.text[3] = sprintf("  SALT  %5dFT",getprop("position/altitude-ft"));
			me.text[4] = sprintf("THDG %5.1f\xc2\xb0     G/S %3d",getprop("orientation/true-heading-deg"),getprop("velocities/groundspeed-kt"));
		} elsif (me.INSpage == 1) {
			me.text[0] = sprintf("    INS INFLT ALIGN  %s ",me.no);
			me.text[1] = sprintf("                        ");
			me.text[2] = sprintf(" COMPASS HDG   * %3d°*  ",hdgmag);
			me.text[3] = sprintf("                        ");#FIX NECESSARY
			me.text[4] = sprintf("                        ");
		}
	},

	updateEWS: func() {
		var flares = getprop("ai/submodels/submodel[0]/count");
		var jammer = getprop("f16/ews/ew-jmr-switch") ? " ON" : "OFF";
		me.text[0] = sprintf("       EWS CONTROLS  %s",me.no);
		me.text[1] = sprintf(" CH %3d     REQJAM   %s", flares, jammer);
		me.text[2] = sprintf(" FL %3d     FDBK      ON", flares);
		me.text[3] = sprintf(" MODE %s  REQCTR    ON", getprop("f16/ews/ew-mode-knob") == 1 ? "MAN " :( getprop("f16/ews/ew-mode-knob") == 2?"AUT ":"OFF "));
		me.text[4] = sprintf("            BINGO     ON");
	},

	updateMode: func() {
		me.text[0] = sprintf("      MODE * NAV *   %s ",me.no);
		me.text[1] = sprintf("                        ");
	if (getprop("sim/variant-id") == 2) {
			me.text[2] = sprintf("      AACMI RECORD      ", date);
		} else {
			me.text[2] = sprintf("                        ");
		}
		me.text[3] = sprintf("                        ");
		me.text[4] = sprintf("                        ");
	},

	VRPpage: 0,
	updateVRP: func() {
		if (me.VRPpage == 0) {
			me.text[0] = sprintf("       TGT-TO-VRP       ");
			me.text[1] = sprintf("      TGT               ");
			me.text[2] = sprintf("     TBRG    0.0°       ");
			me.text[3] = sprintf("      RNG          0FT  ");
			me.text[4] = sprintf("     ELEV        0FT    ");
		} elsif (me.VRPpage == 1) {
			me.text[0] = sprintf("       TGT-TO-PUP       ");
			me.text[1] = sprintf("      TGT               ");
			me.text[2] = sprintf("     TBRG    0.0°       ");
			me.text[3] = sprintf("      RNG          0FT  ");
			me.text[4] = sprintf("     ELEV        0FT    ");
		}
	},

	updateIntg: func() {
		me.updateIFF2();
	},

	updateDlnk: func() {

		if (getprop("instrumentation/datalink/power")) {
			var csl = []~datalink.get_connected_callsigns();
			var idl = []~datalink.get_connected_indices();
			var myW = getprop("link16/wingman-4");
			if (myW != nil and myW != "") {
				append(csl, myW);
				append(idl, -1);
			}
			var last = size(csl);
			var list = setsize([],last);
			me.scroll += 0.25;
			if (me.scroll >= last-3) me.scroll = 0;
			var usedI = setsize([],4);
			var usedC = setsize([],4);
			var j = 0;
			var highest = 0;
			foreach (var idl_ ; idl) {
				if (idl_ > highest) highest = idl_+1;
			}
			for(var i = int(me.scroll); i < int(me.scroll)+4;i+=1) {
				if (i < last) {
					usedI[j] = sprintf("#%02d", idl[i]+1);
					usedC[j] = csl[i];

					while(size(usedC[j]) < 7) {
						usedC[j] = usedC[j]~" ";
					}
				} else {
					usedI[j] = "#  ";
					usedC[j] = "       ";
				}
				j += 1;
			}

			me.text[0] = sprintf("    DLNK  CH %s  %s",pDLNK.vector[0].getText(),me.no);
			me.text[1] = sprintf("%s %7s       COMM VHF",usedI[0],usedC[0]);
			me.text[2] = sprintf("%s %7s       DATA 16K",usedI[1],usedC[1]);
			me.text[3] = sprintf("%s %7s       OWN  #0 ",usedI[2],usedC[2]);
			me.text[4] = sprintf("%s %7s       LAST #%d ",usedI[3],usedC[3],highest);
		} else {
			me.text[0] = sprintf("        DLNK          %s ",me.no);
			me.text[1] = sprintf("  NO DLINK DATA ");
			me.text[2] = sprintf("                        ");
			me.text[3] = sprintf("                        ");
			me.text[4] = sprintf("                        ");
		}
	},

	updateMisc: func() {
		me.text[0] = sprintf("           MISC      %s ", me.no);
		me.text[1] = sprintf(" "~utf8.chstr(0xFB51)~"CORR "~utf8.chstr(0xFB52)~"MAGV "~utf8.chstr(0xFB53)~"OFP "~utf8.chstr(0xFB6B)~"HMCS");
		me.text[2] = sprintf(" "~utf8.chstr(0xFB54)~"INSM "~utf8.chstr(0xFB55)~"LASR "~utf8.chstr(0xFB56)~"GPS "~utf8.chstr(0xFB5E)~" ");
		me.text[3] = sprintf(" "~utf8.chstr(0xFB57)~"DRNG "~utf8.chstr(0xFB58)~"BULL "~utf8.chstr(0xFB59)~"WPT "~utf8.chstr(0xFB50)~"HARM ");
		me.text[4] = sprintf("                        ");
	},

	updateMiscHUD: func() {
		me.text[0] = sprintf("           MISC      %s ", me.no);
		me.text[1] = sprintf(" 1CORR 2MAGV 3OFP RHMCS ");
		me.text[2] = sprintf(" 4INSM 5LASR 6GPS E     ");
		me.text[3] = sprintf(" 7DRNG 8BULL 9WPT 0HARM ");
		me.text[4] = sprintf("                        ");
	},

	updateMagv: func() {
		var amount = geo.normdeg180(getprop("orientation/heading-deg")-getprop("orientation/heading-magnetic-deg"));
		if (amount != nil) {
			var letter = "W";
			if (amount <0) {#no longer sure, this is correct..
				letter = "E";
				amount = math.abs(amount);
			}
			me.text[2] = sprintf("         %s %.1f\xc2\xb0",letter, amount);
		} else {
			me.text[2] = sprintf("         GPS OFFLINE");
		}
		me.text[0] = sprintf("       MAGV  AUTO    %s ",me.no);
		me.text[1] = sprintf("                        ");
		me.text[3] = sprintf("                        ");
		me.text[4] = sprintf("                        ");
	},

	OFPpage: 0,
	updateOFP: func() {
		var serial = getprop("/sim/model/livery/serial");
		var splitSerial = split("-",serial);
		var serialSimple = splitSerial[0]~splitSerial[1];
		if (me.OFPpage == 0) {
			me.text[0] = sprintf("         OFP1        %s",me.no);
			me.text[1] = sprintf("  UFC  P07A   FCR  7010");
			me.text[2] = sprintf("  MFD  P07A   FCC  P07B");
			me.text[3] = sprintf("  SMS  P07A   DTE  P010");
			me.text[4] = sprintf("  FDR  P30A   HUD  002e");
		} elsif (me.OFPpage == 1) {
			me.text[0] = sprintf("         OFP2        %s",me.no);
			me.text[1] = sprintf("  GPS  P07B   IFF  P03A");
			me.text[2] = sprintf("  HK3  P07A   TGP  P07A");
			me.text[3] = sprintf("  HK7  P07A  BLKR  P07B");
			me.text[4] = sprintf(" FLCS  7072   NVP  P07A");
		} elsif (me.OFPpage == 2) {
			me.text[0] = sprintf("         OFP3        %s",me.no);
			me.text[1] = sprintf("  RWR  P07A  IECM  P07A");
			me.text[2] = sprintf("  EID  P07B   MDF  M074");
			me.text[3] = sprintf(" CMDS  P040  DLNK  P07B");
			me.text[4] = sprintf("  MDF  M074   ");
		} else {
			me.text[0] = sprintf("        DTC MISC       ");
			me.text[1] = sprintf("                       ");
			me.text[2] = sprintf("  A/C TAIL  *%s*       ",serialSimple);
			me.text[3] = sprintf("  WPN DATA             ");
			me.text[4] = sprintf("  RDR DATA             ");
		}
	},

	updateCORR: func() {
		me.text[0] = sprintf("          CORR       %s ", me.no);
		me.text[1] = sprintf("                        ");
		me.text[2] = sprintf("                        ");
		me.text[3] = sprintf("                        ");
		me.text[4] = sprintf("                        ");
	},

	updateINSM: func() {
		me.text[0] = sprintf("          INSM          ");
		me.text[1] = sprintf("                        ");
		me.text[2] = sprintf("        *      *        ");
		me.text[3] = sprintf("                        ");
		me.text[4] = sprintf("                        ");
	},

	updateDRNG: func() {
		me.text[0] = sprintf("          DRNG       %s ", me.no);
		me.text[1] = sprintf("                        ");
		me.text[2] = sprintf("    X      FT     LNG   ");
		me.text[3] = sprintf("    Y      FT     LFT   ");
		me.text[4] = sprintf("                        ");
	},

	HMCSpage: 0,
	updateHMCS: func() {
		if (me.HMCSpage == 0) {
			me.text[0] = sprintf("      HMCS DISPLAY   %s ", me.no);
			me.text[1] = sprintf("  HUD BLNK              ");
			me.text[2] = sprintf("  CKPT BLNK             ");
			me.text[3] = sprintf("  DECLUTTER  LVL1       ");
			me.text[4] = sprintf("                        ");
		} elsif (me.HMCSpage == 1) {
			me.text[0] = sprintf("       HMCS ALIGN    %s ", me.no);
			me.text[1] = sprintf("  COURSE    UPLKRST     ");
			me.text[2] = sprintf("  AZ/EL                 ");
			me.text[3] = sprintf("  ROLL                  ");
			me.text[4] = sprintf("  UPLK                  ");
		}
	},

	harmTablePage: 0,
	updateHARM: func() {
		#me.harmTablePage = radar_system.f16_radSensor.currtable;# for now the tables cannot be flipped on DED.
		var table = radar_system.f16_radSensor.tables[me.harmTablePage];
		var siz = size(table);
		me.text[0] = sprintf(" HARM TBL%d "~utf8.chstr(0x2195)~"   T1 %s",me.harmTablePage+1,siz>0?table[0]:"");
		me.text[1] = sprintf("               T2 %s",siz>1?table[1]:"");
		me.text[2] = sprintf("               T3 %s",siz>2?table[2]:"");
		me.text[3] = sprintf("               T4 %s",siz>3?table[3]:"");
		me.text[4] = sprintf(" SEQ=MN1       T5 %s",siz>4?table[4]:"");
	},

	updateLaser: func() {
		var code = getprop("f16/avionics/laser-code");
		me.text[0] = sprintf("         LASER       %s ",me.no);
		me.text[1] = sprintf("   TGP CODE   %s     ",pLASR.vector[0].getText());
		me.text[2] = sprintf("   LST CODE    %04d     ",code);
		me.text[3] = sprintf("   A-G: CMBT  A-A: TRNG ");
		me.text[4] = sprintf("   LASER ST TIME  16 SEC");
	},

	GPSpage: 0,
	updateGPS: func() {
		if (getprop("f16/avionics/power-gps")) {
			if (me.GPSpage == 0) {
				var date = sprintf("%02.0f", getprop("/sim/time/utc/month")) ~ "/" ~ sprintf("%02.0f", getprop("/sim/time/utc/day")) ~ "/" ~ right(sprintf("%s", getprop("/sim/time/utc/year")), 2);
				me.text[0] = sprintf(" GPS INIT1   DSPL/ENTR");
				me.text[1] = sprintf("      TIME   %s    ", getprop("/sim/time/gmt-string"));
				me.text[2] = sprintf("  MM/DD/YY   %s    ", date);
				me.text[3] = sprintf("       G/S   %-4dKTS", getprop("/instrumentation/gps/indicated-ground-speed-kt"));
				me.text[4] = sprintf("      MTRK   %03d\xc2\xb0", getprop("/instrumentation/gps/indicated-track-magnetic-deg"));
			} else {
				me.text[0] = sprintf(" GPS INIT2   DSPL/ENTR");
				me.text[1] = sprintf("                        ");
				me.text[2] = sprintf("       LAT   %s    ", convertDegreeToStringLat(getprop("/instrumentation/gps/indicated-latitude-deg")));
				me.text[3] = sprintf("       LON   %s", convertDegreeToStringLat(getprop("/instrumentation/gps/indicated-longitude-deg")));
				me.text[4] = sprintf("       ALT   %5dFT", getprop("/instrumentation/gps/indicated-altitude-ft"));
			}
		} else {
			me.text[0] = sprintf(" GPS OFFLINE   DSPL/ENTR");
			me.text[1] = sprintf("                        ");
			me.text[2] = sprintf("                        ");
			me.text[3] = sprintf("                        ");
			me.text[4] = sprintf("                        ");
		}
	},

	updateBull: func() {
		if (steerpoints.bullseyeMode) {
			me.text[0] = sprintf("      *BULLSEYE*        ");
		} else {
			me.text[0] = sprintf("       BULLSEYE         ");
		}
		me.text[1] = sprintf("       BULL 555    ");
		me.text[2] = sprintf("                        ");
		me.text[3] = sprintf("                        ");
		me.text[4] = sprintf("                        ");
		wp_num_curr = steerpoints.index_of_bullseye;
	},

	updateWPT: func() {
		me.text[0] = sprintf("           WPT          ");
		me.text[1] = sprintf("                        ");
		me.text[2] = sprintf("                        ");
		me.text[3] = sprintf("                        ");
		me.text[4] = sprintf("                        ");
	},

	CNIshowWind: 0,
	updateCNI: func() {
		winddir = sprintf("%03d\xc2\xb0",getprop("environment/wind-from-heading-deg"));
		windkts = sprintf("%03d",getprop("environment/wind-speed-kt"));
		var m3 = "3";
		if (getprop("instrumentation/transponder/inputs/knob-mode") == 0) {
    		m3 = " ";
		}
		var m4 = " ";
		if (getprop("instrumentation/iff/activate")) {
    		m4 = "4";
		}
		var mc = " ";
		if (getprop("instrumentation/transponder/inputs/knob-mode") == 5) {
    		mc = "C";
		}
		var ms = " ";
		if (getprop("sim/multiplay/online")) {
    		ms = "S";
		}
		me.text[0] = sprintf("UHF   %6.2f    STPT %s",getprop("/instrumentation/comm[0]/frequencies/selected-mhz"), me.no);# removed the 'A' here, as MLU manuals don't show it. Otherwise it should depend on steerpoints.autoMode

		if (me.CNIshowWind) {
			me.text[1] = sprintf("                %s %s", winddir, windkts);
		} else {
			me.text[1] = sprintf("                ");
		}
		me.text[2] = sprintf("VHF   %6.2f    %s",getprop("/instrumentation/comm[1]/frequencies/selected-mhz"), getprop("/sim/time/gmt-string"));
		if (me.chrono.running) {
			var hackHour = int(getprop("f16/avionics/hack/elapsed-time-sec") / 3600);
			var hackMin = int((getprop("f16/avionics/hack/elapsed-time-sec") - (hackHour * 3600)) / 60);
			var hackSec = int(getprop("f16/avionics/hack/elapsed-time-sec") - (hackHour * 3600) - (hackMin * 60));
			var hackTime = sprintf("%02.0f", hackHour) ~ ":" ~ sprintf("%02.0f", hackMin) ~ ":" ~ sprintf("%02.0f", hackSec);
			me.text[3] = sprintf("                %s", hackTime);
		} else {
			me.text[3] = sprintf(" ");
		}
		me.text[4] = sprintf("M  %s%s%s%s %04d   MAN T%03.0f%s",m3,m4,mc,ms,getprop("instrumentation/transponder/id-code"), getprop("instrumentation/tacan/frequencies/selected-channel"), getprop("instrumentation/tacan/frequencies/selected-channel[4]"));
	},

	Comm1page: 0,
	updateComm1: func() {
		if (me.Comm1page == 0) {
			me.text[0] = sprintf("  SEC  UHF   MAIN  ");
			me.text[1] = sprintf("  %s", pCOMM1.vector[0].getText());
			me.text[2] = sprintf("               1");
			me.text[3] = sprintf("  PRE  2");
			me.text[4] = sprintf("  %s    NB", pCOMM1.vector[1].getText());
		} elsif (me.Comm1page == 1) {
			me.text[0] = sprintf("         UHF ON         ");
			me.text[1] = sprintf("                        ");
			me.text[2] = sprintf("         GUARD          ");
			me.text[3] = sprintf("                        ");
			me.text[4] = sprintf("           243.00       ");
		}
	},

	Comm2page: 0,
	updateComm2: func() {
		if (me.Comm2page == 0) {
			me.text[0] = sprintf("       VHF   ON  ");
			me.text[1] = sprintf("  %s", pCOMM2.vector[0].getText());
			me.text[2] = sprintf("              1");
			me.text[3] = sprintf("  PRE  2     TOD");
			me.text[4] = sprintf("  %s    NB", pCOMM2.vector[1].getText());
		} elsif (me.Comm2page == 1) {
			me.text[0] = sprintf("         VHF ON         ");
			me.text[1] = sprintf("                        ");
			me.text[2] = sprintf("        AM  GUARD       ");
			me.text[3] = sprintf("                        ");
			me.text[4] = sprintf("                        ");
		}
	},

	updateIFF1: func() {
		var ms1 = "OFF";
		if (getprop("sim/multiplay/online")) {
    		ms1 = "ON";
		}
		var mc1 = "OFF";
		if (getprop("instrumentation/transponder/inputs/knob-mode") == 5) {
    		mc1 = "ON";
		}
		var mcid = getprop("instrumentation/transponder/id-code");
		me.text[0] = sprintf("IFF        MAN       %s ", me.no);# Should have ON between IFF and MAN. But I moved it beside the channels, until we get more transponder/iff in cockpit.
		me.text[1] = sprintf("                        ");
		me.text[2] = sprintf("M1       OFF M4%s%s ", pIFF1.vector[2].getText(), pIFF1.vector[3].getText());
		me.text[3] = sprintf("M2       OFF MC %s  %s ",mcid,mc1);
		me.text[4] = sprintf("M3%s%s    MS  %s     ", pIFF1.vector[0].getText(), pIFF1.vector[1].getText(),ms1);
	},
	updateIFF2: func() {
		var target = radar_system.apg68Radar.getPriorityTarget();
		var sign = "";
		var type = "";
		var friend = "";
		if (target != nil) {
			sign = target.get_Callsign();
			type = target.getModel();
		}
		var frnd = 0;
		if (getprop("instrumentation/datalink/power") and sign != nil) {
			var lnk = datalink.get_data(sign);
			if (lnk != nil and lnk.on_link() == 1) {
				frnd = 1;
			}
		}
		if (frnd == 2) {
			friend = "WINGMAN";
		} elsif (frnd == 1) {
			friend = "DLINK";
		} elsif (frnd == 3) {
			friend = "DL-FRND";
		} elsif (sign != "") {
			friend = "NO CONN";
		}

		me.text[0] = sprintf("       SCAN INTG        ");
		me.text[1] = sprintf("                        ");
		me.text[2] = sprintf("ID   %s                 ",sign);
		me.text[3] = sprintf("RESP %s                 ",friend);
		me.text[4] = sprintf("TYPE %s                 ",type);
	},
	updateIFF3: func() {
		var ownid = getprop("sim/multiplay/callsign");

		me.text[0] = sprintf("         MODE S      %s ", me.no);
		me.text[1] = sprintf("      ID  %s     ",ownid);
		me.text[2] = sprintf("                        ");
		me.text[3] = sprintf("OPER  ADDR   16372      ");
		me.text[4] = sprintf("PERM  ADDR 2020319  HEX ");
	},
};

var Actions = {
	Tacan: {
		mSel: Action.new(pTACAN, toggleTACANBand),
	},
	Time: {
		toggleHack: Action.new(pTIME, toggleHack),
		resetHack: Action.new(pTIME, resetHack),
	},
	Fix: {
		mSel: Action.new(pFIX, modeSelFix),
	},
	Acal: {
		mSel: Action.new(pACAL, modeSelAcal),
	},
	Bullseye: {
		mSel: Action.new(pBULL, modeSelBull),
	},
	enter: Action.new(nil, dataEntryDisplay.page.enter),
	recall: Action.new(nil, dataEntryDisplay.page.recall),
	stptNext: Action.new(nil, stptNext),
	stptLast: Action.new(nil, stptLast),
	wx: Action.new(-1, stptSend),
	fud: Action.new(-1, stptCurr),
};

var Routers = {
	tacanRouter: Router.new(pCNI, pTACAN),
	alowRouter: Router.new(pCNI, pALOW),
	fackRouter: Router.new(pCNI, pFACK),
	stptRouter: Router.new(pCNI, pSTPT),
	crusRouter: Router.new(pCNI, pCRUS),
	timeRouter: Router.new(pCNI, pTIME),
	fixRouter: Router.new(pCNI, pFIX),
	markRouter: Router.new(pCNI, pMARK),
	acalRouter: Router.new(pCNI, pACAL),
	List: {
		destRouter: Router.new(pLIST, pDEST),
		bingoRouter: Router.new(pLIST, pBINGO),
		vipRouter: Router.new(pLIST, pVIP),
		navRouter: Router.new(pLIST, pNAV),
		manRouter: Router.new(pLIST, pMAN),
		insRouter: Router.new(pLIST, pINS),
		ewsRouter: Router.new(pLIST, pEWS),
		intgRouter: Router.new(pLIST, pINTG),
		dlnkRouter: Router.new(pLIST, pDLNK),
		modeRouter: Router.new(pLIST, pMODE),
		vrpRouter: Router.new(pLIST, pVRP),
		miscRouter: Router.new(pLIST, pMISC),
	},
	Misc: {
		corrRouter: Router.new(pMISC, pCORR),
		magvRouter: Router.new(pMISC, pMAGV),
		ofpRouter: Router.new(pMISC, pOFP),
		insmRouter: Router.new(pMISC, pINSM),
		laserRouter: Router.new(pMISC, pLASR),
		gpsRouter: Router.new(pMISC, pGPS),
		drngRouter: Router.new(pMISC, pDRNG),
		bullRouter: Router.new(pMISC, pBULL),
		wptRouter: Router.new(pMISC, pWPT),
		hmcsRouter: Router.new(pMISC, pHMCS),
		harmRouter: Router.new(pMISC, pHARM),
	},
	comm1Router: Router.new(nil, pCOMM1),
	comm2Router: Router.new(nil, pCOMM2),
	iffRouter: Router.new(nil, pIFF1),
	listRouter: Router.new(nil, pLIST),
	comm1Router2: Router.new(pCOMM1, pCNI),
	comm2Router2: Router.new(pCOMM2, pCNI),
	iffRouter2: Router.new(pIFF1, pCNI),
	listRouter2: Router.new(pLIST, pCNI),
};

var RouterVectors = {
	button1: [Routers.List.destRouter, Routers.tacanRouter, Routers.Misc.corrRouter,],
	button2: [Routers.List.bingoRouter, Routers.Misc.magvRouter, Routers.alowRouter],
	button3: [Routers.List.vipRouter, Routers.Misc.ofpRouter, Routers.fackRouter],
	button4: [Routers.List.navRouter, Routers.Misc.insmRouter, Routers.stptRouter],
	button5: [Routers.List.manRouter, Routers.Misc.laserRouter, Routers.crusRouter],
	button6: [Routers.List.insRouter, Routers.Misc.gpsRouter, Routers.timeRouter],
	button7: [Routers.List.ewsRouter, Routers.markRouter, Routers.Misc.drngRouter],
	button8: [Routers.List.modeRouter, Routers.Misc.bullRouter, Routers.fixRouter],
	button9: [Routers.acalRouter, Routers.List.vrpRouter, Routers.Misc.wptRouter],
	button0: [Routers.List.miscRouter, Routers.Misc.harmRouter],
	buttonComm1: [Routers.comm1Router2, Routers.comm1Router],
	buttonComm2: [Routers.comm2Router2, Routers.comm2Router],
	buttonIFF: [Routers.iffRouter2, Routers.iffRouter],
	buttonList: [Routers.listRouter2, Routers.listRouter],
	buttonEnter: [Routers.List.dlnkRouter],
	buttonRecall: [Routers.List.intgRouter, Routers.Misc.hmcsRouter],
};

var ActionVectors = {
	button1: [],
	button2: [],
	button3: [],
	button4: [],
	button5: [],
	button6: [],
	button7: [],
	button8: [],
	button9: [],
	button0: [Actions.Bullseye.mSel,Actions.Tacan.mSel,Actions.Fix.mSel,Actions.Acal.mSel],
	buttonup: [Actions.Time.toggleHack, Actions.stptNext],
	buttondown: [Actions.Time.resetHack,  Actions.stptLast],
	buttonEnter: [Actions.enter],
	buttonRecall: [Actions.recall],
	buttonWX: [Actions.wx],
	buttonFUD: [Actions.fud],
};

var Buttons = {
	button1: Button.new(btnText: "1", routerVec: RouterVectors.button1, To9: 1),
	button2: Button.new(btnText: "2", routerVec: RouterVectors.button2, To9: 1),
	button3: Button.new(btnText: "3", routerVec: RouterVectors.button3, To9: 1),
	button4: Button.new(btnText: "4", routerVec: RouterVectors.button4, To9: 1),
	button5: Button.new(btnText: "5", routerVec: RouterVectors.button5, To9: 1),
	button6: Button.new(btnText: "6", routerVec: RouterVectors.button6, To9: 1),
	button7: Button.new(btnText: "7", routerVec: RouterVectors.button7, To9: 1),
	button8: Button.new(btnText: "8", routerVec: RouterVectors.button8, To9: 1),
	button9: Button.new(btnText: "9", routerVec: RouterVectors.button9, To9: 1),
	button0: Button.new(btnText: "0", actionVec: ActionVectors.button0, routerVec: RouterVectors.button0),
	buttoncomm1: Button.new(routerVec: RouterVectors.buttonComm1),
	buttoncomm2: Button.new(routerVec: RouterVectors.buttonComm2),
	buttoniff: Button.new(routerVec: RouterVectors.buttonIFF),
	buttonlist: Button.new(routerVec: RouterVectors.buttonList),
	buttonup: Button.new(actionVec: ActionVectors.buttonup),
	buttondown: Button.new(actionVec: ActionVectors.buttondown),
	entr: Button.new(actionVec: ActionVectors.buttonEnter, routerVec: RouterVectors.buttonEnter),
	rcl: Button.new(actionVec: ActionVectors.buttonRecall, routerVec: RouterVectors.buttonRecall),
	wx: Button.new(actionVec: ActionVectors.buttonWX),
	flirUD: Button.new(actionVec: ActionVectors.buttonFUD),
};

setlistener("f16/avionics/rtn-seq", func() {
	if (getprop("f16/avionics/rtn-seq") == -1) {
		if (size(dataEntryDisplay.page.vector) != 0) {
			dataEntryDisplay.page.vector[dataEntryDisplay.page.selectedIndex()].reset();
		}
		dataEntryDisplay.page = pCNI;
	} elsif (getprop("f16/avionics/rtn-seq") == 1) {

		if (dataEntryDisplay.page == pIFF1) {
			if (size(dataEntryDisplay.page.vector) != 0) {
				dataEntryDisplay.page.vector[dataEntryDisplay.page.selectedIndex()].reset();
			}
			dataEntryDisplay.page = pIFF2;
			return;
		}
		if (dataEntryDisplay.page == pIFF2) {
			if (size(dataEntryDisplay.page.vector) != 0) {
				dataEntryDisplay.page.vector[dataEntryDisplay.page.selectedIndex()].reset();
			}
			dataEntryDisplay.page = pIFF3;
			return;
		}
		if (dataEntryDisplay.page == pIFF3) {
			if (size(dataEntryDisplay.page.vector) != 0) {
				dataEntryDisplay.page.vector[dataEntryDisplay.page.selectedIndex()].reset();
			}
			dataEntryDisplay.page = pIFF1;
			return;
		}

		if (dataEntryDisplay.page == pCNI) {
			dataEntryDisplay.CNIshowWind = !dataEntryDisplay.CNIshowWind;
			return;
		}

		if (dataEntryDisplay.page == pCOMM1) {
			dataEntryDisplay.Comm1page = !dataEntryDisplay.Comm1page;
			return;
		}

		if (dataEntryDisplay.page == pCOMM2) {
			dataEntryDisplay.Comm2page = !dataEntryDisplay.Comm2page;
			return;
		}

		if (dataEntryDisplay.page == pTACAN) {
			toggleTACANMode();
			return;
		}

		if (dataEntryDisplay.page == pNAV) {
			dataEntryDisplay.NAVpage = !dataEntryDisplay.NAVpage;
			return;
		}

		if (dataEntryDisplay.page == pINS) {
			dataEntryDisplay.INSpage = !dataEntryDisplay.INSpage;
			return;
		}

		if (dataEntryDisplay.page == pOFP) {
			dataEntryDisplay.OFPpage = dataEntryDisplay.OFPpage + 1;
			if (dataEntryDisplay.OFPpage == 4) {
				dataEntryDisplay.OFPpage = 0;
			}
			return;
		}

		if (dataEntryDisplay.page == pVIP) {
			dataEntryDisplay.VIPpage = !dataEntryDisplay.VIPpage;
			return;
		}

		if (dataEntryDisplay.page == pVRP) {
			dataEntryDisplay.VRPpage = !dataEntryDisplay.VRPpage;
			return;
		}

		if (dataEntryDisplay.page == pHMCS) {
			dataEntryDisplay.HMCSpage = !dataEntryDisplay.HMCSpage;
			return;
		}

		if (dataEntryDisplay.page == pGPS and getprop("f16/avionics/power-gps")) {
			dataEntryDisplay.GPSpage = !dataEntryDisplay.GPSpage;
			return;
		}

		if (dataEntryDisplay.page == pHARM) {
			dataEntryDisplay.harmTablePage += 1;
			if (dataEntryDisplay.harmTablePage >= 3) dataEntryDisplay.harmTablePage = 0;
			return;
		}

		if (dataEntryDisplay.page == pCRUS and CRUSmodeTF.selected) {
		    CRUSmodeTF.sequence();
		    #if (dataEntryDisplay.crusMode == "TOS") {
			#	dataEntryDisplay.crusMode = "RNG";
			#} elsif (dataEntryDisplay.crusMode == "RNG") {
			#	dataEntryDisplay.crusMode = "HOME";
			#} elsif (dataEntryDisplay.crusMode == "HOME") {
			#	dataEntryDisplay.crusMode = "EDR";
			#} elsif (dataEntryDisplay.crusMode == "EDR") {
			#} else {
			#	dataEntryDisplay.crusMode = "TOS";
			#}
		}

		#if (dataEntryDisplay.page == pMARK and dataEntryDisplay.markModeSelected) {
		#	if (dataEntryDisplay.markMode == "OFLY") {
		#		dataEntryDisplay.markMode = "FCR";
		#	} elsif (dataEntryDisplay.markMode == "FCR") {
		#		dataEntryDisplay.markMode = "HUD";
		#	} else {
		#		dataEntryDisplay.markMode = "OFLY";
		#	}
		#	return;
		#}

		if (dataEntryDisplay.page == pFIX and dataEntryDisplay.fixTakingModeSelected) {
			if (dataEntryDisplay.fixTakingMode == "OFLY") {
				dataEntryDisplay.fixTakingMode = "FCR";
			} elsif (dataEntryDisplay.fixTakingMode == "FCR") {
				dataEntryDisplay.fixTakingMode = "HUD";
			} else {
				dataEntryDisplay.fixTakingMode = "OFLY";
			}
			return;
		}

		if (dataEntryDisplay.page == pACAL and dataEntryDisplay.acalModeSelected) {
			if (dataEntryDisplay.acalMode == " GPS") {
				dataEntryDisplay.acalMode = " DTS";
			} elsif (dataEntryDisplay.acalMode == " DTS") {
				dataEntryDisplay.acalMode = "BOTH";
			} else {
				dataEntryDisplay.acalMode = " GPS";
			}
			return;
		}
	}
}, 0, 0);

setlistener("f16/avionics/ded-up-down", func() {
	if (size(dataEntryDisplay.page.vector) != 0) {
		dataEntryDisplay.page.vector[dataEntryDisplay.page.selectedIndex()].reset();
	}

	if (getprop("f16/avionics/ded-up-down") == -1) {
		dataEntryDisplay.page.getNext();
	} elsif (getprop("f16/avionics/ded-up-down") == 1) {
		dataEntryDisplay.page.getPrev();
	}
}, 0, 0);
