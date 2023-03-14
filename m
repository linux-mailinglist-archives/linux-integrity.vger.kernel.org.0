Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A670B6B9110
	for <lists+linux-integrity@lfdr.de>; Tue, 14 Mar 2023 12:07:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230316AbjCNLG6 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 14 Mar 2023 07:06:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230224AbjCNLG5 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 14 Mar 2023 07:06:57 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88AB247423;
        Tue, 14 Mar 2023 04:06:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678791979; x=1710327979;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=BITUYkoSga6F+EORhAd27x2Ck6fcH/5teE0HpeuSSiI=;
  b=gLISrTkWboXC8UTrCK6iYfT56q9Lbcip3AALGDlI/7L0XwJnrxdsORw8
   DCOzcgU3wE+fp6P8S5JfTHIYHukw0fGXnNifaA4Zer2h5oJ5AzmE3Vq/v
   PWB/td+HBN6DC6KXKEIc3KdNOXd4+2G4hczEpANpebTBsjBTON/M3UDX8
   Z7/QTU3x/NPJ1CSG0nSOCxc2J+UBxvmzlAaYX6vpSdn/1RlOsmZxWC7Vs
   49iZa7mal7gtYagrUSVGhgqPPlM5FBU9O58zFSARpFE2xM639pAvRge/T
   GcaqnSJCXSfI0rjO0EKhZ7FOw2cj1HDK5qU729LcjuSRT3c8TWn2qu1OJ
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10648"; a="339757432"
X-IronPort-AV: E=Sophos;i="5.98,259,1673942400"; 
   d="scan'208";a="339757432"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2023 04:05:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10648"; a="822332495"
X-IronPort-AV: E=Sophos;i="5.98,259,1673942400"; 
   d="scan'208";a="822332495"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga001.fm.intel.com with ESMTP; 14 Mar 2023 04:05:28 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pc2T7-003AuV-31;
        Tue, 14 Mar 2023 13:05:25 +0200
Date:   Tue, 14 Mar 2023 13:05:25 +0200
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
Message-ID: <ZBBU9diKqetWQztO@smile.fi.intel.com>
References: <20230310192614.GA528@domac.alu.hr>
 <CAHC9VhSzppHevG_Td+hKU4KRSDgV_NYf2RSeKA06PR-rD+dJLw@mail.gmail.com>
 <c1c1cbcc-10b6-de3f-81e8-78e6b173d46f@alu.unizg.hr>
 <CAHC9VhRFQtqTZku==BkW0uz1oZgG63j15GoQD1iexW4aPoAPcA@mail.gmail.com>
 <ZA7tyrscjwavzY3a@smile.fi.intel.com>
 <CAHC9VhTMoCAFhaa36Bq7_jiKGiaeMbYTuWv7tTQP1OHpY0EUsg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHC9VhTMoCAFhaa36Bq7_jiKGiaeMbYTuWv7tTQP1OHpY0EUsg@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, Mar 13, 2023 at 04:27:42PM -0400, Paul Moore wrote:
> On Mon, Mar 13, 2023 at 5:33 AM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> > On Sat, Mar 11, 2023 at 09:59:17AM -0500, Paul Moore wrote:
> > > On Fri, Mar 10, 2023 at 5:53 PM Mirsad Goran Todorovac
> > > <mirsad.todorovac@alu.unizg.hr> wrote:

...

> > > With that out of the way, I wanted to make a quick comment on the
> > > patch itself.  Currently LSMs do not support unloading, or dynamic
> > > loading for that matter.  There are several reasons for this, but
> > > perhaps the most important is that in order to help meet the security
> > > goals for several of the LSMs they need to be present in the kernel
> > > from the very beginning and remain until the very end.  Adding a
> > > proper "release" method to a LSM is going to be far more complicated
> > > than what you've done with this patchset, involving a lot of
> > > discussion both for the LSM layer itself and all of the currently
> > > supported LSMs, and ultimately I don't believe it is something we will
> > > want to support.
> > >
> > > I appreciate your desire to help, and I want to thank you for your
> > > patch and the effort behind it, but I don't believe the kobject memory
> > > leak you saw at kernel shutdown was a real issue (it was only "leaked"
> > > because the system was shutting down) and I'm not sure the current
> > > behavior is something we want to change in the near future.
> >
> > Currently the security module so secure that even adds an unneeded noise to
> > the debugging output.
> >
> > At very least it would be nice to add a stub and put a big comment
> > (on your taste) explaining why we do not do anything there.
> >
> > Agree?
> 
> No.

Are you sure? I'm proposing to add a stub which is no-op, but with a comment
inside explaining why. In such case we:

1) shut the kobject infra up;
2) keep the status quo in LSM;
3) put in the code a good explanation for others on what's going on.

> At least not without a lot of additional work beyond what was
> presented in this patchset.  What about all of the other kobject
> caches created by other LSMs, this is more than just the IMA
> iint_cache.  I'm also skeptical that this patchset was ever tested and
> verified as the newly added release() method was never actually called
> from anywhere that I could see.

I'm not talking about this patchset, but you are right that it wasn't
tested.

> I think we would need to see a proper, verified fix before I could say
> for certain.

And continuing to spread the noise in the logs just because LSM is stubborn?

> If you want to discuss potential designs, we can do that
> too, but please remember the constraints that were already mentioned
> about intentionally not allowing the LSMs to be unloaded (prior to
> system shutdown).
> 
> I don't know the answer to this, but I'm guessing the LSMs aren't the
> only kernel subsystems to "leak" memory on system shutdown; working on
> the assumption that this is the case, how are those "leaked"
> allocations handled?

Note, I'm full for the proper fix, but the current issue is logs flooding done
by LSM that needs to be addressed.

-- 
With Best Regards,
Andy Shevchenko


