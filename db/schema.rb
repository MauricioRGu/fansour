# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2024_03_01_021422) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.integer "record_id", null: false
    t.integer "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.integer "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "assinaturas", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "criador_id", null: false
    t.datetime "dt_inicio", null: false
    t.datetime "dt_fim", null: false
    t.float "valor"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "plan", null: false
    t.boolean "vencida", default: false
    t.boolean "renovacao_automatica", default: true
    t.index ["criador_id"], name: "index_assinaturas_on_criador_id"
    t.index ["user_id"], name: "index_assinaturas_on_user_id"
  end

  create_table "checagem_profiles", force: :cascade do |t|
    t.boolean "analisado", default: false
    t.boolean "aprovado", default: false
    t.string "observacao"
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_checagem_profiles_on_user_id"
  end

  create_table "posts", force: :cascade do |t|
    t.string "descricao"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "nome_completo"
    t.string "nome_publico"
    t.string "cpf"
    t.date "dt_nascimento"
    t.string "telefone"
    t.string "pais"
    t.string "cep"
    t.string "estado"
    t.string "cidade"
    t.string "endereco"
    t.string "bairro"
    t.integer "numero"
    t.string "complemento"
    t.boolean "perfil_criador", default: false
    t.datetime "dt_verificacao"
    t.boolean "publico", default: false
    t.boolean "desativado", default: false
    t.text "descricao"
    t.integer "sign_in_count", default: 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.string "nome_arroba"
    t.float "valor1", default: 0.0
    t.integer "desc1", default: 0
    t.float "valor3", default: 0.0
    t.integer "desc3", default: 0
    t.float "valor6", default: 0.0
    t.integer "desc6", default: 0
    t.string "instagram"
    t.string "twitter"
    t.string "tiktok"
    t.string "telegram"
    t.string "site"
    t.string "type_user"
    t.index ["cpf"], name: "index_users_on_cpf", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["nome_arroba"], name: "index_users_on_nome_arroba", unique: true
    t.index ["nome_publico"], name: "index_users_on_nome_publico", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "assinaturas", "users"
  add_foreign_key "assinaturas", "users", column: "criador_id"
  add_foreign_key "checagem_profiles", "users"
end
