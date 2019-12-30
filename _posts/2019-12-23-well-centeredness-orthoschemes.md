---
layout: post
title: Well-centeredness and Orthoschemes
category: Polytopes
---

Last time we looked at [well-centered polytopes](/well-centeredness) and I wondered whether a vertex-transitive
polytope with well-centered $$j$$-faces would be completely well-centered.
(For $$j=0$$ or 1 the condition is trivial, since points and edges are always well-centered,
so we'd have to require $$j=2$$ at least.)
This seems to be false. But why would I think this?

A completely well-centered polytope is what I've called _orthodivisible_:
it can be split into [orthoschemes](https://en.wikipedia.org/wiki/Schl%C3%A4fli_orthoscheme)—simplices
whose vertices are on a path $$P_0, \dotsc, P_d$$ with mutually orthogonal edges.

{::nomarkdown}
<div style="display: flex; justify-content: space-around;">
<figure>
<svg viewBox="-10 -50 60 60" version="1.1" xmlns="http://www.w3.org/2000/svg" height="150px" width="150px">
<polygon points="0,0 30,0 0,-30" fill="none" stroke="white" stroke-width="1.2"/>
</svg>
<figcaption>2-dimensional orthoscheme</figcaption>
</figure>
<figure align="right">
<img src="/images/3dortho.png" alt="3-dimensional orthoscheme" align="right" />
<figcaption>3-dimensional orthoscheme</figcaption>
</figure>
</div>
{:/}

That's because you can make a path starting at a vertex—let's call it $$P_0$$—continuing to the midpoint
of an edge—$$P_1$$—and through the circumcenters of $$j$$-faces, up to the center of the whole polytope,
and all the edges are mutually orthogonal.

![Circumscribed pentagonal bipyramid orthoscheme](/images/circpentbyp.png)

They're mutually orthogonal since the circumsphere $$S_F$$ of each face $$F$$ is the intersection
of the affine span of $$F$$ with the circumsphere of the whole polytope $$P$$, and the normal vector
from the circumcenter $$c$$ of $$P$$ through any subspace $$\operatorname{aff}(F)$$ meets it in the center of $$S_F$$.

![Line from circumcenter through aff(F)](/images/cpb-line.gif)

Some circumscribable polyhedra with regular 2-faces aren't well-centered, like the
pentagonal pyramid J2:

![Circumscribed pentagonal pyramid](/images/j2-line.png)

or a square rotunda:

![Circumscribed square rotunda](/images/circsqrrot.gif)

Although the normal lines through each face's circumcenter all meet in one point—the polytope's circumcenter—that's outside the polytope.

These problems occur because the polytope's faces don't "surround" the whole sphere:
and so the meeting point of the normal lines through the faces' circumcenters might not be inside.

A vertex-transitive polytope, though—or indeed a polytope whose symmetries act transitively on all the faces of any particular rank—must
surround the sphere in the right way.
Even in a vertex-transitive polytope, though, the 2-faces might not be well-centered.
Consider the disphenoid frustum from last time, with its affine spans and normal lines:

![Disphenoid frustum](/images/disphrust.gif)

In combination, though—well-centered 2-faces in a vertex-transitive polytope—it seems like
looking within a 3-face at the point where the normal lines through each of its 2-faces' circumcenters meet,
which is the 3-face's circumcenter, might have to be in the interior.

Yet [spidrox](http://eusebeia.dyndns.org/4d/spidrox) puts the kibosh on that.

It's vertex-transitive, with regular 2-faces, but its square pyramid facets are not well-centered.
Notably, they're _barely_ not well-centered: the circumcenter lies in the boundary.

Could strengthening a bit more—to vertex- and edge-transitive poltyopes—mean that the 3-faces must be well-centered?
