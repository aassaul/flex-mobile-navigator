/**
 * Created with IntelliJ IDEA.
 * User: Andrey Assaul
 * Date: 16.07.2015
 * Time: 23:03
 */
package com.trembit.mobile.navigator.commands {
import com.trembit.as3commands.commands.Command;
import com.trembit.mobile.navigator.StateViewNavigatorTest;

public class BaseTestCommand extends Command {
	protected final function get navigator():StateViewNavigatorTest {
		return event.data;
	}
}
}
