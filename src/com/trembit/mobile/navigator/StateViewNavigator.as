/**
 * Created with IntelliJ IDEA.
 * User: Andrey Assaul
 * Date: 16.07.2015
 * Time: 3:25
 */
package com.trembit.mobile.navigator {
import com.trembit.mobile.navigator.model.vo.ViewStateVO;
import com.trembit.navigation.events.NavigationModelEvent;
import com.trembit.navigation.model.NavigationModel;
import com.trembit.navigation.model.vo.StateVO;

import spark.components.ViewNavigator;
import spark.transitions.ViewTransitionBase;

public class StateViewNavigator extends ViewNavigator {

	private var _model:NavigationModel;

	public function setNavigationStates(value:Vector.<ViewStateVO> = null, start:ViewStateVO = null):void {
		if(_model){
			_model.addEventListener(NavigationModelEvent.CURRENT_STATE_CHANGE, onStateChange);
		}
		popAll();
		if(value){
			var states:Vector.<StateVO> = new Vector.<StateVO>(value.length, true);
			for (var i:int = 0; i < value.length; i++) {
				states[i] = value[i];
			}
			_model = new NavigationModel(states);
			_model.addEventListener(NavigationModelEvent.CURRENT_STATE_CHANGE, onStateChange);
			_model.activate(start);
		}
	}

	private function onStateChange(event:NavigationModelEvent):void {
		if(!activeView){
			firstView = ViewStateVO(event.newState).view;
			firstViewData = event.newState;
		} else if(event.newState.equals(event.previousState)){
			activeView.data = event.newState;
		} else{
			var transition:ViewTransitionBase = event.newState.isPreviousForState(event.previousState)?defaultPopTransition:defaultPushTransition;
			replaceView(ViewStateVO(event.newState).view, event.newState, null, transition)
		}
	}
}
}
