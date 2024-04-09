# Compare result with other sources

Our script should contain exactly what's being said and done in the movies.

There are a few ways in which we can ensure, the transcribed dialogues and actions are correct.

Especially when it comes to off screen or off camera exclaims from people in the background (like anonymous soldiers in battle scenes), some sources seem to be better suited than others.

## Movies

Obviously the best way to check if the transcription is correct, is to watch the movie in parallel and pay close attention while proof reading the script.

## Subtitles

Subtitles, although not containing speaker information, seem to be correct regarding spelling and order.

I provide a [directory](subtitles) containing two files per movie.
One includes timestamps (`srt`) while the other one doesn't hold any additional meta information but spoken words (`txt`).

## Other sources

You may use other transcriptions and fan-made websites for research purposes and inspiration. You may not copy any content without explicit written permission by the creator of that very content.

The [readme](README.md) contains a few external links.

# General rules

This pseudo-screenplay will be written in spell checked American English in full sentences.

## Things we want to include

* Scene Headings
* Dialogues (incl. character cue)
* Actions

## Things we (currently) don't want to include

At this very stage of the project, we do not want any of the following information in the compiled documents.

* Titles
* Camera angles
* Cutting instructions
* Transitions

Scene headings should be enough to introduce the setting.

Here are a few examples of elements that are not allowed

* `AERIAL SHOT`
* `MONTAGE`
* `ANGLE ON`
* `DISSOLVE TO`
* `CLOSE ON`
* `CUT TO`
* `FADE UP`
* `IMAGE`
* `TEASING SHOTS`
* `SUPER: Lorem ipsum title heading`

The reason for this decision is mainly priority.

Another thing I don't see fitting, is slug lines for sounds.
Just write down what's being heard as a complete sentence.

## Comments and Notes

Do not include any notes or comments yet.
A day may come when we will use them, but it is not this day.
I reserve them for later (to label extended scenes, trivia, ...).

## Punctuation

Every sentence should end with one punctuation mark.
Even strong statements cannot be emphasized with multiple exclamation marks!!!

Parantheses (`()`, `[]`, `<>`, `{}`) are not to be used (explicit exceptions below).

## Spaces, tabs, newlines and invisible characters

At the end of a line, do not use `\r\n` (CRLF) but `\n` (LF) only.

Do not use spaces or tabs to indent any text.
Actually, don't use the tabulator at all.

The only reason to use multiple spaces is to explicitly add a non-breaking line (i.e. empty line), which is only allowed for actions.
Although readability is one requirement for the final document, currently I don't see the necessity to allow for empty lines in dialogues (see below for the acceptable exception in translations).

Do not use paragraphs.

## Dash, hyphen and ellipsis

