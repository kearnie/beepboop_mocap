# beepboop_mocap
walking signal motion capture experience 

project demo video: https://vimeo.com/191298261

First iteration of ideas: a body as particles–initially I automatically conjured ideas that could be attributed to some sort 
of radiation or atmospheric effect: a figure of star particles, pixel dust, wisps of smoke–something simple, seamless, but 
with admirable aesthetics. This desire to represent some aura-based atmosphere also led to indirect models of the form, such 
as a delicate rain scene, where the body is invisible and the viewer can only see the body from where the rain bounces off. 
Another exploration regarded the soul butterflies, i.e. butterflies of death, a common trope in anime where glittering 
butterflies fly near lost souls or people close to death. (So, perhaps some iteration where if the model makes abrupt 
movements/shaking, he or she could shake the butterflies/death off of them–this shaking and loosening effect could be applied 
to any of my particle-based ideas).

I originally partnered with Takos to do this assignment and toy with some of these, and her ideas, and as we assigned ourselves 
parts to develop further, we actually continually drifted apart in our coding approaches and end goals… which eventually led to 
separate projects haha.
Ironically, my final product was an idea that she gave to me, including the link to the video below (thanks Takos!); 
once she presented this idea to me, I already thought of all the attributes needed that I thought would make the execution 
successful, and ended up going with it, while she decided to develop another completely different idea (that, ironically, 
was more of my usual aesthetic with seamless monochromatic visuals…) But cool thing is, I’m glad I explored something different 
anyway, and am actually very happy with how well-rounded my results became, in that even though it was a visually simple 
simulation, I feel like all the details and characteristics were well-considered and complement each other with purpose very much.

As such is the walking signal simulator, where a plane of circle bulbs light up according to the human figure: if the figure is 
moving, it is green, and ideally if the figure stops moving, the lights go red. I included audio from the walking signal noise 
at Morewood and Forbes (commonly nicknamed the “beep boop” by CMU students), and the audio also pauses if the red stop signal 
is on. The lights are lit according to an isBoneNear function that calculates the theoretical segment between all the Bvh 
bones and compares it to a point(x,y) that would be the center of all the circles on the light bulb plane, and if the distance 
is within my hardcoded epsilon, the circle will be green or red instead of the default gradient of grays.

Final: Troubleshooting the head was interesting because I assumed that the head would be the bone without a parent (a conditional 
I had to include anyway so that there wouldn’t be a null exception error), but when I upped the epsilon I saw no change, so 
I… guess the head wasn’t it; Golan then taught me about the function that allowed me to directly check for bone names (“Head”) 
that made the process easier, so raising the epsilon ended up succeeding to make the head little more prominent, although the 
default Head bone itself was still very close to the torso so the final figure looks like it has a very short neck… 
(but this is still the best improvement because the figure originally looked headless… also thank you Golan.) 
I even had an iteration where, because I still couldn’t identify and isolate the head bone yet, where my increase in 
epsilon accidentally made the model look pregnant (because it turned out that the bone I affected was at the waist I guess…) 
I could not fathom how to get the stop signal of red to work at random pauses, as I found it difficult to calculate whether 
the Bvh model moved between the last frame or not, so I ended up coding a method to just make the file pause at the end of 
every loop for a bit longer than usual before relooping, and at that moment of pause, changed the lit color to red and 
the audio amp to 0. I also added a two frames to the borders to give it an effect of having the walking signal yellow box frame. 
Originally I also made the plane flat, but decided to give it a top down gradient of gray rather than the flat grays, 
to mimic some short of shadow being casted from the top of the walking signal box. The top four pictures of the screencaps 
below were the initial tinkering stages of making the colors work and align well (as you can see, I had some debugging to do.)

I particularly also found it fitting that the model is stretching, as if taking a break from a jog or pedestrian stroll or walk 🙂 
Take care of yourself, exercise, and remember that it’s the little things that count! (I should really take that advice…) 
Overall, I’m really pleased that, although the result appears uncomplicated, that all its parts combine very well… 
it made me really happy that the class laughed once they realized exactly what my mocap attempted to mimic in real life. 
(The beep boop audio helped immensely, I believe… by the way, credits to this CMU remix, which is where I cropped the audio from!)
