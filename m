Return-Path: <linux-integrity+bounces-4064-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B2F39C0829
	for <lists+linux-integrity@lfdr.de>; Thu,  7 Nov 2024 14:52:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 344B41F239FE
	for <lists+linux-integrity@lfdr.de>; Thu,  7 Nov 2024 13:52:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3791C20F5AA;
	Thu,  7 Nov 2024 13:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="FVk4UzMz";
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="FVk4UzMz"
X-Original-To: linux-integrity@vger.kernel.org
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [96.44.175.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8382220FA81;
	Thu,  7 Nov 2024 13:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.44.175.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730987529; cv=none; b=RG8d6eVws+/yOI0AZGYJTVFg+dsVqcQd66NfqcluCqEY5IEDGXIJChZslyWB91Bn6sPlr8jRSODcKZpiaHQSzMbfPaVYMhNbJXUNlnJ/4zVJX13v9CcaKw27hssxq8BM+Pk6MoN8bcTvOKaNH3CN3GQV9iRQzs7BbsiOPN60+Ak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730987529; c=relaxed/simple;
	bh=GgoWWJlxURJ1HeK6ZNXcXEMbIMwTJeBVOTlimc4RSe8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YhzseuOGEuJKMX6kJSy2pMc0tx+v9JJJ5V6FLmleZk5MNRrujJCN3UcepIm2aD11Jbp3bzri9XdZJ65JbjbvmUBVeF/IXWVMOUNgPBdvQHvfjHKwk4nJXbW8CbqC4UoaZ80kIUJbC1sXdcNyI3Bd3AUuGSpB7DxQxzWMh2wshic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com; spf=pass smtp.mailfrom=HansenPartnership.com; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=FVk4UzMz; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=FVk4UzMz; arc=none smtp.client-ip=96.44.175.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=HansenPartnership.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1730987526;
	bh=GgoWWJlxURJ1HeK6ZNXcXEMbIMwTJeBVOTlimc4RSe8=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=FVk4UzMzLFPcuKuNBF5rj58ThdWMts/19excLQSrXXXgkdTp5sPWcnpxVzF+r12jH
	 y5XkjmsjeOc6lpp7yJBZ4KXknkJNE/TEH0M23CUiwUJW8LrdA2o/Cj42DzfKKd87za
	 uSw1M2lrWhX9WphB799tbLAHgfDDan8gN6CJ5pfc=
Received: from localhost (localhost [127.0.0.1])
	by bedivere.hansenpartnership.com (Postfix) with ESMTP id 6EDA01286544;
	Thu, 07 Nov 2024 08:52:06 -0500 (EST)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id udYK4MnnoXrs; Thu,  7 Nov 2024 08:52:06 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1730987526;
	bh=GgoWWJlxURJ1HeK6ZNXcXEMbIMwTJeBVOTlimc4RSe8=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=FVk4UzMzLFPcuKuNBF5rj58ThdWMts/19excLQSrXXXgkdTp5sPWcnpxVzF+r12jH
	 y5XkjmsjeOc6lpp7yJBZ4KXknkJNE/TEH0M23CUiwUJW8LrdA2o/Cj42DzfKKd87za
	 uSw1M2lrWhX9WphB799tbLAHgfDDan8gN6CJ5pfc=
Received: from lingrow.int.hansenpartnership.com (unknown [IPv6:2601:5c4:4302:c21::a774])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 7281B1286301;
	Thu, 07 Nov 2024 08:52:05 -0500 (EST)
Message-ID: <10296fd8b0fcbf1d813577ef41738ffea12b70d1.camel@HansenPartnership.com>
Subject: Re: [PATCH v2] tpm: Opt-in in disable PCR integrity protection
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: Jarkko Sakkinen <jarkko@kernel.org>, linux-integrity@vger.kernel.org, 
 Jonathan Corbet <corbet@lwn.net>, Peter Huewe <peterhuewe@gmx.de>, Jason
 Gunthorpe <jgg@ziepe.ca>
Cc: Roberto Sassu <roberto.sassu@huawei.com>, Mimi Zohar
 <zohar@linux.ibm.com>,  linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Thu, 07 Nov 2024 08:52:02 -0500
In-Reply-To: <D5FZT0QPHL0O.231WD6VUHC48X@kernel.org>
References: <20241107095138.78209-1-jarkko@kernel.org>
	 <76d9ae11c339b589a8ec94f010e7439b7ce7d283.camel@HansenPartnership.com>
	 <D5FZT0QPHL0O.231WD6VUHC48X@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 2024-11-07 at 15:49 +0200, Jarkko Sakkinen wrote:
> On Thu Nov 7, 2024 at 3:20 PM EET, James Bottomley wrote:
> > On Thu, 2024-11-07 at 11:51 +0200, Jarkko Sakkinen wrote:
> > [...]
> > > +void tpm_buf_append_auth(struct tpm_chip *chip, struct tpm_buf
> > > *buf,
> > > +                        u8 attributes, u8 *passphrase, int
> > > passphrase_len)
> > > +{
> > > +       /* offset tells us where the sessions area begins */
> > > +       int offset = buf->handles * 4 + TPM_HEADER_SIZE;
> > > +       u32 len = 9 + passphrase_len;
> > > +
> > > +       if (tpm_buf_length(buf) != offset) {
> > > +               /* not the first session so update the existing
> > > length */
> > > +               len += get_unaligned_be32(&buf->data[offset]);
> > > +               put_unaligned_be32(len, &buf->data[offset]);
> > > +       } else {
> > > +               tpm_buf_append_u32(buf, len);
> > > +       }
> > > +       /* auth handle */
> > > +       tpm_buf_append_u32(buf, TPM2_RS_PW);
> > > +       /* nonce */
> > > +       tpm_buf_append_u16(buf, 0);
> > > +       /* attributes */
> > > +       tpm_buf_append_u8(buf, 0);
> > > +       /* passphrase */
> > > +       tpm_buf_append_u16(buf, passphrase_len);
> > > +       tpm_buf_append(buf, passphrase, passphrase_len);
> > > +}
> > > +
> > 
> > The rest of the code looks fine, but if you're going to extract
> > this as a separate function instead of doing the open coded struct
> > tpm2_null_auth that was there originally, you should probably
> > extract and use the tpm2_buf_append_auth() function in
> > trusted_tpm2.c
> 
> So this was straight up from Mimi's original patch :-)

Yes, I had the same comment prepped for that too.

> Hmm... was there duplicate use for this in the patch? I'll check
> this.

The original open coded the empty auth append with struct
tpm2_null_auth since it's the only user.  However, since we do have
another user in trusted keys, it might make sense to consolidate.

James


