Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A5E97119009
	for <lists+linux-integrity@lfdr.de>; Tue, 10 Dec 2019 19:53:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727558AbfLJSxn (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 10 Dec 2019 13:53:43 -0500
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:57170 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727349AbfLJSxn (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 10 Dec 2019 13:53:43 -0500
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id D616E8EE0F8;
        Tue, 10 Dec 2019 10:53:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1576004022;
        bh=QZr7wT9b1l0MiLo0TLgMPv7Kq1IzQO4h6rkCpS3STiA=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=BE7wvGYo/T4dCnFiFGuWsqa87CLzPUCcDdnJHxP8oY2RpSulYAxsuUrTSkMfDOqqW
         TAUKIJtHfB4VvdItwzmVTngPv3bZaw5a97vGJ2kN8y29uxN4E+pH0E9KPNjwTYx/I7
         VC1YBKV9NpP1SJXTEna2BjCYKNLmeUBgOKhcZPOQ=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id GI76whowrTYV; Tue, 10 Dec 2019 10:53:42 -0800 (PST)
Received: from [10.252.0.210] (unknown [198.134.98.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 2119A8EE02B;
        Tue, 10 Dec 2019 10:53:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1576004022;
        bh=QZr7wT9b1l0MiLo0TLgMPv7Kq1IzQO4h6rkCpS3STiA=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=BE7wvGYo/T4dCnFiFGuWsqa87CLzPUCcDdnJHxP8oY2RpSulYAxsuUrTSkMfDOqqW
         TAUKIJtHfB4VvdItwzmVTngPv3bZaw5a97vGJ2kN8y29uxN4E+pH0E9KPNjwTYx/I7
         VC1YBKV9NpP1SJXTEna2BjCYKNLmeUBgOKhcZPOQ=
Message-ID: <1576004020.3647.13.camel@HansenPartnership.com>
Subject: Re: [PATCH v2 2/8] lib: add asn.1 encoder
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     David Howells <dhowells@redhat.com>
Cc:     David Woodhouse <dwmw2@infradead.org>,
        linux-integrity@vger.kernel.org, Mimi Zohar <zohar@linux.ibm.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        keyrings@vger.kernel.org
Date:   Tue, 10 Dec 2019 10:53:40 -0800
In-Reply-To: <10037.1575986929@warthog.procyon.org.uk>
References: <1575984010.3459.4.camel@HansenPartnership.com>
         <1575936272.31378.50.camel@HansenPartnership.com>
         <1575936367.31378.52.camel@HansenPartnership.com>
         <932257121039494734d97e290abb9159b1f5ca28.camel@infradead.org>
         <10037.1575986929@warthog.procyon.org.uk>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, 2019-12-10 at 14:08 +0000, David Howells wrote:
> James Bottomley <James.Bottomley@HansenPartnership.com> wrote:
> 
> > > Didn't you say you were going to make it return an error when it
> > > ran out of space or was asked to encode a negative number?
> > 
> > it follows the pattern of all the other functions in that it dumps
> > a kernel warning on problems and bails.
> 
> I don't see any bounds checking there, let alone anything that dumps
> a kernel warning and bails 

It's in the if (WARN part of asn1_encode_integer.

> - except if the length is so large that the ASN.1 cannot be
> constructed.  That said, there is a check in patch 4.

However, I think you'd like both a length and a buffer length to each
function to cope with definite length encoding overflows?  I can do
that.

> > ... as long as the buffer doesn't overflow.
> 
> Yes, but that's Dave's point.
> 
> [from patch 4]
> 
> > +	 * Assume both ovtet strings will encode to a 2 byte
> > definite length
> 
> octet, btw.

Heh, yes, noticed that mere seconds after I pressed send ...

> At least I've found a preliminary bounds check there
> 
> > +	 */
> > +	if (WARN(work - scratch + pub_len + priv_len + 8 >
> > SCRATCH_SIZE,
> > +		 "BUG: scratch buffer is too small"))
> > +		return -EINVAL;
> 
> which I presume makes the correct calculation.
> 
> I thought TPM comms were slow - slow enough that putting bounds
> checking in your asn1_encode_* routines will be insignificant.

Yes, I'm not bothered about timings.  I can add bounds checking on the
buffer length like the integer case.  For the other routines, I'll make
it decrement the data length in place as it increments the data pointer

> Further, you're promoting this ASN.1 encoder as a general library
> within the kernel, presumably so that other people can make use of
> it.

Well, I did notice the TPM 1.2 asymmetric key code rolled its own ASN.1
encoding, yes.

>   Please therefore put bounds checking and error handling in it.  And
> please *don't* just produce broken ASN.1 when something goes wrong.

OK, I'll make it return an error and add a wrapper for my use case that
warns on error and causes the function to bail.

James

