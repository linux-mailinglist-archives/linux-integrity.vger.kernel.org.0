Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFB5E22BE2B
	for <lists+linux-integrity@lfdr.de>; Fri, 24 Jul 2020 08:43:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726554AbgGXGnm (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 24 Jul 2020 02:43:42 -0400
Received: from mx2.suse.de ([195.135.220.15]:48664 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725942AbgGXGnl (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 24 Jul 2020 02:43:41 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 95338AC20;
        Fri, 24 Jul 2020 06:43:48 +0000 (UTC)
Date:   Fri, 24 Jul 2020 08:43:38 +0200
From:   Petr Vorel <pvorel@suse.cz>
To:     Lachlan Sneff <t-josne@linux.microsoft.com>
Cc:     zohar@linux.ibm.com, ltp@lists.linux.it,
        nramas@linux.microsoft.com, balajib@linux.microsoft.com,
        linux-integrity@vger.kernel.org
Subject: Re: [PATCH v3] IMA: Add test for kexec cmdline measurement
Message-ID: <20200724064338.GF32086@dell5510>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20200722184739.19460-1-t-josne@linux.microsoft.com>
 <20200723114600.GB31591@dell5510>
 <0a970e3c-a10f-f032-eb26-d738bc220458@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0a970e3c-a10f-f032-eb26-d738bc220458@linux.microsoft.com>
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

> Hi Petr,
> Thank you for reviewing
Thanks for your time as well :).

> On 7/23/20 7:46 AM, Petr Vorel wrote:
> > Hi,

> > ...
> > > +++ b/testcases/kernel/security/integrity/ima/tests/ima_kexec.sh
> > > @@ -0,0 +1,121 @@
> > > +#!/bin/sh
> > > +# SPDX-License-Identifier: GPL-2.0-or-later
> > > +# Copyright (c) 2020 Microsoft Corporation
> > > +# Author: Lachlan Sneff <t-josne@linux.microsoft.com>
> > > +#
> > > +# Verify that kexec cmdline is measured correctly.
> > > +
> > > +TST_NEEDS_CMDS="kexec sed xargs printf grep tr"
> > > +TST_CNT=1
> > > +TST_NEEDS_DEVICE=1
> > > +
> > > +. ima_setup.sh
> > > +
> > > +# Since the test is executed inside some sort of
> > > +# separate shell, *most* environment variables are
> > > +# not accessible, so there's no way to set it from
> > > +# the outside.
> > Do you mean that using this will not work?
> > IMA_KEXEC_IMAGE="${IMA_KEXEC_IMAGE:-/boot/vmlinuz-$(uname -r)}"
> > I don't understand that as I'm able to set variables even I run some tests in
> > dracut.
> I tried doing this in the past, and couldn't get it to work, but I just
> tried it again
> and was able to get it working. Essentially, what I tried before was
> `SOME_VAR="..." sudo runltp ...`, which doesn't work, but `sudo
> SOME_VAR="..." runltp` does pass the variable
> to the test. So, that should be added to this patch.
OK, so no any dracut / initramfs involved :).
Passing variables really works as expected, you need to export it first:
$ sudo su
# export IMA_KEXEC_IMAGE=/tmp/foo
# PATH="/opt/ltp/testcases/bin:$PATH" runltp ...

or just run the script directly:
$ sudo su
# IMA_KEXEC_IMAGE=/tmp/foo PATH="/opt/ltp/testcases/bin:$PATH" ima_kexec.sh

> > Also writing same docs doc on 2 places is not good. High level info should go to
> > README.md, implementation details to shell script.
> This is a good point. I'll reorganize the documentation of this patch.
> > Please hold on with posting new version. I have several fixes, thus I'd like to
> > send it after we sort this (trying to save you time).
> Okay :)
> > Kind regards,
> > Petr
> Thanks,
> Lachlan

Kind regards,
Petr
