Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06FF0471A83
	for <lists+linux-integrity@lfdr.de>; Sun, 12 Dec 2021 14:55:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231298AbhLLNzX (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 12 Dec 2021 08:55:23 -0500
Received: from mail-m971.mail.163.com ([123.126.97.1]:33742 "EHLO
        mail-m971.mail.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229979AbhLLNzX (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 12 Dec 2021 08:55:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=cdE7N
        cm9pcQKaI/4ppM0Xh5ubS5gPNoRT9n4pnfsXNs=; b=JAArMrvR0UajIpByVpHFM
        X3hCg5Dcp+wJRdyxipD00Fw4+hjSO2ishCUReaCUuzMwRipbIYX+1Av0u/CrEbAx
        39FB5A7wglb1cCz7v1Y3xY+MRcJtI/QaNWbHLLdk5DByXWtAM23TfjwhVTA6+iKX
        j4S6Wh3kaozRisa3cHFTfw=
Received: from localhost.localdomain (unknown [36.112.214.113])
        by smtp1 (Coremail) with SMTP id GdxpCgBHmx_9_rVhaB4NBQ--.25678S4;
        Sun, 12 Dec 2021 21:54:33 +0800 (CST)
From:   Jianglei Nie <niejianglei2021@163.com>
To:     jejb@linux.ibm.com, jarkko@kernel.org, zohar@linux.ibm.com,
        dhowells@redhat.com, jmorris@namei.org, serge@hallyn.com
Cc:     linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jianglei Nie <niejianglei2021@163.com>
Subject: [PATCH] security:trusted_tpm2: Fix memory leak in tpm2_key_encode()
Date:   Sun, 12 Dec 2021 21:54:03 +0800
Message-Id: <20211212135403.59724-1-niejianglei2021@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: GdxpCgBHmx_9_rVhaB4NBQ--.25678S4
X-Coremail-Antispam: 1Uf129KBjvJXoW7Ww4DGFy7XF4UZr4xZrWrKrg_yoW8Kw4fpF
        W5KF1UZrWagry7Ary7JF4Svr1fCa98KF47Kws7W39rG3ZxJFsxtFy7Ar4Ygr17ZFWfKw15
        Za1qvFWUWrWqvwUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jf9N3UUUUU=
X-Originating-IP: [36.112.214.113]
X-CM-SenderInfo: xqlhyxxdqjzvrlsqjii6rwjhhfrp/1tbi6xlnjFXlyhOO9wAAsJ
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

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

Signed-off-by: Jianglei Nie <niejianglei2021@163.com>
---
 security/keys/trusted-keys/trusted_tpm2.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/security/keys/trusted-keys/trusted_tpm2.c b/security/keys/trusted-keys/trusted_tpm2.c
index 0165da386289..3408a74c855f 100644
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
 
@@ -69,9 +71,12 @@ static int tpm2_key_encode(struct trusted_key_payload *payload,
 	 * trigger, so if it does there's something nefarious going on
 	 */
 	if (WARN(work - scratch + pub_len + priv_len + 14 > SCRATCH_SIZE,
-		 "BUG: scratch buffer is too small"))
+		 "BUG: scratch buffer is too small")) {
+		kfree(scratch);
 		return -EINVAL;
+	}
 
+	kfree(scratch);
 	work = asn1_encode_integer(work, end_work, options->keyhandle);
 	work = asn1_encode_octet_string(work, end_work, pub, pub_len);
 	work = asn1_encode_octet_string(work, end_work, priv, priv_len);
-- 
2.25.1

