Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE7DA70ED6E
	for <lists+linux-integrity@lfdr.de>; Wed, 24 May 2023 07:57:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236309AbjEXF5U (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 24 May 2023 01:57:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233759AbjEXF5T (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 24 May 2023 01:57:19 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE831132;
        Tue, 23 May 2023 22:57:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684907838; x=1716443838;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=O2khWCZpYpaAuiJUEy1FdFjA3ykBxyXgTWC0NJSEmZA=;
  b=C4+lc4zy4Kb8ZH1xra/2GXw3sfN36YRL2mz/QgheTdgxiXocRPgzbJ2P
   eyrMAmVgUZ9IoAfGybOycAehTVMN3DwA7EbfptGEM5hWmORF+oViQlexS
   paVDzKCdjw87cf7p5cXe4blCVudyIpu/LzcTDXGFhnC8JQPkcnDj6IXP9
   BTG5LtaVhbQQ7TtJlTiOilFA3zlhaemSlMgrYnHkt4OGndr+3Etji579S
   Mw8ga9vUaebarAH6iHTwZX4BqsqubNy/T9QkMJpI7jvBPH9P47VBTt1gA
   Ut2N3HS0BTiobjJPkRNbtu3OzafaCXACaXqIr7Mg50UA/3N6jRN3oq64e
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10719"; a="381711522"
X-IronPort-AV: E=Sophos;i="6.00,188,1681196400"; 
   d="scan'208";a="381711522"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2023 22:57:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10719"; a="769310141"
X-IronPort-AV: E=Sophos;i="6.00,188,1681196400"; 
   d="scan'208";a="769310141"
Received: from mhakkine-mobl4.ger.corp.intel.com (HELO pujfalus-desk.ger.corp.intel.com) ([10.252.53.214])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2023 22:57:15 -0700
From:   Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
To:     peterhuewe@gmx.de, jarkko@kernel.org
Cc:     jgg@ziepe.ca, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org, l.sanfilippo@kunbus.com,
        peter.ujfalusi@linux.intel.com, jsnitsel@redhat.com
Subject: [PATCH] tpm: tpm_tis: Narrow the AAEON DMI quirk to UPX-i11 only
Date:   Wed, 24 May 2023 08:58:15 +0300
Message-Id: <20230524055815.10165-1-peter.ujfalusi@linux.intel.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

The original patch which added the quirk would apply to all AAEON machines,
which might or might not be valid.

The issue was discovered on UPX-i11 (TigerLake), it is not known if the
i12 (AlderLake) version is affected.
UP2 (ApolloLake) does not even have TMP module (no TPM drivers probing
and confirmed by dmidecode).

Let's make the quirk to be applicable for UPX-i11 (UPX-TGL01) only.

Fixes: 95a9359ee22f ("tpm: tpm_tis: Disable interrupts for AEON UPX-i11")
Suggested-by: Jerry Snitselaar <jsnitsel@redhat.com>
Signed-off-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
---
Hi Jarkko,

the patch is generated on top of your
git://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git : irq-storm

Regards,
Peter

 drivers/char/tpm/tpm_tis.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/char/tpm/tpm_tis.c b/drivers/char/tpm/tpm_tis.c
index 7db3593941ea..4357d4ba8f9e 100644
--- a/drivers/char/tpm/tpm_tis.c
+++ b/drivers/char/tpm/tpm_tis.c
@@ -143,6 +143,7 @@ static const struct dmi_system_id tpm_tis_dmi_table[] = {
 		.ident = "UPX-TGL",
 		.matches = {
 			DMI_MATCH(DMI_SYS_VENDOR, "AAEON"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "UPX-TGL01"),
 		},
 	},
 	{}
-- 
2.40.1

