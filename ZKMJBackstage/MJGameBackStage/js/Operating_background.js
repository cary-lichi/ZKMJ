 //创建子管理员
 var state=$("input[name = 'state']")[0].value;
 state=config_default.adminRights[state];
 $("input[name = 'state']")[0].checked='checked';
 $("input[name = 'state']").each(function(index, item) {
	    item.addEventListener('tap', function() {
	    	
	           item.checked='checked';
	           var state_v=item.value;
	           state=config_default.userState[state_v];
//	           console.log('84'+state);
//	           show();
               console.log(state);
	    }, false);
			
   });
 console.log(state);
 $("#add1").click(function() {
   	var userName=$('#userName').val();
   	var passWord=$('#passWord').val();
   	var nick=$('#nick').val();
   	var type=$('#type').val();
// 	console.log(userName);
     console.log('aid='+Aid);
 	$.ajax({
			type:"post",
			url:config.baseUrl + "/adminRegSubadmin",
			data:{
				    'Aid':Aid,
					'token':token,
					'userName':userName,
					'passWord':passWord,
				     'level':state,
                     'nick':nick,
                     'type':type
				},
			async:false,
			dataType:'json',
			success:function(data)
			{
//				console.log('data=');
	    	if(data.errorcode==config_error.success){
	    		alert("创建成功!");
	    	}
	    	else if(data.errorcode==config_error.userrepeated){
	    		alert("该用户已经存在!");
	    	}
	    	else{
	    		alert("未创建成功!");
	    	}
			},
			error:function(xhr,status,error)
			{
			    mui.toast("服务器出错！");	
			}
		});
	
});
//获取操作记录
var page=$(".page_input").val();
function show() {
//	page=1;
	$.ajax({
		
		type: "post",
		url: config.baseUrl + "/adminGetadmin",

		async: false,
		crossDomain: true,
		data: {
			'Aid':Aid,
			'token':token,
			'page':page
		},
		dataType: 'json',
				success: function(data) {
                       //得到错误码
						var code = data.errorcode;
						console.log(data);
						if(code==0){
							$('.countNum')[0].innerHTML=data.pageCount;
							g_pageCount=data.pageCount;
							analysisData(data.adminInfo);
						}
//						else
//						{
//							//错误报表
//							alert(config_errordata[code]);
//						}

		},
		error: 
		function(xhr, type, errorThrown) {
			//异常处理；
//			mui.toast('服务器异常!');
		    serve_error();
		}

	});
}
//解析数据
function analysisData(data){
	var html_l='';
	$.each(data, function(index,item){
		console.log(index);
		console.log(item.admin);
        console.log(config_admin[item.admin]);
        html_l=html_l+"<tr><td>"+item.nickname+"</td><td>"+item.type+"</td><td>"+config_admin[item.admin]+"</td><td>"+config_operate[item.admin]+"</td></tr>";
	});
	$('.test').html(html_l);
	$('.pageNum')[0].innerHTML=page;
}
show();