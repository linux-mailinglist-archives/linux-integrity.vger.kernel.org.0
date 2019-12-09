Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EB17E1170D1
	for <lists+linux-integrity@lfdr.de>; Mon,  9 Dec 2019 16:46:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726335AbfLIPqP (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 9 Dec 2019 10:46:15 -0500
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:57126 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726290AbfLIPqP (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 9 Dec 2019 10:46:15 -0500
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id B9A658EE112;
        Mon,  9 Dec 2019 07:46:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1575906374;
        bh=G+/1aTvEuLQtscgA18GvV50TxH1WHORzgvA2ENnV94I=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=mDa8L/zXRFrjsczrhe+4ZgVvQx9PRauTfkMN9LjDHErZBRb5d/3ZORRhcpqyGWwkB
         dWAG/9ZRnj8px5z4KPXYs1+ok+hxj7SwlO7JTSugf4MOCP5n3SpF5PIBS/S7LjJMAt
         UcGp+V/p6pfWYXJwGjr4jB5pUIQIqtr+zc+KxPHI=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id C0GHa8IOMP17; Mon,  9 Dec 2019 07:46:14 -0800 (PST)
Received: from jarvis.lan (unknown [50.35.76.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 2FD338EE0FC;
        Mon,  9 Dec 2019 07:46:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1575906374;
        bh=G+/1aTvEuLQtscgA18GvV50TxH1WHORzgvA2ENnV94I=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=mDa8L/zXRFrjsczrhe+4ZgVvQx9PRauTfkMN9LjDHErZBRb5d/3ZORRhcpqyGWwkB
         dWAG/9ZRnj8px5z4KPXYs1+ok+hxj7SwlO7JTSugf4MOCP5n3SpF5PIBS/S7LjJMAt
         UcGp+V/p6pfWYXJwGjr4jB5pUIQIqtr+zc+KxPHI=
Message-ID: <1575906372.3340.14.camel@HansenPartnership.com>
Subject: Re: [PATCH 2/8] lib: add asn.1 encoder
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     David Woodhouse <dwmw2@infradead.org>,
        linux-integrity@vger.kernel.org
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        David Howells <dhowells@redhat.com>
Date:   Mon, 09 Dec 2019 07:46:12 -0800
In-Reply-To: <8391d7c97e2897ec7e0ba2a30de272f7a0dd1ec3.camel@infradead.org>
References: <1575781600.14069.8.camel@HansenPartnership.com>
         <1575781706.14069.10.camel@HansenPartnership.com>
         <8391d7c97e2897ec7e0ba2a30de272f7a0dd1ec3.camel@infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, 2019-12-09 at 08:50 +0000, David Woodhouse wrote:
> On Sat, 2019-12-07 at 21:08 -0800, James Bottomley wrote:
> > +/**
> > + * asn1_encode_integer - encode positive integer to ASN.1
> > + * @_data: pointer to the pointer to the data
> > + * @integer: integer to be encoded
> > + *
> > + * This is a simplified encoder: since we know the integer is
> > + * positive we don't have to bother with twos complement and since
> > we
> > + * know the largest integer is a u64, we know the max length is 8.
> > + */
> > +void asn1_encode_integer(unsigned char **_data, u64 integer)
> > +{
> > +	unsigned char *data = *_data, *d = &data[2];
> > +	int i;
> > +	bool found = false;
> > +
> > +	data[0] = _tag(UNIV, PRIM, INT);
> > +	if (integer == 0) {
> > +		*d++ = 0;
> > +		goto out;
> > +	}
> > +	for (i = sizeof(integer); i > 0 ; i--) {
> > +		int byte = integer >> (8*(i-1));
> > +
> > +		if (!found && byte == 0)
> > +			continue;
> > +		found = true;
> > +		if (byte & 0x80)
> > +			*d++ = 0;
> > +		*d++ = byte;
> > +	}
> > + out:
> > +	data[1] = d - data - 2;
> > +	*_data = d;
> > +}
> 
> I'd be a lot happier to see a 'buffer length' argument here. This API
> is just one accidental u64 underflow away from a caller which "knows"
> its <128 integer is only three bytes long, actually taking eleven and
> overflowing its buffer. Especially since  you are actively
> encouraging people to create fragments on the stack and then assemble
> them into SEQUENCES later (qv¹).

OK, I'll add a length argument.

> Also: is documenting it as taking a 'positive integer' enough? Making
> that explicit in the function name might be more likely to prevent
> future users from assuming i actually encodes an arbitrary INTEGER.

Well, I have no use case for a signed integer at the moment, but it
shouldn't be too hard to add, so if that use case came along someone
could fill in the code ... it just involves stripping off leading
0xff's.

How about I make the input an s64 and return EINVAL on negative?  That
way the API is ready for the negative case.

> > +static void asn1_encode_definite_length(unsigned char **data, u32
> > len)
> > +{
> > +	if (len <= 0x7f) {
> > +		*((*data)++) = len;
> > +		return;
> > +	}
> > +	if (len <= 0xff) {
> > +		*((*data)++) = 0x81;
> > +		*((*data)++) = len & 0xff;
> > +		return;
> > +	}
> > +	if (len <= 0xffff) {
> > +		*((*data)++) = 0x82;
> > +		*((*data)++) = (len >> 8) & 0xff;
> > +		*((*data)++) = len & 0xff;
> > +		return;
> > +	}
> > +
> > +	if (WARN(len > 0xffffff, "ASN.1 length can't be >
> > 0xffffff"))
> > +		return;
> > +
> > +	*((*data)++) = 0x83;
> > +	*((*data)++) = (len >> 16) & 0xff;
> > +	*((*data)++) = (len >> 8) & 0xff;
> > +	*((*data)++) = len & 0xff;
> > +}
> 
> (¹)
> 
> That's nice when you know the length in advance. Less so when you
> don't, because you have to either calculate it first or actually
> create
> the whole of the content in a separate buffer and copy it around.
> 
> It would be useful to permit sequences with indeterminate length. You
> could even return a pointer which allows them to be changed to
> definite
> length if they are <128 bytes at the end.
> 
> I note that later in this series in tpm2_encode_policy() you are
> eschewing your own API for this, and doing just what I said above —
> going back and filling in the length later.

Yes, that bit bothers me.  I'll fix it to do indefinite followed by
updateable sequence lengths and the same for the tag code.

James


> > +/**
> > + * asn1_encode_tag - add a tag for optional or explicit value
> > + * @data: pointer to place tag at
> > + * @tag: tag to be placed
> > + * @string: the data to be tagged
> > + * @len: the length of the data to be tagged
> > + *
> > + * Note this currently only handles short form tags < 31
> > + */
> > +void asn1_encode_tag(unsigned char **data, u32 tag,
> > +		     const unsigned char *string, u32 len)
> > +{
> > +	if (WARN(tag > 30, "ASN.1 tag can't be > 30"))
> > +		return;
> > +
> > +	*((*data)++) = _tagn(CONT, CONS, tag);
> > +	asn1_encode_definite_length(data, len);
> > +	memcpy(*data, string, len);
> > +	*data += len;
> > +}
> > +EXPORT_SYMBOL(asn1_encode_tag);
> 
> EXPORT_SYMBOL() again when everything else here uses
> EXPORT_SYMBOL_GPL().
> 
> 

