-- load input file from hdfs
-- I am Rohini
-- I am rohini
inputFile = LOAD 'hdfs:///user/rohini/input.txt' AS (line:chararray);
	
-- Tokeize each word in the line into words(Map)
-- i
-- am
-- rohini
-- I
-- am
-- rohini
words = FOREACH inputFile GENERATE FLATTEN(TOKENIZE(line)) AS word;

-- Group words by word(MAP)
grpd = GROUP words BY word;

-- Count the number of words
totalCount = FOREACH grpd GENERATE $0, COUNT($1);

-- Remove and rewriting the file
rmf hdfs:///user/rohini/PigOutput1;

-- Store the results in HDFS
STORE totalCount INTO 'hdfs:///user/rohini/PigOutput1';