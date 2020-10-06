Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC2CE284E9E
	for <lists+linux-integrity@lfdr.de>; Tue,  6 Oct 2020 17:07:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725970AbgJFPHp (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 6 Oct 2020 11:07:45 -0400
Received: from mx2.suse.de ([195.135.220.15]:34438 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725943AbgJFPHo (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 6 Oct 2020 11:07:44 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id CED6EAF1F;
        Tue,  6 Oct 2020 15:07:43 +0000 (UTC)
Date:   Tue, 6 Oct 2020 17:07:42 +0200
From:   Petr Vorel <pvorel@suse.cz>
To:     Ken Goldman <kgold@linux.ibm.com>
Cc:     Linux Integrity <linux-integrity@vger.kernel.org>
Subject: Re: [PATCH 3/6] ima-evm-utils: When using the IBM TSS, link in its
 library
Message-ID: <20201006150742.GA16684@dell5510>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <136e154e-16bc-9d6e-90a3-075cc67be333@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <136e154e-16bc-9d6e-90a3-075cc67be333@linux.ibm.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Ken,

> This is a prerequisite for the code change that uses the TSS rather
> than the command line tools.

> Signed-off-by: Ken Goldman <kgoldman@us.ibm.com>
> ---
>  src/Makefile.am | 1 +
>  1 file changed, 1 insertion(+)

> diff --git a/src/Makefile.am b/src/Makefile.am
> index d6c779f..bf18caf 100644
> --- a/src/Makefile.am
> +++ b/src/Makefile.am
> @@ -26,6 +26,7 @@ if USE_PCRTSS
>  evmctl_SOURCES += pcr_tss.c
>  else
>  evmctl_SOURCES += pcr_tsspcrread.c
> +evmctl_LDADD += -libmtss
>  endif
But pcr_tsspcrread.c uses the binary (tsspcrread).

pcr_tss.c uses TSS, but that's already covered:
ldd src/.libs/evmctl |grep tss
	libtss2-rc.so.0 => /usr/lib64/libtss2-rc.so.0 (0x00007fb82514c000)
	libtss2-esys.so.0 => /usr/lib64/libtss2-esys.so.0 (0x00007fb824eba000)
	libtss2-sys.so.0 => /usr/lib64/libtss2-sys.so.0 (0x00007fb8244ba000)
	libtss2-mu.so.0 => /usr/lib64/libtss2-mu.so.0 (0x00007fb824276000)

Thus I thing this patch is invalid. Or do I miss something obvious?

And other thing: could you please rebase your patches for next-testing branch?
It's not applicable for master, next and next-testing.

Kind regards,
Petr
