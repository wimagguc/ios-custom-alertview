# Custom iOS7 AlertView

`v0.2`

The addSubview is not available in UIAlertView in iOS7 any more. The view hierarchy for this class is private and must not be modified.

As a solution, this class creates an iOS7-style dialog which you can extend with any UIViews or buttons. The animations and the looks are copied too and no images or other resources are needed.

![A demo screen](Docs/screen.png)

## Install

As simple as adding the following files to your project:

* CustomIOS7AlertView.h
* CustomIOS7AlertView.m

## Quick start guide

1. Create the UIView object. (Passing the whole parent view, because some calculations are needed: the dialog comes in the middle etc.)

    ```
    CustomIOS7AlertView *alertView = [[CustomIOS7AlertView alloc] initWithParentView:self.view];
    ```
  
2. Add some custom content to the alert view (optional)

    ```
    UIView *customView ..;

    [alertView setContainerView:customView];
    ```

3. Display the dialog

    ```
    [alertView show];
    ```

## More functions

* Close the dialog

    ```
    [alertView close];
    ```

* To add more buttons, pass a list of titles

    ```
    [alertView setButtonTitles:[NSMutableArray arrayWithObjects:@"Button1", @"Button2", @"Button3", nil]];
    ```

* You can remove all buttons by passing nil

    ```
    [alertView setButtonTitles:NULL];
    ```

* Handle button clicks with a custom delegate

    First, set the delegate:

    ```
    [alertView setDelegate:self];
    ```

    Then add the delegate methods:

    ```
    - (void)customIOS7dialogButtonTouchUpInside: (CustomIOS7AlertView *)alertView clickedButtonAtIndex: (NSInteger)buttonIndex
    {
        NSLog(@"Button at position %d is clicked on alertView %d.",         buttonIndex, [alertView tag]);
    }
    ```

## Todos

This is a really quick implementation, and there are a few things missing:

* Better rotation support (works with landscape and portrait mode too, so the current best practise is to re-open the same dialog once the screen is rotated)
* Adding more buttons: they don't exactly match the look with that of on iOS7

## License

Use it as is, show me if you did something cool. Also, feel free to push back anything you think is useful for the project.

## Other projects

`iOS developers`, check out [AppWoodoo](http://www.appwoodoo.com/), our remote app settings (and A/B testing) service. It's open source and free to use.

Some more of my free stuff for web devs at [Github](https://github.com/wimagguc?tab=repositories).

Project updates [newsletter](http://wimagguc.us4.list-manage.com/subscribe/post?u=83343dbd708d35d76618f66c5&id=da7cc7f1dc)

## About

Richard Dancsi  
[www.wimagguc.com](http://www.wimagguc.com/)  

twitter: [@wimagguc](http://twitter.com/wimagguc)  
linkedin: [linkedin.com/in/richarddancsi](http://linkedin.com/in/richarddancsi)  
gplus: [plus.google.com/u/0/115939246085616544919](https://plus.google.com/u/0/115939246085616544919)  
