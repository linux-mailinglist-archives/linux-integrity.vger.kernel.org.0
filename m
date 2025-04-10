Return-Path: <linux-integrity+bounces-5751-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 881DFA83901
	for <lists+linux-integrity@lfdr.de>; Thu, 10 Apr 2025 08:15:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BBA581B62FBD
	for <lists+linux-integrity@lfdr.de>; Thu, 10 Apr 2025 06:15:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7B19202C2F;
	Thu, 10 Apr 2025 06:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NylHXf6l"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 906DE202C21;
	Thu, 10 Apr 2025 06:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744265703; cv=none; b=AnkEvIF2I9RVezCG+HFzwVYSbnHvjnmm8mSHh/8o8IZUta0ptnPCTdooD/7HNDco4WOYcw5wdm6HS2TqIVmRNyTa4M8eY5tC3mG0YJF8bglZOvSpYuWj37tAZKIRKGn6p2PsB3BLKwETZq17gm0B4o9T2SBBaqY6NMQJVilHVvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744265703; c=relaxed/simple;
	bh=zVqocgr36YZsJUJK4G4a6s/8nYUj5HCGaQSX42jvOFU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sphh2AvgYz/obqVRiCJqhEs5GOl8PR6tjO8QBCoB9KbefCPbyb6U4P5Cw+6Dnl2v3Xk9N/5KrjVdTkDIDf7nnwCFBh93g8fn62AGBnTqP30yvGzdXjsjLAylBdBNHHXiumJ20ieTVoEaa49wtAQd99EzAlPsacB0GXieO93U2l4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NylHXf6l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75497C4CEDD;
	Thu, 10 Apr 2025 06:15:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744265703;
	bh=zVqocgr36YZsJUJK4G4a6s/8nYUj5HCGaQSX42jvOFU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NylHXf6lqaAGXazFBMv88lr1z9ex6hdd51f1u6e7g72x9dM7wcYU7ONP5o0O5jRxV
	 gczLYMI8LDcrdT/x0f+YjYkaLVQsk+SH3mQa05wPfPC8zhaLgCmyBhZo1ofAvriN+v
	 zqQk+zSK9VuGaEBlchIPjbqDwH6SuXj78pa6DhRjuSMHvNe57TGgYj8GhchUWbjbUs
	 f71h1gS1uCGH6M3UXyDyObUabf8y6k5hMDN4h+jAnZJcBi2ElCuL61pfxVcNqf840/
	 WoaP5t4J5no1nN5uyrT2qlJ9hdAX8R7ociBsBXjbfR9oWz8+TRxxlgqkGuJby5qZ6r
	 /02h0jLwoFmkw==
Date: Thu, 10 Apr 2025 09:14:58 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Purva Yeshi <purvayeshi550@gmail.com>
Cc: peterhuewe@gmx.de, jgg@ziepe.ca, linux-integrity@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] char: tpm: tpm-buf: Fix uninitialized return values in
 read helpers
Message-ID: <Z_dh4tRIa6xxAWQ2@kernel.org>
References: <20250409205536.210202-1-purvayeshi550@gmail.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250409205536.210202-1-purvayeshi550@gmail.com>

On Thu, Apr 10, 2025 at 02:25:36AM +0530, Purva Yeshi wrote:
> Fix Smatch-detected error:
> drivers/char/tpm/tpm-buf.c:208 tpm_buf_read_u8() error:
> uninitialized symbol 'value'.
> drivers/char/tpm/tpm-buf.c:225 tpm_buf_read_u16() error:
> uninitialized symbol 'value'.
> drivers/char/tpm/tpm-buf.c:242 tpm_buf_read_u32() error:
> uninitialized symbol 'value'.
> 
> Call tpm_buf_read() to populate value but do not check its return
> status. If the read fails, value remains uninitialized, causing
> undefined behavior when returned or processed.
> 
> Initialize value to zero to ensure a defined return even if
> tpm_buf_read() fails, avoiding undefined behavior from using
> an uninitialized variable.

How does tpm_buf_read() fail?

> 
> Signed-off-by: Purva Yeshi <purvayeshi550@gmail.com>
> ---
>  drivers/char/tpm/tpm-buf.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/char/tpm/tpm-buf.c b/drivers/char/tpm/tpm-buf.c
> index e49a19fea3bd..dc882fc9fa9e 100644
> --- a/drivers/char/tpm/tpm-buf.c
> +++ b/drivers/char/tpm/tpm-buf.c
> @@ -201,7 +201,7 @@ static void tpm_buf_read(struct tpm_buf *buf, off_t *offset, size_t count, void
>   */
>  u8 tpm_buf_read_u8(struct tpm_buf *buf, off_t *offset)
>  {
> -	u8 value;
> +	u8 value = 0;
>  
>  	tpm_buf_read(buf, offset, sizeof(value), &value);
>  
> @@ -218,7 +218,7 @@ EXPORT_SYMBOL_GPL(tpm_buf_read_u8);
>   */
>  u16 tpm_buf_read_u16(struct tpm_buf *buf, off_t *offset)
>  {
> -	u16 value;
> +	u16 value = 0;
>  
>  	tpm_buf_read(buf, offset, sizeof(value), &value);
>  
> @@ -235,7 +235,7 @@ EXPORT_SYMBOL_GPL(tpm_buf_read_u16);
>   */
>  u32 tpm_buf_read_u32(struct tpm_buf *buf, off_t *offset)
>  {
> -	u32 value;
> +	u32 value = 0;
>  
>  	tpm_buf_read(buf, offset, sizeof(value), &value);
>  
> -- 
> 2.34.1
> 

BR, Jarkko

