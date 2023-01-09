Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FA26662BE0
	for <lists+linux-integrity@lfdr.de>; Mon,  9 Jan 2023 17:57:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233794AbjAIQ5Q (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 9 Jan 2023 11:57:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236962AbjAIQ4y (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 9 Jan 2023 11:56:54 -0500
Received: from frasgout12.his.huawei.com (frasgout12.his.huawei.com [14.137.139.154])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB75222A
        for <linux-integrity@vger.kernel.org>; Mon,  9 Jan 2023 08:56:52 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.18.147.228])
        by frasgout12.his.huawei.com (SkyGuard) with ESMTP id 4NrKfH3NCLz9v7Z2
        for <linux-integrity@vger.kernel.org>; Tue, 10 Jan 2023 00:49:11 +0800 (CST)
Received: from huaweicloud.com (unknown [10.204.63.22])
        by APP2 (Coremail) with SMTP id GxC2BwCXHWQ9R7xjPQWBAA--.14103S3;
        Mon, 09 Jan 2023 17:56:38 +0100 (CET)
From:   Roberto Sassu <roberto.sassu@huaweicloud.com>
To:     zohar@linux.ibm.com, dmitry.kasatkin@gmail.com
Cc:     linux-integrity@vger.kernel.org, vt@altlinux.org,
        Roberto Sassu <roberto.sassu@huawei.com>
Subject: [PATCH ima-evm-utils 1/8] Fix error messages and mdlen init in calc_evm_hmac()
Date:   Mon,  9 Jan 2023 17:55:45 +0100
Message-Id: <20230109165552.3409716-2-roberto.sassu@huaweicloud.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230109165552.3409716-1-roberto.sassu@huaweicloud.com>
References: <20230109165552.3409716-1-roberto.sassu@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: GxC2BwCXHWQ9R7xjPQWBAA--.14103S3
X-Coremail-Antispam: 1UD129KBjvJXoW7try3Cw45Xw1DJw4UZr1DZFb_yoW8Ww18pa
        9rWw1DGw18tryj9FWUCF4kCa1UJrWIyr1Utw42ga4fZasrJF9FyayxAF4F9rWUJFWkAa4f
        JF4Fya4rua1kAr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUBFb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUGw
        A2048vs2IY020Ec7CjxVAFwI0_Jrv_JF4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
        w2x7M28EF7xvwVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
        W8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
        6r4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2
        WlYx0E2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkE
        bVWUJVW8JwACjcxG0xvY0x0EwIxGrwCY1x0262kKe7AKxVW8ZVWrXwCF04k20xvY0x0EwI
        xGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480
        Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7
        IYx2IY67AKxVW8JVW5JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJwCI42IY6xAI
        w20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x
        0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x07j4BTOUUUUU=
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgAMBF1jj4NhmgAAsD
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

From: Roberto Sassu <roberto.sassu@huawei.com>

Make sure that the function name in the error message corresponds to the
actual function called. Also, initialize mdlen to the size of 'hash'
(MAX_DIGEST_SIZE), as this is expected by EVP_DigestSignFinal().

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 src/evmctl.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/src/evmctl.c b/src/evmctl.c
index 0ac7930da6f2..d4912d7ee891 100644
--- a/src/evmctl.c
+++ b/src/evmctl.c
@@ -1186,7 +1186,7 @@ static int cmd_setxattr_ima(struct command *cmd)
 
 static int calc_evm_hmac(const char *file, const char *keyfile, unsigned char *hash)
 {
-	size_t mdlen;
+	size_t mdlen = MAX_DIGEST_SIZE;
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
 	err = EVP_DigestSignFinal(pctx, hash, &mdlen);
 	if (err != 1)
-		log_err("HMAC_Final() failed\n");
+		log_err("EVP_DigestSignFinal() failed\n");
 out_ctx_cleanup:
 	EVP_PKEY_free(pkey);
 #if OPENSSL_VERSION_NUMBER >= 0x10100000
-- 
2.25.1

