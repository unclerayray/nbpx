package com.nb.nbpx.utils;

import java.util.ArrayList;
import java.util.List;

import net.sourceforge.pinyin4j.PinyinHelper;
import net.sourceforge.pinyin4j.format.HanyuPinyinCaseType;
import net.sourceforge.pinyin4j.format.HanyuPinyinOutputFormat;
import net.sourceforge.pinyin4j.format.HanyuPinyinToneType;
import net.sourceforge.pinyin4j.format.HanyuPinyinVCharType;
import net.sourceforge.pinyin4j.format.exception.BadHanyuPinyinOutputFormatCombination;

public class PinYinUtil {
	
	public static String getPinYin(String inputString) {
		
		HanyuPinyinOutputFormat format = new HanyuPinyinOutputFormat();
		format.setCaseType(HanyuPinyinCaseType.LOWERCASE);
		//format.setToneType(HanyuPinyinToneType.WITH_TONE_MARK);
		format.setToneType(HanyuPinyinToneType.WITHOUT_TONE);
		format.setVCharType(HanyuPinyinVCharType.WITH_U_UNICODE);

		char[] input = inputString.trim().toCharArray();
		StringBuffer output = new StringBuffer("");

		try {
			for (int i = 0; i < input.length; i++) {
				if (Character.toString(input[i]).matches("[\u4E00-\u9FA5]+")) {
					String[] temp = PinyinHelper.toHanyuPinyinStringArray(input[i], format);
					output.append(temp[0]);
					output.append("");
				} else
					output.append(Character.toString(input[i]));
			}
		} catch (BadHanyuPinyinOutputFormatCombination e) {
			e.printStackTrace();
		}
		return output.toString();
	}
	
public static List<String> getPinYinList(String inputString) {
		List<String> list = new ArrayList<String>();
		HanyuPinyinOutputFormat format = new HanyuPinyinOutputFormat();
		format.setCaseType(HanyuPinyinCaseType.LOWERCASE);
		//format.setToneType(HanyuPinyinToneType.WITH_TONE_MARK);
		format.setToneType(HanyuPinyinToneType.WITHOUT_TONE);
		format.setVCharType(HanyuPinyinVCharType.WITH_U_UNICODE);

		char[] input = inputString.trim().toCharArray();
		StringBuffer output = new StringBuffer("");
		StringBuffer outputInit = new StringBuffer("");
		StringBuffer output1stInit = new StringBuffer("");
		StringBuffer output2ndInit = new StringBuffer("");
		try {
			for (int i = 0; i < input.length; i++) {
				if (Character.toString(input[i]).matches("[\u4E00-\u9FA5]+")) {
					String[] temp = PinyinHelper.toHanyuPinyinStringArray(input[i], format);
					output.append(temp[0]);
					outputInit.append(temp[0].substring(0, 1));
					if(i==0){
						output1stInit.append(temp[0]);
						output2ndInit.append(temp[0]);
					}else if(i==1){
						output1stInit.append(temp[0].substring(0, 1));
						output2ndInit.append(temp[0]);
					}else{
						output1stInit.append(temp[0].substring(0, 1));
						output2ndInit.append(temp[0].substring(0, 1));
					}
				} else
					output.append(Character.toString(input[i]));
			}
		} catch (BadHanyuPinyinOutputFormatCombination e) {
			e.printStackTrace();
		}
		list.add(output.toString());
		list.add(outputInit.toString());
		list.add(output1stInit.toString());
		list.add(output2ndInit.toString());
		return list;
	}
	
	public static void main(String[] args) {
		String chs = "我是中国人! I'm Chinese!";
		System.out.println(chs);
		System.out.println(getPinYin(chs));
		List<String> list = getPinYinList(chs);
		for(String str:list){
			System.out.println(str);
		}
	}
	
}