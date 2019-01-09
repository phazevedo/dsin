class Admins::AdminsController < ApplicationController
    protect_from_forgery with: :exception
    

    def dashboard
        render 'admins/admins/dashboard'
    end


    def report
        
    end

    def seven_report
        @orders = Order.where(created_at:  (Date.today - 7).beginning_of_day..(Date.today).end_of_day).where(status: Order::STATUS_ENDED)
        @total_value = 0
        @count = 0 
        @orders.each do |order|
            @total_value += order.value
            @count += 1
        end
    end

    def weekly_report
        @weeks = {}
        orders = Order.all.pluck("id", "DATE_TRUNC('week', created_at)").map { |id, name| {"#{name}": id}}
        orders.each do |h|
            h.each do |w, ids|
                @weeks[w] = @weeks[w] || []
                @weeks[w].push(ids)
            end
        end
    end

end
  