Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B197339302D
	for <lists+linux-integrity@lfdr.de>; Thu, 27 May 2021 15:54:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236650AbhE0N4F (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 27 May 2021 09:56:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236644AbhE0N4E (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 27 May 2021 09:56:04 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F165C061574;
        Thu, 27 May 2021 06:54:31 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id v14so3744634pgi.6;
        Thu, 27 May 2021 06:54:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=VBTc6GrR5fsw1SZ888oXO0FealYGM7xDUiPSmTCnIlY=;
        b=OEELm/BdHHWKdbGzsyyxOAk0JElA8Ei4SqvYVVOB0t2O/sI2xUP9FaKaoLC4nzHab9
         0Nk4v7YzQ326Oz+E4hLmVGZO7lRNlS2w6bT8EOK02C9yp6Rkiiu2HOg6HbY/t6T+63jr
         +BDLyhEpCVKmF6Tn7fFQAWzUyfopXQ3lKqTqs1hf6J9gQ2qHJEhez7UCwCmh7FxeAN2w
         5YToDOofqPoliIsKL3aHLzQ6Ct+mV2tZrVAkm8SgCPh2ado0RYdxQwZdBNFHwkYgQLmL
         mC7YPGqcfBVEN22DuWyh5qY0F5985lC3LJcBjlJtsj96PSIQPylW96X0PeJ8qmsQeWn/
         ahaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=VBTc6GrR5fsw1SZ888oXO0FealYGM7xDUiPSmTCnIlY=;
        b=HfnOau9V3uHsFcfv4Qf5js+Mc+WhVZBCpYVTHW5o7FGmim92AvJ6YbHxGv4DFrU2yY
         RiQMj2t6hZ7XzutmnutROOnI05xvesXut/07BDERwTsom1uSF7FssmX+g/TbKDRdIJ18
         7sZHT/c3SnVeoBKNvDBY11prRnvl9x6RGTgMOkTfZiQ9REahTmAf02/RpEx90UiiaFLy
         QrxczH0oQ2FxPNP27d2c0fqAJJjd0ejnPKSLNsP9JMxAJWOvQYRI/Q/KOCA4+TlDWSk/
         TkXECyoSoA6mO/rXjkXr0JjoowkjslBhm8XeS9vWaYPlrXIp1DXHL9O0hC2tbAaSLQwf
         rbSA==
X-Gm-Message-State: AOAM533V2esGC3VPwbgFql4yJIJHXbQf1WTNUTt5pw3Alhhsq9nuY0bo
        y6uCJgwakj12VwDmLY9j6GpnColDVus=
X-Google-Smtp-Source: ABdhPJxxZeJ3yFKMK22o612/p4HcRQyAMzNsSJFAnv37EwlM7RSRqNiOMaQrT2EsAdbp90b67VkiPw==
X-Received: by 2002:aa7:829a:0:b029:2e9:e53:198d with SMTP id s26-20020aa7829a0000b02902e90e53198dmr3906269pfm.72.1622123670544;
        Thu, 27 May 2021 06:54:30 -0700 (PDT)
Received: from localhost.localdomain ([203.205.141.39])
        by smtp.gmail.com with ESMTPSA id 10sm2163387pgl.39.2021.05.27.06.54.27
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 May 2021 06:54:30 -0700 (PDT)
From:   Hongbo Li <herbert.tencent@gmail.com>
To:     keyrings@vger.kernel.org, linux-crypto@vger.kernel.org,
        herbert@gondor.apana.org.au, ebiggers@kernel.org,
        dhowells@redhat.com, jarkko@kernel.org,
        tianjia.zhang@linux.alibaba.com, herberthbli@tencent.com
Cc:     linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org
Subject: [PATCH v2 1/7] crypto: fix a memory leak in sm2
Date:   Thu, 27 May 2021 21:53:29 +0800
Message-Id: <1622123615-15517-2-git-send-email-herbert.tencent@gmail.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1622123615-15517-1-git-send-email-herbert.tencent@gmail.com>
References: <1622123615-15517-1-git-send-email-herbert.tencent@gmail.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

From: Hongbo Li <herberthbli@tencent.com>

SM2 module alloc ec->Q in sm2_set_pub_key(), when doing alg test in
test_akcipher_one(), it will set public key for every test vector,
and don't free ec->Q. This will cause a memory leak.

This patch alloc ec->Q in sm2_ec_ctx_init().

Fixes: ea7ecb66440b ("crypto: sm2 - introduce OSCCA SM2 asymmetric cipher algorithm")
Signed-off-by: Hongbo Li <herberthbli@tencent.com>
Reviewed-by: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
---
 crypto/sm2.c | 24 ++++++++++--------------
 1 file changed, 10 insertions(+), 14 deletions(-)

diff --git a/crypto/sm2.c b/crypto/sm2.c
index b21addc3ac06..db8a4a265669 100644
--- a/crypto/sm2.c
+++ b/crypto/sm2.c
@@ -79,10 +79,17 @@ static int sm2_ec_ctx_init(struct mpi_ec_ctx *ec)
 		goto free;
 
 	rc = -ENOMEM;
+
+	ec->Q = mpi_point_new(0);
+	if (!ec->Q)
+		goto free;
+
 	/* mpi_ec_setup_elliptic_curve */
 	ec->G = mpi_point_new(0);
-	if (!ec->G)
+	if (!ec->G) {
+		mpi_point_release(ec->Q);
 		goto free;
+	}
 
 	mpi_set(ec->G->x, x);
 	mpi_set(ec->G->y, y);
@@ -91,6 +98,7 @@ static int sm2_ec_ctx_init(struct mpi_ec_ctx *ec)
 	rc = -EINVAL;
 	ec->n = mpi_scanval(ecp->n);
 	if (!ec->n) {
+		mpi_point_release(ec->Q);
 		mpi_point_release(ec->G);
 		goto free;
 	}
@@ -386,27 +394,15 @@ static int sm2_set_pub_key(struct crypto_akcipher *tfm,
 	MPI a;
 	int rc;
 
-	ec->Q = mpi_point_new(0);
-	if (!ec->Q)
-		return -ENOMEM;
-
 	/* include the uncompressed flag '0x04' */
-	rc = -ENOMEM;
 	a = mpi_read_raw_data(key, keylen);
 	if (!a)
-		goto error;
+		return -ENOMEM;
 
 	mpi_normalize(a);
 	rc = sm2_ecc_os2ec(ec->Q, a);
 	mpi_free(a);
-	if (rc)
-		goto error;
-
-	return 0;
 
-error:
-	mpi_point_release(ec->Q);
-	ec->Q = NULL;
 	return rc;
 }
 
-- 
2.27.0

