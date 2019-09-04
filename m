Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D7B31A8DA1
	for <lists+linux-integrity@lfdr.de>; Wed,  4 Sep 2019 21:32:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731625AbfIDRXy (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 4 Sep 2019 13:23:54 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:33256 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731447AbfIDRXy (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 4 Sep 2019 13:23:54 -0400
Received: from lhreml704-cah.china.huawei.com (unknown [172.18.7.106])
        by Forcepoint Email with ESMTP id 187B65B3F6DB77A72A5B;
        Wed,  4 Sep 2019 18:23:52 +0100 (IST)
Received: from roberto-HP-EliteDesk-800-G2-DM-65W.huawei.com (10.204.65.154)
 by smtpsuk.huawei.com (10.201.108.45) with Microsoft SMTP Server (TLS) id
 14.3.408.0; Wed, 4 Sep 2019 18:23:41 +0100
From:   Roberto Sassu <roberto.sassu@huawei.com>
To:     <jarkko.sakkinen@linux.intel.com>, <zohar@linux.ibm.com>
CC:     <linux-integrity@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>,
        <keyrings@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <silviu.vlasceanu@huawei.com>,
        Roberto Sassu <roberto.sassu@huawei.com>
Subject: [PATCH] KEYS: trusted: correctly initialize digests and fix locking issue
Date:   Wed, 4 Sep 2019 19:23:18 +0200
Message-ID: <20190904172318.610-1-roberto.sassu@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.204.65.154]
X-CFilter-Loop: Reflected
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

This patch fixes two issues introduced with commit 240730437deb ("KEYS:
trusted: explicitly use tpm_chip structure from tpm_default_chip()").

It initializes the algorithm in init_digests() for trusted keys, and moves
the algorithm check in tpm_pcr_extend() before locks are taken in
tpm_find_get_ops().

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
Fixes: 240730437deb ("KEYS: trusted: explicitly use tpm_chip structure from tpm_default_chip()")
---
 drivers/char/tpm/tpm-interface.c | 8 ++++----
 security/keys/trusted.c          | 5 +++++
 2 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-interface.c
index 1b4f95c13e00..1fffa91fc148 100644
--- a/drivers/char/tpm/tpm-interface.c
+++ b/drivers/char/tpm/tpm-interface.c
@@ -316,14 +316,14 @@ int tpm_pcr_extend(struct tpm_chip *chip, u32 pcr_idx,
 	int rc;
 	int i;
 
-	chip = tpm_find_get_ops(chip);
-	if (!chip)
-		return -ENODEV;
-
 	for (i = 0; i < chip->nr_allocated_banks; i++)
 		if (digests[i].alg_id != chip->allocated_banks[i].alg_id)
 			return -EINVAL;
 
+	chip = tpm_find_get_ops(chip);
+	if (!chip)
+		return -ENODEV;
+
 	if (chip->flags & TPM_CHIP_FLAG_TPM2) {
 		rc = tpm2_pcr_extend(chip, pcr_idx, digests);
 		tpm_put_ops(chip);
diff --git a/security/keys/trusted.c b/security/keys/trusted.c
index ade699131065..1fbd77816610 100644
--- a/security/keys/trusted.c
+++ b/security/keys/trusted.c
@@ -1228,11 +1228,16 @@ static int __init trusted_shash_alloc(void)
 
 static int __init init_digests(void)
 {
+	int i;
+
 	digests = kcalloc(chip->nr_allocated_banks, sizeof(*digests),
 			  GFP_KERNEL);
 	if (!digests)
 		return -ENOMEM;
 
+	for (i = 0; i < chip->nr_allocated_banks; i++)
+		digests[i].alg_id = chip->allocated_banks[i].alg_id;
+
 	return 0;
 }
 
-- 
2.17.1

