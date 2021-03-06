
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

$('#btn_leftA').on("click", function(){sendUnit(leftPlayer, $.extend(true, {},leftPlayer.types['robotType']),blueRobotSprite);});
$('#btn_rightA').on("click", function(){sendUnit(rightPlayer, $.extend(true,{}, rightPlayer.types['robotType']),pinkRobotSprite);});
$('#btn_leftB').on("click", function(){sendUnit(leftPlayer, $.extend(true,{},leftPlayer.types['archerType']),archerSprite);});
$('#btn_rightB').on("click", function(){sendUnit(rightPlayer, $.extend(true,{}, rightPlayer.types['archerType']), archer2Sprite);});

$('#btn_start').on("click", start);
////////////////////////////////////////////////////////////////////////////
//                        Callbacks
///////////////////////////////////////////////////////////////////////////

function doKeyDown(evt) {
    switch (evt.keyCode) {     
        case KEYS.LEFT:
			sendUnit(leftPlayer, $.extend(true, {},leftPlayer.types['robotType']),blueRobotSprite);
            break;    
        case KEYS.RIGHT:
			sendUnit(rightPlayer, $.extend(true,{}, rightPlayer.types['robotType']),pinkRobotSprite);
			break;
        case KEYS.SPACE:
            start();
            break;
        case KEYS.UP:
            sendUnit(leftPlayer, $.extend(true,{},leftPlayer.types['archerType']),archerSprite);
            break;
        case KEYS.DOWN:
            sendUnit(rightPlayer, $.extend(true,{}, rightPlayer.types['archerType']), archer2Sprite);
            break;
        case KEYS.P:
            if (game.isPaused == true) {
                game.isPaused = false;
                startGame();
            }
            else {
                game.isPaused = true;
            }
            break;
    }
}
///////////////////////////////////////////////////////////////
//Methods that do the work of input
//////////////////////////////////////////////////////////////
//this should really be sendunit(type), but we'll get there.
function sendUnit(player,type,sprite){
    if(player.money >= type.cost)
    {
        player.units.push(new Unit(type,sprite,player.baseX,player.baseY, ++unitCount))
        player.money -= type.cost;
    }
}
function start(){
    if(!game.isGameActive)
    {
        preinit();
        startGame();
        game.isGameActive = true;
    }
}

