// onRestore

// onSave
// regular js events
$(function () {

    var data = {}
    var date = new Date();
    var current_data = date.getDate() + "/" + (date.getMonth() + 1) + "/" + date.getFullYear();
    var retrievedObject = localStorage.getItem('testObject');
    var comment_retrievedObject = localStorage.getItem('commentObject');
    var obj_data = JSON.parse(retrievedObject)
    var comment_obj = JSON.parse(comment_retrievedObject)

    $.each(userData, function (i, f) {
        data = f
    });
    $('.tabs').tabs();
    $(".emoji_icon").click(function () {
        var temp = $(this).text()
        $(".emoji").html(temp);
        $(".emoji").addClass("active");
    });

    $(".title").text(data.title);
    $("#modal_header").val(data.title);

    // $.each(userData, function(i, f) {
    //     var temp_id = f._id
    //     var img_icon = f.screenshot 
    //     $.each(f.memorable, function(i, f) {
    //         $("#memorable_ul").append('<li class="collection-item record_id">'+ temp_id +'<p class="add_memorable" id='+ temp_id +'> '+ f.memorable +' </p><p class="createdBy_name">'+ f.createdBy +' </p><p class="createdAt_date" id="date'+temp_id+'">'+ f.createdAt +'</p></li>');
    //     });
    //     $.each(f.comment, function(i, f) {
    //         $("#comment_ul").append('<li class="collection-item avatar"><img src="'+ img_icon +'" alt="" class="circle"><span class="creater_name">'+ f.comment +'</span><p class="created_data">'+ f.createdBy +' </br> '+ f.createdAt +'</p></li>');
    //     });
    // });

    $.each(userData, function (i, f) {
        // console.log("userData", f);
        var temp_id = f._id
        var rating1 = {}
        var memorable1 = {}
        var comment1 = {}
        var temp_data = f
        $.each(f.rating, function (i, f) {
            rating1 = f
            // console.log("userData_function", f.memorable);
        });
        $.each(f.comment, function (i, f) {
            comment1 = f
        });
        $.each(f.memorable, function (i, f) {
            memorable1 = f
            // console.log("userData_function", f.memorable);
            });
        console.log("memorable1",memorable1.memorable);
        // $("#card_container").append('<div class="card-content white-text"><div class="row"><div class="col s3" style="margin-top: 5px;"><i class="medium material-icons emoji brand-logo" id="emoji'+temp_id+'">'+rating1+'</i></div><div class="col s6"><h4 class="grey-text text-darken-4 title center-align card-title truncate">'+temp_data.title+'</h4></div><div class="col s3" style="margin-top: 10px;"><a href="#modal" id="modal_btn"class="secondary-content  btn-floating waves-effect waves-light modal-trigger"><i class="small material-icons">edit</i></a></div></div>');
        $("#card_container").append('<div class="card-content white-text"><div class="row"><div class="col s3" style="margin-top: 5px;"><i class="medium material-icons emoji brand-logo" id="emoji'+temp_data._id  +'">'+ rating1.rating +'</i></div><div class="col s6"><h4 class="grey-text text-darken-4 title center-align card-title truncate">'+temp_data.title+'</h4></div><div class="col s3" style="margin-top: 10px;"><a href="#modal" id="modal_btn" class="secondary-content  btn-floating waves-effect waves-light modal-trigger modal_btn"><i class="small material-icons">edit</i></a></div></div><div class="row"><div class="col s5"></div><div class="col s2" id="img_res'+temp_id+'"><img src="images/img_avatar.jpg" alt="" class="circle responsive-img"></div><div class="col s5"></div></div><div class="row valign-wrapper"><div class="col s2"><img src="images/img_avatar.jpg" alt="" class="circle responsive-img"></div><div class="col s8 center-align"><img src="images/img_avatar.jpg" alt="" class="circle responsive-img"></div><div class="col s2"><img src="images/img_avatar.jpg" alt="" class="circle responsive-img"></div></div><div class="row"><div class="col s5"></div><div class="col s2"><img src="images/img_avatar.jpg" alt="" class="circle responsive-img"></div><div class="col s5"></div></div><div class="row"><div class="card-tabs" id="tab_id'+temp_id+'"><ul class="tabs tabs-fixed-width" id="tab_id'+temp_id+'"><li class="tab"><a href="#memorable_div" class="blue white-text" id="memo_id'+temp_id+'">Memorable</a></li><li class="tab"><a href="#comment_div" class="blue white-text" id="comm_id'+temp_id+'">Comment</a></li></ul></div><div class="card-content black-text"><div id="memorable_div"><ul class="collection" id="memorable_ul"><li class="collection-item record_id">'+ temp_id +'<p class="add_memorable" id='+ temp_id +'> '+ memorable1.memorable +' </p><p class="createdBy_name">'+ memorable1.createdBy +' </p><p class="createdAt_date" id="date'+temp_id+'">'+ memorable1.createdAt +'</p></li></ul></div><div id="comment_div"><ul class="collection" id="comment_ul"><li class="collection-item avatar">'+ temp_id +'<img src="'+ temp_data.screenshot +'" alt="" class="circle"><span class="creater_name">'+ comment1.comment +'</span><p class="created_data">'+ comment1.createdBy +' </br> '+ comment1.createdAt +'</p></li></ul><div class="input-field"><i class="material-icons prefix send_comment">mode_edit</i><textarea id="comment_txt" class="materialize-textarea"></textarea></div></div></div></div></div>')

    });

    $.each(data.memorable, function (i, f) {
        $("#memorable_txt").text(f.memorable);
    });

    // $.each(data.rating, function (i, f) {
    //     $(".emoji").text(f.rating);
    // });

    $(".modal_btn").click(function () {
        console.log("click on edit button");
        
        $('.modal').modal();
        $("#memorable_txt").focus();
    });

    if (localStorage.getItem("commentObject") === null) {
        var items = [];
    } else {
        var items = comment_obj;
    }

    function comment_function() {
        var current_input = $('#comment_txt').val();
        var current_user_name;
        $.each(data.comment, function (i, f) {
            current_user_name = f.createdBy
        });
        $("#comment_ul").append('<li class="collection-item avatar"><img src="' + data.screenshot + '" alt="" class="circle"><span class="creater_name">' + current_input + '</span><p class="created_data">' + current_user_name + ' </br> ' + current_data + '</p></li>');

        var commentData = {
            comment_user_name: current_user_name,
            comment_text: current_input,
            comment_icon: data.screenshot,
            comment_date: current_data
        }

        items.push(commentData);
        $('#comment_txt').val('');
    }

    $(document).on('keypress', function (e) {
        if (e.which == 13) {
            comment_function();
            localStorage.setItem('commentObject', JSON.stringify(items));
        }
    });

    $("#save").click(function () {
        var emoj = $(".emoji").text()
        var c = $("#memorable_txt").val();
        var memorable_ul = $(".add_memorable");

        var update_memorable = $($('#' + memorable_ul.length))[0]
        $(update_memorable).html(c);
        var new_text = $($('#' + memorable_ul.length))[0].innerText
        var createdAt_date = $(".createdAt_date");
        var createdAt = $('#date' + createdAt_date.length).context.lastModified

        var data = {
            date: createdAt,
            memorable: new_text,
            emoj: emoj
        }

        var update_date = $('#date' + createdAt_date.length)[0]
        $(update_date).html(data.date);

        localStorage.setItem('testObject', JSON.stringify(data));
    });

    if (localStorage.getItem("testObject") === null) {
        // console.log("retrievedObject",obj_data);
    } else {
        $(".emoji").text(obj_data.emoj);
        $("#memorable_txt").text(obj_data.memorable);
        var update_memorable = $($('#' + $(".add_memorable").length))[0]
        $(update_memorable).text(obj_data.memorable);
        var update_date = $('#date' + $('.createdAt_date').length)[0]
        $(update_date).html(obj_data.date);
    }

    if (localStorage.getItem("commentObject") === null) {
        // console.log("comment_obj",comment_obj);
    } else {
        $.each(comment_obj, function (i, f) {
            $("#comment_ul").append('<li class="collection-item avatar"><img src="' + f.comment_icon + '" alt="" class="circle"><span class="creater_name">' + f.comment_text + '</span><p class="created_data">' + f.comment_user_name + ' </br> ' + f.comment_date + '</p></li>');
        });
    }
});