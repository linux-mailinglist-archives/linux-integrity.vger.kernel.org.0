Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 766D4117648
	for <lists+linux-integrity@lfdr.de>; Mon,  9 Dec 2019 20:50:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726607AbfLITuu (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 9 Dec 2019 14:50:50 -0500
Received: from mga11.intel.com ([192.55.52.93]:1100 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726483AbfLITuu (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 9 Dec 2019 14:50:50 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Dec 2019 11:50:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,296,1571727600"; 
   d="scan'208";a="215200333"
Received: from nshalmon-mobl.ger.corp.intel.com (HELO localhost) ([10.252.8.146])
  by orsmga006.jf.intel.com with ESMTP; 09 Dec 2019 11:50:45 -0800
Date:   Mon, 9 Dec 2019 21:50:43 +0200
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, peterhuewe@gmx.de, jgg@ziepe.ca,
        arnd@arndb.de
Subject: Re: [PATCH] tpm_tis_spi: use new `delay` structure for SPI transfer
 delays
Message-ID: <20191209195043.GE19243@linux.intel.com>
References: <20191204080049.32701-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191204080049.32701-1-alexandru.ardelean@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, Dec 04, 2019 at 10:00:49AM +0200, Alexandru Ardelean wrote:
> In a recent change to the SPI subsystem [1], a new `delay` struct was added
> to replace the `delay_usecs`. This change replaces the current `delay_secs`
> with `delay` for this driver.

Please, write 'delay_usecs' instead of `delay_usecs`.

/Jarkko
