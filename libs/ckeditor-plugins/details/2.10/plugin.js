/**
 * Details Widget
 *
 * @author Otavia
 */
'use strict';

(function (CKEDITOR) {
    /**
     * DTD
     */
    CKEDITOR.dtd['$editable']['summary'] = 1;

    /**
     * Plugin
     */
    CKEDITOR.plugins.add('details', {
      requires: 'widget',
      icons: 'details',
      hidpi: true,
      lang: 'en,fi',
      init: function (editor) {
        /**
         * Widget
         */
        editor.widgets.add('details', {
            button: editor.lang.details.title,
            template: '<details class="details"><summary class="details__summary">' + editor.lang.details.title +'</summary><div class="details__content"></div></details>',
            editables: {
                summary: {
                    selector: 'summary.details__summary',
                },
                content: {
                    selector: 'div.details__content'
                }
            },
            allowedContent: 'details(!details); summary(!details__summary); div(!details__content)',
            requiredContent: 'details(details)',
            upcast: function (element) {
                return element.name == 'details' && element.hasClass( 'details' );
            },
        });
      }
    });
})(CKEDITOR);
