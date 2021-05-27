Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05EB9393045
	for <lists+linux-integrity@lfdr.de>; Thu, 27 May 2021 15:55:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236678AbhE0N4d (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 27 May 2021 09:56:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236696AbhE0N4U (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 27 May 2021 09:56:20 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20AA6C06138D;
        Thu, 27 May 2021 06:54:47 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id t21so24188plo.2;
        Thu, 27 May 2021 06:54:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=e2Q9Fi4+Y3HDr0p6x7AzX3U4YPXNdxuFZ7l9M0bi/AI=;
        b=qnB5RTc/6YtVrmIAgqR+Rr40dJeVcNVXbAQZVC8mLbmSj015v7oAcLdkklaMEt0zEa
         CkL1MEkQA5E38KMEYXb8XIz/6CY2KwU+3bqo1pu06CINeMlOz4LOQ9+lF1D+IV7hcGEx
         n9OUpJs4nr78QHJ06woTHGZahnmlfxZRAykB5wA8yJaG3GhPRRhoh56g+iN7J0szLGB6
         slPwUQY+Wf7VzsFyPE80N7QqOfkXzI+w5o+no6YCFa5HSfQuACesMYWvq32xirStu1YX
         iJWeLm1dT/pXwEsSZ6Twb8mMGpCftmw4ezSB30i7gvkieGakCIg23Bt83L06mdjzV5sk
         cbNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=e2Q9Fi4+Y3HDr0p6x7AzX3U4YPXNdxuFZ7l9M0bi/AI=;
        b=f2qrdaGap/BXqZ7i2sCKmLnVC8GOlaZ3xSHWiXaBQcZqqtcVMMsMKBdHMGsVtWyLCc
         Ua7hnrlzKwBftutRi+3jBR/ayHY1gj0Wae6jddfmrpS0r6dFzEYYjJOg4RQuLwSx/PSa
         fVQa6UMMyJrNoOWxvXok+Ww0QtUgnBWGEiUguK/uep5BydOPp8qgk4eNKx7mCW9NWWk6
         fK4T4IbAG3QhWu49R3h+pweQiGxqrCznrzWtyAxvJy+nxV8EoMP+OVFrxwmJN8Zp+H9o
         3Y36CJIvKOYQIAJGOkmcfXcRVwilDcXrGczI+sTfKMdvYESfg2dOywqQpyLm6PZLTMLS
         Bi+A==
X-Gm-Message-State: AOAM533P6afiH0o+ARUDHGJ8du+sm2c6FYqDPUc/sHjOMfl7ukvmFA32
        NMmW0tIfNvGrj/WQ9UxClXBBYIZaIy4=
X-Google-Smtp-Source: ABdhPJyQUMsBrYjMTZ9of8jWYyYdJXwXhPAvB1qiqKeQreJ0Iw3GmWjgpd3Mi4dsoJyq8wiUlxPWpg==
X-Received: by 2002:a17:90a:5309:: with SMTP id x9mr9483917pjh.111.1622123686351;
        Thu, 27 May 2021 06:54:46 -0700 (PDT)
Received: from localhost.localdomain ([203.205.141.39])
        by smtp.gmail.com with ESMTPSA id 10sm2163387pgl.39.2021.05.27.06.54.43
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 May 2021 06:54:46 -0700 (PDT)
From:   Hongbo Li <herbert.tencent@gmail.com>
To:     keyrings@vger.kernel.org, linux-crypto@vger.kernel.org,
        herbert@gondor.apana.org.au, ebiggers@kernel.org,
        dhowells@redhat.com, jarkko@kernel.org,
        tianjia.zhang@linux.alibaba.com, herberthbli@tencent.com
Cc:     linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org
Subject: [PATCH v2 7/7] crypto: add eddsa test vector
Date:   Thu, 27 May 2021 21:53:35 +0800
Message-Id: <1622123615-15517-8-git-send-email-herbert.tencent@gmail.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1622123615-15517-1-git-send-email-herbert.tencent@gmail.com>
References: <1622123615-15517-1-git-send-email-herbert.tencent@gmail.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

From: Hongbo Li <herberthbli@tencent.com>

This patch adds the test vector for ed25519.
The test vector is from RFC8032 section 7.1 [1]

[1]https://datatracker.ietf.org/doc/html/rfc8032#section-7.1

Signed-off-by: Hongbo Li <herberthbli@tencent.com>
---
 crypto/testmgr.c |  6 ++++++
 crypto/testmgr.h | 32 ++++++++++++++++++++++++++++++++
 2 files changed, 38 insertions(+)

diff --git a/crypto/testmgr.c b/crypto/testmgr.c
index 10c5b3b01ec4..498d1866ef77 100644
--- a/crypto/testmgr.c
+++ b/crypto/testmgr.c
@@ -4938,6 +4938,12 @@ static const struct alg_test_desc alg_test_descs[] = {
 		.suite = {
 			.akcipher = __VECS(ecrdsa_tv_template)
 		}
+	}, {
+		.alg = "eddsa-25519",
+		.test = alg_test_akcipher,
+		.suite = {
+			.akcipher = __VECS(eddsa_25519_tv_template)
+		}
 	}, {
 		.alg = "essiv(authenc(hmac(sha256),cbc(aes)),sha256)",
 		.test = alg_test_aead,
diff --git a/crypto/testmgr.h b/crypto/testmgr.h
index 34e4a3db3991..11807a308ef9 100644
--- a/crypto/testmgr.h
+++ b/crypto/testmgr.h
@@ -1144,6 +1144,38 @@ static const struct akcipher_testvec ecrdsa_tv_template[] = {
 	},
 };
 
+/*
+ * EDDSA test vectors.
+ * From RFC8032 section 7.1
+ */
+static const struct akcipher_testvec eddsa_25519_tv_template[] = {
+	{
+	.key =
+	"\x3d\x40\x17\xc3\xe8\x43\x89\x5a\x92\xb7\x0a\xa7\x4d\x1b\x7e\xbc"
+	"\x9c\x98\x2c\xcf\x2e\xc4\x96\x8c\xc0\xcd\x55\xf1\x2a\xf4\x66\x0c",
+	.key_len = 32,
+	/*
+	 * RFC8032 section 5.1.7. m is SHA512(dom2(F, C) || R || A || PH(M))
+	 * M is 0x72
+	 */
+	.m =
+	"\xa2\x71\xdf\x0d\x2b\x0d\x03\xbd\x17\xb4\xed\x9a\x4b\x6a\xfd\xdf"
+	"\x2e\x73\x28\x7f\xd6\x30\xf1\xa1\x37\xd8\x7c\xe8\x73\xa5\x91\xcc"
+	"\x31\xb6\xdd\x85\x2a\x98\xb5\xdd\x12\x26\xfe\x99\x3d\x82\x28\x27"
+	"\x8c\xeb\xa2\x1f\x80\xb8\xfc\x95\x98\x6a\x70\xd7\x1e\xdf\x3f\xaf",
+	.m_size = 64,
+	.c =
+	"\x92\xa0\x09\xa9\xf0\xd4\xca\xb8\x72\x0e\x82\x0b\x5f\x64\x25\x40"
+	"\xa2\xb2\x7b\x54\x16\x50\x3f\x8f\xb3\x76\x22\x23\xeb\xdb\x69\xda"
+	"\x08\x5a\xc1\xe4\x3e\x15\x99\x6e\x45\x8f\x36\x13\xd0\xf1\x1d\x8c"
+	"\x38\x7b\x2e\xae\xb4\x30\x2a\xee\xb0\x0d\x29\x16\x12\xbb\x0c\x00",
+	.c_size = 64,
+	.algo = OID_ed25519,
+	.public_key_vec = true,
+	.siggen_sigver_test = true,
+	}
+};
+
 /*
  * PKCS#1 RSA test vectors. Obtained from CAVS testing.
  */
-- 
2.27.0

