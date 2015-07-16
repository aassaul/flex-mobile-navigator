/**
 * Created with IntelliJ IDEA.
 * User: Andrey Assaul
 * Date: 17.07.2015
 * Time: 0:34
 */
package com.trembit.mobile.navigator.commands {
import com.trembit.as3commands.util.Commands;

import flash.events.Event;

import flash.utils.setTimeout;

import flexunit.framework.Assert;

public class BaseOneStepCommand extends BaseTestCommand{

	protected var nextSateIndex:int;

	override public function get isSingleton():Boolean {
		return false;
	}

	override protected function execute():void {
		if(nextSateIndex >= 0 && nextSateIndex < navigator.viewStates.length){
			Commands.run(navigator.viewStates[nextSateIndex].event);
			navigator.validateNow();
			navigator.dispatchEvent(new Event(Event.ENTER_FRAME));
			setTimeout(assertValidStateAtIndex, navigator.waitDelay, nextSateIndex);
		} else {
			onComplete(navigator);
		}
	}

	private function assertValidStateAtIndex(index:int):void{
		Assert.assertTrue(navigator.activeView is navigator.viewStates[index].view);
		Assert.assertEquals(navigator.activeView.data, navigator.viewStates[index]);
		onComplete(navigator);
	}
}
}
