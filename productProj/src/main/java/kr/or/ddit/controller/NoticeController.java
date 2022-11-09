package kr.or.ddit.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import lombok.extern.slf4j.Slf4j;

@RequestMapping("/notice")
@Slf4j
@Controller
public class NoticeController {
	@GetMapping("/list")
	public String list() {
		
		log.info("list: access to all");
		
		return "notice/list";	// forwarding
	}

	@GetMapping("/register")
	public String registerForm() {
		
		log.info("list: access to admin");
		
		return "notice/register";
	}
}
