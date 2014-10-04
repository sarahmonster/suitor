    <body leftmargin="0" marginwidth="0" topmargin="0" marginheight="0" offset="0">
      <center>
          <table align="center" border="0" cellpadding="0" cellspacing="0" height="100%" width="100%" id="bodyTable">
              <tr>
                  <td align="center" valign="top" id="bodyCell">
                      <!-- BEGIN TEMPLATE // -->
                      <table border="0" cellpadding="0" cellspacing="0" id="templateContainer">
                          <tr>
                              <td align="center" valign="top">

                              <?php if ($showpreheader === true): ?>
                                  <!-- BEGIN PREHEADER // -->
                                    <table border="0" cellpadding="0" cellspacing="0" width="100%" id="templatePreheader">
                                        <tr>
                                            <td valign="top" class="preheaderContent" style="padding-top:10px; padding-right:20px; padding-bottom:10px; padding-left:20px;" mc:edit="preheader_content00">
                                                Use this area to offer a short teaser of your email's content. Text here will show in the preview area of some email clients.
                                            </td>
                                            <!-- *|IFNOT:ARCHIVE_PAGE|* -->
                                            <td valign="top" width="180" class="preheaderContent" style="padding-top:10px; padding-right:20px; padding-bottom:10px; padding-left:0;" mc:edit="preheader_content01">
                                                Does this email look wonky? <a href="*|ARCHIVE|*" target="_blank">Try this instead</a>.
                                            </td>
                                            <!-- *|END:IF|* -->
                                        </tr>
                                    </table>
                                    <!-- // END PREHEADER -->
                                  <?php endif; ?>
                                  
                                </td>
                            </tr>
                          <tr>
                              <td align="center" valign="top">
                                  <!-- BEGIN HEADER // -->
                                    <table border="0" cellpadding="0" cellspacing="0" width="100%" id="templateHeader">
                                        <tr>
                                            <td valign="top" class="headerContent">
                                              <img src="http://mrsuitor.com/suitor.png" style="max-width:350px;" id="headerImage" mc:label="header_image" mc:edit="header_image" mc:allowdesigner mc:allowtext />

                                              <h1><?php echo $title; ?></h1>
                                            </td>
                                        </tr>
                                    </table>
                                    <!-- // END HEADER -->
                                </td>
                            </tr>
