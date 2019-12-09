Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 94B071171AE
	for <lists+linux-integrity@lfdr.de>; Mon,  9 Dec 2019 17:32:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726532AbfLIQcB (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 9 Dec 2019 11:32:01 -0500
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:57782 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725904AbfLIQcB (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 9 Dec 2019 11:32:01 -0500
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 1D6228EE112;
        Mon,  9 Dec 2019 08:32:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1575909121;
        bh=jV8jXjxVTfsUpD+smPNt+I0g87/EI9xN41Hmtqo7AfA=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=PpjV9DBiMatJYqJj7yMbxj4YxUUpv0LY2tC2nfS6mG53IRWqx/hMzMF5Wb8EY9Rcd
         tur7l+5MjcfnqVLd4iKV9NUw46p5ZS1XVClF82bXLEuH97HWH+c1Pe0urDjA0Ld6B8
         WD3KXJ+18lS3e/HNgkddO+V3lfhK7q2YVLYp9beY=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id aaoCMFW3icl8; Mon,  9 Dec 2019 08:32:00 -0800 (PST)
Received: from jarvis.lan (unknown [50.35.76.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 906C88EE0FC;
        Mon,  9 Dec 2019 08:32:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1575909120;
        bh=jV8jXjxVTfsUpD+smPNt+I0g87/EI9xN41Hmtqo7AfA=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=Tpcf/xVybPSsKgHaZNGJQtqrW4CQMdnDnRfU5yXEOyaCTsxbEeajw9we50fmMr6OX
         OeRqb+cAFSEp/beYrOu1uwZXsQmYrlPd4057WJGXmU8rLT7tjF1K2nR4BbDS/XOz3e
         lIkuYNvtvSVSybGDkEynsAlUQezeH3YyU6uapMeA=
Message-ID: <1575909119.3340.27.camel@HansenPartnership.com>
Subject: Re: [PATCH 4/8] security: keys: trusted: use ASN.1 tpm2 key format
 for the blobs
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     David Woodhouse <dwmw2@infradead.org>,
        linux-integrity@vger.kernel.org,
        David Howells <dhowells@redhat.com>
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Date:   Mon, 09 Dec 2019 08:31:59 -0800
In-Reply-To: <3b035027b934eb253143dca66ebae4356b386efe.camel@infradead.org>
References: <1575781600.14069.8.camel@HansenPartnership.com>
         <1575781831.14069.13.camel@HansenPartnership.com>
         <3b035027b934eb253143dca66ebae4356b386efe.camel@infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, 2019-12-09 at 10:04 +0000, David Woodhouse wrote:
> On Sat, 2019-12-07 at 21:10 -0800, James Bottomley wrote:
> > Modify the tpm2 key format blob output to export and import in the
> > ASN.1 form for tpm2 sealed object keys.  For compatibility with
> > prior trusted keys, the importer will also accept two tpm2b
> > quantities representing the public and private parts of the
> > key.  However, the export via keyctl pipe will only output the
> > ASN.1 format.
> 
> You still have a tpm2_key_encode() function which spits out the raw
> private/public blobs each prefixed with a length word. What's that
> still used for?

It's the TPM2B format for input of the keys to the TPM.

> > The benefit of the ASN.1 format is that it's a standard
> 
> We should probably make that true. Did we even get as far as writing
> up an RFC-style description of the ASN.1? 

No ... I was going to ask you if you'd made a start.  I take it linux-
integrity is as good a list as any to begin this on.  I'll cc the
openssl_tpm2_engine list ... are there any others?

> >  and thus the
> > exported key can be used by userspace tools.  The format includes
> > policy specifications, thus it gets us out of having to construct
> > policy handles in userspace and the format includes the parent
> > meaning you don't have to keep passing it in each time.
> > 
> > This patch only implements basic handling for the ASN.1 format, so
> > keys with passwords but no policy.
> 
> ... but doesn't bail out with an error when it sees something it
> doesn't yet understand? Including the 'secret' field which is only
> relevant for importable keys, etc.

I hadn't actually got around to defining importable blobs ... but I
think keeping the same OID and adding the shared import secret in [2]
would be good enough?  In which case the TPM will error out for us
because it won't be able to unwrap the private blob.  If keyctl were
capable of returning information about the source of the problem it
might be worth checking, but while it can't, I think getting -EINVAL
from the TPM is as good as putting a check returning -EINVAL.

> > Signed-off-by: James Bottomley
> > <James.Bottomley@HansenPartnership.com>
> > ---
> >  security/keys/trusted-keys/Makefile       |   2 +-
> >  security/keys/trusted-keys/tpm2key.asn1   |  23 ++++
> >  security/keys/trusted-keys/trusted_tpm1.c |   2 +-
> >  security/keys/trusted-keys/trusted_tpm2.c | 170
> > +++++++++++++++++++++++++++++-
> >  4 files changed, 190 insertions(+), 7 deletions(-)
> >  create mode 100644 security/keys/trusted-keys/tpm2key.asn1
> > 
> > diff --git a/security/keys/trusted-keys/Makefile
> > b/security/keys/trusted-keys/Makefile
> > index 7b73cebbb378..e0198641eff2 100644
> > --- a/security/keys/trusted-keys/Makefile
> > +++ b/security/keys/trusted-keys/Makefile
> > @@ -5,4 +5,4 @@
> >  
> >  obj-$(CONFIG_TRUSTED_KEYS) += trusted.o
> >  trusted-y += trusted_tpm1.o
> > -trusted-y += trusted_tpm2.o
> > +trusted-y += trusted_tpm2.o tpm2key.asn1.o
> > diff --git a/security/keys/trusted-keys/tpm2key.asn1
> > b/security/keys/trusted-keys/tpm2key.asn1
> > new file mode 100644
> > index 000000000000..1851b7c80f08
> > --- /dev/null
> > +++ b/security/keys/trusted-keys/tpm2key.asn1
> > @@ -0,0 +1,23 @@
> > +---
> > +--- Note: This isn't quite the definition in the standard
> > +---       However, the Linux asn.1 parser doesn't understand
> > +---       [2] EXPLICIT SEQUENCE OF OPTIONAL
> > +---       So there's an extra intermediate TPMPolicySequence
> > +---       definition to work around this
> 
> At the very least we should prod David with a pointy stick on that
> topic, rather than quietly working around it.

OK, I'll add him to the cc list on this one.

[...]
> > +static int tpm2_key_encode(struct trusted_key_payload *payload,
> > +			   struct trusted_key_options *options,
> > +			   u8 *src, u32 len)
> > +{
> > +	u8 *scratch = kmalloc(PAGE_SIZE, GFP_KERNEL);
> > +	u8 *work = scratch, *work1;
> > +	u8 *priv, *pub;
> > +	u16 priv_len, pub_len;
> > +
> > +	priv_len = get_unaligned_be16(src);
> > +	src += 2;
> > +	priv = src;
> > +	src += priv_len;
> > +	pub_len = get_unaligned_be16(src);
> > +	src += 2;
> > +	pub = src;
> > +
> > +	if (!scratch)
> > +		return -ENOMEM;
> > +
> > +	asn1_encode_oid(&work, tpm2key_oid,
> > asn1_oid_len(tpm2key_oid));
> > +	if (options->blobauth[0] == 0) {
> > +		unsigned char bool[3], *w = bool;
> > +		/* tag 0 is emptyAuth */
> > +		asn1_encode_boolean(&w, true);
> > +		asn1_encode_tag(&work, 0, bool, w - bool);
> > +	}
> > +	asn1_encode_integer(&work, options->keyhandle);
> > +	asn1_encode_octet_string(&work, pub, pub_len);
> > +	asn1_encode_octet_string(&work, priv, priv_len);
> > +
> > +	work1 = payload->blob;
> > +	asn1_encode_sequence(&work1, scratch, work - scratch);
> > +
> > +	return work1 - payload->blob;
> > +}
> 
> I still don't like the lack of overflow protection here, one layer up
> from the underlying encoding APIs I already commented on.

Fixed.

> > +struct tpm2key_context {
> > +	u32 parent;
> > +	const u8 *pub;
> > +	u32 pub_len;
> > +	const u8 *priv;
> > +	u32 priv_len;
> > +};
> > +
> > +static int tpm2_key_decode(struct trusted_key_payload *payload,
> > +			   struct trusted_key_options *options,
> > +			   u8 **buf)
> > +{
> > +	int ret;
> > +	struct tpm2key_context ctx;
> > +	u8 *blob;
> > +
> > +	ret = asn1_ber_decoder(&tpm2key_decoder, &ctx, payload-
> > >blob,
> > +			       payload->blob_len);
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	if (ctx.priv_len + ctx.pub_len > MAX_BLOB_SIZE)
> > +		return -EINVAL;
> > +
> > +	blob = kmalloc(ctx.priv_len + ctx.pub_len + 4,
> > GFP_KERNEL);
> > +	if (!blob)
> > +		return -ENOMEM;
> > +
> > +	*buf = blob;
> > +	options->keyhandle = ctx.parent;
> > +	put_unaligned_be16(ctx.priv_len, blob);
> > +	blob += 2;
> > +	memcpy(blob, ctx.priv, ctx.priv_len);
> > +	blob += ctx.priv_len;
> > +	put_unaligned_be16(ctx.pub_len, blob);
> > +	blob += 2;
> > +	memcpy(blob, ctx.pub, ctx.pub_len);
> > 
> 
> Hm, do we really have to create this legacy form here and pass it
> around? Can't we change whatever consumes this?

It's not a legacy form ... it's the intrinsic TPM2B form the TPM 2.0
uses so it's the natural destination form for the conversion.

James
