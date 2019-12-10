Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E6E1111896A
	for <lists+linux-integrity@lfdr.de>; Tue, 10 Dec 2019 14:20:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727295AbfLJNUN (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 10 Dec 2019 08:20:13 -0500
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:50860 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727211AbfLJNUN (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 10 Dec 2019 08:20:13 -0500
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id AA0DD8EE18E;
        Tue, 10 Dec 2019 05:20:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1575984012;
        bh=BJOcl/8ddzmbITs1rLnDhHDvl/+bu60lAtaFfEUGLyk=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=t4oc1j6+dJFLt67Lrktn9mJzRogZWSJ3e4hdAHPMHae07ufBV6oMa0QOA11y/VhmO
         q5HnWwSCm2MTpnD8+B6JiMVuGMZ7C9SRmQ3Pc+keJt2er8VnK7z4ZhH/2/+i/95L1a
         q9AA3PZipHLU771PzQbBSQ4QPlFrdEg0tOq/9ITY=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 9DKuYZdbkwfA; Tue, 10 Dec 2019 05:20:11 -0800 (PST)
Received: from jarvis.lan (unknown [50.35.76.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 283D08EE0F8;
        Tue, 10 Dec 2019 05:20:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1575984011;
        bh=BJOcl/8ddzmbITs1rLnDhHDvl/+bu60lAtaFfEUGLyk=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=cPJMiHoTy4+KzpvI7IM8ZvkO8b01seGliPrSswZbs2mhIO9tj+P07efUeCkFQLoF+
         Ob+jmVmVVAnUOeva4Vg6XqibuKPZGCe8Qr0T02yHa6drgdy3HFGsp4PsW/S9IIv4qX
         3aglJWIDGUXbBsDPKy3mNAEsDCUPs9PFEvQ/e1WY=
Message-ID: <1575984010.3459.4.camel@HansenPartnership.com>
Subject: Re: [PATCH v2 2/8] lib: add asn.1 encoder
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     David Woodhouse <dwmw2@infradead.org>,
        linux-integrity@vger.kernel.org
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        keyrings@vger.kernel.org
Date:   Tue, 10 Dec 2019 05:20:10 -0800
In-Reply-To: <932257121039494734d97e290abb9159b1f5ca28.camel@infradead.org>
References: <1575936272.31378.50.camel@HansenPartnership.com>
         <1575936367.31378.52.camel@HansenPartnership.com>
         <932257121039494734d97e290abb9159b1f5ca28.camel@infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, 2019-12-10 at 08:18 +0000, David Woodhouse wrote:
> On Mon, 2019-12-09 at 16:06 -0800, James Bottomley wrote:
> > +/**
> > + * asn1_encode_integer - encode positive integer to ASN.1
> > + * @_data: pointer to the pointer to the data
> > + * @integer: integer to be encoded
> > + * @len: length of buffer
> > + *
> > + * This is a simplified encoder: it only currently does
> > + * positive integers, but it should be simple enough to add the 
> > + * negative case if a use comes along.
> > + */
> > +void asn1_encode_integer(unsigned char **_data, s64 integer, int
> > len)
> > +{
> > +       unsigned char *data = *_data, *d = &data[2];
> > +       int i;
> > +       bool found = false;
> > +
> > +       if (WARN(integer < 0,
> > +                "BUG: asn1_encode_integer only supports positive
> > integers"))
> > +               return;
> > +
> > +       if (WARN(len < 3,
> > +                "BUG: buffer for integers must have at least 3
> > bytes"))
> > +               return;
> > +
> > +       len =- 2;
> > +
> > +       data[0] = _tag(UNIV, PRIM, INT);
> > +       if (integer == 0) {
> > +               *d++ = 0;
> > +               goto out;
> > +       }
> > +       for (i = sizeof(integer); i > 0 ; i--) {
> > +               int byte = integer >> (8*(i-1));
> > +
> > +               if (!found && byte == 0)
> > +                       continue;
> > +               found = true;
> > +               if (byte & 0x80) {
> > +                       /*
> > +                        * no check needed here, we already know we
> > +                        * have len >= 1
> > +                        */
> > +                       *d++ = 0;
> > +                       len--;
> > +               }
> > +               if (WARN(len == 0,
> > +                        "BUG buffer too short in
> > asn1_encode_integer"))
> > +                       return;
> > +               *d++ = byte;
> > +               len--;
> > +       }
> > + out:
> > +       data[1] = d - data - 2;
> > +       *_data = d;
> > +}
> > +EXPORT_SYMBOL_GPL(asn1_encode_integer);
> 
> 
> Didn't you say you were going to make it return an error when it ran
> out of space or was asked to encode a negative number?

it follows the pattern of all the other functions in that it dumps a
kernel warning on problems and bails.  I don't really want to add error
handling for my use case, since it's not expected to have any problems.
 My main problem case is a malicious user tricking the kernel into
trying to overflow the output buffer and in that case I don't really
care that the ASN.1 output will be malformed as long as the buffer
doesn't overflow.

James

> There are other encoding functions which you haven't yet added the
> buffer length field to, and they'll want to be able to return -ENOSPC
> too.


