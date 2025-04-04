% This script loads a skeletonized tif stack, extracts the network, and
% plots it in 3D. It also highlights any loops present in the network.

close all; 
clear all; 
clc;

addpath('C:/Users/ADMINS1/Desktop/Megumi Matlab/skel2graph_lib');

% Load tif stack
[file, folder] = uigetfile({'*.tif;*.tiff','TIFF Files (*.tif, *.tiff)';'*.*','All Files'},'Select the TIFF stack file');
if isequal(file, 0)
    disp('User cancelled the operation.');
    return;
end
file_path = fullfile(folder, file);

% Load the selected image
BW_stack = load_tif(file_path);

% Parameters
dr = 7; % um/pixel

% Extract network
[~, nodes, links] = Skel2Graph3D(BW_stack,0);
im_size = size(BW_stack);
L = segment_lengths(links,dr,im_size);
[edge_list, node_positions] = construct_newtork(links,nodes,L,im_size);

% Plot 3D network and loops
figure;
plot_graph_3d(edge_list,node_positions, folder);
axis tight; axis equal;
set(gca,'Color','k');

% Use 3D plot to find the node number of the root of the tree, 
% and plot branching tree
root_node = 6;
figure;
plot_graph(edge_list,node_positions,root_node, folder);

% Save node_positions to CSV file in the same folder as the selected image
csv_file_path = fullfile(folder, 'node_positions.csv');
csvwrite(csv_file_path, node_positions);
disp(['Node positions saved to ', csv_file_path]);

% Functions
function B = load_tif(file_path)
    info = imfinfo(file_path);
    num_images = length(info);
    B = [];
    for nframe = 1:num_images
        B(:,:,nframe) = imread(file_path,nframe,'Info',info);
    end
    B = (B > 0);
end

function pos = pt_pos(pt_ind,im_size)
    [row,col,frame] = ind2sub(im_size,pt_ind);
    pos = [row,col,frame];
end

function [edge_list,node_positions,node_positions_all] = construct_newtork(links,nodes,L,im_size)
    edge_list = [];
    node_positions = [];
    sauce = double(vertcat(links.n1));
    endpt = double(vertcat(links.n2));
    edge_list = [sauce, endpt, L];

    unodes = (1:length(vertcat(nodes.comx)))';
    node_positions = [unodes, vertcat(nodes.comx), vertcat(nodes.comy), vertcat(nodes.comz)];

    nodesidx = vertcat(nodes.idx);
    pos = pt_pos(nodesidx,im_size);
    ntot = (1:length(nodesidx))';
    node_positions_all = [ntot, pos];
end

function [G,h] = plot_graph(edge_list,node_positions,source_node, folder)
    m = max(node_positions(:,1));
    edge_list(any(isnan(edge_list), 2), :) = m + 1;
    G = graph(edge_list(:,1),edge_list(:,2));
    h = plot(G,'layout','layered','NodeLabel',{},'Marker','none','EdgeColor','k');
    layout(h,'layered','sources',source_node);
    plot_cycles(G,h, folder);
end

function [G,h] = plot_graph_3d(edge_list,node_positions, folder)
    m = max(node_positions(:,1));
    edge_list(any(isnan(edge_list), 2), :) = m + 1;
    G = graph(edge_list(:,1),edge_list(:,2));
    h = plot(G,'XData',node_positions(:,2),'YData',node_positions(:,3),'ZData',node_positions(:,4),'NodeLabel',{},'Marker','none','EdgeColor','w', 'LineWidth', 2);
    plot_cycles(G,h, folder);
end

function plot_cycles(G,h, folder)
    [cycles,edgecycles] = cyclebasis(G);

    if isempty(cycles)
        disp('No loops detected')
    else
        disp('Plotting loops')
        for k = 1:length(cycles)
            highlight(h,cycles{k},'Edges',edgecycles{k},'EdgeColor','g','NodeColor','g','LineWidth', 4)
            disp(cycles{k})
        end
    end
    
    % Save text displayed by the script to a text file
    loops_text = '';
    if ~isempty(cycles)
        loops_text = 'Loops detected:';
        for k = 1:length(cycles)
            loops_text = [loops_text, sprintf('\nLoop %d: %s', k, mat2str(cycles{k}))];
        end
    else
        loops_text = 'No loops detected.';
    end

    loops_file_path = fullfile(folder, 'loops.txt');
    fid = fopen(loops_file_path, 'w');
    fprintf(fid, '%s', loops_text);
    fclose(fid);
    disp(['Loops information saved to ', loops_file_path]);
end

function L = segment_lengths(links,dr,im_size)
    L = zeros(length(links),1);
    for i = 1:length(links)
        pts = links(i).point;
        d = 0;
        for j = 1:length(pts)-1
            pt1 = pts(j); pt2 = pts(j+1);
            pos1 = pt_pos(pt1,im_size); pos2 = pt_pos(pt2,im_size);
            d = d + pdist2(pos1.*dr,pos2.*dr);
        end
        L(i) = d;
    end
end
