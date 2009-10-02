package com.wemakedigital.state.model{	import com.wemakedigital.log.Log;	import com.wemakedigital.state.controller.StateEventCommand;	import com.wemakedigital.state.controller.StateResponderCommand;	import com.wemakedigital.state.view.IStateResponder;		import org.puremvc.as3.multicore.interfaces.IProxy;	import org.puremvc.as3.multicore.patterns.proxy.Proxy;		/**	 * The StateProxy state machine is responsible for maintaining application state.	 */	public class StateProxy extends Proxy implements IProxy 	{			//----------------------------------------------------------------------		//		//  Constants		//		//----------------------------------------------------------------------				/**		 * Defines the name of the Proxy.		 */		public static const NAME : String = "StateProxy" ;				/**		 * Notification sent when a state change or state event is successfully called.		 */		public static const CALLED : String = "StateProxy.CALLED";				/**		 * Notification sent when a state change or state event error occurs.		 */		public static const ERROR : String = "StateProxy.ERROR" ;				/**		 * Notification sent when a state change or state event has completed.		 */		public static const COMPLETE : String = "StateProxy.COMPLETE";				/**		 * Type sent with CALLED, ERROR, or COMPLETE state notification.		 */		public static const EVENT : String = "StateProxy.EVENT" ;				/**		 * Type sent with CALLED, ERROR, or COMPLETE state notification.		 */		public static const STATE : String = "StateProxy.STATE" ;				/**		 * Type sent with state or event notification telling the state machine 		 * not to ask for confirmation. 		 */		public static const CALL : String = "StateProxy.CALL";		/**		 * Type sent with state or event notification telling the state machine 		 * to ask for confirmation before calling.		 */		public static const CALL_CONFIRM : String = "StateProxy.CALL_CONFIRM";				/**		 * Notification sent asking for confirmation before proceeding with an 		 * event or state call.		 */		public static const CONFIRM : String = "StateProxy.CONFIRM";				/**		 * Notification sent in response to a StateProxy.CONFIRM notification.		 */		public static const CONFIRM_RESPONSE : String = "StateProxy.CONFIRM_RESPONSE";				/**		 * Type sent with state notification by a state responder adding it as a 		 * responder to changes in the state.		 */		public static const ADD_RESPONDER : String = "StateProxy.ADD_RESPONDER";		/**		 * Type sent with state notification by a state responder removing it as 		 * a responder to changes in the state.		 */		public static const REMOVE_RESPONDER : String = "StateProxy.REMOVE_RESPONDER";		/**		 * Type sent with state notification by the state proxy instructing all 		 * responders to exit the state.		 */		public static const EXIT : String = "StateProxy.EXIT";		/**		 * Type sent with state notification by a state responder informing the 		 * state proxy that is has exited the state.		 */		public static const EXIT_RESPONSE : String = "StateProxy.EXIT_RESPONSE";		/**		 * Type sent with state notification by the state proxy instructing all 		 * responders to enter the state.		 */		public static const ENTER : String = "StateProxy.ENTER";				/**		 * Type sent with state notification by a state responder informing the 		 * state proxy that is has entered the state.		 */		public static const ENTER_RESPONSE : String = "StateProxy.ENTER_RESPONSE";		//----------------------------------------------------------------------		//		//  Variables		//		//----------------------------------------------------------------------						/**		 * Map of States objects by name.		 */		private var states : Object;		/**		 * The initial state of the StateProxy.		 */		private var initialState : State;		/**		 * The initial state of the StateProxy.		 */		private var currentState : State;		/**		 * Set to true when the state proxy is waiting for an asynchronous 		 * response from conditions, actions or responders. 		 */		private var busy : Boolean = false ;				/**		 * Array of transitions associated with the last event called.		 */		private var transitions : Array ;		/**		 * Event notification name called.		 */		private var called : String ;		/**		 * The type of notification called, STATE or EVENT.		 */		private var typeCalled : String ;		/**		 * Flag telling the state machine to wait for confirmation before 		 * proceeding with a call.		 */		private var confirm : Boolean = false ;				/**		 * Array of condition notifications sent and awaiting results.		 */		private var conditionsSent : Array ;				/**		 * Map of condition results.		 */		private var conditionResults : Object ;				/**		 * The transition called as a result of an event call.		 */		private var transitionCalled : Transition ;				/**		 * The state that is currently exiting.		 */		private var exitingState : State ;				/**		 * The action called as a result of an event call.		 */		private var actionCalled : String ;				/**		 * The state that is currently entering.		 */		private var enteringState : State ;				/**		 * Array of previous states		 */		private var stateHistory : Array ;				//----------------------------------------------------------------------		//		//  Constructor		//		//----------------------------------------------------------------------		/**		 * Class constructor.		 */		public function StateProxy ( )		{			Log.stackTrace( this , "StateProxy" ) ;						super( StateProxy.NAME ) ;		}		//----------------------------------------------------------------------		//		//  Methods		//		//----------------------------------------------------------------------				/**		 * Registers an event with the StateEventCommand		 * 		 * @param event The event notification name. 		 */		public function registerEvent ( event : String ) : void		{			if ( !this.facade.hasCommand( event ) ) this.facade.registerCommand( event , StateEventCommand );		}				/**		 * Clears all existing states.		 */		public function clearStates () : void		{			Log.stackTrace( this , "clearStates" ) ;						if ( !this.busy )			{				// Resets just about everything.				this.states = null ;				this.initialState = null ;				this.currentState = null ;				this.transitions = null ;				this.called = null ;				this.typeCalled = null ;				this.conditionsSent = null ;				this.conditionResults = null ;				this.transitionCalled = null ;				if ( this.exitingState ) this.exitingState.stopTimoutTimer() ;				if ( this.exitingState ) this.exitingState.responses = null ;				this.exitingState = null ;				this.actionCalled = null ;				if ( this.enteringState ) this.enteringState.stopTimoutTimer() ;				if ( this.enteringState ) this.enteringState.responses = null ;				this.enteringState = null ;			}		}		/**		 * Sets the initial states.		 * 		 * @param id The state identifier and notification name.		 */		public function setInitialState ( id : String ) : void		{			Log.stackTrace( this , "setInitialState", id ) ;						this.stateHistory = [] ;			this.initialState = this.states[ id ] ;		}		/**		 * Gets the initial states.		 * 		 * @return The State instance.		 */		public function getInitialState () : State		{			return this.initialState ;		}		/**		 * Registers a new state with the state proxy.		 * 		 * @param id The state identifier and notification name.		 * @return The new State instance.		 */		public function createState ( id : String ) : State		{			Log.stackTrace( this , "createState", id ) ;						// Creates an empty state map if one doesn't exist.			if ( !this.states ) this.states = new Object() ;						// Creates the new state if it doesn't already exist.			if ( id == null || states[ id ] != null ) return null;			states[ id ] = new State( id, this ) ;						// Registers the state responder command to respond to the new state. 			if ( !this.facade.hasCommand( id ) ) this.facade.registerCommand( id , StateResponderCommand ) ;						// Returns the new state.			return states[ id ] as State ;		}		/**		 * Removes a state from the state proxy.		 * 		 * @param id The state identifier and notification name.		 */		public function removeState ( id : String ) : void		{			Log.stackTrace( this , "removeState", id ) ;						// Removes the state if it exists.			if ( states[ id ] ) this.facade.removeCommand( id ) ;			states[ id ] = null;		}		/**		 * Gets a registered state object by id. 		 * 		 * @param id The state identifier and notification name.		 * @return The State instance.		 */		public function getState ( id : String ) : State		{			return states[ id ] as State ;		}		/**		 * Gets the current state object.		 * 		 * @return The State instance.		 */		public function getCurrentState () : State		{			if ( !this.currentState ) this.currentState = this.initialState ;			return this.currentState ;		}		/**		 * Sets the current state object.		 * 		 * @param id The new state ID.		 */		private function setCurrentState ( id : String ) : void		{			Log.stackTrace( this , "setCurrentState", id ) ;						this.currentState = states[ id ] ;		}				/**		 * Gets the target state for the accepted transition.		 */		public function getTargetState () : String		{			if ( this.transitionCalled )				return this.transitionCalled.target ? this.transitionCalled.target : this.currentState.id ;			else				return null ;		}		//----------------------------------------------------------------------		/**		 * Calls a state change directly.		 * 		 * @param event The event notification name. 		 */		public function callStateChange ( state : String, confirm : Boolean = false ) : void		{			Log.stackTrace( this , "callStateChange" , state ) ;						// Only proceed if a current state exists.			if ( this.getCurrentState() )			{				// Only proceed if the state proxy isn't busy processing another event.				if ( !this.busy )				{					this.confirm = confirm ;										// State proxy is now busy processing this event call.					this.busy = true ;					this.called = state ;					this.typeCalled = StateProxy.STATE ;										// Send event called notification.					this.sendNotification( StateProxy.CALLED, this, StateProxy.STATE ) ;										// Check for event transitions.					this.transitions = this.getCurrentState().getTransitionsByState( state ) ;					if ( this.transitions.length > 0 )					{						// Create a list of conditions to test.						var conditions : Array = this.getConditions() ;												// If conditions exist, send conditions notifications and await response else proceed calling transitions.						if ( conditions.length > 0 )							this.sendConditionNotifications( conditions ) ;						else							this.callTransitions( this.transitions ) ;					}					else					{						this.busy = false ;						this.error( "There are no transitions to state " + state + "." ) ;					}				}				else					this.error( "The state proxy is busy, so state " + state + " cannot be called." ) ;				}			else				this.error( "There is no current or initial state, so state " + state + " cannot be called." ) ;		}						//----------------------------------------------------------------------						/**		 * Calls a state machine event.		 * 		 * @param event The event notification name. 		 */		public function callEvent ( event : String, confirm : Boolean = false ) : void		{			Log.info( this , "callEvent" , event, confirm ) ;						// Only proceed if a current state exists.			if ( this.getCurrentState() )			{				// Only proceed if the state proxy isn't busy processing another event.				if ( !this.busy )				{					this.confirm = confirm ;										// State proxy is now busy processing this event call.					this.busy = true ;					this.called = event ;					this.typeCalled = StateProxy.EVENT ;										// Send event called notification.					this.sendNotification( StateProxy.CALLED, this, StateProxy.EVENT ) ;										// Check for event transitions.					this.transitions = this.getCurrentState().getTransitionsByEvent( event ) ;					if ( this.transitions.length > 0 )					{						// Create a list of conditions to test.						var conditions : Array = this.getConditions() ;												// If conditions exist, send conditions notifications and await response else proceed calling transitions.						if ( conditions.length > 0 )							this.sendConditionNotifications( conditions ) ;						else							this.callTransitions( this.transitions ) ;					}					else					{						this.busy = false ;						this.error( "There is no transition associated with the event " + event + "." ) ;					}				}				else					this.error( "The state proxy is busy, so event " + event + " cannot be called." ) ;				}			else				this.error( "There is no current or initial state, so event " + event + " cannot be called." ) ;						}				/**		 * Calls state transitions triggered by and event after conditions are 		 * considered.		 * 		 * @param transitions An array of state transitions. 		 */		private function callTransitions ( transitions : Array ) : void		{			Log.info( this , "callTransitions" , transitions.length ) ;						// Only proceed if there is just one transition.			if ( transitions.length == 1 )			{				// Sets the transition called and exits the current state.				this.transitionCalled = transitions[ 0 ] as Transition ;									if ( this.confirm )				{					this.sendNotification( StateProxy.CONFIRM, this , this.called ) ;							}				else					this.exitCurrentState() ;			}			// TODO change error messages for typeCalled state.			else if ( transitions.length > 1 )				this.error( "Error in state machine condition logic! More than one transition has been called by " + this.called + "." ) ;			else 				this.error( "Error in state machine condition logic! No transition has been called by " + this.called + "." ) ;		}				/**		 * Sends event error notifications.		 * 		 * @param error The error message.		 */		private function error ( error : String ) : void		{			Log.error( this , "eventError" , error ) ;						this.busy = false ;						// Send event error notification with the error message as the type.			this.sendNotification( StateProxy.ERROR, this, this.called ) ;		}		//----------------------------------------------------------------------				/**		 * Receives responses from a call confirmation.		 * 		 * @param id The event or state id.		 * @param result The result of the confirmation, true or false.		 */		public function confirmResponse ( id : String, result : Boolean ) : void		{			Log.stackTrace( this , "confirmResponse" , id, result ) ;						if ( id == this.called )				if ( result )					this.exitCurrentState() ;				else					this.error( "Error, " + this.called + " call was not confirmed." ) ;			else				Log.warning( this, "confirmResponse", "Confirm response recieved for " + id + ", expected confirmation for " + this.called + "." ) ;		}				//----------------------------------------------------------------------				/**		 * Receives responses from transition condition commands.		 * 		 * @param condition The condition id.		 * @param result The result of the condition, true or false.		 */		public function conditionResponse ( condition : String, result : Boolean ) : void		{			Log.stackTrace( this , "conditionResult" , condition, result ) ;						if ( this.conditionResults[ condition ] == null ) this.conditionResults[ condition ] = result ;						for each ( var sentCondition : String in this.conditionsSent )				if ( this.conditionResults[ sentCondition ] == null ) return ;						this.testConditions() ;		}				/**		 * Gets the conditions to test for the called event's transitions.		 * 		 * @return An array of conditions with no duplicates.		 */		private function getConditions () : Array		{			Log.stackTrace( this , "getConditions" ) ;						var conditions : Array = [] ;			for each ( var transition : Transition in this.transitions )				if ( transition.condition && conditions.indexOf( transition.condition ) == -1 )					conditions.push( transition.condition ) ;			return conditions ;		}				/**		 * Sends condition notifications to condition commands.		 * 		 * @param conditions An array of conditions.		 */		private function sendConditionNotifications ( conditions : Array ) : void		{			Log.stackTrace( this , "sendConditionNotifications", conditions ) ;						this.conditionsSent = conditions ;			this.conditionResults = new Object() ;						for each ( var condition : String in conditions )			{				Log.info( this , "sendConditionNotifications" , condition ) ;				this.sendNotification( condition ) ;			}		}				/**		 * Reduces the array of event transitions down to those that meet their 		 * conditions, then calls those transitions.		 */		private function testConditions () : void		{			Log.stackTrace( this , "testConditions" ) ;						for each ( var transition : Transition in this.transitions )				if ( transition.condition ) 					if ( this.conditionResults [ transition.condition ] == transition.conditionInverse )						this.transitions.splice( this.transitions.indexOf( transition ), 1 ) ; 						this.callTransitions( this.transitions ) ;		}				//----------------------------------------------------------------------				/**		 * Sends exit notification for the current state.		 */		private function exitCurrentState() : void		{			Log.stackTrace( this , "exitCurrentState", this.getCurrentState() ) ;						this.exitingState = this.getCurrentState() ;			this.exitingState.responses = [] ;			this.exitingState.startTimoutTimer() ;			var checkNowFlag : Boolean = this.exitingState.getResponderTotal() == 0 ;			this.sendNotification( this.exitingState.id, this, StateProxy.EXIT ) ;			if ( checkNowFlag ) this.checkExitResponse() ;		}		/**		 * Informs the proxy of a response to state exit notification.		 *		 * @param state The state identifier and notification name.		 * @param responder An IStateResponder instance.		 */		public function exitResponse ( state : String, responder : IStateResponder ) : void		{			Log.stackTrace( this , "exitResponse", state, responder ) ;						// Checks that the response is to the currently exiting state.			if ( this.getState( state ) == this.exitingState && this.exitingState.responses.indexOf( responder ) == -1 )			{				// Records the response.				this.exitingState.responses.push( responder ) ;								this.checkExitResponse() ;			}		}				/**		 * Checks to see if all the exit responsers have responded.		 */		private function checkExitResponse() : void		{			// Checks whether all the responders have responded. 			if ( this.exitingState.getAllResponded() )			{				Log.debug( this , "checkExitResponse", "Exited state " + this.getCurrentState().id ) ;								this.stateHistory.push( this.exitingState.id ) ;								// Reset the exiting state.				this.exitingState.stopTimoutTimer() ;				this.exitingState.responses = null ;				this.exitingState = null ;								// If an action exists send the action notification, otherwise just enter the new state.				if ( this.transitionCalled.action )				{					this.actionCalled = this.transitionCalled.action ;					this.sendNotification( this.actionCalled, this.transitionCalled, this.getCurrentState().id ) ;				}				else					 this.enterNewState() ;			}		}				/**		 * Receives asynchrounous response from an action called by the current 		 * event transition.		 * 		 * @param action The action notification name.		 */		public function actionResponse ( action : String ) : void		{			// If the action responding is the action that was called, proceed to enter the new state.			if ( action == this.actionCalled )			{				this.actionCalled = null ;				this.enterNewState() ;			}		}				/**		 * Sends enter notification for the new state. 		 */		private function enterNewState() : void		{			Log.stackTrace( this , "enterNewState", this.transitionCalled.target ) ;						this.enteringState = this.getState( this.transitionCalled.target ) ;			this.enteringState.responses = [] ;			this.enteringState.startTimoutTimer() ;			var checkNowFlag : Boolean = this.enteringState.getResponderTotal() == 0 ;			this.sendNotification( this.enteringState.id, this, StateProxy.ENTER ) ;			if ( checkNowFlag ) this.checkEnterResponse() ;		}				/**		 * Informs the proxy of a response to state enter notification.		 *		 * @param state The state identifier and notification name.		 * @param responder An IStateResponder instance.		 */		public function enterResponse ( state : String, responder : IStateResponder ) : void		{			Log.stackTrace( this , "enterResponse", state, responder ) ;						// Checks that the response is to the currently entering state.			if ( this.getState( state ) == this.enteringState && this.enteringState.responses.indexOf( responder ) == -1 )			{				// Records the response.				this.enteringState.responses.push( responder ) ;								this.checkEnterResponse() ;			}		}				/**		 * Checks to see if all the enter responsers have responded.		 */		private function checkEnterResponse() : void		{			// Checks whether all the responders have responded.			if ( this.enteringState.getAllResponded() )			{									Log.debug( this , "enterResponse", "State changed to " + this.enteringState.id ) ; 								// Set the new state as the current state.				this.setCurrentState( this.enteringState.id ) ;								// Reset the entering state and busy flag.				this.enteringState.stopTimoutTimer() ;				this.enteringState.responses = null ;				this.enteringState = null ;				this.busy = false ;												// Send event complete notification.				this.sendNotification( StateProxy.COMPLETE, this , this.called ) ;			}		}				/**		 * Get the previous states IDs.		 * 		 * @return An Array of state IDs.		 */		public function getStateHistory () : Array		{			return this.stateHistory ;		} 		/**		 * Get the previous state.		 * 		 * @return A state ID.		 */		public function getLastState () : String		{			return this.stateHistory[ this.stateHistory.length - 1 ] ;		}	}}