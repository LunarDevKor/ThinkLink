package kr.or.ddit.groupware.service.drive;

import java.io.File;
import java.io.IOException;
import java.sql.SQLException;
import java.text.MessageFormat;
import java.util.Date;
import java.util.List;
import java.util.UUID;

import javax.annotation.Resource;
import javax.inject.Inject;

import org.apache.commons.io.FileUtils;
import org.apache.commons.io.FilenameUtils;
import org.apache.commons.lang3.StringUtils;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import kr.or.ddit.groupware.controller.common.CommonAbstractImpl;
import kr.or.ddit.groupware.mapper.drive.IDriveMapper;
import kr.or.ddit.groupware.mapper.drive.ILogMapper;
import kr.or.ddit.groupware.util.DriveEnum;
import kr.or.ddit.groupware.util.FileUtil;
import kr.or.ddit.groupware.util.Result;
import kr.or.ddit.groupware.util.TableCode;
import kr.or.ddit.groupware.vo.DriveFolderVO;
import kr.or.ddit.groupware.vo.DriveItemVO;
import kr.or.ddit.groupware.vo.DriveVO;
import kr.or.ddit.groupware.vo.EmployeeVO;
import kr.or.ddit.groupware.vo.LogVO;

/**
 * 자료실 서비스 구현체
 * 
 * @author <strong>이명문</strong>
 * @version 1.0
 * @see DriveServiceImpl
 */

@Service
public class DriveServiceImpl extends CommonAbstractImpl implements IDriveService {

	@Inject
	private IDriveMapper driveMapper;

	@Inject
	private ILogMapper logMapper;

	@Inject
	private FileUtil fileUtil;

	@Resource(name = "path")
	private String resourcePath;

	private static String[] folders;
	static {
		folders = new String[] {
				"company", "department", "private"
		};
	}

	@Transactional(rollbackFor = {
			RuntimeException.class, Exception.class
	})
	@Override
	public Result saveUploadFiles(DriveVO driveVO) {
		EmployeeVO employeeVO = getEmployee();
		int emplNo = employeeVO.getEmplNo();
		
		String savedPath = fileUtil.getFolderName(resourcePath, TableCode.DRIVE);
		if(StringUtils.isNotBlank(driveVO.getFilePath())) {
			savedPath = MessageFormat.format("{0}{1}{2}{3}{4}", 
					savedPath, '/' 
					, getFolderType(driveVO.getFldrType()) , '/'
					, driveVO.getFilePath());
			
			File f = new File(savedPath);
			
			if(!f.exists()) {
				f.mkdirs();
			}
		}

		List<MultipartFile> files = driveVO.getFiles();

		for (MultipartFile file : files) {
			String savedName = UUID.randomUUID().toString() + "_" + file.getOriginalFilename();
			String uploadedFileName = savedPath.replace(File.separatorChar, '/') + "/" + savedName;
			DriveVO dVO = DriveVO.builder().emplNo(emplNo).fileNm(savedName).orgnlFilename(file.getOriginalFilename())
					.fileSize(file.getSize()).fileFancysize(FileUtils.byteCountToDisplaySize(file.getSize()))
					.fileMimeType(fileUtil.getMediaType(file.getOriginalFilename()).toString())
					.fileExtsn(FilenameUtils.getExtension(uploadedFileName)).filePath(uploadedFileName)
					.fileRegister(emplNo).fileRgsde(new Date()).fileUpdusr(emplNo).fileUpdde(new Date()).build();

			int result = driveMapper.saveUploadFile(dVO);

			if (result <= 0) {
				new RuntimeException();
				return Result.FAILED;
			}

			DriveVO dVo2 = DriveVO.builder().fileNo(dVO.getFileNo()).upperFldrNo(driveVO.getUpperFldrNo()).build();

			if (driveVO.getUpperFldrNo() != 0) {
				int uploadResult = driveMapper.insertFolderFile(dVo2);

				if (uploadResult <= 0) {
					new RuntimeException();
					return Result.FAILED;
				}
			}

			File saveFile = new File(savedPath, savedName);
			LogVO logVO = LogVO.builder()
					.fileNo(dVO.getFileNo())
					.emplNo(emplNo)
					.logCn(contentMessageFormat(DriveEnum.UPLOAD.getName(), 
							MessageFormat.format("{0} {1} 님이  ''{2}'' 파일 업로드",
									employeeVO.getEmplNm(),
									employeeVO.getClsfNm(),
									file.getOriginalFilename()
							)
					))
					.build();
			
			logMapper.insertLog(logVO);
			try {
				file.transferTo(saveFile);
			} catch (IOException e) {
				e.printStackTrace();
			}
		}

		return Result.OK;
	}

	@Override
	public List<DriveItemVO> selectDriveMainFiles(DriveItemVO driveItemVO) {
		return driveMapper.selectDriveMainFiles(driveItemVO);
	}

	@Override
	public ResponseEntity<byte[]> imageFileView(String filePath) {
		return fileUtil.getFileEntity(filePath, false);
	}

	@Override
	public int createNewFolder(DriveFolderVO driveFolderVO) {
		String fldrPath = getFolderPath(driveFolderVO);
		driveFolderVO.setFldrPath(fldrPath);

		int result = driveMapper.createNewFolder(driveFolderVO);

		if(result > 0) {
			return driveFolderVO.getFldrNo();
		}
		
		return 0;
	}

	private String getFolderType(String type) {
		return folders[Integer.parseInt(type)];
	}

