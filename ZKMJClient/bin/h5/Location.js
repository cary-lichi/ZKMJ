/**
 * ...
 * @author dawenhao
 */
function GetLocation(callBack,caller) {
	var info = {
					'accuracy' :"",
					'lng':"",
					'lat':"",
					'address':""
					}
				callBack(info,caller);
				return;
	//var address;
	//var lat;
	//var lng;
	//var accuracy;
	//
	//var geolocation = new BMap.Geolocation();
	//geolocation.getCurrentPosition(function(result) {
		//if(this.getStatus() == BMAP_STATUS_SUCCESS) {
			//lat = result.point.lat;//获取到的纬度  
            //lng = result.point.lng;//获取到的经度
			//accuracy = result.accuracy;
			//var point = new BMap.Point(lng,lat);
			//var gc = new BMap.Geocoder();
			//gc.getLocation(point,function(rs){
				//var addComp = rs.addressComponents;
				//address = addComp.province + addComp.city + addComp.district + addComp.street + addComp.streetNumber;
				//var info = {
					//'accuracy' :accuracy,
					//'lng':lng,
					//'lat':lat,
					//'address':address
					//}
				//callBack(info,caller);
			//});
		//}
	//});
};

//
function GetDistance(lng1,lat1,lng2,lat2)
		{
			return "";
			//var point1 = new BMap.Point(lng1,lat1);
			//var point2 = new BMap.Point(lng2,lat2);
			//var map = new BMap.Map();
			//var distance = map.getDistance(point1,point2).toFixed(2);
			//return distance;
		}