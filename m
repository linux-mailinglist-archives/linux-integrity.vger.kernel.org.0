Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 974F42C5F4D
	for <lists+linux-integrity@lfdr.de>; Fri, 27 Nov 2020 05:46:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388741AbgK0Ene (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 26 Nov 2020 23:43:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:39938 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388732AbgK0Ene (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 26 Nov 2020 23:43:34 -0500
Received: from suppilovahvero.lan (83-245-197-237.elisa-laajakaista.fi [83.245.197.237])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 574A222228;
        Fri, 27 Nov 2020 04:43:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606452213;
        bh=KCh3+Weqe5EoWf6AM49ei1gCXMTd+SGq55MsrADXfZw=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=xJa59Lc8W/rBYcF/YckZVBxZDJ3h1RH9b8NKOaBy2uTovn6/eTilJdfSbb5gZcrLS
         1zjx0cVSA44XgysDbdmGK0gj7Q/uYRRVRKNQtjBEfwggu9DD7oFQMkS2760uR4+Kc2
         jMXWt8fk+Zeft8BWaBPe5qIHaC4Gjx/Bc2xu52tI=
Message-ID: <00461e52673271f71250398b5f43a9f311f20457.camel@kernel.org>
Subject: Re: [PATCH 131/141] tpm: Fix fall-through warnings for Clang
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Date:   Fri, 27 Nov 2020 06:43:29 +0200
In-Reply-To: <20201124144023.GH16084@embeddedor>
References: <cover.1605896059.git.gustavoars@kernel.org>
         <1804f48dac434541dc60ada5eefcb86f74905671.1605896060.git.gustavoars@kernel.org>
         <20201123225226.GA17124@kernel.org> <20201123225322.GA19839@kernel.org>
         <20201124144023.GH16084@embeddedor>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, 2020-11-24 at 08:40 -0600, Gustavo A. R. Silva wrote:
> On Tue, Nov 24, 2020 at 12:53:22AM +0200, Jarkko Sakkinen wrote:
> > On Tue, Nov 24, 2020 at 12:52:31AM +0200, Jarkko Sakkinen wrote:
> > > On Fri, Nov 20, 2020 at 12:40:14PM -0600, Gustavo A. R. Silva wrote:
> > > > In preparation to enable -Wimplicit-fallthrough for Clang, fix a warning
> > > > by explicitly adding a break statement instead of letting the code fall
> > > > through to the next case.
> > > > 
> > > > Link: https://github.com/KSPP/linux/issues/115
> > > > Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> > > > ---
> > > >  drivers/char/tpm/eventlog/tpm1.c | 1 +
> > > >  1 file changed, 1 insertion(+)
> > > > 
> > > > diff --git a/drivers/char/tpm/eventlog/tpm1.c b/drivers/char/tpm/eventlog/tpm1.c
> > > > index 2c96977ad080..8aa9057601d6 100644
> > > > --- a/drivers/char/tpm/eventlog/tpm1.c
> > > > +++ b/drivers/char/tpm/eventlog/tpm1.c
> > > > @@ -210,6 +210,7 @@ static int get_event_name(char *dest, struct tcpa_event *event,
> > > >                 default:
> > > >                         break;
> > > >                 }
> > > > +               break;
> > > >         default:
> > > >                 break;
> > > >         }
> > > > -- 
> > > > 2.27.0
> > > > 
> > > > 
> > > 
> > > Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@iki.fi>
> > > 
> > > Who is picking these patches?
> 
> I can take it in my tree for 5.11 if people are OK with that. :)
> 
> > > 
> > > /Jarkko
> > 
> > I mean
> > 
> > Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
> 
> Thanks, Jarkko.
> --
> Gustavo

keyring:

https://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git/commit/?id=a49bdffa9db63a54a6ac56cdcdef8cc8f404f4b6

TPM:

https://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git/commit/?id=1ce46c91fdfe5ebf27a6d328b108c630406d1c8c

Looks good?

/Jarkko

