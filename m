Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E46D933DAD2
	for <lists+linux-integrity@lfdr.de>; Tue, 16 Mar 2021 18:22:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238844AbhCPRVh (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 16 Mar 2021 13:21:37 -0400
Received: from mx2.suse.de ([195.135.220.15]:54608 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239228AbhCPRV1 (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 16 Mar 2021 13:21:27 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id B47D3AE78;
        Tue, 16 Mar 2021 17:21:25 +0000 (UTC)
Date:   Tue, 16 Mar 2021 18:21:24 +0100
From:   Petr Vorel <pvorel@suse.cz>
To:     Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Cc:     Mimi Zohar <zohar@linux.ibm.com>, tusharsu@linux.microsoft.com,
        ltp@lists.linux.it, linux-integrity@vger.kernel.org
Subject: Re: [PATCH v2] IMA: Allow only ima-buf template for key measurement
Message-ID: <YFDpFL3CSwMfZ6wo@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20210314233646.2925-1-nramas@linux.microsoft.com>
 <YFC7j4+wA8xorNgu@pevik>
 <deeb4320-a064-fd0f-bc1e-8e52be079ff9@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <deeb4320-a064-fd0f-bc1e-8e52be079ff9@linux.microsoft.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Lakshmi,

> > Just a double check does it always work without template=ima-buf for all kernel versions?
> > Or only for kernels with dea87d0889dd ("ima: select ima-buf template for buffer measurement")
> > i.e. v5.11-rc1 or backport?
> The above change is required. Prior to this change, template has to be
> specified in the policy, otherwise the default template would be used.
The default template is ima-ng, right?
From what you write I understand that "measure func=KEY_CHECK
keyrings=.ima|.evm" will work only on newer kernel, thus we should always use
template=ima-buf as the policy example so that it's working also on that few
kernels between <v5.6,v5.10> (which have IMA key functionality, but not
dea87d0889dd), right?

But we should mention that in the README.md.

Kind regards,
Petr

> > Also, don't we want to change also keycheck.policy?
> > Currently it contains:
> > measure func=KEY_CHECK keyrings=.ima|.evm|.builtin_trusted_keys|.blacklist|key_import_test template=ima-buf
> > Do we want to drop template=ima-buf to test the default value? Or have two rules
> > (one with template=ima-buf, other w/a?)
> Good point.

> I will send you the v3 patch - with two rules: one with template=buf and
> other without a template, like the following example:

> measure func=KEY_CHECK
> keyrings=.builtin_trusted_keys|.blacklist|key_import_test template=ima-buf

> measure func=KEY_CHECK keyrings=.ima|.evm

>  -lakshmi
