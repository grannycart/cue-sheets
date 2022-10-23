# Convert Markdown Cue Sheet to Pocket-sized PDF

## What?
If you write out a nice clean set of bicycle cues (that is, directions
so you don't get lost while riding) in markdown, this make file will
use pandoc to convert it to a nicely-formatted pocket-sized page for
printing out and bringing with you on your ride.

Mostly I write my cue sheets by putting in a route to google maps
(selecting bicycle of course), making adjustments to the route, and
then writing down the cues by hand. 

## Why?
Basically, the thing is that I want to go on rides without using my
phone. I need directions, but I need them to be manageable (ideally)
without stopping, flipping pages, trying to read tiny print with
complete sentences of unnecessary verbiage, etc.

Google maps (and, I'm pretty sure, virtually all other automatic
route-generating software) creates routes with FAR too much detail. 
So, firstly, while Google's route is a good place to start, I want
simpler routes, so I adjust the routes by hand. 
There are also often places where Google's algorithm wants you to ride
(or not ride) but I know a better route. The perennial example of this
is where you can salmon the wrong way one block up a one-way street and avoid
a long roundabout and potentially more dangerous way Google want you
to go. Also, in NYC there are many bridges, paths, connectors, stairs
and whatnot Google tries to avoid but are easier to just take.

"But," you say, "why not just use your phone?" 

There's nothing wrong with using a phone to navigate. Especially if
you are a roady trying to go for your best time on an established
route. But that's not the kind of riding I do (mostly). I like to pick
some remote spot, find a route out there that gets off the beaten
path, and then (preferably) a loop back home on a different route.

When I say "remote" I don't mean a back-country fire trail that goes
two miles out beyond the last ice cream stand (though sometimes I do).
Remote can also mean a neighborhood I haven't been to, or a beach I've
never visited, or (as is often the case in NJ) some town in a different
state. Often the way there takes me through industrial zones where
trucks get washed or tractors get repaired, along rarely-used bike
paths that are lumpy with long neglect and full of glass, cuts across
highway on-ramps and over guard rails, and winding through the
interminable tracts of row houses in the outer boroughs of NYC.

The point is, I like to go far out to places I haven't been before.
Doing this adds to the mental map I have in my head. I've been doing
this for more than a decade in NYC, and the process I have has given
me a surface map of NYC roads that rivals only old cab drivers these
days. (Since young cab drivers, like everyone else, just use their
phones.)

It's not just the ability to tell someone how to get their without
resorting to a phone though. There's a kind of satisfaction that comes
with a route that works out. Every time the cue sheet is right, and
the turn shows up where it's supposed to, and that little section of
detail gets plugged into the growing map in my head, I get that same
feeling you get when you find a piece that fits in a puzzle and snap
it in. Of course the opposite is also true: it's incredibly
frustrating to get lost. But it's hard to get TOO lost these days, and
if you do, you can always pull out your phone. (Or if you are like me
and refuse to bring a phone you can always ask someone how to get back
onto your cue sheet.)

Anyway, this repo is to help make legible cue sheets -- useful to me
because on a number of occasions I have been lost entirely because
I couldn't read my own handwriting. Also over the years I have lost
cue sheets that I know I've done before, and it sucks having to write
them out by hand a second time.


## Resources:
* columns.lua:
	* is from: https://github.com/jdutant/columns
	* Documented by: https://levelup.gitconnected.com/use-columns-adjust-margins-and-do-more-in-markdown-with-these-simple-pandoc-commands-adb4c19f9f35
* Makefile:
	* This Makefile modified from original maintainer at:
		* https://github.com/evangoer/pandoc-ebook-template
	* Originally released under an MIT license


## License:
* MIT
* See: [LICENSE](./LICENSE)





