Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A2F4111AB7B
	for <lists+linux-integrity@lfdr.de>; Wed, 11 Dec 2019 14:02:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729230AbfLKNCh (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 11 Dec 2019 08:02:37 -0500
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:46868 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727402AbfLKNCg (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 11 Dec 2019 08:02:36 -0500
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 0E9F18EE185;
        Wed, 11 Dec 2019 05:02:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1576069356;
        bh=gqwOYEC+dyhnb46SOGwBM02WbPe+46yQCK8G0crsihE=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=mRdee038/dSrQ4LKXnc+CBERR4sDb3pxVUKd2AecRtYNynU3UaZxPw6fW4j/YEg1Y
         X1jMsEW+Rr3M1wKuyMwGkuUQqXlBJ2rCDDkg1lBb6cCsBug/oie9HqLQbG0J7dAU5Y
         PRIE7iKfBIhB/Jom9jtIFzGSYMTYLfbMCbyPE36U=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id k_O_AuNrpY22; Wed, 11 Dec 2019 05:02:35 -0800 (PST)
Received: from [192.168.101.75] (unknown [24.246.103.29])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id A130B8EE0ED;
        Wed, 11 Dec 2019 05:02:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1576069355;
        bh=gqwOYEC+dyhnb46SOGwBM02WbPe+46yQCK8G0crsihE=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=oCtnO6W33QqPqTzV2O0Hjf9oj4pJ+90ARts6sChEYiOMqOZiob+Dqg5ae+8BTP8iH
         uktbUNk4cFvtmish+CtJ3GleciDwhGnRhg+gP7mPwWVuQRfoMNxeJEcCkIuwYRNSaF
         HdxONk6DjLkjTaemW6duRZ9o5vFGp90DEpH3wIRc=
Message-ID: <1576069352.2812.1.camel@HansenPartnership.com>
Subject: Re: [PATCH v2 2/8] lib: add asn.1 encoder
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     David Woodhouse <dwmw2@infradead.org>,
        David Howells <dhowells@redhat.com>
Cc:     linux-integrity@vger.kernel.org, Mimi Zohar <zohar@linux.ibm.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        keyrings@vger.kernel.org
Date:   Wed, 11 Dec 2019 08:02:32 -0500
In-Reply-To: <35B37965-359E-40E0-8F44-836A56EC4756@infradead.org>
References: <1575984010.3459.4.camel@HansenPartnership.com>
         <1575936272.31378.50.camel@HansenPartnership.com>
         <1575936367.31378.52.camel@HansenPartnership.com>
         <932257121039494734d97e290abb9159b1f5ca28.camel@infradead.org>
         <10037.1575986929@warthog.procyon.org.uk>
         <1576004020.3647.13.camel@HansenPartnership.com>
         <35B37965-359E-40E0-8F44-836A56EC4756@infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, 2019-12-10 at 22:37 +0000, David Woodhouse wrote:
> 
> On 10 December 2019 18:53:40 GMT, James Bottomley <James.Bottomley@Ha
> nsenPartnership.com> wrote:
> > On Tue, 2019-12-10 at 14:08 +0000, David Howells wrote:
> > >   Please therefore put bounds checking and error handling in
> > > it.  And
> > > please *don't* just produce broken ASN.1 when something goes
> > > wrong.
> > 
> > OK, I'll make it return an error and add a wrapper for my use case
> > that
> > warns on error and causes the function to bail.
> 
> Traditionally we call that "error handling" :p

This is what I'm thinking (still reworking the rest of the series ... I
found out that AA doesn't habitually have power sockets and my laptop
dying in the middle of a rebase turned out not to be such a good
thing).

James

---

From 7b0c52cf07ca2b8b8ddbe0442a6d3f9de30f7b1b Mon Sep 17 00:00:00 2001
From: James Bottomley <James.Bottomley@HansenPartnership.com>
Date: Wed, 4 Dec 2019 15:19:01 -0800
Subject: [PATCH] lib: add asn.1 encoder

We have a need in the TPM trusted keys to return the ASN.1 form of the
TPM key blob so it can be operated on by tools outside of the kernel.
To do that, we have to be able to read and write the key format.  The
current ASN.1 decoder does fine for reading, but we need pieces of an
ASN.1 encoder to return the key blob.

The current implementation only encodes the ASN.1 bits we actually need.

Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>

---

v2: updated API to use indefinite length, and made symbol exports gpl

diff --git a/include/linux/asn1_encoder.h b/include/linux/asn1_encoder.h
new file mode 100644
index 000000000000..f4afe5ad79a8
--- /dev/null
+++ b/include/linux/asn1_encoder.h
@@ -0,0 +1,24 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+
+#ifndef _LINUX_ASN1_ENCODER_H
+#define _LINUX_ASN1_ENCODER_H
+
+#include <linux/types.h>
+#include <linux/asn1.h>
+#include <linux/asn1_ber_bytecode.h>
+#include <linux/bug.h>
+
+#define asn1_oid_len(oid) (sizeof(oid)/sizeof(u32))
+int asn1_encode_integer(unsigned char **_data, int *data_len,
+			s64 integer);
+int asn1_encode_oid(unsigned char **_data, int *data_len,
+		    u32 oid[], int oid_len);
+int asn1_encode_tag(unsigned char **data, int *data_len, u32 tag,
+		    const unsigned char *string, int len);
+int asn1_encode_octet_string(unsigned char **data, int *data_len,
+			     const unsigned char *string, u32 len);
+int asn1_encode_sequence(unsigned char **data, int *data_len,
+			 const unsigned char *seq, int len);
+int asn1_encode_boolean(unsigned char **data, int *data_len, bool val);
+
+#endif
diff --git a/lib/Makefile b/lib/Makefile
index c2f0e2a4e4e8..515b35f92c3c 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -233,7 +233,7 @@ obj-$(CONFIG_INTERVAL_TREE_TEST) += interval_tree_test.o
 
 obj-$(CONFIG_PERCPU_TEST) += percpu_test.o
 
-obj-$(CONFIG_ASN1) += asn1_decoder.o
+obj-$(CONFIG_ASN1) += asn1_decoder.o asn1_encoder.o
 
 obj-$(CONFIG_FONT_SUPPORT) += fonts/
 
diff --git a/lib/asn1_encoder.c b/lib/asn1_encoder.c
new file mode 100644
index 000000000000..c3c03bad7e6a
--- /dev/null
+++ b/lib/asn1_encoder.c
@@ -0,0 +1,362 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Simple encoder primitives for ASN.1 BER/DER/CER
+ *
+ * Copyright (C) 2019 James.Bottomley@HansenPartnership.com
+ */
+
+#include <linux/asn1_encoder.h>
+#include <linux/bug.h>
+#include <linux/string.h>
+#include <linux/module.h>
+
+/**
+ * asn1_encode_integer - encode positive integer to ASN.1
+ * @_data: pointer to the pointer to the data
+ * @data_len: length of buffer remaining
+ * @integer: integer to be encoded
+ *
+ * This is a simplified encoder: it only currently does
+ * positive integers, but it should be simple enough to add the
+ * negative case if a use comes along.
+ */
+int asn1_encode_integer(unsigned char **_data, int *data_len, s64 integer)
+{
+	unsigned char *data = *_data, *d = &data[2];
+	int i;
+	bool found = false;
+
+	if (WARN(integer < 0,
+		 "BUG: integer encode only supports positive integers"))
+		return -EINVAL;
+
+	if (*data_len < 3)
+		return -EINVAL;
+
+	*data_len -= 2;
+
+	data[0] = _tag(UNIV, PRIM, INT);
+	if (integer == 0) {
+		*d++ = 0;
+		goto out;
+	}
+	for (i = sizeof(integer); i > 0 ; i--) {
+		int byte = integer >> (8*(i-1));
+
+		if (!found && byte == 0)
+			continue;
+		found = true;
+		if (byte & 0x80) {
+			/*
+			 * no check needed here, we already know we
+			 * have len >= 1
+			 */
+			*d++ = 0;
+			(*data_len)--;
+		}
+		if (*data_len == 0)
+			return -EINVAL;
+		*d++ = byte;
+		(*data_len)--;
+	}
+ out:
+	data[1] = d - data - 2;
+	*_data = d;
+	return 0;
+}
+EXPORT_SYMBOL_GPL(asn1_encode_integer);
+
+/* calculate the base 128 digit values setting the top bit of the first octet */
+static int asn1_encode_oid_digit(unsigned char **_data, int *data_len, u32 oid)
+{
+	int start = 7 + 7 + 7 + 7;
+	unsigned char *data = *_data;
+	int ret = 0;
+
+	if (*data_len < 1)
+		return -EINVAL;
+
+	/* quick case */
+	if (oid == 0) {
+		*data++ = 0x80;
+		(*data_len)--;
+		goto out;
+	}
+
+	while (oid >> start == 0)
+		start -= 7;
+
+	while (start > 0 && *data_len > 0) {
+		u8 byte;
+
+		byte = oid >> start;
+		oid = oid - (byte << start);
+		start -= 7;
+		byte |= 0x80;
+		*data++ = byte;
+		(*data_len)--;
+	}
+	if (*data_len > 0) {
+		*data++ = oid;
+		(*data_len)--;
+	} else {
+		ret = -EINVAL;
+	}
+
+ out:
+	*_data = data;
+	return ret;
+}
+
+/**
+ * asn1_encode_oid - encode an oid to ASN.1
+ * @_data: position to begin encoding at
+ * @data_len: remaining bytes in @_data
+ * @oid: array of oids
+ * @oid_len: length of oid array
+ *
+ * this encodes an OID up to ASN.1 when presented as an array of OID values
+ */
+int asn1_encode_oid(unsigned char **_data, int *data_len,
+		    u32 oid[], int oid_len)
+{
+	unsigned char *data = *_data;
+	unsigned char *d = data + 2;
+	int i, ret;
+
+	if (WARN(oid_len < 2, "OID must have at least two elements"))
+		return -EINVAL;
+	if (WARN(oid_len > 32, "OID is too large"))
+		return -EINVAL;
+	if (*data_len < 2)
+		return -EINVAL;
+
+	data[0] = _tag(UNIV, PRIM, OID);
+	*d++ = oid[0] * 40 + oid[1];
+	*data_len -= 2;
+	ret = 0;
+	for (i = 2; i < oid_len; i++) {
+		ret = asn1_encode_oid_digit(&d, data_len, oid[i]);
+		if (ret < 0)
+			return ret;
+	}
+	data[1] = d - data - 2;
+	*_data = d;
+	return ret;
+}
+EXPORT_SYMBOL_GPL(asn1_encode_oid);
+
+static int asn1_encode_length(unsigned char **data, int *data_len, int len)
+{
+	if (*data_len < 1)
+		return -EINVAL;
+	(*data_len)--;
+	if (len < 0) {
+		*((*data)++) = ASN1_INDEFINITE_LENGTH;
+		return 0;
+	}
+	if (*data_len < 1)
+		return -EINVAL;
+	if (len <= 0x7f) {
+		*((*data)++) = len;
+		(*data_len)--;
+		return 0;
+	}
+
+	if (*data_len < 2)
+		return -EINVAL;
+	if (len <= 0xff) {
+		*((*data)++) = 0x81;
+		*((*data)++) = len & 0xff;
+		*data_len -= 2;
+		return 0;
+	}
+	if (*data_len < 3)
+		return -EINVAL;
+	if (len <= 0xffff) {
+		*((*data)++) = 0x82;
+		*((*data)++) = (len >> 8) & 0xff;
+		*((*data)++) = len & 0xff;
+		*data_len -= 3;
+		return 0;
+	}
+
+	if (WARN(len > 0xffffff, "ASN.1 length can't be > 0xffffff"))
+		return -EINVAL;
+
+	if (*data_len < 4)
+		return -EINVAL;
+	*((*data)++) = 0x83;
+	*((*data)++) = (len >> 16) & 0xff;
+	*((*data)++) = (len >> 8) & 0xff;
+	*((*data)++) = len & 0xff;
+	*data_len -= 4;
+
+	return 0;
+}
+
+/**
+ * asn1_encode_tag - add a tag for optional or explicit value
+ * @data: pointer to place tag at
+ * @data_len: remaining size of @data buffer
+ * @tag: tag to be placed
+ * @string: the data to be tagged
+ * @len: the length of the data to be tagged
+ *
+ * Note this currently only handles short form tags < 31.  To encode
+ * in place pass a NULL @string and -1 for @len; all this will do is
+ * add an indefinite length tag and update the data pointer to the
+ * place where the tag contents should be placed.  After the data is
+ * placed, repeat the prior statement but now with the known length.
+ * In order to avoid having to keep both before and after pointers,
+ * the repeat expects to be called with @data pointing to where the
+ * first encode placed it.  For the recode case, set @data_len to NULL
+ */
+int asn1_encode_tag(unsigned char **data, int *data_len, u32 tag,
+		    const unsigned char *string, int len)
+{
+	int ret, dummy_len = 2;
+
+	if (WARN(tag > 30, "ASN.1 tag can't be > 30"))
+		return -EINVAL;
+
+	if (!string && WARN(len > 127,
+			    "BUG: recode tag is too big (>127)"))
+		return -EINVAL;
+
+	if (!string && len > 0) {
+		/*
+		 * we're recoding, so move back to the start of the
+		 * tag and install a dummy length because the real
+		 * data_len should be NULL
+		 */
+		*data -= 2;
+		data_len = &dummy_len;
+	}
+
+	if (*data_len < 2)
+		return -EINVAL;
+
+	*((*data)++) = _tagn(CONT, CONS, tag);
+	(*data_len)--;
+	ret = asn1_encode_length(data, data_len, len);
+	if (ret < 0)
+		return ret;
+	if (!string)
+		return 0;
+	if (*data_len < len)
+		return -EINVAL;
+	memcpy(*data, string, len);
+	*data += len;
+	*data_len -= len;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(asn1_encode_tag);
+
+/**
+ * asn1_encode_octet_string - encode an ASN.1 OCTET STRING
+ * @data: pointer to encode at
+ * @data_len: bytes remaining in @data buffer
+ * @string: string to be encoded
+ * @len: length of string
+ *
+ * Note ASN.1 octet strings may contain zeros, so the length is obligatory.
+ */
+int asn1_encode_octet_string(unsigned char **data, int *data_len,
+			     const unsigned char *string, u32 len)
+{
+	int ret;
+
+	if (*data_len < 2)
+		return -EINVAL;
+
+	*((*data)++) = _tag(UNIV, PRIM, OTS);
+	(*data_len)--;
+	ret = asn1_encode_length(data, data_len, len);
+	if (ret)
+		return ret;
+
+	if (*data_len < len)
+		return -EINVAL;
+
+	memcpy(*data, string, len);
+	*data += len;
+	*data_len -= len;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(asn1_encode_octet_string);
+
+/**
+ * asn1_encode_sequence - wrap a byte stream in an ASN.1 SEQUENCE
+ * @data: pointer to encode at
+ * @data_len: remaining size of @data pointer
+ * @seq: data to be encoded as a sequence
+ * @len: length of the data to be encoded as a sequence
+ *
+ * Fill in a sequence.  To encode in place, pass NULL for @seq and -1
+ * for @len; then call again once the length is known (still with NULL
+ * for @seq). In order to avoid having to keep both before and after
+ * pointers, the repeat expects to be called with @data pointing to
+ * where the first encode placed it.  The recode case should pass NULL
+ * to @data_size
+ */
+int asn1_encode_sequence(unsigned char **data, int *data_len,
+			 const unsigned char *seq, int len)
+{
+	int ret, dummy_len = 2;
+
+	if (!seq && WARN(len > 127,
+			 "BUG: recode sequence is too big (>127)"))
+		return -EINVAL;
+	if (!seq && len >= 0) {
+		/*
+		 * we're recoding, so move back to the start of the
+		 * sequence and install a dummy length because the
+		 * real length should be NULL
+		 */
+		*data -= 2;
+		data_len = &dummy_len;
+	}
+
+	if (*data_len < 2)
+		return -EINVAL;
+
+	*((*data)++) = _tag(UNIV, CONS, SEQ);
+	(*data_len)--;
+	ret = asn1_encode_length(data, data_len, len);
+	if (ret)
+		return ret;
+	if (!seq)
+		return 0;
+
+	if (*data_len < len)
+		return -EINVAL;
+
+	memcpy(*data, seq, len);
+	*data += len;
+	*data_len -= len;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(asn1_encode_sequence);
+
+/**
+ * asn1_encode_boolean - encode a boolean value to ASN.1
+ * @data: pointer to encode at
+ * @data_len: bytes remaining in @data buffer
+ * @val: the boolean true/false value
+ */
+int asn1_encode_boolean(unsigned char **data, int *data_len, bool val)
+{
+	if (*data_len < 2)
+		return -EINVAL;
+	*((*data)++) = _tag(UNIV, PRIM, BOOL);
+	asn1_encode_length(data, data_len, 1);
+	(*data_len)--;
+	*((*data)++) = val ? 1 : 0;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(asn1_encode_boolean);
