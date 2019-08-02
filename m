Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1BCFE7FD15
	for <lists+linux-integrity@lfdr.de>; Fri,  2 Aug 2019 17:11:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729019AbfHBPLW (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 2 Aug 2019 11:11:22 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:33109 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726044AbfHBPLW (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 2 Aug 2019 11:11:22 -0400
Received: from LHREML711-CAH.china.huawei.com (unknown [172.18.7.108])
        by Forcepoint Email with ESMTP id D994141B3E5806BD2DD0;
        Fri,  2 Aug 2019 16:11:20 +0100 (IST)
Received: from roberto-HP-EliteDesk-800-G2-DM-65W.huawei.com (10.204.65.154)
 by smtpsuk.huawei.com (10.201.108.34) with Microsoft SMTP Server (TLS) id
 14.3.408.0; Fri, 2 Aug 2019 16:11:13 +0100
From:   Roberto Sassu <roberto.sassu@huawei.com>
To:     <jarkko.sakkinen@linux.intel.com>, <jejb@linux.ibm.com>,
        <zohar@linux.ibm.com>, <jgg@ziepe.ca>, <tyhicks@canonical.com>
CC:     <linux-integrity@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>,
        <keyrings@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <crazyt2019+lml@gmail.com>, <nayna@linux.vnet.ibm.com>,
        <silviu.vlasceanu@huawei.com>,
        Roberto Sassu <roberto.sassu@huawei.com>
Subject: [PATCH v2] KEYS: trusted: allow module init if TPM is inactive or deactivated
Date:   Fri, 2 Aug 2019 17:07:33 +0200
Message-ID: <20190802150733.1972-1-roberto.sassu@huawei.com>
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

However, trusted module initialization can still fail if the TPM is
inactive or deactivated. This patch ignores tpm_get_random() errors in
init_digests() and returns -EFAULT in pcrlock() if the TPM didn't return
random data.

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 security/keys/trusted.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/security/keys/trusted.c b/security/keys/trusted.c
index 9a94672e7adc..34f04ffcf2e5 100644
--- a/security/keys/trusted.c
+++ b/security/keys/trusted.c
@@ -389,6 +389,10 @@ static int pcrlock(const int pcrnum)
 	if (!capable(CAP_SYS_ADMIN))
 		return -EPERM;
 
+	/* This happens if the TPM didn't return random data */
+	if (!digests)
+		return -EFAULT;
+
 	return tpm_pcr_extend(chip, pcrnum, digests) ? -EINVAL : 0;
 }
 
@@ -1233,10 +1237,8 @@ static int __init init_digests(void)
 	int i;
 
 	ret = tpm_get_random(chip, digest, TPM_MAX_DIGEST_SIZE);
-	if (ret < 0)
-		return ret;
-	if (ret < TPM_MAX_DIGEST_SIZE)
-		return -EFAULT;
+	if (ret < 0 || ret < TPM_MAX_DIGEST_SIZE)
+		return 0;
 
 	digests = kcalloc(chip->nr_allocated_banks, sizeof(*digests),
 			  GFP_KERNEL);
-- 
2.17.1

