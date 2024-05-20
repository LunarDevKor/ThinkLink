package kr.or.ddit.groupware.service.approval;

import java.io.IOException;
import java.sql.SQLException;
import java.time.ZoneId;
import java.time.ZonedDateTime;
import java.util.Base64;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.commons.lang.StringUtils;
import org.apache.ibatis.exceptions.PersistenceException;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import kr.or.ddit.groupware.mapper.approval.IApprovalMapper;
import kr.or.ddit.groupware.mapper.notification.INotificationMapper;
import kr.or.ddit.groupware.util.FileUtil;
import kr.or.ddit.groupware.util.NotificationUtil;
import kr.or.ddit.groupware.util.Result;
import kr.or.ddit.groupware.util.TableCode;
import kr.or.ddit.groupware.vo.ApprovalRfrncVO;
import kr.or.ddit.groupware.vo.ApprovalSearchVO;
import kr.or.ddit.groupware.vo.ApprovalVO;
import kr.or.ddit.groupware.vo.CustomUser;
import kr.or.ddit.groupware.vo.DocBookmarkVO;
import kr.or.ddit.groupware.vo.DocumentsVO;
import kr.or.ddit.groupware.vo.EmployeeVO;
import kr.or.ddit.groupware.vo.NotificationVO;
import kr.or.ddit.groupware.vo.OrganizationTreeVO;
import kr.or.ddit.groupware.vo.SanctionerBookmarkGroupVO;
import kr.or.ddit.groupware.vo.SanctionerBookmarkRefVO;
import kr.or.ddit.groupware.vo.SanctionerBookmarkVO;
import kr.or.ddit.groupware.vo.SanctionerVO;

/**
 * 전자 결재 서비스 구현체
 * 
 * @author <strong>이명문</strong>
 * @version 1.0
 * @see ApprovalServiceImpl
 */
@Service
public class ApprovalServiceImpl implements IApprovalService {

	@Inject
	private IApprovalMapper approvalMapper;
	
	@Inject
	private INotificationMapper notificationMapper;

	@Inject
	private FileUtil fileUtil;
	
	@Inject
	private NotificationUtil noti;

	@Override
	public List<ApprovalVO> selectDraftList(ApprovalVO approvalVO) {
		if(approvalVO.getType().equals("approve")) {
			return approvalMapper.selectApproveList(approvalVO);
		}
		return approvalMapper.selectDraftList(approvalVO);
	}

	@Override
	public List<OrganizationTreeVO> selectOragnTree() {
		return approvalMapper.selectOragnTree();
	}

	@Override
	public int insertSanctionerGroup(SanctionerBookmarkGroupVO vo) {
		return approvalMapper.insertSanctionerGroup(vo);
	}

	@Override
	@Transactional(rollbackFor = SQLException.class)
	public Result insertSanctioner(SanctionerBookmarkVO[] bookmarkList) {

		int cnt = 0;
		for (SanctionerBookmarkVO sanctionerBookmarkVO : bookmarkList) {
			cnt = approvalMapper.insertSanctioner(sanctionerBookmarkVO);
			if (cnt <= 0) {
				throw new RuntimeException();
			}
		}

		if (cnt > 0) return Result.OK;

		return Result.FAILED;
	}

	@Override
	@Transactional(rollbackFor = SQLException.class)
	public Result insertReferencer(SanctionerBookmarkRefVO[] refList) {

		int cnt = 0;

		for (SanctionerBookmarkRefVO sanctionerBookmarkRefVO : refList) {
			cnt = approvalMapper.insertReferencer(sanctionerBookmarkRefVO);
			if (cnt <= 0) {
				throw new RuntimeException();
			}
		}

		if (cnt > 0) return Result.OK;

		return Result.FAILED;
	}

	@Override
	public List<SanctionerBookmarkGroupVO> selectMyLine(SanctionerBookmarkGroupVO vo) {
		return approvalMapper.selectMyLine(vo);
	}

