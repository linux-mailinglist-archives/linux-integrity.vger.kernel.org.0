Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16B833A2C2B
	for <lists+linux-integrity@lfdr.de>; Thu, 10 Jun 2021 14:56:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230406AbhFJM6g (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 10 Jun 2021 08:58:36 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:47428 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S230293AbhFJM6e (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 10 Jun 2021 08:58:34 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15ACXHcW114254;
        Thu, 10 Jun 2021 08:56:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=NlHSA1GDwa6h1vl9U/Q+pgDk10qBxYeO9j1v34eD1dg=;
 b=l6ERU9mQqBIe7UgGPqcZL5PL03pX5J0yyZ7CnvyXs7xzJf55GzvsvgdzRwSbejSBgWbm
 1LlbhJCosixZUaxlw+NSfwiCjKWIUAivRTz1VJ8ZERG7ir0ZRoqYgixboSvpvYfjAr//
 Re/rhHCMiQ/JyltPq45P3Fgq6eT4gxtQXl5B22WHYFbfPlSzIktg0viCEGgyQlrZkZK8
 REQMQ6mdri3LU2cCltsmIRsId2rcMS9dLzXmgJqesYPKFlp6AiPO05cqMJBahm+Jv/dQ
 sVkk4OYw2pbflw/nMTCxo51QVe0g1RbDgghwEVBY8r+yphwiglhvWU/tZUD3BOk8yNKi Ag== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 393hrn2taq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 10 Jun 2021 08:56:32 -0400
Received: from m0098414.ppops.net (m0098414.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 15ACYejG118429;
        Thu, 10 Jun 2021 08:56:31 -0400
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.11])
        by mx0b-001b2d01.pphosted.com with ESMTP id 393hrn2taa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 10 Jun 2021 08:56:31 -0400
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
        by ppma03dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 15AChPWh002279;
        Thu, 10 Jun 2021 12:56:31 GMT
Received: from b01cxnp23033.gho.pok.ibm.com (b01cxnp23033.gho.pok.ibm.com [9.57.198.28])
        by ppma03dal.us.ibm.com with ESMTP id 3900waa17b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 10 Jun 2021 12:56:31 +0000
Received: from b01ledav004.gho.pok.ibm.com (b01ledav004.gho.pok.ibm.com [9.57.199.109])
        by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 15ACuUqx36700536
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 10 Jun 2021 12:56:30 GMT
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 45EB0112075;
        Thu, 10 Jun 2021 12:56:30 +0000 (GMT)
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3FF44112074;
        Thu, 10 Jun 2021 12:56:30 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.47.158.152])
        by b01ledav004.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu, 10 Jun 2021 12:56:30 +0000 (GMT)
From:   Stefan Berger <stefanb@linux.ibm.com>
To:     jeyu@kernel.org, keyrings@vger.kernel.org, dhowells@redhat.com,
        dwmw2@infradead.org, zohar@linux.ibm.com, jarkko@kernel.org
Cc:     nayna@linux.ibm.com, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH v6 3/4] certs: Add support for using elliptic curve keys for signing modules
Date:   Thu, 10 Jun 2021 08:56:22 -0400
Message-Id: <20210610125623.1553792-4-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210610125623.1553792-1-stefanb@linux.ibm.com>
References: <20210610125623.1553792-1-stefanb@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 0QwYlXcN_nmCHCKdt2cpLHzC3OjAz8AV
X-Proofpoint-ORIG-GUID: RTgWzNgCPzKYw412sHulK632D1qI-WY8
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-06-10_07:2021-06-10,2021-06-10 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 adultscore=0
 clxscore=1015 mlxscore=0 spamscore=0 lowpriorityscore=0 mlxlogscore=999
 malwarescore=0 priorityscore=1501 phishscore=0 impostorscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2106100081
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Add support for using elliptic curve keys for signing modules. It uses
a NIST P384 (secp384r1) key if the user chooses an elliptic curve key
and will have ECDSA support built into the kernel.

Note: A developer choosing an ECDSA key for signing modules should still
delete the signing key (rm certs/signing_key.*) when building an older
version of a kernel that only supports RSA keys. Unless kbuild automati-
cally detects and generates a new kernel module key, ECDSA-signed kernel
modules will fail signature verification.

Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
Acked-by: Jarkko Sakkinen <jarkko@kernel.org>
Tested-by: Mimi Zohar <zohar@linux.ibm.com>
Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
---
 certs/Kconfig                         | 26 ++++++++++++++++++++++++++
 certs/Makefile                        |  8 ++++++++
 crypto/asymmetric_keys/pkcs7_parser.c |  8 ++++++++
 3 files changed, 42 insertions(+)

