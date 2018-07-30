﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Messenger.aspx.cs" Inherits="WebApplication2.App.Messenger" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Messenger</title>
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <link rel="stylesheet" href="Theme/css/style.css" />
    <link href='http://fonts.googleapis.com/css?family=Open+Sans:400,600,700' rel='stylesheet' type='text/css' />
</head>
<body style="background: #d6d9dc">
    <form id="form1" runat="server">
        <div class="chatter-wrap">
            <div id="chatbox">
                <div id="topmenu">
                    <a class="menu" href="#" onclick="switchTab('friendslist')">
                        <img src="Theme/Images/chat-list.png" />
                    </a>
                    <a class="menu" href="#" onclick="switchTab('friendslist')">
                        <img src="Theme/Images/chat.png" />
                    </a>
                    <a class="menu" href="#" onclick="switchTab('chatSettings')">
                        <img src="Theme/Images/user--profile.png" />
                    </a>
                </div>

                <%-- MAIN CHAT SCREEN --%>
                <div id="friendslist" class="tab-content">
                    <div id="friends">
                        <div id="search">
                            <input type="text" autocomplete="off" id="searchfield" placeholder="Search by email address" />
                        </div>
                        <div id="friendsChat"></div>
                        <div id="createGroup">
                            <a href="#" data-modal="createGroupModal" data-modal-title="Chatter Group">
                                <img src="Theme/Images/chat-list.png" height="25"/>
                            </a>
                        </div>
                    </div>
                </div>

                <%-- INDIVIDUAL CHAT SCREEN --%>
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
                    </div>

                    <div id="sendmessage">
                        <input id="message" autocomplete="off" type="text" placeholder="Type a message..." />
                        <button type="button" id="send" style="display: none"></button>
                    </div>

                </div>

                <%-- SETTINGS PAGE --%>
                <div id="chatSettings" class="tab-content" style="display: none">
                    <h3 class="sett-title">Chatter Settings</h3>
                    <div class="sett-dp">
                        <img src="Theme/Images/Defaults/profile_default.jpg"/>
                        <a href="#">Change</a>
                    </div>
                    <div class="sett-username">
                        <h4 class="sett-title--sub">Chat Username <button>Update</button></h4>
                        <input type="text" class="input" placeholder="Username"/>
                    </div>
                    <div class="sett-password">
                        <h4 class="sett-title--sub">Change Password <button>Update</button></h4>
                        <input type="password" class="input" placeholder="Old Password"/>
                        <input type="password" class="input" placeholder="New Password"/>
                        <input type="password" class="input" placeholder="Confirm New Password"/>
                        
                    </div>
                </div>

                <img id="chatterImage" src="Theme/Images/Defaults/profile_default.jpg" class="floatingImg" style="display: none" />

                <div id="createGroupModal" class="modal">
                    <div class="group-title">
                        <input type="text" class="group-email-input" value="Group Name" />
                    </div>
                    <input id="groupEmailInput" type="email" class="group-email-input" placeholder="add participants email id here..." />
                    <button type="button" id="addGroupEmail" class="group-email-add">+</button>
                    <ul class="group-participants"></ul>
                    <button class="create-group">Create Group</button>
                </div>



            </div>
        </div>
    </form>
    <%--<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>--%>
    <script src="Theme/js/jquery.min.js"></script>
    <script src="/Scripts/jquery.signalR-2.2.2.min.js"></script>
    <script src="/signalr/hubs" type="text/javascript"></script>
    <script src="../Scripts/Cookies/jquery.cookie.js"></script>
    <script>

        //Script for tab
        var switchTab = (target) => {
            let i;
            let targets = document.querySelectorAll('.tab-content');
            for (i = 0 ; i < targets.length; i++) {
                targets[i].style.display = 'none';
            }
            document.getElementById(target).style.display = 'block';
        }

        //Adding participants to list
        $('#addGroupEmail').click(function () {
            let i;
            let addUserInput = $('#groupEmailInput');
            let addedUsers = document.querySelectorAll('.participant');
            let userExist = false;
            for (i = 0 ; i < addedUsers.length; i++) {
                if (addedUsers[i].innerHTML === addUserInput.val()) {
                    userExist = true;
                    break;
                }
            }
            userExist ? alert('User Already Added to List') : $('.group-participants').append(`<li class="participant">${addUserInput.val()}</li>`);
            addUserInput.val('');
        });

        function Send(you, me, message) {
            var message = { FromId: me, ToId: you, Message: message };
            console.log(message);
            $.ajax({
                url: '/api/messenger/send',
                contentType: 'application/json;charset=utf-8',
                dataType: 'JSON',
                method: 'POST',
                data: JSON.stringify(message),
                success: function (data) {
                    console.log(data);
                    if (data.Success) {
                        var html = '<div class="message"><img src="' + data.Data.From.ProfileImagePath + '" /><div class="bubble">' + message.Message + '<div class="corner"></div><span>5 min</span></div></div>';
                        $('#chat-messages').append(html);
                        scrollDown();
                        $('#message').val('');
                    }
                },
                error: function (error) {
                    console.log(error);
                }

            });
        }

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
                                    html += '<div class="message"><img src="' + chat.From.ProfileImagePath + '" /><div class="bubble">' + chat.Message + '<div class="corner"></div><span>3 min</span></div></div>';
                                }
                                else {
                                    html += '<div class="message right"><img src="' + chat.From.ProfileImagePath + '" /><div class="bubble">' + chat.Message + '<div class="corner"></div><span>3 min</span></div></div>';
                                }

                            }
                            $('#chat-messages').children().remove();
                            $('#chat-messages').append(html).attr('data-you-id', you);

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
                        'width': "70px",
                        'left': '50%',
                        'top': '15px'
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

                        RefreshChatList($.cookie('ch_us_id'));
                        $("#chat-messages, #profile, #profile p").removeClass("animate");
                        $('.cx, .cy').removeClass("s1 s2 s3");
                        $('.floatingImg').animate({
                            'width': "50%",
                            'top': '15px',
                            'transform': 'translateX(-50%)'
                        }, 200, function () { $('#chatterImage').hide(); });

                        setTimeout(function () {
                            $('#chatview').fadeOut();
                            $('#friendslist').fadeIn();
                        }, 50);
                    });
                    scrollDown();
                },


            });
        }

        //scroll down logiv
        function scrollDown() {
            $('#chat-messages').scrollTop($('#chat-messages')[0].scrollHeight);
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
                                html += '<div data-chatter-id=' + chat.ChatterId + ' class="chat"><img src="' + chat.ProfileImagePath + '" /><p><strong>' + chat.FirstName + '</strong><span>' + chat.Email + '</span></p>';
                                if (chat.Unread != 0) {
                                    html += '<div style="display:block" class="unread-count status available">' + chat.Unread + '</div></div>';
                                } else {
                                    html += '<div style="display:none" class="unread-count status available">' + chat.Unread + '</div></div>';
                                }

                            }
                            $('#friendsChat').children('.chat').remove();
                            $('#friendsChat').append(html);
                            try {
                                afterRefresh();
                            }
                            catch (e) {

                            }
                        }
                    }
                },
                error: function (xhr) {
                    console.log(xhr);
                }

            });
        }

        //hub init
        var chatcon = $.connection.chathub;

        $(document).ready(function () {

            // CHATTER MODAL START FUNCTION
            $('[data-modal]').click(function() {
                let modalTargetId = $(this).attr('data-modal');
                let modalTitle = $(this).attr('data-modal-title') || 'Chatter Modal';
                let html = `<div class="chatter-modal-wrapper">
                    <div class="modal-header"><div>${modalTitle} <span class="chatter-modal-close">x</span></div></div></div>`;
                $(document).find(`#${modalTargetId}`).addClass('in').wrap(html);
            });
            // CHATTER MODAL CLOSE FUNCTION
            $('body').on('click', '.chatter-modal-close', function () {
                $(this).closest('.chatter-modal-wrapper').find('.modal').removeClass('in');
                $(this).closest('.modal-header').unwrap().remove();
            });

            console.log(chatcon);

            chatcon.client.newMessage = function (you, message, youProfileImage) {
                var current_you_id = $('#chat-messages').attr('data-you-id');
                if (current_you_id == you) {
                    var html = '<div class="message right"><img src="' + youProfileImage + '" /><div class="bubble">' + message + '<div class="corner"></div><span>3 min</span></div></div>';
                    $('#chat-messages').append(html);
                    scrollDown();
                    RefreshChatList($.cookie('ch_us_id'));
                }
                else {
                    RefreshChatList($.cookie('ch_us_id'));
                }


            }

            RefreshChatList($.cookie('ch_us_id'));

            $("#sendmessage input").focus(function () {
                if ($(this).val() == "Type a message...") {
                    $(this).val("");
                }
            });
            $("#sendmessage input").focusout(function () {
                if ($(this).val() == "") {
                    $(this).val("Type a message...");

                }
            });

            $("#searchfield").focus(function () {
                if ($(this).val() == "Search by email address") {
                    $(this).val("");
                }
            });
            $("#searchfield").focusout(function () {
                if ($(this).val() == "") {
                    $(this).val("Search by email address");

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
                                    var me = $.cookie('ch_us_id');
                                    var you = data.Data.ChatterId;
                                    showChat(data.Data.Name, data.Data.Email, you, me);
                                    $('#searchfield').val('');
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
            $('body').on('click', '.chat', function () {

                var name = $(this).find("p strong").html();
                var desc = $(this).find("p span").html();
                var me = Number($.cookie('ch_us_id'));
                var you = Number($(this).attr('data-chatter-id'));
                showChat(name, desc, you, me);
            });

            //Send Button
            $('#message').keyup(function (e) {
                e.preventDefault();
                if (e.keycode == 13 || e.which == 13) {
                    var message = $('#message').val();
                    if (message == '') {
                        return;
                    }
                    var you = Number($('#chat-messages').attr('data-you-id'));
                    var me = Number($.cookie('ch_us_id'));
                    Send(you, me, message);
                }

            });
            $('#send').click(function () {
                var message = $('#message').val();
                if (message == '') {
                    return;
                }
                var you = Number($('#chat-messages').attr('data-you-id'));
                var me = Number($.cookie('ch_us_id'));
                Send(you, me, message);
            });

            $.connection.hub.start()
            .done(function () {
                console.log('Now connected, connection ID=' + $.connection.hub.id);
            })
            .fail(function () { console.log('Could not Connect!'); });

        });
    </script>
</body>
</html>
