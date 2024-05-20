package kr.or.ddit.groupware.vo;

import java.util.Arrays;

import com.fasterxml.jackson.annotation.JsonIgnore;

import lombok.Data;

@Data
public class DriveItemVO {
	private int itemNo;
	private int upperFldrNo;
	private String itemNm;
	private String itemSize;
	private String itemExtsn;
	private String itemRgsde;
	private String itemPath;
	private String itemType;
	private String delYn;
	
	private Integer[] delFolders;
	private Integer[] delFiles;
	
	private String searchText;
	private String fldrType;
	private String deptCode;
	private int emplNo;

	@JsonIgnore
	private String[] byteUnits;

	public DriveItemVO() {
		byteUnits = new String[] {" B", " KB", " MB", " GB"};
	}

//	public void setItemNm(String itemNm) {
//		if(itemNm != null && !itemNm.trim().equals("") && itemNm.lastIndexOf(".") != -1) {
//			System.out.println("#### =>" + FilenameUtils.getExtension(itemNm));
//			this.itemNm = itemNm.substring(0, itemNm.lastIndexOf("."));
//		}
//		else this.itemNm = itemNm;
//	}

	public void setItemSize(String itemSize) {
		long cnt = Arrays.stream(byteUnits).filter(unit -> itemSize.indexOf(unit) != -1).count();
		
		if(cnt > 0) {
			this.itemSize = itemSize;
			return;
		}
		
		if (itemSize != null && !itemSize.trim().equals("") && !itemSize.equals("0")) {
			try {
				double size = Double.parseDouble(itemSize.trim());
				int unitIndex = 0;

				while (size >= 1024 && unitIndex < byteUnits.length - 1) {
					size /= 1024;
					unitIndex++;
				}

				if (unitIndex == 0) this.itemSize = String.format("%.0f%s", size, byteUnits[unitIndex]);
				else
					this.itemSize = String.format("%.1f%s", size, byteUnits[unitIndex]);

			} catch (NumberFormatException e) {
				e.printStackTrace();
			}
		}
		else
			this.itemSize = "";
	}
}
