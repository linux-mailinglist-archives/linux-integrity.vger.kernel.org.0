Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B57AC30C3A0
	for <lists+linux-integrity@lfdr.de>; Tue,  2 Feb 2021 16:25:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235191AbhBBPYn (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 2 Feb 2021 10:24:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:39434 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235363AbhBBPQz (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 2 Feb 2021 10:16:55 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 21C3464F54;
        Tue,  2 Feb 2021 15:15:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612278955;
        bh=9CDdITm+XMBuPvwZUnYLZ4vvX9fQtJebA/oGAu2vTwQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=i4uYT7mVUoRAMrFZDSzIwT4fpa+g5HnBHZXoJn4xL11cYAPHIIAppb7q1iQjHTbRm
         L5lZ1mfZYTJb2BpATrjpWCowqrJLJoOQ11BCUzQ1AmC2NLUVOlobGz2RGMQdhvWAd2
         HZ7dzM4ITTrvg0VbQ+0YAQCTQHZiGqX3/tjdrTqF5kQXl27zhOXdJ4L+Fh8efj2Osx
         fWQw8o8ee0bHjUlJfTtLH17HQinIHt5kgud7ixQgauHT1jliK6pcLKSsOZSWZAZ2nq
         D3tfMEJ2qgvGhI/fzkdIHeCpkzbDWo1Ir0QTrwXwOyiuKe+2gON1oJaz53UwW4TGyX
         CTzt5m9ivxCiQ==
Date:   Tue, 2 Feb 2021 17:15:47 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     James Bottomley <James.Bottomley@hansenpartnership.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        James Morris James Morris <jmorris@namei.org>,
        David Howells <dhowells@redhat.com>,
        Peter Huewe <peterhuewe@gmx.de>
Subject: Re: [GIT PULL] tpmdd updates for v5.12-rc1
Message-ID: <YBlso9KxuZxT0P6D@kernel.org>
References: <YBNcv8jLEDE8C/IW@kernel.org>
 <CAHk-=wjk7zEOFEjGWZmGF8_dcitBQ_dPUMSkr-g7B7cYcXGvSQ@mail.gmail.com>
 <YBWUHkbNt6OLoeUq@kernel.org>
 <CAHk-=whCPotCrco-Q4hUfgoG3+6uNn_CprxbuV1mQtxJHm0gfg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whCPotCrco-Q4hUfgoG3+6uNn_CprxbuV1mQtxJHm0gfg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Sat, Jan 30, 2021 at 10:44:24AM -0800, Linus Torvalds wrote:
> On Sat, Jan 30, 2021 at 9:15 AM Jarkko Sakkinen <jarkko@kernel.org> wrote:
> >
> > This was meant for 5.12 but the timing was *way* too early. I'll take this
> > one back. Just to unambiguity reasons I'll use tpmdd-next-v5.12-rc1-v2 tag
> > for my final v5.12 PR, once I send it.
> >
> > I considered a bit, and I really think that it would make a lot of sense
> > to do a late 5.11 just containing the two commits from James
> 
> Ok. I'll ignore this pull request, and will expect the "real" ones later.

Alright, thank you.

> Thanks,
> 
>              Linus

/Jarkko
