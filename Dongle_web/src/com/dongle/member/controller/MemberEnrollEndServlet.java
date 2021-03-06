package com.dongle.member.controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.dongle.member.model.vo.Member;
import com.dongle.member.model.service.MemberService;


/**
 * Servlet implementation class MemberEnrollEndServlet
 */
@WebServlet("/memberEnrollEnd")
//@WebServlet(name="MemberEnrollEndServlet",
//
//			urlPatterns="/memberEnrollEnd")
public class MemberEnrollEndServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public MemberEnrollEndServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		//가입데이터를 받아오기~! 
		request.setCharacterEncoding("UTF-8");
		
		
		String userId=request.getParameter("userId");
		String password=request.getParameter("password");
		String passwordHint = request.getParameter("pwdHint");
		String passwordAnswer = request.getParameter("hintAnswer");
		String userName=request.getParameter("userName");	
		String gender=request.getParameter("gender");
		String ssn=request.getParameter("age");
		String phone=request.getParameter("phone");
		String address=request.getParameter("address");
		String email=request.getParameter("email");
		
		System.out.println(userId+password+passwordHint+passwordAnswer+userName+ssn+gender+phone+address+email);
		
		Member m=new Member();
		m.setMemberId(userId);
		m.setMemberName(userName);
		m.setMemberPwd(password);
		m.setGender(gender);
		m.setAddress(address);
		m.setSsn(ssn);
		m.setEmail(email);
		m.setPhone(phone);
		m.setPwdHintList(passwordHint);
		m.setPwdHintAnswer(passwordAnswer);
		
		int result=new MemberService().insertMember(m);
		
		String view="/Dongle_view/msg.jsp";
		String loc="";
		String msg="";
		
		if(result>0)
		{
			msg="회원가입이 완료되었습니다!";
			loc="/";
		}
		else
		{
			msg="회원가입을 실패하였습니다.!";
			loc="/Dongle_view/enrollMember.jsp";
		}
		//응답객체에 데이터넣어야함
		request.setAttribute("msg", msg);
		request.setAttribute("loc", loc);
		
		RequestDispatcher rd=request.getRequestDispatcher(view);
		rd.forward(request, response);		
	}
	

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
