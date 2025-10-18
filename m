Return-Path: <linux-integrity+bounces-7494-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C38ABECE84
	for <lists+linux-integrity@lfdr.de>; Sat, 18 Oct 2025 13:24:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A4D214E464F
	for <lists+linux-integrity@lfdr.de>; Sat, 18 Oct 2025 11:24:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 084101E520A;
	Sat, 18 Oct 2025 11:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f8U8zij2"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4FB719A2A3;
	Sat, 18 Oct 2025 11:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760786660; cv=none; b=Dg0xfOOjpXDaoG1OJXgSn8J4y6lpXqZROplAKTCdw5t4n9wKXcCqb18tRhqGCnHbQAFP7cyo9Xv6HdrHIx6WK/wvMKksc5T4gAaU5qo9Z7UA6NLGtsfeRwQyM0MT2p9YC9Osj5uGLO+QvgBVUsW7dDX5sE4ErZRZl5z+15+NTxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760786660; c=relaxed/simple;
	bh=vIX+zASVCEWJgvgHuP0y3ZQ3+YtqE6IF2mGxnKPU3/c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kuYg2IW/3Dd+RhvHZrBmlBw1/8pqzgF6IOMiL4bdQ8KahLaI3qQ/89og6nB3e6e2Ch3wc/YLL4NbP+nxVdvTAMp49J2XzkYR3zme4lswrGPatptT5sMhWgkXmAnPrD8nVuRiHECDcYUcB6gk/qsRhkIaS+TqQdiQk4YTPizjHqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f8U8zij2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 401A8C4CEF8;
	Sat, 18 Oct 2025 11:24:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760786660;
	bh=vIX+zASVCEWJgvgHuP0y3ZQ3+YtqE6IF2mGxnKPU3/c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=f8U8zij2IuWdF7RuKtpq8H00vV5AIAKz3SCEdteoXkI6zkf404UAKU+cWnW/6/BE2
	 lRgvaD7MLJvlN0tPuCpJJJTurWimo9JSItGt5KKbR4RWOO428+iI5V1fPKYMth0tWR
	 bHPUVQfYSB7sGk/STLO+UknHGaIB4Wo/6wJPZt9cbxLNNqIGvLtcK+QqrRmdB7PiKs
	 VA6YnNfD04IHPIcaY0dlItgXyEtOred16PWXNu/eRiZqn+WhLmvIi+KhHRGxu3/P3d
	 7SeL/x+Fwo+XVzSRPyQb7TXoLFJrQPOy4/8jy3JEKrx5Geuzkti7MPm6fT+gMCHEid
	 Fc4AcN7IsbGUA==
Date: Sat, 18 Oct 2025 14:24:17 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: Gopi Krishna Menon <krishnagopi487@gmail.com>, zohar@linux.ibm.com,
	James.Bottomley@hansenpartnership.com, corbet@lwn.net,
	Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>,
	Pankaj Gupta <pankaj.gupta@nxp.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org, david.hunter.linux@gmail.com,
	linux-kernel-mentees@lists.linux.dev, khalid@kernel.org
Subject: Re: [PATCH] docs: trusted-encrypted: fix htmldocs build error
Message-ID: <aPN44cFbtIvwnbbY@kernel.org>
References: <20251017181135.354411-1-krishnagopi487@gmail.com>
 <7928c851-649d-47f4-a747-3314c0d45706@infradead.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7928c851-649d-47f4-a747-3314c0d45706@infradead.org>

On Fri, Oct 17, 2025 at 12:27:43PM -0700, Randy Dunlap wrote:
> Adding patch signers.
> 
> Fixes: 95c46f40aac4 ("docs: trusted-encrypted: trusted-keys as protected keys")
> 
> although that might not matter if this patch is only in a -next tree.
> 
> 
> On 10/17/25 11:11 AM, Gopi Krishna Menon wrote:
> > Running "make htmldocs" generates the following build error and
> > warning in trusted-encrypted.rst:
> > 
> > Documentation/security/keys/trusted-encrypted.rst:18: ERROR: Unexpected indentation.
> > Documentation/security/keys/trusted-encrypted.rst:19: WARNING: Block quote ends without a blank line; unexpected unindent.
> > 
> > Add a blank line before bullet list and fix the indentation of text to
> > fix the build error and resolve the warning.
> > 
> > Signed-off-by: Gopi Krishna Menon <krishnagopi487@gmail.com>
> 
> Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
> Tested-by: Randy Dunlap <rdunlap@infradead.org>

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

BR, Jarkko

