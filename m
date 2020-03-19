Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8D28A18BD01
	for <lists+linux-integrity@lfdr.de>; Thu, 19 Mar 2020 17:47:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728222AbgCSQr0 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 19 Mar 2020 12:47:26 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:51111 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727302AbgCSQr0 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 19 Mar 2020 12:47:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1584636444;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bAwDx5gSn1U4ksB1jrmtVBV6unzFl6U6RfO3IvxTBrQ=;
        b=PyL7lBiL8zUA8ukPPYrVxR6e8mXBEyyODpRU98n2+8vMCeIfNxRp+hjbRl7avR010kfhDH
        TXiVxo0x9EH3DNIGbxMppcDtn6Cg047zbl1rtRwGPj5w4wf0sAlrYAXHCpS3jwUww82MQ/
        27hFjFN3gzyomYW9eZEtBILoOC9lfDs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-197-9GDMm0NPP76HvVCGBkf1jQ-1; Thu, 19 Mar 2020 12:47:23 -0400
X-MC-Unique: 9GDMm0NPP76HvVCGBkf1jQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 878A219251D6;
        Thu, 19 Mar 2020 16:47:21 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-113-126.rdu2.redhat.com [10.10.113.126])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2F5295DA81;
        Thu, 19 Mar 2020 16:47:20 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20200310051607.30334-2-James.Bottomley@HansenPartnership.com>
References: <20200310051607.30334-2-James.Bottomley@HansenPartnership.com> <20200310051607.30334-1-James.Bottomley@HansenPartnership.com>
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     dhowells@redhat.com, linux-integrity@vger.kernel.org,
        Mimi Zohar <zohar@linux.ibm.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        David Woodhouse <dwmw2@infradead.org>, keyrings@vger.kernel.org
Subject: Re: [PATCH v8 1/8] lib: add ASN.1 encoder
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3180268.1584636439.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Thu, 19 Mar 2020 16:47:19 +0000
Message-ID: <3180269.1584636439@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

James Bottomley <James.Bottomley@HansenPartnership.com> wrote:

> + * Copyright (C) 2019 James.Bottomley@HansenPartnership.com

2020?

> +unsigned char *
> +asn1_encode_integer(unsigned char *data, const unsigned char *end_data,
> +		    s64 integer);

I wonder if we should actually use u8 rather than unsigned char for data
pointers like this.  That applies to asn1_ber_decoder() also.

You should be able to precalculate the length from fls64() or ilog2(), e.g=
.:

	static size_t asn1_uint_len(unsigned long long integer)
	{
		size_t l =3D integer ? fls64(integer) : 1;
		return l / 8 + 1;
	}

See attached toy program.

> +/**
> + * asn1_encode_tag() - add a tag for optional or explicit value
> + * @data:	pointer to place tag at
> + * @end_data:	end of data pointer, points one beyond last usable byte i=
n @data
> + * @tag:	tag to be placed
> + * @string:	the data to be tagged
> + * @len:	the length of the data to be tagged
> + *
> + * Note this currently only handles short form tags < 31.  To encode
> + * in place pass a NULL @string and -1 for @len; all this will do is
> + * add an indefinite length tag and update the data pointer to the
> + * place where the tag contents should be placed.  After the data is
> + * placed, repeat the prior statement but now with the known length.
> + * In order to avoid having to keep both before and after pointers,
> + * the repeat expects to be called with @data pointing to where the
> + * first encode placed it.
> + */

I wonder if it's worth appending a note to the comment that if indefinite
length encoding is selected, then the result is not DER-compliant and may =
not
be CER-compliant since you're advertising BER/DER/CER.

> +	if (*data_len < 1)
> +		return -EINVAL;

ENOBUFS?  I guess it doesn't really matter.

David
---
#include <stdio.h>

static inline int fls64(unsigned long long x)
{
	int bitpos =3D -1;
	/*
	 * AMD64 says BSRQ won't clobber the dest reg if x=3D=3D0; Intel64 says t=
he
	 * dest reg is undefined if x=3D=3D0, but their CPU architect says its
	 * value is written to set it to the same as before.
	 */
	asm("bsrq %1,%q0"
	    : "+r" (bitpos)
	    : "rm" (x));
	return bitpos + 1;
}

static const unsigned long long vals[] =3D {
	0x1000000, 0xffffff, 0x800000, 0x7fffff,
	0x100000, 0xfffff, 0x80000, 0x7ffff,
	0x10000, 0xffff, 0x8000, 0x7fff,
	0x1000, 0xfff, 0x800, 0x7ff,
	0x100, 0xff, 0x80, 0x7f,
	3, 2, 1, 0
};

static size_t asn1_uint_len(unsigned long long integer)
{
	size_t l =3D integer ? fls64(integer) : 1;
	return l / 8 + 1;
}

int main()
{
	const unsigned long long *p =3D vals;
	unsigned long long integer;

	do {
		integer =3D *p++;
		printf("len: %16llx -> %zu\n", integer, asn1_uint_len(integer));
	} while (integer);
}

