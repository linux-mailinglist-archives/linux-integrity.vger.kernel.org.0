Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBA10356191
	for <lists+linux-integrity@lfdr.de>; Wed,  7 Apr 2021 04:58:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348167AbhDGC6B (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 6 Apr 2021 22:58:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344040AbhDGC6A (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 6 Apr 2021 22:58:00 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD3D5C061761;
        Tue,  6 Apr 2021 19:57:50 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id c17so11859625pfn.6;
        Tue, 06 Apr 2021 19:57:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=OnoshHT7kOoHWmdZSKOnaWYfp7XXeFLdosqxj5qpzjw=;
        b=IHX7QBCwMHz+/zT73feoVBFa0fuWAtGEA23+VyS/Y4aIbtctg7ZW4i6iFvx52A/hlO
         upChPxdZ+5p+47SEepurTE6XgCnCa+qO0zDo1yNVqlDsm2uXiqAhapQ7TBCyfYoDIhy/
         d8SNKBrMGh+gtxqUnegsGeyOZZFLM7uF+XoZw/SjDVvAxjxCCtD5V+2lHfjDJiqlA91t
         KK32gHS12zgO/czDWLXaGIsrEQ34B4L5hEIOzk/Eon0GIbDXR9WiuSmhJeeVP9W0ncS0
         dXvF6CtKR8FYo1q2+HSuZvf/D6Ix6r+M3oCnVu+twYBeQJZmULQZ0p7m9YcgefKM2VSY
         XECQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=OnoshHT7kOoHWmdZSKOnaWYfp7XXeFLdosqxj5qpzjw=;
        b=WJB0+D1P2UzEzG8opQNSRIr6L4nauB3EYYjyb2OqYRCvihGtIIGnubJEYPIVd3sIob
         H5xVIw8JYmlGSm2ugUFdT1UOlAUHnceZqN1ZMF71CuXDM2kwIpl0glWAg9ud3hbSfaJa
         /UAGv9/2VYPKjr0zpEewJ3/AI1xefwNku/wtWkvAtzng53DowxCgMcTlDtmONFBbObuy
         XzvZx+RDDTR+qhXQvEMSvdRXeoh+JABSzzAm1VPMkiUxzCseyLgmaOeN2J5AQRkqVxIH
         H9hw4LK64XMc+AXSab0s+TbnJjP86oFbjQOab3IXY3adWkqndHMMR4kmag2AcR4A9Bks
         t27A==
X-Gm-Message-State: AOAM531f/3AGQNIKIHNQy3gJe14TSKLQXlvUmJuTfCQnugg+Ui1Cn0BF
        wGBDJnuAP3ICzKtOzG/aI1dJOJVzA1kUMA==
X-Google-Smtp-Source: ABdhPJwBzLRsU6gd4BJc8eRAxhOBetWkNjVk9A51y16Ookp70Nfi1YVpA4O37NpZS1hCSM1D7hxpng==
X-Received: by 2002:a65:6881:: with SMTP id e1mr1210017pgt.147.1617764270296;
        Tue, 06 Apr 2021 19:57:50 -0700 (PDT)
Received: from localhost.localdomain ([203.205.141.39])
        by smtp.gmail.com with ESMTPSA id s22sm3574981pjs.42.2021.04.06.19.57.48
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 06 Apr 2021 19:57:50 -0700 (PDT)
From:   Hongbo Li <herbert.tencent@gmail.com>
To:     keyrings@vger.kernel.org, linux-crypto@vger.kernel.org,
        herbert@gondor.apana.org.au, dhowells@redhat.com,
        zohar@linux.ibm.com, jarkko@kernel.org, herberthbli@tencent.com
Cc:     linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        Hongbo Li <herbert.tencent@gmail.com>
Subject: [PATCH v2 4/4] ima: add support for rsa pss verification
Date:   Wed,  7 Apr 2021 10:57:03 +0800
Message-Id: <1617764223-14275-5-git-send-email-herbert.tencent@gmail.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1617764223-14275-1-git-send-email-herbert.tencent@gmail.com>
References: <1617764223-14275-1-git-send-email-herbert.tencent@gmail.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

This patch adds support for ima verification for rsa with
pss encoding.

And a patch for ima-evm-utils will be sent later.

Signed-off-by: Hongbo Li <herbert.tencent@gmail.com>
---
 security/integrity/digsig_asymmetric.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/security/integrity/digsig_asymmetric.c b/security/integrity/digsig_asymmetric.c
index 23240d7..ef7a51a 100644
--- a/security/integrity/digsig_asymmetric.c
+++ b/security/integrity/digsig_asymmetric.c
@@ -85,6 +85,7 @@ int asymmetric_verify(struct key *keyring, const char *sig,
 	struct public_key_signature pks;
 	struct signature_v2_hdr *hdr = (struct signature_v2_hdr *)sig;
 	const struct public_key *pk;
+	struct public_key_signature *cert_sig;
 	struct key *key;
 	int ret;
 
@@ -109,16 +110,21 @@ int asymmetric_verify(struct key *keyring, const char *sig,
 
 	pk = asymmetric_key_public_key(key);
 	pks.pkey_algo = pk->pkey_algo;
-	if (!strcmp(pk->pkey_algo, "rsa"))
-		pks.encoding = "pkcs1";
-	else if (!strncmp(pk->pkey_algo, "ecdsa-", 6))
+	if (!strcmp(pk->pkey_algo, "rsa")) {
+		cert_sig = key->payload.data[asym_auth];
+		if (cert_sig)
+			pks.encoding = cert_sig->encoding;
+		else
+			pks.encoding = "pkcs1";
+	} else if (!strncmp(pk->pkey_algo, "ecdsa-", 6)) {
 		/* edcsa-nist-p192 etc. */
 		pks.encoding = "x962";
-	else if (!strcmp(pk->pkey_algo, "ecrdsa") ||
-		   !strcmp(pk->pkey_algo, "sm2"))
+	} else if (!strcmp(pk->pkey_algo, "ecrdsa") ||
+		   !strcmp(pk->pkey_algo, "sm2")) {
 		pks.encoding = "raw";
-	else
+	} else {
 		return -ENOPKG;
+	}
 
 	pks.digest = (u8 *)data;
 	pks.digest_size = datalen;
-- 
1.8.3.1

