package com.kook.ezenPJT.dao;

import java.util.ArrayList;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;

import com.kook.ezenPJT.dto.AuthUserDto;
import com.kook.ezenPJT.dto.DashBoardDto;
import com.kook.ezenPJT.dto.EzenBoardDto;
import com.kook.ezenPJT.dto.EzenJoinDto;
import com.kook.ezenPJT.dto.FullCalendarDto;
import com.kook.ezenPJT.dto.RecipeDto;
import com.kook.ezenPJT.dto.RecipeOrderDto;

public class EzenDao implements IEzenDao {
	@Autowired
	private SqlSession sqlSession;
	
	/*join처리*/
	@Override
	public String join(EzenJoinDto dto) {
		String result = null;
		try {
			int res = sqlSession.insert("join", dto);
			
			System.out.println(res);
			if(res > 0) {
				result = "success";
			}
			else {
				result = "failed";
			}
		}
		catch(Exception e) {
			e.getMessage();
			result = "failed"; 
		}
		return result;
	}
	
	/*login 처리 */
	@Override
	public EzenJoinDto login(String pid) {
		System.out.println(pid);
		EzenJoinDto result = sqlSession.selectOne("login",pid);
		return result;
	}
	
	/*main의 recipe view */
	@Override
	public ArrayList<RecipeDto> recipeList() {
		System.out.println("recipeList");
		ArrayList<RecipeDto> dtos =  (ArrayList)sqlSession.selectList("recipeList");
		return dtos;
	}
	
	/* recipe에서 recipe등록 */
	@Override
	public String recipeWrite(RecipeDto dto) {
		System.out.println("recipeWrite");
		String result;
		int res = sqlSession.insert("recipeWrite",dto);
		if(res == 1) {
			result = "success";
		}
		else {
			result = "failed";
		}
		
		return result;
	}
	
	/*레시피 상세정보 */
	@Override
	public RecipeDto recipeDetails(int rId) {
		System.out.println("recipeDetails");
		RecipeDto dto = sqlSession.selectOne("recipeDetails",rId);	
		return dto;
	}
	
	@Override
	public void recipeOrder(RecipeOrderDto dto) {
		System.out.println("recipeOrder DB처리");
		int res = sqlSession.insert("recipeOrder",dto);
	}
	//레시피 주문 내역
	public ArrayList<RecipeOrderDto> recipeOrderList(String oUser){
		System.out.println("recipeOrderList DB");
		ArrayList<RecipeOrderDto> dtos = (ArrayList)sqlSession.selectList("recipeOrderList",oUser);
		return dtos;
	}
	
	/*authAdmin */
	@Override
	public String adminAuth(String pid,String auth) {
		EzenJoinDto dto = new EzenJoinDto(pid,auth);
		int res = sqlSession.update("adminAuth",dto);
		System.out.println("auth res " + res);
		if(res > 0 ) {
			return "success";
		}
		else {
			return "failed";
		}
	}
	
	/*EBoard list*/
	@Override
	public ArrayList<EzenBoardDto> list() {
		ArrayList<EzenBoardDto> dtos = (ArrayList)sqlSession.selectList("list");		
		return dtos;
	}
	
	//searchList
	@Override
	public ArrayList<EzenBoardDto> searchList() {
		ArrayList<EzenBoardDto> dtos = (ArrayList)sqlSession.selectList("searchList");		
		return dtos;
	}
	
	/*EBoard page list */
	@Override
	public ArrayList<EzenBoardDto> pageList(String pageNo) {
		System.out.println("pageList");
		int page = Integer.parseInt(pageNo);
		int startNo = (page-1) * 10 +1;
		System.out.println("startNo : " + startNo);
		ArrayList<EzenBoardDto> result = (ArrayList)sqlSession.selectList("pageList",startNo);
		return result;
	}
	
	/*Ebaoard write */
	@Override
	public void bWrite(String name,String title,String content) {
		EzenBoardDto dto = new EzenBoardDto(name,title,content);
		sqlSession.insert("bWrite",dto);
	}
	
	/*게시판 내용 보기 */
	@Override
	public EzenBoardDto contentView(String bid) {
		int bId = Integer.parseInt(bid);
		upHit(bId);		
		EzenBoardDto dto = sqlSession.selectOne("contentView",bId);
		return dto;
	}
	
	/*히트수 올리기 */
	@Override
	public void upHit(int bId) {
		sqlSession.update("upHit",bId);
	}
	
	/*게시판 수정 */
	@Override
	public void modify(EzenBoardDto dto) {
		sqlSession.update("modify",dto);
	}
	
	/*게시판 삭제 */
	@Override
	public void delete(int bId) {
		int res = sqlSession.delete("delete",bId);
	}
	
	/*게시판 댓글 창 보여 주기 */
	@Override
	public EzenBoardDto replyView(int bId) {
		System.out.println("댓글창 보여주기");
		EzenBoardDto dto = sqlSession.selectOne("replyView",bId);
		return dto;
	}
	
	/*댓글 내용 저장 */
	@Override
	public void reply(EzenBoardDto dto) {
		System.out.println("댓글내용 저장 하기");
		replyShape(dto.getbGroup(), dto.getbStep());
		int res = sqlSession.insert("reply",dto);
	}
	
	/*댓글 모양 처리 */
	@Override
	public void replyShape(int bGroup,int bStep) {
		EzenBoardDto dto = new EzenBoardDto(bGroup,bStep);
		int res = sqlSession.update("replyShape",dto);
	}
	
	/*캘린더 insert */
	public void calendarInsert(FullCalendarDto dto) {
		System.out.println("캘린더 insert DB");
		int res = sqlSession.insert("calendarInsert",dto);
	}
	
	//캘린더 리스트 처리
	@Override
	public ArrayList<FullCalendarDto> calendarList(String cId) {
		System.out.println("캘린더 list DB처리");
		ArrayList<FullCalendarDto> list = (ArrayList)sqlSession.selectList("calendarList",cId);
		return list;
	}
	
	//캘린더 업데이트 처리
	@Override
	public void calendarUpdate(FullCalendarDto dto) {
		System.out.println("캘린더 update DB처리");
		int res = sqlSession.update("calendarUpdate",dto);
	}
	
	//캘린더 일정 삭제
	@Override
	public void calendarDelete(FullCalendarDto dto) {
		System.out.println("캘린더 Delete DB처리");
		int res = sqlSession.delete("calendarDelete",dto);
	}
	
	//dashboard
	@Override
	public ArrayList<DashBoardDto> dashBoardList() {
		System.out.println("dashboard DB처리");
		ArrayList<DashBoardDto> dtos =(ArrayList)sqlSession.selectList("dashBoardList");
		return dtos;
	}
	
	@Override
	public void dashBoardWrite(DashBoardDto dto) {
		System.out.println("dashboard DB 입력 처리");
		int res = sqlSession.insert("dashBoardWrite",dto);
	}
	
	//Auth처리
	@Override
	public void authDB(AuthUserDto dto) {
		System.out.println("Auth DB  처리");
		String authUsername = dto.getAuthUsername();
		AuthUserDto result = sqlSession.selectOne("authDB",authUsername);
		if(result == null) {
			authInsert(dto);			
		}		
	}
	
	@Override
	public void authInsert(AuthUserDto dto) {
		System.out.println("Auth DB insert 처리");
		int res = sqlSession.insert("authInsert",dto);
	}
	
	@Override
	public AuthUserDto authLogin(String username) {
		System.out.println("Auth DB 로그인 처리");
		AuthUserDto dto = sqlSession.selectOne("authLogin",username);
		return dto;
	}

}
