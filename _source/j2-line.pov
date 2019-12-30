#version 3.6;

#include "colors.inc"
#include "textures.inc"

#macro v_equal(v1,v2) ((v1.x=v2.x)&(v1.y=v2.y)&(v1.z=v2.z)) #end

#macro col_to_tex(col, elem_tex_map, elem_col_map, def_tex)
   #local typ=0;
   #if(col.y>=0) #local typ=1; #end
   #if(!typ & col.y=-1)
      #if(col.x<dimension_size(elem_tex_map,1))
         #ifdef(elem_tex_map[col.x]) #local typ=2; #end
      #end
      #if(!typ & col.x<dimension_size(elem_col_map,1))
         #ifdef(elem_col_map[col.x]) #local typ=3; #end
      #end
   #end
   #switch(typ)
      #case(0) texture{ def_tex } #break;
      #case(1) texture{ pigment{ rgbt col}} #break;
      #case(2) texture{ elem_tex_map[-col.x]} #break;
      #case(3) texture{ pigment{ color elem_col_map[-col.x]}} #break;
   #end
#end

#macro disp_edge(edge, col)
   #if(!v_equal(verts[edges[edge][0]], verts[edges[edge][1]]) )
      cylinder{verts[edges[edge][0]] verts[edges[edge][1]] edge_sz
         col_to_tex(col, tex_map, col_map, edge_tex)
      }
   #end
#end

// Display values
   // Size (or radius) of elements
   #declare vert_sz = 0.0237764; // 0.0237764
   #declare edge_sz = 0.01; // 0.0158509
   #declare face_sz = 0; // 0

   // Colour of elements (used to set up default textures
   #declare vert_col = <0.901961, 0.45098, 0, 0>;
   #declare edge_col = <0.8, 0.6, 0.8, 0>; // <0.8, 0.6, 0.8, 0>
   #declare face_col = <0.8, 0.901961, 0.901961, 0>; // <0.8, 0.901961, 0.901961, 0>

   // Texture of elements
   #declare vert_tex=texture{ pigment{ rgbt vert_col}}
   #declare edge_tex=texture{ pigment{ rgbt edge_col}}
   #declare face_tex=texture{ pigment{ rgbt face_col}}

#declare col_map = array[1]; // Default colourmap
#declare tex_map = array[1]; // Default texmap

// Array of vertex coordinates
#declare num_verts = 8;
#declare verts = array [num_verts] {
    <0,0,sqrt(5)/2>,
    <0,0,0>,
    <1,0,0.5>,
    <cos(2*pi/5), sin(2*pi/5), 0.5>,
    <cos(4*pi/5), sin(4*pi/5), 0.5>,
    <cos(6*pi/5), sin(6*pi/5), 0.5>,
    <cos(8*pi/5), sin(8*pi/5), 0.5>,
    <(3+sqrt(5))/12, sqrt(10 + 2*sqrt(5))/12, (2 + sqrt(5))/6>
}

// Array of edge indexes
#declare num_edges = 10;
#declare edges = array [num_edges][2] {
   {0, 2},
   {0, 3},
   {0, 4},
   {0, 5},
   {0, 6},
   {2, 3},
   {3, 4},
   {4, 5},
   {5, 6},
   {6, 2},
}

// face colours
#declare f_col = <0.901961, 0.45098, 0, 1>;

// Colour Maps - redefine these, normally in an include file
   #declare col_map = array[1];
   #declare tex_map = array[1];

// Array of face vertex counts and indexes

   #declare i=0;
   #while (i<num_verts)
      sphere{ verts[i] vert_sz col_to_tex(vert_col, tex_map, col_map, vert_tex) }
      #declare i=i+1;
      #end

// Display edge elements
   #declare i=0;
   #while (i<num_edges)
      disp_edge(i, edge_col)
      #declare i=i+1;
      #end
  cylinder{<0,0,0> <1.309017, 0.951057, 2.118034>
    edge_sz col_to_tex(edge_col, tex_map, col_map, edge_tex)
  }

// Extra object
   sphere{<0,0,0> sqrt(5)/2 
       pigment{
           uv_mapping
           Tiles_Ptrn()
           color_map {
               [0.00 color rgb <1,1,1>] // white stanchions
               [0.04 color rgbt <0,0,0,1>] // transparent spaces
           }
           scale <0.02, 0.02, 0.5> // size and ratio of the grid
       }
       rotate 90*x
   }
               
   disc {verts[7] verts[7] 0.68 0.67 texture{ pigment{ color White } finish { diffuse 1.0}}}

background {color <0,0,0,1>}
// Max Trace Level (10), increase if black areas appear when using transparency
global_settings{
    max_trace_level 10
    assumed_gamma 1.8
}

  camera { right x*1.5
           location <0,1.8,0.9>
           sky <0,0,1>
           look_at <0,0,0.4>
         }

   light_source {<.3, 3, 1.5> color <1,1,1> shadowless}
