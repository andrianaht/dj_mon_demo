class WelcomeController < ApplicationController

  def index
    seed_data if stale?
    redirect_to dj_mon_url
  end

  private

  def seed_data
    Delayed::Job.destroy_all

    10.times { |i| Email.new.delay(priority: i, queue: "queue_#{i%2}" ).deliver }
    5.times { |i| Email.new.delay(priority: i, queue: "queue_#{i%2}").deliver_failed }

    Delayed::Worker.new.work_off

    12.times { |i| Email.new.delay(priority: i).deliver }
  end

  def stale?
    Delayed::Job.where('updated_at < ?',  1.hour.ago).present? || Delayed::Job.count.zero?
  end

end
