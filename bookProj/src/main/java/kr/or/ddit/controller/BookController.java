package kr.or.ddit.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import kr.or.ddit.service.BookService;
import kr.or.ddit.vo.BookVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class BookController {
	
	@Autowired
	BookService bookService;
	
	// 도서 등록
	@RequestMapping(value="/addBook",method=RequestMethod.GET)
	public ModelAndView addBook() {
		
		ModelAndView mav = new ModelAndView();
		mav.setViewName("book/addBook");
		
		return mav;
	}
	
	@RequestMapping(value="/addBook",method=RequestMethod.POST)
	public ModelAndView addBookPost(ModelAndView mav, @ModelAttribute BookVO bookVO) {
		log.info("bookVO: " + bookVO.toString());
		
		int result = this.bookService.insert(bookVO);
		
		log.info("result: " + result);
		
		if(result<1) {
			mav.setViewName("redirect:/addBook");
		} else {
			mav.setViewName("redirect:/detail?bookId=" + bookVO.getBookId());
		}
		
		return mav;
	}
	
	// 도서 목록
	@RequestMapping(value="/books",method=RequestMethod.GET)
	public ModelAndView list(ModelAndView mav, @RequestParam(value="keyword", required=false) String keyword) {
		
		// Model
		List<BookVO> list = this.bookService.list(keyword);
		
		for(BookVO vo : list) {
			log.info("vo: " + vo.toString());
		}
		
		mav.setViewName("book/books");
		mav.addObject("data", list);
		
		return mav;
	}
	
	// 도서 상세
	@RequestMapping(value="/detail", method=RequestMethod.GET)
	public ModelAndView detail(ModelAndView mav, @ModelAttribute BookVO bookVO) {
		log.info("detail 확인");
		
		BookVO data = this.bookService.detail(bookVO);
		
		mav.setViewName("book/detail");
		mav.addObject("data", data);
		mav.addObject("bookId", data.getBookId());
		
		return mav;
	}
	
	public ModelAndView detail(ModelAndView mav, @RequestParam(value="keyword", required=false) String keyword) {
		
		List<BookVO> list = this.bookService.list(keyword);
		
		for(BookVO vo : list) {
			log.info("vo: " + vo.toString());
		}
		
		// forwarding
		mav.setViewName("book/list");
		mav.addObject("data", list);
		
		return mav;
	}
	
	
}
