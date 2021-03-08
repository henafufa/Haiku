module HaikusHelper
   
    def SyllableCount(text)
        s = "->s{s.scan(/[aiouy]+e*|e(?!d$|ly).|[td]ed|le$/).size}"
        f = eval s
        f.call(text)
    end

    def verse_1_haiku?(verse)
        SyllableCount(verse) == 5 || SyllableCount(verse) == 4 || SyllableCount(verse) == 6
    end

    def verse_2_haiku?(verse)
        SyllableCount(verse) == 7 || SyllableCount(verse) == 8 || SyllableCount(verse) == 6
    end

    def verse_3_haiku?(verse)
        SyllableCount(verse) == 5 || SyllableCount(verse) == 4 || SyllableCount(verse) == 6
    end
end
