Return-Path: <linux-integrity+bounces-4455-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C7FD9FA655
	for <lists+linux-integrity@lfdr.de>; Sun, 22 Dec 2024 16:01:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 51A7B1887D97
	for <lists+linux-integrity@lfdr.de>; Sun, 22 Dec 2024 15:01:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49EC038385;
	Sun, 22 Dec 2024 15:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="LuHooYBb";
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="LuHooYBb"
X-Original-To: linux-integrity@vger.kernel.org
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [96.44.175.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32DDF14287;
	Sun, 22 Dec 2024 15:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.44.175.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734879668; cv=none; b=sVCYlMl4m6WAbmS14manJ+m7Z13B2TeYUhzU22vgYm6Jc9DlhXot0YJXOYQ8WwNg1Bry6ZOFeawX22W5ejAGzgqLRa1JGEChRtae34Dqp2r0pEbiRSjmlSpOgXWNmxblWFUp2KG0OdP6F1dc292ewbZ2kJWe5C+0YI3IeUfZSsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734879668; c=relaxed/simple;
	bh=HgTkeKvUIYgxKdMQ+4N5qBYoOI1jVq0RJ07iLBAZLR0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PTFe2scX10ocYVlOyay0QkPtnrJ6kqjKxYjbs43uPNxF8GJOJMh4Wf6+PtCLvStS7Gw5eyY2VpF/P+y3l6Rc7Y5xYU+kAlWjzvaXTdLBuOfvGH26/gR/kRweC+qUx3fCYmLN3AoNhC13KG9v8tUq47T357Ngx+CVKUTIl0WGFus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com; spf=pass smtp.mailfrom=HansenPartnership.com; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=LuHooYBb; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=LuHooYBb; arc=none smtp.client-ip=96.44.175.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=HansenPartnership.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1734879661;
	bh=HgTkeKvUIYgxKdMQ+4N5qBYoOI1jVq0RJ07iLBAZLR0=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=LuHooYBbiR1pW3nd0zP6hbyDYWVpJ7RdLeYAGm0LPznbdOkDeI4tZKQtOmkaow7i2
	 FWkI1xd2YdaPs0ZMfuAjJHN0nPx0eMWIrA1CVbEkSM5GKtJ6VWfrt+spvKv5zil92u
	 lW1QlHwdpVuWSq2dVIaZnc2ddmouw1sEw5I6Ah0k=
Received: from localhost (localhost [127.0.0.1])
	by bedivere.hansenpartnership.com (Postfix) with ESMTP id D66DA1286552;
	Sun, 22 Dec 2024 10:01:01 -0500 (EST)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id xW0dg6JN9ZqN; Sun, 22 Dec 2024 10:01:01 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1734879661;
	bh=HgTkeKvUIYgxKdMQ+4N5qBYoOI1jVq0RJ07iLBAZLR0=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=LuHooYBbiR1pW3nd0zP6hbyDYWVpJ7RdLeYAGm0LPznbdOkDeI4tZKQtOmkaow7i2
	 FWkI1xd2YdaPs0ZMfuAjJHN0nPx0eMWIrA1CVbEkSM5GKtJ6VWfrt+spvKv5zil92u
	 lW1QlHwdpVuWSq2dVIaZnc2ddmouw1sEw5I6Ah0k=
Received: from lingrow.int.hansenpartnership.com (unknown [IPv6:2601:5c4:4302:c21::a774])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 8076A12864AC;
	Sun, 22 Dec 2024 10:01:00 -0500 (EST)
Message-ID: <e8037b6dd77c3105ac94e0fe68aad39e9f3b9656.camel@HansenPartnership.com>
Subject: Re: [PATCH] tpm: Map the ACPI provided event log
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: Jarkko Sakkinen <jarkko.sakkinen@iki.fi>, Ard Biesheuvel
 <ardb@kernel.org>,  Jarkko Sakkinen <jarkko@kernel.org>
Cc: linux-integrity@vger.kernel.org, Peter Huewe <peterhuewe@gmx.de>, Jason
 Gunthorpe <jgg@ziepe.ca>, Colin Ian King <colin.i.king@gmail.com>, Joe
 Hattori <joe@pf.is.s.u-tokyo.ac.jp>, Stefan Berger <stefanb@linux.ibm.com>,
 Roberto Sassu <roberto.sassu@huawei.com>, Al Viro
 <viro@zeniv.linux.org.uk>, Andy Liang <andy.liang@hpe.com>, Matthew Garrett
 <mjg59@srcf.ucam.org>, Mimi Zohar <zohar@linux.ibm.com>,
 linux-kernel@vger.kernel.org
Date: Sun, 22 Dec 2024 10:00:59 -0500
In-Reply-To: <D6HNHJM9L4BS.MNNTVW049NZJ@iki.fi>
References: <20241221113318.562138-1-jarkko@kernel.org>
	 <CAMj1kXHPpz2sH_MSjJ3wRP64tB2pSZJDUoMv4uKXh-HpgHWfvQ@mail.gmail.com>
	 <fc11e26d9a202d60a56403af9bd0bae4bd3a852f.camel@HansenPartnership.com>
	 <D6HNHJM9L4BS.MNNTVW049NZJ@iki.fi>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sat, 2024-12-21 at 22:11 +0200, Jarkko Sakkinen wrote:
> On Sat Dec 21, 2024 at 7:16 PM EET, James Bottomley wrote:
> > On Sat, 2024-12-21 at 17:04 +0100, Ard Biesheuvel wrote:
> > > On Sat, 21 Dec 2024 at 12:33, Jarkko Sakkinen <jarkko@kernel.org>
> > > wrote:
> > > > 
> > > > The following failure was reported:
> > > > 
> > > > [   10.693310][    T1] tpm_tis STM0925:00: 2.0 TPM (device-id
> > > > 0x3,
> > > > rev-id 0)
> > > > [   10.848132][    T1] ------------[ cut here ]------------
> > > > [   10.853559][    T1] WARNING: CPU: 59 PID: 1 at
> > > > mm/page_alloc.c:4727 __alloc_pages_noprof+0x2ca/0x330
> > > > [   10.862827][    T1] Modules linked in:
> > > > [   10.866671][    T1] CPU: 59 UID: 0 PID: 1 Comm: swapper/0
> > > > Not
> > > > tainted 6.12.0-lp155.2.g52785e2-default #1 openSUSE Tumbleweed
> > > > (unreleased) 588cd98293a7c9eba9013378d807364c088c9375
> > > > [   10.882741][    T1] Hardware name: HPE ProLiant DL320
> > > > Gen12/ProLiant DL320 Gen12, BIOS 1.20 10/28/2024
> > > > [   10.892170][    T1] RIP:
> > > > 0010:__alloc_pages_noprof+0x2ca/0x330
> > > > [   10.898103][    T1] Code: 24 08 e9 4a fe ff ff e8 34 36 fa
> > > > ff e9
> > > > 88 fe ff ff 83 fe 0a 0f 86 b3 fd ff ff 80 3d 01 e7 ce 01 00 75
> > > > 09
> > > > c6 05 f8 e6 ce 01 01 <0f> 0b 45 31 ff e9 e5 fe ff ff f7 c2 00
> > > > 00 08
> > > > 00 75 42 89 d9 80 e1
> > > > [   10.917750][    T1] RSP: 0000:ffffb7cf40077980 EFLAGS:
> > > > 00010246
> > > > [   10.923777][    T1] RAX: 0000000000000000 RBX:
> > > > 0000000000040cc0
> > > > RCX: 0000000000000000
> > > > [   10.931727][    T1] RDX: 0000000000000000 RSI:
> > > > 000000000000000c
> > > > RDI: 0000000000040cc0
> > > > 
> > > > Above shows that ACPI pointed a 16 MiB buffer for the log
> > > > events
> > > > because RSI maps to the 'order' parameter of
> > > > __alloc_pages_noprof(). Address the bug by mapping the region
> > > > when
> > > > needed instead of copying.
> > > > 
> > > > Reported-by: Andy Liang <andy.liang@hpe.com>
> > > > Closes: https://bugzilla.kernel.org/show_bug.cgi?id=219495
> > > > Suggested-by: Matthew Garrett <mjg59@srcf.ucam.org>
> > > > Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
> > > 
> > > This is a very intrusive fix - care to provide some more context
> > > on
> > > why all these changes are needed?
> > 
> > Since the bug reports never found an actual log over a few tens of
> > kilobytes this is caused by the BIOS implementation allocating a
> > huge
> > buffer that is mostly unused.
> > 
> > There are two other possibilities for fixing this, which were both
> > part
> > of the original suggestions.  One would be to work out the size of
> > the
> > log and then allocate an exact size.  This would require
> > implementing
> > tpm1 and tpm2 parsers for log size.  However, since we can never go
> > over KMALLOC_MAX_SIZE without an error even with this calculated
> > size,
> > the simplest straight line fix would be to cap the copy at
> > KMALLOC_MAX_SIZE if it's over.  That would be a simple one liner.
> 
> All I'm saying is this.
> 
> I've got bunch of complains of this from mainly SUSE, and now I'm
> here with a response to that feedback. So I don't care. You decide.
> 
> I'm 100% sure that the fix that Stefan proposed is not a sustainable
> path in long-term, so I guess this was more like more long-term but
> intrusive fix.

If event logs grow to greater than KMALLOC_MAX_SIZE then absolutely it
makes sense to map them instead of copying them.  But we'd have to do
that for all event log locators: ACPI, EFI and OF, because event log
size should be independent of the mechanism used to locate it.  So,
even as a long term fix (assuming we think there's a possibility of
logs expanding by 50x), this patch doesn't do the right thing because
it only maps ACPI logs.

If you're determined to do the mapping approach for all logs, I don't
see why we shouldn't keep the log permanently mapped which would really
simplify the patch set.  The main reason why ACPI memory is mapped and
unmapped is because it's usually I/O regions of devices for which we
have to use the device mapping primitives.  However, for machine main
memory, which is where we know the log is, the mapping eventually boils
down to a nop.

Regards,

James

> Ya, and also please test the changes, especially anything that can
> reach of OF eventlogs would be welcome feedback.
> 
> BR, Jarkko
> 


