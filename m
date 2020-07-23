Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5604922A4EF
	for <lists+linux-integrity@lfdr.de>; Thu, 23 Jul 2020 03:56:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729198AbgGWB4Z (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 22 Jul 2020 21:56:25 -0400
Received: from mga06.intel.com ([134.134.136.31]:36270 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387467AbgGWB4Z (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 22 Jul 2020 21:56:25 -0400
IronPort-SDR: FTd/rG7UyP7yBicbP9seWS8LOcyrM+8t6iOlrOrNy6PO00wfe5qIH6P3gG1AyHh4KcByeN2VWo
 STgvhwKjOW4w==
X-IronPort-AV: E=McAfee;i="6000,8403,9690"; a="211994944"
X-IronPort-AV: E=Sophos;i="5.75,383,1589266800"; 
   d="scan'208";a="211994944"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2020 18:56:24 -0700
IronPort-SDR: eft/LI+Y9JdA91Wr+oeDxOG2Znrbja3Lrbrd7/9hlno2qPW+RUbUgziqzulTUEVwYYkbcjm1xW
 I3GatGhmYf6w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,383,1589266800"; 
   d="scan'208";a="302148581"
Received: from schwings-mobl.ger.corp.intel.com (HELO localhost) ([10.252.33.132])
  by orsmga002.jf.intel.com with ESMTP; 22 Jul 2020 18:56:21 -0700
Date:   Thu, 23 Jul 2020 04:56:19 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Guenter Roeck <groeck@google.com>
Cc:     Andrey Pronin <apronin@chromium.org>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        linux-integrity@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Guenter Roeck <groeck@chromium.org>
Subject: Re: [PATCH] tpm: avoid accessing cleared ops during shutdown
Message-ID: <20200723015619.GF45081@linux.intel.com>
References: <20200710002209.6757-1-apronin@chromium.org>
 <20200710114000.GD2614@linux.intel.com>
 <CAP7wa8LfEtEATbENjr18jTXShT+YmrAoDt4k9FK1SLpxVqViog@mail.gmail.com>
 <20200714113205.GA1461506@linux.intel.com>
 <CABXOdTcAZjG8aQvs+M72CFe9rAdBKZH+6x=C1Ha2aX_w0gXiHw@mail.gmail.com>
 <20200716172811.GB14135@linux.intel.com>
 <CABXOdTd4oY8TpuE1qZP--dYTJ-czdovsjmhLVbd_tTw=sApHYw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABXOdTd4oY8TpuE1qZP--dYTJ-czdovsjmhLVbd_tTw=sApHYw@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, Jul 16, 2020 at 10:38:00AM -0700, Guenter Roeck wrote:
> On Thu, Jul 16, 2020 at 10:28 AM Jarkko Sakkinen
> <jarkko.sakkinen@linux.intel.com> wrote:
> >
> > On Tue, Jul 14, 2020 at 08:48:38AM -0700, Guenter Roeck wrote:
> > > On Tue, Jul 14, 2020 at 4:32 AM Jarkko Sakkinen
> > > <jarkko.sakkinen@linux.intel.com> wrote:
> > > >
> > > > On Fri, Jul 10, 2020 at 11:25:44AM -0700, Andrey Pronin wrote:
> > > > > > Why does not tpm_del_char_device need this?
> > > > >
> > > > > "Not" is a typo in the sentence above, right? tpm_del_char_device *does*
> > > > > need the fix. When tpm_class_shutdown is called it sets chip->ops to
> > > > > NULL. If tpm_del_char_device is called after that, it doesn't check if
> > > > > chip->ops is NULL (normal kernel API and char device API calls go
> > > > > through tpm_try_get_ops, but tpm_del_char_device doesn't) and proceeds to
> > > > > call tpm2_shutdown(), which tries sending the command and dereferences
> > > > > chip->ops.
> > > >
> > > > It's a typo, yes. Sorry about that.
> > > >
> > > > tpm_class_shutdown() is essentially tail of tpm_del_char_device().
> > > >
> > > > To clean things up, I'd suggest dropping tpm_del_char_device() and
> > > > call tpm_class_shutdown() in tpm_chip_unregisters() along, and open
> > > > coding things that prepend it in tpm_del_char_device().
> > > >
> > >
> > > Personally I would have preferred two separate patches, one to fix the
> > > immediate problem (with Cc: stable) and one for the cleanup, but I
> > > guess merging both into one is ok as long as it is marked for stable.
> > >
> > > Thanks,
> > > Guenter
> >
> > Not sure about stable as this issue does not afaik concern earlier
> > kernel versions?
> >
> 
> I just had a quick look into linux-5.4.y, and it seemed to me that it
> is affected. Maybe I am wrong. Either case, we already applied this
> patch to all affected ChromeOS kernel branches, so from our
> perspective it doesn't really matter.
> 
> Thanks,
> Guenter

I'm fine with cc'ing stable after consideration given the benefits.

Given that conclusion, it is better to break this down to two part
series as you proposed.

/Jarkko
