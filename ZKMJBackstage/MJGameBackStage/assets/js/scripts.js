
jQuery(document).ready(function() {

    $('#submit_l').click(function(){
    	
        var username = $('.username').val();
        var password = $('.password').val();
        
        if(username == '') {
            $(this).find('.error').fadeOut('fast', function(){
                $(this).css('top', '27px');
            });
            $(this).find('.error').fadeIn('fast', function(){
                $(this).parent().find('.username').focus();
            });
            alert("请填写用户名!");
            return false;
        }
        if(password == '') {
            $(this).find('.error').fadeOut('fast', function(){
                $(this).css('top', '96px');
            });
            $(this).find('.error').fadeIn('fast', function(){
                $(this).parent().find('.password').focus();
            });
            alert("请填写密码!");
            return false;
        }
		console.log(username);
        $.ajax({
        	type:"post",
        	url:"http://192.168.0.134:8000/adminlogin",
        	async:true,
        	data:{
        		'username':username,
        		'passwd':password
        	},
        	dataType:'json',
        	success:function(data)
        	{
        		console.log(data);
        		if(data.errorcode==0)
        		{
        			localStorage.setItem('name',data.username);
          			window.location.href = "index.html";
        		}else{
        			alert("用户名或密码错误!");
        		}
        	},
        	error:function(xhr,status,error)
        	{
        		console.log(error);
        	}
        });
       
    });

    $('.page-container form .username, .page-container form .password').keyup(function(){
        $(this).parent().find('.error').fadeOut('fast');
    });

});
