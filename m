Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB8916FE8FC
	for <lists+linux-integrity@lfdr.de>; Thu, 11 May 2023 02:54:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236082AbjEKAyy (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 10 May 2023 20:54:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232030AbjEKAyx (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 10 May 2023 20:54:53 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB4A62720
        for <linux-integrity@vger.kernel.org>; Wed, 10 May 2023 17:54:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1683766449;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=gQADr3uLo7kuMaIoXdW68k59lf8w0tnVTrTJLVpL2l4=;
        b=M2TlbuSFCvwf3UIPuO9k005kzaKzvtiQ11rzX7UNsZtIzo94zfqBEfynaEPksUDvQ0pxRM
        KW/xZwr2Dzg2pKedcSS/WRe1G02lX6q/wnB4czWTzeuHJzPGSIIYh72gHJw+NDNfS8j8r+
        +AmDf7XIhKagx3sPgx0dYrDd0xGhowk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-75-49nZcDDvOsKY-XjYHmJ1TQ-1; Wed, 10 May 2023 20:54:06 -0400
X-MC-Unique: 49nZcDDvOsKY-XjYHmJ1TQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E7AC2100F64F;
        Thu, 11 May 2023 00:54:05 +0000 (UTC)
Received: from cantor.redhat.com (unknown [10.2.16.36])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CD736141511D;
        Thu, 11 May 2023 00:54:04 +0000 (UTC)
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org
Cc:     Peter Zijlstra <peterz@infradead.org>, stable@vger.kernel.org,
        Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>
Subject: [PATCH] tpm/tpm_tis: Disable interrupts for more Lenovo devices
Date:   Wed, 10 May 2023 17:54:03 -0700
Message-Id: <20230511005403.24689-1-jsnitsel@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

The P360 Tiny suffers from an irq storm issue like the T490s, so add
an entry for it to tpm_tis_dmi_table, and force polling. There also
previously was a report from the previous attempt to enable interrupts
that involved a ThinkPad L490. So an entry is added for it as well.

Reported-by: Peter Zijlstra <peterz@infradead.org> # P360 Tiny
Closes: https://lore.kernel.org/linux-integrity/20230505130731.GO83892@hirez.programming.kicks-ass.net/
Cc: stable@vger.kernel.org # 6.2
Cc: Peter Huewe <peterhuewe@gmx.de>
Cc: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Jason Gunthorpe <jgg@ziepe.ca>
Signed-off-by: Jerry Snitselaar <jsnitsel@redhat.com>
---
 drivers/char/tpm/tpm_tis.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/char/tpm/tpm_tis.c b/drivers/char/tpm/tpm_tis.c
index 7af389806643..709b4e13bd6e 100644
--- a/drivers/char/tpm/tpm_tis.c
+++ b/drivers/char/tpm/tpm_tis.c
@@ -122,6 +122,22 @@ static const struct dmi_system_id tpm_tis_dmi_table[] = {
 			DMI_MATCH(DMI_PRODUCT_VERSION, "ThinkPad T490s"),
 		},
 	},
+	{
+		.callback = tpm_tis_disable_irq,
+		.ident = "ThinkStation P360 Tiny",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
+			DMI_MATCH(DMI_PRODUCT_VERSION, "ThinkStation P360 Tiny"),
+		},
+	},
+	{
+		.callback = tpm_tis_disable_irq,
+		.ident = "ThinkPad L490",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
+			DMI_MATCH(DMI_PRODUCT_VERSION, "ThinkPad L490"),
+		},
+	},
 	{}
 };
 
-- 
2.38.1

