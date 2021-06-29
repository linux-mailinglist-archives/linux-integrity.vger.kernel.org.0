Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12E903B79E8
	for <lists+linux-integrity@lfdr.de>; Tue, 29 Jun 2021 23:34:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235394AbhF2VhC (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 29 Jun 2021 17:37:02 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:16698 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235071AbhF2VhB (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 29 Jun 2021 17:37:01 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15TLX1mV050992;
        Tue, 29 Jun 2021 17:34:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=Q1lXpYraVtwjfvdbQr6ogMCgErTtRUfs0JYxQqtCkOk=;
 b=cb/olTXkv+o0gahsHLErs+bkR7aqKNw5m16Sl/nyPxoWPcTJeV6gPYX4mLdm3DBP+GFS
 x308wALo95PrRkYz0GM8RAyfZUhiVlRXdWwF/If/DsmmE6ktet9Qg7Lug4GjtKl60I3q
 aU9NejipOPux5xKNo+8jc+/61weNculsRYfvo19ynoF4zxM54mN+xP0YvJ8bslpViZJC
 dowiq8DJTTmCtatSWwBt2gR5iOWQPFPD7kAKbR0ofIUukrwS4zrQurDOljeye1JTEIqn
 XRJbmK5p1VX4Y/FsxIEed6+DxQ5yYezmh+FiwWh34lDI2yEu/Kc/3d2TmNdd/0ZgbbUA 6w== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 39g8nkch80-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 29 Jun 2021 17:34:29 -0400
Received: from m0098393.ppops.net (m0098393.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 15TLYTxT057646;
        Tue, 29 Jun 2021 17:34:29 -0400
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com [169.63.214.131])
        by mx0a-001b2d01.pphosted.com with ESMTP id 39g8nkch7m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 29 Jun 2021 17:34:29 -0400
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
        by ppma01dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 15TLVNmU003540;
        Tue, 29 Jun 2021 21:34:28 GMT
Received: from b01cxnp23034.gho.pok.ibm.com (b01cxnp23034.gho.pok.ibm.com [9.57.198.29])
        by ppma01dal.us.ibm.com with ESMTP id 39duvdau3y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 29 Jun 2021 21:34:27 +0000
Received: from b01ledav006.gho.pok.ibm.com (b01ledav006.gho.pok.ibm.com [9.57.199.111])
        by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 15TLYR2j34931104
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 29 Jun 2021 21:34:27 GMT
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 02AB0AC05B;
        Tue, 29 Jun 2021 21:34:27 +0000 (GMT)
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DBBC3AC068;
        Tue, 29 Jun 2021 21:34:26 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.47.158.152])
        by b01ledav006.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue, 29 Jun 2021 21:34:26 +0000 (GMT)
From:   Stefan Berger <stefanb@linux.vnet.ibm.com>
To:     jeyu@kernel.org, keyrings@vger.kernel.org, dhowells@redhat.com,
        dwmw2@infradead.org, zohar@linux.ibm.com, jarkko@kernel.org
Cc:     nayna@linux.ibm.com, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH v8 2/2] certs: Add support for using elliptic curve keys for signing modules
Date:   Tue, 29 Jun 2021 17:34:21 -0400
Message-Id: <20210629213421.60320-3-stefanb@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210629213421.60320-1-stefanb@linux.vnet.ibm.com>
References: <20210629213421.60320-1-stefanb@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: dwcQcJfBWFPQKuYUqvfnpPFFbMd7i64F
X-Proofpoint-ORIG-GUID: 4NNNhVFhaYsfCI1CZu5nip-u0a9hSDUv
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-06-29_14:2021-06-29,2021-06-29 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 priorityscore=1501 mlxscore=0 malwarescore=0 bulkscore=0 spamscore=0
 adultscore=0 clxscore=1015 mlxlogscore=999 phishscore=0 impostorscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106290132
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

From: Stefan Berger <stefanb@linux.ibm.com>

Add support for using elliptic curve keys for signing modules. It uses
a NIST P384 (secp384r1) key if the user chooses an elliptic curve key
and will have ECDSA support built into the kernel.

Note: A developer choosing an ECDSA key for signing modules should still
delete the signing key (rm certs/signing_key.*) when building an older
version of a kernel that only supports RSA keys. Unless kbuild automati-
cally detects and generates a new kernel module key, ECDSA-signed kernel
modules will fail signature verification.

Cc: David Howells <dhowells@redhat.com>
Cc: David Woodhouse <dwmw2@infradead.org>
Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
---
 certs/Kconfig                         | 26 ++++++++++++++++++++++++++
 certs/Makefile                        | 13 +++++++++++++
 crypto/asymmetric_keys/pkcs7_parser.c |  8 ++++++++
 3 files changed, 47 insertions(+)

diff --git a/certs/Kconfig b/certs/Kconfig
index f4e61116f94e..7d38d65e2128 100644
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
+	 when falling back to building Linux 5.13 and older kernels.
+
+endchoice
+
 config SYSTEM_TRUSTED_KEYRING
 	bool "Provide system-wide ring of trusted keys"
 	depends on KEYS
diff --git a/certs/Makefile b/certs/Makefile
index f9344e52ecda..279433783b10 100644
--- a/certs/Makefile
+++ b/certs/Makefile
@@ -66,9 +66,21 @@ ifeq ($(CONFIG_MODULE_SIG_KEY),"certs/signing_key.pem")
 
 ifeq ($(openssl_available),yes)
 X509TEXT=$(shell openssl x509 -in "certs/signing_key.pem" -text 2>/dev/null)
+endif
 
+# Support user changing key type
+ifdef CONFIG_MODULE_SIG_KEY_TYPE_ECDSA
+keytype_openssl = -newkey ec -pkeyopt ec_paramgen_curve:secp384r1
+ifeq ($(openssl_available),yes)
+$(if $(findstring id-ecPublicKey,$(X509TEXT)),,$(shell rm -f "certs/signing_key.pem"))
+endif
+endif # CONFIG_MODULE_SIG_KEY_TYPE_ECDSA
+
+ifdef CONFIG_MODULE_SIG_KEY_TYPE_RSA
+ifeq ($(openssl_available),yes)
 $(if $(findstring rsaEncryption,$(X509TEXT)),,$(shell rm -f "certs/signing_key.pem"))
 endif
+endif # CONFIG_MODULE_SIG_KEY_TYPE_RSA
 
 $(obj)/signing_key.pem: $(obj)/x509.genkey
 	@$(kecho) "###"
@@ -83,6 +95,7 @@ $(obj)/signing_key.pem: $(obj)/x509.genkey
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
2.31.1

