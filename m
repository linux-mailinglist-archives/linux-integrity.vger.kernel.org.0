Return-Path: <linux-integrity+bounces-7142-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D63F2B7C80D
	for <lists+linux-integrity@lfdr.de>; Wed, 17 Sep 2025 14:04:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE42A1C0459E
	for <lists+linux-integrity@lfdr.de>; Wed, 17 Sep 2025 09:39:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B970343D70;
	Wed, 17 Sep 2025 09:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aA123NGr"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC134306B22;
	Wed, 17 Sep 2025 09:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758101909; cv=none; b=U0clGr+0Nfkwx4H2pJqWPUYByn57lHLMu+IYW36DZYXiiX3yHtzdJPNvY0LS42jXOQPx/oMXtgJmmneyTFZuBTuUmW71IME5kiJCyNtJ6ZDB/3crM+5suETAZqkHZOgrbVG3jYQk6yxLbt2bYIT+KnwaIK8YJ1ucqiPJeX+hTOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758101909; c=relaxed/simple;
	bh=Jio7bAVw9qSJCBnMd44EyKscciXyCsu3ThljIX/NLok=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CywAvzDfVSHRKCbNY1C0JgYMcrlePGQvXSM2WXDEpFX3Bo9OIzG1tNExiPx6GCUoZwaiG0yKIHK6hTbeqkAJes1k22UO3Ku2VPEHCL9EeHirzTvtwZAhWTITj4SPjpfuneWsmp96yBnlGfRTYBPf8vvfb8hd8j3ryaPlsR4FKgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aA123NGr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D726C4CEF0;
	Wed, 17 Sep 2025 09:38:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758101908;
	bh=Jio7bAVw9qSJCBnMd44EyKscciXyCsu3ThljIX/NLok=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aA123NGre/Y337CiqEBShrS4jPBc82oq0oClBDi8S5SoV4ZvC37x/MkzmPxmAqUuo
	 f7mvhgd/sVw0LkDQrxwgKKWvn+qSTWyzSC8Xl7aHazts+ItYYStGeQWD9kDUPx/tXC
	 zSekAoppOpm//P7gzr2SuoYlYAdgtSmDDjHx8Q6vfj4z+IZMqFZm9tsVnX7LT3afFV
	 Mxuvu6W/FPyfB3igMdJmB0xl3HQshKJ56I17gmMAzVEv5OTaa4U/dOzoF8s70HT5zh
	 JIFW9G3A0lzbHdy3hsoGaO4J5NrzwABG+2fh6w+pqqT9Qhycw6Sw30tMuPW9i5RHqo
	 l6VFg19ajS9aQ==
Date: Wed, 17 Sep 2025 10:38:23 +0100
From: Lee Jones <lee@kernel.org>
To: Nathan Chancellor <nathan@kernel.org>
Cc: Qunqin Zhao <zhaoqunqin@loongson.cn>, herbert@gondor.apana.org.au,
	jarkko@kernel.org, linux-kernel@vger.kernel.org,
	loongarch@lists.linux.dev, davem@davemloft.net,
	linux-crypto@vger.kernel.org, peterhuewe@gmx.de, jgg@ziepe.ca,
	linux-integrity@vger.kernel.org, sgarzare@redhat.com
Subject: Re: [GIT PULL] Immutable branch between MFD, Char and Crypto due for
 the v6.18 merge window
Message-ID: <20250917093823.GG3893363@google.com>
References: <20250705072045.1067-1-zhaoqunqin@loongson.cn>
 <20250902124205.GL2163762@google.com>
 <20250912213256.GA3062565@ax162>
 <20250916075835.GB1637058@google.com>
 <20250916191658.GA1249009@ax162>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250916191658.GA1249009@ax162>

On Tue, 16 Sep 2025, Nathan Chancellor wrote:

> On Tue, Sep 16, 2025 at 08:58:35AM +0100, Lee Jones wrote:
> > On Fri, 12 Sep 2025, Nathan Chancellor wrote:
> > > > The following changes since commit 8f5ae30d69d7543eee0d70083daf4de8fe15d585:
> > > > 
> > > >   Linux 6.17-rc1 (2025-08-10 19:41:16 +0300)
> ...
> > > > Qunqin Zhao (4):
> > > ...
> > > >       tpm: Add a driver for Loongson TPM device
> > > 
> > > This one needs a fix up due to commit 07d8004d6fb9 ("tpm: add bufsiz
> > > parameter in the .send callback") in 6.17-rc1, as I am seeing the
> > > following error in next-20250912.
> > > 
> > >   drivers/char/tpm/tpm_loongson.c:48:17: error: initialization of 'int (*)(struct tpm_chip *, u8 *, size_t,  size_t)' {aka 'int (*)(struct tpm_chip *, unsigned char *, long unsigned int,  long unsigned int)'} from incompatible pointer type 'int (*)(struct tpm_chip *, u8 *, size_t)' {aka 'int (*)(struct tpm_chip *, unsigned char *, long unsigned int)'} [-Wincompatible-pointer-types]
> > >      48 |         .send = tpm_loongson_send,
> > >         |                 ^~~~~~~~~~~~~~~~~
> > >   drivers/char/tpm/tpm_loongson.c:48:17: note: (near initialization for 'tpm_loongson_ops.send')
> > >   drivers/char/tpm/tpm_loongson.c:31:12: note: 'tpm_loongson_send' declared here
> > >      31 | static int tpm_loongson_send(struct tpm_chip *chip, u8 *buf, size_t count)
> > >         |            ^~~~~~~~~~~~~~~~~
> > > 
> > > Can you squash it or do you want a separate patch?
> > > 
> > > Cheers,
> > > Nathan
> > > 
> > > diff --git a/drivers/char/tpm/tpm_loongson.c b/drivers/char/tpm/tpm_loongson.c
> > > index a4ec23639911..9e50250763d1 100644
> > > --- a/drivers/char/tpm/tpm_loongson.c
> > > +++ b/drivers/char/tpm/tpm_loongson.c
> > > @@ -28,7 +28,7 @@ static int tpm_loongson_recv(struct tpm_chip *chip, u8 *buf, size_t count)
> > >  	return cmd_ret->data_len;
> > >  }
> > >  
> > > -static int tpm_loongson_send(struct tpm_chip *chip, u8 *buf, size_t count)
> > > +static int tpm_loongson_send(struct tpm_chip *chip, u8 *buf, size_t bufsiz, size_t count)
> > >  {
> > >  	struct loongson_se_engine *tpm_engine = dev_get_drvdata(&chip->dev);
> > >  	struct tpm_loongson_cmd *cmd = tpm_engine->command;
> > 
> > This will break my local branch.
> > 
> > Any chance of an immutable pull-request for:
> > 
> >   07d8004d6fb9 ("tpm: add bufsiz parameter in the .send callback")
> 
> I might be missing something but this commit is in Linux 6.17-rc1, which
> this tree is based on according to both 'git log' and the lead in to
> your pull request at the top, so your local branch is already broken.
> That error message was taken from the tip of your tree and the fix was
> tested against it as well.
> 
> "tpm: Add a driver for Loongson TPM device" was sent back in early July,
> so it was never updated for this conflict.

Ah, gotcha.  I thought you were saying that 07d8004d6fb9 ("tpm: add
bufsiz parameter in the .send callback") was applied somewhere else.  In
which case, I need to figure out why my build testing didn't catch it.

I'd be happy with a formal patch from you or I can create the patch and
add your {Reported,Suggested}-by.  How would you like to proceed?

-- 
Lee Jones [李琼斯]

