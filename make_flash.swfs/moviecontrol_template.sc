#=============================================
# A swf moviecontrol template 
#=============================================

#**************************************************************
# Author: Patrick Brockmann
# Contact: Patrick.Brockmann@cea.fr
# $Date: 2011/09/07 15:03:56 $
# $Name: FAST_672_1_0 $
# $Revision: 1.1.1.5 $
# History:
# Modification:
#  - 08/04/2008 Add direction controls (Forward, Rocking, Backward)
#
#**************************************************************

.flash bbox=autocrop version=6 filename="O1O1" compress background=#FFFFFF

#---------------------------------------------
# Define and place objects
#---------------------------------------------
.font myfont "MAKE_FLASHDIR/VeraBd.swf"

.box button_idle width=60 height=25 color=#222222 fill=#666666 line=3
.box button_hover width=60 height=25 color=#FF0000 fill=#666666 line=3
.box button_pressed width=60 height=25 color=#666666 fill=#666666 line=3

.button button_play
	.show button_idle as=idle
	.show button_idle as=shape
	.show button_idle as=area
	.show button_hover as=hover
	.show button_pressed as=pressed
	.on_press:
		MovieCtrl_play();
	.end
.end
.button button_stop
	.show button_idle as=shape
	.show button_idle as=area
	.show button_hover as=hover
	.show button_pressed as=pressed
	.on_press:
		MovieCtrl_stop();
	.end
.end
.button button_next
	.show button_idle as=shape
	.show button_idle as=area
	.show button_hover as=hover
	.show button_pressed as=pressed
	.on_press:
		MovieCtrl_next();
	.end
.end
.button button_goto
	.show button_idle as=shape
	.show button_idle as=area
	.show button_hover as=hover
	.show button_pressed as=pressed
	.on_press:
		MovieCtrl_goto();
	.end
.end
.button button_prev
	.show button_idle as=shape
	.show button_idle as=area
	.show button_hover as=hover
	.show button_pressed as=pressed
	.on_press:
		MovieCtrl_prev();
	.end
.end
.button button_first
	.show button_idle as=shape
	.show button_idle as=area
	.show button_hover as=hover
	.show button_pressed as=pressed
	.on_press:
		MovieCtrl_first();
	.end
.end
.button button_last
	.show button_idle as=shape
	.show button_idle as=area
	.show button_hover as=hover
	.show button_pressed as=pressed
	.on_press:
		MovieCtrl_last();
	.end
.end
.button button_slow
        .show button_idle as=shape
        .show button_idle as=area
        .show button_hover as=hover
        .show button_pressed as=pressed
        .on_press:
        	MovieCtrl_slower();
        .end
.end
.button button_fast
        .show button_idle as=shape
        .show button_idle as=area
        .show button_hover as=hover
        .show button_pressed as=pressed
        .on_press:
        	MovieCtrl_faster();
        .end
.end
.button button_direction
        .show button_idle as=shape
        .show button_idle as=area
        .show button_hover as=hover
        .show button_pressed as=pressed
        .on_press:
        	MovieCtrl_direction();
        .end
.end

.box swf_frame width=W1W1 height=H1H1 color=#000000 fill=#FFFFFF line=3
.put swf_frame x=0 y=0 

#--------------------
.text text_goto font=myfont text="Goto" color=black size=15%
.put button_goto pin=center x=40 BY1BY1
.put text_goto pin=center x=40 BY1BY1
.edittext text_info font=myfont text="####" color=black size=15% width=60 height=25 border variable=text_info_var
.put text_info pin=center x=105 BY1BY1
.text text_prev font=myfont text="Prev" color=black size=15%
.put button_prev pin=center x=170 BY1BY1
.put text_prev pin=center x=170 BY1BY1
.text text_first font=myfont text="First" color=black size=15%
.put button_first pin=center x=235 BY1BY1
.put text_first pin=center x=235 BY1BY1
.text text_slow font=myfont text="Slower" color=black size=15%
.put button_slow pin=center x=300 BY1BY1
.put text_slow pin=center x=300 BY1BY1

.text text_play font=myfont text="Play" color=black size=15%
.put button_play pin=center x=40 y=BY2BY2
.put text_play pin=center x=40 y=BY2BY2
.text text_stop font=myfont text="Stop" color=black size=15%
.put button_stop pin=center x=105 y=BY2BY2
.put text_stop pin=center x=105 y=BY2BY2
.text text_next font=myfont text="Next" color=black size=15%
.put button_next pin=center x=170 y=BY2BY2
.put text_next pin=center x=170 y=BY2BY2
.text text_last font=myfont text="Last" color=black size=15%
.put button_last pin=center x=235 y=BY2BY2
.put text_last pin=center x=235 y=BY2BY2
.text text_fast font=myfont text="Faster" color=black size=15%
.put button_fast pin=center x=300 y=BY2BY2
.put text_fast pin=center x=300 y=BY2BY2

