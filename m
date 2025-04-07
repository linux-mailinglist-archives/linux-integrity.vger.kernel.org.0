Return-Path: <linux-integrity+bounces-5640-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B9C1A7DE27
	for <lists+linux-integrity@lfdr.de>; Mon,  7 Apr 2025 14:49:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC827168FE5
	for <lists+linux-integrity@lfdr.de>; Mon,  7 Apr 2025 12:49:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CD4B24E00C;
	Mon,  7 Apr 2025 12:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lmUvKk7g"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16B3724110D;
	Mon,  7 Apr 2025 12:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744030152; cv=none; b=RmZv2oF3gwrMxDu7PCLxH8ohc39Lq8R6nic98tOJEmo/wdXp/hJcQ4R/q5sCMY5dFM+oz/Lu1LmfII4zBsxI1J/Pxyb+SpTGuOCAzYvL3NACN0QcLfOROUdTB9V1Uh4h/PLlp10ScHjy80AoYL38//fUGcKR9wlnQ/knTp5he9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744030152; c=relaxed/simple;
	bh=JpHK2GInyOvQWJPGhVG/ljGWZfTBL47D2/o2U5mHtRU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gEj9zoMkYogfPzcm+jZmvqfbeIuT0Y+h1ASF5OIUdXI2h3na4bUeN8ZWPzFUMEa3M0DKajTUNueC/EKtFqaPan6swvhrvBlCuY7wsBny/AvdzEdopuWgrHfWgEoSeIs08IpoDDHkIbH6OIXQOk16yFt8wvE4xgjcXWi6SQWJXII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lmUvKk7g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8329C4CEDD;
	Mon,  7 Apr 2025 12:49:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744030151;
	bh=JpHK2GInyOvQWJPGhVG/ljGWZfTBL47D2/o2U5mHtRU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lmUvKk7gNwvEGxyJTkq6yyYizO5LpuX0UhRDPtkpOl0KsG/EiFppVqw8D6uxs3dqP
	 ruk0I8YegfsiFOrqTLmp6tTjqkvmct2P3EDx6WJ6Nc2eI7CSorJss/A9I+K6ABugla
	 G2WUZAFeLDscvtXzL3I8O4oRXWRAjqLjFaaQQVFV0oI7fz8SNS8AkFp2ycvubfCMtV
	 +pbApiXT1t2GMqZ50bhejLtJ9QofDB4OnGqJWdGG20MdlKumbjU3uuUNlTSx0Ot50e
	 MT9Xu0vRXjvscVdfYo7uDPFdI8fzRwlsfDO/6b025zwVfC3SlvsiFdrRSNJMYop55k
	 T66ywoYl2hNjA==
Date: Mon, 7 Apr 2025 15:49:06 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: keyrings@vger.kernel.org, Jarkko Sakkinen <jarkko.sakkinen@opinsys.com>,
	stable@vger.kernel.org, David Howells <dhowells@redhat.com>,
	Lukas Wunner <lukas@wunner.de>,
	Ignat Korchagin <ignat@cloudflare.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	Mimi Zohar <zohar@linux.ibm.com>, linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
	linux-security-module@vger.kernel.org
Subject: Re: [PATCH v7] KEYS: Add a list for unreferenced keys
Message-ID: <Z_PJwt_d9ISuZJBr@kernel.org>
References: <20250407023918.29956-1-jarkko@kernel.org>
 <CGME20250407102514eucas1p1b297b7b6012a5ece4ccdca8e0e2c7956@eucas1p1.samsung.com>
 <32c1e996-ac34-496f-933e-a266b487da1a@samsung.com>
 <Z_O1v8awuTeJ9qfS@kernel.org>
 <Z_PATvNUE-qBDEEV@kernel.org>
 <377bfc52-db94-4d76-ab47-8076933bc7e7@samsung.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <377bfc52-db94-4d76-ab47-8076933bc7e7@samsung.com>

