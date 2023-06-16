Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32D817339D4
	for <lists+linux-integrity@lfdr.de>; Fri, 16 Jun 2023 21:27:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346134AbjFPT1c (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 16 Jun 2023 15:27:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346177AbjFPT1L (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 16 Jun 2023 15:27:11 -0400
Received: from frasgout12.his.huawei.com (unknown [14.137.139.154])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2138E4498
        for <linux-integrity@vger.kernel.org>; Fri, 16 Jun 2023 12:25:30 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.18.147.227])
        by frasgout12.his.huawei.com (SkyGuard) with ESMTP id 4QjTLZ40slz9xFbH
        for <linux-integrity@vger.kernel.org>; Sat, 17 Jun 2023 03:12:22 +0800 (CST)
Received: from huaweicloud.com (unknown [10.204.63.22])
        by APP2 (Coremail) with SMTP id GxC2BwAH2F7TtoxksMlFAw--.17356S3;
        Fri, 16 Jun 2023 20:24:14 +0100 (CET)
From:   Roberto Sassu <roberto.sassu@huaweicloud.com>
To:     zohar@linux.ibm.com, dmitry.kasatkin@gmail.com
Cc:     linux-integrity@vger.kernel.org, vt@altlinux.org, pvorel@suse.cz,
        stefanb@linux.ibm.com, paul@paul-moore.com, casey@schaufler-ca.com,
        Roberto Sassu <roberto.sassu@huawei.com>
Subject: [PATCH v3 ima-evm-utils 1/4] Include the filesystem UUID in HMAC calculation
Date:   Fri, 16 Jun 2023 21:23:55 +0200
Message-Id: <20230616192358.314906-2-roberto.sassu@huaweicloud.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230616192358.314906-1-roberto.sassu@huaweicloud.com>
References: <20230616192358.314906-1-roberto.sassu@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: GxC2BwAH2F7TtoxksMlFAw--.17356S3
X-Coremail-Antispam: 1UD129KBjvJXoWxJry3ur45Ar45Xw1fZryrZwb_yoW8Cw1kpa
        9ag345ta4ktF1xKFy3Aa1xua4rJ3y0yr13KwsrZw13ZasxWFWjqa4fKF4Yga45Xr1kAFyf
        Xw4akryF9ayDA3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUBFb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUGw
        A2048vs2IY020Ec7CjxVAFwI0_JFI_Gr1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
        w2x7M28EF7xvwVC0I7IYx2IY67AKxVWUCVW8JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
        W8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
        6r4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2
        WlYx0E2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7xkE
        bVWUJVW8JwACjcxG0xvY0x0EwIxGrwCY1x0262kKe7AKxVW8ZVWrXwCF04k20xvY0x0EwI
        xGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480
        Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7
        IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJwCI42IY6xAI
        w20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x
        0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x07j-pnQUUUUU=
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgAKBF1jj4rIbAAAsT
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        MAY_BE_FORGED,PDS_RDNS_DYNAMIC_FP,RDNS_DYNAMIC,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

From: Roberto Sassu <roberto.sassu@huawei.com>

Modify calc_evm_hmac() to include, similarly to calc_evm_hash(), the
filesystem UUID in the HMAC calculation.

If the -u option is not specified in the evmctl command line, the UUID of
the filesystem the input file resides on is taken for the calculation.

If a string is specified as a value for the -u option, that string is taken
as UUID (assuming that it is formatted correctly).

If no value is specified for the -u option, the filesystem UUID is not
included in the HMAC calculation.

Not including the filesystem UUID in the digest/HMAC calculation is needed
for the case where the kernel is compiled with CONFIG_EVM_ATTR_FSUUID=n, or
the digest/HMAC is not for an EVM portable signature.

Fixes: 1d24a94bb556 ("added uuid support for EVM")
Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 src/evmctl.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/src/evmctl.c b/src/evmctl.c
index c35a28c58f4..c24261cf0e6 100644
--- a/src/evmctl.c
+++ b/src/evmctl.c
@@ -1199,6 +1199,7 @@ static int calc_evm_hmac(const char *file, const char *keyfile, unsigned char *s
 	int keylen;
 	unsigned char evmkey[MAX_KEY_SIZE];
 	char list[1024];
+	char uuid[16];
 	ssize_t list_size;
 	struct h_misc_64 hmac_misc;
 	int hmac_size;
@@ -1330,6 +1331,18 @@ static int calc_evm_hmac(const char *file, const char *keyfile, unsigned char *s
 		log_err("EVP_DigestSignUpdate() failed\n");
 		goto out_ctx_cleanup;
 	}
+	if (!(hmac_flags & HMAC_FLAG_NO_UUID)) {
+		err = get_uuid(&st, uuid);
+		if (err)
+			goto out_ctx_cleanup;
+
+		err = EVP_DigestSignUpdate(pctx, (const unsigned char *)uuid,
+					   sizeof(uuid));
+		if (!err) {
+			log_err("EVP_DigestSignUpdate() failed\n");
+			goto out_ctx_cleanup;
+		}
+	}
 	err = EVP_DigestSignFinal(pctx, sig, &siglen);
 	if (err != 1)
 		log_err("EVP_DigestSignFinal() failed\n");
-- 
2.25.1

