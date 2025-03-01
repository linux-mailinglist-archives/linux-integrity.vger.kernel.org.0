Return-Path: <linux-integrity+bounces-5028-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10B9FA4A7A4
	for <lists+linux-integrity@lfdr.de>; Sat,  1 Mar 2025 02:45:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3038516CEC2
	for <lists+linux-integrity@lfdr.de>; Sat,  1 Mar 2025 01:45:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2188229406;
	Sat,  1 Mar 2025 01:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OVDe5RQ/"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC687101C8;
	Sat,  1 Mar 2025 01:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740793515; cv=none; b=jf6BX2VnGCttqTpWVWJkVysjxs9+JgV5O/RcqUNXPhOXWLE7TMIcYyR7nboFAOmSpsbewuWvC4xTPZk9T1mEP9DYcqRBckwjDDRbOPyVub0g+qcc2P+ajhN1IQ+H7lT1oXRZHKnAyJ/AyDTUGBdn/27gqHqVzWOwJ9/WeIa5V1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740793515; c=relaxed/simple;
	bh=0Elztxno2Wh5dEC0H+MhvIWJ2BKl3os0U6qKe03LeG8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W46j3oYI6gsR+DGCpDVAJQ7IHUWTUpFLdYuL1epdMWZZlCHiRqCu3M6AcH5+CjxiDftw8x679swz1IEk2y7iWXjkSzbe4afY3cLwp88g1Ya+gcW3ripaSKj10jg3d04E8EWOh5Kg8ksFxWpMBNGkZMVxvL/vxCrIqNXUM7XeJLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OVDe5RQ/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEA55C4CED6;
	Sat,  1 Mar 2025 01:45:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740793514;
	bh=0Elztxno2Wh5dEC0H+MhvIWJ2BKl3os0U6qKe03LeG8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OVDe5RQ/h1jln2AQ0P6LEwQN/NhtLmB10XtR1QDduwYNfd0NpgHRUOazNgTfnFLAM
	 Zp1a5vq3oTok1S56+moZyVy+SMxZrEjEuaPzoxJ+b3MiPsSIn5zzoEJZ/NL7RWflCa
	 wSMXDVcAbrq2sN2BjFL6HM5y1KHvZzuwi6O6UugNG9mE0UZ0+hbVv+JOuQWvymN3ad
	 xpUHNWEim474l5uB3gJ4rBa2ICVzBSLkCog5rGAtwoiaq2KuM3NjAHDs4MNxyw9aMu
	 WqXauNphcdKLwfXFWXq4eoW5zj2htHvHBmOPL4m8fKC/cPB6szw6xSEFq7naOBJlR4
	 Aqq7a46dLzMaQ==
Date: Sat, 1 Mar 2025 03:45:10 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Claudio Carvalho <cclaudio@linux.ibm.com>,
	Peter Huewe <peterhuewe@gmx.de>, x86@kernel.org,
	Dov Murik <dovmurik@linux.ibm.com>, linux-coco@lists.linux.dev,
	Dionna Glaze <dionnaglaze@google.com>,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	Ingo Molnar <mingo@redhat.com>, Joerg Roedel <jroedel@suse.de>,
	Jason Gunthorpe <jgg@ziepe.ca>, linux-integrity@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [RFC PATCH v2 3/6] tpm: add send_recv() ops in tpm_class_ops
Message-ID: <Z8Jmps6AF_geaHUw@kernel.org>
References: <20250228170720.144739-1-sgarzare@redhat.com>
 <20250228170720.144739-4-sgarzare@redhat.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250228170720.144739-4-sgarzare@redhat.com>

On Fri, Feb 28, 2025 at 06:07:17PM +0100, Stefano Garzarella wrote:
> +	int (*send_recv)(struct tpm_chip *chip, u8 *buf, size_t buf_len,
> +			 size_t to_send);

Please describe the meaning and purpose of to_send.

BR, Jarkko

