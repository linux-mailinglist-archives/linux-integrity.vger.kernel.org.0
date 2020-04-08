Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 139D71A276F
	for <lists+linux-integrity@lfdr.de>; Wed,  8 Apr 2020 18:46:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730349AbgDHQqf (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 8 Apr 2020 12:46:35 -0400
Received: from mga11.intel.com ([192.55.52.93]:39188 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729355AbgDHQqf (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 8 Apr 2020 12:46:35 -0400
IronPort-SDR: 45bEa2gAHB2GdoaIEZORwqygpMww3NvW1OyoYRWU+JU6iClxYODD61/X2yzg2jJEtQRw8OYWeL
 b5rF2WBY7NQQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2020 09:46:34 -0700
IronPort-SDR: vnrR0SDm2xnMUZvyRTH4Ooy7MJySJhAdizG4leup9HxoJXjykfOP9niO3wUFsAJTh99vx3/vde
 dZeaCFdP7EJg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,359,1580803200"; 
   d="scan'208";a="425200141"
Received: from pratuszn-mobl.ger.corp.intel.com (HELO localhost) ([10.252.40.202])
  by orsmga005.jf.intel.com with ESMTP; 08 Apr 2020 09:46:24 -0700
Date:   Wed, 8 Apr 2020 19:46:23 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     amirmizi6@gmail.com
Cc:     Eyal.Cohen@nuvoton.com, oshrialkoby85@gmail.com,
        alexander.steffen@infineon.com, robh+dt@kernel.org,
        mark.rutland@arm.com, peterhuewe@gmx.de, jgg@ziepe.ca,
        arnd@arndb.de, gregkh@linuxfoundation.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-integrity@vger.kernel.org, oshri.alkoby@nuvoton.com,
        tmaimon77@gmail.com, gcwilson@us.ibm.com, kgoldman@us.ibm.com,
        Dan.Morav@nuvoton.com, oren.tanami@nuvoton.com,
        shmulik.hager@nuvoton.com, amir.mizinski@nuvoton.com
Subject: Re: [PATCH v6 1/7] tpm: tpm_tis: Make implementation of read16
 read32 write32 optional
Message-ID: <20200408164623.GA33486@linux.intel.com>
References: <20200407162044.168890-1-amirmizi6@gmail.com>
 <20200407162044.168890-2-amirmizi6@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200407162044.168890-2-amirmizi6@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, Apr 07, 2020 at 07:20:38PM +0300, amirmizi6@gmail.com wrote:
> From: Amir Mizinski <amirmizi6@gmail.com>
> 
> Only tpm_tis can use memory mapped I/O, which is truly mapped into
> the kernel's memory space. So using ioread16/ioread32/iowrite32 turn into a
> straightforward pointer dereference.
> Every other driver require more complicated operations to read more than 1
> byte at a time and will just fall back to read_bytes/write_bytes.
> Therefore, move this common code out of tpm_tis_spi into tpm_tis_core, so
> that it is automatically used when low-level drivers do not implement the
> specialized methods.
> 
> Co-developed-by: Alexander Steffen <Alexander.Steffen@infineon.com>
> Signed-off-by: Alexander Steffen <Alexander.Steffen@infineon.com>
> Signed-off-by: Amir Mizinski <amirmizi6@gmail.com>
> Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>

Just noticed that the short summary is still wrong. As far as I remember
I asked to fix it.

tpm: tpm_tis: Make implementation of read16 read32 write32 optional

In English you put comma between enumerated things except for the last
thing where you use and-conjuction. How hard is it seriously to write
legit sentences?

/Jarkko
