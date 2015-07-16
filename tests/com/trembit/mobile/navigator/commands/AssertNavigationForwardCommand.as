/**
 * Created with IntelliJ IDEA.
 * User: Andrey Assaul
 * Date: 16.07.2015
 * Time: 21:59
 */
package com.trembit.mobile.navigator.commands {
import com.trembit.as3commands.util.Commands;

import flash.events.Event;
import flash.utils.setTimeout;

import flexunit.framework.Assert;

public class AssertNavigationForwardCommand extends BaseOneStepCommand {
	override protected function execute():void {
		nextSateIndex = navigator.viewStates.indexOf(navigator.activeView.data) + 1;
		super.execute();
	}
}
}