Stick to [these rules](https://www.grammarbook.com/blog/ellipses/dash-vs-ellipsis/) on when to use dash and when to prefer ellipsis.

Always use a single `-` (hyphen), neither use `—` (em dash), `–` (en dash) nor `--` (double hyphen).

Surround the hyphen character with a space before and after if used as a dash.

```
GOLLUM
He wants it - he needs it!
Sméagol sees it in his eyes. Very soon, he will ask you for it - you will see ... the Fat One will take it from you.
```

Do not use `…` (ellipsis) but instead use `...` (three explicit dots).

We stick to [Robert Bringhurst's Elements of Typographic Style](https://en.wikipedia.org/wiki/The_Elements_of_Typographic_Style) when it comes to ellipses:

* `i ... j`
* `k....`
* `l..., l`
* `l, ... l`
* `m...?`
* `n...!`

## Quotation Marks

Quotations within the movie (e.g. Bilbo writing a book) must be written with double quotes.

Always use `"`, never `„`, `«`, `‟`, `”` or whatever you might think is sensible.

```
[...]

Bilbo turns the title page over to start on a new page. He pauses and takes a puff from his pipe. He dips his pen and resumes his writing.

BILBO
"Concerning Hobbits."

EXT. HOBBITON - DAY

[...]
```

Single quotation marks aka apostrophes are only to be used for Genitive and contractions.

```
Sam smokes his pipe and looks at Rosie behind the bar. She gives him a huge smile.

GAFFER
Far-off tales and children's stories, that's all that is. You're beginning to sound like that old Bilbo Baggins.
Cracked, he was.
```

Always use `'` and nothing else like `’` or `\``.

## Page numbers, page breaks

Do not add page numbers, page breaks (`===`) or other 'meta' information intended for the final document.
The screenplay is build from the sources for different output formats and page layouts.
Explicit page numbering is not necessary.

## Emphasis

Do not use bold, underlined or italic text for anything but the explicitly mentioned special cases (translations, songs, scene headings, ...).
Also, do not use upper case text in actions or dialogues.

Although all of this is common and meaningful in real screenplays (mainly to mark the important bits in a longer sentence), it's not what this project is about.
We don't want to create a realistic movie script.
Instead, our version should emphasize readability.

# Scene Headings

Slug lines are written in all upper case every single time, no exceptions.

This is a scene heading:
`EXT. LOCATION - TIME OF DAY`

At this stage of the project, we only use master scene headings and no subheadings.
Do not use `CONTINUOUS` or `SAME`.

We include all of the following information in every heading, even within a scene and do not omit anything.

## Interior or exterior

`INT.` or `EXT.` determine whether the scene takes place inside (interior) or outside (exterior).

There's no dash after this element, only a space.

We explicitly disallow `INT./EXT.` aka `I./E.`.
As far as I know `INT./EXT.` is used for closed vehicle scenes which are not to be found in LOTR.

`EST` (for establishing shots) may not be used.

As a rule of thumb: Keep it as simple as possible.
We only want the reader to get an idea of the setting.
Atmosphere should be described later.

## Location

This element describes, where the scene takes place.
Don't be overly specific.

A few examples include `ISENGARD`, `OSGILIATH`, `PLAINS OF ROHAN`, `BORDERS OF FANGORN`, `THE DEAD MARSHES`, `PASS OF CARADHRAS`, `WEST BASE OF THE MISTY MOUNTAINS` and `MORIA GATE`.

The location always ends with 'space hyphen space' (` - `).

The location may be refined using a comma.

`INT. FRODO’S BEDROOM, RIVENDELL - DAY`

`EXT. PARTY FIELD, HOBBITON - NIGHT`

`INT. ISENGARD, PALANTÍR CHAMBER - NIGHT`

## Time of day

The last element describes the time of the day.
It may not be used for absolute times or dates.

A few acceptable times include `DAY`, `NIGHT`, `DAWN`, `DUSK`, `EVENING`, `MORNING`, `PREDAWN` and  `AFTERNOON`.

The only exception to this rule is `LATER`, which may be used whenever the location is not changed and the same characters appear in the scene.

## Scene Numbers

If the scene heading is the very first one in a scene, add the scene number accordingly.

`EXT. PLAINS OF ROHAN - DAY #20#`

# Character cue

A character cue describes, who speaks.
It may be a person, the One Ring, an Ent....

## Voiceover, off-screen, off-camera

If the character speaking is physically at the location, but not in the camera's view, he/she is off-screen.

Voiceover is different in such a way that the speaker is not at the scene location but speaks from the outside.

Only use voiceover (`V.O.`) and off-screen (`O.S.`) (with a space after the character and without space between the letters).
Omit off-camera (`O.C.`) completely.

Add this information whenever someone speaks, who is not in frame.

`GANDALF (V.O.)`

It's the first addition after the character.

`THÉODEN (V.O.) (CONT’D)`

## Parentheticals

In most cases, parentheticals describe how a dialogue should be spoken.
Keep them short and do not add `spoken` or any of that kind.
So instead of `(speaking softly)`, just use `softly`.
We already know that someone's going to speak by the character cue.

```
BOROMIR
(softly)
It is a strange fate we should suffer so much fear and doubt ... over so small a thing. Such a little thing.
```

A few examples:
`(quietly)`, `(warningly)`, `(panicked)`, `(lightly)`, `(worried)`, `(angry)`, `(groggy)`, `(yelling)`, `(nervous)`, `(joyous disbelief)`, `(disjointed)`, `(terrified)`, `(alarmed yell)`, `(without surprise)`, `(shrieking)`

Sometimes it is written who is being addressed:
`(to Frodo)`, `(to himself)`, `(to the horsemen)`

Rarely, you may write what takes place while talking.
Only use this form, if the action is directly connected to the thing being said.

```
ÉOWYN (CONT’D)
I’m to be sent with the women into the caves.

ARAGORN
(nodding)
That is an honorable charge.

ÉOWYN
To mind the children, to find food and bedding with the men return. What renown is there in that?
```

These options may also be mixed.
Use a comma if appropriate and start with the mood.

```
PIPPIN
(quietly, to himself)
Aragorn!

UGLÚK
(loudly, to the company)
Let's move!
```

There may be situations in which the mood changes without action or the speaker addresses someone directly.
In that instance, you may add another parenthetical within the dialogue.

```
ÉOWYN
(softly)
The Men have found their Captain - they will follow you into battle, even to death.
(quietly)
You have given us hope.
```

```
ÉOMER
Look for your friends. But do not trust to hope. It has forsaken these lands.
(to the riders)
We ride north!
```

Do not confuse parantheticals with actions.

Instead of writing

```
FRODO
(turning the Ring over and over between his fingers)
Nothing. There's nothing....
```

use this version:

```
Frodo turns the Ring over and over between his fingers.

FRODO
Nothing. There's nothing -
```

# Dialogue

Do not use (forced) empty lines in dialogues.
Only very rarely use newline breaks, if at all.

## (CONT’D)

If a continuous dialogue is interrupted by an action, we manually insert `(CONT'D)` after the character.
Although this information could be added automatically when compiling the final document, I want the source material (i.e. the raw `.fountain` files) to be as readable as possible.

```
ARAGORN
(rises)
If by my life or death, I can protect you, I will.

He approaches Frodo and keels before him.

ARAGORN (CONT'D)
You have my sword.
```

There are certain situations in which a dialogue is not continued, even if the same character speaks.
An action description could lead to a situation change in which a character starts over or changes subject.

The script is compiled automatically to many versions.
There's no need to manually insert `(MORE)` ever.
If a dialogue text is broken into two parts through a page break, `(MORE)` will automatically be added at the end of the page while `CHARACTER (CONT'D)` will be inserted at the very beginning of the next page.

## Foreign languages

In case someone speaks in another language but English, the language has to be added as paranthetical.
If there's hard-coded subtitles in the movie, add `, subtitled` right after the language.

Translations follow in single square brackets with an empty line (`  ` = two spaces) before and after.

```
ARWEN
(Elvish, subtitled)
Frodo, Im Arwen ... Telin let thaed.
  
[I am Arwen. I have come here to help you.]
  
(urgent)
Lasto beth nîn. Tolo dan na ngalad.
  
[Hear my voice. Return to the light.]
```

If the dialogue spans over several lines, add the translation as one block right after them.
Lyrics must not be marked in the translation.

```
ELVES
(Elvish)
~a Galad ren i veniar
~hi' aladhremmin ennorath
~A Elbereth Gilthoniel
~ithil nâ thûl, ithil lîn hen

[O Light to us that wander here
Amid the world of woven trees!
O Elbereth! Gilthoniel!
Clear are thy eyes and bright thy breath!]
```

If the translation is later given within the dialogue itself, it's not necessary to add the translation in the script again.

I thought about using dual dialog option (i.e. left: dialogue, right: translation), but don't like the formatting.

## Poems and Songs

Lyrics are marked with the `~` character at the beginning of every line.
Be informed that lines of poetry each get their own line.

```
PIPPIN
(singing softly)
~Home is behind, the world ahead
~and there are many paths to tread.
~Through shadow to the edge of night
~until the stars are all alight.
~Mist and shadow cloud and shade
~all shall fade, all shall fade.
```

# Action

Sentences must be easy to read and easy to follow.
Try to avoid nested sentences if possible.
Ideally, it doesn't take longer to read what's going on, than to watch it happen in the movie.

Here's a [quick reminder](https://www.studiobinder.com/blog/how-to-write-a-scene-description/) of the important bits in actions.

Character names must not be written in all upper case, even at their first appearance.

Do not reference characters from the dialogue but instead rewrite their name.
It must always be clear who is acting.

```
INT. PUB - DAY

Sauron is drinking a beer alone at the bar.
Suddenly he looks up.

SAURON
(enthusiastically)
Good to see you, old lad!

FRODO (O.S.)
(slightly annoyed)
Oh ... hey there!
```
~~`He`~~ **`FRODO`**` walks over and hugs his former adversary in a constrained way.`

# Special letters (characters)

Use special letters uniformly and always.
Do not mix `Eowyn` and `Èowyn`, but only use the latter option. 

Here are few examples: `Barad-Dûr`, `Déagol`, `Èomer`, `Èowyn`, `Gríma`, `Grishnákh`, `Háma`, `Henneth Annûn`, `Mûmakil`, `Nazgûl`, `Palantír`, `Sméagol`, `Théoden`, `Théodred`, `Uglúk`
