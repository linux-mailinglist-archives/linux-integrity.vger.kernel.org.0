Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD4911E57F4
	for <lists+linux-integrity@lfdr.de>; Thu, 28 May 2020 08:55:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725779AbgE1GzB (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 28 May 2020 02:55:01 -0400
Received: from mga11.intel.com ([192.55.52.93]:59336 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725601AbgE1GzA (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 28 May 2020 02:55:00 -0400
IronPort-SDR: HLxfSJuOI/fs1n3Ti6pJqdQpFdpz3NnQ7sMHUvvhZt8UmTKurUOvP1E01AkMibFZ6XVxEXfAFo
 xHFySqEFSC2A==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2020 23:55:00 -0700
IronPort-SDR: sHU66gPhdE5R1kkcsnKvnfNAfUHDpVx/+CnoJ4Q4SrA1jIiwqDcQS4AB+ORo+WdqFSGSMDBbzP
 Gr0SxifOer5Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,443,1583222400"; 
   d="scan'208";a="267117340"
Received: from dmescala-mobl1.amr.corp.intel.com (HELO localhost) ([10.252.59.102])
  by orsmga003.jf.intel.com with ESMTP; 27 May 2020 23:54:55 -0700
Date:   Thu, 28 May 2020 09:54:53 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Alex Guzman <alex@guzman.io>
Cc:     Mario.Limonciello@dell.com, James.Bottomley@HansenPartnership.com,
        peterhuewe@gmx.de, jgg@ziepe.ca, arnd@arndb.de,
        gregkh@linuxfoundation.org, linux-integrity@vger.kernel.org,
        jeffrin@rajagiritech.edu.in
Subject: Re: [PATCH] tpm: Revert "tpm: fix invalid locking in NONBLOCKING
 mode"
Message-ID: <20200528065453.GD188849@linux.intel.com>
References: <20200526183213.20720-1-mario.limonciello@dell.com>
 <1590520454.11810.40.camel@HansenPartnership.com>
 <ccf055cbf1a14f28bc95a6b02e29a2f6@AUSX13MPC105.AMER.DELL.COM>
 <d6b4591c49f01f24b0dbfd25c8792a3f506d6cae.camel@linux.intel.com>
 <a5e2a176faa272a0edc8737c1ef1bf5b3c278f63.camel@guzman.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a5e2a176faa272a0edc8737c1ef1bf5b3c278f63.camel@guzman.io>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, May 27, 2020 at 06:10:02PM -0700, Alex Guzman wrote:
> On Wed, 2020-05-27 at 23:15 +0300, Jarkko Sakkinen wrote:
> > On Tue, 2020-05-26 at 19:23 +0000, Mario.Limonciello@dell.com wrote:
> > > Thanks, I don't pretend to understand the nuances of this
> > > particular code,
> > > but I was hoping that the request to revert got some attention
> > > since Alex's
> > > kernel Bugzilla and message a few months ago to linux integrity
> > > weren't.
> > 
> > Removing linux-kernel from CC since this subsystem internal
> > discussion.
> > 
> > Seeing the whole thing first time today.
> > 
> > Bugzilla is the first thing to ignore when busy. It is good as place
> > holder for bugs, but all discussions should happen only in LKML.
> > There's
> > no official requirement to proactively use Bugzilla for anything.
> > 
> > That said I'm happy that people put stuff there so that it gets
> > logged.
> > 
> > For follow-up's use only LKML if it is important to you. Those will
> > get
> > processed.
> > 
> > As far as this goes, if nothing is heard from me, check that you put
> > me
> > as CC to the original email. Otherwise, I might have missed it (by
> > mistake,
> > not by purpose).
> > 
> > Honestly, I'm not sure what point was this patch when there was time
> > to
> > wait for months without response. Why the passivity for all this
> > time?
> > 
> > /Jarkko
> > 
> 
> It largely went quiet because I didn't raise the issue in the mailing
> list again. I pinged back in February (
> https://lore.kernel.org/linux-integrity/CAJ7-PMbujee92N1f9xVF8vtXgS49qpe7qHkeWh1Z0R-Rk-Jkaw@mail.gmail.com/
> ) but the conversation died out and I was content to simply use the
> last working kernel version and see if the bug was resolved on its own.
> I raised the issue again on the bugtracker a few days ago, leading to
> this follow up here. :)

OK  cool and thanks a lot for reporting this!

/Jarkko
