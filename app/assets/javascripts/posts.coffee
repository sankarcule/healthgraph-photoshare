# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).on 'click', '.login, .signup', ()->
  $('.login').toggleClass('active')
  $('.signup').toggleClass('active')
  $('.login-content').toggleClass('hidden')
  $('.signup-content').toggleClass('hidden')

$(document).on 'click', '.login-submit', (e)->
  e.preventDefault()
  email = $('.login-email').val()
  pwd = $('.login-pwd').val()
  if (email == '')
    swal {
        title: 'Woops! Please type your email..'
        type: "warning"
    }
    return true
  if (pwd == '')
    swal {
        title: 'Woops! Please type your password..'
        type: "warning"
    }
    return true
  $('#new_user').submit();

$(document).on 'click', '.signup-submit', (e)->
  e.preventDefault()
  email = $('.signup-email').val()
  pwd = $('.signup-pwd').val()
  c_pwd = $('.signup-confirm-pwd').val()
  if (email == '')
    swal {
        title: 'Woops! Please type your email..'
        type: "warning"
    }
    return true
  if (pwd == '')
    swal {
        title: 'Woops! Please type your password..'
        type: "warning"
    }
    return true
  if (c_pwd == '')
    swal {
        title: 'Woops! Please type your confirm password..'
        type: "warning"
    }
    return true
  $('.register_user').submit();

$(document).on 'click', '.follow', ()->
  id = $(this).data('id')
  type = $(this).data('type')
  page = $(this).data('page')
  $.ajax '/posts/follow',
    type: 'get'
    data: {
      id: id
      type: type
      page: page
    }
    success: (data, textStatus, jqXHR) ->
      if (page == 'index')
        $('.posts').html data
      else
        $('.users').html data
