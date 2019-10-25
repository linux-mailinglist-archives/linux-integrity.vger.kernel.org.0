Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2A767E4EAB
	for <lists+linux-integrity@lfdr.de>; Fri, 25 Oct 2019 16:13:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731516AbfJYONi (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 25 Oct 2019 10:13:38 -0400
Received: from mga04.intel.com ([192.55.52.120]:3078 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727367AbfJYONi (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 25 Oct 2019 10:13:38 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Oct 2019 07:13:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,228,1569308400"; 
   d="scan'208";a="228913925"
Received: from jsakkine-mobl1.tm.intel.com (HELO localhost) ([10.237.50.120])
  by fmsmga002.fm.intel.com with ESMTP; 25 Oct 2019 07:13:35 -0700
Date:   Fri, 25 Oct 2019 17:13:33 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     ivan.lazeev@gmail.com
Cc:     Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8] tpm_crb: fix fTPM on AMD Zen+ CPUs
Message-ID: <20191025141333.GA975@linux.intel.com>
References: <20191016182814.18350-1-ivan.lazeev@gmail.com>
 <20191021155735.GA7387@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191021155735.GA7387@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, Oct 21, 2019 at 06:57:35PM +0300, Jarkko Sakkinen wrote:
> On Wed, Oct 16, 2019 at 09:28:14PM +0300, ivan.lazeev@gmail.com wrote:
> > From: Ivan Lazeev <ivan.lazeev@gmail.com>
> > 
> > Bug link: https://bugzilla.kernel.org/show_bug.cgi?id=195657
> > 
> > cmd/rsp buffers are expected to be in the same ACPI region.
> > For Zen+ CPUs BIOS's might report two different regions, some of
> > them also report region sizes inconsistent with values from TPM
> > registers.
> > 
> > Memory configuration on ASRock x470 ITX:
> > 
> > db0a0000-dc59efff : Reserved
> >         dc57e000-dc57efff : MSFT0101:00
> >         dc582000-dc582fff : MSFT0101:00
> > 
> > Work around the issue by storing ACPI regions declared for the
> > device in a fixed array and adding an array for pointers to
> > corresponding possibly allocated resources in crb_map_io function.
> > This data was previously held for a single resource
> > in struct crb_priv (iobase field) and local variable io_res in
> > crb_map_io function. ACPI resources array is used to find index of
> > corresponding region for each buffer and make the buffer size
> > consistent with region's length. Array of pointers to allocated
> > resources is used to map the region at most once.
> > 
> > Signed-off-by: Ivan Lazeev <ivan.lazeev@gmail.com>
> 
> Almost tested this today. Unfortunately the USB stick at hand was
> broken.  I'll retry tomorrow or Wed depending on which day I visit at
> the office and which day I WFH.
> 
> At least the AMI BIOS had all the TPM stuff in it. The hardware I'll be
> using is Udoo Bolt V8 (thanks Jerry for pointing me out this device)
> with AMD Ryzen Embedded V1605B [1]
> 
> Thanks for the patience with your patch.
> 
> [1] https://en.wikichip.org/wiki/amd/ryzen_embedded/v1605b

Tested-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>

Heh, the problem with my kernel config was that I didn't have xhci
(USB3) my kernel config :-) Never needed that one before when testing
TPM changes.

/Jarkko
