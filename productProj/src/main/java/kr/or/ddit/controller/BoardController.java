package kr.or.ddit.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import lombok.extern.slf4j.Slf4j;

// 클래스 레벨
@RequestMapping("/board")
@Slf4j
@Controller
public class BoardController {
	@GetMapping("/list")
	public String list() {
		log.info("list: access to all");
		
		return "board/list";	// forwarding
	}
	
	@GetMapping("/register")
	public String registerForm() {
		log.info("registerForm: access to member");	// 멤버만 접속할 수 있도록 막기
		
		return "board/register"; 
	}
}
