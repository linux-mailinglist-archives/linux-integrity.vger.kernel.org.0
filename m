Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9ECF233DFE6
	for <lists+linux-integrity@lfdr.de>; Tue, 16 Mar 2021 22:09:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232479AbhCPVIU (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 16 Mar 2021 17:08:20 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:49576 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231907AbhCPVIH (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 16 Mar 2021 17:08:07 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 12GL4kFl079083;
        Tue, 16 Mar 2021 17:07:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=5sJ3USGhI8ahnQIzdDx2iXzHJ4odYoT/NhbTZi259l4=;
 b=JVk/ujSnm7eZO6+ZoIOrVBKidmtljr/9ltFD82Qazc+d87d8QVUFgr+1FRECGFrmR7D+
 uqT0aPBkTcJ9NeQJ/KWL9RaDSvVQ+66oLFKbCqkTBaDxrlSOMSfsxStHbQPfIkwDv24L
 z5C01E4beQcOXKcOVLTwL72N57LC3e8v4oWg+YeMdU5GCMY63n0aCUhR1h3/0k0mUucz
 OF826a0OUOehSWj84G3y7BbngsT0SCQllYI7qbRBQKF+3bVuy5dWXBhMw2R1cUKDdV34
 W1MEUTE8Ox09fWncn3gGK9/Owg3QtbHue0CAN3jzjxe/MOhyxZNAljHQOnmYiV1h1OAg 2Q== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 37b0rvwsgu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 16 Mar 2021 17:07:56 -0400
Received: from m0098421.ppops.net (m0098421.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 12GL4v9T079561;
        Tue, 16 Mar 2021 17:07:55 -0400
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com [169.53.41.122])
        by mx0a-001b2d01.pphosted.com with ESMTP id 37b0rvwsgg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 16 Mar 2021 17:07:55 -0400
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
        by ppma04dal.us.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 12GL76rj024923;
        Tue, 16 Mar 2021 21:07:55 GMT
Received: from b03cxnp07029.gho.boulder.ibm.com (b03cxnp07029.gho.boulder.ibm.com [9.17.130.16])
        by ppma04dal.us.ibm.com with ESMTP id 37a3gcfn5r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 16 Mar 2021 21:07:55 +0000
Received: from b03ledav002.gho.boulder.ibm.com (b03ledav002.gho.boulder.ibm.com [9.17.130.233])
        by b03cxnp07029.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 12GL7rEK31457762
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 16 Mar 2021 21:07:53 GMT
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 399A8136051;
        Tue, 16 Mar 2021 21:07:53 +0000 (GMT)
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5DEB7136055;
        Tue, 16 Mar 2021 21:07:52 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.47.158.152])
        by b03ledav002.gho.boulder.ibm.com (Postfix) with ESMTP;
        Tue, 16 Mar 2021 21:07:52 +0000 (GMT)
From:   Stefan Berger <stefanb@linux.ibm.com>
To:     keyrings@vger.kernel.org, linux-crypto@vger.kernel.org,
        davem@davemloft.net, herbert@gondor.apana.org.au,
        dhowells@redhat.com, zohar@linux.ibm.com, jarkko@kernel.org
Cc:     linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, patrick@puiterwijk.org,
        Saulo Alessandre <saulo.alessandre@tse.jus.br>,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH v12 03/10] crypto: Add NIST P384 curve parameters
Date:   Tue, 16 Mar 2021 17:07:33 -0400
Message-Id: <20210316210740.1592994-4-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210316210740.1592994-1-stefanb@linux.ibm.com>
References: <20210316210740.1592994-1-stefanb@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-16_08:2021-03-16,2021-03-16 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 bulkscore=0
 adultscore=0 suspectscore=0 lowpriorityscore=0 mlxscore=0 phishscore=0
 impostorscore=0 spamscore=0 mlxlogscore=999 malwarescore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103160135
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

From: Saulo Alessandre <saulo.alessandre@tse.jus.br>

Add the parameters for the NIST P384 curve and define a new curve ID
for it. Make the curve available in ecc_get_curve.

Summary of changes:

* crypto/ecc_curve_defs.h
  - add nist_p384 params

