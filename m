Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2BBF460A65
	for <lists+linux-integrity@lfdr.de>; Fri,  5 Jul 2019 18:41:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728560AbfGEQlC (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 5 Jul 2019 12:41:02 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:33057 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726302AbfGEQlC (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 5 Jul 2019 12:41:02 -0400
Received: from LHREML711-CAH.china.huawei.com (unknown [172.18.7.108])
        by Forcepoint Email with ESMTP id 01758ED5E91E14B571A7;
        Fri,  5 Jul 2019 17:41:00 +0100 (IST)
Received: from roberto-HP-EliteDesk-800-G2-DM-65W.huawei.com (10.204.65.154)
 by smtpsuk.huawei.com (10.201.108.34) with Microsoft SMTP Server (TLS) id
 14.3.408.0; Fri, 5 Jul 2019 17:40:52 +0100
From:   Roberto Sassu <roberto.sassu@huawei.com>
To:     <jarkko.sakkinen@linux.intel.com>, <jejb@linux.ibm.com>,
        <zohar@linux.ibm.com>, <jgg@ziepe.ca>
CC:     <linux-integrity@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>,
        <keyrings@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <crazyt2019+lml@gmail.com>, <tyhicks@canonical.com>,
        <nayna@linux.vnet.ibm.com>, <silviu.vlasceanu@huawei.com>,
        Roberto Sassu <roberto.sassu@huawei.com>
Subject: [PATCH] KEYS: trusted: allow module init if TPM is inactive or deactivated
Date:   Fri, 5 Jul 2019 18:37:35 +0200
Message-ID: <20190705163735.11539-1-roberto.sassu@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.204.65.154]
X-CFilter-Loop: Reflected
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Commit c78719203fc6 ("KEYS: trusted: allow trusted.ko to initialize w/o a
TPM") allows the trusted module to be loaded even a TPM is not found to
avoid module dependency problems.

Unfortunately, this does not completely solve the issue, as there could be
a case where a TPM is found but is not functional (the TPM commands return
an error). Specifically, after the tpm_chip structure is returned by
tpm_default_chip() in init_trusted(), the execution terminates after
init_digests() returns -EFAULT (due to the fact that tpm_get_random()
returns a positive value, but less than TPM_MAX_DIGEST_SIZE).

This patch fixes the issue by ignoring the TPM_ERR_DEACTIVATED and
TPM_ERR_DISABLED errors.

Fixes: 240730437deb ("KEYS: trusted: explicitly use tpm_chip structure...")
Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 drivers/char/tpm/tpm.h  | 2 --
 include/linux/tpm.h     | 3 +++
 security/keys/trusted.c | 6 +++++-
 3 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/char/tpm/tpm.h b/drivers/char/tpm/tpm.h
index e503ffc3aa39..a216ac396711 100644
--- a/drivers/char/tpm/tpm.h
+++ b/drivers/char/tpm/tpm.h
@@ -54,8 +54,6 @@ enum tpm_addr {
 
 #define TPM_WARN_RETRY          0x800
 #define TPM_WARN_DOING_SELFTEST 0x802
-#define TPM_ERR_DEACTIVATED     0x6
-#define TPM_ERR_DISABLED        0x7
 #define TPM_ERR_INVALID_POSTINIT 38
 
 #define TPM_HEADER_SIZE		10
diff --git a/include/linux/tpm.h b/include/linux/tpm.h
index 53c0ea9ec9df..efd3ccbb6aee 100644
--- a/include/linux/tpm.h
+++ b/include/linux/tpm.h
@@ -26,6 +26,9 @@
 #define TPM_DIGEST_SIZE 20	/* Max TPM v1.2 PCR size */
 #define TPM_MAX_DIGEST_SIZE SHA512_DIGEST_SIZE
 
+#define TPM_ERR_DEACTIVATED     0x6
+#define TPM_ERR_DISABLED        0x7
+
 struct tpm_chip;
 struct trusted_key_payload;
 struct trusted_key_options;
diff --git a/security/keys/trusted.c b/security/keys/trusted.c
index 9a94672e7adc..430d85090b3b 100644
--- a/security/keys/trusted.c
+++ b/security/keys/trusted.c
@@ -389,6 +389,10 @@ static int pcrlock(const int pcrnum)
 	if (!capable(CAP_SYS_ADMIN))
 		return -EPERM;
 
+	/* This can happen if the TPM is inactive. */
+	if (!digests)
+		return -EINVAL;
+
 	return tpm_pcr_extend(chip, pcrnum, digests) ? -EINVAL : 0;
 }
 
@@ -1233,7 +1237,7 @@ static int __init init_digests(void)
 	int i;
 
 	ret = tpm_get_random(chip, digest, TPM_MAX_DIGEST_SIZE);
-	if (ret < 0)
+	if (ret < 0 || ret == TPM_ERR_DEACTIVATED || ret == TPM_ERR_DISABLED)
 		return ret;
 	if (ret < TPM_MAX_DIGEST_SIZE)
 		return -EFAULT;
-- 
2.17.1

