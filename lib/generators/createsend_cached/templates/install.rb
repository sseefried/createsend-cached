class <%= migration_class_name %> < ActiveRecord::Migration
  def self.up
    create_table :campaign_monitor_campaigns, :force => true do |t|
      t.column :campaign_id, :string # Also a primary key but not the one we use
      t.column :web_version_url, :text
      t.column :web_version_text_url, :text
      t.column :world_view_url, :text
      t.timestamps
    end

    create_table :campaign_monitor_lists, :force => true do |t|
      t.column :list_id, :string # also a primary key but not the one we use
      t.column :confirmed_opt_it, :bool
      t.column :title, :text
      t.column :unsubscribe_page,    :text
      t.column :unsubscribe_setting, :text
      t.column :confirmation_success_page, :text
    end

    # Campaigns have multiple lists.
    # Lists can belong to multiple campaigns
    # Need a join table
    create_table :campaign_monitor_campaign_list, :force => true do |t|
      t.references :campaign_monitor_campaign, :null => false
      t.references :campaign_monitor_list, :null => false
    end

    create_table :campaign_monitor_recipients, :force => true do |t|
      t.references :campaign_monitor_campaign, :null => false
      t.references :campaign_monitor_list, :null => false
      t.references :campaign_monitor_subscriber, :null => false
    end

    create_table :campaign_monitor_bounces, :force => true do |t|
      t.references :campaign_monitor_campaign, :null => false
      t.references :campaign_monitor_list, :null => false
      t.column :bounce_type, :integer # From CampaignMonitor::BOUNCE_TYPE
      t.column :date, :datetime
      t.column :reason, :text
    end

    create_table :campaign_monitor_opens, :force => true do |t|
      t.references :campaign_monitor_campaign, :null => false
      t.references :campaign_monitor_list, :null => false
      t.column :date, :datetime
      t.column :ip_address, :string
      t.column :latitude, :decimal
      t.column :longitude, :decimal
      t.column :city, :string
      t.column :region, :string
      t.column :country_code, :string
      t.column :country_name, :string
      t.column :email_address, :text
    end

    create_table :campaign_monitor_clicks, :force => true do |t|
      t.references :campaign_monitor_campaign, :null => false
      t.references :campaign_monitor_list, :null => false
      t.column     :date, :datetime
      t.column     :ip_address, :string
      t.column     :latitude, :string
      t.column     :longitude, :string
      t.column     :city, :string
      t.column     :region, :string
      t.column     :country_code, :string
      t.column     :country_name, :string
    end

    create_table :campaign_monitor_unsubscribes, :force => true do |t|
      t.references :campaign_monitor_campaign, :null => false
      t.references :campaign_monitor_list, :null => false
      t.column     :date, :datetime
      t.column     :ip_address, :string
    end

    create_table :campaign_monitor_subscribers, :force => true do |t|
      t.references :campaign_monitor_list, :null => false
      t.column :email_address, :text
      t.column :name, :text
      t.column :custom_fields, :text
      t.column :date, :datetime
      t.column :status, :integer # from CampaignMonitor::SUBSCRIBER_STATUS
      t.column :state, :integer # From CampaignMonitor::SUBSCRIBER_STATE
      t.column :reads_email_with, :string
    end

    create_table :campaign_monitor_spam_complaints, :force => true do |t|
      t.references :campaign_monitor_campaign, :null => false
      t.references :campaign_monitor_list, :null => false
      t.column     :date, :datetime
    end

    create_table :campaign_monitor_segments, :force => true do |t|
      t.references :campaign_monitor_list, :null => false
      t.column     :segment_id, :string # Also a primary key but not the one we use.
      t.column     :title, :text
    end

    create_table :campaign_monitor_rule_group, :force => true do |t|
      t.references :campaign_monitor_segment, :null => false
    end

    create_table :campaign_monitor_rule, :force => true do |t|
      t.references :campaign_monitor_rule_group, :null => false
      t.column     :rule_type, :string
      t.column     :clause, :text
    end

    add_index :campaign_monitor_campaigns, [:campaign_id], :name => 'campaign_id_index'
    add_index :campaign_monitor_lists,     [:list_id], :name => 'list_id_index'
    add_index :campaign_monitor_segments,  [:segment_id], :name => 'segment_id'
  end

  def self.down
    drop_table :campaign_monitor_campaigns
  end
end
