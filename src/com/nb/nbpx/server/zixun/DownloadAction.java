package com.nb.nbpx.server.zixun;

import java.io.File;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;

import org.apache.commons.io.FileUtils;
import org.apache.commons.io.FilenameUtils;
import org.apache.struts2.convention.annotation.InterceptorRef;
import org.apache.struts2.convention.annotation.InterceptorRefs;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Component;

import com.nb.nbpx.common.ResponseStatus;
import com.nb.nbpx.pojo.keyword.Keyword;
import com.nb.nbpx.pojo.subject.Subject;
import com.nb.nbpx.pojo.zixun.Download;
import com.nb.nbpx.pojo.zixun.DownloadKeyword;
import com.nb.nbpx.pojo.zixun.DownloadSubject;
import com.nb.nbpx.server.BaseAction;
import com.nb.nbpx.service.keyword.IKeywordService;
import com.nb.nbpx.service.subject.ISubjectService;
import com.nb.nbpx.service.zixun.IDownloadService;
import com.nb.nbpx.utils.JsonUtil;
import com.nb.nbpx.utils.SolrUtil;

@InterceptorRefs({
	@InterceptorRef("auctionStack")
})
@Component("DownloadAction")
@Scope("prototype")
public class DownloadAction extends BaseAction {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	public IDownloadService downloadService;
	public IKeywordService keywordService;
	public ISubjectService subjectService;
	public String filetype;
	public Download download;
	public File file;
	public Integer downloadId;
	public String title;
	public String description;
	public String author;
	public String downloadSubjects;
	public String downloadKeywords;
	public String fileContentType;
	public String fileFileName;
	public String category;

	public String queryDownloads() {
		String json = downloadService.queryDownloads(filetype, rows,
				getStartPosi(), sort, order);
		this.inputStream = castToInputStream(json);
		return SUCCESS;
	}

	public String saveDownload() {
		try {
			String regEx1 = "[\\pP‘’“”_]";
			if (downloadKeywords != null) {
				downloadKeywords = downloadKeywords.replace(" ", "");
				downloadKeywords = downloadKeywords.replaceAll(regEx1, ",");
			}
			List<Keyword> keys = keywordService.saveKeywords(category, downloadKeywords);
			if (downloadSubjects != null) {
				downloadSubjects = downloadSubjects.replace(" ", "");
				downloadSubjects = downloadSubjects.replaceAll(regEx1, ",");
			}
			List<Subject> subs = subjectService.saveSubjects(category, downloadSubjects);
			if (file != null) {
				String realpath = SolrUtil.getDownloadPath();

				String ext = FilenameUtils.getExtension(fileFileName);

				File savefile = new File(new File(realpath), title +"."+ ext);
				if (!savefile.getParentFile().exists())
					savefile.getParentFile().mkdirs();
				long lll = file.length();
				//System.out.println("lll" + lll);
				double size = (double) (Math.round((file.length() / 1000000.00) *100.00)/100.00);//Mb
				download = new Download(downloadId, title, savefile.getAbsolutePath(), filetype,
						description, author, new Date(), 200, 200,
						size,category);
				download = saveKeywords2Download(download,keys);
				download = saveSubjects2Download(download,subs);
				downloadService.saveDownload(download);
				FileUtils.copyFile(file, savefile);
			}else{
				download = downloadService.getById(downloadId);
				download.setTitle(title);
				download.setDescription(description);
				download.setAuthor(author);
				download.setFiletype(filetype);
				download.setUploadDate(new Date());
				download = saveKeywords2Download(download,keys);
				download = saveSubjects2Download(download,subs);
				downloadService.saveDownload(download);
			}
			//TODO save download info to Solr
		} catch (Exception e) {
			e.printStackTrace();
			this.inputStream = castToInputStream(JsonUtil.formatToOpResJson(
					ResponseStatus.FAIL,
					ResponseStatus.SAVE_FAILED + e.getMessage()));
			return "failure";
		}
		this.inputStream = castToInputStream(JsonUtil.formatToOpResJson(
				ResponseStatus.SUCCESS, ResponseStatus.SAVE_SUCCESS));
		return SUCCESS;
	}
	
	private Download saveKeywords2Download(Download download,List<Keyword> keys){
		for(Keyword key:keys){
			DownloadKeyword dk = new DownloadKeyword();
			dk.setDownload(download);
			dk.setKeyword(key.getKeyword());
			dk.setKeywordId(key.getKeyId());
			download.getDownloadKeywords().add(dk);
		}
		return download;
	}
	
	private Download saveSubjects2Download(Download download,List<Subject> subs){
		for(Subject sub:subs){
			DownloadSubject ds = new DownloadSubject();
			ds.setSubject(sub.getSubject());
			ds.setDownload(download);
			ds.setSubjectId(sub.getSubjectId());
			download.getDownloadSubjects().add(ds);
		}
		return download;
	}

	public String deleteDownload() {
		downloadService.deleteDownload(download);
		File tobedelete = new File(download.getFilepath());
		try {
			tobedelete.delete();
		} catch (Exception e) {
			e.printStackTrace();
			this.inputStream = castToInputStream(JsonUtil.formatToOpResJson(
					ResponseStatus.FAIL,
					ResponseStatus.DELETE_FAILED + e.getMessage()));
			return "failure";
		}
		this.inputStream = castToInputStream(JsonUtil.formatToOpResJson(
				ResponseStatus.SUCCESS, ResponseStatus.DELETE_SUCCESS));
		return SUCCESS;
	}

	public IDownloadService getDownloadService() {
		return downloadService;
	}

	@Resource
	public void setDownloadService(IDownloadService downloadService) {
		this.downloadService = downloadService;
	}

	public String getFiletype() {
		return filetype;
	}

	public void setFiletype(String filetype) {
		this.filetype = filetype;
	}

	public Download getDownload() {
		return download;
	}

	public void setDownload(Download download) {
		this.download = download;
	}

	public File getFile() {
		return file;
	}

	public void setFile(File file) {
		this.file = file;
	}

	public Integer getDownloadId() {
		return downloadId;
	}

	public void setDownloadId(Integer downloadId) {
		this.downloadId = downloadId;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public String getAuthor() {
		return author;
	}

	public void setAuthor(String author) {
		this.author = author;
	}

	public String getFileContentType() {
		return fileContentType;
	}

	public void setFileContentType(String fileContentType) {
		this.fileContentType = fileContentType;
	}

	public String getFileFileName() {
		return fileFileName;
	}

	public void setFileFileName(String fileFileName) {
		this.fileFileName = fileFileName;
	}

	public String getCategory() {
		return category;
	}

	public void setCategory(String category) {
		this.category = category;
	}

	public IKeywordService getKeywordService() {
		return keywordService;
	}

	@Resource
	public void setKeywordService(IKeywordService keywordService) {
		this.keywordService = keywordService;
	}

	public ISubjectService getSubjectService() {
		return subjectService;
	}

	@Resource
	public void setSubjectService(ISubjectService subjectService) {
		this.subjectService = subjectService;
	}

	public String getDownloadSubjects() {
		return downloadSubjects;
	}

	public void setDownloadSubjects(String downloadSubjects) {
		this.downloadSubjects = downloadSubjects;
	}

	public String getDownloadKeywords() {
		return downloadKeywords;
	}

	public void setDownloadKeywords(String downloadKeywords) {
		this.downloadKeywords = downloadKeywords;
	}


}
