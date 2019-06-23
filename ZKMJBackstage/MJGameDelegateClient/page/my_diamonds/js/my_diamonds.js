$('.num').html(money);

$.ajax({
	type:"post",
	url:config.baseUrl+"/deleGetRechatgeInfo",
	async:true,
	data:{'id':did},
	dataType:'json',
	success:function(data){
		console.log(data);
		if(data.errorcode==0){
			var html="";
			$.each(data.rechatgeinfo, function(item,index) {
//				console.log(item);
				if(item!='errorcode')
				{
					html+='<li class="mui-table-view-cell">';
					html+='<img src="../img/shop_car.png" id="userphoto" class="mui-media-object mui-pull-left userphotoimg" />';
					html+='<div class="mui-media-body">';
					if(data.rechatgeinfo[item].fromc==0){
						html+='<span class="userspan">正常充值</span>';
			            html+='<p class="mui-ellipsis addrechargep">充值时间:<span>'+data.rechatgeinfo[item].time+'</span></p>';
		     	        html+='</div><div class="remoney"><span class="money">+'+data.rechatgeinfo[item].money+'</span></div></li>';	

					}
					else if(data.rechatgeinfo[item].fromc==1){
						html+='<span class="userspan">苹果充值</span>';
			            html+='<p class="mui-ellipsis addrechargep">充值时间:<span>'+data.rechatgeinfo[item].time+'</span></p>';
		     	        html+='</div><div class="remoney"><span class="money">+'+data.rechatgeinfo[item].money+'</span></div></li>';	
					}
					else if(data.rechatgeinfo[item].fromc==2){
						html+='<span class="userspan">厂家购钻</span>';
			            html+='<p class="mui-ellipsis addrechargep">充值时间:<span>'+data.rechatgeinfo[item].time+'</span></p>';
		     	        html+='</div><div class="remoney"><span class="money">+'+data.rechatgeinfo[item].money+'</span></div></li>';	
					}
					else if(data.rechatgeinfo[item].fromc==3){
						html+='<span class="userspan">为下级代理充值</span>';
			            html+='<p class="mui-ellipsis addrechargep">充值时间:<span>'+data.rechatgeinfo[item].time+'</span></p>';
					    html+='</div><div class="remoney"><span class="money1">-'+data.rechatgeinfo[item].money+'</span></div></li>';	
					}
					
				}			
			});
			$(".mui-table-view").html(html);
		}
	},
	error:function(xhr,status,error){
		console.log(error);
    }
});