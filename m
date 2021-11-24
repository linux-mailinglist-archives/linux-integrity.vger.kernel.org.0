Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0B6B45CA87
	for <lists+linux-integrity@lfdr.de>; Wed, 24 Nov 2021 18:02:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349391AbhKXRFT (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 24 Nov 2021 12:05:19 -0500
Received: from mail-m972.mail.163.com ([123.126.97.2]:47782 "EHLO
        mail-m972.mail.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242707AbhKXRFT (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 24 Nov 2021 12:05:19 -0500
X-Greylist: delayed 924 seconds by postgrey-1.27 at vger.kernel.org; Wed, 24 Nov 2021 12:05:17 EST
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=8ERBp
        /cCG6WzioJCfEWJSK1orI4R+L3An4qXLiZdnB0=; b=OXoqhebDEZzeJ7/tZsJ8J
        SmHIkZsNHWXXKsahcfmp5T5PaR4vFOn43TKWCwZtcdsvse2Y3iS9n2yfkEkCP2Ci
        UjVtEpPgC5S6Qv0Tiq1HAYq9yLfeKz9fnQYKqFL7FONJ8brCFR5+TGnmQhNDGfVy
        crGX80h2iLKCQeg3+CzZFY=
Received: from localhost.localdomain (unknown [218.106.182.227])
        by smtp2 (Coremail) with SMTP id GtxpCgBHHNXNa55h7hmJKQ--.39097S4;
        Thu, 25 Nov 2021 00:44:01 +0800 (CST)
From:   Jianglei Nie <niejianglei2021@163.com>
To:     jejb@linux.ibm.com, jarkko@kernel.org, zohar@linux.ibm.com,
        dhowells@redhat.com, jmorris@namei.org, serge@hallyn.com
Cc:     linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jianglei Nie <niejianglei@gmail.com>
Subject: [PATCH] security:trusted_tpm2: Fix memory leak in tpm2_key_encode()
Date:   Thu, 25 Nov 2021 00:43:54 +0800
Message-Id: <20211124164354.20448-1-niejianglei2021@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: GtxpCgBHHNXNa55h7hmJKQ--.39097S4
X-Coremail-Antispam: 1Uf129KBjvJXoWxJw18Ww1kWF15Gry3XrWrZrb_yoW5XryUpF
        ZxKF17ZrWagry7Ary7Ja1Svr1fCay5Gr47GwsrW39rGasxJFsxtFy7ArWYgrnrAFWfKw15
        ZF4qvFWUWrWDtrUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07bY2-5UUUUU=
X-Originating-IP: [218.106.182.227]
X-CM-SenderInfo: xqlhyxxdqjzvrlsqjii6rwjhhfrp/1tbi6xFVjFXlyRVF+AAAsy
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

From: Jianglei Nie <niejianglei@gmail.com>

Line 36 (#1) allocates a memory chunk for scratch by kmalloc(), but
it is never freed through the function, which will lead to a memory
leak.

We should kfree() scratch before the function returns (#2, #3 and #4).

31 static int tpm2_key_encode(struct trusted_key_payload *payload,
32			   struct trusted_key_options *options,
33			   u8 *src, u32 len)
34 {
36	u8 *scratch = kmalloc(SCRATCH_SIZE, GFP_KERNEL);
        // #1: kmalloc space
37	u8 *work = scratch, *work1;
50	if (!scratch)
51		return -ENOMEM;

56	if (options->blobauth_len == 0) {
60		if (WARN(IS_ERR(w), "BUG: Boolean failed to encode"))
61			return PTR_ERR(w); // #2: missing kfree
63	}

71	if (WARN(work - scratch + pub_len + priv_len + 14 > SCRATCH_SIZE,
72		 "BUG: scratch buffer is too small"))
73		return -EINVAL; // #3: missing kfree

  	// #4: missing kfree: scratch is never used afterwards.
82	if (WARN(IS_ERR(work1), "BUG: ASN.1 encoder failed"))
83		return PTR_ERR(work1);

85	return work1 - payload->blob;
86 }

Signed-off-by: Jianglei Nie <niejianglei@gmail.com>
---
 security/keys/trusted-keys/trusted_tpm2.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/security/keys/trusted-keys/trusted_tpm2.c b/security/keys/trusted-keys/trusted_tpm2.c
index 0165da386289..99bb8b2409ac 100644
--- a/security/keys/trusted-keys/trusted_tpm2.c
+++ b/security/keys/trusted-keys/trusted_tpm2.c
@@ -57,8 +57,10 @@ static int tpm2_key_encode(struct trusted_key_payload *payload,
 		unsigned char bool[3], *w = bool;
 		/* tag 0 is emptyAuth */
 		w = asn1_encode_boolean(w, w + sizeof(bool), true);
-		if (WARN(IS_ERR(w), "BUG: Boolean failed to encode"))
+		if (WARN(IS_ERR(w), "BUG: Boolean failed to encode")) {
+			kfree(scratch);
 			return PTR_ERR(w);
+		}
 		work = asn1_encode_tag(work, end_work, 0, bool, w - bool);
 	}
 
@@ -69,8 +71,10 @@ static int tpm2_key_encode(struct trusted_key_payload *payload,
 	 * trigger, so if it does there's something nefarious going on
 	 */
 	if (WARN(work - scratch + pub_len + priv_len + 14 > SCRATCH_SIZE,
-		 "BUG: scratch buffer is too small"))
+		 "BUG: scratch buffer is too small")){
+		kfree(scratch);
 		return -EINVAL;
+	}
 
 	work = asn1_encode_integer(work, end_work, options->keyhandle);
 	work = asn1_encode_octet_string(work, end_work, pub, pub_len);
@@ -79,6 +83,7 @@ static int tpm2_key_encode(struct trusted_key_payload *payload,
 	work1 = payload->blob;
 	work1 = asn1_encode_sequence(work1, work1 + sizeof(payload->blob),
 				     scratch, work - scratch);
+	kfree(scratch);
 	if (WARN(IS_ERR(work1), "BUG: ASN.1 encoder failed"))
 		return PTR_ERR(work1);
 
-- 
2.25.1

