Return-Path: <linux-integrity+bounces-6552-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A6D0AEA551
	for <lists+linux-integrity@lfdr.de>; Thu, 26 Jun 2025 20:24:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 019165642C5
	for <lists+linux-integrity@lfdr.de>; Thu, 26 Jun 2025 18:24:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 328D82ED878;
	Thu, 26 Jun 2025 18:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b2RqB/Sa"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 042BF339A8;
	Thu, 26 Jun 2025 18:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750962289; cv=none; b=GJ3+IbqpsXyGvX++PndoP1DAWtfJ7w2DuLvtA8PuHlJMSZwIeFTteSLzArks0MThLvh/+M6Qm0/iaFom7pR42fkfGdWvwBcBIYBkrsKyInYA3++jvKiaNeui4DmDXjJfE17EflNjJr8EblvAR7Z8MfVdVz+zfkCM4kVd/sHR6Qo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750962289; c=relaxed/simple;
	bh=VBO6SHEvPL92Si8JXDGxsZbBfbbb6GTH4PwLlVCETjQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LFKnJh4o6lvIY2d4RuNHL3toefmizbyZvWE8bRKyF9CldkLTp360vmQ7vSgGGg9eKYcxQ6KQ3VVphmUyEzyOLF59CjLarGIjt8lJEq9zPRWwkBqPXqe5QBHo25R9ziwxeVP54qF+yxpP0V+5vSwE+DkixoAc0zmEoaTYlw20MlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b2RqB/Sa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 130D4C4CEEB;
	Thu, 26 Jun 2025 18:24:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750962288;
	bh=VBO6SHEvPL92Si8JXDGxsZbBfbbb6GTH4PwLlVCETjQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=b2RqB/Sa37z1pmwUf2et0REh80ca0rny9ik6MKp+9jaq0ondNbhMOzQDOr1qewbE8
	 2dxOaNe5VhMb6FSAuEbXJp1Vlq6vVEo6WcP2qR5qU3RERjwfM0Xj1KQmmxd4osfxda
	 Vj3YEwuLYls19pYIZZRAIFzIs7hKCNTg9uPoNoKwWYM1oaOt9PRFcODBdzFFXs4CVw
	 wgJRiJakELzF/qhlJzeirczZRE2FlzPG3lXKwcl70tp41rrk6FjLag8Ti86K3Xmq/e
	 hfVpYZ4RIHuO6Xyb7TIN/kvwF8yMlA/Ki+digykq4r4WMKSaBlKZIALMgByxAMBXl9
	 wq0snfhV/44HQ==
Date: Thu, 26 Jun 2025 21:24:44 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: linux-kernel@vger.kernel.org, keyrings@vger.kernel.org,
	Jarkko Sakkinen <jarkko.sakkinen@opinsys.com>,
	Peter Huewe <peterhuewe@gmx.de>,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	Mimi Zohar <zohar@linux.ibm.com>,
	David Howells <dhowells@redhat.com>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	"open list:TPM DEVICE DRIVER" <linux-integrity@vger.kernel.org>,
	"open list:SECURITY SUBSYSTEM" <linux-security-module@vger.kernel.org>
Subject: Re: [PATCH] tpm: Create cleanup class for tpm_buf
Message-ID: <aF2QbDmxzGJS903j@kernel.org>
References: <20250625213757.1236570-1-jarkko@kernel.org>
 <20250626144915.GD213144@ziepe.ca>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250626144915.GD213144@ziepe.ca>

On Thu, Jun 26, 2025 at 11:49:15AM -0300, Jason Gunthorpe wrote:
> On Thu, Jun 26, 2025 at 12:37:56AM +0300, Jarkko Sakkinen wrote:
> > @@ -323,7 +323,7 @@ unsigned long tpm1_calc_ordinal_duration(struct tpm_chip *chip, u32 ordinal)
> >   */
> >  static int tpm1_startup(struct tpm_chip *chip)
> >  {
> > -	struct tpm_buf buf;
> > +	CLASS(tpm_buf, buf)();
> >  	int rc;
> >  
> >  	dev_info(&chip->dev, "starting up the TPM manually\n");
> > @@ -335,7 +335,6 @@ static int tpm1_startup(struct tpm_chip *chip)
> >  	tpm_buf_append_u16(&buf, TPM_ST_CLEAR);
> >  
> >  	rc = tpm_transmit_cmd(chip, &buf, 0, "attempting to start the TPM");
> > -	tpm_buf_destroy(&buf);
> >  	return rc;
> >  }
> 
> So, Linus has spoken negatively about just converting existing code to
> use cleanup.h, fearful it would introduce more bugs.

I did not do this for the sake of conversion. It's just that tpm_buf is
a pretty good fit for such construct, as it is always in function scope
and always heap allocated.

> I would certainly split this into more patches, and it would be nice
> if something mechanical like coccinelle could do the change.

I took this a bit in further:

https://lore.kernel.org/linux-integrity/aF2NNHilFfZwBoxA@kernel.org/T/#t

I did that few dozen times while developing this, running always at
minimum:

1. https://codeberg.org/jarkko/linux-tpmdd-test/src/branch/main/board/pc_x86_64/test_tpm2_kselftest.exp.in
2. https://codeberg.org/jarkko/linux-tpmdd-test/src/branch/main/board/pc_x86_64/test_tpm2_trusted.exp.in

A few times I run some ad-hoc tests too.

And despite 89% is mechanical work there was at least a dozen code
blocks where you need to understand the context too. So actually with
this careful manual work was not that bad idea in the end.

> 
> At least I would add the class and drop the tpm_buf_destroy() as one
> patch, and another would be to cleanup any empty gotos.
> 
> Also, I think the style guide for cleanup.h is to not use the
> variable block, so it should be more like:
> 
> CLASS(tpm_buf, buf)();
> if (!tpm_buf)
>    return -ENOMEM;
> 
> AFAICT, but that seems to be some kind of tribal knowledge.

This was improved in v2 :-) If you have some proposal how you'd
liked that version to be splitted, please give feedback.
> 
> Jason


BR, Jarkko

