var Quote = 0;
var Bold  = 0;
var Italic = 0;
var Underline = 0;
var Code = 0;
var Center = 0;
var Strike = 0;
var Sound = 0;
var Swf = 0;
var Ra = 0;
var Rm = 0;
var Marquee = 0;
var Fly = 0;
var fanzi=0;
var text_enter_url      = "????????????ַ";
var text_enter_txt      = "??????????˵??";
var text_enter_image    = "??????ͼƬ??ַ";
var text_enter_sound    = "???????????ļ???ַ";
var text_enter_swf      = "??????FLASH??????ַ";
var text_enter_ra      = "??????Real??????ַ";
var text_enter_rm      = "??????RealӰƬ??ַ";
var text_enter_wmv      = "??????MediaӰƬ??ַ";
var text_enter_wma      = "??????Media??????ַ";
var text_enter_mov      = "??????QuickTime??????ַ";
var text_enter_sw      = "??????shockwave??????ַ";
var text_enter_email    = "???????ʼ???ַ";
var error_no_url        = "????????????ַ";
var error_no_txt        = "??????????˵??";
var error_no_title      = "????????????ҳ????";
var error_no_email      = "???????????ʼ???ַ";
var error_no_gset       = "??????ȷ???ո?ʽ???룡";
var error_no_gtxt       = "???????????֣?";
var text_enter_guang1   = "???ֵĳ??ȡ???ɫ?ͱ߽???С";
var text_enter_guang2   = "Ҫ????Ч???????֣?";
function commentWrite(NewCode) {
document.frmAnnounce.Content.value+=NewCode;
document.frmAnnounce.Content.focus();
return;
}
function storeCaret(text) { 
	if (text.createTextRange) {
		text.caretPos = document.selection.createRange().duplicate();
	}
        if(event.ctrlKey && window.event.keyCode==13){i++;if (i>1) {alert('???????ڷ??????????ĵȴ???');return false;}this.document.form.submit();}
}
function AddText(text) {
	if (document.frmAnnounce.Content.createTextRange && document.frmAnnounce.Content.caretPos) {      
		var caretPos = document.frmAnnounce.Content.caretPos;      
		caretPos.text = caretPos.text.charAt(caretPos.text.length - 1) == ' ' ?
		text + ' ' : text;
	}
	else document.frmAnnounce.Content.value += text;
	document.frmAnnounce.Content.focus(caretPos);
}
function inputs(str)
{
AddText(str);
}
function Curl() {
var FoundErrors = '';
var enterURL   = prompt(text_enter_url, "http://");
var enterTxT   = prompt(text_enter_txt, enterURL);
if (!enterURL)    {
FoundErrors += "\n" + error_no_url;
}
if (!enterTxT)    {
FoundErrors += "\n" + error_no_txt;
}
if (FoundErrors)  {
alert("??????"+FoundErrors);
return;
}
var ToAdd = "[URL="+enterURL+"]"+enterTxT+"[/URL]";
document.frmAnnounce.Content.value+=ToAdd;
document.frmAnnounce.Content.focus();
}
function Cimage() {
var FoundErrors = '';
var enterURL   = prompt(text_enter_image, "http://");
if (!enterURL) {
FoundErrors += "\n" + error_no_url;
}
if (FoundErrors) {
alert("??????"+FoundErrors);
return;
}
var ToAdd = "[IMG]"+enterURL+"[/IMG]";
document.frmAnnounce.Content.value+=ToAdd;
document.frmAnnounce.Content.focus();
}
function Cemail() {
var emailAddress = prompt(text_enter_email,"");
if (!emailAddress) { alert(error_no_email); return; }
var ToAdd = "[EMAIL]"+emailAddress+"[/EMAIL]";
commentWrite(ToAdd);
}
function Ccode() {
if (Code == 0) {
ToAdd = "[CODE]";
document.form.code.value = " ????*";
Code = 1;
} else {
ToAdd = "[/CODE]";
document.form.code.value = " ???? ";
Code = 0;
}
commentWrite(ToAdd);
}
function Cquote() {
fontbegin="[QUOTE]";
fontend="[/QUOTE]";
fontchuli();
}
function Cbold() {
fontbegin="[B]";
fontend="[/B]";
fontchuli();
}
function Citalic() {
fontbegin="[I]";
fontend="[/I]";
fontchuli();
}
function Cunder() {
fontbegin="[U]";
fontend="[/U]";
fontchuli();
}
function Ccenter() {
fontbegin="[center]";
fontend="[/center]";
fontchuli();
}
function Cstrike() {
fontbegin="[strike]";
fontend="[/strike]";
fontchuli();
}
function Csound() {
var FoundErrors = '';
var enterURL   = prompt(text_enter_sound, "http://");
if (!enterURL) {
FoundErrors += "\n" + error_no_url;
}
if (FoundErrors) {
alert("??????"+FoundErrors);
return;
}
var ToAdd = "[SOUND]"+enterURL+"[/SOUND]";
document.frmAnnounce.Content.value+=ToAdd;
document.frmAnnounce.Content.focus();
}

