Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5E2D542719
	for <lists+linux-integrity@lfdr.de>; Wed,  8 Jun 2022 08:59:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232336AbiFHFdk (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 8 Jun 2022 01:33:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234023AbiFHFdY (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 8 Jun 2022 01:33:24 -0400
Received: from mail-m972.mail.163.com (mail-m972.mail.163.com [123.126.97.2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5ED0F2A8938;
        Tue,  7 Jun 2022 20:00:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=55rL/
        8+u+QDxUibK3Ff+8lesiAblAVPkbmExdrwsXfg=; b=dFYbY7AT6Lfit+gyHZSrT
        WyOO1/iDneqIGtne0jlzyA7YRERDocaDDSDt68wdd04AzvAO0AE3PwslK0ZKzXWO
        /OckntlXewtygVQ+LB2Gzku38QFkgB8qFZbQMxOkHOD6aNw9QY+OG5pfcWLkebUy
        INUq/ct9M+BjKaoQpdCN14=
Received: from localhost.localdomain (unknown [123.112.69.106])
        by smtp2 (Coremail) with SMTP id GtxpCgC3KgCcEKBiolEjHg--.26179S4;
        Wed, 08 Jun 2022 10:59:51 +0800 (CST)
From:   Jianglei Nie <niejianglei2021@163.com>
To:     jejb@linux.ibm.com, jarkko@kernel.org, zohar@linux.ibm.com,
        dhowells@redhat.com, jmorris@namei.org, serge@hallyn.com
Cc:     linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jianglei Nie <niejianglei2021@163.com>
Subject: [PATCH] security:trusted_tpm2: Fix memory leak in tpm2_key_encode()
Date:   Wed,  8 Jun 2022 10:59:38 +0800
Message-Id: <20220608025938.447908-1-niejianglei2021@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: GtxpCgC3KgCcEKBiolEjHg--.26179S4
X-Coremail-Antispam: 1Uf129KBjvJXoW7urWxGF17Wr1ftF1kZw4ktFb_yoW8Zr4fpF
        ZxKF13XrZF9F9rAry3JF4SvF43C3s5GrW7Wwsru39rGasxJFsxtFy7Ar4Ygr17AFWSqw15
        AFWDZFWUuFWqqr7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zRID7fUUUUU=
X-Originating-IP: [123.112.69.106]
X-CM-SenderInfo: xqlhyxxdqjzvrlsqjii6rwjhhfrp/1tbiPgcajFxBsmbZUwAAss
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

tpm2_key_encode() allocates a memory chunk from scratch with kmalloc(),
but it is never freed, which leads to a memory leak. Free the memory
chunk with kfree() in the return path.

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

