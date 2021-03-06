import XMonad
import Data.Monoid
import Data.Tree
import System.IO (hPutStrLn)
import System.Exit (exitSuccess)
import XMonad.Actions.GridSelect
import XMonad.Actions.MouseResize
import XMonad.Actions.UpdatePointer
import XMonad.Actions.WithAll (sinkAll)
import XMonad.Actions.CopyWindow (kill1)
import XMonad.Actions.CycleWS (nextScreen, prevScreen)

import XMonad.Hooks.SetWMName
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.FadeInactive
import XMonad.Hooks.InsertPosition
import XMonad.Hooks.WorkspaceHistory
import XMonad.Hooks.ManageHelpers (doFullFloat, isFullscreen)
import XMonad.Hooks.ManageDocks (ToggleStruts (..), avoidStruts, docksEventHook, manageDocks)
import XMonad.Hooks.DynamicLog (PP (..), dynamicLogWithPP, shorten, wrap, xmobarColor, xmobarPP)

import XMonad.Layout.Spacing
import XMonad.Layout.NoBorders
import XMonad.Layout.ShowWName()
import XMonad.Layout.ThreeColumns
import XMonad.Layout.ResizableTile
import XMonad.Layout.SimplestFloat
import XMonad.Layout.LayoutModifier
import XMonad.Layout.GridVariants (Grid (Grid))
import XMonad.Layout.LimitWindows (limitWindows)
import XMonad.Layout.Renamed (Rename (Replace), renamed)
import XMonad.Layout.MultiToggle ((??), EOT (EOT), mkToggle, single)
import XMonad.Layout.WindowArranger (WindowArrangerMsg (..), windowArrange)
import XMonad.Layout.MultiToggle.Instances (StdTransformers (MIRROR, NBFULL, NOBORDERS))
import qualified XMonad.StackSet as W
import qualified XMonad.Layout.MultiToggle as MT (Toggle (..))
import qualified XMonad.Layout.ToggleLayouts as T (ToggleLayout (Toggle), toggleLayouts)

import XMonad.Util.EZConfig (additionalKeysP)
import XMonad.Util.Run (spawnPipe)
import XMonad.Util.SpawnOnce

myModMask = mod4Mask :: KeyMask

myTerminal = "alacritty" :: String
myBrowser = "firefox" :: String
myEditor = "emacsclient -c -a 'emacs'" :: String

myBorderWidth = 2 :: Dimension

myNormColor = "#292d3e" :: String

myFocusColor = "#c792ea" :: String

myFont = "xft:JetBrains Mono Nerd Font Mono:regular:size=9:antialias=true:hinting=true" :: String

windowCount :: X (Maybe String)
windowCount = gets $ Just . show . length . W.integrate' . W.stack . W.workspace . W.current . windowset

mySpacing :: Integer -> l a -> XMonad.Layout.LayoutModifier.ModifiedLayout Spacing l a
mySpacing i = spacingRaw False (Border i i i i) True (Border i i i i) True

-- Single window with no gaps
mySpacing' :: Integer -> l a -> XMonad.Layout.LayoutModifier.ModifiedLayout Spacing l a
mySpacing' i = spacingRaw True (Border i i i i) True (Border i i i i) True

-- Layouts definition

tall = renamed [Replace "tall"]
    $ limitWindows 12
    $ mySpacing 4
    $ ResizableTall 1 (3 / 100) (1 / 2) []

monocle = renamed [Replace "monocle"] $ limitWindows 20 Full

grid = renamed [Replace "grid"]
    $ limitWindows 12
    $ mySpacing 4
    $ mkToggle (single MIRROR)
    $ Grid (16 / 10)

threeCol = renamed [Replace "threeCol"]
    $ limitWindows 7
    $ mySpacing' 4
    $ ThreeCol 1 (3 / 100) (1 / 3)

floats = renamed [Replace "floats"] $ limitWindows 20 simplestFloat

-- Layout hook

myLayoutHook = avoidStruts
    $ smartBorders
    $ mouseResize
    $ windowArrange
    $ T.toggleLayouts floats
    $ mkToggle (NBFULL ?? NOBORDERS ?? EOT) myDefaultLayout
  where
    myDefaultLayout =
        noBorders monocle
        ||| tall
        ||| threeCol
        ||| grid

xmobarEscape :: String -> String
xmobarEscape = concatMap doubleLts
  where
    doubleLts '<' = "<<"
    doubleLts x = [x]

