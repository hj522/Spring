package kr.or.ddit.dao;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kr.or.ddit.vo.AttachVO;
import kr.or.ddit.vo.HwMemberVO;
import kr.or.ddit.vo.MemberVO;

// 매퍼xml(book_SQL.xml)을 실행시키는 DAO(Data Access Object) 클래스
// Repository 어노테이션: 데이터에 접근하는 자바빈 객체로 스프링에 등록해줌
// 프링아, 이거 데이터를 관리하는 특별한 클래스야. 
@Repository
public class HwMemberDAO {

	@Autowired
	SqlSessionTemplate sqlSessionTemplate;
	
	public List<HwMemberVO> list(Map<String, String> map) {
		return this.sqlSessionTemplate.selectList("hwMember.selectMember", map);
	}

	public int insert(HwMemberVO hwMemVO) {
		return this.sqlSessionTemplate.insert("hwMember.insertMember", hwMemVO);
	}
	
	// HW_MEMBER 전체 행의 수 구하기
//	   <select id="getTotal" resultType="int">
	public int getTotal(Map<String, String> map) {
		return this.sqlSessionTemplate.selectOne("hwMember.getTotal", map);
	}
}
