package kr.or.ddit.vo;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.Data;

// 자바빈 클래스
// Pojo
@Data
public class CardVO {
	
	private String userId;
	private String no;
	@DateTimeFormat(pattern="yyyy-MM-dd")
	private Date validMonth;	// 2022-11-01
	
}