myColorizer :: Window -> Bool -> X (String, String)
myColorizer = colorRangeFromClassName
                  (0x28,0x2c,0x34) -- lowest inactive bg
                  (0x28,0x2c,0x34) -- highest inactive bg
                  (0xc7,0x92,0xea) -- active bg
                  (0xc0,0xa7,0x9a) -- inactive fg
                  (0x28,0x2c,0x34) -- active fg

-- gridSelect menu layout
mygridConfig :: p -> GSConfig Window
mygridConfig colorizer = (buildDefaultGSConfig myColorizer)
    { gs_cellheight   = 40
    , gs_cellwidth    = 200
    , gs_cellpadding  = 6
    , gs_originFractX = 0.5
    , gs_originFractY = 0.5
    , gs_font         = myFont
    }

spawnSelected' :: [(String, String)] -> X ()
spawnSelected' lst = gridselect conf lst >>= flip whenJust spawn
    where conf = def
                   { gs_cellheight   = 40
                   , gs_cellwidth    = 200
                   , gs_cellpadding  = 6
                   , gs_originFractX = 0.5
                   , gs_originFractY = 0.5
                   , gs_font         = myFont
                   }

myAppGrid = [ ("Neovim", "alacritty nvim")
                 , ("Alacritty", "kitty")
                 , ("St", "st")
                 , ("Emacs", "emacsclient -c -a emacs")
                 , ("Firefox", "firefox")
                 , ("Neovim", "alacritty -e nvim")
                 , ("PCManFM", "pcmanfm")
                 , ("PavuControl", "pavucontrol")
                 , ("BleachBit", "bleachbit")
                 ]

myWorkspaces :: [String]
myWorkspaces = clickable . (map xmobarEscape)
--          ???           ???          ???         ???           ???          ???          ???          ???          ???
    -- $ ["\xf269 ", "\xe61f ", "\xe795 ", "\xf121 ", "\xf419 ", "\xf308 ", "\xf74a ", "\xf7e8 ", "\xf827 "]
    $ ["dev", "www", "cmd", "ref", "git", "vid", "fs", "gfx", "mis"]
  where
    clickable l = ["<action=xdotool key super+" ++ show (i) ++ "> " ++ ws ++ "</action>" | (i, ws) <- zip [1 .. 9] l]

myManageHook :: XMonad.Query (Data.Monoid.Endo WindowSet)
myManageHook = composeAll
     -- 'doFloat' forces a window to float.  Useful for dialog boxes and such.
     -- using 'doShift ( myWorkspaces !! 7)' sends program to workspace 8!
     -- I'm doing it this way because otherwise I would have to write out the full
     -- name of my workspaces and the names would be very long if using clickable workspaces.
     [ className =? "confirm"         --> doFloat
     , className =? "file_progress"   --> doFloat
     , className =? "yad"             --> doFloat
     , className =? "download"        --> doFloat
     , className =? "error"           --> doFloat
     , className =? "pavucontrol"     --> doFloat
     , className =? "notification"    --> doFloat
     , className =? "pinentry-gtk-2"  --> doFloat
     , className =? "splash"          --> doFloat
     , className =? "toolbar"         --> doFloat
     , className =? "Alacritty"   --> doShift ( myWorkspaces !! 0 )
     , className =? "firefox"     --> doShift ( myWorkspaces !! 1 )
     , isFullscreen -->  doFullFloat
     ]

