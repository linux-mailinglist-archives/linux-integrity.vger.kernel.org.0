Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E11C2477BF
	for <lists+linux-integrity@lfdr.de>; Mon, 17 Aug 2020 21:56:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729630AbgHQT40 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 17 Aug 2020 15:56:26 -0400
Received: from mx2.suse.de ([195.135.220.15]:34792 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729118AbgHQT4Z (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 17 Aug 2020 15:56:25 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 204CAAAB0;
        Mon, 17 Aug 2020 19:56:50 +0000 (UTC)
Date:   Mon, 17 Aug 2020 21:56:23 +0200
From:   Petr Vorel <pvorel@suse.cz>
To:     Bruno Meneguele <bmeneg@redhat.com>
Cc:     linux-integrity@vger.kernel.org,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Vitaly Chikunov <vt@altlinux.org>
Subject: Re: [PATCH ima-evm-utils 9/9] travis: Switch to docker based builds
Message-ID: <20200817195623.GB112397@x230>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20200813182532.6931-1-pvorel@suse.cz>
 <20200813182532.6931-10-pvorel@suse.cz>
 <20200817080451.GA21486@dell5510>
 <20200817183806.GJ4781@glitch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200817183806.GJ4781@glitch>
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Bruno,

> On Mon, Aug 17, 2020 at 10:04:51AM +0200, Petr Vorel wrote:
> > Hi Mimi,

> > I'm sorry I left debugging code in travis/fedora.sh.

> > > --- /dev/null
> > > +++ b/travis/fedora.sh
> > > @@ -0,0 +1,49 @@
> > > +#!/bin/sh
> > > +# Copyright (c) 2020 Petr Vorel <pvorel@suse.cz>
> > > +set -e
> > > +
> > > +if [ -z "$CC" ]; then
> > > +	echo "missing \$CC!" >&2
> > > +	exit 1
> > > +fi
> > > +
> > > +case "$TSS" in
> > > +ibmtss) TSS="tss2-devel";;

> Unfortunately tss2 is only shipped for ppc64 today on CentOS. But there
> are plans to enable it to all other supported arches soon.

I'm sorry I haven't noticed that they're not installed on intel.
Hope they'll fix it soon.

Thanks for testing!

Kind regards,
Petr

> > > +tpm2-tss) TSS="tpm2-tss-devel";;
> > > +'') echo "Missing TSS!" >&2; exit 1;;
> > > +*) echo "Unsupported TSS: '$TSS'!" >&2; exit 1;;
> > > +esac
...
