/**
 * Created with IntelliJ IDEA.
 * User: Andrey Assaul
 * Date: 16.07.2015
 * Time: 18:00
 */
package com.trembit.mobile.navigator {
import com.trembit.as3commands.events.SequenceCommandEvent;
import com.trembit.as3commands.util.Commands;
import com.trembit.mobile.navigator.commands.AssertChangeViewStateCommand;
import com.trembit.mobile.navigator.commands.AssertNavigationBackwardCommand;
import com.trembit.mobile.navigator.commands.AssertNavigationForwardCommand;
import com.trembit.mobile.navigator.commands.SendTestCompleteCommand;
import com.trembit.mobile.navigator.model.vo.ViewStateVO;
import com.trembit.mobile.navigator.model.vo.ViewStateVO;
import com.trembit.mobile.navigator.views.View1;
import com.trembit.mobile.navigator.views.View2;
import com.trembit.mobile.navigator.views.View3;
import com.trembit.mobile.navigator.views.View4;
import com.trembit.navigation.model.vo.StateVO;

import flash.events.Event;
import flash.utils.setTimeout;

import flexunit.framework.Assert;

import mx.core.FlexGlobals;

import org.flexunit.async.Async;

public class StateViewNavigatorTest extends StateViewNavigator{

	public var viewStates:Vector.<ViewStateVO>;

	public var waitDelay:Number;

	private var completeHandler:Function;

	[Before]
	public function init():void{
		percentHeight = 100;
		percentWidth = 100;
		FlexGlobals.topLevelApplication.addElement(this);
		waitDelay = 2000;
		viewStates = new <ViewStateVO>[
			new ViewStateVO("state1", View1, null, null, null, "state1"),
			new ViewStateVO("state2", View2, null, new <StateVO>[
				new ViewStateVO(null, null, null, null, null, "subState1"),
				new ViewStateVO(null, null, null, null, null, "subState2"),
				new ViewStateVO()
			], null, "state2"),
			new ViewStateVO("state3", View3, null, null, null, "state3"),
			new ViewStateVO("state4", View4, null, null, null, "state4")
		];
	}

	[After]
	public function dispose():void {
		FlexGlobals.topLevelApplication.removeElement(this);
	}

	[Test(order="0")]
	public function testTitleChange():void {
		Assert.assertEquals(ViewStateVO(viewStates[1].subStates[2]).title, viewStates[1].title);
		Assert.assertEquals(ViewStateVO(viewStates[1].subStates[0]).title, "subState1");
		Assert.assertEquals(ViewStateVO(viewStates[1].subStates[1]).title, "subState2");
	}

	[Test(async, order="1")]
	public function testSetStates():void {
		setNavigationStates(viewStates);
		validateNow();
		dispatchEvent(new Event(Event.ENTER_FRAME));
		Assert.assertNotNull(activeView);
		Assert.assertTrue(activeView is viewStates[0].view);
		Assert.assertEquals(activeView.data, viewStates[0]);
		completeHandler = Async.asyncHandler(this, onTestComplete, waitDelay*10, null, null);
		addEventListener("TestComplete", completeHandler, false, 0, true );
		setTimeout(Commands.run, waitDelay, new SequenceCommandEvent(new <Class>[
			AssertNavigationForwardCommand, AssertNavigationForwardCommand, AssertNavigationForwardCommand,
			AssertChangeViewStateCommand, SendTestCompleteCommand], this));
	}

	[Test(async, order="2")]
	public function testSetStartState():void {
		for (var i:int = 1; i < viewStates.length; i++) {
			viewStates[i].previousState = viewStates[i-1];
		}
		setNavigationStates(viewStates, viewStates[2]);
		validateNow();
		dispatchEvent(new Event(Event.ENTER_FRAME));
		Assert.assertNotNull(activeView);
		Assert.assertTrue(activeView is viewStates[2].view);
		Assert.assertEquals(activeView.data, viewStates[2]);
		completeHandler = Async.asyncHandler(this, onTestComplete, waitDelay*15, null, null);
		addEventListener("TestComplete", completeHandler, false, 0, true );
		setTimeout(Commands.run, waitDelay, new SequenceCommandEvent(new <Class>[
			AssertNavigationBackwardCommand, AssertNavigationBackwardCommand,
			AssertNavigationForwardCommand, AssertNavigationForwardCommand, AssertNavigationForwardCommand,
			SendTestCompleteCommand], this));
	}

	private function onTestComplete(event:Event, data:*):void{
		this.removeEventListener("TestComplete", completeHandler);
		completeHandler = null;
		setNavigationStates();
	}
}
}
