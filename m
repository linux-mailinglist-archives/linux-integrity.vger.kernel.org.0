Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68DB233FA08
	for <lists+linux-integrity@lfdr.de>; Wed, 17 Mar 2021 21:38:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233357AbhCQUhb (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 17 Mar 2021 16:37:31 -0400
Received: from mx2.suse.de ([195.135.220.15]:44170 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233300AbhCQUha (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 17 Mar 2021 16:37:30 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id D7544AE89;
        Wed, 17 Mar 2021 20:37:28 +0000 (UTC)
Date:   Wed, 17 Mar 2021 21:37:27 +0100
From:   Petr Vorel <pvorel@suse.cz>
To:     Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Cc:     Mimi Zohar <zohar@linux.ibm.com>, tusharsu@linux.microsoft.com,
        ltp@lists.linux.it, linux-integrity@vger.kernel.org
Subject: Re: [PATCH v2] IMA: Allow only ima-buf template for key measurement
Message-ID: <YFJoh++5vxSuwJiz@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20210314233646.2925-1-nramas@linux.microsoft.com>
 <YFC7j4+wA8xorNgu@pevik>
 <deeb4320-a064-fd0f-bc1e-8e52be079ff9@linux.microsoft.com>
 <YFDpFL3CSwMfZ6wo@pevik>
 <5cbe66e7-aebf-e75a-cd9a-d0a69e8a1edd@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5cbe66e7-aebf-e75a-cd9a-d0a69e8a1edd@linux.microsoft.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Lakshmi,

> > > > Just a double check does it always work without template=ima-buf for all kernel versions?
> > > > Or only for kernels with dea87d0889dd ("ima: select ima-buf template for buffer measurement")
> > > > i.e. v5.11-rc1 or backport?
> > > The above change is required. Prior to this change, template has to be
> > > specified in the policy, otherwise the default template would be used.
> > The default template is ima-ng, right?
> Yes: ima-ng is the default template.

> > > From what you write I understand that "measure func=KEY_CHECK
> > keyrings=.ima|.evm" will work only on newer kernel, thus we should always use
> > template=ima-buf as the policy example so that it's working also on that few
> > kernels between <v5.6,v5.10> (which have IMA key functionality, but not
> > dea87d0889dd), right?
> Yes: In the kernels between v5.6 and v5.10, ima-buf template needs to be
> specified in the policy for KEY_CHECK.

OK, thus your original version - i.e. don't require template=ima-buf,
but keep it in policy example is the best approach.

> > But we should mention that in the README.md.

> Agreed - will update the README.md
Thanks!

Kind regards,
Petr

> thanks,
>  -lakshmi
