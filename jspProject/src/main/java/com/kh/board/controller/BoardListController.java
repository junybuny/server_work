package com.kh.board.controller;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.kh.board.model.service.BoardService;
import com.kh.board.model.vo.Board;
import com.kh.common.model.vo.PageInfo;

/**
 * Servlet implementation class BoardListController
 */
@WebServlet("/list.bo")
public class BoardListController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public BoardListController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//---------------------- 페이징처리 ----------------------
		int listCount; // 현재 총 게시글 수
		int currentPage; // 현재 페이지(즉, 사용자가 요청한 페이지)
		int pageLimit; // 페이지 하단에 보여질 페이징바의 페이지 최대 갯수(10개)
		int boardLimit; // 한 페이지에 보여질 게시글의 최대 갯수
		// 위 4개의 값을 기준으로 아래 3개의 값을 구할 것이다.
		
		int maxPage; // 가장 마지막 페이지(총 페이지의 수)
		int startPage; // 페이징바의 시작수
		int endPage; // 페이징바의 끝수
		
		// *listCount : 총 게시글 수
		listCount = new BoardService().selectListCount();
		
		// *currentPage : 현재 페이지(즉, 사용자가 요청한 페이지)
		currentPage = Integer.parseInt(request.getParameter("cpage"));
		
		// *pageLimit : 페이징바의 최대 갯수(단위)
		pageLimit = 10;
		
		// *boardLimit : 한 페이지에 보여질 게시글의 최대 갯수(단위)
		boardLimit = 10;
		
		/**
		 * *maxPage : 제일 마지막 페이지 수(총 페이지의 수)
		 * 
		 * listCount, boardLimit에 영향을 받음
		 * 
		 * ex) 게시글이 10개 단위씩 보여진다는 가정하에
		 * 	listCount 		boardLimit	나눈값		maxPage
		 * 		100.0			10		=>10.0		10
		 * 		101.0			10		=>10.1		11
		 * 		105.0			10		=>10.5		11
		 * 		110.0			10		=>11.0		11
		 * 
		 * ex) 게시글이 5개 단위씩 보여진다는 가정하에
		 * listCount 		boardLimit	나눈값		maxPage
		 * 		10.0			5		=>2.0		2
		 * 		11.0			5		=>2.1		3
		 * 		14.0			5		=>2.4		3
		 * 
		 * 총 게시글 갯수(실수) / boardLimit => 올림처리
		 */
		
		maxPage = (int)Math.ceil((double)listCount / boardLimit);
		
		/**
		 * *startPage : 페이징바 시작수
		 * 
		 *  pageLimit, currentPage에 영향을 받음
		 *  
		 *  ex) 페이징바의 목록이 10단위씩이라는 가정하에
		 *  	startPage : 1, 11, 21, 31 ...
		 *  			=> n*10 + 1
		 *  			=> n*pageLimit + 1
		 *  
		 *  1~10	=> n=0(1페이지)
		 *  11~20	=> n=1(2페이지)
		 *  21~30	=> n=2
		 *  ...
		 *  
		 */
		
		startPage = ((currentPage - 1) / pageLimit) * pageLimit + 1;
		
		/**
		 * *endPage : 페이징바의 끝수
		 * 
		 * startPage, pageLimit에 영향을 받음
		 * 
		 * pageLimit에 : 10이라는 가정하에
		 * 
		 * startPage : 1 => endPage : 10
		 * startPage : 11 => endPage : 20
		 * startPage : 21 => endPage : 30
		 * 
		 */
		
		endPage = startPage + pageLimit - 1;
		
		// startPage가 11이면 endPage는 20이 됨 (만약 maxPage가 13이라면?)
		endPage = endPage > maxPage ? maxPage : endPage;
		
		PageInfo pi = new PageInfo(listCount, currentPage, pageLimit, boardLimit, maxPage, startPage, endPage);

		ArrayList<Board> list = new BoardService().selectList(pi);
	
		request.setAttribute("pi", pi);
		request.setAttribute("list", list);
		
		request.getRequestDispatcher("views/board/boardListView.jsp").forward(request, response);
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
