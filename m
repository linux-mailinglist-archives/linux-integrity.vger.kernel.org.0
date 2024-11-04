Return-Path: <linux-integrity+bounces-4016-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 136739BB5D3
	for <lists+linux-integrity@lfdr.de>; Mon,  4 Nov 2024 14:22:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB9B02819FD
	for <lists+linux-integrity@lfdr.de>; Mon,  4 Nov 2024 13:22:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50A6D42A95;
	Mon,  4 Nov 2024 13:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="TEDGmUiM";
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="UuTKtIlz"
X-Original-To: linux-integrity@vger.kernel.org
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [96.44.175.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23CC62B9BC;
	Mon,  4 Nov 2024 13:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.44.175.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730726520; cv=none; b=I/CXq7+rJyO5QGHszpMd/YRn9cgoKWo8dVOnRcOYtuZCQov5TXYD7g45becruef66vWcAQmJBlIMxIN4zBUSdJjEQ5ncGVteKAVo2fGJYJRietaCjCK9a5UetaD/0tBYzgnXrhLIM2Bhx9YY31DiGuRIFdFYdbzY9EWsXP4ubko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730726520; c=relaxed/simple;
	bh=XWiezMdHQhwVAQ8FS0dYPAP0vsMdPsMcHS8Bdu27PCs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CZFF5sevy75Y+DGuKU3oRIl5kOmV3ubU+0C/QnNqrhgIzZdgkDGddddka3Hyp02Ghyr0lOTj4+bRBWBt9/tliOzqkCisI+kzpXQ/LlhQaoq7KUUpIPgkO/ZUOAxGwtfqDA5vld1E8lE9/CHz8wBanf8yhEN7hvgH90/tH2TR6SQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com; spf=pass smtp.mailfrom=HansenPartnership.com; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=TEDGmUiM; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=UuTKtIlz; arc=none smtp.client-ip=96.44.175.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=HansenPartnership.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1730726516;
	bh=XWiezMdHQhwVAQ8FS0dYPAP0vsMdPsMcHS8Bdu27PCs=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=TEDGmUiM1pAQv0SxNv+MicVlNshvHOaypSIY2DUUZeU9i5dXfpB+XOGDlK2w2hzs0
	 hrtT9o8fU8J5pw+pXlR0E5oI/9WiV0SqD3ILwezUxS3TmAXX/5aPrhcWg/ZKfhCrQ0
	 q5ss4euAOD8W2ArIZbW5HNu6B1cN28bt0SoAzUdc=
Received: from localhost (localhost [127.0.0.1])
	by bedivere.hansenpartnership.com (Postfix) with ESMTP id 93EFF12869C9;
	Mon, 04 Nov 2024 08:21:56 -0500 (EST)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id JV_hL4Tmk4bz; Mon,  4 Nov 2024 08:21:56 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1730726515;
	bh=XWiezMdHQhwVAQ8FS0dYPAP0vsMdPsMcHS8Bdu27PCs=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=UuTKtIlzvkhrSqdMfExl/QMP3DzspfuEpSRJ6AIxw+1b/M55rnTDhF1IVhAeEc2QQ
	 lQDezNvU5IFv2U5Bxb1QwES53gtATg07N8hbrM91E+02AjGuqJYotaIAFtZGyaFTBa
	 r0X9fRZBIDbbDqDBkxHdwVaYr/28pArA4JLcnJcs=
Received: from lingrow.int.hansenpartnership.com (unknown [IPv6:2601:5c4:4302:c21::a774])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id EEF9F1286919;
	Mon, 04 Nov 2024 08:21:54 -0500 (EST)
Message-ID: <3bc70b659c1c86c0f08c6d91a6d894ce58825e04.camel@HansenPartnership.com>
Subject: Re: [RFC PATCH 0/4] Alternative TPM patches for Trenchboot
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: "Daniel P. Smith" <dpsmith@apertussolutions.com>, Ard Biesheuvel
	 <ardb@kernel.org>
Cc: Jarkko Sakkinen <jarkko@kernel.org>, x86@kernel.org, Ross Philipson
 <ross.philipson@oracle.com>, Thomas Gleixner <tglx@linutronix.de>, Peter
 Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>, "open list:TPM
 DEVICE DRIVER" <linux-integrity@vger.kernel.org>, open list
 <linux-kernel@vger.kernel.org>,  trenchboot-devel@googlegroups.com
Date: Mon, 04 Nov 2024 08:21:50 -0500
In-Reply-To: <7b324454-bc34-4cc4-bd12-99268a543508@apertussolutions.com>
References: <20241102152226.2593598-1-jarkko@kernel.org>
	 <D5BW0P0HH0QL.7Y4HBLJGEDL8@kernel.org>
	 <e745226d-4722-43ed-86ad-89428f56fcba@apertussolutions.com>
	 <D5DCPWBQ2M7H.GAUEVUKGC3G0@kernel.org>
	 <CAMj1kXGd5KAXiFr3rEq3cQK=_970b=eRT4X6YKVSj2PhN6ACrw@mail.gmail.com>
	 <97d4e1a0-d86e-48a9-ad31-7e53d6885a96@apertussolutions.com>
	 <CAMj1kXFEJYVs7p6QLEAU-T+xfoWhkFi=PE9QpJ4Oo4oh3eM38Q@mail.gmail.com>
	 <7b324454-bc34-4cc4-bd12-99268a543508@apertussolutions.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

On Mon, 2024-11-04 at 07:19 -0500, Daniel P. Smith wrote:
> On 11/4/24 06:55, 'Ard Biesheuvel' via trenchboot-devel wrote:
[...]
> > I was referring specifically to the read-write sysfs node that
> > permits user space to update the default TPM locality. Does it need
> > to be writable? And does it need to exist at all?

This was my question here, which never got answered as well:

https://lore.kernel.org/linux-integrity/685f3f00ddf88e961e2d861b7c783010774fe19d.camel@HansenPartnership.com/

> Right, sorry. As I recall, that was introduce due to the sequence of
> how the TPM driver handled locality, moving back to Locality 0 after
> done sending cmds. In the Oracle implementation, the initramfs takes 
> integrity measurements of the environment it is about to kexec into,
> eg.  target kernel, initramfs, file system, etc. Some of these
> measurements should go into PCR 17 and PCR 18, which requires
> Locality 2 to be able extend those PCRs. If the slmodule is able to
> set the locality for all PCR extends coming from user space to be
> Locality 2, that removes the current need for it.

Well, no, that's counter to the desire to have user space TPM commands
and kernel space TPM commands in different localities.  I thought the
whole point of having locality restricted PCRs is so that only trusted
entities (i.e. those able to access the higher locality) could extend
into them.  If you run every TPM command, regardless of source, in the
trusted locality, that makes the extends accessible to everyone and
thus destroys the trust boundary.

It also doesn't sound like the above that anything in user space
actually needs this facility.  The measurements of kernel and initramfs
are already done by the boot stub (to PCR9, but that could be changed)
so we could do it all from the trusted entity.

Regards,

James


