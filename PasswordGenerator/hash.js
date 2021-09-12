import { createHash } from 'crypto';
import { writeFileSync } from 'fs';

const argsName = { 
  filename: 2,
  text: 3,
}

const fileName = process.argv[argsName.filename];
const text = process.argv[argsName.text];
console.log(fileName, text)
export function getHash(text)
{
  return createHash('sha256').update(text).digest('hex');
}

export function writeHashToFile(text, file, encoding = "utf-8")
{
 const hash = getHash(text); 
 writeFileSync(file, hash, encoding);
}

if(fileName !== undefined && text !== undefined) writeHashToFile(text, fileName);