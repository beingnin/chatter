<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Messenger.aspx.cs" Inherits="WebApplication2.App.Messenger" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Messenger</title>
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <link rel="stylesheet" href="Theme/css/style.css?v=310718" />
    <link href='http://fonts.googleapis.com/css?family=Open+Sans:400,600,700' rel='stylesheet' type='text/css' />
    <link href="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/css/toastr.min.css" rel="stylesheet" />
</head>
<body style="background: #d6d9dc">
    <%--<form id="form1" runat="server">--%>
    <%--hidden fields--%>
    <a href="#" style="display: none" id="openCreateGroup" data-modal="createGroupModal" data-modal-title="Create new group"></a>

    <div class="chatter-wrap">
        <div id="chatbox">
            <div id="topmenu">
                <a class="menu active" href="#" onclick="switchTab('friendslist')">
                    <img src="Theme/Images/chat.png " />
                </a>

                <a class="menu" href="#" onclick="switchTab('GroupTab')">
                    <img src="Theme/Images/chat-list.png" />
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
                    <div id="addChat">
                        <a href="#">
                            <img src="Theme/Images/add-user.png" height="20" />
                        </a>
                    </div>
                </div>
            </div>

            <%-- INDIVIDUAL CHAT SCREEN --%>
            <div id="chatview" class="p1">
                <div id="profile">

                    <div id="close">
                        <img src="Theme/Images/back.png" width="20" />
                    </div>

                    <div id="more">
                        <img src="Theme/Images/more.png" width="20" />
                    </div>

                    <p id="chatName">--Chatter--</p>
                    <span id="chatDesc">--description--</span>
                </div>
                <div id="chat-messages">
                </div>

                <div id="sendmessage">
                    <input id="message" autocomplete="off" type="text" placeholder="Type a message..." />
                    <button type="button" id="send"></button>
                </div>

            </div>

            <%-- SETTINGS PAGE --%>
            <div id="chatSettings" class="tab-content" style="display: none">
                <h3 id="profileFullName" class="sett-title">Profile</h3>
                <div class="sett-dp">
                    <img id="profileImage" src="Theme/Images/Defaults/profile_default.jpg" />
                    <label for="btnChangeProPic">Change</label>
                    <input type="file" accept="image/*" name="btnChangeProPic" id="btnChangeProPic" hidden="hidden" />
                    <p id="profileEmail">xx</p>
                    <p id="joinedDate">xx</p>
                </div>
                <div class="sett-username">
                    <h4 class="sett-title--sub">Name
                        <button type="button" id="btnUpdateName">
                            <img src="Theme/Images/save.png" height="12" />&nbsp;Update</button></h4>
                    <input type="text" id="txtfName" class="input" placeholder="First Name" />
                    <input type="text" id="txtlName" class="input" placeholder="Last Name" />
                </div>
                <div class="sett-password">
                    <h4 class="sett-title--sub">Change Password
                        <button type="button" id="btnUpdatePwd">
                            <img src="Theme/Images/save.png" height="12" />&nbsp;Update</button></h4>
                    <input type="password" id="txtOldPwd" class="input" placeholder="old password" />
                    <input type="password" class="input" id="txtNewPwd1" placeholder="new password" />
                    <input type="password" class="input" id="txtNewPwd2" placeholder="confirm password" />

                </div>
                <a href="/App/Account/Logout" id="logout">Logout</a>
                <div class="sett-logo">
                    <img src="Theme/Images/doKonnect.png" height="35" />
                </div>
            </div>

            <img id="chatterImage" src="Theme/Images/Defaults/profile_default.jpg" class="floatingImg" style="display: none" />

            <div id="GroupTab" class="tab-content" style="display: none">
                <div id="groups">
                    <%--<div id="search">
                        <input type="text" autocomplete="off" id="searchfield" placeholder="Search by email address" />
                    </div>--%>
                    <div id="groupChat"></div>
                    <div id="addGroup">
                        <a href="#">
                            <img src="Theme/Images/add-user.png" height="20" />
                        </a>
                    </div>
                </div>

                <%--<div class="group-title">
                    <input type="text" class="group-email-input" placeholder="Type group name here..." />
                </div>
                <input id="groupEmailInput" type="email" class="group-email-input" placeholder="add participants email id here..." />
                <button type="button" id="addGroupEmail" class="group-email-add">+</button>
                <ul class="group-participants"></ul>
                <button class="create-group">Create Group</button>--%>
            </div>



            <div id="createGroupModal" data-group-id="0" class="modal">
                <div class="group-title">
                    <input type="text" id="txtGroupName" class="group-email-input" placeholder="Type group name here..." />
                </div>
                <input id="groupEmailInput" type="email" class="group-email-input" placeholder="add participants email id here..." />
                <button type="button" id="addGroupEmail" class="group-email-add">+</button>
                <ul class="group-participants"></ul>
                <button type="button" id="btnCreateNewGroup" class="create-group">Create Group</button>
            </div>

        </div>
    </div>
    <%--</form>--%>
    <%--<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>--%>
    <script src="Theme/js/jquery.min.js"></script>
    <script src="Theme/js/app.js"></script>
    <script src="/Scripts/jquery.signalR-2.2.2.min.js"></script>
    <script src="/signalr/hubs" type="text/javascript"></script>
    <script src="../Scripts/Cookies/jquery.cookie.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/js/toastr.min.js"></script>
    <script>

        //Script for tab
        var switchTab = (target) => {
            $('#topmenu > a').removeClass('active');
            let i;
            let targets = document.querySelectorAll('.tab-content');
            for (i = 0 ; i < targets.length; i++) {
                targets[i].style.display = 'none';
            }
            document.getElementById(target).style.display = 'block';
        }
        $('#topmenu').children('a').click(function () { $(this).addClass('active') });



        //get data of a current chatter

        function fillProfile() {
            var id = $.cookie('ch_us_id');
            $.ajax({
                url: '/api/account/get?id=' + id,
                method: 'GET',
                dataType: 'Json',
                success: function (profile) {
                    console.log(profile);
                    if (profile.Success) {
                        $('#profileEmail').text(profile.Data.Email);
                        $('#joinedDate').text("joined on " + profile.Data.JoinedOn);
                        $('#txtfName').val(profile.Data.FirstName);
                        $('#txtlName').val(profile.Data.LastName);
                        $('#profileFullName').text(profile.Data.Name);
                        $('#profileImage').attr('src', profile.Data.ProfileImagePath);
                    }
                }
            });

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
            userExist ? toast('error', 'User Already Added to List') : $('.group-participants').append(`<li class="participant">${addUserInput.val()}</li>`);
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
                        var html = '<div class="message"><img src="' + data.Data.From.ProfileImagePath + '" /><div class="bubble">' + message.Message + '<div class="corner"></div><span>' + data.Data.RelativeTime + '</span></div></div>';
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
                                    html += '<div class="message"><img src="' + chat.From.ProfileImagePath + '" /><div class="bubble">' + chat.Message + '<div class="corner"></div><span>' + chat.RelativeTime + '</span></div></div>';
                                }
                                else {
                                    html += '<div class="message right"><img src="' + chat.From.ProfileImagePath + '" /><div class="bubble">' + chat.Message + '<div class="corner"></div><span>' + chat.RelativeTime + '</span></div></div>';
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

        //REset participants modal
        function resetParticipants() {
            $('.group-participants').children('li.participant').remove();;
            $('#createGroupModal').attr('data-group-id','0');
            $('#txtGroupName').val('');;
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

        function searchEmail(email) {
            if (email.match(/@/g) == null) {

                toast('error', "Provide a valid email address and try");
                return;
            }

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
                    else {
                        $('#searchfield').val('');
                        if (confirm("This user is not yet registered with us. Send an invitation?")) {
                            $.ajax({
                                url: '/api/account/invite?toemail=' + email + '&by=' + $.cookie('ch_us_id'),
                                method: 'POST',
                                contentType: 'application/json;charset=utf-8',
                                dataType: 'JSON',

                                success: function (d) {
                                    if (d.Success) {
                                        toast('error', d.Response);
                                    }
                                    else {
                                        toast('error', d.Response);
                                    }
                                }


                            })
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

            //Create new group

            $('#addGroup').click(function () { $('#openCreateGroup').trigger('click'); });

            $('#btnCreateNewGroup').click(function () {
                var group = {};
                var emaillist = $('.group-participants').children('li.participant');
                group.GroupId = $('#createGroupModal').attr('data-group-id');
                group.Name =    $('#txtGroupName').val();;
                group.Participants = [];
                for (var i = 0; i < emaillist.length; i++) {
                    group.Participants.push({ Email: $(emaillist[i]).html() });
                }
                if (!group.Name) {
                    toast('error', 'Provide a valid group name');
                }
                if (group.Participants.length < 2) {
                    toast('error', 'Add atleast two participants');
                }

                $.ajax({
                    url: '/api/messenger/SaveorUpdateGroup',
                    method:'POST',
                    contentType: 'application/json;charset=utf-8',
                    dataType: 'JSON',
                    data: JSON.stringify(group),
                    success: function (data) {
                        if (data.Success) {
                            resetParticipants();
                            $('.chatter-modal-close').trigger('click');
                            toast('success', data.Response);
                        }
                        else {
                            toast('error', data.Response);
                        }
                    }
                });

            });

            // CHATTER MODAL START FUNCTION
            $('[data-modal]').click(function () {
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

            chatcon.client.newMessage = function (you, message, youProfileImage, date) {
                var current_you_id = $('#chat-messages').attr('data-you-id');
                if (current_you_id == you) {
                    var html = '<div class="message right"><img src="' + youProfileImage + '" /><div class="bubble">' + message + '<div class="corner"></div><span>' + date + '</span></div></div>';
                    $('#chat-messages').append(html);
                    scrollDown();
                    RefreshChatList($.cookie('ch_us_id'));
                }
                else {
                    RefreshChatList($.cookie('ch_us_id'));
                }


            }

            RefreshChatList($.cookie('ch_us_id'));
            fillProfile();
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
                    searchEmail(email);
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

            $('#btnChangeProPic').change(function (e) {

                if (e.target.files[0].size > 1048576) {
                    toast('error', 'Please choose a file less than 1 Mb in size');
                    return;
                }
                var reader = new FileReader();
                reader.onload = function (result) {
                    var b64 = result.target.result.split(',')[1];
                    console.log(b64);
                    $.ajax({
                        url: '/api/account/UpdateProfilePic?chatterId=' + $.cookie('ch_us_id'),
                        method: 'POST',
                        contentType: 'application/json;charset=utf-8',
                        dataType: 'JSON',
                        data: JSON.stringify(b64),
                        success: function (data) {
                            console.log(data);
                            if (data.Success) {
                                $('.sett-dp img').attr('src', result.target.result);
                            }
                        }
                    })
                }
                reader.readAsDataURL(e.target.files[0]);
            });

            $('#btnUpdateName').click(function (e) {
                var fNAme = $('#txtfName').val();
                var lNAme = $('#txtlName').val();
                if (!fNAme) {
                    toast('error', 'First name must not be empty');
                    $('#txtOldPwd,#txtNewPwd1,#txtNewPwd2').val('');
                    return;
                }
                $.ajax({
                    url: '/api/account/ChangeName?chatterId=' + $.cookie('ch_us_id') + '&fname=' + fNAme + "&lName=" + lNAme,
                    method: 'POST',
                    contentType: 'application/json;charset=utf-8',
                    dataType: 'JSON',
                    success: function (data) {
                        console.log(data);
                        if (data.Success) {
                            toast('error', data.Response);
                        }
                        else {
                            toast('error', data.Response);
                        }
                        $('#txtOldPwd,#txtNewPwd1,#txtNewPwd2').val('');
                    }
                })


            });

            $('#btnUpdatePwd').click(function (e) {
                var old = $('#txtOldPwd').val();
                var new1 = $('#txtNewPwd1').val();
                var new2 = $('#txtNewPwd2').val();
                if (new1 !== new2) {
                    toast('error', 'Your passwords do not match. Try again');
                    return;
                }
                $.ajax({
                    url: '/api/account/ChangePassword?chatterId=' + $.cookie('ch_us_id') + '&oldPwd=' + old + "&newPwd=" + new2,
                    method: 'POST',
                    contentType: 'application/json;charset=utf-8',
                    dataType: 'JSON',
                    success: function (data) {
                        console.log(data);
                        if (data.Success) {
                            toast('error', data.Response);
                        }
                        else {
                            toast('error', data.Response);
                        }
                    }
                })


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
