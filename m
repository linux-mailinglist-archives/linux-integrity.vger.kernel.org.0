Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A48A874D81D
	for <lists+linux-integrity@lfdr.de>; Mon, 10 Jul 2023 15:47:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233060AbjGJNr4 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 10 Jul 2023 09:47:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233141AbjGJNru (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 10 Jul 2023 09:47:50 -0400
Received: from mx.mylinuxtime.de (mx.mylinuxtime.de [IPv6:2a01:4f8:13a:16c2::25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CAC2135
        for <linux-integrity@vger.kernel.org>; Mon, 10 Jul 2023 06:47:41 -0700 (PDT)
Received: from leda.eworm.de (unknown [194.36.25.21])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mx.mylinuxtime.de (Postfix) with ESMTPSA id 07F7F23469A;
        Mon, 10 Jul 2023 15:39:04 +0200 (CEST)
Received: by leda.eworm.de (Postfix, from userid 1000)
        id A4EE01814B5; Mon, 10 Jul 2023 15:39:03 +0200 (CEST)
From:   Christian Hesse <mail@eworm.de>
To:     linux-integrity@vger.kernel.org
Cc:     Thorsten Leemhuis <regressions@leemhuis.info>,
        Lino Sanfilippo <l.sanfilippo@kunbus.com>,
        Linux kernel regressions list <regressions@lists.linux.dev>,
        Peter Huewe <peterhuewe@gmx.de>,
        Christian Hesse <mail@eworm.de>, stable@vger.kernel.org,
        roubro1991@gmail.com
Subject: [PATCH 1/2] tpm/tpm_tis: Disable interrupts for Framework Laptop Intel 12th gen
Date:   Mon, 10 Jul 2023 15:38:35 +0200
Message-ID: <20230710133836.4367-1-mail@eworm.de>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <c0ee4b7c-9d63-0bb3-c677-2be045deda43@leemhuis.info>
References: <c0ee4b7c-9d63-0bb3-c677-2be045deda43@leemhuis.info>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

This device suffer an irq storm, so add it in tpm_tis_dmi_table to
force polling.

https://bugs.archlinux.org/user/38129
https://bugzilla.kernel.org/show_bug.cgi?id=217631

Fixes: e644b2f498d297a928efcb7ff6f900c27f8b788e
Cc: stable@vger.kernel.org
Reported-by:  <roubro1991@gmail.com>
Signed-off-by: Christian Hesse <mail@eworm.de>
---
 drivers/char/tpm/tpm_tis.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/char/tpm/tpm_tis.c b/drivers/char/tpm/tpm_tis.c
index 7db3593941ea..2979f8b9aaa0 100644
--- a/drivers/char/tpm/tpm_tis.c
+++ b/drivers/char/tpm/tpm_tis.c
@@ -114,6 +114,14 @@ static int tpm_tis_disable_irq(const struct dmi_system_id *d)
 }
 
 static const struct dmi_system_id tpm_tis_dmi_table[] = {
+	{
+		.callback = tpm_tis_disable_irq,
+		.ident = "Framework Laptop Intel 12th gen",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Framework"),
+			DMI_MATCH(DMI_PRODUCT_VERSION, "A4"),
+		},
+	},
 	{
 		.callback = tpm_tis_disable_irq,
 		.ident = "ThinkPad T490s",
-- 
2.41.0

