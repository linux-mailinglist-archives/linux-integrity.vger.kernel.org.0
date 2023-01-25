Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78D8467ACD0
	for <lists+linux-integrity@lfdr.de>; Wed, 25 Jan 2023 09:51:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233453AbjAYIvu (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 25 Jan 2023 03:51:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229646AbjAYIvu (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 25 Jan 2023 03:51:50 -0500
Received: from frasgout13.his.huawei.com (frasgout13.his.huawei.com [14.137.139.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB778116
        for <linux-integrity@vger.kernel.org>; Wed, 25 Jan 2023 00:51:43 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.18.147.227])
        by frasgout13.his.huawei.com (SkyGuard) with ESMTP id 4P1y6k24pDz9xGnc
        for <linux-integrity@vger.kernel.org>; Wed, 25 Jan 2023 16:43:42 +0800 (CST)
Received: from huaweicloud.com (unknown [10.204.63.22])
        by APP1 (Coremail) with SMTP id LxC2BwD3fQmG7dBjf2fGAA--.15976S3;
        Wed, 25 Jan 2023 09:51:29 +0100 (CET)
From:   Roberto Sassu <roberto.sassu@huaweicloud.com>
To:     zohar@linux.ibm.com, dmitry.kasatkin@gmail.com
Cc:     linux-integrity@vger.kernel.org, vt@altlinux.org, pvorel@suse.cz,
        stefanb@linux.ibm.com, Roberto Sassu <roberto.sassu@huawei.com>
Subject: [PATCH ima-evm-utils v3 01/11] Fix error messages and vars in calc_evm_hmac()
Date:   Wed, 25 Jan 2023 09:50:20 +0100
Message-Id: <20230125085030.1568256-2-roberto.sassu@huaweicloud.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230125085030.1568256-1-roberto.sassu@huaweicloud.com>
References: <20230125085030.1568256-1-roberto.sassu@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: LxC2BwD3fQmG7dBjf2fGAA--.15976S3
X-Coremail-Antispam: 1UD129KBjvJXoW7try7trWDCr18WryDJF1UKFg_yoW8urWfpa
        9rWw15Wr18tFyjkrW7CF4ku3W5ArWxtr15J3yjga43ZasrJa4DtaySyF4F93y8JFWkAa48
        Jr4Y9a4F9a1kAr7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvlb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUGw
        A2048vs2IY020Ec7CjxVAFwI0_JFI_Gr1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
        w2x7M28EF7xvwVC0I7IYx2IY67AKxVWUJVWUCwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
        W8JVWxJwA2z4x0Y4vEx4A2jsIE14v26r4j6F4UM28EF7xvwVC2z280aVCY1x0267AKxVW8
        JVW8Jr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx
        0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWU
        JVW8JwACjcxG0xvY0x0EwIxGrwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJV
        W8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF
        1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6x
        IIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvE
        x4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvj
        DU0xZFpf9x07UiAwxUUUUU=
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQAIBF1jj4gLMgAAsN
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

From: Roberto Sassu <roberto.sassu@huawei.com>

Make sure that the function name in the error message corresponds to the
actual function called.

Rename mdlen and hash respectively to siglen and sig. Also, initialize
siglen to the size of sig (MAX_DIGEST_SIZE), as this is recommended in the
documentation of EVP_DigestSignFinal().

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
---
 src/evmctl.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/src/evmctl.c b/src/evmctl.c
index 0ac7930da6f2..91b531c9e01e 100644
--- a/src/evmctl.c
+++ b/src/evmctl.c
@@ -1184,9 +1184,9 @@ static int cmd_setxattr_ima(struct command *cmd)
 
 #define MAX_KEY_SIZE 128
 
-static int calc_evm_hmac(const char *file, const char *keyfile, unsigned char *hash)
+static int calc_evm_hmac(const char *file, const char *keyfile, unsigned char *sig)
 {
-	size_t mdlen;
+	size_t siglen = MAX_DIGEST_SIZE;
 	EVP_MD_CTX *pctx;
 	EVP_PKEY *pkey = NULL;
 	struct stat st;
@@ -1260,7 +1260,7 @@ static int calc_evm_hmac(const char *file, const char *keyfile, unsigned char *h
 
 	pkey = EVP_PKEY_new_mac_key(EVP_PKEY_HMAC, NULL, evmkey, sizeof(evmkey));
 	if (!pkey) {
-		log_err("HMAC_Init() failed\n");
+		log_err("EVP_PKEY_new_mac_key() failed\n");
 		goto out;
 	}
 
@@ -1326,12 +1326,12 @@ static int calc_evm_hmac(const char *file, const char *keyfile, unsigned char *h
 
 	err = EVP_DigestSignUpdate(pctx, &hmac_misc, hmac_size);
 	if (err != 1) {
-		log_err("HMAC_Update() failed\n");
+		log_err("EVP_DigestSignUpdate() failed\n");
 		goto out_ctx_cleanup;
 	}
-	err = EVP_DigestSignFinal(pctx, hash, &mdlen);
+	err = EVP_DigestSignFinal(pctx, sig, &siglen);
 	if (err != 1)
-		log_err("HMAC_Final() failed\n");
+		log_err("EVP_DigestSignFinal() failed\n");
 out_ctx_cleanup:
 	EVP_PKEY_free(pkey);
 #if OPENSSL_VERSION_NUMBER >= 0x10100000
@@ -1340,7 +1340,7 @@ out_ctx_cleanup:
 out:
 	free(key);
 	if (err == 1)
-		return mdlen;
+		return siglen;
 	return err;
 }
 
-- 
2.25.1

