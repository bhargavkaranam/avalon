
$(document).on('click','.addFriend',function(){
	let id = $(this).data('id');
	
	$.ajax({
		url: '/addfriend',
		type: 'post',
		data: 'id=' + id,
		dataType: 'json',
		success: function(data) {
			$(".friendsMessage").html(data.message);
			$("#friendsModal").modal('toggle');
		}
	})
})

$(document).on('click','.accept',function(){
	let id = $(this).data('id');
	$.ajax({
		url: '/accept',
		type: 'post',
		data: 'id=' + id,
		dataType: 'json',
		success: function(data) {
			alert("Done");
		}
	})	
})

function checkFriendRequests()
{
	$(".notifications").empty();
	$.ajax({
		url: '/notifications',
		type: 'get',		
		dataType: 'json',
		success: function(data) {
			$.each(data.requests,function(k,v){
				// alert("New friend request");
				$(".notifications").append('<a class="dropdown-item" href="#">' + v.fid1 + ' sent a friend request.<br/><button data-id="' + v.fid1 + '" class="btn-primary accept">Accept</button></a>');
			})
		}
	})
}

setInterval(checkFriendRequests,2000);