#--------------------
.text text_direction_forward font=myfont text="Forward" color=black size=15%
.text text_direction_rocking font=myfont text="Rocking" color=black size=15%
.text text_direction_backward font=myfont text="Backward" color=black size=15%
.put button_direction pin=center x=365 BY1BY1

.sprite display_text_direction_forward 
.put text_direction_forward pin=center x=365 BY1BY1
.end

.sprite display_text_direction_rocking 
.put text_direction_rocking pin=center x=365 BY1BY1
.end

.sprite display_text_direction_backward 
.put text_direction_backward pin=center x=365 BY1BY1
.end

#--------------------
LG1LG1.swf logo filename="LG2LG2" 
LG1LG1.put logo scale=40% pin=center x=LX1LX1 y=LY1LY1 

.text text_copyright font=myfont text="T3T3" color=black size=15% 
.put text_copyright x=10 y=LY2LY2 

.text text_title1 font=myfont text="T1T1" color=black size=25% 
.put text_title1 x=10 y=25 
.text text_title2 font=myfont text="T2T2" color=black size=25% 
.put text_title2 x=10 y=45 

S1S1.box movie_shadow width=W0W0 height=H0H0 fill=#666666 
S1S1.put movie_shadow x=15 y=65

.swf movie filename="I1I1" 
.put movie x=10 y=60 scale=100% 

#---------------------------------------------
# ActionScript
#---------------------------------------------

.action:

interval = IIIIII;

var monStyle = new TextFormat();
monStyle.align =  "center";
monstyle.size = 15;
text_info.setnewTextFormat(monStyle);
deltaframe = 1;

function ChangeButtonToForward() {
	_root.createEmptyMovieClip("Clip1",100);
	_root.attachMovie("display_text_direction_forward","Clip1",100);
	direction = "Forward";
}
function ChangeButtonToRocking() {
	_root.createEmptyMovieClip("Clip1",100);
	_root.attachMovie("display_text_direction_rocking","Clip1",100);
	direction = "Rocking";
}    
function ChangeButtonToBackward() {
	_root.createEmptyMovieClip("Clip1",100);
	_root.attachMovie("display_text_direction_backward","Clip1",100);
	direction = "Backward";
}
function MovieController(interval) {
	clearInterval(animID);
	animID=setInterval(DisplayFrame, interval);
        }
function UpdateCounter() {
        text_info_var = movie._currentframe;
        }
function DisplayFrame() {
	switch (direction) {
	 case "Forward" :
		if (movie._currentframe == movie._totalframes) {
			movie.gotoAndStop(1); }
		else {
			movie.gotoAndStop(movie._currentframe+1); }
		break;
	 case "Rocking" :
		if (movie._currentframe == movie._totalframes) { 
			deltaframe = -1; }
		if (movie._currentframe == 1) {
			deltaframe = 1; }
		movie.gotoAndStop(movie._currentframe+deltaframe);
		break;
	 case "Backward" :
		if (movie._currentframe == 1) {
			movie.gotoAndStop(movie._totalframes); }
		else {
			movie.gotoAndStop(movie._currentframe-1); }
		break;
	}
	UpdateCounter();
        }
function MovieCtrl_play() {
	MovieController(interval);
        }
function MovieCtrl_stop() {
	clearInterval(animID);
	movie.stop(); 
        }
function MovieCtrl_next() {
	clearInterval(animID);
        movie.nextframe();
	UpdateCounter();
        }
function MovieCtrl_goto() {
	clearInterval(animID);
        movie.gotoAndstop(text_info_var);
	UpdateCounter();
        }
function MovieCtrl_prev() {
	clearInterval(animID);
        movie.prevframe();
	UpdateCounter();
        }
function MovieCtrl_first() {
	clearInterval(animID);
        movie.gotoAndstop(1);
	UpdateCounter();
        }
function MovieCtrl_last() {
	clearInterval(animID);
        movie.gotoAndstop(movie._totalframes);
	UpdateCounter();
        }
function MovieCtrl_slower() {
        if (interval < 1000) {
        	interval=int(2*interval);
	}
	MovieController(interval);
        }
function MovieCtrl_faster() {
        if (interval > 1) {
           interval=int(interval/2);
        }
	MovieController(interval);
        }
function MovieCtrl_direction() {
	switch (direction) {
	 case "Forward" :
		ChangeButtonToRocking();
		break;
	 case "Rocking" :
		ChangeButtonToBackward();
		break;
	 case "Backward" :
		ChangeButtonToForward();
		break;
	}
        }

ChangeButtonToForward();
movie.stop();
UpdateCounter();

.end

#=============================================
.end # End swf movie