myKeys :: [(String, X ())]
myKeys =
    [
    ------------------ Window configs ------------------

    -- Move focus to the next window
    ("M-j", windows W.focusDown),
    -- Move focus to the previous window
    ("M-k", windows W.focusUp),
    -- Swap focused window with next window
    ("M-S-j", windows W.swapDown),
    -- Swap focused window with prev window
    ("M-S-k", windows W.swapUp),
    -- Kill window
    ("M-q", kill1),
    -- Restart xmonad
    ("M-S-r", spawn "xmonad --restart"),
    -- Quit xmonad
    ("M-S-q", io exitSuccess),

    ----------------- Floating windows -----------------

    -- Toggles 'floats' layout
    ("M-f", sendMessage (T.Toggle "floats")),
    -- Push floating window back to tile
    ("M-S-f", withFocused $ windows . W.sink),

    ---------------------- Layouts ----------------------

    -- Switch to next layout
    ("M-<Tab>", sendMessage NextLayout),
    -- Toggles noborder/full
    ("M-<Space>", sendMessage (MT.Toggle NBFULL) >> sendMessage ToggleStruts),
    -- Shrink vertical window width
    ("M-C-j", sendMessage MirrorShrink),
    -- Exoand vertical window width
    ("M-C-k", sendMessage MirrorExpand),

    ---------------------- GridSelect ----------------------
        -- Grid Select (CTR-g followed by a key)
    ("C-g g", spawnSelected' myAppGrid),                 -- grid select favorite apps
    ("C-g t", goToSelected $ mygridConfig myColorizer),  -- goto selected window
    ("C-g b", bringSelected $ mygridConfig myColorizer), -- bring selected window

-------------------- App configs --------------------

   -- Terminal
   ("M-<Return>", spawn myTerminal),
   -- Browser
   ("M-w", spawn myBrowser),
   -- Menu
   ("M-e", spawn myEditor),
   -- File explorer
   ("M-n", spawn "pcmanfm"),
   -- Scrot
   ("M-s", spawn "scrot"),

   -------------------- Dmenu and Scripts --------------------
   -- Dmenu Run
   ("M-d", spawn "dmenu_run -nb '#070E11' -nf '#dfc4cd' -sb '#35638A' -sf '#dfc4cd'"),
   -- Dmenu Conf Editor
   ("M-c", spawn ".local/bin/dm-confedit"),
   -- Dmenu Logout
   ("M-x", spawn ".local/bin/dm-logout"),
   -- Dmenu Program Killer
   ("M-p", spawn ".local/bin/dm-kill"),
   -- Dmenu Recorder
   ("M-r", spawn ".local/bin/dm-record"),
   -- Dmenu Music Player
   ("M-m", spawn ".local/bin/dm-sounds"),
   -- Dmenu Book Menu 
   ("M-b", spawn ".local/bin/dm-bookman"),
   -- Dmenu wifi menu
   ("M-S-w", spawn ".local/bin/dm-wifi"),
   -- Dmenu todo menu
   ("M-o", spawn ".local/bin/todo"),
   -- Dmenu pass menu
   ("M-S-p", spawn "passmenu"),
   --------------------- Hardware ---------------------
   -- Volume
   ("<XF86AudioLowerVolume>", spawn "pactl set-sink-volume @DEFAULT_SINK@ -5%"),
   ("<XF86AudioRaiseVolume>", spawn "pactl set-sink-volume @DEFAULT_SINK@ +5%"),
   ("<XF86AudioMute>", spawn "pactl set-sink-mute @DEFAULT_SINK@ toggle" ),

-- Brightness
   ("<XF86MonBrightnessUp>", spawn "xbacklight -inc 5%"),
   ("<XF86MonBrightnessDown>", spawn "xbacklight -dec 5%")
   ]

myStartupHook :: X ()
myStartupHook = do
    spawnOnce "picom &"
    spawnOnce "/usr/bin/dunst"
    spawnOnce "emacs --daemon"
    spawnOnce "xwallpaper --zoom /usr/share/backgrounds/wallpapers/0031.jpg"
    spawnOnce "/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1"
    setWMName "LG3D"

main :: IO ()
main = do
    -- Xmobar
    xmobarLaptop <- spawnPipe "xmobar -x 0 ~/.config/xmobar/xmobarrc"
    -- Xmonad
    xmonad $ ewmh def {
      --manageHook = (isFullscreen --> doFullFloat) <+> manageDocks <+> insertPosition Below Newer,
        manageHook = myManageHook <+> manageDocks,
        handleEventHook = docksEventHook,
        modMask = myModMask,
        terminal = myTerminal,
        startupHook = myStartupHook,
        layoutHook = myLayoutHook,
        workspaces = myWorkspaces,
        borderWidth = myBorderWidth,
        normalBorderColor = myNormColor,
        focusedBorderColor = myFocusColor,
        -- Log hook
        logHook = workspaceHistoryHook <+> dynamicLogWithPP xmobarPP {
            ppOutput = \x -> hPutStrLn xmobarLaptop x ,
            -- Current workspace in xmobar
            ppCurrent = xmobarColor "#c3e88d" "" . wrap "[" " ]",
            -- Visible but not current workspace
            ppVisible = xmobarColor "#c3e88d" "",
            -- Hidden workspaces in xmobar
            ppHidden = xmobarColor "#82AAFF" "",
            -- Hidden workspaces (no windows)
            ppHiddenNoWindows = xmobarColor "#c792ea" "",
            -- Title of active window in xmobar
            ppTitle = xmobarColor "#6272a4" "" . shorten 55,
            -- Separators in xmobar
            ppSep = "<fc=#666666> | </fc>",
            -- Urgent workspace
            ppUrgent = xmobarColor "#C45500" "" . wrap "" "!",
            -- Number of windows in current workspace
            ppExtras = [windowCount],
            ppOrder = \(ws : l : t : ex) -> [ws, l] ++ ex ++ [t]
        } >> updatePointer (0.5, 0.5) (0.5, 0.5)
} `additionalKeysP` myKeys
