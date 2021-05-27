/*
  Warnings:

  - You are about to drop the column `article_id` on the `crawls` table. All the data in the column will be lost.
  - You are about to drop the column `tweet_id` on the `crawls` table. All the data in the column will be lost.
  - The primary key for the `handles` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - The primary key for the `tweets` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - You are about to drop the column `id_str` on the `tweets` table. All the data in the column will be lost.
  - A unique constraint covering the columns `[href]` on the table `articles` will be added. If there are existing duplicate values, this will fail.
  - Added the required column `description` to the `articles` table without a default value. This is not possible if the table is not empty.
  - Added the required column `published_at` to the `articles` table without a default value. This is not possible if the table is not empty.
  - Added the required column `authorId` to the `tweets` table without a default value. This is not possible if the table is not empty.

*/
-- DropForeignKey
ALTER TABLE "crawls" DROP CONSTRAINT "crawls_article_id_fkey";

-- DropForeignKey
ALTER TABLE "crawls" DROP CONSTRAINT "crawls_tweet_id_fkey";

-- AlterTable
ALTER TABLE "articles" ADD COLUMN     "description" TEXT NOT NULL,
ADD COLUMN     "published_at" TIMESTAMP(3) NOT NULL;

-- AlterTable
ALTER TABLE "crawls" DROP COLUMN "article_id",
DROP COLUMN "tweet_id",
ADD COLUMN     "sinceId" TEXT;

-- AlterTable
ALTER TABLE "handles" DROP CONSTRAINT "handles_pkey",
ALTER COLUMN "id" SET DATA TYPE TEXT,
ADD PRIMARY KEY ("id");

-- AlterTable
ALTER TABLE "tweets" DROP CONSTRAINT "tweets_pkey",
DROP COLUMN "id_str",
ADD COLUMN     "authorId" TEXT NOT NULL,
ALTER COLUMN "id" SET DATA TYPE TEXT,
ADD PRIMARY KEY ("id");

-- CreateTable
CREATE TABLE "shares" (
    "id" SERIAL NOT NULL,
    "account_id" INTEGER NOT NULL,
    "user_id" INTEGER NOT NULL,
    "crawl_id" INTEGER NOT NULL,
    "tweet_id" TEXT NOT NULL,
    "article_id" INTEGER NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "articles.href_unique" ON "articles"("href");

-- AddForeignKey
ALTER TABLE "shares" ADD FOREIGN KEY ("account_id") REFERENCES "accounts"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "shares" ADD FOREIGN KEY ("user_id") REFERENCES "users"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "shares" ADD FOREIGN KEY ("crawl_id") REFERENCES "crawls"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "shares" ADD FOREIGN KEY ("tweet_id") REFERENCES "tweets"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "shares" ADD FOREIGN KEY ("article_id") REFERENCES "articles"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "tweets" ADD FOREIGN KEY ("authorId") REFERENCES "handles"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "crawls" ADD FOREIGN KEY ("account_id") REFERENCES "accounts"("id") ON DELETE CASCADE ON UPDATE CASCADE;
