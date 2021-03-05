Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0568A32DE7D
	for <lists+linux-integrity@lfdr.de>; Fri,  5 Mar 2021 01:52:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231521AbhCEAwW (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 4 Mar 2021 19:52:22 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:52190 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S231430AbhCEAwV (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 4 Mar 2021 19:52:21 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 1250jE9C178112;
        Thu, 4 Mar 2021 19:52:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=83Ty5NeWlE8hxGAqq+K0aQUl2aB9eYYBeVV6ziV1fRQ=;
 b=W86LYsnWscwIRfgvNwiD6MgnKioztMI7PiN08bxOz6xNk9gCAnKXiio8ljlR3LGqqPOT
 b4yIUka4oVDk1DsohtCUuXQauEVJ5Hjoi5p1S4Gzo5cczKU72IUywy/frW7GgSl+peN2
 t3uxWK58NA+eDAOOQHKyt/dke2pUSxZixA8/8mpt52Z9djTtNFsEeSLv6H7OOG1uJvla
 tHVUWaC4SieZSXptSnYVzmg9ZMIknkKgEnKriXd29ZNGX1sN3ayxcA9L1OssngN7xw7J
 0ZPt71Gt/rWHJsnTyDgEWdZojS6S1NCxaPyUPD7pEXeSq3POvKCrwAOjMvtPnrN6MY/3 ww== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 373ackg3e3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 04 Mar 2021 19:52:14 -0500
Received: from m0098414.ppops.net (m0098414.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1250ncf4192674;
        Thu, 4 Mar 2021 19:52:13 -0500
Received: from ppma03wdc.us.ibm.com (ba.79.3fa9.ip4.static.sl-reverse.com [169.63.121.186])
        by mx0b-001b2d01.pphosted.com with ESMTP id 373ackg3dy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 04 Mar 2021 19:52:13 -0500
Received: from pps.filterd (ppma03wdc.us.ibm.com [127.0.0.1])
        by ppma03wdc.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 1250WoG4025067;
        Fri, 5 Mar 2021 00:52:12 GMT
Received: from b03cxnp07029.gho.boulder.ibm.com (b03cxnp07029.gho.boulder.ibm.com [9.17.130.16])
        by ppma03wdc.us.ibm.com with ESMTP id 37128gv1cn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 05 Mar 2021 00:52:12 +0000
Received: from b03ledav006.gho.boulder.ibm.com (b03ledav006.gho.boulder.ibm.com [9.17.130.237])
        by b03cxnp07029.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1250qBnV50331968
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 5 Mar 2021 00:52:11 GMT
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 91CF8C6057;
        Fri,  5 Mar 2021 00:52:11 +0000 (GMT)
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DB88BC6055;
        Fri,  5 Mar 2021 00:52:10 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
        by b03ledav006.gho.boulder.ibm.com (Postfix) with ESMTP;
        Fri,  5 Mar 2021 00:52:10 +0000 (GMT)
From:   Stefan Berger <stefanb@linux.vnet.ibm.com>
To:     keyrings@vger.kernel.org, linux-crypto@vger.kernel.org,
        davem@davemloft.net, herbert@gondor.apana.org.au,
        dhowells@redhat.com, zohar@linux.ibm.com
Cc:     linux-kernel@vger.kernel.org, patrick@puiterwijk.org,
        linux-integrity@vger.kernel.org,
        Stefan Berger <stefanb@linux.ibm.com>,
        Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
Subject: [PATCH v10 5/9] x509: Detect sm2 keys by their parameters OID
Date:   Thu,  4 Mar 2021 19:51:59 -0500
Message-Id: <20210305005203.3547587-6-stefanb@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210305005203.3547587-1-stefanb@linux.vnet.ibm.com>
References: <20210305005203.3547587-1-stefanb@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-04_09:2021-03-03,2021-03-04 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 adultscore=0
 mlxscore=0 mlxlogscore=999 spamscore=0 lowpriorityscore=0 phishscore=0
 clxscore=1015 impostorscore=0 malwarescore=0 priorityscore=1501
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103050001
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

From: Stefan Berger <stefanb@linux.ibm.com>

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

