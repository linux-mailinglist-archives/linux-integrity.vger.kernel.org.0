Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 960FE30997D
	for <lists+linux-integrity@lfdr.de>; Sun, 31 Jan 2021 01:42:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232327AbhAaAl4 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sat, 30 Jan 2021 19:41:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232295AbhAaAlz (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sat, 30 Jan 2021 19:41:55 -0500
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [IPv6:2607:fcd0:100:8a00::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC954C061573;
        Sat, 30 Jan 2021 16:41:15 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 917F812800EA;
        Sat, 30 Jan 2021 16:41:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1612053675;
        bh=ujtvEXo0CAfqmJN44waKH6NoDvjf3jsEyhgN1RaHQKY=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=VdVE+YSjkvz+BQdHyt5wLQrJhz/cGQgTjW55CmdVViEjBK4HKsIlrxNE6/jaTwKO5
         o5reCzjfiWUryNl7b2UZgZo3F7GBrtxJjmTMDmvgoQFh2gpksWB3s6ArSBPV/eR0lx
         OHtn2sihbJhl3BggArmpUu9qZE+fzyVGnJXtl3TA=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id OeonLmAfWZ0J; Sat, 30 Jan 2021 16:41:15 -0800 (PST)
Received: from jarvis.int.hansenpartnership.com (unknown [IPv6:2601:600:8280:66d1::c447])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 00C641280027;
        Sat, 30 Jan 2021 16:41:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1612053675;
        bh=ujtvEXo0CAfqmJN44waKH6NoDvjf3jsEyhgN1RaHQKY=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=VdVE+YSjkvz+BQdHyt5wLQrJhz/cGQgTjW55CmdVViEjBK4HKsIlrxNE6/jaTwKO5
         o5reCzjfiWUryNl7b2UZgZo3F7GBrtxJjmTMDmvgoQFh2gpksWB3s6ArSBPV/eR0lx
         OHtn2sihbJhl3BggArmpUu9qZE+fzyVGnJXtl3TA=
Message-ID: <bf4564a2f4f761a4c0a00857c7dc346fc43bcd92.camel@HansenPartnership.com>
Subject: Re: [PATCH] tpm_tis: Add missing start/stop_tpm_chip calls
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Guenter Roeck <linux@roeck-us.net>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        =?UTF-8?Q?=C5=81ukasz?= Majczak <lma@semihalf.com>
Cc:     Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        Radoslaw Biernacki <rad@semihalf.com>,
        Marcin Wojtas <mw@semihalf.com>,
        Alex Levin <levinale@google.com>
Date:   Sat, 30 Jan 2021 16:41:13 -0800
In-Reply-To: <7a702108-ec9e-b2e2-be89-3590437c0eb5@roeck-us.net>
References: <20210123014247.989368-1-lma@semihalf.com>
         <20210125171846.GA31929@roeck-us.net>
         <CAFJ_xboNDcp-XrxfbrBjqTWjLZUdVWe1OJi4KK==ij+yivFeHA@mail.gmail.com>
         <YBSTOrlgTPpzoblY@kernel.org>
         <7a702108-ec9e-b2e2-be89-3590437c0eb5@roeck-us.net>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Sat, 2021-01-30 at 15:49 -0800, Guenter Roeck wrote:
> On 1/29/21 2:59 PM, Jarkko Sakkinen wrote:
> > On Tue, Jan 26, 2021 at 04:46:07PM +0100, Łukasz Majczak wrote:
> > > Hi Jarkko, Guenter
> > > 
> > > Yes, here are the logs when failure occurs -
> > > https://gist.github.com/semihalf-majczak-lukasz/1575461f585f1e7fb1e9366b8eceaab9
> > > Look for a phrase "TPM returned invalid status"
> > > 
> > > Guenter - good suggestion - I will try to keep it as tight as
> > > possible.
> > > 
> > > Best regards,
> > > Lukasz
> > 
> > Is it possible for you try out with linux-next? Thanks. It's a
> > known issue, which ought to be fixed by now.
> > 
> > The log message is harmless, it'a warning not panic, and does not
> > endanger system stability. WARN()'s always dump stack trace. No
> > oops is happening.
> > 
> 
> There is a note in the kernel documentation which states:
> 
> Note that the WARN()-family should only be used for "expected to
> be unreachable" situations. If you want to warn about "reachable
> but undesirable" situations, please use the pr_warn()-family of
> functions.

It fits the definition.  The warning only triggers if the access is in
the wrong locality, which should be impossible, so the warning should
be unreachable.

James

> It seems to me that "harmless" doesn't really fit the expected
> use of WARN(). Should it possibly be converted to pr_warn() ?


