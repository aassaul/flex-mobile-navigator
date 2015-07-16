/**
 * Created with IntelliJ IDEA.
 * User: Andrey Assaul
 * Date: 16.07.2015
 * Time: 22:11
 */
package com.trembit.mobile.navigator.commands {
import com.trembit.as3commands.util.Commands;
import com.trembit.mobile.navigator.model.vo.ViewStateVO;
import com.trembit.navigation.model.vo.StateVO;

import flash.utils.setTimeout;

import flexunit.framework.Assert;

import spark.components.View;

public class AssertChangeViewStateCommand extends BaseTestCommand {

	private var viewState:ViewStateVO;

	override protected function execute():void {
		viewState = getStateWithSubStates();
		if(viewState){
			Commands.run(viewState.event);
			setTimeout(executeInternal, navigator.waitDelay, 0);
		} else {
			onComplete(navigator);
		}
	}

	private function executeInternal(index:int):void {
		if(index < this.viewState.subStates.length){
			var currentView:View = navigator.activeView;
			var currentViewState:ViewStateVO = ViewStateVO(navigator.activeView.data);
			var stateVO:StateVO = this.viewState.subStates[index];
			Commands.run(stateVO.event);
			Assert.assertEquals(currentView, navigator.activeView);
			Assert.assertEquals(stateVO, navigator.activeView.data);
			Assert.assertFalse(currentViewState == navigator.activeView.data);
			setTimeout(executeInternal, navigator.waitDelay, index+1);
		} else {
			viewState = null;
			onComplete(navigator);
		}
	}

	private function getStateWithSubStates():ViewStateVO{
		for each (var viewStateVO:ViewStateVO in navigator.viewStates) {
			if(viewStateVO.subStates && viewStateVO.subStates.length){
				return viewStateVO;
			}
		}
		return null;
	}
}
}
