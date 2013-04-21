/*
Author���źƻ�
Date��2011.12.27 1:18
*/

/* ��һ����ǩ */
function OpenTab(title, url, icon){
	/**
	����������ı�ǩ���ڣ���ѡ��ñ�ǩ
	�������һ����ǩ����ǩ��
	*/
	if($("#tabs").tabs('exists', title)){
		$("#tabs").tabs('select', title);
	}else{
		$("#tabs").tabs('add',{
			title: title,
			content: createTabContent(url),
			closable: true,
			icon: icon
		});
	}	
}

/* ���ɱ�ǩ���� */
function createTabContent(url){
	return '<iframe style="width:100%;height:100%;" scrolling="auto" frameborder="0" src="' + url + '"></iframe>';
}

$(function(){

	//ˢ��
	$("#m-refresh").click(function(){
		var currTab = $('#tabs').tabs('getSelected');	//��ȡѡ�еı�ǩ��
		var url = $(currTab.panel('options').content).attr('src');	//��ȡ��ѡ������ݱ�ǩ��iframe���� src ����
		/* �������øñ�ǩ */
		$('#tabs').tabs('update',{
			tab:currTab,
			options:{
				content: createTabContent(url)
			}
		})
	});
	
	//�ر�����
	$("#m-closeall").click(function(){
		$(".tabs li").each(function(i, n){
			var title = $(n).text();
			$('#tabs').tabs('close',title);	
		});
	});
	
	//����ǰ֮��ر�����
	$("#m-closeother").click(function(){
		var currTab = $('#tabs').tabs('getSelected');
		currTitle = currTab.panel('options').title;	
		
		$(".tabs li").each(function(i, n){
			var title = $(n).text();
			
			if(currTitle != title){
				$('#tabs').tabs('close',title);			
			}
		});
	});
	
	//�رյ�ǰ
	$("#m-close").click(function(){
		var currTab = $('#tabs').tabs('getSelected');
		currTitle = currTab.panel('options').title;	
		$('#tabs').tabs('close', currTitle);
	});
});

