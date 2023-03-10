Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D11316B5186
	for <lists+linux-integrity@lfdr.de>; Fri, 10 Mar 2023 21:14:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230427AbjCJUOO (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 10 Mar 2023 15:14:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231300AbjCJUOM (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 10 Mar 2023 15:14:12 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1274C12D404;
        Fri, 10 Mar 2023 12:14:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678479252; x=1710015252;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=x15Y/xNp6x5PWl7ixmxyrgkMNZmZuvLaLDNTFcnQCoc=;
  b=ibINhq3Xkm7t9chKezxnZBIrj6G6epWo2T8GVDnT6/5YPUx+LHjJpBuo
   3v4dVv5NvcV5fcEsOMvw2e5eOdb0tCu/PBfGwwtdlgCyepHoRYSjbChOL
   sqJC2JzK3KcHRSgBD+9+lNI7I0LDjlNLRXFetjJsmiK3aSS6dgk3Q/lzv
   VFUpoPIczefts1Hq0AZApo9PLm8/5Vlx/bo6FQKu2v9hwARd7LhzfpHQS
   83SozUgLfgF6Mk9wWbEtny/OCdIQ9sdw5XZyq7DuKdXbmOmQX5ephCpGG
   RBPi/F+JuBRatRo6tFjg6m59J6GoSpqk5CuU+CfbWUAH9knXnbtl/ArIQ
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10645"; a="320674514"
X-IronPort-AV: E=Sophos;i="5.98,250,1673942400"; 
   d="scan'208";a="320674514"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2023 12:14:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10645"; a="710402788"
X-IronPort-AV: E=Sophos;i="5.98,250,1673942400"; 
   d="scan'208";a="710402788"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga001.jf.intel.com with ESMTP; 10 Mar 2023 12:14:07 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1paj7s-0018GF-2h;
        Fri, 10 Mar 2023 22:14:04 +0200
Date:   Fri, 10 Mar 2023 22:14:04 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
Cc:     Mirsad Goran Todorovac <mirsad.goran.todorovac@alu.hr>,
        linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
        Paul Moore <paul@paul-moore.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Christian =?iso-8859-1?Q?G=F6ttsche?= <cgzones@googlemail.com>,
        =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
        Frederick Lawler <fred@cloudflare.com>
Subject: Re: [PATCH v1 1/2] Add release hook to LSM
Message-ID: <ZAuPjCT/GGy860hW@smile.fi.intel.com>
References: <20230310194159.GB528@domac.alu.hr>
 <ZAuJY1MM3hEiT0ri@smile.fi.intel.com>
 <147c1a43-b5a1-a802-3d14-5f2de8306cc3@alu.unizg.hr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <147c1a43-b5a1-a802-3d14-5f2de8306cc3@alu.unizg.hr>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, Mar 10, 2023 at 09:02:18PM +0100, Mirsad Goran Todorovac wrote:
> On 10. 03. 2023. 20:47, Andy Shevchenko wrote:
> > On Fri, Mar 10, 2023 at 08:42:00PM +0100, Mirsad Goran Todorovac wrote:
> >>
> >> Add release() hook to the definition of the LSM modules, to enable calling
> >> destructors and deallocating allocated resources cleanly.
> >>
> >> Signed-off-by: Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
> > 
> >> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > 
> > I haven't given you this tag. Sorry, you must not add something
> > which was not explicitly given.

> This change could have long lasting consequences if approved, and I am not
> continuing the patch submission without your mentoring and approval.
> 
> It is true that I assumed that you have reviewed the patch, but you did not
> explicitly give the Reviewed-by tag.
> 
> But I am rather new to this patch submission process, and please would you
> please mentor me to do this the right way.

We have a nice documentation for that [1]. Please, read it in full.
If some questions left, do not hesitate to ask.

[1]: https://www.kernel.org/doc/html/latest/process/submitting-patches.html

-- 
With Best Regards,
Andy Shevchenko


