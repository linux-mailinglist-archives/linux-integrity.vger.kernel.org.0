Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A048309068
	for <lists+linux-integrity@lfdr.de>; Sat, 30 Jan 2021 00:04:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231287AbhA2XBg (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 29 Jan 2021 18:01:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:33840 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231296AbhA2XBg (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 29 Jan 2021 18:01:36 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id DB55D6024A;
        Fri, 29 Jan 2021 23:00:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611961255;
        bh=DZaxE07pVtdgl2l/Xugpjwng1nKYpg85qZ+3fPvMYts=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=p6fKmzQTPtYtS13E+2KWrZc9ffEFVmA/2UL4CEdRIXsUmyWJo+6YOL66kelLBOyOc
         50ajn+BXQKDC74PWlHL/bxknlbG+aVyiQdqLvYwGxok2j7ITF++I/I6BvYpj1aLVYJ
         OHNcjkT8Lp8iD2tmjukTt0ldOMBirFXRQja5GpubbknOHOypN5BCh39imBt54TebUu
         LR13hMRRh1EB2ne+9EatdtxfqO+E92MXnPY4VcBEk4kNQU0RUVSchUu57fu7uTXQCq
         uYMuWeRjE6n+GKSwaXVlWnITWTf6cAyQ/jbIlekGm/Ea7SBXFeJll9vDFqT3AWfwI4
         KPpEG9KLQmLWQ==
Date:   Sat, 30 Jan 2021 01:00:50 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     =?utf-8?Q?=C5=81ukasz?= Majczak <lma@semihalf.com>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        Radoslaw Biernacki <rad@semihalf.com>,
        Marcin Wojtas <mw@semihalf.com>,
        Alex Levin <levinale@google.com>,
        James.Bottomley@hansenpartnership.com
Subject: Re: [PATCH] tpm_tis: Add missing start/stop_tpm_chip calls
Message-ID: <YBSToq5PV+2luy5r@kernel.org>
References: <20210123014247.989368-1-lma@semihalf.com>
 <20210125171846.GA31929@roeck-us.net>
 <CAFJ_xboNDcp-XrxfbrBjqTWjLZUdVWe1OJi4KK==ij+yivFeHA@mail.gmail.com>
 <YBSTOrlgTPpzoblY@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YBSTOrlgTPpzoblY@kernel.org>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Sat, Jan 30, 2021 at 12:59:09AM +0200, Jarkko Sakkinen wrote:
> On Tue, Jan 26, 2021 at 04:46:07PM +0100, Łukasz Majczak wrote:
> > Hi Jarkko, Guenter
> > 
> > Yes, here are the logs when failure occurs -
> > https://gist.github.com/semihalf-majczak-lukasz/1575461f585f1e7fb1e9366b8eceaab9
> > Look for a phrase "TPM returned invalid status"
> > 
> > Guenter - good suggestion - I will try to keep it as tight as possible.
> > 
> > Best regards,
> > Lukasz
> 
> Is it possible for you try out with linux-next? Thanks. It's a known
> issue, which ought to be fixed by now.
> 
> The log message is harmless, it'a warning not panic, and does not
> endanger system stability. WARN()'s always dump stack trace. No oops
> is happening.

The regression itself originates from 2006. It has just been unmasked
with "improved" logging.

/Jarkko
