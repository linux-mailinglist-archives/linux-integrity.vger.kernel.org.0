Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B8F49AEA7C
	for <lists+linux-integrity@lfdr.de>; Tue, 10 Sep 2019 14:34:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389910AbfIJMe7 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 10 Sep 2019 08:34:59 -0400
Received: from mga09.intel.com ([134.134.136.24]:55125 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729890AbfIJMe6 (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 10 Sep 2019 08:34:58 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Sep 2019 05:34:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,489,1559545200"; 
   d="scan'208";a="185495499"
Received: from mweingar-mobl.ger.corp.intel.com (HELO localhost) ([10.252.53.26])
  by fmsmga007.fm.intel.com with ESMTP; 10 Sep 2019 05:34:54 -0700
Date:   Tue, 10 Sep 2019 13:34:52 +0100
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Seunghun Han <kkamagui@gmail.com>
Cc:     Peter Huewe <peterhuewe@gmx.de>,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        "open list:TPM DEVICE DRIVER" <linux-integrity@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] tpm: tpm_crb: enhance command and response buffer
 size calculation code
Message-ID: <20190910123452.GC7484@linux.intel.com>
References: <20190909090906.28700-1-kkamagui@gmail.com>
 <20190909090906.28700-2-kkamagui@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190909090906.28700-2-kkamagui@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, Sep 09, 2019 at 06:09:05PM +0900, Seunghun Han wrote:
> The purpose of crb_fixup_cmd_size() function is to work around broken
> BIOSes and get the trustable size between the ACPI region and register.
> When the TPM has a command buffer and response buffer independently,
> the crb_map_io() function calls crb_fixup_cmd_size() twice to calculate
> each buffer size.  However, the current implementation of it considers
> one of two buffers.
> 
> To support independent command and response buffers, I changed
> crb_check_resource() function for storing ACPI TPB regions to a list.
> I also changed crb_fixup_cmd_size() to use the list for calculating each
> buffer size.
> 
> Signed-off-by: Seunghun Han <kkamagui@gmail.com>

I think as far as the tpm_crb goes I focus on getting Vanya's change
landed because it is better structured, more mature and the first
version was sent couple of weeks earlier. You are welcome to make
your remarks on that patch.

/Jarkko
