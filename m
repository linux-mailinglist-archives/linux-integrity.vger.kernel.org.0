Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E3FB325326
	for <lists+linux-integrity@lfdr.de>; Thu, 25 Feb 2021 17:10:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229886AbhBYQJ1 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 25 Feb 2021 11:09:27 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:16072 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233545AbhBYQJN (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 25 Feb 2021 11:09:13 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 11PG4hiR092545;
        Thu, 25 Feb 2021 11:08:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=MXfCX1wk9BIZ68gGWhcDaFwNYVRHvKY3ZF4SIXiWy20=;
 b=PUJIpBTVX8QY7aAKO9lK4RL6TVVwe84c5TJSiSS/zvm7mluC30z8D8HRwPCq4f3Z0E30
 7kxFtf2sYdGQ2IaUrz9iVS7VGop+FXg85402jktTRVD4ybnatkFx+PW+XFAznHFHg7hg
 MoMGBo3ztequJ9vTYr8rfRCu9VrvL1VukU+AElMrVF1an9uGXrnAfCsNW3ZkOG7Uh9iR
 sYQyaTqzD3lz/06hY4ogcUPiM44jalMaVWlFo/k1+C5WzcaMvJDKK4k3Qt202CvJdA6V
 MpyDwj4HJFH6lM9mFpbo9TvwPNEFWv2OMwiFD0QIku0VzNpc8CJjfn2npQuitf5U/LbH 7g== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 36x8dwpxjv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 25 Feb 2021 11:08:24 -0500
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 11PG4tms093683;
        Thu, 25 Feb 2021 11:08:23 -0500
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com [169.53.41.122])
        by mx0a-001b2d01.pphosted.com with ESMTP id 36x8dwpxj4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 25 Feb 2021 11:08:23 -0500
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
        by ppma04dal.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 11PG2Pqb013608;
        Thu, 25 Feb 2021 16:08:22 GMT
Received: from b03cxnp07028.gho.boulder.ibm.com (b03cxnp07028.gho.boulder.ibm.com [9.17.130.15])
        by ppma04dal.us.ibm.com with ESMTP id 36tt2b1rhh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 25 Feb 2021 16:08:22 +0000
Received: from b03ledav001.gho.boulder.ibm.com (b03ledav001.gho.boulder.ibm.com [9.17.130.232])
        by b03cxnp07028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 11PG8K3v27328804
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 25 Feb 2021 16:08:20 GMT
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CA5C36E050;
        Thu, 25 Feb 2021 16:08:20 +0000 (GMT)
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2518B6E04C;
        Thu, 25 Feb 2021 16:08:20 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
        by b03ledav001.gho.boulder.ibm.com (Postfix) with ESMTP;
        Thu, 25 Feb 2021 16:08:20 +0000 (GMT)
From:   Stefan Berger <stefanb@linux.vnet.ibm.com>
To:     keyrings@vger.kernel.org, linux-crypto@vger.kernel.org,
        davem@davemloft.net, herbert@gondor.apana.org.au,
        dhowells@redhat.com, zohar@linux.ibm.com
Cc:     linux-kernel@vger.kernel.org, patrick@puiterwijk.org,
        linux-integrity@vger.kernel.org,
        Stefan Berger <stefanb@linux.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        Vitaly Chikunov <vt@altlinux.org>,
        Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
Subject: [PATCH v9 4/9] ima: Support EC keys for signature verification
Date:   Thu, 25 Feb 2021 11:07:57 -0500
Message-Id: <20210225160802.2478700-5-stefanb@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210225160802.2478700-1-stefanb@linux.vnet.ibm.com>
References: <20210225160802.2478700-1-stefanb@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-02-25_09:2021-02-24,2021-02-25 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 adultscore=0 lowpriorityscore=0 spamscore=0 clxscore=1011 phishscore=0
 suspectscore=0 malwarescore=0 bulkscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102250127
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

From: Stefan Berger <stefanb@linux.ibm.com>

Add support for IMA signature verification for EC keys. Since SHA type
of hashes can be used by RSA and ECDSA signature schemes we need to
look at the key and derive from the key which signature scheme to use.
Since this can be applied to all types of keys, we change the selection
of the encoding type to be driven by the key's signature scheme rather
than by the hash type.

Cc: Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
Cc: linux-integrity@vger.kernel.org
Cc: David Howells <dhowells@redhat.com>
Cc: keyrings@vger.kernel.org
Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
Reviewed-by: Vitaly Chikunov <vt@altlinux.org>
Reviewed-by: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
Acked-by: Mimi Zohar <zohar@linux.ibm.com>

---
v7->v8:
  - use strncmp to check for 'ecdsa-' to match 'ecdsa-nist-p192' and
    'ecdsa-nist-p256' key types; previously they were just 'ecdsa'
---
 include/keys/asymmetric-type.h         |  6 ++++++
 security/integrity/digsig_asymmetric.c | 30 ++++++++++++--------------
 2 files changed, 20 insertions(+), 16 deletions(-)

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
index a662024b4c70..23240d793b07 100644
--- a/security/integrity/digsig_asymmetric.c
+++ b/security/integrity/digsig_asymmetric.c
@@ -84,6 +84,7 @@ int asymmetric_verify(struct key *keyring, const char *sig,
 {
 	struct public_key_signature pks;
 	struct signature_v2_hdr *hdr = (struct signature_v2_hdr *)sig;
+	const struct public_key *pk;
 	struct key *key;
 	int ret;
 
@@ -105,23 +106,20 @@ int asymmetric_verify(struct key *keyring, const char *sig,
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
+	else if (!strncmp(pk->pkey_algo, "ecdsa-", 6))
+		/* edcsa-nist-p192 etc. */
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

