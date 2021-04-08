// Methods
var char_data = null;
var delete_char = null;
var create_char = null;
var _charId = null;
var current_characters = {};
var current_char = null;

function formatNumber(num) {
  return num.toString().replace(/(\d)(?=(\d{3})+(?!\d))/g, '$1,')
}

function ShowSpawn() {
    if (current_char.job == "police") {
        
        $("#spawn-job-1").html("Sandy Shores");
        $("#spawn-job-2").html("Paleto Bay");
        $("#spawn-job-3").html("Vespucci");
        $("#spawn-job-4").html("MRPD");
        $("#spawn-job-5").html("Pier");

        
        $("#job-image-1").attr("src", "images/jobs/police-2.png");
        $("#job-image-2").attr("src", "images/jobs/police-3.png");
        $("#job-image-3").attr("src", "images/jobs/police-4.png");
        $("#job-image-4").attr("src", "images/jobs/police-1.png");
        // $("#job-image-3").attr("src", "images/jobs/unused.png");
        $("#job-image-5").attr("src", "images/jobs/police-5.png");

        $("#job-spawn-1").attr("data-job-name", "police");
        $("#job-spawn-2").attr("data-job-name", "police");
        $("#job-spawn-3").attr("data-job-name", "police");
        $("#job-spawn-4").attr("data-job-name", "police");
        $("#job-spawn-5").attr("data-job-name", "police");

        $('.spawn-container-job').css({"display":"flex"});
    } else if (current_char.job == "lses") {
        $("#spawn-job-1").html("Central Hospital");
        $("#spawn-job-2").html("Pillbox Hill");
        $("#spawn-job-3").html("Sandy Shores Medical");
        $("#spawn-job-4").html("Mount Zonah");
        $("#spawn-job-5").html("Paleto Bay Medical");

        $("#job-image-1").attr("src", "images/jobs/lses-4.png");
        $("#job-image-2").attr("src", "images/jobs/lses-2.png");
        $("#job-image-3").attr("src", "images/jobs/lses-3.png");
        $("#job-image-4").attr("src", "images/jobs/lses-1.png");
        $("#job-image-5").attr("src", "images/jobs/lses-5.png");

        $("#job-spawn-1").attr("data-job-name", "lses");
        $("#job-spawn-2").attr("data-job-name", "lses");
        $("#job-spawn-3").attr("data-job-name", "lses");
        $("#job-spawn-4").attr("data-job-name", "lses");
        $("#job-spawn-5").attr("data-job-name", "lses");

        $('.spawn-container-job').css({"display":"flex"});
    } else if (current_char.job == "gruppe6") {
        $("#spawn-job-1").html("Gruppe6 City HQ");
        $("#spawn-job-2").html("Unused");
        $("#spawn-job-3").html("Unused");
        $("#spawn-job-4").html("Unused");
        $("#spawn-job-5").html("Bollingbrooke Security Office");
 

        $("#job-image-1").attr("src", "images/jobs/gruppe6-1.png");
        $("#job-image-2").attr("src", "images/jobs/unused.png");
        $("#job-image-3").attr("src", "images/jobs/unused.png");
        $("#job-image-4").attr("src", "images/jobs/unused.png");
        $("#job-image-5").attr("src", "images/jobs/gruppe6-2.png");

        $("#job-spawn-1").attr("data-job-name", "gruppe6");
        $("#job-spawn-2").attr("data-job-name", "gruppe6");
        $("#job-spawn-3").attr("data-job-name", "gruppe6");
        $("#job-spawn-4").attr("data-job-name", "gruppe6");
        $("#job-spawn-5").attr("data-job-name", "gruppe6");


        $('.spawn-container-job').css({"display":"flex"});
    } else if (current_char.job == "bearcat") {
        $("#spawn-job-1").html("Unused");
        $("#spawn-job-2").html("Unused");
        $("#spawn-job-3").html("Bearcat City HQ");
        $("#spawn-job-4").html("Unused");
        $("#spawn-job-5").html("Unused");

        $("#job-image-1").attr("src", "images/jobs/unused.png");
        $("#job-image-2").attr("src", "images/jobs/unused.png");
        $("#job-image-3").attr("src", "images/jobs/bearcat-1.png");
        $("#job-image-4").attr("src", "images/jobs/unused.png");
        $("#job-image-5").attr("src", "images/jobs/unused.png");

        $("#job-spawn-1").attr("data-job-name", "bearcat");
        $("#job-spawn-2").attr("data-job-name", "bearcat");
        $("#job-spawn-3").attr("data-job-name", "bearcat");
        $("#job-spawn-4").attr("data-job-name", "bearcat");
        $("#job-spawn-5").attr("data-job-name", "bearcat");

        $('.spawn-container-job').css({"display":"flex"});
    }
    $('.spawn-container').css({"display":"flex"});
}

