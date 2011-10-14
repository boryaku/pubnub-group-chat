<%--
/**
 * Copyright (c) Pure Source, LLC All rights reserved.
 *
 * This library is free software; you can redistribute it and/or modify it under
 * the terms of the GNU Lesser General Public License as published by the Free
 * Software Foundation; either version 2.1 of the License, or (at your option)
 * any later version.
 *
 * This library is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
 * FOR A PARTICULAR PURPOSE. See the GNU Lesser General Public License for more
 * details.
 */
--%>
<div class="configure_group_chat" style="display: ${PUB_KEY eq "demo" ? 'block' : 'none'};">
    <span style="padding: 10px;">The Site Group Chat Portlet is running in DEMO mode and needs to be configured with your PubNub &copy; Account information.<br/>
    <span style="padding: 10px; text-align: center;">Click <a href="http://www.pubnub.com/account" target="_blank">HERE</a> to create your PubNub &copy; Account.</span>
    </span>
</div>
<div id="box" class="nubpub_chat_box"></div>
<div><input id="input" class="nubpub_chat_input" /></div>
<div id="pubnub" pub-key="${PUB_KEY}" sub-key="${SUB_KEY}" ssl="${SSL_KEY}"></div>
<script src=http://cdn.pubnub.com/pubnub-3.1.min.js></script>
<span style="float:right; font-size: smaller;" class="remove-powered-by">powered by <a href="http://www.puresrc.com" target="_blank">PureSrc</a></span>

<script type="text/javascript" charset="UTF-8">

var box = PUBNUB.$('box'),
    input = PUBNUB.$('input'),
    portraitId = '${user.portraitId}',
    fullName = '${user.fullName}',
    channel = '${channel}',
    rowClass = 'row-odd';

function chat_message(msg){
this.portraitId = portraitId;
this.fullName = fullName == '' ? 'Guest' : fullName;
this.channel = channel;
this.msg_text = msg;
this.time = new Date().getTime();
}

PUBNUB.history({
    channel : channel,
    limit : 25
}, function(messages) {
    for(var i=0; i < messages.length; ++i){
       handle_msg(messages[i]);
    }
} );


PUBNUB.subscribe({
    channel  : channel,
    callback : function(msg) {
        handle_msg(msg);
    }
});

PUBNUB.bind( 'keyup', input, function(e) {
    (e.keyCode || e.charCode) === 13 && PUBNUB.publish({
        channel : channel, message : new chat_message(input.value)
    });

    if(e.keyCode == 13 || e.charCode == 13){
        input.value = "";
    }

} );

function handle_msg(msg){
    box.innerHTML = box.innerHTML +
            '<div id=\"chatContainer\" class="'+rowClass+'">'+
                '<span id=\"chatImg\" class=\"chatImg\">' +
                    img_create(msg.portraitId) +
                '</span>'+
                '<span id=\"chatFullName\" class=\"chatFullName\">'+
                    msg.fullName+
                '<br/>' +
                    '<span id=\"chatMsg\" class=\"chatMsg\">'+
                        (''+msg.msg_text).replace( /[<>]/g, '' ) +
                    '</span>'+
                '</span>'+
                '<span id=\"chatTime\" class=\"chatTime\">'+
                    getClockTime(new Date(msg.time));
                '<span/>' +
            '</div><br/>';

    box.scrollTop = box.scrollHeight;

    if(rowClass == 'row-even'){
        rowClass = 'row-odd';
    }else{
        rowClass = 'row-even';
    }
}

function img_create(img_id) {
    var img = '<img class=\"avatar\" src=\"/image/user_male_portrait?img_id='+img_id+'&t='+${now}+'\" width=\"25px\"/>'
    return img;
}

function getClockTime(date)
{
   var now    = date;
   var hour   = now.getHours();
   var minute = now.getMinutes();
   var second = now.getSeconds();
   var ap = "AM";
   if (hour   > 11) { ap = "PM";             }
   if (hour   > 12) { hour = hour - 12;      }
   if (hour   == 0) { hour = 12;             }
   if (minute < 10) { minute = "0" + minute; }
   var timeString = hour +
                    ':' +
                    minute +
                    ' '+
                    ap;
   return timeString;
}



</script>