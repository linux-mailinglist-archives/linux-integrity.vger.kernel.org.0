Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67BAA6395C0
	for <lists+linux-integrity@lfdr.de>; Sat, 26 Nov 2022 12:39:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229509AbiKZLjl (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sat, 26 Nov 2022 06:39:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbiKZLjk (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sat, 26 Nov 2022 06:39:40 -0500
X-Greylist: delayed 450 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 26 Nov 2022 03:39:39 PST
Received: from smtp.smtpout.orange.fr (smtp-20.smtpout.orange.fr [80.12.242.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8D0CC1A20E
        for <linux-integrity@vger.kernel.org>; Sat, 26 Nov 2022 03:39:39 -0800 (PST)
Received: from pop-os.home ([86.243.100.34])
        by smtp.orange.fr with ESMTPA
        id ytPio8ERzOAzAytPioz7Fj; Sat, 26 Nov 2022 12:32:07 +0100
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sat, 26 Nov 2022 12:32:07 +0100
X-ME-IP: 86.243.100.34
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-integrity@vger.kernel.org
Subject: [PATCH] tpm_crb: Remove a useless include
Date:   Sat, 26 Nov 2022 12:32:05 +0100
Message-Id: <9ebb8c8c3f19bc85fabcfea787d9a04454114b16.1669462318.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

This file does not use rcu, so there is no point in including
<linux/rculist.h>.

So just remove it.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/char/tpm/tpm_crb.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/char/tpm/tpm_crb.c b/drivers/char/tpm/tpm_crb.c
index 18606651d1aa..05b5522bdd2b 100644
--- a/drivers/char/tpm/tpm_crb.c
+++ b/drivers/char/tpm/tpm_crb.c
@@ -13,7 +13,6 @@
 
 #include <linux/acpi.h>
 #include <linux/highmem.h>
-#include <linux/rculist.h>
 #include <linux/module.h>
 #include <linux/pm_runtime.h>
 #ifdef CONFIG_ARM64
-- 
2.34.1

