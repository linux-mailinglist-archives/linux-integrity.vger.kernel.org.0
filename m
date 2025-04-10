Return-Path: <linux-integrity+bounces-5765-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 19630A84397
	for <lists+linux-integrity@lfdr.de>; Thu, 10 Apr 2025 14:48:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA9C3178123
	for <lists+linux-integrity@lfdr.de>; Thu, 10 Apr 2025 12:44:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FEB22853EE;
	Thu, 10 Apr 2025 12:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZLqJuvoJ"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21500204594;
	Thu, 10 Apr 2025 12:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744289038; cv=none; b=GNaXUPZqgvblJgAN5EgtJhO8Eb7b31o+w99aRy00Hcq1rR7ZLl/Up9rP1mGxIapYHsDQc3rEreEmJSIE54Rfiotd1hxlCQjSvf5cVFfds7uolV76/zY+vKzui1cLkexhBHn449wruiDpUCXJSgys74JvhLxt6P8G98FOGKy2yXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744289038; c=relaxed/simple;
	bh=xwaR9XYSdQUCeqfL0a9Vy+BmO2PDEo5QHtWus2v3bRY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nDYQUKD8fiP0UY8i1hSymJZN84Oh+wwJnNNfzIoCEUKApftzbImOVeyMAX4Y9uJQiI8hB4HcOIFdWEXcvCNnQCJMA6MwpnLMc/m4w3u/wYqO8orwIowBrtALPL08QrT0ST00ejQjLrbVTgxku6JKb3qh6DTOJGJx2d+0jDVB8oA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZLqJuvoJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 243FFC4CEDD;
	Thu, 10 Apr 2025 12:43:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744289037;
	bh=xwaR9XYSdQUCeqfL0a9Vy+BmO2PDEo5QHtWus2v3bRY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZLqJuvoJ5+3WOT9aSmeUQ+exzI0Edu08Eaey+hgTkpAGlztGl8YNms2K6alwnWVQC
	 F1H87/409EHH8AzPTksZftTkGX0i1hzqXTDlhh6pBUEuc3An5Pt9tSGxW3GIQdk/GG
	 rgGdZNwd5ZDquE1hdfHh8CvSEMXvhdWPHSHp3FB45b0764MxhrhjiQ7dC7pffHLij5
	 1tWUzX0AYuGxNGELhRH5Agmn0kI47dRa9FPVX+VEjRWEXvkujL+yM4FrdF6+hjStgj
	 pjnLCbEKQZRAjYtUJtESOS+rokE8Et3IdK19uA3VZWkCbU4LIsmXgb+v8Mg82Qv9Ij
	 1zcpH20uKBxrA==
Date: Thu, 10 Apr 2025 15:43:53 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: keyrings@vger.kernel.org
Cc: Jarkko Sakkinen <jarkko.sakkinen@opinsys.com>, stable@vger.kernel.org,
	David Howells <dhowells@redhat.com>, Lukas Wunner <lukas@wunner.de>,
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
Message-ID: <Z_e9CVsmiXD3QYkg@kernel.org>
References: <20250407125801.40194-1-jarkko@kernel.org>
 <Z_VIaxyGoRlg3vyo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z_VIaxyGoRlg3vyo@kernel.org>

On Tue, Apr 08, 2025 at 07:01:47PM +0300, Jarkko Sakkinen wrote:
> On Mon, Apr 07, 2025 at 03:58:01PM +0300, Jarkko Sakkinen wrote:
> > From: Jarkko Sakkinen <jarkko.sakkinen@opinsys.com>
> > 
> > Add an isolated list of unreferenced keys to be queued for deletion, and
> > try to pin the keys in the garbage collector before processing anything.
> > Skip unpinnable keys.
> > 
> > Use this list for blocking the reaping process during the teardown:
> > 
> > 1. First off, the keys added to `keys_graveyard` are snapshotted, and the
> >    list is flushed. This the very last step in `key_put()`.
> > 2. `key_put()` reaches zero. This will mark key as busy for the garbage
> >    collector.
> > 3. `key_garbage_collector()` will try to increase refcount, which won't go
> >    above zero. Whenever this happens, the key will be skipped.
> > 
> > Cc: stable@vger.kernel.org # v6.1+
> > Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@opinsys.com>
> 
> This version is my master branch now:
> 
> https://web.git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git/log/
> 
> For the time being not in next.

I just updated it to my -next, so probably tomorrow will be in
linux-next.

I believe this is absolutely right thing to do but please be aware of
this (now it is *knowingly* applied) and ping me for any issues.

Summaery: it sets walls against using struct key in the middle of
destruction (e.g. when key_put() is accessing it after zero refcount, GC
should never touch it).

BR, Jarkko

