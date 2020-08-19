Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05907249456
	for <lists+linux-integrity@lfdr.de>; Wed, 19 Aug 2020 07:14:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725939AbgHSFOX (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 19 Aug 2020 01:14:23 -0400
Received: from mx2.suse.de ([195.135.220.15]:57356 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725275AbgHSFOX (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 19 Aug 2020 01:14:23 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 0CC48AAB0;
        Wed, 19 Aug 2020 05:14:48 +0000 (UTC)
Date:   Wed, 19 Aug 2020 07:14:20 +0200
From:   Petr Vorel <pvorel@suse.cz>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     linux-integrity@vger.kernel.org,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Vitaly Chikunov <vt@altlinux.org>,
        "Bruno E . O . Meneguele" <bmeneg@redhat.com>
Subject: Re: [PATCH ima-evm-utils 0/9] Docker based Travis CI builds
Message-ID: <20200819051420.GA4455@dell5510>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20200813182532.6931-1-pvorel@suse.cz>
 <4f205c34d7b41325c3c46e485f07bc716c917d83.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4f205c34d7b41325c3c46e485f07bc716c917d83.camel@linux.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Mimi,

> Hi Petr,

> On Thu, 2020-08-13 at 20:25 +0200, Petr Vorel wrote:
> > Hi,

> > we talked about Docker based Travis CI builds.
> > Here they are [1]. Working on it revealed few bugs, that's why they're
> > included.

> > I've resent 2 commits ("man:" prefix).

> > I haven't addressed Mimi's suggestion to replace ibmswtpm2 with libtmps/swtpm [2].

> To summarize:
> - Add libtpms/swtpm support
> - Remove debugging from travis/fedora.sh 
> - CentOS tss & tss2-devel issues
> - Petr todo's comment:
>   * add pgrep and pkill to _require (fix of a different commit)
>   * add magic constant 114 to exit codes (in tests/functions.sh)
>   * I'd like reuse exit codes in build.sh. I could source tests/functions.sh (they
>     look to be general enough, just I didn't like script in root directory depending
>     on it, as it's general enough for build without testing) have these constants in
>     separate file.

> swtpm: patch was posted, reviewed, and fixed.
Great.

> CentOS: Our internal Travis on ppc64 is installing both tpm2-tss-2.0.0-
> 4.el8.x86_64.rpm and tpm2-tss-devel-2.0.0-4.el8.x86_64.rpm on CentOS. 
> In general, the "boot_aggregate.test" is only run if both a software
> TPM and the tsseventextend exist.  If either one of them are missing,
> the test is skipped.  For CentOS on x86, the "boot_aggregate" would be
> skipped.
Great. BTW it'd be nice to have native non-intel builds instead of
cross-compilation. But, they're constantly broken on Travis CI, that's why I
didn't implement it (I've been testing ppc64le and s390x for several months).

> Left is Petr's "todo's" comment.  Petr, would these be additional
> patches on top of the existing ones or were you planning on re-posting
> them?   If these are additional patches, I can remove the debugging
> from travis/fedora.sh in patch 9/9.  Please let me know how you want to
> go forward.
Please, remove the debugging from travis/fedora.sh, I'll send additional patch.

Kind regards,
Petr
