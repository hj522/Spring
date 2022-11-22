package kr.or.ddit.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import kr.or.ddit.service.BookService;
import kr.or.ddit.vo.BookVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@RequestMapping("/book")
@Controller
public class BookController {

	@Autowired
	BookService bookService;
	
	@GetMapping("/list")
	public String list(Model model) {
		
		List<BookVO> bookVOList = this.bookService.list();
		log.info("bookVOList: " + bookVOList);
		
		// 공통 약속
		model.addAttribute("bodyTitle", "도서 목록");
		model.addAttribute("bookVOList", bookVOList);
				
		// forwarding
		return "book/list";
	}
	
	// 요청URI: /book/detail?bookId=3
	// 요청파라미터: bookId=3
	// 메소드 이름: detail
	// 목록에서 title을 클릭 시 상세페이지로 이동
	/*	1) 스프링에서 요청파라미터를 매개변수로 받을 수 있다. 요청파라미터는 String타입. int형 매개변수로도 받을 수 있음(자동 형변환 가능)
			- 매개변수: String bookId / int bookId
		2) Map<String, String> / Map<String, Object> 가능 
		3) 골뱅이ModelAttribute BookVO bookVO 
		4) 골뱅이RequestParam Map<String, String> / Map<String, Object> 가능 */
	@GetMapping("/detail")
	public String detail(@RequestParam String bookId, @ModelAttribute BookVO bookVO, Model model) {
		
		BookVO data = this.bookService.detailBook(bookVO);
		log.info("bookVO: " + bookVO.toString());
		
		// 공통 약속
		model.addAttribute("bodyTitle", "도서 상세");
		model.addAttribute("data", data); 
		
		return "book/detail";
	}
	
	@PostMapping("/updatePost")
	public String updatePost(@ModelAttribute BookVO bookVO) {
		
		log.info("bookVO: " + bookVO.toString());
		
		// merge into에 의해 bookId가 변경될 것이므로 미리 bookId를 받아놓자
		int bookId = bookVO.getBookId();
		// updatePost(bookVO) -> insertPost(bookVO)
		int result = this.bookService.updateBook(bookVO);
		log.info("result: " + result);
		
//		return "redirect:/book/detail?bookId="+bookVO.getBookId();
		return "redirect:/book/detail?bookId="+bookId;
		
		// jsp에 name값 줬는지 확인!!!! 그래야 값이 입력됩니다
	}
	
	@PreAuthorize("hasRole('ROLE_ADMIN')")
	@GetMapping("/insert")
	public String insert(Model model) {
		
		model.addAttribute("bodyTitle", "도서 등록");
		
		return "book/insert";
	}
	
	@PostMapping("/insertPost")
	public String insertPost(@ModelAttribute BookVO bookVO) {
		
		log.info("bookVO: " + bookVO.toString());

		// 도서 입력
		int result = this.bookService.insertBook(bookVO);
		log.info("result: " + result);
		
		// bookVO.getBookId()는 매퍼 xml의 selectKey를 통해 채워질 것임!
		return "redirect:/book/detail?bookId="+bookVO.getBookId();
	}
	
}

