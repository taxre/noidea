#!/usr/bin/env ruby
RAILS_ENV = 'development'
require File.expand_path('../environment', __FILE__)

#f = File.open("test-devil.txt") 
f = File.open("dvldc10.txt") 
# scan leaves out punctuation such as ' and .
# split divides by space and may work better doesn't

# want definition to survive multiple lines
definition = "Definition: "

#need to put word and type in buffer as defintion comes later
wordBuffer = ""
typeBuffer =""
wordBuffer1 = ""
typeBuffer1 =""
wordBuffer2 = ""
typeBuffer2 =""
defBuffer1 = ""
defBuffer2 = ""
defBuffer3 =""
defBuffer4 = ""
lastWord = ""

count = 0
f.each do | line|
  # n is where to start the definition
  n = 0
  scanned = line.scan(/\w+\.?/)
  # remove white space at left and right of line
  #scanned = scanned.rstrip!
  puts "scanned: " + scanned.to_s
  #scanned = scanned.lstrip!
  word = ""
  type = ""
  finalDef = ""
  
  #  scanned = line.scan(/\w+\'?|\.?/)
  # scanned = line.split()
  length = scanned.size
  
  # wordFlag: 1 = new word
  typeFlag = 0
  
  # check for nils and indented text
  if (scanned[0]!= nil && scanned[1]!= nil && scanned[2]!= nil)
    
    # check for capitals to signify the word 
    # check for more than one to avoid a capital as first word of definition.
    capitals = /^[A-Z]*$/
    puts "scanned: " + scanned[0]
    if scanned[0].match(capitals)
      
      finalDef = definition
      defBuffer1 = finalDef
      defBuffer2 = defBuffer1
      defBuffer3 = defBuffer2
      defBuffer4 = defBuffer3
      
      puts "defBuf3: " + defBuffer3
      puts "defBuf4: " + defBuffer4
      puts "wordBuf: " + wordBuffer1
      puts "typeBuf: " + typeBuffer1
      puts "wordBuf: " + wordBuffer
      puts "wordBuf1: " + wordBuffer1
      puts "wordBuf2: " + wordBuffer2
      puts "lastWord: " + lastWord
      puts "typeBuf1: " + typeBuffer1
      puts "finalDef: " + finalDef
      if (wordBuffer2!="" && typeBuffer2!="" && !defBuffer4.eql?("Definition: ") && wordBuffer1 !=lastWord)
        @word = Word.new
        @word.word = wordBuffer1
        @word.wordtype = typeBuffer1
        @word.description = defBuffer3
        @word.save #formerly @word.create
        lastWord = wordBuffer1
      end 
      puts "entry: " + wordBuffer1 + " " + typeBuffer1 + " " + defBuffer3
      
      #  end
      definition = "Definition: "
      word = scanned[0]
      #    puts "caps: " + word
      
      # otherwise add the line to the definition
      
      # check for type of word, noun, adjective, verb, etc
      #  puts "1" + scanned[1] 
      verb = scanned[1] + scanned[2]
      if ((verb.eql?("v.t.")) || (verb.eql?("v.i.")))
        
        type = verb
        #   puts verb
        n = 3
        typeFlag = 1
        count = 1
      end 
      
      if ((scanned[1].eql?("n.")) || (scanned[1].eql?("adj.")))
        
        type = scanned[1]
        #   puts type
        n = 2
      end
      
      # if the above are true, then scanned[0] must be a new word
      # puts scanned[0]
      
      # the rest of the line  (if anything) should be the start of the definition
      if typeFlag == 0
        n = 2
      else
        n=3
      end
      
      while n < length
        definition = definition+ " " + scanned[n]
        n = n+1
      end
      # not capitals
      if (word!="" && type!= "")
        count = count+1
        #   puts "word: " + word
        #   puts "type: " + type
        # put word and type into buffer to wait for their definition
        
        wordBuffer = word
        typeBuffer = type
        wordBuffer1 = wordBuffer
        typeBuffer1 = typeBuffer
        wordBuffer2 = wordBuffer1
        typeBuffer2 = typeBuffer1
      end
    else
      # put the line into the definition
      if typeFlag == 0
        n = 2
      else
        n=3
      end
      while n < length
        definition = definition+ " " + scanned[n]
        n = n+1  
      end
      # puts definition
      
    end
    
  end
  
end
f.close
