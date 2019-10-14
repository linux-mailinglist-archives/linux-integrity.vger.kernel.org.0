Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AB42DD5D24
	for <lists+linux-integrity@lfdr.de>; Mon, 14 Oct 2019 10:10:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726452AbfJNIKR (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 14 Oct 2019 04:10:17 -0400
Received: from mga06.intel.com ([134.134.136.31]:40911 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725936AbfJNIKR (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 14 Oct 2019 04:10:17 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Oct 2019 01:10:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,295,1566889200"; 
   d="scan'208";a="194159144"
Received: from jsakkine-mobl1.tm.intel.com (HELO localhost) ([10.237.50.126])
  by fmsmga008.fm.intel.com with ESMTP; 14 Oct 2019 01:10:13 -0700
Date:   Mon, 14 Oct 2019 11:10:14 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     ivan.lazeev@gmail.com
Cc:     Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7] tpm_crb: fix fTPM on AMD Zen+ CPUs
Message-ID: <20191014081014.GA5433@linux.intel.com>
References: <20191008215137.17893-1-ivan.lazeev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191008215137.17893-1-ivan.lazeev@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, Oct 09, 2019 at 12:51:37AM +0300, ivan.lazeev@gmail.com wrote:
> From: Ivan Lazeev <ivan.lazeev@gmail.com>
> 
> Bug link: https://bugzilla.kernel.org/show_bug.cgi?id=195657
> 
> cmd/rsp buffers are expected to be in the same ACPI region.
> For Zen+ CPUs BIOS's might report two different regions, some of
> them also report region sizes inconsistent with values from TPM
> registers.
> 
> Memory configuration on ASRock x470 ITX:
> 
> db0a0000-dc59efff : Reserved
>         dc57e000-dc57efff : MSFT0101:00
>         dc582000-dc582fff : MSFT0101:00
> 
> Work around the issue by storing ACPI regions declared for the
> device in a fixed array and adding an array for pointers to
> corresponding possibly allocated resources in crb_map_io function.
> This data was previously held for a single resource
> in struct crb_priv (iobase field) and local variable io_res in
> crb_map_io function. ACPI resources array is used to find index of
> corresponding region for each buffer and make the buffer size
> consistent with region's length. Array of pointers to allocated
> resources is used to map the region at most once.
> 
> Signed-off-by: Ivan Lazeev <ivan.lazeev@gmail.com>
> ---
> Changes in v7:
> 	- use terminator entry in iores_array

You must have always the full changelog i.e.

v7:
...

v6:
...

...

v2:
...

If there is need for new iteration, please add it. However, I don't
think there is. I'm getting Udoo Bolt this week that I can use for
testing this. If it doesn't break anything, I can apply it.

/Jarkko