* include/crypto/ecdh.h
  - add ECC_CURVE_NIST_P384

* crypto/ecc.c
  - change ecc_get_curve to accept nist_p384

Signed-off-by: Saulo Alessandre <saulo.alessandre@tse.jus.br>
Tested-by: Stefan Berger <stefanb@linux.ibm.com>
Acked-by: Jarkko Sakkinen <jarkko@kernel.org>
---
 crypto/ecc.c            |  2 ++
 crypto/ecc_curve_defs.h | 32 ++++++++++++++++++++++++++++++++
 include/crypto/ecdh.h   |  1 +
 3 files changed, 35 insertions(+)

diff --git a/crypto/ecc.c b/crypto/ecc.c
index 25e79fd70566..f6cef5a7942d 100644
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
diff --git a/crypto/ecc_curve_defs.h b/crypto/ecc_curve_defs.h
index 69be6c7d228f..b327732f6ef5 100644
--- a/crypto/ecc_curve_defs.h
+++ b/crypto/ecc_curve_defs.h
@@ -54,4 +54,36 @@ static struct ecc_curve nist_p256 = {
 	.b = nist_p256_b
 };
 
+/* NIST P-384 */
+static u64 nist_p384_g_x[] = { 0x3A545E3872760AB7ull, 0x5502F25DBF55296Cull,
+				0x59F741E082542A38ull, 0x6E1D3B628BA79B98ull,
+				0x8Eb1C71EF320AD74ull, 0xAA87CA22BE8B0537ull };
+static u64 nist_p384_g_y[] = { 0x7A431D7C90EA0E5Full, 0x0A60B1CE1D7E819Dull,
+				0xE9DA3113B5F0B8C0ull, 0xF8F41DBD289A147Cull,
+				0x5D9E98BF9292DC29ull, 0x3617DE4A96262C6Full };
+static u64 nist_p384_p[] = { 0x00000000FFFFFFFFull, 0xFFFFFFFF00000000ull,
+				0xFFFFFFFFFFFFFFFEull, 0xFFFFFFFFFFFFFFFFull,
+				0xFFFFFFFFFFFFFFFFull, 0xFFFFFFFFFFFFFFFFull };
+static u64 nist_p384_n[] = { 0xECEC196ACCC52973ull, 0x581A0DB248B0A77Aull,
+				0xC7634D81F4372DDFull, 0xFFFFFFFFFFFFFFFFull,
+				0xFFFFFFFFFFFFFFFFull, 0xFFFFFFFFFFFFFFFFull };
+static u64 nist_p384_a[] = { 0x00000000FFFFFFFCull, 0xFFFFFFFF00000000ull,
+				0xFFFFFFFFFFFFFFFEull, 0xFFFFFFFFFFFFFFFFull,
+				0xFFFFFFFFFFFFFFFFull, 0xFFFFFFFFFFFFFFFFull };
+static u64 nist_p384_b[] = { 0x2a85c8edd3ec2aefull, 0xc656398d8a2ed19dull,
+				0x0314088f5013875aull, 0x181d9c6efe814112ull,
+				0x988e056be3f82d19ull, 0xb3312fa7e23ee7e4ull };
+static struct ecc_curve nist_p384 = {
+	.name = "nist_384",
+	.g = {
+		.x = nist_p384_g_x,
+		.y = nist_p384_g_y,
+		.ndigits = 6,
+	},
+	.p = nist_p384_p,
+	.n = nist_p384_n,
+	.a = nist_p384_a,
+	.b = nist_p384_b
+};
+
 #endif
diff --git a/include/crypto/ecdh.h b/include/crypto/ecdh.h
index a5b805b5526d..e4ba1de961e4 100644
--- a/include/crypto/ecdh.h
+++ b/include/crypto/ecdh.h
@@ -25,6 +25,7 @@
 /* Curves IDs */
 #define ECC_CURVE_NIST_P192	0x0001
 #define ECC_CURVE_NIST_P256	0x0002
+#define ECC_CURVE_NIST_P384	0x0003
 
 /**
  * struct ecdh - define an ECDH private key
-- 
2.29.2

