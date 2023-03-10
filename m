Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EEFC6B5120
	for <lists+linux-integrity@lfdr.de>; Fri, 10 Mar 2023 20:47:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230381AbjCJTr4 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 10 Mar 2023 14:47:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229916AbjCJTrz (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 10 Mar 2023 14:47:55 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85D7112084E;
        Fri, 10 Mar 2023 11:47:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678477673; x=1710013673;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=vFmOS6tH4fTn1rJ5ojoDPetfpQVdjsiIuUV/Va2DQkM=;
  b=MTFsr95HrLtcmrkonZOJtsKBCxvbwRxkNgGBpzJn05gr8d1blnRK8toi
   uiLGt/zxt2hy3JsGxIqCeYnnkZUAOc08yScCL/gJw+qGU3OUwavnrE0E+
   XSjJ/+Xci4lQdgrV2fksJ0bG68Bj1EM8lnoDw6w6mNAQDgS33srpCKNTI
   evGHlia/AvaQXcMBs4/IC8WzpExIrcJKpsAbikO8opDPIbZmlpgNFm28+
   EBcnWN02qc2IMxf4J1UIpxMBa+VEN0u9ByFTrjn9+dVLnnZnIW3iurtbH
   HwRKjwWzJ6ESBv2Seefyo1mLnRkkIdODV42J2rY+sd4QiW/32VrauG9nX
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10645"; a="336837182"
X-IronPort-AV: E=Sophos;i="5.98,250,1673942400"; 
   d="scan'208";a="336837182"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2023 11:47:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10645"; a="746840002"
X-IronPort-AV: E=Sophos;i="5.98,250,1673942400"; 
   d="scan'208";a="746840002"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga004.fm.intel.com with ESMTP; 10 Mar 2023 11:47:49 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1paiiR-0017Rf-2I;
        Fri, 10 Mar 2023 21:47:47 +0200
Date:   Fri, 10 Mar 2023 21:47:47 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Mirsad Goran Todorovac <mirsad.goran.todorovac@alu.hr>
Cc:     linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
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
Message-ID: <ZAuJY1MM3hEiT0ri@smile.fi.intel.com>
References: <20230310194159.GB528@domac.alu.hr>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230310194159.GB528@domac.alu.hr>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, Mar 10, 2023 at 08:42:00PM +0100, Mirsad Goran Todorovac wrote:
> 
> Add release() hook to the definition of the LSM modules, to enable calling
> destructors and deallocating allocated resources cleanly.
> 
> Signed-off-by: Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>

> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

I haven't given you this tag. Sorry, you must not add something
which was not explicitly given.

> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Mimi Zohar <zohar@linux.ibm.com>
> Cc: Paul Moore <paul@paul-moore.com>
> Cc: Thomas Weiﬂschuh <linux@weissschuh.net>
> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Use --cc parameter to `git send-email`.

-- 
With Best Regards,
Andy Shevchenko


