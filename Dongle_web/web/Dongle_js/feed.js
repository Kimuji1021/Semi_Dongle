// var feed=$('.feed:last-child').after('<div>new feed</div>').css({
//     'width':'750px',
//     'height':'300px',
//     'border':'1px solid red'
// }).attr('class','feed');
// $(document).ready(function () {
//     //스크롤 발생 이벤트 처리
//     $('.newsfeed').scroll(function () {
//         console.log('df');
//         var scrollT = $(this).scrollTop(); //스크롤바의 상단위치
//         var scrollH = $(this).height(); //스크롤바를 갖는 div의 높이
//         var contentH = $('.news').height(); //문서 전체 내용을 갖는 div의 높이
//         if (scrollT + scrollH >= contentH) { // 스크롤바가 맨 아래에 위치할 때
//             $('.news').append($('<div>new feed</div>').css({
//                 'width':'750',
//                 'height':'300',
//                 'border':'1px solid red'
//             }));
//         }
//     });
// });

$(document).ready(
		function() {
			$('#more').click(
					function() {

						for (var i = 0; i < 3; i++) {

							$('.news').append($('<hr>'));
							$('.news').append($('<div>new feed</div>').css({
								'width' : '500',
								'height' : 'auto',
								'border' : '1px solid grey'
							}).attr('class', 'feed'));
							$('.feed:last-child').append(
									$('<div>new feed 작성자, 작성 시간</div>').css({
										'border' : '1px solid grey',
										'width' : '500px',
										'height' : '40px'
									}).attr('class', 'storyH'));
							$('.feed:last-child').append(
									$('<div>new feed 작성 내용</div>').css({
										'border' : '1px solid grey',
										'width' : '500px',
										'height' : '200px'
									}).attr('class', 'storyB'));
							$('.feed:last-child').append(
									$('<div></div>').css({
										'border' : '1px solid grey',
										'width' : '500px',
										'height' : '40px'
									}).attr('class', 'storyF').append(
											$('<a>∥댓글달기</a>').attr('class',
													'comment')).append(
											$('<a>∥댓글보기</a>').attr('class',
													'repleview')));

						}
						// $('#more').remove();
						console.log($('.news:last-child'));
						$('.news:last-child').append($('#more'));

					});
		});
$(document).ready(
		function() {

			$(document).on(
					'click',
					'.comment',
					function() {

						// console.log($(this).parent().parent());
						$(this).parent().parent().css('height', '300px');
						$(this).parent().css('height', '40px').append(
								'<form></form>');
						$(this).next().append('<label>댓글 입력</label>');
						$(this).next().children().append(
								'<input type="text" size="40"/>').css({
							'type' : 'text',
							'size' : '200'
						});
						$(this).next().append('<button>등록</button>');
						// $(this).parent().siblings('#comment').next;
						console.log($(this).next().children());
						$(this).remove();
					});
		});
$(document).ready(function() {

	$(document).on('click', '.repleview', function() {
		var reple = [ '댓글1', '댓글2', '댓글3', '댓글4', '댓글5' ];
		console.log($(this).parent().next());
		for ( var r in reple) {
			$(this).parent().after('<div>' + reple[r] + '</div>');
		}
		$(this).parent().after('<button>접기</button>');
		$(this).remove();

	});
});