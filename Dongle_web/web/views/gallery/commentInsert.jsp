<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>

<%@ page import="com.dongle.gallery.model.vo.GalleryCommentJoin,java.util.*,com.dongle.member.model.vo.Member,com.dongle.gallery.model.vo.GalleryPath" %>
<%
	List<GalleryPath> gplist=(List)request.getAttribute("gplist");
	List<GalleryCommentJoin> gclist=(List)request.getAttribute("gclist");
	int groupNo = (int)request.getAttribute("groupNo");
	Member loginMember = (Member)session.getAttribute("loginMember");
%>
	<link href="<%=request.getContextPath() %>/css/gallery_style.css" rel="stylesheet">
	<!-- ���â ���� -->
	<div class="comment-editor">
		<ul>
			<%if(gclist!=null){ %>
				<%for(GalleryCommentJoin g:gclist){ %>
					<%if(g.getGalCommentLevel()==1){ %>
						<li class='level1' style="list-style:none;">
							<span class='ico_skin thumb_profile'>
								<img class='img_profile' src='<%=request.getContextPath()%>/images/group_profile/<%=g.getGroupMemberImageNewPath() %>'>
							</span>
							<span class='comment_box'>
								<span class='comment-writer'><%=g.getGroupMemberNickname()%></span>
								<span class='comment-date'>
									<%=g.getGalCommentDate() %>
									<a href='*' >�Ű�</a>
								</span>
								<br/>
								<span class='comment_content'>
									<%=g.getGalCommentContent() %>
									<button class='btn-reply' value='<%=g.getGalCommentNo()%>'>���</button>
								</span>
							</span>
						</li>
					<%} 
					else{%>
						<li class="level2" style="list-style:none;">
							<span class='ico_skin thumb_profile'>
								<img class='img_profile' src='<%=request.getContextPath()%>/images/group_profile/<%=g.getGroupMemberImageNewPath() %>'>
							</span>
							<span class='comment_box'>
								<span class='comment-writer'><%=g.getGroupMemberNickname()%></span>
								<span class='comment-date'>
									<%=g.getGalCommentDate() %>
									<a href='*' >�Ű�</a>
								</span>
								<br/>
								<span class='comment_content'>
									<%=g.getGalCommentContent() %>
								</span>
							</span>
						</li>
					<%} %>
				<%} %>
			<%}%> 
		</ul>
		<input type="hidden" name="groupNo" id='groupNo' value="<%=gplist.get(0).getGroupNo() %>"/>
		<input type="hidden" name="galNo" id="galNo" value="<%=gplist.get(0).getGalNo() %>"/>
		<input type="hidden" name="galCommentWriterNo" id='galCommentWriterNo' value="<%=loginMember.getMemberNo() %>"/>
		<input type="hidden" name="galCommentLevel" id='galCommentLevel' value="1"/>
		<input type="hidden" name="galCommentRef" id='galCommentRef' value="0"/>
		<input type="hidden" name="albumCode" id='albumCode' value="<%=gplist.get(0).getAlbumCode()%>"/>
		<input type="hidden" name="galFileNo" id='galFileNo' value="<%=gplist.get(0).getGalFileNo()%>"/>
		<fieldset class='modal_comment'>
			<legend class='screen_out'>��۾��� ��</legend>
			<div class='comment_write'>
				<label for='comment' class='lab_write screen_out'>����</label>
				<textarea name="galCommentContent" id='galCommentContent' placeholder="������ ����� �Է����ּ���" tabindex='3' style='resize:none;box-sizing: border-box;width:100%;height:80;border:1px solid #fff;'></textarea>
			</div>
			<div class='comment_btn'>
				<button type="button" id='btn-insert'>�Է�</button>
			</div>
		</fieldset>
	</div>

	<script>
