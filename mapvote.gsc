#include maps\mp\_utility;
#include common_scripts\utility;
#include maps\mp\gametypes\_hud_util;

init() {
    precacheshader("gradient_fadein");
    precacheshader("gradient_top");
    precacheshader("white");
    // Note set maps in rotation here. Otherwise maps will be displayed as options that can't be played. Only level.mapvotemaps needs to be changed.
    // level.mapvotemaps = strtok("mp_alpha#mp_bootleg#mp_bravo#mp_carbon#mp_dome#mp_exchange#mp_hardhat#mp_interchange#mp_lambeth#mp_mogadishu#mp_paris#mp_plaza2#mp_radar#mp_seatown#mp_underground#mp_village#mp_terminal_cls#mp_rust#mp_highrise#mp_italy#mp_park#mp_overwatch#mp_morningwood#mp_meteora#mp_cement#mp_qadeem#mp_restrepo_ss#mp_hillside_ss#mp_courtyard_ss#mp_aground_ss#mp_six_ss#mp_burn_ss#mp_crosswalk_ss#shipbreaker#mp_roughneck#mp_moab#mp_boardwalk#mp_nola#mp_favela#mp_nuked#mp_nightshift", "#");
    level.mapvotemaps = strtok("mp_alpha#mp_bootleg#mp_bravo#mp_carbon#mp_dome#mp_exchange#mp_hardhat#mp_interchange#mp_lambeth#mp_mogadishu#mp_paris#mp_plaza2#mp_radar#mp_seatown#mp_underground#mp_village#mp_terminal_cls","#");
    level.mapvotedescs = strtok("European city center. Great for Team \nDefender.#Medium sized Asian market. Fun for all game \nmodes.#African colonial settlement. Fight to control \nthe center.#Medium sized refinery. Great for any number \nof players.#Small outpost in the desert. Fast and frantic \naction.#Urban map with wide streets. Good for long \nand short range fights.#A small construction site. Fast paced, close \nquarter action.#Destroyed freeway. Great for a wide range of \nspaces and styles.#Derelict Russian ghost town. Great for \ncareful, tactical engagements.#Crash site in an African city. Classic urban \ncombat.#Parisian district. Great for Domination and Kill \nConfirmed.#Medium sized German mall. Intense Search & \nDestroy games.#Large Siberian airbase. Great for epic large \nbattles.#A costal town. Narrow streets bring hectic, \nclose encounters.#Small subway station. Fast paced action both \ninside and out.#Large African village. Great for all game \nmodes.#Russian airport terminal under siege. The \nclassic fan favorite is back.#Tiny desert sandstorm. Fast-paced action on \na small map.#Classic MW2's Rooftop skyscraper.#A small coastal Italian town. Features tight \nclose quarter combat.#Large New York park set in autumn. Great for \nlong distance fire fights.#Unfinished top of a skyscraper. Features \ntense Demolition matches.#Air Force One crash site. Very open map with a \nfew homes that provide cover.#Greek Monastery on a sandstone pillar. \nFeatures both medium and long range combat.#Korean cement factory. Great for close \nquarter combat and tactical maneuvering.#Luxury resort in Dubai. Features Intense \nDomination maches# Remote outpost in Afghanistan. Tight, Sparse \ninteriors linked by open lanes and overlooks #Upscale beachside retreat. Multi-tiered run \nand gun combat haven. #Roman ruins near Mt. Vesuvius. Strong \ninteriors offset by multi-level flanks.#Shipwreck on the irish coast. Open layout \nallows for long distance engagements#American farm in the path of a monster \ntornado. Sparse interiors and well-defined lanes.#War torn section of mid-east highway. \nPlentiful cover and close quarter fighting#Metro intersection on lockdown. Strong \ninterior locations and tactical urban combat#Ship scavenging operation on the indian \ncoast. Dominant overwatch positions and \n strong flank routes.#Deep Water drilling rig. Medium to long range \nengagements between multi-tiered, joined \nplatforms#Abandoned Utah mining settlement. Features \nan open layout and strong flanks.#Jersey shore amusement boardwalk. \nElevated main path set off by close quarters. \nflanks#New Orleans under assault. Features \nfast-paced matches with abundant close \nquarters fighting.#Alleyways of Brazil. Great for all modes\nand all sizes.#A deserted nuke testing facility used in the Cold War.#Urban City fighting. In and out of apartments/nclose range engagements.", "#");
    level.mapvoteindices = randomindices();
    replacefunc(maps\mp\gametypes\_gamelogic::waittillFinalKillcamDone, ::finalkillcamhook);
}

finalkillcamhook() {
    if (!IsDefined(level.finalkillcam_winner)) {
        mapvote();
        return false;
    } else {
        level waittill("final_killcam_done");
        mapvote();
        return true;
    }
}

