module ApplicationHelper

  def title(value)
    unless value.nil?
      @title = "#{value} | Turnos"
    end
  end

  def print_resources
    resource_types = get_RT
    result = '['

    resource_types.each do |rt|
      result += <<-eos

              {
                field: '#{get_RT_name(rt)}',
                dataSource: [
      eos
      rt.resources.each do |r|
        result += <<-eos
                  { text: '#{r[:text]}', value: #{r[:id]}, color: '#{r[:color]}' },
        eos
      end

      result += <<-eos
                ],
                title: '#{rt[:title]}',
                multiple: #{rt[:multiple]}
              },
              eos
    end
    result += ']'
  end

  def resource_type_fields
    result = ''
    resource_types = get_RT
    resource_types.each do |rt|
      result += <<-eos
        #{get_RT_name(rt)}: { from: '#{get_RT_name(rt)}', nullable: true},
      eos
    end
    result
  end


private

  def get_RT
    ResourceType.all
  end

  def get_RT_name(rt)
    rt.multiple ? rt.title : rt.field
  end
end
