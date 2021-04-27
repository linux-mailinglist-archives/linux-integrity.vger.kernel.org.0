Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9146C36CBAF
	for <lists+linux-integrity@lfdr.de>; Tue, 27 Apr 2021 21:31:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238526AbhD0TcX (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 27 Apr 2021 15:32:23 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:20546 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237840AbhD0TcW (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 27 Apr 2021 15:32:22 -0400
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13RJKpl6123840
        for <linux-integrity@vger.kernel.org>; Tue, 27 Apr 2021 15:31:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=kcDK+inrbcRO8skKNLtG8xa/Oc5hkzTYaOC8lne4n/8=;
 b=ekn7LPM4AMWoJL05woDtNna98YALSAa6P2TNcFtklJ0zAdQzz4kfQN2sGik24c7V5oMn
 LNoasYvT+zQ+24Rlxa9EI2ne9Ex2JeOMnz97OUN+Ica/z0n39zPIGokkhzE+n+KTmd4B
 LTJNHmMhQtX2rion57czdnDvEzlfNPCDwDoSmRk94vEXRXM44/kGK1qHHVOe4FemPjPd
 v9bs2mdiOKswAhoVDOiq8aAg85HGgDjdgdMcI2mC20utript/pzun59gmAnugOlwKLq5
 GfiR8i43olIUqkqxMHJkxntSBf3xWXVPXSmnKcF7alwAs30IjxeGUZiovjiNaENkAK9X MA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 386rpkr781-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Tue, 27 Apr 2021 15:31:38 -0400
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 13RJLGBu124811
        for <linux-integrity@vger.kernel.org>; Tue, 27 Apr 2021 15:31:38 -0400
Received: from ppma02wdc.us.ibm.com (aa.5b.37a9.ip4.static.sl-reverse.com [169.55.91.170])
        by mx0a-001b2d01.pphosted.com with ESMTP id 386rpkr77v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 27 Apr 2021 15:31:38 -0400
Received: from pps.filterd (ppma02wdc.us.ibm.com [127.0.0.1])
        by ppma02wdc.us.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 13RJR7BC009362;
        Tue, 27 Apr 2021 19:31:37 GMT
Received: from b01cxnp23033.gho.pok.ibm.com (b01cxnp23033.gho.pok.ibm.com [9.57.198.28])
        by ppma02wdc.us.ibm.com with ESMTP id 384ay9qp60-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 27 Apr 2021 19:31:37 +0000
Received: from b01ledav005.gho.pok.ibm.com (b01ledav005.gho.pok.ibm.com [9.57.199.110])
        by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 13RJVaGf21955042
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 27 Apr 2021 19:31:36 GMT
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 40076AE060;
        Tue, 27 Apr 2021 19:31:36 +0000 (GMT)
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 29773AE06A;
        Tue, 27 Apr 2021 19:31:36 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.47.158.155])
        by b01ledav005.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue, 27 Apr 2021 19:31:36 +0000 (GMT)
From:   Stefan Berger <stefanb@linux.ibm.com>
To:     linux-integrity@vger.kernel.org
Cc:     zohar@linux.ibm.com, dmitry.kasatkin@gmail.com,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH v2 3/3] libimaevm: Have sign_hash_v2 call sign_hash_v2_pkey after reading key file
Date:   Tue, 27 Apr 2021 15:31:33 -0400
Message-Id: <20210427193133.1718367-4-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210427193133.1718367-1-stefanb@linux.ibm.com>
References: <20210427193133.1718367-1-stefanb@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: GxW9VOvsXl2MscG4a2iFyk6MP0ehAI4G
X-Proofpoint-ORIG-GUID: fNMg2LHhry0_irLPh8Ixx7rmWp3za6XR
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-27_11:2021-04-27,2021-04-27 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 clxscore=1015
 impostorscore=0 bulkscore=0 mlxlogscore=999 spamscore=0 priorityscore=1501
 suspectscore=0 phishscore=0 mlxscore=0 malwarescore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104270126
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Have sign_hash_v2 call sign_hash_v2_pkey after reading the key file.

Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
---
 src/libimaevm.c | 65 ++++++++-----------------------------------------
 1 file changed, 10 insertions(+), 55 deletions(-)

