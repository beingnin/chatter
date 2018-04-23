<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="forgetter.aspx.cs" Inherits="WebApplication2.forgetter" %>

<!DOCTYPE html>

<html class="w-mod-js w-mod-no-touch w-mod-video w-mod-no-ios w-mod-js w-mod-no-touch w-mod-video w-mod-no-ios wf-montserrat-n4-active wf-montserrat-n7-active wf-active w-mod-js w-mod-no-touch w-mod-video w-mod-ios w-mod-js w-mod-no-touch w-mod-video w-mod-ios" style="">

<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Forgetter</title>

    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no"/>

    <link rel="stylesheet" type="text/css" href="/Theme/Chat/normalize.css"/>
    <link rel="stylesheet" type="text/css" href="/Theme/Chat/framework.css"/>
    <link rel="stylesheet" type="text/css" href="/Theme/Chat/washington.css"/>
    <link rel="stylesheet" href="/Theme/Chat/css"/>
    <%--<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta.2/css/bootstrap.min.css" />--%>
    <link href="https://fonts.googleapis.com/css?family=Oxygen|Ubuntu" rel="stylesheet"/>



    <link href="/Theme/Chat/ionicons.min.css" rel="stylesheet" type="text/css"/>

    <style>
        body{
            font-family:'Ubuntu', sans-serif,'Oxygen', sans-serif;
        }
        .w-lightbox-content,
        .w-lightbox-view,
        .w-lightbox-view:before {
            height: 568px;
        }

        .w-lightbox-view {
            width: 320px;
        }

        .w-lightbox-group,
        .w-lightbox-group .w-lightbox-view,
        .w-lightbox-group .w-lightbox-view:before {
            height: 488.48px;
        }

        .w-lightbox-image {
            max-width: 320px;
            max-height: 568px;
        }

        .w-lightbox-group .w-lightbox-image {
            max-height: 488.48px;
        }

        .w-lightbox-strip {
            padding: 0 5.68px;
        }

        .w-lightbox-item {
            width: 56.800000000000004px;
            padding: 11.36px 5.68px;
        }

        .w-lightbox-thumbnail {
            height: 56.800000000000004px;
        }

        @media (min-width: 768px) {
            .w-lightbox-content,
            .w-lightbox-view,
            .w-lightbox-view:before {
                height: 545.28px;
            }

            .w-lightbox-content {
                margin-top: 11.36px;
            }

            .w-lightbox-group,
            .w-lightbox-group .w-lightbox-view,
            .w-lightbox-group .w-lightbox-view:before {
                height: 477.12px;
            }

            .w-lightbox-image {
                max-width: 307.2px;
                max-height: 545.28px;
            }

            .w-lightbox-group .w-lightbox-image {
                max-width: 263.36px;
                max-height: 477.12px;
            }
        }
    </style>
    <style>
        .w-lightbox-content,
        .w-lightbox-view,
        .w-lightbox-view:before {
            height: 568px;
        }

        .w-lightbox-view {
            width: 320px;
        }

        .w-lightbox-group,
        .w-lightbox-group .w-lightbox-view,
        .w-lightbox-group .w-lightbox-view:before {
            height: 488.48px;
        }

        .w-lightbox-image {
            max-width: 320px;
            max-height: 568px;
        }

        .w-lightbox-group .w-lightbox-image {
            max-height: 488.48px;
        }

        .w-lightbox-strip {
            padding: 0 5.68px;
        }

        .w-lightbox-item {
            width: 56.800000000000004px;
            padding: 11.36px 5.68px;
        }

        .w-lightbox-thumbnail {
            height: 56.800000000000004px;
        }

        @media (min-width: 768px) {
            .w-lightbox-content,
            .w-lightbox-view,
            .w-lightbox-view:before {
                height: 545.28px;
            }

            .w-lightbox-content {
                margin-top: 11.36px;
            }

            .w-lightbox-group,
            .w-lightbox-group .w-lightbox-view,
            .w-lightbox-group .w-lightbox-view:before {
                height: 477.12px;
            }

            .w-lightbox-image {
                max-width: 307.2px;
                max-height: 545.28px;
            }

            .w-lightbox-group .w-lightbox-image {
                max-width: 263.36px;
                max-height: 477.12px;
            }
        }


        .new-chat {
    position: absolute;
    height: 100%;
    width: 100%;
    z-index: 999999;
    background-color: #CFD8DC;
}
        .new-chat-wrap {
    height: 40%;
    width: 100%;
    position: absolute;
    top: 50%;
    text-align:center;
    transform: translateY(-50%;
    );
}
            .new-chat-wrap input {
        width: 90%;
        border: none;
        height: 40px;
        font-size: 18px;
        outline: none;
        padding: 4px 10px;
        margin-bottom: 15px;
        border-radius: 7px;
        opacity: .7;
    }

        .new-chat-wrap input:focus {
            opacity: 1;
        }

    .new-chat-wrap button {
        width: 60%;
        border: none;
        height: 40px;
        font-size: 18px;
        outline: none;
        padding: 4px 10px;
        background-color: #37474F;
        color: #ccc;
        border-radius: 5px;
        font-size: 20px;
    }
    </style>