function Cswf() {
var FoundErrors = '';
var enterURL   = prompt(text_enter_swf, "http://");
if (!enterURL) {
FoundErrors += "\n" + error_no_url;
}
if (FoundErrors) {
alert("??????"+FoundErrors);
return;
}
var ToAdd = "[FLASH]"+enterURL+"[/FLASH]";
document.frmAnnounce.Content.value+=ToAdd;
document.frmAnnounce.Content.focus();
}
function Cra() {
var FoundErrors = '';
var enterURL   = prompt(text_enter_ra, "http://");
if (!enterURL) {
FoundErrors += "\n" + error_no_url;
}
if (FoundErrors) {
alert("??????"+FoundErrors);
return;
}
var ToAdd = "[RA]"+enterURL+"[/RA]";
document.frmAnnounce.Content.value+=ToAdd;
document.frmAnnounce.Content.focus();
}
function Crm() {
var FoundErrors = '';
var enterURL   = prompt(text_enter_rm, "http://");
if (!enterURL) {
FoundErrors += "\n" + error_no_url;
}
if (FoundErrors) {
alert("??????"+FoundErrors);
return;
}
var ToAdd = "[RM=500,350]"+enterURL+"[/RM]";
document.frmAnnounce.Content.value+=ToAdd;
document.frmAnnounce.Content.focus();
}
function Cwmv() {
var FoundErrors = '';
var enterURL   = prompt(text_enter_wmv, "http://");
if (!enterURL) {
FoundErrors += "\n" + error_no_url;
}
if (FoundErrors) {
alert("??????"+FoundErrors);
return;
}
var ToAdd = "[MP=500,350]"+enterURL+"[/MP]";
document.frmAnnounce.Content.value+=ToAdd;
document.frmAnnounce.Content.focus();
}

function Cfanzi() {
fontbegin="[xray]";
fontend="[/xray]";
fontchuli();
}

function Cwma() {
var FoundErrors = '';
var enterURL   = prompt(text_enter_wma, "http://");
if (!enterURL) {
FoundErrors += "\n" + error_no_url;
}
if (FoundErrors) {
alert("??????"+FoundErrors);
return;
}
var ToAdd = "[wma]"+enterURL+"[/wma]";
document.frmAnnounce.Content.value+=ToAdd;
document.frmAnnounce.Content.focus();
}
function Cmov() {
var FoundErrors = '';
var enterURL   = prompt(text_enter_mov, "http://");
if (!enterURL) {
FoundErrors += "\n" + error_no_url;
}
if (FoundErrors) {
alert("??????"+FoundErrors);
return;
}
var ToAdd = "[QT=500,350]"+enterURL+"[/QT]";
document.frmAnnounce.Content.value+=ToAdd;
document.frmAnnounce.Content.focus();
}
function Cdir() {
var FoundErrors = '';
var enterURL   = prompt(text_enter_sw, "http://");
if (!enterURL) {
FoundErrors += "\n" + error_no_url;
}
if (FoundErrors) {
alert("??????"+FoundErrors);
return;
}
var ToAdd = "[DIR=500,350]"+enterURL+"[/DIR]";
document.frmAnnounce.Content.value+=ToAdd;
document.frmAnnounce.Content.focus();
}
function Cmarquee() {
fontbegin="[move]";
fontend="[/move]";
fontchuli();
}
function Cfly() {
fontbegin="[fly]";
fontend="[/fly]";
fontchuli();
}

function paste(text) {
	if (opener.document.frmAnnounce.Content.createTextRange && opener.document.frmAnnounce.Content.caretPos) {      
		var caretPos = opener.document.frmAnnounce.Content.caretPos;      
		caretPos.text = caretPos.text.charAt(caretPos.text.length - 1) == ' ' ?
		text + ' ' : text;
	}
	else opener.document.frmAnnounce.Content.value += text;
	opener.document.frmAnnounce.Content.focus(caretPos);
}

function showsize(size){
fontbegin="[size="+size+"]";
fontend="[/size]";
fontchuli();
}

function showfont(font){
fontbegin="[face="+font+"]";
fontend="[/face]";
fontchuli();
}

function showcolor(color){
fontbegin="[color="+color+"]";
fontend="[/color]";
fontchuli();
}

function fontchuli(){
if ((document.selection)&&(document.selection.type == "Text")) {
var range = document.selection.createRange();
var ch_text=range.text;
range.text = fontbegin + ch_text + fontend;
} 
else {
document.frmAnnounce.Content.value=fontbegin+document.frmAnnounce.Content.value+fontend;
document.frmAnnounce.Content.focus();
}
}

function Cguang() {
var FoundErrors = '';
var enterSET   = prompt(text_enter_guang1, "255,red,2");
var enterTxT   = prompt(text_enter_guang2, "????");
if (!enterSET)    {
FoundErrors += "\n" + error_no_gset;
}
if (!enterTxT)    {
FoundErrors += "\n" + error_no_gtxt;
}
if (FoundErrors)  {
alert("??????"+FoundErrors);
return;
}
var ToAdd = "[glow="+enterSET+"]"+enterTxT+"[/glow]";
document.frmAnnounce.Content.value+=ToAdd;
document.frmAnnounce.Content.focus();
}

function Cying() {
var FoundErrors = '';
var enterSET   = prompt(text_enter_guang1, "255,blue,1");
var enterTxT   = prompt(text_enter_guang2, "????");
if (!enterSET)    {
FoundErrors += "\n" + error_no_gset;
}
if (!enterTxT)    {
FoundErrors += "\n" + error_no_gtxt;
}
if (FoundErrors)  {
alert("??????"+FoundErrors);
return;
}
var ToAdd = "[SHADOW="+enterSET+"]"+enterTxT+"[/SHADOW]";
document.frmAnnounce.Content.value+=ToAdd;
document.frmAnnounce.Content.focus();
}

ie = (document.all)? true:false
if (ie){
function ctlent(eventobject){if(event.ctrlKey && window.event.keyCode==13){this.document.frmAnnounce.submit();}}
}
function DoTitle(addTitle) { 
var revisedTitle; 
var currentTitle = document.frmAnnounce.subject.value; 
revisedTitle = currentTitle+addTitle; 
document.frmAnnounce.subject.value=revisedTitle; 
document.frmAnnounce.subject.focus(); 
return; }

function insertsmilie(smilieface){

	document.frmAnnounce.Content.value+=smilieface;
}