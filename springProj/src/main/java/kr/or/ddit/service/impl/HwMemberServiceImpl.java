package kr.or.ddit.service.impl;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.or.ddit.dao.HwMemberDAO;
import kr.or.ddit.mapper.HwMemberMapper;
import kr.or.ddit.service.HwMemberService;
import kr.or.ddit.util.FileUploadUtil;
import kr.or.ddit.vo.HwMemberVO;

// 프링아. 이 클래스는 서비스 클래스야 라고 알려줌. 프링이가 자바빈으로 등록해줌
@Service
public class HwMemberServiceImpl implements HwMemberService {
	
	// DI(의존성 주입)
	@Inject
	HwMemberDAO hwMemberDao;
	
	@Autowired
	HwMemberMapper hwMemberMapper;
	
	@Inject
	FileUploadUtil fileUploadUtil;

	@Override
	public List<HwMemberVO> list(Map<String, String> map) {
		return this.hwMemberMapper.selectMember(map);
	}
	
	// 프링아. 트랜잭션 처리를 해주렴
	@Transactional
	@Override
	public int insert(HwMemberVO hwMemberVO) {
		// HW_MEMBER테이블에 insert
		this.hwMemberMapper.insertMember(hwMemberVO);
		
		// FileUploadUtil 활용 -> 업로드, ATTACH테이블에 insert
		return this.fileUploadUtil.fileUploadAction(hwMemberVO.getPictureArray(), hwMemberVO.getMemId());
	}
	
	// HW_MEMBER 전체 행의 수 구하기
	@Override
	public int getTotal(Map<String, String> map) {
		return this.hwMemberMapper.getTotal(map);
	}
	
	// 아이디 중복체크
	@Override
	public int chkDup(String memId) {
		return this.hwMemberMapper.chkDup(memId);
	}		
	
	// 상세보기
	@Override
	public HwMemberVO detail(String memId) {
		return this.hwMemberMapper.detail(memId);
	}
}