</head>

<body>
    <form runat="server"
>  <section class="w-section mobile-wrapper" style="width: 100%; height: 568px;">
        <div class="page-content" id="main-stack">

            <%--Register User--%>
            <div class="new-chat" style="display: none">
                <div class="text-center new-chat-wrap">
                    <input id="chatter" type="text" placeholder="Enter Your Name" />
                    <button id="setChatter" type="button">Start Chatting</button>
                </div>

            </div>

            <div class="w-nav navbar" style="background-color:#4e4747;color:#4fd2c2" data-collapse="all" data-animation="over-left" data-duration="400" data-contain="1" data-easing="ease-out-quint" data-no-scroll="1">
                <div class="w-container">
                    <%--<div class="wrapper-mask" data-ix="menu-mask" style="opacity: 0;"></div>--%>
                    <div class="navbar-title">Chat, then forget</div>
<%--                    <a class="w-inline-block navbar-button" href="#" data-load="1">
                        <div class="navbar-button-icon icon ion-ios-arrow-thin-left"></div>
                    </a>--%>
<%--                    <div class="dropdown dropdown show">

                    <a class="w-inline-block navbar-button right  dropdown-toggle" href="#" data-ix="search-box">
                        <div class="navbar-button-icon smaller icon ion-ios-gear-outline" data-load="1"></div>
                    </a>
                          <div class="dropdown-menu" aria-labelledby="dropdownMenuLink">
    <a class="dropdown-item" href="#">Action</a>
    <a class="dropdown-item" href="#">Another action</a>
    <a class="dropdown-item" href="#">Something else here</a>
  </div>
                    </div>--%>
                </div>
                <div class="w-nav-overlay" data-wf-ignore=""></div>
            </div>
            <div class="body" id="chatBody">
                <ul  id="chatContainer" class="list list-chats">
                   <%-- <li class="w-clearfix list-chat" data-ix="list-item" style="opacity: 1; transform: translateX(0px) translateY(0px); transition: opacity 500ms cubic-bezier(0.23, 1, 0.32, 1), transform 500ms cubic-bezier(0.23, 1, 0.32, 1);">
                        <div class="column-left chat">
                            <div class="image-message chat">
                                <img src="/Theme/Chat/128 (4).jpg"></div>
                        </div>
                        <div class="w-clearfix column-right chat">
                            <div class="arrow-globe"></div>
                            <div class="chat-text">Yesterday I went to see Mike, he has just arrived to the city he is a cool dude! you will meet him soon...</div>
                            <div class="chat-time">3 mins ago</div>
                        </div>
                    </li>
                    <li class="list-chat right" data-ix="list-item" style="opacity: 1; transform: translateX(0px) translateY(0px); transition: opacity 500ms cubic-bezier(0.23, 1, 0.32, 1), transform 500ms cubic-bezier(0.23, 1, 0.32, 1);">
                        <div class="w-clearfix column-right chat right">
                            <div class="arrow-globe right"></div>
                            <div class="chat-text right">Great! how was it? what did you do?</div>
                            <div class="chat-time right">3 min ago</div>
                        </div>
                    </li>
                    <li class="w-clearfix list-chat" data-ix="list-item" style="opacity: 1; transform: translateX(0px) translateY(0px); transition: opacity 500ms cubic-bezier(0.23, 1, 0.32, 1), transform 500ms cubic-bezier(0.23, 1, 0.32, 1);">
                        <div class="column-left chat">
                            <div class="image-message chat">
                                <img src="/Theme/Chat/128 (4).jpg"></div>
                        </div>
                        <div class="w-clearfix column-right chat">
                            <div class="arrow-globe"></div>
                            <div class="chat-text">I went to his brother’s house.</div>
                            <div class="chat-time">1 min ago</div>
                        </div>
                    </li>
                    <li class="list-chat right" data-ix="list-item" style="opacity: 1; transform: translateX(0px) translateY(0px); transition: opacity 500ms cubic-bezier(0.23, 1, 0.32, 1), transform 500ms cubic-bezier(0.23, 1, 0.32, 1);">
                        <div class="w-clearfix column-right chat right">
                            <div class="arrow-globe right"></div>
                            <div class="chat-text right">Oh my god!</div>
                            <div class="chat-time right">50 sec ago</div>
                        </div>
                    </li>
                    <li class="w-clearfix list-chat" data-ix="list-item" style="opacity: 1; transform: translateX(0px) translateY(0px); transition: opacity 500ms cubic-bezier(0.23, 1, 0.32, 1), transform 500ms cubic-bezier(0.23, 1, 0.32, 1);">
                        <div class="column-left chat">
                            <div class="image-message chat">
                                <img src="/Theme/Chat/128 (4).jpg"></div>
                        </div>
                        <div class="w-clearfix column-right chat">
                            <div class="arrow-globe"></div>
                            <div class="chat-text">it was great, we had so much fun playing some games.</div>
                            <div class="chat-time">30 sec ago</div>
                        </div>
                    </li>
                    <li class="list-chat right" data-ix="list-item" style="opacity: 1; transform: translateX(0px) translateY(0px); transition: opacity 500ms cubic-bezier(0.23, 1, 0.32, 1), transform 500ms cubic-bezier(0.23, 1, 0.32, 1);">
                        <div class="w-clearfix column-right chat right">
                            <div class="arrow-globe right"></div>
                            <div class="chat-text right">douh! what sort of games...?</div>
                            <div class="chat-time right">20 sec ago</div>
                        </div>
                    </li>
                    <li class="list-chat right" data-ix="list-item" style="opacity: 1; transform: translateX(0px) translateY(0px); transition: opacity 500ms cubic-bezier(0.23, 1, 0.32, 1), transform 500ms cubic-bezier(0.23, 1, 0.32, 1);">
                        <div class="w-clearfix column-right chat right">
                            <div class="arrow-globe right"></div>
                            <div class="chat-text right">I mean...</div>
                            <div class="chat-time right">15 sec ago</div>
                        </div>
                    </li>
                    <li class="w-clearfix list-chat" data-ix="list-item" style="opacity: 1; transform: translateX(0px) translateY(0px); transition: opacity 500ms cubic-bezier(0.23, 1, 0.32, 1), transform 500ms cubic-bezier(0.23, 1, 0.32, 1);">
                        <div class="column-left chat">
                            <div class="image-message chat">
                                <img src="/Theme/Chat/128 (4).jpg"></div>
                        </div>
                        <div class="w-clearfix column-right chat">
                            <div class="arrow-globe"></div>
                            <div class="chat-text">We played COD 3 and Batelfield, it was a proper war mate! hahah</div>
                            <div class="chat-time">7 sec ago</div>
                        </div>
                    </li>
                    <li class="list-chat right" data-ix="list-item" style="opacity: 1; transform: translateX(0px) translateY(0px); transition: opacity 500ms cubic-bezier(0.23, 1, 0.32, 1), transform 500ms cubic-bezier(0.23, 1, 0.32, 1);">
                        <div class="w-clearfix column-right chat right">
                            <div class="arrow-globe right"></div>
                            <div class="chat-text right">oh!! cool!</div>
                            <div class="chat-time right">just now</div>
                        </div>
                    </li>--%>
                </ul>
            </div>
            <div class="input-chat-block">
                <div class="w-form">
                   
                        <input class="w-input input-chat" id="msg" autocomplete="off" type="text" placeholder="Type message..."  required="required"/>
                        <input id="send" class="w-button chat-button" type="button" value="Send" data-wait="Please wait..."/>
                 
                    <div class="w-form-done">
                        <p>Thank you! Your submission has been received!</p>
                    </div>
                    <div class="w-form-fail">
                        <p>Oops! Something went wrong while submitting the form</p>
                    </div>
                </div>
            </div>
        </div>
        <div class="page-content loading-mask stop-loading" id="new-stack">
            <div class="loading-icon">
                <div class="navbar-button-icon icon ion-load-d"></div>
            </div>
        </div>
        <div class="shadow-layer"></div>
    </section>
        </form>  
