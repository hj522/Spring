package kr.or.ddit.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.ddit.service.GalleryService;
import kr.or.ddit.vo.BookVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@RequestMapping("/gallery")
@Controller
public class GalleryController {
	
	// DI(의존성 주입)
	@Autowired
	GalleryService galleryService;
	
	@GetMapping("/list")
	public String list(Model model, @ModelAttribute BookVO bookVO) {
	
		bookVO = this.galleryService.list(bookVO);
		log.info("bookVO: " + bookVO);
		
		model.addAttribute("bodyTitle", "이미지 갤러리");	// 공통 약속
		model.addAttribute("bookVO", bookVO);
		
		return "gallery/list";	// forwarding
	}
	
	// 요청URI: /gallery/bookList
	// 방식: get
	// 도서 목록 가져와서 select에 추가하기
	// json 데이터로 리턴
	@ResponseBody
	@GetMapping("/bookList")
	public List<BookVO> bookList() {
		List<BookVO> bookVOList = this.galleryService.bookList();
		
		log.info("bookVOList : " + bookVOList);
		
		return bookVOList;
	}

	@GetMapping("/regist")
	public String regist() {
		
		return "gallery/regist";
	}
}
