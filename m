Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3746743B433
	for <lists+linux-integrity@lfdr.de>; Tue, 26 Oct 2021 16:31:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236655AbhJZOdb (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 26 Oct 2021 10:33:31 -0400
Received: from vmicros1.altlinux.org ([194.107.17.57]:49874 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236729AbhJZOdV (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 26 Oct 2021 10:33:21 -0400
Received: from imap.altlinux.org (imap.altlinux.org [194.107.17.38])
        by vmicros1.altlinux.org (Postfix) with ESMTP id 115B772C8B8;
        Tue, 26 Oct 2021 17:30:55 +0300 (MSK)
Received: from altlinux.org (sole.flsd.net [185.75.180.6])
        by imap.altlinux.org (Postfix) with ESMTPSA id ED1924A46EC;
        Tue, 26 Oct 2021 17:30:54 +0300 (MSK)
Date:   Tue, 26 Oct 2021 17:30:54 +0300
From:   Vitaly Chikunov <vt@altlinux.org>
To:     Mimi Zohar <zohar@linux.ibm.com>, linux-integrity@vger.kernel.org
Cc:     Petr Vorel <petr.vorel@gmail.com>,
        Gleb Fotengauer-Malinovskiy <glebfm@altlinux.org>,
        "Dmitry V. Levin" <ldv@altlinux.org>
Subject: Re: [PATCH ima-evm-utils 2/2] upgrade to glibc-2.34 uses clone3
 causing CI to fail
Message-ID: <20211026143054.7khp5jxcyn2fzira@altlinux.org>
References: <20211026024929.535519-1-zohar@linux.ibm.com>
 <20211026024929.535519-2-zohar@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <20211026024929.535519-2-zohar@linux.ibm.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Mimi,

On Mon, Oct 25, 2021 at 10:49:29PM -0400, Mimi Zohar wrote:
> Both opensuse/tumbleweed and Alt Linux have upgraded to glibc-2.34,
> causing the CI testing to fail.  Disable seccomp (which is not needed
> anyway, since GA uses throwable virtual environments anyway).

JFYI. We decided to update our glibc package to fall-back from clone3 to
clone in case it's EPERM. So, after some time (perhaps a day) this
workaround will not be needed for ALT Linux. But this will not hurts
either and may be beneficial in the future.

Thanks,

> 
> options: --security-opt seccomp=unconfined
> 
> Suggested-by: Vitaly Chikunov <vt@altlinux.org>
> Acked-by: Petr Vorel <petr.vorel@gmail.com>
> Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
> ---
>  .github/workflows/ci.yml | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/.github/workflows/ci.yml b/.github/workflows/ci.yml
> index 0931f2487d50..ad611ad914b4 100644
> --- a/.github/workflows/ci.yml
> +++ b/.github/workflows/ci.yml
> @@ -103,6 +103,7 @@ jobs:
>      container:
>        image: ${{ matrix.container }}
>        env: ${{ matrix.env }}
> +      options: --security-opt seccomp=unconfined
>  
>      steps:
>      - name: Show OS
> -- 
> 2.27.0
