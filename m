Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87A566B8041
	for <lists+linux-integrity@lfdr.de>; Mon, 13 Mar 2023 19:20:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230380AbjCMSUM (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 13 Mar 2023 14:20:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230516AbjCMSTz (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 13 Mar 2023 14:19:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F30DA77CA5;
        Mon, 13 Mar 2023 11:19:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 634B061471;
        Mon, 13 Mar 2023 18:19:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76C6CC433EF;
        Mon, 13 Mar 2023 18:19:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1678731564;
        bh=egvsBA0xTYE8cPXmnqy+IsmLfVywJIuZpjOIMPUg1GU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rNOQeNcgi7cuC5pqUmi5P77h8F+XyCf5UGuxFE4oxYLpbMQxtR6+GzbSTGqNWENV3
         mEqTbW47Om9NGXmcyvr8r6AvQSl/CEBDANlT+oF1iECVk2P7/9fNbYlxUvPL3QTIOg
         95xqsLYtxuJN0pVjcnrP7BRg71DLB7ZYNLKzftEM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     rafael@kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-integrity@vger.kernel.org
Subject: [PATCH 10/12] tpm: fix up the tpm_class shutdown_pre pointer when created
Date:   Mon, 13 Mar 2023 19:18:41 +0100
Message-Id: <20230313181843.1207845-10-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230313181843.1207845-1-gregkh@linuxfoundation.org>
References: <20230313181843.1207845-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2648; i=gregkh@linuxfoundation.org; h=from:subject; bh=egvsBA0xTYE8cPXmnqy+IsmLfVywJIuZpjOIMPUg1GU=; b=owGbwMvMwCRo6H6F97bub03G02pJDCn8mcxtF9kXf8xd/Fl1Z7lvecqW4Nc7bBdUKYqzBWcIH F+nafGoI5aFQZCJQVZMkeXLNp6j+ysOKXoZ2p6GmcPKBDKEgYtTACZyP4RhQdv0SW6vu2961G5U O6e4xO5kBZ90JMM8TeN55p9PRvhNubj0WuMygbVJnlubAQ==
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp; fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Do not wait until long after the struct class has been created to set
the shutdown_pre pointer for the tpm_class, assign it right away.

This is the only in-kernel offender that tries to modify the
device->class pointer contents after it has been assigned to a device,
so fix that up by doing the function pointer assignment before it is
matched with the device.  Because of this, the patch should go through
the driver core tree to allow later changes to struct device to be
possible.

Cc: Peter Huewe <peterhuewe@gmx.de>
Cc: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Jason Gunthorpe <jgg@ziepe.ca>
Cc: linux-integrity@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/char/tpm/tpm-chip.c      | 3 +--
 drivers/char/tpm/tpm-interface.c | 1 +
 drivers/char/tpm/tpm.h           | 1 +
 3 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/char/tpm/tpm-chip.c b/drivers/char/tpm/tpm-chip.c
index b99f55f2d4fd..7c444209a256 100644
--- a/drivers/char/tpm/tpm-chip.c
+++ b/drivers/char/tpm/tpm-chip.c
@@ -282,7 +282,7 @@ static void tpm_dev_release(struct device *dev)
  *
  * Return: always 0 (i.e. success)
  */
-static int tpm_class_shutdown(struct device *dev)
+int tpm_class_shutdown(struct device *dev)
 {
 	struct tpm_chip *chip = container_of(dev, struct tpm_chip, dev);
 
@@ -337,7 +337,6 @@ struct tpm_chip *tpm_chip_alloc(struct device *pdev,
 	device_initialize(&chip->dev);
 
 	chip->dev.class = tpm_class;
-	chip->dev.class->shutdown_pre = tpm_class_shutdown;
 	chip->dev.release = tpm_dev_release;
 	chip->dev.parent = pdev;
 	chip->dev.groups = chip->groups;
diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-interface.c
index 8763c820d1f8..43e23a04433a 100644
--- a/drivers/char/tpm/tpm-interface.c
+++ b/drivers/char/tpm/tpm-interface.c
@@ -467,6 +467,7 @@ static int __init tpm_init(void)
 	int rc;
 
 	tpm_class = class_create("tpm");
+	tpm_class->shutdown_pre = tpm_class_shutdown;
 	if (IS_ERR(tpm_class)) {
 		pr_err("couldn't create tpm class\n");
 		return PTR_ERR(tpm_class);
diff --git a/drivers/char/tpm/tpm.h b/drivers/char/tpm/tpm.h
index 24ee4e1cc452..a45eb39db0c4 100644
--- a/drivers/char/tpm/tpm.h
+++ b/drivers/char/tpm/tpm.h
@@ -183,6 +183,7 @@ int tpm1_get_pcr_allocation(struct tpm_chip *chip);
 unsigned long tpm_calc_ordinal_duration(struct tpm_chip *chip, u32 ordinal);
 int tpm_pm_suspend(struct device *dev);
 int tpm_pm_resume(struct device *dev);
+int tpm_class_shutdown(struct device *dev);
 
 static inline void tpm_msleep(unsigned int delay_msec)
 {
-- 
2.39.2

