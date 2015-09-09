<%-- 
    Document   : calendar
    Created on : Sep 08, 2015, 08:52:27 PM
    Author     : mdekmak
--%>

<%@include file="header.jsp" %>

<div id="calendar"></div>

<script type="text/javascript">
    $(document).ready(function () {
        $('#calendar').fullCalendar({
            header: {
                left: 'prev,next today',
                center: 'title',
                right: 'month,agendaWeek,agendaDay'
            },
            editable: true,
            selectable: true,
            selectHelper: true,
            select: function (start, end) {
                var title = prompt('Event Title:');
                var eventData;
                if (title) {
                    eventData = {
                        title: title,
                        start: start,
                        end: end
                    };
                    $('#calendar').fullCalendar('renderEvent', eventData, true); // stick? = true
//                    $.ajax({
//                        url: "user-actions.jsp",
//                        dataType: 'JSON',
//                        type: 'POST',
//                        data: {userAction: "addEvent", title: title, start: start, end: end, createdBy: '<%= request.getUserPrincipal().getName() %>'},
//                        success: function (response) {
//                            alert(response.data);
//                        },
//                        error: function (xhr, status) {
//                            alert("Sorry, there was a problem!");
//                        }
//                    });
                }
                $('#calendar').fullCalendar('unselect');
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
                    title: 'Repeating Event',
                    start: '2015-09-09T16:00:00'
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
</script>

