Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39F3D27DE57
	for <lists+linux-integrity@lfdr.de>; Wed, 30 Sep 2020 04:11:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729487AbgI3CLr (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 29 Sep 2020 22:11:47 -0400
Received: from mga01.intel.com ([192.55.52.88]:51417 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729322AbgI3CLr (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 29 Sep 2020 22:11:47 -0400
IronPort-SDR: w1OVesv/eXdEXJHjdXFJ9pQYL2z8aJ8qAkyMhQgph/qUmsiqPctM9BQ1s3wbZztGT7ZgKZzcdF
 ULWv8wDRzCMw==
X-IronPort-AV: E=McAfee;i="6000,8403,9759"; a="180495761"
X-IronPort-AV: E=Sophos;i="5.77,320,1596524400"; 
   d="scan'208";a="180495761"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2020 19:11:45 -0700
IronPort-SDR: lXWEtbqgfLn++IAOw7rqKqNDOLMV2cITz65FfGHDEIhswPTzmXxn3VFwRj2DztLdMRrzs8cWL8
 2KkUIiPtIhnQ==
X-IronPort-AV: E=Sophos;i="5.77,320,1596524400"; 
   d="scan'208";a="494821852"
Received: from xinpan-mobl.ger.corp.intel.com (HELO localhost) ([10.249.35.239])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2020 19:11:38 -0700
Date:   Wed, 30 Sep 2020 05:11:36 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Hao Wu <hao.wu@rubrik.com>
Cc:     James Bottomley <James.Bottomley@HansenPartnership.com>,
        Nayna Jain <nayna@linux.vnet.ibm.com>, peterhuewe@gmx.de,
        jgg@ziepe.ca, arnd@arndb.de, gregkh@linuxfoundation.org,
        Hamza Attak <hamza@hpe.com>, why2jjj.linux@gmail.com,
        zohar@linux.vnet.ibm.com, linux-integrity@vger.kernel.org,
        Paul Menzel <pmenzel@molgen.mpg.de>,
        Ken Goldman <kgold@linux.ibm.com>,
        Seungyeop Han <seungyeop.han@rubrik.com>,
        Shrihari Kalkar <shrihari.kalkar@rubrik.com>,
        Anish Jhaveri <anish.jhaveri@rubrik.com>
Subject: Re: [PATCH] Fix Atmel TPM crash caused by too frequent queries
Message-ID: <20200930021136.GD808399@linux.intel.com>
References: <20200926223150.109645-1-hao.wu@rubrik.com>
 <73405d14d7665e8a4e3e9defde7fb12aeae7784c.camel@HansenPartnership.com>
 <DFD7629C-05BF-46C1-B3D7-92FBBC176D9E@rubrik.com>
 <cf5c8035b7183522fb8a5df4baa95bd24288e61f.camel@HansenPartnership.com>
 <20200928010835.GD6704@linux.intel.com>
 <1F6A3D58-6B60-4FCB-A629-34CE8813E04C@rubrik.com>
 <20200928141613.GB70098@linux.intel.com>
 <E0629B0C-E49F-4FA1-8DBA-E8CB1EDEFD1A@rubrik.com>
 <20200928194745.GB125819@linux.intel.com>
 <18048BE4-2700-4BF9-8959-D024ECF0B704@rubrik.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <18048BE4-2700-4BF9-8959-D024ECF0B704@rubrik.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, Sep 28, 2020 at 01:27:14PM -0700, Hao Wu wrote:
> 
> 
> > On Sep 28, 2020, at 12:47 PM, Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com> wrote:
> > 
> > On Mon, Sep 28, 2020 at 10:49:56AM -0700, Hao Wu wrote:
> >> Hi Jarkko,
> >> 
> >> https://github.com/torvalds/linux/commit/9f3fc7bcddcb51234e23494531f93ab60475e1c3 
> >> Is the one introducing the issue since 4.14. Then the other three commits
> >> changed the relevant code a bit. Probably you can check the timestamp / release version
> >> on each commit to understand the relationship.
> >> 
> >> I think the original patch commit message can help you understand the root cause.
> >> Attaching the commit here for your convenience.
> >> 
> >> Thanks
> >> Hao
> > 
> > Please, again, when you respond quote properly instead of putting your
> > response on top. Thank you.
> > 
> > Yes, I know the issue and it is already documented also in the James'
> > earlier patch that did a similar change. I.e. for some reason some TPM's
> > (or the bus itself) do not like poking it too often.
> Yes, probably. Although the issue James’s patch fixes has the same error code,
> it is about a different issue which is similar.

OK, great.

> > So: what if you revert on using msleep(TPM_TIMEOUT) in
> > wait_for_tpm_stat(), i.e. revert to the behaviour before the
> > aformentioned commit?
> I believe that should resolve the issue as well

I'd return to the old code that works instead of doing something new
along the lines. James?

Anyway, thanks a lot for coming with this. I think we are making at
least some progress sorting this out.

Also want to underline that my comments about quoting emails did not
have anything to do that I would not appreciate this feedback. It is
just a "protocol thing".

> Thanks
> Hao

/Jarkko
