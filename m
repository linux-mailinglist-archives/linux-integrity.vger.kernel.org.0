Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 369A8221DFE
	for <lists+linux-integrity@lfdr.de>; Thu, 16 Jul 2020 10:15:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725897AbgGPIPl (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 16 Jul 2020 04:15:41 -0400
Received: from mx2.suse.de ([195.135.220.15]:34040 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725867AbgGPIPl (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 16 Jul 2020 04:15:41 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id B5634AED6;
        Thu, 16 Jul 2020 08:15:43 +0000 (UTC)
Date:   Thu, 16 Jul 2020 10:15:38 +0200
From:   Petr Vorel <pvorel@suse.cz>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     linux-integrity@vger.kernel.org,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Cyril Hrubis <chrubis@suse.cz>
Subject: Re: [PATCH ima-evm-utils v2] Check for tsspcrread in runtime
Message-ID: <20200716081538.GC18117@dell5510>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20200715132817.8529-1-pvorel@suse.cz>
 <20200715133741.GB32201@dell5510>
 <1594841666.12900.335.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1594841666.12900.335.camel@linux.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

> On Wed, 2020-07-15 at 15:37 +0200, Petr Vorel wrote:
> > Hi Mimi,

> > > instead of checking in build time as it's runtime dependency.
> > > Also log when tsspcrread not found to make debugging easier.

> > > We search for tsspcrread unless there is tss2-esys with Esys_PCR_Read(),
> > > thus pcr_none.c was dropped as unneeded.

> > > file_exist(), tst_get_path() and MIN() taken from LTP project.
> > BTW these parts holds Cyril's copyright. If you ever add copyright to
> > src/utils.[ch], please add it there.
> > Copyright (C) 2010 Cyril Hrubis <chrubis@suse.cz>

> Are you Ok with the following?
Yes, thanks!

Kind regards,
Petr

> diff --git a/src/utils.c b/src/utils.c
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

> Mimi

