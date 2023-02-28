import XMonad

import XMonad.Util.EZConfig
import XMonad.Util.EZConfig
import XMonad.Util.Loggers
import XMonad.Layout.Spiral

import XMonad.Hooks.DynamicLog
import XMonad.Hooks.StatusBar
import XMonad.Hooks.StatusBar.PP
import XMonad.Hooks.EwmhDesktops

import XMonad.Actions.Promote
import XMonad.Actions.CycleWS
import XMonad.Actions.Plane
import Graphics.X11.ExtraTypes.XF86
import Graphics.X11.Xlib.Extras
import XMonad.Layout.Gaps
import Data.Maybe
import qualified XMonad.StackSet as W


import XMonad.Util.Dzen
import XMonad.Prompt
import qualified Data.Map as M
import Data.Monoid
import Data.Word
import XMonad.Util.SpawnOnce

import XMonad.Layout.Spacing
import XMonad.Layout.ThreeColumns
import XMonad.Layout.Grid
import XMonad.Hooks.FadeInactive
import XMonad.Util.Run
import XMonad.Hooks.ManageDocks

colorScheme = "doom-one"

colorBack = "#282c34"
colorFore = "#bbc2cf"

color01 = "#1c1f24"
color02 = "#ff6c6b"
color03 = "#98be65"
color04 = "#da8548"
color05 = "#51afef"
color06 = "#c678dd"
color07 = "#5699af"
color08 = "#202328"
color09 = "#5b6268"
color10 = "#da8548"
color11 = "#4db5bd"
color12 = "#ecbe7b"
color13 = "#3071db"
color14 = "#a9a1e1"
color15 = "#46d9ff"
color16 = "#dfdfdf"

colorTrayer :: String
colorTrayer = "--tint 0x282c34"




windowCount :: X (Maybe String)
windowCount = gets $ Just . show . length . W.integrate' . W.stack . W.workspace . W.current . windowset



myStartupHook :: X ()
myStartupHook = do
  spawn "picom"
  spawn "/usr/bin/emacs --daemon" -- emacs daemon for the emacsclient
  spawn "xsetroot -cursor_name left_ptr"
  spawn "feh --bg-scale --no-fehbg --randomize ~/Pictures/abstractWallpapers/*"
  spawn "xscreensaver -no-splash"
  spawn "volnoti"


myWorkspaces = ["Main","Code","Mail","Conf","Sys","Library","Leisure","Notes","Misc."]
myWorkspaceIndices = M.fromList $ zipWith (,) myWorkspaces [1..] -- (,) == \x y -> (x,y)
clickable ws = "<action=xdotool key super+"++show i++">"++ws++"</action>"
    where i = fromJust $ M.lookup ws myWorkspaceIndices


myLayout = avoidStruts $ tiled ||| Mirror tiled ||| theg ||| Full ||| threeLayout ||| spiral (6/7) ||| Grid ||| spiralGap
  where
    tiled = spacing 35 $ Tall nmaster delta ratio
    theg = gaps [(D,18), (L,23),(U,18), (R,23)] $ Tall 1 (3/100) (1/2)
    threeLayout = ThreeCol 1 (3/100) (1/2)
    nmaster = 1
    ratio = 1/2
    delta = 3/100
    spiralGap = gaps [(D,18), (L,23),(U,18), (R,23)] $ spiral (6/7)



myFocusedBorderColor :: [Char]
myNormalBorderColor :: [Char]

myFocusedBorderColor = color06
myNormalBorderColor  = color11

myConfig = def
    { modMask = mod4Mask
    , terminal = "alacritty"
    , borderWidth = 2
    , normalBorderColor = myNormalBorderColor
    , focusedBorderColor = myFocusedBorderColor
    , startupHook = myStartupHook
    , layoutHook = myLayout
    , workspaces = myWorkspaces
    } `additionalKeys`
    [
       ((0, xF86XK_AudioMute ), spawn "rjc-volnoti-config -m ~/Pictures/bachpic.jpeg" ) --mute
    ,  ((0, xF86XK_AudioLowerVolume), spawn "rjc-volnoti-config -l") -- lower volume
    ,  ((0, xF86XK_AudioRaiseVolume), spawn "rjc-volnoti-config -r") -- raise volume
    ,  ((0, xF86XK_MonBrightnessUp),  spawn "rjc-volnoti-config -b ~/Pictures/brightnessicons/bulb.gif ~/Pictures/brightnessicons/bulb.gif ~/Pictures/brightnessicons/bulb.gif")
    ,  ((0, xF86XK_MonBrightnessDown),  spawn "rjc-volnoti-config -d ~/Pictures/brightnessicons/bulb.gif ~/Pictures/brightnessicons/bulb.gif ~/Pictures/brightnessicons/bulb.gif")
    ,  ((0, xK_Print), spawn "spectacle") --Screen Shot
    ,   ((mod4Mask .|. shiftMask, xK_z), spawn "xscreensaver-command -lock") --Lock Screen
    ,   ((mod4Mask .|. mod1Mask, xK_k), nextWS) --Next Workspace <Super - Alt - k>
    ,   ((mod4Mask .|. mod1Mask, xK_j), prevWS) --Previous Workspace <Super - Alt - j>
    ,   ((mod4Mask .|. shiftMask, xK_slash ), spawn "qutebrowser")
    ,   ((mod4Mask, xK_m), spawn "emacs")
    ,   ((mod4Mask, xK_p), spawn "dmenu_run" )
    ]

main :: IO ()
main = do
    xmonad
        $ docks
        . ewmhFullscreen
        . ewmh
        . withEasySB(statusBarProp "xmobar" (pure  myXmobarPP)) defToggleStrutsKey
        $ myConfig


myXmobarPP :: PP
myXmobarPP = def

  {
     ppSep = "<fc=" ++ color09 ++ ">  <fn=3>- </fn></fc>"
    , ppCurrent         = xmobarColor color06 "" .wrap
      ("<box type=Top width=2 mt=2 color="++color06++">") "</box>"
    , ppHidden          = xmobarColor color05 "" . wrap
      ("<box type=Top width=2 mt=2 color=" ++ color05 ++ ">") "</box>"
    , ppHiddenNoWindows = xmobarColor color16  ""
    , ppExtras          = [windowCount]
    , ppUrgent          = xmobarColor color02 "" . wrap  "!" "!"
    , ppOrder           = \(ws:l:t:ex) -> [ws,l]++ex++[t]
    , ppVisible = xmobarColor color06 ""
    , ppTitle = xmobarColor color16 "" . shorten 30
    }
  where

    -- | Windows should have *some* title, which should not not exceed a
    -- sane length.
    ppWindow :: String -> String
    ppWindow = xmobarRaw . (\w -> if Prelude.null w then "untitled" else w) . shorten 30
