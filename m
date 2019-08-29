Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 375BBA1F4F
	for <lists+linux-integrity@lfdr.de>; Thu, 29 Aug 2019 17:34:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727073AbfH2Pen (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 29 Aug 2019 11:34:43 -0400
Received: from mga07.intel.com ([134.134.136.100]:46572 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726852AbfH2Pen (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 29 Aug 2019 11:34:43 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Aug 2019 08:34:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,443,1559545200"; 
   d="scan'208";a="182374920"
Received: from friedlmi-mobl1.ger.corp.intel.com (HELO localhost) ([10.252.54.26])
  by fmsmga007.fm.intel.com with ESMTP; 29 Aug 2019 08:34:40 -0700
Date:   Thu, 29 Aug 2019 18:34:37 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Seunghun Han <kkamagui@gmail.com>
Cc:     Matthew Garrett <mjg59@srcf.ucam.org>,
        Matthew Garrett <mjg59@google.com>,
        Peter Huewe <peterhuewe@gmx.de>,
        "open list:TPM DEVICE DRIVER" <linux-integrity@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] x86: tpm: Remove a busy bit of the NVS area for
 supporting AMD's fTPM
Message-ID: <20190829153437.gjcqfolsc26vyt4x@linux.intel.com>
References: <20190826081752.57258-1-kkamagui@gmail.com>
 <CACdnJutomLNthYDzEc0wFBcBHK5iqnk0p-hkAkp57zQZ38oGPA@mail.gmail.com>
 <CAHjaAcSFhQsDYL2iRwwhyvxh9mH4DhxZ__DNzhtk=iiZZ5JdbA@mail.gmail.com>
 <CACdnJutfR2X-5ksXw4PNUdyH2MJs_mExNCcYPp8NLcPW2EDrYQ@mail.gmail.com>
 <CAHjaAcSpU0eW5PLsEpxTkycwi+wNS67xeizb6_BMM_-qUZYAmg@mail.gmail.com>
 <20190827171106.owkvt6slwwg5ypyl@srcf.ucam.org>
 <CAHjaAcSu04J3WqT_vnSnaQuYpFQ+xiXXWxhcCeLQccEq6eQGcQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHjaAcSu04J3WqT_vnSnaQuYpFQ+xiXXWxhcCeLQccEq6eQGcQ@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: NeoMutt/20180716
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, Aug 28, 2019 at 06:36:04PM +0900, Seunghun Han wrote:
> >
> > On Wed, Aug 28, 2019 at 01:36:30AM +0900, Seunghun Han wrote:
> >
> > > I got your point. Is there any problem if some regions which don't
> > > need to be handled in NVS area are saved and restored? If there is a
> > > problem, how about adding code for ignoring the regions in NVS area to
> > > the nvs.c file like Jarkko said? If we add the code, we can save and
> > > restore NVS area without driver's interaction.
> >
> > The only thing that knows which regions should be skipped by the NVS
> > driver is the hardware specific driver, so the TPM driver needs to ask
> > the NVS driver to ignore that region and grant control to the TPM
> > driver.
> >
> > --
> > Matthew Garrett | mjg59@srcf.ucam.org
> 
> Thank you, Matthew and Jarkko.
> It seems that the TPM driver needs to handle the specific case that
> TPM regions are in the NVS. I would make a patch that removes TPM
> regions from the ACPI NVS by requesting to the NVS driver soon.
> 
> Jarkko,
> I would like to get some advice on it. What do you think about
> removing TPM regions from the ACPI NVS in TPM CRB driver? If you don't
> mind, I would make the patch about it.

I'm not sure if ignoring is right call. Then the hibernation behaviour
for TPM regions would break.

Thus, should be "ask access" rather than "grant control".

/Jarkko
