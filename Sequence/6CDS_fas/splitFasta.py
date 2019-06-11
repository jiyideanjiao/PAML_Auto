import sys
def parseFasta(filename):
    fas = {}
    id = None
    with open(filename, 'r') as fh:
        for line in fh:
            if line[0] == '>':
                header = line[1:].rstrip()
                id = header.split()[0]
                fas[id] = []
            else:
                fas[id].append(line.rstrip())
        for id, seq in fas.iteritems():
            fas[id] = ''.join(seq)
    return fas
fas = parseFasta(sys.argv[1])
for i in fas:
    with open(i + ".fa", 'w') as f:
        f.write(">" + i + "\n" + fas[i] + "\n")
