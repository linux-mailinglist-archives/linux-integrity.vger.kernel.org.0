Return-Path: <linux-integrity+bounces-5756-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D2DE3A83DA1
	for <lists+linux-integrity@lfdr.de>; Thu, 10 Apr 2025 10:56:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C1B2B7B3EEE
	for <lists+linux-integrity@lfdr.de>; Thu, 10 Apr 2025 08:54:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2026C20B814;
	Thu, 10 Apr 2025 08:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FqWEvgWI"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB8C51DF97F;
	Thu, 10 Apr 2025 08:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744275327; cv=none; b=RNMcH6f6l2lz8pJBjYyQuny/OomLY3HM79pFcvxJDh5YT8jR1w1berbrTf0+QIpCZbg/t3TKPCiZrLG2SBa4pABkFPvQGDpbsQLqn+4BhN973AJ+lyjj66W1J8rYjqFQ/3GgWwrBvZE/SMs6ypSEK8A2LuBHsYb2M4WE1OV61dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744275327; c=relaxed/simple;
	bh=EhMxPe8hnh5VvcDeuDZAxU1vq1abjs5GoHLLbLqj+c8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BP6HwNre2KR1Swrg+JO3PhkA6vd6cTze+GkQl5C3UpZNuPFm9daBNmx7omMz95/A8ibxuQMA9RZd5rnNVyyAZpMhQQM4/dpgUwzMgRyLl2/jUrFOTJwRT3C/6+6dqzA7eP9on16MK5wOh7CQd6hYC2gvUSEi2ZSkt71LvUnLtQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FqWEvgWI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12DB5C4CEDD;
	Thu, 10 Apr 2025 08:55:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744275326;
	bh=EhMxPe8hnh5VvcDeuDZAxU1vq1abjs5GoHLLbLqj+c8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FqWEvgWI/XnLXFuYOLuajdLysIghAhqgtwM2lDY8VkijptZ6Jub5hI/sgkCyzB4AU
	 7F4LHGGSICvkrzG87nO4V59OEMARsAZ3ivWLUaK3TYd6dZpucWevVOugw+ahQaYvd1
	 Tuda5bDZCrROV4NzK/sR7KCwwUllVWDVmwHRN2KU50VQoB/6HxdZQ0z0ZAjJq7k9pW
	 Xl3vjJEHcbZ0V8JCtsoGwgeOIPvv+ZMmUY6TIwXLOaGjEfW/kMoy7xc65kRkHFshy1
	 uuag0t29M/ebinTHcUBB2Kd1udm0Sq80o8XxEqTPZWnKwFI4f830Nl5ntzjtXBHm71
	 YGwos6QUwcvMA==
Date: Thu, 10 Apr 2025 11:55:22 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Purva Yeshi <purvayeshi550@gmail.com>
Cc: Stefano Garzarella <sgarzare@redhat.com>, peterhuewe@gmx.de,
	jgg@ziepe.ca, linux-integrity@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] char: tpm: tpm-buf: Fix uninitialized return values in
 read helpers
Message-ID: <Z_eHei1jT0YoPgki@kernel.org>
References: <20250409205536.210202-1-purvayeshi550@gmail.com>
 <Z_dh4tRIa6xxAWQ2@kernel.org>
 <t2ri7facyvtmt6rx6xwcjos7rgtyiln7cywl2gt4effgukeejc@f3ml4apdh4zs>
 <fab2bb2d-a78e-4130-a5fd-bf07430210c7@gmail.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fab2bb2d-a78e-4130-a5fd-bf07430210c7@gmail.com>

On Thu, Apr 10, 2025 at 02:12:07PM +0530, Purva Yeshi wrote:
> On 10/04/25 13:21, Stefano Garzarella wrote:
> > On Thu, Apr 10, 2025 at 09:14:58AM +0300, Jarkko Sakkinen wrote:
> > > On Thu, Apr 10, 2025 at 02:25:36AM +0530, Purva Yeshi wrote:
> > > > Fix Smatch-detected error:
> > > > drivers/char/tpm/tpm-buf.c:208 tpm_buf_read_u8() error:
> > > > uninitialized symbol 'value'.
> > > > drivers/char/tpm/tpm-buf.c:225 tpm_buf_read_u16() error:
> > > > uninitialized symbol 'value'.
> > > > drivers/char/tpm/tpm-buf.c:242 tpm_buf_read_u32() error:
> > > > uninitialized symbol 'value'.
> > > > 
> > > > Call tpm_buf_read() to populate value but do not check its return
> > > > status. If the read fails, value remains uninitialized, causing
> > > > undefined behavior when returned or processed.
> > > > 
> > > > Initialize value to zero to ensure a defined return even if
> > > > tpm_buf_read() fails, avoiding undefined behavior from using
> > > > an uninitialized variable.
> > > 
> > > How does tpm_buf_read() fail?
> > 
> > If TPM_BUF_BOUNDARY_ERROR is set (or we are setting it), we are
> > effectively returning random stack bytes to the caller.
> > Could this be a problem?
> > 
> > If it is, maybe instead of this patch, we could set `*output` to zero in
> > the error path of tpm_buf_read(). Or return an error from tpm_buf_read()
> > so callers can return 0 or whatever they want.
> > 
> > Thanks,
> > Stefano
> > 
> 
> Hi Jarkko, Stefano,
> Thank you for the review.
> 
> I've revisited the issue and updated the implementation of tpm_buf_read() to
> zero out the *output buffer in the error paths, instead of initializing the
> return value in each caller.
> 
> static void tpm_buf_read(struct tpm_buf *buf, off_t *offset, size_t count,
> void *output)
> {
> 	off_t next_offset;
> 
> 	/* Return silently if overflow has already happened. */
> 	if (buf->flags & TPM_BUF_BOUNDARY_ERROR) {
> 		memset(output, 0, count);
> 		return;
> 	}
> 
> 	next_offset = *offset + count;
> 	if (next_offset > buf->length) {
> 		WARN(1, "tpm_buf: read out of boundary\n");
> 		buf->flags |= TPM_BUF_BOUNDARY_ERROR;
> 		memset(output, 0, count);
> 		return;
> 	}
> 
> 	memcpy(output, &buf->data[*offset], count);
> 	*offset = next_offset;
> }

Please don't touch this.

> 
> This approach ensures that output is always zeroed when the read fails,
> which avoids returning uninitialized stack values from the helper functions
> like tpm_buf_read_u8(), tpm_buf_read_u16(), and tpm_buf_read_u32().
> 
> Does this solution look acceptable for the next version of the patch?
> 
> Best regards,
> Purva Yeshi

BR, Jarkko

