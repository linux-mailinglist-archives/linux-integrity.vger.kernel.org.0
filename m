Return-Path: <linux-integrity+bounces-5453-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9066BA7200C
	for <lists+linux-integrity@lfdr.de>; Wed, 26 Mar 2025 21:37:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 259B3168CC4
	for <lists+linux-integrity@lfdr.de>; Wed, 26 Mar 2025 20:37:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82FA52192E2;
	Wed, 26 Mar 2025 20:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iefXod47"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A7DA137930;
	Wed, 26 Mar 2025 20:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743021434; cv=none; b=SUYMGKDIMHez2bO6NqZjNxsMcf51oI4Jl4AA6WW1NpW306GGlRo0MtNAmgKgQEpSuFWJtr7I6SXsfrgXwCFN4uV9kas7rmyFRqnObJFqy8wr5xFFic+Yb1Xr/tD156OlOk7pH8p6tCqy6zBtLfPl2bGvao6eilBs+dvEUvV4aH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743021434; c=relaxed/simple;
	bh=gIUYBjs4qNqH+FWbyydKPm0g0LeEniBPBOuD5tjT/jU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fiCHKwoMyT8oPimKy+BvweKWzvJtdMH+Pt5eRnrtBzMXxVr8EAWIAdIUEhcXn3psmyuuJD+/VDIjmK7RMD5rGZIRNTaiRBhSLdFOvbALyOXi9RnX+Od5iKNv9O8iUqOY9ECYOzS3BXVJ6Jb6ZtNjG+fL2SzWMOPv6fZdo9lE6rM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iefXod47; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5732DC4CEE2;
	Wed, 26 Mar 2025 20:37:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743021433;
	bh=gIUYBjs4qNqH+FWbyydKPm0g0LeEniBPBOuD5tjT/jU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iefXod47v80rjYS9tmKEVnrdQcLbbHnNFkHyx2VIVSxFtce+oKh6VgmUIrq678PW0
	 fAgLSea5kBsK+ldIfMsv2r0UkNp/yUDJG2qZQPpEYSsbep8VWNh6sGv74SshB6rR/N
	 Z8mp3+a2Tj9ulAhRvVKLjGTvXcFmnKgrOhZPlQVcqYszGxkKhnPJs1kjwhvJXx175N
	 xYuvMLbQOfv5ulWstchROj8Odr2Q1uY03hDwj+0O6TMhPlRrGT8lBpPpqa5p9JTeVH
	 589do7rnBDDPMrC0maIvdzzhIC6lP3sPzS5KIwjfn3wmxbEqD1mNXq2a7slDQ39l+U
	 qf1al/wdbyphw==
Date: Wed, 26 Mar 2025 22:37:09 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Sumit Garg <sumit.garg@kernel.org>,
	Stefano Garzarella <sgarzare@redhat.com>,
	linux-kernel@vger.kernel.org, Peter Huewe <peterhuewe@gmx.de>,
	linux-integrity@vger.kernel.org,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	Jens Wiklander <jens.wiklander@linaro.org>
Subject: Re: [PATCH 2/2] tpm/tpm_ftpm_tee: use send_recv() op
Message-ID: <Z-RlbEN9BoKnTN2E@kernel.org>
References: <20250320152433.144083-1-sgarzare@redhat.com>
 <20250320152433.144083-3-sgarzare@redhat.com>
 <Z-I86tWMcD6b_YeM@sumit-X1>
 <Z-Pu4FhcntnKii61@kernel.org>
 <Z+QQWe/upJuVpU8r@ziepe.ca>
 <Z-QV5y1JGBDpsPuH@kernel.org>
 <Z-QkGUenPAMid63l@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z-QkGUenPAMid63l@kernel.org>

On Wed, Mar 26, 2025 at 05:58:33PM +0200, Jarkko Sakkinen wrote:
> On Wed, Mar 26, 2025 at 04:57:47PM +0200, Jarkko Sakkinen wrote:
> > On Wed, Mar 26, 2025 at 11:34:01AM -0300, Jason Gunthorpe wrote:
> > > On Wed, Mar 26, 2025 at 02:11:12PM +0200, Jarkko Sakkinen wrote:
> > > 
> > > > Generally speaking I don't see enough value in complicating
> > > > callback interface. It's better to handle complications in
> > > > the leaves (i.e. dictatorship of majority ;-) ).
> > > 
> > > That is very much not the way most driver subsystems view the
> > > world. We want to pull logical things into the core code and remove
> > > them from drivers to make the drivers simpler and more robust.
> > > 
> > > The amount of really dumb driver boiler plate that this series
> > > obviously removes is exactly the sort of stuff we should be fixing by
> > > improving the core code.
> > > 
> > > The callback interface was never really sanely designed, it was just
> > > built around the idea of pulling the timout processing into the core
> > > code for TIS hardware. It should be revised to properly match these
> > > new HW types that don't have this kind of timeout mechanism.
> > 
> > Both TIS and CRB, which are TCG standards and they span to many
> > different types of drivers and busses. I don't have the figures but
> > probably they cover vast majority of the hardware.
> > 
> > We are talking about 39 lines of reduced complexity at the cost
> > of complicating branching at the top level. I doubt that there
> > is either any throughput or latency issues.
> > 
> > What is measurable benefit? The rationale is way way too abstract
> > for me to cope, sorry.
> 
> E.g., here's how you can get rid of extra cruft in tpm_ftpm_tee w/o
> any new callbacks.

Measurable benefit: no need to allocate memory buffer.

Let's take that as a starting point ;-)

On that basis I can consider this (i.e. something to measure).

BR, Jarkko

