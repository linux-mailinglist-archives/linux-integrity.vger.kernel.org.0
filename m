Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA72721B429
	for <lists+linux-integrity@lfdr.de>; Fri, 10 Jul 2020 13:40:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727078AbgGJLkG (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 10 Jul 2020 07:40:06 -0400
Received: from mga03.intel.com ([134.134.136.65]:53565 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726828AbgGJLkF (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 10 Jul 2020 07:40:05 -0400
IronPort-SDR: aJV7CgbdijTx+fy6IFDRB2UdxlZaj0XJbQw7d9tFBky2fNsj89MzXPeN5nLHtbZibBCOMJ0UKq
 Ki810C6ww1Dg==
X-IronPort-AV: E=McAfee;i="6000,8403,9677"; a="148173814"
X-IronPort-AV: E=Sophos;i="5.75,335,1589266800"; 
   d="scan'208";a="148173814"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2020 04:40:04 -0700
IronPort-SDR: GgUGeJx380Kb043Ycq+vOjyyyY2kot0/3TdLXU2AGXiqyVLKWd5yRL/sqOaCsjJoPfu0fEcd/O
 T20s/oE8UqBA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,335,1589266800"; 
   d="scan'208";a="324588693"
Received: from taverna-mobl.ger.corp.intel.com (HELO localhost) ([10.252.53.137])
  by orsmga007.jf.intel.com with ESMTP; 10 Jul 2020 04:40:01 -0700
Date:   Fri, 10 Jul 2020 14:40:00 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Andrey Pronin <apronin@chromium.org>
Cc:     peterhuewe@gmx.de, jgg@ziepe.ca, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org, groeck@chromium.org
Subject: Re: [PATCH] tpm: avoid accessing cleared ops during shutdown
Message-ID: <20200710114000.GD2614@linux.intel.com>
References: <20200710002209.6757-1-apronin@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200710002209.6757-1-apronin@chromium.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, Jul 09, 2020 at 05:22:09PM -0700, Andrey Pronin wrote:
> This patch prevents NULL dereferencing when using chip->ops while
> sending TPM2_Shutdown command if both tpm_class_shutdown handler and
> tpm_del_char_device are called during system shutdown.
> 
> Both these handlers set chip->ops to NULL but don't check if it's
> already NULL when they are called before using it.
> 
> This issue was revealed in Chrome OS after a recent set of changes
> to the unregister order for spi controllers, such as:
>   b4c6230bb0ba spi: Fix controller unregister order
>   f40913d2dca1 spi: pxa2xx: Fix controller unregister order
> and similar for other controllers.

I'm not sure I fully understand the scenario. When does thi happen?
Why does not tpm_del_char_device need this? The changes listed tell
me nothing. Why they have this effect?

I'm just trying to understand whether this could be a regression or
not.

I neither understand what you mean by "and similar for other
controllers."

NAK for the reason that I don't understand what I'm merging.

/Jarkko

> 
> Signed-off-by: Andrey Pronin <apronin@chromium.org>
> ---
>  drivers/char/tpm/tpm-chip.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/char/tpm/tpm-chip.c b/drivers/char/tpm/tpm-chip.c
> index 8c77e88012e9..a410ca40a3c5 100644
> --- a/drivers/char/tpm/tpm-chip.c
> +++ b/drivers/char/tpm/tpm-chip.c
> @@ -296,7 +296,7 @@ static int tpm_class_shutdown(struct device *dev)
>  	struct tpm_chip *chip = container_of(dev, struct tpm_chip, dev);
>  
>  	down_write(&chip->ops_sem);
> -	if (chip->flags & TPM_CHIP_FLAG_TPM2) {
> +	if (chip->ops && (chip->flags & TPM_CHIP_FLAG_TPM2)) {
>  		if (!tpm_chip_start(chip)) {
>  			tpm2_shutdown(chip, TPM2_SU_CLEAR);
>  			tpm_chip_stop(chip);
> @@ -479,7 +479,7 @@ static void tpm_del_char_device(struct tpm_chip *chip)
>  
>  	/* Make the driver uncallable. */
>  	down_write(&chip->ops_sem);
> -	if (chip->flags & TPM_CHIP_FLAG_TPM2) {
> +	if (chip->ops && (chip->flags & TPM_CHIP_FLAG_TPM2)) {
>  		if (!tpm_chip_start(chip)) {
>  			tpm2_shutdown(chip, TPM2_SU_CLEAR);
>  			tpm_chip_stop(chip);
> -- 
> 2.25.1
> 