function HideSpawn() {
    $('.spawn-container').css({"display":"none"});
    $('.spawn-container-job').css({"display":"none"});
}

function ShowUI(data) {
    $(".character-container").empty();

    if (data.maxCharacters == null) {data.maxCharacters = 3}

    for (let charId = 1; charId <= data.maxCharacters; charId++) {
        var charBox = $(`<div class="character-box" data-charid="${charId}">`)

        var charHeader = $(`<div class="character-head">Empty Slot #${charId}</div>`)
        var charBody = $(`<div class="character-body"></div>`)
        var charFooter = $(`<div class="character-button"></div>`)

        if (data.characters[charId-1]) {
            var char = data.characters[charId-1];
            current_characters[charId] = char;

            charHeader.html(char.icname)
            charBody.append(`<h3>Full-time Job</h3><p>${char.job_label+" - "+char.job_gradelabel}</p>`)
            charBody.append(`<h3>Part-time Job</h3><p>${char.subjob_label+" - "+char.subjob_gradelabel}</p>`)
            charBody.append(`<h3>Date Of Birth</h3><p>${char.dateofbirth}</p>`)

            charFooter.append(`<button class="btn-play" data-charid="${charId}">Select</button>`)
            charFooter.append(`<button class="btn-delete" data-charid="${charId}">Delete</button>`)
        } else {
            charFooter.append(`<button class="btn-create" data-charid="${charId}">Create Character</button>`)
        }

        charBox.append(charHeader);
        charBox.append(charBody);
        charBox.append(charFooter);

        $(".character-container").append(charBox)
    }


    $(".main-container").css({"display":"block"});
}

function HideUI() {
    $('.main-container').css({"display":"none"});
}

function UnhideUI() {
    $('.main-container').css({"display":"block"});
}

function CloseUI() {
    $('.main-container').css({"display":"none"});
}
function DeleteChar(charid) {
    $("#character-body-"+charid+"-hide").css({"display":"none"});
    $("#btn-play-"+charid).css({"display":"none"});
    $("#btn-delete-"+charid).css({"display":"none"});
    $("#btn-create-"+charid).css({"display":"inline-block"});
}

window.onload = function(e) {
    window.addEventListener('message', function(event) {
        switch(event.data.action) {
            case 'openui':
                char_data = event.data;
                ShowUI(char_data);
                break;
        }
    })
}

$(".character-container").on("click", ".btn-play", function() {
    _charId = $(this).attr("data-charid");
    current_char = current_characters[_charId];

    if (current_char.isDead == 1) {
        HideUI();
        CloseUI();
        $.post("http://base_scripting/LoadCharacter", JSON.stringify({
            charId: _charId,
            spawn:   0,
            job:    "dead",
        }));
        return;
    }

    HideUI();
    ShowSpawn();
});

$(".character-container").on("click", ".btn-create", function() {
    create_char = $(this).attr("data-charid");
    _charId = $(this).attr("data-charid");
    $(".create-character-container").css({"display":"block"})
    $(".create-character-disabled").css({"display":"block"})
    $(".main-container").css({"filter":"blur(4px)"});
});

