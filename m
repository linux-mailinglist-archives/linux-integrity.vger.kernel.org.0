Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAED3358831
	for <lists+linux-integrity@lfdr.de>; Thu,  8 Apr 2021 17:24:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231977AbhDHPYV (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 8 Apr 2021 11:24:21 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:29016 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231919AbhDHPYU (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 8 Apr 2021 11:24:20 -0400
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 138FALOT178071;
        Thu, 8 Apr 2021 11:24:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=+pFq3MF5lrDPqf60Fw/2ger+HZoMALSVDMfFuRxM5VE=;
 b=RyQq0IEiND5j0WOANpQATchkJZt5zpxks0T3MzFbxgXfF2EUoReRyll2CT3wWOUNJZ4E
 2Xzt8DsmdCezQR3vYqF3CpuSpIC0J1ia16OV7jkNVxFhzRRcXZEmNSFr2EQKIf+hCHlp
 BtMM64vK3M5Vd77W+QxBMZPqr8046WcoDdJe/kkH/Dsql97wL48KX+MoGYLvna/XU9+9
 sKOtkkbyoxp9kZaf019mC9TqkJrDcwtm3JeO5ZZ3tOEnbWA3VLXehq2rE2atqVWyUlgo
 2v2PtCcF0y06ujNQY1xbYeKtJ1+4DYtFGr9ZoKdaIXMyV8OpnnnO0sjmMchDMoK9XcZf YA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 37rvn1nkjk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 08 Apr 2021 11:24:09 -0400
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 138FAN5u179073;
        Thu, 8 Apr 2021 11:24:08 -0400
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com [169.63.214.131])
        by mx0a-001b2d01.pphosted.com with ESMTP id 37rvn1nkhk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 08 Apr 2021 11:24:08 -0400
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
        by ppma01dal.us.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 138FNH3h008340;
        Thu, 8 Apr 2021 15:24:07 GMT
Received: from b01cxnp22035.gho.pok.ibm.com (b01cxnp22035.gho.pok.ibm.com [9.57.198.25])
        by ppma01dal.us.ibm.com with ESMTP id 37rvs1h6dk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 08 Apr 2021 15:24:07 +0000
Received: from b01ledav004.gho.pok.ibm.com (b01ledav004.gho.pok.ibm.com [9.57.199.109])
        by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 138FO69O15794432
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 8 Apr 2021 15:24:06 GMT
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 73AE9112066;
        Thu,  8 Apr 2021 15:24:06 +0000 (GMT)
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6567911206B;
        Thu,  8 Apr 2021 15:24:06 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.47.158.152])
        by b01ledav004.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu,  8 Apr 2021 15:24:06 +0000 (GMT)
From:   Stefan Berger <stefanb@linux.ibm.com>
To:     keyrings@vger.kernel.org, dhowells@redhat.com, zohar@linux.ibm.com,
        jarkko@kernel.org
Cc:     nayna@linux.ibm.com, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH v2 2/2] certs: Add support for using elliptic curve keys for signing modules
Date:   Thu,  8 Apr 2021 11:24:03 -0400
Message-Id: <20210408152403.1189121-3-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210408152403.1189121-1-stefanb@linux.ibm.com>
References: <20210408152403.1189121-1-stefanb@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: TDHyjJOtPgL3ZV3qnNALYCf7pSZ4cEiV
X-Proofpoint-ORIG-GUID: RZwUfmD17cwFD5uxpqZebpAbXIfE41J4
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-08_03:2021-04-08,2021-04-08 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 phishscore=0
 mlxlogscore=999 bulkscore=0 lowpriorityscore=0 suspectscore=0 adultscore=0
 spamscore=0 mlxscore=0 malwarescore=0 impostorscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104080104
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
v2:
  - check for ECDSA key by id-ecPublicKey from output line
    'Public Key Algorithm: id-ecPublicKey'.
---
 certs/Kconfig                         | 25 +++++++++++++++++++++++++
 certs/Makefile                        |  9 +++++++++
 crypto/asymmetric_keys/pkcs7_parser.c |  4 ++++
 3 files changed, 38 insertions(+)

diff --git a/certs/Kconfig b/certs/Kconfig
index 48675ad319db..6f8337874ae0 100644
--- a/certs/Kconfig
+++ b/certs/Kconfig
@@ -15,6 +15,31 @@ config MODULE_SIG_KEY
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
+	 Use an elliptic curve key (NIST P384) for module signing.
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