mapvote() {
    if (!waslastround()) return;
    level.mapvoteui[0] = shader("white", "TOP", "TOP", 0, 120, 350, 20, (0.157,0.173,0.161), 1, 1, true);
    level.mapvoteui[1] = shader("white", "TOP", "TOP", 0, 140, 350, 60, (0.310,0.349,0.275), 1, 1, true);
    level.mapvoteui[2] = shader("gradient_top", "TOP", "TOP", 0, 140, 350, 2, (1,1,1), 1, 2, true);
    level.mapvoteui[3] = shader("white", "TOP", "TOP", 0, 200, 350, 20, (0.212,0.231,0.220), 1, 1, true);
    level.mapvoteui[4] = shader("white", "TOP", "TOP", 0, 220, 350, 20, (0.180,0.196,0.188), 1, 1, true);
    level.mapvoteui[9] = shader("white", "TOP", "TOP", 0, 240, 350, 20, (0.157,0.173,.161), 1, 1, true);
    level.mapvoteui[10] = shader("white", "TOP", "TOP", 0, 260, 350, 20, (0.310,0.349,0.275), 1, 1, true);
    level.mapvoteui[11] = shader("gradient_top", "TOP", "TOP", 0, 240, 350, 2, (1,1,1), 1, 2, true);
    level.mapvoteui[12] = text(&"VOTING PHASE: ", "LEFT", "TOP", -170, 130, 1, "hudSmall", (1,1,1), 1, 3, true, 30);
    level.mapvoteui[13] = text(maptostring(level.mapvotemaps[level.mapvoteindices[0]]), "LEFT", "TOP", -170, 210, 1.5, "normal", (1,1,1), 1, 3, true, 0);
    level.mapvoteui[14] = text(maptostring(level.mapvotemaps[level.mapvoteindices[1]]), "LEFT", "TOP", -170, 230, 1.5, "normal", (1,1,1), 1, 3, true, 0);
    //TODO: speed_throw/toggleads_throw will show bound/unbound for hold/toggle ads players. compromise may be to use forward/back, depending on how controller
    //bindings handle this.
    level.mapvoteui[19] = text("Move cursor ^2[{+attack}]", "LEFT", "TOP", -170, 250, 1.5, "normal", (1,1,1), 1, 3, true);
    level.mapvoteui[20] = text("Vote ^2[{+activate}]", "RIGHT", "TOP", 170, 250, 1.5, "normal", (1,1,1), 1, 3, true);
    foreach(player in level.players) player thread input();
    for(i = 0; i <= 30; i++) {
        level.mapvoteui[12] setvalue(30 - i);
        //playsoundonplayers("trophy_detect_projectile");
        wait 1;
    }
    level notify("mapvote_over");
    besti = 0;
    bestv = -1;
    for(i = 0; i < 2; i++) {
        if(level.mapvoteui[i + 13].value > bestv) {
            besti = i;
            bestv = level.mapvoteui[i + 13].value;
        }
    }
    //Note: We wait to prevent the scoreboard popping up at the end for a cleaner transition (Don't wait infinitely as a failsafe).
    //TODO: Proper manipulation of sv_maprotation is the better way to do this as it would allow the final scoreboard to show.
    cmdexec("map " + level.mapvotemaps[level.mapvoteindices[besti]]);
    wait 5;
}

input() {
    self endon("disconnect");
    self endon("mapvote_over");
    index = 0;
    selected = -1;
    select[0] = self text((level.mapvoteui[13].value+level.mapvoteui[14].value) + "/" + level.players.size +" votes cast", "RIGHT", "TOP", 170, 130, 1.5, "normal", (1,1,1), 1, 3, false);
    select[1] = self text(level.mapvotedescs[level.mapvoteindices[index]], "LEFT", "TOP", -170, 150, 1.5, "normal", (1,1,1), 1, 3, false);
    select[2] = self shader("gradient_fadein", "TOP", "TOP", 0, 200, 350, 20, (1,1,1), 0.5, 2, false);
    select[3] = self shader("gradient_top", "TOP", "TOP", 0, 220, 350, 2, (1,1,1), 1, 2, false);
    self notifyonplayercommand("up", "+attack");
	self notifyonplayercommand("up", "+forward");
    self notifyonplayercommand("down", "+toggleads_throw");
    self notifyonplayercommand("down", "+speed_throw");
    self notifyonplayercommand("down", "+back");
    self notifyonplayercommand("select", "+usereload");
    self notifyonplayercommand("select", "+activate");
    self notifyonplayercommand("select", "+frag");
    for(;;) {
        command = self waittill_any_return("up", "down", "select");
        if(command != "select" && index == 1) {
            index--;
            select[0] settext((level.mapvoteui[13].value+level.mapvoteui[14].value) + "/" + level.players.size +" votes cast");
            select[1] settext(level.mapvotedescs[level.mapvoteindices[index]]);
            select[2].y -= 20;
            select[3].y -= 20;
            self playlocalsound("mouse_over");
        } else if(command != "select" && index == 0) {
            index++;
            select[0] settext((level.mapvoteui[13].value+level.mapvoteui[14].value) + "/" + level.players.size +" votes cast");
            select[1] settext(level.mapvotedescs[level.mapvoteindices[index]]);
            select[2].y += 20;
            select[3].y += 20;
            self playlocalsound("mouse_over");
        } else if(command == "select") {
            if(selected == -1) {
                selected = index;
                level.mapvoteui[selected + 13].value += 1;
                level.mapvoteui[selected + 13] setvalue(level.mapvoteui[selected + 13].value);
                self playlocalsound("mouse_click");
            } else if(selected != index) {
                level.mapvoteui[selected + 13].value -= 1;
                level.mapvoteui[selected + 13] setvalue(level.mapvoteui[selected + 13].value);
                selected = index;
                level.mapvoteui[selected + 13].value += 1;
                level.mapvoteui[selected + 13] setvalue(level.mapvoteui[selected + 13].value);
                self playlocalsound("mouse_click");
            }
        }
    }
}

