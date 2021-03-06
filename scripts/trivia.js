// Description:
//   Trollcho wants you to answer his questions about Bulgarian poetry,
//   music and more.
//
// Dependencies:
//
// Configuration:
//   None
//
// Commands:
//   питай ме - Make trollcho ask you a question
//
// Author:
//   ydm

/*jslint vars:true */

'use strict';

///////////////
// Questions //
///////////////

var answerRe = /^[А-Яа-я0-9_\s]+$/;
var questionTypes = [
    "Кой е написал",
    "Кой е казал",
    "Коя група пее",
    'От кое стихотвореине е',
    'От кое произведение е',
];
var questions = [
    [0, 'Ботев', '...а вий, вий сте идиоти!'],
    [0, 'Ботев', 'В тъги, в неволи младост минува, / кръвта се ядно в жили вълнува...'],
    [0, 'Вапцаров', 'За него – Живота – направил бих взичко. / Летлял бих със пробна машина в небето,\nбих влезнал във взривна ракета самичък, / бих търсил в простора далечна планета.'],
    [0, 'Вапцаров', 'Понякога ще идвам във съня ти / като нечакан и неискан гостенин.'],
    [0, 'Вапцаров', 'Притихва последната нота / на този миньорен пасаж.\nТи още живееш със своя / далечен, изгубен мираж.'],
    [0, 'Гео Милев', 'Данте беше andante: / страх и терор без надежда. / Ний сме presto.'],
    [0, 'Гео Милев', 'Кажи: разбираш ли лъжата / на тия гибелни мечти?\n–А, истината и лъжата / са кръг – и в него кръг си ти!'],
    [0, 'Далчев', 'Над старото тържище ален / бе залезът като домат / и все тъй строен, все тъй млад / стоеше бедният хамалин.'],
    [0, 'Далчев', 'Не съм те никога избирал на земята. / Родих се просто в теб на юнски ден във зноя.\nАз те обичам не защото си богата, / а само за това, че си родина моя.'],
    [0, 'Смирненски', '...и през сълзи и кървав гнет, / през ужаса на мрак студен\nразбунен вик гърми навред: / "Да бъде ден, да бъде ден!'],
    [0, 'Смирненски', '...покани ме Дявола – старият Дявол – / дома си на чашка абсент.'],
    [0, 'Смирненски', 'Аз не зная защо съм на тоз свят роден, / не попитах защо ще умра...'],
    [0, 'Смирненски', 'Като черна гробница и тази вечер / пуст и мрачен е градът...'],
    [1, 'Вапцаров', 'Зная свойто място / във живота / и напразно / няма да се дам.\nЧестно ще умра като / работинк / в боя ни / за хляб и свобода.'],
    [2, 'Кокоша глава', 'Искам да направя магамагазин, в него да продавам херохероин.'],
    [2, 'Уикеда', 'Там, където няма роби, няма и господари.'],
    [2, 'Хиподил', 'Възбуден съм като шишарка...'],
    [2, 'Хиподил', 'Колко ти струва да праснеш момиче отзад?'],
    [3, 'Писмо', 'За мен е ясно както, че ще съмне – / с главите си ще счупим ледовете.\nИ слънцето на хоризонта тъмен, / да, нашто ярко слънце ще просветне.'],
    [3, 'Пристанала', '...храни, горо, таквиз чеда, / дорде слънце в светът гледа;\nдорде птичка в тебе пее, / тоз байряк да се ветрее!'],
    [3, 'Септември', 'Нощта ражда из мъртва утроба / вековната злоба на роба...'],
    [3, 'Хаджи Димитър', '...жътварка пее нейде в полето\nи кръвта още по–силно тече!'],
    [3, 'Хаджи Димитър', 'Настане месец, вечер изгрее, / звезди обсипят сводът небесен;\nгора зашуми, вятър повее, – / Балканът пее хайдушка песен!'],
    [4, 'Огледалото на свети Христофор', 'Очистих се, защото направих добро на най–лошия.'],
    [4, 'Огледалото на свети Христофор', 'Тогава песоглавецът... напусна родния си град, за чието добро така неуморно се бе борил.'],
    [4, 'По жицата', 'Боже, колко мъка има по тоя свят, боже!'],
    [4, 'Приказка за стълбата', 'Аз съм плебей по рождение и всички дрипльовци са мои братя! О, колко е грозна земята и колко са нещастни хората!'],
    [4, 'Приказка за стълбата', 'Аз съм принц по рождение и боговете ми са братя! О, колко красива е земята и колко са щастливи хората!'],
];


////////////
// Trivia //
////////////

var currentQuestion = null;

var ask = function (msg) {
    var question = msg.random(questions);
    msg.reply(questionTypes[question[0]] + ' ' + '"' + question[2] + '"?');
    currentQuestion = question;
};

var answer = function (msg) {
    if (currentQuestion === null) {
        return;
    }
    if (msg.match[0] === currentQuestion[1]) {
        currentQuestion = null;
        msg.reply('правилно!');
    }
};


//////////////////////
// Message handling //
//////////////////////

module.exports = function (robot) {
    robot.hear('^питай ме$', ask);
    robot.hear(answerRe, answer);
};
