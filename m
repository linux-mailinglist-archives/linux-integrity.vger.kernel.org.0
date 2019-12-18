Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 199A1123FC0
	for <lists+linux-integrity@lfdr.de>; Wed, 18 Dec 2019 07:39:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726695AbfLRGju (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 18 Dec 2019 01:39:50 -0500
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:42794 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725799AbfLRGju (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 18 Dec 2019 01:39:50 -0500
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 0C63C8EE193;
        Tue, 17 Dec 2019 22:39:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1576651190;
        bh=VqwZ/3+z22mHG8djxbT81BfP7Dswb0A9A7olkdrIdt4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QQega7UM8OY0jDE1PkD/JMSxgnSlubcbBwvcS6/nV4KH+0EhWCLoE9NpiQr009QnM
         ImGCAFKwvcA9KZsAACEjCRT80NE/Yba2RET5V14RZm9K3jN0My6qLSP/YkjdQcoC3V
         kLcrNEGSyyYG7nVnEz8iTttvBPumGHSXPIyBDboU=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id t5W7xdDkVtbG; Tue, 17 Dec 2019 22:39:49 -0800 (PST)
Received: from jarvis.int.hansenpartnership.com (jarvis.ext.hansenpartnership.com [153.66.160.226])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 05EB08EE0DF;
        Tue, 17 Dec 2019 22:39:48 -0800 (PST)
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     linux-integrity@vger.kernel.org
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        David Woodhouse <dwmw2@infradead.org>, keyrings@vger.kernel.org
Subject: [PATCH v3 8/9] security: keys: trusted fix tpm2 authorizations
Date:   Wed, 18 Dec 2019 15:31:41 +0900
Message-Id: <20191218063142.23033-9-James.Bottomley@HansenPartnership.com>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20191218063142.23033-1-James.Bottomley@HansenPartnership.com>
References: <20191218063142.23033-1-James.Bottomley@HansenPartnership.com>
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

Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>
---
 include/keys/trusted-type.h               |  1 +
 security/keys/trusted-keys/trusted_tpm1.c | 24 +++++++++++++++++++-----
 2 files changed, 20 insertions(+), 5 deletions(-)

diff --git a/include/keys/trusted-type.h b/include/keys/trusted-type.h
index fc9c13802c06..c117bf598230 100644
--- a/include/keys/trusted-type.h
+++ b/include/keys/trusted-type.h
@@ -34,6 +34,7 @@ struct trusted_key_options {
 	uint16_t keytype;
 	uint32_t keyhandle;
 	unsigned char keyauth[TPM_DIGEST_SIZE];
+	uint32_t blobauth_len;
 	unsigned char blobauth[TPM_DIGEST_SIZE];
 	uint32_t pcrinfo_len;
 	unsigned char pcrinfo[MAX_PCRINFO_SIZE];
diff --git a/security/keys/trusted-keys/trusted_tpm1.c b/security/keys/trusted-keys/trusted_tpm1.c
index 668cbdc675b8..af269f4774de 100644
--- a/security/keys/trusted-keys/trusted_tpm1.c
+++ b/security/keys/trusted-keys/trusted_tpm1.c
@@ -785,12 +785,26 @@ static int getoptions(char *c, struct trusted_key_payload *pay,
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
-- 
2.16.4

