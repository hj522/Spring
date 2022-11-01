package kr.or.ddit.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kr.or.ddit.vo.AttachVO;
import kr.or.ddit.vo.BookVO;
import kr.or.ddit.vo.CardVO;
import kr.or.ddit.vo.MemberVO;

// 매퍼xml(book_SQL.xml)을 실행시키는 DAO(Data Access Object) 클래스
// Repository 어노테이션: 데이터에 접근하는 자바빈 객체로 스프링에 등록해줌
// 프링아, 이거 데이터를 관리하는 특별한 클래스야. 
@Repository
public class MemberDAO {

	@Autowired
	SqlSessionTemplate sqlSessionTemplate;
	
	// MEMBER테이블에 insert
	public int memberInsert(MemberVO memberVO) {
		// .insert("namespace.id",파라미터)
		return this.sqlSessionTemplate.insert("member.memberInsert",memberVO);
	}
	
	// ADDRESS테이블에 insert
	public int addressInsert(MemberVO memberVO) {
		return this.sqlSessionTemplate.insert("member.addressInsert",memberVO);
	}
	
	// CARD 테이블에 insert
	public int insertCard(List<CardVO> cardVOList) {
		return this.sqlSessionTemplate.insert("member.insertCard",cardVOList);
	}
}
