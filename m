Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3EBAA18BE0C
	for <lists+linux-integrity@lfdr.de>; Thu, 19 Mar 2020 18:31:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727269AbgCSRb2 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 19 Mar 2020 13:31:28 -0400
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:39474 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727146AbgCSRb2 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 19 Mar 2020 13:31:28 -0400
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 081098EE369;
        Thu, 19 Mar 2020 10:31:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1584639088;
        bh=ZiA7B+xzCQdj+Pd7Hob2CdEeWMzKsTvOKw3GUD6CQpo=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=D4anwyxJN6GmbbFwJerPuUZIeQ4YCodeUzefKOjd/j+WBrXcEZX3fS3hneKvQK/gB
         uWK86EIgCps5UdCMX4TJtBEllZIq+hf6OdkofWRR/SIIaw18sEW/mixmFH6Ev2lE4+
         4tSS5jU5VVkDq6Lcd6beeALTZdf73looHIGmGBeo=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id tfx1zcUvhI_o; Thu, 19 Mar 2020 10:31:27 -0700 (PDT)
Received: from [153.66.254.194] (unknown [50.35.76.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 5A3DB8EE182;
        Thu, 19 Mar 2020 10:31:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1584639087;
        bh=ZiA7B+xzCQdj+Pd7Hob2CdEeWMzKsTvOKw3GUD6CQpo=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=umhzKgUlUl76g7GtjaOE315K07ITVuvUfli+s4BlPrBU17FX3u+ejyLc3IdHZgcev
         KNw58hWbmX6jTJTxvZBRCGnDCg08DQnaJ2//LlKbrIVSmM0+H1l14anqvM6MhtIFhl
         Dgd4/hUVkvPe8HfIK0+6U3puHK5x7q73gzbSH9IU=
Message-ID: <1584639086.3610.28.camel@HansenPartnership.com>
Subject: Re: [PATCH v8 1/8] lib: add ASN.1 encoder
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     David Howells <dhowells@redhat.com>
Cc:     linux-integrity@vger.kernel.org, Mimi Zohar <zohar@linux.ibm.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        David Woodhouse <dwmw2@infradead.org>, keyrings@vger.kernel.org
Date:   Thu, 19 Mar 2020 10:31:26 -0700
In-Reply-To: <3180269.1584636439@warthog.procyon.org.uk>
References: <20200310051607.30334-2-James.Bottomley@HansenPartnership.com>
         <20200310051607.30334-1-James.Bottomley@HansenPartnership.com>
         <3180269.1584636439@warthog.procyon.org.uk>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, 2020-03-19 at 16:47 +0000, David Howells wrote:
> James Bottomley <James.Bottomley@HansenPartnership.com> wrote:
> 
> > + * Copyright (C) 2019 James.Bottomley@HansenPartnership.com
> 
> 2020?

Actually, no, under the Berne convention it should be the date the work
was committed to a fixed medium.  In theory, that's the first git
commit I did in my internal repository.  There's a lot of wiggle room
in this: authors tend to use the date the manuscript was completed, not
when it was started, for instance, but 2019 would seem to be the more
accurate year even so.

> > +unsigned char *
> > +asn1_encode_integer(unsigned char *data, const unsigned char
> > *end_data,
> > +		    s64 integer);
> 
> I wonder if we should actually use u8 rather than unsigned char for
> data pointers like this.  That applies to asn1_ber_decoder() also.

I followed exactly what you did in asn1_decoder.c ... I think there's
value in having a completely signature consistent interface.  Of
course, if you want to alter the encoder and decoder to u8 that can be
done as a follow on patch.

> You should be able to precalculate the length from fls64() or
> ilog2(), e.g.:
> 
> 	static size_t asn1_uint_len(unsigned long long integer)
> 	{
> 		size_t l = integer ? fls64(integer) : 1;
> 		return l / 8 + 1;
> 	}
> 
> See attached toy program.

We can, but it adds a lot of complexity for pretty much no gain: it's
no real hassle to begin the encoding and then find the buffer is too
short, and the code is definitely much easier to follow.

> > +/**
> > + * asn1_encode_tag() - add a tag for optional or explicit value
> > + * @data:	pointer to place tag at
> > + * @end_data:	end of data pointer, points one beyond last
> > usable byte in @data
> > + * @tag:	tag to be placed
> > + * @string:	the data to be tagged
> > + * @len:	the length of the data to be tagged
> > + *
> > + * Note this currently only handles short form tags < 31.  To
> > encode
> > + * in place pass a NULL @string and -1 for @len; all this will do
> > is
> > + * add an indefinite length tag and update the data pointer to the
> > + * place where the tag contents should be placed.  After the data
> > is
> > + * placed, repeat the prior statement but now with the known
> > length.
> > + * In order to avoid having to keep both before and after
> > pointers,
> > + * the repeat expects to be called with @data pointing to where
> > the
> > + * first encode placed it.
> > + */
> 
> I wonder if it's worth appending a note to the comment that if
> indefinite length encoding is selected, then the result is not DER-
> compliant and may not be CER-compliant since you're advertising
> BER/DER/CER.

We only encode definite length currently, so the comment is superfluous
(and probably confusing if you don't know the difference between
DER/BER and CER).  Let's add something like this iff we ever start to
use indefinite lengths in the encoder.

> > +	if (*data_len < 1)
> > +		return -EINVAL;
> 
> ENOBUFS?  I guess it doesn't really matter.

This error gets sent to the user who's not doing to know why because
it's a kernel internal length we got wrong ... let's just keep EINVAL
which is our default "something went wrong" error.

> David
> ---
> #include <stdio.h>
> 
> static inline int fls64(unsigned long long x)
> {
> 	int bitpos = -1;
> 	/*
> 	 * AMD64 says BSRQ won't clobber the dest reg if x==0; Intel64
> says the
> 	 * dest reg is undefined if x==0, but their CPU architect says
> its
> 	 * value is written to set it to the same as before.
> 	 */
> 	asm("bsrq %1,%q0"
> 	    : "+r" (bitpos)
> 	    : "rm" (x));
> 	return bitpos + 1;
> }
> 
> static const unsigned long long vals[] = {
> 	0x1000000, 0xffffff, 0x800000, 0x7fffff,
> 	0x100000, 0xfffff, 0x80000, 0x7ffff,
> 	0x10000, 0xffff, 0x8000, 0x7fff,
> 	0x1000, 0xfff, 0x800, 0x7ff,
> 	0x100, 0xff, 0x80, 0x7f,
> 	3, 2, 1, 0
> };
> 
> static size_t asn1_uint_len(unsigned long long integer)
> {
> 	size_t l = integer ? fls64(integer) : 1;
> 	return l / 8 + 1;
> }
> 
> int main()
> {
> 	const unsigned long long *p = vals;
> 	unsigned long long integer;
> 
> 	do {
> 		integer = *p++;
> 		printf("len: %16llx -> %zu\n", integer,
> asn1_uint_len(integer));
> 	} while (integer);
> }
> 

