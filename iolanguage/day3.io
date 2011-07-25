f := File with("phonebook.txt")
f remove
f openForUpdating
f write("\"Bob Smith\": \"5195551212\"\n")
f write("\"Mary Walsh\": \"4162223434\"")
f close

OperatorTable addAssignOperator(":", "atPutNumber")
Object curlyBrackets := method(
  r := Map clone
  call message arguments foreach(arg,
    r doMessage(arg)
  )
)
Object atPutNumber := method(x,y,
  Map atPut(x asMutable removePrefix("\"") removeSuffix("\""),y)//asMutableは文字列を変更可能にする
)
s := File with("phonebook.txt") openForReading contents
phoneNumbers := doString(s)
phoneNumbers keys println
phoneNumbers values println

Builder := Object clone
Builder forward := method(
  writeln("<" , call message name, ">" )
  call message arguments foreach(
    arg,
    content := self doMessage(arg);
    if(content type == "Sequence" , writeln(content)))
  writeln("</" , call message name, ">" )
)
Builder ul(li("Io" ),li("Lua" ),li("JavaScript" ))

vizzini := Object clone
vizzini talk := method(
  "Fezzik, are there rocks ahead?" println
  yield
  "No more rhymes now, I mean it." println
  yield)
fezzik := Object clone
fezzik rhyme := method(
  yield
  "If there are, we'll all be dead." println
  yield
  "Anybody want a peanut?" println)
vizzini @@talk; fezzik @@rhyme
//Coroutine currentCoroutine pause

"question1 start==============" println
XMLBuilder := Object clone
depth := 0
blank := "...."
XMLBuilder forward := method(
  addBlank := (blank repeated(self depth))
  writeln(addBlank,"<" , call message name, ">" )
  depth = depth + 1
  call message arguments foreach(
    arg,
    content := self doMessage(arg);
    if(content type == "Sequence" ,writeln(addBlank, blank, content)))
  depth = depth - 1
  writeln(addBlank,"</" , call message name, ">" )
)
XMLBuilder ul(li("Io" ),li("Lua" ),li("JavaScript" ))

"question2 start==============" println
Object curlyBrackets := method(
   call message arguments
)
sampleList := {a,b,c}
sampleList println

"question3 start==============" println

XmlDocument := Object clone();
XmlDocument init := method(
  self rootNode ::= nil;
  return( self )
)


XmlDocument asString := method(return(self printNode( rootNode(), 0 )))

XmlDocument getDepthPrefix := method(depth,return("...." repeated( depth )))

XmlDocument printNode := method( xmlElement, depth,
buffer := list();
newLine := "\n";
depthPrefix := self getDepthPrefix( depth );

buffer append(
  depthPrefix,
  "<",xmlElement name(),
  if(xmlElement attributes size > 0,
    attributeBuffer := list( "" )
    xmlElement attributes() foreach( name, value,attributeBuffer append(name .. "=\"" .. value .. "\""))
    attributeBuffer join( " " ),(""))
    ,
    ">",newLine
)

if(xmlElement text(),
buffer append(
  self getDepthPrefix( depth + 1 ),
  xmlElement text(),
  newLine
)
)

xmlElement childNodes() foreach( childNode,
  buffer append(
    self printNode( childNode, (depth + 1) )
  )
)

buffer append(depthPrefix,"</",xmlElement name(),">",newLine);

return(buffer join( "" ))
)

XmlAttributes := Map clone();
XmlAttributes atPut := method( name, value,
  if(
    list( "Sequence", "Number" ) contains( value type() ),
    super( atPut( name, value ) )
  )
  return( self )
)

XmlElement := Object clone();
XmlElement init := method(
  self name ::= nil;
  self text ::= nil;
  self attributes ::= XmlAttributes clone();
  self childNodes ::= list();
  self parentNode ::= nil;
  return( self )
)

XmlParser := Object clone();
XmlParser atPutPair := method( name, value,
  attribute := Map clone();
  attribute atPut( "name", name );
  attribute atPut( "value", value );
  return( attribute );
)

XmlParser curlyBrackets := method(
  attributes := list();
  call message arguments foreach( attributePair,attributes append(self doString( attributePair asString )))
  return( attributes )
)

XmlParser forward := method(
  missingMethodName := call message name
  missingMethodArgs := call message arguments
  xmlElement := XmlElement clone
  xmlElement setName( missingMethodName )
if(self isCurlyBrackets( missingMethodArgs at( 0 ) ),
  (attributesMarkup := missingMethodArgs removeFirst();
  attributesList := self doMessage( attributesMarkup );
  attributesList foreach( attribute,
    xmlElement attributes() atPut(
    attribute at( "name" ),
    attribute at( "value" )
    )
    )
  )
)
missingMethodArgs foreach( argument,
  content := self doMessage( argument );
  if((content type() == "XmlElement"),
    (content setParentNode( xmlElement );
    xmlElement childNodes() append( content );),
    (xmlElement setText( content );)
  )
  )
  return( xmlElement )
)


XmlParser isCurlyBrackets := method( targetMessage,
  return((targetMessage asString() findSeq( "curlyBrackets" )) == 0)
)

XmlParser parse := method(
  xmlDoc := XmlDocument clone
  xmlDoc setRootNode(self doMessage(call message arguments at( 0 )))
return( xmlDoc )
)


girls := XmlParser parse(

girls(
{ type: "hotties", isActive: "true" },

girl(
{ id: 17 },
name( "Sarah" ),
age( 35 )
),
girl(
{ id: 104 },
name( "Joanna" ),
age( 32 )
),
girl(
{ id: 15 }
)
)

);


// Print the girls XML docuement.
girls println();




















// OperatorTable addAssignOperator(":", "xmlEl")

// Object xmlEl := method(x,y,
//   return x
//   x println
// // writeln(x asMutable removePrefix("\"") removeSuffix("\""),"=\"",y,"\"")
// )

// curlyXMLBuilder := Object clone

// depth := 0
// blank := "...."

// curlyXMLBuilder curlyBackets := method(
//   "------------------------" println
//   self println
//   (call message arguments) println
// )

// curlyXMLBuilder forward := method(
//   addBlank := (blank repeated(self depth))
//   writeln(addBlank,"<" , call message name, ">" )
//   depth = depth + 1
//   call message arguments foreach(
//     arg,
//     content := self doMessage(arg);
//     if(content type == "Sequence" ,writeln(addBlank, blank, content)))
//   depth = depth - 1
//   writeln(addBlank,"</" , call message name, ">" )
// )

// book := curlyXMLBuilder clone
// book({"author": "Tate"}) println