/*  */
	/* ���� ���� �Լ�*/
	$(function(){
		var eventflag;
		$('.btn-reply').on('click',function(e){
			console.log($(this));
			<%if(loginMember!=null){%>
				eventflag=true;
				var div=$("<div class='recomment_content'></div>");
				var html="";
				html+="<input type='hidden' name='groupNo' value='<%=groupNo %>'/>"
				html+="<input type='hidden' name='galNo' value='<%=gplist.get(0).getGalNo()%>'/>";
				html+="<input type='hidden' name='galCommentWriterNo' value='<%=loginMember.getMemberNo()%>'/>";
				html+="<input type='hidden' name='galCommentLevel' value='2'/>";
				html+="<input type='hidden' name='albumCode' value='<%=gplist.get(0).getAlbumCode()%>'/>";
				html+="<input type='hidden' name='galFileNo' value='<%=gplist.get(0).getGalFileNo()%>'/>";
				html+="<input type='hidden' name='galCommentRef2' value='"+$(this).val()+"'/>";
				html+="<fieldset class='modal_comment'>";
				html+="<div class='comment_write'>";
				html+="<textarea name='galCommentContent' id='galCommentContent' placeholder='������ ����� �Է����ּ���' tabindex='3' style='resize:none;box-sizing: border-box;width:100%;height:80;border:1px solid #fff;'></textarea>";
				html+="</div>";
				html+="<div class='comment_btn'>";
				html+="<button value='"+$(this).val()+"' type='button' id='btn-insert' style='float:right;width:65px;height:28px;font-size:14px;line-height:15px;border-radius: 20px;border:none;background-color:white;'>Send</button>";
				html+="</div>"
				html+="</fieldset>"
				div.html(html);
				div.insertAfter($(this).parent().parent().parent()).children("span").slideDown(800);
				/* ����� �̺�Ʈ ���� */
				$(this).off('click');
				/* ����� ������ display�ٲ�� �� */
 				$('.recomment_content').click(function(){
					if(eventflag)
					{
						$(this).css('display','none');
						eventflag=false;
						return;
					}
				}) 
				
				div.find('#btn-insert').click(function(e){
					if(<%=loginMember==null%>)
					{
					 	fn_loginAlert();
						e.preventDefault();
						return;
					}
					var len=($(this).parent().find()).siblings('textarea').val().trim().length;
					if(len==0)
					{
						e.preventDefault();
					} 
					$.ajax({
						url:"<%=request.getContextPath()%>/gallery/commentInsert",
						data:{"groupNo":$('#groupNo').val(),
							"galNo":$('#galNo').val(),
							"galCommentWriterNo":$('#galCommentWriterNo').val(),
							"galCommentLevel":2,
							"galCommentRef":$(this).val(),
							"albumCode":$('#albumCode').val(),
							"galFileNo":$('#galFileNo').val(),
							"galCommentContent":$('#galCommentContent').val(),
						},
						type:"post",
						success:function(data){
							if(data!=null)
							{	
								alert('��� ��� �Ϸ�!');
								$('.comment-editor').html(data);
							}
							else
							{
								alert('��� ��Ͽ� �����Ͽ����ϴ�');
							}
						},
						error:function(request){console.log(request);}
					})
				});
				div.find("textarea").focus();
			<%}%>
		});
		function fn_loginAlert()
		{
			alert('�α��� �� �̿��� �� �ֽ��ϴ�.');
		}

		
		/* ��� ��� */
		$(function(){
			$('#btn-insert').click(function(){
				$.ajax({
					url:"<%=request.getContextPath()%>/gallery/commentInsert",
					data:{"groupNo":$('#groupNo').val(),
						"galNo":$('#galNo').val(),
						"galCommentWriterNo":$('#galCommentWriterNo').val(),
						"galCommentLevel":$('#galCommentWriterNo').val(),
						"galCommentRef":$('#galCommentLevel').val(),
						"albumCode":$('#albumCode').val(),
						"galFileNo":$('#galFileNo').val(),
						"galCommentContent":$('#galCommentContent').val(),
						"dataNum":2
					},
					type:"post",
					success:function(data){
						if(data!=null)
						{	
							alert('��� ��� �Ϸ�!');
							$('.comment-editor').html(data);
						}
						else
						{
							alert('��� ��Ͽ� �����Ͽ����ϴ�');
						}
					},
					error:function(request){console.log(request);}
				});					
			});
		});
	});
</script>