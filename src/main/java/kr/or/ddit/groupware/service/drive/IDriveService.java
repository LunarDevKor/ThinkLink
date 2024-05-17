package kr.or.ddit.groupware.service.drive;

import java.util.List;

import org.springframework.http.ResponseEntity;

import kr.or.ddit.groupware.util.Result;
import kr.or.ddit.groupware.vo.DriveFolderVO;
import kr.or.ddit.groupware.vo.DriveItemVO;
import kr.or.ddit.groupware.vo.DriveVO;
import kr.or.ddit.groupware.vo.LogVO;

/**
 * 자료실 서비스 인터페이스
 * @author <strong>이명문</strong>
 * @version 1.0
 * @see IDriveService
 */
public interface IDriveService {

	Result saveUploadFiles(DriveVO driveVO);

	List<DriveItemVO> selectDriveMainFiles(DriveItemVO driveItemVO);

	ResponseEntity<byte[]> imageFileView(String filePath);

	int createNewFolder(DriveFolderVO driveFolderVO);

	Result editName(DriveItemVO driveItemVO);

	List<DriveFolderVO> getFolder(DriveFolderVO driveFolderVO);

	Result deleteFile(DriveItemVO driveItemVO);

	Result fileMove(DriveItemVO driveItemVO);

	List<DriveItemVO> searchDrive(DriveItemVO driveItemVO);

	ResponseEntity<byte[]> downloadFile(int itemNo);

	List<LogVO> getLog(DriveItemVO driveItemVO);

	List<LogVO> getAllLog(DriveItemVO driveItemVO);

}
