Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2DAB3B79B6
	for <lists+linux-integrity@lfdr.de>; Tue, 29 Jun 2021 23:10:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235337AbhF2VNP (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 29 Jun 2021 17:13:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:55228 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235288AbhF2VNO (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 29 Jun 2021 17:13:14 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3F75C61D8E;
        Tue, 29 Jun 2021 21:10:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625001046;
        bh=Vihb2Lt7gLwYGR7pQK/C0fGk+fZKr6WmhBI8AO8i67E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uO0/sgh2b1mrAbPPLwV1wcu4h6LskX0VVtGXkKZh4CYgWc6NbbzKLofUVZk5MjpBv
         qQj/V+lP+rsc+1cucf5XRx8+Q17gfvLYpXcIo9+yFhwRv3s7A/tQPcBWwdaBOpfQRl
         eYLUppPBxaolNF5V36Q1zOfsOM/TOEkPzDkDlTNpdxb/+AA+T1mAVkTgjHt5u3IbmU
         tIPH5oa/RUr4OiRuQnOkpMb00FQxwN0Xe2boaW8ghsvTOK04Ie4zRRfuS89sXUIkcc
         y09NqGnMnIVQXVH7Ghhgh6Ylu09n6ts+erKmwwyE882OFVD1TzpAp2p6s4OnseFTUx
         OJRGqxjaA9OiQ==
Date:   Wed, 30 Jun 2021 00:10:44 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Stefan Berger <stefanb@linux.ibm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        James Morris James Morris <jmorris@namei.org>,
        David Howells <dhowells@redhat.com>,
        Peter Huewe <peterhuewe@gmx.de>
Subject: Re: [GIT PULL] TPM DEVICE DRIVER changes for v5.14
Message-ID: <20210629211044.nqumpnkxt3ouhxcs@kernel.org>
References: <20210623135600.n343aglmvu272fsg@kernel.org>
 <CAHk-=whhEf=xJz=rdcLWNnRU1uR6Ft-mn6xNrOg3OcQ=5cX6BQ@mail.gmail.com>
 <20210629202041.4ptesmrs67hkbzxn@kernel.org>
 <CAHk-=who-5aibKGaCgn75KjDDJ_0OVR5SiXPJhvgvLT+BGN8kQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=who-5aibKGaCgn75KjDDJ_0OVR5SiXPJhvgvLT+BGN8kQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, Jun 29, 2021 at 02:08:53PM -0700, Linus Torvalds wrote:
> On Tue, Jun 29, 2021 at 1:20 PM Jarkko Sakkinen <jarkko@kernel.org> wrote:
> >
> > Since there was still a new fix for the series [*], I'd rather refine
> > the pull request without these patches, and not risk them being blocker
> > for the rest of the commits.
> 
> They seemed to be just the last two commits at the end of the series,
> so I could take everything up to 0178f9d0f60b ("tpm: Replace
> WARN_ONCE() with dev_err_once() in tpm_tis_status()") perhaps?
> 
> I can do that even without a new pull request (I've done that kind of
> thing before where I decide to pull everything but the last few
> commits). But admittedly I'd prefer to see a new pull request just so
> that I get a signed tag (which I wouldn't get if I just merged that
> top commit).
> 
>                      Linus

OK, that would be great! Please, do that. Thank you.

/Jarkko
