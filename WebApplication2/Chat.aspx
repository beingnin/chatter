<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Chat.aspx.cs" Inherits="WebApplication2.Chat" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">

    <title>M-Link Chat</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <script src="Scripts/jquery-1.10.2.min.js"></script>
    <script src="Scripts/jquery.signalR-2.2.2.min.js"></script>
    <script src="../signalr/hubs" type="text/javascript"></script>
    <link href="https://fonts.googleapis.com/css?family=Dosis|Open+Sans" rel="stylesheet"/>
    <script src="Scripts/jquery.cookie.js"></script>
    <link href="style.css?v=0.0.1" rel="stylesheet" />

</head>
<body>
    <form id="form1" runat="server">


        <div class="main-wrapper">
		<div class="new-chat" style="display: none">
			<div class="text-center new-chat-wrap">
				<input id="chatter" type="text" placeholder="Enter Your Name"/>
				<button  id="setChatter" type="button">Start Chatting</button>
			</div>
			
		</div>
		<div class="chatbox-header">
			<h1>Forgetter</h1>
            <img src="icon.svg" />
		</div>
		<div id="chatContainer" class="chatbox-body">

		</div>
		<div class="chatbox-wrap">
			<input class="chat-input" id="msg" placeholder="Type message.." autocomplete="off" type="text" />
			<button id="send" type="button" class="send-msg">
                <img src="send.svg" />
			</button>
		</div>
	</div>
    </form>
        <script>
            $(document).ready(function () {
                var isConnected = false;
                var Message = $.connection.chat;
                //getting the name of chatter if not set
                if ($.cookie('chatter') == undefined || $.cookie('chatter') == null || $.cookie('chatter') == '') {
                    $('.new-chat').fadeIn('slow');
                }
                else {
                    $('.new-chat').fadeOut('slow');
                    openConnectionAndRun(function () {
                        Message.server.newChatter($.cookie('chatter'));
                    });
                }
                $('#setChatter').click(function () {
                    if ($('#chatter').val() !== '') {
                        $.cookie("chatter", $('#chatter').val(), { expires: 7 });
                        $('.new-chat').fadeOut('slow');
                        openConnectionAndRun(function () {
                            Message.server.newChatter($.cookie('chatter'));
                        });
                        
                    }
                
                });
                $('#chatter').off().keyup(function (e) {
                    if (e.which == 13 || e.keyCode == 13) {
                        if ($('#chatter').val() !== '') {
                            var chatter = $('#chatter').val();
                            $.cookie("chatter", chatter, { expires: 7 });
                            $('.new-chat').fadeOut('slow');
                        }
                        openConnectionAndRun(function () {
                            Message.server.newChatter($.cookie('chatter'));
                        });
                    }
                });
                //getting the name of chatter ends here
            
             

                Message.client.newChatterOnline = function (names) {
                console.log(names);
                }
                Message.client.removeChatterOnline = function (names) {
                    console.log(names);
                }
            Message.client.addMessage = function (message,user) {
                var time = formatAMPM(new Date);
                $('#chatContainer').append('<div class="chat from"><span class="chat-avatar">'+user.substr(0,2).toUpperCase()+'</span><span class="chatter">' + user + '</span><p >' + message + '</p></div>').fadeIn('slow');
                $('#chatContainer').scrollTop($('#chatContainer')[0].scrollHeight);
            }
            Message.client.selfMessage = function (message,user) {
                var time = formatAMPM(new Date);
                $('#chatContainer').append('<div class="chat to"><span class="chat-avatar">' + user.substr(0, 2).toUpperCase() + '</span><span class="chatter">Me</span><p >' + message + '</p></div>').fadeIn('slow');
                $('#chatContainer').scrollTop($('#chatContainer')[0].scrollHeight);
            }
            $('#msg').keyup(function (e) {
                if (e.which == 13 || e.keyCode == 13) {
                    e.preventDefault();
                    Message.server.send($('#msg').val(), $.cookie('chatter'));
                    $(this).val('')
                }
            });
            $('#send').click(function (e){ 
                
                    
                Message.server.send($('#msg').val(), $.cookie('chatter'));
                    $('#msg').val('');
               
            });

            $(window).unload(function () {

                openConnectionAndRun(function () {
                    Message.server.removeChatter($.cookie('chatter'));
                });
            });
            function formatAMPM(date) {
                var hours = date.getHours();
                var minutes = date.getMinutes();
                var ampm = hours >= 12 ? 'pm' : 'am';
                hours = hours % 12;
                hours = hours ? hours : 12; // the hour '0' should be '12'
                minutes = minutes < 10 ? '0' + minutes : minutes;
                var strTime = hours + ':' + minutes + ' ' + ampm;
                return strTime;
            }

            function openConnectionAndRun(callbackFunc) {
                if (!isConnected) {
                    isConnected = true;
                    $.connection.hub.start().done(function () {
                        callbackFunc();
                    });
                }
                else {
                    callbackFunc();
                }
            }

        });
    </script>
</body>
</html>
