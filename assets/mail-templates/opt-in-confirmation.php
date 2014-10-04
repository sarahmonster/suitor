<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

    <?php 
        $showpreheader = false;
        $title = "Let&rsquo;s be friends!";
    ?>

    <?php include('static/head.php'); ?>
    <?php include('static/header.php'); ?>

    <tr>
    	<td align="center" valign="top">
        	<!-- BEGIN BODY // -->
            <table border="0" cellpadding="0" cellspacing="0" width="100%" id="templateBody">
                <tr>
                    <td valign="top" class="bodyContent" mc:edit="body_content">
                        <h3>Hi there!</h3>
                        <p>We&rsquo;re <span class="suitor">suitor</span>, and we&rsquo;re delighted to meet you! We&rsquo;re pretty excited to send you messages all about our launch and development, but first, we need you to <a href="http://mrsuitor.us1.list-manage1.com/subscribe/confirm?u=7cf7b38d641914fc60e63954f&id=2c3bb4988b&e=*|UNIQID|*">confirm that you actually like us</a>.

                        <p class="center">
                            <a class="button" href="http://mrsuitor.us1.list-manage1.com/subscribe/confirm?u=7cf7b38d641914fc60e63954f&id=2c3bb4988b&e=*|UNIQID|*">Confirm subscription</a>
                        </p>

                        <p>Don&rsquo;t worry; we&rsquo;re too busy to flood your inbox with mails, and you can unsubscribe at any point. If you&rsquo;ve changed your mind, just delete this email, and we promise not to mail you again.</p>

                        <p class="xo">&hearts; suitor xox</p>
                    </td>
                </tr>
            </table>
            <!-- // END BODY -->
        </td>
    </tr>
    <?php //include('static/mailchimp-footer.php'); ?>
    <?php include('static/foot.php'); ?>

    <span itemscope itemtype="http://schema.org/EmailMessage">
      <span itemprop="description" content="We need to confirm your email address."/>
      <span itemprop="action" itemscope itemtype="http://schema.org/ConfirmAction">
        <meta itemprop="name" content="Confirm Subscription"/>
        <span itemprop="handler" itemscope itemtype="http://schema.org/HttpActionHandler">
          <meta itemprop="url" content="https://mrsuitor.us1.list-manage.com/subscribe/smartmail-confirm?u=7cf7b38d641914fc60e63954f&id=2c3bb4988b&e=*|UNIQID|*&inline=true"/>
          <link itemprop="method" href="http://schema.org/HttpRequestMethod/POST"/>
        </span>
      </span>
    </span>
</html>
