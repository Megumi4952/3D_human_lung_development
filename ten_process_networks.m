% To test this script, download an unzip the data in ¨Data for testing ten_process_netwok¨, and put the data in the same folder as this script.
% open the script in Matlab (R2022a or newer) and press RUN .
% The script produces the edge_list and corresponding node positions list for each lobe in the sample.

clc;  clear all
% close all;

%% Choose dataset to analyse
prunning = 0; % in microns
perform_generation_dependant_prunning = 0; factor = 0.5; % del endduct length < width*factor
generate_networks_with_endnode_levels = 0;
needs_skeletonization = 0;

% dataset = 'right-upper'
% dataset = 'left-upper'
dataset = 'left-lower'
% dataset = 'left-upper-with-surface'
% dataset = 'compare width method min mean max'

folder_path = {}; file_names = {}; width_imgs = {}; drs = {}; branch_nodes = {}; sample = {};
if ispc
    switch dataset
        case 'compare width method min mean max'

            branches = {'B1and2','B3','B4','B5'};
            
            folder_path{end+1} = 'E:\Documents\Ignacio\Megumi\Shared Human Lung Development (data)\Left Lungs\Left Upper Lobes\EH4287-LU-B3-PART-P14';
            sample{end+1} = 'EH4287-LU-B3-PART-P14';
            file_names{end+1} = 'EH4287Gen8_skel_4um.ome.tif';
            width_imgs{end+1} = 'EH4287Gen8_4um_Tb.tif';
            drs{end+1} = [4 4 4];
            branch_nodes{end+1} = [47.0, 343.0, 126.0;nan nan nan;47.0, 343.0, 126.0;nan nan nan;nan nan nan;];
            
            network_dir = ['E:\Documents\Ignacio\Megumi\Shared Human Lung Development (data)\Left Lungs\Left Upper Lobes\','test_widths'];
        case 'left-upper'
            %% Left Lungs\Left Upper Lobes
            branches = {'B1and2','B3','B4','B5'};

%             % % Root: Not applicable (broken at root)
%             folder_path{end+1} = 'E:\Documents\Ignacio\Megumi\Shared Human Lung Development (data)\Left Lungs\Left Upper Lobes\EH4295-LU-P8.3(8.3)';
%             sample{end+1} = 'EH4295-LU-P8.3(8.3)';
%             file_names{end+1} = 'EH4295LU_Skel_7um_2_prune35.ome.tif';
%             width_imgs{end+1} = 'EH4295LU_7um_Tb.tif';
%             drs{end+1} = [7 7 7];
%             branch_nodes{end+1} = [nan nan nan;128, 198, 193;164, 204, 180;203, 217, 194;221, 230, 206];
% 
%             %           Root: Not applicable (broken at root)
%             folder_path{end+1} = 'E:\Documents\Ignacio\Megumi\Shared Human Lung Development (data)\Left Lungs\Left Upper Lobes\EH4256-LU-P8.4(8.3)';
%             sample{end+1} = 'EH4256-LU-P8.4(8.3)';
%             file_names{end+1} = 'EH4256LU_Skel_7um_2_prune35.ome.tif';
%             width_imgs{end+1} = 'EH4256LU_7um_Tb.tif';
%             drs{end+1} = [7 7 7];
%             branch_nodes{end+1} = [nan nan nan;125, 190, 247;144, 181, 250;197, 218, 250;218, 205, 261];


%             folder_path{end+1} = 'E:\Documents\Ignacio\Megumi\Shared Human Lung Development (data)\Left Lungs\Left Upper Lobes\EH4062-LU-P8.3';
%             sample{end+1} = 'EH4062-LU-P8.3';
%             file_names{end+1} = 'EH4062LU_Skel_7um_3_prune35.ome.tif';
%             width_imgs{end+1} = 'EH4062LU_7um_Tb.tif';
%             drs{end+1} = [7 7 7];
%             branch_nodes{end+1} = [205, 340, 41;276, 347, 68;250, 307, 75;190, 283, 95;189, 279, 66];
% 
%             folder_path{end+1} = 'E:\Documents\Ignacio\Megumi\Shared Human Lung Development (data)\Left Lungs\Left Upper Lobes\EH4049LU-P9.9';
%             sample{end+1} = 'EH4049LU-P9.9';
%             file_names{end+1} = 'EH4049LU_Skel_7um_4_prune35.ome.tif';
%             width_imgs{end+1} = 'EH4049LU_7um_Tb.tif';
%             drs{end+1} = [7 7 7];
%             branch_nodes{end+1} = [650, 189, 343;758, 226, 301;746, 260, 294;641, 162, 272;566, 122, 267];
% 
% 
%             folder_path{end+1} = 'E:\Documents\Ignacio\Megumi\Shared Human Lung Development (data)\Left Lungs\Left Upper Lobes\EH3685-LU-P8.9(P8.7)';
%             sample{end+1} = 'EH3685-LU-P8.9(P8.7)';
%             file_names{end+1} = 'EH3685LU_skel_7um_3_prune35.ome.tif';
%             width_imgs{end+1} = 'EH3685LU_7um_Tb.tif';
%             drs{end+1} = [7 7 7];
%             branch_nodes{end+1} = [269, 331, 20;320, 303, 77;312, 272, 85;238, 239, 97;213, 249, 80];
% 
%             folder_path{end+1} = 'E:\Documents\Ignacio\Megumi\Shared Human Lung Development (data)\Left Lungs\Left Upper Lobes\EH3549-LU-P8.7(8.3)';
%             sample{end+1} = 'EH3549-LU-P8.7(8.3)';
%             file_names{end+1} = 'EH3549LU_Skel_7um_4_prune35.ome.tif';
%             width_imgs{end+1} = 'EH3549LU_7um_Tb.tif';
%             drs{end+1} = [7 7 7];
%             branch_nodes{end+1} = [251, 325, 247;231, 301, 187;271, 286, 178;340, 267, 175;374, 276, 183];
% 
%             folder_path{end+1} = 'E:\Documents\Ignacio\Megumi\Shared Human Lung Development (data)\Left Lungs\Left Upper Lobes\EH3547-LU-P8.0(P8.7)';
%             sample{end+1} = 'EH3547-LU-P8.0(P8.7)';
%             file_names{end+1} = 'EH3547LU_Skel_7um_2_prune35.ome.tif';
%             width_imgs{end+1} = 'EH3547LU_7um_Tb.tif';
%             drs{end+1} = [7 7 7];
%             branch_nodes{end+1} = [308, 241, 31;338, 273, 95;375, 238, 107;247, 227, 149;238, 198, 128];
% 
%             folder_path{end+1} = 'E:\Documents\Ignacio\Megumi\Shared Human Lung Development (data)\Left Lungs\Left Upper Lobes\EH4437LU-P9.0(9.7)';
%             sample{end+1} = 'EH4437LU-P9.0(9.7)';
%             file_names{end+1} = 'EH4437LU_7um_skel_prune35.tif';
%             width_imgs{end+1} = 'EH4437LU_7um_Tb.tif';
%             drs{end+1} = [7 7 7];
%             branch_nodes{end+1} = [310.0, 112.0, 241.0;400.0, 129.0, 211.0;424.33, 169.33, 211.67;340.33, 173.33, 207.67;293.0, 188.33, 217.67];
% 
%             folder_path{end+1} = 'E:\Documents\Ignacio\Megumi\Shared Human Lung Development (data)\Left Lungs\Left Upper Lobes\EH3822-LU-P9.9(10.2)';
%             sample{end+1} = 'EH3822-LU-P9.9(10.2)';
%             file_names{end+1} = 'EH3822LU_Skel_4um_prune35.tif';
%             width_imgs{end+1} = 'EH3822LU_4um_Tb.tif';
%             drs{end+1} = [4 4 4];
%             branch_nodes{end+1} = [1133.00	524.00	503;	1338.00	495.25	412;	1203.00	489.67	388.33;	969.67	421.67	379.33;	895.33	472.00	449.00];
% 
%             folder_path{end+1} = 'E:\Documents\Ignacio\Megumi\Shared Human Lung Development (data)\Left Lungs\Left Upper Lobes\EH3138-LU-P9.0(9.7)';
%             sample{end+1} = 'EH3138-LU-P9.0(9.7)';
%             file_names{end+1} = 'EH3138LU_skel_7um_prune35.ome.tif';
%             width_imgs{end+1} = 'EH3138LU_7um.ome_Tb.tif';
%             drs{end+1} = [7 7 7];
%             branch_nodes{end+1} = [510.00	301.00	283.33;	556.33	255.67	245.67;	518	261	244;	456	230	231;	386	216	228];
% 
%             folder_path{end+1} = 'E:\Documents\Ignacio\Megumi\Shared Human Lung Development (data)\Left Lungs\Left Upper Lobes\EH3570-LU-P9.9(P7.9)';
%             sample{end+1} = 'EH3570-LU-P9.9(P7.9)';
%             file_names{end+1} = 'EH3570LU_Skel_7um_prune35.ome.tif';
%             width_imgs{end+1} = 'EH3570LU_7um_rootadded.ome_Tb.tif';
%             drs{end+1} = [7 7 7];
%             branch_nodes{end+1} = [282.0, 162.0, 78.0;210.67, 122.67, 70.333;232.0, 139.0, 93.0;285.0, 135.0, 154.0;320.67, 137.0, 187.67];
% 
            folder_path{end+1} = 'E:\Documents\Ignacio\Megumi\Shared Human Lung Development (data)\Left Lungs\Left Upper Lobes\EH2848-LU-P7.7(6.9)';
            sample{end+1} = 'EH2848-LU-P7.7(6.9)';
            file_names{end+1} = 'EH2848LU_Skel_7um_prune35.ome.tif';
            width_imgs{end+1} = 'EH2848LU_7um_Tb.tif';
            drs{end+1} = [7 7 7];
            branch_nodes{end+1} = [120.0, 239.0, 202.0;122.0, 244.0, 142.0; 97.0, 219.0, 133.0;92.0, 144.0, 143.0;84.667, 114.33, 187.33];
% 
% %%             B1 and 2 only!!!! Check with megumi
%             folder_path{end+1} = 'E:\Documents\Ignacio\Megumi\Shared Human Lung Development (data)\Left Lungs\Left Upper Lobes\EH3879-2-LU-P11-B1and2ONLY';
%             sample{end+1} = 'EH3879-2-LU-P11-B1and2ONLY';
%             file_names{end+1} = 'SkelPrune35_noloops.ome.tif';
%             width_imgs{end+1} = 'newEH3879-2-LU-B1and2-4um_Tb.tif';
%             drs{end+1} = [7 7 7];
%             branch_nodes{end+1} = [111 574 116;111 574 116;nan nan nan;nan nan nan;nan nan nan;];
% % 
% 
%             folder_path{end+1} = 'E:\Documents\Ignacio\Megumi\Shared Human Lung Development (data)\Left Lungs\Left Upper Lobes\EH4287-LU-B3-PART-P14';
%             sample{end+1} = 'EH4287-LU-B3-PART-P14';
%             file_names{end+1} = 'EH4287Gen8_skel_4um.ome.tif';
%             width_imgs{end+1} = 'EH4287Gen8_4um_Tb.tif';
%             drs{end+1} = [4 4 4];
%             branch_nodes{end+1} = [47.0, 343.0, 126.0;nan nan nan;47.0, 343.0, 126.0;nan nan nan;nan nan nan;];
% % branch_nodes{end+1} = [47.0, 343.0, 126.0;nan nan nan;92,212,109;nan nan nan;nan nan nan;];

%             folder_path{end+1} = 'E:\Documents\Ignacio\Megumi\Shared Human Lung Development (data)\Left Lungs\Left Upper Lobes\EH4489LU-P13.7-B3PartEdge';
%             sample{end+1} = 'EH4489LU-P13.7-B3PartEdge';
%             file_names{end+1} = 'EH4489LUEdge_4um_skel_hand_corrected.ome.tif';
%             width_imgs{end+1} = 'EH4489LUEdge_4um-lbl_hand_corrected_Tb.tif';
%             drs{end+1} = [4 4 4];
%             branch_nodes{end+1} = [495 352 179;nan nan nan;495 352 179;nan nan nan;nan nan nan;];

%             folder_path{end+1} = 'E:\Documents\Ignacio\Megumi\Shared Human Lung Development (data)\Left Lungs\Left Upper Lobes\EH4489LU-P13.9-B1PartSup\Superior';
%             sample{end+1} = 'EH4489LU-P13.9-B1PartSup';
%             file_names{end+1} = 'EH4489LUB1Sup_4um_skel.ome.tif';
%             width_imgs{end+1} = 'EH4489LUB1Sup_4um_Tb.tif';
%             drs{end+1} = [4 4 4];
%             branch_nodes{end+1} = [114.0, 99.0, 78.0;114.0, 99.0, 78.0;nan nan nan;nan nan nan;nan nan nan;];


         network_dir = ['E:\Documents\Ignacio\Megumi\Shared Human Lung Development (data)\Left Lungs\Left Upper Lobes\','networks_raw'];

        case 'left-upper-with-surface'
            %% Left Lungs\Left Upper Lobes
            branches = {'B1and2','B3','B4','B5'};

            folder_path{end+1} = 'E:\Documents\Ignacio\Megumi\Shared Human Lung Development (data)\Left Lungs\Left Upper Lobes\with_surface\EH4256LU-P8.4(8.3)';
            sample{end+1} = 'EH4256LU-P8.4(8.3)';
            file_names{end+1} = 'EH4256LU_skel_7um_prune35.ome.tif';
            width_imgs{end+1} = 'EH4256LU_7um_Tb.tif';
            drs{end+1} = [7 7 7];
            branch_nodes{end+1} = [152.5,	177.5,	280.0;	129.0,	198.0,	253.0;	155.0,	186.33,	232.33;	201.0,	226.0,	256.0;	221.67,	212.33,	268.67];

            network_dir = ['E:\Documents\Ignacio\Megumi\Shared Human Lung Development (data)\Left Lungs\Left Upper Lobes\with_surface\','networks_raw'];

        case 'left-lower'
            branches = {'B6','B7','B8','B9','B10','Bsharp'};

%             folder_path{end+1} = 'E:\Documents\Ignacio\Megumi\Shared Human Lung Development (data)\Left Lungs\Left Lower Lobes\10GW28082022-LL-P8.0';
%             sample{end+1} = '10GW28082022-LL-P8.0';
%             file_names{end+1} = '10GW28082022LL_7um_skel_prune35.ome.tif';
%             width_imgs{end+1} = '10GW28082022LL_7um_Tb.tif';
%             drs{end+1} = [7 7 7];
%             branch_nodes{end+1} = [436	332	77.0;	384	321.33	103.67;	289.33	231.33	101.67;	302.67	222.67	129.67;	281.67	257.67	123.33;	285.67	288	111.33];

%             folder_path{end+1} = 'E:\Documents\Ignacio\Megumi\Shared Human Lung Development (data)\Left Lungs\Left Lower Lobes\11GW18032022-LL-P9.0';
%             sample{end+1} = '11GW18032022-LL-P9.0';
%             file_names{end+1} = '11GW18032022LL_skel_7um_prune35.ome.tif';
%             width_imgs{end+1} = '11GW18032022LL_7um_Tb.tif';
%             drs{end+1} = [7 7 7];
%             branch_nodes{end+1} = [564	92	256.0;	543.33	100.67	214.33;	412	178	292.0;	440	215	274.0;	443	170.33	246.0;	455	139	237.0];

%             folder_path{end+1} = 'E:\Documents\Ignacio\Megumi\Shared Human Lung Development (data)\Left Lungs\Left Lower Lobes\EH2987-LL-P6.1(4.7)';
%             sample{end+1} = 'EH2987-LL-P6.1(4.7)';
%             file_names{end+1} = 'EH2987LL_skel_7um_noprune.ome.tif';
%             width_imgs{end+1} = 'EH2987LL_7um_Tb.tif';
%             drs{end+1} = [7 7 7];
%             branch_nodes{end+1} = [122	60	18.0;	122.25	57	18.5;	81.333	24.667	57.333;	102	39	76.0;	82	54	66.0;	80	63	51.0];
% 
%             folder_path{end+1} = 'E:\Documents\Ignacio\Megumi\Shared Human Lung Development (data)\Left Lungs\Left Lower Lobes\EH3547-LL-P8.0(8.7)';
%             sample{end+1} = 'EH3547-LL-P8.0(8.7)';
%             file_names{end+1} = 'EH3547LL_skel_7um_prune35.ome.tif';
%             width_imgs{end+1} = 'EH3547LL_7um_Tb.tif';
%             drs{end+1} = [7 7 7];
%             branch_nodes{end+1} = [543	226	94.0;	505.67	269.33	157.33;	385.67	185.33	209.33;	406.33	207	227.67;	364	229	205.0;	391	245	169.0];
% 
%             folder_path{end+1} = 'E:\Documents\Ignacio\Megumi\Shared Human Lung Development (data)\Left Lungs\Left Lower Lobes\EH3549-LL-P8.7(8.3)';
%             sample{end+1} = 'EH3549-LL-P8.7(8.3)';
%             file_names{end+1} = 'EH3549LL_7um_skel_prune35.ome.tif';
%             width_imgs{end+1} = 'EH3549LL_7um_Tb.tif';
%             drs{end+1} = [7 7 7];
%             branch_nodes{end+1} = [113.0, 230.0, 259.0;159.0, 261.0, 232.0;279.0, 283.0, 256.0;291.0, 282.0, 237.0;271.0, 224.0, 165.0;266.0, 260.0, 184.0;243.0, 202.0, 202.0];
% 
            folder_path{end+1} = '';
            sample{end+1} = 'EH3669-LL-P5.6(6.3)';
            file_names{end+1} = 'EH3669LL_skel_7um_prune35.ome.tif';
            width_imgs{end+1} = 'EH3669LL_7um_Tb.tif';
            drs{end+1} = [7 7 7];
            branch_nodes{end+1} = [93	75	180.0;	64.75	70	131.25;	133.33	100.33	70.667;	121.67	59.667	62.667;	95	92	58.0;	67	96	89.0];
% 
%             folder_path{end+1} = 'E:\Documents\Ignacio\Megumi\Shared Human Lung Development (data)\Left Lungs\Left Lower Lobes\EH3685-LL-P8.9(8.7)';
%             sample{end+1} = 'EH3685-LL-P8.9(8.7)';
%             file_names{end+1} = 'EH3685LL_skel_7um_prune35.ome.tif';
%             width_imgs{end+1} = 'EH3685LL_7um_Tb.tif';
%             drs{end+1} = [7 7 7];
%             branch_nodes{end+1} = [489	305	79.0;	471	342	127.0;	317.67	232.67	121.67;	345.67	233.67	149.33;	349.67	286	141.33;	334	325	129.0];
% 
%             folder_path{end+1} = 'E:\Documents\Ignacio\Megumi\Shared Human Lung Development (data)\Left Lungs\Left Lower Lobes\EH4062-LL-P8.7';
%             sample{end+1} = 'EH4062-LL-P8.7';
%             file_names{end+1} = 'EH4062LL_skel_7um_prune35.ome.tif';
%             width_imgs{end+1} = 'EH4062LL_7um_Tb.tif';
%             drs{end+1} = [7 7 7];
%             branch_nodes{end+1} = [508	379	117.0;	484	405	167.0;	402	327	126.0;	427.67	310.67	176.33;	370	322	186.0;	328.33	355.67	184.33;	370	402	190.0];
% 
%             folder_path{end+1} = 'E:\Documents\Ignacio\Megumi\Shared Human Lung Development (data)\Left Lungs\Left Lower Lobes\EH4441-LL-P6.4(4.7)';
%             sample{end+1} = 'EH4441-LL-P6.4(4.7)';
%             file_names{end+1} = 'EH4441LL_skel_7um_prune35.ome.tif';
%             width_imgs{end+1} = 'EH4441LL_7um_Tb.tif';
%             drs{end+1} = [7 7 7];
%             branch_nodes{end+1} = [115	139	53.0;	139	100	57.0;	76.667	79.667	86.667;	71	61	66.0;	93	54	107.0;	124	60	112.0];
% 
%             folder_path{end+1} = 'E:\Documents\Ignacio\Megumi\Shared Human Lung Development (data)\Left Lungs\Left Lower Lobes\EH4451-LL-P7.7(6.3)';
%             sample{end+1} = 'EH4451-LL-P7.7(6.3)';
%             file_names{end+1} = 'EH4451LL_skel_7um_prune35.ome.tif';
%             width_imgs{end+1} = 'EH4451LL_7um_Tb.tif';
%             drs{end+1} = [7 7 7];
%             branch_nodes{end+1} = [192	85	94.0;	176	68	52.0;	117	147	72.0;	133	128	42.0;	82	151.5	37.5;	101	94	38.0];


            network_dir = ['E:\Documents\Ignacio\Megumi\Shared Human Lung Development (data)\Left Lungs\Left Lower Lobes\','networks_raw'];

        case 'right-upper'
            branches = {'B1','B2','B3','B4','B5'};

            folder_path{end+1} = 'E:\Documents\Ignacio\Megumi\Shared Human Lung Development (data)\Right Upper and Middle Lobes\EH3685-RUM-P8.9(8.7)';
            sample{end+1} = 'EH3685-RUM-P8.9(8.7)';
            file_names{end+1} = 'EH3685RUM_7um_skel_prune35.ome.tif';
            width_imgs{end+1} = 'EH3685RUM_7um_Tb.tif';
            drs{end+1} = [7 7 7];
            branch_nodes{end+1} = [322	62	306.0;	265	125	209.0;	296	166	206.0;	262	165	269.0;	415.67	222.67	283.67;	412.33	224.67	322.67];

            folder_path{end+1} = 'E:\Documents\Ignacio\Megumi\Shared Human Lung Development (data)\Right Upper and Middle Lobes\EH3694-RUM-P9.3(9.7)';
            sample{end+1} = 'EH3694-RUM-P9.3(9.7)';
            file_names{end+1} = 'EH3694RUM_7um_skel_prune35.ome.tif';
            width_imgs{end+1} = 'EH3694RUM_7um_Tb.tif';
            drs{end+1} = [7 7 7];
            branch_nodes{end+1} = [547	257	180.0;	509	232	259.0;	455	196.67	253.33;	449	273	235.0;	302	387	162.0;	267	341.67	157.33];

            folder_path{end+1} = 'E:\Documents\Ignacio\Megumi\Shared Human Lung Development (data)\Right Upper and Middle Lobes\GW1028082022-RUM-P8.0';
            sample{end+1} = 'GW1028082022-RUM-P8.0';
            file_names{end+1} = 'GW1028082022RUM_skel_7um_prune35.ome.tif';
            width_imgs{end+1} = 'GW1028082022RUM_7um_Tb.tif';
            drs{end+1} = [7 7 7];
            branch_nodes{end+1} = [189	390	32.0;	190	365	97.0;	222	331	121.0;	175	308	96.0;	276.33	257.67	68.333;	244	241	67.0];

            %     folder_path{end+1} = '';
            %     sample{end+1} = '';
            %     file_names{end+1} = '.tif';
            %     width_imgs{end+1} = '.tif';
            %     drs{end+1} = [7 7 7];
            %     branch_nodes{end+1} = [];

            network_dir = ['E:\Documents\Ignacio\Megumi\Shared Human Lung Development (data)\Right Upper and Middle Lobes\','networks_raw'];

    end
else
end

mkdir(network_dir)

for nfiles = 1:length(folder_path)

    save_fold = folder_path{nfiles};
    dr = drs{nfiles}; % um/pixel
    %     prunning_factor = 6;

    tree_info = {};
    num_imgs = [];
    %     file_name = file_names(nfiles).name;
    if isempty(folder_path{nfiles})
        full_path = file_names{nfiles};
        width_path = width_imgs{nfiles};
    else
    full_path = [folder_path{nfiles},'\',file_names{nfiles}];
    width_path = [folder_path{nfiles},'\',width_imgs{nfiles}];
    end
    info = imfinfo(full_path);
    % extract images and relevant info
    num_images_tot = length(info);
    % image dimensions
    num_images = length(info);
%     B = [];
%     for nframe = 1:num_images
% %         B(:,:,nframe) = imread_big(full_path, [nframe,nframe]);
%         B(:,:,nframe) = imread(full_path,nframe,'Info',info);
%     end
    if needs_skeletonization == 1
        B = tiffreadVolume(width_path);
        B = (B > 0);
        B = Skeleton3D(B==1);
    else
        B = tiffreadVolume(full_path);
        B = (B > 0);
    end

    [~,nodes,links] = Skel2Graph3D(B,prunning/dr(1));
    samp = sample{nfiles};
    switch samp
        case 'EH4062-LL-P8.7'
%             xyz = [nodes(:).comx;nodes(:).comy;nodes(:).comz]'
% [id,mind] = min(pdist2(xyz,[340,241,151]))
% [id,mind] = min(pdist2(xyz,[241,340,151]))
% nodes(192).idx
%              find([links(:).n1] == 333)
% find([links(:).n2] == 333)
% find([links(:).n1] == 396)
% find([links(:).n2] == 396)
            links(673) = [];
    end
    

    k = find(B == 1);
    [x,y,z] = ind2sub(size(B),k);
    ntot = (1:length(x))';
    node_positions_all = [ntot, x,y,z];

    im_size = size(B);
    L = segment_lengths(links,dr,im_size);

    % to manually add missing links
    
    switch dataset
        case 'left-upper'
%             switch samp
%                 case 'EH4049LU-P9.9'
%                     % (885, 286, 265) should connect with (864, 275, 266)
%                     poss{1} = [885, 286, 265];
%                     poss{2} = [864, 275, 266];
%                     connect_nodes = find_closest_node(node_positions_all(:,2:4),poss{1},poss{2},dr(1));
%                 otherwise
                     connect_nodes = [];
%             end
        case 'left-lower'
            switch samp
                case '11GW18032022-LL-P9.0'
                    poss{1} = [281,130,186; 249,120,186; 246,117,186; 228,114,186; 391,201,243];
                    poss{2} = [279,130,186; 247,119,186; 246,115,184; 225,114,184; 385,204,243];
                    connect_nodes = find_closest_node(node_positions_all(:,2:4),poss{1},poss{2},dr(1));
%                 case 'EH3549-LL-P8.7(8.3)'
%                     poss{1} = [328,151,144;327,323,229];
%                     poss{2} = [335,151,144;327,320,230];
%                     connect_nodes = find_closest_node(node_positions_all(:,2:4),poss{1},poss{2},dr(1));
                otherwise
                    connect_nodes = [];
            end
        otherwise
            connect_nodes = [];
    end

    source_position = branch_nodes{nfiles}(1,:);
    [edge_list,node_positions,edge_list_all,node_positions_all] = construct_newtork_node(links,nodes,L,im_size,source_position,width_path,dr(1),connect_nodes);

    if isfinite(branch_nodes{nfiles}(1,1))
        source_position = branch_nodes{nfiles}(1,:); % from images [y,x,z]
    else
        source_position = branch_nodes{nfiles}(2,:);
    end

    edge_list_orig = edge_list; 

    [~,root_nodes] = min(pdist2(node_positions(:,[3,2,4]),branch_nodes{nfiles}(:,[2,1,3])));
    root_nodes(~isfinite(branch_nodes{nfiles}(:,1))) = nan;
    [edge_list,del_nodes] = find_root(edge_list,root_nodes);

    edge_list_intermediate = edge_list;

    if perform_generation_dependant_prunning
    [edge_list,del_endnodes] = generation_dependant_prunning(edge_list,root_nodes,factor); factor = 0.5;
    end

    G = graph(edge_list_orig(:,1),edge_list_orig(:,2));
    [bins,binsizes] = conncomp(G);
    bns = bins(root_nodes(isfinite(root_nodes)));
    sources =[];
    for nun = unique(bns)
        tmp = find(bns == nun);
        sources(end+1) = tmp(1);
    end
    nods = find(ismember(bins,bns));
    inds = find(any(ismember(edge_list_orig(:,1:2),nods),2));
    edge_list_tmp = edge_list_orig(inds,:);
    G = graph(edge_list_tmp(:,1),edge_list_tmp(:,2));

    if generate_networks_with_endnode_levels && isfinite(root_nodes(1))
        [edge_list_tmp_clean] = remove_intermediate(edge_list_tmp,root_nodes(1));
        f0 = figure;
        [nod_dists_deg,poss] = end_node_level(edge_list_tmp_clean,node_positions,root_nodes(1));
        plot_3d_graph_endnode_level(edge_list_tmp_clean,node_positions,nod_dists_deg,poss,dr,root_nodes(1));

        f1 = figure;
        plot_3d_branching_degree(edge_list_tmp_clean,node_positions,dr,root_nodes(1));
    end

    f=figure;
    f.Position = [100 100 2000 400];
    subplot(1,length(root_nodes),1)
    h = plot(G,'layout','layered','NodeLabel',{},'Marker','none','EdgeColor','k');
    rn_tmp = root_nodes(isfinite(root_nodes));
    layout(h,'layered','sources',rn_tmp(sources));
    highlight(h,rn_tmp(1),'Marker','o','MarkerSize',4,'NodeColor','k')
    cols = [0 0.4470 0.7410;0.8500 0.3250 0.0980;0.9290 0.6940 0.1250;0.4940 0.1840 0.5560;0.4660 0.6740 0.1880;0.3010 0.7450 0.9330;0.6350 0.0780 0.1840];
    for i = 2:length(root_nodes)
        if isfinite(root_nodes(i))
        highlight(h,root_nodes(i),'Marker','o','MarkerSize',4,'NodeColor',cols(i,:))
        end
    end
    title('Full')
    sgtitle(sample{nfiles})

    G = graph(edge_list(:,1),edge_list(:,2));
    [bins,binsizes] = conncomp(G);
    file_dir = [network_dir,'\',sample{nfiles}];
    mkdir(file_dir)
    Im = tiffreadVolume(width_path);
    info = imfinfo(width_path);
    if ~isempty(info(1).XResolution)
        Im = Im.*info(1).XResolution;
    end

    for i = 2:length(root_nodes)
        if isfinite(branch_nodes{nfiles}(i,1))
            rn = root_nodes(i);
            bin = bins(rn);

            sub_nodes = find(bins == bin);

            inds = find(all(ismember(edge_list(:,1:2),sub_nodes),2));
            edge_list_sub = edge_list(inds,:);

            [edge_list_clean,node_positions_clean,newroot] = clean_edge_list(edge_list_sub,node_positions,rn);
            G = graph(edge_list_sub(:,1),edge_list_sub(:,2));
            deg = degree(G); deg(1) = [];
            if any(deg == 2)
                disp('Removing extra nodes (deg==2)')
%                 [edge_list_clean,node_positions_clean] = remove_intermediate_nodes(edge_list_clean,node_positions_clean,newroot);
                [edge_list_clean] = remove_intermediate(edge_list_clean,newroot);
            end

            [edge_list_sub,node_positions_sub] = construct_newtork_subtree(links,nodes,sub_nodes,rn,size(B),dr(1),Im);



%             figure;
            subplot(1,length(root_nodes),i)
            G = graph(edge_list_clean(:,1),edge_list_clean(:,2));
            h = plot(G,'layout','layered','NodeLabel',{},'Marker','none','EdgeColor','k');
            layout(h,'layered','sources',1);
            highlight(h,1,'Marker','o','MarkerSize',4,'NodeColor',cols(i,:))
            title(branches{i-1})
            
            file_path= [file_dir,'\',branches{i-1},'_all_nodes_edge_list.dat'];
            write_edge_list(file_path,sample{nfiles},branches{i-1},edge_list_sub)
            file_path= [file_dir,'\',branches{i-1},'_all_nodes_node_positions.dat'];
            write_node_pos(file_path,sample{nfiles},branches{i-1},node_positions_sub)

            file_path= [file_dir,'\',branches{i-1},'_clean_edge_list.dat'];
            write_edge_list(file_path,sample{nfiles},branches{i-1},edge_list_clean)
            file_path= [file_dir,'\',branches{i-1},'_clean_node_positions.dat'];
            write_node_pos(file_path,sample{nfiles},branches{i-1},node_positions_clean)
        end
    end

    file_path= [file_dir,'\networks.png'];
    saveas(f,file_path)

    if generate_networks_with_endnode_levels && isfinite(root_nodes(1))
    file_path= [file_dir,'\full_networks_with_endonde_levels.fig'];
    saveas(f0,file_path)

    file_path= [file_dir,'\full_networks_with_branching_type.fig'];
    saveas(f1,file_path)
    end

    %     plot_graph(edge_list,node_positions,root_nodes);



    %     [N,edges] = histcounts(L,0:10:10^3,'Normalization','PDF');
    %     X = (edges(2:end)+edges(1:end-1))/2;
    %
    %     all_Ns(nfiles,:) = N;
    %
    %     length(L)
    %
    %     %     all_Ns(all_Ns == 0) = [];
    %     mn = nanmean(all_Ns,1);
    %     err = nanstd(all_Ns,[],1);
    %     erneg = mn - err;
    %     erneg(erneg<=0) = 10e-8;
    %
    %     node_file = [save_fold,'node_positions.mat'];
    %     edge_file = [save_fold,'edge_list.mat'];
    %     save(node_file,'node_positions')
    %     save(edge_file,'edge_list')
    %
    %     node_file = [save_fold,'node_positions_all.mat'];
    %     save(node_file,'node_positions_all')
end

% scatter3(node_positions_all(:,2),node_positions_all(:,3),node_positions_all(:,4),'filled')
%%
%     [edge_list_tmp,del_nodes] = find_root(edge_list,root_nodes);
% 
%     G = graph(edge_list(:,1),edge_list(:,2));
%     [bins,binsizes] = conncomp(G);
% 
%     figure;
%     subplot(2,ceil((length(root_nodes)+1)/2),1)
%     h = plot(G,'layout','layered','NodeLabel',{},'Marker','none','EdgeColor','k');
%     layout(h,'layered','sources',root_nodes(1));
%     highlight(h,root_nodes(1),'Marker','o','MarkerSize',4,'NodeColor','g')
%     highlight(h,root_nodes(2:end),'Marker','o','MarkerSize',4,'NodeColor','r')
%     title('Full')
%     sgtitle(sample{nfiles})

% figure;
% h = plot_3d_graph(edge_list_clean,node_positions_clean,dr,1);
% highlight(h,4011,'Marker','o','NodeColor','r','MarkerSize',10);
%%
% figure;
% h = plot_3d_graph(edge_list_intermediate,node_positions,dr,root_nodes(1));
% highlight(h,del_endnodes,'Marker','o','NodeColor','r','MarkerSize',10);
    %%
% figure
% % plot_graph_v2(edge_list,node_positions)
% % figure;
% %
% G = plot_graph(edge_list,node_positions,1);
% %
% % cycles = allcycles(G);
% 
% % PRUNE
% deg = degree(G);
% ind1 = find(deg == 1); ind1(ind1 == 1) = [];
% [r,c] = find(ismember(edge_list(:,1:2),ind1))
% indshort = find(edge_list(:,3) <= prunning_factor*drs(1))
% inds = intersect(r,indshort);
% figure
% edge_list_pruned = edge_list;
% edge_list_pruned(inds,:) = [];
% % plot_graph_v2(edge_list_pruned,node_positions)
% plot_graph(edge_list_pruned,node_positions,1);
% 
% 
% 
% edge_file = [save_fold,'edge_list_pruned.mat'];
% save(edge_file,'edge_list_pruned')
% 
% figure;
% subplot(1,2,1)
% plot_3d_network(edge_list,node_positions)
% subplot(1,2,2)
% plot_3d_network(edge_list_pruned,node_positions); title('pruned')

%%

%             rn = root_nodes(i);
%             bin = bins(rn);
% 
%             sub_nodes = find(bins == bin);
% 
%             inds = find(all(ismember(edge_list(:,1:2),sub_nodes),2));
%             edge_list_sub = edge_list(inds,:);
% 
%             [edge_list_clean,node_positions_clean,newroot] = clean_edge_list(edge_list_sub,node_positions,rn);
%             G = graph(edge_list_sub(:,1),edge_list_sub(:,2));
%             deg = degree(G); deg(1) = [];
%             if any(deg == 2)
%                 disp('Removing extra nodes (deg==2)')
%                 [edge_list_clean,node_positions_clean] = remove_intermediate_nodes(edge_list_clean,node_positions_clean,newroot);
%             end
% 
%             [edge_list_sub,node_positions_sub] = construct_newtork_subtree(links,nodes,sub_nodes,rn,size(B),dr(1),width_path);



function L = segment_lengths(links,dr,im_size)
L = zeros(length(links),1);
for i = 1:length(links)
    pts = links(i).point;
    d = 0;
    for j = 1:length(pts)-1
        pt1 = pts(j); pt2 = pts(j+1);
        pos1 = pt_pos(pt1,im_size); pos2 = pt_pos(pt2,im_size);
        %
        d = d + pdist2(pos1.*dr,pos2.*dr);
    end
    L(i) = d;
end
end

function pos = pt_pos(pt_ind,im_size)
[row,col,frame] = ind2sub(im_size,pt_ind);
pos = [row,col,frame];

% pos = [row',col',frame'];
% if size(pos,2) ~= 3
%     disp('Error in pos dims')
% end
end

function [edge_list,node_positions,edge_list_all,node_positions_all] = construct_newtork_node(links,nodes,L,im_size,source_pos,width_imgs,dr,connect_nodes)
edge_list = [];
node_positions = [];
sauce = double(vertcat(links.n1));
endpt = double(vertcat(links.n2));
edge_list = [sauce, endpt, L];

Im = tiffreadVolume(width_imgs);
info = imfinfo(width_imgs);
if ~isempty(info(1).XResolution)
    Im = Im.*info(1).XResolution;
end
for i = 1:length(links)
    inds = links(i).point;
    w = find_duct_widths(Im,inds,dr);
% w = 1; disp('uncomment find widths!!!!!!!!!')
    edge_list(i,4) = nanmean(w);
    if ~isfinite(mean(w))
        disp('WARNING: NAN WIDTH')
    end
end

unodes = (1:length(vertcat(nodes.comx)))';
pos_reduced = [vertcat(nodes(unodes).comx), vertcat(nodes(unodes).comy), vertcat(nodes(unodes).comz)];

% size(unodes)
% size(pos_reduced)
node_positions = [unodes, pos_reduced];

edge_list_all = [[nodes.links];[nodes.conn]];

if ~isempty(connect_nodes)
    edge_list(end+1:end+size(connect_nodes,1),:) = [connect_nodes,nan(size(connect_nodes,1),1)];
    edge_list_all(:,end+1:end+size(connect_nodes,1),:) = connect_nodes(:,1:2)';
end

nodesidx = vertcat(nodes.idx);
pos = pt_pos(nodesidx,im_size);
ntot = (1:length(nodesidx))';
node_positions_all = [ntot, pos];

% % move node 1 to node max+1 so that we can use 1 for the source
% node_positions_tmp = node_positions;
% edge_list_tmp = edge_list;
%
% [~,source] = min(pdist2(source_pos,pos_reduced));
% source
% edge_list(edge_list_tmp == 1) = source;
% edge_list(edge_list_tmp == source) = 1;
% 
% node_positions(1,2:end) = node_positions_tmp(source,2:end);
% node_positions(source,2:end) = node_positions_tmp(1,2:end);
end

function [edge_list,node_positions,node_positions_all] = construct_newtork(links,nodes,L,source_position,im_size)
edge_list = [];
node_positions = [];
sauce = double(vertcat(links.n1));
endpt = double(vertcat(links.n2));
edge_list = [sauce, endpt, L];

unodes = double(unique([sauce;endpt]));
node_positions = [unodes, vertcat(nodes.comx), vertcat(nodes.comy), vertcat(nodes.comz)];

% find the pixel along the path closest to the source
nodesidx = vertcat(nodes.idx);
pos = pt_pos(nodesidx,im_size);
ntot = (1:length(nodesidx))';
node_positions_all = [ntot, pos];

[d,mind] = min(pdist2(source_position,pos));
nodesc = nodesidx(mind);
store_links = [];
for i = 1:length(links)
    pts = links(i).point;
    if ismember(nodesc,pts)
        store_links(end+1,:) = [i,links(i).n1,links(i).n2];
    end
end
in = store_links(1,1);

% move node 1 to node max+1 so that we can use 1 for the source
maxnode = max(unodes);
maxnode = maxnode +1;
[r1,c1] = find(edge_list(:,1:2) == 1);
for i = 1:length(r1); edge_list(r1(i),c1(i)) = maxnode; end
node_positions(maxnode,:) = [maxnode, node_positions(1,2:4)];
% add node 1 to nodes
node_positions(1,:) = [1,pos(mind,:)];
% add links and node 1, and break old link
p1 = node_positions(store_links(1,2),2:4);
p2 = node_positions(store_links(1,3),2:4);
edge_list(end+1,:) = [1 store_links(1,2) pdist2(p1,pos(mind,:))];
edge_list(end+1,:) = [1 store_links(1,3) pdist2(p2,pos(mind,:))];
edge_list(in,:) = [];

% % define the node closest to source_position as the source
% [d,mind] = min(pdist2(source_position,node_positions(:,2:4)));
% 
% [r1,c1] = find(edge_list(:,1:2) == 1);
% [rs,cs] = find(edge_list(:,1:2) == mind);
% for i = 1:length(r1); edge_list(r1(i),c1(i)) = mind; end
% for i = 1:length(rs); edge_list(rs(i),cs(i)) = 1; end
% 
% np1 = node_positions(1,2:4);
% node_positions(1,2:4) = node_positions(mind,2:4);
% node_positions(mind,2:4) = np1;
end

%%
function G = plot_graph(edge_list,node_positions,source_node)
m = max(node_positions(:,1));
edge_list(any(isnan(edge_list), 2), :) = m + 1;
% node_positions(any(isnan(node_positions), 2), :) = [];
    G = graph(edge_list(:,1),edge_list(:,2));
    h = plot(G,'layout','layered','NodeLabel',{},'Marker','none','EdgeColor','k');
    layout(h,'layered','sources',source_node);
end

function plot_3d_network(edge_list,node_positions)
hold on
for i=1:length(edge_list(:,1))
    n1 = edge_list(i,1);
    n2 = edge_list(i,2);
    r1 = node_positions(n1,2:4);
    r2 = node_positions(n2,2:4);
%     plot([r1(1) r2(1)],[r1(2) r2(2)],'-k','linewidth',1.5)
    plot3([r1(1) r2(1)],[r1(2) r2(2)],[r1(3) r2(3)],'-k')
end
hold off
end

function plot_graph_v2(edge_list,node_positions)
m = max(node_positions(:,1));
edge_list(any(isnan(edge_list), 2), :) = m + 1;
% node_positions(any(isnan(node_positions), 2), :) = [];
    G = graph(edge_list(:,1),edge_list(:,2));
    plot(G,'XData',node_positions(:,2),'YData',node_positions(:,3),'ZData',node_positions(:,4),'NodeLabel',{},'Marker','none','EdgeColor','k')
end

% function edge_list = find_duct_widths(edge_list,node_positions,dr,width_imgs)
%     edge_list(:,4) = nan;
%     node_positions = round(node_positions);
%     % find subset of ductal nodes to measure width 
%     G = graph(edge_list(:,1),edge_list(:,2));
%     D = degree(G);
%     duct_nodes = find(D == 2); 
%     pos_duct_nodes = node_positions(duct_nodes,:);
%     zposs = unique(pos_duct_nodes(:,4))';
%     % load images
%     info = imfinfo(width_imgs);
%     zposs
%     for im_num = zposs%:num_images%num_images%:-40:1
%         Im = imread(width_imgs, im_num, 'Info', info);
%         % find nodes in zpos
%         ind = find(pos_duct_nodes(:,4) == im_num);
%         for i = 1:length(ind)
%             node = duct_nodes(ind(i));
%             % find values
%             pos = node_positions(node,2:3);
%             width = Im(pos(1),pos(2))*dr(1);
%             % añadir
%             [inode,~] = find(edge_list(:,1:2) == node);
%             edge_list(inode,4) = width;
%         end
%     end
% end

function w = find_duct_widths(Im,inds,dr)
    % load images
%     dr = 4/7
    [LY,LX,LZ] = size(Im);
%     LZ = length(info);
%     LX = info.Width;
%     LY = info.Height; 
    
%     if length(inds)>3
%     n = randperm(length(inds),3);
%     inds = inds(n);
%     end

    [xs,ys,zs] = ind2sub([LY,LX,LZ],inds);
    w = zeros(length(zs),1);
%     info = imfinfo(width_imgs);
    for i = 1:length(zs)%:num_images%num_images%:-40:1
        im_num = zs(i);
%         Im = imread_big(width_imgs, [im_num,im_num]);%, 'Info', info);
%         w(i,1) = Im(xs(i),ys(i)).*dr;
        w(i,1) = Im(xs(i),ys(i),im_num).*dr;
    end
end

function [edge_list,del_nodes] = find_root(edge_list,root_nodes)

del_nodes = [];
G = graph(edge_list(:,1),edge_list(:,2));

for i = 1:(length(root_nodes)-1)
    for j = (i+1):length(root_nodes)
        if all([root_nodes(i),root_nodes(j)]>0)
        P = shortestpath(G,root_nodes(i),root_nodes(j));

        if root_nodes(i) == root_nodes(j)
            disp('root are equal')
        elseif numel(P) < 2
            disp('warning: check roots')
        elseif numel(P) == 2
            disp('warning: roots directly connected')
        elseif numel(P) == 3 
            if not(ismember(P(2),root_nodes))
                del_nodes(end+1)=P(2);
            end
        elseif numel(P) > 3 
            if not(ismember(P(2),root_nodes))
                del_nodes(end+1)=P(2);
            end
            if not(ismember(P(end-1),root_nodes))
                del_nodes(end+1)=P(end-1);
            end
            
        end
        end
    end
end
del_nodes
del_nodes = unique(del_nodes);
[r,c]  = find(any(ismember(edge_list(:,1:2),del_nodes),2));
r = unique(r);
edge_list(r,:) = [];

[p1,p2] = ndgrid(root_nodes,root_nodes);
[r,c]  = find(ismember(edge_list(:,1:2),[p1(:),p2(:)],'rows'));
r = unique(r);
edge_list(r,:) = [];

end

function [edge_list_all,node_positions_all] = construct_newtork_all(links,nodes,im_size,dr)

edge_list_all = [];
node_positions_all = [];
for i =1:length(links)
    pts = links(i).point';
    n1 = links(i).n1;
    n2 = links(i).n2;

    pts(1) = nodes(n1).idx(1); 
    pts(end) = nodes(n2).idx(1);

    edge_list_all = [edge_list_all;pts(1:end-1),pts(2:end)];

    node_positions_all = [node_positions_all;pts];
end
node_positions_all = unique(node_positions_all);
% a = unique(horzcat(links(:).point))';
[x,y,z] = ind2sub(im_size,node_positions_all);
node_positions_all = [node_positions_all,x,y,z];
%     k = find(B == 1);
%     [x,y,z] = ind2sub(size(B),k);
%     ntot = (1:length(x))';
%     node_positions_all = [ntot, x,y,z];
for i = 1:size(edge_list_all,1)
   if isfinite(edge_list_all(i,1))
      n1 = edge_list_all(i,1);
      n2 = edge_list_all(i,2);
      nn1 = find(node_positions_all(:,1)==n1);
      nn2 = find(node_positions_all(:,1)==n2);
      edge_list_all(i,3) = sqrt(sum((dr.*(node_positions_all(nn1,2:4)-node_positions_all(nn2,2:4))).^2));
   end
end
end

function [edge_list_all,node_positions_all,root] = construct_newtork_subtree(links,nodes,sub_nodes,rn,im_size,dr,Im)

root = nodes(rn).idx(1);

edge_list_all = [];
node_positions_all = [];
for i =1:length(links)
    pts = links(i).point';
    n1 = links(i).n1;
    n2 = links(i).n2;
    
    if all(ismember([n1,n2],sub_nodes),2)
    pts(1) = nodes(n1).idx(1); 
    pts(end) = nodes(n2).idx(1);

    w = find_duct_widths(Im,pts,dr);

    edge_list_all = [edge_list_all;pts(1:end-1),pts(2:end),zeros(length(pts(1:end-1)),1),w(2:end)];

    node_positions_all = [node_positions_all;pts];
    end

end
node_positions_all = unique(node_positions_all);
% a = unique(horzcat(links(:).point))';
[x,y,z] = ind2sub(im_size,node_positions_all);
node_positions_all = [node_positions_all,x,y,z];
%     k = find(B == 1);
%     [x,y,z] = ind2sub(size(B),k);
%     ntot = (1:length(x))';
%     node_positions_all = [ntot, x,y,z];
% link length
for i = 1:size(edge_list_all,1)
   if isfinite(edge_list_all(i,1))
      n1 = edge_list_all(i,1);
      n2 = edge_list_all(i,2);
      nn1 = find(node_positions_all(:,1)==n1);
      nn2 = find(node_positions_all(:,1)==n2);
      edge_list_all(i,3) = sqrt(sum((dr.*(node_positions_all(nn1,2:4)-node_positions_all(nn2,2:4))).^2));
   end
end

[edge_list_all,node_positions_all,root] = clean_edge_list(edge_list_all,node_positions_all,root);
end

function [edge_list,node_positions,root] = clean_edge_list(edge_list,node_positions,root)

rootemp = [];
unode = unique(edge_list(:,1:2));
% mem = find(ismember(node_positions(:,1),unode));

[rs,cs] = find(ismember(node_positions(:,1),unode));
node_positions = node_positions(rs,:);

newn = 1:length(unode);
for i = 1:length(unode)
    if node_positions(i) == root
        rootemp = newn(i);
    end
% [rs,cs] = find(edge_list(:,1:2) == node_positions(i));
% edge_list(ind) = newn(i);

[rs,cs] = find(edge_list(:,1:2) == node_positions(i));
for nn = 1:length(rs)
    edge_list(rs(nn),cs(nn)) = newn(i);
end
node_positions(i) = newn(i);
end

if rootemp > 1
[r1,c1] = find(edge_list(:,1:2) == 1);
[rs,cs] = find(edge_list(:,1:2) == rootemp);
for i = 1:length(r1); edge_list(r1(i),c1(i)) = rootemp; end
for i = 1:length(rs); edge_list(rs(i),cs(i)) = 1; end
% 
np1 = node_positions(1,2:4);
node_positions(1,2:4) = node_positions(rootemp,2:4);
node_positions(rootemp,2:4) = np1;
end
root = 1;
end

% % define the node closest to source_position as the source
% [d,mind] = min(pdist2(source_position,node_positions(:,2:4)));
% 
% [r1,c1] = find(edge_list(:,1:2) == 1);
% [rs,cs] = find(edge_list(:,1:2) == mind);
% for i = 1:length(r1); edge_list(r1(i),c1(i)) = mind; end
% for i = 1:length(rs); edge_list(rs(i),cs(i)) = 1; end
% 
% np1 = node_positions(1,2:4);
% node_positions(1,2:4) = node_positions(mind,2:4);
% node_positions(mind,2:4) = np1;

function write_edge_list(fname,filename,branch,edge_list)
fileID = fopen(fname,'w');
fprintf(fileID,['# ',filename,'\n']);
fprintf(fileID,['# ',branch,'\n']);
fprintf(fileID,['# root_node_id = 1\n']);
fprintf(fileID,['# ','source_node target_node length_um diameter_um','\n']);
for i = 1:size(edge_list,1)
  fprintf(fileID,'%d\t%d\t%f\t%f\n', edge_list(i,1),edge_list(i,2),edge_list(i,3),edge_list(i,4));
end
fclose(fileID);
end

function write_node_pos(fname,filename,branch,node_positions)
fileID = fopen(fname,'w');
fprintf(fileID,['# ',filename,'\n']);
fprintf(fileID,['# ',branch,'\n']);
fprintf(fileID,['# root_node_id = 1\n']);
fprintf(fileID,['# ','node_id x_um y_um z_um','\n']);
for i = 1:size(node_positions,1)
  fprintf(fileID,'%d\t%d\t%f\t%f\n', node_positions(i,1),node_positions(i,2),node_positions(i,3),node_positions(i,4));
end
fclose(fileID);
end

function [] = connect_2_nodes(edge_list,node_positions,xyzn1,xyzn2)

[a,n1] = min(pdist2(node_positions(:,[3,2,4]),xyzn1));
[a,n2] = min(pdist2(node_positions(:,[3,2,4]),xyzn2));

end

function [edge_list] = remove_intermediate(edge_list,source_node)

% edge_list(:,3) = 1;

G = graph(edge_list(:,1),edge_list(:,2));
D = degree(G);
D(source_node) = 10; % para ignorar source_node (root)
bidx = find(D==2); % find degree == 2 (these are the intermendiate nodes)

for i = length(bidx):-1:1  
        [r,c] = find(edge_list(:,1:2) == bidx(i));
        if c(1) == 2 
            c1n = 1;
        else
            c1n = 2;
        end
        if c(2) == 2 
            c2n = 1;
        else
            c2n = 2;
        end
        n1new = edge_list(r(1),c1n);
        n2new = edge_list(r(2),c2n);
        lnew = edge_list(r(1),3) + edge_list(r(2),3);

        if numel(edge_list(1,:))==4
            w1new = max([edge_list(r(1),4),edge_list(r(2),4)]);
            edge_list(end+1,:) = [n1new, n2new, lnew, w1new];
        else
            edge_list(end+1,:) = [n1new, n2new, lnew];
        end
        edge_list(r,:) = []; 
end
end

function [edge_list,node_positions,node_association] = remove_intermediate_nodes(edge_list,node_positions,source_node)
%% remove intermediate nodes
extra_nodes = 1;

% [~,dists,~] = node_level(edge_list,node_positions,source_node);

while extra_nodes == 1
    unodes = unique(edge_list(:,1:2));
    unodes = unodes(isfinite(unodes));
    [bcts,idx] = histc([edge_list(:,1);edge_list(:,2)],[min(unodes)-0.5:max(unodes)+0.5]);
    bidx = find(bcts==2); % find degree == 2 (these are the intermendiate nodes)
    bidx(bidx == source_node) = [];
    if numel(bidx)>0
        lidx = bsxfun(@eq,idx,bidx');
        ym = repmat([edge_list(:,1);edge_list(:,2)],size(lidx,1),1);
        out = unique(ym(lidx));
        
        [r,c] = find(edge_list(:,1:2) == out(1));
        if c(1) == 2 
            c1n = 1;
        else
            c1n = 2;
        end
        if c(2) == 2 
            c2n = 1;
        else
            c2n = 2;
        end
        n1new = edge_list(r(1),c1n);
        n2new = edge_list(r(2),c2n);
        dnew = edge_list(r(1),3) + edge_list(r(2),3);

        if numel(edge_list(1,:))==4
            w1new = max([edge_list(r(1),4),edge_list(r(2),4)]);
            edge_list(end+1,:) = [n1new, n2new, dnew, w1new];
        else
            edge_list(end+1,:) = [n1new, n2new, dnew];
        end
        edge_list(r,:) = [];

    else
        extra_nodes = 0;
    end
    
end
end

function connect_nodes = find_closest_node(node_positions_all,yxz1,yxz2,dr)
connect_nodes = [];
for i = 1:size(yxz1,1)
    [~,mind1] = min(pdist2(node_positions_all,yxz1(i,:)));
    n1 = node_positions_all(mind1,1);
    [~,mind2] = min(pdist2(node_positions_all,yxz2(i,:)));
    n2 = node_positions_all(mind2,1);
    d = sqrt(sum((node_positions_all(mind2,:)-node_positions_all(mind1,:)).^2))*dr;
    connect_nodes(i,:) = [n1,n2,d];
end
end

function [A,node,link] = Skel2Graph3D(skel,THR)
% SKEL2GRAPH3D Calculate the network graph of a 3D voxel skeleton
%
% [A,node,link] = SKEL2GRAPH3D(skel,THR)
%
% where "skel" is the input 3D binary image, and "THR" is a threshold for 
% the minimum length of branches. A is the adjacency matrix, and node/link
% are structures describing node and link properties
%
% Philip Kollmannsberger (philipk@gmx.net)
%
% For more information, see <a
% href="matlab:web('http://uk.mathworks.com/matlabcentral/fileexchange/43527-skel2graph-3d')">Skel2Graph3D</a> at the MATLAB File Exchange.

% pad volume with zeros
skel=padarray(skel,[1 1 1]);

% create label matrix for different skeletons
cc_skel=bwconncomp(skel);
lm=labelmatrix(cc_skel);

% image dimensions
w=size(skel,1);
l=size(skel,2);
h=size(skel,3);

% need this for labeling nodes etc.
skel2 = uint16(skel);

% all foreground voxels
list_canal=find(skel);

% 26-nh of all canal voxels
nh = logical(pk_get_nh(skel,list_canal));

% 26-nh indices of all canal voxels
nhi = pk_get_nh_idx(skel,list_canal);

% # of 26-nb of each skel voxel + 1
sum_nh = sum(logical(nh),2);

% all canal voxels with >2 nb are nodes
nodes = list_canal(sum_nh>3);

% all canal voxels with exactly one nb are end nodes
ep = list_canal(sum_nh==2);

% all canal voxels with exactly 2 nb
cans = list_canal(sum_nh==3);

% Nx3 matrix with the 2 nb of each canal voxel
can_nh_idx = pk_get_nh_idx(skel,cans);
can_nh = pk_get_nh(skel,cans);

% remove center of 3x3 cube
can_nh_idx(:,14)=[];
can_nh(:,14)=[];

% keep only the two existing foreground voxels
can_nb = sort(logical(can_nh).*can_nh_idx,2);

% remove zeros
can_nb(:,1:end-2) = [];

% add neighbours to canalicular voxel list (this might include nodes)
cans = [cans can_nb];

% group clusters of node voxels to nodes
node=[];
link=[];

tmp=false(w,l,h);
tmp(nodes)=1;
cc2=bwconncomp(tmp); % number of unique nodes
num_realnodes = cc2.NumObjects;

% create node structure
for i=1:cc2.NumObjects
    node(i).idx = cc2.PixelIdxList{i};
    node(i).links = [];
    node(i).conn = [];
    [x,y,z]=ind2sub([w l h],node(i).idx);
    node(i).comx = mean(x);
    node(i).comy = mean(y);
    node(i).comz = mean(z);
    node(i).ep = 0;
    node(i).label = lm(node(i).idx(1));
   
    % assign index to node voxels
    skel2(node(i).idx) = i+1;
end;

tmp=false(w,l,h);
tmp(ep)=1;
cc3=bwconncomp(tmp); % number of unique nodes

% create node structure
for i=1:cc3.NumObjects
    ni = num_realnodes+i;
    node(ni).idx = cc3.PixelIdxList{i};
    node(ni).links = [];
    node(ni).conn = [];
    [x,y,z]=ind2sub([w l h],node(ni).idx);
    node(ni).comx = mean(x);
    node(ni).comy = mean(y);
    node(ni).comz = mean(z);
    node(ni).ep = 1;
    node(ni).label = lm(node(ni).idx(1));

    % assign index to node voxels
    skel2(node(ni).idx) = ni+1;
end;

l_idx = 1;

c2n=zeros(w*l*h,1);
c2n(cans(:,1))=1:size(cans,1);

s2n=zeros(w*l*h,1);
s2n(nhi(:,14))=1:size(nhi,1);

% visit all nodes
for i=1:length(node)

    % find all canal vox in nb of all node idx
    link_idx = s2n(node(i).idx);
    
    for j=1:length(link_idx)
        % visit all voxels of this node
        
        % all potential unvisited links emanating from this voxel
        link_cands = nhi(link_idx(j),nh(link_idx(j),:)==1);
        
	% short branches that only have an endpoint
        ep_cands = intersect(link_cands,ep);

        link_cands = link_cands(skel2(link_cands)==1);
	link_cands = intersect(link_cands,cans(:,1));
        
        for k=1:length(link_cands)
            [vox,n_idx,ept] = pk_follow_link(skel2,node,i,j,link_cands(k),cans,c2n);
            skel2(vox(2:end-1))=0;
            if((ept && length(vox)>THR) || (~ept && i~=n_idx))
                link(l_idx).n1 = i;
                link(l_idx).n2 = n_idx; % node number
                link(l_idx).point = vox;
                link(l_idx).label = lm(vox(1));
		node(i).links = [node(i).links, l_idx];
                node(i).conn = [int16(node(i).conn), int16(n_idx)];
                node(n_idx).links = [node(n_idx).links, l_idx];
                node(n_idx).conn = [int16(node(n_idx).conn), int16(i)];
                l_idx = l_idx + 1;
            end;
        end;

        if (THR==0) % if short branches allowed
            for k=1:length(ep_cands)
                n_idx = skel2(ep_cands(k))-1;
                if(n_idx && n_idx~=i)
                    skel2(ep_cands(k))=0;
                    link(l_idx).n1 = i;
                    link(l_idx).n2 = n_idx; % node number
                    link(l_idx).point = ep_cands(k);
                    link(l_idx).label = lm(ep_cands(k));
                    node(i).links = [node(i).links, l_idx];
                    node(i).conn = [int16(node(i).conn), int16(n_idx)];
                    node(n_idx).links = [node(n_idx).links, l_idx];
                    node(n_idx).conn = [int16(node(n_idx).conn), int16(i)];
                    l_idx = l_idx + 1;
                end;
            end;
        end;

    end;
        
end;

% mark all 1-nodes as end points
ep_idx = find(cellfun('length',{node.links})==1);
for i=1:length(ep_idx)
    node(ep_idx(i)).ep = 1;    
end;

% number of nodes
n_nodes = length(node);

% initialize matrix
A = zeros(n_nodes);

% for all nodes, make according entries into matrix for all its links
for i=1:n_nodes
    idx1=find(node(i).conn>0);
    idx2=find(node(i).links>0);
    idx=intersect(idx1,idx2);
    for j=1:length(idx) % for all its links
        if(i==link(node(i).links(idx(j))).n1) % if we are the starting point
            A(i,link(node(i).links(idx(j))).n2)=length(link(node(i).links(idx(j))).point);
            A(link(node(i).links(idx(j))).n2,i)=length(link(node(i).links(idx(j))).point);
        end;
        if(i==link(node(i).links(idx(j))).n2) % if we are the end point
            A(i,link(node(i).links(idx(j))).n1)=length(link(node(i).links(idx(j))).point);
            A(link(node(i).links(idx(j))).n1,i)=length(link(node(i).links(idx(j))).point);
        end;
    end;
end;

% convert to sparse
A = sparse(A);

% transform all voxel and position indices back to non-padded coordinates
for i=1:length(node)
    [x,y,z] = ind2sub([w,l,h],node(i).idx);
    node(i).idx = sub2ind([w-2,l-2,h-2],x-1,y-1,z-1);
    node(i).comx = node(i).comx - 1;
    node(i).comy = node(i).comy - 1;
    node(i).comz = node(i).comz - 1;
end;

% transform all link voxel indices back to non-padded coordinates
for i=1:length(link)
    [x,y,z] = ind2sub([w,l,h],link(i).point);
    link(i).point = sub2ind([w-2,l-2,h-2],x-1,y-1,z-1);
end
end

function nhood = pk_get_nh(img,i)

width = size(img,1);
height = size(img,2);
depth = size(img,3);

[x,y,z]=ind2sub([width height depth],i);

nhood = false(length(i),27);

for xx=1:3
    for yy=1:3
        for zz=1:3
            w=sub2ind([3 3 3],xx,yy,zz);
            idx = sub2ind([width height depth],x+xx-2,y+yy-2,z+zz-2);
            nhood(:,w)=img(idx);
        end
    end
end
end

function nhood = pk_get_nh_idx(img,i)

width = size(img,1);
height = size(img,2);
depth = size(img,3);

[x,y,z]=ind2sub([width height depth],i);

nhood = zeros(length(i),27);

for xx=1:3
    for yy=1:3
        for zz=1:3
            w=sub2ind([3 3 3],xx,yy,zz);
            nhood(:,w) = sub2ind([width height depth],x+xx-2,y+yy-2,z+zz-2);
        end
    end
end
end

function [vox,n_idx,ep] = pk_follow_link(skel,node,k,j,idx,cans,c2n)

vox = [];
n_idx = [];
ep = 0;

% assign start node to first voxel
vox(1) = node(k).idx(j);

i=1;
isdone = false;
while(~isdone) % while no node reached
    i=i+1; % next voxel
    next_cand = c2n(idx);
        cand = cans(next_cand,2);
        if(cand==vox(i-1)) % switch direction
            cand = cans(next_cand,3);
        end;
        if(skel(cand)>1) % node found
            vox(i) = idx;
            vox(i+1) = cand; % first node
            n_idx = skel(cand)-1; % node #
            if(node(n_idx).ep)
                ep=1;
            end;
            isdone = 1;
        else % next voxel
            vox(i) = idx;
            idx = cand;
        end
end
end

function [nod_dists_deg,poss] = end_node_level(edge_list,node_positions,source_node) 
G = graph(edge_list(:,1),edge_list(:,2));
nod_dists_deg = [];
poss = [];
D = degree(G);
nodes = find(D==1); nodes(nodes==source_node) = [];
for i = 1:length(nodes)
    nod = nodes(i);
    if isfinite(nod)
    [P,d] = shortestpath(G,source_node,nod);

    nod_dists_deg(i,:) = [nod,d,D(nod)];
    poss(i,:) = node_positions(nod,:);
    else
        dists(i,:) = [nan,nan,nan];
        poss(i,:) = [nan,nan,nan];
    end
end
end

function plot_3d_graph_endnode_level(edge_list,node_positions,nod_dists_deg,poss,dr,root)
m = max(node_positions(:,1));
edge_list(any(isnan(edge_list), 2), :) = m + 1;

% node_positions(any(isnan(node_positions), 2), :) = [];

G = graph(edge_list(:,1),edge_list(:,2),edge_list(:,3),'OmitSelfLoops');

x = node_positions(:,2).*dr(1);
y = node_positions(:,3).*dr(2);
z = node_positions(:,4).*dr(3);

h = plot(G,'XData',x,'YData',y,'ZData',z,'Marker','none','EdgeColor','k');
% h = plot(G);
%      layout(h,'layered','sources',source_node);
highlight(h,root,'Marker','o','NodeColor','k','MarkerSize',3);
hold on
gen = nod_dists_deg(:,2);
% deg = nod_dists_deg(:,3)-1;

mingen = min(gen); maxgen = max(gen);
c = winter(maxgen-mingen+1);
c = c(gen-mingen+1,:);
scatter3(poss(:,2).*dr(1),poss(:,3).*dr(2),poss(:,4).*dr(3),50,c,'filled','MarkerEdgeColor','k')
hold off
c = colorbar;
c.Label.String = 'Generation from root';
caxis([mingen, maxgen]);
% highlight(h,clone_nodes(ind,1),'Marker','o','NodeColor',c(i,:),'MarkerSize',3);
axis equal;
axis tight;
grid on
end

function plot_3d_branching_degree(edge_list,node_positions,dr,root)
m = max(node_positions(:,1));
edge_list(any(isnan(edge_list), 2), :) = m + 1;

% node_positions(any(isnan(node_positions), 2), :) = [];

G = graph(edge_list(:,1),edge_list(:,2),edge_list(:,3),'OmitSelfLoops');
deg=degree(G)
x = node_positions(:,2).*dr(1);
y = node_positions(:,3).*dr(2);
z = node_positions(:,4).*dr(3);

h = plot(G,'XData',x,'YData',y,'ZData',z,'Marker','none','EdgeColor','k');
% h = plot(G);
%      layout(h,'layered','sources',source_node);
highlight(h,root,'Marker','o','NodeColor','k','MarkerSize',3);
hold on
ind = find(deg>2);
deg = deg(ind);
% deg = nod_dists_deg(:,3)-1;

mingen = min(deg); maxgen = max(deg);
c = winter(maxgen-mingen+1);
c = c(deg-mingen+1,:);
scatter3(node_positions(ind,2).*dr(1),node_positions(ind,3).*dr(2),node_positions(ind,4).*dr(3),50,c,'filled','MarkerEdgeColor','k')
hold off
c = colorbar;
c.Label.String = 'Order of branching';
caxis([mingen-1, maxgen-1]);
axis tight;
grid on
% highlight(h,clone_nodes(ind,1),'Marker','o','NodeColor',c(i,:),'MarkerSize',3);
end

function [edge_list,del_endnodes] = generation_dependant_prunning(edge_list,roots,factor)
G = graph(edge_list(:,1),edge_list(:,2));
deg = degree(G);
ind = find(deg==1); 
ind(ismember(ind,roots)) = [];
[r,c] = find(ismember(edge_list(:,1:2),ind));
lengths = edge_list(r,3);
widths = edge_list(r,4);

inds = find(lengths<widths*factor);

del_endnodes = ind(ismember(ind,edge_list(r(inds),1:2)));

edge_list(r(inds),:) = [];
end

function h = plot_3d_graph(edge_list,node_positions,dr,root)
m = max(node_positions(:,1));
edge_list(any(isnan(edge_list), 2), :) = m + 1;

% node_positions(any(isnan(node_positions), 2), :) = [];

G = graph(edge_list(:,1),edge_list(:,2),edge_list(:,3),'OmitSelfLoops');

x = node_positions(:,2).*dr(1);
y = node_positions(:,3).*dr(2);
z = node_positions(:,4).*dr(3);

h = plot(G,'XData',x,'YData',y,'ZData',z,'Marker','none','EdgeColor','k');
% h = plot(G);
%      layout(h,'layered','sources',source_node);
axis equal;
axis tight;
grid on
end
