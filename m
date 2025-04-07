Return-Path: <linux-integrity+bounces-5633-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15857A7DC32
	for <lists+linux-integrity@lfdr.de>; Mon,  7 Apr 2025 13:26:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 93AE016DFE5
	for <lists+linux-integrity@lfdr.de>; Mon,  7 Apr 2025 11:23:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0AC623A9BA;
	Mon,  7 Apr 2025 11:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W+V5oIbE"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6577E224FD;
	Mon,  7 Apr 2025 11:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744025029; cv=none; b=Lxsj3OS2RSglAQW2zGjqIvtdEHpRod5nDN2Adwxba9F++yXBoxD19A1le3OfYMC+HQVpFuez21BA6PCUKDESNBhmkWDrboA/meEJOGpkDaS2lyjLVWerJld/qaDjGF0PxpEYtdE+cVlu09jJYjbbVTtWcXisqKG7p36y2c5UY0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744025029; c=relaxed/simple;
	bh=sHEKCcrC+aBLI9FEns9XzlFr6q3pm4govj/mFugnWCQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RaEFSpTebGe3uP3o7spCPEoDcQZqP79kNj82sWvonFKwC3DENq+1W+rqYM5pebZPBtkMtsUXvzj1JT1teu3ZElw6Rityh2g+vUEku/7C61bVIxt0fboRCQHBuNufbdTDHTYXpAxHnWPPBnDhU0tmhhxt4FwlCBqDbUS4TzTCCh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W+V5oIbE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C8E3C4CEDD;
	Mon,  7 Apr 2025 11:23:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744025028;
	bh=sHEKCcrC+aBLI9FEns9XzlFr6q3pm4govj/mFugnWCQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=W+V5oIbEuDtHrxQJgqamVnyQwbZkwMLLRJm44TVufYz/3fHfv+aXNOtbiwMPaqL/4
	 W4Fcgak8ZG3CNT59EC3YCAr5iiost2mwp8UhrJnAgWExIETwaXXO4mx5UoQivS4ZBA
	 PzaCk7okiFCtBVxRlrIh/L3eGkph/AhgKfISUQ5YYUVM9J4/fJWc744GE/ebqgauDu
	 f8+IIrs7QNJSuDgw7W846+RjWcwNAMKCYLYTcYC1pTU0/ozrvE2juSmmESRhVEM0o6
	 Yq1o9WQcqKehDJZEbRF0WRvMgEjBLEV7o4flfX+Kgaf902OY1OrnLBpJqS0xkiVnIl
	 6nDHZuaP6hrVg==
Date: Mon, 7 Apr 2025 14:23:43 +0300
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
Message-ID: <Z_O1v8awuTeJ9qfS@kernel.org>
References: <20250407023918.29956-1-jarkko@kernel.org>
 <CGME20250407102514eucas1p1b297b7b6012a5ece4ccdca8e0e2c7956@eucas1p1.samsung.com>
 <32c1e996-ac34-496f-933e-a266b487da1a@samsung.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <32c1e996-ac34-496f-933e-a266b487da1a@samsung.com>

On Mon, Apr 07, 2025 at 12:25:11PM +0200, Marek Szyprowski wrote:
> On 07.04.2025 04:39, Jarkko Sakkinen wrote:
> > From: Jarkko Sakkinen <jarkko.sakkinen@opinsys.com>
> >
> > Add an isolated list of unreferenced keys to be queued for deletion, and
> > try to pin the keys in the garbage collector before processing anything.
> > Skip unpinnable keys.
> >
> > Use this list for blocking the reaping process during the teardown:
> >
> > 1. First off, the keys added to `keys_graveyard` are snapshotted, and the
> >     list is flushed. This the very last step in `key_put()`.
> > 2. `key_put()` reaches zero. This will mark key as busy for the garbage
> >     collector.
> > 3. `key_garbage_collector()` will try to increase refcount, which won't go
> >     above zero. Whenever this happens, the key will be skipped.
> >
> > Cc: stable@vger.kernel.org # v6.1+ Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@opinsys.com>
> This patch landed in today's linux-next as commit b0d023797e3e ("keys: 
> Add a list for unreferenced keys"). In my tests I found that it triggers 
> the following lockdep issue:
> 
> ================================
> WARNING: inconsistent lock state
> 6.15.0-rc1-next-20250407 #15630 Not tainted
> --------------------------------
> inconsistent {SOFTIRQ-ON-W} -> {IN-SOFTIRQ-W} usage.
> ksoftirqd/3/32 [HC0[0]:SC1[1]:HE1:SE0] takes:
> c13fdd68 (key_serial_lock){+.?.}-{2:2}, at: key_put+0x74/0x128
> {SOFTIRQ-ON-W} state was registered at:
>    lock_acquire+0x134/0x384
>    _raw_spin_lock+0x38/0x48
>    key_alloc+0x2fc/0x4d8
>    keyring_alloc+0x40/0x90
>    system_trusted_keyring_init+0x50/0x7c
>    do_one_initcall+0x68/0x314
>    kernel_init_freeable+0x1c0/0x224
>    kernel_init+0x1c/0x12c
>    ret_from_fork+0x14/0x28
> irq event stamp: 234
> hardirqs last  enabled at (234): [<c0cb7060>] 
> _raw_spin_unlock_irqrestore+0x5c/0x60
> hardirqs last disabled at (233): [<c0cb6dd0>] 
> _raw_spin_lock_irqsave+0x64/0x68
> softirqs last  enabled at (42): [<c013bcd8>] handle_softirqs+0x328/0x520
> softirqs last disabled at (47): [<c013bf10>] run_ksoftirqd+0x40/0x68

OK what went to -next went there by accident and has been removed,
sorry. I think it was like the very first version of this patch.

Thanks for informing anyhow!

BR, Jarkko

