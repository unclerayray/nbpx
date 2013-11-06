package com.nb.nbpx.task;
import java.util.Date;
import java.util.TimerTask;
public class DataBaseTask extends TimerTask {
	private static boolean running = false;
	 
	 @Override
	 public void run() {
	  if(!running){
	   running = true;   
	   //添加计划调度任务;
	   System.out.println((new Date())+"Hey! I'm running!!");
	   running = false;
	  }else{
	   System.out.println("DataBaseTask is running!");
	  }
	 }
}
