/**
 * ...
 * @author dawenhao
 */
function btnShareAppMessage(roomID,sICode) {
	wx.miniProgram.postMessage({
		data:{
			type:"joinroom",
			RoomID:roomID,
			ICode:sICode
		}
	});
}
/**
	定义数据类型
	
	data:{
			type:分享类型, 
			以下为任意字段
			aaa:aaa
		}
 
	分享类型 
	joinroom 加入房间
 */