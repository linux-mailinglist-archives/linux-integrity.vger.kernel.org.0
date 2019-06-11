Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 29C103C3FF
	for <lists+linux-integrity@lfdr.de>; Tue, 11 Jun 2019 08:32:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403983AbfFKG30 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 11 Jun 2019 02:29:26 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:51722 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2391292AbfFKG3Z (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 11 Jun 2019 02:29:25 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5B6RQti132294
        for <linux-integrity@vger.kernel.org>; Tue, 11 Jun 2019 02:29:24 -0400
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2t2648289a-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Tue, 11 Jun 2019 02:29:23 -0400
Received: from localhost
        by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <bauerman@linux.ibm.com>;
        Tue, 11 Jun 2019 07:29:23 +0100
Received: from b03cxnp07028.gho.boulder.ibm.com (9.17.130.15)
        by e35.co.us.ibm.com (192.168.1.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 11 Jun 2019 07:29:17 +0100
Received: from b03ledav006.gho.boulder.ibm.com (b03ledav006.gho.boulder.ibm.com [9.17.130.237])
        by b03cxnp07028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x5B6TFxT18153748
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 11 Jun 2019 06:29:15 GMT
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5A319C6059;
        Tue, 11 Jun 2019 06:29:15 +0000 (GMT)
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 06D9DC6055;
        Tue, 11 Jun 2019 06:29:08 +0000 (GMT)
Received: from morokweng.localdomain.com (unknown [9.85.227.34])
        by b03ledav006.gho.boulder.ibm.com (Postfix) with ESMTP;
        Tue, 11 Jun 2019 06:29:07 +0000 (GMT)
From:   Thiago Jung Bauermann <bauerman@linux.ibm.com>
To:     linux-integrity@vger.kernel.org
Cc:     linux-security-module@vger.kernel.org, keyrings@vger.kernel.org,
        linux-crypto@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mimi Zohar <zohar@linux.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        David Howells <dhowells@redhat.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Jessica Yu <jeyu@kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Jonathan Corbet <corbet@lwn.net>,
        "AKASHI, Takahiro" <takahiro.akashi@linaro.org>,
        Thiago Jung Bauermann <bauerman@linux.ibm.com>
Subject: [PATCH v11 02/13] PKCS#7: Refactor verify_pkcs7_signature()
Date:   Tue, 11 Jun 2019 03:28:06 -0300
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190611062817.18412-1-bauerman@linux.ibm.com>
References: <20190611062817.18412-1-bauerman@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19061106-0012-0000-0000-00001742EB4B
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00011245; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000286; SDB=6.01216304; UDB=6.00639510; IPR=6.00997403;
 MB=3.00027259; MTD=3.00000008; XFM=3.00000015; UTC=2019-06-11 06:29:21
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19061106-0013-0000-0000-000057A5FADF
Message-Id: <20190611062817.18412-3-bauerman@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-11_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906110044
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

IMA will need to verify a PKCS#7 signature which has already been parsed.
For this reason, factor out the code which does that from
verify_pkcs7_signature() into a new function which takes a struct
pkcs7_message instead of a data buffer.

Signed-off-by: Thiago Jung Bauermann <bauerman@linux.ibm.com>
Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
Cc: David Howells <dhowells@redhat.com>
Cc: David Woodhouse <dwmw2@infradead.org>
Cc: Herbert Xu <herbert@gondor.apana.org.au>
Cc: "David S. Miller" <davem@davemloft.net>
---
 certs/system_keyring.c       | 61 ++++++++++++++++++++++++++----------
 include/linux/verification.h | 10 ++++++
 2 files changed, 55 insertions(+), 16 deletions(-)

diff --git a/certs/system_keyring.c b/certs/system_keyring.c
index c05c29ae4d5d..4ba82e52e4b4 100644
--- a/certs/system_keyring.c
+++ b/certs/system_keyring.c
@@ -194,33 +194,27 @@ late_initcall(load_system_certificate_list);
 #ifdef CONFIG_SYSTEM_DATA_VERIFICATION
 
 /**
- * verify_pkcs7_signature - Verify a PKCS#7-based signature on system data.
+ * verify_pkcs7_message_sig - Verify a PKCS#7-based signature on system data.
  * @data: The data to be verified (NULL if expecting internal data).
  * @len: Size of @data.
- * @raw_pkcs7: The PKCS#7 message that is the signature.
- * @pkcs7_len: The size of @raw_pkcs7.
+ * @pkcs7: The PKCS#7 message that is the signature.
  * @trusted_keys: Trusted keys to use (NULL for builtin trusted keys only,
  *					(void *)1UL for all trusted keys).
  * @usage: The use to which the key is being put.
  * @view_content: Callback to gain access to content.
  * @ctx: Context for callback.
  */
-int verify_pkcs7_signature(const void *data, size_t len,
-			   const void *raw_pkcs7, size_t pkcs7_len,
-			   struct key *trusted_keys,
-			   enum key_being_used_for usage,
-			   int (*view_content)(void *ctx,
-					       const void *data, size_t len,
-					       size_t asn1hdrlen),
-			   void *ctx)
+int verify_pkcs7_message_sig(const void *data, size_t len,
+			     struct pkcs7_message *pkcs7,
+			     struct key *trusted_keys,
+			     enum key_being_used_for usage,
+			     int (*view_content)(void *ctx,
+						 const void *data, size_t len,
+						 size_t asn1hdrlen),
+			     void *ctx)
 {
-	struct pkcs7_message *pkcs7;
 	int ret;
 
-	pkcs7 = pkcs7_parse_message(raw_pkcs7, pkcs7_len);
-	if (IS_ERR(pkcs7))
-		return PTR_ERR(pkcs7);
-
 	/* The data should be detached - so we need to supply it. */
 	if (data && pkcs7_supply_detached_data(pkcs7, data, len) < 0) {
 		pr_err("PKCS#7 signature with non-detached data\n");
@@ -273,6 +267,41 @@ int verify_pkcs7_signature(const void *data, size_t len,
 	}
 
 error:
+	pr_devel("<==%s() = %d\n", __func__, ret);
+	return ret;
+}
+
+/**
+ * verify_pkcs7_signature - Verify a PKCS#7-based signature on system data.
+ * @data: The data to be verified (NULL if expecting internal data).
+ * @len: Size of @data.
+ * @raw_pkcs7: The PKCS#7 message that is the signature.
+ * @pkcs7_len: The size of @raw_pkcs7.
+ * @trusted_keys: Trusted keys to use (NULL for builtin trusted keys only,
+ *					(void *)1UL for all trusted keys).
+ * @usage: The use to which the key is being put.
+ * @view_content: Callback to gain access to content.
+ * @ctx: Context for callback.
+ */
+int verify_pkcs7_signature(const void *data, size_t len,
+			   const void *raw_pkcs7, size_t pkcs7_len,
+			   struct key *trusted_keys,
+			   enum key_being_used_for usage,
+			   int (*view_content)(void *ctx,
+					       const void *data, size_t len,
+					       size_t asn1hdrlen),
+			   void *ctx)
+{
+	struct pkcs7_message *pkcs7;
+	int ret;
+
+	pkcs7 = pkcs7_parse_message(raw_pkcs7, pkcs7_len);
+	if (IS_ERR(pkcs7))
+		return PTR_ERR(pkcs7);
+
+	ret = verify_pkcs7_message_sig(data, len, pkcs7, trusted_keys, usage,
+				       view_content, ctx);
+
 	pkcs7_free_message(pkcs7);
 	pr_devel("<==%s() = %d\n", __func__, ret);
 	return ret;
diff --git a/include/linux/verification.h b/include/linux/verification.h
index 018fb5f13d44..5e1d41f2b336 100644
--- a/include/linux/verification.h
+++ b/include/linux/verification.h
@@ -36,6 +36,7 @@ extern const char *const key_being_used_for[NR__KEY_BEING_USED_FOR];
 #ifdef CONFIG_SYSTEM_DATA_VERIFICATION
 
 struct key;
+struct pkcs7_message;
 
 extern int verify_pkcs7_signature(const void *data, size_t len,
 				  const void *raw_pkcs7, size_t pkcs7_len,
@@ -45,6 +46,15 @@ extern int verify_pkcs7_signature(const void *data, size_t len,
 						      const void *data, size_t len,
 						      size_t asn1hdrlen),
 				  void *ctx);
+extern int verify_pkcs7_message_sig(const void *data, size_t len,
+				    struct pkcs7_message *pkcs7,
+				    struct key *trusted_keys,
+				    enum key_being_used_for usage,
+				    int (*view_content)(void *ctx,
+							const void *data,
+							size_t len,
+							size_t asn1hdrlen),
+				    void *ctx);
 
 #ifdef CONFIG_SIGNED_PE_FILE_VERIFICATION
 extern int verify_pefile_signature(const void *pebuf, unsigned pelen,

