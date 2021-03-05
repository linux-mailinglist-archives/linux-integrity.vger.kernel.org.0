Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF82632DE94
	for <lists+linux-integrity@lfdr.de>; Fri,  5 Mar 2021 01:53:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231865AbhCEAwd (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 4 Mar 2021 19:52:33 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:7990 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231579AbhCEAwY (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 4 Mar 2021 19:52:24 -0500
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 1250k0cC032864;
        Thu, 4 Mar 2021 19:52:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=pp1;
 bh=QzjBFALSLq4QYZR2eCh+JG+vZKqRQhN+VIwKneoebbA=;
 b=dVOhTBgL7N5ujDwhXBPVNXcisioFr/9jxImsykJfOI3ZzJKYOv2wwpLDLAkwqdmthflt
 4qlpWo+Ywthir7p2KFqZqjZxBIN9vDSvzaP7SwLXYfi7q6PfztV08N+P/WPX5FqHv+Rs
 f8DRk/SVMctNxZHVmh089BvGeJjtyeCyCyTuZQmLJqDl6PrGA0/Gc6ETTASs36dMsKGE
 E0cxCdkEaw+bOYm1wnNxyM8oCxVS5B0BIfubKeRJ30NjF39d/fpQgZrF/03GyVdzixJZ
 9BudXAXwjNXYY629Ica1xpyz/GUEbktVOIvVD+eVE3DNVvujGmqgAh/CtlgyuHPv9UJj 3w== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 373ad1049n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 04 Mar 2021 19:52:13 -0500
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1250k1I3032884;
        Thu, 4 Mar 2021 19:52:12 -0500
Received: from ppma03wdc.us.ibm.com (ba.79.3fa9.ip4.static.sl-reverse.com [169.63.121.186])
        by mx0a-001b2d01.pphosted.com with ESMTP id 373ad10492-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 04 Mar 2021 19:52:12 -0500
Received: from pps.filterd (ppma03wdc.us.ibm.com [127.0.0.1])
        by ppma03wdc.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 1250WrAO025094;
        Fri, 5 Mar 2021 00:52:11 GMT
Received: from b03cxnp07027.gho.boulder.ibm.com (b03cxnp07027.gho.boulder.ibm.com [9.17.130.14])
        by ppma03wdc.us.ibm.com with ESMTP id 37128gv1cg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 05 Mar 2021 00:52:11 +0000
Received: from b03ledav006.gho.boulder.ibm.com (b03ledav006.gho.boulder.ibm.com [9.17.130.237])
        by b03cxnp07027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1250qAYT23069056
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 5 Mar 2021 00:52:10 GMT
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1BE61C6057;
        Fri,  5 Mar 2021 00:52:10 +0000 (GMT)
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 705EDC6055;
        Fri,  5 Mar 2021 00:52:09 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
        by b03ledav006.gho.boulder.ibm.com (Postfix) with ESMTP;
        Fri,  5 Mar 2021 00:52:09 +0000 (GMT)
From:   Stefan Berger <stefanb@linux.vnet.ibm.com>
To:     keyrings@vger.kernel.org, linux-crypto@vger.kernel.org,
        davem@davemloft.net, herbert@gondor.apana.org.au,
        dhowells@redhat.com, zohar@linux.ibm.com
Cc:     linux-kernel@vger.kernel.org, patrick@puiterwijk.org,
        linux-integrity@vger.kernel.org,
        Saulo Alessandre <saulo.alessandre@tse.jus.br>,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH v10 3/9] crypto: Add math to support fast NIST P384
Date:   Thu,  4 Mar 2021 19:51:57 -0500
Message-Id: <20210305005203.3547587-4-stefanb@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210305005203.3547587-1-stefanb@linux.vnet.ibm.com>
References: <20210305005203.3547587-1-stefanb@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-04_09:2021-03-03,2021-03-04 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 mlxlogscore=999 spamscore=0 priorityscore=1501 suspectscore=0
 clxscore=1015 mlxscore=0 phishscore=0 bulkscore=0 lowpriorityscore=0
 adultscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2009150000 definitions=main-2103050001
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

From: Saulo Alessandre <saulo.alessandre@tse.jus.br>

* crypto/ecc.c
  - add vli_mmod_fast_384
  - change some routines to pass ecc_curve forward until vli_mmod_fast

* crypto/ecc.h
  - add ECC_CURVE_NIST_P384_DIGITS
  - change ECC_MAX_DIGITS to P384 size

Signed-off-by: Saulo Alessandre <saulo.alessandre@tse.jus.br>
Tested-by: Stefan Berger <stefanb@linux.ibm.com>
---
 crypto/ecc.c | 266 +++++++++++++++++++++++++++++++++++++--------------
 crypto/ecc.h |   3 +-
 2 files changed, 194 insertions(+), 75 deletions(-)

diff --git a/crypto/ecc.c b/crypto/ecc.c
index f6cef5a7942d..c125576cda6b 100644
--- a/crypto/ecc.c
+++ b/crypto/ecc.c
@@ -778,18 +778,133 @@ static void vli_mmod_fast_256(u64 *result, const u64 *product,
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
+	tmp[1] = (product[10]<<32);	//a20|| 0
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
+			  const struct ecc_curve *curve)
 {
 	u64 tmp[2 * ECC_MAX_DIGITS];
+	const u64 *curve_prime = curve->p;
+	const unsigned int ndigits = curve->g.ndigits;
 
-	/* Currently, both NIST primes have -1 in lowest qword. */
-	if (curve_prime[0] != -1ull) {
+	/* Currently, all NIST have name nist_.* */
+	if (strncmp(curve->name, "nist_", 5) != 0) {
 		/* Try to handle Pseudo-Marsenne primes. */
 		if (curve_prime[ndigits - 1] == -1ull) {
 			vli_mmod_special(result, product, curve_prime,
@@ -812,6 +927,9 @@ static bool vli_mmod_fast(u64 *result, u64 *product,
 	case 4:
 		vli_mmod_fast_256(result, product, curve_prime, tmp);
 		break;
+	case 6:
+		vli_mmod_fast_384(result, product, curve_prime, tmp);
+		break;
 	default:
 		pr_err_ratelimited("ecc: unsupported digits size!\n");
 		return false;
@@ -835,22 +953,22 @@ EXPORT_SYMBOL(vli_mod_mult_slow);
 
 /* Computes result = (left * right) % curve_prime. */
 static void vli_mod_mult_fast(u64 *result, const u64 *left, const u64 *right,
-			      const u64 *curve_prime, unsigned int ndigits)
+			      const struct ecc_curve *curve)
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
@@ -948,25 +1066,27 @@ static bool ecc_point_is_zero(const struct ecc_point *point)
 
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
@@ -975,7 +1095,7 @@ static void ecc_point_double_jacobian(u64 *x1, u64 *y1, u64 *z1,
 	/* t3 = x1 - z1^2 */
 	vli_mod_sub(z1, x1, z1, curve_prime, ndigits);
 	/* t1 = x1^2 - z1^4 */
-	vli_mod_mult_fast(x1, x1, z1, curve_prime, ndigits);
+	vli_mod_mult_fast(x1, x1, z1, curve);
 
 	/* t3 = 2*(x1^2 - z1^4) */
 	vli_mod_add(z1, x1, x1, curve_prime, ndigits);
@@ -992,7 +1112,7 @@ static void ecc_point_double_jacobian(u64 *x1, u64 *y1, u64 *z1,
 	/* t1 = 3/2*(x1^2 - z1^4) = B */
 
 	/* t3 = B^2 */
-	vli_mod_square_fast(z1, x1, curve_prime, ndigits);
+	vli_mod_square_fast(z1, x1, curve);
 	/* t3 = B^2 - A */
 	vli_mod_sub(z1, z1, t5, curve_prime, ndigits);
 	/* t3 = B^2 - 2A = x3 */
@@ -1000,7 +1120,7 @@ static void ecc_point_double_jacobian(u64 *x1, u64 *y1, u64 *z1,
 	/* t5 = A - x3 */
 	vli_mod_sub(t5, t5, z1, curve_prime, ndigits);
 	/* t1 = B * (A - x3) */
-	vli_mod_mult_fast(x1, x1, t5, curve_prime, ndigits);
+	vli_mod_mult_fast(x1, x1, t5, curve);
 	/* t4 = B * (A - x3) - y1^4 = y3 */
 	vli_mod_sub(t4, x1, t4, curve_prime, ndigits);
 
@@ -1010,23 +1130,22 @@ static void ecc_point_double_jacobian(u64 *x1, u64 *y1, u64 *z1,
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
@@ -1037,35 +1156,37 @@ static void xycz_initial_double(u64 *x1, u64 *y1, u64 *x2, u64 *y2,
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
@@ -1074,11 +1195,11 @@ static void xycz_add(u64 *x1, u64 *y1, u64 *x2, u64 *y2, u64 *curve_prime,
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
 
@@ -1089,22 +1210,24 @@ static void xycz_add(u64 *x1, u64 *y1, u64 *x2, u64 *y2, u64 *curve_prime,
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
@@ -1113,29 +1236,29 @@ static void xycz_add_c(u64 *x1, u64 *y1, u64 *x2, u64 *y2, u64 *curve_prime,
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
 
@@ -1165,41 +1288,37 @@ static void ecc_point_mult(struct ecc_point *result,
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
@@ -1220,9 +1339,9 @@ static void ecc_point_add(const struct ecc_point *result,
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
@@ -1251,8 +1370,7 @@ void ecc_point_mult_shamir(const struct ecc_point *result,
 	points[2] = q;
 	points[3] = &sum;
 
-	num_bits = max(vli_num_bits(u1, ndigits),
-		       vli_num_bits(u2, ndigits));
+	num_bits = max(vli_num_bits(u1, ndigits), vli_num_bits(u2, ndigits));
 	i = num_bits - 1;
 	idx = (!!vli_test_bit(u1, i)) | ((!!vli_test_bit(u2, i)) << 1);
 	point = points[idx];
@@ -1263,7 +1381,7 @@ void ecc_point_mult_shamir(const struct ecc_point *result,
 	z[0] = 1;
 
 	for (--i; i >= 0; i--) {
-		ecc_point_double_jacobian(rx, ry, z, curve->p, ndigits);
+		ecc_point_double_jacobian(rx, ry, z, curve);
 		idx = (!!vli_test_bit(u1, i)) | ((!!vli_test_bit(u2, i)) << 1);
 		point = points[idx];
 		if (point) {
@@ -1273,14 +1391,14 @@ void ecc_point_mult_shamir(const struct ecc_point *result,
 
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
 
@@ -1434,10 +1552,10 @@ int ecc_is_pubkey_valid_partial(const struct ecc_curve *curve,
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
index 2ea86dfb5cf7..8f40ebd74565 100644
--- a/crypto/ecc.h
+++ b/crypto/ecc.h
@@ -29,7 +29,8 @@
 /* One digit is u64 qword. */
 #define ECC_CURVE_NIST_P192_DIGITS  3
 #define ECC_CURVE_NIST_P256_DIGITS  4
-#define ECC_MAX_DIGITS             (512 / 64)
+#define ECC_CURVE_NIST_P384_DIGITS  6
+#define ECC_MAX_DIGITS              (512 / 64) /* due to ecrdsa */
 
 #define ECC_DIGITS_TO_BYTES_SHIFT 3
 
-- 
2.29.2

