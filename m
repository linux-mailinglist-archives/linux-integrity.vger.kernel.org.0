Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DFE86B72B2
	for <lists+linux-integrity@lfdr.de>; Mon, 13 Mar 2023 10:35:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231162AbjCMJfP (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 13 Mar 2023 05:35:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230186AbjCMJet (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 13 Mar 2023 05:34:49 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58FB012BD8;
        Mon, 13 Mar 2023 02:33:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678699994; x=1710235994;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=F26rz5vL8ASK0vwBawwnPkZu1yacUTeFb5CHoZ+HiH0=;
  b=SlDJJ1A85O6yTggIhVRUVypHdLD27XC3VrHX1tNut9NpKkUbRn23JrOn
   09/reILQJMq1R5D0nrLx8dE1asq5jgICQ2pELXCCW/qlVZ43SNIGZWdDX
   fj0Ql4aaUe+xDoxI/dLcyWyjqZ3IHidTR2doE6wbBxy2oTNUpPnCmi5R3
   xM0NKNBqCyqvw280kGz/r/Y8KFZiObrh78xsHheuoGf7rPdqzKxshtBAv
   xdpMfiHZG39MSHnNNHrs5UgUXtJeOwGfTLM4cls7FGRkFm2Jhn1lJUY49
   MLlM+PpWYZi4gg/kYwli0t6cBL2rMOSn8/bNLBoqxby42MIWWRBTcu1Od
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10647"; a="325459694"
X-IronPort-AV: E=Sophos;i="5.98,256,1673942400"; 
   d="scan'208";a="325459694"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2023 02:33:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10647"; a="655914665"
X-IronPort-AV: E=Sophos;i="5.98,256,1673942400"; 
   d="scan'208";a="655914665"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga006.jf.intel.com with ESMTP; 13 Mar 2023 02:33:01 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pbeY6-002Xjv-27;
        Mon, 13 Mar 2023 11:32:58 +0200
Date:   Mon, 13 Mar 2023 11:32:58 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Paul Moore <paul@paul-moore.com>
Cc:     Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>,
        Mirsad Goran Todorovac <mirsad.goran.todorovac@alu.hr>,
        linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Christian =?iso-8859-1?Q?G=F6ttsche?= <cgzones@googlemail.com>,
        =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
        Frederick Lawler <fred@cloudflare.com>
Subject: Re: [PATCH v1 0/2] Add destructor hook to LSM modules
Message-ID: <ZA7tyrscjwavzY3a@smile.fi.intel.com>
References: <20230310192614.GA528@domac.alu.hr>
 <CAHC9VhSzppHevG_Td+hKU4KRSDgV_NYf2RSeKA06PR-rD+dJLw@mail.gmail.com>
 <c1c1cbcc-10b6-de3f-81e8-78e6b173d46f@alu.unizg.hr>
 <CAHC9VhRFQtqTZku==BkW0uz1oZgG63j15GoQD1iexW4aPoAPcA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHC9VhRFQtqTZku==BkW0uz1oZgG63j15GoQD1iexW4aPoAPcA@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Sat, Mar 11, 2023 at 09:59:17AM -0500, Paul Moore wrote:
> On Fri, Mar 10, 2023 at 5:53 PM Mirsad Goran Todorovac
> <mirsad.todorovac@alu.unizg.hr> wrote:

...

> With that out of the way, I wanted to make a quick comment on the
> patch itself.  Currently LSMs do not support unloading, or dynamic
> loading for that matter.  There are several reasons for this, but
> perhaps the most important is that in order to help meet the security
> goals for several of the LSMs they need to be present in the kernel
> from the very beginning and remain until the very end.  Adding a
> proper "release" method to a LSM is going to be far more complicated
> than what you've done with this patchset, involving a lot of
> discussion both for the LSM layer itself and all of the currently
> supported LSMs, and ultimately I don't believe it is something we will
> want to support.
> 
> I appreciate your desire to help, and I want to thank you for your
> patch and the effort behind it, but I don't believe the kobject memory
> leak you saw at kernel shutdown was a real issue (it was only "leaked"
> because the system was shutting down) and I'm not sure the current
> behavior is something we want to change in the near future.

Currently the security module so secure that even adds an unneeded noise to
the debugging output.

At very least it would be nice to add a stub and put a big comment
(on your taste) explaining why we do not do anything there.

Agree?

-- 
With Best Regards,
Andy Shevchenko


