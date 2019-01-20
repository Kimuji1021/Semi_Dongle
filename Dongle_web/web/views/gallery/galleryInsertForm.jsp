<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@page import="com.dongle.member.model.vo.Member" %>
<%
	int groupNo=(int)request.getAttribute("groupNo");
	String albumCode = (String)request.getAttribute("albumCode");
	Member loginMember = (Member)request.getSession().getAttribute("loginMember");
%>
<meta charset="EUC-KR">
<style>
div.all-div div.back-div{padding-left:50px;padding-top:50px;}
div.all-div div.back-div a.list_btn{text-decoration:none;}
div.all-div div.back-div a.list_btn img.back_icon{width:10px;height:10px;}
img.selProductFile{width:10%; height:10%;}
img.selProductFile:hover{background-color:rgb(200,200,200);}
div.all-div div.input_wrap{padding-left:50px;padding-top:20px;}
div.imgs_wrap{padding-left:50px;padding-bottom:30px;padding-right:50px;}
div h5{padding-left:50px;}
div.imgs_textarea{background-color:rgb(228,228,228);margin-top:10px;height:120px;border-top:1px solid rgb(200,200,200);}
div.imgs_textarea textarea#galFileContent{margin-left:50px;margin-top:15px;resize:none;box-sizing: border-box;width:80%;height:80;border:1px solid #fff;}
div.imgs_textarea a.my_button{float:right;padding-right:50px;}
div.all-div span#fname{position:absolute;margin-left:128px;margin-top:-20px;background-color:white;width:40%;}
</style>
<div>
	<div class='all-div'>
		<div class='back-div'>
			<a href='javascript:' class='list_btn'>
				<img class='back_icon' src='<%=request.getContextPath()%>/images/gallery/back.png' title='�������'>
			</a>
		</div>
		<div class='input_wrap'>
			<br>
			<a href='javascript:' onclick='fileUploadAction();' class='my_button'>���� ���ε�</a>
			<input type='file' id='input_imgs' name='input_imgs' multiple/>
			
		</div>
	</div>
	<div>
		<hr style='width:85%'>
		<h5>�̸�����</h5>
		<div class='imgs_wrap'>
			<img id='img'/>
		</div>
	</div>
	<div class='imgs_textarea'>
		<textarea name="galFileContent" id='galFileContent' placeholder="������ �Է����ּ���." tabindex='3'></textarea>
		<br><br>
		<a href='javascript:' onclick='submitAction();' class='my_button'>���� �ø���</a>
	</div>
	
</div>

<script type='text/javascript'>
	//�̹��� �������� ���� �迭 ����
	var sel_files = [];
	
	$(document).ready(function(){
		$('#input_imgs').on('change', handleImgFileSelect);
	});
	
	function fileUploadAction(){
		console.log('fileUploadAction');
		$('#input_imgs').trigger('click');
	}
	
	function handleImgFileSelect(e){
		//�̹��� �������� �ʱ�ȭ
		sel_files = [];
		$('.imgs_wrap').empty();
		var files=e.target.files;
		var filesArr=Array.prototype.slice.call(files);
		
		var index = 0;
		console.log(filesArr.length);
		if(filesArr.length>=10)
		{
			alert('�̹����� 10������ ��� �����մϴ�.');
			$("#fname").remove();
			fname="<span id='fname'>��ϵ� ������ �����ϴ�.</span>";
			$(".all-div ").append(fname);
			return false;
		}
		filesArr.forEach(function(f){
			if(!f.type.match("image.*")){
				alert('Ȯ���ڴ� �̹��� Ȯ���ڸ� �����մϴ�.');
				return;
			}
			sel_files.push(f);
			var reader = new FileReader();
			reader.onload=function(e){
				var html = "<a href='javascript:void(0);' onclick='deleteImageAction("+index+")' id='img_id_"+index+"'><img src='"+e.target.result+"' data-file='"+f.name+"' class='selProductFile' name='selProductFile' title='Ŭ���ؼ� �����ϱ�'></a>";
				$(".imgs_wrap").append(html);
				index++;
			}
			reader.readAsDataURL(f);
			
			
		})
	}
</script>

<script>
//���� ���� �̸����⿡�� Ư�� �̹����� �����ϱ�
function deleteImageAction(index){
	console.log("index: "+index);
	//splice(start,count) : start���� count���� �����ϴ� ��
	sel_files.splice(index,1);
	//�Ʒ��� a�±� id���� �޾Ƽ� �����ϴ� ��
	var img_id = "#img_id_"+index;
	$(img_id).remove();
	console.log(sel_files.length);
	
	if((index+1)!=$('.imgs_wrap').children().length)
	{
		var fname="";
		$("#fname").remove();
		if(sel_files.length==0||sel_files.length>=10)
		{
			fname="<span id='fname'>��ϵ� ������ �����ϴ�.</span>";
		}
		else
		{
			fname="<span id='fname'>���� "+sel_files.length+"��</span>";
		}
		$(".all-div ").append(fname);
	}
	
}
</script>

<script>
//���� ���� POST����
// ���õ� �̹������� ������ ���ε��ϱ�
function submitAction(){
	var content = $('[name=galFileContent]').val();
	if(sel_files.length==0)
	{
		//�Էµ� ������ 0�̸� ���
		alert('���ε� ������ �����ϴ�.');
		return false;
	}
	if(content.trim().length==0)
	{
		//��������� �Է��ش޶�� ���!
		alert('������ �Է��ϼ���.');
		return false;
	}
	
	//���� �ޱ� ���� ��ü
	var data = new FormData();
	data.append('groupNo',<%=groupNo%>);
	data.append('memberNo',<%=loginMember.getMemberNo()%>);
	data.append('albumCode','<%=albumCode%>');
	data.append('galFileContent',$('#galFileContent').val());
	
	for(var i=0, len=sel_files.length; i<len; i++){
		var name = "image_"+i;
		data.append(name, sel_files[i]);
	}
	data.append("image_count",sel_files.length);
	$.ajax({
		url:"<%=request.getContextPath()%>/gallery/insertGalleryEnd",
		data:data,
		type:'post',
		processData:false,
		contentType:false,
		success:function(data)
		{
			alert('Message: '+data);
			$.ajax({
				url:"<%=request.getContextPath()%>/gallery/galleryGet?groupNo=<%=groupNo%>&albumCode=<%=albumCode%>",
				dataType:"html",
				success:function(data){
					$('#content-div').html(data);
				},
				error:function(request){
				}
			});
		}
	});
};

</script>
<script>
$(function(){
	$(".back_icon").click(function(){
		$.ajax({
			url:"<%=request.getContextPath()%>/gallery/albumGet?groupNo=<%=groupNo%>&memberNo=<%=loginMember.getMemberNo()%>",
			type:"post",
			dataType:"html",
			success:function(data){
				$('#content-div').html(data);
			},
			error:function(request){},
			complate:function(){console.log("ok");}
		});
	});
});
</script>