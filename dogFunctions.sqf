waitUntil {!isNil "BIS_fnc_init"};
waitUntil {time > 0.1};
_player = player;

// 3rd person view
player switchCamera "External";

// Dog follower
BURK_dogFollowing = true;

// Spawn dog
BURK_dog = createAgent ["Fin_random_F", getPos player, [], 5, "CAN_COLLIDE"];

// Following player
BURK_dogFollowPlayer = {
	BURK_dog setVariable ["BIS_fnc_animalBehaviour_disable", true];
	
	BURK_dogFollowing = true;
	[_player,"whistle"] remoteExec ["life_fnc_say3D",RANY];
	
	0 = [] spawn {
		while {BURK_dogFollowing} do 
		{
			if (alive BURK_dog) then 
			{
				BURK_dog moveTo getPos player;				
				
				sleep 0.5;
			};
		};
	};
};

// Stop following
BURK_dogStopFollowing = {
	BURK_dog setVariable ["BIS_fnc_animalBehaviour_disable", false];
	BURK_dogFollowing = false;

	BURK_dog playMove "Dog_Idle_Stop";	
};

BURK_dogGrawlPlayer = {
[BURK_dog,"dog_growl"] remoteExec ["life_fnc_say3D",RANY];
};

BURK_dogmeanPlayer = {
[_player,"dog_close"] remoteExec ["life_fnc_say3D",RANY];
};

BURK_dogDelete = {

deleteVehicle BURK_dog;	
[BURK_dog,"dog_whine"] remoteExec ["life_fnc_say3D",RANY];
};

// Follow defined path
BURK_dogFollowPath = {
	if (BURK_dogFollowing) then {
		[] call BURK_dogStopFollowing;		
	};
	
	BURK_dog setVariable ["BIS_fnc_animalBehaviour_disable", true];

	while {(BURK_dog distance getMarkerPos "BURK_mrk1") > 1} do 
	{
		if (alive BURK_dog) then 
		{
			BURK_dog moveTo getMarkerPos "BURK_mrk1";				
		};
	};	

	while {(BURK_dog distance getMarkerPos "BURK_mrk2") > 1} do 
	{
		if (alive BURK_dog) then 
		{
			BURK_dog moveTo getMarkerPos "BURK_mrk2";				
		};
	};	

	while {(BURK_dog distance getMarkerPos "BURK_mrk3") > 1} do 
	{
		if (alive BURK_dog) then 
		{
			BURK_dog moveTo getMarkerPos "BURK_mrk3";				
		};
	};	

	while {(BURK_dog distance getMarkerPos "BURK_mrk4") > 1} do 
	{
		if (alive BURK_dog) then 
		{
			BURK_dog moveTo getMarkerPos "BURK_mrk4";				
		};
	};	
	
	BURK_dog playMove "Dog_Idle_Stop";
	
	BURK_dog setVariable ["BIS_fnc_animalBehaviour_disable", true];
};

// Actions for following
player addAction ["Dog: Start following player", {[] call BURK_dogFollowPlayer;}];
player addAction ["Dog: Grawl", {[] call BURK_dogGrawlPlayer;}];
player addAction ["Dog: Be mean", {[] call BURK_dogmeanPlayer;}];
player addAction ["Dog: Stop following", {[] call BURK_dogStopFollowing;}];
player addAction ["Dog: Delete", {[] call BURK_dogDelete;}];
player addAction ["Dog: Follow path (Markers 1 - 2 - 3 - 4)", {[] call BURK_dogFollowPath;}];

// Actions for behaviour override
player addAction ["Dog: Default behaviour", {BURK_dog playMove "Dog_Idle_Stop";}];
player addAction ["Dog: Stop", {BURK_dog playMove "Dog_Stop";}];
player addAction ["Dog: Sit", {BURK_dog playMove "Dog_Sit";}];
player addAction ["Dog: Walk", {BURK_dog playMove "Dog_Walk";}];
player addAction ["Dog: Run", {BURK_dog playMove "Dog_Run";}];
player addAction ["Dog: Sprint", {BURK_dog playMove "Dog_Sprint";}];