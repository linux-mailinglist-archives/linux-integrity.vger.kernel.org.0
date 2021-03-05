Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69C6932F4F3
	for <lists+linux-integrity@lfdr.de>; Fri,  5 Mar 2021 22:01:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229976AbhCEVAZ (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 5 Mar 2021 16:00:25 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:32156 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229693AbhCEVAS (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 5 Mar 2021 16:00:18 -0500
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 125KXLkK182717;
        Fri, 5 Mar 2021 16:00:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=pHGMUorRKoM0SU+XHOfDbWQVMw9U7ZaFRKwfSwIa7Ls=;
 b=j9rkYH0WQ65aWaTqfelPmO/R/9NVioEnJ8PjiEUtRleZGgEdFfXt3YD13SQ2POQyD0FM
 VuKvJbCfZMEi0iXbtndlxNqQwFnpDSXqG0koOWV2pz+eZkO6tSj586kC/+hZFvKyH8Q3
 Urdu5HS5e5oGfgaTnziMhX4HMS9wr2njVNmCmIBjPNUdAZapjqkAvmSiw2vRZlhZi8mQ
 IlYUC/HMbmuoVnk4edZ30w43q1Ddg4Sy1OP+nL+4uwI1i83Zr9dXIq1A09hNvn2jS2jT
 gj9VtCNfalAnRW5nQV4GmUpfWI2miiU214wFILNfv4pYxp7J9a57Yty31DxxnkHgTVMS rQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 373usj0h06-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 05 Mar 2021 16:00:11 -0500
Received: from m0098417.ppops.net (m0098417.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 125Ka11F191282;
        Fri, 5 Mar 2021 16:00:11 -0500
Received: from ppma04wdc.us.ibm.com (1a.90.2fa9.ip4.static.sl-reverse.com [169.47.144.26])
        by mx0a-001b2d01.pphosted.com with ESMTP id 373usj0gyf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 05 Mar 2021 16:00:11 -0500
Received: from pps.filterd (ppma04wdc.us.ibm.com [127.0.0.1])
        by ppma04wdc.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 125KqOUS006352;
        Fri, 5 Mar 2021 21:00:10 GMT
Received: from b03cxnp08026.gho.boulder.ibm.com (b03cxnp08026.gho.boulder.ibm.com [9.17.130.18])
        by ppma04wdc.us.ibm.com with ESMTP id 3712pja4g0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 05 Mar 2021 21:00:10 +0000
Received: from b03ledav005.gho.boulder.ibm.com (b03ledav005.gho.boulder.ibm.com [9.17.130.236])
        by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 125L09m611534780
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 5 Mar 2021 21:00:09 GMT
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 50255BE06D;
        Fri,  5 Mar 2021 21:00:09 +0000 (GMT)
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 96107BE06A;
        Fri,  5 Mar 2021 21:00:08 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
        by b03ledav005.gho.boulder.ibm.com (Postfix) with ESMTP;
        Fri,  5 Mar 2021 21:00:08 +0000 (GMT)
From:   Stefan Berger <stefanb@linux.vnet.ibm.com>
To:     keyrings@vger.kernel.org, linux-crypto@vger.kernel.org,
        davem@davemloft.net, herbert@gondor.apana.org.au,
        dhowells@redhat.com, zohar@linux.ibm.com, jarkko@kernel.org
Cc:     linux-kernel@vger.kernel.org, patrick@puiterwijk.org,
        linux-integrity@vger.kernel.org,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH v11 10/10] certs: Add support for using elliptic curve keys for signing modules
Date:   Fri,  5 Mar 2021 15:59:56 -0500
Message-Id: <20210305205956.3594375-11-stefanb@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210305205956.3594375-1-stefanb@linux.vnet.ibm.com>
References: <20210305205956.3594375-1-stefanb@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-05_14:2021-03-03,2021-03-05 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 adultscore=0
 mlxscore=0 clxscore=1015 spamscore=0 impostorscore=0 malwarescore=0
 lowpriorityscore=0 phishscore=0 priorityscore=1501 mlxlogscore=999
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103050103
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

From: Stefan Berger <stefanb@linux.ibm.com>

Add support for using elliptic curve keys for signing modules. It uses
a NIST P384 (secp384r1) key if the user chooses an elliptic curve key
and will have ECDSA support built into the kernel.

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