On Mon, Apr 07, 2025 at 02:42:34PM +0200, Marek Szyprowski wrote:
> On 07.04.2025 14:08, Jarkko Sakkinen wrote:
> > On Mon, Apr 07, 2025 at 02:23:49PM +0300, Jarkko Sakkinen wrote:
> >> On Mon, Apr 07, 2025 at 12:25:11PM +0200, Marek Szyprowski wrote:
> >>> On 07.04.2025 04:39, Jarkko Sakkinen wrote:
> >>>> From: Jarkko Sakkinen <jarkko.sakkinen@opinsys.com>
> >>>>
> >>>> Add an isolated list of unreferenced keys to be queued for deletion, and
> >>>> try to pin the keys in the garbage collector before processing anything.
> >>>> Skip unpinnable keys.
> >>>>
> >>>> Use this list for blocking the reaping process during the teardown:
> >>>>
> >>>> 1. First off, the keys added to `keys_graveyard` are snapshotted, and the
> >>>>      list is flushed. This the very last step in `key_put()`.
> >>>> 2. `key_put()` reaches zero. This will mark key as busy for the garbage
> >>>>      collector.
> >>>> 3. `key_garbage_collector()` will try to increase refcount, which won't go
> >>>>      above zero. Whenever this happens, the key will be skipped.
> >>>>
> >>>> Cc: stable@vger.kernel.org # v6.1+ Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@opinsys.com>
> >>> This patch landed in today's linux-next as commit b0d023797e3e ("keys:
> >>> Add a list for unreferenced keys"). In my tests I found that it triggers
> >>> the following lockdep issue:
> >>>
> >>> ================================
> >>> WARNING: inconsistent lock state
> >>> 6.15.0-rc1-next-20250407 #15630 Not tainted
> >>> --------------------------------
> >>> inconsistent {SOFTIRQ-ON-W} -> {IN-SOFTIRQ-W} usage.
> >>> ksoftirqd/3/32 [HC0[0]:SC1[1]:HE1:SE0] takes:
> >>> c13fdd68 (key_serial_lock){+.?.}-{2:2}, at: key_put+0x74/0x128
> >>> {SOFTIRQ-ON-W} state was registered at:
> >>>     lock_acquire+0x134/0x384
> >>>     _raw_spin_lock+0x38/0x48
> >>>     key_alloc+0x2fc/0x4d8
> >>>     keyring_alloc+0x40/0x90
> >>>     system_trusted_keyring_init+0x50/0x7c
> >>>     do_one_initcall+0x68/0x314
> >>>     kernel_init_freeable+0x1c0/0x224
> >>>     kernel_init+0x1c/0x12c
> >>>     ret_from_fork+0x14/0x28
> >>> irq event stamp: 234
> >>> hardirqs last  enabled at (234): [<c0cb7060>]
> >>> _raw_spin_unlock_irqrestore+0x5c/0x60
> >>> hardirqs last disabled at (233): [<c0cb6dd0>]
> >>> _raw_spin_lock_irqsave+0x64/0x68
> >>> softirqs last  enabled at (42): [<c013bcd8>] handle_softirqs+0x328/0x520
> >>> softirqs last disabled at (47): [<c013bf10>] run_ksoftirqd+0x40/0x68
> >> OK what went to -next went there by accident and has been removed,
> >> sorry. I think it was like the very first version of this patch.
> >>
> >> Thanks for informing anyhow!
> >
> > Testing branch: https://web.git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git/log/?h=keys-graveyard
> >
> > I updated my next this morning so should be fixed soon...
> 
> I've just checked that branch and it still triggers lockdep issue. The 
> following change is needed to get it fixed:
> 
> diff --git a/security/keys/gc.c b/security/keys/gc.c
> index 0a3beb68633c..b22dc93eb4b4 100644
> --- a/security/keys/gc.c
> +++ b/security/keys/gc.c
> @@ -302,9 +302,9 @@ static void key_garbage_collector(struct work_struct 
> *work)
>                  key_schedule_gc(new_timer);
>          }
> 
> -       spin_lock(&key_graveyard_lock);
> +       spin_lock_irqsave(&key_graveyard_lock, flags);
>          list_splice_init(&key_graveyard, &graveyard);
> -       spin_unlock(&key_graveyard_lock);
> +       spin_unlock_irqrestore(&key_graveyard_lock, flags);
> 
>          if (unlikely(gc_state & KEY_GC_REAPING_DEAD_2) ||
>              !list_empty(&graveyard)) {

Oh, it used to be liked this. I managed to mess things up during rebase:

https://lore.kernel.org/keyrings/Z-682XjIjxjAZ9j-@kernel.org/T/#m4a0db2526abb549df3871dec23056350556d4556

Thanks for spotting this, I'll revert it how it used to be in v4.

> 
> Best regards
> -- 
> Marek Szyprowski, PhD
> Samsung R&D Institute Poland
> 
> 
BR, Jarkko

