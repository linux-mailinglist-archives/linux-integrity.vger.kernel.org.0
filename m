Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FFCD47BC95
	for <lists+linux-integrity@lfdr.de>; Tue, 21 Dec 2021 10:10:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236142AbhLUJKI (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 21 Dec 2021 04:10:08 -0500
Received: from mail-m973.mail.163.com ([123.126.97.3]:37532 "EHLO
        mail-m973.mail.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbhLUJKI (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 21 Dec 2021 04:10:08 -0500
X-Greylist: delayed 917 seconds by postgrey-1.27 at vger.kernel.org; Tue, 21 Dec 2021 04:10:07 EST
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=gPtm4
        1ZRhN2hM6/uWkxP17bgJY7N8owgKDTDBYkkLEE=; b=HZqm69xsMl/M5Z2ptYTtS
        QMPPcI1giHMnW1Gm7D3H4LHkGM/D8XfdusdOH3ASlOxgVzYWGHmn4g209yyKdrhB
        rXT9Ayyo+h9X5UbBC1gUYxvTN9ab/w6K0KI+y3VxHptmPd0K3ZKLffQW618wcadX
        rINiKkHhHOsa/Wv5vxvEm4=
Received: from localhost.localdomain (unknown [36.112.214.113])
        by smtp3 (Coremail) with SMTP id G9xpCgB3W+8ulsFheyJVCQ--.60164S4;
        Tue, 21 Dec 2021 16:54:18 +0800 (CST)
From:   Jianglei Nie <niejianglei2021@163.com>
To:     jejb@linux.ibm.com, jarkko@kernel.org, zohar@linux.ibm.com,
        dhowells@redhat.com, jmorris@namei.org, serge@hallyn.com
Cc:     linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jianglei Nie <niejianglei2021@163.com>
Subject: [PATCH] security:trusted_tpm2: Fix memory leak in tpm2_key_encode()
Date:   Tue, 21 Dec 2021 16:54:04 +0800
Message-Id: <20211221085404.6769-1-niejianglei2021@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: G9xpCgB3W+8ulsFheyJVCQ--.60164S4
X-Coremail-Antispam: 1Uf129KBjvJXoWxJw18Ww1kWF15GryxurykXwb_yoW5GF4DpF
        ZxKF1UZFWagry7Ary7JF4Svr1Ska98Gr47KwsrW39rGasxJFsxtFy7Ar4YgrnrAFWfKw15
        ZF4qvFWUWrWqqwUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jhKsUUUUUU=
X-Originating-IP: [36.112.214.113]
X-CM-SenderInfo: xqlhyxxdqjzvrlsqjii6rwjhhfrp/xtbB3Q9wjGBHLhNxswAAs2
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
index 0165da386289..7bb1119b1dea 100644
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
+		 "BUG: scratch buffer is too small")) {
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

