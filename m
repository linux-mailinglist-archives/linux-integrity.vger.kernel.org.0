Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 188911FBFC1
	for <lists+linux-integrity@lfdr.de>; Tue, 16 Jun 2020 22:13:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730725AbgFPUNu (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 16 Jun 2020 16:13:50 -0400
Received: from mga06.intel.com ([134.134.136.31]:29213 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729167AbgFPUNu (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 16 Jun 2020 16:13:50 -0400
IronPort-SDR: kDdGVkMiEIhHcmMBYGg3CSKsKngtMdvcrsD9eGuoauIfZ2ASQcaPlj7o7OZOAQgS82hcr767AD
 7S7c5A2iKaTA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2020 13:13:49 -0700
IronPort-SDR: 3nJAAzy3YxiPJ0sP468sPM5Fu667Cvns/MXDS30yNAjYE82K/nNE7cMc219k9R1vmyhejpwwLH
 YfwJFcii7rpg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,519,1583222400"; 
   d="scan'208";a="299034811"
Received: from gosinald-mobl2.ger.corp.intel.com (HELO localhost) ([10.249.36.106])
  by fmsmga004.fm.intel.com with ESMTP; 16 Jun 2020 13:13:44 -0700
Date:   Tue, 16 Jun 2020 23:13:43 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Maxim Uvarov <maxim.uvarov@linaro.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "tee-dev @ lists . linaro . org" <tee-dev@lists.linaro.org>,
        peterhuewe@gmx.de, Jason Gunthorpe <jgg@ziepe.ca>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        linux-integrity@vger.kernel.org, Arnd Bergmann <arnd@linaro.org>,
        Sumit Garg <sumit.garg@linaro.org>
Subject: Re: [PATCHv6 1/3] optee: use uuid for sysfs driver entry
Message-ID: <20200616201343.GE10412@linux.intel.com>
References: <20200601150645.13412-1-maxim.uvarov@linaro.org>
 <20200601150645.13412-2-maxim.uvarov@linaro.org>
 <20200604083655.GA4026@linux.intel.com>
 <CAD8XO3b4K6ozHwKf2NDJ482JQY6CPXKKxRuZgo5snP16i_5E=Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAD8XO3b4K6ozHwKf2NDJ482JQY6CPXKKxRuZgo5snP16i_5E=Q@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, Jun 04, 2020 at 12:16:21PM +0300, Maxim Uvarov wrote:
> On Thu, 4 Jun 2020 at 11:37, Jarkko Sakkinen
> <jarkko.sakkinen@linux.intel.com> wrote:
> >
> > On Mon, Jun 01, 2020 at 06:06:43PM +0300, Maxim Uvarov wrote:
> > > With the evolving use-cases for TEE bus, now it's required to support
> > > multi-stage enumeration process. But using a simple index doesn't
> > > suffice this requirement and instead leads to duplicate sysfs entries.
> > > So instead switch to use more informative device UUID for sysfs entry
> > > like:
> > > /sys/bus/tee/devices/optee-ta-<uuid>
> > >
> > > Signed-off-by: Maxim Uvarov <maxim.uvarov@linaro.org>
> > > Reviewed-by: Sumit Garg <sumit.garg@linaro.org>
> >
> > Why do you mean by duplicate sysfs entries?
> >
> 
> Without this change it will try to register something like that:
> first stage w/o tee-supplicant:
> /sys/bus/tee/devices/optee-clnt0
> /sys/bus/tee/devices/optee-clnt1
> /sys/bus/tee/devices/optee-clnt3
> Then with tee-supplicant also index started with 0. I.e.
> /sys/bus/tee/devices/optee-clnt0
> /sys/bus/tee/devices/optee-clnt1
> ...
> 
> So we need to increase global index or use some other unique names.

Got it, thanks.

/Jarkko
