package com.kh.member.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.kh.member.model.service.MemberService;


/**
 * Servlet implementation class MemberDeleteController
 */
@WebServlet("/delete.me")
public class MemberDeleteController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public MemberDeleteController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		/**
		 * 요청 실행할 sql
		 * UPDATE MEMBER
		 * 		SET STATUS = 'N'
		 * 			, MODIFY_DATE = SYSDATE
		 * WHERE USER_ID = ?
		 * AND USER_PWD = ?
		 * 
		 * (정보변경, 비밀번호 변경처럼 갱신된 회원 다시 조회할 필요 없음)
		 * 
		 * 성공했을 경우 => 메인페이지에서 alert(성공적으로 회원탈퇴 되었습니다. 그동안~)
		 * 				단, 로그아웃되어있어야만한다(세션에 loginUser라는 키값에 해당하는 속성 지우기)
		 * 실패했을 경우 => 마이페이지 alert(회원탈퇴 실패)
		 */
		
		request.setCharacterEncoding("UTF-8");
		
		String userId = request.getParameter("userId");
		String userPwd = request.getParameter("userPwd");
		
		int result = new MemberService().deleteMember(userId, userPwd);
		
		HttpSession session = request.getSession();
		
		if (result > 0) { // 성공
			session.setAttribute("alertMsg", "성공적으로 회원탈퇴 되었습니다.");
			session.removeAttribute("loginUser");
			
			response.sendRedirect(request.getContextPath());
		} else {
			session.setAttribute("alertMsg", "회원탈퇴에 실패하였습니다.");
			response.sendRedirect(request.getContextPath() + "/myPage.me");
			
		}
		
	}
		

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