</body>
    
<script src="Scripts/jquery-1.10.2.min.js"></script>
<script src="Scripts/jquery.signalR-2.2.2.min.js"></script>
<script src="../signalr/hubs" type="text/javascript"></script>
<script src="Scripts/jquery.cookie.js"></script>

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
        Message.client.addMessage = function (message, user) {
            var time = formatAMPM(new Date);
            $('#chatContainer').append('<li class="w-clearfix list-chat" data-ix="list-item" style="opacity: 1; transform: translateX(0px) translateY(0px); transition: opacity 500ms cubic-bezier(0.23, 1, 0.32, 1), transform 500ms cubic-bezier(0.23, 1, 0.32, 1);"><div class="column-left chat"><div class="image-message chat"> <img src="/Theme/Chat/128 (4).jpg"></div></div><div class="w-clearfix column-right chat"><div class="arrow-globe"></div><div class="chat-text">' + message + '</div><div class="chat-time"><strong>' + user + '</strong>&nbsp;|&nbsp;' + time + '</div></div></li>').fadeIn('slow');
            $(window).scrollTop(999999999999999);
            //$('#chatContainer').scrollTop($('#chatContainer')[0].scrollHeight);
        }
        Message.client.selfMessage = function (message, user) {
            var time = formatAMPM(new Date);
            $('#chatContainer').append('<li class="list-chat right" data-ix="list-item" style="opacity: 1; transform: translateX(0px) translateY(0px); transition: opacity 500ms cubic-bezier(0.23, 1, 0.32, 1), transform 500ms cubic-bezier(0.23, 1, 0.32, 1);"><div class="w-clearfix column-right chat right"><div class="arrow-globe right"></div><div class="chat-text right">' + message + '?</div><div class="chat-time right"><strong>Myself</strong>&nbsp;|&nbsp;' + time + '</div></div></li>').fadeIn('slow');
            $(window).scrollTop(999999999999999);
            //$('#chatContainer').scrollTop($('#chatContainer')[0].scrollHeight);
        }
        $('#msg').keyup(function (e) {
            if (e.which == 13 || e.keyCode == 13) {
                e.preventDefault();
                Message.server.send($('#msg').val(), $.cookie('chatter'));
                $(this).val('')
            }
        });
        $('#send').click(function (e) {


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
</html>