diff --git a/certs/Kconfig b/certs/Kconfig
index f4e61116f94e..916cbb1af928 100644
--- a/certs/Kconfig
+++ b/certs/Kconfig
@@ -15,6 +15,32 @@ config MODULE_SIG_KEY
          then the kernel will automatically generate the private key and
          certificate as described in Documentation/admin-guide/module-signing.rst
 
+choice
+	prompt "Type of module signing key to be generated"
+	default MODULE_SIG_KEY_TYPE_RSA
+	help
+	 The type of module signing key type to generate. This option
+	 does not apply if a #PKCS11 URI is used.
+
+config MODULE_SIG_KEY_TYPE_RSA
+	bool "RSA"
+	depends on MODULE_SIG || (IMA_APPRAISE_MODSIG && MODULES)
+	help
+	 Use an RSA key for module signing.
+
+config MODULE_SIG_KEY_TYPE_ECDSA
+	bool "ECDSA"
+	select CRYPTO_ECDSA
+	depends on MODULE_SIG || (IMA_APPRAISE_MODSIG && MODULES)
+	help
+	 Use an elliptic curve key (NIST P384) for module signing. Consider
+	 using a strong hash like sha256 or sha384 for hashing modules.
+
+	 Note: Remove all ECDSA signing keys, e.g. certs/signing_key.pem,
+	 when falling back to building Linux 5.11 and older kernels.
+
+endchoice
+
 config SYSTEM_TRUSTED_KEYRING
 	bool "Provide system-wide ring of trusted keys"
 	depends on KEYS
diff --git a/certs/Makefile b/certs/Makefile
index 72758684d254..dc9f354dd5f8 100644
--- a/certs/Makefile
+++ b/certs/Makefile
@@ -67,6 +67,13 @@ ifeq ($(CONFIG_MODULE_SIG_KEY),"certs/signing_key.pem")
 ifeq ($(openssl_available),yes)
 X509TEXT=$(shell openssl x509 -in $(CONFIG_MODULE_SIG_KEY) -text)
 
+# Support user changing key type
+ifdef CONFIG_MODULE_SIG_KEY_TYPE_ECDSA
+keytype_openssl = -newkey ec -pkeyopt ec_paramgen_curve:secp384r1
+$(if $(findstring id-ecPublicKey,$(X509TEXT)),,$(shell rm -f $(CONFIG_MODULE_SIG_KEY)))
+endif
+
+ifdef CONFIG_MODULE_SIG_KEY_TYPE_RSA
 $(if $(findstring rsaEncryption,$(X509TEXT)),,$(shell rm -f $(CONFIG_MODULE_SIG_KEY)))
 endif
 
@@ -83,6 +90,7 @@ $(obj)/signing_key.pem: $(obj)/x509.genkey
 		-batch -x509 -config $(obj)/x509.genkey \
 		-outform PEM -out $(obj)/signing_key.pem \
 		-keyout $(obj)/signing_key.pem \
+		$(keytype_openssl) \
 		$($(quiet)redirect_openssl)
 	@$(kecho) "###"
 	@$(kecho) "### Key pair generated."
diff --git a/crypto/asymmetric_keys/pkcs7_parser.c b/crypto/asymmetric_keys/pkcs7_parser.c
index 967329e0a07b..6592279d839a 100644
--- a/crypto/asymmetric_keys/pkcs7_parser.c
+++ b/crypto/asymmetric_keys/pkcs7_parser.c
@@ -269,6 +269,14 @@ int pkcs7_sig_note_pkey_algo(void *context, size_t hdrlen,
 		ctx->sinfo->sig->pkey_algo = "rsa";
 		ctx->sinfo->sig->encoding = "pkcs1";
 		break;
+	case OID_id_ecdsa_with_sha1:
+	case OID_id_ecdsa_with_sha224:
+	case OID_id_ecdsa_with_sha256:
+	case OID_id_ecdsa_with_sha384:
+	case OID_id_ecdsa_with_sha512:
+		ctx->sinfo->sig->pkey_algo = "ecdsa";
+		ctx->sinfo->sig->encoding = "x962";
+		break;
 	default:
 		printk("Unsupported pkey algo: %u\n", ctx->last_oid);
 		return -ENOPKG;
-- 
2.29.2

