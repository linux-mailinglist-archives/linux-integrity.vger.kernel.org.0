Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8936F43ADAF
	for <lists+linux-integrity@lfdr.de>; Tue, 26 Oct 2021 09:56:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234026AbhJZH7A (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 26 Oct 2021 03:59:00 -0400
Received: from out30-44.freemail.mail.aliyun.com ([115.124.30.44]:44535 "EHLO
        out30-44.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233200AbhJZH65 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 26 Oct 2021 03:58:57 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R731e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04395;MF=tianjia.zhang@linux.alibaba.com;NM=1;PH=DS;RN=19;SR=0;TI=SMTPD_---0UtlDC38_1635234987;
Received: from localhost(mailfrom:tianjia.zhang@linux.alibaba.com fp:SMTPD_---0UtlDC38_1635234987)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 26 Oct 2021 15:56:28 +0800
From:   Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
To:     James Bottomley <jejb@linux.ibm.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        David Howells <dhowells@redhat.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Jerry Snitselaar <jsnitsel@redhat.com>,
        linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-security-module@vger.kernel.org
Cc:     Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
Subject: [PATCH v3 2/2] tpm: use SM3 instead of SM3_256
Date:   Tue, 26 Oct 2021 15:56:26 +0800
Message-Id: <20211026075626.61975-3-tianjia.zhang@linux.alibaba.com>
X-Mailer: git-send-email 2.19.1.3.ge56e4f7
In-Reply-To: <20211026075626.61975-1-tianjia.zhang@linux.alibaba.com>
References: <20211026075626.61975-1-tianjia.zhang@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

According to https://tools.ietf.org/id/draft-oscca-cfrg-sm3-01.html,
SM3 always produces a 256-bit hash value and there are no plans for
other length development, so there is no ambiguity in the name of sm3.

Signed-off-by: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
---
 Documentation/security/keys/trusted-encrypted.rst | 2 +-
 drivers/char/tpm/tpm-sysfs.c                      | 4 ++--
 drivers/char/tpm/tpm2-cmd.c                       | 2 +-
 include/linux/tpm.h                               | 2 +-
 security/keys/trusted-keys/trusted_tpm2.c         | 2 +-
 5 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/Documentation/security/keys/trusted-encrypted.rst b/Documentation/security/keys/trusted-encrypted.rst
index 80d5a5af62a1..3292461517f6 100644
--- a/Documentation/security/keys/trusted-encrypted.rst
+++ b/Documentation/security/keys/trusted-encrypted.rst
@@ -162,7 +162,7 @@ Usage::
                      default 1 (resealing allowed)
        hash=         hash algorithm name as a string. For TPM 1.x the only
                      allowed value is sha1. For TPM 2.x the allowed values
-                     are sha1, sha256, sha384, sha512 and sm3-256.
+                     are sha1, sha256, sha384, sha512 and sm3.
        policydigest= digest for the authorization policy. must be calculated
                      with the same hash algorithm as specified by the 'hash='
                      option.
diff --git a/drivers/char/tpm/tpm-sysfs.c b/drivers/char/tpm/tpm-sysfs.c
index 63f03cfb8e6a..fe6c785dc84a 100644
--- a/drivers/char/tpm/tpm-sysfs.c
+++ b/drivers/char/tpm/tpm-sysfs.c
@@ -471,7 +471,7 @@ PCR_ATTR_BUILD(TPM_ALG_SHA1, sha1);
 PCR_ATTR_BUILD(TPM_ALG_SHA256, sha256);
 PCR_ATTR_BUILD(TPM_ALG_SHA384, sha384);
 PCR_ATTR_BUILD(TPM_ALG_SHA512, sha512);
-PCR_ATTR_BUILD(TPM_ALG_SM3_256, sm3);
+PCR_ATTR_BUILD(TPM_ALG_SM3, sm3);
 
 
 void tpm_sysfs_add_device(struct tpm_chip *chip)
@@ -500,7 +500,7 @@ void tpm_sysfs_add_device(struct tpm_chip *chip)
 		case TPM_ALG_SHA512:
 			chip->groups[chip->groups_cnt++] = &pcr_group_sha512;
 			break;
-		case TPM_ALG_SM3_256:
+		case TPM_ALG_SM3:
 			chip->groups[chip->groups_cnt++] = &pcr_group_sm3;
 			break;
 		default:
diff --git a/drivers/char/tpm/tpm2-cmd.c b/drivers/char/tpm/tpm2-cmd.c
index 20f55de9d87b..d5a9410d2273 100644
--- a/drivers/char/tpm/tpm2-cmd.c
+++ b/drivers/char/tpm/tpm2-cmd.c
@@ -19,7 +19,7 @@ static struct tpm2_hash tpm2_hash_map[] = {
 	{HASH_ALGO_SHA256, TPM_ALG_SHA256},
 	{HASH_ALGO_SHA384, TPM_ALG_SHA384},
 	{HASH_ALGO_SHA512, TPM_ALG_SHA512},
-	{HASH_ALGO_SM3, TPM_ALG_SM3_256},
+	{HASH_ALGO_SM3, TPM_ALG_SM3},
 };
 
 int tpm2_get_timeouts(struct tpm_chip *chip)
diff --git a/include/linux/tpm.h b/include/linux/tpm.h
index aa11fe323c56..56a79fee1250 100644
--- a/include/linux/tpm.h
+++ b/include/linux/tpm.h
@@ -40,7 +40,7 @@ enum tpm_algorithms {
 	TPM_ALG_SHA384		= 0x000C,
 	TPM_ALG_SHA512		= 0x000D,
 	TPM_ALG_NULL		= 0x0010,
-	TPM_ALG_SM3_256		= 0x0012,
+	TPM_ALG_SM3		= 0x0012,
 };
 
 /*
diff --git a/security/keys/trusted-keys/trusted_tpm2.c b/security/keys/trusted-keys/trusted_tpm2.c
index 52a696035176..b15a9961213d 100644
--- a/security/keys/trusted-keys/trusted_tpm2.c
+++ b/security/keys/trusted-keys/trusted_tpm2.c
@@ -23,7 +23,7 @@ static struct tpm2_hash tpm2_hash_map[] = {
 	{HASH_ALGO_SHA256, TPM_ALG_SHA256},
 	{HASH_ALGO_SHA384, TPM_ALG_SHA384},
 	{HASH_ALGO_SHA512, TPM_ALG_SHA512},
-	{HASH_ALGO_SM3, TPM_ALG_SM3_256},
+	{HASH_ALGO_SM3, TPM_ALG_SM3},
 };
 
 static u32 tpm2key_oid[] = { 2, 23, 133, 10, 1, 5 };
-- 
2.19.1.3.ge56e4f7

