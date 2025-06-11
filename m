Return-Path: <linux-integrity+bounces-6428-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C8B9DAD602F
	for <lists+linux-integrity@lfdr.de>; Wed, 11 Jun 2025 22:38:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73BD33A5F8A
	for <lists+linux-integrity@lfdr.de>; Wed, 11 Jun 2025 20:38:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 704A327CCDB;
	Wed, 11 Jun 2025 20:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="EoUvEmL6"
X-Original-To: linux-integrity@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8AE11DFF7;
	Wed, 11 Jun 2025 20:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749674321; cv=none; b=nAJE1ed8Ez4By8iYUWrMrWq3CxmkuJuaQVWN5cEjUQkVVBDOtnygd8dH9eSeaq6HJtbeYtjWEkI9UxExUPeBiF/UuKmwlrJu13U08v/TgP/D1pdVYg0T13TeTndJZdOayHlcfQgzFahPT7eVPTC7EN68ldXdYGUr+kZTPjG66h4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749674321; c=relaxed/simple;
	bh=Fq8ELmuibnelHYrzd1Mzwt71QMVSkNfHVRs9SHbwKbU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W9LKcBL+8Puc3UDwJfLoMqooOo7/IwYf05SxT6Y6zt8/E22s7e3s7INwcWJQ7bSqkKuiV12/R5ywqpElo9N+lauFT+Na5MEW/QeBRZ9tWBFf74waLSYsMobPcDLopg+zKCOJcKBQTTOrNnkhB/y811iAEZxlEvTI30JL9Gvz3cE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=EoUvEmL6; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=xA+/2rvyHlvLh6sMEKRsJ8AH3tUN9/JJhk5cfiv7zYA=; b=EoUvEmL6WVTMg96LSOD4HzjyyK
	GpXRfcZJcRohRPWjWHdUAUYxev0kE4Z4mvgdj95Cjf0VVg6A7khkgJjpEeEa2+Fo3xGQ1V1wM5uin
	QZu1CUW8bTWsiA5ytC0Z4URZ0JSIRTzuMSf8W3l8fa50tHPU7BUJbdv5s5XN87tCDFATwIDFz9Xvz
	pPFwWcjBBDzt1gL6wAcGfLkdRs/0C5b8hOgn1Hob7x1JnCH9YZfkrwh/Jcn3qdFphnle1i9FoZPWf
	k9jOjVOgnKzF4q9uVJfHKKH6wsT7WTQlOxrQdx9sLi3m8hEX6g1wFaTdhab2XpnPkmfa0chhRWl/F
	p8KGJVug==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uPSDS-000000066Qx-3B6L;
	Wed, 11 Jun 2025 20:38:35 +0000
Date: Wed, 11 Jun 2025 21:38:34 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: David Howells <dhowells@redhat.com>, Paul Moore <paul@paul-moore.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Jarkko Sakkinen <jarkko@kernel.org>, keyrings@vger.kernel.org,
	linux-security-module@vger.kernel.org, linux-crypto@vger.kernel.org,
	linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] KEYS: Invert FINAL_PUT bit
Message-ID: <20250611203834.GR299672@ZenIV>
References: <301015.1748434697@warthog.procyon.org.uk>
 <CAHC9VhRn=EGu4+0fYup1bGdgkzWvZYpMPXKoARJf2N+4sy9g2w@mail.gmail.com>
 <CAHk-=wjY7b0gDcXiecsimfmOgs0q+aUp_ZxPHvMfdmAG_Ex_1Q@mail.gmail.com>
 <382106.1749667515@warthog.procyon.org.uk>
 <CAHk-=wgBt2=pnDVvH9qnKjxBgm87Q_th4SLzkv9YkcRAp7Bj2A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgBt2=pnDVvH9qnKjxBgm87Q_th4SLzkv9YkcRAp7Bj2A@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Wed, Jun 11, 2025 at 11:59:19AM -0700, Linus Torvalds wrote:
> On Wed, 11 Jun 2025 at 11:45, David Howells <dhowells@redhat.com> wrote:
> >
> > Do you want a signed tag and git pull for it?
> 
> Particularly during the merge window that makes sense just to make it
> trigger my usual "git pull" pattern, but now that I'm more aware of it
> I can just take the patch directly.
> 
> Anyway - done just to get this behind us. But for next time, just do
> it as a signed tag pull request, _particularly_ during the merge
> window when most other emails get much lower priority.

Speaking of the stuff fallen through the cracks - could you take another
look at https://lore.kernel.org/all/20250602041118.GA2675383@ZenIV/?

