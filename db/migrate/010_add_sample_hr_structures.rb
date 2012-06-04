class AddSampleHrStructures < ActiveRecord::Migration
  def self.up
#    title=HrJobTitle.new(:title => 'My Job title')
#    title.save
#    manager=User.find(:first, :conditions => ["status=? AND admin=?",1,1] )
#    org=HrOrganization.new(:name => 'My Organization', :manager_job_title => title, :manager => manager)
#    org.save
#    dep=HrDepartment.new(:name => 'My Department', :organization => org, :manager => manager,:manager_job_title => title)
#    dep.save
  end

  def self.down
    title=HrJobTitle.find(:first, :conditions => ["title=?" , 'My Job title'])
    if title
      title.destroy
    end
  end
end
