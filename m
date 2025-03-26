Return-Path: <linux-integrity+bounces-5448-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69DD9A71C7F
	for <lists+linux-integrity@lfdr.de>; Wed, 26 Mar 2025 17:57:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC19A174477
	for <lists+linux-integrity@lfdr.de>; Wed, 26 Mar 2025 16:54:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B910315852F;
	Wed, 26 Mar 2025 16:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XMW9oG75"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9137F1547E7;
	Wed, 26 Mar 2025 16:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743008035; cv=none; b=WNwSM8ytjh1nK2EXLUK1rZ6qImL01RTXG1YXxsPReRGtlc6iMukARwnvnI2/PeK8hpNVoOBgtlBZ+Tp9tpMx0JyqLNY1gBmRqE23j4P684yYVN4e4XvGuapYLfgAVq1b6vpJ8O19+Z4iwBOenX3qYWTGRaIC3huj0vS7dW+KcZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743008035; c=relaxed/simple;
	bh=GD9/Unp7kHxkjyBxvRNjmE21o0vBLYIrBR+MU3QlEeY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mqeWAzJWLoFIHOx0+lcFstD5l5J9vAJKJdssnePsRaIRj+4tuLUZa5GW2gXZ/SNSVO8E/CwkY03u/rF4J3X1MTfcp9hsSWR2roUB6vTMTQ0xXj4tEkzNspRY0MsuPlTXsCkd5+lbcCljbVTyz+SRGauMauzJg+IDcbtg/+OB/PA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XMW9oG75; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A35F3C4CEE2;
	Wed, 26 Mar 2025 16:53:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743008035;
	bh=GD9/Unp7kHxkjyBxvRNjmE21o0vBLYIrBR+MU3QlEeY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XMW9oG75dOAkY6lTifdvJK6RSCOfjhN7eboKLZY4VQ3Ar1+gvOgO8OtgBqqv1WFxC
	 9te4wvjtVj7LDHX4kl0omSGGNQZFE/rS4M953rNI6oNNlsbcEbXa8x8tEUzKCAD8Lt
	 AMeKOgXftNyKvDQJpkvNixlmteQ213LrzyGfre5EDrn9MG7JpXYzXv/dGSQ/xHDYHy
	 ns51mHh5GRDIXh4tnX4zl03AcauqeVJ0basYWsBwZq95znB6atrIjFc1EQMZGYbFMX
	 qaZ2Y/rUwE6h3DeCjjasdS06QbS4ljirUjdczuj9M3h7GwkS4uq+1kBiGzSQfz5DFx
	 xcs64XumVtgRg==
Date: Wed, 26 Mar 2025 18:53:51 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, linux-kernel@vger.kernel.org,
	Peter Huewe <peterhuewe@gmx.de>, linux-integrity@vger.kernel.org,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	Jens Wiklander <jens.wiklander@linaro.org>,
	Sumit Garg <sumit.garg@kernel.org>
Subject: Re: [PATCH 1/2] tpm: add send_recv() op in tpm_class_ops
Message-ID: <Z-QxH7aDjlixl2gp@kernel.org>
References: <20250320152433.144083-1-sgarzare@redhat.com>
 <20250320152433.144083-2-sgarzare@redhat.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250320152433.144083-2-sgarzare@redhat.com>

On Thu, Mar 20, 2025 at 04:24:32PM +0100, Stefano Garzarella wrote:
> From: Stefano Garzarella <sgarzare@redhat.com>
> 
> Some devices do not support interrupts and provide a single operation
> to send the command and receive the response on the same buffer.
> 
> To support this scenario, a driver could set TPM_CHIP_FLAG_IRQ in the
> chip's flags to get recv() to be called immediately after send() in
> tpm_try_transmit(), or it needs to implement .status() to return 0,
> and set both .req_complete_mask and .req_complete_val to 0.
> 
> In order to simplify these drivers and avoid temporary buffers to be

Simplification can be addressed with no callback changes:

https://lore.kernel.org/linux-integrity/20250326161838.123606-1-jarkko@kernel.org/T/#u

I also noticed that tpm_ftpm_tee initalized req_complete_mask and
req_complete_val explictly while they would be already implicitly
zero.

So it reduces this just a matter of getting rid off the extra
buffer.

> used between the .send() and .recv() callbacks, introduce a new callback
> send_recv(). If that callback is defined, it is called in
> tpm_try_transmit() to send the command and receive the response on
> the same buffer in a single call.

I don't find anything in the commit message addressing buf_len an
cmd_len (vs "just len"). Why two lengths are required?

Not completely rejecting but this explanation is incomplete.

BR, Jarkko

