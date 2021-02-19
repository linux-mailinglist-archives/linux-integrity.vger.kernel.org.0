Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D92031FC41
	for <lists+linux-integrity@lfdr.de>; Fri, 19 Feb 2021 16:43:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229945AbhBSPmN (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 19 Feb 2021 10:42:13 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:48608 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229800AbhBSPmG (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 19 Feb 2021 10:42:06 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 11JFUkv8051856;
        Fri, 19 Feb 2021 10:41:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=W/3NgxUmfYxZtO+paNk0oK9prvw2sBrJNHkEhc2t+mU=;
 b=pYXP/XYz7ev9yp4dtLlabathFttlN1apW02qsInLJ+QvWFR88MHJgKkHVPtyOn5dJxbN
 EkFmWvPsy3TMxH7SviXK8o4bs8FuMkjS3acQu8JImIR4Ny+H1dMf+0NaHLNcDK2ozjCL
 LGaJ94l45fuBhpE3j4+IcrORdsMPCL32bA+aYkkGMc9XzCe1zWe5O6b5pj54XgJoTNL2
 SZI/5GQa8bWHGKKURfeVvHMrZvh4kJTQgyGZiBjMnUmiFG1Dd3l4sVtvncSjvRqU/CqZ
 mjRNrkM+Whxy0qD1E0A7Y30EE1MBBCvxaorJOLpGMm/K8JTMYWMo5dLuvF55BY6lAcQU Vw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 36tfy8gh0y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 19 Feb 2021 10:41:19 -0500
Received: from m0098416.ppops.net (m0098416.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 11JFV53w053798;
        Fri, 19 Feb 2021 10:41:18 -0500
Received: from ppma04wdc.us.ibm.com (1a.90.2fa9.ip4.static.sl-reverse.com [169.47.144.26])
        by mx0b-001b2d01.pphosted.com with ESMTP id 36tfy8gh0t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 19 Feb 2021 10:41:18 -0500
Received: from pps.filterd (ppma04wdc.us.ibm.com [127.0.0.1])
        by ppma04wdc.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 11JFRt6t015687;
        Fri, 19 Feb 2021 15:41:18 GMT
Received: from b01cxnp22033.gho.pok.ibm.com (b01cxnp22033.gho.pok.ibm.com [9.57.198.23])
        by ppma04wdc.us.ibm.com with ESMTP id 36p6d9pfgp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 19 Feb 2021 15:41:18 +0000
Received: from b01ledav001.gho.pok.ibm.com (b01ledav001.gho.pok.ibm.com [9.57.199.106])
        by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 11JFfHQ521758238
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 19 Feb 2021 15:41:17 GMT
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C198F28058;
        Fri, 19 Feb 2021 15:41:17 +0000 (GMT)
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A6A2E28059;
        Fri, 19 Feb 2021 15:41:17 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
        by b01ledav001.gho.pok.ibm.com (Postfix) with ESMTP;
        Fri, 19 Feb 2021 15:41:17 +0000 (GMT)
From:   Stefan Berger <stefanb@linux.vnet.ibm.com>
To:     keyrings@vger.kernel.org, dhowells@redhat.com, dwmw2@infradead.org,
        linux-security-module@vger.kernel.org
Cc:     zohar@linux.ibm.com, linux-kernel@vger.kernel.org,
        linux-integrity@vger.kernel.org, nayna@linux.ibm.com,
        saulo.alessandre@gmail.com, Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH] certs: Add support for using elliptic curve keys for signing modules
Date:   Fri, 19 Feb 2021 10:41:14 -0500
Message-Id: <20210219154114.2416778-1-stefanb@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-02-19_07:2021-02-18,2021-02-19 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 malwarescore=0
 lowpriorityscore=0 clxscore=1011 suspectscore=0 impostorscore=0
 priorityscore=1501 phishscore=0 mlxlogscore=999 spamscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102190123
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

From: Stefan Berger <stefanb@linux.ibm.com>

This patch adds support for using elliptic curve keys for signing
modules. It uses a NIST P256 (prime256v1) key if the user chooses an
elliptic curve key.

A developer choosing an ECDSA key for signing modules has to manually
delete the signing key (rm certs/signing_key.*) when falling back to
an older version of a kernel that only supports RSA key since otherwise
ECDSA-signed modules will not be usable when that older kernel runs.

Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>

---

This patch builds on top of my ECDSA patch series and Nayna's
series for 'kernel build support for loading the kernel module
signing key'.
- https://lkml.org/lkml/2021/2/15/766
- https://lkml.org/lkml/2021/2/18/856
---
 certs/Kconfig                         | 17 +++++++++++++++++
 certs/Makefile                        | 14 ++++++++++++++
 crypto/asymmetric_keys/pkcs7_parser.c |  4 ++++
 3 files changed, 35 insertions(+)

diff --git a/certs/Kconfig b/certs/Kconfig
index 48675ad319db..5e2dd5c24d31 100644
--- a/certs/Kconfig
+++ b/certs/Kconfig
@@ -15,6 +15,23 @@ config MODULE_SIG_KEY
          then the kernel will automatically generate the private key and
          certificate as described in Documentation/admin-guide/module-signing.rst
 
+choice
+       prompt "Type of module signing key to be generated"
+       default MODULE_SIG_KEY_TYPE_RSA
+       help
+         The type of module signing key type to generated. This option
+         does not apply if a #PKCS11 URI is used.
+
+config MODULE_SIG_KEY_TYPE_RSA
+       bool "RSA"
+       depends on MODULE_SIG || IMA_APPRAISE_MODSIG
+
+config MODULE_SIG_KEY_TYPE_ECDSA
+       bool "ECDSA"
+       depends on (MODULE_SIG || IMA_APPRAISE_MODSIG) && CRYPTO_ECDSA
+
+endchoice
+
 config SYSTEM_TRUSTED_KEYRING
 	bool "Provide system-wide ring of trusted keys"
 	depends on KEYS
diff --git a/certs/Makefile b/certs/Makefile
index 3fe6b73786fa..2d5fd4720d07 100644
--- a/certs/Makefile
+++ b/certs/Makefile
@@ -69,6 +69,18 @@ else
 SIGNER = -signkey $(obj)/signing_key.key
 endif # CONFIG_IMA_APPRAISE_MODSIG
 
+X509TEXT=$(shell openssl x509 -in $(CONFIG_MODULE_SIG_KEY) -text)
+
+# Support user changing key type
+ifdef CONFIG_MODULE_SIG_KEY_TYPE_ECDSA
+keytype_openssl = -newkey ec -pkeyopt ec_paramgen_curve:prime256v1
+$(if $(findstring ecdsa-with-,$(X509TEXT)),,$(shell rm -f $(CONFIG_MODULE_SIG_KEY)))
+endif
+
+ifdef CONFIG_MODULE_SIG_KEY_TYPE_RSA
+$(if $(findstring rsaEncryption,$(X509TEXT)),,$(shell rm -f $(CONFIG_MODULE_SIG_KEY)))
+endif
+
 $(obj)/signing_key.pem: $(obj)/x509.genkey
 	@$(kecho) "###"
 	@$(kecho) "### Now generating an X.509 key pair to be used for signing modules."
@@ -86,12 +98,14 @@ ifeq ($(CONFIG_IMA_APPRAISE_MODSIG),y)
 		-batch -x509 -config $(obj)/x509.genkey \
 		-outform PEM -out $(CA_KEY) \
 		-keyout $(CA_KEY) -extensions ca_ext \
+		$(keytype_openssl) \
 		$($(quiet)redirect_openssl)
 endif # CONFIG_IMA_APPRAISE_MODSIG
 	$(Q)openssl req -new -nodes -utf8 \
 		-batch -config $(obj)/x509.genkey \
 		-outform PEM -out $(obj)/signing_key.csr \
 		-keyout $(obj)/signing_key.key -extensions myexts \
+		$(keytype_openssl) \
 		$($(quiet)redirect_openssl)
 	$(Q)openssl x509 -req -days 36500 -in $(obj)/signing_key.csr \
 		-outform PEM -out $(obj)/signing_key.crt $(SIGNER) \
diff --git a/crypto/asymmetric_keys/pkcs7_parser.c b/crypto/asymmetric_keys/pkcs7_parser.c
index 967329e0a07b..2546ec6a0505 100644
--- a/crypto/asymmetric_keys/pkcs7_parser.c
+++ b/crypto/asymmetric_keys/pkcs7_parser.c
@@ -269,6 +269,10 @@ int pkcs7_sig_note_pkey_algo(void *context, size_t hdrlen,
 		ctx->sinfo->sig->pkey_algo = "rsa";
 		ctx->sinfo->sig->encoding = "pkcs1";
 		break;
+	case OID_id_ecdsa_with_sha256:
+		ctx->sinfo->sig->pkey_algo = "ecdsa";
+		ctx->sinfo->sig->encoding = "x962";
+		break;
 	default:
 		printk("Unsupported pkey algo: %u\n", ctx->last_oid);
 		return -ENOPKG;
-- 
2.29.2

