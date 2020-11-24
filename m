Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 651DA2C29DA
	for <lists+linux-integrity@lfdr.de>; Tue, 24 Nov 2020 15:40:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388913AbgKXOkJ (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 24 Nov 2020 09:40:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:56986 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388014AbgKXOkJ (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 24 Nov 2020 09:40:09 -0500
Received: from embeddedor (187-162-31-110.static.axtel.net [187.162.31.110])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 990E3206E5;
        Tue, 24 Nov 2020 14:40:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606228808;
        bh=8cAsMW0jxkAcxLnMU27PtmCKLh9UoLHSExBwGavk3CM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FWfBIFPmZ0R2i7RCHQHaBZ8/6WRxggDrlntE4uMwJ+oU7Op241xy8MEa/A/MPv6JJ
         3oZlg9Nm76YrmqkWSykwqf0amdIH1fk84bmRLMbQXJ57QGILd9Se5EWNJ0fn0rGgt/
         XRVrh9vqQiyyZzerPTYZhYEB7h8Yis7PLIqIe7IE=
Date:   Tue, 24 Nov 2020 08:40:23 -0600
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Jarkko Sakkinen <jarkko@kernel.org>
Cc:     Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH 131/141] tpm: Fix fall-through warnings for Clang
Message-ID: <20201124144023.GH16084@embeddedor>
References: <cover.1605896059.git.gustavoars@kernel.org>
 <1804f48dac434541dc60ada5eefcb86f74905671.1605896060.git.gustavoars@kernel.org>
 <20201123225226.GA17124@kernel.org>
 <20201123225322.GA19839@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201123225322.GA19839@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, Nov 24, 2020 at 12:53:22AM +0200, Jarkko Sakkinen wrote:
> On Tue, Nov 24, 2020 at 12:52:31AM +0200, Jarkko Sakkinen wrote:
> > On Fri, Nov 20, 2020 at 12:40:14PM -0600, Gustavo A. R. Silva wrote:
> > > In preparation to enable -Wimplicit-fallthrough for Clang, fix a warning
> > > by explicitly adding a break statement instead of letting the code fall
> > > through to the next case.
> > > 
> > > Link: https://github.com/KSPP/linux/issues/115
> > > Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> > > ---
> > >  drivers/char/tpm/eventlog/tpm1.c | 1 +
> > >  1 file changed, 1 insertion(+)
> > > 
> > > diff --git a/drivers/char/tpm/eventlog/tpm1.c b/drivers/char/tpm/eventlog/tpm1.c
> > > index 2c96977ad080..8aa9057601d6 100644
> > > --- a/drivers/char/tpm/eventlog/tpm1.c
> > > +++ b/drivers/char/tpm/eventlog/tpm1.c
> > > @@ -210,6 +210,7 @@ static int get_event_name(char *dest, struct tcpa_event *event,
> > >  		default:
> > >  			break;
> > >  		}
> > > +		break;
> > >  	default:
> > >  		break;
> > >  	}
> > > -- 
> > > 2.27.0
> > > 
> > > 
> > 
> > Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@iki.fi>
> > 
> > Who is picking these patches?

I can take it in my tree for 5.11 if people are OK with that. :)

> > 
> > /Jarkko
> 
> I mean
> 
> Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

Thanks, Jarkko.
--
Gustavo