text(text, align, relative, x, y, fontscale, font, color, alpha, sort, server, value) {
    element = spawnstruct();
    if(server) {
        element = createserverfontstring(font, fontscale);
    } else {
        element = self createfontstring(font, fontscale);
    }
    if(isdefined(value)) {
        element.label = text;
        element.value = value;
        element setvalue(value);
    } else {
        element settext(text);
    }
    element.hidewheninmenu = true;
    element.color = color;
    element.alpha = alpha;
    element.sort = sort;
    element setpoint(align, relative, x, y);
    return element;
}

shader(shader, align, relative, x, y, width, height, color, alpha, sort, server) {
    element = spawnstruct();
    if(server) {
        element = newhudelem(self);
    } else {
        element = newclienthudelem(self);
    }
    element.elemtype = "icon";
    element.hidewheninmenu = true;
    element.shader = shader;
    element.width = width;
    element.height = height;
    element.align = align;
    element.relative = relative;
    element.xoffset = 0;
    element.yoffset = 0;
    element.children = [];
    element.sort = sort;
    element.color = color;
    element.alpha = alpha;
    element setparent(level.uiparent);
    element setshader(shader, width, height);
    element setpoint(align, relative, x, y);
    return element;
}

randomindices() {
    array = [];
    for (i = 0; i < 2; i++) {
        array[i] = randomint(level.mapvotemaps.size);
        for (j = 0; j < i; j++) {
            if (array[i] == array[j]) {
                i--;
                break;
            }
        }
    }
    return array;
}

maptostring(map) {
    switch(map) {
    case "mp_alpha": return &"LOCKDOWN: ";
    case "mp_bootleg": return &"BOOTLEG: ";
    case "mp_bravo": return &"MISSION: ";
    case "mp_carbon": return &"CARBON: ";
    case "mp_dome": return &"DOME: ";
    case "mp_exchange": return &"DOWNTURN: ";
    case "mp_hardhat": return &"HARDHAT: ";
    case "mp_interchange": return &"INTERCHANGE: ";
    case "mp_lambeth": return &"FALLEN: ";
    case "mp_mogadishu": return &"BAKAARA: ";
    case "mp_paris": return &"RESISTANCE: ";
    case "mp_plaza2": return &"ARKADEN: ";
    case "mp_radar": return &"OUTPOST: ";
    case "mp_seatown": return &"SEATOWN: ";
    case "mp_underground": return &"UNDERGROUND: ";
    case "mp_village": return &"VILLAGE: ";
    case "mp_terminal_cls": return &"TERMINAL: ";
    case "mp_rust": return &"RUST: ";
    case "mp_highrise": return &"HIGHRISE: ";
    case "mp_italy": return &"PIAZZA: ";
    case "mp_park": return &"LIBERATION: ";
    case "mp_overwatch": return &"OVERWATCH: ";
    case "mp_morningwood": return &"BLACK BOX: ";
    case "mp_meteora": return &"SANCTUARY: ";
    case "mp_qadeem": return &"OASIS: ";
    case "mp_restrepo_ss": return &"LOOKOUT: ";
    case "mp_hillside_ss": return &"GETAWAY: ";
    case "mp_courtyard_ss": return &"EROSION: ";
    case "mp_aground_ss": return &"AGROUND: ";
    case "mp_six_ss": return &"VORTEX: ";
    case "mp_burn_ss": return &"U-TURN: ";
    case "mp_crosswalk_ss": return &"INTERSECTION: ";
    case "mp_shipbreaker": return &"DECOMMISSION: ";
    case "mp_roughneck": return &"OFF SHORE: ";
    case "mp_moab": return &"GULCH: ";
    case "mp_boardwalk": return &"BOARDWALK: ";
    case "mp_nola": return &"PARISH: ";
    case "mp_favela": return &"FAVELA: ";
    case "mp_nuked": return &"NUKETOWN: ";
    case "mp_nightshift": return &"SKIDROW: ";
    default: return &"MAP: ";
    }
}
