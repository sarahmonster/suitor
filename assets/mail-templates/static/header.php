    <body leftmargin="0" marginwidth="0" topmargin="0" marginheight="0" offset="0" bgcolor="f7f7f7" background="http://mrsuitor.com/assets/pinstriped_suit-47d5b1841dc0b111accba9dd972415a4.jpg">
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
                                                <span style="float:left">Let&#39;s chat.</span>  
                                          
                                            <!-- *|IFNOT:ARCHIVE_PAGE|* -->
                                                <span style="float:right">&nbsp; &nbsp; Does this email look wonky? <a href="*|ARCHIVE|*" target="_blank">Try this instead</a></span>
                                            <!-- *|END:IF|* -->
                                          </td>
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
                                              <a href="http://mrsuitor.com"><img src="http://mrsuitor.com/suitor.png" style="max-width:350px;" id="headerImage" /></a>
                                              <h1 mc:edit="Email title"><?php echo $title; ?></h1>
                                            </td>
                                        </tr>
                                    </table>
                                    <!-- // END HEADER -->
                                </td>
                            </tr>
