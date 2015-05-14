
---


# <font color='#FF0000'>DRAFT</font> #

# UI Framework #

## Overview ##

TODO


# Classes #

### Core Component ###

[Source](http://code.google.com/p/wemakedigital/source/browse/trunk/ui/as3/code/src/com/wemakedigital/ui/core/CoreComponent.as)

[API Documentation](http://wemakedigital.googlecode.com/svn/trunk/ui/as3/code/docs/com/wemakedigital/ui/core/CoreComponent.html)

The core component is the base component class for the ui framework. It is an abstract class that is extended by the rest of the framework, but can also be used alone as a super class for your own components. A full list of features can be found in the API Documentation, but here will just look at the main concepts.

**Creation and Destruction**

The `create` method is called when the component is added to the display list and sets the `created` Boolean property to `true`. The `destroy` method is called when the component is removed from the display list and resets `created` to `false`. Overriding these methods, you can ensure that your component doesn't start using system resources until it is needed and that it cleans up after itself, removing any children, event listeners, tweens etc.

**Update, Invalidate, Render**

The core component uses the following cycle to update the display when a property changes e.g. width, colour etc.

  1. The `update` method should be called by the setter method for any display property when it is changed. It can be overridden to update other properties as a result, but primarily it should determine whether the property change invalidates the display i.e. the display needs to be re-rendered as a result of the change. If so, the `update` method should call the `invalidate` method.
  1. The purpose of the `invalidate` method is to flag that the component needs to be re-rendered after all property changes have been received. For example, if you changed the `width`, `height`, and `colour` of a component, `invalidate` would be called three times, but it would ensure that the `render` method is only called once and doesn't burden the Flash Player with unnecessary redraws.
  1. The `render` method is used to redraw the component's display e.g. updating vector graphics, resizing and positioning child display objects.

**Width and Height**

In a `DisplayObject`, the `width` and `height` properties immediately affect the scale when changed. In a component, we don't want to scale when the width or height changes, we want to re-render the component at the new size. The core component replaces the `width` and `height` properties inherited from `DisplayObject`, which become read only via `displayWidth` and `displayHeight` properties.

The `width` and `height` properties represent a fixed size in pixels just as they do in a
`DisplayObject`, however in future subclasses there may be other properties that affect the size of the component. Therefore, the `update` method is used to interpret the final size and update the protected `explicitWidth` and `explicitHeight` properties. It is these size properties alone that should be used in the `render` method to re-render the component.

The following example renders an ellipse at the explicit size of the component:

```
override public function render () : void
{
    this.graphics.clear() ;
    this.graphics.beginFill( 0x000000 ) ;
    this.graphics.drawEllipse( 0, 0, this.explicitWidth, this.explicitHeight ) ;
    super.render() ;
}
```

## Source ##

TODO