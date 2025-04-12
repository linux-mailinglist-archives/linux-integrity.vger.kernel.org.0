Return-Path: <linux-integrity+bounces-5854-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EDA42A86A13
	for <lists+linux-integrity@lfdr.de>; Sat, 12 Apr 2025 03:30:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 01F8D3B9671
	for <lists+linux-integrity@lfdr.de>; Sat, 12 Apr 2025 01:30:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D426B18E3F;
	Sat, 12 Apr 2025 01:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hWpSOZpC"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93BEF195;
	Sat, 12 Apr 2025 01:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744421424; cv=none; b=QiKSCdwMaNaCX9KhfY7NkyoJdlQXGdK6YTC656yOEK0TneB3iqZn0Xt5bH4vJanStPbKT3PAZAFZw38Ok33OPwtxSF00dv93XBk3IuhozwPJLyH9Rt4cff3Jh1Zhfpr6ny6Cw2Ax0Ly8JF8sBW74XDpaf7+1Wf6nRbebbD7NUuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744421424; c=relaxed/simple;
	bh=Fe0fCF/tuq0mEs3h1dkfZG1C4wSL3OME901B7lp5VWM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NpSIoHTcWWg9JitcdR8zfww/bS+TCr4SuB7AUvjmx+K2ZwtVZffrCMS28Dcya6mI/W9gYVSX3aoiXnJVw6xWSRENa5HnkdS/S49hdifb+BpuneIuRs8KUn+fgIYEUo4unced4RIDFTdOHRh1ohlxoJuAUo+jidG6QNcn7fbdGpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hWpSOZpC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C24FC4CEE2;
	Sat, 12 Apr 2025 01:30:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744421424;
	bh=Fe0fCF/tuq0mEs3h1dkfZG1C4wSL3OME901B7lp5VWM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hWpSOZpChz0odP4hab5Gjam+KIQNYOL3DxmcgCXZWOCt1zkyCRSDLjyiB8bgbDu80
	 TfXpGdKjP20mhhJg2ZSrLH7lKM6BQ8qyjyUwNgQNrM6veTb8dATSyFX+GPAyboOzso
	 cN9ukrMTDuve3WDzWCbjwDZhxCGCkx4iZ+RJj/CySTJFRtq/zbths1zeurg4KHttoA
	 hFfSN56cwUSRgK0eTEtQGMOQ7JC2Gpn+3lKBG2xxoVlfw0tsjrnTwCh0vGQhRXNWfh
	 N31QDE+EkAhoEhsoScIbfk8ZYxIMXKHmON+uuQ/NtagbnsJWNRzDHxG3g4BrBkfk/v
	 1qOnSdS0UyvxA==
Date: Sat, 12 Apr 2025 04:30:20 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: keyrings@vger.kernel.org, Jarkko Sakkinen <jarkko.sakkinen@opinsys.com>,
	stable@vger.kernel.org, Lukas Wunner <lukas@wunner.de>,
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
Subject: Re: [PATCH v8] KEYS: Add a list for unreferenced keys
Message-ID: <Z_nCLHD33VR3un3O@kernel.org>
References: <20250407125801.40194-1-jarkko@kernel.org>
 <2426186.1744387151@warthog.procyon.org.uk>
 <Z_l9f45aO3CqYng_@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z_l9f45aO3CqYng_@kernel.org>

On Fri, Apr 11, 2025 at 11:37:25PM +0300, Jarkko Sakkinen wrote:
> On Fri, Apr 11, 2025 at 04:59:11PM +0100, David Howells wrote:
> > Jarkko Sakkinen <jarkko@kernel.org> wrote:
> > 
> > > +	spin_lock_irqsave(&key_graveyard_lock, flags);
> > > +	list_splice_init(&key_graveyard, &graveyard);
> > > +	spin_unlock_irqrestore(&key_graveyard_lock, flags);
> > 
> > I would wrap this bit in a check to see if key_graveyard is empty so that we
> > can avoid disabling irqs and taking the lock if the graveyard is empty.
> 
> Can do, and does make sense.
> 
> > 
> > > +		if (!refcount_inc_not_zero(&key->usage)) {
> > 
> > Sorry, but eww.  You're going to wangle the refcount twice on every key on the
> > system every time the gc does a pass.  Further, in some cases inc_not_zero is
> > not the fastest op in the world.
> 
> One could alternatively "test_bit(KEY_FLAG_FINAL_PUT, &key->flags)) &&
> !refcount_inc_not_zero(&key->usage))" without mb() on either side and

Refactoring the changes to key_put() would be (draft):

void key_put(struct key *key)
{
	unsigned long flags;

	if (!key)
		return;

	key_check(key);

	if (!refcount_dec_and_test(&key->usage))
		return;

	local_irq_save(flags);

	set_bit(KEY_FLAG_FINAL_PUT, &key->flags);

	/* Remove user's key tracking and quota: */
	if (test_bit(KEY_FLAG_IN_QUOTA, &key->flags)) {
		spin_lock(&key->user->lock);
		key->user->qnkeys--;
		key->user->qnbytes -= key->quotalen;
		spin_unlock(&key->user->lock);
	}

	spin_lock(&key_graveyard_lock);
	list_add_tail(&key->graveyard_link, &key_graveyard);
	spin_unlock(&key_graveyard_lock);

	schedule_work(&key_gc_work);

	local_irq_restore(flags);
}

And:

static bool key_get_gc(struct key *key)
{
	return !test_bit(KEY_FLAG_FINAL_PUT, &key->flags)) &&	/* fast path */
	       refcount_inc_not_zero(&key->usage)		/* slow path */
}

In the gc-loop:

	if (!key_get_gc(&key)) {
		key = NULL;
		gc_state |= KEY_GC_REAP_AGAIN;
		goto skip_dead_key;
 	}

[none yet compiled]

BR, Jarkko

