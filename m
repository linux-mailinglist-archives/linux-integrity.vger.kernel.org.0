Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 49BF897A2B
	for <lists+linux-integrity@lfdr.de>; Wed, 21 Aug 2019 15:00:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728796AbfHUM76 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 21 Aug 2019 08:59:58 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:33282 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728609AbfHUM76 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 21 Aug 2019 08:59:58 -0400
Received: by mail-pg1-f195.google.com with SMTP id n190so1298469pgn.0
        for <linux-integrity@vger.kernel.org>; Wed, 21 Aug 2019 05:59:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=WLl6SIkEm8EPIG82alGpVstR8SNIlujuw9bck6n6T54=;
        b=Sk2mCxZBnMLZ2cz/iaYrc5sjnCnb8SThczMvGRzq8Woz7Hp5Z0CqBNY/PapAfhTyPd
         hGMwRa940PyFzD6qIiVQn5go9BKQbeZfu4d8QsM31jLrvynmBvZ977jEwjQc8+1BYuX+
         YT9WARrdHPYFGntiWzrqtd8XNN14E6vnqDBNs6LucpVj1EC97SV08LyTAQ5CKlPAc/S5
         gWDsN9zcQE+sHZv+pLT6VLzuQbve3W5SpxQ0fa55djtTYtb/ZL3y/S4lycfJ/YcPq6fC
         eL9lG8ZxMT/j3892YAHShV0OdUGvv4dt1TRw8gaCkW057UqMpJOb2nM26Q/E/fAJYny6
         1X5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=WLl6SIkEm8EPIG82alGpVstR8SNIlujuw9bck6n6T54=;
        b=gNZ5/1mr5C4ekB1t8dZeqizV5mOHasUIlgfnsxs3ZIoHBDoVr2UmM/9QX7laV/aITX
         AQEK3XDuB/oG5s07pLa8KZXFIx0j9l9rADO/F72vUXB06eFvPuRhg/mkGZ5SyzXkqqC3
         +sVePFlno1/cSc+IUZHgAQZyH5NhBI45Da+zGFYnd0dbV8YNeOf2uKsNi0gmgMB+l4DL
         VpleAtXZ2Oob2ErdnI9vUN7GeTt4xRs0oQ/iJUYYLrpqyHhSY7y6sRI2OdRjW+icdtEa
         WBfGa6QWamxeMMbPi2fVzmPbJnri0pgR8PfJQj2RuFOHATNgkACQ5JDo741QEbltQ+m4
         NU4w==
X-Gm-Message-State: APjAAAWEfjLYIBFvZ5qISg+ohnvtgp9ItUJ0nfMHplmQvOff5c6lmgYD
        ChvEEtjxYM8yBajYsLVE45k2gg==
X-Google-Smtp-Source: APXvYqzlKMjp8DCpd6a6z7a650tbJXYFtFUFqF22rJNGK/IbJS5/bZSgCLs3e42qzeTTpmWL4bR3RQ==
X-Received: by 2002:a62:1d8a:: with SMTP id d132mr32087051pfd.187.1566392397324;
        Wed, 21 Aug 2019 05:59:57 -0700 (PDT)
Received: from localhost.localdomain ([117.252.68.28])
        by smtp.gmail.com with ESMTPSA id o24sm47377476pfp.135.2019.08.21.05.59.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 21 Aug 2019 05:59:56 -0700 (PDT)
From:   Sumit Garg <sumit.garg@linaro.org>
To:     keyrings@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-security-module@vger.kernel.org
Cc:     dhowells@redhat.com, herbert@gondor.apana.org.au,
        davem@davemloft.net, peterhuewe@gmx.de, jgg@ziepe.ca,
        jejb@linux.ibm.com, jarkko.sakkinen@linux.intel.com, arnd@arndb.de,
        gregkh@linuxfoundation.org, zohar@linux.ibm.com, jmorris@namei.org,
        serge@hallyn.com, casey@schaufler-ca.com,
        ard.biesheuvel@linaro.org, daniel.thompson@linaro.org,
        linux-kernel@vger.kernel.org, tee-dev@lists.linaro.org,
        Sumit Garg <sumit.garg@linaro.org>