	@Override
	public List<SanctionerBookmarkGroupVO> selectMyGroup(SanctionerBookmarkGroupVO vo) {
		return approvalMapper.selectMyGroup(vo);
	}

	@Transactional(rollbackFor = {
			Exception.class
	})
	@Override
	public int insertApproval(ApprovalVO approvalVO) {
		List<MultipartFile> files = approvalVO.getFiles();

		if (files != null) {
			int atchFileGroupNo = fileUtil.saveUploadFile(files, TableCode.DRAFT);
			approvalVO.setAtchFileGroupNo(atchFileGroupNo);
		}

		int result = approvalMapper.insertApproval(approvalVO);

		List<SanctionerVO> sanctionerList = approvalVO.getSanctionerList();
		if(sanctionerList != null && sanctionerList.size() > 0) {
			for (SanctionerVO sanctionerVO : sanctionerList) {
				sanctionerVO.setAprovlNo(approvalVO.getAprovlNo());
				approvalMapper.insertSanctioners(sanctionerVO);
			}
			
		}

		List<ApprovalRfrncVO> rfrncList = approvalVO.getRfrncList();
		if (rfrncList != null && rfrncList.size() > 0) {
			for (ApprovalRfrncVO approvalRfrncVO : rfrncList) {
				approvalRfrncVO.setAprovlNo(approvalVO.getAprovlNo());
				approvalMapper.insertApprovalRfrnc(approvalRfrncVO);
			}
		}

		ApprovalVO apVO = selectApprovalDocument(approvalVO.getAprovlNo());
		List<SanctionerVO> sanList = apVO.getSanctionerList();
		
		NotificationVO notificationVO = new NotificationVO();
		
		if(sanList != null && sanList.size() > 0) {
			for (SanctionerVO sanVO : sanList) {
				
				String content = "[결재 도착] '"
						.concat(apVO.getEmplNm() + " " + apVO.getAprovlClsfNm())
						.concat("'님이 작성한 '")
						.concat(apVO.getAprovlNm() + "' 이(가) 도착했습니다!");
				notificationVO.setNtcnRecp(sanVO.getApproverNo());
				notificationVO.setNtcnTypeCode("N101");
				notificationVO.setNtcnContent(content);
				notificationVO.setNtcnUrl("/approval/document/"+sanVO.getAprovlNo());
				notificationVO.setLocalDt(ZonedDateTime.now(ZoneId.of("Asia/Seoul")).toLocalDateTime());
				// LocalDateTime.of(2024, 4, 25, 10, 30); 날짜 지정 or
				// LocalDateTime.now() / now.withHour(12).withMinute(0); // 12시 0분 시간 지정 => 2024, 4 , 25, 12, 0
				// LocalDateTime future = now.PlusDays(7).plusHours(3); // 현재 날짜에서 7일 3시간 더함.
				
				notificationMapper.insertNotification(notificationVO);
				noti.sendNoti(sanVO.getApproverNo());
			}
		}
		
		List<ApprovalRfrncVO> rfList = apVO.getRfrncList();
		if(rfList != null && rfList.size() > 0) {
			
			for (ApprovalRfrncVO rfVO : rfList) {
				String content = "[참조 도착] "
						.concat(apVO.getEmplNm() + " " +apVO.getAprovlClsfNm() )
						.concat("'님이 작성한 '")
						.concat(apVO.getAprovlNm() + "' 이(가) 도착했습니다!");
				
				notificationVO.setNtcnRecp(rfVO.getRfrncerNo());
				notificationVO.setNtcnTypeCode("N105");
				notificationVO.setNtcnContent(content);
				notificationVO.setNtcnUrl("/approval/document/"+rfVO.getAprovlNo());
				notificationVO.setLocalDt(ZonedDateTime.now(ZoneId.of("Asia/Seoul")).toLocalDateTime());
				
				notificationMapper.insertNotification(notificationVO);
				noti.sendNoti(rfVO.getRfrncerNo());
			}
		}
		
		if (result > 0) return approvalVO.getAprovlNo();

		return 0;
	}

