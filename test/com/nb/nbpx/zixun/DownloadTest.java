package com.nb.nbpx.zixun;

import java.util.Date;

import javax.annotation.Resource;

import org.junit.Test;

import com.nb.nbpx.BaseServiceTest;
import com.nb.nbpx.pojo.zixun.Download;
import com.nb.nbpx.pojo.zixun.DownloadKeyword;
import com.nb.nbpx.service.zixun.IDownloadService;

public class DownloadTest  extends BaseServiceTest {
	@Resource
	private IDownloadService downloadService;
	
	@Test
	public void testSave(){
		Download download = downloadService.getById(20);
		DownloadKeyword dk = new DownloadKeyword();
		dk.setDownload(download);
		dk.setKeyword("I love to fuck");
		dk.setKeywordId(23);
		download.getDownloadKeywords().add(dk);
		DownloadKeyword dk1 = new DownloadKeyword();
		dk1.setDownload(download);
		dk1.setKeyword("what the hell");
		dk1.setKeywordId(88);
		download.getDownloadKeywords().add(dk);
		download.getDownloadKeywords().add(dk1);
		//System.out.println(download.getDownloadKeywords().size());
		try {
			//downloadService.saveDownload(download);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	@Test
	public void testSize(){
		long xx = 11107680;
		System.out.println((xx / 1000000.00));
		System.out.println(Math.round((xx / 1000000.00)));
		System.out.println(Math.round((xx / 1000000.00) *100.00));
		double size = (double) (Math.round((xx / 1000000.00) *100)/100.00);
		System.out.println(size);
	}
}
