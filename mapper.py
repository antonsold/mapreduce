import sys
import string

for line in sys.stdin:
    text_id, text = line.strip().split('\t', 1)
    words = list(map(lambda x: x.strip(string.punctuation).lower(), text.split()))
    for word in words:
        if word != '':
            if word.istitle():
                print(word + '\t' + text_id + "\t1")
            else:
                print(word + '\t' + text_id + "\t0")
