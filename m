Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AB4E2122AE7
	for <lists+linux-integrity@lfdr.de>; Tue, 17 Dec 2019 13:06:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726986AbfLQMG2 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 17 Dec 2019 07:06:28 -0500
Received: from mga18.intel.com ([134.134.136.126]:46177 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726747AbfLQMG2 (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 17 Dec 2019 07:06:28 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Dec 2019 04:06:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,325,1571727600"; 
   d="scan'208";a="221746459"
Received: from pbroex-mobl1.ger.corp.intel.com ([10.251.85.107])
  by fmsmga001.fm.intel.com with ESMTP; 17 Dec 2019 04:06:24 -0800
Message-ID: <9991700815c02b3227a5902e4cae1afe5200b0ff.camel@linux.intel.com>
Subject: Re: [PATCH V3] tpm_tis_spi: use new 'delay' structure for SPI
 transfer delays
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, peterhuewe@gmx.de, jgg@ziepe.ca,
        arnd@arndb.de
In-Reply-To: <20191217091615.12764-1-alexandru.ardelean@analog.com>
References: <20191204080049.32701-1-alexandru.ardelean@analog.com>
         <20191217091615.12764-1-alexandru.ardelean@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160
 Espoo
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Date:   Tue, 17 Dec 2019 14:04:29 +0200
User-Agent: Evolution 3.34.1-2 
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, 2019-12-17 at 11:16 +0200, Alexandru Ardelean wrote:
> In a recent change to the SPI subsystem [1], a new 'delay' struct was added
> to replace the 'delay_usecs'. This change replaces the current
> 'delay_usecs' with 'delay' for this driver.
> 
> The 'spi_transfer_delay_exec()' function [in the SPI framework] makes sure
> that both 'delay_usecs' & 'delay' are used (in this order to preserve
> backwards compatibility).
> 
> [1] commit bebcfd272df6485 ("spi: introduce `delay` field for
> `spi_transfer` + spi_transfer_delay_exec()")
> 
> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>

Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>

/Jarkko

