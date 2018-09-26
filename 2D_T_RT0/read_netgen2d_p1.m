function [nodes2coord,elems2nodes,nodes2dofs,ngdof,elems2subd,boundary]=read_netgen2d_p1(meshfile)
% read 2-d mesh from Neutral Format generated by Netgen
%
% To generate a mesh file of this format, first define the geometry using
% the 2D Spline geometry format (.in2d), load into netgen, click 
% 'Generate Mesh', then export to a .mesh file (ensure export filetype is 
% neutral)
%
% Input:
%   meshfile - .mesh file generated by netgen
%
% Output:
%   nodes2coord - mapping of nodes to coordinates
%   elems2nodes - mapping of elements to nodes
%   nodes2dofs  - mapping of nodes to degrees of freedom
%   ngdof       - number of global degrees of freedom
%   elems2subd  - mapping of elements to subdomains
%   boundary    - information about boundary
% ----------------------------------------------------------
% by Bedrich Sousedik, March 2010.
% modified by Kevin Williamson, August 2017

% read mesh information;
fid = fopen(meshfile,'r');
nnode = textscan(fid,'%f',1);  
nnode = nnode{1};          % # of points
C = textscan(fid,'%f %f %f %f');
fclose(fid);

% extract the coordinates
gcoord(:,1)=C{1}(1:nnode);
gcoord(:,2)=C{2}(1:nnode);
nodes2coord = gcoord';

% extract elements, partitioned into subdomains
nel = C{1}(nnode+1);
elems2subd = C{1}(1+nnode+(1:nel))';	     
nodes(:,1)=C{2}(1+nnode+(1:nel)); 
nodes(:,2)=C{3}(1+nnode+(1:nel)); 
nodes(:,3)=C{4}(1+nnode+(1:nel)); 
elems2nodes = nodes';

% extract boundary information
nintf= C{1}(nnode+nel+2);
boundary=[C{1}(nnode+nel+2+(1:nintf)) C{2}(nnode+nel+2+(1:nintf)) C{3}(nnode+nel+2+(1:nintf))]';

% extract degrees of freedom
% pressure dof only at corners. get number of corner nodes
ngdof = nnode;
nodes2dofs = (1:nnode);

return % end of function