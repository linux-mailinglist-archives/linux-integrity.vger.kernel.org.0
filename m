Return-Path: <linux-integrity+bounces-5757-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DE6B3A83DB0
	for <lists+linux-integrity@lfdr.de>; Thu, 10 Apr 2025 11:00:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9BDFA3AE2BF
	for <lists+linux-integrity@lfdr.de>; Thu, 10 Apr 2025 08:57:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48F3220B80C;
	Thu, 10 Apr 2025 08:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W2SmaSST"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21454204594;
	Thu, 10 Apr 2025 08:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744275460; cv=none; b=GgM4IAXPqdymFLhg/HKwr0qkROacus27zkdzqoJjurJbh8aHTrl/A1xfLtPk+Gm/jqRGr11F451xvhSWEXIhNdx2+LlMvxvOTW2T7Q7xM3YGhWfMEs+6jk86wRgCcQe1ZSGZEkI+FJcssfm0zibdHsEnVYc9rZo8nKMxkig8zMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744275460; c=relaxed/simple;
	bh=kMQ2qLgDzPxHkEZrtpPSbHZJxyC8GPGP+Gcz7m4/g6o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JqyTOkXgxnQ7BctRc2zbyhkkJm+eQQGSn+PK/LZAyatpar8THOu4wn3kP1AyrWwpZxGBMsxuXm7FbNxG3jA3whCGwFT4HORSVT+hQ8qTvpJG7IXFPTZkR1ywzmgyWo7TnlY+UisxIP3xZer1sM+alEG+j9Oldg1FqzuhQh/vygo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W2SmaSST; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C07BC4CEDD;
	Thu, 10 Apr 2025 08:57:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744275459;
	bh=kMQ2qLgDzPxHkEZrtpPSbHZJxyC8GPGP+Gcz7m4/g6o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=W2SmaSSTJQ99d14lHEC3mA9n4DhjLcXShkGIIuKbIFrR4em29b8zHAnKomrmRY1V4
	 z+vD4/2rDtwKLy+S109ZKK7nsRsWseZapK4MHk4/H99xxLnC657Kt/N2iGqNjuZ/eF
	 nylE+dSCbkZWweha9KpGAHYUN9QMRxpNZVzGhpPPU2vMp1kXeoO1spv76KRXN6Q8qv
	 HiyiQtxIUTtiCyvE0rJURaqB7PaEnRndxfWAiJn4z4DMPOK531rOC52Cy4I1m1T0QM
	 DbPV0ufXqJFxdwyaYRKmOW9qa59s9fre0Qb62z3BFKtB0BEbNyj7ZxvRCtuvfNQEK2
	 OjI30BnKKCCTw==
Date: Thu, 10 Apr 2025 11:57:36 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Purva Yeshi <purvayeshi550@gmail.com>
Cc: Stefano Garzarella <sgarzare@redhat.com>, peterhuewe@gmx.de,
	jgg@ziepe.ca, linux-integrity@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] char: tpm: tpm-buf: Fix uninitialized return values in
 read helpers
Message-ID: <Z_eIAOSZZv4zJWVO@kernel.org>
References: <20250409205536.210202-1-purvayeshi550@gmail.com>
 <Z_dh4tRIa6xxAWQ2@kernel.org>
 <t2ri7facyvtmt6rx6xwcjos7rgtyiln7cywl2gt4effgukeejc@f3ml4apdh4zs>
 <fab2bb2d-a78e-4130-a5fd-bf07430210c7@gmail.com>
 <Z_eHei1jT0YoPgki@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z_eHei1jT0YoPgki@kernel.org>

On Thu, Apr 10, 2025 at 11:55:22AM +0300, Jarkko Sakkinen wrote:
> On Thu, Apr 10, 2025 at 02:12:07PM +0530, Purva Yeshi wrote:
> > On 10/04/25 13:21, Stefano Garzarella wrote:
> > > On Thu, Apr 10, 2025 at 09:14:58AM +0300, Jarkko Sakkinen wrote:
> > > > On Thu, Apr 10, 2025 at 02:25:36AM +0530, Purva Yeshi wrote:
> > > > > Fix Smatch-detected error:
> > > > > drivers/char/tpm/tpm-buf.c:208 tpm_buf_read_u8() error:
> > > > > uninitialized symbol 'value'.
> > > > > drivers/char/tpm/tpm-buf.c:225 tpm_buf_read_u16() error:
> > > > > uninitialized symbol 'value'.
> > > > > drivers/char/tpm/tpm-buf.c:242 tpm_buf_read_u32() error:
> > > > > uninitialized symbol 'value'.
> > > > > 
> > > > > Call tpm_buf_read() to populate value but do not check its return
> > > > > status. If the read fails, value remains uninitialized, causing
> > > > > undefined behavior when returned or processed.
> > > > > 
> > > > > Initialize value to zero to ensure a defined return even if
> > > > > tpm_buf_read() fails, avoiding undefined behavior from using
> > > > > an uninitialized variable.
> > > > 
> > > > How does tpm_buf_read() fail?
> > > 
> > > If TPM_BUF_BOUNDARY_ERROR is set (or we are setting it), we are
> > > effectively returning random stack bytes to the caller.
> > > Could this be a problem?
> > > 
> > > If it is, maybe instead of this patch, we could set `*output` to zero in
> > > the error path of tpm_buf_read(). Or return an error from tpm_buf_read()
> > > so callers can return 0 or whatever they want.
> > > 
> > > Thanks,
> > > Stefano
> > > 
> > 
> > Hi Jarkko, Stefano,
> > Thank you for the review.
> > 
> > I've revisited the issue and updated the implementation of tpm_buf_read() to
> > zero out the *output buffer in the error paths, instead of initializing the
> > return value in each caller.
> > 
> > static void tpm_buf_read(struct tpm_buf *buf, off_t *offset, size_t count,
> > void *output)
> > {
> > 	off_t next_offset;
> > 
> > 	/* Return silently if overflow has already happened. */
> > 	if (buf->flags & TPM_BUF_BOUNDARY_ERROR) {
> > 		memset(output, 0, count);
> > 		return;
> > 	}
> > 
> > 	next_offset = *offset + count;
> > 	if (next_offset > buf->length) {
> > 		WARN(1, "tpm_buf: read out of boundary\n");
> > 		buf->flags |= TPM_BUF_BOUNDARY_ERROR;
> > 		memset(output, 0, count);
> > 		return;
> > 	}
> > 
> > 	memcpy(output, &buf->data[*offset], count);
> > 	*offset = next_offset;
> > }
> 
> Please don't touch this.

If you want to do anything, check the call sites for raw tpm_buf_read()
instead, which is not very common.

BR, Jarkko

