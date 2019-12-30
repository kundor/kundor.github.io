#version 3.7;

#include "colors.inc"
#include "math.inc"

#macro Circumcenter (Corner_1, Corner_2, Corner_3)
#local C1 = Corner_1;
#local C2 = Corner_2;
#local C3 = Corner_3;

#if( VAngleD( C1-C2,C3-C2) < VAngleD( C3-C1,C3-C2))
#local C1 = Corner_1;
#local C2 = Corner_3;
#local C3 = Corner_2;
#end // #if
  #local V1 = vnormalize(C2-C1);
  #local V2 = vnormalize(C3-C1);
  #local V3 = C3-C2;
  #local Sinus = vlength( vcross( V1, V2));
  #local Radius = vlength(V3)/(2*Sinus);

   (C1+C2)/2 +sqrt( Radius*Radius - 1/4*vlength(C2-C1)*vlength(C2-C1))
   * ( vcross( vnormalize(vcross((C2-C1),(C3-C1))), V1) )
#end   

#macro v_equal(v1,v2) ((v1.x=v2.x)&(v1.y=v2.y)&(v1.z=v2.z)) #end

#macro disp_edge(edge)
   #if(!v_equal(verts[edges[edge][0]], verts[edges[edge][1]]) )
      cylinder{verts[edges[edge][0]] verts[edges[edge][1]] edge_sz
         texture{ edge_tex }
      }
   #end
#end

#macro raythru(pt)
   sphere{ pt vert_sz texture{ pigment { rgbt <.9, .5, .2, 0> } } }
   cylinder{<0,0,0> 5*pt
     0.006 texture { pigment { rgbt <1, 1, 1, 0> } }
   }
#end

#macro fourface(v1, v2, v3, v4, col)
   polygon { 4, verts[v1] verts[v2] verts[v3] verts[v4] texture { pigment { rgbt col } } }
   raythru(Circumcenter(verts[v1], verts[v2], verts[v3]))
#end

// Display values
   // Size (or radius) of elements
   #declare vert_sz = 0.05;
   #declare edge_sz = 0.03; 

   // Colour of elements (used to set up default textures
   #declare vert_col = <0.901961, 0.45098, 0, 0>;
   #declare edge_col = <0.8, 0.6, 0.8, 0>; // <0.8, 0.6, 0.8, 0>

   // Texture of elements
   #declare vert_tex=texture{ pigment{ rgbt vert_col}}
   #declare edge_tex=texture{ pigment{ rgbt edge_col}}

// Array of vertex coordinates
#declare num_verts = 9;
#declare verts = array [num_verts] {
<-3, 4, .5>,
<4, -3, -.5>,
<3, -4, .5>,
<4, 3, -.5>,
<-4, -3, -.5>,
<3, 4, .5>,
<-4, 3, -.5>,
<-3, -4, .5>,
<0, 0, 0>
}

// Array of edge indexes
#declare num_edges = 12;
#declare edges = array [num_edges][2] {
   {0, 5},
   {0, 6},
   {0, 7},
   {1, 2},
   {1, 3},
   {1, 4},
   {2, 5},
   {2, 7},
   {3, 5},
   {3, 6},
   {4, 6},
   {4, 7},
}

#declare rec_col = <0.78039, 1.00000, 0.10196, 0.2>;
#declare trap_col = <1.00000, 0.10196, 0.10196, 0.2>;
// Array of face vertex counts and indexes
fourface(3, 6, 0, 5, trap_col)
fourface(7, 2, 5, 0, rec_col)
fourface(7, 0, 6, 4, trap_col)
fourface(5, 2, 1, 3, trap_col)
fourface(1, 4, 6, 3, rec_col)
fourface(4, 1, 2, 7, trap_col)

   #declare i=0;
   #while (i<num_verts)
      sphere{ verts[i] vert_sz texture { vert_tex } }
      #declare i=i+1;
      #end

// Display edge elements
   #declare i=0;
   #while (i<num_edges)
      disp_edge(i)
      #declare i=i+1;
      #end

// Extra object
      sphere{<0,0,0> vlength(verts[0]) texture{ pigment{color White filter 0.8 }}}
/*   sphere{<0,0,0> vlength(verts[0])
       pigment{
           uv_mapping
           Tiles_Ptrn()
           color_map {
               [0.00 color rgb <1,1,1>] // white stanchions
               [0.1 color rgbt <0,0,0,1>] // transparent spaces
           }
           scale <0.04, 0.06, 1> // size and ratio of the grid
       }
//       finish {ambient 1 diffuse 0}
       rotate 90*x
   }*/

background {color <0,0,0,1>}
// Max Trace Level (10), increase if black areas appear when using transparency
global_settings{
    max_trace_level 10
    assumed_gamma 1.2
}

  camera { location <0,10,1>
           sky <0,0,1>
           look_at <0,0,0>
           rotate <0, 0, 360*clock>
         }

   light_source {<.5, 7, 7> color <1,1,1> shadowless
           rotate <0, 0, 360*clock>
       }
