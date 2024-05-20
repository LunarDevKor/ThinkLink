package kr.or.ddit.groupware.mapper.drive;

import java.util.List;

import kr.or.ddit.groupware.vo.DriveFolderVO;
import kr.or.ddit.groupware.vo.DriveItemVO;
import kr.or.ddit.groupware.vo.DriveVO;

/**
 * 자료실 SQL Mapper
 * @author 이명문
 * @version 1.0
 * @see IDriveMapper
 */
public interface IDriveMapper {

	int saveUploadFile(DriveVO driveVO);

	List<DriveItemVO> selectDriveMainFiles(DriveItemVO driveItemVO);

	int createNewFolder(DriveFolderVO driveFolderVO);

	int editFileName(DriveItemVO driveItemVO);

	int editFolderName(DriveItemVO driveItemVO);

	List<DriveFolderVO> getFolder(DriveFolderVO driveFolderVO);

	int deleteFile(Integer fileNo);

	int deleteFolder(Integer fldrNo);
	
	int isExistInFolder(DriveItemVO driveItemVO);

	int existFileMove(DriveItemVO driveItemVO);

	int notExistFileMove(DriveItemVO driveItemVO);

	int folderMove(DriveItemVO driveItemVO);

	int insertFolderFile(DriveVO driveVO);

	List<DriveItemVO> searchDrive(DriveItemVO driveItemVO);

	void incrementDownloadCnt(DriveVO driveVO);

	DriveVO getFile(int itemNo);
	
	DriveFolderVO getFoldrOne(int itemNo);

}
