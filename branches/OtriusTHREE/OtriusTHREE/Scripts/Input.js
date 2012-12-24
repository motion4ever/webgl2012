﻿///////////////////////////////////////////////////////////////////////
//INPUT VARIABLES
///////////////////////////////////////////////////////////////////////

//Key States
var LeftDown = false;
var RightDown = false;
var UpDown = false;
var DownDown = false;

//KEYS
var KEYS = {
    SPACE: 32,
    LEFT: 37,
    UP: 38,
    RIGHT: 39,
    DOWN: 40,
    P: 80
};

//Key Listeners
window.addEventListener('keydown', doKeyDown, true);
window.addEventListener('keyup', doKeyUp, true);


////////////////////////////////////////////////////////////////////////////
//                        Callbacks
///////////////////////////////////////////////////////////////////////////


function doKeyDown(evt) {
    switch (evt.keyCode) {

        //Should be left arrow key      
        case KEYS.LEFT:
            LeftDown = true;
            break;
            //right      
        case KEYS.RIGHT:
            RightDown = true;
            break;
        case KEYS.UP:
            UpDown = true;
            break;
        case KEYS.DOWN:
            DownDown = true;
            break;
    }
}

function doKeyUp(evt) {
    switch (evt.keyCode) {

        //Should be left arrow key      
        case KEYS.LEFT:
            LeftDown = false;
            break;
            //right      
        case KEYS.RIGHT:
            RightDown = false;
            break;
        case KEYS.UP:
            UpDown = false;
            break;
        case KEYS.DOWN:
            DownDown = false;
            break;
    }
}

/////////////////////////////////////////////////////////////////////
//                      Process Input
////////////////////////////////////////////////////////////////////

function processInput() {

    //Move Paddle if keys are pressed
    if (LeftDown && !RightDown) {
        dae.position.x -= .01;
        dae.rotation.y += .05;
    }
    else if (RightDown && !LeftDown) {
        dae.position.x += .01;
        dae.rotation.y -= .05;
    }
    if (UpDown && !DownDown) {
        dae.position.y += .01;
    }
    else if (DownDown && !UpDown) {
        dae.position.y -= .01;
    }

}
