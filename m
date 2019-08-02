Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2092D8012F
	for <lists+linux-integrity@lfdr.de>; Fri,  2 Aug 2019 21:43:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406353AbfHBTne (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 2 Aug 2019 15:43:34 -0400
Received: from mga11.intel.com ([192.55.52.93]:6759 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405999AbfHBTne (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 2 Aug 2019 15:43:34 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Aug 2019 12:43:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,339,1559545200"; 
   d="scan'208";a="175688182"
Received: from psathya-mobl1.ger.corp.intel.com (HELO localhost) ([10.252.36.242])
  by orsmga003.jf.intel.com with ESMTP; 02 Aug 2019 12:43:25 -0700
Date:   Fri, 2 Aug 2019 22:43:24 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Alexander Steffen <Alexander.Steffen@infineon.com>,
        Peter Huewe <peterhuewe@gmx.de>,
        Andrey Pronin <apronin@chromium.org>,
        linux-kernel@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-integrity@vger.kernel.org,
        Duncan Laurie <dlaurie@chromium.org>,
        Guenter Roeck <groeck@chromium.org>
Subject: Re: [PATCH v2 5/6] tpm: add driver for cr50 on SPI
Message-ID: <20190802194324.i244f32h4hakj35p@linux.intel.com>
References: <20190716224518.62556-1-swboyd@chromium.org>
 <20190716224518.62556-6-swboyd@chromium.org>
 <f824e3ab-ae2f-8c2f-549a-16569b10966e@infineon.com>
 <5d2f7daf.1c69fb81.c0b13.c3d4@mx.google.com>
 <5d2f955d.1c69fb81.35877.7018@mx.google.com>
 <b05904bf-00b9-bf30-0fc9-9f363e181d80@infineon.com>
 <5d30b649.1c69fb81.f440e.9a0a@mx.google.com>
 <1bb8d417-3199-7aff-ad60-b25464502cb3@infineon.com>
 <5d430cfb.1c69fb81.9480d.0d81@mx.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5d430cfb.1c69fb81.9480d.0d81@mx.google.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: NeoMutt/20180716
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, Aug 01, 2019 at 09:02:02AM -0700, Stephen Boyd wrote:
> Quoting Alexander Steffen (2019-07-19 00:53:00)
> > On 18.07.2019 20:11, Stephen Boyd wrote:
> > > Quoting Alexander Steffen (2019-07-18 09:47:22)
> > >> On 17.07.2019 23:38, Stephen Boyd wrote:
> > >>> Quoting Stephen Boyd (2019-07-17 12:57:34)
> > >>>> Quoting Alexander Steffen (2019-07-17 05:00:06)
> > >>>>>
> > >>>>> Can't the code be shared more explicitly, e.g. by cr50_spi wrapping
> > >>>>> tpm_tis_spi, so that it can intercept the calls, execute the additional
> > >>>>> actions (like waking up the device), but then let tpm_tis_spi do the
> > >>>>> common work?
> > >>>>>
> > >>>>
> > >>>> I suppose the read{16,32} and write32 functions could be reused. I'm not
> > >>>> sure how great it will be if we combine these two drivers, but I can
> > >>>> give it a try today and see how it looks.
> > >>>>
> > >>>
> > >>> Here's the patch. I haven't tested it besides compile testing.
> > > 
> > > The code seems to work but I haven't done any extensive testing besides
> > > making sure that the TPM responds to pcr reads and some commands like
> > > reading random numbers.
> > > 
> > >>
> > >> Thanks for providing this. Makes it much easier to see what the actual
> > >> differences between the devices are.
> > >>
> > >> Do we have a general policy on how to support devices that are very
> > >> similar but need special handling in some places? Not duplicating the
> > >> whole driver just to change a few things definitely seems like an
> > >> improvement (and has already been done in the past, as with
> > >> TPM_TIS_ITPM_WORKAROUND). But should all the code just be added to
> > >> tpm_tis_spi.c? Or is there some way to keep a clearer separation,
> > >> especially when (in the future) we have multiple devices that all have
> > >> their own set of deviations from the spec?
> > >>
> > > 
> > > If you have any ideas on how to do it please let me know. At this point,
> > > I'd prefer if the maintainers could provide direction on what they want.
> > 
> > Sure, I'd expect Jarkko will say something once he's back from vacation.
> > 
> 
> Should I just resend this patch series? I haven't attempted to make the
> i2c driver changes, but at least the SPI driver changes seem good enough
> to resend.

Go ahead.

/Jarkko
