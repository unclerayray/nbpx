package com.nb.nbpx.keyword;

import java.util.StringTokenizer;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

/** */
/**
 * @author LJ-silver
 */
public class ReplaceKeyword {

	public ReplaceKeyword() {
		
	}
	
	public static String replaceKeyword(String targetString,
			String matchString, String replaceString) {
		String out;
		int targetLength = targetString.length();
		int replaceLength = replaceString.length();
		int matchLength = matchString.length();
		StringTokenizer st = new StringTokenizer(targetString, matchString);
		int firstIndex = targetString.indexOf(matchString);

		if (firstIndex < 0) {
			// 无匹配
			out = targetString;

			return out;
		}

		if (firstIndex > 0) {
			out = "";
		} else {
			// 以要替换的字符串开头
			out = replaceString;
		}

		while (st.hasMoreTokens()) {
			out += st.nextToken() + replaceString;
		}

		out = out.substring(0, out.length() - replaceLength);

		int lastIndex = targetString.lastIndexOf(matchString);

		// 以要替换的字符串结尾
		if (lastIndex == (targetLength - matchLength)) {
			out = out + replaceString;
		}

		return out;
	}
	
	public static String replaceText(String text,String keyword,int replaceTimes){
		int i=0;
		String replaceStr="";
		String regex="\\[key\\](.*?)\\[/key\\]";
		Pattern p =Pattern.compile(regex);
		Matcher m=p.matcher(text);
		while(m.find()){
			
			replaceStr+=m.group();
			if(keyword.equals(m.group(1))){
				i++;
				if(i<=replaceTimes){
			    	System.out.println(m.group(1));		    	
			    }
			}
		    if(m.group(1).equals("个人贷款")){
		    	
		    	System.out.println(m.group(1));
		    }
		    
		    
		}
		return replaceStr;
	}
	
	
	public static void main(String[] args) {
		
		String str = "卡的房间[key]贷款[/key]kdajfkl打开附件[key]个人贷款[/key]阿卡多几[key]贷款[/key]分快乐大师傅贷款";
		String keyword="贷款";
		int replaceTimes=1;
		/*String s[] = str.split("\\[key\\]");
		String s1 = "";
		for (int i = 0; i < s.length; i++) {
			//System.out.println(s[i]);
			if (i <= 0) {
				s1 = s1 + s[i];
			} else {
				s1 = s1
						+ ("[key]" + s[i])
								.replaceAll("\\[key\\]\\S{0,11}\\[/key\\]",
										"<a href='http://www.google.cn'>ddd</a>");
			}
		}
		System.out.println(s1);*/
		//System.out.println(str.replaceAll("\\[key\\]\\S*\\[/key\\]","[key]bb[/key]"));
		replaceText(str,keyword,replaceTimes);
		 //System.out.println(replaceText(str));
		
		System.out.println("发生的放卡贷款浪费adsAgdg爱过对方贷款;<a href='http://www.google.cn'>a</a>sdf;是否合法的".replaceAll("a", "<a href='http://www.google.cn'>a</a>"));
		
		System.out.println(replaceKeyword("发生的放卡贷款浪费adsgdg爱过对方贷款;<a href='http://www.google.cn'>a</a>sdf;是否合法的","贷款", "<a href='http://www.google.cn'>贷款</a>"));
	}

}
