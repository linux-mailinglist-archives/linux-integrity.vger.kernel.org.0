Return-Path: <linux-integrity+bounces-7104-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 10514B5A13D
	for <lists+linux-integrity@lfdr.de>; Tue, 16 Sep 2025 21:17:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 97A812A837F
	for <lists+linux-integrity@lfdr.de>; Tue, 16 Sep 2025 19:17:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD2162D9488;
	Tue, 16 Sep 2025 19:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="irVToYby"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85E9727702A;
	Tue, 16 Sep 2025 19:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758050224; cv=none; b=iZ2IgqB37l0h7HLwChU9k4+LlRWDg28yQ+ixzWY70IBuA4lFUDY28mxBMA8Ia28Gf4gKjzbFW6eTeOmcB3zpggjR2ROi0L9xTcbDNk1zUSydc+lXhOYFFX9ceezT8v4KO5NnXJUebtbTbTZtZsbe2OoVvPA3xvN0jGXpajS0svU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758050224; c=relaxed/simple;
	bh=MCfy3UUe9SGDvblB2otWUElDBg2kG3cObuhgRkiSZaE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KnMepHA7BiNFGMwRdjVstAlfQvqVykVErT/KETEFNi+NniikhiIFPLlPv6DvU4oCvB0YGNVcB5NHec23JtFtUzbHzGhbkvgndMyX5A+JMU4Wb9+lmcWdyh7olcJRfvPxsEV1i5rCarM/9sULu4fCrm3Hn3Ibv8h1r0Hrxah3NP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=irVToYby; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BAC0C4CEEB;
	Tue, 16 Sep 2025 19:17:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758050224;
	bh=MCfy3UUe9SGDvblB2otWUElDBg2kG3cObuhgRkiSZaE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=irVToYbyKA9zV+Jv/UyZYdBPHUu5trW7OpgacTJmnzFxEPjY5GODB5+/dB47WdJOM
	 wUsXChj1HRtPu/aBNMTmTiwdDlN7Jn1NA2M2AT8HkeY0lpaTiKQDLqUh8OyKJYa08k
	 82uz577D9jimv+LWW+4RSr36XmfkfxjhzCiSMQKHHH//N2uC0Bv9/CByfUl1IAf6xv
	 kUdTXtitRRqkHDf4ujw4pYee2s9k+FlV1KiB8MlmOFydY/2h46w4RJokFo+uALCWUA
	 F4vjsWGxkKaTNUzPqBdPft3WdQCp+6EYP8kdsFckQgIvU9/A990/O+vm/kv5wnnSiZ
	 hTSP7K7d/TS7g==
Date: Tue, 16 Sep 2025 12:16:58 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Lee Jones <lee@kernel.org>
Cc: Qunqin Zhao <zhaoqunqin@loongson.cn>, herbert@gondor.apana.org.au,
	jarkko@kernel.org, linux-kernel@vger.kernel.org,
	loongarch@lists.linux.dev, davem@davemloft.net,
	linux-crypto@vger.kernel.org, peterhuewe@gmx.de, jgg@ziepe.ca,
	linux-integrity@vger.kernel.org, sgarzare@redhat.com
Subject: Re: [GIT PULL] Immutable branch between MFD, Char and Crypto due for
 the v6.18 merge window
Message-ID: <20250916191658.GA1249009@ax162>
References: <20250705072045.1067-1-zhaoqunqin@loongson.cn>
 <20250902124205.GL2163762@google.com>
 <20250912213256.GA3062565@ax162>
 <20250916075835.GB1637058@google.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250916075835.GB1637058@google.com>

On Tue, Sep 16, 2025 at 08:58:35AM +0100, Lee Jones wrote:
> On Fri, 12 Sep 2025, Nathan Chancellor wrote:
> > > The following changes since commit 8f5ae30d69d7543eee0d70083daf4de8fe15d585:
> > > 
> > >   Linux 6.17-rc1 (2025-08-10 19:41:16 +0300)
...
> > > Qunqin Zhao (4):
> > ...
> > >       tpm: Add a driver for Loongson TPM device
> > 
> > This one needs a fix up due to commit 07d8004d6fb9 ("tpm: add bufsiz
> > parameter in the .send callback") in 6.17-rc1, as I am seeing the
> > following error in next-20250912.
> > 
> >   drivers/char/tpm/tpm_loongson.c:48:17: error: initialization of 'int (*)(struct tpm_chip *, u8 *, size_t,  size_t)' {aka 'int (*)(struct tpm_chip *, unsigned char *, long unsigned int,  long unsigned int)'} from incompatible pointer type 'int (*)(struct tpm_chip *, u8 *, size_t)' {aka 'int (*)(struct tpm_chip *, unsigned char *, long unsigned int)'} [-Wincompatible-pointer-types]
> >      48 |         .send = tpm_loongson_send,
> >         |                 ^~~~~~~~~~~~~~~~~
> >   drivers/char/tpm/tpm_loongson.c:48:17: note: (near initialization for 'tpm_loongson_ops.send')
> >   drivers/char/tpm/tpm_loongson.c:31:12: note: 'tpm_loongson_send' declared here
> >      31 | static int tpm_loongson_send(struct tpm_chip *chip, u8 *buf, size_t count)
> >         |            ^~~~~~~~~~~~~~~~~
> > 
> > Can you squash it or do you want a separate patch?
> > 
> > Cheers,
> > Nathan
> > 
> > diff --git a/drivers/char/tpm/tpm_loongson.c b/drivers/char/tpm/tpm_loongson.c
> > index a4ec23639911..9e50250763d1 100644
> > --- a/drivers/char/tpm/tpm_loongson.c
> > +++ b/drivers/char/tpm/tpm_loongson.c
> > @@ -28,7 +28,7 @@ static int tpm_loongson_recv(struct tpm_chip *chip, u8 *buf, size_t count)
> >  	return cmd_ret->data_len;
> >  }
> >  
> > -static int tpm_loongson_send(struct tpm_chip *chip, u8 *buf, size_t count)
> > +static int tpm_loongson_send(struct tpm_chip *chip, u8 *buf, size_t bufsiz, size_t count)
> >  {
> >  	struct loongson_se_engine *tpm_engine = dev_get_drvdata(&chip->dev);
> >  	struct tpm_loongson_cmd *cmd = tpm_engine->command;
> 
> This will break my local branch.
> 
> Any chance of an immutable pull-request for:
> 
>   07d8004d6fb9 ("tpm: add bufsiz parameter in the .send callback")

I might be missing something but this commit is in Linux 6.17-rc1, which
this tree is based on according to both 'git log' and the lead in to
your pull request at the top, so your local branch is already broken.
That error message was taken from the tip of your tree and the fix was
tested against it as well.

"tpm: Add a driver for Loongson TPM device" was sent back in early July,
so it was never updated for this conflict.

Cheers,
Nathan