	@Transactional(rollbackFor = {
			Exception.class
	})
	@Override
	public Result deleteMyLine(SanctionerBookmarkGroupVO vo) {
		int result = approvalMapper.deleteMyLine(vo);

		if (result <= 0) throw new RuntimeException();

		result = approvalMapper.deleteMyLineGroup(vo);

		if (result <= 0) throw new RuntimeException();

		return Result.OK;
	}

	@Transactional(rollbackFor = {
			Exception.class
	})
	@Override
	public Result deleteMyGroup(SanctionerBookmarkGroupVO vo) {
		int result = approvalMapper.deleteMyGroup(vo);

		if (result <= 0) throw new RuntimeException();

		result = approvalMapper.deleteMyLineGroup(vo);

		if (result <= 0) throw new RuntimeException();

		return Result.OK;
	}

	@Override
	public ApprovalVO selectApprovalDocument(int aprovlNo) {
		ApprovalVO approvalVO = approvalMapper.selectApprovalDocument(aprovlNo);
		List<ApprovalRfrncVO> rfrncList = approvalMapper.selectApprovalRfrncer(aprovlNo);
		if (rfrncList != null && rfrncList.size() > 0) {
			CustomUser user = (CustomUser) SecurityContextHolder.getContext().getAuthentication().getPrincipal();

			for (ApprovalRfrncVO approvalRfrncVO : rfrncList) {
				if (user.getEmployeeVO().getEmplNo() == approvalRfrncVO.getRfrncerNo()
						&& approvalRfrncVO.getRfrncConfirmDt() == null) {
					approvalMapper.readRfrncDocument(approvalRfrncVO);
					break;
				}
			}

			approvalVO.setRfrncList(rfrncList);
		}

		return approvalVO;
	}

	@Override
	public List<ApprovalVO> selectApprovalList(SanctionerVO sanctionerVO) {
		return approvalMapper.selectApprovalList(sanctionerVO);
	}

	@Transactional(rollbackFor = Exception.class)
	@Override
	public Result confirmApproval(SanctionerVO sanctionerVO) {
		int result = approvalMapper.confirmApproval(sanctionerVO);
		String code = sanctionerVO.getSanctnerSttusCode();
		
		ApprovalVO apVO = approvalMapper.selectApprovalDocument(sanctionerVO.getAprovlNo());
		NotificationVO notificationVO = new NotificationVO();
		String content = "";
		
		if(code.equals("G307")) {
			approvalMapper.approvalArbitrary(sanctionerVO);
			approvalMapper.finishApprovalDocument(sanctionerVO.getAprovlNo());
			
			content = "[결재 완료] "
					.concat(apVO.getEmplNm()+ " " + apVO.getAprovlClsfNm())
					.concat("'님이 작성한 '")
					.concat(apVO.getAprovlNm() + "' 이(가) 완료되었습니다.");
			notificationVO.setNtcnRecp(apVO.getEmplNo());
			notificationVO.setNtcnTypeCode("N104");
			notificationVO.setNtcnContent(content);
			notificationVO.setNtcnUrl("/approval/document/"+sanctionerVO.getAprovlNo());
			notificationVO.setLocalDt(ZonedDateTime.now(ZoneId.of("Asia/Seoul")).toLocalDateTime());
			
			notificationMapper.insertNotification(notificationVO);
			noti.sendNoti(apVO.getEmplNo());
		}else {
			if (result > 0) {
				int update = approvalMapper.nextApprovalUpdate(sanctionerVO);
				for(SanctionerVO sanVO : apVO.getSanctionerList()) {
					if(sanVO.getApproverNo() == sanctionerVO.getApproverNo()) {
						content = "[결재 승인] "
								.concat(sanVO.getApproverNm()+ " " + sanVO.getClsfNm())
								.concat("'님이 '")
								.concat(apVO.getAprovlNm() + "' 문서 결재를 승인 하였습니다!");
						notificationVO.setNtcnRecp(apVO.getEmplNo());
						notificationVO.setNtcnTypeCode("N100");
						notificationVO.setNtcnContent(content);
						notificationVO.setNtcnUrl("/approval/document/"+sanVO.getAprovlNo());
						notificationVO.setLocalDt(ZonedDateTime.now(ZoneId.of("Asia/Seoul")).toLocalDateTime());
						
						notificationMapper.insertNotification(notificationVO);
						noti.sendNoti(apVO.getEmplNo());
					}
				}
	
				if (update == 0) {
					approvalMapper.finishApprovalDocument(sanctionerVO.getAprovlNo());
					
					content = "[결재 완료] "
							.concat(apVO.getEmplNm()+ " " + apVO.getAprovlClsfNm())
							.concat("'님이 작성한 '")
							.concat(apVO.getAprovlNm() + "' 이(가) 완료되었습니다.");
					notificationVO.setNtcnRecp(apVO.getEmplNo());
					notificationVO.setNtcnTypeCode("N104");
					notificationVO.setNtcnContent(content);
					notificationVO.setNtcnUrl("/approval/document/"+sanctionerVO.getAprovlNo());
					notificationVO.setLocalDt(ZonedDateTime.now(ZoneId.of("Asia/Seoul")).toLocalDateTime());
					
					notificationMapper.insertNotification(notificationVO);
					noti.sendNoti(apVO.getEmplNo());
				}
			}
		}
		
		approvalMapper.approvalConfrimConetentUpdate(sanctionerVO);

		return Result.OK;
	}