diff --git a/src/libimaevm.c b/src/libimaevm.c
index c4841c5..bda28a1 100644
--- a/src/libimaevm.c
+++ b/src/libimaevm.c
@@ -994,15 +994,9 @@ err:
 static int sign_hash_v2(const char *algo, const unsigned char *hash,
 			int size, const char *keyfile, unsigned char *sig)
 {
-	struct signature_v2_hdr *hdr;
-	int len = -1;
+	char *error = NULL;
 	EVP_PKEY *pkey;
-	char name[20];
-	EVP_PKEY_CTX *ctx = NULL;
-	const EVP_MD *md;
-	size_t sigsize;
-	const char *st;
-	uint32_t keyid;
+	int len = -1;
 
 	if (!hash) {
 		log_err("sign_hash_v2: hash is null\n");
@@ -1014,16 +1008,6 @@ static int sign_hash_v2(const char *algo, const unsigned char *hash,
 		return -1;
 	}
 
-	if (!sig) {
-		log_err("sign_hash_v2: sig is null\n");
-		return -1;
-	}
-
-	if (!algo) {
-		log_err("sign_hash_v2: algo is null\n");
-		return -1;
-	}
-
 	log_info("hash(%s): ", imaevm_params.hash_algo);
 	log_dump(hash, size);
 
@@ -1031,49 +1015,20 @@ static int sign_hash_v2(const char *algo, const unsigned char *hash,
 	if (!pkey)
 		return -1;
 
-	hdr = (struct signature_v2_hdr *)sig;
-	hdr->version = (uint8_t) DIGSIG_VERSION_2;
-
-	hdr->hash_algo = imaevm_get_hash_algo(algo);
-	if (hdr->hash_algo == (uint8_t)-1) {
-		log_err("sign_hash_v2: hash algo is unknown: %s\n", algo);
-		return -1;
-	}
-
-	calc_keyid_v2(&keyid, name, pkey);
-	hdr->keyid = keyid;
-
-	st = "EVP_PKEY_CTX_new";
-	if (!(ctx = EVP_PKEY_CTX_new(pkey, NULL)))
-		goto err;
-	st = "EVP_PKEY_sign_init";
-	if (!EVP_PKEY_sign_init(ctx))
-		goto err;
-	st = "EVP_get_digestbyname";
-	if (!(md = EVP_get_digestbyname(imaevm_params.hash_algo)))
-		goto err;
-	st = "EVP_PKEY_CTX_set_signature_md";
-	if (!EVP_PKEY_CTX_set_signature_md(ctx, md))
-		goto err;
-	st = "EVP_PKEY_sign";
-	sigsize = MAX_SIGNATURE_SIZE - sizeof(struct signature_v2_hdr) - 1;
-	if (!EVP_PKEY_sign(ctx, hdr->sig, &sigsize, hash, size))
+	len = sign_hash_v2_pkey(algo, hash, size, pkey, sig, MAX_SIGNATURE_SIZE - 1,
+	                        &error);
+	if (len < 0) {
+		log_err("%s\n", error);
+		output_openssl_errors();
 		goto err;
-	len = (int)sigsize;
+	}
 
-	/* we add bit length of the signature to make it gnupg compatible */
-	hdr->sig_size = __cpu_to_be16(len);
-	len += sizeof(*hdr);
 	log_info("evm/ima signature: %d bytes\n", len);
 
 err:
-	if (len == -1) {
-		log_err("sign_hash_v2: signing failed: (%s) in %s\n",
-			ERR_reason_error_string(ERR_peek_error()), st);
-		output_openssl_errors();
-	}
-	EVP_PKEY_CTX_free(ctx);
+	free(error);
 	EVP_PKEY_free(pkey);
+
 	return len;
 }
 
-- 
2.30.2

