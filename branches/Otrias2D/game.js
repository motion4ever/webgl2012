var Canvas = document.getElementById("GameCanvas");
var ctx = Canvas.getContext("2d");
document.addEventListener('click', DoClick, false);
document.addEventListener('keydown',ProcessKey,false);

ctx.fillStyle="#333333";

var CanvasWidth = Canvas.width;
var CanvasHeight = Canvas.height;

startGame();

function startGame() {
    intervalID = setInterval(gameLoop, 1000 / 30);
}

function gameLoop(){
    InitFloor();
}
function InitFloor()
{
    var tileheight=20;
    var tilewidth=20;
    var x_numtiles=Math.floor(CanvasHeight/tileheight);
	var y_numtiles=Math.floor(CanvasWidth/tilewidth);
    for (var i=0;i<x_numtiles;i++)
    {	
        for (var j=0;j<y_numtiles;j++)
        {
            ctx.fillRect(i*tileheight+i,j*tilewidth+j,tileheight,tilewidth);
        }
    }
}

function DoClick(click)
{
}
function ProcessKey(key)
{

}