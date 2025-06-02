class Settings
  def initialize
    @configurations = {}
  end

  def add(key, value, **params)
    if params[:readonly]
      define_singleton_method_for_key(key, value)
      define_singleton_method("#{key}=") do |value|
        raise "Configuração '#{key}' é somente leitura."
      end
    else
      define_singleton_method_for_key(key, value)
      define_singleton_method("#{key}=") do |value|
        @configurations[key] = value
      end
    end
    if params[:alias]
      define_singleton_method(params[:alias]) do
        @configurations[key]
      end
    end
  end

  def method_missing(method_name, *args)
    if @configurations.key?(method_name)
      @configurations[method_name]
    else
      raise "Configuração '#{method_name}' não existe."
    end
  end

  def respond_to_missing?(method_name, include_private = false)
    @configurations.key?(method_name) || super
  end

  def all
    @configurations
  end

  private

  def define_singleton_method_for_key(key, value)
    define_singleton_method(key) do
      @configurations[key] = value
    end
  end
end


settings = Settings.new
settings.add(:timeout, 30)
settings.add(:mode, "production")

puts settings.timeout
puts settings.mode

# puts settings.retry

puts settings.respond_to? :timeout
puts settings.respond_to? :retry

# 1. Suporte a aliases
settings.add(:timeout, 30, alias: :espera)
puts settings.timeout  # => 30
puts settings.espera   # => 30

# 2. Configuração somente leitura
puts settings.add(:api_key, "SECRET", readonly: true)
puts settings.api_key # => SECRET
# puts settings.api_key = "HACKED"  # => Erro: configuração 'api_key' é somente leitura

# 3. Listagem de configurações
puts settings.all

# 4. Integração com method_missing para setters
puts settings.timeout = 40
puts settings.espera
puts settings.retry = 3
