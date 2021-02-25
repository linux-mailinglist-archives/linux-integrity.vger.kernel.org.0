Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DF5A32532B
	for <lists+linux-integrity@lfdr.de>; Thu, 25 Feb 2021 17:11:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233524AbhBYQKP (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 25 Feb 2021 11:10:15 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:12420 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233615AbhBYQJO (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 25 Feb 2021 11:09:14 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 11PG32Jg060968;
        Thu, 25 Feb 2021 11:08:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=vlulkbjFe3fFtDvvDhP9dMk2nV7D/SeYW3cL/u10bNs=;
 b=gzatDwh1Rmvu30MukGGhH4+FXuFxdggjHf7UhGb4fqWSWwGPUNlLt4Dzp3PQhLe//vRY
 bmbyIW6Fuaybz7HqjwNJ+ZvBCnPD9p+66DY/OQ1pt+yOhOuTAVRX+3yiTNgOCGmNIVq/
 48YVTHAmm5JNnM0vCm+poW4WceICh+UGz7fVTjOM6qf/rrWWKiMUzpkebjKqXDotIUr9
 I/3ZvFrVfUY7lZi6P8OPerRn09fYq5t1G2V6DqGPncoA2L3w6ktPWczihwyKMWOluvOt
 PZytsmh1CwLjUk1yUbakOl2bE1ipgnt0nj8FcRmqJ/kl9FPnm3K9tBMp3tUY0kTHloaa GQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 36xdyj37s1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 25 Feb 2021 11:08:27 -0500
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 11PG3VLu063576;
        Thu, 25 Feb 2021 11:08:27 -0500
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.10])
        by mx0a-001b2d01.pphosted.com with ESMTP id 36xdyj37rf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 25 Feb 2021 11:08:27 -0500
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
        by ppma02dal.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 11PG2uam018938;
        Thu, 25 Feb 2021 16:08:26 GMT
Received: from b03cxnp08025.gho.boulder.ibm.com (b03cxnp08025.gho.boulder.ibm.com [9.17.130.17])
        by ppma02dal.us.ibm.com with ESMTP id 36tt2ahtwt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 25 Feb 2021 16:08:26 +0000
Received: from b03ledav001.gho.boulder.ibm.com (b03ledav001.gho.boulder.ibm.com [9.17.130.232])
        by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 11PG8OLM29295024
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 25 Feb 2021 16:08:24 GMT
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 36EFD6E052;
        Thu, 25 Feb 2021 16:08:24 +0000 (GMT)
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A526E6E04C;
        Thu, 25 Feb 2021 16:08:23 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
        by b03ledav001.gho.boulder.ibm.com (Postfix) with ESMTP;
        Thu, 25 Feb 2021 16:08:23 +0000 (GMT)
From:   Stefan Berger <stefanb@linux.vnet.ibm.com>
To:     keyrings@vger.kernel.org, linux-crypto@vger.kernel.org,
        davem@davemloft.net, herbert@gondor.apana.org.au,
        dhowells@redhat.com, zohar@linux.ibm.com
Cc:     linux-kernel@vger.kernel.org, patrick@puiterwijk.org,
        linux-integrity@vger.kernel.org,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH v9 9/9] certs: Add support for using elliptic curve keys for signing modules
Date:   Thu, 25 Feb 2021 11:08:02 -0500
Message-Id: <20210225160802.2478700-10-stefanb@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210225160802.2478700-1-stefanb@linux.vnet.ibm.com>
References: <20210225160802.2478700-1-stefanb@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-02-25_09:2021-02-24,2021-02-25 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 bulkscore=0
 adultscore=0 priorityscore=1501 phishscore=0 mlxscore=0 impostorscore=0
 clxscore=1015 lowpriorityscore=0 suspectscore=0 spamscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102250127
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

From: Stefan Berger <stefanb@linux.ibm.com>

This patch adds support for using elliptic curve keys for signing
modules. It uses a NIST P384 (secp384r1) key if the user chooses an
elliptic curve key and will have ECDSA support built into the kernel.

Note: A developer choosing an ECDSA key for signing modules has to
manually delete the signing key (rm certs/signing_key.*) when falling
back to building an older version of a kernel that only supports RSA
keys since otherwise ECDSA-signed modules will not be usable when that
older kernel runs and the ECDSA key was still used for signing modules.

Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>

---

v8->v9:
 - Automatically select CONFIG_ECDSA for built-in ECDSA support
 - Added help documentation

This patch builds on top Nayna's series for 'kernel build support for
loading the kernel module signing key'.
- https://lkml.org/lkml/2021/2/18/856
---
 certs/Kconfig                         | 22 ++++++++++++++++++++++
 certs/Makefile                        | 14 ++++++++++++++
 crypto/asymmetric_keys/pkcs7_parser.c |  4 ++++
 3 files changed, 40 insertions(+)

diff --git a/certs/Kconfig b/certs/Kconfig
index 48675ad319db..919db43ce80b 100644
--- a/certs/Kconfig
+++ b/certs/Kconfig
@@ -15,6 +15,28 @@ config MODULE_SIG_KEY
          then the kernel will automatically generate the private key and
          certificate as described in Documentation/admin-guide/module-signing.rst
 
+choice
+	prompt "Type of module signing key to be generated"
+	default MODULE_SIG_KEY_TYPE_RSA
+	help
+	 The type of module signing key type to generated. This option
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
+	 Use an elliptic curve key (NIST P384) for module signing.
+
+endchoice
+
 config SYSTEM_TRUSTED_KEYRING
 	bool "Provide system-wide ring of trusted keys"
 	depends on KEYS
diff --git a/certs/Makefile b/certs/Makefile
index 3fe6b73786fa..c487d7021c54 100644
--- a/certs/Makefile
+++ b/certs/Makefile
@@ -69,6 +69,18 @@ else
 SIGNER = -signkey $(obj)/signing_key.key
 endif # CONFIG_IMA_APPRAISE_MODSIG
 
+X509TEXT=$(shell openssl x509 -in $(CONFIG_MODULE_SIG_KEY) -text)
+
+# Support user changing key type
+ifdef CONFIG_MODULE_SIG_KEY_TYPE_ECDSA
+keytype_openssl = -newkey ec -pkeyopt ec_paramgen_curve:secp384r1
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

