Return-Path: <linux-integrity+bounces-6418-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AD152AD5C9D
	for <lists+linux-integrity@lfdr.de>; Wed, 11 Jun 2025 18:47:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 96EAE169151
	for <lists+linux-integrity@lfdr.de>; Wed, 11 Jun 2025 16:47:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 842591E376C;
	Wed, 11 Jun 2025 16:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qvlw2CSX"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44C972E610F;
	Wed, 11 Jun 2025 16:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749660463; cv=none; b=kHkshG5z1kAHnaSWAkXvJcrRzzT0WVd+6Dc3bwoYx9XzraQGC9bPIXQVSkmEJUjKHwj05SG+/wM1Kq/un201Ww2+5EAiLKw1m5mGkj/+toaoD4u75Bo8D6ooG/qBi2vfnEv7+XkWmpiysXQH6mAQ6wSzrjw2R+drNwPvUPCDUQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749660463; c=relaxed/simple;
	bh=ATrbfAkxfXBN7T6ZyMKbNj8vLHFLN6YtT6rOvmO5aG8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RrlOFe3qJdKUVfgmtQVbwsWFYpe3Mn41+ykXpxokhRujue23A9NKQckQU7An9HHn2yLWC5vg6jYpi/vKN+dk1ljBOTox2ld8we3tzQDfFTdQO3LXWiFzD7D8ZvHGisgyenNTUwhXCIiV1vjerJ6QDJIoydq2/J5LfoOENdEFO4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qvlw2CSX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F724C4CEE3;
	Wed, 11 Jun 2025 16:47:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749660461;
	bh=ATrbfAkxfXBN7T6ZyMKbNj8vLHFLN6YtT6rOvmO5aG8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Qvlw2CSX3aAkzEft0go9oT9ndvFJxfQGgKRPZP3YQ/RCO7I0zOIcQFgGoutcVkHuY
	 JzyMlnw6WfR9KWtTb6FNboSdG0wLI1rXjuJPPw+lIVnq4XombBSoOhdvpzguvUp8j7
	 29htLOaPHYUZaJ2K4ySGgQWZd1nu456+II1VORfcjBaJOFtMr0Vfgi38vg35KuEV61
	 JOUbn/ePxyBY8BUgD8m2lJ/e4X0G4VaKpqnBDkDtCgMoWDYrY9/yjEWI61JUiAXqBR
	 2zNNV8YF4Lv6fgjyxyinkmYx5Kvlsa0C29vAp6O2KeQMPAkaHp0CxKyGed+0CGa3FM
	 gzfxEH5tg8Upw==
Date: Wed, 11 Jun 2025 19:47:38 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Paul Moore <paul@paul-moore.com>
Cc: David Howells <dhowells@redhat.com>, torvalds@linux-foundation.org,
	Herbert Xu <herbert@gondor.apana.org.au>, keyrings@vger.kernel.org,
	linux-security-module@vger.kernel.org, linux-crypto@vger.kernel.org,
	linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] KEYS: Invert FINAL_PUT bit
Message-ID: <aEmzKhXJ_nc4que3@kernel.org>
References: <301015.1748434697@warthog.procyon.org.uk>
 <CAHC9VhRn=EGu4+0fYup1bGdgkzWvZYpMPXKoARJf2N+4sy9g2w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHC9VhRn=EGu4+0fYup1bGdgkzWvZYpMPXKoARJf2N+4sy9g2w@mail.gmail.com>

On Tue, Jun 10, 2025 at 08:22:59PM -0400, Paul Moore wrote:
> On Wed, May 28, 2025 at 8:19 AM David Howells <dhowells@redhat.com> wrote:
> >
> > Hi Linus,
> >
> > Could you apply this, please?  There shouldn't be any functional change,
> > rather it's a switch to using combined bit-barrier ops and lesser barriers.
> > A better way to do this might be to provide set_bit_release(), but the end
> > result would be much the same.
> >
> > Thanks,
> > David
> > ---
> > From: Herbert Xu <herbert@gondor.apana.org.au>
> >
> > KEYS: Invert FINAL_PUT bit
> >
> > Invert the FINAL_PUT bit so that test_bit_acquire and clear_bit_unlock
> > can be used instead of smp_mb.
> >
> > Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
> > Signed-off-by: David Howells <dhowells@redhat.com>
> > Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
> > cc: keyrings@vger.kernel.org
> > cc: linux-security-module@vger.kernel.org
> > cc: linux-crypto@vger.kernel.org
> > cc: linux-integrity@vger.kernel.org
> > ---
> >  include/linux/key.h |    2 +-
> >  security/keys/gc.c  |    4 ++--
> >  security/keys/key.c |    5 +++--
> >  3 files changed, 6 insertions(+), 5 deletions(-)
> 
> It doesn't look like this has made its way to Linus.  David or Jarkko,
> do one of you want to pick this up into a tree and send this to Linus
> properly?

I'm open for anything but need comment from David at first. It is up to
him as he carries the torch ATM for this one :-)

BR, Jarkko

