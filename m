Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6035E356230
	for <lists+linux-integrity@lfdr.de>; Wed,  7 Apr 2021 05:50:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348455AbhDGDuv (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 6 Apr 2021 23:50:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348503AbhDGDuO (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 6 Apr 2021 23:50:14 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CBCBC06174A;
        Tue,  6 Apr 2021 20:50:05 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id v10so11930783pfn.5;
        Tue, 06 Apr 2021 20:50:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=OnoshHT7kOoHWmdZSKOnaWYfp7XXeFLdosqxj5qpzjw=;
        b=STPtszXRctw9+TT+8la68Rw7DOYaMtI0tX6b8mngOAGmS1T6mKx0a4cHotreGlXe6V
         18OTdoQ0kuH07dofW/hHJ0EPEeQ3NSNPFXlnozpugT+8gU2CoSG4Pj/3yYR/843dxE5B
         dG8uOypKWrfITGmTatSA/usQbXqaYeTuinYPVsOCx0jbjwxH/5+pgU0ZM1z+sghvk+99
         OXCYYdawNMl4Lb7f7HzogMVVmdtbOKQeEfnPai4G/u+XRqfbAFfIYjJAFIv2sbFwp8M+
         5RgWjN1M8zIPMCKy/enAamjffecFK8hbBCd1uiB4NyKoCjQMn57gzmH8GVftt4KF2sqN
         JhdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=OnoshHT7kOoHWmdZSKOnaWYfp7XXeFLdosqxj5qpzjw=;
        b=JSu8rj0Dvq/1DB2LaGP0liC0d12PmF5Dtnfi55O6Iq6jQMx0Prg7DUi/+omkrS5qPr
         XZK0/yIisE9eNHM+Eqe80nNyVSJZgWZ3clFawhsasPEtpYLAvdCgAjR99A1+JTCxVvyi
         0/pfQ3BW+RXWjxowdsn74bRlLea7+gjvNqbdVH8vcq8RCtbf+bhE4sV2uxJ76w6U0dVK
         dTRDcE2BekOwzXKyJBpCUn+nEQx9d07aruO2flvjVus7L7rWkT75FkLwkIaiF5OAKu06
         Wmvn4fFiEB8nKtjvrvoz3cBW3RCwZEhOxgysKPmDyK/0lRD+CwRt+naXl7B6PfJ6Ghf0
         qUAw==
X-Gm-Message-State: AOAM533QkLOAW8xAhENjiK3tsG4AeYj00tv9jsnwQYIMwYZ9M1TsSx4W
        bOr13LtAtgwZVB8w2zjvUIgbbfEAr7Wujw==
X-Google-Smtp-Source: ABdhPJxwUwf+Ht4SscvgaZ4jjMxxQAp1ebQInQIU8paP0SN8akViV9uKyJSfo+sAOtjokY76YKlI6g==
X-Received: by 2002:aa7:8756:0:b029:242:3e63:87da with SMTP id g22-20020aa787560000b02902423e6387damr602819pfo.66.1617767404663;
        Tue, 06 Apr 2021 20:50:04 -0700 (PDT)
Received: from localhost.localdomain ([203.205.141.39])
        by smtp.gmail.com with ESMTPSA id s21sm6000922pgl.36.2021.04.06.20.50.02
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 06 Apr 2021 20:50:04 -0700 (PDT)
From:   Hongbo Li <herbert.tencent@gmail.com>
To:     keyrings@vger.kernel.org, linux-crypto@vger.kernel.org,
        herbert@gondor.apana.org.au, dhowells@redhat.com,
        zohar@linux.ibm.com, jarkko@kernel.org, herberthbli@tencent.com
Cc:     linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        Hongbo Li <herbert.tencent@gmail.com>
Subject: [PATCH v3 4/4] ima: add support for rsa pss verification
Date:   Wed,  7 Apr 2021 11:49:18 +0800
Message-Id: <1617767358-25279-5-git-send-email-herbert.tencent@gmail.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1617767358-25279-1-git-send-email-herbert.tencent@gmail.com>
References: <1617767358-25279-1-git-send-email-herbert.tencent@gmail.com>
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

