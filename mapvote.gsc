#include maps\mp\_utility;
#include common_scripts\utility;
#include maps\mp\gametypes\_hud_util;

init() {
    precacheshader("gradient_fadein");
    precacheshader("gradient_top");
    precacheshader("white");
    level.mapvotedata[0] = strtok(getdvar("sv_maprotation"), " ")[1];
    level.mapvotedata[1] = strtok("mp_alpha#mp_bootleg#mp_bravo#mp_carbon#mp_dome#mp_exchange#mp_hardhat#mp_interchange#mp_lambeth#mp_mogadishu#mp_paris#mp_plaza2#mp_radar#mp_seatown#mp_underground#mp_village#mp_terminal_cls#mp_rust", "#");
    level.mapvotedata[2] = strtok("European city center. Great for Team \nDefender.#Medium sized Asian market. Fun for all game \nmodes.#African colonial settlement. Fight to control \nthe center.#Medium sized refinery. Great for any number \nof players.#Small outpost in the desert. Fast and frantic \naction.#Urban map with wide streets. Good for long \nand short range fights.#A small construction site. Fast paced, close \nquarter action.#Destroyed freeway. Great for a wide range of \nspaces and styles.#Derelict Russian ghost town. Great for \ncareful, tactical engagements.#Crash site in an African city. Classic urban \ncombat.#Parisian district. Great for Domination and Kill \nConfirmed.#Medium sized German mall. Intense Search & \nDestroy games.#Large Siberian airbase. Great for epic large \nbattles.#A costal town. Narrow streets bring hectic, \nclose encounters.#Small subway station. Fast paced action both \ninside and out.#Large African village. Great for all game \nmodes.#Russian airport terminal under siege. The \nclassic fan favorite is back.#Tiny desert sandstorm. Fast-paced action on \na small map.", "#");
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
    level.mapvoteui[5] = shader("white", "TOP", "TOP", 0, 240, 350, 20, (0.212,0.231,0.220), 1, 1, true);
    level.mapvoteui[6] = shader("white", "TOP", "TOP", 0, 260, 350, 20, (0.180,0.196,0.188), 1, 1, true);
    level.mapvoteui[7] = shader("white", "TOP", "TOP", 0, 280, 350, 20, (0.212,0.231,0.220), 1, 1, true);
    level.mapvoteui[8] = shader("white", "TOP", "TOP", 0, 300, 350, 20, (0.180,0.196,0.188), 1, 1, true);
    level.mapvoteui[9] = shader("white", "TOP", "TOP", 0, 320, 350, 20, (0.157,0.173,.161), 1, 1, true);
    level.mapvoteui[10] = shader("white", "TOP", "TOP", 0, 340, 350, 20, (0.310,0.349,0.275), 1, 1, true);
    level.mapvoteui[11] = shader("gradient_top", "TOP", "TOP", 0, 320, 350, 2, (1,1,1), 1, 2, true);
    level.mapvoteui[12] = text(&"VOTING PHASE: ", "LEFT", "TOP", -170, 130, 1, "hudSmall", (1,1,1), 1, 3, true, 30);
    level.mapvoteui[13] = text(maptostring(level.mapvotedata[1][level.mapvoteindices[0]]), "LEFT", "TOP", -170, 210, 1.5, "normal", (1,1,1), 1, 3, true, 0);
    level.mapvoteui[14] = text(maptostring(level.mapvotedata[1][level.mapvoteindices[1]]), "LEFT", "TOP", -170, 230, 1.5, "normal", (1,1,1), 1, 3, true, 0);
    level.mapvoteui[15] = text(maptostring(level.mapvotedata[1][level.mapvoteindices[2]]), "LEFT", "TOP", -170, 250, 1.5, "normal", (1,1,1), 1, 3, true, 0);
    level.mapvoteui[16] = text(maptostring(level.mapvotedata[1][level.mapvoteindices[3]]), "LEFT", "TOP", -170, 270, 1.5, "normal", (1,1,1), 1, 3, true, 0);
    level.mapvoteui[17] = text(maptostring(level.mapvotedata[1][level.mapvoteindices[4]]), "LEFT", "TOP", -170, 290, 1.5, "normal", (1,1,1), 1, 3, true, 0);
    level.mapvoteui[18] = text(maptostring(level.mapvotedata[1][level.mapvoteindices[5]]), "LEFT", "TOP", -170, 310, 1.5, "normal", (1,1,1), 1, 3, true, 0);
    level.mapvoteui[19] = text("Up ^2[{+attack}] ^7Down ^2[{+speed_throw}]", "LEFT", "TOP", -170, 330, 1.5, "normal", (1,1,1), 1, 3, true);
    level.mapvoteui[20] = text("Vote ^2[{+activate}]", "RIGHT", "TOP", 170, 330, 1.5, "normal", (1,1,1), 1, 3, true);
    foreach(player in level.players) player thread input();
    for(i = 0; i <= 30; i++) {
        level.mapvoteui[12] setvalue(30 - i);
        //playsoundonplayers("trophy_detect_projectile");
        wait 1;
    }
    level notify("mapvote_over");
    setdvar("sv_maprotation", "dsr " + level.mapvotedata[0] + "map " + level.mapvotedata[1][0]);
}

input() {
    self endon("disconnect");
    self endon("mapvote_over");
    index = 0;
    selected = -1;
    select[0] = self text((index + 1) + "/6", "RIGHT", "TOP", 170, 130, 1.5, "normal", (1,1,1), 1, 3, false);
    select[1] = self text(level.mapvotedata[2][level.mapvoteindices[index]], "LEFT", "TOP", -170, 150, 1.5, "normal", (1,1,1), 1, 3, false);
    select[2] = self shader("gradient_fadein", "TOP", "TOP", 0, 200, 350, 20, (1,1,1), 0.5, 2, false);
    select[3] = self shader("gradient_top", "TOP", "TOP", 0, 220, 350, 2, (1,1,1), 1, 2, false);
    self notifyonplayercommand("up", "+attack");
    self notifyonplayercommand("down", "+speed_throw");
    self notifyonplayercommand("select", "+usereload");
    self notifyonplayercommand("select", "+activate");
    for(;;) {
        command = self waittill_any_return("up", "down", "select");
        if(command == "up" && index > 0) {
            index--;
            select[0] settext((index + 1) + "/6");
            select[1] settext(level.mapvotedata[2][level.mapvoteindices[index]]);
            select[2].y -= 20;
            select[3].y -= 20;
            self playlocalsound("mouse_over");
        } else if(command == "down" && index < 5) {
            index++;
            select[0] settext((index + 1) + "/6");
            select[1] settext(level.mapvotedata[2][level.mapvoteindices[index]]);
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
        element = level createserverfontstring(font, fontscale);
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
    element.elemtype = "bar";
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
    for (i = 0; i < 6; i++) {
        array[i] = randomint(level.mapvotedata[1].size);
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
    default: return &"MAP: ";
    }
}
