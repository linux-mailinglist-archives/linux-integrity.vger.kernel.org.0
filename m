Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F102639303D
	for <lists+linux-integrity@lfdr.de>; Thu, 27 May 2021 15:54:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236701AbhE0N4W (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 27 May 2021 09:56:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236678AbhE0N4P (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 27 May 2021 09:56:15 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4EABC0613CE;
        Thu, 27 May 2021 06:54:41 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id t21so24068plo.2;
        Thu, 27 May 2021 06:54:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=4n6zz9KSKw8/sugGUm2oSKx88caKtNeXkpuRKrDlH1M=;
        b=eyjPwFuC0WY1LPpbFF1t6hkHwjFsKaI5REAE9TugeO98o7Ham+iog3Epy7Ux9QrPe4
         k2IONP15HCDGBdsdUcXTC4IRgtTVu1HHiKDnjHhmqDLrAkdDq1GRWXeMg+bWhybh/HK8
         X9iq0cTeGdW/lJhTkvVwAxiXC0oh0PW5XGZMwMnkP6zeads15g/IU6PepVMryK7Dl6n8
         WloWxAjGHjAB3ZnXKQ8BdYLASz8SX69kRvj9GMxgVh1JSczafdHZl9Pz8GjKCVADDOqH
         C0eKlJkP7+Vwo2WzouhNC9UWeOrKvJBCnrkghK68E+DvTxAZ5NCDfo2qbFe+gDtWZ1ou
         e+Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=4n6zz9KSKw8/sugGUm2oSKx88caKtNeXkpuRKrDlH1M=;
        b=oO3P0R/qOjkZVqeIF4cLi0Or+MODB8bVmQ6v+X/THAuvyBqQoyzeXNrFqhQY+aHbZH
         PpN5G4xZ28JB+QU7vuepbqlQ/ryBWJFbpwd3OSC+enGm5qcbNxcr5OezjseHgf0eq5DY
         r6ZD5JFBhhqD/CESq9tD2nOA6jc609Ok/3XP+dFzVn/MOQlnWiNEWlRmF5fIKtUH1Pwp
         tWNh561ZEG5OFcfkVDcC23uyOVsPRgk1dsTd3rjJLAfk0vjo3gqifuKnN4yHCbw3Soa1
         XFTyFlD5rp3w0mac3Ee5z6AI0N9X1xP6lgZdtYoZ8WJ3+j08VlWRqzcnptm1NDCbrLwd
         Pp0g==
X-Gm-Message-State: AOAM532HywZyiNMEswHC1+EZQWo/1T4FQwzvUJe12l05heA0rPD9GtZk
        vg39uhGajgTcWusbNGX6pnlb3h/LtSw=
X-Google-Smtp-Source: ABdhPJz/8Z/X5254r+Cza4yavOkHrT9GiI9pX20ue+cLJ+z2zMPsA7MLrgANhRwVEicE7TGhpckjFQ==
X-Received: by 2002:a17:90a:28a6:: with SMTP id f35mr3307959pjd.1.1622123681023;
        Thu, 27 May 2021 06:54:41 -0700 (PDT)
Received: from localhost.localdomain ([203.205.141.39])
        by smtp.gmail.com with ESMTPSA id 10sm2163387pgl.39.2021.05.27.06.54.38
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 May 2021 06:54:40 -0700 (PDT)
From:   Hongbo Li <herbert.tencent@gmail.com>
To:     keyrings@vger.kernel.org, linux-crypto@vger.kernel.org,
        herbert@gondor.apana.org.au, ebiggers@kernel.org,
        dhowells@redhat.com, jarkko@kernel.org,
        tianjia.zhang@linux.alibaba.com, herberthbli@tencent.com
Cc:     linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org
Subject: [PATCH v2 5/7] crypto: move common code in sm2 to ec_mpi.c and ec_mpi.h
Date:   Thu, 27 May 2021 21:53:33 +0800
Message-Id: <1622123615-15517-6-git-send-email-herbert.tencent@gmail.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1622123615-15517-1-git-send-email-herbert.tencent@gmail.com>
References: <1622123615-15517-1-git-send-email-herbert.tencent@gmail.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

From: Hongbo Li <herberthbli@tencent.com>

Some structs and functions in sm2 are common codes, and could be
used by the following eddsa patch. So move them to common files:
ec_mpi.c and ec_mpi.h.

Signed-off-by: Hongbo Li <herberthbli@tencent.com>
---
 crypto/Kconfig  |  4 ++
 crypto/Makefile |  1 +
 crypto/ec_mpi.c | 82 +++++++++++++++++++++++++++++++++++++++++
 crypto/ec_mpi.h | 37 +++++++++++++++++++
 crypto/sm2.c    | 98 ++-----------------------------------------------
 5 files changed, 127 insertions(+), 95 deletions(-)
 create mode 100644 crypto/ec_mpi.c
 create mode 100644 crypto/ec_mpi.h

diff --git a/crypto/Kconfig b/crypto/Kconfig
index 4a0d1876aadb..75ae7d3f6f92 100644
--- a/crypto/Kconfig
+++ b/crypto/Kconfig
@@ -265,6 +265,9 @@ config CRYPTO_ECRDSA
 	  standard algorithms (called GOST algorithms). Only signature verification
 	  is implemented.
 
+config CRYPTO_EC_MPI
+	tristate
+
 config CRYPTO_SM2
 	tristate "SM2 algorithm"
 	select CRYPTO_SM3
@@ -272,6 +275,7 @@ config CRYPTO_SM2
 	select CRYPTO_MANAGER
 	select MPILIB
 	select ASN1
+	select CRYPTO_EC_MPI
 	help
 	  Generic implementation of the SM2 public key algorithm. It was
 	  published by State Encryption Management Bureau, China.
diff --git a/crypto/Makefile b/crypto/Makefile
index 10526d4559b8..8afb39359776 100644
--- a/crypto/Makefile
+++ b/crypto/Makefile
@@ -177,6 +177,7 @@ obj-$(CONFIG_CRYPTO_OFB) += ofb.o
 obj-$(CONFIG_CRYPTO_ECC) += ecc.o
 obj-$(CONFIG_CRYPTO_ESSIV) += essiv.o
 obj-$(CONFIG_CRYPTO_CURVE25519) += curve25519-generic.o
+obj-$(CONFIG_CRYPTO_EC_MPI) += ec_mpi.o
 
 ecdh_generic-y += ecdh.o
 ecdh_generic-y += ecdh_helper.o
diff --git a/crypto/ec_mpi.c b/crypto/ec_mpi.c
new file mode 100644
index 000000000000..a537e6fc713f
--- /dev/null
+++ b/crypto/ec_mpi.c
@@ -0,0 +1,82 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * EC MPI common functions.
+ *
+ * Copyright (c) 2020, Alibaba Group.
+ * Authors: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
+ */
+
+#include <linux/module.h>
+#include <linux/mpi.h>
+#include "ec_mpi.h"
+
+int ec_mpi_ctx_init(struct mpi_ec_ctx *ec, const struct ecc_domain_parms *ecp)
+{
+	MPI p, a, b;
+	MPI x, y;
+	int rc = -EINVAL;
+
+	p = mpi_scanval(ecp->p);
+	a = mpi_scanval(ecp->a);
+	b = mpi_scanval(ecp->b);
+	if (!p || !a || !b)
+		goto free_p;
+
+	x = mpi_scanval(ecp->g_x);
+	y = mpi_scanval(ecp->g_y);
+	if (!x || !y)
+		goto free;
+
+	rc = -ENOMEM;
+
+	ec->Q = mpi_point_new(0);
+	if (!ec->Q)
+		goto free;
+
+	/* mpi_ec_setup_elliptic_curve */
+	ec->G = mpi_point_new(0);
+	if (!ec->G) {
+		mpi_point_release(ec->Q);
+		goto free;
+	}
+
+	mpi_set(ec->G->x, x);
+	mpi_set(ec->G->y, y);
+	mpi_set_ui(ec->G->z, 1);
+
+	rc = -EINVAL;
+	ec->n = mpi_scanval(ecp->n);
+	if (!ec->n) {
+		mpi_point_release(ec->Q);
+		mpi_point_release(ec->G);
+		goto free;
+	}
+
+	ec->h = ecp->h;
+	ec->name = ecp->desc;
+	mpi_ec_init(ec, ecp->model, ecp->dialect, 0, p, a, b);
+
+	rc = 0;
+
+free:
+	mpi_free(x);
+	mpi_free(y);
+free_p:
+	mpi_free(p);
+	mpi_free(a);
+	mpi_free(b);
+
+	return rc;
+}
+EXPORT_SYMBOL(ec_mpi_ctx_init);
+
+void ec_mpi_ctx_deinit(struct mpi_ec_ctx *ec)
+{
+	mpi_ec_deinit(ec);
+
+	memset(ec, 0, sizeof(*ec));
+}
+EXPORT_SYMBOL(ec_mpi_ctx_deinit);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Tianjia Zhang <tianjia.zhang@linux.alibaba.com>");
diff --git a/crypto/ec_mpi.h b/crypto/ec_mpi.h
new file mode 100644
index 000000000000..e1f6d3aaeef9
--- /dev/null
+++ b/crypto/ec_mpi.h
@@ -0,0 +1,37 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * EC MPI common structs.
+ *
+ * Copyright (c) 2020, Alibaba Group.
+ * Authors: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
+ */
+
+#include <linux/mpi.h>
+
+struct ecc_domain_parms {
+	const char *desc;           /* Description of the curve.  */
+	unsigned int nbits;         /* Number of bits.  */
+	unsigned int fips:1; /* True if this is a FIPS140-2 approved curve */
+
+	/* The model describing this curve.  This is mainly used to select
+	 * the group equation.
+	 */
+	enum gcry_mpi_ec_models model;
+
+	/* The actual ECC dialect used.  This is used for curve specific
+	 * optimizations and to select encodings etc.
+	 */
+	enum ecc_dialects dialect;
+
+	const char *p;              /* The prime defining the field.  */
+	const char *a, *b;          /* The coefficients.  For Twisted Edwards
+				     * Curves b is used for d.  For Montgomery
+				     * Curves (a,b) has ((A-2)/4,B^-1).
+				     */
+	const char *n;              /* The order of the base point.  */
+	const char *g_x, *g_y;      /* Base point.  */
+	unsigned int h;             /* Cofactor.  */
+};
+
+int ec_mpi_ctx_init(struct mpi_ec_ctx *ec, const struct ecc_domain_parms *ecp);
+void ec_mpi_ctx_deinit(struct mpi_ec_ctx *ec);
diff --git a/crypto/sm2.c b/crypto/sm2.c
index db8a4a265669..ea1676ba1a9a 100644
--- a/crypto/sm2.c
+++ b/crypto/sm2.c
@@ -9,42 +9,17 @@
  */
 
 #include <linux/module.h>
-#include <linux/mpi.h>
 #include <crypto/internal/akcipher.h>
 #include <crypto/akcipher.h>
 #include <crypto/hash.h>
 #include <crypto/sm3_base.h>
 #include <crypto/rng.h>
 #include <crypto/sm2.h>
+#include "ec_mpi.h"
 #include "sm2signature.asn1.h"
 
 #define MPI_NBYTES(m)   ((mpi_get_nbits(m) + 7) / 8)
 
-struct ecc_domain_parms {
-	const char *desc;           /* Description of the curve.  */
-	unsigned int nbits;         /* Number of bits.  */
-	unsigned int fips:1; /* True if this is a FIPS140-2 approved curve */
-
-	/* The model describing this curve.  This is mainly used to select
-	 * the group equation.
-	 */
-	enum gcry_mpi_ec_models model;
-
-	/* The actual ECC dialect used.  This is used for curve specific
-	 * optimizations and to select encodings etc.
-	 */
-	enum ecc_dialects dialect;
-
-	const char *p;              /* The prime defining the field.  */
-	const char *a, *b;          /* The coefficients.  For Twisted Edwards
-				     * Curves b is used for d.  For Montgomery
-				     * Curves (a,b) has ((A-2)/4,B^-1).
-				     */
-	const char *n;              /* The order of the base point.  */
-	const char *g_x, *g_y;      /* Base point.  */
-	unsigned int h;             /* Cofactor.  */
-};
-
 static const struct ecc_domain_parms sm2_ecp = {
 	.desc = "sm2p256v1",
 	.nbits = 256,
@@ -60,73 +35,6 @@ static const struct ecc_domain_parms sm2_ecp = {
 	.h = 1
 };
 
-static int sm2_ec_ctx_init(struct mpi_ec_ctx *ec)
-{
-	const struct ecc_domain_parms *ecp = &sm2_ecp;
-	MPI p, a, b;
-	MPI x, y;
-	int rc = -EINVAL;
-
-	p = mpi_scanval(ecp->p);
-	a = mpi_scanval(ecp->a);
-	b = mpi_scanval(ecp->b);
-	if (!p || !a || !b)
-		goto free_p;
-
-	x = mpi_scanval(ecp->g_x);
-	y = mpi_scanval(ecp->g_y);
-	if (!x || !y)
-		goto free;
-
-	rc = -ENOMEM;
-
-	ec->Q = mpi_point_new(0);
-	if (!ec->Q)
-		goto free;
-
-	/* mpi_ec_setup_elliptic_curve */
-	ec->G = mpi_point_new(0);
-	if (!ec->G) {
-		mpi_point_release(ec->Q);
-		goto free;
-	}
-
-	mpi_set(ec->G->x, x);
-	mpi_set(ec->G->y, y);
-	mpi_set_ui(ec->G->z, 1);
-
-	rc = -EINVAL;
-	ec->n = mpi_scanval(ecp->n);
-	if (!ec->n) {
-		mpi_point_release(ec->Q);
-		mpi_point_release(ec->G);
-		goto free;
-	}
-
-	ec->h = ecp->h;
-	ec->name = ecp->desc;
-	mpi_ec_init(ec, ecp->model, ecp->dialect, 0, p, a, b);
-
-	rc = 0;
-
-free:
-	mpi_free(x);
-	mpi_free(y);
-free_p:
-	mpi_free(p);
-	mpi_free(a);
-	mpi_free(b);
-
-	return rc;
-}
-
-static void sm2_ec_ctx_deinit(struct mpi_ec_ctx *ec)
-{
-	mpi_ec_deinit(ec);
-
-	memset(ec, 0, sizeof(*ec));
-}
-
 /* RESULT must have been initialized and is set on success to the
  * point given by VALUE.
  */
@@ -416,14 +324,14 @@ static int sm2_init_tfm(struct crypto_akcipher *tfm)
 {
 	struct mpi_ec_ctx *ec = akcipher_tfm_ctx(tfm);
 
-	return sm2_ec_ctx_init(ec);
+	return ec_mpi_ctx_init(ec, &sm2_ecp);
 }
 
 static void sm2_exit_tfm(struct crypto_akcipher *tfm)
 {
 	struct mpi_ec_ctx *ec = akcipher_tfm_ctx(tfm);
 
-	sm2_ec_ctx_deinit(ec);
+	ec_mpi_ctx_deinit(ec);
 }
 
 static struct akcipher_alg sm2 = {
-- 
2.27.0

