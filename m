Return-Path: <linux-integrity+bounces-2590-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F2D88CD8FF
	for <lists+linux-integrity@lfdr.de>; Thu, 23 May 2024 19:08:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8C8D8B22EBF
	for <lists+linux-integrity@lfdr.de>; Thu, 23 May 2024 17:08:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FA5E7E59A;
	Thu, 23 May 2024 17:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="P3p6J5eo";
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="P3p6J5eo"
X-Original-To: linux-integrity@vger.kernel.org
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [96.44.175.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6949376F17;
	Thu, 23 May 2024 17:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.44.175.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716484114; cv=none; b=NOIBrS3kultTWgroqMMW+fCigydXXioKSUMt1F1y2JqiPwSxkIKG0jMXlg+D/nFJ51v1+EgH1bYQ1cAo7tl/MvCChgYz5dBawaNV8Aoq/gAbakzvGcKBXEJGNHah0q6P4DOXwaZg3rGOqZFPnIzT8QNBVhL4ZgCEbkp7F8sA9Y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716484114; c=relaxed/simple;
	bh=KZFKKbZdm+lm8S+PYjUAhSjWvEXA2BCj8ce8gNs6EgI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=e/1v9m4c9tfMiD0rhbsSUdQ/rLGV5FChqWYDKYpFkO4ZfXP+4/AvdVnm5281BsbQyWjhznfVzCzTaHOcYeYbY61XXneT3zAJswX185lseJ2lxGywBZxhOh6iRjOTRyuUSwPCNtUa+bRcBnvJCxD4+dMff6XW25wwvV7pQ+bEiyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com; spf=pass smtp.mailfrom=HansenPartnership.com; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=P3p6J5eo; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=P3p6J5eo; arc=none smtp.client-ip=96.44.175.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=HansenPartnership.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1716484109;
	bh=KZFKKbZdm+lm8S+PYjUAhSjWvEXA2BCj8ce8gNs6EgI=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=P3p6J5eo0+A1Ts/CMbB8H/gN3fXMswLIF8AtaBTmA5o7bZSDyz2k2vizgnnK6+4It
	 6hZXuwiAu1OBJ6B190W38UwTkbXoXxyCSb7/2d8ixRfgfl6vKmFK1cR8v0TiL6p4FS
	 d46jVl1v4VUsFgCIz6ALOWylCNwYf9J7nps93p90=
Received: from localhost (localhost [127.0.0.1])
	by bedivere.hansenpartnership.com (Postfix) with ESMTP id F1D7212872C0;
	Thu, 23 May 2024 13:08:29 -0400 (EDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id tdMngKiMGbsI; Thu, 23 May 2024 13:08:29 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1716484109;
	bh=KZFKKbZdm+lm8S+PYjUAhSjWvEXA2BCj8ce8gNs6EgI=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=P3p6J5eo0+A1Ts/CMbB8H/gN3fXMswLIF8AtaBTmA5o7bZSDyz2k2vizgnnK6+4It
	 6hZXuwiAu1OBJ6B190W38UwTkbXoXxyCSb7/2d8ixRfgfl6vKmFK1cR8v0TiL6p4FS
	 d46jVl1v4VUsFgCIz6ALOWylCNwYf9J7nps93p90=
Received: from lingrow.int.hansenpartnership.com (unknown [IPv6:2601:5c4:4302:c21::a774])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 4E8BD12872BB;
	Thu, 23 May 2024 13:08:28 -0400 (EDT)
Message-ID: <cb7510433c13aaaa9bc64d624331f1a3a958fcf3.camel@HansenPartnership.com>
Subject: Re: [PATCH RESEND] KEYS: trusted: Use ASN.1 encoded OID
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: Jarkko Sakkinen <jarkko@kernel.org>, linux-integrity@vger.kernel.org
Cc: keyrings@vger.kernel.org, David Woodhouse <dwmw2@infradead.org>, Eric
 Biggers <ebiggers@kernel.org>, Herbert Xu <herbert@gondor.apana.org.au>,
 "David S. Miller" <davem@davemloft.net>, Andrew Morton
 <akpm@linux-foundation.org>, Mimi Zohar <zohar@linux.ibm.com>, David
 Howells <dhowells@redhat.com>, Paul Moore <paul@paul-moore.com>, James
 Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, "open
 list:CRYPTO API" <linux-crypto@vger.kernel.org>,  open list
 <linux-kernel@vger.kernel.org>, "open list:SECURITY SUBSYSTEM"
 <linux-security-module@vger.kernel.org>
Date: Thu, 23 May 2024 13:08:26 -0400
In-Reply-To: <9dfeb6e3d568452ab1227484405b1fc221bd25c1.camel@HansenPartnership.com>
References: <20240523131931.22350-1-jarkko@kernel.org>
	 <9c96f39ed2161dd7f0c3a7964cba2de3169fae3b.camel@HansenPartnership.com>
	 <D1H2P674GFY0.3O8WYK2P1GZ2K@kernel.org>
	 <9dfeb6e3d568452ab1227484405b1fc221bd25c1.camel@HansenPartnership.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 2024-05-23 at 11:30 -0400, James Bottomley wrote:
> On Thu, 2024-05-23 at 16:54 +0300, Jarkko Sakkinen wrote:
> > On Thu May 23, 2024 at 4:38 PM EEST, James Bottomley wrote:
> > > On Thu, 2024-05-23 at 16:19 +0300, Jarkko Sakkinen wrote:
> > > > There's no reason to encode OID_TPMSealedData at run-time, as
> > > > it
> > > > never changes.
> > > > 
> > > > Replace it with the encoded version, which has exactly the same
> > > > size:
> > > > 
> > > >         67 81 05 0A 01 05
> > > > 
> > > > Include OBJECT IDENTIFIER (0x06) tag and length as the epilogue
> > > > so
> > > > that the OID can be simply copied to the blob.
> > > 
> > > This is true, but if we're going to do this, we should expand the
> > > OID
> > > registry functions (in lib/oid_registry.c) to do something like
> > > encode_OID.  The registry already contains the hex above minus
> > > the
> > > two
> > > prefixes (which are easy to add).
> > 
> > Yes, I do agree with this idea, and I named variable the I named
> > it to make it obvious that generation is possible.
> > 
> > It would be best to have a single source, which could be just
> > a CSV file with entries like:
> > 
> > <Name>,<OID number>
> > 
> > And then in scripts/ there should be a script that takes this
> > source and generates oid_registry.gen.{h,c}. The existing
> > oid_registry.h should really just include oid_registry.gen.h
> > then to make this transparent change.
> > 
> > And then in the series where OID's are encoded per-subsystem
> > patch that takes pre-encoded OID into use.
> > 
> > Happy to review such patch set if it is pushed forward.
> 
> Heh, OK, since I'm the one who thinks it's quite easy, I'll give it a
> go.

Turns out it's actually really simple.  This would go as three patches:
adding the feature to lib/oid_registry.c using it in trusted keys and
removing the now unused OID encode from lib/asn1_encode.c but I'm
attaching here (minus the removal) to give an idea.

James

---

diff --git a/include/linux/oid_registry.h b/include/linux/oid_registry.h
index 51421fdbb0ba..87a6bcb2f5c0 100644
--- a/include/linux/oid_registry.h
+++ b/include/linux/oid_registry.h
@@ -151,5 +151,6 @@ extern enum OID look_up_OID(const void *data, size_t datasize);
 extern int parse_OID(const void *data, size_t datasize, enum OID *oid);
 extern int sprint_oid(const void *, size_t, char *, size_t);
 extern int sprint_OID(enum OID, char *, size_t);
+extern ssize_t encode_OID(enum OID, u8 *, size_t);
 
 #endif /* _LINUX_OID_REGISTRY_H */
diff --git a/lib/oid_registry.c b/lib/oid_registry.c
index fe6705cfd780..45f97e1e0f91 100644
--- a/lib/oid_registry.c
+++ b/lib/oid_registry.c
@@ -12,6 +12,7 @@
 #include <linux/errno.h>
 #include <linux/bug.h>
 #include <linux/asn1.h>
+#include <linux/asn1_ber_bytecode.h>
 #include "oid_registry_data.c"
 
 MODULE_DESCRIPTION("OID Registry");
@@ -196,3 +197,31 @@ int sprint_OID(enum OID oid, char *buffer, size_t bufsize)
 	return ret;
 }
 EXPORT_SYMBOL_GPL(sprint_OID);
+
+/**
+ * encode_OID - embed an ASN.1 encoded OID in the provide buffer
+ * @oid: The OID to encode
+ * @buffer: The buffer to encode to
+ * @bufsize: the maximum size of the buffer
+ *
+ * Returns: negative error or encoded size in the buffer.
+ */
+ssize_t encode_OID(enum OID oid, u8 *buffer, size_t bufsize)
+{
+	int oid_size;
+
+	BUG_ON(oid >= OID__NR);
+
+	oid_size = oid_index[oid + 1] - oid_index[oid];
+
+	if (bufsize < oid_size + 2)
+		return -EINVAL;
+
+	buffer[0] = _tag(UNIV, PRIM, OID);
+	buffer[1] = oid_size;
+
+	memcpy(&buffer[2], &oid_data[oid_index[oid]], oid_size);
+
+	return oid_size;
+}
+EXPORT_SYMBOL_GPL(encode_OID);
diff --git a/security/keys/trusted-keys/trusted_tpm2.c b/security/keys/trusted-keys/trusted_tpm2.c
index 9c7ac2e423d3..b6f34ff0ca5c 100644
--- a/security/keys/trusted-keys/trusted_tpm2.c
+++ b/security/keys/trusted-keys/trusted_tpm2.c
@@ -19,8 +19,6 @@
 #include "tpm2key.asn1.h"
 #include "tpm2-policy.h"
 
-static u32 tpm2key_oid[] = { 2, 23, 133, 10, 1, 5 };
-
 static int tpm2_key_encode(struct trusted_key_payload *payload,
 			   struct trusted_key_options *options,
 			   u8 *src, u32 len)
@@ -31,6 +29,7 @@ static int tpm2_key_encode(struct trusted_key_payload *payload,
 	u8 *end_work = scratch + SCRATCH_SIZE;
 	u8 *priv, *pub;
 	u16 priv_len, pub_len;
+	int ret;
 
 	priv_len = get_unaligned_be16(src) + 2;
 	priv = src;
@@ -43,8 +42,10 @@ static int tpm2_key_encode(struct trusted_key_payload *payload,
 	if (!scratch)
 		return -ENOMEM;
 
-	work = asn1_encode_oid(work, end_work, tpm2key_oid,
-			       asn1_oid_len(tpm2key_oid));
+	ret = encode_OID(OID_TPMSealedData, work, end_work - work);
+	if (ret < 0)
+		return ret;
+	work += ret;
 
 	if (options->blobauth_len == 0) {
 		unsigned char bool[3], *w = bool;


