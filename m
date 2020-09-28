Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9803727B5A3
	for <lists+linux-integrity@lfdr.de>; Mon, 28 Sep 2020 21:47:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726578AbgI1Trx (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 28 Sep 2020 15:47:53 -0400
Received: from mga06.intel.com ([134.134.136.31]:57367 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726562AbgI1Trx (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 28 Sep 2020 15:47:53 -0400
IronPort-SDR: LP2VVXvU5lX7ZNRcxwJmyheLqFLb0/n79/MnwWVhx88l9LmL4vUTddtLcQwFeEvrwUwwjJqjuE
 Nt2xfuEoKu3w==
X-IronPort-AV: E=McAfee;i="6000,8403,9758"; a="223645160"
X-IronPort-AV: E=Sophos;i="5.77,315,1596524400"; 
   d="scan'208";a="223645160"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2020 12:47:52 -0700
IronPort-SDR: wStESfx4XC3qWvgY/U1J7QA8kcQ5W8tRv6dSN4FuKqrLPxPySXHevy6w9Wyua0pVo68a6hox/C
 wMxbJ0OC+gKA==
X-IronPort-AV: E=Sophos;i="5.77,315,1596524400"; 
   d="scan'208";a="456967047"
Received: from evinhugx-mobl1.ger.corp.intel.com (HELO localhost) ([10.252.44.118])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2020 12:47:48 -0700
Date:   Mon, 28 Sep 2020 22:47:45 +0300
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
Message-ID: <20200928194745.GB125819@linux.intel.com>
References: <20200926223150.109645-1-hao.wu@rubrik.com>
 <73405d14d7665e8a4e3e9defde7fb12aeae7784c.camel@HansenPartnership.com>
 <DFD7629C-05BF-46C1-B3D7-92FBBC176D9E@rubrik.com>
 <cf5c8035b7183522fb8a5df4baa95bd24288e61f.camel@HansenPartnership.com>
 <20200928010835.GD6704@linux.intel.com>
 <1F6A3D58-6B60-4FCB-A629-34CE8813E04C@rubrik.com>
 <20200928141613.GB70098@linux.intel.com>
 <E0629B0C-E49F-4FA1-8DBA-E8CB1EDEFD1A@rubrik.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E0629B0C-E49F-4FA1-8DBA-E8CB1EDEFD1A@rubrik.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, Sep 28, 2020 at 10:49:56AM -0700, Hao Wu wrote:
> Hi Jarkko,
> 
> https://github.com/torvalds/linux/commit/9f3fc7bcddcb51234e23494531f93ab60475e1c3 
> Is the one introducing the issue since 4.14. Then the other three commits
> changed the relevant code a bit. Probably you can check the timestamp / release version
> on each commit to understand the relationship.
> 
> I think the original patch commit message can help you understand the root cause.
> Attaching the commit here for your convenience.
> 
> Thanks
> Hao

Please, again, when you respond quote properly instead of putting your
response on top. Thank you.

Yes, I know the issue and it is already documented also in the James'
earlier patch that did a similar change. I.e. for some reason some TPM's
(or the bus itself) do not like poking it too often.

So: what if you revert on using msleep(TPM_TIMEOUT) in
wait_for_tpm_stat(), i.e. revert to the behaviour before the
aformentioned commit?

/Jarkko
