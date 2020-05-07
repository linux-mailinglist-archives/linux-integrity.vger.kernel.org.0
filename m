Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBCB61C9F03
	for <lists+linux-integrity@lfdr.de>; Fri,  8 May 2020 01:13:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726612AbgEGXNb (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 7 May 2020 19:13:31 -0400
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:33436 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726514AbgEGXNb (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 7 May 2020 19:13:31 -0400
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id E7B1A8EE268;
        Thu,  7 May 2020 16:13:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1588893210;
        bh=RioGwXWnvHDFKqdS5qjun9SGo7ileKndFjxl7WUKj6U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TMoaThKq1C/Unbfxk/vB2kgc7+0ZLiz+4+S4YNoBN+dmbawpcXm1CS2AssclnbQsK
         5USgbWHFkkpQ5/FgWoiIFTY7geCsg3jJ9Q7eif34FqSuKhsiE6AgseXWWX4B2gLAoN
         d8xjaG+DEgoA6cS22BAd3VIQlP/D0+FWx1gxliUw=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id SGUGfrwq_6R7; Thu,  7 May 2020 16:13:30 -0700 (PDT)
Received: from jarvis.lan (jarvis.ext.hansenpartnership.com [153.66.160.226])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 6FCEA8EE181;
        Thu,  7 May 2020 16:13:30 -0700 (PDT)
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     linux-integrity@vger.kernel.org
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        David Woodhouse <dwmw2@infradead.org>,
        keyrings@vger.kernel.org, David Howells <dhowells@redhat.com>
Subject: [PATCH v9 3/8] security: keys: trusted: fix TPM2 authorizations
Date:   Thu,  7 May 2020 16:11:42 -0700
Message-Id: <20200507231147.27025-4-James.Bottomley@HansenPartnership.com>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200507231147.27025-1-James.Bottomley@HansenPartnership.com>
References: <20200507231147.27025-1-James.Bottomley@HansenPartnership.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

after we will accept both the old hex sha1 form as well as a new
directly supplied password:

keyctl add trusted kmk "new 32 blobauth=hello keyhandle=81000001"

Since a sha1 hex code must be exactly 40 bytes long and a direct
password must be 20 or less, we use the length as the discriminator
for which form is input.

Note this is both and enhancement and a potential bug fix.  The TPM
2.0 spec requires us to strip leading zeros, meaning empyty
authorization is a zero length HMAC whereas we're currently passing in
20 bytes of zeros.  A lot of TPMs simply accept this as OK, but the
Microsoft TPM emulator rejects it with TPM_RC_BAD_AUTH, so this patch
makes the Microsoft TPM emulator work with trusted keys.

Fixes: 0fe5480303a1 ("keys, trusted: seal/unseal with TPM 2.0 chips")
Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>
Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>

---

v6: change comment, eliminate else clauses and add fixes tag
v7: fixes before signoff
---
 include/keys/trusted-type.h               |  1 +
 security/keys/trusted-keys/trusted_tpm1.c | 32 ++++++++++++++++++-----
 security/keys/trusted-keys/trusted_tpm2.c | 10 ++++---
 3 files changed, 33 insertions(+), 10 deletions(-)

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
index 8001ab07e63b..3b8fa7df0d27 100644
--- a/security/keys/trusted-keys/trusted_tpm1.c
+++ b/security/keys/trusted-keys/trusted_tpm1.c
@@ -781,13 +781,33 @@ static int getoptions(char *c, struct trusted_key_payload *pay,
 				return -EINVAL;
 			break;
 		case Opt_blobauth:
-			if (strlen(args[0].from) != 2 * SHA1_DIGEST_SIZE)
-				return -EINVAL;
-			res = hex2bin(opt->blobauth, args[0].from,
-				      SHA1_DIGEST_SIZE);
-			if (res < 0)
-				return -EINVAL;
+			/*
+			 * TPM 1.2 authorizations are sha1 hashes passed in as
+			 * hex strings.  TPM 2.0 authorizations are simple
+			 * passwords (although it can take a hash as well)
+			 */
+			opt->blobauth_len = strlen(args[0].from);
+
+			if (opt->blobauth_len == 2 * TPM_DIGEST_SIZE) {
+				res = hex2bin(opt->blobauth, args[0].from,
+					      TPM_DIGEST_SIZE);
+				if (res < 0)
+					return -EINVAL;
+
+				opt->blobauth_len = TPM_DIGEST_SIZE;
+				return 0;
+			}
+
+			if (tpm2 && opt->blobauth_len <= sizeof(opt->blobauth)) {
+				memcpy(opt->blobauth, args[0].from,
+				       opt->blobauth_len);
+				return 0;
+			}
+
+			return -EINVAL;
+
 			break;
+
 		case Opt_migratable:
 			if (*args[0].from == '0')
 				pay->migratable = 0;
diff --git a/security/keys/trusted-keys/trusted_tpm2.c b/security/keys/trusted-keys/trusted_tpm2.c
index 08ec7f48f01d..b4a5058107c2 100644
--- a/security/keys/trusted-keys/trusted_tpm2.c
+++ b/security/keys/trusted-keys/trusted_tpm2.c
@@ -91,10 +91,12 @@ int tpm2_seal_trusted(struct tpm_chip *chip,
 			     TPM_DIGEST_SIZE);
 
 	/* sensitive */
-	tpm_buf_append_u16(&buf, 4 + TPM_DIGEST_SIZE + payload->key_len + 1);
+	tpm_buf_append_u16(&buf, 4 + options->blobauth_len + payload->key_len + 1);
+
+	tpm_buf_append_u16(&buf, options->blobauth_len);
+	if (options->blobauth_len)
+		tpm_buf_append(&buf, options->blobauth, options->blobauth_len);
 
-	tpm_buf_append_u16(&buf, TPM_DIGEST_SIZE);
-	tpm_buf_append(&buf, options->blobauth, TPM_DIGEST_SIZE);
 	tpm_buf_append_u16(&buf, payload->key_len + 1);
 	tpm_buf_append(&buf, payload->key, payload->key_len);
 	tpm_buf_append_u8(&buf, payload->migratable);
@@ -258,7 +260,7 @@ static int tpm2_unseal_cmd(struct tpm_chip *chip,
 			     NULL /* nonce */, 0,
 			     TPM2_SA_CONTINUE_SESSION,
 			     options->blobauth /* hmac */,
-			     TPM_DIGEST_SIZE);
+			     options->blobauth_len);
 
 	rc = tpm_send(chip, buf.data, tpm_buf_length(&buf));
 	if (rc > 0)
-- 
2.26.1

