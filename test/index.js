
import prisma from '../lib/'

const main = async () => {
  const account = await prisma.account.findMany()
  console.log(account)
  process.exit()
}

main()