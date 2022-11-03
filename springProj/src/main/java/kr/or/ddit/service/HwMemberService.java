package kr.or.ddit.service;

import java.util.List;
import java.util.Map;

import kr.or.ddit.vo.CardVO;
import kr.or.ddit.vo.HwMemberVO;
import kr.or.ddit.vo.MemberVO;


// 서비스 interface: 비즈니스 로직
public interface HwMemberService {

	// 메소드 시그니처
	public List<HwMemberVO> list(Map<String, String> map);

	public int insert(HwMemberVO hwMemberVO);

	public int getTotal(Map<String, String> map); 	// HW_MEMBER 전체 행의 수 구하기

	public int chkDup(String memId);	// 아이디 중복 체크

}
