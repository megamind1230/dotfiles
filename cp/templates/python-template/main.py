import sys

def main():
    data = sys.stdin.buffer.read().split()
    it = iter(data)

    # ---- SOLUTION START ----
    t = int(next(it))
    out = []
    for _ in range(t):
        n = int(next(it))
        s = 0
        for _ in range(n):
            s += int(next(it))
        out.append(str(s))
    sys.stdout.write("\n".join(out) + "\n")
    # ---- SOLUTION END ----

if __name__ == "__main__":
    main()
