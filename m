Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 554BB28D04C
	for <lists+linux-integrity@lfdr.de>; Tue, 13 Oct 2020 16:33:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726572AbgJMOdy (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 13 Oct 2020 10:33:54 -0400
Received: from mga14.intel.com ([192.55.52.115]:47862 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726395AbgJMOdy (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 13 Oct 2020 10:33:54 -0400
IronPort-SDR: Yh5heJ0LOnmhCnpNLBM2bUAqpG+46vi8+P0CaWAbiLzOvrRW236gvIZkXYlBZX3dEnEIJAwa/b
 PgwD4AkDqvNg==
X-IronPort-AV: E=McAfee;i="6000,8403,9772"; a="165128943"
X-IronPort-AV: E=Sophos;i="5.77,371,1596524400"; 
   d="scan'208";a="165128943"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2020 07:33:53 -0700
IronPort-SDR: AecpkliYlnk5aZtfNvkzJwD3rSbLOVqDQIaJfpBiyS1vS57tj1A+NOCg4IyQ/dQA5e2vezzTTk
 t1I9es4yj/YA==
X-IronPort-AV: E=Sophos;i="5.77,371,1596524400"; 
   d="scan'208";a="530413595"
Received: from cgheban-mobl.ger.corp.intel.com (HELO localhost) ([10.249.35.29])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2020 07:33:50 -0700
Date:   Tue, 13 Oct 2020 17:33:48 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Tyler Hicks <tyhicks@linux.microsoft.com>
Cc:     Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        linux-integrity@vger.kernel.org,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [Regression] "tpm: Require that all digests are present in
 TCG_PCR_EVENT2 structures" causes null pointer dereference
Message-ID: <20201013143348.GA153769@linux.intel.com>
References: <E1FDCCCB-CA51-4AEE-AC83-9CDE995EAE52@canonical.com>
 <20200928140623.GA69515@linux.intel.com>
 <BB63B86E-CA44-4EB7-A5D1-21B0E9EB2850@canonical.com>
 <846fe4da67d05f57fba33e38c9a6e394e657adc3.camel@linux.ibm.com>
 <20200930022040.GG808399@linux.intel.com>
 <A983BE2B-02A7-450B-9FD0-77B1470EF233@canonical.com>
 <20201009160654.GA26881@linux.intel.com>
 <20201013143139.GA12418@sequoia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201013143139.GA12418@sequoia>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, Oct 13, 2020 at 09:31:39AM -0500, Tyler Hicks wrote:
> Sorry for coming in so late, I've been on an extended vacation with
> little connectivity.
> 
> On 2020-10-09 19:06:54, Jarkko Sakkinen wrote:
> > On Thu, Oct 08, 2020 at 05:09:06PM +0800, Kai-Heng Feng wrote:
> > > > I do not have yet any reasonable answer to this and my v5.10 PR is
> > > > running late. Does everyone agree that I should revert the patch?
> > > 
> > > Given that there are multiple users confirmed reverting the commit
> > > helps, can you please revert it and Cc: linux-stable?
> > 
> > I already sent the PR, but I schedule the revert to my rc2 PR.
> 
> I'll try to better understand what's going on. I, too, am confused about
> how the change would introduce the reported regression. I've only
> skimmed the thread so far but it feels like there's possibly a latent
> issue that the change may be uncovering on certain systems.
> 
> FWIW, we've had this patch applied to our internal kernel for a month
> and haven't seen any issues.
> 
> Tyler

Tyler, it will be a while before even rc1 is out, i.e. there's window
for investigation.

/Jarkko
