Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5C544413A3
	for <lists+linux-integrity@lfdr.de>; Mon,  1 Nov 2021 07:13:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229865AbhKAGQF (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 1 Nov 2021 02:16:05 -0400
Received: from vmicros1.altlinux.org ([194.107.17.57]:55602 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbhKAGQE (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 1 Nov 2021 02:16:04 -0400
Received: from mua.local.altlinux.org (mua.local.altlinux.org [192.168.1.14])
        by vmicros1.altlinux.org (Postfix) with ESMTP id 9392A72C8B8;
        Mon,  1 Nov 2021 09:13:30 +0300 (MSK)
Received: by mua.local.altlinux.org (Postfix, from userid 508)
        id 855297CCC17; Mon,  1 Nov 2021 09:13:30 +0300 (MSK)
Date:   Mon, 1 Nov 2021 09:13:30 +0300
From:   "Dmitry V. Levin" <ldv@altlinux.org>
To:     Vitaly Chikunov <vt@altlinux.org>
Cc:     Mimi Zohar <zohar@linux.ibm.com>, linux-integrity@vger.kernel.org,
        Petr Vorel <petr.vorel@gmail.com>,
        Gleb Fotengauer-Malinovskiy <glebfm@altlinux.org>
Subject: Re: [PATCH ima-evm-utils 2/2] upgrade to glibc-2.34 uses clone3
 causing CI to fail
Message-ID: <20211101061330.GA15373@altlinux.org>
References: <20211026024929.535519-1-zohar@linux.ibm.com>
 <20211026024929.535519-2-zohar@linux.ibm.com>
 <20211026143054.7khp5jxcyn2fzira@altlinux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211026143054.7khp5jxcyn2fzira@altlinux.org>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi,

On Tue, Oct 26, 2021 at 05:30:54PM +0300, Vitaly Chikunov wrote:
> Mimi,
> 
> On Mon, Oct 25, 2021 at 10:49:29PM -0400, Mimi Zohar wrote:
> > Both opensuse/tumbleweed and Alt Linux have upgraded to glibc-2.34,
> > causing the CI testing to fail.  Disable seccomp (which is not needed
> > anyway, since GA uses throwable virtual environments anyway).
> 
> JFYI. We decided to update our glibc package to fall-back from clone3 to
> clone in case it's EPERM. So, after some time (perhaps a day) this
> workaround will not be needed for ALT Linux. But this will not hurts
> either and may be beneficial in the future.

Citing myself [3]:

"you must have missed the whole discussion on this subject [1][2],
the consensus was that problematic container runtimes need to be fixed
to make their seccomp filters return ENOSYS for unknown syscalls.

[1] https://sourceware.org/pipermail/libc-alpha/2020-November/119955.html
[2] https://lore.kernel.org/linux-api/87lfer2c0b.fsf@oldenburg2.str.redhat.com/T/#u
"
 
That discussion was about a different syscall, but the problem is
essentially the same, and all who commented on the subject more or less
vehemently rejected the idea of adding this kind of hacks into glibc.
Therefore, I think that change in ALT glibc has to be reconsidered,
and problematic container runtimes have to be fixed instead.
  
[3] https://sourceware.org/pipermail/libc-alpha/2021-February/123008.html


-- 
ldv
