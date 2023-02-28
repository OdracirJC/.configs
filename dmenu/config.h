/* See LICENSE file for copyright and license details. */
/* Default settings; can be overriden by command line. */

static const char Background[] = "#282a36";
static const char CurrentLine[]	="#44475a";
static const char Foreground[]	="#f8f8f2";
static const char Cyan[] = 	"#8be9fd";
static const char Green[] = 	"#50fa7b";
static const char Orange[] = 	"#ffb86c";
static const char Pink[] = 	"#ff79c6";
static const char Purple[] = 	"#bd93f9";
static const char Red[] = 	"#ff5555";
static const char Yellow[] = "#f1fa8c";



/* colorScheme = "doom-one" */

static const char colorBack[] = "#282c34" ;
static const char colorFore[] = "#bbc2cf" ;
static const char color01[] = "#1c1f24" ;
static const char color02[] = "#ff6c6b" ;
static const char color03[] = "#98be65" ;
static const char color04[] = "#da8548";
static const char color05[] = "#51afef";
/* -- color06 = "#c678dd" */
/* -- color07 = "#5699af" */
/* -- color08 = "#202328" */
/* -- color09 = "#5b6268" */
/* -- color10 = "#da8548" */
/* -- color11 = "#4db5bd" */
/* -- color12 = "#ecbe7b" */
/* -- color13 = "#3071db" */
/* -- color14 = "#a9a1e1" */
/* -- color15 = "#46d9ff" */
/* -- color16 = "#dfdfdf" */

/* -- colorTrayer :: String */
/* -- colorTrayer = "--tint 0x282c34" */



static int topbar = 0;                      /* -b  option; if 0, dmenu appears at bottom     */
/* -fn option overrides fonts[0]; default X11 font or font set */
static const char *fonts[] = {
	"monospace:size=12",
	"NotoColorEmoji:pixelsize=8:antialias=true:autohint=true"
};
static const unsigned int bgalpha = 0xAA;
static const unsigned int fgalpha = OPAQUE;
static const char *prompt      =  ">";      /* -p  option; prompt to the left of input field */
static const char *colors[SchemeLast][2] = {
	/*     fg         bg       */
	[SchemeNorm] = {colorFore, colorBack},
	[SchemeSel] = { color03, colorBack },
	[SchemeOut] = { Red, Yellow },
};
static const unsigned int alphas[SchemeLast][2] = {
	/*		fgalpha		bgalphga	*/
	[SchemeNorm] = { fgalpha, bgalpha },
	[SchemeSel] = { fgalpha, bgalpha },
	[SchemeOut] = { fgalpha, bgalpha },
};

/* -l option; if nonzero, dmenu uses vertical list with given number of lines */
static unsigned int lines      = 0;

/*
 * Characters not considered part of a word while deleting words
 * for example: " /?\"&[]"
 */
