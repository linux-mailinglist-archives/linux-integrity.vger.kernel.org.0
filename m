Return-Path: <linux-integrity+bounces-1177-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59F5F853723
	for <lists+linux-integrity@lfdr.de>; Tue, 13 Feb 2024 18:20:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AC44EB23181
	for <lists+linux-integrity@lfdr.de>; Tue, 13 Feb 2024 17:20:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C92F5FDD6;
	Tue, 13 Feb 2024 17:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="UBOEyUH0"
X-Original-To: linux-integrity@vger.kernel.org
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [96.44.175.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B401B5FDB7;
	Tue, 13 Feb 2024 17:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.44.175.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707844821; cv=none; b=CJYFcitps0kQGzbmgH8Qu0sr1vWcQ0mLYJ8lHZCUlgRxftuqCMgOSuXXJf5IUQHi+339IdsOpPTAQniwuLZ30Cl9+3FSHLybXXCn4aye1Va5OeGe/Y9VkpBSv7INQ1NYGhFJwbD+SCFZde7vhficJyarDORaA6noyMiXB96qRHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707844821; c=relaxed/simple;
	bh=n9YvRsnnNJb/4lPCcMJ3MIw+1+rEr0i+MpcxxItUWFg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=io1hTpHOzzGeZv91JAYOwZPvCRyIA4DTio/U0c7OMRAZp2aOgS4SJ5qAghRvUi3TfpaIXf377URfUrXIJwRTKt65epGs31DbHO/o2FkGaL0KX1OtAjzB9Zt2LjImhnNRynqZgug7Ubc+jhIKGWuYSgTIWQ6UaYaRgNfDuAvwlD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com; spf=pass smtp.mailfrom=HansenPartnership.com; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=UBOEyUH0; arc=none smtp.client-ip=96.44.175.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=HansenPartnership.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1707844819;
	bh=n9YvRsnnNJb/4lPCcMJ3MIw+1+rEr0i+MpcxxItUWFg=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:From;
	b=UBOEyUH0HT+oUZukJOCAkpgT40p94kGFWAU0VP8Ge3+WXwmFf7syZWNKoeomQqY75
	 2h4PL6wIY/KQGSLxbB+bRUvACFwxwyS/WsEKfS5oVs17woojf4RFHUb1/pLyU7E8nx
	 4i9wSbNpir34aCi5GvbREsJ9oib2H7giTFDppHtY=
Received: from localhost (localhost [127.0.0.1])
	by bedivere.hansenpartnership.com (Postfix) with ESMTP id 1A2511280D89;
	Tue, 13 Feb 2024 12:20:19 -0500 (EST)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id IvNl8VmaethV; Tue, 13 Feb 2024 12:20:19 -0500 (EST)
Received: from lingrow.int.hansenpartnership.com (unknown [153.66.160.227])
	by bedivere.hansenpartnership.com (Postfix) with ESMTP id 5EC421280CB7;
	Tue, 13 Feb 2024 12:20:18 -0500 (EST)
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: linux-integrity@vger.kernel.org
Cc: Jarkko Sakkinen <jarkko@kernel.org>,
	keyrings@vger.kernel.org,
	Ard Biesheuvel <ardb@kernel.org>
Subject: [PATCH v7 14/21] tpm: Add HMAC session name/handle append
Date: Tue, 13 Feb 2024 12:13:27 -0500
Message-Id: <20240213171334.30479-15-James.Bottomley@HansenPartnership.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240213171334.30479-1-James.Bottomley@HansenPartnership.com>
References: <20240213171334.30479-1-James.Bottomley@HansenPartnership.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add tpm2_append_name() for appending to the handle area of the TPM
command.  When TPM_BUS_SECURITY is enabled and HMAC sessions are in
use this adds the standard u32 handle to the buffer but additionally
records the name of the object which must be used as part of the HMAC
computation.  The name of certain object types (volatile and permanent
handles and NV indexes) is a hash of the public area of the object.
Since this hash is not known ahead of time, it must be requested from
the TPM using TPM2_ReadPublic() (which cannot be HMAC protected, but
if an interposer lies about it, the HMAC check will fail and the
problem will be detected).

Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>
Reviewed-by: Ard Biesheuvel <ard.biesheuvel@linaro.org> # crypto API parts

---

v6: split into new patch, update config variable
v7: add tpm2_ prefix
---
 drivers/char/tpm/tpm2-sessions.c | 121 +++++++++++++++++++++++++++++++
 include/linux/tpm.h              |  26 +++++++
 2 files changed, 147 insertions(+)

diff --git a/drivers/char/tpm/tpm2-sessions.c b/drivers/char/tpm/tpm2-sessions.c
index c8792a6b8bd4..9eb420d8e530 100644
--- a/drivers/char/tpm/tpm2-sessions.c
+++ b/drivers/char/tpm/tpm2-sessions.c
@@ -49,6 +49,11 @@
  *	Under normal operation this function is done by
  *	tpm_buf_check_hmac_response(), so this is only to be used on
  *	error legs where the latter is not executed.
+ * tpm_buf_append_name() to add a handle to the buffer.  This must be
+ *	used in place of the usual tpm_buf_append_u32() for adding
+ *	handles because handles have to be processed specially when
+ *	calculating the HMAC.  In particular, for NV, volatile and
+ *	permanent objects you now need to provide the name.
  */
 
 #include "tpm.h"
@@ -106,8 +111,26 @@ struct tpm2_auth {
 		u8 scratch[AES_KEYBYTES + AES_BLOCK_SIZE];
 	};
 	u8 session_key[SHA256_DIGEST_SIZE];
+	/* 3 names of handles: name_h is handle, name is name of handle */
+	u32 name_h[AUTH_MAX_NAMES];
+	u8 name[AUTH_MAX_NAMES][2 + SHA512_DIGEST_SIZE];
 };
 
