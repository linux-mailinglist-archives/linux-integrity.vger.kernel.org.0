Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6C4B3B793E
	for <lists+linux-integrity@lfdr.de>; Tue, 29 Jun 2021 22:20:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233487AbhF2UXM (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 29 Jun 2021 16:23:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:44138 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234073AbhF2UXL (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 29 Jun 2021 16:23:11 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id CBB8D61DBA;
        Tue, 29 Jun 2021 20:20:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624998044;
        bh=gw9AVLOUztWmRXWvM9/xRh99n0bjCRmSFulGqTeihMg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SNiQ5hALN+ur2lXkwmiG+bSeejKhOJnbAmfOvPqiSe8HJKj0vcWWuOwP83/w9+8Tr
         Owoxv0A9P5WQWh65z+c1Y1LX2CqFviNQdrI6CwdVKtCkWErBxCUwEdn9FysG/VPBWE
         mgi4FPA+MMRVpC8Hq/fyzeXCa/YAbqzeyjMQpDoTd2ww35pp8VgB/s/sp2PxmfoV1W
         nCJJt9BRuroncNUoRfvamRn+nxHx638UT8RgZ5fAiuW41jz/tsLOT+OZvJflvPmfyy
         Q8TgQTUm8V7e+Z6qnOcD4UeF7ZXBtM9gzX/9+E86WuUg4oqWsz21QWDYBO6/08JoMm
         m++DWZBEQ3H1w==
Date:   Tue, 29 Jun 2021 23:20:41 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Stefan Berger <stefanb@linux.ibm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        James Morris James Morris <jmorris@namei.org>,
        David Howells <dhowells@redhat.com>,
        Peter Huewe <peterhuewe@gmx.de>
Subject: Re: [GIT PULL] TPM DEVICE DRIVER changes for v5.14
Message-ID: <20210629202041.4ptesmrs67hkbzxn@kernel.org>
References: <20210623135600.n343aglmvu272fsg@kernel.org>
 <CAHk-=whhEf=xJz=rdcLWNnRU1uR6Ft-mn6xNrOg3OcQ=5cX6BQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whhEf=xJz=rdcLWNnRU1uR6Ft-mn6xNrOg3OcQ=5cX6BQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, Jun 28, 2021 at 10:34:26AM -0700, Linus Torvalds wrote:
> On Wed, Jun 23, 2021 at 6:56 AM Jarkko Sakkinen <jarkko@kernel.org> wrote:
> >
> > Contains bug fixes for TPM, and support for signing modules using elliptic
> > curve keys, which I promised to pick up to my tree.
> 
> I pulled this, but then I looked at the key type changes, and that
> made me so scared that I unpulled it again.
> 
> In particular, that code will do
> 
>     shell rm -f $(CONFIG_MODULE_SIG_KEY)
> 
> from the Makefile if some config options have changed.
> 
> That just seems too broken for words. Maybe I misunderstand this, but
> this really seems like an easy mistake might cause the kernel build to
> actively start removing some random user key files that the user
> pointed at previously.
> 
>                   Linus

Since there was still a new fix for the series [*], I'd rather refine
the pull request without these patches, and not risk them being blocker
for the rest of the commits.

[*] https://lore.kernel.org/linux-integrity/20210629201257.dr77kemy66mxpox5@kernel.org/

/Jarkko
