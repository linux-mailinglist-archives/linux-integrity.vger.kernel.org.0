Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB3FA3673A3
	for <lists+linux-integrity@lfdr.de>; Wed, 21 Apr 2021 21:43:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245514AbhDUToJ (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 21 Apr 2021 15:44:09 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:38696 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S245496AbhDUToC (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 21 Apr 2021 15:44:02 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13LJYH4F088501;
        Wed, 21 Apr 2021 15:43:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=4OumTIa+6p1ka93GHomN7b6NR3Ghe9gvkQLBB6dvFEs=;
 b=rbGz/pzykMQeN+bE6ID5uoGRdxDDBIsdC2jNghjzXLKSMCpR8UHk9FuhbCQUA5ww+o5/
 jRCZCEddaoefSU/KJuFPCAL9R9m7/cOvmkaVg9lepdxU1vc2/bEQMD9pqggV47GTWY6I
 OsKrZ+uXP3Xv/1XKupNGfe5Dpl67MKmfycVY0Sx4JHInyekJnbelXWVq2wquNJeBOeeu
 Vj2D4RJh2cGxBNc8fqGllwjedABzuVfypcSYWa7naPfYuf8xJOjQ7jwHd7b/Lv/yunJq
 ZIIeLeI46eY2MF6A4tBk8aOca7mvays2fyOAWeaucXcE1i66P/ufn01JVG1CWEyQzGMH BQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 382sbr9td2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 21 Apr 2021 15:43:27 -0400
Received: from m0098396.ppops.net (m0098396.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 13LJaAkD097703;
        Wed, 21 Apr 2021 15:43:27 -0400
Received: from ppma03wdc.us.ibm.com (ba.79.3fa9.ip4.static.sl-reverse.com [169.63.121.186])
        by mx0a-001b2d01.pphosted.com with ESMTP id 382sbr9tcq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 21 Apr 2021 15:43:27 -0400
Received: from pps.filterd (ppma03wdc.us.ibm.com [127.0.0.1])
        by ppma03wdc.us.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 13LJgYAD021907;
        Wed, 21 Apr 2021 19:43:26 GMT
Received: from b03cxnp08025.gho.boulder.ibm.com (b03cxnp08025.gho.boulder.ibm.com [9.17.130.17])
        by ppma03wdc.us.ibm.com with ESMTP id 37yqa9cg4x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 21 Apr 2021 19:43:26 +0000
Received: from b03ledav004.gho.boulder.ibm.com (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
        by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 13LJhODe32178508
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 21 Apr 2021 19:43:24 GMT
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A4FE678060;
        Wed, 21 Apr 2021 19:43:24 +0000 (GMT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EDFD87805E;
        Wed, 21 Apr 2021 19:43:23 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.47.158.152])
        by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTP;
        Wed, 21 Apr 2021 19:43:23 +0000 (GMT)
From:   Stefan Berger <stefanb@linux.ibm.com>
To:     jeyu@kernel.org, keyrings@vger.kernel.org, dhowells@redhat.com,
        zohar@linux.ibm.com, jarkko@kernel.org
Cc:     nayna@linux.ibm.com, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH v3 2/2] certs: Add support for using elliptic curve keys for signing modules
Date:   Wed, 21 Apr 2021 15:43:19 -0400
Message-Id: <20210421194319.1489291-3-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210421194319.1489291-1-stefanb@linux.ibm.com>
References: <20210421194319.1489291-1-stefanb@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: RZqX34gZpmpTwsXMgx2-u_MIVJc9ikub
X-Proofpoint-GUID: E6BucHQ_nDFy5dpOVlW0s3UZ41Syh29g
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-21_05:2021-04-21,2021-04-21 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxlogscore=999
 lowpriorityscore=0 bulkscore=0 suspectscore=0 adultscore=0 impostorscore=0
 priorityscore=1501 clxscore=1015 spamscore=0 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104210134
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

---
v3:
  - added missing OIDs for ECDSA signed hashes to pkcs7_sig_note_pkey_algo
  - added recommendation to use string hash to Kconfig help text

v2:
  - check for ECDSA key by id-ecPublicKey from output line
    'Public Key Algorithm: id-ecPublicKey'.
---
 certs/Kconfig                         | 26 ++++++++++++++++++++++++++
 certs/Makefile                        |  9 +++++++++
 crypto/asymmetric_keys/pkcs7_parser.c |  8 ++++++++
 3 files changed, 43 insertions(+)

diff --git a/certs/Kconfig b/certs/Kconfig
index 48675ad319db..d58f16c9f2d9 100644
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
+	depends on MODULE_SIG || IMA_APPRAISE_MODSIG
+	help
+	 Use an RSA key for module signing.
+
+config MODULE_SIG_KEY_TYPE_ECDSA
+	bool "ECDSA"
+	select CRYPTO_ECDSA
+	depends on MODULE_SIG || IMA_APPRAISE_MODSIG
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
index f64bc89ccbf1..c2fabc288550 100644
--- a/certs/Makefile
+++ b/certs/Makefile
@@ -62,7 +62,15 @@ ifeq ($(CONFIG_MODULE_SIG_KEY),"certs/signing_key.pem")
 
 X509TEXT=$(shell openssl x509 -in $(CONFIG_MODULE_SIG_KEY) -text)
 
+# Support user changing key type
+ifdef CONFIG_MODULE_SIG_KEY_TYPE_ECDSA
+keytype_openssl = -newkey ec -pkeyopt ec_paramgen_curve:secp384r1
+$(if $(findstring id-ecPublicKey,$(X509TEXT)),,$(shell rm -f $(CONFIG_MODULE_SIG_KEY)))
+endif
+
+ifdef CONFIG_MODULE_SIG_KEY_TYPE_RSA
 $(if $(findstring rsaEncryption,$(X509TEXT)),,$(shell rm -f $(CONFIG_MODULE_SIG_KEY)))
+endif
 
 $(obj)/signing_key.pem: $(obj)/x509.genkey
 	@$(kecho) "###"
@@ -77,6 +85,7 @@ $(obj)/signing_key.pem: $(obj)/x509.genkey
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

