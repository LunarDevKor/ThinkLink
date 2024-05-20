package kr.or.ddit.groupware.util;

import java.io.File;
import java.io.IOException;
import java.nio.charset.StandardCharsets;
import java.text.MessageFormat;
import java.util.List;
import java.util.UUID;

import javax.annotation.Resource;

import org.apache.commons.io.FileUtils;
import org.apache.commons.io.FilenameUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.MediaTypeFactory;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Component;
import org.springframework.web.multipart.MultipartFile;

import kr.or.ddit.groupware.service.attach.IAttachFileService;
import kr.or.ddit.groupware.vo.AttachFileGroupVO;
import kr.or.ddit.groupware.vo.AttachFileVO;
import lombok.extern.slf4j.Slf4j;

@Component
@Slf4j
public class FileUtil {

	@Resource(name = "path")
	private String resourcePath;

	@Autowired
	private IAttachFileService attachFileService;

	/**
	 * @method : saveUploadFile
	 * @auther : <strong>이명문</strong>
	 * @param  : files - 업로드할 파일
	 * @param  : code - 폴더를 구분할 식별자
	 * @return : atchFileGroupNo - 업로드한 파일의 그룹 번호
	 * @date : 2024. 4. 8
	 */
	public int saveUploadFile(List<MultipartFile> files, TableCode code) {

		if (files == null || files.isEmpty() || files.stream().allMatch(MultipartFile::isEmpty)) {
			return -1; // 파일이 없거나 모든 파일이 비어 있으면 -1 반환
		}

		int atchFileGroupNo = 0;

		if (files != null) {
			atchFileGroupNo = attachFileService.insertAttachFileGroup();
		}

		saveFile(files, atchFileGroupNo, code);

		return atchFileGroupNo;
	}

	/**
	 * @method : updateSaveFile
	 * @auther : <strong>이명문</strong>
	 * @param  : files - 수정할 파일
	 * @param  : atchFileGroupNo - 파일의 그룹 번호
	 * @param  : code - 폴더를 구분할 식별자
	 * @date : 2024. 4. 15
	 */
	public void updateSaveFile(List<MultipartFile> files, int atchFileGroupNo, TableCode code) {
		saveFile(files, atchFileGroupNo, code);
	}

