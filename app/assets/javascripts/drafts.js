$(document).ready(function() {

    var autoSaveInterval = 30000;
    var shouldCreateDraft = true;
    var shouldSaveDraft = false;
    var shouldPublishDraft = true;
    if ($(document.body).attr('data-action') === 'show') {
        shouldCreateDraft = false;
        shouldSaveDraft = true;
    }
    var statusIndicatorDiv = $('#status-indicator');
    var statusIndicatorSpan = statusIndicatorDiv[0];

    window.onbeforeunload = function() {
        if (statusIndicatorSpan.innerText !== 'Enter a title and start writing' && statusIndicatorSpan.innerText !== "Work on what you left off" && statusIndicatorSpan.innerText !== 'Saved') {
            return 'Your changes are not saved.';
        }
    };
    
    function changeStutusIndicator(text, dataTooltip) {
        statusIndicatorSpan.innerText = text;
        statusIndicatorDiv.attr({
            'data-tooltip': dataTooltip,
            'data-position': 'bottom center'
        });
    }

    function changeToCodeName(text) {
        if (text === 'Short Story') {
            return 'short-story';
        } else if (text === 'Student Life') {
            return 'student-life';
        } else if (text === 'Tech & Innovation') {
            return 'technology';
        } else {
            return text.toLowerCase();
        }
    }

    $('.fr-view').on('froalaEditor.contentChanged', function(){
        if ($('.fr-view').froalaEditor('core.isEmpty')) {
            $('#publish-button').addClass('disabled');
        } else {
            if ($('#editor-title').val().length !== 0) {
                $('#publish-button').removeClass('disabled');
                createDraft();
                if (statusIndicatorSpan.innerText === 'Saved' || statusIndicatorSpan.innerText === 'Draft created, will auto save every 30 seconds' || statusIndicatorSpan.innerText === 'Work on what you left off') {
                    changeStutusIndicator('Unsaved changes', "Click the 'Save' button to save manually");
                }
            }
        }
    });

    $('#editor-title').on('propertychange change paste input', function(){
        if ($('#editor-title').val().length === 0) {
            $('#publish-button').addClass('disabled');
        } else {
            if ($('.fr-view').froalaEditor('core.isEmpty') === false) {
                $('#publish-button').removeClass('disabled');
            }
        }
    });

    function createDraft() {
        // console.log('Creating a new draft...');
        if (window.location.pathname === '/drafts/new' && shouldCreateDraft) {
            shouldCreateDraft = false;
            statusIndicatorSpan.innerText = 'Creating a new draft';
            var title = $('#editor-title').val();
            var body = $('.fr-view')[0].innerHTML;
            $.ajax({
                type: 'POST',
                url: '/drafts/autocreate',
                data: {draft: {title: title, body: body}},
                dataType: 'json',
                success: function () {
                    window.history.pushState(null, '', ('/drafts/' + getCookie('draft_token')));
                    deleteCookie('draft_token');
                    changeStutusIndicator('Draft created, will auto save every 30 seconds', 'All changes are auto-saved every 30 seconds');
                    $('#save-button')[0].style.display = 'inline-block';
                    setInterval(saveDraft, autoSaveInterval);
                }
            });
            shouldSaveDraft = true;
        }
    }

    if ($(document.body).attr('data-action') === 'show' && shouldSaveDraft === true) {
        setInterval(saveDraft, autoSaveInterval);
    }

    function saveDraft() {
        // console.log('Saving...');
        statusIndicatorSpan.innerText = '';
        $('#save-button').addClass('loading');
        var title = $('#editor-title').val();
        var body = $('.fr-view')[0].innerHTML;
        $.ajax({
            type: 'POST',
            url: window.location.pathname,
            data: { _method:'PUT', draft: { title: title, body: body } },
            dataType: 'json',
            success: function () {
                setTimeout(
                    function(){
                        changeStutusIndicator('Saved', 'All changes are auto-saved every 30 seconds');
                        $('#save-button').removeClass('loading');
                    }, 1500);
            }
        });
    }

    // function save() {
    //     if (window.location.pathname === '/drafts/new' && shouldCreateDraft) {
    //         createDraft();
    //     } else {
    //         saveDraft();
    //     }
    // }

    $('#publish-button').click(function(){
        $('#publish-modal').modal('show');
    });

    $('#web-editor-usage').click(function(){
        $('#web-editor-usage-modal').modal('show');
    });


    $('#save-button').click(function(){
        saveDraft();
    });

    $('#publish-now-button').click(function(){
        if (shouldPublishDraft === true) {
            shouldPublishDraft = false;
            var title = $('#editor-title').val();
            var body = $('.fr-view')[0].innerHTML;
            var draft_token = window.location.pathname.split('/').pop();
            var topics = changeToCodeName($('#topic-dropdown .text').text());
            $.ajax({
                type: 'POST',
                url: '/writings',
                data: { writing: { title: title, body: body, draft_token: draft_token, tag_list: topics } },
                dataType: 'json',
                success: function() {
                    $.ajax({
                        type: 'DELETE',
                        url: window.location.pathname,
                        dataType: 'json',
                        success: function () {
                            window.location.replace('/writings/' + getCookie('writing_slug'));
                            deleteCookie('writing_slug')
                        }
                    });
                }
            });
        }
    });

});