Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2BE453F7CC
	for <lists+linux-integrity@lfdr.de>; Tue,  7 Jun 2022 10:02:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237984AbiFGIC6 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 7 Jun 2022 04:02:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231132AbiFGIC5 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 7 Jun 2022 04:02:57 -0400
X-Greylist: delayed 915 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 07 Jun 2022 01:02:54 PDT
Received: from mail-m972.mail.163.com (mail-m972.mail.163.com [123.126.97.2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8029F35878;
        Tue,  7 Jun 2022 01:02:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=FzsQe
        Klfx+PTNhydCXy5arK4m63g42oEcDpVKHz+ar0=; b=Eqd5XGCE4BV50FAUN/N4t
        q7z/nZMZr7sIwloIGMSpLbKhTA7sDPho1a0gsRfPPiIdh3JUiz1ZfbYx06iFRxKT
        kr/NKH0YuNIgP0XSHvW99p93YbU/3sNYKGZJw0MJjc+NpPfDPuHx/yVEY2okMPPv
        G2irPV95sR/DiAtmPSgcxU=
Received: from localhost.localdomain (unknown [123.112.69.106])
        by smtp2 (Coremail) with SMTP id GtxpCgB3PCJrAp9iIndHHQ--.24586S4;
        Tue, 07 Jun 2022 15:47:06 +0800 (CST)
From:   Jianglei Nie <niejianglei2021@163.com>
To:     jejb@linux.ibm.com, jarkko@kernel.org, zohar@linux.ibm.com,
        dhowells@redhat.com, jmorris@namei.org, serge@hallyn.com
Cc:     linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jianglei Nie <niejianglei2021@163.com>
Subject: [PATCH] security:trusted_tpm2: Fix memory leak in tpm2_key_encode()
Date:   Tue,  7 Jun 2022 15:46:50 +0800
Message-Id: <20220607074650.432834-1-niejianglei2021@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: GtxpCgB3PCJrAp9iIndHHQ--.24586S4
X-Coremail-Antispam: 1Uf129KBjvJXoW7Ar4xKFyxXF18uFykuFyDKFg_yoW8Zr1kpF
        ZxKF4aqrZF9F9rAry7JF4fZF13C395Gr47Gwsru39rGasxJFsxtFy7AF4Ygr17CFWftw15
        AFWDZFWUWrWqvr7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zRIPfLUUUUU=
X-Originating-IP: [123.112.69.106]
X-CM-SenderInfo: xqlhyxxdqjzvrlsqjii6rwjhhfrp/1tbiWxoZjGI0U5oI1wAAsU
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

The function allocates a memory chunk for scratch by kmalloc(), but
it is never freed through the function, which leads to a memory leak.
Handle those cases with kfree().

Signed-off-by: Jianglei Nie <niejianglei2021@163.com>
---
 security/keys/trusted-keys/trusted_tpm2.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/security/keys/trusted-keys/trusted_tpm2.c b/security/keys/trusted-keys/trusted_tpm2.c
index 0165da386289..dc9efd6c8b14 100644
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
@@ -79,8 +83,10 @@ static int tpm2_key_encode(struct trusted_key_payload *payload,
 	work1 = payload->blob;
 	work1 = asn1_encode_sequence(work1, work1 + sizeof(payload->blob),
 				     scratch, work - scratch);
-	if (WARN(IS_ERR(work1), "BUG: ASN.1 encoder failed"))
+	if (WARN(IS_ERR(work1), "BUG: ASN.1 encoder failed")) {
+		kfree(scratch);
 		return PTR_ERR(work1);
+	}
 
 	return work1 - payload->blob;
 }
-- 
2.25.1

