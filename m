Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6FECA3C403
	for <lists+linux-integrity@lfdr.de>; Tue, 11 Jun 2019 08:32:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404003AbfFKG33 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 11 Jun 2019 02:29:29 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:59768 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2403989AbfFKG33 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 11 Jun 2019 02:29:29 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5B6RObE076927
        for <linux-integrity@vger.kernel.org>; Tue, 11 Jun 2019 02:29:28 -0400
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2t26q7gupa-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Tue, 11 Jun 2019 02:29:28 -0400
Received: from localhost
        by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <bauerman@linux.ibm.com>;
        Tue, 11 Jun 2019 07:29:27 +0100
Received: from b03cxnp08028.gho.boulder.ibm.com (9.17.130.20)
        by e36.co.us.ibm.com (192.168.1.136) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 11 Jun 2019 07:29:21 +0100
Received: from b03ledav006.gho.boulder.ibm.com (b03ledav006.gho.boulder.ibm.com [9.17.130.237])
        by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x5B6TKaP27328894
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 11 Jun 2019 06:29:20 GMT
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4010AC605B;
        Tue, 11 Jun 2019 06:29:20 +0000 (GMT)
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BDA52C6055;
        Tue, 11 Jun 2019 06:29:15 +0000 (GMT)
Received: from morokweng.localdomain.com (unknown [9.85.227.34])
        by b03ledav006.gho.boulder.ibm.com (Postfix) with ESMTP;
        Tue, 11 Jun 2019 06:29:15 +0000 (GMT)
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
Subject: [PATCH v11 03/13] PKCS#7: Introduce pkcs7_get_digest()
Date:   Tue, 11 Jun 2019 03:28:07 -0300
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190611062817.18412-1-bauerman@linux.ibm.com>
References: <20190611062817.18412-1-bauerman@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19061106-0020-0000-0000-00000EF7C4C6
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00011245; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000286; SDB=6.01216304; UDB=6.00639509; IPR=6.00997403;
 MB=3.00027259; MTD=3.00000008; XFM=3.00000015; UTC=2019-06-11 06:29:25
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19061106-0021-0000-0000-000066337270
Message-Id: <20190611062817.18412-4-bauerman@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-11_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906110044
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

IMA will need to access the digest of the PKCS7 message (as calculated by
the kernel) before the signature is verified, so introduce
pkcs7_get_digest() for that purpose.

Also, modify pkcs7_digest() to detect when the digest was already
calculated so that it doesn't have to do redundant work. Verifying that
sinfo->sig->digest isn't NULL is sufficient because both places which
allocate sinfo->sig (pkcs7_parse_message() and pkcs7_note_signed_info())
use kzalloc() so sig->digest is always initialized to zero.

Signed-off-by: Thiago Jung Bauermann <bauerman@linux.ibm.com>
Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
Cc: David Howells <dhowells@redhat.com>
Cc: David Woodhouse <dwmw2@infradead.org>
Cc: Herbert Xu <herbert@gondor.apana.org.au>
Cc: "David S. Miller" <davem@davemloft.net>
---
 crypto/asymmetric_keys/pkcs7_verify.c | 33 +++++++++++++++++++++++++++
 include/crypto/pkcs7.h                |  4 ++++
 2 files changed, 37 insertions(+)

diff --git a/crypto/asymmetric_keys/pkcs7_verify.c b/crypto/asymmetric_keys/pkcs7_verify.c
index f7b0980bf02d..3243981152b5 100644
--- a/crypto/asymmetric_keys/pkcs7_verify.c
+++ b/crypto/asymmetric_keys/pkcs7_verify.c
@@ -16,6 +16,7 @@
 #include <linux/err.h>
 #include <linux/asn1.h>
 #include <crypto/hash.h>
+#include <crypto/hash_info.h>
 #include <crypto/public_key.h>
 #include "pkcs7_parser.h"
 
@@ -33,6 +34,10 @@ static int pkcs7_digest(struct pkcs7_message *pkcs7,
 
 	kenter(",%u,%s", sinfo->index, sinfo->sig->hash_algo);
 
+	/* The digest was calculated already. */
+	if (sig->digest)
+		return 0;
+
 	if (!sinfo->sig->hash_algo)
 		return -ENOPKG;
 
@@ -121,6 +126,34 @@ static int pkcs7_digest(struct pkcs7_message *pkcs7,
 	return ret;
 }
 
+int pkcs7_get_digest(struct pkcs7_message *pkcs7, const u8 **buf, u32 *len,
+		     enum hash_algo *hash_algo)
+{
+	struct pkcs7_signed_info *sinfo = pkcs7->signed_infos;
+	int i, ret;
+
+	/*
+	 * This function doesn't support messages with more than one signature.
+	 */
+	if (sinfo == NULL || sinfo->next != NULL)
+		return -EBADMSG;
+
+	ret = pkcs7_digest(pkcs7, sinfo);
+	if (ret)
+		return ret;
+
+	*buf = sinfo->sig->digest;
+	*len = sinfo->sig->digest_size;
+
+	for (i = 0; i < HASH_ALGO__LAST; i++)
+		if (!strcmp(hash_algo_name[i], sinfo->sig->hash_algo)) {
+			*hash_algo = i;
+			break;
+		}
+
+	return 0;
+}
+
 /*
  * Find the key (X.509 certificate) to use to verify a PKCS#7 message.  PKCS#7
  * uses the issuer's name and the issuing certificate serial number for
diff --git a/include/crypto/pkcs7.h b/include/crypto/pkcs7.h
index 583f199400a3..3bfe6829eaae 100644
--- a/include/crypto/pkcs7.h
+++ b/include/crypto/pkcs7.h
@@ -13,6 +13,7 @@
 #define _CRYPTO_PKCS7_H
 
 #include <linux/verification.h>
+#include <linux/hash_info.h>
 #include <crypto/public_key.h>
 
 struct key;
@@ -44,4 +45,7 @@ extern int pkcs7_verify(struct pkcs7_message *pkcs7,
 extern int pkcs7_supply_detached_data(struct pkcs7_message *pkcs7,
 				      const void *data, size_t datalen);
 
+extern int pkcs7_get_digest(struct pkcs7_message *pkcs7, const u8 **buf,
+			    u32 *len, enum hash_algo *hash_algo);
+
 #endif /* _CRYPTO_PKCS7_H */

