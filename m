Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7CA7A9E849
	for <lists+linux-integrity@lfdr.de>; Tue, 27 Aug 2019 14:47:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727058AbfH0MrL (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 27 Aug 2019 08:47:11 -0400
Received: from mga18.intel.com ([134.134.136.126]:36325 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726170AbfH0MrL (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 27 Aug 2019 08:47:11 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Aug 2019 05:47:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,437,1559545200"; 
   d="scan'208";a="187907181"
Received: from jsakkine-mobl1.fi.intel.com (HELO localhost) ([10.237.66.169])
  by FMSMGA003.fm.intel.com with ESMTP; 27 Aug 2019 05:47:08 -0700
Date:   Tue, 27 Aug 2019 15:47:07 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Matthew Garrett <mjg59@google.com>
Cc:     Seunghun Han <kkamagui@gmail.com>,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        Peter Huewe <peterhuewe@gmx.de>,
        "open list:TPM DEVICE DRIVER" <linux-integrity@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] x86: tpm: Remove a busy bit of the NVS area for
 supporting AMD's fTPM
Message-ID: <20190827124707.yhqtaqa4ur6i45h7@linux.intel.com>
References: <20190826081752.57258-1-kkamagui@gmail.com>
 <CACdnJutomLNthYDzEc0wFBcBHK5iqnk0p-hkAkp57zQZ38oGPA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACdnJutomLNthYDzEc0wFBcBHK5iqnk0p-hkAkp57zQZ38oGPA@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: NeoMutt/20180716
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, Aug 26, 2019 at 10:40:25AM -0700, Matthew Garrett wrote:
> On Mon, Aug 26, 2019 at 1:18 AM Seunghun Han <kkamagui@gmail.com> wrote:
> > To support AMD's fTPM, I removed the busy bit from the ACPI NVS area like
> > the reserved area so that AMD's fTPM regions could be assigned in it.
> 
> drivers/acpi/nvs.c saves and restores the contents of NVS regions, and
> if other drivers use these regions without any awareness of this then
> things may break. I'm reluctant to say that just unilaterally marking
> these regions as available is a good thing, but it's clearly what's
> expected by AMD's implementation. One approach would be to have a
> callback into the nvs code to indicate that a certain region should be
> handed off to a driver, which would ensure that we can handle this on
> a case by case basis?

What if E820 would just have a small piece of code just for fTPM's e.g.
it would check the ACPI tree for fTPM's and ignore TPM regions.

/Jarkko
