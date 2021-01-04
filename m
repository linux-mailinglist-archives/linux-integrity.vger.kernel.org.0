Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E17D62E9CF4
	for <lists+linux-integrity@lfdr.de>; Mon,  4 Jan 2021 19:22:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727091AbhADSWn (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 4 Jan 2021 13:22:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:43958 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727086AbhADSWn (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 4 Jan 2021 13:22:43 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6C5E22075E;
        Mon,  4 Jan 2021 18:22:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609784522;
        bh=khefqDNCRqsTnqMvRiZqw3JXlLS+Vu+7p0DiGH1epXQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=muvYH2tvuRZrBkyOTZYNaSDGkdzgeTqtyo0WXfcV0gbQE3HLNXEBwaMIIHBloL8Ic
         91xR8zVdr3W/ETppkpYNSc2P+xGRLt+v4lHG62ZZRoOglfjywuuvLUNpE/R0x5bgwr
         7c3DIFAlc5amO/PSQP21oy0iOYRp5VEfzPylS5JYfGE1kEjHY7mwysT9d3wRDnk7w6
         dYLmv3mIeXSMZoHx3Si27kXkqvHqERToGi76tPRzT1guR+jhcq1FOBYfbLb91D82XF
         aUUXhbvBdCBgUZXwdsDD8Fok+8lwIir0JQMPc2/pAfxnfTMEZUxbrZQBlJjXEtA5Zn
         bs+oXd7kfiVRA==
Date:   Mon, 4 Jan 2021 20:21:56 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-integrity@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>,
        Philip Tricca <philip.b.tricca@intel.com>,
        Tadeusz Struk <tadeusz.struk@intel.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Subject: Re: [PATCH V2] tpm: Remove tpm_dev_wq_lock
Message-ID: <20210104182156.GA7921@kernel.org>
References: <20190211105835.16851-1-bigeasy@linutronix.de>
 <87ft48doti.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87ft48doti.fsf@nanos.tec.linutronix.de>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, Dec 14, 2020 at 11:07:21PM +0100, Thomas Gleixner wrote:
> 
> From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> 
> Never used since it was added.

Hi, apologies for this latency. I was in vacation during 12/14-12/20
last month, and after that Christmas and New Year mixed up schedules a
bit.

Applying today, thanks.

/Jarkko

> Fixes: 9e1b74a63f776 ("tpm: add support for nonblocking operation")
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Cc: linux-integrity@vger.kernel.org
> Cc: Jason Gunthorpe <jgg@ziepe.ca>
> Cc: Philip Tricca <philip.b.tricca@intel.com>
> Cc: Tadeusz Struk <tadeusz.struk@intel.com>
> Cc: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> ---
> V2: Reworded the change log so the !&!%#$ dispute over the formatting
>     is not longer in the way of getting this triviality done.
> ---
>  drivers/char/tpm/tpm-dev-common.c |    1 -
>  1 file changed, 1 deletion(-)
> 
> --- a/drivers/char/tpm/tpm-dev-common.c
> +++ b/drivers/char/tpm/tpm-dev-common.c
> @@ -20,7 +20,6 @@
>  #include "tpm-dev.h"
>  
>  static struct workqueue_struct *tpm_dev_wq;
> -static DEFINE_MUTEX(tpm_dev_wq_lock);
>  
>  static ssize_t tpm_dev_transmit(struct tpm_chip *chip, struct tpm_space *space,
>  				u8 *buf, size_t bufsiz)
