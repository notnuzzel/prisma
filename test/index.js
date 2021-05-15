
import prisma from '../lib/'

const main = async () => {
  await prisma.user.findMany()
  process.exit()
}

main()