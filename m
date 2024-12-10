Return-Path: <linux-integrity+bounces-4331-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 45B569EB410
	for <lists+linux-integrity@lfdr.de>; Tue, 10 Dec 2024 15:56:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F0AF1882E84
	for <lists+linux-integrity@lfdr.de>; Tue, 10 Dec 2024 14:56:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCC471B85FA;
	Tue, 10 Dec 2024 14:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="UYfF7n3t";
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="UYfF7n3t"
X-Original-To: linux-integrity@vger.kernel.org
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [96.44.175.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65CB41B6D16;
	Tue, 10 Dec 2024 14:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.44.175.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733842547; cv=none; b=g4Fz0GJrgFxRxo4ICxaIchKA/6J3FzbpuOsW+oi8orfuB+mkZ4AquVmgOMaa4KCf9NN4G/MYWk8nEsYRbTKQJykU3wbuzs9xFUKz7ikhx9fxLHJQrebhyluhTcdVYSjByKoZLqF9NXG8y3n/NzvT/D9F81fudwh0et3QKy03NJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733842547; c=relaxed/simple;
	bh=synrjfSGa+8PhwIluVHkXHHskInFjv0lF5HbMiZIHIs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GYmp+lrZkUz8lyy+Cq42/yEVhNE073c7UZNOGa8iymz3BaFVCokL9IyE0PrXMJ24zNJuOBwAx0E4q6urGVGh2Gp8g2bqJJmSrXdArKKgQaD0vD1Q5nwUDnquEFHHW7sOn2wysLuMzT0IPLBqsjxgPXLUdHM3cqos+N5ybspjVNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com; spf=pass smtp.mailfrom=HansenPartnership.com; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=UYfF7n3t; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=UYfF7n3t; arc=none smtp.client-ip=96.44.175.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=HansenPartnership.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1733842544;
	bh=synrjfSGa+8PhwIluVHkXHHskInFjv0lF5HbMiZIHIs=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=UYfF7n3t0XT2VEkMPxGAyhvR9qFw+/fCbdLox4e3A4qsmgCJeRlVhTgzW8iMD9zRC
	 TRKDs1Rcab1HykrXGMyGL+uTTtZtcdgIr6COJuHBRYVyr0XpGf1dJmSdG8VHIlffrr
	 48DrI6Y1zEJpeG31eelkoEKVrfZXRQ3m4fuFxjrk=
Received: from localhost (localhost [127.0.0.1])
	by bedivere.hansenpartnership.com (Postfix) with ESMTP id F29951285D0D;
	Tue, 10 Dec 2024 09:55:44 -0500 (EST)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id fkLteG4LaKJH; Tue, 10 Dec 2024 09:55:44 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1733842544;
	bh=synrjfSGa+8PhwIluVHkXHHskInFjv0lF5HbMiZIHIs=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=UYfF7n3t0XT2VEkMPxGAyhvR9qFw+/fCbdLox4e3A4qsmgCJeRlVhTgzW8iMD9zRC
	 TRKDs1Rcab1HykrXGMyGL+uTTtZtcdgIr6COJuHBRYVyr0XpGf1dJmSdG8VHIlffrr
	 48DrI6Y1zEJpeG31eelkoEKVrfZXRQ3m4fuFxjrk=
Received: from lingrow.int.hansenpartnership.com (unknown [IPv6:2601:5c4:4302:c21::a774])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 5FD081285CB9;
	Tue, 10 Dec 2024 09:55:43 -0500 (EST)
Message-ID: <50a2e1d29b065498146f459035e447851a518d1a.camel@HansenPartnership.com>
Subject: Re: [PATCH 3/3] x86/sev: add a SVSM vTPM platform device
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: Jason Gunthorpe <jgg@ziepe.ca>, Stefano Garzarella <sgarzare@redhat.com>
Cc: linux-coco@lists.linux.dev, Borislav Petkov <bp@alien8.de>, Dave Hansen
 <dave.hansen@linux.intel.com>, Peter Huewe <peterhuewe@gmx.de>, "H. Peter
 Anvin" <hpa@zytor.com>, linux-integrity@vger.kernel.org, x86@kernel.org,
 Joerg Roedel <jroedel@suse.de>, Jarkko Sakkinen <jarkko@kernel.org>, 
 linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, Thomas
 Gleixner <tglx@linutronix.de>, Claudio Carvalho <cclaudio@linux.ibm.com>,
 Dov Murik <dovmurik@linux.ibm.com>, Tom Lendacky <thomas.lendacky@amd.com>
Date: Tue, 10 Dec 2024 09:55:41 -0500
In-Reply-To: <20241210144025.GG1888283@ziepe.ca>
References: <20241210143423.101774-1-sgarzare@redhat.com>
	 <20241210143423.101774-4-sgarzare@redhat.com>
	 <20241210144025.GG1888283@ziepe.ca>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 2024-12-10 at 10:40 -0400, Jason Gunthorpe wrote:
> On Tue, Dec 10, 2024 at 03:34:23PM +0100, Stefano Garzarella wrote:
> 
> > +               if (platform_device_add_data(&tpm_device, &pops,
> > sizeof(pops)))
> > +                       return -ENODEV;
> > +               if (platform_device_register(&tpm_device))
> > +                       return -ENODEV;
> 
> This seems like an old fashioned way to instantiate a device. Why do
> this? Just put the TPM driver here and forget about pops? Simple tpm
> drivers are not very complex.

This driver may be for the AMD SEV SVSM vTPM module, but there are
other platforms where there's an internal vTPM which might be contacted
via a platform specific enlightenment (Intel SNP and Microsoft
OpenHCL).  This separation of the platform device from the contact
mechanism is designed to eliminate the duplication of having a platform
device within each implementation and to make any bugs in the mssim
protocol centrally fixable (every vTPM currently speaks this).

Regards,

James


