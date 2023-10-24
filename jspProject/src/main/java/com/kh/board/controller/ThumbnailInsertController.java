package com.kh.board.controller;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.tomcat.util.http.fileupload.servlet.ServletFileUpload;

import com.kh.board.model.service.BoardService;
import com.kh.board.model.vo.Board;
import com.kh.common.MyFileRenamePolicy;
import com.kh.common.model.vo.Attachment;
import com.oreilly.servlet.MultipartRequest;

/**
 * Servlet implementation class ThumbnailInsertController
 */
@WebServlet("/insert.th")
public class ThumbnailInsertController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ThumbnailInsertController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		
		if (ServletFileUpload.isMultipartContent(request)) {
			//1_1)파일용량제한
			int maxSize = 10*1024*1024;
			
			//1_2)전달된 파일을 저장시킬 폴더의 경로 알아내기
			String savePath = request.getSession().getServletContext().getRealPath("/resources/thumbnail_upfile/");
			
			//2 전달된 파일 업로드(request 변환)
			MultipartRequest multiRequest = new MultipartRequest(request, savePath, maxSize, "UTF-8", new MyFileRenamePolicy());
			
			//3. DB에 기록할 값 추출하기
			Board b = new Board();
			b.setBoardWriter(multiRequest.getParameter("userNo"));
			b.setBoardTitle(multiRequest.getParameter("title"));
			b.setBoardContent(multiRequest.getParameter("content"));
			
			//Attachment에 여러번 insert할 데이터 추출
			ArrayList<Attachment> list = new ArrayList<>();
			for(int i = 1; i <= 4; i++) {
				String key = "file" + i;
				if (multiRequest.getOriginalFileName(key) != null) {
					//첨부파일이 존재할 경우
					//Attachment 생성 + 원본명, 수정된파일명, 폴더경로, 파일레벨 => list에 담기
					
					Attachment at = new Attachment();
					at.setOriginName(multiRequest.getOriginalFileName(key));
					at.setChangeName(multiRequest.getFilesystemName(key));
					at.setFilePath("resources/thumbnail_upfile/");
					
					if(i == 1) { //대표이미지
						at.setFileLevel(1);
					} else { // 상세이미지
						at.setFileLevel(2);
					}
					
					list.add(at);
				}
			}
			
			int result = new BoardService().insertThumbnailBoard(b, list);
			
			if (result > 0) { //성공 => /jsp/list.th url재요청
				request.getSession().setAttribute("alertMsg", "성공적으로 게시글 등록하였습니다");
				response.sendRedirect(request.getContextPath() + "/list.th");
				
			} else { //실패 => 에러페이지 
				request.setAttribute("errorMsg", "사진게시글 작성 실패");
				request.getRequestDispatcher("views/common/errorPage.jsp").forward(request, response);
			}
			
			
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