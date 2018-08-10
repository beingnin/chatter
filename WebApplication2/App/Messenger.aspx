<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Messenger.aspx.cs" Inherits="WebApplication2.App.Messenger" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Messenger</title>
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <link rel="stylesheet" href="Theme/css/style.css?v=100818" />
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

            <div id="groupChatview" class="p1">
                <div id="groupProfile">

                    <div id="groupClose">
                        <img src="Theme/Images/back.png" width="20" />
                    </div>

                    <div id="groupMore">
                        <img src="Theme/Images/more.png" width="20" />
                    </div>

                    <p id="groupChatName">--Chatter--</p>
                    <span id="groupChatDesc">--description--</span>
                </div>
                <div id="group-chat-messages">
                </div>

                <div id="groupSendmessage">
                    <input id="groupMessage" autocomplete="off" type="text" placeholder="Type a message..." />
                    <button type="button" id="groupSend"></button>
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
    <script src="Theme/js/messenger.js?v=100818"></script>
</body>
</html>
