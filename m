Return-Path: <linux-integrity+bounces-6566-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ACE77AEC40F
	for <lists+linux-integrity@lfdr.de>; Sat, 28 Jun 2025 04:15:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E56E189B05B
	for <lists+linux-integrity@lfdr.de>; Sat, 28 Jun 2025 02:15:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9CFC1C8630;
	Sat, 28 Jun 2025 02:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pqlG7F/w"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5CD83A1B6;
	Sat, 28 Jun 2025 02:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751076897; cv=none; b=G5dlcNlGfHwPB4oLx+cyNCLn8xWAXXja/pE5+chUit+Sl9+uV5rwd6gKLFFKFhhnqUOpKcBuXHcFgJdGI8mnSB/b2ctYAmFBPlK6kLJseMiyZuUk3z1NrWcZLo4ecVW7cc9ABRsYFMrYkgDLZ/5TWvOvtIrVJqS75h7UC7irDh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751076897; c=relaxed/simple;
	bh=t6pVLr1Tzh3nt6Hh1Jez7jmmRCpveeXCaZpPVc1tWEc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oyTh2ppBVDJBoDHp55XwkCiw7mGIikxXSasXqsuMhdWIRa82p+nh5VJL2Dw7PrtGf3U7Jv8aExCcQJ0xoJEc2dpo4xRdBdvj+bmdfsSDBu7vPrASk8O7EPiA+cUB32/y3M8m27NnJFPJzqLcv3DMouxrBdoSqHUIL+2eYGbPyhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pqlG7F/w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D65FAC4CEE3;
	Sat, 28 Jun 2025 02:14:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751076897;
	bh=t6pVLr1Tzh3nt6Hh1Jez7jmmRCpveeXCaZpPVc1tWEc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pqlG7F/wpFW21z8arHkZxp5KoLX1AN61EL81NqKcgYvpMz6jfn/qD0ruyd0nMYntb
	 t8HKMY09cOn+zAbnjGY4hUN+VhGgBI5F7KtjJZI+vqaZhVZ7rO0D1tg4CmD8tiBJIo
	 M3hGxD6ktnK7s1Wh/olmlESEzIc3ULFa2A300/sBpAesTzLgj5qBnPlAi01BkKrJe1
	 azKWhkGGZsWe5Iq34zcM8xQP/cHCJOXYCVrA68zMoZW8Lva66JGsk9OECdS9g1+waJ
	 ZmfMKhi20Sf85kQ+kOUYN6DS5wEsfalqhE/nOYYlFugx6XTPKjSxnClb691qmMV/vj
	 nkMTAnpmgroTw==
Date: Sat, 28 Jun 2025 05:14:53 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: keyrings@vger.kernel.org, Jarkko Sakkinen <jarkko.sakkinen@opinsys.com>,
	Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	Mimi Zohar <zohar@linux.ibm.com>,
	David Howells <dhowells@redhat.com>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	"open list:TPM DEVICE DRIVER" <linux-integrity@vger.kernel.org>,
	"open list:SECURITY SUBSYSTEM" <linux-security-module@vger.kernel.org>
Subject: Re: [PATCH v2] tpm: Cleanup class for tpm_buf
Message-ID: <aF9QHdH9k8x1mVjy@kernel.org>
References: <20250626101935.1007898-1-jarkko@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250626101935.1007898-1-jarkko@kernel.org>

On Thu, Jun 26, 2025 at 01:19:33PM +0300, Jarkko Sakkinen wrote:
> From: Jarkko Sakkinen <jarkko.sakkinen@opinsys.com>
> 
> Create a cleanup class for struct tpm_buf using DEFINE_CLASS(), which will
> guarantee that the heap allocated memory will be freed automatically for
> the transient instances of this structure, when they go out of scope.
> 
> Wrap this all into help macro CLASS_TPM_BUF().
> 
> A TPM buffer can now be declared trivially:
> 
>     CLASS_TPM_BUF(buf, buf_size);

Right, so learning this while doing and probably DEFINE_CLASS() would be
a bad idea :-) There's a better fit in cleanup.h: DEFINE_FREE() and
__free().

Given thatintroduction of tpm_buf_alloc() wipes out tpm_buf_destroy(),
we don't need to create any new wrappers with DEFINE_FREE() as
linux/slab.h has kfree() covered already.

This leads up to "one step backwards" solution i.e., explicitly call
tpm_buf_alloc() and implictly destroy (null checks are left out from
examples):

	struct tpm_buf *buf __free(kfree) = tpm_buf_alloc();
	/* 
	 * I dropped buf_size as it will be gone in v3 as requested by
	 * James earlier.
	 */

	 /* Or: */
	struct tpm_buf *buf2 __free(kfree) = NULL;

	/* ... */
	buf2 = tpm_buf_alloc();

OFF-TOPIC: while doing this patch I noticed maybe 3-5 location where
we have do this:

1. Init something that is more complex to rollback than rolling back
   tpm_buf (which is kfree).
2. Init tpm_buf.
3. After this guaranteed success.

Only reason for doing the rollback for the "more complex to rollback
thing" is that stupid placement of tpm_buf_init(). There's no additional
conditionally failing steps after it.

I need to relocate these code blocks and do a reorders as split patches
and place them to the head of the patch set.

This was mostly reminder for myself :-) 

BR, Jarkko