	public String getFolderPath(DriveFolderVO driveFolderVO) {
		String path = MessageFormat.format("{0}/{1}/{2}", 
						fileUtil.getFolderName(TableCode.DRIVE),
						getFolderType(driveFolderVO.getFldrType()),
						driveFolderVO.getFldrNm());
		fileUtil.createFolder(path);
		return path;
	}

	@Override
	public Result editName(DriveItemVO driveItemVO) {
		String type = driveItemVO.getItemType();
		int result = 0;
		String originalName = "";
		
		if (type.equals("FILE")) {
			DriveVO driveVO = driveMapper.getFile(driveItemVO.getItemNo());
			originalName = driveVO.getOrgnlFilename();
			result = driveMapper.editFileName(driveItemVO);
		}
		else {
			result = driveMapper.editFolderName(driveItemVO);
		}
		
		EmployeeVO employeeVO = getEmployee();
		LogVO logVO = LogVO.builder()
					.fileNo(driveItemVO.getItemNo())
					.emplNo(employeeVO.getEmplNo())
					.logCn(contentMessageFormat(DriveEnum.MODIFY.getName(), 
							MessageFormat.format("{0} {1} 님이  ''{2}'' 파일의 이름 ''{3}'' 으로 수정",
									employeeVO.getEmplNm(),
									employeeVO.getClsfNm(),
									originalName,
									driveItemVO.getItemNm())
					))
					.build();
		
		logMapper.insertLog(logVO);

		return result > 0 ? Result.OK : Result.FAILED; 
	}

	@Override
	public List<DriveFolderVO> getFolder(DriveFolderVO driveFolderVO) {
		return driveMapper.getFolder(driveFolderVO);
	}

	@Transactional(rollbackFor = {SQLException.class})
	@Override
	public Result deleteFile(DriveItemVO driveItemVO) {
		EmployeeVO employeeVO = getEmployee();
		Integer[] delFiles = driveItemVO.getDelFiles();
		Integer[] delFolders = driveItemVO.getDelFolders();

		if (delFiles.length > 0) {
			for (Integer fileNo : delFiles) {
				DriveVO driveVO = driveMapper.getFile(fileNo);
				int result = driveMapper.deleteFile(fileNo);
				
				LogVO logVO = LogVO.builder()
						.fileNo(driveVO.getFileNo())
						.emplNo(employeeVO.getEmplNo())
						.logCn(contentMessageFormat(DriveEnum.DELETE.getName(),
								MessageFormat.format("{0} {1} 님이 ''{2}'' 파일 삭제", 
										employeeVO.getEmplNm(),
										employeeVO.getClsfNm(),
										driveVO.getOrgnlFilename()
								)
						))
						.build();
				
				logMapper.insertLog(logVO);
				
				if (result <= 0) {
					new SQLException();
				}
			}
		}

		if (delFolders.length > 0) {
			for (Integer fldrNo : delFolders) {
				int result = driveMapper.deleteFolder(fldrNo);
				
				if (result <= 0) {
					new SQLException();
				}
			}
		}

		return Result.OK;
	}

	@Transactional(rollbackFor = Exception.class)
	@Override
	public Result fileMove(DriveItemVO driveItemVO) {
		int cnt = 0;

		if (driveItemVO.getItemType().equals("FILE")) {

			int result = driveMapper.isExistInFolder(driveItemVO);

			if (result > 0) {
				cnt = driveMapper.existFileMove(driveItemVO);
			}
			else {
				cnt = driveMapper.notExistFileMove(driveItemVO);
			}
		}
		else
			cnt = driveMapper.folderMove(driveItemVO);

		if (cnt > 0) return Result.OK;

		return Result.FAILED;
	}

	@Override
	public List<DriveItemVO> searchDrive(DriveItemVO driveItemVO) {
		return driveMapper.searchDrive(driveItemVO);
	}

	@Override
	public ResponseEntity<byte[]> downloadFile(int itemNo) {

		DriveVO driveVO = driveMapper.getFile(itemNo);
		File file = new File(driveVO.getFilePath());

		if (file.exists() && file.isFile()) {
			EmployeeVO employeeVO = getEmployee();
			String content = contentMessageFormat(
					DriveEnum.DOWNLOAD.getName(),
					MessageFormat.format("{0} {1} 님이  ''{2}'' 파일 다운로드", employeeVO.getEmplNm(), employeeVO.getClsfNm(), driveVO.getOrgnlFilename()));
			
			LogVO logVO = LogVO.builder()
					.emplNo(employeeVO.getEmplNo())
					.fileNo(driveVO.getFileNo())
					.logCn(content)
					.build();

			logMapper.insertLog(logVO);
			driveMapper.incrementDownloadCnt(driveVO);
			return fileUtil.getFileEntity(driveVO.getFilePath(), true);
		}

		return null;
	}

	private String contentMessageFormat(String type, String content) {
		return MessageFormat.format("{0} {1}", type, content);
	}

	@Override
	public List<LogVO> getLog(DriveItemVO driveItemVO) {
		List<LogVO> logList = null;
		
		if(driveItemVO.getItemType().equals("FOLDER")) {
			logList = logMapper.getFolderLog(driveItemVO);
		}else {
			logList = logMapper.getFileLog(driveItemVO);
		}
		
		return logList;
	}

	@Override
	public List<LogVO> getAllLog(DriveItemVO driveItemVO) {
		return logMapper.getAllLog(driveItemVO);
	}
}
