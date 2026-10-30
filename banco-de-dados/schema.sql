-- CreateEnum
CREATE TYPE "UserType" AS ENUM ('ADMINISTRADOR', 'FISCAL');

-- CreateTable
CREATE TABLE "users" (
    "id" TEXT NOT NULL,
    "email" TEXT NOT NULL,
    "full_name" TEXT,
    "siap_registration" TEXT,
    "profile_completed" BOOLEAN NOT NULL DEFAULT false,
    "google_sub" TEXT,
    "picture_url" TEXT,
    "user_type" "UserType" NOT NULL DEFAULT 'FISCAL',
    "revoked_at" TIMESTAMP(3),
    "invited_by_id" TEXT,
    "last_login_at" TIMESTAMP(3),
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "users_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "conversations" (
    "id" TEXT NOT NULL,
    "user_id" TEXT NOT NULL,
    "title" TEXT NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,
    "is_pinned" BOOLEAN NOT NULL DEFAULT false,
    "deleted_at" TIMESTAMP(3),

    CONSTRAINT "conversations_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "interaction_history" (
    "id" TEXT NOT NULL,
    "conversation_id" TEXT NOT NULL,
    "user_query" TEXT NOT NULL,
    "ai_response" TEXT NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "interaction_history_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "response_sources" (
    "id" TEXT NOT NULL,
    "interaction_id" TEXT NOT NULL,
    "normative_id" TEXT NOT NULL,

    CONSTRAINT "response_sources_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "response_source_excerpts" (
    "id" TEXT NOT NULL,
    "response_source_id" TEXT NOT NULL,
    "parent_chunk_id" TEXT,
    "section_header" TEXT,
    "n1_header" TEXT,
    "n2_header" TEXT,
    "citation" TEXT,
    "excerpt" TEXT NOT NULL,
    "role" TEXT,
    "rank" INTEGER NOT NULL DEFAULT 0,
    "page_start" INTEGER,
    "page_end" INTEGER,
    "char_start" INTEGER,
    "char_end" INTEGER,
    "location_precision" TEXT,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "response_source_excerpts_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "normative_documents" (
    "id" TEXT NOT NULL,
    "title" TEXT NOT NULL,
    "document_type" TEXT NOT NULL,
    "original_content" TEXT NOT NULL,
    "admin_id" TEXT NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,
    "deleted_at" TIMESTAMP(3),
    "file_name" TEXT,
    "file_mime_type" TEXT,
    "file_size" INTEGER,
    "file_hash" TEXT,
    "file_data" BYTEA,
    "indexed_content" TEXT,
    "page_map" JSONB,
    "total_pages" INTEGER,

    CONSTRAINT "normative_documents_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "parent_chunks" (
    "id" TEXT NOT NULL,
    "document_id" TEXT NOT NULL,
    "section_header" TEXT NOT NULL,
    "content" TEXT NOT NULL,
    "metadata" JSONB NOT NULL DEFAULT '{}',
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "parent_chunks_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "users_email_key" ON "users"("email");

-- CreateIndex
CREATE UNIQUE INDEX "users_google_sub_key" ON "users"("google_sub");

-- CreateIndex
CREATE INDEX "response_source_excerpts_response_source_id_idx" ON "response_source_excerpts"("response_source_id");

-- CreateIndex
CREATE INDEX "response_source_excerpts_parent_chunk_id_idx" ON "response_source_excerpts"("parent_chunk_id");

-- AddForeignKey
ALTER TABLE "users" ADD CONSTRAINT "users_invited_by_id_fkey" FOREIGN KEY ("invited_by_id") REFERENCES "users"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "conversations" ADD CONSTRAINT "conversations_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "users"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "interaction_history" ADD CONSTRAINT "interaction_history_conversation_id_fkey" FOREIGN KEY ("conversation_id") REFERENCES "conversations"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "response_sources" ADD CONSTRAINT "response_sources_interaction_id_fkey" FOREIGN KEY ("interaction_id") REFERENCES "interaction_history"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "response_sources" ADD CONSTRAINT "response_sources_normative_id_fkey" FOREIGN KEY ("normative_id") REFERENCES "normative_documents"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "response_source_excerpts" ADD CONSTRAINT "response_source_excerpts_response_source_id_fkey" FOREIGN KEY ("response_source_id") REFERENCES "response_sources"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "response_source_excerpts" ADD CONSTRAINT "response_source_excerpts_parent_chunk_id_fkey" FOREIGN KEY ("parent_chunk_id") REFERENCES "parent_chunks"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "normative_documents" ADD CONSTRAINT "normative_documents_admin_id_fkey" FOREIGN KEY ("admin_id") REFERENCES "users"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "parent_chunks" ADD CONSTRAINT "parent_chunks_document_id_fkey" FOREIGN KEY ("document_id") REFERENCES "normative_documents"("id") ON DELETE CASCADE ON UPDATE CASCADE;

