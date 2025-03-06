Return-Path: <linux-integrity+bounces-5146-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C1AA7A55922
	for <lists+linux-integrity@lfdr.de>; Thu,  6 Mar 2025 22:53:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A917F3B492E
	for <lists+linux-integrity@lfdr.de>; Thu,  6 Mar 2025 21:52:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7566E278110;
	Thu,  6 Mar 2025 21:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pweQuxs0"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EED2278104;
	Thu,  6 Mar 2025 21:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741297971; cv=none; b=mtBV+KNTc+w360WIHNBTIitM7hAkZ6lVLX4GtPKSXhrmirr/ty/YdoRZNNSztZhwX3oNqS3unCAnmXvzmpifFunNjrhwYUzZbhnr1C77b+mE5hfolCPt7n2iF5L/RSod1ob+08RbDvnnxZr2Z0TPRjdXsKt0QGnrwSFqeNRuwUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741297971; c=relaxed/simple;
	bh=LMR2PvMaqiPaqf+FPvIKU8w+oYH2T82yjmHwvvbMFQ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZaO9YQo04/AXmS0pFvesx+14nqDUOBGzgwKw5VsDs0GiXlTh2njOboJw+jNFzz4KlWkPLqlbHwjcn5ag1RvBewALVRmFlp5AyL7CAGQyRQchiv5sT3lWXqIzCtybt505Ix+lww+h9/rxQiXAwIHFUe3TtrzIe6Wm4ORVb1y+8K8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pweQuxs0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30A6EC4CEE5;
	Thu,  6 Mar 2025 21:52:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741297970;
	bh=LMR2PvMaqiPaqf+FPvIKU8w+oYH2T82yjmHwvvbMFQ4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pweQuxs0SJwGMMkXVQOFGk1zV9wNaNjTXJbvTPtAY6ex/1UF0ZoIGO62qC/ovC1Xh
	 +JfBA+W7lZqRzFlLe1vF4jLl5lzLEy7K8T5rO4vvxlt2exLv6fKj0el71Rmtd6Mx7E
	 kaIKqwyCIp3c4cLT7P89M55oTKMpIw4M5H7eg0b78xIHyI9D5fJ1uzrI2qhk4SUY5D
	 V09jBRwRpOvzLKkye2MEH1955mVC19azdZu1KVoN3qBvjRXJ03LZZCkjnTQ5Sn//hz
	 nzP3GPe1jExmPbNlaD1EM8p0jqHNkpJgHGDfHfIZhS60QxbH1mp/xVI5yc8latBiQY
	 cUjvO8HecOaKA==
Date: Thu, 6 Mar 2025 23:52:46 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Stefano Garzarella <sgarzare@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Claudio Carvalho <cclaudio@linux.ibm.com>,
	Peter Huewe <peterhuewe@gmx.de>, x86@kernel.org,
	Dov Murik <dovmurik@linux.ibm.com>, linux-coco@lists.linux.dev,
	Dionna Glaze <dionnaglaze@google.com>,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	Ingo Molnar <mingo@redhat.com>, Joerg Roedel <jroedel@suse.de>,
	linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [RFC PATCH v2 3/6] tpm: add send_recv() ops in tpm_class_ops
Message-ID: <Z8oZLqn4p2-AWQbz@kernel.org>
References: <20250228170720.144739-1-sgarzare@redhat.com>
 <20250228170720.144739-4-sgarzare@redhat.com>
 <Z8Jmps6AF_geaHUw@kernel.org>
 <3p5erujbhxw7ozdnfpmresv3dqdh2xszolv6mh4khkagoy3wit@ow5qht4keh4h>
 <0e156883acf95d31b9358831550d6d675e3ce4ff.camel@kernel.org>
 <Z8dg46Mj81Q9Z0WV@kernel.org>
 <jkr5z4thb55gs2jcmtcfipgg6p7z6ikhr6etd6l3nqpf723hf7@3fns3z5cjqk4>
 <20250305190229.GC354403@ziepe.ca>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250305190229.GC354403@ziepe.ca>

On Wed, Mar 05, 2025 at 03:02:29PM -0400, Jason Gunthorpe wrote:
> On Wed, Mar 05, 2025 at 10:04:25AM +0100, Stefano Garzarella wrote:
> > Jason suggested the send_recv() ops [2], which I liked, but if you prefer to
> > avoid that, I can restore what we did in v1 and replace the
> > TPM_CHIP_FLAG_IRQ hack with your point 2 (or use TPM_CHIP_FLAG_IRQ if you
> > think it is fine).
> 
> I think it is a pretty notable simplification for the driver as it
> does not need to implement send, status, req_canceled and more ops.
> 
> Given the small LOC on the core side I'd call that simplification a
> win..

I'm sorry to disagree with you on this but adding a callback for
one leaf driver is not what I would call "a win" :-)

I mean, it's either a minor twist in

1. "the framework code" which affects in a way all other leaf drivers.
   At bare minimum it adds a tiny bit of complexity to the callback
   interface and a tiny bit of accumulated maintenance cost.
2. in the leaf driver

So I'd really would want to keep that tiny bit of extra complexity
localized.

> 
> Jason

BR, Jarkko

