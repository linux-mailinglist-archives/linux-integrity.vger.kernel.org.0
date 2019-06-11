Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3624D3C423
	for <lists+linux-integrity@lfdr.de>; Tue, 11 Jun 2019 08:32:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404140AbfFKGaA (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 11 Jun 2019 02:30:00 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:53926 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2404125AbfFKGaA (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 11 Jun 2019 02:30:00 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5B6RM9R099622
        for <linux-integrity@vger.kernel.org>; Tue, 11 Jun 2019 02:29:58 -0400
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2t25e3khjt-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Tue, 11 Jun 2019 02:29:58 -0400
Received: from localhost
        by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <bauerman@linux.ibm.com>;
        Tue, 11 Jun 2019 07:29:57 +0100
Received: from b03cxnp08027.gho.boulder.ibm.com (9.17.130.19)
        by e34.co.us.ibm.com (192.168.1.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 11 Jun 2019 07:29:51 +0100
Received: from b03ledav006.gho.boulder.ibm.com (b03ledav006.gho.boulder.ibm.com [9.17.130.237])
        by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x5B6TnwN25362752
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 11 Jun 2019 06:29:49 GMT
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8E4BAC6062;
        Tue, 11 Jun 2019 06:29:49 +0000 (GMT)
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A8D47C605B;
        Tue, 11 Jun 2019 06:29:44 +0000 (GMT)
Received: from morokweng.localdomain.com (unknown [9.85.227.34])
        by b03ledav006.gho.boulder.ibm.com (Postfix) with ESMTP;
        Tue, 11 Jun 2019 06:29:44 +0000 (GMT)
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
Subject: [PATCH v11 08/13] ima: Factor xattr_verify() out of ima_appraise_measurement()
Date:   Tue, 11 Jun 2019 03:28:12 -0300
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190611062817.18412-1-bauerman@linux.ibm.com>
References: <20190611062817.18412-1-bauerman@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19061106-0016-0000-0000-000009C11C60
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00011245; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000286; SDB=6.01216304; UDB=6.00639510; IPR=6.00997404;
 MB=3.00027259; MTD=3.00000008; XFM=3.00000015; UTC=2019-06-11 06:29:55
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19061106-0017-0000-0000-0000439AFD6F
Message-Id: <20190611062817.18412-9-bauerman@linux.ibm.com>
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

Verify xattr signature in a separate function so that the logic in
ima_appraise_measurement() remains clear when it gains the ability to also
verify an appended module signature.

The code in the switch statement is unchanged except for having to
dereference the status and cause variables (since they're now pointers),
and fixing the style of a block comment to appease checkpatch.

Suggested-by: Mimi Zohar <zohar@linux.ibm.com>
Signed-off-by: Thiago Jung Bauermann <bauerman@linux.ibm.com>
Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
---
 security/integrity/ima/ima_appraise.c | 141 +++++++++++++++-----------
 1 file changed, 81 insertions(+), 60 deletions(-)

diff --git a/security/integrity/ima/ima_appraise.c b/security/integrity/ima/ima_appraise.c
index 18bbe753421a..5d4772f39757 100644
--- a/security/integrity/ima/ima_appraise.c
+++ b/security/integrity/ima/ima_appraise.c
@@ -202,6 +202,83 @@ int ima_read_xattr(struct dentry *dentry,
 	return ret;
 }
 
+/*
+ * xattr_verify - verify xattr digest or signature
+ *
+ * Verify whether the hash or signature matches the file contents.
+ *
+ * Return 0 on success, error code otherwise.
+ */
+static int xattr_verify(enum ima_hooks func, struct integrity_iint_cache *iint,
+			struct evm_ima_xattr_data *xattr_value, int xattr_len,
+			enum integrity_status *status, const char **cause)
+{
+	int rc = -EINVAL, hash_start = 0;
+
+	switch (xattr_value->type) {
+	case IMA_XATTR_DIGEST_NG:
+		/* first byte contains algorithm id */
+		hash_start = 1;
+		/* fall through */
+	case IMA_XATTR_DIGEST:
+		if (iint->flags & IMA_DIGSIG_REQUIRED) {
+			*cause = "IMA-signature-required";
+			*status = INTEGRITY_FAIL;
+			break;
+		}
+		clear_bit(IMA_DIGSIG, &iint->atomic_flags);
+		if (xattr_len - sizeof(xattr_value->type) - hash_start >=
+				iint->ima_hash->length)
+			/*
+			 * xattr length may be longer. md5 hash in previous
+			 * version occupied 20 bytes in xattr, instead of 16
+			 */
+			rc = memcmp(&xattr_value->data[hash_start],
+				    iint->ima_hash->digest,
+				    iint->ima_hash->length);
+		else
+			rc = -EINVAL;
+		if (rc) {
+			*cause = "invalid-hash";
+			*status = INTEGRITY_FAIL;
+			break;
+		}
+		*status = INTEGRITY_PASS;
+		break;
+	case EVM_IMA_XATTR_DIGSIG:
+		set_bit(IMA_DIGSIG, &iint->atomic_flags);
+		rc = integrity_digsig_verify(INTEGRITY_KEYRING_IMA,
+					     (const char *)xattr_value,
+					     xattr_len,
+					     iint->ima_hash->digest,
+					     iint->ima_hash->length);
+		if (rc == -EOPNOTSUPP) {
+			*status = INTEGRITY_UNKNOWN;
+			break;
+		}
+		if (IS_ENABLED(CONFIG_INTEGRITY_PLATFORM_KEYRING) && rc &&
+		    func == KEXEC_KERNEL_CHECK)
+			rc = integrity_digsig_verify(INTEGRITY_KEYRING_PLATFORM,
+						     (const char *)xattr_value,
+						     xattr_len,
+						     iint->ima_hash->digest,
+						     iint->ima_hash->length);
+		if (rc) {
+			*cause = "invalid-signature";
+			*status = INTEGRITY_FAIL;
+		} else {
+			*status = INTEGRITY_PASS;
+		}
+		break;
+	default:
+		*status = INTEGRITY_UNKNOWN;
+		*cause = "unknown-ima-data";
+		break;
+	}
+
+	return rc;
+}
+
 /*
  * ima_appraise_measurement - appraise file measurement
  *
@@ -221,7 +298,7 @@ int ima_appraise_measurement(enum ima_hooks func,
 	struct dentry *dentry = file_dentry(file);
 	struct inode *inode = d_backing_inode(dentry);
 	enum integrity_status status = INTEGRITY_UNKNOWN;
-	int rc = xattr_len, hash_start = 0;
+	int rc = xattr_len;
 
 	if (!(inode->i_opflags & IOP_XATTR))
 		return INTEGRITY_UNKNOWN;
@@ -259,65 +336,9 @@ int ima_appraise_measurement(enum ima_hooks func,
 		WARN_ONCE(true, "Unexpected integrity status %d\n", status);
 	}
 
-	switch (xattr_value->type) {
-	case IMA_XATTR_DIGEST_NG:
-		/* first byte contains algorithm id */
-		hash_start = 1;
-		/* fall through */
-	case IMA_XATTR_DIGEST:
-		if (iint->flags & IMA_DIGSIG_REQUIRED) {
-			cause = "IMA-signature-required";
-			status = INTEGRITY_FAIL;
-			break;
-		}
-		clear_bit(IMA_DIGSIG, &iint->atomic_flags);
-		if (xattr_len - sizeof(xattr_value->type) - hash_start >=
-				iint->ima_hash->length)
-			/* xattr length may be longer. md5 hash in previous
-			   version occupied 20 bytes in xattr, instead of 16
-			 */
-			rc = memcmp(&xattr_value->data[hash_start],
-				    iint->ima_hash->digest,
-				    iint->ima_hash->length);
-		else
-			rc = -EINVAL;
-		if (rc) {
-			cause = "invalid-hash";
-			status = INTEGRITY_FAIL;
-			break;
-		}
-		status = INTEGRITY_PASS;
-		break;
-	case EVM_IMA_XATTR_DIGSIG:
-		set_bit(IMA_DIGSIG, &iint->atomic_flags);
-		rc = integrity_digsig_verify(INTEGRITY_KEYRING_IMA,
-					     (const char *)xattr_value,
-					     xattr_len,
-					     iint->ima_hash->digest,
-					     iint->ima_hash->length);
-		if (rc == -EOPNOTSUPP) {
-			status = INTEGRITY_UNKNOWN;
-			break;
-		}
-		if (IS_ENABLED(CONFIG_INTEGRITY_PLATFORM_KEYRING) && rc &&
-		    func == KEXEC_KERNEL_CHECK)
-			rc = integrity_digsig_verify(INTEGRITY_KEYRING_PLATFORM,
-						     (const char *)xattr_value,
-						     xattr_len,
-						     iint->ima_hash->digest,
-						     iint->ima_hash->length);
-		if (rc) {
-			cause = "invalid-signature";
-			status = INTEGRITY_FAIL;
-		} else {
-			status = INTEGRITY_PASS;
-		}
-		break;
-	default:
-		status = INTEGRITY_UNKNOWN;
-		cause = "unknown-ima-data";
-		break;
-	}
+	if (xattr_value)
+		rc = xattr_verify(func, iint, xattr_value, xattr_len, &status,
+				  &cause);
 
 out:
 	/*

