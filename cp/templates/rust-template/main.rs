use std::io::{self, BufRead};

fn main() {
    let stdin = io::stdin();
    let mut lines = stdin.lock().lines().map(|l| l.unwrap());

    // ---- SOLUTION START ----
    let t: usize = lines.next().unwrap().parse().unwrap();
    let mut out = Vec::new();
    for _ in 0..t {
        let n: usize = lines.next().unwrap().parse().unwrap();
        let sum: i64 = lines
            .next()
            .unwrap()
            .split_whitespace()
            .take(n)
            .map(|x| x.parse::<i64>().unwrap())
            .sum();
        out.push(sum.to_string());
    }
    // ---- SOLUTION END ----
    println!("{}", out.join("\n"));
}
