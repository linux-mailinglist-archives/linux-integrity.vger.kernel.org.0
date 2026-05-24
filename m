Return-Path: <linux-integrity+bounces-9648-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sNjBBaCJEmqC0gYAu9opvQ
	(envelope-from <linux-integrity+bounces-9648-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Sun, 24 May 2026 07:16:16 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DC2F5C169B
	for <lists+linux-integrity@lfdr.de>; Sun, 24 May 2026 07:16:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 399B1301CCE6
	for <lists+linux-integrity@lfdr.de>; Sun, 24 May 2026 05:15:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56E1F2D238F;
	Sun, 24 May 2026 05:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IR871SuC"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BCDE2EFDAF;
	Sun, 24 May 2026 05:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779599735; cv=none; b=KSymYrDqqLm1CtqISttOjdFUAjEUtFzaNGp63BeSqWtkYX0DX6bt+P38q43+thVzROcXHUGtj1m56G3bMcSoxjcRYVPoAh9cfXIf9xnBkDXE244cT3R6CbHcYxjptLh0hUNsqSc9xqoydGRL63g1zzgwPcxUZJgD1A9oNIhtXLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779599735; c=relaxed/simple;
	bh=YI9qK6UgcZSkpAxrngBlhDn+0JTPk5OJxnEUnm7fFrk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ky0fjaqG+ExWZsLpMQfzV5o7ZSUDr5smbFeb169obhU+72f1c13R8jhcWfnjjlmkUfEDZuc0IV5aHdOF4OIP1w5O+ajmlbgZqJ6nZaamWKIPZ+SX/+GUtNMPT/AzUkRv58rEGtj+xcIoAGh+2ARZjc7z9AjsdF9g3KFPR4uAxOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IR871SuC; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 8439D1F000E9;
	Sun, 24 May 2026 05:15:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779599733;
	bh=FKWO26ho61Nb4Vf1urgGRlJ3443TyMqUwpMqSFotZMw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=IR871SuCM5f+t5BI2O1PgUK8NDo0wZ3e2SoG6JydtbrdujWBZLxeIs5vvTa4KYCAQ
	 eCL4ikWuQMffuBEYS5nfGP78mm1G4tX5PC4KOs2b/i4sPG4SvzmB1Qin2HO1CEXiFs
	 cz9Ky7Xqq22VRLWHLRU/bR/9hzCoKmMD5aB+6i9lUOHJis7qoX2glq/98CzWHZvDvM
	 nhwuhdFGFQj56i4aSQmdjmibFLCaadJBL9pI3bIanrKhyc4cV+pGVTHGfXUhv3hk9j
	 xYOz3fjiyMtTeed7nmxkizkRJh25GgLLVQbDvxWkhKM5PGu8y32+Z2jCOCSCyodL8S
	 1AirmbV1Ew49w==
From: Jarkko Sakkinen <jarkko@kernel.org>
To: keyrings@vger.kernel.org
Cc: David Howells <dhowells@redhat.com>,
	linux-crypto@vger.kernel.org,
	linux-integrity@vger.kernel.org,
	David Woodhouse <dwmw2@infradead.org>,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	Stefan Berger <stefanb@linux.ibm.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	James Bottomley <James.Bottomley@HansenPartnership.com>,
	Mimi Zohar <zohar@linux.ibm.com>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	linux-kernel@vger.kernel.org (open list),
	linux-security-module@vger.kernel.org (open list:SECURITY SUBSYSTEM)
Subject: [PATCH v8 1/3] lib/asn1_encoder: Add asn1_encode_integer_bytes()
Date: Sun, 24 May 2026 08:15:12 +0300
Message-ID: <20260524051519.3708075-2-jarkko@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260524051519.3708075-1-jarkko@kernel.org>
References: <20260524051519.3708075-1-jarkko@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9648-lists,linux-integrity=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jarkko@kernel.org,linux-integrity@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-integrity];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 9DC2F5C169B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add a helper encoding a positive integer from a byte array in big-endian
format.

Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
---
 include/linux/asn1_encoder.h |  3 ++
 lib/asn1_encoder.c           | 62 ++++++++++++++++++++++++++++++++++++
 2 files changed, 65 insertions(+)

diff --git a/include/linux/asn1_encoder.h b/include/linux/asn1_encoder.h
index d17484dffb74..e206bd425854 100644
--- a/include/linux/asn1_encoder.h
+++ b/include/linux/asn1_encoder.h
@@ -12,6 +12,9 @@ unsigned char *
 asn1_encode_integer(unsigned char *data, const unsigned char *end_data,
 		    s64 integer);
 unsigned char *
+asn1_encode_integer_bytes(unsigned char *data, const unsigned char *end_data,
+			  const unsigned char *integer, u32 integer_len);
+unsigned char *
 asn1_encode_oid(unsigned char *data, const unsigned char *end_data,
 		u32 oid[], int oid_len);
 unsigned char *
diff --git a/lib/asn1_encoder.c b/lib/asn1_encoder.c
index 92f35aae13b1..22e0acd6fe08 100644
--- a/lib/asn1_encoder.c
+++ b/lib/asn1_encoder.c
@@ -10,6 +10,8 @@
 #include <linux/string.h>
 #include <linux/module.h>
 
+static int asn1_encode_length(unsigned char **data, int *data_len, int len);
+
 /**
  * asn1_encode_integer() - encode positive integer to ASN.1
  * @data:	pointer to the pointer to the data
@@ -85,6 +87,66 @@ asn1_encode_integer(unsigned char *data, const unsigned char *end_data,
 }
 EXPORT_SYMBOL_GPL(asn1_encode_integer);
 
+/**
+ * asn1_encode_integer_bytes() - encode positive integer bytes to ASN.1
+ * @data:		pointer to the pointer to the data
+ * @end_data:		end of data pointer, points one beyond last usable byte in @data
+ * @bytes:		integer bytes
+ * @bytes_len:		amount of bytes
+ *
+ * Encode a positive integer from a byte array in big-endian format. Strip
+ * leading zeros.
+ */
+unsigned char *
+asn1_encode_integer_bytes(unsigned char *data, const unsigned char *end_data,
+			  const unsigned char *bytes, u32 bytes_len)
+{
+	static const unsigned char zero;
+	int data_len = end_data - data;
+	bool add_pad = false;
+	int ret;
+
+	if (IS_ERR(data))
+		return data;
+
+	if (!bytes || !bytes_len)
+		return ERR_PTR(-EINVAL);
+
+	/* Strip leading zeros: */
+	while (bytes_len > 1 && bytes[0] == 0) {
+		bytes++;
+		bytes_len--;
+	}
+
+	if (!bytes_len) {
+		bytes = &zero;
+		bytes_len = 1;
+	} else {
+		add_pad = bytes[0] & 0x80;
+	}
+
+	if (data_len < 2)
+		return ERR_PTR(-EINVAL);
+
+	*(data++) = _tag(UNIV, PRIM, INT);
+	data_len--;
+
+	ret = asn1_encode_length(&data, &data_len, bytes_len + add_pad);
+	if (ret)
+		return ERR_PTR(ret);
+
+	if (data_len < bytes_len + add_pad)
+		return ERR_PTR(-EINVAL);
+
+	if (add_pad)
+		*(data++) = 0;
+
+	memcpy(data, bytes, bytes_len);
+	data += bytes_len;
+	return data;
+}
+EXPORT_SYMBOL_GPL(asn1_encode_integer_bytes);
+
 /* calculate the base 128 digit values setting the top bit of the first octet */
 static int asn1_encode_oid_digit(unsigned char **_data, int *data_len, u32 oid)
 {
-- 
2.47.3


