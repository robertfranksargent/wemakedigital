package com.wemakedigital.state.example.gumballmachine.model {	import com.wemakedigital.log.Log;		import org.puremvc.as3.multicore.interfaces.IProxy;	import org.puremvc.as3.multicore.patterns.proxy.Proxy;		/**	 * Keeps track of the number of gumballs in the machine.	 */	public class GumballCounterProxy extends Proxy implements IProxy 	{		/**		 * Defines the name of the Proxy.		 */		public static const NAME : String = "GumballMachineProxy";				/**		 * Class constructor.		 * 		 * @param proxyName	Proxy identifier, defaults to "GumballMachineProxy".		 * @param data		The initial number of gumballs in the machine.		 */		public function GumballCounterProxy ( proxyName : String = GumballCounterProxy.NAME, data : Object = 0 )		{			Log.stackTrace( this, "GumballCounterProxy", proxyName, data ) ;			super( proxyName , data );		}				/**		 * The number of gumballs in the machine.		 */		public function get gumballCount () : int		{			return this.data as int;		}		/**		 * The number of gumballs in the machine.		 */		public function set gumballCount ( value : int ) : void		{			this.data = value;		}	}}