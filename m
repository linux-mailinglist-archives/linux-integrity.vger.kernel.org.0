Return-Path: <linux-integrity+bounces-6442-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E6994AD6DF3
	for <lists+linux-integrity@lfdr.de>; Thu, 12 Jun 2025 12:37:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 51FAE3A19CA
	for <lists+linux-integrity@lfdr.de>; Thu, 12 Jun 2025 10:36:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AB89280A20;
	Thu, 12 Jun 2025 10:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Adhe+qAt"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3922828032E;
	Thu, 12 Jun 2025 10:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749724356; cv=none; b=HR9vd4/OWcXL9bplXwWjJ2oD9+HN8DI+PtDVGZJCu6v05tPbnIch8bLPM40V1C3fT8+RuT4b1YVjLHOvlJDUNsHBCxzWHVmrfC1v7wQ4Taj7CO6ZvjpUPVGkzGUeOczQxRobRIEzSJVvnDj9gfrf2xrtlnYkZSSpNTYKqmG5SVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749724356; c=relaxed/simple;
	bh=YMnRaTUFakFJLPvl7q3vCoMeTDEm9FrrLwyT1W/42nk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QWGyARZ/hqdTuX+eYNO+aUBuR5YhUiifhjERTQXoGJ6cdvpmMvFEx1tK3rR4TcuOc2TCQjYNM/VagVGQi8o0gNab0pFfcjMA4ddmA7KNpupwpc5p1BIsXULW5erHBowMapr7Hm/wOwFAfZEkulbv5DvcPCAhIrjx/fhJ3TXcvCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Adhe+qAt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B59C7C4CEEA;
	Thu, 12 Jun 2025 10:32:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749724356;
	bh=YMnRaTUFakFJLPvl7q3vCoMeTDEm9FrrLwyT1W/42nk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Adhe+qAttboQeqrW31YXMRcpFEw+Cfjk/7Dd3/UlW2It87CK+vAw8qc/6foHLRNyV
	 k7clu4nQLf4qyHiFyBAkROiQ71bragstzHznsC1EFlSU3kX0B2mIIUwkTe5DgfNxtO
	 ZSzFeJyAaK53rmb66VND8EZguN+12wAIe1ZWu7IWzjZL3V8VA64/ElHHnxEbl6DPPB
	 WO/pWpTY3ky2JQfCfKvqKvwvuzKX5Na2ls9bCTaL2LfsC16MWqY4xsQIERQZWRqAJt
	 QI1CGvBzv2vYovhuI/2UsIdAzmkmZUFdQeU/ipvF8p+VmvSjFsXAJRJun08ICb6VaC
	 LLFf5mqV/c41w==
Date: Thu, 12 Jun 2025 13:32:32 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Paul Moore <paul@paul-moore.com>, David Howells <dhowells@redhat.com>,
	Herbert Xu <herbert@gondor.apana.org.au>, keyrings@vger.kernel.org,
	linux-security-module@vger.kernel.org, linux-crypto@vger.kernel.org,
	linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] KEYS: Invert FINAL_PUT bit
Message-ID: <aEqswAc8nkXVAJH7@kernel.org>
References: <301015.1748434697@warthog.procyon.org.uk>
 <CAHC9VhRn=EGu4+0fYup1bGdgkzWvZYpMPXKoARJf2N+4sy9g2w@mail.gmail.com>
 <CAHk-=wjY7b0gDcXiecsimfmOgs0q+aUp_ZxPHvMfdmAG_Ex_1Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjY7b0gDcXiecsimfmOgs0q+aUp_ZxPHvMfdmAG_Ex_1Q@mail.gmail.com>

On Wed, Jun 11, 2025 at 10:50:46AM -0700, Linus Torvalds wrote:
> On Tue, 10 Jun 2025 at 17:23, Paul Moore <paul@paul-moore.com> wrote:
> >
> > It doesn't look like this has made its way to Linus.
> 
> Bah. It "made it" in the sense that sure, it's in my inbox.
> 
> But particularly during the the early merge window I end up heavily
> limiting my emails to pull requests. And then it ended up composted at
> the bottom of my endless pile of emails.
> 
> I guess I can still take it if people just say "do it".
> 
>             Linus

+1 for picking it.

BR, Jarkko

