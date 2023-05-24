Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FAD770F1A2
	for <lists+linux-integrity@lfdr.de>; Wed, 24 May 2023 11:01:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239862AbjEXJBD (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 24 May 2023 05:01:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236330AbjEXJBC (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 24 May 2023 05:01:02 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C303C97;
        Wed, 24 May 2023 02:01:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684918861; x=1716454861;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=cKX+IQFRHNQoqNojwoK2jn87UOsCzMzUFKLeh9N1RlA=;
  b=Alts5aY07pgFJ8yt9XkddOQh7x4ShjrBqoKCL+2R7BYfWa8jzQrdekUa
   1vwq7IlrAmYSkoB8SkFaW5pr5miF1lIDQ718nKdG5L8cmm/1T9i9jE54Z
   4piJXCkTfCv9pAEOqxtbrjRL0oFeUNbxMHssXGAmhlUwVFipttDok920q
   AgnPp9O6rMyxmWJ5l9kLmvPcB1TdvLk9xtL8gTIezrMHsKR1KSnZGsvwm
   FZHEZmS71lnwOV4xkYCqdq+1N4VevNCFnDRQCnnPstN4qCo1z+2zIIKce
   0ZgVSQJh97rpAt04DRNJ33/io9Ev9mN7gjoWCUbQwNs1t58Kw5Uih/vGl
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10719"; a="439858812"
X-IronPort-AV: E=Sophos;i="6.00,188,1681196400"; 
   d="scan'208";a="439858812"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2023 01:57:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10719"; a="878571020"
X-IronPort-AV: E=Sophos;i="6.00,188,1681196400"; 
   d="scan'208";a="878571020"
Received: from mhakkine-mobl4.ger.corp.intel.com (HELO pujfalus-desk.ger.corp.intel.com) ([10.252.53.214])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2023 01:57:45 -0700
From:   Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
To:     peterhuewe@gmx.de, jarkko@kernel.org
Cc:     jgg@ziepe.ca, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org, l.sanfilippo@kunbus.com,
        peter.ujfalusi@linux.intel.com, jsnitsel@redhat.com,
        pmenzel@molgen.mpg.de
Subject: [PATCH v2] tpm: tpm_tis: Narrow the AAEON DMI quirk to UPX-i11 only
Date:   Wed, 24 May 2023 11:58:44 +0300
Message-Id: <20230524085844.11580-1-peter.ujfalusi@linux.intel.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

The original patch which added the quirk would apply to all AAEON machines,
which might or might not be valid.

The issue was discovered on UPX-i11 (Tiger Lake), it is not known if the
i12 (Alder Lake) version is affected.
UP2 (Apollo Lake) does not even have TPM module (no TPM drivers probing
and confirmed by dmidecode).

Let's make the quirk to be applicable for UPX-i11 (UPX-TGL01) only.

Fixes: 95a9359ee22f ("tpm: tpm_tis: Disable interrupts for AEON UPX-i11")
Suggested-by: Jerry Snitselaar <jsnitsel@redhat.com>
Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>
Signed-off-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
---
Hi Jarkko,

Changes since v1:
- Findings from Paul Menzel in the commit message has been addressed

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

