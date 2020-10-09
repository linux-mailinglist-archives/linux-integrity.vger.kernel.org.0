Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B4D9288DC0
	for <lists+linux-integrity@lfdr.de>; Fri,  9 Oct 2020 18:07:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389497AbgJIQHB (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 9 Oct 2020 12:07:01 -0400
Received: from mga04.intel.com ([192.55.52.120]:23760 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389278AbgJIQHB (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 9 Oct 2020 12:07:01 -0400
IronPort-SDR: yHhWgsgS4UXsrCKGQQZsd2CuMpM7rEcpcRJ9DyYbpEiwTDqzzXd/1SN2MoXd154m2JX/+ath39
 M9CpNm5d8rNg==
X-IronPort-AV: E=McAfee;i="6000,8403,9769"; a="162865986"
X-IronPort-AV: E=Sophos;i="5.77,355,1596524400"; 
   d="scan'208";a="162865986"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2020 09:07:01 -0700
IronPort-SDR: GQik6NGxQni81iP+KDGp5j5jzgwbibUgULP1+1SAFHWujWihi9dzmdDO867nPo3wpXZlA0oiS/
 m5gjBjjwC4ow==
X-IronPort-AV: E=Sophos;i="5.77,355,1596524400"; 
   d="scan'208";a="298471758"
Received: from rgordani-mobl.ger.corp.intel.com (HELO localhost) ([10.249.34.105])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2020 09:06:57 -0700
Date:   Fri, 9 Oct 2020 19:06:54 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc:     Mimi Zohar <zohar@linux.ibm.com>, tyhicks@linux.microsoft.com,
        linux-integrity@vger.kernel.org,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [Regression] "tpm: Require that all digests are present in
 TCG_PCR_EVENT2 structures" causes null pointer dereference
Message-ID: <20201009160654.GA26881@linux.intel.com>
References: <E1FDCCCB-CA51-4AEE-AC83-9CDE995EAE52@canonical.com>
 <20200928140623.GA69515@linux.intel.com>
 <BB63B86E-CA44-4EB7-A5D1-21B0E9EB2850@canonical.com>
 <846fe4da67d05f57fba33e38c9a6e394e657adc3.camel@linux.ibm.com>
 <20200930022040.GG808399@linux.intel.com>
 <A983BE2B-02A7-450B-9FD0-77B1470EF233@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <A983BE2B-02A7-450B-9FD0-77B1470EF233@canonical.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, Oct 08, 2020 at 05:09:06PM +0800, Kai-Heng Feng wrote:
> > I do not have yet any reasonable answer to this and my v5.10 PR is
> > running late. Does everyone agree that I should revert the patch?
> 
> Given that there are multiple users confirmed reverting the commit
> helps, can you please revert it and Cc: linux-stable?

I already sent the PR, but I schedule the revert to my rc2 PR.

> Thanks!
> 
> Kai-Heng

/Jarkko
