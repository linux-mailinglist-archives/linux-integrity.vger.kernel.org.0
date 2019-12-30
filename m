Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6BC5312D2DC
	for <lists+linux-integrity@lfdr.de>; Mon, 30 Dec 2019 18:40:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727537AbfL3Rk2 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 30 Dec 2019 12:40:28 -0500
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:39318 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726602AbfL3Rk2 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 30 Dec 2019 12:40:28 -0500
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 4353F8EE15F;
        Mon, 30 Dec 2019 09:40:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1577727628;
        bh=23Cn71eJx0AKyDSbpqORDAxWJucZcBbmg7D9H8pTp1Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FDRbw9ppeNvrvkJVFultComoD9jAQtOLOHKhkUAPxWml4psM5/DK8lioSmlCJ4IOj
         1J3tK3AmR/LQrovwnFcx67VSc26PYWozC0oMvmCl6Cf9v3Tp7VC6A/c3KT3wMuntGo
         ggT4gXg+kiuh6YM/2R6QenC5+/b5vJdw+VZZfKdM=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id bA641DOJ_PIz; Mon, 30 Dec 2019 09:40:28 -0800 (PST)
Received: from jarvis.int.hansenpartnership.com (jarvis.ext.hansenpartnership.com [153.66.160.226])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id CE5A08EE07B;
        Mon, 30 Dec 2019 09:40:27 -0800 (PST)
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     linux-integrity@vger.kernel.org
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        David Woodhouse <dwmw2@infradead.org>, keyrings@vger.kernel.org
Subject: [PATCH v4 3/9] security: keys: trusted fix tpm2 authorizations
Date:   Mon, 30 Dec 2019 09:37:56 -0800
Message-Id: <20191230173802.8731-4-James.Bottomley@HansenPartnership.com>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20191230173802.8731-1-James.Bottomley@HansenPartnership.com>
References: <20191230173802.8731-1-James.Bottomley@HansenPartnership.com>
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

In TPM 1.2 an authorization was a 20 byte number.  The spec actually
recommended you to hash variable length passwords and use the sha1
hash as the authorization.  Because the spec doesn't require this
hashing, the current authorization for trusted keys is a 40 digit hex
number.  For TPM 2.0 the spec allows the passing in of variable length
passwords and passphrases directly, so we should allow that in trusted
keys for ease of use.  Update the 'blobauth' parameter to take this
into account, so we can now use plain text passwords for the keys.

so before

keyctl add trusted kmk "new 32 blobauth=f572d396fae9206628714fb2ce00f72e94f2258f"

after:

keyctl add trusted kmk "new 32 blobauth=hello keyhandle=81000001"

Note this is both and enhancement and a potential bug fix.  The TPM
2.0 spec requires us to strip leading zeros, meaning empyty
authorization is a zero length HMAC whereas we're currently passing in
20 bytes of zeros.  A lot of TPMs simply accept this as OK, but the
Microsoft TPM emulator rejects it with TPM_RC_BAD_AUTH, so this patch
makes the Microsoft TPM emulator work with trusted keys.

Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>
---
 include/keys/trusted-type.h               |  1 +
 security/keys/trusted-keys/trusted_tpm1.c | 24 +++++++++++++++++++-----
 security/keys/trusted-keys/trusted_tpm2.c |  9 +++++----
 3 files changed, 25 insertions(+), 9 deletions(-)

diff --git a/include/keys/trusted-type.h b/include/keys/trusted-type.h
index a94c03a61d8f..b2ed3481c6a0 100644
--- a/include/keys/trusted-type.h
+++ b/include/keys/trusted-type.h
@@ -30,6 +30,7 @@ struct trusted_key_options {
 	uint16_t keytype;
 	uint32_t keyhandle;
 	unsigned char keyauth[TPM_DIGEST_SIZE];
+	uint32_t blobauth_len;
 	unsigned char blobauth[TPM_DIGEST_SIZE];
 	uint32_t pcrinfo_len;
 	unsigned char pcrinfo[MAX_PCRINFO_SIZE];
diff --git a/security/keys/trusted-keys/trusted_tpm1.c b/security/keys/trusted-keys/trusted_tpm1.c
index d2c5ec1e040b..ef15b6cda6ec 100644
--- a/security/keys/trusted-keys/trusted_tpm1.c
+++ b/security/keys/trusted-keys/trusted_tpm1.c
@@ -781,12 +781,26 @@ static int getoptions(char *c, struct trusted_key_payload *pay,
 				return -EINVAL;
 			break;
 		case Opt_blobauth:
-			if (strlen(args[0].from) != 2 * SHA1_DIGEST_SIZE)
-				return -EINVAL;
-			res = hex2bin(opt->blobauth, args[0].from,
-				      SHA1_DIGEST_SIZE);
-			if (res < 0)
+			/*
+			 * TPM 1.2 authorizations are sha1 hashes
+			 * passed in as hex strings.  TPM 2.0
+			 * authorizations are simple passwords
+			 * (although it can take a hash as well)
+			 */
+			opt->blobauth_len = strlen(args[0].from);
+			if (opt->blobauth_len == 2 * TPM_DIGEST_SIZE) {
+				res = hex2bin(opt->blobauth, args[0].from,
+					      TPM_DIGEST_SIZE);
+				if (res < 0)
+					return -EINVAL;
+				opt->blobauth_len = TPM_DIGEST_SIZE;
+			} else if (tpm2 &&
+				   opt->blobauth_len <= sizeof(opt->blobauth)) {
+				memcpy(opt->blobauth, args[0].from,
+				       opt->blobauth_len);
+			} else {
 				return -EINVAL;
+			}
 			break;
 		case Opt_migratable:
 			if (*args[0].from == '0')
diff --git a/security/keys/trusted-keys/trusted_tpm2.c b/security/keys/trusted-keys/trusted_tpm2.c
index 08ec7f48f01d..11a331a94327 100644
--- a/security/keys/trusted-keys/trusted_tpm2.c
+++ b/security/keys/trusted-keys/trusted_tpm2.c
@@ -91,10 +91,11 @@ int tpm2_seal_trusted(struct tpm_chip *chip,
 			     TPM_DIGEST_SIZE);
 
 	/* sensitive */
-	tpm_buf_append_u16(&buf, 4 + TPM_DIGEST_SIZE + payload->key_len + 1);
+	tpm_buf_append_u16(&buf, 4 + options->blobauth_len + payload->key_len + 1);
 
-	tpm_buf_append_u16(&buf, TPM_DIGEST_SIZE);
-	tpm_buf_append(&buf, options->blobauth, TPM_DIGEST_SIZE);
+	tpm_buf_append_u16(&buf, options->blobauth_len);
+	if (options->blobauth_len)
+		tpm_buf_append(&buf, options->blobauth, options->blobauth_len);
 	tpm_buf_append_u16(&buf, payload->key_len + 1);
 	tpm_buf_append(&buf, payload->key, payload->key_len);
 	tpm_buf_append_u8(&buf, payload->migratable);
@@ -258,7 +259,7 @@ static int tpm2_unseal_cmd(struct tpm_chip *chip,
 			     NULL /* nonce */, 0,
 			     TPM2_SA_CONTINUE_SESSION,
 			     options->blobauth /* hmac */,
-			     TPM_DIGEST_SIZE);
+			     options->blobauth_len);
 
 	rc = tpm_send(chip, buf.data, tpm_buf_length(&buf));
 	if (rc > 0)
-- 
2.16.4

