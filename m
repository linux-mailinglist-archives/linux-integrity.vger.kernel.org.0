Return-Path: <linux-integrity+bounces-5144-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 808D0A558EA
	for <lists+linux-integrity@lfdr.de>; Thu,  6 Mar 2025 22:39:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D04837A71F2
	for <lists+linux-integrity@lfdr.de>; Thu,  6 Mar 2025 21:38:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD5C220012D;
	Thu,  6 Mar 2025 21:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eLGaqgkZ"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B76B1151990
	for <linux-integrity@vger.kernel.org>; Thu,  6 Mar 2025 21:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741297147; cv=none; b=j20vzl4Ka0QfSqnLw0ljm61GyiEPqfUVBQRj7KP725qJ/qSdRmX5SGRjm3CqrjLYx64r/tyOLm/psGHSenxmxDAb8z9IyYXyra56iadZSCxzttFva76MvjMzZHqdzEblY+NoifYnBYhg0uVQcJuvftrRyN4j/kz8bkoFiB9TjZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741297147; c=relaxed/simple;
	bh=KJp1Ehqox6k3+xGAMgRcHQbJirXSCp7PcAQYZ8D2h04=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BxyQfQWq4JhYvi34Z6Fe4zLuO7F848/eEF1cDHFjlGAHMfRAQrhT1K01CdHl8LCRTfjCYH439emure3ZHmOKLeN2OLzKjPTiHdfLUWCXj2wjPc/ek1KF053HOtpVvx+mzIrkeTqj6Hgh9sS8jnuChLhtgekWFFz9oCmflLeyKFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eLGaqgkZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5114C4CEE0;
	Thu,  6 Mar 2025 21:39:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741297147;
	bh=KJp1Ehqox6k3+xGAMgRcHQbJirXSCp7PcAQYZ8D2h04=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eLGaqgkZZX9ByFPBmaONg9/XXmWgM7fTT+SjTbsvjDlWq52GyRJkRAE8NNfkho9dC
	 xdQ7NGKXefa2fQKU660wZZ0vxBRQ9Ja5OKSEk/T5RDBPt215G3+XpOU5TI//ln0LS7
	 5yuTZHGGnsgevvmznBm+z/ei7AhMIWGwF5xrhNohxrvjZYA1/FTtao1v3I91ZqOyxp
	 EnkuvfqDY0WGrCOJBnj49y59JRm8cU8qkmdLR73xMB17fqnwry2T13p1V96VKBmJhB
	 c1doHgo2icOgKiZcCZm1C3PSamsmkGhEJ6XAiPZ/5JQDFki2WWQWMPMS0Cq58Q34nc
	 Ygi0ReLl5VJ1Q==
Date: Thu, 6 Mar 2025 23:39:02 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Jonathan McDowell <noodles@earth.li>
Cc: James Bottomley <James.Bottomley@hansenpartnership.com>,
	linux-integrity@vger.kernel.org
Subject: Re: Unbalanced TPM2 HMAC session calls
Message-ID: <Z8oV9lJ4hsHualcP@kernel.org>
References: <Z8m8G0RfiRyYGH_t@earth.li>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z8m8G0RfiRyYGH_t@earth.li>

On Thu, Mar 06, 2025 at 03:15:39PM +0000, Jonathan McDowell wrote:
> We're seeing a lot of:
> 
> tpm tpm0: auth session is active
> 
> messages in our logs. This is emitted (once per boot) by 
> tpm2_start_auth_session() if the auth sessions is already active when it 
> is called.

It's by design actually:

https://web.git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git/commit/?id=df745e25098dc

> Investigating I think this is because tpm2_pcr_extend() calls 
> tpm_buf_append_hmac_session() which sets TPM2_SA_CONTINUE_SESSION so 
> tpm_buf_check_hmac_response() does not cleanup the auth session, but 
> then doesn't call tpm2_end_auth_session().
> 
> Looking at tpm2_get_random() it uses TPM2_SA_CONTINUE_SESSION but *also* 
> cleans up with tpm2_end_auth_session().
> 
> I'd be sending a patch proposing the addition of tpm2_end_auth_session() 
> to the end of tpm2_pcr_extend() but I recall a bunch of discussion 
> about trying to cache the HMAC session to improve IMA performance, so I 
> don't know if perhaps we should be dropping the warning instead?
> 
> (As an aside, I'm not clear dropping the warning is enough, as I can't 
> see where the session otherwise gets cleaned up other than by accident 
> when the RNG tries to get more randomness.)

It would be appropriate action, or relaxing it into pr_debug().

> 
> J.
> 
> -- 
> I've got a trigger inside.

BR, Jarkko

