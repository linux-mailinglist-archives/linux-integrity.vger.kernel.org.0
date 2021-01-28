Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA8C1306D2A
	for <lists+linux-integrity@lfdr.de>; Thu, 28 Jan 2021 06:59:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229847AbhA1F72 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 28 Jan 2021 00:59:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:37304 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229739AbhA1F7Y (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 28 Jan 2021 00:59:24 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id DA56461492;
        Thu, 28 Jan 2021 05:58:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611813523;
        bh=GEdC11JIthNvWqLvLzGyO7/UjMyrlohhCwoIECOZYK8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QpDETxCIN+gp8KLLQWdOiKR1G2qIxOZaAm65VIhO0araXgUPy4ccRR/oMcjQtzhs9
         4vuyL1yjQv5F9czvKHLsxTN684WUr4fwM2eyInKstHL72YpmW7y0mOdtQscbNs1eCu
         iZcgsnL8T5iBYgn3r5pyTiQX5Rs8wt/zsSY1lm1OURwW7x9OguL+R02T4h6NeDguX8
         bdWZ7S9D8B6bb37kkporkSmyMvKbhLDqfsWIyfpZjWbSP3jwjFwix1Ikw/Gc7q3Q75
         AiDdPlY1m2YMNobwhG5KEiN3uhFDoOq8KbiOWa1uSocpaqe4xVSV2GJhxbPv4A0F8E
         I2L4nNLxR1sAw==
Date:   Thu, 28 Jan 2021 07:58:38 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     James Bottomley <James.Bottomley@hansenpartnership.com>
Cc:     =?utf-8?Q?=C5=81ukasz?= Majczak <lma@semihalf.com>,
        Guenter Roeck <linux@roeck-us.net>,
        "Tj (Elloe Linux)" <ml.linux@elloe.vision>,
        Dirk Gouders <dirk@gouders.net>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        Radoslaw Biernacki <rad@semihalf.com>,
        Marcin Wojtas <mw@semihalf.com>,
        Alex Levin <levinale@google.com>
Subject: Re: [PATCH] tpm_tis: Add missing start/stop_tpm_chip calls
Message-ID: <YBJSju6RX4LZx08N@kernel.org>
References: <20210123014247.989368-1-lma@semihalf.com>
 <20210125171846.GA31929@roeck-us.net>
 <CAFJ_xboNDcp-XrxfbrBjqTWjLZUdVWe1OJi4KK==ij+yivFeHA@mail.gmail.com>
 <a0249ad7b498e6f1cc065814350e145a07e92d37.camel@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a0249ad7b498e6f1cc065814350e145a07e92d37.camel@HansenPartnership.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, Jan 26, 2021 at 08:46:48AM -0800, James Bottomley wrote:
> On Tue, 2021-01-26 at 16:46 +0100, Łukasz Majczak wrote:
> > Hi Jarkko, Guenter
> > 
> > Yes, here are the logs when failure occurs -
> > https://gist.github.com/semihalf-majczak-lukasz/1575461f585f1e7fb1e9366b8eceaab9
> > Look for a phrase "TPM returned invalid status"
> 
> We've had other reports of this:
> 
> https://lore.kernel.org/linux-integrity/ghsgagsnag.fsf@gouders.net/
> https://lore.kernel.org/linux-integrity/374e918c-f167-9308-2bea-ae6bc6a3d2e3@elloe.vision/
> 
> The problem is some TIS TPMs don't begin in the correct locality so we
> have to set it.  When I proposed the check, I also proposed a fix for
> this problem:
> 
> https://lore.kernel.org/linux-integrity/20201001180925.13808-5-James.Bottomley@HansenPartnership.com/
> 
> But it's part of a series that never went upstream.  Part of the reason
> was Jarkko proposed the get/put patch to fix this instead, but that
> never went upstream either.  We need to decide an approach and apply
> one or other fixes.

Can you remind me what I proposed? I remember only proposing removing
interrupt code.

Can you pick up just 1/5 and 2/5 from that serieis and send them as a
mini series?

I had one remark for 1/5, which can be found here:

https://lore.kernel.org/linux-integrity/20201024120744.GA32607@kernel.org/

I don't think there was never argument on locality changes.

/Jarkko