	@Transactional(rollbackFor = Exception.class)
	@Override
	public Result returnApproval(Map<String, String> param) {

		int result = 0;
		int cnt = approvalMapper.returnSanctioner(param);

		if (cnt > 0) {
			result = approvalMapper.returnApproval(param);
		}

		if (result > 0) {
			approvalMapper.allApprovalCancel(param);
			ApprovalVO apVO = approvalMapper.selectApprovalDocument(Integer.parseInt(param.get("aprovlNo")));
			
			NotificationVO notificationVO = new NotificationVO();
			String content = "[결재 반려] "
					.concat(apVO.getEmplNm() + " " + apVO.getAprovlClsfNm())
					.concat("'님이 작성한 '")
					.concat(apVO.getAprovlNm() + "' 이(가) 반려되었습니다!");
			notificationVO.setNtcnRecp(apVO.getEmplNo());
			notificationVO.setNtcnTypeCode("N103");
			notificationVO.setNtcnContent(content);
			notificationVO.setNtcnUrl("/approval/document/"+apVO.getAprovlNo());
			notificationVO.setLocalDt(ZonedDateTime.now(ZoneId.of("Asia/Seoul")).toLocalDateTime());
			
			notificationMapper.insertNotification(notificationVO);
			noti.sendNoti(apVO.getEmplNo());
			
			SanctionerVO sanctionerVO = new SanctionerVO();
			sanctionerVO.setAprovlCn(param.get("aprovlCn"));
			sanctionerVO.setAprovlNo(Integer.parseInt(param.get("aprovlNo")));
			approvalMapper.approvalConfrimConetentUpdate(sanctionerVO);;
			return Result.OK;
		}

		return Result.FAILED;
	}

	@Transactional(rollbackFor = Exception.class)
	@Override
	public Result holdSanctioner(Map<String, String> param) {
		int result = approvalMapper.holdSanctioner(param);
		if (result > 0) return Result.OK;

		return Result.FAILED;
	}

