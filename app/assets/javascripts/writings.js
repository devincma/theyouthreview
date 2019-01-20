$(document).ready(function() {

    if ($(document.body).attr('data-action') === 'edit') {

        var shouldAlert = false;

        window.onbeforeunload = function(e) {
            if (shouldAlert === true) {
                return 'Your changes are not saved.';
            }
        };

        $('.fr-view').on('froalaEditor.contentChanged', function(){
            shouldAlert = true;
        });

        $('#save-update-button').click(function(){
            shouldAlert = false;
            var title = $('#editor-title').val();
            var body = $('.fr-view')[0].innerHTML;
            var draft_token = window.location.pathname.split('/').pop();
            $.ajax({
                type: 'POST',
                url: '/writings/' + getCookie('writing_slug'),
                data: { _method: 'PUT', writing: { title: title, body: body, draft_token: draft_token } },
                dataType: 'json',
                success: function() {
                    window.location.replace('/writings/' + getCookie('writing_slug'));
                    deleteCookie('writing_slug')
                }
            });
        });
    }

});