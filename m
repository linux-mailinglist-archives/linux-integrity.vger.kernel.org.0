Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9827309726
	for <lists+linux-integrity@lfdr.de>; Sat, 30 Jan 2021 18:17:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230281AbhA3RP4 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sat, 30 Jan 2021 12:15:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:57028 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230197AbhA3RPz (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Sat, 30 Jan 2021 12:15:55 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0A3B464E11;
        Sat, 30 Jan 2021 17:15:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612026915;
        bh=Oyuo7h5UergkvVDL9fR3M7gdK4HQFxBivD4yC0hVtr8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QFNMaK5bzrFpO3wQuiTR9G298//O1CINM9cnjrO7/eEAwJQF96FkPEdErNQVcZ8Kp
         XFaKgco7L/GlyvgOX045oSJGFKPCKVbeEuTNTKBRA9uyHescqlUx4XlV6DWk1kCdHY
         VkW4chQJnDyIDG0VXwKDyycBK9Yjvle+lrzodOSSeXb74FXzKcDQAfo8Dl0fs3rGAi
         JbhNn1XRP44/BHdkzhHDWWYiiPbyrMITaOdKofH1ABxhHCCs7FKU53kTe9CiDc75H+
         6JfcC/cnBNlwUubNqpsoiMWCE59EC1dHsCS8K47mV7WOrjKcc+F4w8BkSzXQuqHn8E
         pPjiFePwK3x0Q==
Date:   Sat, 30 Jan 2021 19:15:10 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        James Bottomley <James.Bottomley@hansenpartnership.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        James Morris James Morris <jmorris@namei.org>,
        David Howells <dhowells@redhat.com>,
        Peter Huewe <peterhuewe@gmx.de>
Subject: Re: [GIT PULL] tpmdd updates for v5.12-rc1
Message-ID: <YBWUHkbNt6OLoeUq@kernel.org>
References: <YBNcv8jLEDE8C/IW@kernel.org>
 <CAHk-=wjk7zEOFEjGWZmGF8_dcitBQ_dPUMSkr-g7B7cYcXGvSQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjk7zEOFEjGWZmGF8_dcitBQ_dPUMSkr-g7B7cYcXGvSQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, Jan 28, 2021 at 07:38:21PM -0800, Linus Torvalds wrote:
> On Thu, Jan 28, 2021 at 4:54 PM Jarkko Sakkinen <jarkko@kernel.org> wrote:
> >
> > This contains bug fixes for tpm_tis driver, which had a racy wait for
> > hardware state change to be ready to send a command to the TPM chip. The
> > bug has existed already since 2006, but has only made itself known in
> > recent past.
> 
> Hmm. Is this for the next merge window? The subject line implies that,
> as does the addition of the cr50 driver.
> 
> But the commentary about fixes implies that at least part of it should
> be in 5.11?

This was meant for 5.12 but the timing was *way* too early. I'll take this
one back. Just to unambiguity reasons I'll use tpmdd-next-v5.12-rc1-v2 tag
for my final v5.12 PR, once I send it.

I considered a bit, and I really think that it would make a lot of sense
to do a late 5.11 just containing the two commits from James, namely:

1. tpm_tis: Fix check_locality for correct locality acquisition
2. tpm_tis: Clean up locality release 

James: Does this make sense to you? 

>             Linus

/Jarkko
