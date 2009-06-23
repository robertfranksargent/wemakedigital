package com.wemakedigital.state.view {	import com.wemakedigital.state.model.StateProxy;	import org.puremvc.as3.multicore.interfaces.INotification;	import org.puremvc.as3.multicore.patterns.mediator.Mediator;	/**	 * Base class for Mediators that respond to state changes issued by the 	 * state proxy.	 */	public class StateResponderMediator extends Mediator implements IStateResponder 	{		//----------------------------------------------------------------------		//		//  Variables		//		//----------------------------------------------------------------------		protected var lastStateNotification : String ;		//----------------------------------------------------------------------		//		//  Constructor		//		//----------------------------------------------------------------------				/**		 * Class constructor.		 * 		 * @param mediatorName The name of the mediator.		 * @param viewComponent A view component.		 */		public function StateResponderMediator ( mediatorName : String = null, viewComponent : Object = null )		{			super( mediatorName, viewComponent );		}				//----------------------------------------------------------------------		//		//  Methods		//		//----------------------------------------------------------------------				/**		 * Lists the states this mediator will respond to.		 * 		 * @return An Array of state ids.		 */		public function listStateInterests () : Array		{			return [];		}				/**		 * @inheritDoc		 */			override public function listNotificationInterests () : Array		{			return this.listStateInterests().concat( super.listNotificationInterests() );		}				/**		 * @inheritDoc		 */			override public function onRegister () : void		{			super.onRegister() ;						// Add this mediator as a responder for all of its state interests.			for each ( var state : String in this.listStateInterests() ) 				this.sendNotification( state , this, StateProxy.ADD_RESPONDER ) ;		}				/**		 * @inheritDoc		 */			override public function onRemove () : void		{			super.onRemove() ;						// Remove this mediator as a responder for all of its state interests.			for each ( var state : String in this.listStateInterests() )				this.sendNotification( state , this, StateProxy.REMOVE_RESPONDER ) ;		}				override public function handleNotification ( note : INotification ) : void		{			var notificationName : String = note.getName() ;			for each ( var state : String in this.listStateInterests() )				if ( notificationName == state ) this.lastStateNotification = notificationName ;		}		/**		 * Shortcut for sending the exit response state notification.		 * 		 * @param state The state name.		 */		protected function sendExitResponse( state : String ) : void		{			this.sendNotification( state, this, StateProxy.EXIT_RESPONSE ) ;		}				/**		 * Shortcut for sending the enter response state notification.		 * 		 * @param state The state name.		 */		protected function sendEnterResponse( state : String ) : void		{			this.sendNotification( state, this, StateProxy.ENTER_RESPONSE ) ;		}	}}