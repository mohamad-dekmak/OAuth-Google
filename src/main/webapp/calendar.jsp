<%-- 
    Document   : calendar
    Created on : Sep 08, 2015, 08:52:27 PM
    Author     : mdekmak
--%>

<%@include file="header.jsp" %>

<div id="calendar"></div>

<div id="eventModal" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="eventModal">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="eventModal">Event</h4>
            </div>
            <div class="modal-body">
                <form>
                    <input type="hidden" id="id" value="" />
                    <div class="form-group required">
                        <label class="required control-label"><abbr title="required">*</abbr> Title:</label>
                        <input type="text" class="form-control" id="title">
                    </div>
                    <div class="form-group required">
                        <label class="required control-label"><abbr title="required">*</abbr> Start:</label>
                        <input type="text" id="start" class="form-control datepicker" data-date-format="mm/dd/yyyy">
                    </div>
                    <div class="form-group">
                        <label class="control-label">End:</label>
                        <input type="text" class="form-control datepicker" id="end">
                    </div>
                    <div class="form-group">
                        <label class="control-label">Location:</label>
                        <input type="text" class="form-control" id="location">
                    </div>
                    <div class="form-group">
                        <label class="control-label">Invities:</label>
                        <%@include file="users-dropdown.jsp" %>
                    </div>
                    <div id="helpMsgContainer">
                        <p class="help-block text-red" id="errorMsg"></p>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default modalEventCloseBtn" data-dismiss="modal">Close</button>
                <button type="button" class="btn btn-primary" id="eventBtn" onClick="eventBtn();">Save</button>
            </div>
        </div>
    </div>
</div>

<script type="text/javascript">
    $(document).ready(function () {
        $('#calendar').fullCalendar({
//            dateFormat: 'Y-M-D',
//            timeFormat: 'H:mm',
            header: {
                left: 'prev,next today',
                center: 'title',
                right: 'month,agendaWeek,agendaDay'
            },
            editable: true,
            selectable: true,
            selectHelper: true,
            select: function (start, end) {
                $("#errorMsg").addClass("hide");
                $("#title", "#eventModal").val('');
                $("#location", "#eventModal").val('');
                $("#start", "#eventModal").val(moment(start).format('YYYY-MM-DD HH:mm'));
                $("#end", "#eventModal").val(moment(end).format('YYYY-MM-DD HH:mm'));
                $('.selectpicker').selectpicker();
                $("#eventModal").submit(function () {
                    eventBtn();
                });
                $('#eventModal').modal();
                $("#title", "#eventModal").focus();
                $('#eventModal').on('shown.bs.modal', function () {
                    $('#title').focus();
                    $('.datepicker').datetimepicker({format:'Y-m-d H:i'});
                });
            },
            events: [
                {
                    title: 'All Day Event',
                    start: '2015-09-01'
                },
                {
                    title: 'Long Event',
                    start: '2015-09-07',
                    end: '2015-09-10'
                },
                {
                    id: 999,
                    title: 'sadsaas aasd asd',
                    start: '2015-09-09T09:00:00',
                    end: '2015-09-09T13:00:00'
                },
                {
                    id: 999,
                    title: 'Repeating Event',
                    start: '2015-09-16T16:00:00'
                },
                {
                    title: 'Conference',
                    start: '2015-09-11',
                    end: '2015-09-13'
                }
            ]
        });
    });
    function eventBtn() {
        var title = $("#title", "#eventModal").val();
        var location = $("#location", "#eventModal").val();
        var start = $("#start", "#eventModal").val();
        var end = $("#end", "#eventModal").val();
        var msg = "";
        if (!title) {
            msg = "Title is required.";
            document.getElementById("errorMsg").innerHTML = msg;
            $("#errorMsg").removeClass("hide");
        } else if (!start) {
            msg = "Start is required.";
            document.getElementById("errorMsg").innerHTML = msg;
            $("#errorMsg").removeClass("hide");
        } else {
            // submit event form
            $("#errorMsg").addClass("hide");
            var loggedUser = '<%= request.getUserPrincipal().getName()%>';
            $.ajax({
                url: "user-actions.jsp",
                dataType: 'JSON',
                type: 'POST',
                data: {userAction: "addEvent", title: title, start: start, end: end, location: location, createdBy: loggedUser},
                success: function (response) {
                    if (response.data == "success") {
                        $("#errorMsg").addClass("hide");
                        $(".modalEventCloseBtn").click();
                        var eventData;
                        eventData = {
                            title: title,
                            start: moment(start).format('YYYY-MM-DDTHH:mm:ssZ'),//YYYY-MM-DDTHH:mm:ssZ
                            end: moment(end).format('YYYY-MM-DDTHH:mm:ssZ')
                        };
                        $('#calendar').fullCalendar('renderEvent', eventData, true);
                        $('#calendar').fullCalendar('unselect');
                    } else {
                        $("#errorMsg").removeClass("hide").html(response.data);
                    }
                },
                error: function (xhr, status) {
                    alert("Sorry, there was a problem!");
                }
            });
        }
    }
</script>

