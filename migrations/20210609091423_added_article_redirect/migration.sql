-- CreateTable
CREATE TABLE "article_redirects" (
    "id" SERIAL NOT NULL,
    "article_id" INTEGER NOT NULL,
    "href" TEXT NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "article_redirects.href_unique" ON "article_redirects"("href");

-- AddForeignKey
ALTER TABLE "article_redirects" ADD FOREIGN KEY ("article_id") REFERENCES "articles"("id") ON DELETE CASCADE ON UPDATE CASCADE;
