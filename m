Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6269374E01F
	for <lists+linux-integrity@lfdr.de>; Mon, 10 Jul 2023 23:16:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229582AbjGJVQu (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 10 Jul 2023 17:16:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjGJVQu (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 10 Jul 2023 17:16:50 -0400
Received: from mx.mylinuxtime.de (mx.mylinuxtime.de [IPv6:2a01:4f8:13a:16c2::25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42037B7
        for <linux-integrity@vger.kernel.org>; Mon, 10 Jul 2023 14:16:49 -0700 (PDT)
Received: from leda.eworm.de (p5085aabd.dip0.t-ipconnect.de [80.133.170.189])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mx.mylinuxtime.de (Postfix) with ESMTPSA id A103C23645D;
        Mon, 10 Jul 2023 23:16:47 +0200 (CEST)
Received: by leda.eworm.de (Postfix, from userid 1000)
        id 56F6B1831DF; Mon, 10 Jul 2023 23:16:47 +0200 (CEST)
From:   Christian Hesse <mail@eworm.de>
To:     linux-integrity@vger.kernel.org
Cc:     Thorsten Leemhuis <regressions@leemhuis.info>,
        Lino Sanfilippo <l.sanfilippo@kunbus.com>,
        Linux kernel regressions list <regressions@lists.linux.dev>,
        Peter Huewe <peterhuewe@gmx.de>,
        Christian Hesse <mail@eworm.de>, stable@vger.kernel.org,
        roubro1991@gmail.com
Subject: [PATCH v3 2/2] tpm/tpm_tis: Disable interrupts for Framework Laptop Intel 13th gen
Date:   Mon, 10 Jul 2023 23:16:10 +0200
Message-ID: <20230710211635.4735-2-mail@eworm.de>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230710211635.4735-1-mail@eworm.de>
References: <20230710231315.4ef54679@leda.eworm.net>
 <20230710211635.4735-1-mail@eworm.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_PDS_OTHER_BAD_TLD,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

This device suffer an irq storm, so add it in tpm_tis_dmi_table to
force polling.

Link: https://community.frame.work/t/boot-and-shutdown-hangs-with-arch-linux-kernel-6-4-1-mainline-and-arch/33118
Fixes: e644b2f498d2 ("tpm, tpm_tis: Enable interrupt test")
Cc: stable@vger.kernel.org
Reported-by: <roubro1991@gmail.com>
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=217631
Signed-off-by: Christian Hesse <mail@eworm.de>
---
 drivers/char/tpm/tpm_tis.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/char/tpm/tpm_tis.c b/drivers/char/tpm/tpm_tis.c
index 52bb8b642207..f8a8587c66f3 100644
--- a/drivers/char/tpm/tpm_tis.c
+++ b/drivers/char/tpm/tpm_tis.c
@@ -122,6 +122,14 @@ static const struct dmi_system_id tpm_tis_dmi_table[] = {
 			DMI_MATCH(DMI_PRODUCT_NAME, "Laptop (12th Gen Intel Core)"),
 		},
 	},
+	{
+		.callback = tpm_tis_disable_irq,
+		.ident = "Framework Laptop (13th Gen Intel Core)",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Framework"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Laptop (13th Gen Intel Core)"),
+		},
+	},
 	{
 		.callback = tpm_tis_disable_irq,
 		.ident = "ThinkPad T490s",
-- 
2.41.0

