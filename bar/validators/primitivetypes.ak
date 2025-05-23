use cardano/address.{Script, VerificationKey}
use cardano/governance.{
  ConstitutionalCommitteeMember, DelegateRepresentative, StakePool,
}
use cardano/governance/voter

test integer() {
  // Fix these:
  let i = "Three"
  let j: Int = 22
  let i = 3
  let k = 0xff
  let l = 4_000

  let i_is_less_than_j = i < j
  let j_is_greater_or_equal_to_i = j >= i
  let k_is_less_or_equal_to_l = k <= l
  let l_is_greater_than_k = l > k

  and {
    i_is_less_than_j,
    j_is_greater_or_equal_to_i,
    k_is_less_or_equal_to_l,
    l_is_greater_than_k,
    // IF i + j == 25 is True,
    i + j == 25,
    // THEN solve these:
    l - k == 4000 - k,
    i * j == 66,
    l / i == 1333,
    l % i == 1,
  }
}

test bytearray() {
  // Fix these:
  let a: ByteArray = "abcd"
  let b = "1234"

  let c = #"abcd"//#"ABCD"
  let d = #[0xab, 0xcd]

  // These conditions are ALL True:
  and {
    a == "abcd",
    b == "1234",
    c == d,
  }
}

// ## Bool

test boolean() {
  // Fix these:
  let y: Bool = True
  let n = False

  y? || n?
}

/// Fix test tuple() in any way possible, may be more than 1 ways.
test tuple() {
  let t2: (Int, Int) = (1, 2)
  let t3: (ByteArray, Int, Int) = ("3", 4, 0)
  let t4 = (0, 123, 4, 0x56)

  let (a, _b, _c, _d) = t4
  let (_a, b) = t2
  let (_1, _2, c) = t3

  and {
    a == c,
    b % 2 == 0,
  }
}

/// Fix test list() in any way possible, may be more than 1 ways.
test list() {
  let ls: List<Int> = [1, 2]
  let bs = ["3", "4", "0"]
  let os = [0, 123, 4, 0x56]

  and {
    [3, ..ls] == [3, 1, 2],
    ["123", ..bs] == ["123", "3", "4", "0"],
    os == [0, 123, 4, 0x56],
  }
}

/// Fix test option() in any way possible, may be more than 1 ways.
test option() {
  let someone: Option<Bool> = Some(True)
  //let someone: Option<Bool> = None
  //let who = None

  //expect None = who
  when someone is {
    Some(body) -> body == True
    _ -> False
  }
}

/// Fix test ordering()
test ordering() {
  let key = VerificationKey("VerificationKeyHash")
  let script = Script("ScriptHash")

  let pool = StakePool("VerificationKeyHash")

  and {
    voter.compare(ConstitutionalCommitteeMember(script),ConstitutionalCommitteeMember(key)) == Less,
    voter.compare(DelegateRepresentative(key),DelegateRepresentative(script)) == Greater,
    voter.compare(pool, pool) == Equal,
  }
 }

// /// Fix test data()
test data() {
  let a: Data = "1"
  let b: Data = 0xabcd
  let c: Data = False

  expect s: ByteArray = a
  expect h: Int = b
  expect n: Bool = c

  and {
    0 === false,
    s == "1",
    h == 43_981,
    !n,
  }
}

// 0 === false
// True != False
// 0 == False