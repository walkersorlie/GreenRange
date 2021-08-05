
// Activate scrollspy to add active class to navbar items on scroll
var scrollSpy = new bootstrap.ScrollSpy(document.body, {
    target: '#nav',
    offset: 25
});


$(document).ready(function() {
    $('#contactForm').submit(function (e) {
        var url = "/"; // send the form data here.
        e.preventDefault(); // block the traditional submission of the form.
        $.ajax({
            type: "POST",
            url: url,
            data: $('#contactForm').serialize(), // serializes the form's elements.
            success: function (data) {
                console.log(data.message)  // display the returned data in the console.
            }
        }).done(function(data) {
           alert(data.message);
           $('#contactForm').css('display', 'none')
           $('#contactFormSubmitted').css('display', 'block')
        });
    });

    var csrfToken = "{{ csrf_token() }}";

    // Inject our CSRF token into our AJAX request.
    $.ajaxSetup({
        beforeSend: function(xhr, settings) {
            if (!/^(GET|HEAD|OPTIONS|TRACE)$/i.test(settings.type) && !this.crossDomain) {
                xhr.setRequestHeader("X-CSRFToken", csrfToken)
            }
        }
    })
  });