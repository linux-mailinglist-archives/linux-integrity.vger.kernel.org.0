Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9CB131BF43
	for <lists+linux-integrity@lfdr.de>; Mon, 15 Feb 2021 17:30:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231424AbhBOQ3L (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 15 Feb 2021 11:29:11 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:12570 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S230256AbhBOQ0k (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 15 Feb 2021 11:26:40 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 11FG3URf013038;
        Mon, 15 Feb 2021 11:25:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=VznWH/st8iEX8OCNg2iZEx5HK0tTns1td9csB+iRJEA=;
 b=Oa3dab+vW7b9UAYaEq0hwtgeljHhE9i1LV7apBvFxwG4RGpQlj8jvCfPjQx28TwlakeX
 LUUaW5gfnPDNiV+5uBs/Cgxw/G/UiCRUrkbEZLase4pUmNXS8255eoa8raHBCZ+CK4uy
 mbrz1bZs+0J/J2skYAR70qgL8bkNbZwZkQO39EhNdxF/Hk/HJmOQ5J3/8H/JSULNWNge
 mHlC4kH6RKCV6Yv//XjI3XgCZjvGdeFqSzBtyc9FAo8J4pZwG7mui/wZJRhrGFnWrYMN
 WNjq8k/hGT1bcD+MMDmtNDbJOFOm/KWC7oT9+IZoVVA6ve+4Ug5m44GVG2MifI3X+bnK fw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 36qutyscaa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 15 Feb 2021 11:25:52 -0500
Received: from m0098413.ppops.net (m0098413.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 11FG4ach018365;
        Mon, 15 Feb 2021 11:25:51 -0500
Received: from ppma02wdc.us.ibm.com (aa.5b.37a9.ip4.static.sl-reverse.com [169.55.91.170])
        by mx0b-001b2d01.pphosted.com with ESMTP id 36qutysc9t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 15 Feb 2021 11:25:51 -0500
Received: from pps.filterd (ppma02wdc.us.ibm.com [127.0.0.1])
        by ppma02wdc.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 11FGM5wB031920;
        Mon, 15 Feb 2021 16:25:50 GMT
Received: from b03cxnp08027.gho.boulder.ibm.com (b03cxnp08027.gho.boulder.ibm.com [9.17.130.19])
        by ppma02wdc.us.ibm.com with ESMTP id 36p6d908n5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 15 Feb 2021 16:25:50 +0000
Received: from b03ledav003.gho.boulder.ibm.com (b03ledav003.gho.boulder.ibm.com [9.17.130.234])
        by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 11FGPnsT13238902
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 15 Feb 2021 16:25:49 GMT
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 607D86A047;
        Mon, 15 Feb 2021 16:25:49 +0000 (GMT)
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 82A0B6A054;
        Mon, 15 Feb 2021 16:25:48 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
        by b03ledav003.gho.boulder.ibm.com (Postfix) with ESMTP;
        Mon, 15 Feb 2021 16:25:48 +0000 (GMT)
From:   Stefan Berger <stefanb@linux.ibm.com>
To:     keyrings@vger.kernel.org, linux-crypto@vger.kernel.org,
        davem@davemloft.net, herbert@gondor.apana.org.au,
        dhowells@redhat.com, zohar@linux.ibm.com
Cc:     linux-kernel@vger.kernel.org, patrick@puiterwijk.org,
        linux-integrity@vger.kernel.org,
        Stefan Berger <stefanb@linux.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        Vitaly Chikunov <vt@altlinux.org>,
        Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
Subject: [PATCH v8 4/4] ima: Support EC keys for signature verification
Date:   Mon, 15 Feb 2021 11:25:32 -0500
Message-Id: <20210215162532.1077098-5-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210215162532.1077098-1-stefanb@linux.ibm.com>
References: <20210215162532.1077098-1-stefanb@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-02-15_11:2021-02-12,2021-02-15 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxlogscore=999
 priorityscore=1501 clxscore=1015 suspectscore=0 malwarescore=0 mlxscore=0
 spamscore=0 phishscore=0 impostorscore=0 adultscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102150124
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

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

