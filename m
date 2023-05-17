Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39A8C706816
	for <lists+linux-integrity@lfdr.de>; Wed, 17 May 2023 14:28:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230378AbjEQM2l (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 17 May 2023 08:28:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230307AbjEQM2k (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 17 May 2023 08:28:40 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBF6B10DA;
        Wed, 17 May 2023 05:28:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684326519; x=1715862519;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=X2f39L4vZwZUOK/jkj4uPaCR2SriTj538cYcK+gs4jo=;
  b=hx7hLmchS1rMD/O8DpfUT2UC+A91YI09d3x15i618uekizG3On7Sn2L1
   ydJhINEr0oZi/QfLm4qn7M3jsIIvT/G2jdcyXNToIC04qEXTEGFTgpO/y
   HsD59ijFc8f+iBFRyP3vagbVxphUxb5ebOtCaLI7mxDoyxRYzTIlBA+IM
   UhYxeiBqAB9Yx20gw+kw551WsMTe8qYkNBhfXtKr2L69rXVV2Elv8ctGx
   BrEwQOUFxQBHJIWDOth7PuyV0QDDdrkGcAG8D0Tmu6BhaGcm27DnzhUqO
   vvorbJI327KHVImdHIlFk6QggqPVtzc9wvGU4AqMlr4IRGDzoa3trSw1s
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10712"; a="415156753"
X-IronPort-AV: E=Sophos;i="5.99,282,1677571200"; 
   d="scan'208";a="415156753"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2023 05:28:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10712"; a="652213946"
X-IronPort-AV: E=Sophos;i="5.99,282,1677571200"; 
   d="scan'208";a="652213946"
Received: from fabiobar-mobl.ger.corp.intel.com (HELO pujfalus-desk.ger.corp.intel.com) ([10.251.219.163])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2023 05:28:35 -0700
From:   Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
To:     peterhuewe@gmx.de, jarkko@kernel.org
Cc:     jgg@ziepe.ca, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org, l.sanfilippo@kunbus.com,
        peter.ujfalusi@linux.intel.com, jsnitsel@redhat.com
Subject: [PATCH - for 6.4] tpm: tpm_tis: Disable interrupts for AEON UPX-i11
Date:   Wed, 17 May 2023 15:29:31 +0300
Message-Id: <20230517122931.22385-1-peter.ujfalusi@linux.intel.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

The interrupts initially works on the device but they will stop arriving
after about 200 interrupts.

On system reboot/shutdown this will cause a long wait (120000 jiffies).

The interrupts on this device got enabled by commit
e644b2f498d2 ("tpm, tpm_tis: Enable interrupt test")

Prior to this point the interrupts were not enabled on this machine.

Complements: e644b2f498d2 ("tpm, tpm_tis: Enable interrupt test")
Signed-off-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
---
Hi,

This patch applies on top of mainline since 6.4-rc1 takes about 2 minutes to
reboot on this machine, linux-next have
e7d3e5c4b1dd tpm/tpm_tis: Disable interrupts for more Lenovo devices

I'm not sure if I shouold send this on top of next or mainline is fine, please
let me know the preferred way to get this to 6.4.

Regards,
Peter

 drivers/char/tpm/tpm_tis.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/char/tpm/tpm_tis.c b/drivers/char/tpm/tpm_tis.c
index 7af389806643..aad682c2ab21 100644
--- a/drivers/char/tpm/tpm_tis.c
+++ b/drivers/char/tpm/tpm_tis.c
@@ -122,6 +122,13 @@ static const struct dmi_system_id tpm_tis_dmi_table[] = {
 			DMI_MATCH(DMI_PRODUCT_VERSION, "ThinkPad T490s"),
 		},
 	},
+	{
+		.callback = tpm_tis_disable_irq,
+		.ident = "UPX-TGL",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "AAEON"),
+		},
+	},
 	{}
 };
 
-- 
2.40.1

