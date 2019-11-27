---
layout: post
title: Well-centered-ness
category: Polytopes
---

A _well-centered polytope_ is one whose vertices all lie on a sphere (also known as being [circumscribable](https://en.m.wikipedia.org/wiki/Circumscribed_sphere), or [equiradial](http://www.numericana.com/answer/polyhedra.htm#equi)) and with the center of that sphere (the _circumcenter_) within the polytope's interior.

Circumscribable polygons are also known as cyclic polygons.

There are circumscribable polytopes which are not well-centered, like this isosceles trapezoid:

{::nomarkdown}
<svg viewBox="-50 -50 100 50" version="1.1" xmlns="http://www.w3.org/2000/svg" height=150px width=300px>
<circle r="50" fill="none" stroke="white" stroke-width=".8"/>
<polygon points="30,-40 -30,-40 -42.7,-26 42.7,-26" fill="yellow" stroke="white" stroke-width=".5"/>
</svg>
{:/}

Or the equilateral pentagonal pyramid (Johnson solid J2):

![pentagonal pyramid in its circumsphere](/images/J2.png)

A polytope is _vertex-transitive_ if the polytope can be rotated or reflected to take any vertex to any other vertex, while the whole polytope looks the same as when you started; then we say "the polytope's symmetries act transitively on its vertices". This is also known as being [isogonal](https://en.wikipedia.org/wiki/Isogonal_figure).

A vertex-transitive polytope is always well-centered.
But there are also well-centered polytopes which aren't vertex-transitive,
like this pentagon:

{::nomarkdown}
<svg viewBox="-50 -50 100 100" version="1.1" xmlns="http://www.w3.org/2000/svg" height=300px width=300px>
<circle r="50" fill="none" stroke="white" stroke-width="1"/>
<polygon points="30,40 -30,40 -50,0 0,-50 50,0" fill="yellow" stroke="white" />
</svg>
{:/}

An $$n$$-gonal [bipyramid](https://en.wikipedia.org/wiki/Bipyramid) can also be made
well-centered for any $$n$$, by putting the apices on the sphere centered on the
base polygon's circumcenter and going through the base's circumcircle.
These won't be vertex-transitive, though, since the apices are different from the vertices on the base—except
for the square bipyramid; when you scale that to be circumscribable, you get a regular [octahedron](https://en.wikipedia.org/wiki/Octahedron).

The faces of a well-centered polytope aren't necessarily well-centered themselves,
although they are circumscribable.
For instance, you can make a well-centered hexahedron with four sides
being the isosceles trapezoid we saw above.
Just attach four of them in a cycle, alternating long and short edges;
the top and bottom will form rectangles, oriented perpendicular to eachother:

![spinning disphenoid frustum](/images/isotrapfrust.gif)

(This shape could be called a _disphenoid frustum_, if you're so inclined. It's also
a [prismoid](http://mathworld.wolfram.com/Prismoid.html).)

A well-centered polytope all of whose faces are themselves well-centered
is called _completely well-centered_.

So, a vertex-transitive polytope is always well-centered.
And its faces are always circumscribable.
But its faces aren't necessarily well-centered; for instance,
the disphenoid frustum we just saw is vertex-transitive,
but the trapezoid sides aren't well-centered.

So vertex-transitive does not imply completely well-centered.
Also, being completely well-centered does not imply vertex transitivity;
the [pseudorhombicuboctahedron](https://en.wikipedia.org/wiki/Pseudorhombicuboctahedron)
is one completely well-centered but not isogonal polytope.
Johnson solids [J11 (Gyroelongated pentagonal pyramid)](https://en.wikipedia.org/wiki/Gyroelongated_pentagonal_pyramid) and [J19 (Elongated square cupola)](https://en.wikipedia.org/wiki/Elongated_square_cupola) are more examples.

Does adding some more conditions allow one to draw conclusions in one direction or the other?

For instance, a circumscribable and equilateral polytope
must actually have regular 2-faces (since equilateral cyclic polygons are regular).
So the 3-faces must be regular-faced and circumscribable,
which means they can only be among the Platonic solids, the Archimedean solids, 25 out of the 92 Johnson solids,
an $$n$$-gonal uniform prism, or an $$n$$-gonal equilateral antiprism.

### Isogonal + Isotoxal ⇒ completely well-centered?

Could it be that a polytope which is both vertex- and edge-transitive
is completely well-centered?
Such a polytope is circumscribable and equilateral,
so it has regular 2-faces. If the 3-faces must be well-centered then that would rule out 
several of the 25 circumscribable Johnson solids.

A counterexample would have to be at least 4-dimensional.
A 4-polytope which is vertex- and edge-transitive
but not completely well-centered
would have to have non-well-centered regular-faced polyhedra
for some of its 3-faces.
There are actually only three possible polyhedra:
J1, the square pyramid; J2, the pentagonal pyramid; or J6, the pentagonal rotunda.

We saw in [Twisty Antiprisms](/Twisty-Antiprisms/) that there's no vertex-transitive
4-polytope made only of J2. But we haven't ruled out a mix of J2 and other facets.

### Well-centered j-faces ⇒ well-centered (j+1)-faces?

Could it be true that a vertex-transitive polytope
with well-centered 2-faces always has well-centered 3-faces?
(Or, more generally, that a vertex-transitive polytope with well-centered
$$j$$-faces ($$j \geq 2$$) always has well-centered $$(j+1)$$-faces?)

A potential counterexample to this last conjecture is a 4-polytope
which has been called [spidrox](http://eusebeia.dyndns.org/4d/spidrox), or the "Swirlprismatodiminished Rectified 600-cell".
This is reported to be vertex-transitive and to
have equilateral triangles, squares, and regular pentagons as 2-faces,
so its 2-faces are all well-centered.
Yet its 3-faces include square pyramids, which are not well-centered.
In a future installment we'll investigate this polytope with [polymake](https://polymake.org/).

