//翻页 && 实时更新  && 获取state && 登出
//          控制相应函数
$(function() {
	if(page==g_pageCount)
	{
		$(".NextPage").css('color','black');
	}else{
		$(".NextPage").css('color',"#428BCA");
	}
	if(page==1)
	{
		$(".lastPage").css('color','black');
	}else{
		$(".lastPage").css('color',"#428BCA");
	}
	$(".reduce").click(reducePage);
	$(".add").click(addPage);
	$(".NextPage").click(function() {
		addPage();
		show();
	});
	$(".lastPage").click(function() {
		reducePage();
		show();
	});
	$(".TurnToPage").click(function() {
		page = $(".page_input").val();
		show();
	});
	
	
});
//			减页
function reducePage() {
	if(page == 1) {
		$(".lastPage").css('color','black');
		$(".NextPage").css('color',"#428BCA");
		return 0;
	} else if((page-1)==1){		
		page--;
		$(".lastPage").css('color','black');
		$(".NextPage").css('color',"#428BCA");
		$(".page_input").val(page);
	}else{
		page--;
		$(".page_input").val(page);
	}
}

//      	加页
function addPage() {
	var pagemax = g_pageCount;
	if(page == pagemax) {
		$(".lastPage").css('color',"#428BCA");
		$(".NextPage").css('color','black');
		return 0;
	} else if((page+1)==g_pageCount){
		page++;
		$(".NextPage").css('color','black');	
		$(".page_input").val(page);
	}else{
		page++;
		$(".NextPage").css('color',"#428BCA");
		$(".lastPage").css('color',"#428BCA");	
		$(".page_input").val(page);
	}
}
//状态  state
//为每一个元素添加监听事件  监听点击
$("input[name = 'state']").each(function(index, item) {
	    item.addEventListener('tap', function() {
	    	
	           item.checked='checked';
	           var state_v=item.value;
	           state=config_default.userState[state_v];
//	           console.log('84'+state);
	           show();
	    }, false);
			
   });
   
// console.log(config_default.userState.all);
//      登出		
$("#logout").click(function(){
        	$.ajax({
		type: "post",
		url: config.baseUrl + "/adminOutLogin",
		async: false,
		crossDomain: true,
		data: {
			'Aid':Aid,
			'token':token
		},
		dataType: 'json',
		success: function(data) {

			console.log('111');
			console.log(data);
			//得到错误码
			var code = data.errorcode;
			if(code==0){
							localStorage.removeItem("token");
							localStorage.removeItem("Aid");
							window.location.href = "../index.html";
							console.log("您已经退出");
						}
						else
						{
							//错误报表
							alert(config_errordata[code]);
						}

		},
		error: 
		function(xhr, type, errorThrown) {
			//异常处理；
//			mui.toast('服务器异常1');
			serve_error();
        }
    });
        });

//实时更新
function dsupdate()
{
	page = $(".page_input").val();
	state=$('.checkbox_position input[name="state"]:checked ').val();
	state=config_default.userState[state];
	console.log("174="+state);
	show();
}
setInterval(dsupdate,10000);