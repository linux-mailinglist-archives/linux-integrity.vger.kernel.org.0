Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8DE9AACA14
	for <lists+linux-integrity@lfdr.de>; Sun,  8 Sep 2019 01:58:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732554AbfIGX6b (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sat, 7 Sep 2019 19:58:31 -0400
Received: from mga07.intel.com ([134.134.136.100]:45343 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726168AbfIGX6b (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Sat, 7 Sep 2019 19:58:31 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Sep 2019 16:58:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,478,1559545200"; 
   d="scan'208";a="184864717"
Received: from andriiza-mobl.ger.corp.intel.com ([10.252.38.198])
  by fmsmga007.fm.intel.com with ESMTP; 07 Sep 2019 16:58:25 -0700
Message-ID: <2c9ba2f43d3d234eab15980770ec72a565f730ab.camel@linux.intel.com>
Subject: Re: [PATCH] tpm_crb: fix fTPM on AMD Zen+ CPUs
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     ivan.lazeev@gmail.com
Cc:     Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Sun, 08 Sep 2019 02:58:24 +0300
In-Reply-To: <180a3a0fd33cbac9df8adf65999c53a9ddc20bf5.camel@linux.intel.com>
References: <20190904190332.25019-1-ivan.lazeev@gmail.com>
         <180a3a0fd33cbac9df8adf65999c53a9ddc20bf5.camel@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.2-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Sun, 2019-09-08 at 00:49 +0300, Jarkko Sakkinen wrote:
> On Wed, 2019-09-04 at 22:03 +0300, ivan.lazeev@gmail.com wrote:
> > From: Ivan Lazeev <ivan.lazeev@gmail.com>
> > 
> > Bug link: https://bugzilla.kernel.org/show_bug.cgi?id=195657
> > 
> > cmd/rsp buffers are expected to be in the same ACPI region.
> > For Zen+ CPUs BIOS's might report two different regions, some of
> > them also report region sizes inconsistent with values from TPM
> > registers.
> > 
> > Work around the issue by storing ACPI regions declared for the
> > device in a list, then using it to find entry corresponding
> > to each buffer. Use information from the entry to map each resource
> > at most once and make buffer size consistent with the length of the
> > region.
> > 
> > Signed-off-by: Ivan Lazeev <ivan.lazeev@gmail.com>
> 
> Can you add the relevant pieces of /proc/iomem output to the commit
> message so we can see the memory configuration? I don't have the
> hardware available where this kind of situation occurs.

Here in particular this is more than relevant because given that this
patch fixes the issue for you, it seems that you don't have the regions
marked as NVS regions.

/Jarkko

