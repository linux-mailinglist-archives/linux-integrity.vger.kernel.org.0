Return-Path: <linux-integrity+bounces-5033-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 41439A4A7E3
	for <lists+linux-integrity@lfdr.de>; Sat,  1 Mar 2025 03:13:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C2D7177C2C
	for <lists+linux-integrity@lfdr.de>; Sat,  1 Mar 2025 02:13:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0275C1A7264;
	Sat,  1 Mar 2025 02:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B6oKt3Fo"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D243A1A23BE
	for <linux-integrity@vger.kernel.org>; Sat,  1 Mar 2025 02:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740795207; cv=none; b=ZnUKL6OpYkxEnMX5prkfyGSf8eEKKpXDN+nQurrJ3IzI1orDaIDi98z0TaWM5vo19m4KqSjwOHUKU+F6BhfMtNlmv+5W2ngiPR4GDvs+VyCsEoYf2+9ObRgfcyp9vobcD/p/Q5LglJJRIM8CuoUhcssZBrFVezPiSaljifD4nZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740795207; c=relaxed/simple;
	bh=0ub4O/TyeKtd7xXnrR9h0s5sKrmitnCN7oJiiSFdGyQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=advPGJ/r688+1cnxg2f47z4P5T0dXN8wwfzYtfSLnh1ypn6DRwznfWVjjfrVI/PodRoWxRRWWN6q65nAefBvT0wkEsVzwgZAlDFzIcDa1CMZC0vbk359qffXiNpQQcgpq3F9/quEzsa0lOA754E+cJ3CK4XkpM85ur+/6BLLfVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B6oKt3Fo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8FE8C4CEE5;
	Sat,  1 Mar 2025 02:13:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740795207;
	bh=0ub4O/TyeKtd7xXnrR9h0s5sKrmitnCN7oJiiSFdGyQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=B6oKt3Fo5WACO6AxT+0sDjYXRLId+y+mp5klsqO9c0zbD0lDJeh6xjJPZHh4oQlbZ
	 yiN/GTc9MlWIjC/CjDAMhTD/cuk8j9Ae8GKYLUR94fFt5QCLDqPYPOFGRF/nVOJHV/
	 qOS+NHqN4hx1zWN9MuEFSe3RgcYA7Q94xNtqLvPlmqjbOvfprjQWQtQLHdQ5uVRvOq
	 2VzQkjeNwtY9V1tgSzr5J8xGzRl1S4LTMlPwMpidnBpJ8WgalisRfLDR6BWpHFdjeR
	 xGPUlEHGVF2+b6O+mh0NMcyfAr+BSyKqf/7qKol1BtJKJ9kZWt9kghFzfM/yfQEh9P
	 GS5eLebcub9Yg==
Date: Sat, 1 Mar 2025 04:13:23 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
Cc: Jonathan McDowell <noodles@earth.li>, linux-integrity@vger.kernel.org
Subject: Re: TPM operation times out (very rarely)
Message-ID: <Z8JtQ4qKSjKsJZ52@kernel.org>
References: <Z50IKdYe42_n2B0b@kitsune.suse.cz>
 <D7GIBDO5KJMD.118CQO10LJ79Y@kernel.org>
 <Z6Nm7Y8TFF8YG56Z@kitsune.suse.cz>
 <Z6N10NQY75hpX0Ed@earth.li>
 <Z6UdFCdqCNZ8VGOL@kernel.org>
 <Z6XRuFnEXeQI_rEZ@earth.li>
 <Z6e-w2YT6hFOyFiP@kernel.org>
 <Z6om1DIcDW3b0fAh@earth.li>
 <D7OY20MS7TAI.3N7Z569U7SH0N@kernel.org>
 <Z7xuTRrJqeSDH4hR@kitsune.suse.cz>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z7xuTRrJqeSDH4hR@kitsune.suse.cz>

On Mon, Feb 24, 2025 at 02:04:13PM +0100, Michal Suchánek wrote:
> On Mon, Feb 10, 2025 at 07:32:53PM +0200, Jarkko Sakkinen wrote:
> > On Mon Feb 10, 2025 at 6:18 PM EET, Jonathan McDowell wrote:
> > > Who then handles the ERESTARTSYS though? Part of the issues we've seen
> > > is the failure happens in a context save or load, which is all within
> > > the kernel rather than directly under the control of userspace. I'm
> > > guessing the HMAC changes are likely to hit similar problems. I think
> > > some level of timeout improvement in tpm_transmit is appropriate, if we
> > > can work out what it should be.
> > 
> > Right I get what you mean, not all transmits initiate from syscalls
> > And obviously this can happen without hmac too with tpmrm0.
> > 
> > Hmm... so I'm open for a patch that radically simplifies the state
> > change timeouts, i.e. sort of part of that old patch.
> 
> There is also another aspect to this:
> 
> What happens when the context save/load result is dropped on the floor?

Trying to understand what are you meaning by this. Are you speaking
about scenario where after the operation context operations fail
inside kernel?

> 
> There was other call that can take a very long time: get random number.
> And while dropping a random number that took a long time ito fabricate
> on the floor is wasteful it does not cause any real problem.
> 
> With the context save/load, however, the context state gets
> desynchronized between TPM and kernel when the result of the call is
> ignored.
> 
> If the kernel cannot correct the state by examining return value from
> later calls the TPM can effectively become defunct because the kernel
> will call the wrong context operation, it will return unexpected value
> which the kernel interprets as failure, and no operation can be
> performed.

I got lost in the beginning so not yet sure about this (not same
as rejecting, also I'm responding from holiday).

Not really sure if this related but I'll just this here.

We could possibly identify some expensive TPM commands that
fill these requirements:

1. Don't run in a session.
2. Don't cause handles to be created (neither sessions nor
   objects).

and executed as they were put to /dev/tpm0. At least we might
be able to do this for TPM2_GetRandom.

> 
> Thanks
> 
> Michal


BR, Jarkko

