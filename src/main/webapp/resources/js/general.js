function aboutApp(appName, appVersion) {
    alert(appName + "." + appVersion + "\nLicensed to: Client X\n\nCredits:\n\u2022 Bootstrap 3.3.5\n\u2022 jQuery 1.11.3\n\u2022 Bootstrap-select 1.7.2");
}
function getCurrentURLWithoutGetParams()
{
    //get full url
    var url = window.location.href;
    //get url after/  
    var value = url.substring(0, url.indexOf('?'));
    //get the part after before ?
    //value = value.split("?")[0];
    return value;
}

//nth_occurrence('aaaaacabkhjecdddchjke', 'c', 3);
// Returns 16. The index of the third 'c' character.
function nth_occurrence(string, char, nth) {
    var first_index = string.indexOf(char);
    var length_up_to_first_index = first_index + 1;

    if (nth == 1) {
        return first_index;
    } else {
        var string_after_first_occurrence = string.slice(length_up_to_first_index);
        var next_occurrence = nth_occurrence(string_after_first_occurrence, char, nth - 1);

        if (next_occurrence === -1) {
            return -1;
        } else {
            return length_up_to_first_index + next_occurrence;
        }
    }
}

function clearGoogleParamsFromURL(googleRespone) {
    var currentURL = getCurrentURLWithoutGetParams();
    if (currentURL) {
        var indexOfProjectName = nth_occurrence(currentURL, '/', 4);
        window.location = currentURL.substring(0, indexOfProjectName + 1) + "social-networks.jsp?googleRespone=" + googleRespone;
    }

}

function banUnbanUser(username, isBanned) {
    var userAction = "";
    var banUser = "";
    var confirmed = "";
    if (isBanned == 'no') { // ban user
        if (confirm("Are you sure do you want to ban \"" + username + "\" user?")) {
            confirmed = 1;
            userAction = "banUser";
            banUser = "yes";
        }
    } else { // unban user
        if (confirm("Are you sure do you want to unban \"" + username + "\" user?")) {
            confirmed = 1;
            userAction = "unbanUser";
            banUser = "no";
        }
    }
    if (confirmed == 1) {
        $.ajax({
            url: "user-actions.jsp",
            dataType: 'JSON',
            type: 'POST',
            data: {userAction: userAction, username: username, banUser: banUser},
            success: function (response) {
                alert(response.data);
                location.reload();
            },
            error: function (xhr, status) {
                alert("Sorry, there was a problem!");
            }
        });
    }

}

function changeUserPasswordDialog(username) {
    $("#newPwd").val("");
    $("#confirmNewPwd").val("");
    $("#usernameField").val(username);
    $('#changePwdModal').on('show.bs.modal', function (event) {
        var modal = $(this);
        modal.find('.modal-title').text("Change password for \"" + username + "\"");
    });
}
function changeUserPwd(username, newPwd) {
    $.ajax({
        url: "user-actions.jsp",
        dataType: 'JSON',
        type: 'POST',
        data: {userAction: "changePassword", username: username, newPassword: newPwd},
        success: function (response) {
            alert(response.data);
            $(".modalCloseBtn").click();
        },
        error: function (xhr, status) {
            alert("Sorry, there was a problem!");
        }
    });

}
function editUserDialog(username, roles) {
    roles = roles.substr(1);
    var rolesAr = roles.split('; ');
    var tempAr = [];
    for (i in rolesAr) {
        tempAr.push(rolesAr[i]);
    }
    $('.selectpicker').selectpicker('val', tempAr);
    $('.selectpicker').selectpicker('render');
    $("#username", '#editUserModal').val(username);
    $("#oldUsername", '#editUserModal').val(username);
    $('#editUserModal').on('show.bs.modal', function (event) {
        var modal = $(this);
        modal.find('.modal-title').text("Edit user \"" + username + "\"");
    });
}
function submitEditForm(username, roles) {
    var oldUsername = $("#oldUsername", '#editUserModal').val();
    var rolesObj = {};
    for (i in roles) {
        rolesObj[roles[i]] = roles[i];
    }
    var rolesObj = JSON.stringify(rolesObj);
    $.ajax({
        url: "user-actions.jsp",
        dataType: 'JSON',
        type: 'POST',
        data: {userAction: "editUser", oldUsername: oldUsername, newUsername: username, newRoles: rolesObj},
        success: function (response) {
            alert(response.data);
            $(".modalEditUserCloseBtn").click();
            location.reload();
        },
        error: function (xhr, status) {
            alert("Sorry, there was a problem!");
        }
    });

}
function editGroupDialog(name) {
    $("#name", '#editGroupModal').val(name);
    $("#oldName", '#editGroupModal').val(name);
    $('#editGroupModal').on('show.bs.modal', function (event) {
        var modal = $(this);
        modal.find('.modal-title').text("Edit user group \"" + name + "\"");
    });
}
function submitEditGroupForm(name) {
    var oldName = $("#oldName", '#editGroupModal').val();
    if (oldName == name) {
        alert("no changes!!!");
        $(".modalEditGroupCloseBtn").click();
    } else {
        $.ajax({
            url: "user-actions.jsp",
            dataType: 'JSON',
            type: 'POST',
            data: {userAction: "editUserGroup", oldName: oldName, newName: name},
            success: function (response) {
                alert(response.data);
                $(".modalEditGroupCloseBtn").click();
                location.reload();
            },
            error: function (xhr, status) {
                alert("Sorry, there was a problem!");
            }
        });
    }


}
function disconnectGoogleAccount(username, gooleUrl, appName) {
    $.ajax({
        url: "user-actions.jsp",
        dataType: 'JSON',
        type: 'POST',
        data: {userAction: "disconnectGoogleAccount", username: username},
        success: function (response) {
            if (response.data == "success") {
                $(".btn-google-connect").removeClass("btn-default").addClass("btn-info").html("Connect").attr("onclick", "").attr("href", gooleUrl);
                $(".googleText").html("Your " + appName + " account is not connected to Google");
            } else {
                alert("Sorry, there was a problem when updating data in DB!");
            }
        },
        error: function (xhr, status) {
            alert("Sorry, there was a problem!");
        }
    });
}
function killBannedUser(username) {
    $.ajax({
        url: "user-actions.jsp",
        dataType: 'JSON',
        type: 'POST',
        data: {userAction: "killBannedUser", username: username},
        success: function (response) {
            if (response.data == "isBanned") {
                alert("Your account has been banned. Sorry you cannot access the application again. Please check your Administrator.");
                window.location = window.location.href;
            }
        },
        error: function (xhr, status) {
            alert("Sorry, there was a problem!");
        }
    });
}