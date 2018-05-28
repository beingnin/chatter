<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Messenger.aspx.cs" Inherits="WebApplication2.App.Messenger" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Messenger</title>
    <link rel="stylesheet" href="Theme/css/style.css" />
    <link href='http://fonts.googleapis.com/css?family=Open+Sans:400,600,700' rel='stylesheet' type='text/css' />
</head>
<body style="background: #232020">
    <form id="form1" runat="server">
        <div>
            <div id="chatbox">
                <div id="friendslist">
                    <div id="topmenu">
                        <span class="friends"></span>
                        <span class="chats"></span>
                        <span class="history"></span>
                    </div>

                    <div id="friends">
                        <%--                        <div class="friend">
                            <img src="https://s3-us-west-2.amazonaws.com/s.cdpn.io/245657/1_copy.jpg" />
                            <p>
                                <strong>Miro Badev</strong>
                                <span>mirobadev@gmail.com</span>
                            </p>
                            <div class="status available"></div>
                        </div>

                        <div class="friend">
                            <img src="https://s3-us-west-2.amazonaws.com/s.cdpn.io/245657/2_copy.jpg" />
                            <p>
                                <strong>Martin Joseph</strong>
                                <span>marjoseph@gmail.com</span>
                            </p>
                            <div class="status away"></div>
                        </div>

                        <div class="friend">
                            <img src="https://s3-us-west-2.amazonaws.com/s.cdpn.io/245657/3_copy.jpg" />
                            <p>
                                <strong>Tomas Kennedy</strong>
                                <span>tomaskennedy@gmail.com</span>
                            </p>
                            <div class="status inactive"></div>
                        </div>

                        <div class="friend">
                            <img src="https://s3-us-west-2.amazonaws.com/s.cdpn.io/245657/4_copy.jpg" />
                            <p>
                                <strong>Enrique	Sutton</strong>
                                <span>enriquesutton@gmail.com</span>
                            </p>
                            <div class="status inactive"></div>
                        </div>

                        <div class="friend">
                            <img src="https://s3-us-west-2.amazonaws.com/s.cdpn.io/245657/5_copy.jpg" />
                            <p>
                                <strong>Darnell	Strickland</strong>
                                <span>darnellstrickland@gmail.com</span>
                            </p>
                            <div class="status inactive"></div>
                        </div>--%>

                        <div id="search">
                            <input type="text" id="searchfield" value="Search contacts..." />
                        </div>

                    </div>

                </div>

                <div id="chatview" class="p1">
                    <div id="profile">

                        <div id="close">
                            <div class="cy"></div>
                            <div class="cx"></div>
                        </div>

                        <p id="chatName">--Chatter--</p>
                        <span id="chatDesc">--description--</span>
                    </div>
                    <div id="chat-messages">
                        <%--<label>Thursday 02</label>--%>

                        <%--                    <div class="message">
                            <img src="https://s3-us-west-2.amazonaws.com/s.cdpn.io/245657/1_copy.jpg" />
                            <div class="bubble">
                                Really cool stuff!
                   
                                <div class="corner"></div>
                                <span>3 min</span>
                            </div>
                        </div>

                        <div class="message right">
                            <img src="https://s3-us-west-2.amazonaws.com/s.cdpn.io/245657/2_copy.jpg" />
                            <div class="bubble">
                                Can you share a link for the tutorial?
                   
                                <div class="corner"></div>
                                <span>1 min</span>
                            </div>
                        </div>

                        <div class="message">
                            <img src="https://s3-us-west-2.amazonaws.com/s.cdpn.io/245657/1_copy.jpg" />
                            <div class="bubble">
                                Yeah, hold on
                   
                                <div class="corner"></div>
                                <span>Now</span>
                            </div>
                        </div>

                        <div class="message right">
                            <img src="https://s3-us-west-2.amazonaws.com/s.cdpn.io/245657/2_copy.jpg" />
                            <div class="bubble">
                                Can you share a link for the tutorial?
                   
                                <div class="corner"></div>
                                <span>1 min</span>
                            </div>
                        </div>

                        <div class="message">
                            <img src="https://s3-us-west-2.amazonaws.com/s.cdpn.io/245657/1_copy.jpg" />
                            <div class="bubble">
                                Yeah, hold on
                   
                                <div class="corner"></div>
                                <span>Now</span>
                            </div>
                        </div>--%>
                    </div>

                    <div id="sendmessage">
                        <input autocomplete="off" type="text" value="Send message..." />
                        <button type="button" id="send"></button>
                    </div>

                </div>
                <img id="chatterImage" src="Theme/Images/Defaults/profile_default.jpg" class="floatingImg" style="top: 20px; width: 68px; left: 108px; display: none" />
            </div>
        </div>
    </form>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
    <script>
        $(document).ready(function () {

            RefreshChatList(1);

            $("#searchfield").focus(function () {
                if ($(this).val() == "Search contacts...") {
                    $(this).val("");
                }
            });
            $("#searchfield").focusout(function () {
                if ($(this).val() == "") {
                    $(this).val("Search contacts...");

                }
            });
            $('#searchfield').keyup(function (e) {
                e.preventDefault();
                var email = $(this).val();
                if (e.which == 13 || e.keyCode == 13) {
                    $.ajax({
                        url: '/api/account/get?email=' + email,
                        dataType: 'JSON',
                        method: 'GET',
                        success: function (data) {
                            console.log(data);
                            if (data.Success) {
                                if (data.Data != null) {
                                    var me = 1;
                                    var you = data.Data.ChatterId;
                                    showChat(data.Data.Name, data.Data.Email, you, me);

                                }
                            }
                        },
                        error: function (xhr) {
                            console.log(xhr);
                        }
                    });
                }
            });


            //chat list click
            $('.friend').click(function () {

                var name = $(this).find("p strong").html();
                var desc = $(this).find("p span").html();
                showChat(name, desc);
            });



            //show chat function
            function showChat(name, desc, you, me) {
                $.ajax({
                    url: '/api/messenger/getChats?me=' + me + '&you=' + you,
                    method: 'GET',
                    dataType: 'Json',
                    success: function (chats) {
                        console.log(chats);
                        if (chats.Success) {
                            if (chats.Data != null) {
                                var html = '';
                                for (var i = 0; i < chats.Data.length; i++) {
                                    var chat = chats.Data[i];
                                    if (chat.FromId == me) {
                                        html += '<div class="message"><img src="Theme/Images/Defaults/profile_default.jpg" /><div class="bubble">' + chat.Message + '!<div class="corner"></div><span>3 min</span></div></div>';
                                    }
                                    else {
                                        html += '<div class="message right"><img src="Theme/Images/Defaults/profile_default.jpg" /><div class="bubble">' + chat.Message + '<div class="corner"></div><span>3 min</span></div></div>';
                                    }

                                }
                                $('#chat-messages').children().remove();
                                $('#chat-messages').append(html);
                            }
                        }

                        //appending chats



                        setTimeout(function () { $("#profile p").addClass("animate"); $("#profile").addClass("animate"); }, 100);
                        setTimeout(function () {
                            $("#chat-messages").addClass("animate");
                            $('.cx, .cy').addClass('s1');
                            setTimeout(function () { $('.cx, .cy').addClass('s2'); }, 100);
                            setTimeout(function () { $('.cx, .cy').addClass('s3'); }, 200);
                        }, 150);

                        $('.floatingImg').animate({
                            'width': "68px",
                            'left': '108px',
                            'top': '20px'
                        }, 200);

                        //var name = $(obj).find("p strong").html();
                        //var email = $(obj).find("p span").html();
                        $("#profile p").html(name);
                        $("#profile span").html(desc);

                        //$(".message").not(".right").find("img").attr("src", $(clone).attr("src"));
                        $('#friendslist').fadeOut();
                        $('#chatview').fadeIn();
                        $('#chatterImage').show();

                        $('#close').unbind("click").click(function () {

                            $("#chat-messages, #profile, #profile p").removeClass("animate");
                            $('.cx, .cy').removeClass("s1 s2 s3");
                            $('.floatingImg').animate({
                                'width': "40px",
                                'top': top,
                                'left': '12px'
                            }, 200, function () { $('#chatterImage').hide(); });

                            setTimeout(function () {
                                $('#chatview').fadeOut();
                                $('#friendslist').fadeIn();
                            }, 50);
                        });
                    },


                });



            }


            //chatlist function
            function RefreshChatList(me) {
                $.ajax({
                    url: '/api/Messenger/ChatList?me=' + me,
                    method: 'GET',
                    dataType: 'JSON',
                    success: function (list) {
                        console.log(list);

                        var html = '';
                        if (list.Success) {
                            if (list.Data != null) {
                                //$('#friends').children().remove();
                                for (var i = 0; i < list.Data.length; i++) {
                                    var chat = list.Data[i];
                                    html += '<div class="friend"><img src="' + chat.ProfileImagePath + '" /><p><strong>' + chat.FirstName + '</strong><span>' + chat.Email + '</span></p><div class="status available"></div></div>';
                                }
                                $('#friends').append(html);
                            }
                        }
                    },
                    error: function (xhr) {
                        console.log(xhr);
                    }

                });
            }
        });
    </script>
</body>
</html>
