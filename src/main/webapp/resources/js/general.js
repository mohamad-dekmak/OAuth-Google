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

function clearGoogleParamsFromURL() {
    var currentURL = getCurrentURLWithoutGetParams();
    if (currentURL) {
        var indexOfProjectName = nth_occurrence(currentURL, '/', 3);
        window.history.pushState("object or string", "Title", "/" + currentURL.substring(indexOfProjectName + 1));
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

function setTempUserName(username){
    document.getElementById('tempInput').value = username;
}