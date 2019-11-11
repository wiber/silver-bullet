// onRestore

// onSave
// regular js events
$(function () {
    
    var data = {}
    var date=new Date();
    var current_data = date.getDate()+"/"+(date.getMonth()+1)+"/"+date.getFullYear();
    var retrievedObject = localStorage.getItem('testObject');
    var comment_retrievedObject = localStorage.getItem('commentObject');
    var obj_data = JSON.parse(retrievedObject)
    var comment_obj = JSON.parse(comment_retrievedObject)
    // console.log("comment_obj",comment_obj);
    
    $.each(userData, function(i, f) {
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

    $.each(userData, function(i, f) {
        var temp_id = f._id
        var img_icon = f.screenshot 
        $.each(f.memorable, function(i, f) {
            $("#memorable_ul").append('<li class="collection-item record_id">'+ temp_id +'<p class="add_memorable" id='+ temp_id +'> '+ f.memorable +' </p><p class="createdBy_name">'+ f.createdBy +' </p><p class="createdAt_date" id="date'+temp_id+'">'+ f.createdAt +'</p></li>');
        });
        $.each(f.comment, function(i, f) {
            $("#comment_ul").append('<li class="collection-item avatar"><img src="'+ img_icon +'" alt="" class="circle"><span class="creater_name">'+ f.comment +'</span><p class="created_data">'+ f.createdBy +' </br> '+ f.createdAt +'</p></li>');
        });
    });

    $.each(data.memorable, function(i, f) {
        $("#memorable_txt").text(f.memorable);
    });

    $.each(data.rating, function(i, f) {
        $(".emoji").text(f.rating);
    });

    $("#modal_btn").click(function () {
        $('.modal').modal();  
        $("#memorable_txt").focus();
    });   
    
    if (localStorage.getItem("commentObject") === null) {
        var items = [];
    }
    else{
        var items = comment_obj;
    }

    function comment_function() {
        var current_input = $('#comment_txt').val();
        var current_user_name;
        $.each(data.comment, function(i, f) {
            current_user_name = f.createdBy
        });
        $("#comment_ul").append('<li class="collection-item avatar"><img src="'+ data.screenshot +'" alt="" class="circle"><span class="creater_name">'+ current_input   +'</span><p class="created_data">'+ current_user_name +' </br> '+ current_data +'</p></li>');
        
        var commentData = {
            comment_user_name: current_user_name,
            comment_text: current_input,
            comment_icon: data.screenshot,
            comment_date: current_data
        }
        
        items.push(commentData);
        $('#comment_txt').val('');
    }
    
    $(document).on('keypress',function(e) {
        if(e.which == 13) {
            comment_function();
            // console.log("items",items);
            localStorage.setItem('commentObject', JSON.stringify(items));
        }
    });
    // $(".send_comment").click(function () {
    //     comment_function();
    // }); 

    $("#save").click(function () {
        var emoj = $(".emoji").text()
        var c = $("#memorable_txt").val();
        var memorable_ul = $(".add_memorable");
        
        var update_memorable = $($('#'+memorable_ul.length))[0]
        $(update_memorable).html(c);
        var new_text = $($('#'+memorable_ul.length))[0].innerText
        var createdAt_date = $(".createdAt_date");
        var createdAt = $('#date'+createdAt_date.length).context.lastModified

        var data = {
            date: createdAt,
            memorable: new_text,
            emoj: emoj
        }
        
        var update_date = $('#date'+createdAt_date.length)[0]
        $(update_date).html(data.date);

        localStorage.setItem('testObject', JSON.stringify(data));
    });  

    if (localStorage.getItem("testObject") === null) {
        // console.log("retrievedObject",obj_data);
    }
    else{
        
        $(".emoji").text(obj_data.emoj);
        $("#memorable_txt").text(obj_data.memorable);
        var update_memorable = $($('#'+$(".add_memorable").length))[0]
        $(update_memorable).text(obj_data.memorable);
        var update_date = $('#date'+$('.createdAt_date').length)[0]
        $(update_date).html(obj_data.date);
    }

    if (localStorage.getItem("commentObject") === null) {
        // console.log("comment_obj",comment_obj);
    }
    else{
        
        $.each(comment_obj, function(i, f) {
            $("#comment_ul").append('<li class="collection-item avatar"><img src="'+ f.comment_icon +'" alt="" class="circle"><span class="creater_name">'+ f.comment_text   +'</span><p class="created_data">'+ f.comment_user_name +' </br> '+ f.comment_date +'</p></li>');
        });
        
    }
});