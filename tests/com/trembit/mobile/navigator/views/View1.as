/**
 * Created with IntelliJ IDEA.
 * User: Andrey Assaul
 * Date: 16.07.2015
 * Time: 18:57
 */
package com.trembit.mobile.navigator.views {
import spark.components.View;

public class View1 extends View {

	override public function set data(value:Object):void {
		super.data = value;
		title = data.title;
	}
}
}
