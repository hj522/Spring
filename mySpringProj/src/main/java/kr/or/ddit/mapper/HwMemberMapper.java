package kr.or.ddit.mapper;

import java.util.List;
import java.util.Map;

import kr.or.ddit.vo.HwMemberVO;

// mapper interface
public interface HwMemberMapper {
	
	// 회원 리스트
	public List<HwMemberVO> selectMember(Map<String,String> map);
	
	// 회원 추가
	public int insertMember(HwMemberVO hwMemberVO);
	
	// HW_MEMBER 전체 행의 수 구하기
	public int getTotal(Map<String, String> map);
	
	// 아이디 중복체크
	public int chkDup(String memId);
	
	// 상세 보기
	public HwMemberVO detail(String memId);
}
