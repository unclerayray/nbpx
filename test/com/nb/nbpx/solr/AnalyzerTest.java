package com.nb.nbpx.solr;

import java.io.IOException;
import java.io.StringReader;
import java.util.ArrayList;
import java.util.List;

import org.apache.lucene.analysis.Analyzer;
import org.apache.lucene.analysis.Token;
import org.apache.lucene.analysis.TokenStream;
import org.junit.Before;
import org.junit.Ignore;
import org.junit.Test;

import com.chenlb.mmseg4j.analysis.ComplexAnalyzer;
import com.chenlb.mmseg4j.analysis.MaxWordAnalyzer;
import com.chenlb.mmseg4j.analysis.SimpleAnalyzer;
import com.chenlb.mmseg4j.analysis.TokenUtils;

public class AnalyzerTest {

	String txt = "";

	@Before
	public void before() throws Exception {
		txt = "京华时报２００９年1月23日报道 昨天，受一股来自中西伯利亚的强冷空气影响，本市出现大风降温天气，白天最高气温只有零下7摄氏度，同时伴有6到7级的偏北风。";
		txt = "２００９年ゥスぁま是中 ＡＢｃｃ国абвгαβγδ首次,我的ⅠⅡⅢ在chenёlbēū全国ㄦ范围ㄚㄞㄢ内①ē②㈠㈩⒈⒑发行地方政府债券，";
	}

	@Test
	@Ignore
	public void testSimple() {
		SimpleAnalyzer analyzer = new SimpleAnalyzer();
		System.out.println("txt = " +txt);
		//ēū
		//txt = "２００９年ゥスぁま是中ＡＢｃｃ国абвгαβγδ首次,我的ⅠⅡⅢ在chenёlbēū全国ㄦ范围ㄚㄞㄢ内①②㈠㈩⒈⒑发行地方政府债券，";
		try {
			printlnToken(txt, analyzer);
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	@Test
	@Ignore
	public void testComplex() {
		Analyzer analyzer = new ComplexAnalyzer();
		try {
			//txt = "1884年,中法战争时被派福建会办海疆事务";
			//txt = "1999年12345日报道了一条新闻,2000年中法国足球比赛";
			/*txt = "第一卷 云天落日圆 第一节 偷欢不成倒大霉";
			txt = "中国人民银行";
			txt = "我们";
			txt = "工信处女干事每月经过下属科室都要亲口交代24口交换机等技术性器件的安装工作";*/
			//ComplexSeg.setShowChunk(true);
			printlnToken(txt, analyzer);
			//txt = "核心提示：3月13日上午，近3000名全国人大代表按下表决器，高票批准了温家宝总理代表国务院所作的政府工作报告。这份工作报告起草历时3个月，由温家宝总理亲自主持。";
			//printlnToken(txt, analyzer);
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	@Test
	@Ignore
	public void testMaxWord() {
		Analyzer analyzer = new MaxWordAnalyzer();
		try {
			//txt = "1884年,中法战争时被派福建会办海疆事务";
			//txt = "1999年12345日报道了一条新闻,2000年中法国足球比赛";
			//txt = "第一卷 云天落日圆 第一节 偷欢不成倒大霉";
			//txt = "中国人民银行";
			//txt = "下一个 为什么";
			//txt = "我们家门前的大水沟很难过";
			//ComplexSeg.setShowChunk(true);
			printlnToken(txt, analyzer);
			//txt = "核心提示：3月13日上午，近3000名全国人大代表按下表决器，高票批准了温家宝总理代表国务院所作的政府工作报告。这份工作报告起草历时3个月，由温家宝总理亲自主持。";
			//printlnToken(txt, analyzer);
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	private void printlnToken(String txt, Analyzer analyzer) throws IOException {
		System.out.println("---------"+txt.length()+"\n"+txt);
		TokenStream ts = analyzer.tokenStream("text", new StringReader(txt));
		/*//lucene 2.9 以下
		for(Token t= new Token(); (t=ts.next(t)) !=null;) {
			System.out.println(t);
		}*/
		/*while(ts.incrementToken()) {
			TermAttribute termAtt = (TermAttribute)ts.getAttribute(TermAttribute.class);
			OffsetAttribute offsetAtt = (OffsetAttribute)ts.getAttribute(OffsetAttribute.class);
			TypeAttribute typeAtt = (TypeAttribute)ts.getAttribute(TypeAttribute.class);

			System.out.println("("+termAtt.term()+","+offsetAtt.startOffset()+","+offsetAtt.endOffset()+",type="+typeAtt.type()+")");
		}*/
		for(Token t= new Token(); (t=TokenUtils.nextToken(ts, t)) !=null;) {
			System.out.println(t);
		}
	}

	public static List<String> toWords(String txt, Analyzer analyzer) {
		List<String> words = new ArrayList<String>();
		TokenStream ts;
		try {
			ts = analyzer.tokenStream("text", new StringReader(txt));
			for(Token t= new Token(); (t=TokenUtils.nextToken(ts, t)) !=null;) {
				words.add(t.toString());
			}
		} catch (IOException e) {}

		return words;
	}
	
	
	@Test
	public void testCutTxt(){
		String text="基于java语言开发的轻量级的中文分词工具包";  
        //StringReader sr=new StringReader(text);  
        Analyzer analyzer = new MaxWordAnalyzer();
        //analyzer.tokenStream("text", sr);
        
        List<String> toWords =  toWords(  text, analyzer);
        for(String str:toWords){
            System.out.println(str);
        }
        System.out.println("gagagah");
	}
}