+/*
+ * Name Size based on TPM algorithm (assumes no hash bigger than 255)
+ */
+static u8 name_size(const u8 *name)
+{
+	static u8 size_map[] = {
+		[TPM_ALG_SHA1] = SHA1_DIGEST_SIZE,
+		[TPM_ALG_SHA256] = SHA256_DIGEST_SIZE,
+		[TPM_ALG_SHA384] = SHA384_DIGEST_SIZE,
+		[TPM_ALG_SHA512] = SHA512_DIGEST_SIZE,
+	};
+	u16 alg = get_unaligned_be16(name);
+	return size_map[alg] + 2;
+}
+
 /*
  * It turns out the crypto hmac(sha256) is hard for us to consume
  * because it assumes a fixed key and the TPM seems to change the key
@@ -282,6 +305,104 @@ static void tpm_buf_append_salt(struct tpm_buf *buf, struct tpm_chip *chip)
  out:
 	crypto_free_kpp(kpp);
 }
+
+static int tpm2_parse_read_public(char *name, struct tpm_buf *buf)
+{
+	struct tpm_header *head = (struct tpm_header *)buf->data;
+	off_t offset = TPM_HEADER_SIZE;
+	u32 tot_len = be32_to_cpu(head->length);
+	u32 val;
+
+	/* we're starting after the header so adjust the length */
+	tot_len -= TPM_HEADER_SIZE;
+
+	/* skip public */
+	val = tpm_buf_read_u16(buf, &offset);
+	if (val > tot_len)
+		return -EINVAL;
+	offset += val;
+	/* name */
+	val = tpm_buf_read_u16(buf, &offset);
+	if (val != name_size(&buf->data[offset]))
+		return -EINVAL;
+	memcpy(name, &buf->data[offset], val);
+	/* forget the rest */
+	return 0;
+}
+
+static int tpm2_readpublic(struct tpm_chip *chip, u32 handle, char *name)
+{
+	struct tpm_buf buf;
+	int rc;
+
+	rc = tpm_buf_init(&buf, TPM2_ST_NO_SESSIONS, TPM2_CC_READ_PUBLIC);
+	if (rc)
+		return rc;
+
+	tpm_buf_append_u32(&buf, handle);
+	rc = tpm_transmit_cmd(chip, &buf, 0, "read public");
+	if (rc == TPM2_RC_SUCCESS)
+		rc = tpm2_parse_read_public(name, &buf);
+
+	tpm_buf_destroy(&buf);
+
+	return rc;
+}
+
+/**
+ * tpm_buf_append_name() - add a handle area to the buffer
+ * @chip: the TPM chip structure
+ * @buf: The buffer to be appended
+ * @handle: The handle to be appended
+ * @name: The name of the handle (may be NULL)
+ *
+ * In order to compute session HMACs, we need to know the names of the
+ * objects pointed to by the handles.  For most objects, this is simly
+ * the actual 4 byte handle or an empty buf (in these cases @name
+ * should be NULL) but for volatile objects, permanent objects and NV
+ * areas, the name is defined as the hash (according to the name
+ * algorithm which should be set to sha256) of the public area to
+ * which the two byte algorithm id has been appended.  For these
+ * objects, the @name pointer should point to this.  If a name is
+ * required but @name is NULL, then TPM2_ReadPublic() will be called
+ * on the handle to obtain the name.
+ *
+ * As with most tpm_buf operations, success is assumed because failure
+ * will be caused by an incorrect programming model and indicated by a
+ * kernel message.
+ */
+void tpm_buf_append_name(struct tpm_chip *chip, struct tpm_buf *buf,
+			 u32 handle, u8 *name)
+{
+	int slot;
+	enum tpm2_mso_type mso = tpm2_handle_mso(handle);
+	struct tpm2_auth *auth = chip->auth;
+
+	slot = (tpm_buf_length(buf) - TPM_HEADER_SIZE)/4;
+	if (slot >= AUTH_MAX_NAMES) {
+		dev_err(&chip->dev, "TPM: too many handles\n");
+		return;
+	}
+	WARN(auth->session != tpm_buf_length(buf),
+	     "name added in wrong place\n");
+	tpm_buf_append_u32(buf, handle);
+	auth->session += 4;
+
+	if (mso == TPM2_MSO_PERSISTENT ||
+	    mso == TPM2_MSO_VOLATILE ||
+	    mso == TPM2_MSO_NVRAM) {
+		if (!name)
+			tpm2_readpublic(chip, handle, auth->name[slot]);
+	} else {
+		if (name)
+			dev_err(&chip->dev, "TPM: Handle does not require name but one is specified\n");
+	}
+
+	auth->name_h[slot] = handle;
+	if (name)
+		memcpy(auth->name[slot], name, name_size(name));
+}
+EXPORT_SYMBOL(tpm_buf_append_name);
 /**
  * tpm2_end_auth_session() - kill the allocated auth session
  * @chip: the TPM chip structure
diff --git a/include/linux/tpm.h b/include/linux/tpm.h
index 444f0a83682a..9b0b0d3c0d62 100644
--- a/include/linux/tpm.h
+++ b/include/linux/tpm.h
@@ -271,6 +271,7 @@ enum tpm2_command_codes {
 	TPM2_CC_CONTEXT_LOAD	        = 0x0161,
 	TPM2_CC_CONTEXT_SAVE	        = 0x0162,
 	TPM2_CC_FLUSH_CONTEXT	        = 0x0165,
+	TPM2_CC_READ_PUBLIC		= 0x0173,
 	TPM2_CC_START_AUTH_SESS		= 0x0176,
 	TPM2_CC_VERIFY_SIGNATURE        = 0x0177,
 	TPM2_CC_GET_CAPABILITY	        = 0x017A,
@@ -288,6 +289,21 @@ enum tpm2_permanent_handles {
 	TPM2_RS_PW		= 0x40000009,
 };
 
+/* Most Significant Octet for key types  */
+enum tpm2_mso_type {
+	TPM2_MSO_NVRAM		= 0x01,
+	TPM2_MSO_SESSION	= 0x02,
+	TPM2_MSO_POLICY		= 0x03,
+	TPM2_MSO_PERMANENT	= 0x40,
+	TPM2_MSO_VOLATILE	= 0x80,
+	TPM2_MSO_PERSISTENT	= 0x81,
+};
+
+static inline enum tpm2_mso_type tpm2_handle_mso(u32 handle)
+{
+	return handle >> 24;
+}
+
 enum tpm2_capabilities {
 	TPM2_CAP_HANDLES	= 1,
 	TPM2_CAP_COMMANDS	= 2,
@@ -472,6 +488,8 @@ static inline void tpm_buf_append_empty_auth(struct tpm_buf *buf, u32 handle)
 #ifdef CONFIG_TCG_TPM2_HMAC
 
 int tpm2_start_auth_session(struct tpm_chip *chip);
+void tpm_buf_append_name(struct tpm_chip *chip, struct tpm_buf *buf,
+			 u32 handle, u8 *name);
 void tpm2_end_auth_session(struct tpm_chip *chip);
 #else
 static inline int tpm2_start_auth_session(struct tpm_chip *chip)
@@ -481,6 +499,14 @@ static inline int tpm2_start_auth_session(struct tpm_chip *chip)
 static inline void tpm2_end_auth_session(struct tpm_chip *chip)
 {
 }
+static inline void tpm_buf_append_name(struct tpm_chip *chip,
+				       struct tpm_buf *buf,
+				       u32 handle, u8 *name)
+{
+	tpm_buf_append_u32(buf, handle);
+	/* count the number of handles in the upper bits of flags */
+	buf->handles++;
+}
 #endif	/* CONFIG_TCG_TPM2_HMAC */
 
 #endif
-- 
2.35.3


