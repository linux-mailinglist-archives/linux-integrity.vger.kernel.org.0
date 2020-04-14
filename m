Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 880811A79CC
	for <lists+linux-integrity@lfdr.de>; Tue, 14 Apr 2020 13:42:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439492AbgDNLmj (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 14 Apr 2020 07:42:39 -0400
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133]:52198 "EHLO
        out30-133.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2439489AbgDNLmi (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 14 Apr 2020 07:42:38 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04397;MF=tianjia.zhang@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0TvX5Wi8_1586864546;
Received: from localhost(mailfrom:tianjia.zhang@linux.alibaba.com fp:SMTPD_---0TvX5Wi8_1586864546)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 14 Apr 2020 19:42:27 +0800
From:   Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
To:     peterhuewe@gmx.de, jarkko.sakkinen@linux.intel.com, jgg@ziepe.ca,
        arnd@arndb.de, gregkh@linuxfoundation.org,
        zhang.jia@linux.alibaba.com
Cc:     linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        tianjia.zhang@linux.alibaba.com
Subject: [PATCH] tpm: fix wrong return value in tpm_pcr_extend
Date:   Tue, 14 Apr 2020 19:42:26 +0800
Message-Id: <20200414114226.96691-1-tianjia.zhang@linux.alibaba.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

For the algorithm that does not match the bank, a positive
value EINVAL is returned here. I think this is a typo error.
It is necessary to return an error value.

Signed-off-by: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
---
 drivers/char/tpm/tpm-interface.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-interface.c
index a438b1206fcb..1621ce818705 100644
--- a/drivers/char/tpm/tpm-interface.c
+++ b/drivers/char/tpm/tpm-interface.c
@@ -323,7 +323,7 @@ int tpm_pcr_extend(struct tpm_chip *chip, u32 pcr_idx,
 
 	for (i = 0; i < chip->nr_allocated_banks; i++) {
 		if (digests[i].alg_id != chip->allocated_banks[i].alg_id) {
-			rc = EINVAL;
+			rc = -EINVAL;
 			goto out;
 		}
 	}
-- 
2.17.1

