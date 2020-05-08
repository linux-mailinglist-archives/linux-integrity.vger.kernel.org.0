Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 993371CB442
	for <lists+linux-integrity@lfdr.de>; Fri,  8 May 2020 18:01:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727923AbgEHQBi (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 8 May 2020 12:01:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:59286 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727803AbgEHQBh (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 8 May 2020 12:01:37 -0400
Received: from embeddedor (unknown [189.207.59.248])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BF1F220725;
        Fri,  8 May 2020 16:01:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588953697;
        bh=e/q+X2llUESDXjknVyD37ZTb95TJ/m5mQMoLaK/Zq5s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Bu0EOWe3AR5ZE9lofciPSHX8kg17gXFgLXHZhP4cxL90fG3kmEzp+KGkypxpQoBTN
         bzC20fYQBpgzPgI1cLZUbWrFU4R3x94Z/QlASK96dd66zk6hRxh6oiTi1gDVNRnH36
         BSvVZlEPlc8DxFjnegGZxnsM/oOWQsPny7P98ZDc=
Date:   Fri, 8 May 2020 11:06:04 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: Re: [PATCH RESEND] tpm: eventlog: Replace zero-length array with
 flexible-array member
Message-ID: <20200508160604.GA23375@embeddedor>
References: <20200507040912.GA31382@embeddedor>
 <202005071058.A2234694ED@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202005071058.A2234694ED@keescook>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, May 07, 2020 at 11:02:18AM -0700, Kees Cook wrote:
> On Wed, May 06, 2020 at 11:09:12PM -0500, Gustavo A. R. Silva wrote:
> > As mentioned above: "Flexible array members have incomplete type, and
> > so the sizeof operator may not be applied. As a quirk of the original
> > implementation of zero-length arrays, sizeof evaluates to zero."[1] So,
> > the sizeof(flexible-array) can be safely removed to fix the error above.
> 
> As in "sizeof(event_header->event) always evaluated to 0, so removing it
> has no effect".
> 

Thanks for this.  I wanted to make a more general statement, but I'll
update the changelog text. :)

> > [...]
> > diff --git a/drivers/char/tpm/eventlog/tpm2.c b/drivers/char/tpm/eventlog/tpm2.c
> > index e741b1157525..351a2989b3c6 100644
> > --- a/drivers/char/tpm/eventlog/tpm2.c
> > +++ b/drivers/char/tpm/eventlog/tpm2.c
> > @@ -51,8 +51,7 @@ static void *tpm2_bios_measurements_start(struct seq_file *m, loff_t *pos)
> >  	int i;
> >  
> >  	event_header = addr;
> > -	size = sizeof(struct tcg_pcr_event) - sizeof(event_header->event)
> > -		+ event_header->event_size;
> > +	size = sizeof(*event_header) + event_header->event_size;
> 
> That said, I think it would be better to stick to the struct_size()
> idiom for dealing with flexible arrays here:
> 
> 	size = struct_size(event_header, event, event_size);
> 

Yep, I agree. I'll add this and send v2, shortly.

Thanks
--
Gustavo

