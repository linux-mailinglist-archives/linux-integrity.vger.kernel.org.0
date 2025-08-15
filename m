Return-Path: <linux-integrity+bounces-6865-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 22042B28566
	for <lists+linux-integrity@lfdr.de>; Fri, 15 Aug 2025 19:52:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E4F81CC090B
	for <lists+linux-integrity@lfdr.de>; Fri, 15 Aug 2025 17:53:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A5FF3A8F7;
	Fri, 15 Aug 2025 17:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sfbc8BHa"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F61F317719;
	Fri, 15 Aug 2025 17:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755280357; cv=none; b=U0ZyU8XL0sD5tJjAoLJ2Xdp1mpRxvs6QwKVSdQtildbeZ7OQA/bRB6Rb5fqlUHWE4Y7ul38uXXj8MV0jpduXMsIR6BfwM8FHe5dY8W3iSECK+G0sso9cppq5gHZox9mMZeQlMOM/SQu1Z3po3de1NnVB4FDFOZATUeK8OJNkOwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755280357; c=relaxed/simple;
	bh=tSHfQko4/bqiLMtZRtdkBpP4HPUP+eNAQUQJEiHyBEA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eEXRIPxw9CeDw1Vj9ON+4lCunDoeYql9jKJWFwdRArz8icLqa+Cva3oC39pFqOhZcLzHTH4WrBVvi+Rxjwj9WrpnL0FEFR48T4sVtrbxKuD95qZL0V7hFiaPOQzoVz5fq7CitY6MIbD1T8Ed5q6Je5AUgb0srf5/bE5s3S7fWmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sfbc8BHa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38A2FC4CEEB;
	Fri, 15 Aug 2025 17:52:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755280355;
	bh=tSHfQko4/bqiLMtZRtdkBpP4HPUP+eNAQUQJEiHyBEA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sfbc8BHacBOP1lEvUVBWDlS7/449bdzcLhHMsAZHs29O533mvjanrmi8CG98/oNLc
	 QRnzgCGWGoBT1GhNRkx4LWDVDSklzlEv4coXuhEKlviIlhIpbo5BzBiWF+/rY0/4Sx
	 AOOUJA05FsxJxhYC+MXe0VVgW4fzj7+byEXjJntoQybca5zs8LDd2OQZXYS1bgIVlf
	 ouA35o8iav4vBC7DOZLXxfm3g82yJObqWacUIV0D+42CsF7CHF1RHy+IVVtUUgtzQ/
	 afa3mKte9kn2jFMvMC83lCi7bguPpCPisDcnJymV7z0mnBsPYly41jrd9uXhYKdA1y
	 kP0f2lDJt4dcg==
Date: Fri, 15 Aug 2025 20:52:32 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Chris Fenner <cfenn@google.com>
Cc: Jarkko Sakkinen <jarkko.sakkinen@iki.fi>,
	Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
	linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tpm: Disable TCG_TPM2_HMAC by default
Message-ID: <aJ9z4OlwvFdEA2Q_@kernel.org>
References: <20250814162252.3504279-1-cfenn@google.com>
 <aJ8iNLwlf4PAC0h1@kernel.org>
 <CAMigqh1RTVzz0ffY8M3mZuc7NDaBKpMmCU4q0LuNyM2eAi+NFg@mail.gmail.com>
 <aJ9fy_sO6tza9qLF@iki.fi>
 <CAMigqh2=Kmnv_rrT-gBtESSXtnMrxU=VJdrYE6_9NGhKBN+ZrA@mail.gmail.com>
 <aJ9ySGv0JZ0DiNgf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aJ9ySGv0JZ0DiNgf@kernel.org>

On Fri, Aug 15, 2025 at 08:45:48PM +0300, Jarkko Sakkinen wrote:
> On Fri, Aug 15, 2025 at 10:06:36AM -0700, Chris Fenner wrote:
> > On Fri, Aug 15, 2025 at 9:27 AM Jarkko Sakkinen <jarkko.sakkinen@iki.fi> wrote:
> > 
> > > I'll with shoot another proposal. Let's delete null primary creation
> > > code and add a parameter 'tpm.integrity_handle', which will refers to
> > > persistent primary handle:
> > 
> > I'm not yet sure I understand which handle you mean, or what you're
> > proposing to do with it. Could you elaborate?
> 
> Primary key persistent handle.
> 
> In tpm2_start_auth_session() there's
> 
> 	/* salt key handle */
> 	tpm_buf_append_u32(&buf, null_key);
> 
> Which would become
> 
> 	/* salt key handle */
> 	tpm_buf_append_u32(&buf, integrity_handle);
> 
> And in beginning of exported functions from tpm2-sessions.c:
> 
> 	if (!integrity_handle)
> 		return 0;
> 
> And delete from same file:
> 
> 	1. tpm2_create_*()
> 	2. tpm2_load_null()
> 
> That way the feature makes sense and does not disturb the user who don't
> want it as PCRs and random numbers will be integrity proteced agains an
> unambiguous key that can be certified.

E.g., for example that will unquestionably harden IMA exactly for the
same reasons why some user space software might to choose to use HMAC
based integrity protection.

At data center, there's guards and guns but for appliences, but there
is also the market appliances, home server products etc. They are not
mobile but neither they are protected in the same as e.g., a data
center is.

This is not to admit that right now the feature is no good to anyone
but in a selected set of use cases with this modification it would
make e.g., IMA's security *worse* than it would be with the feature
enabled.

BR, Jarkko

