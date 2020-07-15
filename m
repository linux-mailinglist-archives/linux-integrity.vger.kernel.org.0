Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B80362215AD
	for <lists+linux-integrity@lfdr.de>; Wed, 15 Jul 2020 22:02:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726870AbgGOUCo (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 15 Jul 2020 16:02:44 -0400
Received: from vmicros1.altlinux.org ([194.107.17.57]:59656 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726491AbgGOUCn (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 15 Jul 2020 16:02:43 -0400
X-Greylist: delayed 313 seconds by postgrey-1.27 at vger.kernel.org; Wed, 15 Jul 2020 16:02:42 EDT
Received: from imap.altlinux.org (imap.altlinux.org [194.107.17.38])
        by vmicros1.altlinux.org (Postfix) with ESMTP id AACAB72CCF0;
        Wed, 15 Jul 2020 22:57:28 +0300 (MSK)
Received: from altlinux.org (sole.flsd.net [185.75.180.6])
        by imap.altlinux.org (Postfix) with ESMTPSA id 971FB4A4AEE;
        Wed, 15 Jul 2020 22:57:28 +0300 (MSK)
Date:   Wed, 15 Jul 2020 22:57:28 +0300
From:   Vitaly Chikunov <vt@altlinux.org>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     Petr Vorel <pvorel@suse.cz>, linux-integrity@vger.kernel.org,
        Mimi Zohar <zohar@linux.vnet.ibm.com>
Subject: Re: [PATCH ima-evm-utils v2] Check for tsspcrread in runtime
Message-ID: <20200715195728.w3nysi73nkeuu3qv@altlinux.org>
Mail-Followup-To: Mimi Zohar <zohar@linux.ibm.com>,
        Petr Vorel <pvorel@suse.cz>, linux-integrity@vger.kernel.org,
        Mimi Zohar <zohar@linux.vnet.ibm.com>
References: <20200715132817.8529-1-pvorel@suse.cz>
 <20200715133741.GB32201@dell5510>
 <1594841666.12900.335.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <1594841666.12900.335.camel@linux.ibm.com>
User-Agent: NeoMutt/20171215-106-ac61c7
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Mimi,

On Wed, Jul 15, 2020 at 03:34:26PM -0400, Mimi Zohar wrote:
> On Wed, 2020-07-15 at 15:37 +0200, Petr Vorel wrote:
> > Hi Mimi,
> > 
> > > instead of checking in build time as it's runtime dependency.
> > > Also log when tsspcrread not found to make debugging easier.
> > 
> > > We search for tsspcrread unless there is tss2-esys with Esys_PCR_Read(),
> > > thus pcr_none.c was dropped as unneeded.
> > 
> > > file_exist(), tst_get_path() and MIN() taken from LTP project.
> > BTW these parts holds Cyril's copyright. If you ever add copyright to
> > src/utils.[ch], please add it there.
> > Copyright (C) 2010 Cyril Hrubis <chrubis@suse.cz>
> 
> Are you Ok with the following?
> 
> diff --git a/src/utils.c b/src/utils.c

I don't remember me authoring anything in src/utils.c

> index 416a88c6dbe4..a6ae08fa4d84 100644
> --- a/src/utils.c
> +++ b/src/utils.c
> @@ -1,3 +1,10 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * utils: set of common functions
> + *
> + * Copyright (C) 2020 Vitaly Chikunov <vt@altlinux.org>
> + * Copyright (C) 2010 Cyril Hrubis <chrubis@suse.cz>
> + */
>  #include <stdint.h>
>  #include <stdio.h>
>  #include <stdlib.h>
> 
> Mimi
