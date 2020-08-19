Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80A6F24A835
	for <lists+linux-integrity@lfdr.de>; Wed, 19 Aug 2020 23:09:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726923AbgHSVJb (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 19 Aug 2020 17:09:31 -0400
Received: from mga14.intel.com ([192.55.52.115]:30132 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727107AbgHSVJa (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 19 Aug 2020 17:09:30 -0400
IronPort-SDR: sAGR8TTRwhVSeCwFOpz4X1iNgpNghWkk7bwytvltvMsH4CMNNHGqMaj35QLXkkVcBwPPtewcWT
 jQAYhT9Ot+5Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9718"; a="154460928"
X-IronPort-AV: E=Sophos;i="5.76,332,1592895600"; 
   d="scan'208";a="154460928"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2020 14:09:30 -0700
IronPort-SDR: 5cndTTZ4xWxk+PWXpH3ISKClr+XpZCZ8FvZ0yYib9YUt7SijssSWQhjDU7bAbvZdWB0or30SXt
 NAhYutfpCumg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,332,1592895600"; 
   d="scan'208";a="320622515"
Received: from abojanow-mobl4.ger.corp.intel.com (HELO localhost) ([10.252.52.107])
  by fmsmga004.fm.intel.com with ESMTP; 19 Aug 2020 14:09:27 -0700
Date:   Thu, 20 Aug 2020 00:09:27 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Masahisa Kojima <masahisa.kojima@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Rob Herring <robh+dt@kernel.org>, Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v5 2/2] dt-bindings: Add SynQucer TPM MMIO as a trivial
 device
Message-ID: <20200819210927.GF9942@linux.intel.com>
References: <20200728031433.3370-1-masahisa.kojima@linaro.org>
 <20200728031433.3370-3-masahisa.kojima@linaro.org>
 <20200817211440.GB44714@linux.intel.com>
 <CAMj1kXG2h-yk_hw-HZvhAPfYRVHq=LgNp5FB1J4SmnN82Zm9jA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXG2h-yk_hw-HZvhAPfYRVHq=LgNp5FB1J4SmnN82Zm9jA@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, Aug 19, 2020 at 12:22:52PM +0200, Ard Biesheuvel wrote:
> On Mon, 17 Aug 2020 at 23:14, Jarkko Sakkinen
> <jarkko.sakkinen@linux.intel.com> wrote:
> >
> > On Tue, Jul 28, 2020 at 12:14:32PM +0900, Masahisa Kojima wrote:
> > > Add a compatible string for the SynQuacer TPM to the binding for a
> > > TPM exposed via a memory mapped TIS frame. The MMIO window behaves
> > > slightly differently on this hardware, so it requires its own
> > > identifier.
> > >
> > > Cc: Rob Herring <robh+dt@kernel.org>
> > > Cc: Ard Biesheuvel <ardb@kernel.org>
> > > Acked-by: Rob Herring <robh@kernel.org>
> > > Signed-off-by: Masahisa Kojima <masahisa.kojima@linaro.org>
> >
> > I applied these patches:
> >
> > http://git.infradead.org/users/jjs/linux-tpmdd.git/log/refs/heads/master
> >
> 
> Thanks Jarkko

Yeah, sorry for taking this long. I was on vacation for couple of weeks.

/Jarkko
