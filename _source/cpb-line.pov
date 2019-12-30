#version 3.6;

#include "colors.inc"
#include "transforms.inc"

#macro v_equal(v1,v2) ((v1.x=v2.x)&(v1.y=v2.y)&(v1.z=v2.z)) #end

#macro disp_edge(edge, col)
   #if(!v_equal(verts[edges[edge][0]], verts[edges[edge][1]]) )
      cylinder{verts[edges[edge][0]] verts[edges[edge][1]] edge_sz
         texture { edge_tex }
      }
   #end
#end

// Display values
   // Size (or radius) of elements
   #declare vert_sz = 0.0237764; // 0.0237764
   #declare edge_sz = 0.01; // 0.0158509

   // Colour of elements (used to set up default textures
   #declare vert_col = <0.901961, 0.45098, 0, 0>;
   #declare edge_col = <0.8, 0.6, 0.8, 0>; // <0.8, 0.6, 0.8, 0>

   // Texture of elements
   #declare vert_tex=texture{ pigment{ rgbt vert_col}}
   #declare edge_tex=texture{ pigment{ rgbt edge_col}}

// Array of vertex coordinates
#declare num_verts = 9;
#declare verts = array [num_verts] {
    <0,0,1>,
    <0,0,-1>,
    <1,0,0>,
    <cos(2*pi/5), sin(2*pi/5), 0>,
    <cos(4*pi/5), sin(4*pi/5), 0>,
    <cos(6*pi/5), sin(6*pi/5), 0>,
    <cos(8*pi/5), sin(8*pi/5), 0>,
    <0.3955909, 0.2874136, 0.3955909>,
    <0,0,0>
}

// Array of edge indexes
#declare num_edges = 15;
#declare edges = array [num_edges][2] {
   {0, 2},
   {0, 3},
   {0, 4},
   {0, 5},
   {0, 6},
   {1, 2},
   {1, 3},
   {1, 4},
   {1, 5},
   {1, 6},
   {2, 3},
   {3, 4},
   {4, 5},
   {5, 6},
   {6, 2},
}

   #declare i=0;
   #while (i<num_verts)
      sphere{ verts[i] vert_sz texture { vert_tex } }
      #declare i=i+1;
      #end

// Display edge elements
   #declare i=0;
   #while (i<num_edges)
      disp_edge(i, edge_col)
      #declare i=i+1;
      #end
  cylinder{<0,0,0> <1.97795447, 1.437068, 1.97795447>
    edge_sz texture { edge_tex }
  }

// Extra object
   sphere{<0,0,0> 1 texture{ pigment{color White filter 0.8 }}} 
   disc {verts[7] verts[7] 0.78 0.77 texture{ pigment{ color White } finish { diffuse 1.0}}}
   text { ttf "timrom.ttf" "c" 0.1, 0
       pigment { White }
       rotate 102.8*x
       translate -0.54*x -0.25*z 
       scale 0.18
       rotate <0,0,clock>
   }
   union {
   text { ttf "timrom.ttf" "aff(F)" 0.06, 0
       scale 0.16
       translate .66963*x + y
   }
   text { ttf "timrom.ttf" "S" 0.05, 0
       translate -0.5*x
       scale 0.16 }
   text { ttf "timrom.ttf" "F" 0.06, 0
       translate -0.2*y 
       scale 0.1 }
   translate -.66963*x + .4*y - .001*z
   rotate 128*x
   //rotate 90*y
   //Point_At_Trans(verts[7])
   rotate -54*z
   translate verts[7]
   pigment { Black } finish { diffuse 1.0 }
   }
  /* polygon{ 4, <1/2 - 3/2*cos(2*pi/5), -3/2 * sin(2*pi/5), 2>
               <-1.5 + 1/2*cos(2*pi/5), sin(2*pi/5)/2, 2>
               <2*cos(2*pi/5), 2*sin(2*pi/5), -1>
               <2, 0, -1>
               texture {
                   finish { ambient 1 diffuse 0 }
                   pigment { White }
               }
           }*/
   plane { verts[7] vlength(verts[7]) texture { pigment { color rgb <1,1,1> } } }

background {color <0,0,0,1>}
// Max Trace Level (10), increase if black areas appear when using transparency
global_settings{max_trace_level 10
                assumed_gamma 2.2 }

  camera { location <0,2.7,0.5>
           sky <0,0,1>
           look_at <0,0,0.22>
           rotate   <0,0,clock>
         }

   light_source {<0, 3, 1> color <1,1,1> shadowless rotate <0,0,clock> }
