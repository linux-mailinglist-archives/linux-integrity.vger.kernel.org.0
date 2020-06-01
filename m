Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C03711E9BB8
	for <lists+linux-integrity@lfdr.de>; Mon,  1 Jun 2020 04:31:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726962AbgFACa7 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 31 May 2020 22:30:59 -0400
Received: from mga04.intel.com ([192.55.52.120]:46984 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726860AbgFACa7 (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 31 May 2020 22:30:59 -0400
IronPort-SDR: mNzRv7egugdV/olPghanJEyibIn6JE6Zr+Fsn8JS9Jd5/yrOCUcQoDfNEKXzIA/89K4SoyIglA
 y/mHU6XyG3hw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2020 19:30:59 -0700
IronPort-SDR: T05QpFWba5K1bVwF/kW3+ljbhKH1XhcO80D78Yw8mpE5PkpQVzvY+7ARcdODO70NQuQMX2h/ZW
 Zhh8iymTeLzg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,459,1583222400"; 
   d="scan'208";a="257110159"
Received: from dytagah-mobl.amr.corp.intel.com (HELO localhost) ([10.252.58.236])
  by orsmga007.jf.intel.com with ESMTP; 31 May 2020 19:30:48 -0700
Date:   Mon, 1 Jun 2020 05:30:47 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     amirmizi6@gmail.com
Cc:     Eyal.Cohen@nuvoton.com, oshrialkoby85@gmail.com,
        alexander.steffen@infineon.com, robh+dt@kernel.org,
        peterhuewe@gmx.de, christophe-h.richard@st.com, jgg@ziepe.ca,
        arnd@arndb.de, gregkh@linuxfoundation.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-integrity@vger.kernel.org, oshri.alkoby@nuvoton.com,
        tmaimon77@gmail.com, gcwilson@us.ibm.com, kgoldman@us.ibm.com,
        Dan.Morav@nuvoton.com, oren.tanami@nuvoton.com,
        shmulik.hager@nuvoton.com, amir.mizinski@nuvoton.com,
        Benoit Houyere <benoit.houyere@st.com>
Subject: Re: [PATCH v9 2/8] tpm: tpm_tis: Fix expected bit handling and send
 all bytes in one shot without last byte in exception
Message-ID: <20200601023047.GB796332@linux.intel.com>
References: <20200526141658.157801-1-amirmizi6@gmail.com>
 <20200526141658.157801-3-amirmizi6@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200526141658.157801-3-amirmizi6@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, May 26, 2020 at 05:16:52PM +0300, amirmizi6@gmail.com wrote:
> From: Amir Mizinski <amirmizi6@gmail.com>
> 
> Incorrect implementation of send message was detected. We polled only
> TPM_STS.stsValid bit and then we single-checked the TPM_STS.expect bit
> value.
> TPM_STS.expected bit should be checked at the same time as
> TPM_STS.stsValid bit, and this should be repeated until timeout_A.

I don't understand what the first paragraph is trying to say. It does
not conclude to anything. Please write instead soemthing that explains
what is going on.

> To detect a TPM_STS.expected bit reset, the "wait_for_tpm_stat" function is
> modified to "wait_for_tpm_stat_result". This function regularly reads the
> status register and check the bits defined by "mask" to reach the value
> defined in "mask_result".

Please remove this and explain instead how are you are changing the
existing function.

> This correct implementation is required for using the new CRC calculation
> on I2C TPM command bytes or I2C TPM answer bytes. TPM_STS.expected bit is
> reset after all bytes are acquired and the CRC result is inserted in the
> dedicated register. It introduces a normal latency for TPM_STS.expected
> bit reset.
> 
> Respectively, to send a message, as defined in
> TCG_DesignPrinciples_TPM2p0Driver_vp24_pubrev.pdf, all bytes should be
> sent in one shot instead of sending the last byte separately.
> 
> Suggested-by: Benoit Houyere <benoit.houyere@st.com>
> Signed-off-by: Amir Mizinski <amirmizi6@gmail.com>
> ---
>  drivers/char/tpm/tpm_tis_core.c | 74 +++++++++++++++++------------------------
>  1 file changed, 30 insertions(+), 44 deletions(-)
> 
> diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_core.c
> index 27c6ca0..c725b68 100644
> --- a/drivers/char/tpm/tpm_tis_core.c
> +++ b/drivers/char/tpm/tpm_tis_core.c
> @@ -44,9 +44,10 @@ static bool wait_for_tpm_stat_cond(struct tpm_chip *chip, u8 mask,
>  	return false;
>  }
>  
> -static int wait_for_tpm_stat(struct tpm_chip *chip, u8 mask,
> -		unsigned long timeout, wait_queue_head_t *queue,
> -		bool check_cancel)
> +static int wait_for_tpm_stat_result(struct tpm_chip *chip, u8 mask,
> +				    u8 mask_result, unsigned long timeout,
> +				    wait_queue_head_t *queue,
> +				    bool check_cancel)

Please do not change the function name.

/Jarkko
