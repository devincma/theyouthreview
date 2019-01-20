$(document).ready(function() {

    var frView = $('.fr-view');
    var acl = frView.data('acl');
    var AWSAccessKeyId = frView.data('awsaccesskeyid');
    var policy = frView.data('policy');
    var signature = frView.data('signature');

    // Check if button is active.
    var isActive = function (cmd) {
        var blocks = this.selection.blocks();
        if (blocks.length) {
            var blk = blocks[0];
            var tag = 'N';
            var default_tag = this.html.defaultTag();
            if (blk.tagName.toLowerCase() !== default_tag && blk !== this.el) {
                tag = blk.tagName;
            }
        }
        if (['LI', 'TD', 'TH'].indexOf(tag) >= 0) {
            tag = 'N';
        }
        return tag.toLowerCase() === cmd;
    };

    $.FroalaEditor.DefineIcon('h1', { NAME: '<strong>H1</strong>', template: 'text' });
    $.FroalaEditor.DefineIcon('h2', { NAME: '<strong>H2</strong>', template: 'text' });
    $.FroalaEditor.RegisterCommand('h1', {
        title: 'Heading 1',
        callback: function (cmd, val, params) {
            if (isActive.apply(this, [cmd])) {
                this.paragraphFormat.apply('N');
            }
            else {
                this.paragraphFormat.apply(cmd);
            }
        },
        refresh: function ($btn) {
            $btn.toggleClass('fr-active', isActive.apply(this, [$btn.data('cmd')]));
        }
    });

    $.FroalaEditor.RegisterCommand('h2', {
        title: 'Heading 2',
        callback: function (cmd, val, params) {
            if (isActive.apply(this, [cmd])) {
                this.paragraphFormat.apply('N');
            }
            else {
                this.paragraphFormat.apply(cmd);
            }
        },
        refresh: function ($btn) {
            $btn.toggleClass('fr-active', isActive.apply(this, [$btn.data('cmd')]));
        }
    });

    frView
        .froalaEditor({
            toolbarInline: true,
            placeholderText: 'Start writing...',
            toolbarButtons: ['h1', 'h2', 'bold', 'italic', 'underline', 'align', 'quote', 'insertLink'],
            htmlRemoveTags: ['script', 'style', 'base'],
            imageEditButtons: ['imageReplace', 'imageRemove'],
            linkInsertButtons: ['linkBack'],
            linkEditButtons: ['linkEdit', 'linkRemove'],
            imageUploadToS3: {
                bucket: 'theyouthreview',
                region: 's3-us-west-2', // Change the region if it is different
                keyStart: 'writings-upload/',
                // callback: function (url, key) {
                //     // The URL and Key returned from Amazon.
                //     console.log(url);
                //     console.log(key);
                // },
                params: {
                    acl: acl, // ACL according to Amazon Documentation.
                    AWSAccessKeyId: AWSAccessKeyId, // Access Key from Amazon.
                    policy: policy, // Policy string computed in the backend.
                    signature: signature // Signature computed in the backend.
                }
            }
        });

});