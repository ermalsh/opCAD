$(document).ready(function () {
    responsiveVoice.setDefaultVoice("US English Female");
    var streamid = '';
    var muted = true;
    //CTRL C to Mute/Unmute
    $(document).on('keydown', function (e) {
        // You may replace `c` with whatever key you want
        if ((e.metaKey || e.ctrlKey) && (String.fromCharCode(e.which).toLowerCase() === 'm')) {
            switch (muted) {
                case true:
                    connection.streamEvents[streamid].stream.mute('audio');
                    $("#currentStatusRTO").html('Muted');
                    $("#currentStatusRTO").removeClass('text-success');
                    $("#currentStatusRTO").addClass('text-danger');
                    responsiveVoice.speak("Muted");
                    muted = false;
                    break;
                case false:
                    connection.streamEvents[streamid].stream.unmute('audio');
                    $("#currentStatusRTO").html('Unmuted');
                    $("#currentStatusRTO").removeClass('text-danger');
                    $("#currentStatusRTO").addClass('text-success');
                    responsiveVoice.speak("Un muted");
                    muted = true;
                    break;
                default:
                    muted = false;
            }
        }
    });
   responsiveVoice.speak("Connected to RTO");
   var unit = document.getElementById('currentIdentifier').innerHTML;
// ......................................................
        // ......................................................
        // ..................RTCMultiConnection Code.............
        // ......................................................
        var connection = new RTCMultiConnection();
        var idofroom = 'RTO-Dispatcher';
        // by default, socket.io server is assumed to be deployed on your own URL
        //connection.socketURL = '/';
        // comment-out below line if you do not have your own socket.io server
        // below method "checkRoom" keeps checking for room until joins it
        connection.userid = unit;
        connection.socketURL = 'https://rtcmulticonnection.herokuapp.com:443/';
        connection.socketMessageEvent = 'audio-conference-demo';
        connection.session = {
            audio: true,
            video: false
        };
        connection.mediaConstraints = {
            audio: true,
            video: false
        };
        connection.sdpConstraints.mandatory = {
            OfferToReceiveAudio: true,
            OfferToReceiveVideo: false
        };
        connection.audiosContainer = document.getElementById('audios-container');
        connection.onstream = function (event) {
            var width = parseInt(connection.audiosContainer.clientWidth / 2) - 20;
            var mediaElement = getHTMLMediaElement(event.mediaElement, {
                title: event.userid,
                buttons: ['full-screen'],
                width: width,
                showOnMouseEnter: false
            });
            connection.audiosContainer.appendChild(mediaElement);
            setTimeout(function () {
                mediaElement.media.play();
            }, 2000);
            mediaElement.id = event.streamid;
            streamid = event.streamid;
        };
        connection.onstreamended = function (event) {
            var mediaElement = document.getElementById(event.streamid);
            if (mediaElement) {
                mediaElement.parentNode.removeChild(mediaElement);
            }
        };
        // ......................................................
        // ......................Handling Room-ID................
        // ......................................................
        connection.onUserStatusChanged = function (event) {
            if (event.status === 'offline') {
                // Is the room owner here?	
                var remoteUserId = idofroom; // chat_room is the room name, set higher in the script.
                var chatters = [connection.userid] // initialize array of users with me.
                var isUserConnectedWithYou = connection.getAllParticipants().indexOf(remoteUserId) !== -1;
                if (isUserConnectedWithYou) {
                    // The owner is here...
                    console.log('Primary user is here. Nothing to do.');
                } else {
                    console.log('Primary user is not here!');
                    var numberOfUsersInTheRoom = connection.getAllParticipants().length;
                    console.log('users in room: ' + numberOfUsersInTheRoom); // does not include me!
                    if (numberOfUsersInTheRoom === 0) {
                        // I am the only one here. Take control.
                        connection.open(idofroom);
                        connection.userid = idofroom;
                        console.log('I am the only one here. Take control. I am now the primary user.');
                        console.log('My userid is now: ' + connection.userid);
                    } else {
                        // There are multiple users here. Only one can take control.
                        // Fill our array.
                        connection.getAllParticipants().forEach(function (remoteUserId) {
                            chatters.push(remoteUserId);
                        });
                        // Sort our array.
                        chatters.sort();
                        // Whoever is at the top of the array gets control. Maybe it's me, maybe not.
                        if (connection.userid == chatters[0]) {
                            // Take control.
                            connection.open(idofroom);
                            connection.userid = idofroom;
                            console.log('Ownership of room taken. I am now the primary user.');
                        } else {
                            console.log('I am not taking room control. User ' + chatters[0] + ' will take control.');
                        }
                    } // end if if (numberOfUsersInTheRoom === 0)
                } // end if (isUserConnectedWithYou)		  
                connection.onclose(event);
            }
        };
        connection.join(idofroom);
    console.log(idofroom)
});