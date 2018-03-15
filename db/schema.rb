# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20_180_314_150_942) do
  # These are extensions that must be enabled in order to support this database
  enable_extension 'plpgsql'

  create_table 'distribution_centers', force: :cascade do |t|
    t.string 'country'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end

  create_table 'inventories', force: :cascade do |t|
    t.bigint 'distribution_center_id'
    t.bigint 'stock_keeping_unit_id'
    t.integer 'quantity_reserved'
    t.integer 'quantity_shipped'
    t.integer 'quantity_available'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['distribution_center_id'], name: 'index_inventories_on_distribution_center_id'
    t.index ['stock_keeping_unit_id'], name: 'index_inventories_on_stock_keeping_unit_id'
  end

  create_table 'stock_keeping_units', force: :cascade do |t|
    t.string 'code'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end

  add_foreign_key 'inventories', 'distribution_centers'
  add_foreign_key 'inventories', 'stock_keeping_units'
end
