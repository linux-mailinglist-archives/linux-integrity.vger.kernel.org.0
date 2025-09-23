Return-Path: <linux-integrity+bounces-7241-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 322CDB966D5
	for <lists+linux-integrity@lfdr.de>; Tue, 23 Sep 2025 16:52:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E23E322CAF
	for <lists+linux-integrity@lfdr.de>; Tue, 23 Sep 2025 14:47:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50D9C2561AB;
	Tue, 23 Sep 2025 14:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bFGxxdAy"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20DC3184;
	Tue, 23 Sep 2025 14:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758638753; cv=none; b=Cc821TpBkI+5fxzaaU1yLlD2Em9vCS9ypU+Ar42WHdVpNgbmGs0Ug0mHGLdo2CZH3aMSWB32g2bJPctJGFtyx1X735fWtgD5wuAsKTyvKLw892hYyCwueq3TNAD7WDrrNGwdckHl3Cm0DcVz2Lnb6AjQjvKPtzQBT8pneRtMJtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758638753; c=relaxed/simple;
	bh=xSsvjTQQYdPgRsDd8KZtsWmFm6sZCjsNxzcTfLs/L58=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LUekoo33LokhgZta8jq5S3gJUs2UrXeHHrX93lWRaP6RNpMwSEVhMYTQN1gap+GxWyMIMLaqfpa1GauGlhiSdRx0ba+Z0r+VhuS+aHD0CiI9roiFuKAqIsGiMRmSjf0CvH56d2ySb4SmRZS0Q3JKFk/3U3eEUsPlNiIZnvm3Jjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bFGxxdAy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 240E2C113CF;
	Tue, 23 Sep 2025 14:45:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758638752;
	bh=xSsvjTQQYdPgRsDd8KZtsWmFm6sZCjsNxzcTfLs/L58=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bFGxxdAyuxfi0QzzqTdiW6NUIAmaSyYJZJh3mtFGKIyJj3wPzDqH0N9iLiHiMisJC
	 16Wp5QS9Ru4wLxrtLX8sUncbdFiaC+PLn/md1M+wcHTeQ/xpJsy1BHcI4oUqsAl2Lu
	 eSIFhXjvnMmgyPOKbLHwBN07NSPuJnFHDxosal6E5nFM1Hjsrk2GyZKHcm2AyCORB3
	 SLHmrcVlxiobdygREwkNBhrMCWIG+u62NVu9tYLQTnc72MQR+7lmyN6nz81BENWO9J
	 10jbGPrxyPIGXcpVodqdQ9pFsbiffX1rpKUTHFvzfxl40hv3t9jXLCMUdaP6LvL0zY
	 TILXdCYSxx7yQ==
Date: Tue, 23 Sep 2025 17:45:48 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: list.lkml.keyrings@me.benboeckel.net
Cc: linux-integrity@vger.kernel.org,
	Jarkko Sakkinen <jarkko.sakkinen@opinsys.com>,
	Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
	David Howells <dhowells@redhat.com>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	Mimi Zohar <zohar@linux.ibm.com>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:KEYS/KEYRINGS" <keyrings@vger.kernel.org>,
	"open list:SECURITY SUBSYSTEM" <linux-security-module@vger.kernel.org>
Subject: Re: [PATCH 3/4] tpm2-sessions: Remove unnecessary wrapper
Message-ID: <aNKynIx7sW9oxWoj@kernel.org>
References: <20250922164318.3540792-1-jarkko@kernel.org>
 <20250922164318.3540792-4-jarkko@kernel.org>
 <aNGFv-nGZF5chGIb@rotor>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aNGFv-nGZF5chGIb@rotor>

On Mon, Sep 22, 2025 at 01:22:13PM -0400, Ben Boeckel wrote:
> On Mon, Sep 22, 2025 at 19:43:16 +0300, Jarkko Sakkinen wrote:
> > From: Jarkko Sakkinen <jarkko.sakkinen@opinsys.com>
> > 
> > Open code tpm_buf_append_hmac_session_opt() because it adds unnecessary
> > disperancy to the call sites (and reduces the amount of code).
>   ^^^^^^^^^^
> 
> "discrepancy" as in "difference"? But that doesn't feel like the right
> usage either. Perhaps "unnecessary abstraction"? Also, open coding it
> reduces the amount of code, so some clarification to not read as
> something else that "it" (`tpm_buf_append_hmac_session_opt`) does would
> be clearer.

Fair points. I'll re-edit the commit message and try to address the
issues you reported.

Intend of these changes is to essentially uncover the code paths so that
we know how to wrap it up better than it is wrapped up right now. Also,
they help to reveal possible regression paths. So while not functional 
per se, they do serve a purpose.

Once these fixes have been applied I'll start to look up the call
patterns and try to find a model where essentially we can transform
a TPM command to HMAC wrapped TPM command i.e., from tpm_buf to tpm_buf
operation where both sides of the function are TPM commands.

That way we can better selectively use the feature and it is easier
to fixup up e.g., a persistent parent key because key generation is
a huge bottleneck.

> 
> Thanks,
> 
> --Ben

