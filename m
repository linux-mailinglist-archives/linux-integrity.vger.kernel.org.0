Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F053E2BAE72
	for <lists+linux-integrity@lfdr.de>; Fri, 20 Nov 2020 16:23:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729437AbgKTPQJ (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 20 Nov 2020 10:16:09 -0500
Received: from mga01.intel.com ([192.55.52.88]:38476 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729431AbgKTPQI (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 20 Nov 2020 10:16:08 -0500
IronPort-SDR: YNZhz8DW5d4+J5zHlnBE/2KeVBh3ursfiNaL0UAKaZm7egOjMw0oU05CrOlhHVnpnhzvtN9gb5
 ykPXdH1ntWWw==
X-IronPort-AV: E=McAfee;i="6000,8403,9810"; a="189590019"
X-IronPort-AV: E=Sophos;i="5.78,356,1599548400"; 
   d="scan'208";a="189590019"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2020 07:16:00 -0800
IronPort-SDR: WyQt/srZ4pK1646JJZKBf28dkT35uY4tzIwLMD/dbx5AS9zgHyBppNjfR5rcIYVYMoOrCPdRlL
 OVWcv5iA8mrA==
X-IronPort-AV: E=Sophos;i="5.78,356,1599548400"; 
   d="scan'208";a="545474999"
Received: from aohnmeix-mobl1.ger.corp.intel.com (HELO linux.intel.com) ([10.249.40.86])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2020 07:15:56 -0800
Date:   Fri, 20 Nov 2020 17:15:52 +0200
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Dafna Hirschfeld <dafna.hirschfeld@collabora.com>
Cc:     linux-integrity@vger.kernel.org, apronin@chromium.org,
        dtor@chromium.org, Collabora Kernel ML <kernel@collabora.com>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>
Subject: Re: Re: [PATCH v3 1/2] tpm_tis_core: add optional max xfer size check
Message-ID: <20201120151552.GA3365@linux.intel.com>
References: <1468546745-14646-1-git-send-email-apronin@chromium.org>
 <1469677797-74304-2-git-send-email-apronin@chromium.org>
 <20160809081402.GA10537@intel.com>
 <e601b69a-50a9-187b-1fba-0a344952ed25@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e601b69a-50a9-187b-1fba-0a344952ed25@collabora.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, Nov 19, 2020 at 11:00:40AM +0100, Dafna Hirschfeld wrote:
> Hi,
> I am Dafna Hirschfeld. I work for Collabora on upstreaming patches
> found on the chromeos kernel.
> This patch is in chromeos and is not merged in mainline.

Tested-by is missing.

/Jarkko

> Am 09.08.16 um 10:14 schrieb Jarkko Sakkinen:
> > On Wed, Jul 27, 2016 at 08:49:56PM -0700, Andrey Pronin wrote:
> > > If tpm reports a bigger burstcnt than allowed by the physical protocol,
> > > set burstcnt to the max allowed value.
> > > 
> > > In practice, seen in case of xfer issues (e.g. in spi interface case,
> > > lost header causing flow control issues and wrong values returned on read
> > > from TPM_STS). Without catching, causes the physical layer to reject xfer.
> > > 
> > > Signed-off-by: Andrey Pronin <apronin-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
> > 
> > Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
> > 
> > I don't have hardware to test this. Someone should validate that it
> > does not break anything. Christophe, are you able to do this?
> > 
> > /Jarkko
> > 
> > > ---
> > >   drivers/char/tpm/tpm_tis_core.c | 9 ++++++++-
> > >   drivers/char/tpm/tpm_tis_core.h | 1 +
> > >   2 files changed, 9 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_core.c
> > > index f22caf8..7c4fa0c 100644
> > > --- a/drivers/char/tpm/tpm_tis_core.c
> > > +++ b/drivers/char/tpm/tpm_tis_core.c
> > > @@ -168,8 +168,15 @@ static int get_burstcount(struct tpm_chip *chip)
> > >   			return rc;
> > >   		burstcnt = (value >> 8) & 0xFFFF;
> > > -		if (burstcnt)
> > > +		if (burstcnt) {
> > > +			if (priv->phy_ops->max_xfer_size &&
> > > +			    (burstcnt > priv->phy_ops->max_xfer_size)) {
> > > +				dev_warn(&chip->dev,
> > > +					 "Bad burstcnt read: %d\n", burstcnt);
> > > +				burstcnt = priv->phy_ops->max_xfer_size;
> > > +			}
> > >   			return burstcnt;
> 
> I see there is patch in mainline "tpm_tis_spi: Remove limitation of transfers to MAX_SPI_FRAMESIZE bytes"
> That already limits the transfer length to MAX_SPI_FRAMESIZE. So it seems that this patch is not needed anymore.
> Can someone confirm that?
> 
> Thank you,
> Dafna
> 
> 
> 
> [1] https://lore.kernel.org/tpmdd-devel/1488459879-24349-5-git-send-email-peter.huewe@infineon.com/
> 
> > > +		}
> > >   		msleep(TPM_TIMEOUT);
> > >   	} while (time_before(jiffies, stop));
> > >   	return -EBUSY;
> > > diff --git a/drivers/char/tpm/tpm_tis_core.h b/drivers/char/tpm/tpm_tis_core.h
> > > index 9191aab..58e8b14 100644
> > > --- a/drivers/char/tpm/tpm_tis_core.h
> > > +++ b/drivers/char/tpm/tpm_tis_core.h
> > > @@ -102,6 +102,7 @@ struct tpm_tis_phy_ops {
> > >   	int (*read16)(struct tpm_tis_data *data, u32 addr, u16 *result);
> > >   	int (*read32)(struct tpm_tis_data *data, u32 addr, u32 *result);
> > >   	int (*write32)(struct tpm_tis_data *data, u32 addr, u32 src);
> > > +	u16 max_xfer_size;
> > >   };
> > >   static inline int tpm_tis_read_bytes(struct tpm_tis_data *data, u32 addr,
> > > -- 
> > > 2.6.6
> > > 
> > 
> > ------------------------------------------------------------------------------
> > What NetFlow Analyzer can do for you? Monitors network bandwidth and traffic
> > patterns at an interface-level. Reveals which users, apps, and protocols are
> > consuming the most bandwidth. Provides multi-vendor support for NetFlow,
> > J-Flow, sFlow and other flows. Make informed decisions using capacity
> > planning reports. http://sdm.link/zohodev2dev
> > 
