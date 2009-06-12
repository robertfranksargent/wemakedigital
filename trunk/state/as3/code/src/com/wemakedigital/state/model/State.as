package com.wemakedigital.state.model{	import com.wemakedigital.state.view.IStateResponder;	import com.wemakedigital.log.Log;				/**	 * Defines a state.	 */	public class State 	{			//----------------------------------------------------------------------		//		//  Variables		//		//----------------------------------------------------------------------				/**		 * The state identifier and notification name.		 */		public var id : String;		/**		 * Array of IStateResponder instances registered to this state.		 */		private var responders : Array = [] ;		/**		 * Array of Transition instances registered to this state.		 */ 		private var transitions : Array = [] ;		//----------------------------------------------------------------------		//		//  Constructor		//		//----------------------------------------------------------------------				/**		 * Class constructor.		 * 		 * @param id The identifier of the state.		 */		public function State ( id : String )		{			Log.stackTrace( this, "State", id ) ;						this.id = id;		}				//----------------------------------------------------------------------		//		//  Methods		//		//----------------------------------------------------------------------				/**		 * Registers an instance to respond to changes in this state.		 * 		 * @param responder An IStateResponder instance.		 */		public function addResponder ( responder : IStateResponder ) : void		{			Log.stackTrace( this, "addResponder", responder ) ;						if ( this.responders.indexOf( responder ) < 0 ) this.responders.push( responder );		}		/**		 * Removes an instance from the list of responders for this state.		 * 		 * @param responder An IStateResponder instance.		 */		public function removeResponder ( responder : IStateResponder ) : void		{			Log.stackTrace( this, "removeResponder", responder ) ;						if ( this.responders.indexOf( responder ) < 0 ) this.responders.splice( this.responders.indexOf( responder ), 1 ) ;		}		/**		 * Gets the responder that exists at the specified index.		 * 		 * @param index The index position in the array.		 * @return The IStateResponder instance.		 */		public function getResponderAt ( index : int ) : IStateResponder		{			return this.responders[ index ] ;		}		/**		 * Gets the total number of responders for this state.		 * 		 * @return The length of the responder array.		 */		public function getResponderTotal () : uint		{			return this.responders.length ;		}				/**		 * Compares an array of responders that have reponded to the array of 		 * responders associated with this state.		 * 		 * @param responded The array of IStateResponder objects.		 * @return true if all the responders associated with this state have 		 * responded, false otherwise.		 */		public function compareResponders ( responded : Array ) : Boolean		{			for each ( var responder : IStateResponder in this.responders )				if ( responded.indexOf( responder ) == -1 ) return false ;						return true ;		}				//----------------------------------------------------------------------				/** 		 * Adds a transition. 		 * 		 * @param transition A Transition instance.		 */		public function addTransition ( transition : Transition ) : void		{			Log.stackTrace( this, "addTransition", transition ) ;			if ( this.transitions.indexOf( transition ) < 0 ) this.transitions.push( transition );		}				/** 		 * Remove a previously added transition.		 * 		 * @param transition A Transition instance.		 */		public function removeTransition ( transition : Transition ) : void		{			Log.stackTrace( this, "removeTransition", transition ) ;			if ( this.transitions.indexOf( transition ) < 0 ) this.transitions.splice( this.transitions.indexOf( transition ), 1 ) ;			}				/**		 * Gets the Transition instance that exists at the specified index.		 * 		 * @param index The index position in the array.		 * @return The transition.		 */		public function getTransitionAt ( index : int ) : Transition		{			return this.transitions[ index ] ;		}				/**		 * Gets the total number of Transitions.		 * 		 * @return The length of the transitions array.		 */		public function getTransitionTotal() : uint		{			return this.transitions.length ;		}				/**		 * Gets an array of Transitions triggered by the specified event.		 * 		 * @param event The event name.		 * @return The Array of transitions.		 */		public function getTransitionsByEvent ( event : String ) : Array		{			var transitionsByEvent : Array = [];			for each ( var transition : Transition in this.transitions ) 				if ( transition.event == event ) transitionsByEvent.push( transition ) ;			return transitionsByEvent ;		}	}}