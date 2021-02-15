Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3790C31BF42
	for <lists+linux-integrity@lfdr.de>; Mon, 15 Feb 2021 17:30:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231318AbhBOQ3J (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 15 Feb 2021 11:29:09 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:5448 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231221AbhBOQ0j (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 15 Feb 2021 11:26:39 -0500
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 11FFXD74137661;
        Mon, 15 Feb 2021 11:25:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=JZriS5iGLl9WBptcX1Eu/a4r96AJJCxnbolnIoBswFE=;
 b=e4Qqtd1uv5BXkA21ro6i56mQM7PVNBujq0iULWvcqQriOstrw5dklTIdLbFw1ow7/Xcs
 CyOB15IAhqmX6Q/4dTrY8zTb+0sSDYZ9Pt65CgCpe+txZFTdWGEwBeSqHs/9rjhoa1H6
 neIvCkHH+UyxWIWttgtsePMFW5awksI7PsfkaBeDykCowLla3jxcoPpG6X9IKMvPaMXz
 KE5QdS/zsrCUxpkeLoaY6lqoER1sbk3oelyCJzholBQ8UfIR6ForMZDYsOgS/+ub0WQo
 JRsS20mnk+SnZh5QqDC3Z7/TEcQb/XTe9qoFUlw7AZkvWGX6R/W52dElcethexpYE2FY vQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 36quj424ea-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 15 Feb 2021 11:25:50 -0500
Received: from m0098417.ppops.net (m0098417.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 11FFXXnM138806;
        Mon, 15 Feb 2021 11:25:50 -0500
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com [169.53.41.122])
        by mx0a-001b2d01.pphosted.com with ESMTP id 36quj424dt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 15 Feb 2021 11:25:49 -0500
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
        by ppma04dal.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 11FGLxG7023192;
        Mon, 15 Feb 2021 16:25:49 GMT
Received: from b03cxnp07028.gho.boulder.ibm.com (b03cxnp07028.gho.boulder.ibm.com [9.17.130.15])
        by ppma04dal.us.ibm.com with ESMTP id 36p6d94b3v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 15 Feb 2021 16:25:49 +0000
Received: from b03ledav003.gho.boulder.ibm.com (b03ledav003.gho.boulder.ibm.com [9.17.130.234])
        by b03cxnp07028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 11FGPlXR22544652
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 15 Feb 2021 16:25:47 GMT
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7CDD56A057;
        Mon, 15 Feb 2021 16:25:47 +0000 (GMT)
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B94DA6A047;
        Mon, 15 Feb 2021 16:25:46 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
        by b03ledav003.gho.boulder.ibm.com (Postfix) with ESMTP;
        Mon, 15 Feb 2021 16:25:46 +0000 (GMT)
From:   Stefan Berger <stefanb@linux.ibm.com>
To:     keyrings@vger.kernel.org, linux-crypto@vger.kernel.org,
        davem@davemloft.net, herbert@gondor.apana.org.au,
        dhowells@redhat.com, zohar@linux.ibm.com
Cc:     linux-kernel@vger.kernel.org, patrick@puiterwijk.org,
        linux-integrity@vger.kernel.org,
        Stefan Berger <stefanb@linux.ibm.com>,
        Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
Subject: [PATCH v8 2/4] x509: Detect sm2 keys by their parameters OID
Date:   Mon, 15 Feb 2021 11:25:30 -0500
Message-Id: <20210215162532.1077098-3-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210215162532.1077098-1-stefanb@linux.ibm.com>
References: <20210215162532.1077098-1-stefanb@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-02-15_11:2021-02-12,2021-02-15 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 phishscore=0
 mlxlogscore=999 spamscore=0 impostorscore=0 mlxscore=0 suspectscore=0
 lowpriorityscore=0 bulkscore=0 priorityscore=1501 malwarescore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102150124
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Detect whether a key is an sm2 type of key by its OID in the parameters
array rather than assuming that everything under OID_id_ecPublicKey
is sm2, which is not the case.

Cc: David Howells <dhowells@redhat.com>
Cc: keyrings@vger.kernel.org
Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
Reviewed-by: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
---
 crypto/asymmetric_keys/x509_cert_parser.c | 12 +++++++++++-
 include/linux/oid_registry.h              |  1 +
 lib/oid_registry.c                        | 13 +++++++++++++
 3 files changed, 25 insertions(+), 1 deletion(-)

diff --git a/crypto/asymmetric_keys/x509_cert_parser.c b/crypto/asymmetric_keys/x509_cert_parser.c
index 52c9b455fc7d..1621ceaf5c95 100644
--- a/crypto/asymmetric_keys/x509_cert_parser.c
+++ b/crypto/asymmetric_keys/x509_cert_parser.c
@@ -459,6 +459,7 @@ int x509_extract_key_data(void *context, size_t hdrlen,
 			  const void *value, size_t vlen)
 {
 	struct x509_parse_context *ctx = context;
+	enum OID oid;
 
 	ctx->key_algo = ctx->last_oid;
 	switch (ctx->last_oid) {
@@ -470,7 +471,16 @@ int x509_extract_key_data(void *context, size_t hdrlen,
 		ctx->cert->pub->pkey_algo = "ecrdsa";
 		break;
 	case OID_id_ecPublicKey:
-		ctx->cert->pub->pkey_algo = "sm2";
+		if (parse_OID(ctx->params, ctx->params_size, &oid) != 0)
+			return -EBADMSG;
+
+		switch (oid) {
+		case OID_sm2:
+			ctx->cert->pub->pkey_algo = "sm2";
+			break;
+		default:
+			return -ENOPKG;
+		}
 		break;
 	default:
 		return -ENOPKG;
diff --git a/include/linux/oid_registry.h b/include/linux/oid_registry.h
index 59ad6109f918..f3b2c097c886 100644
--- a/include/linux/oid_registry.h
+++ b/include/linux/oid_registry.h
@@ -121,6 +121,7 @@ enum OID {
 };
 
 extern enum OID look_up_OID(const void *data, size_t datasize);
+extern int parse_OID(const void *data, size_t datasize, enum OID *oid);
 extern int sprint_oid(const void *, size_t, char *, size_t);
 extern int sprint_OID(enum OID, char *, size_t);
 
diff --git a/lib/oid_registry.c b/lib/oid_registry.c
index f7ad43f28579..508e0b34b5f0 100644
--- a/lib/oid_registry.c
+++ b/lib/oid_registry.c
@@ -11,6 +11,7 @@
 #include <linux/kernel.h>
 #include <linux/errno.h>
 #include <linux/bug.h>
+#include <linux/asn1.h>
 #include "oid_registry_data.c"
 
 MODULE_DESCRIPTION("OID Registry");
@@ -92,6 +93,18 @@ enum OID look_up_OID(const void *data, size_t datasize)
 }
 EXPORT_SYMBOL_GPL(look_up_OID);
 
+int parse_OID(const void *data, size_t datasize, enum OID *oid)
+{
+	const unsigned char *v = data;
+
+	if (datasize < 2 || v[0] != ASN1_OID || v[1] != datasize - 2)
+		return -EBADMSG;
+
+	*oid = look_up_OID(data + 2, datasize - 2);
+	return 0;
+}
+EXPORT_SYMBOL_GPL(parse_OID);
+
 /*
  * sprint_OID - Print an Object Identifier into a buffer
  * @data: The encoded OID to print
-- 
2.29.2