Subject: [PATCH v5 2/4] KEYS: trusted: use common tpm_buf for TPM1.x code
Date:   Wed, 21 Aug 2019 18:29:03 +0530
Message-Id: <1566392345-15419-3-git-send-email-sumit.garg@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1566392345-15419-1-git-send-email-sumit.garg@linaro.org>
References: <1566392345-15419-1-git-send-email-sumit.garg@linaro.org>
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Utilize common heap based tpm_buf code for TPM1.x trusted keys rather
than using stack based tpm1_buf code. Also, remove tpm1_buf code.

Suggested-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
---
 include/keys/trusted.h  | 37 +------------------
 security/keys/trusted.c | 98 ++++++++++++++++++++++---------------------------
 2 files changed, 44 insertions(+), 91 deletions(-)

diff --git a/include/keys/trusted.h b/include/keys/trusted.h
index 841ae11..29e3e9b 100644
--- a/include/keys/trusted.h
+++ b/include/keys/trusted.h
@@ -5,10 +5,6 @@
 /* implementation specific TPM constants */
 #define MAX_BUF_SIZE			1024
 #define TPM_GETRANDOM_SIZE		14
-#define TPM_OSAP_SIZE			36
-#define TPM_OIAP_SIZE			10
-#define TPM_SEAL_SIZE			87
-#define TPM_UNSEAL_SIZE			104
 #define TPM_SIZE_OFFSET			2
 #define TPM_RETURN_OFFSET		6
 #define TPM_DATA_OFFSET			10
@@ -17,13 +13,6 @@
 #define LOAD32N(buffer, offset)	(*(uint32_t *)&buffer[offset])
 #define LOAD16(buffer, offset)	(ntohs(*(uint16_t *)&buffer[offset]))
 
