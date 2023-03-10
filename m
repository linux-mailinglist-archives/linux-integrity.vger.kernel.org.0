Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F13E6B511C
	for <lists+linux-integrity@lfdr.de>; Fri, 10 Mar 2023 20:46:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230041AbjCJTqk (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 10 Mar 2023 14:46:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229916AbjCJTqj (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 10 Mar 2023 14:46:39 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5AE411F615;
        Fri, 10 Mar 2023 11:46:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678477598; x=1710013598;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=hlB6oeRmvokxAjZVIqNgu8yeT0nBM2OVSJNrGjaIF4U=;
  b=GcoZv7ftX3WYqxQYzNoPjm9k5Fu02MAY/VlVkxBfqFPOSJpiLsMdKRhY
   Zcd3UBFjGckWn9uaAKwDikIfr4N4H2NbeOZgizllmFExS2PTJhcnjfnmJ
   9b+HYNtE5jLIvEf/zN/Oe1JBXk5eM4Vbm6pU89mdVpP3LEXgk6Hb9V17U
   TI/NqYeWaiFuGyz1xS3rrOxolb4H3AEiDNkQDOTnUt0LxT1C1rJ/9PaT8
   N64jspcgjk1MtohuNKxMMmSqojsV4w7IWC9tLBajDEf90jTSeNxKoFPtz
   TzecOBdGYOVskBACRRxmMiAA13osHYiHI44WriKI8Sxvx2E/MyTXOFbui
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10645"; a="325171004"
X-IronPort-AV: E=Sophos;i="5.98,250,1673942400"; 
   d="scan'208";a="325171004"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2023 11:46:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10645"; a="708130030"
X-IronPort-AV: E=Sophos;i="5.98,250,1673942400"; 
   d="scan'208";a="708130030"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga008.jf.intel.com with ESMTP; 10 Mar 2023 11:46:34 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1paihE-0017Ot-1w;
        Fri, 10 Mar 2023 21:46:32 +0200
Date:   Fri, 10 Mar 2023 21:46:32 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Mirsad Goran Todorovac <mirsad.goran.todorovac@alu.hr>
Cc:     linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Paul Moore <paul@paul-moore.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Christian =?iso-8859-1?Q?G=F6ttsche?= <cgzones@googlemail.com>,
        =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
        Frederick Lawler <fred@cloudflare.com>
Subject: Re: [PATCH v1 0/2] Add destructor hook to LSM modules
Message-ID: <ZAuJGFL4dRFNxuiJ@smile.fi.intel.com>
References: <20230310192614.GA528@domac.alu.hr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230310192614.GA528@domac.alu.hr>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, Mar 10, 2023 at 08:26:14PM +0100, Mirsad Goran Todorovac wrote:
> 
> LSM security/integrity/iint.c had the case of kmem_cache_create() w/o a proper
> kmem_cache_destroy() destructor.
> 
> Introducing the release() hook would enable LSMs to release allocated resources
> on exit, and in proper order, rather than dying all together with kernel shutdown
> in an undefined order.

Your patches are sent as separate emails. Have you forgotten to add --thread
to `git format-patch`?

-- 
With Best Regards,
Andy Shevchenko


