/**
 * Created with IntelliJ IDEA.
 * User: Andrey Assaul
 * Date: 16.07.2015
 * Time: 23:01
 */
package com.trembit.mobile.navigator.commands {
import com.trembit.mobile.navigator.StateViewNavigatorTest;

import flash.events.Event;

public class SendTestCompleteCommand extends BaseTestCommand {

	override protected function execute():void {
		var navigator:StateViewNavigatorTest = this.navigator;
		onComplete(navigator);
		navigator.dispatchEvent(new Event("TestComplete"));
	}
}
}