-struct tpm1_buf {
-	int len;
-	unsigned char data[MAX_BUF_SIZE];
-};
-
-#define INIT_BUF(tb) (tb->len = 0)
-
 struct osapsess {
 	uint32_t handle;
 	unsigned char secret[SHA1_DIGEST_SIZE];
@@ -46,7 +35,7 @@ int TSS_checkhmac1(unsigned char *buffer,
 			  unsigned int keylen, ...);
 
 int trusted_tpm_send(unsigned char *cmd, size_t buflen);
-int oiap(struct tpm1_buf *tb, uint32_t *handle, unsigned char *nonce);
+int oiap(struct tpm_buf *tb, uint32_t *handle, unsigned char *nonce);
 
 #define TPM_DEBUG 0
 
@@ -109,28 +98,4 @@ static inline void dump_tpm_buf(unsigned char *buf)
 {
 }
 #endif
-
-static inline void store8(struct tpm1_buf *buf, const unsigned char value)
-{
-	buf->data[buf->len++] = value;
-}
-
-static inline void store16(struct tpm1_buf *buf, const uint16_t value)
-{
-	*(uint16_t *) & buf->data[buf->len] = htons(value);
-	buf->len += sizeof value;
-}
-
-static inline void store32(struct tpm1_buf *buf, const uint32_t value)
-{
-	*(uint32_t *) & buf->data[buf->len] = htonl(value);
-	buf->len += sizeof value;
-}
-
-static inline void storebytes(struct tpm1_buf *buf, const unsigned char *in,
-			      const int len)
-{
-	memcpy(buf->data + buf->len, in, len);
-	buf->len += len;
-}
 #endif
diff --git a/security/keys/trusted.c b/security/keys/trusted.c
index 0736671..f7134d6 100644
--- a/security/keys/trusted.c
+++ b/security/keys/trusted.c
@@ -395,7 +395,7 @@ static int pcrlock(const int pcrnum)
 /*
  * Create an object specific authorisation protocol (OSAP) session
  */
-static int osap(struct tpm1_buf *tb, struct osapsess *s,
+static int osap(struct tpm_buf *tb, struct osapsess *s,
 		const unsigned char *key, uint16_t type, uint32_t handle)
 {
 	unsigned char enonce[TPM_NONCE_SIZE];
@@ -406,13 +406,10 @@ static int osap(struct tpm1_buf *tb, struct osapsess *s,
 	if (ret != TPM_NONCE_SIZE)
 		return ret;
 
-	INIT_BUF(tb);
-	store16(tb, TPM_TAG_RQU_COMMAND);
-	store32(tb, TPM_OSAP_SIZE);
-	store32(tb, TPM_ORD_OSAP);
-	store16(tb, type);
-	store32(tb, handle);
-	storebytes(tb, ononce, TPM_NONCE_SIZE);
+	tpm_buf_reset(tb, TPM_TAG_RQU_COMMAND, TPM_ORD_OSAP);
+	tpm_buf_append_u16(tb, type);
+	tpm_buf_append_u32(tb, handle);
+	tpm_buf_append(tb, ononce, TPM_NONCE_SIZE);
 
 	ret = trusted_tpm_send(tb->data, MAX_BUF_SIZE);
 	if (ret < 0)
@@ -430,17 +427,14 @@ static int osap(struct tpm1_buf *tb, struct osapsess *s,
 /*
  * Create an object independent authorisation protocol (oiap) session
  */
-int oiap(struct tpm1_buf *tb, uint32_t *handle, unsigned char *nonce)
+int oiap(struct tpm_buf *tb, uint32_t *handle, unsigned char *nonce)
 {
 	int ret;
 
 	if (!chip)
 		return -ENODEV;
 
-	INIT_BUF(tb);
-	store16(tb, TPM_TAG_RQU_COMMAND);
-	store32(tb, TPM_OIAP_SIZE);
-	store32(tb, TPM_ORD_OIAP);
+	tpm_buf_reset(tb, TPM_TAG_RQU_COMMAND, TPM_ORD_OIAP);
 	ret = trusted_tpm_send(tb->data, MAX_BUF_SIZE);
 	if (ret < 0)
 		return ret;
@@ -464,7 +458,7 @@ struct tpm_digests {
  * Have the TPM seal(encrypt) the trusted key, possibly based on
  * Platform Configuration Registers (PCRs). AUTH1 for sealing key.
  */
-static int tpm_seal(struct tpm1_buf *tb, uint16_t keytype,
+static int tpm_seal(struct tpm_buf *tb, uint16_t keytype,
 		    uint32_t keyhandle, const unsigned char *keyauth,
 		    const unsigned char *data, uint32_t datalen,
 		    unsigned char *blob, uint32_t *bloblen,
@@ -535,20 +529,17 @@ static int tpm_seal(struct tpm1_buf *tb, uint16_t keytype,
 		goto out;
 
 	/* build and send the TPM request packet */
-	INIT_BUF(tb);
-	store16(tb, TPM_TAG_RQU_AUTH1_COMMAND);
-	store32(tb, TPM_SEAL_SIZE + pcrinfosize + datalen);
-	store32(tb, TPM_ORD_SEAL);
-	store32(tb, keyhandle);
-	storebytes(tb, td->encauth, SHA1_DIGEST_SIZE);
-	store32(tb, pcrinfosize);
-	storebytes(tb, pcrinfo, pcrinfosize);
-	store32(tb, datalen);
-	storebytes(tb, data, datalen);
-	store32(tb, sess.handle);
-	storebytes(tb, td->nonceodd, TPM_NONCE_SIZE);
-	store8(tb, cont);
-	storebytes(tb, td->pubauth, SHA1_DIGEST_SIZE);
+	tpm_buf_reset(tb, TPM_TAG_RQU_AUTH1_COMMAND, TPM_ORD_SEAL);
+	tpm_buf_append_u32(tb, keyhandle);
+	tpm_buf_append(tb, td->encauth, SHA1_DIGEST_SIZE);
+	tpm_buf_append_u32(tb, pcrinfosize);
+	tpm_buf_append(tb, pcrinfo, pcrinfosize);
+	tpm_buf_append_u32(tb, datalen);
+	tpm_buf_append(tb, data, datalen);
+	tpm_buf_append_u32(tb, sess.handle);
+	tpm_buf_append(tb, td->nonceodd, TPM_NONCE_SIZE);
+	tpm_buf_append_u8(tb, cont);
+	tpm_buf_append(tb, td->pubauth, SHA1_DIGEST_SIZE);
 
 	ret = trusted_tpm_send(tb->data, MAX_BUF_SIZE);
 	if (ret < 0)
@@ -579,7 +570,7 @@ static int tpm_seal(struct tpm1_buf *tb, uint16_t keytype,
 /*
  * use the AUTH2_COMMAND form of unseal, to authorize both key and blob
  */
-static int tpm_unseal(struct tpm1_buf *tb,
+static int tpm_unseal(struct tpm_buf *tb,
 		      uint32_t keyhandle, const unsigned char *keyauth,
 		      const unsigned char *blob, int bloblen,
 		      const unsigned char *blobauth,
@@ -628,20 +619,17 @@ static int tpm_unseal(struct tpm1_buf *tb,
 		return ret;
 
 	/* build and send TPM request packet */
-	INIT_BUF(tb);
-	store16(tb, TPM_TAG_RQU_AUTH2_COMMAND);
-	store32(tb, TPM_UNSEAL_SIZE + bloblen);
-	store32(tb, TPM_ORD_UNSEAL);
-	store32(tb, keyhandle);
-	storebytes(tb, blob, bloblen);
-	store32(tb, authhandle1);
-	storebytes(tb, nonceodd, TPM_NONCE_SIZE);
-	store8(tb, cont);
-	storebytes(tb, authdata1, SHA1_DIGEST_SIZE);
-	store32(tb, authhandle2);
-	storebytes(tb, nonceodd, TPM_NONCE_SIZE);
-	store8(tb, cont);
-	storebytes(tb, authdata2, SHA1_DIGEST_SIZE);
+	tpm_buf_reset(tb, TPM_TAG_RQU_AUTH2_COMMAND, TPM_ORD_UNSEAL);
+	tpm_buf_append_u32(tb, keyhandle);
+	tpm_buf_append(tb, blob, bloblen);
+	tpm_buf_append_u32(tb, authhandle1);
+	tpm_buf_append(tb, nonceodd, TPM_NONCE_SIZE);
+	tpm_buf_append_u8(tb, cont);
+	tpm_buf_append(tb, authdata1, SHA1_DIGEST_SIZE);
+	tpm_buf_append_u32(tb, authhandle2);
+	tpm_buf_append(tb, nonceodd, TPM_NONCE_SIZE);
+	tpm_buf_append_u8(tb, cont);
+	tpm_buf_append(tb, authdata2, SHA1_DIGEST_SIZE);
 
 	ret = trusted_tpm_send(tb->data, MAX_BUF_SIZE);
 	if (ret < 0) {
@@ -670,23 +658,23 @@ static int tpm_unseal(struct tpm1_buf *tb,
 static int key_seal(struct trusted_key_payload *p,
 		    struct trusted_key_options *o)
 {
-	struct tpm1_buf *tb;
+	struct tpm_buf tb;
 	int ret;
 
-	tb = kzalloc(sizeof *tb, GFP_KERNEL);
-	if (!tb)
-		return -ENOMEM;
+	ret = tpm_buf_init(&tb, 0, 0);
+	if (ret)
+		return ret;
 
 	/* include migratable flag at end of sealed key */
 	p->key[p->key_len] = p->migratable;
 
-	ret = tpm_seal(tb, o->keytype, o->keyhandle, o->keyauth,
+	ret = tpm_seal(&tb, o->keytype, o->keyhandle, o->keyauth,
 		       p->key, p->key_len + 1, p->blob, &p->blob_len,
 		       o->blobauth, o->pcrinfo, o->pcrinfo_len);
 	if (ret < 0)
 		pr_info("trusted_key: srkseal failed (%d)\n", ret);
 
-	kzfree(tb);
+	tpm_buf_destroy(&tb);
 	return ret;
 }
 
@@ -696,14 +684,14 @@ static int key_seal(struct trusted_key_payload *p,
 static int key_unseal(struct trusted_key_payload *p,
 		      struct trusted_key_options *o)
 {
-	struct tpm1_buf *tb;
+	struct tpm_buf tb;
 	int ret;
 
-	tb = kzalloc(sizeof *tb, GFP_KERNEL);
-	if (!tb)
-		return -ENOMEM;
+	ret = tpm_buf_init(&tb, 0, 0);
+	if (ret)
+		return ret;
 
-	ret = tpm_unseal(tb, o->keyhandle, o->keyauth, p->blob, p->blob_len,
+	ret = tpm_unseal(&tb, o->keyhandle, o->keyauth, p->blob, p->blob_len,
 			 o->blobauth, p->key, &p->key_len);
 	if (ret < 0)
 		pr_info("trusted_key: srkunseal failed (%d)\n", ret);
@@ -711,7 +699,7 @@ static int key_unseal(struct trusted_key_payload *p,
 		/* pull migratable flag out of sealed key */
 		p->migratable = p->key[--p->key_len];
 
-	kzfree(tb);
+	tpm_buf_destroy(&tb);
 	return ret;
 }
 
-- 
2.7.4

