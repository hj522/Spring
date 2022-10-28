package kr.or.ddit.controller;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.nio.file.Files;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.UUID;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;

import kr.or.ddit.vo.ItemVO;
import lombok.extern.slf4j.Slf4j;
import net.coobird.thumbnailator.Thumbnailator;

@RequestMapping("/item")
@Slf4j
@Controller
public class ItemController {
	
	private String uploadPath = "C:\\eclipse-jee-2020-06-R-win32-x86_64\\workspace\\productProj\\src\\main\\webapp\\resources\\upload";
	
	// 상품 등록 폼
	@GetMapping("/register")
	public String registerForm() {
		return "item/register";
	}
	
	// 상품 등록 실행
	// 요청 URI: /register
	// 방식: post
	@PostMapping("/register")
	public String register(ItemVO itemVO, Model model) {
		
		// itemVO: ItemVO [itemId=0, itemName=오레오 오즈, price=6500, description=맛나다 맛나,
		// pictureUrl=null, pictureUrl2=null, picture=org.springframework.web.multipart.support.StandardMultipartHttpServletRequest$StandardMultipartFile@232bb626, itemAttachVOList=null]
		log.info("itemVO: " + itemVO.toString());

		// <input type="file" name="picture" /> 파일 객체
		MultipartFile file = itemVO.getPicture();
		log.info("originalName: " + file.getOriginalFilename());
		
		// 파일 크기
		log.info("size: " + file.getSize());
		
		// MIME Type은?
		log.info("contentType: " + file.getContentType());
		
		// 파라미터: 원본 파일명, MultipartFile
		String createdFileName = uploadFile(file.getOriginalFilename(), file);
		
		model.addAttribute("msg", "등록이 완료되었습니다.");
		
		// forwarding
		return "item/success";
	}
	
	@GetMapping("/uploadForm")
	public String uploadForm() {
		// forwarding
		return "item/uploadForm";
	}
	
	// 다중 이미지 업로드
	// 요청 URI: /uploadFormAction
	// <input type="file" name="uploadFile" multiple />	 **name uploadFile 동일!!
	@PostMapping("/uploadFormAction")
	public String uploadFormAction(MultipartFile[] uploadFile, Model model) {
		// MultipartFile: 스프링에서 제공해주는 타입
		/*
		 	--잘 쓰는 방법
		 	String .. = file.getOriginalFilename() : 업로드 되는 파일의 이름(실제 파일명)
		 	boolean .. = file.isEmpty : 파일이 없다면 true
		 	long .. = file.getSize() : 업로드 되는 파일의 크기
		 	file.transferTo(File f) : 파일을 저장
		 	
		 	--잘 안쓰는 방법
		 	String .. = file.getName()
		 	byte[] .. = file.getBytes() : byte[]로 파일 데이터 변환
		 	InputStream .. = getInputStream() : 파일 데이터와 연결된 InputStream을 반환
		 */
		
		// make folder 시작 연/월/일------------------------
		File uploadFolder = new File(uploadPath, getFolder());
		log.info("uploadFolder: " + uploadFolder);
		
		// 만약에 upload>연>월>일 폴더가 없다면 생성
		if(uploadFolder.exists()==false) {
			uploadFolder.mkdirs();
		}
		// make folder 끝--------------------------

		// 파일 객체 배열로부터 파일 객체를 하나씩 꺼내오자
		for(MultipartFile multipartFile : uploadFile) {
			log.info("------------------");
			// 이미지명
			log.info("Upload File Name: " + multipartFile.getOriginalFilename());
			log.info("Upload File Size: " + multipartFile.getSize());
			// 서버의 어느 폴더로 복사할 것인지
			// 파일명은 어떻게 되는지
			String uploadFileName = multipartFile.getOriginalFilename();
			// ex) C:_upload_test.jpg 라면 test.jpg만 뽑아오겠다는 뜻
			uploadFileName.substring(uploadFileName.lastIndexOf("\\")+1);
			
			log.info("only file name: " + uploadFileName);
			
			// --------------- 같은 날 같은 이미지를 업로드 할 경우 파일 중복 방지 시작-----------
			// java.util.UUID => 랜덤값 생성
			UUID uuid = UUID.randomUUID();
			// 원래의 파일 이름과 구분하기 위해 _를 붙임
			uploadFileName = uuid.toString() + "_" + uploadFileName;
			// --------------- 같은 날 같은 이미지를 업로드 할 경우 파일 중복 방지 끝 ------------
			
			// File 객체 설계(복사할 대상 경로(서버쪽), 파일명(uuid가 붙은)
			File saveFile = new File(uploadFolder, uploadFileName);
			
			try {
				// 파일 복사 실행
				multipartFile.transferTo(saveFile);
				
				// 썸네일 처리 시작 -----------------------------------
				// 이미지인지 체킹
				if(checkImageType(saveFile)) {
					FileOutputStream thumbnail = new FileOutputStream(new File(uploadFolder,"s_"+uploadFileName));
					// 썸네일 생성
					Thumbnailator.createThumbnail(multipartFile.getInputStream(),thumbnail,100,100);
					thumbnail.close();
				}
				// 썸네일 처리 끝-------------------------------------
			} catch (IllegalStateException | IOException e) {
				log.error(e.getMessage());
			}
			
		} // end for
		
		model.addAttribute("message", "업로드 성공");
		// forwarding
		return "item/success";
	}
	
	// 연/월/일 폴더 생성
	public String getFolder() {
		
		// 간단한 날짜 형식
		// 2022-10-28 형식(format) 지정
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		
		// 날짜 객체 생성(java.util패키지)
		Date date = new Date();
		// 2022-10-28
		String str = sdf.format(date);
		
		// File.seperator는 폴더 형식으로 만듦
		return str.replace("-", File.separator);
	}
	
	// 이미지인지 체킹(썸네일 용)
	// 모바일과 같은 환경에서 많은 데이터를 소비해야 하므로
	// 이미지의 경우 특별한 경우가 아니면 썸네일을 제작해줘야 함
	public boolean checkImageType(File file) {
		/*
		 .jpeg / .jpg(JPEG 이미지)의 MIME 타입: image/jpeg
		 */
		// MIME 타입을 통해 이미지 여부 확인
		// file.toPath() : 파일 객체를 path객체로 변환
		String contentType;

		try {
			contentType = Files.probeContentType(file.toPath());
			log.info("contentType: " + contentType); // image/jpeg, image/png, image/gif
			// MIME 타입 정보가 image로 시작하는지 여부를 return
			return contentType.startsWith("image");

		} catch (IOException e) {
			e.printStackTrace();
		}
		return false;
	}
	
	// 파일을 복사(client 파일 -> 서버로 복사)
	// 파라미터: 파일명, 파일객체의 바이트
	private String uploadFile(String originalName, MultipartFile multipartFile) {
		
		// 랜덤 수를 생성
		UUID uid = UUID.randomUUID();
		
		// 동일 이름의 파일 덮어쓰기 방지
		String createdFileName = uid.toString() + "_" + originalName;
		
		// 복사 준비
		File target = new File(uploadPath, createdFileName);
		
		// 복사 실행
		try {
			multipartFile.transferTo(target);
		} catch(IllegalStateException e) {
			log.error(e.getMessage());
		} catch(IOException e) {
			log.error(e.getMessage());
		}
		return createdFileName;
	}
}
