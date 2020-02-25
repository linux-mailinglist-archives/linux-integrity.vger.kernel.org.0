Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B970616BFD3
	for <lists+linux-integrity@lfdr.de>; Tue, 25 Feb 2020 12:47:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729622AbgBYLrh (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 25 Feb 2020 06:47:37 -0500
Received: from mga03.intel.com ([134.134.136.65]:30644 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729510AbgBYLrh (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 25 Feb 2020 06:47:37 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Feb 2020 03:47:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,484,1574150400"; 
   d="scan'208";a="384447662"
Received: from ayakove1-mobl.ccr.corp.intel.com (HELO localhost) ([10.252.12.5])
  by orsmga004.jf.intel.com with ESMTP; 25 Feb 2020 03:47:31 -0800
Date:   Tue, 25 Feb 2020 13:47:28 +0200
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Fabien Lahoudere <fabien.lahoudere@collabora.com>
Cc:     swboyd@chromium.org, kernel@collabora.com,
        Duncan Laurie <dlaurie@chromium.org>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org
Subject: Re: [PATCH 1/1] Add TPM 2.0 compatible I2C interface for chips with
 cr50 firmware.
Message-ID: <20200225114728.GA15662@linux.intel.com>
References: <20200225110810.1321686-1-fabien.lahoudere@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200225110810.1321686-1-fabien.lahoudere@collabora.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, Feb 25, 2020 at 12:08:07PM +0100, Fabien Lahoudere wrote:
> The firmware running on the currently supported H1 MCU requires a
> special driver to handle its specific protocol, and this makes it
> unsuitable to use tpm_tis_core_* and instead it must implement the
> underlying TPM protocol similar to the other I2C TPM drivers.
> 
> - All 4 byes of status register must be read/written at once.
> - FIFO and burst count is limited to 63 and must be drained by AP.
> - Provides an interrupt to indicate when read response data is ready
> and when the TPM is finished processing write data.
> 
> This driver is based on the existing infineon I2C TPM driver, which
> most closely matches the cr50 i2c protocol behavior.  The driver is
> intentionally kept very similar in structure and style to the
> corresponding drivers in coreboot and depthcharge.
> 
> Signed-off-by: Duncan Laurie <dlaurie@chromium.org>
> [swboyd@chromium.org: Depend on i2c even if it's a module, replace
> boilier plate with SPDX tag, drop asm/byteorder.h include, simplify
> return from probe]
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> Signed-off-by: Fabien Lahoudere <fabien.lahoudere@collabora.com>

The code quality looks overally decent, checkpatch.pl does not complain
and neither does sparse.

My only concern is the lack of tested-by's.

/Jarkko
