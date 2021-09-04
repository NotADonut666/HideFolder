import { writeFileSync, readFileSync } from 'fs';

const symbols = JSON.parse(readFileSync('./symbols.json')).symbols;
const argsName = {
  foldername: 2, 
  passwordLength: 3
}

const foldername = process.argv[argsName.foldername];
const passwordLength = process.argv[argsName.passwordLength]; 

const maxNumValue = 9;

function randomPassword(PassLength, Alphabet)
{
  const BiggestAlphabetIndex = Alphabet.length - 1; 

  let pass = "";

  for (let i = 0; i < PassLength; i++)
   {
    let passNum = Math.round(Math.random() * BiggestAlphabetIndex);
    
    if(Math.round(Math.random()) === 0)
      {
        pass += passNum*passNum % maxNumValue;
      }
    else
      {
        pass += Alphabet[passNum];
      }
  }

  console.log(pass);

  return pass;
}

let password = randomPassword(passwordLength, symbols);
writeFileSync(`../${foldername}/password`,password, "utf-8"); 
