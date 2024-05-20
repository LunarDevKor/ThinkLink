package kr.or.ddit.groupware.controller.employee;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.google.zxing.BarcodeFormat;
import com.google.zxing.MultiFormatWriter;
import com.google.zxing.WriterException;
import com.google.zxing.client.j2se.MatrixToImageWriter;
import com.google.zxing.common.BitMatrix;

import kr.or.ddit.groupware.service.employee.DclzServiceImpl;
import kr.or.ddit.groupware.service.employee.IDclzService;
import kr.or.ddit.groupware.service.employee.IEmployeeService;
import kr.or.ddit.groupware.vo.CustomUser;
import kr.or.ddit.groupware.vo.EmployeeVO;

import com.google.zxing.BarcodeFormat;
import com.google.zxing.MultiFormatWriter;
import com.google.zxing.WriterException;
import com.google.zxing.client.j2se.MatrixToImageWriter;
import com.google.zxing.common.BitMatrix;


import com.google.zxing.WriterException;

/**
 * QR 컨트롤러
 * @author <strong>권예은</strong>
 * @version 1.0
 * @see QRController
 */
@Controller
@RequestMapping("/qr")
public class QRController {
	
	private static String baseUrl = "http://192.168.0.10/qr/attend?emplNo=";

	CustomUser customUser;
	EmployeeVO loginUser;
	
	@Inject
	IDclzService dclzService;
	
	@Inject
	IEmployeeService emplService;
	
	/**
	 * 
	 * @author <strong>권예은</strong>
	 * @return 
	 */
	@GetMapping("")
	public String main(Model model, String deptCode) {
		
		customUser = (CustomUser) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		loginUser = customUser.getEmployeeVO();
		
		model.addAttribute("empl", loginUser);
		 return "qr/myqr";
	}
	
	@GetMapping("/showqr")
	public ResponseEntity<byte[]> showQRCode (Model model, String empNo) throws Exception{
		return generateQrCode(300, empNo);
	}
	
	@GetMapping("/attend")
	public String attend(String emplNo, Model model) {
		
		dclzService.insertDclz(emplNo);
		
		EmployeeVO empl = emplService.selectEmployee(Integer.parseInt(emplNo));

		model.addAttribute("empl", empl);
		
		return "qr/result";
	}

	/**
	 * 주어진 ID를 디바이스에서 식별 가능한 QR코드(PNG)로 변환합니다.
	 * @param size : 생성할 QR코드 크기
	 * @param id : 식별 ID
	 * @return PNG 타입의 QR코드 이미지
	 * @throws WriterException
	 * @throws IOException
	 */
	public static ResponseEntity<byte[]> generateQrCode(int size, String id) throws WriterException, IOException {
		return generateQrCode(size, id, "PNG");
	}
	
	/**
	 * 주어진 ID를 디바이스에서 식별 가능한 QR코드로 변환합니다.
	 * @param size : 생성할 QR코드 크기
	 * @param id : 식별 ID
	 * @param mediaType : 이미지 타입 (jpeg, jpg, png)
	 * @return QR코드 이미지
	 * @throws WriterException
	 * @throws IOException
	 */
	public static ResponseEntity<byte[]> generateQrCode(int size, String id, String mediaType) throws WriterException, IOException {
		
		String url = baseUrl + id;
		
		BitMatrix matrix = new MultiFormatWriter().encode(url, BarcodeFormat.QR_CODE, size, size);
		
		ByteArrayOutputStream out = new ByteArrayOutputStream();
		
		MatrixToImageWriter.writeToStream(matrix, mediaType.toUpperCase(), out);
		
		return ResponseEntity.ok().contentType(getMediaType(mediaType)).body(out.toByteArray());
		
	}
	
	private static Map<String, MediaType> mediaMap;
	
	// static 그룹 선언
	static {
		mediaMap = new HashMap<String, MediaType>();
		mediaMap.put("JPG", MediaType.IMAGE_JPEG);
		mediaMap.put("JPEG", MediaType.IMAGE_JPEG);
		mediaMap.put("PNG", MediaType.IMAGE_PNG);
	}
	
	public static MediaType getMediaType(String type) {
		return mediaMap.get(type.toUpperCase());
	}
	
}
