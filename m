Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E191C309F86
	for <lists+linux-integrity@lfdr.de>; Mon,  1 Feb 2021 00:36:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230192AbhAaXfV (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 31 Jan 2021 18:35:21 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:41776 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229765AbhAaXd4 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 31 Jan 2021 18:33:56 -0500
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 10VNVnXC165864;
        Sun, 31 Jan 2021 18:33:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=wN2IIjhkFjHzZIfdAgrW8xts+j0dytluu90YpCqbmyM=;
 b=kuPM67oGjsoO07vVGsXiq5F2visacoinmnFBEwx5g5eCN3Sqgd1vjdwFC8jWuvLlH/aX
 2HPS/QpSXgC8Eu+W8DCfVwbzXRbzS2LYxAQJSyN7LFAoGxdRKvMYzF3ZCuTZcvWjuvQx
 gA21Ztv0hyO0g4Gvn3jahQhviaS1Bad6nSH4186+y1KJ9cGXnfuyDpZ3QWeJfWdJsG9Q
 Ipk+JyKcNp+PSBix+FXHg2GWUyroP5Q9C/ljnH+E806wH9/lIjBQKEtBaYsE79nXHUH0
 jdQu5Wc7+eeb8jbYA3YzkQP/YsuOvXjwkgNuCmvd/wWKViCHV/7Jm1tqdJMrSn59UqS/ Bg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 36e5murmx1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 31 Jan 2021 18:33:11 -0500
Received: from m0098417.ppops.net (m0098417.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 10VNXAhc171766;
        Sun, 31 Jan 2021 18:33:10 -0500
Received: from ppma03wdc.us.ibm.com (ba.79.3fa9.ip4.static.sl-reverse.com [169.63.121.186])
        by mx0a-001b2d01.pphosted.com with ESMTP id 36e5murmwv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 31 Jan 2021 18:33:10 -0500
Received: from pps.filterd (ppma03wdc.us.ibm.com [127.0.0.1])
        by ppma03wdc.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 10VNW017013376;
        Sun, 31 Jan 2021 23:33:09 GMT
Received: from b03cxnp08028.gho.boulder.ibm.com (b03cxnp08028.gho.boulder.ibm.com [9.17.130.20])
        by ppma03wdc.us.ibm.com with ESMTP id 36cy38jjru-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 31 Jan 2021 23:33:09 +0000
Received: from b03ledav005.gho.boulder.ibm.com (b03ledav005.gho.boulder.ibm.com [9.17.130.236])
        by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 10VNX8RP36766058
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 31 Jan 2021 23:33:08 GMT
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 47954BE051;
        Sun, 31 Jan 2021 23:33:08 +0000 (GMT)
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8479BBE04F;
        Sun, 31 Jan 2021 23:33:07 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
        by b03ledav005.gho.boulder.ibm.com (Postfix) with ESMTP;
        Sun, 31 Jan 2021 23:33:07 +0000 (GMT)
From:   Stefan Berger <stefanb@linux.ibm.com>
To:     keyrings@vger.kernel.org, linux-crypto@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, patrick@puiterwijk.org,
        linux-integrity@vger.kernel.org,
        Stefan Berger <stefanb@linux.ibm.com>,
        Vitaly Chikunov <vt@altlinux.org>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        Tianjia Zhang <tianjia.zhang@linux.alibaba.com>,
        David Howells <dhowells@redhat.com>
Subject: [PATCH v6 4/4] ima: Support EC keys for signature verification
Date:   Sun, 31 Jan 2021 18:33:01 -0500
Message-Id: <20210131233301.1301787-5-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210131233301.1301787-1-stefanb@linux.ibm.com>
References: <20210131233301.1301787-1-stefanb@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.737
 definitions=2021-01-31_08:2021-01-29,2021-01-31 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 malwarescore=0
 mlxlogscore=999 suspectscore=0 priorityscore=1501 clxscore=1015
 phishscore=0 mlxscore=0 adultscore=0 impostorscore=0 spamscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101310134
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Add support for IMA signature verification for EC keys. Since SHA type
of hashes can be used by RSA and ECDSA signature schemes we need to
look at the key and derive from the key which signature scheme to use.
Since this can be applied to all types of keys, we change the selection
of the encoding type to be driven by the key's signature scheme rather
than by the hash type.

Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
Reviewed-by: Vitaly Chikunov <vt@altlinux.org>
Cc: Mimi Zohar <zohar@linux.ibm.com>
Cc: Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
Cc: linux-integrity@vger.kernel.org
Cc: Vitaly Chikunov <vt@altlinux.org>
Cc: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
Cc: David Howells <dhowells@redhat.com>
Cc: keyrings@vger.kernel.org
---
 include/keys/asymmetric-type.h         |  6 ++++++
 security/integrity/digsig_asymmetric.c | 29 ++++++++++++--------------
 2 files changed, 19 insertions(+), 16 deletions(-)

diff --git a/include/keys/asymmetric-type.h b/include/keys/asymmetric-type.h
index a29d3ff2e7e8..c432fdb8547f 100644
--- a/include/keys/asymmetric-type.h
+++ b/include/keys/asymmetric-type.h
@@ -72,6 +72,12 @@ const struct asymmetric_key_ids *asymmetric_key_ids(const struct key *key)
 	return key->payload.data[asym_key_ids];
 }
 
+static inline
+const struct public_key *asymmetric_key_public_key(const struct key *key)
+{
+	return key->payload.data[asym_crypto];
+}
+
 extern struct key *find_asymmetric_key(struct key *keyring,
 				       const struct asymmetric_key_id *id_0,
 				       const struct asymmetric_key_id *id_1,
diff --git a/security/integrity/digsig_asymmetric.c b/security/integrity/digsig_asymmetric.c
index a662024b4c70..29002d016607 100644
--- a/security/integrity/digsig_asymmetric.c
+++ b/security/integrity/digsig_asymmetric.c
@@ -84,6 +84,7 @@ int asymmetric_verify(struct key *keyring, const char *sig,
 {
 	struct public_key_signature pks;
 	struct signature_v2_hdr *hdr = (struct signature_v2_hdr *)sig;
+	const struct public_key *pk;
 	struct key *key;
 	int ret;
 
@@ -105,23 +106,19 @@ int asymmetric_verify(struct key *keyring, const char *sig,
 	memset(&pks, 0, sizeof(pks));
 
 	pks.hash_algo = hash_algo_name[hdr->hash_algo];
-	switch (hdr->hash_algo) {
-	case HASH_ALGO_STREEBOG_256:
-	case HASH_ALGO_STREEBOG_512:
-		/* EC-RDSA and Streebog should go together. */
-		pks.pkey_algo = "ecrdsa";
-		pks.encoding = "raw";
-		break;
-	case HASH_ALGO_SM3_256:
-		/* SM2 and SM3 should go together. */
-		pks.pkey_algo = "sm2";
-		pks.encoding = "raw";
-		break;
-	default:
-		pks.pkey_algo = "rsa";
+
+	pk = asymmetric_key_public_key(key);
+	pks.pkey_algo = pk->pkey_algo;
+	if (!strcmp(pk->pkey_algo, "rsa"))
 		pks.encoding = "pkcs1";
-		break;
-	}
+	else if (!strcmp(pk->pkey_algo, "ecdsa"))
+		pks.encoding = "x962";
+	else if (!strcmp(pk->pkey_algo, "ecrdsa") ||
+		   !strcmp(pk->pkey_algo, "sm2"))
+		pks.encoding = "raw";
+	else
+		return -ENOPKG;
+
 	pks.digest = (u8 *)data;
 	pks.digest_size = datalen;
 	pks.s = hdr->sig;
-- 
2.29.2