	@Transactional(rollbackFor = {Exception.class, PersistenceException.class})
	@Override
	public int reapplyApproval(ApprovalVO approvalVO) {

		List<MultipartFile> files = approvalVO.getFiles();
		
		if (files != null) {
			int deleteFileGroupNo = approvalVO.getAtchFileGroupNo();
			fileUtil.fileGroupDelete(deleteFileGroupNo);
			fileUtil.updateSaveFile(files, deleteFileGroupNo, TableCode.DRAFT);
		}

		int result = approvalMapper.reapplyApproval(approvalVO);

		List<SanctionerVO> sanctionerList = approvalVO.getSanctionerList();
		if(sanctionerList != null && sanctionerList.size() > 0) {
			approvalMapper.deleteSanctioner(approvalVO.getAprovlNo());
		
			for (SanctionerVO sanctionerVO : sanctionerList) {
				if(sanctionerVO.getApproverNo() != 0) {
					sanctionerVO.setAprovlNo(approvalVO.getAprovlNo());
					approvalMapper.insertSanctioners(sanctionerVO);
					
					String content = "[결재 도착] '"
							.concat(approvalVO.getEmplNm() + " " + approvalVO.getAprovlClsfNm())
							.concat("'님이 작성한 '")
							.concat(approvalVO.getAprovlNm() + "' 이(가) 도착했습니다!");
					NotificationVO notificationVO = new NotificationVO();
					notificationVO.setNtcnRecp(sanctionerVO.getApproverNo());
					notificationVO.setNtcnTypeCode("N101");
					notificationVO.setNtcnContent(content);
					notificationVO.setNtcnUrl("/approval/document/"+sanctionerVO.getAprovlNo());
					notificationVO.setLocalDt(ZonedDateTime.now(ZoneId.of("Asia/Seoul")).toLocalDateTime());
					
					notificationMapper.insertNotification(notificationVO);
					noti.sendNoti(sanctionerVO.getApproverNo());
				}
			}
		}

		List<ApprovalRfrncVO> rfrncList = approvalVO.getRfrncList();
		
		if (rfrncList != null && rfrncList.size() > 0) {
			approvalMapper.deleteReferencer(approvalVO.getAprovlNo());
			
			for (ApprovalRfrncVO approvalRfrncVO : rfrncList) {
				if(approvalRfrncVO.getAprovlRfrncNo() != 0) {
					approvalRfrncVO.setAprovlNo(approvalVO.getAprovlNo());
					approvalMapper.insertApprovalRfrnc(approvalRfrncVO);
					
					String content = "[참조 도착] "
							.concat(approvalVO.getEmplNm() + " " +approvalVO.getAprovlClsfNm() )
							.concat("'님이 작성한 '")
							.concat(approvalVO.getAprovlNm() + "' 이(가) 도착했습니다!");
					
					NotificationVO notificationVO = new NotificationVO();
					notificationVO.setNtcnRecp(approvalRfrncVO.getRfrncerNo());
					notificationVO.setNtcnTypeCode("N105");
					notificationVO.setNtcnContent(content);
					notificationVO.setNtcnUrl("/approval/document/"+approvalRfrncVO.getAprovlNo());
					notificationVO.setLocalDt(ZonedDateTime.now(ZoneId.of("Asia/Seoul")).toLocalDateTime());
					
					notificationMapper.insertNotification(notificationVO);
					noti.sendNoti(approvalRfrncVO.getRfrncerNo());
				}
			}
		}

		if (result > 0) return approvalVO.getAprovlNo();

		return 0;
	}

	@Override
	public Result cancelApprovalDraft(int aprovlNo) {
		ApprovalVO apVO = approvalMapper.selectApprovalDocument(aprovlNo);
		
		approvalMapper.deleteReferencer(aprovlNo);
		approvalMapper.deleteSanctioner(aprovlNo);
		int result = approvalMapper.cancelApprovalDraft(aprovlNo);
		
		String content = "[결재 취소] "
				.concat(apVO.getEmplNm() + " " +apVO.getAprovlClsfNm() )
				.concat("'님이 작성한 '")
				.concat(apVO.getAprovlNm() + "' 이(가) 취소되었습니다!");
		
		NotificationVO notificationVO = new NotificationVO();
		notificationVO.setNtcnRecp(apVO.getEmplNo());
		notificationVO.setNtcnTypeCode("N102");
		notificationVO.setNtcnContent(content);
		notificationVO.setNtcnUrl("/approval/document/"+apVO.getAprovlNo());
		notificationVO.setLocalDt(ZonedDateTime.now(ZoneId.of("Asia/Seoul")).toLocalDateTime());
		
		notificationMapper.insertNotification(notificationVO);
		noti.sendNoti(apVO.getEmplNo());
		
		if(result > 0) return Result.OK;
		
		return Result.FAILED;
	}

