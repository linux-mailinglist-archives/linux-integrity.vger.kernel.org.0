Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EC02E801E4
	for <lists+linux-integrity@lfdr.de>; Fri,  2 Aug 2019 22:43:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729201AbfHBUng (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 2 Aug 2019 16:43:36 -0400
Received: from mga11.intel.com ([192.55.52.93]:10879 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726574AbfHBUng (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 2 Aug 2019 16:43:36 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Aug 2019 13:43:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,339,1559545200"; 
   d="scan'208";a="191922581"
Received: from psathya-mobl1.ger.corp.intel.com (HELO localhost) ([10.252.36.242])
  by fmsmga001.fm.intel.com with ESMTP; 02 Aug 2019 13:43:24 -0700
Date:   Fri, 2 Aug 2019 23:43:18 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Alexander Steffen <Alexander.Steffen@infineon.com>
Cc:     Stephen Boyd <swboyd@chromium.org>,
        Peter Huewe <peterhuewe@gmx.de>,
        Andrey Pronin <apronin@chromium.org>,
        linux-kernel@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-integrity@vger.kernel.org,
        Duncan Laurie <dlaurie@chromium.org>,
        Guenter Roeck <groeck@chromium.org>
Subject: Re: [PATCH v2 5/6] tpm: add driver for cr50 on SPI
Message-ID: <20190802204318.5aktcn7xnvzcwvqj@linux.intel.com>
References: <20190716224518.62556-1-swboyd@chromium.org>
 <20190716224518.62556-6-swboyd@chromium.org>
 <f824e3ab-ae2f-8c2f-549a-16569b10966e@infineon.com>
 <5d2f7daf.1c69fb81.c0b13.c3d4@mx.google.com>
 <ef7195c5-4475-3cb1-6ded-e16d885d1a55@infineon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ef7195c5-4475-3cb1-6ded-e16d885d1a55@infineon.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: NeoMutt/20180716
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, Jul 18, 2019 at 06:47:14PM +0200, Alexander Steffen wrote:
> On 17.07.2019 21:57, Stephen Boyd wrote:
> > Quoting Alexander Steffen (2019-07-17 05:00:06)
> > > On 17.07.2019 00:45, Stephen Boyd wrote:
> > > > From: Andrey Pronin <apronin@chromium.org>
> > > > 
> > > > +static unsigned short rng_quality = 1022;
> > > > +module_param(rng_quality, ushort, 0644);
> > > > +MODULE_PARM_DESC(rng_quality,
> > > > +              "Estimation of true entropy, in bits per 1024 bits.");
> > > 
> > > What is the purpose of this parameter? None of the other TPM drivers
> > > have it.
> > 
> > I think the idea is to let users override the quality if they decide
> > that they don't want to use the default value specified in the driver.
> 
> But isn't this something that applies to all TPMs, not only cr50? So
> shouldn't this parameter be added to one of the global modules (tpm?
> tpm_tis_core?) instead? Or do all low-level drivers (tpm_tis, tpm_tis_spi,
> ...) need this parameter to provide a consistent interface for the user?

This definitely something that is out of context of the patch set and
thus must be removed from the patch set.

/Jarkko