$(".character-container").on("click", ".btn-delete", function() {
    $(".delete-character-container").css({"display":"block"});
    $(".main-container").css({"filter":"blur(4px)"});
    delete_char = $(this).attr("data-charid")
});

$(".delete-character-confirm").click(function() {
    $(".delete-character-container").css({"display":"none"});
    $(".create-character-disabled").css({"display":"none"})
    $(".main-container").css({"filter":"blur(0px)"});
    $.post("http://base_scripting/DeleteCharacter", JSON.stringify({
        charId: delete_char,
    }));
    DeleteChar(delete_char);
    delete_char = null;
});

$(".delete-character-cancel").click(function() {
    $(".delete-character-container").css({"display":"none"});
    $(".create-character-disabled").css({"display":"none"})
    $(".main-container").css({"filter":"blur(0px)"});
    delete_char = null;
});

var invalid = ["0","1","2","3","4","5","6","7","8","9"];
$(".create-btn-accept").click(function() {
    var first = $("#create-first").val(); 
    var last  = $("#create-last").val();
    var dob   = new Date($('#create-dob').val());
    var day   = dob.getDate();
    var month = dob.getMonth() + 1;
    var year  = dob.getFullYear();
    var _issuesFound = false;

    // Resets style so if you have new errors old ones don't show
    $("#create-first").css({"border":"none"});
    $("#create-last").css({"border":"none"});
    $("#create-dob").css({"border":"none"});

    // Checks minimum length of first name
    if (first.length <= 2) {
        console.log("Firstname is too short");
        $("#create-first").css({"border":"2px solid rgba(200,0,0,0.9)"});
        _issuesFound = true;
    }

    // Checks minimum length of last name
    if (last.length <= 2) {
        console.log("Lastname is too short");
        $("#create-last").css({"border":"2px solid rgba(200,0,0,0.9)"});
        _issuesFound = true;
    }

    // makes sure date isn't null
    if (isNaN(day) || isNaN(month) || isNaN(year)) {
        console.log("Date cannot be Null");
        $("#create-dob").css({"border":"2px solid rgba(200,0,0,0.9)"});
        _issuesFound = true;
    }

    // checks for numbers, originally did characters but that had issues
    for (var i=0; i < invalid.length; i++) {
        var search_first = first.search(invalid[i]);
        var search_last  = first.search(invalid[i]);
        if (search_first != -1) {
            $("#create-first").css({"border":"2px solid rgba(200,0,0,0.9)"});
            _issuesFound = true;
        } else if (search_last != -1) {
            $("#create-last").css({"border":"2px solid rgba(200,0,0,0.9)"});
            _issuesFound = true;
        }
    }

    // Assigned a variable so it can show all issues
    if (_issuesFound) {return;}

    // Below Executes if no issues are found
    $("#create-first").css({"border":"none"});
    $("#create-last").css({"border":"none"});
    $("#create-dob").css({"border":"none"});

    $.post("http://base_scripting/CreateCharacter", JSON.stringify({
        charid: create_char,
        icname: first+" "+last,
        dob: [day, month, year].join('/'),
    }));
    $(".create-character-container").css({"display":"none"})
    $(".create-character-disabled").css({"display":"none"})
    $(".main-container").css({"filter":"blur(0px)"});
    HideUI();
});

$(".create-btn-cancel").click(function() {
    $(".create-character-container").css({"display":"none"})
    $(".create-character-disabled").css({"display":"none"})
    $(".main-container").css({"filter":"blur(0px)"});
});

$(".spawn-point").click(function(){                                                                 // Spawn Point Button
    var name = $(this).children(".spawn-name").html();
    if (name == "Unused") return; 																	// Stops people from spawning in the middle of nowhere
    $.post("http://base_scripting/LoadCharacter", JSON.stringify({                                  // Sends spawn to client in a callback
        charId: _charId,
        spawn:  $(this).attr("data-point"),                                                         // Sends the spawn id (INT)
        job:    $(this).attr("data-job-name"),                                                      // Sends your job name, it's crude but this is my first time
    }));
    HideSpawn();
    CloseUI();
});