	@Transactional(rollbackFor = {Exception.class, PersistenceException.class})
	@Override
	public Result cancelApproval(SanctionerVO sanctionerVO) {
		
		int result = approvalMapper.cancelApproval(sanctionerVO);
		approvalMapper.nextApprovalStatusUpdate(sanctionerVO);
		approvalMapper.approvalConfrimConetentUpdate(sanctionerVO);
		if(result > 0) return Result.OK;
		
		return Result.FAILED;
	}

	@Override
	public List<ApprovalVO> selectMainApproval(ApprovalVO approvalVO) {
		return approvalMapper.selectMainApproval(approvalVO);
	}

	@Override
	public List<ApprovalVO> selectMainInprogress(ApprovalVO approvalVO) {
		return approvalMapper.selectMainInprogress(approvalVO);
	}

	@Override
	public List<ApprovalVO> selectMainComplete(ApprovalVO approvalVO) {
		return approvalMapper.selectMainComplete(approvalVO);
	}

	@Override
	public List<Map<String, Object>> myDocumentsCount(int emplNo) {
		List<Map<String,Object>> list = approvalMapper.myDocumentsCount(emplNo);
		return list;
	}

	@Override
	public Result documentsBookMark(DocBookmarkVO docBookmarkVO) {
		
		int exist = approvalMapper.isExistDocument(docBookmarkVO);
		
		if(exist > 0) {
			return Result.EXIST;
		}
		
		int result = approvalMapper.documentsBookmark(docBookmarkVO);
		
		return result > 0 ? Result.OK : Result.FAILED;
	}

	@Override
	public List<DocumentsVO> getDocumentsBookmark(int emplNo) {
		return approvalMapper.getDocumentsBookmark(emplNo);
	}

	@Override
	public Result documentBookmarkDelete(DocBookmarkVO docBookmarkVO) {
		int result = approvalMapper.documentBookmarkDelete(docBookmarkVO);
		return result > 0 ? Result.OK : Result.FAILED;
	}

	@Override
	public Result signEdit(MultipartFile signFile) {
		int result = 0;
		
		if(signFile != null && StringUtils.isNotBlank(signFile.getOriginalFilename())) {
			try {
				String emplSign = "data:image/png;base64," + Base64.getEncoder().encodeToString(signFile.getBytes());
				CustomUser user = (CustomUser) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
				EmployeeVO employeeVO = user.getEmployeeVO();
				employeeVO.setEmplSign(emplSign);
				result = approvalMapper.signEdit(employeeVO);
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		
		return result > 0 ? Result.OK : Result.FAILED;
	}

	@Override
	public List<ApprovalVO> adminApprovalList() {
		return approvalMapper.adminApprovalList();
	}

	@Override
	public List<ApprovalVO> approvalSearch(ApprovalSearchVO approvalSearchVO) {
		return approvalMapper.approvalSearch(approvalSearchVO);
	}

	@Override
	public List<ApprovalVO> getAllApprovalStat(ApprovalVO approvalVO) {
		return approvalMapper.getAllApprovalStat(approvalVO);
	}

	@Override
	public List<ApprovalVO> getReturnApprovalChartData(ApprovalVO approvalVO) {
		return approvalMapper.getReturnApprovalChartData(approvalVO);
	}

	@Override
	public List<ApprovalVO> getSanctionerChartData(ApprovalVO approvalVO) {
		return approvalMapper.getSanctionerChartData(approvalVO);
	}

	@Override
	public List<ApprovalVO> getSanctionerTimeChartData(ApprovalVO approvalVO) {
		return approvalMapper.getSanctionerTimeChartData(approvalVO);
	}

}
