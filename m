Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7540D30AB13
	for <lists+linux-integrity@lfdr.de>; Mon,  1 Feb 2021 16:24:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231618AbhBAPUT (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 1 Feb 2021 10:20:19 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:62142 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S231152AbhBAPUL (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 1 Feb 2021 10:20:11 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 111F6NRe130181;
        Mon, 1 Feb 2021 10:19:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=FkYuYW0lpNE5sfqJVu9Oc3er1eHA0pKAzOO57Ilbh0E=;
 b=DlYcbnZPAVLKtgERoxQY80cXxkV8lVjhgnuKBvLaaJJtQAI7B6VnWVfttIo3EhGmkswO
 iL3dwyL47DsuuGgLut2uVndpw9lBTQaak1NUc7a85UPaBYEoAfGq3EaJ24WLqufekJXr
 nRO3oS32W9CP/uKkPhhZ438bphWj+MkOeUFnH8jUvQdwL4WLVENkag+fV9em2q4lX7ot
 iWAtTIh3fChM/QQbdwm4MyD+hkhrP3af3VXq3k5gN0H/gRXHlo2eiBqoSlDzBoo6UJMw
 NMaQbiKPghIXayCd0Jv4BtzWeehjAoTzZAhwx/Ki4mv9E2R37QvO+AgHvJGMKDyMbSD8 QA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 36eks8gusq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 01 Feb 2021 10:19:24 -0500
Received: from m0098414.ppops.net (m0098414.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 111F6diY131536;
        Mon, 1 Feb 2021 10:19:24 -0500
Received: from ppma02wdc.us.ibm.com (aa.5b.37a9.ip4.static.sl-reverse.com [169.55.91.170])
        by mx0b-001b2d01.pphosted.com with ESMTP id 36eks8guqn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 01 Feb 2021 10:19:23 -0500
Received: from pps.filterd (ppma02wdc.us.ibm.com [127.0.0.1])
        by ppma02wdc.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 111FEe6M019257;
        Mon, 1 Feb 2021 15:19:21 GMT
Received: from b03cxnp08026.gho.boulder.ibm.com (b03cxnp08026.gho.boulder.ibm.com [9.17.130.18])
        by ppma02wdc.us.ibm.com with ESMTP id 36cy38yawb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 01 Feb 2021 15:19:20 +0000
Received: from b03ledav001.gho.boulder.ibm.com (b03ledav001.gho.boulder.ibm.com [9.17.130.232])
        by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 111FJJBq23265754
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 1 Feb 2021 15:19:19 GMT
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 35ED46E05B;
        Mon,  1 Feb 2021 15:19:19 +0000 (GMT)
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C44E46E062;
        Mon,  1 Feb 2021 15:19:17 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
        by b03ledav001.gho.boulder.ibm.com (Postfix) with ESMTP;
        Mon,  1 Feb 2021 15:19:17 +0000 (GMT)
From:   Stefan Berger <stefanb@linux.ibm.com>
To:     keyrings@vger.kernel.org, linux-crypto@vger.kernel.org,
        davem@davemloft.net, herbert@gondor.apana.org.au,
        dhowells@redhat.com, zohar@linux.ibm.com
Cc:     linux-kernel@vger.kernel.org, patrick@puiterwijk.org,
        linux-integrity@vger.kernel.org,
        Stefan Berger <stefanb@linux.ibm.com>,
        Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
Subject: [PATCH v7 2/4] x509: Detect sm2 keys by their parameters OID
Date:   Mon,  1 Feb 2021 10:19:08 -0500
Message-Id: <20210201151910.1465705-3-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210201151910.1465705-1-stefanb@linux.ibm.com>
References: <20210201151910.1465705-1-stefanb@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.737
 definitions=2021-02-01_05:2021-01-29,2021-02-01 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 lowpriorityscore=0 mlxscore=0 malwarescore=0 suspectscore=0 adultscore=0
 mlxlogscore=999 clxscore=1015 spamscore=0 phishscore=0 bulkscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102010077
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Detect whether a key is an sm2 type of key by its OID in the parameters
array rather than assuming that everything under OID_id_ecPublicKey
is sm2, which is not the case.

Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
Reviewed-by: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
Cc: David Howells <dhowells@redhat.com>
Cc: keyrings@vger.kernel.org
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

