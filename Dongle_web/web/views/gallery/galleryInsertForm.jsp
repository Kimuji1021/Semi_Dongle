<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<meta charset="EUC-KR">
<div>
	<div>
		<h2>�̹��� �̸�����</h2>
		<div class='input_wrap'>
			<a href='javascript:' onclick='fileUploadAction();' class='up_btn'>���� ���ε�</a>
			<input type='file' id='input_img' multiple/>
		</div>
	</div>
	<div>
		<div class='imgs_wrap'>
			<img id='img'>
		</div>
	</div>
	<a href='javascript:' onclick='submitAction();' class='up_btn'>���ε�</a>
</div>

<script type='text/javascript'>
	//�̹��� �������� ���� �迭 ����
	var sel_files = [];
	
	$(document).ready(function(){
		$('#input_imgs').on('change', handleImgFileSelect);
	});
	
	function fuleUploadAction(){
		console.log('fileUploadAction');
		$('#input_imgs').trigger('click');
	}
	
	function handleImgFileSelect(e){
		
	}
	


</script>