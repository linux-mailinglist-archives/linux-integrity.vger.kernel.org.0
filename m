Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AECB6B5180
	for <lists+linux-integrity@lfdr.de>; Fri, 10 Mar 2023 21:12:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230371AbjCJUMr (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 10 Mar 2023 15:12:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230102AbjCJUMr (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 10 Mar 2023 15:12:47 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFE9012B97F;
        Fri, 10 Mar 2023 12:12:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678479165; x=1710015165;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=qPlR+f+ExZCZjoKbaEkB6HYGa/oajr4vTTPBCO+MbBc=;
  b=ONXWhktgaUWr0YwNs8HhM0gaCmmZZmR2DBriWAKC/nDMP/ruMTBYhdVS
   cbxxwd6iQmnGNQkSPh3yhsv7edKMAdSJxKtdZ8hBdJd0Jn9gIihtQvUDp
   OSHaeo4MSnH0F6PxcI0pp0RJiHzAJQTiYyblZKO9EtRjd/EhxR/7i7d8K
   oHo0uRjKaznQh/0tpufmD2y4hmeb717crttWi+RJZY3JqnaMXErQN0e4W
   kbiyTohJKlooAfUIQ5UorEi60Kay4+4MaxtYVPFtqEE2XkAJheIXtWzZn
   8e9MF1YZoKrzcxoIDLdewm33AFfmf0Wo1VCv1pn5k3kdEceGKFij9+HZ/
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10645"; a="335518011"
X-IronPort-AV: E=Sophos;i="5.98,250,1673942400"; 
   d="scan'208";a="335518011"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2023 12:12:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10645"; a="627929915"
X-IronPort-AV: E=Sophos;i="5.98,250,1673942400"; 
   d="scan'208";a="627929915"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga003.jf.intel.com with ESMTP; 10 Mar 2023 12:12:41 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1paj6V-0018Cc-0i;
        Fri, 10 Mar 2023 22:12:39 +0200
Date:   Fri, 10 Mar 2023 22:12:38 +0200
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
Message-ID: <ZAuPNm3UdC/c1EXm@smile.fi.intel.com>
References: <20230310194159.GB528@domac.alu.hr>
 <ZAuJY1MM3hEiT0ri@smile.fi.intel.com>
 <47129238-d98e-0561-0921-adfe40b6b85f@alu.unizg.hr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <47129238-d98e-0561-0921-adfe40b6b85f@alu.unizg.hr>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, Mar 10, 2023 at 08:52:32PM +0100, Mirsad Goran Todorovac wrote:
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
> 
> Mea culpa.
> 
> I misunderstood that you have approved the change when saying that I should
> file a formal patch. It worked with Florian Westphal in my first patch, so I
> thought it would be inappropriate to leave out who endorsed the patch.

We have Suggested-by tag for that.

> Thousand apologies. This is my second patch, so I am asking for some extra
> grace ...

> What should I do now?

Wait at least a couple of days (even more, since it's weekend) for other
comments and then send a v2 of the series with the comments addressed.

Btw, you may take my "smart" script [1] for sending patch series. It
makes much less headache on how to do that properly.

[1]: https://github.com/andy-shev/home-bin-tools/blob/master/ge2maintainer.sh

-- 
With Best Regards,
Andy Shevchenko


