Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DAC330C3F6
	for <lists+linux-integrity@lfdr.de>; Tue,  2 Feb 2021 16:37:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233290AbhBBPhc (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 2 Feb 2021 10:37:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:44240 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235555AbhBBPe3 (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 2 Feb 2021 10:34:29 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2B7D864E92;
        Tue,  2 Feb 2021 15:33:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612280028;
        bh=T3DVUO/GgGfi86E/fUEjepr1D9Sby+jHPBoOfChLKkc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eHbAAO/01CxQRjzrZuDMHZUN0rn6FkGXUoJ3Qv21irQdNM94ukiy6Ohqgqfdfcpgc
         mIFM+ed4gFJkkH09s3XMDqUqa0x2mSDs3NcJi7tBnIAgEvHgJ5IXPhlLniK2w3RZaL
         mRNuU4RmTOTvnuDjo1K0DRYEZtVPuqy0VpqPr2FyfLh4eqlQUNHj488ivreNy9d6dY
         eA3C1+5cFVmRzllY6+3YPQiWXwZR5oIe14O8yyLaoK4ms/S9q8NV9BiybHyzwIZDs5
         2DjgVa2NqWUh9TkNfYI5LK3KPWo7tgzk6Zwe2HxO4k3bZGh3fbIE/JQz1U8qofPhC1
         R4FMTr+kppAoQ==
Date:   Tue, 2 Feb 2021 17:33:41 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     =?utf-8?Q?=C5=81ukasz?= Majczak <lma@semihalf.com>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        Radoslaw Biernacki <rad@semihalf.com>,
        Marcin Wojtas <mw@semihalf.com>,
        Alex Levin <levinale@google.com>,
        James.Bottomley@hansenpartnership.com
Subject: Re: [PATCH] tpm_tis: Add missing start/stop_tpm_chip calls
Message-ID: <YBlw1eMK4mRyRhUF@kernel.org>
References: <20210123014247.989368-1-lma@semihalf.com>
 <20210125171846.GA31929@roeck-us.net>
 <CAFJ_xboNDcp-XrxfbrBjqTWjLZUdVWe1OJi4KK==ij+yivFeHA@mail.gmail.com>
 <YBSTOrlgTPpzoblY@kernel.org>
 <7a702108-ec9e-b2e2-be89-3590437c0eb5@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7a702108-ec9e-b2e2-be89-3590437c0eb5@roeck-us.net>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Sat, Jan 30, 2021 at 03:49:09PM -0800, Guenter Roeck wrote:
> On 1/29/21 2:59 PM, Jarkko Sakkinen wrote:
> > On Tue, Jan 26, 2021 at 04:46:07PM +0100, Łukasz Majczak wrote:
> >> Hi Jarkko, Guenter
> >>
> >> Yes, here are the logs when failure occurs -
> >> https://gist.github.com/semihalf-majczak-lukasz/1575461f585f1e7fb1e9366b8eceaab9
> >> Look for a phrase "TPM returned invalid status"
> >>
> >> Guenter - good suggestion - I will try to keep it as tight as possible.
> >>
> >> Best regards,
> >> Lukasz
> > 
> > Is it possible for you try out with linux-next? Thanks. It's a known
> > issue, which ought to be fixed by now.
> > 
> > The log message is harmless, it'a warning not panic, and does not
> > endanger system stability. WARN()'s always dump stack trace. No oops
> > is happening.
> > 
> 
> There is a note in the kernel documentation which states:
> 
> Note that the WARN()-family should only be used for "expected to
> be unreachable" situations. If you want to warn about "reachable
> but undesirable" situations, please use the pr_warn()-family of
> functions.
> 
> It seems to me that "harmless" doesn't really fit the expected
> use of WARN(). Should it possibly be converted to pr_warn() ?

It should, and I agree that it was a mistake to merge the commit
that added this WARN(). I'm sending a late PR to Linus containing
just the James' fixes. I'll include one line change to that PR,
that does just what you suggested.

It also lacks useful information, i.e. the status.

I just send a fixed with your "suggested-by". Can you review and
ack it ASAP so that I can then go on and send PR to Linus?

/Jarkko
