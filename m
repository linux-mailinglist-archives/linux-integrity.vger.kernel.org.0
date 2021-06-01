Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33D663971E1
	for <lists+linux-integrity@lfdr.de>; Tue,  1 Jun 2021 12:53:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233703AbhFAKzE (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 1 Jun 2021 06:55:04 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:65212 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232173AbhFAKzD (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 1 Jun 2021 06:55:03 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 151AYSkU127767;
        Tue, 1 Jun 2021 06:53:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=i1x06NwNQ2s2eltnGJ9Bz0MKk3gZULKceQyzZdkEbhc=;
 b=VfFshtBWrUBbfOCdiIu5Afe+Qh1/mC01XGtpqdxVEvLoYdR9jD/V+fEBEBDIZMCW/vsp
 zA5hKnucxuG6+zuHlHCvGFD3UM8WLdWNPH54zg39xv1sauD+f899of0S+17FCIxZzF+2
 cvJmOQu5OtRAaHCOzECPjjrDre2ZWX1jV6lPw2+60f/Wt7hEcguaX9DUWbdMtPwTvpOr
 /gK6g4OxgBk9Bzvxts/Mb/7lUrClh+P0Uw52g96psyMN67Ka/sNN6WaEU23ZKEJ6txN2
 +YYBAoor4dwpD8lg+Y4rlHHGF0fnhdE6ZvWGgQrPPnlW4hnC+aMV1QfG+8A3T1n/2MPs pg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 38whsjjtaq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 01 Jun 2021 06:53:20 -0400
Received: from m0098404.ppops.net (m0098404.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 151AYgLM129007;
        Tue, 1 Jun 2021 06:53:19 -0400
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.11])
        by mx0a-001b2d01.pphosted.com with ESMTP id 38whsjjta1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 01 Jun 2021 06:53:19 -0400
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
        by ppma03dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 151Aqc9S003879;
        Tue, 1 Jun 2021 10:53:18 GMT
Received: from b01cxnp22035.gho.pok.ibm.com (b01cxnp22035.gho.pok.ibm.com [9.57.198.25])
        by ppma03dal.us.ibm.com with ESMTP id 38ud89uunf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 01 Jun 2021 10:53:18 +0000
Received: from b01ledav002.gho.pok.ibm.com (b01ledav002.gho.pok.ibm.com [9.57.199.107])
        by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 151ArHMI26935652
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 1 Jun 2021 10:53:18 GMT
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DB0A7124064;
        Tue,  1 Jun 2021 10:53:17 +0000 (GMT)
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C0FB7124069;
        Tue,  1 Jun 2021 10:53:17 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.47.158.152])
        by b01ledav002.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue,  1 Jun 2021 10:53:17 +0000 (GMT)
From:   Stefan Berger <stefanb@linux.ibm.com>
To:     jeyu@kernel.org, keyrings@vger.kernel.org, dhowells@redhat.com,
        dwmw2@infradead.org, zohar@linux.ibm.com, jarkko@kernel.org
Cc:     nayna@linux.ibm.com, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH v5 2/2] certs: Add support for using elliptic curve keys for signing modules
Date:   Tue,  1 Jun 2021 06:52:45 -0400
Message-Id: <20210601105245.213767-3-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210601105245.213767-1-stefanb@linux.ibm.com>
References: <20210601105245.213767-1-stefanb@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: lwvpb1gfiW200dbLGbF5a4xTjuTSqLDc
X-Proofpoint-ORIG-GUID: 7n3Z6R6NDYyXXNITtsCh3_aSZlj8UZPr
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-06-01_05:2021-05-31,2021-06-01 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxscore=0
 lowpriorityscore=0 suspectscore=0 mlxlogscore=999 phishscore=0
 impostorscore=0 priorityscore=1501 adultscore=0 clxscore=1015 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106010071
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
---
 certs/Kconfig                         | 26 ++++++++++++++++++++++++++
 certs/Makefile                        |  9 +++++++++
 crypto/asymmetric_keys/pkcs7_parser.c |  8 ++++++++
 3 files changed, 43 insertions(+)

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
index e6f97c64aa99..3a790d07e951 100644
--- a/certs/Makefile
+++ b/certs/Makefile
@@ -65,7 +65,15 @@ ifeq ($(CONFIG_MODULE_SIG_KEY),"certs/signing_key.pem")
 
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
@@ -80,6 +88,7 @@ $(obj)/signing_key.pem: $(obj)/x509.genkey
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

