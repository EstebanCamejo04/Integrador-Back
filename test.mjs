import bcrypt from "bcrypt";

const password = "123";
const saltRounds = 10;

const testBcrypt = async () => {
  const hash = await bcrypt.hash(password, saltRounds);
  console.log("Generated Hash:", hash);

  //   const hash = "$2y$12$r0qHDRjtvaS5479sMuefq.eI0g9WAeNjfgA6WSsDyP6pKM8BC.qaa";

  const isMatch = await bcrypt.compare(password, hash);
  console.log("Password matches:", isMatch); // Debería ser true
};

testBcrypt();
