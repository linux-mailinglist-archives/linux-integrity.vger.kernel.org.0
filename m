Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00C2F3554AE
	for <lists+linux-integrity@lfdr.de>; Tue,  6 Apr 2021 15:12:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344357AbhDFNMg (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 6 Apr 2021 09:12:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344340AbhDFNM1 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 6 Apr 2021 09:12:27 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D7D4C06174A;
        Tue,  6 Apr 2021 06:12:19 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id k23-20020a17090a5917b02901043e35ad4aso9633995pji.3;
        Tue, 06 Apr 2021 06:12:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=HYiI3Qt5V9Ym1wDCXtAMqzRtan5MPeNNbErHpQjqjSo=;
        b=H1+5roLu+BgC96/PO7bvk2Fj+LggM1PiHxcKaDK5NixMlyj95EmmZ5O88WExJhjY7g
         WLCjuZtbteWy0/qTUeREmJOnZDVTydhhLuTRrrfkPRbIVVpcXFGp/Vtzlzqbyx69k+Fn
         eICIXLov5pAQJ7ezNug1i78DmcqSrxG9Uc+9w0fvYtoQ3paTFlXCh8xmjmuvZmm2Vv4Q
         tWyEMXR4uREtGoBxu6yGZOGjeyQypQGsm5viPinZ2llLbF9r5GUM1WSFBc5T1fFd4qma
         lgJu8Pja/hTVVNgSH4Nv3xGJjnGjXNbfZm7PDRn1TyxEXaRRM9la+nE4kaWjmHpSPx8p
         6VVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=HYiI3Qt5V9Ym1wDCXtAMqzRtan5MPeNNbErHpQjqjSo=;
        b=sItT37G3ht6H2xrOE9I+X2i/vRDunJFxXzAhFS28EeyfcoKFphl5GuyPQuYGKpubWt
         IisaPl2p2unPhiufKt67MVFXzh+meoUkw6NV9VfwRx9fVMk0Pa1WVHHeFiqguIPPiy36
         5MWoPODoyG2IU69o96utwT3pD1O5chEaxu8MEeSdGN5pqGg4NmzmCeKWbEYQVL5TYLs3
         hdgvyXAuCl/pJD9wupyqbTLhgGy1Paj/TVxkmslms3+nr981rQE6w21LCILTChawNiPU
         LKRHPCgM7YjaH/6IW1zFia6anU85WHi96PU3p64hrXmXy6OQuJqeKvE+x5611RnsKxj6
         4gLA==
X-Gm-Message-State: AOAM533AoZr9QnWMNGnhA+3tEQToDnpLlqTMTF50CStmqS0yTp8KNoOC
        qWkkinF6EmnP2+V7nmWVrt7thSP1Yz+1Ww==
X-Google-Smtp-Source: ABdhPJyTAOsz8017uMn9D36NmPU78+ws1EeSX9Yk2v+yRjXYtcQ+9zjIdNKM0ekzM2IcQ9GH0P/dEg==
X-Received: by 2002:a17:90a:1f0e:: with SMTP id u14mr4425394pja.155.1617714738516;
        Tue, 06 Apr 2021 06:12:18 -0700 (PDT)
Received: from localhost.localdomain ([203.205.141.39])
        by smtp.gmail.com with ESMTPSA id i73sm13801351pgc.9.2021.04.06.06.12.16
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 06 Apr 2021 06:12:18 -0700 (PDT)
From:   Hongbo Li <herbert.tencent@gmail.com>
To:     keyrings@vger.kernel.org, linux-crypto@vger.kernel.org,
        herbert@gondor.apana.org.au, dhowells@redhat.com,
        zohar@linux.ibm.com, jarkko@kernel.org, herberthbli@tencent.com
Cc:     linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org
Subject: [PATCH 5/5] ima: add support for rsa pss verification
Date:   Tue,  6 Apr 2021 21:11:26 +0800
Message-Id: <1617714686-25754-6-git-send-email-herbert.tencent@gmail.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1617714686-25754-1-git-send-email-herbert.tencent@gmail.com>
References: <1617714686-25754-1-git-send-email-herbert.tencent@gmail.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

From: Hongbo Li <herberthbli@tencent.com>

This patch adds support for ima verification for rsa with
pss encoding.

And a patch for ima-evm-utils will be sent later.

Signed-off-by: Hongbo Li <herberthbli@tencent.com>
---
 security/integrity/digsig_asymmetric.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/security/integrity/digsig_asymmetric.c b/security/integrity/digsig_asymmetric.c
index 183f452..ef7a51a 100644
--- a/security/integrity/digsig_asymmetric.c
+++ b/security/integrity/digsig_asymmetric.c
@@ -85,6 +85,7 @@ int asymmetric_verify(struct key *keyring, const char *sig,
 	struct public_key_signature pks;
 	struct signature_v2_hdr *hdr = (struct signature_v2_hdr *)sig;
 	const struct public_key *pk;
+	struct public_key_signature *cert_sig;
 	struct key *key;
 	int ret;
 
@@ -110,7 +111,11 @@ int asymmetric_verify(struct key *keyring, const char *sig,
 	pk = asymmetric_key_public_key(key);
 	pks.pkey_algo = pk->pkey_algo;
 	if (!strcmp(pk->pkey_algo, "rsa")) {
-		pks.encoding = "pkcs1";
+		cert_sig = key->payload.data[asym_auth];
+		if (cert_sig)
+			pks.encoding = cert_sig->encoding;
+		else
+			pks.encoding = "pkcs1";
 	} else if (!strncmp(pk->pkey_algo, "ecdsa-", 6)) {
 		/* edcsa-nist-p192 etc. */
 		pks.encoding = "x962";
-- 
1.8.3.1

