#version 3.7;

#include "colors.inc"
#include "textures.inc"

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
     0.003 texture { pigment { rgbt <1, 1, 1, 0> } }
   }
#end

#macro triface(v1, v2, v3)
   triangle { v1 v2 v3 texture{ pigment { rgbt <1, 1, 0, .6> } } }
   #declare ctr = (v1 + v2 + v3) / 3;
   raythru(ctr)
#end

#macro squareface(v1, v2, v3, v4)
   polygon { 4, v1 v2 v3 v4 texture { pigment { rgbt <0, 0, 1, .6> } } }
   #declare ctr = (v1 + v2 + v3 + v4) / 4;
   raythru(ctr)
#end

// Display values
   // Size (or radius) of elements
   #declare vert_sz = 0.0237764; // 0.0237764
   #declare edge_sz = 0.01; // 0.0158509
   #declare face_sz = 0; // 0

   // Colour of elements (used to set up default textures
   #declare vert_col = <0.901961, 0.45098, 0, 0>;
   #declare edge_col = <0.8, 0.6, 0.8, 0>; // <0.8, 0.6, 0.8, 0>

   // Texture of elements
   #declare vert_tex=texture{ pigment{ rgbt vert_col}}
   #declare edge_tex=texture{ pigment{ rgbt edge_col}}

// Array of vertex coordinates
#declare num_verts = 13;
#declare verts = array [num_verts] {
    <1/sqrt(2-sqrt(2)), 0, 1/2>,
    <cos(pi/4)/sqrt(2-sqrt(2)), sin(pi/4)/sqrt(2-sqrt(2)), 1/2>,
    <cos(2*pi/4)/sqrt(2-sqrt(2)), sin(2*pi/4)/sqrt(2-sqrt(2)), 1/2>,
    <cos(3*pi/4)/sqrt(2-sqrt(2)), sin(3*pi/4)/sqrt(2-sqrt(2)), 1/2>,
    <cos(4*pi/4)/sqrt(2-sqrt(2)), sin(4*pi/4)/sqrt(2-sqrt(2)), 1/2>,
    <cos(5*pi/4)/sqrt(2-sqrt(2)), sin(5*pi/4)/sqrt(2-sqrt(2)), 1/2>,
    <cos(6*pi/4)/sqrt(2-sqrt(2)), sin(6*pi/4)/sqrt(2-sqrt(2)), 1/2>,
    <cos(7*pi/4)/sqrt(2-sqrt(2)), sin(7*pi/4)/sqrt(2-sqrt(2)), 1/2>,
    <cos(0*pi/2+pi/8)/sqrt(2), sin(0*pi/2+pi/8)/sqrt(2), (1+sqrt(2))/2>,
    <cos(1*pi/2+pi/8)/sqrt(2), sin(1*pi/2+pi/8)/sqrt(2), (1+sqrt(2))/2>,
    <cos(2*pi/2+pi/8)/sqrt(2), sin(2*pi/2+pi/8)/sqrt(2), (1+sqrt(2))/2>,
    <cos(3*pi/2+pi/8)/sqrt(2), sin(3*pi/2+pi/8)/sqrt(2), (1+sqrt(2))/2>,
    <0,0,0>
}

// Array of edge indexes
#declare num_edges = 20;
#declare edges = array [num_edges][2] {
   {0, 1},
   {1, 2},
   {2, 3},
   {3, 4},
   {4, 5},
   {5, 6},
   {6, 7},
   {7, 0},
   {8, 9},
   {9, 10},
   {10, 11},
   {11, 8},
   {0, 8},
   {1, 8},
   {2, 9},
   {3, 9},
   {4, 10},
   {5, 10},
   {6, 11},
   {7, 11}
}

// Array of face vertex counts and indexes
   triface(verts[0], verts[1], verts[8])
   triface(verts[2], verts[3], verts[9])
   triface(verts[4], verts[5], verts[10])
   triface(verts[6], verts[7], verts[11])
   squareface(verts[1], verts[2], verts[9], verts[8])
   squareface(verts[3], verts[4], verts[10], verts[9])
   squareface(verts[5], verts[6], verts[11], verts[10])
   squareface(verts[7], verts[0], verts[8], verts[11])
   squareface(verts[8], verts[9], verts[10], verts[11])

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

  camera { location <0,3.2,1.5>
           sky <0,0,1>
           look_at <0,0,0>
           rotate <0, 0, clock>
         }

   light_source {<0.2, 7, 7> color <1,1,1> shadowless
           rotate <0, 0, clock>
       }
