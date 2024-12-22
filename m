Return-Path: <linux-integrity+bounces-4458-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DAB049FA764
	for <lists+linux-integrity@lfdr.de>; Sun, 22 Dec 2024 18:42:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 975A3162CAD
	for <lists+linux-integrity@lfdr.de>; Sun, 22 Dec 2024 17:41:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E71FF1922E4;
	Sun, 22 Dec 2024 17:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="QILaYBQp";
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="QILaYBQp"
X-Original-To: linux-integrity@vger.kernel.org
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [96.44.175.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30B4318F2CF;
	Sun, 22 Dec 2024 17:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.44.175.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734889289; cv=none; b=J44UkK5sMG4dYdRFn9mhMUKgEVMEBocS1fmV6Io6KzR7xDKFcx9NbqAJTotASPvarkD2UR+TUmtYZRsoAhDAXCXHYzCIc76NvVI05KaWs/vNrXHsfcMCKMZ0yNhi/2aScDznIwvaxBql1QP1axtVKe1lIXIxOZEfhjOGbyqZ7ls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734889289; c=relaxed/simple;
	bh=xrjfnHwg+CZKbK+oKpjNXwJTwyXeNJAU0aVD1fMcMzI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cZadWFIZimdCdFE2IrzZiB7D2/n4Rg2BRFP3QHhWj8zx2DYe3UzN9vX+SxiVFcNaBOnrVzP/HpZZT3I3Kum/A4xPcYfo15Y44BuvCTX9r3E8z8rH1E4ZVBQlDdcUmAXJeHDYxdzMqoe6xhZ2dm0m+IEMOhe6V74Mqv1++i1g64M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com; spf=pass smtp.mailfrom=HansenPartnership.com; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=QILaYBQp; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=QILaYBQp; arc=none smtp.client-ip=96.44.175.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=HansenPartnership.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1734889287;
	bh=xrjfnHwg+CZKbK+oKpjNXwJTwyXeNJAU0aVD1fMcMzI=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=QILaYBQppjxoQImEHhY8vrqmbkUO1llJT+q7zoKeCy8tA6M4lpeyk1/mslcywBgM0
	 ho12PuQG1kJo+gGKv6vSwozvOYz3/lLTTZu5oT5WVyJ/6OaXQSS6N7Sulm2X/xCeD8
	 hRxAx0BBHaGS5PP+cwm7oSNCF3Kra7W/9OI2tUMk=
Received: from localhost (localhost [127.0.0.1])
	by bedivere.hansenpartnership.com (Postfix) with ESMTP id 540D01280659;
	Sun, 22 Dec 2024 12:41:27 -0500 (EST)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id m0VZsl1wqpUL; Sun, 22 Dec 2024 12:41:27 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1734889287;
	bh=xrjfnHwg+CZKbK+oKpjNXwJTwyXeNJAU0aVD1fMcMzI=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=QILaYBQppjxoQImEHhY8vrqmbkUO1llJT+q7zoKeCy8tA6M4lpeyk1/mslcywBgM0
	 ho12PuQG1kJo+gGKv6vSwozvOYz3/lLTTZu5oT5WVyJ/6OaXQSS6N7Sulm2X/xCeD8
	 hRxAx0BBHaGS5PP+cwm7oSNCF3Kra7W/9OI2tUMk=
Received: from lingrow.int.hansenpartnership.com (unknown [IPv6:2601:5c4:4302:c21::a774])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id CFEA61280256;
	Sun, 22 Dec 2024 12:41:25 -0500 (EST)
Message-ID: <56aa08af3da583366ca3053f51ec5a36ac61a386.camel@HansenPartnership.com>
Subject: Re: [PATCH] tpm: Map the ACPI provided event log
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: Jarkko Sakkinen <jarkko@kernel.org>, Jarkko Sakkinen
	 <jarkko.sakkinen@iki.fi>, Ard Biesheuvel <ardb@kernel.org>
Cc: linux-integrity@vger.kernel.org, Peter Huewe <peterhuewe@gmx.de>, Jason
 Gunthorpe <jgg@ziepe.ca>, Colin Ian King <colin.i.king@gmail.com>, Joe
 Hattori <joe@pf.is.s.u-tokyo.ac.jp>, Stefan Berger <stefanb@linux.ibm.com>,
 Roberto Sassu <roberto.sassu@huawei.com>, Al Viro
 <viro@zeniv.linux.org.uk>, Andy Liang <andy.liang@hpe.com>, Matthew Garrett
 <mjg59@srcf.ucam.org>, Mimi Zohar <zohar@linux.ibm.com>,
 linux-kernel@vger.kernel.org
Date: Sun, 22 Dec 2024 12:41:24 -0500
In-Reply-To: <D6IC7BH3A75U.31VJX6T6QRKKI@kernel.org>
References: <20241221113318.562138-1-jarkko@kernel.org>
	 <CAMj1kXHPpz2sH_MSjJ3wRP64tB2pSZJDUoMv4uKXh-HpgHWfvQ@mail.gmail.com>
	 <fc11e26d9a202d60a56403af9bd0bae4bd3a852f.camel@HansenPartnership.com>
	 <D6HNHJM9L4BS.MNNTVW049NZJ@iki.fi>
	 <e8037b6dd77c3105ac94e0fe68aad39e9f3b9656.camel@HansenPartnership.com>
	 <D6IBZOIZPHG9.33MA1XLBELFNF@iki.fi> <D6IC7BH3A75U.31VJX6T6QRKKI@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sun, 2024-12-22 at 17:33 +0200, Jarkko Sakkinen wrote:
> On Sun Dec 22, 2024 at 5:23 PM EET, Jarkko Sakkinen wrote:
> > On Sun Dec 22, 2024 at 5:00 PM EET, James Bottomley wrote:
> > > If event logs grow to greater than KMALLOC_MAX_SIZE then
> > > absolutely it makes sense to map them instead of copying them. 
> > > But we'd have to do that for all event log locators: ACPI, EFI
> > > and OF, because event log size should be independent of the
> > > mechanism used to locate it.  So, even as a long term fix
> > > (assuming we think there's a possibility of logs expanding by
> > > 50x), this patch doesn't do the right thing because it only maps
> > > ACPI logs.
> > 
> > Because we have a test target only on ACPI where this happens fix
> > should still fix only ACPI. It's not hard to reiterate this but 
> > precursory iteration is a bad idea.
> 
> Also, "event log size should be independent of the mechanism used to
> locate it" is a sentence that is sky high too abstract to say much.
> 
> I don't know what it means to be frank.

event log size means the number of bytes from the beginning to the end
of the event log.  Since the event log is created by the pre-boot
environment, there is a convention for how to communicate this
information from pre-boot to the kernel; this is the mechanism used to
locate it.  We decode three mechanisms: an ACPI table, an EFI table and
an OF entry.

The pre-boot environment generating the event log is supposed to
conform to the TCG standards for what events it contains; none of the
entries depends on the mechanism used to locate the log, which is why
the size also can't depend on the mechanis.  There are many optional
events, but even if the pre-boot took a maximalist approach the most it
could contain is a couple of hundred entries.  The variable entries are
mostly small but several types can contain device paths or
certificates, but even if you allow a 10k size for each entry, that's
still at most 2MB.  So I think if a pre-boot declared log area goes
over KMALLOC_MAX_SIZE (4MB on x86) it's safe to truncate the area
because the log will never fill all of it.

The corollary is that if we ever did find an actual log over 4MB, then
the EFI and OF mechanisms used to locate it would also fail in the
kmalloc, which is why KMALLOC_MAX_SIZE is the correct cap for the
declared size.

Regards,

James


