// Holocure Tower of Suffering Autosplitter (1.70)
// by Adesi

state("HoloCure","1.70")
{
    double JumpProgress : "HoloCure.exe", 0x052DF510,0x20,0x50,0xA8,0x138,0x18,0x28,0x610,0x0,0x50,0x19E0;
    double TimeS : "HoloCure.exe", 0x050B5980, 0x1B8,0x0,0x0,0x6D8,0x40,0x30,0x0,0x88,0x8,0x20;
    double TimeM : "HoloCure.exe", 0x050B5980, 0x1B8,0x10,0x90,0x0,0x0,0x1B8,0x18,0x10,0x8,0x10;
    double TimeH : "HoloCure.exe", 0x050B5980, 0x1B8,0x0,0x0,0x580,0x20,0x58,0x50,0x8,0x0;

    float PosY : "HoloCure.exe",0x052CE540,0x490,0x318,0xB8,0xB0,0x2F0,0x70,0x10,0xF8;
    float PosX : "HoloCure.exe",0x04EE2668,0x80,0x180,0x20,0x98,0x108,0x70,0x10,0xF4;
}

init
{
    version = "1.70";
    refreshRate = 30;

    vars.coldstart = true;
    vars.HasReset = false;
    current.kfp = false;
    current.statues = false;
    current.prison = false;
    current.tummy = false;
    current.jungle = false;
    current.jungletree = false;
    current.castle = false;
    current.finaltower = false;
    current.time = false;

    int size = modules.First().ModuleMemorySize;
    //print("Holocure Tower of Suffering Autosplitter\nVersion: " + version + "\nMemory size: " + size.ToString());
    if(size == 91324416)
        version = "1.70";
    else
    {
        print("Autosplitter Warning: Incompatible game version\nMemory size: " + size.ToString());
        return false;
    }

    print("Holocure Tower of Suffering Autosplitter\nVersion: " + version + "\nMemory size: " + size.ToString());
}


update
{
    if (version == "") return false;
    //print("PlayerObject:"+current.PosX+","+current.PosY +"\n" + "JumpProgress:" + current.JumpProgress); // uncomment this to print the current position in dbgview
    return true;
}

gameTime
{
    if(old.TimeS != current.TimeS || old.TimeM != current.TimeM || old.TimeH != current.TimeH){
        return TimeSpan.FromSeconds(current.TimeH*3600 + current.TimeM*60 + current.TimeS);
    }
}
reset
{
    if(current.PosX == 112 && current.PosY == 15840 && (old.PosX != 112 || old.PosY != 15840) && (current.TimeS <= 0 || current.TimeM <= 0 || current.TimeH <= 0) && (old.TimeS >= 0 || old.TimeM >= 0 || old.TimeH >= 0) && vars.HasReset == false){
        vars.HasReset = true;
        return true;
    }
    return false;
}
split
{
    if(!current.kfp && current.PosY <= 14400 && current.PosX >= 200)
    {
        current.kfp = true;
        return true;
    }
    if(!current.statues && current.PosY <= 13456 && current.PosX <= 420)
    {
        current.statues = true;
        return true;
    }
    if(!current.prison && current.PosY <= 11980)
    {
        current.prison = true;
        return true;
    }
    if(!current.tummy && current.PosY <= 11344)
    {
        current.tummy = true;
        return true;
    }
    if(!current.jungle && current.PosY <= 8500 && current.PosX >= 300)
    {
        current.jungle = true;
        return true;
    }
    if(!current.jungletree && current.PosY <= 7400 && current.PosX <= 414)
    {
        current.jungletree = true;
        return true;
    }
    if(!current.castle && current.PosY <= 3584 && current.PosX <= 230)
    {
        current.castle = true;
        return true;
    }
    if(!current.finaltower && current.PosY <= 2624)
    {
        current.finaltower = true;
        return true;
    }
    if(!current.time && current.PosY <= 1040)
    {
        current.time = true;
        return true;
    }
}

// My Chosen Splits:
// Start: posx == 112, posy == 15840
// -----------------------------------------------------------------------------
// KFP Store: 10% , posy<= 14400, posx >= 200
// Three Statues: 17%, posy <= 13456, posx <= 420
// Prison: 27%, posy <= 11980
// Tummy: 31%, posy <= 11344
// Jungle: 50%, posy <= 8500, posx >= 300
// Jungle Tree: 64%, posy <= 6400, posx <= 360
// Castle: 83%, posy <= 3584, posx <= 230
// Final Tower: 90%, posy <= 2624
// Time: 100%, posy <= 1040
// -----------------------------------------------------------------------------


start
{
    current.kfp = false;
    current.statues = false;
    current.prison = false;
    current.tummy = false;
    current.jungle = false;
    current.jungletree = false;
    current.castle = false;
    current.finaltower = false;
    current.time = false;

    current.GameTime = TimeSpan.Zero;
    if(vars.HasReset && current.PosX == 112 && current.PosY == 15840 && (current.TimeS <= 0 || current.TimeM <= 0 || current.TimeH <= 0) && (old.TimeS >= 0 || old.TimeM >= 0 || old.TimeH >= 0)){
        vars.HasReset = false;
        return true;
    }else {
        return current.PosX == 112 && current.PosY == 15840;
    }
}