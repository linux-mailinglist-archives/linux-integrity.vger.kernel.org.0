Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0DC26BCA13
	for <lists+linux-integrity@lfdr.de>; Thu, 16 Mar 2023 09:53:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231210AbjCPIxw (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 16 Mar 2023 04:53:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229985AbjCPIw7 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 16 Mar 2023 04:52:59 -0400
Received: from mail.nfschina.com (unknown [42.101.60.237])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B914B79F0;
        Thu, 16 Mar 2023 01:52:08 -0700 (PDT)
Received: from localhost (unknown [127.0.0.1])
        by mail.nfschina.com (Postfix) with ESMTP id D9D621A00ADB;
        Thu, 16 Mar 2023 16:51:25 +0800 (CST)
X-Virus-Scanned: amavisd-new at nfschina.com
Received: from mail.nfschina.com ([127.0.0.1])
        by localhost (localhost.localdomain [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id meKGZ0lKMs2B; Thu, 16 Mar 2023 16:51:25 +0800 (CST)
Received: from localhost.localdomain (unknown [180.167.10.98])
        (Authenticated sender: yuzhe@nfschina.com)
        by mail.nfschina.com (Postfix) with ESMTPA id 61B3E1A00874;
        Thu, 16 Mar 2023 16:51:24 +0800 (CST)
From:   Yu Zhe <yuzhe@nfschina.com>
To:     peterhuewe@gmx.de, jarkko@kernel.org, jgg@ziepe.ca
Cc:     linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org, liqiong@nfschina.com,
        Yu Zhe <yuzhe@nfschina.com>
Subject: [PATCH] tpm: remove unnecessary (void*) conversions
Date:   Thu, 16 Mar 2023 16:50:37 +0800
Message-Id: <20230316085037.21255-1-yuzhe@nfschina.com>
X-Mailer: git-send-email 2.11.0
X-Spam-Status: No, score=0.2 required=5.0 tests=BAYES_00,RCVD_IN_VALIDITY_RPBL,
        RDNS_NONE,SPF_HELO_NONE,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Pointer variables of void * type do not require type cast.

Signed-off-by: Yu Zhe <yuzhe@nfschina.com>
---
 drivers/char/tpm/eventlog/common.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/char/tpm/eventlog/common.c b/drivers/char/tpm/eventlog/common.c
index 8512ec76d526..639c3f395a5a 100644
--- a/drivers/char/tpm/eventlog/common.c
+++ b/drivers/char/tpm/eventlog/common.c
@@ -36,7 +36,7 @@ static int tpm_bios_measurements_open(struct inode *inode,
 		inode_unlock(inode);
 		return -ENODEV;
 	}
-	chip_seqops = (struct tpm_chip_seqops *)inode->i_private;
+	chip_seqops = inode->i_private;
 	seqops = chip_seqops->seqops;
 	chip = chip_seqops->chip;
 	get_device(&chip->dev);
@@ -55,8 +55,8 @@ static int tpm_bios_measurements_open(struct inode *inode,
 static int tpm_bios_measurements_release(struct inode *inode,
 					 struct file *file)
 {
-	struct seq_file *seq = (struct seq_file *)file->private_data;
-	struct tpm_chip *chip = (struct tpm_chip *)seq->private;
+	struct seq_file *seq = file->private_data;
+	struct tpm_chip *chip = seq->private;
 
 	put_device(&chip->dev);
 
-- 
2.11.0

