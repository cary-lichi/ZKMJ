jQuery(document).ready(function() {
            //开始
		    $('.submit').click(function(){
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
					        	url:config.baseUrl+"/adminLogin",
					        	async:true,
					        	data:{
					        		'userName':username,
					        		'passWord':password
					        	},
					        	dataType:'json',
					        	success:function(data)
					        	{
					        		console.log(data);
					        		if(data.errorcode==0)
					        		{
					        			console.log(data.Aid);
					        			localStorage.setItem('nickName',data.nickName);
					        			localStorage.setItem('Aid',data.Aid);
					        			localStorage.setItem('token',data.token);
					          			window.location.href = "page/nav_list.html";
					        		}else{
					        			alert("用户名或密码错误!");
					        		}
					        	},
					        	error:function(xhr,status,error)
					        	{
					        		alert("网络异常！");
					        	}
					        });
				//结束       
				});
				
				    $('.page-container form .username, .page-container form .password').keyup(function(){
				        $(this).parent().find('.error').fadeOut('fast');
				    });

});