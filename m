Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D0F5417844A
	for <lists+linux-integrity@lfdr.de>; Tue,  3 Mar 2020 21:49:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731943AbgCCUtd (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 3 Mar 2020 15:49:33 -0500
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:47186 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730274AbgCCUtc (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 3 Mar 2020 15:49:32 -0500
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 40A758EE11D;
        Tue,  3 Mar 2020 12:49:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1583268572;
        bh=CcvJPmDzJVVXXGRQmtUgOkP0UMisCXHoOTvhcpQwHaA=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=a55e7lHRo/Se/vGLA8lw22QSFQotXHzNZci/ZEfN9qGo5uhZGgAvGn3uiveAdpNHp
         93d6KVfaWl7vc228C4End1gSEYkB95M+M0jA1CG6+VsN9gniPEAzOnCOksaUzLGZwW
         oQl4KV3yaan/LKcWkt00hPf11ZA8OD5lx5PE2qDs=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id FScBN0xhChT0; Tue,  3 Mar 2020 12:49:32 -0800 (PST)
Received: from jarvis.ext.hansenpartnership.com (jarvis.ext.hansenpartnership.com [153.66.160.226])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 8A27F8EE10C;
        Tue,  3 Mar 2020 12:49:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1583268572;
        bh=CcvJPmDzJVVXXGRQmtUgOkP0UMisCXHoOTvhcpQwHaA=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=a55e7lHRo/Se/vGLA8lw22QSFQotXHzNZci/ZEfN9qGo5uhZGgAvGn3uiveAdpNHp
         93d6KVfaWl7vc228C4End1gSEYkB95M+M0jA1CG6+VsN9gniPEAzOnCOksaUzLGZwW
         oQl4KV3yaan/LKcWkt00hPf11ZA8OD5lx5PE2qDs=
Message-ID: <1583268570.3638.15.camel@HansenPartnership.com>
Subject: Re: [PATCH v6 1/6] lib: add ASN.1 encoder
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     linux-integrity@vger.kernel.org, Mimi Zohar <zohar@linux.ibm.com>,
        David Woodhouse <dwmw2@infradead.org>, keyrings@vger.kernel.org
Date:   Tue, 03 Mar 2020 15:49:30 -0500
In-Reply-To: <20200303192208.GA5775@linux.intel.com>
References: <20200302122759.5204-1-James.Bottomley@HansenPartnership.com>
         <20200302122759.5204-2-James.Bottomley@HansenPartnership.com>
         <20200303192208.GA5775@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, 2020-03-03 at 21:22 +0200, Jarkko Sakkinen wrote:
> On Mon, Mar 02, 2020 at 07:27:54AM -0500, James Bottomley wrote:
[...]
> > diff --git a/lib/asn1_encoder.c b/lib/asn1_encoder.c
> > new file mode 100644
> > index 000000000000..c7493667656e
> > --- /dev/null
> > +++ b/lib/asn1_encoder.c
> > @@ -0,0 +1,431 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/*
> > + * Simple encoder primitives for ASN.1 BER/DER/CER
> > + *
> > + * Copyright (C) 2019 James.Bottomley@HansenPartnership.com
> > + */
> > +
> > +#include <linux/asn1_encoder.h>
> > +#include <linux/bug.h>
> > +#include <linux/string.h>
> > +#include <linux/module.h>
> > +
> > +/**
> > + * asn1_encode_integer() - encode positive integer to ASN.1
> > + * @data:	pointer to the pointer to the data
> > + * @end_data:	end of data pointer, points one beyond last
> > usable byte in @data
> > + * @integer:	integer to be encoded
> > + *
> > + * This is a simplified encoder: it only currently does
> > + * positive integers, but it should be simple enough to add the
> > + * negative case if a use comes along.
> > + */
> > +unsigned char *
> > +asn1_encode_integer(unsigned char *data, const unsigned char
> > *end_data,
> > +		    s64 integer)
> > +{
> > +	unsigned char *d = &data[2];
> 
> So what magic does index 2 contain?

ASN.1 has the form <tag> <length> <content> so a small integer has one
byte for the _tag(UNIV, PRIM, INT), one byte for the length, which must
be between 1 and 4, so the actual integer itself starts at 2.

> > +	int i;
> > +	bool found = false;
> > +	int data_len = end_data - data;
> 
> I'd reorder these:
> 
> int data_len = end_data - data;
> unsigned char *d = &data[2];
> bool found = false;
> int i;

Ah, reverse Christmas tree ... I can do that.

> Reordering makes easier to comprehend the declarations.
> 
> > +
> > +	if (WARN(integer < 0,
> > +		 "BUG: integer encode only supports positive
> > integers"))
> > +		return ERR_PTR(-EINVAL);
> > +
> > +	if (IS_ERR(data))
> > +		return data;
> > +
> > +	/* need at least 3 bytes for tag, length and integer
> > encoding */
> > +	if (data_len < 3)
> > +		return ERR_PTR(-EINVAL);
> > +
> > +	/* remaining length where at d (the start of the integer
> > encoding) */
> > +	data_len -= 2;
> > +
> > +	data[0] = _tag(UNIV, PRIM, INT);
> > +	if (integer == 0) {
> > +		*d++ = 0;
> > +		goto out;
> > +	}
> > +
> > +	for (i = sizeof(integer); i > 0 ; i--) {
> > +		int byte = integer >> (8*(i-1));
> 
> Spacing (according to the kernel coding style) is wrong here.

OK, will add spaces around the brackets and the operations.

James


