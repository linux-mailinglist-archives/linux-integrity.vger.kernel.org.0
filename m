Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0DF630C557
	for <lists+linux-integrity@lfdr.de>; Tue,  2 Feb 2021 17:22:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236210AbhBBQUE (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 2 Feb 2021 11:20:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:54858 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236131AbhBBQSW (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 2 Feb 2021 11:18:22 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 65F0864F65;
        Tue,  2 Feb 2021 16:17:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612282661;
        bh=nb+F01HMLRbj+cnqYSMEzMNAlToI/VhoRjb/1UPO14o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=awb7QjyJEyWVbjnGn/Mhv+3amTQfNDdW5oLwCYeY0+pF87JCTfQnE5VFAlFWGfXEy
         7oD3w5MWDGPKQ6ZHQGm6VbKwhUSIowuGhzLrgXJoe4Vp94x/RvzkhPFmuDuOsAW6pY
         d16+y1zXDJCBuUJYinBwNcS/IW8wtuZJhd++vdnsgu6Uo/wNAUbVLlHX5MHiHtVFkE
         cNq+tSvbruwksHhvxADr2b6Z6xg6yalPyhq5r+1hkx9S4MRyZUHR7wip57UDpvuqQw
         7R5Se4QM3b3TbIMGMdsvN3oK+rGV3heiT1fgkLBHwjTyBNkMR9M15LDaHP70IjK5CW
         FzedsnaOEljLA==
Date:   Tue, 2 Feb 2021 18:17:34 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     James Bottomley <James.Bottomley@hansenpartnership.com>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        =?utf-8?Q?=C5=81ukasz?= Majczak <lma@semihalf.com>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        Radoslaw Biernacki <rad@semihalf.com>,
        Marcin Wojtas <mw@semihalf.com>,
        Alex Levin <levinale@google.com>
Subject: Re: [PATCH] tpm_tis: Add missing start/stop_tpm_chip calls
Message-ID: <YBl7HlcgPSX0qRHy@kernel.org>
References: <20210123014247.989368-1-lma@semihalf.com>
 <20210125171846.GA31929@roeck-us.net>
 <CAFJ_xboNDcp-XrxfbrBjqTWjLZUdVWe1OJi4KK==ij+yivFeHA@mail.gmail.com>
 <YBSTOrlgTPpzoblY@kernel.org>
 <7a702108-ec9e-b2e2-be89-3590437c0eb5@roeck-us.net>
 <bf4564a2f4f761a4c0a00857c7dc346fc43bcd92.camel@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <bf4564a2f4f761a4c0a00857c7dc346fc43bcd92.camel@HansenPartnership.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Sat, Jan 30, 2021 at 04:41:13PM -0800, James Bottomley wrote:
> On Sat, 2021-01-30 at 15:49 -0800, Guenter Roeck wrote:
> > On 1/29/21 2:59 PM, Jarkko Sakkinen wrote:
> > > On Tue, Jan 26, 2021 at 04:46:07PM +0100, Łukasz Majczak wrote:
> > > > Hi Jarkko, Guenter
> > > > 
> > > > Yes, here are the logs when failure occurs -
> > > > https://gist.github.com/semihalf-majczak-lukasz/1575461f585f1e7fb1e9366b8eceaab9
> > > > Look for a phrase "TPM returned invalid status"
> > > > 
> > > > Guenter - good suggestion - I will try to keep it as tight as
> > > > possible.
> > > > 
> > > > Best regards,
> > > > Lukasz
> > > 
> > > Is it possible for you try out with linux-next? Thanks. It's a
> > > known issue, which ought to be fixed by now.
> > > 
> > > The log message is harmless, it'a warning not panic, and does not
> > > endanger system stability. WARN()'s always dump stack trace. No
> > > oops is happening.
> > > 
> > 
> > There is a note in the kernel documentation which states:
> > 
> > Note that the WARN()-family should only be used for "expected to
> > be unreachable" situations. If you want to warn about "reachable
> > but undesirable" situations, please use the pr_warn()-family of
> > functions.
> 
> It fits the definition.  The warning only triggers if the access is in
> the wrong locality, which should be impossible, so the warning should
> be unreachable.

It's an overkill. Even in perfectly working kernel it's not impossible, as
sometimes hardware gives faulty data. I think that it also lacks the useful
information i.e. the status code.

I would useful WARN() only if the driver state could suffer. In this case
it doesn't. It only results failing transfer but kernel state is still
legit.

/Jarkko
> 
