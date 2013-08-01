package com.nb.nbpx.course;

import java.util.Date;
import java.util.List;

import javax.annotation.Resource;

import junit.framework.Assert;

import org.apache.commons.lang.StringUtils;
import org.junit.Test;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.test.annotation.Rollback;
import org.springframework.transaction.annotation.Transactional;

import com.nb.nbpx.BaseServiceTest;
import com.nb.nbpx.dao.course.ICourseDao;
import com.nb.nbpx.dao.keyword.IKeywordDao;
import com.nb.nbpx.dto.course.CourseAllInfoDto;
import com.nb.nbpx.pojo.course.Course;
import com.nb.nbpx.pojo.course.CourseInfo;
import com.nb.nbpx.pojo.keyword.Keyword;
import com.nb.nbpx.service.course.ICourseService;

/**
 * Course模块的单元测试类
 * @author Roger
 * @date 2013年7月20日
 */
/**
 * Course模块的单元测试类
 * 
 * @author Roger
 * @date 2013年7月20日
 */
public class CourseServiceTest extends BaseServiceTest {
	@Resource
	private ICourseService courseService;
	@Resource
	private ICourseDao courseDao;
	@Resource
	private IKeywordDao keywordDao;

	/**
	 * 测试保存后怎么获取ID
	 */
	@Test
	@Rollback(false)
	//@Transactional
	public void testSaveCourse() {
		String content = "简介如果您听说过 Node，或者阅读过一些文章，宣称 Node 是多么多么的棒，那么您可能会想：“Node 究竟是什么东西？” 即便是在参阅 Node 的主页之后，您甚至可能还是 不明白 Node 为何物？Node 肯定不适合每个程序员，但它可能是某些程序员一直苦苦追寻的东西。为试图解释什么是 Node.js，本文将简要介绍一些背景信息：它要解决的问题，它如何工作，如何运行一个简单应用程序，最后，Node 在什么情况下是一个好的解决方案。本文不涉及如何编写一个复杂的 Node 应用程序，也不是一份全面的 Node 教程。阅读本文应该有助于您决定是否应该继续学习 Node，以便将其用于您的业务。回页首Node 旨在解决什么问题？Node 公开宣称的目标是 “旨在提供一种简单的构建可伸缩网络程序的方法”。当前的服务器程序有什么问题？我们来做个数学题。在 Java™ 和 PHP 这类语言中，每个连接都会生成一个新线程，每个新线程可能需要 2 MB 的配套内存。在一个拥有 8 GB RAM 的系统上，理论上最大的并发连接数量是 4,000 个用户。随着您的客户群的增长，如果希望您的 Web 应用程序支持更多用户，那么，您必须添加更多服务器。当然，这会增加服务器成本、流量成本和人工成本等成本。除这些成本上升外，还有一个潜在技术问题，即用户可能针对每个请求使用不同的服务器，因此，任何共享资源都必须在所有服务器之间共享。鉴于上述所有原因，整个 Web 应用程序架构（包括流量、处理器速度和内存速度）中的瓶颈是：服务器能够处理的并发连接的最大数量。Node 解决这个问题的方法是：更改连接到服务器的方式。每个连接发射一个在 Node 引擎的进程中运行的事件，而不是为每个连接生成一个新的 OS 线程（并为其分配一些配套内存）。Node 声称它绝不会死锁，因为它根本不允许使用锁，它不会直接阻塞 I/O 调用。Node 还宣称，运行它的服务器能支持数万个并发连接。现在您有了一个能处理数万个并发连接的程序，那么您能通过 Node 实际构建什么呢？如果您有一个 Web 应用程序需要处理这么多连接，那将是一件很 “恐怖” 的事！那是一种 “如果您有这个问题，那么它根本不是问题” 的问题。在回答上面的问题之前，我们先看看 Node 的工作原理以及它的设计运行方式。回页首Node 肯定不是什么？没错，Node 是一个服务器程序。但是，基础 Node 产品肯定不 像 Apache 或 Tomcat。本质上，那些服务器 “安装就绪型” 服 务器产品，支持立即部署应用程序。通过这些产品，您可以在一分钟内启动并运行一个服务器。Node 肯定不是这种产品。Apache 能通过添加一个 PHP 模块来允许开发人员创建动态 Web 页，添加一个 SSL 模块来实现安全连接，与此类似，Node 也有模块概念，允许向 Node 内核添加模块。实际上，可供选择的用于 Node 的模块有数百个之多，社区在创建、发布和更新模块方面非常活跃，一天甚至可以处理数十个模块。本文后面将讨论 Node 的整个模块部分。回页首Node 如何工作？Node 本身运行 V8 JavaScript。等等，服务器上的 JavaScript？没错，您没有看错。对于只在客户机上使用 JavaScript 的程序员而言，服务器端 JavaScript 可能是一个新概念，但这个概念本身并非遥不可及，因此为何不能在服务器上使用客户机上使用的编程语言？什么是 V8？V8 JavaScript 引擎是 Google 用于其 Chrome 浏览器的底层 JavaScript 引擎。很少有人考虑 JavaScript 在客户机上实际做了些什么？实际上，JavaScript 引擎负责解释并执行代码。Google 使用 V8 创建了一个用 C++ 编写的超快解释器，该解释器拥有另一个独特特征；您可以下载该引擎并将其嵌入任何 应用程序。V8 JavaScript 引擎并不仅限于在一个浏览器中运行。因此，Node 实际上会使用 Google 编写的 V8 JavaScript 引擎，并将其重建为可在服务器上使用。太完美了！既然已经有一个不错的解决方案可用，为何还要创建一种新语言呢？";
		Course course = new Course(null, "我去", content);
		CourseAllInfoDto dto = new CourseAllInfoDto(course);

		try {
			course = courseService.saveCourse(course);
			System.out.println("-------------courseId = " + course.getCourseId());
			Assert.assertNotNull(course.getCourseId());
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	@Test
	@Rollback(true)
	@Transactional
	public void testSaveCourseInfo() {
		CourseInfo courseInfo = new CourseInfo(null, 2, new Date(), new Date(),
				"003_01", "深圳");
		courseService.saveCourseInfo(courseInfo);
		Assert.assertNotNull(courseInfo.getCourseInfoId());
	}

	@Test
	public void testStringJoin() {
		String hql = "select keyword from com.nb.nbpx.pojo.course.CourseKeyword where courseId = 10";
		List list = courseDao.find(hql);
		String sss = StringUtils.join(list, ",");
		System.out.println("sss = " + sss);
		Assert.assertNotNull(sss);
	}

	/**
	 * 测试违反唯一索引限制后会不会返回主键，结论是不会
	 */
	@Test
	@Transactional
	public void testDumplicateKeyword() {
		Keyword keyword = new Keyword();
		keyword.setKeyword("国家");
				//(null, "国家", true, null, null);
		try {
			keywordDao.save(keyword);
		} catch (DataIntegrityViolationException e) {
			Assert.assertFalse(false);
		}
		System.out.println(keyword.getKeyId());
		Assert.assertNotNull(keyword.getKeyId());
	}
}
