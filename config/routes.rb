Rails.application.routes.draw do
  # ------ transaction  ------
  post 'transaction.create',       to: 'transaction#create'
  post 'transaction.broadcast',    to: 'transaction#broadcast'
  post 'transaction.get',          to: 'transaction#get'

  # ------ wallet ------
  post 'wallet.create',            to: 'wallet#create'
  post 'wallet.get',               to: 'wallet#get'
end
