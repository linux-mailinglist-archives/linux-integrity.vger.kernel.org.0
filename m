Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F39F51D7F0
	for <lists+linux-integrity@lfdr.de>; Fri,  6 May 2022 14:33:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1392069AbiEFMg7 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 6 May 2022 08:36:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1392101AbiEFMgw (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 6 May 2022 08:36:52 -0400
Received: from smtp11.infineon.com (smtp11.infineon.com [IPv6:2a00:18f0:1e00:4::5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2EED6A418;
        Fri,  6 May 2022 05:32:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=infineon.com; i=@infineon.com; q=dns/txt; s=IFXMAIL;
  t=1651840374; x=1683376374;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=VYFmUvni3sr0e7gTHP7uul+cgiFgQYIDzKVxDbrcH/0=;
  b=ny2bw0FsbnNuM6cl9/VgFbwULI1Lbg+UCwPqnKG6uonU2T49O4ncElxw
   c5h7Q05/MC5za8yx9yCeoBSbBn3rMQuxI0Xd5ILsIuh5BTNQUdB2lF8iy
   3S8CWkrGfLPhmCEXQwdfW2kzRfc2X9PBvToS7G8/xYZU2PqclkjSmKKAr
   g=;
X-SBRS: None
X-IronPort-AV: E=McAfee;i="6400,9594,10338"; a="293244969"
X-IronPort-AV: E=Sophos;i="5.91,203,1647298800"; 
   d="scan'208";a="293244969"
Received: from unknown (HELO mucxv002.muc.infineon.com) ([172.23.11.17])
  by smtp11.infineon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2022 14:32:51 +0200
Received: from MUCSE803.infineon.com (MUCSE803.infineon.com [172.23.29.29])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mucxv002.muc.infineon.com (Postfix) with ESMTPS;
        Fri,  6 May 2022 14:32:50 +0200 (CEST)
Received: from MUCSE818.infineon.com (172.23.29.44) by MUCSE803.infineon.com
 (172.23.29.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Fri, 6 May 2022
 14:32:50 +0200
Received: from smaha-lin-dev01.agb.infineon.com (172.23.8.247) by
 MUCSE818.infineon.com (172.23.29.44) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Fri, 6 May 2022 14:32:50 +0200
From:   Stefan Mahnke-Hartmann <stefan.mahnke-hartmann@infineon.com>
To:     <jarkko@kernel.org>, <linux-integrity@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <Marten.Lindahl@axis.com>, <martenli@axis.com>, <jgg@ziepe.ca>,
        <jsnitsel@redhat.com>, <nayna@linux.vnet.ibm.com>,
        <johannes.holland@infineon.com>, <peterhuewe@gmx.de>,
        Stefan Mahnke-Hartmann <stefan.mahnke-hartmann@infineon.com>
Subject: [PATCH 2/2] tpm: Add Field Upgrade mode support for Infineon TPM2 modules
Date:   Fri, 6 May 2022 14:31:48 +0200
Message-ID: <20220506123145.229058-2-stefan.mahnke-hartmann@infineon.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220506123145.229058-1-stefan.mahnke-hartmann@infineon.com>
References: <20220506123145.229058-1-stefan.mahnke-hartmann@infineon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.23.8.247]
X-ClientProxiedBy: MUCSE801.infineon.com (172.23.29.27) To
 MUCSE818.infineon.com (172.23.29.44)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

TPM2_GetCapability with a capability that has the property type value
of TPM_PT_TOTAL_COMMANDS returns a zero length list, when an Infineon
TPM2 is in Field Upgrade mode.
Since an Infineon TPM2.0 in Field Upgrade mode returns RC_SUCCESS on
TPM2_Startup, the Field Upgrade mode has to be detected by
TPM2_GetCapability.

Signed-off-by: Stefan Mahnke-Hartmann <stefan.mahnke-hartmann@infineon.com>
---
 drivers/char/tpm/tpm2-cmd.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/char/tpm/tpm2-cmd.c b/drivers/char/tpm/tpm2-cmd.c
index e62a644ce26b..659130e2936e 100644
--- a/drivers/char/tpm/tpm2-cmd.c
+++ b/drivers/char/tpm/tpm2-cmd.c
@@ -746,6 +746,12 @@ int tpm2_auto_startup(struct tpm_chip *chip)
 	}
 
 	rc = tpm2_get_cc_attrs_tbl(chip);
+	/*
+	 * Infineon TPM in Field Upgrade mode will return no data for the number
+	 * of supported commands.
+	 */
+	if (rc == -ENODATA)
+		rc = TPM2_RC_UPGRADE;
 
 out:
 	if (rc == TPM2_RC_UPGRADE) {
-- 
2.25.1

