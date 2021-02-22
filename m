Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B6B6321EB3
	for <lists+linux-integrity@lfdr.de>; Mon, 22 Feb 2021 19:00:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231907AbhBVR7x (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 22 Feb 2021 12:59:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231628AbhBVR7s (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 22 Feb 2021 12:59:48 -0500
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 256E9C061786;
        Mon, 22 Feb 2021 09:59:08 -0800 (PST)
Received: by mail-qt1-x831.google.com with SMTP id v3so9892497qtw.4;
        Mon, 22 Feb 2021 09:59:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=upy4LZN81JmkKsnhpewdn/2zpm3+mszwvnaxwayCE3Y=;
        b=bTNQgQbEmmce7DirxdGZNHLQLoI/vAOXy/pyv+sOPDBtd6s8VjYnza0NUECL8uW1dn
         Foa6Oc29+qb1//MkMxEq8UL3EIGDuoCEonoqSnusH39Wzv0C44lFbwDPOXz+dJcxghVy
         /78k3NYVHVrdT+Ds1fv0veo5RbmZpFkBz4kdPCkTUNNAhID2bJQQo04wkL8wMckUn9e7
         3a3ReC4iwNGnhy+9w0kWveHlFjDZJSi3CqzPDfr+5s6Q/7adrVe3qgA98IWbtjYXVyBx
         noprlmShp5M7RjxA+GmyF3Tlsfz4QHOiYOxYq9e06ye+N77lKxBTSFg4J2DNp6W16Nh7
         Ou7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=upy4LZN81JmkKsnhpewdn/2zpm3+mszwvnaxwayCE3Y=;
        b=Ntn9z9AKDY7PdmHHv3hLDhTCHh/QjMDLtHBeDJxIYlvAoz/DDc/ctOAk+VKJGYTOYY
         VUZ6wPiuRDfzTdxFAIMXidZjyO3/jup2bus+7bN1M+/67UKe+OZ0d/tYSGLC5xzXve0p
         itvOU6ZSgNDR98n8T/wkoMFpbGEJ1BkVoKEDTg0JquxxdAFgIIIcnpktzHgZz4CxMBFL
         b6Yf77IUzZ6gmYP4SDwKK3l07a4sDYnyFE8KJN7fyWA1ocRmbPryI7MaRDWOkrud6eZR
         Turl730yZgS4QP+pZVaJD0CtfaVvXAO6DRGTtezHmY/1xPkOKZRosCmPoSktXRkUYJcx
         J6qw==
X-Gm-Message-State: AOAM532BAQyPJaTdh3LyDXS/IcaIGkzRx9phd9fsswc3RzqReylT95op
        y769YGKeOm8wFS7x3xRm55w=
X-Google-Smtp-Source: ABdhPJyBOfNKXyder/sTPLzwDnkRekeudoCsp48+4h/llX43tKkCmGUpa0TVTE8sfKd60nyZF/URKA==
X-Received: by 2002:ac8:6d38:: with SMTP id r24mr20034112qtu.285.1614016746558;
        Mon, 22 Feb 2021 09:59:06 -0800 (PST)
Received: from localhost.localdomain ([189.61.66.20])
        by smtp.gmail.com with ESMTPSA id p6sm12686170qkg.36.2021.02.22.09.59.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Feb 2021 09:59:05 -0800 (PST)
From:   Saulo Alessandre <saulo.alessandre@gmail.com>
To:     stefanb@linux.ibm.com
Cc:     davem@davemloft.net, dhowells@redhat.com,
        herbert@gondor.apana.org.au, keyrings@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org, patrick@puiterwijk.org,
        zohar@linux.ibm.com, Saulo Alessandre <saulo.alessandre@tse.jus.br>
Subject: [PATCH v2 2/3] adds math to support nist_p384 fast and changes routines to pass forward ecc_curve
Date:   Mon, 22 Feb 2021 14:58:49 -0300
Message-Id: <20210222175850.1131780-2-saulo.alessandre@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210222175850.1131780-1-saulo.alessandre@gmail.com>
References: <20210215162532.1077098-1-stefanb@linux.ibm.com>
 <20210222175850.1131780-1-saulo.alessandre@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

From: Saulo Alessandre <saulo.alessandre@tse.jus.br>

*  crypto/ecc.c
  - change ecc_get_curve to accept nist_p384
  - add vli_mmod_fast_384
  - change some routines to pass ecc_curve forward until vli_mmod_fast

* crypto/ecc.h
  - add ECC_CURVE_NIST_P384_DIGITS

Signed-off-by: Saulo Alessandre <saulo.alessandre@tse.jus.br>
---
 crypto/ecc.c | 265 +++++++++++++++++++++++++++++++++++++--------------
 crypto/ecc.h |   3 +-
 2 files changed, 195 insertions(+), 73 deletions(-)

diff --git a/crypto/ecc.c b/crypto/ecc.c
index 25e79fd70566..db90f688dfb1 100644
--- a/crypto/ecc.c
+++ b/crypto/ecc.c
@@ -50,6 +50,8 @@ const struct ecc_curve *ecc_get_curve(unsigned int curve_id)
 		return fips_enabled ? NULL : &nist_p192;
 	case ECC_CURVE_NIST_P256:
 		return &nist_p256;
+	case ECC_CURVE_NIST_P384:
+		return &nist_p384;
 	default:
 		return NULL;
 	}
@@ -776,18 +778,133 @@ static void vli_mmod_fast_256(u64 *result, const u64 *product,
 	}
 }
 
