Return-Path: <linux-integrity+bounces-6577-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 498CAAEEB40
	for <lists+linux-integrity@lfdr.de>; Tue,  1 Jul 2025 02:26:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A93D3BC884
	for <lists+linux-integrity@lfdr.de>; Tue,  1 Jul 2025 00:26:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D020A72636;
	Tue,  1 Jul 2025 00:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S2y/R0/v"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D6C242AAF;
	Tue,  1 Jul 2025 00:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751329614; cv=none; b=u7MCVUSwcSEH1Hk+Q6mineQ4OQsp57vMLCm2b12RLzkGWYXtXiqnYRf2ZUNidAdmAw+VNs9gusNo1ZimadzyEEmm3cNU05HBUb6zFOvYg0gD8KsBt0qA1m5VeSXS56GrwAdU5hXKhn4Gt3EIRUFllaclN0HlxQ/MFqWBGUVDtGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751329614; c=relaxed/simple;
	bh=Fmumyu8a2ayYdfXQUUkpkpKLNK8JnwjK2FVutXPhFCM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y1PeGZj5G9X3dq5qAKEoC1kyIRxG7PSAx40qIhl7pp5WgR2Zm+Q83HPUsSUGZvs4XwmV0VxzEtIpj0z9b2g1WY/XREdgxjLGoLfU46p5scKQaqnovXfhGEQ2NiwfUYwyUkvff9d1RzrDGEOHTHEwT3IM2/WR6Fp6OJfUJ9lj11o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S2y/R0/v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6F18C4CEE3;
	Tue,  1 Jul 2025 00:26:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751329614;
	bh=Fmumyu8a2ayYdfXQUUkpkpKLNK8JnwjK2FVutXPhFCM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=S2y/R0/v7OFXpObKUiHDb1PU7VKZwDDBO33VLJdMYUhme3nqJHE6ZvvMNtlCBck59
	 y0AsvClr5A8LJTMmooSLYZXn8HUQBU63nSKksIVykZez33FjxpR5dl/nw88SjkYv2L
	 xaURBkHe3f7O9k7YC8htrApA5lwjdfbE7fbQfpP34advhyW1HYulQ3A0w8bQpbgyie
	 qDHkhJ6CChSO9f1fTL09k4/Eb0MuTV2DJjcIo7TdIDz671kJe0eTwHS7hsNYnhSMu/
	 wqCVEM2Ik7KAZ2gBcpgDuNyF9kqcLTaNTMNZuGtrqw6JB4X66c7vLaYjvP6yvsFKJU
	 lDM3CvYYOAbyg==
Date: Tue, 1 Jul 2025 03:26:50 +0300
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
Subject: Re: [PATCH v3] tpm: Repeal and replace tpm_buf_init*() and
 tpm_buf_destroy()
Message-ID: <aGMrSqY9mojJrPja@kernel.org>
References: <20250701001153.769030-1-jarkko@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250701001153.769030-1-jarkko@kernel.org>

On Tue, Jul 01, 2025 at 03:11:51AM +0300, Jarkko Sakkinen wrote:
> From: Jarkko Sakkinen <jarkko.sakkinen@opinsys.com>
> 
> Repeal and replace tpm_buf_init() and tpm_buf_init_sized() with
> tpm_buf_alloc(), which returns PAGE_SIZE of memory with the struct tpm_buf
> header in the beginning of the returned buffer. This leaves 4088 bytes of
> free space for data.

A minor error: it is now 4090 bytes:

struct tpm_buf {
	u16 flags;
	u16 length;
	u16 handles;
	u8 data[];
};

I guess this should be changed into:

struct tpm_buf {
	u8 flags;
	u8 handles;
	u16 length;
	u8 data[];
}

It's not strictly necessary given that we are already "above the
hardware spec" but it neither makes much sense to keep `handles`
or `flags` 16-bit words with MSB always empty in both of the
words.

BR, Jarkko

