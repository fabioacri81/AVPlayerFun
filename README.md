## AVPlayerFun
----

This is a small demo about AVPlayer, used together with AVPlayerViewController to inherit playback controls.
It's been written in 1 hour or so including tests, UI is reduced to minimum, it's basically a table view showing a list of possible videos to show,
and when you tap on each cell a new view is presented showing the video full screen with AVPlayerViewController and its playback controls.
Device orientation is handled as well either when showing only the table view data and also when the video is presented full screen.

## Architecture

It's quite simple, a MVP tiny framework, following best practises in Swift and SOLID principles, the tests are all performed against the most components.
Components here are initiated through dependency injection and that also makes testability a great key point.

I didn't spend too much time on UI, will perhaps add something more later on.