+#define SL32OR32(x32, y32) (((u64)x32 << 32) | y32)
+#define AND64H(x64)  (x64 & 0xffFFffFF00000000ull)
+#define AND64L(x64)  (x64 & 0x00000000ffFFffFFull)
+
+/* Computes result = product % curve_prime
+ * from "Mathematical routines for the NIST prime elliptic curves"
+ */
+static void vli_mmod_fast_384(u64 *result, const u64 *product,
+				const u64 *curve_prime, u64 *tmp)
+{
+	int carry;
+	const unsigned int ndigits = 6;
+
+	/* t */
+	vli_set(result, product, ndigits);
+
+	/* s1 */
+	tmp[0] = 0;		// 0 || 0
+	tmp[1] = 0;		// 0 || 0
+	tmp[2] = SL32OR32(product[11], (product[10]>>32));	//a22||a21
+	tmp[3] = product[11]>>32;	// 0 ||a23
+	tmp[4] = 0;		// 0 || 0
+	tmp[5] = 0;		// 0 || 0
+	carry = vli_lshift(tmp, tmp, 1, ndigits);
+	carry += vli_add(result, result, tmp, ndigits);
+
+	/* s2 */
+	tmp[0] = product[6];	//a13||a12
+	tmp[1] = product[7];	//a15||a14
+	tmp[2] = product[8];	//a17||a16
+	tmp[3] = product[9];	//a19||a18
+	tmp[4] = product[10];	//a21||a20
+	tmp[5] = product[11];	//a23||a22
+	carry += vli_add(result, result, tmp, ndigits);
+
+	/* s3 */
+	tmp[0] = SL32OR32(product[11], (product[10]>>32));	//a22||a21
+	tmp[1] = SL32OR32(product[6], (product[11]>>32));	//a12||a23
+	tmp[2] = SL32OR32(product[7], (product[6])>>32);	//a14||a13
+	tmp[3] = SL32OR32(product[8], (product[7]>>32));	//a16||a15
+	tmp[4] = SL32OR32(product[9], (product[8]>>32));	//a18||a17
+	tmp[5] = SL32OR32(product[10], (product[9]>>32));	//a20||a19
+	carry += vli_add(result, result, tmp, ndigits);
+
+	/* s4 */
+	tmp[0] = AND64H(product[11]);	//a23|| 0
+	tmp[1] = (product[10]<<32); 	//a20|| 0
+	tmp[2] = product[6];	//a13||a12
+	tmp[3] = product[7];	//a15||a14
+	tmp[4] = product[8];	//a17||a16
+	tmp[5] = product[9];	//a19||a18
+	carry += vli_add(result, result, tmp, ndigits);
+
+	/* s5 */
+	tmp[0] = 0;		//  0|| 0
+	tmp[1] = 0;		//  0|| 0
+	tmp[2] = product[10];	//a21||a20
+	tmp[3] = product[11];	//a23||a22
+	tmp[4] = 0;		//  0|| 0
+	tmp[5] = 0;		//  0|| 0
+	carry += vli_add(result, result, tmp, ndigits);
+
+	/* s6 */
+	tmp[0] = AND64L(product[10]);	// 0 ||a20
+	tmp[1] = AND64H(product[10]);	//a21|| 0
+	tmp[2] = product[11];	//a23||a22
+	tmp[3] = 0;		// 0 || 0
+	tmp[4] = 0;		// 0 || 0
+	tmp[5] = 0;		// 0 || 0
+	carry += vli_add(result, result, tmp, ndigits);
+
+	/* d1 */
+	tmp[0] = SL32OR32(product[6], (product[11]>>32));	//a12||a23
+	tmp[1] = SL32OR32(product[7], (product[6]>>32));	//a14||a13
+	tmp[2] = SL32OR32(product[8], (product[7]>>32));	//a16||a15
+	tmp[3] = SL32OR32(product[9], (product[8]>>32));	//a18||a17
+	tmp[4] = SL32OR32(product[10], (product[9]>>32));	//a20||a19
+	tmp[5] = SL32OR32(product[11], (product[10]>>32));	//a22||a21
+	carry -= vli_sub(result, result, tmp, ndigits);
+
+	/* d2 */
+	tmp[0] = (product[10]<<32);	//a20|| 0
+	tmp[1] = SL32OR32(product[11], (product[10]>>32));	//a22||a21
+	tmp[2] = (product[11]>>32);	// 0 ||a23
+	tmp[3] = 0;		// 0 || 0
+	tmp[4] = 0;		// 0 || 0
+	tmp[5] = 0;		// 0 || 0
+	carry -= vli_sub(result, result, tmp, ndigits);
+
+	/* d3 */
+	tmp[0] = 0;		// 0 || 0
+	tmp[1] = AND64H(product[11]);	//a23|| 0
+	tmp[2] = product[11]>>32;	// 0 ||a23
+	tmp[3] = 0;		// 0 || 0
+	tmp[4] = 0;		// 0 || 0
+	tmp[5] = 0;		// 0 || 0
+	carry -= vli_sub(result, result, tmp, ndigits);
+
+	if (carry < 0) {
+		do {
+			carry += vli_add(result, result, curve_prime, ndigits);
+		} while (carry < 0);
+	} else {
+		while (carry || vli_cmp(curve_prime, result, ndigits) != 1)
+			carry -= vli_sub(result, result, curve_prime, ndigits);
+	}
+
+}
+
+#undef SL32OR32
+#undef AND64H
+#undef AND64L
+
 /* Computes result = product % curve_prime for different curve_primes.
  *
  * Note that curve_primes are distinguished just by heuristic check and
  * not by complete conformance check.
  */
 static bool vli_mmod_fast(u64 *result, u64 *product,
-			  const u64 *curve_prime, unsigned int ndigits)
+			const struct ecc_curve *curve)
 {
 	u64 tmp[2 * ECC_MAX_DIGITS];
+	const u64 *curve_prime = curve->p;
+	const unsigned int ndigits = curve->g.ndigits;
 
-	/* Currently, both NIST primes have -1 in lowest qword. */
-	if (curve_prime[0] != -1ull) {
+	/* Currently, all NIST have name nist_.* */
+	if (curve->name && strncmp(curve->name, "nist_", 5) != 0) {
 		/* Try to handle Pseudo-Marsenne primes. */
 		if (curve_prime[ndigits - 1] == -1ull) {
 			vli_mmod_special(result, product, curve_prime,
@@ -810,6 +927,9 @@ static bool vli_mmod_fast(u64 *result, u64 *product,
 	case 4:
 		vli_mmod_fast_256(result, product, curve_prime, tmp);
 		break;
+	case 6:
+		vli_mmod_fast_384(result, product, curve_prime, tmp);
+		break;
 	default:
 		pr_err_ratelimited("ecc: unsupported digits size!\n");
 		return false;
@@ -833,22 +953,22 @@ EXPORT_SYMBOL(vli_mod_mult_slow);
 
 /* Computes result = (left * right) % curve_prime. */
 static void vli_mod_mult_fast(u64 *result, const u64 *left, const u64 *right,
-			      const u64 *curve_prime, unsigned int ndigits)
+				const struct ecc_curve *curve)
 {
 	u64 product[2 * ECC_MAX_DIGITS];
 
-	vli_mult(product, left, right, ndigits);
-	vli_mmod_fast(result, product, curve_prime, ndigits);
+	vli_mult(product, left, right, curve->g.ndigits);
+	vli_mmod_fast(result, product, curve);
 }
 
 /* Computes result = left^2 % curve_prime. */
 static void vli_mod_square_fast(u64 *result, const u64 *left,
-				const u64 *curve_prime, unsigned int ndigits)
+				const struct ecc_curve *curve)
 {
 	u64 product[2 * ECC_MAX_DIGITS];
 
-	vli_square(product, left, ndigits);
-	vli_mmod_fast(result, product, curve_prime, ndigits);
+	vli_square(product, left, curve->g.ndigits);
+	vli_mmod_fast(result, product, curve);
 }
 
 #define EVEN(vli) (!(vli[0] & 1))
@@ -946,25 +1066,27 @@ static bool ecc_point_is_zero(const struct ecc_point *point)
 
 /* Double in place */
 static void ecc_point_double_jacobian(u64 *x1, u64 *y1, u64 *z1,
-				      u64 *curve_prime, unsigned int ndigits)
+					const struct ecc_curve *curve)
 {
 	/* t1 = x, t2 = y, t3 = z */
 	u64 t4[ECC_MAX_DIGITS];
 	u64 t5[ECC_MAX_DIGITS];
+	const u64 *curve_prime = curve->p;
+	const unsigned int ndigits = curve->g.ndigits;
 
 	if (vli_is_zero(z1, ndigits))
 		return;
 
 	/* t4 = y1^2 */
-	vli_mod_square_fast(t4, y1, curve_prime, ndigits);
+	vli_mod_square_fast(t4, y1, curve);
 	/* t5 = x1*y1^2 = A */
-	vli_mod_mult_fast(t5, x1, t4, curve_prime, ndigits);
+	vli_mod_mult_fast(t5, x1, t4, curve);
 	/* t4 = y1^4 */
-	vli_mod_square_fast(t4, t4, curve_prime, ndigits);
+	vli_mod_square_fast(t4, t4, curve);
 	/* t2 = y1*z1 = z3 */
-	vli_mod_mult_fast(y1, y1, z1, curve_prime, ndigits);
+	vli_mod_mult_fast(y1, y1, z1, curve);
 	/* t3 = z1^2 */
-	vli_mod_square_fast(z1, z1, curve_prime, ndigits);
+	vli_mod_square_fast(z1, z1, curve);
 
 	/* t1 = x1 + z1^2 */
 	vli_mod_add(x1, x1, z1, curve_prime, ndigits);
@@ -973,7 +1095,7 @@ static void ecc_point_double_jacobian(u64 *x1, u64 *y1, u64 *z1,
 	/* t3 = x1 - z1^2 */
 	vli_mod_sub(z1, x1, z1, curve_prime, ndigits);
 	/* t1 = x1^2 - z1^4 */
-	vli_mod_mult_fast(x1, x1, z1, curve_prime, ndigits);
+	vli_mod_mult_fast(x1, x1, z1, curve);
 
 	/* t3 = 2*(x1^2 - z1^4) */
 	vli_mod_add(z1, x1, x1, curve_prime, ndigits);
@@ -990,7 +1112,7 @@ static void ecc_point_double_jacobian(u64 *x1, u64 *y1, u64 *z1,
 	/* t1 = 3/2*(x1^2 - z1^4) = B */
 
 	/* t3 = B^2 */
-	vli_mod_square_fast(z1, x1, curve_prime, ndigits);
+	vli_mod_square_fast(z1, x1, curve);
 	/* t3 = B^2 - A */
 	vli_mod_sub(z1, z1, t5, curve_prime, ndigits);
 	/* t3 = B^2 - 2A = x3 */
@@ -998,7 +1120,7 @@ static void ecc_point_double_jacobian(u64 *x1, u64 *y1, u64 *z1,
 	/* t5 = A - x3 */
 	vli_mod_sub(t5, t5, z1, curve_prime, ndigits);
 	/* t1 = B * (A - x3) */
-	vli_mod_mult_fast(x1, x1, t5, curve_prime, ndigits);
+	vli_mod_mult_fast(x1, x1, t5, curve);
 	/* t4 = B * (A - x3) - y1^4 = y3 */
 	vli_mod_sub(t4, x1, t4, curve_prime, ndigits);
 
@@ -1008,23 +1130,22 @@ static void ecc_point_double_jacobian(u64 *x1, u64 *y1, u64 *z1,
 }
 
 /* Modify (x1, y1) => (x1 * z^2, y1 * z^3) */
-static void apply_z(u64 *x1, u64 *y1, u64 *z, u64 *curve_prime,
-		    unsigned int ndigits)
+static void apply_z(u64 *x1, u64 *y1, u64 *z, const struct ecc_curve *curve)
 {
 	u64 t1[ECC_MAX_DIGITS];
 
-	vli_mod_square_fast(t1, z, curve_prime, ndigits);    /* z^2 */
-	vli_mod_mult_fast(x1, x1, t1, curve_prime, ndigits); /* x1 * z^2 */
-	vli_mod_mult_fast(t1, t1, z, curve_prime, ndigits);  /* z^3 */
-	vli_mod_mult_fast(y1, y1, t1, curve_prime, ndigits); /* y1 * z^3 */
+	vli_mod_square_fast(t1, z, curve);		/* z^2 */
+	vli_mod_mult_fast(x1, x1, t1, curve);	/* x1 * z^2 */
+	vli_mod_mult_fast(t1, t1, z, curve);	/* z^3 */
+	vli_mod_mult_fast(y1, y1, t1, curve);	/* y1 * z^3 */
 }
 
 /* P = (x1, y1) => 2P, (x2, y2) => P' */
 static void xycz_initial_double(u64 *x1, u64 *y1, u64 *x2, u64 *y2,
-				u64 *p_initial_z, u64 *curve_prime,
-				unsigned int ndigits)
+				u64 *p_initial_z, const struct ecc_curve *curve)
 {
 	u64 z[ECC_MAX_DIGITS];
+	const unsigned int ndigits = curve->g.ndigits;
 
 	vli_set(x2, x1, ndigits);
 	vli_set(y2, y1, ndigits);
@@ -1035,35 +1156,37 @@ static void xycz_initial_double(u64 *x1, u64 *y1, u64 *x2, u64 *y2,
 	if (p_initial_z)
 		vli_set(z, p_initial_z, ndigits);
 
-	apply_z(x1, y1, z, curve_prime, ndigits);
+	apply_z(x1, y1, z, curve);
 
-	ecc_point_double_jacobian(x1, y1, z, curve_prime, ndigits);
+	ecc_point_double_jacobian(x1, y1, z, curve);
 
-	apply_z(x2, y2, z, curve_prime, ndigits);
+	apply_z(x2, y2, z, curve);
 }
 
 /* Input P = (x1, y1, Z), Q = (x2, y2, Z)
  * Output P' = (x1', y1', Z3), P + Q = (x3, y3, Z3)
  * or P => P', Q => P + Q
  */
-static void xycz_add(u64 *x1, u64 *y1, u64 *x2, u64 *y2, u64 *curve_prime,
-		     unsigned int ndigits)
+static void xycz_add(u64 *x1, u64 *y1, u64 *x2, u64 *y2,
+			const struct ecc_curve *curve)
 {
 	/* t1 = X1, t2 = Y1, t3 = X2, t4 = Y2 */
 	u64 t5[ECC_MAX_DIGITS];
+	const u64 *curve_prime = curve->p;
+	const unsigned int ndigits = curve->g.ndigits;
 
 	/* t5 = x2 - x1 */
 	vli_mod_sub(t5, x2, x1, curve_prime, ndigits);
 	/* t5 = (x2 - x1)^2 = A */
-	vli_mod_square_fast(t5, t5, curve_prime, ndigits);
+	vli_mod_square_fast(t5, t5, curve);
 	/* t1 = x1*A = B */
-	vli_mod_mult_fast(x1, x1, t5, curve_prime, ndigits);
+	vli_mod_mult_fast(x1, x1, t5, curve);
 	/* t3 = x2*A = C */
-	vli_mod_mult_fast(x2, x2, t5, curve_prime, ndigits);
+	vli_mod_mult_fast(x2, x2, t5, curve);
 	/* t4 = y2 - y1 */
 	vli_mod_sub(y2, y2, y1, curve_prime, ndigits);
 	/* t5 = (y2 - y1)^2 = D */
-	vli_mod_square_fast(t5, y2, curve_prime, ndigits);
+	vli_mod_square_fast(t5, y2, curve);
 
 	/* t5 = D - B */
 	vli_mod_sub(t5, t5, x1, curve_prime, ndigits);
@@ -1072,11 +1195,11 @@ static void xycz_add(u64 *x1, u64 *y1, u64 *x2, u64 *y2, u64 *curve_prime,
 	/* t3 = C - B */
 	vli_mod_sub(x2, x2, x1, curve_prime, ndigits);
 	/* t2 = y1*(C - B) */
-	vli_mod_mult_fast(y1, y1, x2, curve_prime, ndigits);
+	vli_mod_mult_fast(y1, y1, x2, curve);
 	/* t3 = B - x3 */
 	vli_mod_sub(x2, x1, t5, curve_prime, ndigits);
 	/* t4 = (y2 - y1)*(B - x3) */
-	vli_mod_mult_fast(y2, y2, x2, curve_prime, ndigits);
+	vli_mod_mult_fast(y2, y2, x2, curve);
 	/* t4 = y3 */
 	vli_mod_sub(y2, y2, y1, curve_prime, ndigits);
 
@@ -1087,22 +1210,24 @@ static void xycz_add(u64 *x1, u64 *y1, u64 *x2, u64 *y2, u64 *curve_prime,
  * Output P + Q = (x3, y3, Z3), P - Q = (x3', y3', Z3)
  * or P => P - Q, Q => P + Q
  */
-static void xycz_add_c(u64 *x1, u64 *y1, u64 *x2, u64 *y2, u64 *curve_prime,
-		       unsigned int ndigits)
+static void xycz_add_c(u64 *x1, u64 *y1, u64 *x2, u64 *y2,
+			const struct ecc_curve *curve)
 {
 	/* t1 = X1, t2 = Y1, t3 = X2, t4 = Y2 */
 	u64 t5[ECC_MAX_DIGITS];
 	u64 t6[ECC_MAX_DIGITS];
 	u64 t7[ECC_MAX_DIGITS];
+	const u64 *curve_prime = curve->p;
+	const unsigned int ndigits = curve->g.ndigits;
 
 	/* t5 = x2 - x1 */
 	vli_mod_sub(t5, x2, x1, curve_prime, ndigits);
 	/* t5 = (x2 - x1)^2 = A */
-	vli_mod_square_fast(t5, t5, curve_prime, ndigits);
+	vli_mod_square_fast(t5, t5, curve);
 	/* t1 = x1*A = B */
-	vli_mod_mult_fast(x1, x1, t5, curve_prime, ndigits);
+	vli_mod_mult_fast(x1, x1, t5, curve);
 	/* t3 = x2*A = C */
-	vli_mod_mult_fast(x2, x2, t5, curve_prime, ndigits);
+	vli_mod_mult_fast(x2, x2, t5, curve);
 	/* t4 = y2 + y1 */
 	vli_mod_add(t5, y2, y1, curve_prime, ndigits);
 	/* t4 = y2 - y1 */
@@ -1111,29 +1236,29 @@ static void xycz_add_c(u64 *x1, u64 *y1, u64 *x2, u64 *y2, u64 *curve_prime,
 	/* t6 = C - B */
 	vli_mod_sub(t6, x2, x1, curve_prime, ndigits);
 	/* t2 = y1 * (C - B) */
-	vli_mod_mult_fast(y1, y1, t6, curve_prime, ndigits);
+	vli_mod_mult_fast(y1, y1, t6, curve);
 	/* t6 = B + C */
 	vli_mod_add(t6, x1, x2, curve_prime, ndigits);
 	/* t3 = (y2 - y1)^2 */
-	vli_mod_square_fast(x2, y2, curve_prime, ndigits);
+	vli_mod_square_fast(x2, y2, curve);
 	/* t3 = x3 */
 	vli_mod_sub(x2, x2, t6, curve_prime, ndigits);
 
 	/* t7 = B - x3 */
 	vli_mod_sub(t7, x1, x2, curve_prime, ndigits);
 	/* t4 = (y2 - y1)*(B - x3) */
-	vli_mod_mult_fast(y2, y2, t7, curve_prime, ndigits);
+	vli_mod_mult_fast(y2, y2, t7, curve);
 	/* t4 = y3 */
 	vli_mod_sub(y2, y2, y1, curve_prime, ndigits);
 
 	/* t7 = (y2 + y1)^2 = F */
-	vli_mod_square_fast(t7, t5, curve_prime, ndigits);
+	vli_mod_square_fast(t7, t5, curve);
 	/* t7 = x3' */
 	vli_mod_sub(t7, t7, t6, curve_prime, ndigits);
 	/* t6 = x3' - B */
 	vli_mod_sub(t6, t7, x1, curve_prime, ndigits);
 	/* t6 = (y2 + y1)*(x3' - B) */
-	vli_mod_mult_fast(t6, t6, t5, curve_prime, ndigits);
+	vli_mod_mult_fast(t6, t6, t5, curve);
 	/* t2 = y3' */
 	vli_mod_sub(y1, t6, y1, curve_prime, ndigits);
 
@@ -1163,41 +1288,37 @@ static void ecc_point_mult(struct ecc_point *result,
 	vli_set(rx[1], point->x, ndigits);
 	vli_set(ry[1], point->y, ndigits);
 
-	xycz_initial_double(rx[1], ry[1], rx[0], ry[0], initial_z, curve_prime,
-			    ndigits);
+	xycz_initial_double(rx[1], ry[1], rx[0], ry[0], initial_z, curve);
 
 	for (i = num_bits - 2; i > 0; i--) {
 		nb = !vli_test_bit(scalar, i);
-		xycz_add_c(rx[1 - nb], ry[1 - nb], rx[nb], ry[nb], curve_prime,
-			   ndigits);
-		xycz_add(rx[nb], ry[nb], rx[1 - nb], ry[1 - nb], curve_prime,
-			 ndigits);
+		xycz_add_c(rx[1 - nb], ry[1 - nb], rx[nb], ry[nb], curve);
+		xycz_add(rx[nb], ry[nb], rx[1 - nb], ry[1 - nb], curve);
 	}
 
 	nb = !vli_test_bit(scalar, 0);
-	xycz_add_c(rx[1 - nb], ry[1 - nb], rx[nb], ry[nb], curve_prime,
-		   ndigits);
+	xycz_add_c(rx[1 - nb], ry[1 - nb], rx[nb], ry[nb], curve);
 
 	/* Find final 1/Z value. */
 	/* X1 - X0 */
 	vli_mod_sub(z, rx[1], rx[0], curve_prime, ndigits);
 	/* Yb * (X1 - X0) */
-	vli_mod_mult_fast(z, z, ry[1 - nb], curve_prime, ndigits);
+	vli_mod_mult_fast(z, z, ry[1 - nb], curve);
 	/* xP * Yb * (X1 - X0) */
-	vli_mod_mult_fast(z, z, point->x, curve_prime, ndigits);
+	vli_mod_mult_fast(z, z, point->x, curve);
 
 	/* 1 / (xP * Yb * (X1 - X0)) */
 	vli_mod_inv(z, z, curve_prime, point->ndigits);
 
 	/* yP / (xP * Yb * (X1 - X0)) */
-	vli_mod_mult_fast(z, z, point->y, curve_prime, ndigits);
+	vli_mod_mult_fast(z, z, point->y, curve);
 	/* Xb * yP / (xP * Yb * (X1 - X0)) */
-	vli_mod_mult_fast(z, z, rx[1 - nb], curve_prime, ndigits);
+	vli_mod_mult_fast(z, z, rx[1 - nb], curve);
 	/* End 1/Z calculation */
 
-	xycz_add(rx[nb], ry[nb], rx[1 - nb], ry[1 - nb], curve_prime, ndigits);
+	xycz_add(rx[nb], ry[nb], rx[1 - nb], ry[1 - nb], curve);
 
-	apply_z(rx[0], ry[0], z, curve_prime, ndigits);
+	apply_z(rx[0], ry[0], z, curve);
 
 	vli_set(result->x, rx[0], ndigits);
 	vli_set(result->y, ry[0], ndigits);
@@ -1218,9 +1339,9 @@ static void ecc_point_add(const struct ecc_point *result,
 	vli_mod_sub(z, result->x, p->x, curve->p, ndigits);
 	vli_set(px, p->x, ndigits);
 	vli_set(py, p->y, ndigits);
-	xycz_add(px, py, result->x, result->y, curve->p, ndigits);
+	xycz_add(px, py, result->x, result->y, curve);
 	vli_mod_inv(z, z, curve->p, ndigits);
-	apply_z(result->x, result->y, z, curve->p, ndigits);
+	apply_z(result->x, result->y, z, curve);
 }
 
 /* Computes R = u1P + u2Q mod p using Shamir's trick.
@@ -1261,7 +1382,7 @@ void ecc_point_mult_shamir(const struct ecc_point *result,
 	z[0] = 1;
 
 	for (--i; i >= 0; i--) {
-		ecc_point_double_jacobian(rx, ry, z, curve->p, ndigits);
+		ecc_point_double_jacobian(rx, ry, z, curve);
 		idx = (!!vli_test_bit(u1, i)) | ((!!vli_test_bit(u2, i)) << 1);
 		point = points[idx];
 		if (point) {
@@ -1271,14 +1392,14 @@ void ecc_point_mult_shamir(const struct ecc_point *result,
 
 			vli_set(tx, point->x, ndigits);
 			vli_set(ty, point->y, ndigits);
-			apply_z(tx, ty, z, curve->p, ndigits);
+			apply_z(tx, ty, z, curve);
 			vli_mod_sub(tz, rx, tx, curve->p, ndigits);
-			xycz_add(tx, ty, rx, ry, curve->p, ndigits);
-			vli_mod_mult_fast(z, z, tz, curve->p, ndigits);
+			xycz_add(tx, ty, rx, ry, curve);
+			vli_mod_mult_fast(z, z, tz, curve);
 		}
 	}
 	vli_mod_inv(z, z, curve->p, ndigits);
-	apply_z(rx, ry, z, curve->p, ndigits);
+	apply_z(rx, ry, z, curve);
 }
 EXPORT_SYMBOL(ecc_point_mult_shamir);
 
@@ -1432,10 +1553,10 @@ int ecc_is_pubkey_valid_partial(const struct ecc_curve *curve,
 		return -EINVAL;
 
 	/* Check 3: Verify that y^2 == (x^3 + a·x + b) mod p */
-	vli_mod_square_fast(yy, pk->y, curve->p, pk->ndigits); /* y^2 */
-	vli_mod_square_fast(xxx, pk->x, curve->p, pk->ndigits); /* x^2 */
-	vli_mod_mult_fast(xxx, xxx, pk->x, curve->p, pk->ndigits); /* x^3 */
-	vli_mod_mult_fast(w, curve->a, pk->x, curve->p, pk->ndigits); /* a·x */
+	vli_mod_square_fast(yy, pk->y, curve); /* y^2 */
+	vli_mod_square_fast(xxx, pk->x, curve); /* x^2 */
+	vli_mod_mult_fast(xxx, xxx, pk->x, curve); /* x^3 */
+	vli_mod_mult_fast(w, curve->a, pk->x, curve); /* a·x */
 	vli_mod_add(w, w, curve->b, curve->p, pk->ndigits); /* a·x + b */
 	vli_mod_add(w, w, xxx, curve->p, pk->ndigits); /* x^3 + a·x + b */
 	if (vli_cmp(yy, w, pk->ndigits) != 0) /* Equation */
diff --git a/crypto/ecc.h b/crypto/ecc.h
index 2ea86dfb5cf7..c3ad222609de 100644
--- a/crypto/ecc.h
+++ b/crypto/ecc.h
@@ -29,7 +29,8 @@
 /* One digit is u64 qword. */
 #define ECC_CURVE_NIST_P192_DIGITS  3
 #define ECC_CURVE_NIST_P256_DIGITS  4
-#define ECC_MAX_DIGITS             (512 / 64)
+#define ECC_CURVE_NIST_P384_DIGITS  6
+#define ECC_MAX_DIGITS              (512 / 64)
 
 #define ECC_DIGITS_TO_BYTES_SHIFT 3
 
-- 
2.25.1

