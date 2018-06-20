var canvas = document.getElementById("preview");
var context = canvas.getContext('2d');

canvas.width = 250;
canvas.height = 250;

context.width = canvas.width;
context.height = canvas.height;

var video = document.getElementById("video");

var socket = io();

function logger(msg){
    $('#logger').text(msg);
}

function loadCamera(stream){
    video.src = window.URL.createObjectURL(stream);
    logger("Camera connected");
}

function loadFail(){
    logger("Camera not connected");
}

function viewVideo(video,context){
    context.drawImage(video,0,0,context.width,context.height);
    socket.emit('stream',canvas.toDataURL('image/webp'));
}

$(function(){
    navigator.getUserMedia = ( navigator.getUserMedia || navigator.webkitGetUserMedia || navigator.mozGetUserMedia || navigator.msgGetUserMedia );

    if(navigator.getUserMedia){
        navigator.getUserMedia({video: true, audio: false},loadCamera,loadFail);
    }

    setInterval(function(){
        viewVideo(video,context);
    },5);
});
