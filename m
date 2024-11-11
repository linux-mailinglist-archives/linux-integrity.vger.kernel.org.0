Return-Path: <linux-integrity+bounces-4082-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 390CD9C4668
	for <lists+linux-integrity@lfdr.de>; Mon, 11 Nov 2024 21:12:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1E1B281169
	for <lists+linux-integrity@lfdr.de>; Mon, 11 Nov 2024 20:12:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E44B81ABEC2;
	Mon, 11 Nov 2024 20:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="aJumCQrN";
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="aJumCQrN"
X-Original-To: linux-integrity@vger.kernel.org
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [96.44.175.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CC741A2846;
	Mon, 11 Nov 2024 20:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.44.175.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731355969; cv=none; b=pFVadmyiJU+8RehvQAnGM+yKkMDxjlDGEr98V8o2FDyc4131KpgwWBBuOlw3VLOK2ZaJnEtWOa5sRp8ea/eIpiqTbqINcdNV3xONkjIMl1higieK22joQB4o4iDBQNWGzSGgaz992l/2ZB8OiD65tzdOwDndFgQ/pIE34hYmreQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731355969; c=relaxed/simple;
	bh=GDpo5XUbDvTYBZOz3sSuPu22HWXvQHccFYdm81ABpTw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JlPMHX0W5YL6heWTaF1LpA9f8Q0yY8FxQaQItjHXxFhTf9Uq9Y6jK+xLnmacrTMMcSQltJnyl+8HYbiioAPMxnqlPjnSStJnMv/EObdkNMiGx+6dDCi6frs/NgdKAIxVUuH4mMPhYiEKcLV1PE25l4dph9xpWzSp8F2+o5hXCXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com; spf=pass smtp.mailfrom=HansenPartnership.com; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=aJumCQrN; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=aJumCQrN; arc=none smtp.client-ip=96.44.175.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=HansenPartnership.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1731355966;
	bh=GDpo5XUbDvTYBZOz3sSuPu22HWXvQHccFYdm81ABpTw=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=aJumCQrNKYSr/Yd8/URxC7kO+QDWUxG1Q3CDRTb5nIzKy4ozuyU6VJ/QlWW71IigQ
	 p2DJZRp5YSof/Y0Ueh4HndQaKAD500nkyZ7lwfHuewceYR2cHK9fY40pMt8UuiLoZV
	 c2DOm3LhuMzzhZ+enRu+B4z9MAfQZLEZ6jUjirVA=
Received: from localhost (localhost [127.0.0.1])
	by bedivere.hansenpartnership.com (Postfix) with ESMTP id 40ED81285FB5;
	Mon, 11 Nov 2024 15:12:46 -0500 (EST)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id E2m7NtIDHpbL; Mon, 11 Nov 2024 15:12:46 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1731355966;
	bh=GDpo5XUbDvTYBZOz3sSuPu22HWXvQHccFYdm81ABpTw=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=aJumCQrNKYSr/Yd8/URxC7kO+QDWUxG1Q3CDRTb5nIzKy4ozuyU6VJ/QlWW71IigQ
	 p2DJZRp5YSof/Y0Ueh4HndQaKAD500nkyZ7lwfHuewceYR2cHK9fY40pMt8UuiLoZV
	 c2DOm3LhuMzzhZ+enRu+B4z9MAfQZLEZ6jUjirVA=
Received: from [10.106.168.49] (unknown [167.220.104.49])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id AEF3B1280659;
	Mon, 11 Nov 2024 15:12:45 -0500 (EST)
Message-ID: <5f2b10d550dd0d596b37d20e275c69e85cc718a7.camel@HansenPartnership.com>
Subject: Re: [PATCH v2] tpm: Opt-in in disable PCR integrity protection
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: Mimi Zohar <zohar@linux.ibm.com>, Jarkko Sakkinen <jarkko@kernel.org>, 
 linux-integrity@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, Peter
 Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>
Cc: Roberto Sassu <roberto.sassu@huawei.com>, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Date: Mon, 11 Nov 2024 12:12:44 -0800
In-Reply-To: <dd51366e50de86e8a6002f2f53801c53a9b770f3.camel@linux.ibm.com>
References: <20241107095138.78209-1-jarkko@kernel.org>
	 <76d9ae11c339b589a8ec94f010e7439b7ce7d283.camel@HansenPartnership.com>
	 <D5FZT0QPHL0O.231WD6VUHC48X@kernel.org>
	 <10296fd8b0fcbf1d813577ef41738ffea12b70d1.camel@HansenPartnership.com>
	 <dd51366e50de86e8a6002f2f53801c53a9b770f3.camel@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 2024-11-11 at 14:53 -0500, Mimi Zohar wrote:
> On Thu, 2024-11-07 at 08:52 -0500, James Bottomley wrote:
> > On Thu, 2024-11-07 at 15:49 +0200, Jarkko Sakkinen wrote:
> > > On Thu Nov 7, 2024 at 3:20 PM EET, James Bottomley wrote:
> > > > On Thu, 2024-11-07 at 11:51 +0200, Jarkko Sakkinen wrote:
> > > > [...]
> > > > > +void tpm_buf_append_auth(struct tpm_chip *chip, struct
> > > > > tpm_buf
> > > > > *buf,
> > > > > +                        u8 attributes, u8 *passphrase, int
> > > > > passphrase_len)
> > > > > +{
> > > > > +       /* offset tells us where the sessions area begins */
> > > > > +       int offset = buf->handles * 4 + TPM_HEADER_SIZE;
> > > > > +       u32 len = 9 + passphrase_len;
> > > > > +
> > > > > +       if (tpm_buf_length(buf) != offset) {
> > > > > +               /* not the first session so update the
> > > > > existing
> > > > > length */
> > > > > +               len += get_unaligned_be32(&buf-
> > > > > >data[offset]);
> > > > > +               put_unaligned_be32(len, &buf->data[offset]);
> > > > > +       } else {
> > > > > +               tpm_buf_append_u32(buf, len);
> > > > > +       }
> > > > > +       /* auth handle */
> > > > > +       tpm_buf_append_u32(buf, TPM2_RS_PW);
> > > > > +       /* nonce */
> > > > > +       tpm_buf_append_u16(buf, 0);
> > > > > +       /* attributes */
> > > > > +       tpm_buf_append_u8(buf, 0);
> > > > > +       /* passphrase */
> > > > > +       tpm_buf_append_u16(buf, passphrase_len);
> > > > > +       tpm_buf_append(buf, passphrase, passphrase_len);
> > > > > +}
> > > > > +
> > > > 
> > > > The rest of the code looks fine, but if you're going to extract
> > > > this as a separate function instead of doing the open coded
> > > > struct
> > > > tpm2_null_auth that was there originally, you should probably
> > > > extract and use the tpm2_buf_append_auth() function in
> > > > trusted_tpm2.c
> > > 
> > > So this was straight up from Mimi's original patch :-)
> > 
> > Yes, I had the same comment prepped for that too.
> 
> But it wasn't sent ...

no.

> > 
> > > Hmm... was there duplicate use for this in the patch? I'll check
> > > this.
> > 
> > The original open coded the empty auth append with struct
> > tpm2_null_auth since it's the only user.  However, since we do have
> > another user in trusted keys, it might make sense to consolidate.
> 
> Instead of delaying the current patch from being upstreamed, perhaps
> this change can be deferred?

I don't see why not; it was the introduction of the new function rather
than going back to the struct tpm2_null_auth_area of the original that
caught my attention.

James


