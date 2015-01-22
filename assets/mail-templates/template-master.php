<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

    <?php
        $showpreheader = true;
        $title = "Title of newsletter";
    ?>

    <?php include('static/head.php'); ?>
    <?php include('static/header.php'); ?>

    <tr>
    	<td align="center" valign="top">
        	<!-- BEGIN BODY // -->
            <table border="0" cellpadding="0" cellspacing="0" width="100%" id="templateBody">
                <tr>
                    <td valign="top" class="bodyContent" mc:edit="body_content">
                        <h3>Creating a good-looking email is <strong>hard</strong></h3>
                        <p>Customize your template by clicking on the style editor tabs above. Set your fonts, colors, and styles. After setting your styling is all done you can click here in this area, delete the text, and start adding your own awesome content.</p>

                        <h3>Some other header textyness</h3>
                        <p>After you enter your content, highlight the text you want to style and select the options you set in the style editor in the "<em>styles</em>" drop down box. Want to <a href="http://www.mailchimp.com/kb/article/im-using-the-style-designer-and-i-cant-get-my-formatting-to-change" target="_blank">get rid of styling on a bit of text</a>, but having trouble doing it? Just use the "<em>remove formatting</em>" button to strip the text of any formatting and reset your style.</p>

                        <p class="center">
                            <a class="button" href="#">Call to action</a>
                        </p>
                    </td>
                </tr>
            </table>
            <!-- // END BODY -->
        </td>
    </tr>
    <?php include('static/mailchimp-footer.php'); ?>
    <?php include('static/foot.php'); ?>
</html>
