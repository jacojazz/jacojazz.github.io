
disableSerialization;

_gmable=player getVariable "GMABLE";If !( [player] call vts_getisGM) then {if (isnil "_gmable") then {killscript=true;breakclic=0;};}; if (killscript) exitwith {killscript=false;};

private ["_source"];

//D?but de script OnmapClick
if  (breakclic <= 1 ) then
{
	clic1 = false;

	_display = finddisplay 8000;
	_txt = _display displayctrl 200;

	_txt CtrlSetText "Left click on the map to select the group";
	_txt CtrlSetTextColor [0.9,0.9,0.9,1];

	Ctrlshow [200,true];sleep 0.2; CtrlShow [200,false];sleep 0.2;Ctrlshow [200,true];

  //R?cuperation des coordonn?es de la carte
	onMapSingleClick "
    spawn_x = _pos select 0;
		spawn_y = _pos select 1;
		spawn_z = _pos select 2;

		clic1 = true;
	   onMapSingleClick """";
     ";
	 
		for "_j" from 10 to 0 step -1 do 
		{
		format["Click On Map %1, or wait for cancellation",_j] spawn vts_gmmessage;
		sleep 1;
		//hint "pause";
		
			//if (_clic1) exitWith {};
			if (clic1) then
			{
				"" spawn vts_gmmessage;
				_j=0;
				clic1 = false;
				_posclick = [spawn_x,spawn_y,spawn_z];
				/*
				_marker_Take = createMarkerLocal ["Nmarker",_posclick];
				_marker_Take setMarkerShapeLocal "ELLIPSE";
				//		_marker_Take setMarkerTypeLocal "mil_Dot";
				_marker_Take setMarkerSizeLocal [25, 25];
				_marker_Take setMarkerDirLocal 0;
				_marker_Take setMarkerColorLocal "Colorred";
				_marker_Take setMarkerAlphaLocal 0.5;
				*/
				
				//******************************
				//***** Code come here *********
				//******************************
				
				//GM or Server side
				_obj = nearestObject [[spawn_x,spawn_y],vts_smallworkdummy];
	    
	      
	      if (isnull _obj) exitwith {breakclic = 0;hint "!!! No task found !!!"};

	      _task = _obj getVariable "task";
	      _side = _obj getVariable "side";
        _txt = _obj getVariable "text";
	      _obj setvariable ["state","Succeeded",true];
	      //player sidechat str _task;
		  _code={};
		  call compile format["
	      _code=
        {
	       _obj = nearestObject [[%1,%2],vts_smallworkdummy];
         _task = _obj getVariable [""task"",nil];
         if !(isnil ""_task"")  then
         {
            _task settaskstate ""Succeeded"";
            [_task] execvm ""functions\fTaskHint.sqf"";
         };
           
        };
		",spawn_x,spawn_y];
        [_code] call vts_broadcastcommand;
				//******************************

      	sleep 0.5;
				deletemarker "Nmarker";
				//clean marker

        if !(isnil "_task")  then {hint format["Task : %1 SUCCEEDED",taskDescription _task select 1];}; 				
			};
			clic1 = false;

	 }; 
		sleep 0.25;
		//"" spawn vts_gmmessage;
		breakclic = 0; 
		//	waitUntil {(clic1)};
};
If (true) ExitWith {};
