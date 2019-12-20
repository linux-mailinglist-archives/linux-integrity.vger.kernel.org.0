Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B30B512805E
	for <lists+linux-integrity@lfdr.de>; Fri, 20 Dec 2019 17:07:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727511AbfLTQHB (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 20 Dec 2019 11:07:01 -0500
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:38736 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727362AbfLTQHB (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 20 Dec 2019 11:07:01 -0500
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id D6EF88EE1AD;
        Fri, 20 Dec 2019 08:07:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1576858020;
        bh=4kZDAO/nClscJaZaDfwnp3spDSVyC2tR8UNUAp8RRZ8=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=G03iD1KnjZzkLeueelGrVCWqkteAaswud8KEOoormQYjtjpnytODRE3MW2SM8PyG/
         j4Z25LGvX4R4m8z0ycQLhBG3GUlnn0W/e3aKv4YLXzBFRkMJZdK4oK3cd6sgxdyHMG
         n+a70Mwmn1Rt2AJf69IHG5n0jKU2Zc5xklgLiMk4=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id emzUZ-VNk7IU; Fri, 20 Dec 2019 08:06:42 -0800 (PST)
Received: from jarvis.lan (unknown [50.35.76.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 7AACE8EE0E2;
        Fri, 20 Dec 2019 08:06:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1576857996;
        bh=4kZDAO/nClscJaZaDfwnp3spDSVyC2tR8UNUAp8RRZ8=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=Z4XcD6+KpQpWR5raArf7ulux325MWgHwREg/xHoRS/hvTFzvtV0nsEBz/1vVcTMg8
         0GAIqjlFX45OXSyqiPd3CTSBjJcCzMvKfJ6bNeWrRNgulRLWLmVZX/osSa/mHV2Jxa
         NCwKLn5fZGcKaptDF/jBhTCPOtrd9f4FWr6wgcoY=
Message-ID: <1576857993.3411.3.camel@HansenPartnership.com>
Subject: Re: [PATCH v2 2/8] lib: add asn.1 encoder
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     David Howells <dhowells@redhat.com>
Cc:     David Woodhouse <dwmw2@infradead.org>,
        linux-integrity@vger.kernel.org, Mimi Zohar <zohar@linux.ibm.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        keyrings@vger.kernel.org
Date:   Fri, 20 Dec 2019 08:06:33 -0800
In-Reply-To: <1576710652.3396.18.camel@HansenPartnership.com>
References: <1576069352.2812.1.camel@HansenPartnership.com>
         <1575984010.3459.4.camel@HansenPartnership.com>
         <1575936272.31378.50.camel@HansenPartnership.com>
         <1575936367.31378.52.camel@HansenPartnership.com>
         <932257121039494734d97e290abb9159b1f5ca28.camel@infradead.org>
         <10037.1575986929@warthog.procyon.org.uk>
         <1576004020.3647.13.camel@HansenPartnership.com>
         <35B37965-359E-40E0-8F44-836A56EC4756@infradead.org>
         <26946.1576666216@warthog.procyon.org.uk>
         <1576710652.3396.18.camel@HansenPartnership.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, 2019-12-19 at 08:10 +0900, James Bottomley wrote:
> On Wed, 2019-12-18 at 10:50 +0000, David Howells wrote:
> > James Bottomley <James.Bottomley@HansenPartnership.com> wrote:
> > 
> > > +/**
> > > + * asn1_encode_octet_string - encode an ASN.1 OCTET STRING
> > > + * @data: pointer to encode at
> > > + * @data_len: bytes remaining in @data buffer
> > > + * @string: string to be encoded
> > > + * @len: length of string
> > > + *
> > > + * Note ASN.1 octet strings may contain zeros, so the length is
> > > obligatory.
> > > + */
> > > +int asn1_encode_octet_string(unsigned char **data, int
> > > *data_len,
> > > +			     const unsigned char *string, u32
> > > len)
> > 
> > I wonder if it makes more sense to pass in an end pointer and
> > return
> > the new data pointer (or an error), ie.:
> > 
> > unsigned char *asn1_encode_octet_string(unsigned char *data,
> > 				        unsigned char *data_end,
> > 					const unsigned char *string,
> > u32 len)
> 
> On the first point: people are prone to get off by one confusion on
> data_end pointers (should they point to the last byte in the buffer
> or
> one beyond).  If I look at how I use the API, I've no real use for
> either length remaining or the end pointer, so I think it makes no
> difference to the consumer, it's just stuff you have to do for the
> API.
>  If I look at the internal API use, we definitely need the length
> remaining, so I've a marginal preference for that format, but since
> it's easy to work out it is very marginal.
> 
> > Further, I wonder - does it actually make more sense to encode
> > backwards, ie. start at the end of the buffer and do the last
> > element
> > first, working towards the front.
> 
> Heh, let me ask you this: do you use a reverse polish notation
> calculator ... The problem is that it makes the ASN.1 hard to
> construct  for the API user and hard to read for the reviewer because
> of the order reversal.  Debugging is going to be a pain because
> you're going to get the output of asn1parse and have to read it
> backwards to see where the problems are.

I coded this up to see what it would look like, and I think it can all
be made to work with error pass through.  The latter is because you
want to build up sequences of

data = asn1_encode...(data, ...);
data = asn1_encode...(data, ...);
data = asn1_encode...(data, ...);

And only check for errors when you're finished.  I think the interface
looks nicer than a modifying pointer, so if you wait for the v4 patches
they'll show this new interface with the consumers.

James

