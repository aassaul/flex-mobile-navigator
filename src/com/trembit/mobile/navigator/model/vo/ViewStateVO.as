/**
 * Created with IntelliJ IDEA.
 * User: Andrey Assaul
 * Date: 16.07.2015
 * Time: 3:34
 */
package com.trembit.mobile.navigator.model.vo {
import com.trembit.as3commands.events.CommandEvent;
import com.trembit.navigation.model.vo.StateVO;

public class ViewStateVO extends StateVO {

	[Transient]
	public var view:Class;

	[Bindable]
	[Transient]
	public var title:String;

	public function ViewStateVO(stateType:String = null, view:Class = null, prepareCommand:Class = null,
								subStates:Vector.<StateVO> = null, previousState:StateVO = null, title:String = null,
								completeEvent:CommandEvent = null, faultEvent:CommandEvent = null) {
		this.view = view;
		this.title = title;
		super(stateType, prepareCommand, subStates, previousState, completeEvent, faultEvent);
	}

	override public function synchronizeWith(source:*):void {
		var title:String = this.title||source.title;
		super.synchronizeWith(source);
		this.title = title;
	}
}
}
