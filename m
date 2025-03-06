Return-Path: <linux-integrity+bounces-5149-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F3ABA559C2
	for <lists+linux-integrity@lfdr.de>; Thu,  6 Mar 2025 23:29:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 683313B161A
	for <lists+linux-integrity@lfdr.de>; Thu,  6 Mar 2025 22:29:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B69CB27C854;
	Thu,  6 Mar 2025 22:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZiuvMyO7"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 923E927C850
	for <linux-integrity@vger.kernel.org>; Thu,  6 Mar 2025 22:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741300150; cv=none; b=K3DnPPAsm9+2kW2yxOSwllokRwPJj2fkdWoxpwD0iawTJi2IUoR9GIsbM+ZBx+4K9D0G7RWYj13ePk1T8JE18hM8dSb0cpdZepCwv8KJFE8gIBHwM2BRsWVZ+PV6o+NRrVIqHhxyCAHwiUpJEuk5BWfYkiz/Hfd9RTN/b1gE3+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741300150; c=relaxed/simple;
	bh=idcpkxXpjgJGKWjncJnzWdYR9BQAgIZe0hWy2FGkRIc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pik0dgJWOfp2+gTVDPKtbEKAomFjxwYCztb8ynKbs2KZKX4TWsq2mzdDZSFkvswJpfrW7QuA6+rOiTUhKcyrwUg8J/hbA/RNdqPxeG2syuG626kKTQ/LvgiUlCARLBcjfYmMAD90AC0Lu5aYn2oE7UG0Y5W8kR4cQGkInwubkgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZiuvMyO7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72CE4C4CEE0;
	Thu,  6 Mar 2025 22:29:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741300150;
	bh=idcpkxXpjgJGKWjncJnzWdYR9BQAgIZe0hWy2FGkRIc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZiuvMyO7QhgBUUvmF7tep5a6rvcCZpCaFL5HYv+YysJYXbw95hZwPtBYaswB9wVt0
	 KQ2WH9m30eHua6ELC9VYFRD8WUoMINALN7+vYwn+aRy50UijGSWDzGIa1Df/4IDjWB
	 AHt/2W1/FUhGBZOZWx5UeONShPfqNIi5MZe3p9WXqMxwCTfXHGfxtCABNuVWTFl2ZD
	 J4gNQLuRifVFMNWe5I5rWJ1jL28yYET3dQY3NAd0w+ykjtJLAJo7GWLHGj9F1xbfFf
	 2BDzMAB6hJdBhy5RFxNtc9NNrHD4KhFgstzVVJaV7ze/6lvdPhrLXgkf+65CQyi1RF
	 NHspqyazAi9FA==
Date: Fri, 7 Mar 2025 00:29:05 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
Cc: Jonathan McDowell <noodles@earth.li>, linux-integrity@vger.kernel.org
Subject: Re: TPM operation times out (very rarely)
Message-ID: <Z8ohsf1Y9eVL8Egx@kernel.org>
References: <Z6Nm7Y8TFF8YG56Z@kitsune.suse.cz>
 <Z6N10NQY75hpX0Ed@earth.li>
 <Z6UdFCdqCNZ8VGOL@kernel.org>
 <Z6XRuFnEXeQI_rEZ@earth.li>
 <Z6e-w2YT6hFOyFiP@kernel.org>
 <Z6om1DIcDW3b0fAh@earth.li>
 <D7OY20MS7TAI.3N7Z569U7SH0N@kernel.org>
 <Z7xuTRrJqeSDH4hR@kitsune.suse.cz>
 <Z8JtQ4qKSjKsJZ52@kernel.org>
 <Z8hBnRzD-M2pR-pw@kitsune.suse.cz>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z8hBnRzD-M2pR-pw@kitsune.suse.cz>

On Wed, Mar 05, 2025 at 01:20:45PM +0100, Michal Suchánek wrote:
> On Sat, Mar 01, 2025 at 04:13:23AM +0200, Jarkko Sakkinen wrote:
> > On Mon, Feb 24, 2025 at 02:04:13PM +0100, Michal Suchánek wrote:
> > > On Mon, Feb 10, 2025 at 07:32:53PM +0200, Jarkko Sakkinen wrote:
> > > > On Mon Feb 10, 2025 at 6:18 PM EET, Jonathan McDowell wrote:
> > > > > Who then handles the ERESTARTSYS though? Part of the issues we've seen
> > > > > is the failure happens in a context save or load, which is all within
> > > > > the kernel rather than directly under the control of userspace. I'm
> > > > > guessing the HMAC changes are likely to hit similar problems. I think
> > > > > some level of timeout improvement in tpm_transmit is appropriate, if we
> > > > > can work out what it should be.
> > > > 
> > > > Right I get what you mean, not all transmits initiate from syscalls
> > > > And obviously this can happen without hmac too with tpmrm0.
> > > > 
> > > > Hmm... so I'm open for a patch that radically simplifies the state
> > > > change timeouts, i.e. sort of part of that old patch.
> > > 
> > > There is also another aspect to this:
> > > 
> > > What happens when the context save/load result is dropped on the floor?
> > 
> > Trying to understand what are you meaning by this. Are you speaking
> > about scenario where after the operation context operations fail
> > inside kernel?
> 
> I am speaking about the scenario when the opration succeeds but the
> kernel declares it a failure because it did not happen within the
> timeout.

OK got it, thanks.

I guess theoretically we could even never do timeout and let the caller
SIGINT.

> 
> Thanks
> 
> Michal

BR, Jarkko