	/**
	 * @method : saveFile
	 * @auther : <strong>이명문</strong>
	 * @param  : files - 파일 정보
	 * @param  : atchFileGroupNo - 파일의 그룹 번호
	 * @param  : code - 폴더를 구분할 식별자
	 * @date : 2024. 4. 15
	 */
	private void saveFile(List<MultipartFile> files, int atchFileGroupNo, TableCode code) {
		String savedPath = getFolderName(resourcePath, code);

		for (MultipartFile file : files) {
			String savedName = UUID.randomUUID().toString() + "_" + file.getOriginalFilename();
			String uploadedFileName = savedPath.replace(File.separatorChar, '/') + "/" + savedName;
			
			System.out.println("## fileName >> " + file.getOriginalFilename());
			
			AttachFileVO attachFileVO = AttachFileVO.builder().atchFileGroupNo(atchFileGroupNo)
					.atchFileOrnlFileNm(file.getOriginalFilename()).atchFileNm(savedName).atchFileSize(file.getSize())
					.atchFileFancysize(FileUtils.byteCountToDisplaySize(file.getSize()))
					.atchFileExtsn(FilenameUtils.getExtension(uploadedFileName)).atchFilePath(uploadedFileName).build();

			attachFileService.insertSavedFile(attachFileVO);

			File target = new File(savedPath, savedName);

			try {
				file.transferTo(target);
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
	}

	/**
	 * @method : getFolderName
	 * @auther : <strong>이명문</strong>
	 * @param  : path - 파일 경로
	 * @param  : code - 폴더를 구분할 식별자
	 * @return : path
	 * @date : 2024. 4. 8
	 */
	public String getFolderName(String path, TableCode code) {
		String newPath = MessageFormat.format("{0}{1}", path, code.getFolderName());
		createFolder(newPath);
		return newPath;
	}
	
	public String getFolderName(TableCode code) {
		return resourcePath + code.getFolderName();
	}

	/**
	 * @method : createFolder
	 * @auther : <strong>이명문</strong>
	 * @param  : path - 파일 경로
	 * @date : 2024. 4. 8
	 */
	public void createFolder(String path) {

		File uploadDir = new File(path);

		if (!uploadDir.exists()) {
			boolean b = uploadDir.mkdirs();
			if(!b)
				log.debug("폴더 생성 실패_" + path);
		}
	}

	/**
	 * @method : getMediaType
	 * @auther : <strong>이명문</strong>
	 * @param  : type - 미디어 타입 식별
	 * @return : MediaType
	 * @date : 2024. 4. 8
	 */
//	public MediaType getMediaType(String type) {
//		return mediaMap.get(type.toUpperCase()) == null ? MediaType.APPLICATION_OCTET_STREAM
//				: mediaMap.get(type.toUpperCase());
//	}

	/**
	 * @method : getFileEntity
	 * @auther : <strong>이명문</strong>
	 * @param  : path - 파일 경로
	 * @param  : addHeader - 헤더 추가 여부
	 * @return : entity
	 * @date : 2024. 4. 8
	 */
	public ResponseEntity<byte[]> getFileEntity(String path, boolean addHeader) {

		ResponseEntity<byte[]> entity = null;

		String fileName = path.substring(path.indexOf("_") + 1);
		String fileType = FilenameUtils.getExtension(fileName);

		MediaType type = getMediaType(fileType);

		HttpHeaders headers = new HttpHeaders();
		headers.setContentType(type);

		File file = new File(path);

		if (!file.exists()) {
			log.error(this + "_FileNotFound");
			return null;
		}

		try {
			byte[] fileData = FileUtils.readFileToByteArray(file);

			if (addHeader) {
				headers.add(headers.CONTENT_DISPOSITION, "attachment; filename="
						+ new String(fileName.getBytes(StandardCharsets.UTF_8), StandardCharsets.ISO_8859_1));
			}

			entity = new ResponseEntity<byte[]>(fileData, headers, HttpStatus.CREATED);

		} catch (IOException e) {
			e.printStackTrace();
			entity = new ResponseEntity<byte[]>(HttpStatus.BAD_REQUEST);
		}

		return entity;
	}

	/**
	 * @method : realFileDelete
	 * @auther : <strong>이명문</strong>
	 * @param  : path - 파일 경로
	 * @date : 2024. 4. 15
	 */
	public void realFileDelete(String path) {
		File file = new File(path);
		if (file.exists()) {
			file.delete();
			log.debug(path + " 파일 삭제 완료");
		}
		else {
			log.debug("[WARNING] 파일이 존재하지 않습니다!");
		}
	}

	/**
	 * @method : fileGroupDelete
	 * @auther : <strong>이명문</strong>
	 * @param  : attachFileGroupNo - 파일 그룹 번호
	 * @date : 2024. 4. 15
	 */
	public void fileGroupDelete(int attachFileGroupNo) {

		AttachFileGroupVO attachFileGroupVO = attachFileService.getAttachFileGroup(attachFileGroupNo);
		List<AttachFileVO> attachFileList = attachFileGroupVO.getAttachFileList();

		for (AttachFileVO atchFileVO : attachFileList) {
			String path = atchFileVO.getAtchFilePath();
			realFileDelete(path);
		}
	}

	/**
	 * @method : attachFileDelete
	 * @auther : <strong>이명문</strong>
	 * @param  : attachFileNo - 삭제할 파일 번호
	 * @date : 2024. 4. 15
	 */
	public void attachFileDelete(int attachFileNo) {
		attachFileService.attachFileDelete(attachFileNo);
	}

	/**
	 * @method : isImageFile
	 * @auther : <strong>이명문</strong>
	 * @param  : ext - 파일 확장자
	 * @return : boolean 
	 * @date : 2024. 4. 8
	 */
	public boolean isImageFile(String ext) {
		switch (ext) {
		case "JPG":
			return true;
		case "JPEG":
			return true;
		case "PNG":
			return true;
		case "GIF":
			return true;
		}
		return false;
	}
	
	/**
	 * @method : getMediaType
	 * @auther : <strong>이명문</strong>
	 * @param  : 
	 * @return : 
	 * @date : 2024. 4. 27
	 */
	public MediaType getMediaType(String fileName) {
		return MediaTypeFactory.getMediaType(fileName).orElse(MediaType.APPLICATION_OCTET_STREAM);
	}
} 
