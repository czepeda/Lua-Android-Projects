--
-- Created by IntelliJ IDEA.
-- User: paulolpnet
-- Date: 18/07/12
-- Time: 11:16
-- To change this template use File | Settings | File Templates.
--
 
module( ..., package.seeall )
 
function rateThis(params)
    local thisRate = ice:loadBox( "myRate" );
    local time = thisRate:retrieve( "time" );
    -- IF YOU RESET THE CODE UNCOMMENT THE CODE BELLOW
    --thisRate:store("time",nil);
    --thisRate:save();
    if time == nil  then
        -- FIRST TIME ENTERING YOUR APP
        time =1;
        thisRate:store("time",time);
        thisRate:save();
        return true;
    elseif time == 5 then
        -- THE USER DO NOT WANT TO RATE YOUR APP OR HE ALREADY MADE
        return true;
    elseif time == 1 then
        -- IF TIME == 2 W8 FOR THE NEXT TIME
        time = time+1
        thisRate:store("time",time);
        thisRate:save();
        return true;
    elseif time == 2 then
        -- IF TIME == 2 W8 FOR THE NEXT TIME
        time = time+1
        thisRate:store("time",time);
        thisRate:save();
        return true;
    elseif time == 3 then
        -- IF TIME == 3 CALL THE VOTE;
        local androidID,iosID;
        if params.android ~= nil then
            androidID = params.android;
        else
            androidID = "NO_ANDROID_ID";
            print("######## NO ANDROID ID");
        end
        if params.ios ~= nil then
 
            iosID = params.ios
        else
            iosID = "NO_IOS_ID";
            print("######## NO IOs ID");
        end
        -- MAKING THE URLS
        local AppleURL
        local AndroidURL
        AppleURL = "itms-apps://ax.itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?type=Purple+Software&id="..iosID;
        AndroidURL = "market://details?id="..androidID;
 
        -- EVENT NATIVE ALERT FOR IOS
        local function votariphone( event )
            if "clicked" == event.action then
                local i = event.index
                if 1 == i then
                    system.openURL(AppleURL);
                    time = 5
                    thisRate:store("time",time);
                    thisRate:save();
                elseif 2 == i then
                    time = 1
                    thisRate:store("time",time);
                    thisRate:save();
                elseif 3 ==i then
                    time = 5
                    thisRate:store("time",time);
                    thisRate:save();
                end
            end
        end
        -- EVENT NATIVE ALERT FOR ANDROID
        local function votarandroid( event )
            if "clicked" == event.action then
                local i = event.index
                if 1 == i then
                    system.openURL(AndroidURL);
                    time = 5
                    thisRate:store("time",time);
                    thisRate:save();
                elseif 2 == i then
                    time = 1
                    thisRate:store("time",time);
                    thisRate:save();
                elseif 3 ==i then
                    time = 5
                    thisRate:store("time",time);
                    thisRate:save();
                end
            end
        end
        local platform = system.getInfo("platformName")
 
        if platform == "iPhone OS" then
            -- THIS IS THE NATIVE ALERT FOR IPHONE
            -- YOU SHOULD CHANGE THE TEXT FOR THE WAY YOU LIKE THE MOST.
            native.showAlert("Would you like to Rate this app?" , "I would greatly appreciate some Feedback!",
                { "OK", "Rate Later", "Don't Rate" }, votariphone )
        
        elseif platform == "Android" then
            -- THIS IS THE NATIVE ALERT FOR ANDROID
            -- YOU SHOULD CHANGE THE TEXT FOR THE WAY YOU LIKE THE MOST.
            native.showAlert("Would you like to Rate this app?" , "I would greatly appreciate some Feedback!",
                { "OK", "Rate Later", "Don't Rate" }, votarandroid )
        else
            -- THIS IS FOR TEST ON YOUR PC OR MAC
            -- YOU SHOULD CHANGE THE TEXT FOR THE WAY YOU LIKE THE MOST.
            native.showAlert("Would you like to Rate this app?" , "I would greatly appreciate some Feedback!",
                { "OK", "Rate Later", "Don't Rate" }, votariphone )
 
        end
    end
 
 
 
end