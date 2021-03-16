Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D90133DFFA
	for <lists+linux-integrity@lfdr.de>; Tue, 16 Mar 2021 22:09:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232439AbhCPVIT (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 16 Mar 2021 17:08:19 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:29296 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S231578AbhCPVIF (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 16 Mar 2021 17:08:05 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 12GL3ua4016725;
        Tue, 16 Mar 2021 17:07:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=PLl7ht/Z9ogdVmSiFWkF0UyxUt0fAdA9Ukyauhs7ZwU=;
 b=P8WixETO+X8nU0pkl7bEA+gg4Aq/i4JY2RP2pUk8ozaZEGr0euoapS/yMK/AAMiSQ50W
 gFPB5hkz6d1v1ZCX/++oVT11XrrGaeSyGtM53t5HZYHTOzsgOJ+oWs2/mOkWVVni0/j7
 wj8k8+e8E/keB4/N15AzoS/Fh/kQ4/vsL7CGdTJWMky6GNB4vDpFFZxEPK5UqWBoXhFl
 xUCPH8oIYfyFelSIB50dA+c9JuwkvcxTjnTi3s2MSZOMFnrRvFhJDhNFSBPq0bFHdJO7
 y/iYDJombqAnoyiANXrjgxIilvtemlOwetVQFZZiCoLHmFkDNQZqbypU5KX3Jp2HvtSf Bw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 37b0kr6dqa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 16 Mar 2021 17:07:58 -0400
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 12GL4dx7019602;
        Tue, 16 Mar 2021 17:07:58 -0400
Received: from ppma03wdc.us.ibm.com (ba.79.3fa9.ip4.static.sl-reverse.com [169.63.121.186])
        by mx0b-001b2d01.pphosted.com with ESMTP id 37b0kr6dq4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 16 Mar 2021 17:07:58 -0400
Received: from pps.filterd (ppma03wdc.us.ibm.com [127.0.0.1])
        by ppma03wdc.us.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 12GL6jZo029005;
        Tue, 16 Mar 2021 21:07:57 GMT
Received: from b03cxnp08026.gho.boulder.ibm.com (b03cxnp08026.gho.boulder.ibm.com [9.17.130.18])
        by ppma03wdc.us.ibm.com with ESMTP id 378ubtgcmf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 16 Mar 2021 21:07:57 +0000
Received: from b03ledav002.gho.boulder.ibm.com (b03ledav002.gho.boulder.ibm.com [9.17.130.233])
        by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 12GL7uPY22348104
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 16 Mar 2021 21:07:56 GMT
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 21211136051;
        Tue, 16 Mar 2021 21:07:56 +0000 (GMT)
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4FF27136059;
        Tue, 16 Mar 2021 21:07:55 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.47.158.152])
        by b03ledav002.gho.boulder.ibm.com (Postfix) with ESMTP;
        Tue, 16 Mar 2021 21:07:55 +0000 (GMT)
From:   Stefan Berger <stefanb@linux.ibm.com>
To:     keyrings@vger.kernel.org, linux-crypto@vger.kernel.org,
        davem@davemloft.net, herbert@gondor.apana.org.au,
        dhowells@redhat.com, zohar@linux.ibm.com, jarkko@kernel.org
Cc:     linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, patrick@puiterwijk.org,
        Stefan Berger <stefanb@linux.ibm.com>,
        Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
Subject: [PATCH v12 06/10] x509: Detect sm2 keys by their parameters OID
Date:   Tue, 16 Mar 2021 17:07:36 -0400
Message-Id: <20210316210740.1592994-7-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210316210740.1592994-1-stefanb@linux.ibm.com>
References: <20210316210740.1592994-1-stefanb@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-16_08:2021-03-16,2021-03-16 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 lowpriorityscore=0 impostorscore=0 phishscore=0 mlxscore=0 bulkscore=0
 mlxlogscore=999 adultscore=0 priorityscore=1501 suspectscore=0
 malwarescore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2009150000 definitions=main-2103160135
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
Tested-by: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
---
 crypto/asymmetric_keys/x509_cert_parser.c | 12 +++++++++++-
 include/linux/oid_registry.h              |  1 +
 lib/oid_registry.c                        | 24 +++++++++++++++++++++++
 3 files changed, 36 insertions(+), 1 deletion(-)

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
index b504e2f36b25..f32d91895e4d 100644
--- a/include/linux/oid_registry.h
+++ b/include/linux/oid_registry.h
@@ -121,6 +121,7 @@ enum OID {
 };
 
 extern enum OID look_up_OID(const void *data, size_t datasize);
+extern int parse_OID(const void *data, size_t datasize, enum OID *oid);
 extern int sprint_oid(const void *, size_t, char *, size_t);
 extern int sprint_OID(enum OID, char *, size_t);
 
diff --git a/lib/oid_registry.c b/lib/oid_registry.c
index f7ad43f28579..3dfaa836e7c5 100644
--- a/lib/oid_registry.c
+++ b/lib/oid_registry.c
@@ -11,6 +11,7 @@
 #include <linux/kernel.h>
 #include <linux/errno.h>
 #include <linux/bug.h>
+#include <linux/asn1.h>
 #include "oid_registry_data.c"
 
 MODULE_DESCRIPTION("OID Registry");
@@ -92,6 +93,29 @@ enum OID look_up_OID(const void *data, size_t datasize)
 }
 EXPORT_SYMBOL_GPL(look_up_OID);
 
+/**
+ * parse_OID - Parse an OID from a bytestream
+ * @data: Binary representation of the header + OID
+ * @datasize: Size of the binary representation
+ * @oid: Pointer to oid to return result
+ *
+ * Parse an OID from a bytestream that holds the OID in the format
+ * ASN1_OID | length | oid. The length indicator must equal to datasize - 2.
+ * -EBADMSG is returned if the bytestream is too short.
+ */
+int parse_OID(const void *data, size_t datasize, enum OID *oid)
+{
+	const unsigned char *v = data;
+
+	/* we need 2 bytes of header and at least 1 byte for oid */
+	if (datasize < 3 || v[0] != ASN1_OID || v[1] != datasize - 2)
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

