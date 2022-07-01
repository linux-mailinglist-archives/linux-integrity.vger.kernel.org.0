Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06A2A562F9C
	for <lists+linux-integrity@lfdr.de>; Fri,  1 Jul 2022 11:14:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234028AbiGAJN1 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 1 Jul 2022 05:13:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233002AbiGAJN1 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 1 Jul 2022 05:13:27 -0400
Received: from out30-42.freemail.mail.aliyun.com (out30-42.freemail.mail.aliyun.com [115.124.30.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA75135DDE;
        Fri,  1 Jul 2022 02:13:25 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R811e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0VI0Z9O5_1656666803;
Received: from localhost(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0VI0Z9O5_1656666803)
          by smtp.aliyun-inc.com;
          Fri, 01 Jul 2022 17:13:23 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     peterhuewe@gmx.de
Cc:     jarkko@kernel.org, jgg@ziepe.ca, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org, Yang Li <yang.lee@linux.alibaba.com>
Subject: [PATCH -next] tpm: fix platform_no_drv_owner.cocci warning
Date:   Fri,  1 Jul 2022 17:13:22 +0800
Message-Id: <20220701091322.59384-1-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Eliminate the following coccicheck warning:
./drivers/char/tpm/tpm_tis_i2c.c:379:3-8: No need to set .owner here.  The core will do it.

Remove .owner field if calls are used which set it automatically

Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 drivers/char/tpm/tpm_tis_i2c.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/char/tpm/tpm_tis_i2c.c b/drivers/char/tpm/tpm_tis_i2c.c
index 8e0686fe4eb1..ba0911b1d1ff 100644
--- a/drivers/char/tpm/tpm_tis_i2c.c
+++ b/drivers/char/tpm/tpm_tis_i2c.c
@@ -376,7 +376,6 @@ MODULE_DEVICE_TABLE(of, of_tis_i2c_match);
 
 static struct i2c_driver tpm_tis_i2c_driver = {
 	.driver = {
-		.owner = THIS_MODULE,
 		.name = "tpm_tis_i2c",
 		.pm = &tpm_tis_pm,
 		.of_match_table = of_match_ptr(of_tis_i2c_match),
-- 
2.20.1.7.g153144c

