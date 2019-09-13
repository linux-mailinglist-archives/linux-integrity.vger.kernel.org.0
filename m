Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1AB5BB2186
	for <lists+linux-integrity@lfdr.de>; Fri, 13 Sep 2019 16:02:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388191AbfIMOC2 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 13 Sep 2019 10:02:28 -0400
Received: from mga07.intel.com ([134.134.136.100]:4017 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388084AbfIMOC2 (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 13 Sep 2019 10:02:28 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Sep 2019 07:02:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,489,1559545200"; 
   d="scan'208";a="336899035"
Received: from ltudorx-wtg.ger.corp.intel.com (HELO localhost) ([10.252.37.39])
  by orsmga004.jf.intel.com with ESMTP; 13 Sep 2019 07:02:21 -0700
Date:   Fri, 13 Sep 2019 15:02:18 +0100
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Seunghun Han <kkamagui@gmail.com>
Cc:     ivan.lazeev@gmail.com, arnd@arndb.de, gregkh@linuxfoundation.org,
        jgg@ziepe.ca, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org, peterhuewe@gmx.de
Subject: Re: [PATCH v2] Fix fTPM on AMD Zen+ CPUs
Message-ID: <20190913140218.GB29755@linux.intel.com>
References: <CAHjaAcStAfarJoPG0tbSY0BVcp0-7Lvah2FdpmC_eCFfxaSVFw@mail.gmail.com>
 <20190913140006.GA29755@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190913140006.GA29755@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, Sep 13, 2019 at 03:00:06PM +0100, Jarkko Sakkinen wrote:
> On Wed, Sep 11, 2019 at 02:17:48PM +0900, Seunghun Han wrote:
> > Vanya,
> > I also made a patch series to solve AMD's fTPM. My patch link is here,
> > https://lkml.org/lkml/2019/9/9/132 .
> > 
> > The maintainer, Jarkko, wanted me to remark on your patch, so I would
> > like to cooperate with you.
> > 
> > Your patch is good for me. If you are fine, I would like to take your
> > patch and merge it with my patch series. I also would like to change
> > some points Jason mentioned before.
> 
> I rather handle the review processes separately because I can merge
> Vanyas's patch first. Bundling them into patch set would only slow
> down things.

I did not ask to do anything. I just review code changes.

/Jarkko
