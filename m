Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C79AC2CACC0
	for <lists+linux-integrity@lfdr.de>; Tue,  1 Dec 2020 20:52:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727463AbgLATvH (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 1 Dec 2020 14:51:07 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:21106 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729560AbgLATvH (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 1 Dec 2020 14:51:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606852180;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mQvUejzWomuVYfltCHqrdlnx1wcGttLhlCrhNq21ZbA=;
        b=SEIt5f1qnvbwt8qwnhmyhwWSb3R/0HI3OBZAZ3o5jk6oQM9o4bVD3uleFJ2ZBYSZrD+N9D
        WCEMfCg1sSbXa+PUsSICzgS4lbn3KibFF9N/NrFxI/2TX4JRP2K1WjJ9uDR7CWBtKxv7IP
        gvl+aonufl6+pPHEJp2JNWvWSWDlTL8=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-338-39-M8zZOMce7-vRCJqZe1g-1; Tue, 01 Dec 2020 14:49:38 -0500
X-MC-Unique: 39-M8zZOMce7-vRCJqZe1g-1
Received: by mail-qk1-f200.google.com with SMTP id t141so2226545qke.22
        for <linux-integrity@vger.kernel.org>; Tue, 01 Dec 2020 11:49:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version;
        bh=mQvUejzWomuVYfltCHqrdlnx1wcGttLhlCrhNq21ZbA=;
        b=tWs7dCk2/vgz1Rbzan2p8YHV6BqrlwgxYOp+qJg39vXTlRMt7QH+eI62m0ZJWVAYwY
         MxBXRa1nyJsp2fO/H6kvCEmcc+uRp8/l/fJrl2TIvjgDELfCxEyWczLdimbtN3hQkb1S
         gRdcjKmTUkPw0AyquEOKftlg0QgeKm2rnciGTErBNa6n0n9C/dzdO95VDgfhMx3IPQv5
         T7EMe9GE33B5+gQmt1R7fP4wqaNfdeMlpWsFbR42kw1vzG2Q/C/mOfJJvc8dTXF79pQl
         v1vugm0E7SeHNyMM+uERPaJ9D2VZ6Y+U+tpuZsp7D+MFdQGW+XTaaCWVfjJtCf5c64JP
         Sijw==
X-Gm-Message-State: AOAM53094JE0eOKW+OAS2Mzl3mPv1Mr9lIreFaxiw5LjVXEG0vOcVnO7
        XE1SAZqZYTWhp26urkqF7bUrBo4vb0BwXMsKW3fCi1xsHS7zDK5USmp1/cTmSdrU+HzqkGeGJU3
        PcNozBSGN+8LPf94yQ4pvRhBbo4tQ
X-Received: by 2002:ad4:5621:: with SMTP id cb1mr5083371qvb.12.1606852177556;
        Tue, 01 Dec 2020 11:49:37 -0800 (PST)
X-Google-Smtp-Source: ABdhPJznYP4M/3SWgAa9dZ6qJqsBiVtfLWr9AwDotCdmH7lorz++kKREjq0kPpHHrQUW6JqF0JbFeg==
X-Received: by 2002:ad4:5621:: with SMTP id cb1mr5083351qvb.12.1606852177294;
        Tue, 01 Dec 2020 11:49:37 -0800 (PST)
Received: from localhost (ip98-179-76-75.ph.ph.cox.net. [98.179.76.75])
        by smtp.gmail.com with ESMTPSA id c27sm643839qkk.57.2020.12.01.11.49.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Dec 2020 11:49:36 -0800 (PST)
References: <20201001180925.13808-1-James.Bottomley@HansenPartnership.com>
 <20201001180925.13808-4-James.Bottomley@HansenPartnership.com>
 <87h7p5mm3g.fsf@redhat.com>
User-agent: mu4e 1.4.10; emacs 27.1
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     linux-integrity@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>,
        "Jarkko Sakkinen" <jarkko.sakkinen@linux.intel.com>,
        Peter Huewe <peterhuewe@gmx.de>
Subject: Re: [PATCH v2 3/5] tpm_tis: Fix interrupts for TIS TPMs without
 legacy cycles
In-reply-to: <87h7p5mm3g.fsf@redhat.com>
Date:   Tue, 01 Dec 2020 12:49:35 -0700
Message-ID: <87blfdmhm8.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


Jerry Snitselaar @ 2020-12-01 11:12 MST:

> James Bottomley @ 2020-10-01 11:09 MST:
>
>> If a TIS TPM doesn't have legacy cycles, any write to the interrupt
>> registers is ignored unless a locality is active.  This means even to
>> set up the interrupt vectors a locality must first be activated.  Fix
>> this by activating the 0 locality in the interrupt probe setup.
>>
>> Since the TPM_EOI signalling also requires an active locality, the
>> interrupt routine cannot end an interrupt if the locality is released.
>> This can lead to a situation where the TPM goes command ready after
>> locality release and since the interrupt cannot be ended it refires
>> continuously.  Fix this by disabling all interrupts except locality
>> change when a locality is released (this only fires when a locality
>> becomes active, meaning the TPM_EOI should work).
>>
>> Finally, since we now disable all status based interrupts in the
>> locality release, they must be re-enabled before waiting to check the
>> condition, so add interrupt enabling to the status wait.
>>
>> Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>
>>
>> ---
>>
>> v2: renamed functions
>> ---
>>  drivers/char/tpm/tpm_tis_core.c | 125 ++++++++++++++++++++++++++------
>>  1 file changed, 101 insertions(+), 24 deletions(-)
>>
>> diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_core.c
>> index 431919d5f48a..0c07da8cd680 100644
>> --- a/drivers/char/tpm/tpm_tis_core.c
>> +++ b/drivers/char/tpm/tpm_tis_core.c
>> @@ -29,6 +29,46 @@
>>  
>>  static void tpm_tis_clkrun_enable(struct tpm_chip *chip, bool value);
>>  
>> +static void tpm_tis_enable_interrupt(struct tpm_chip *chip, u8 mask)
>> +{
>> +	struct tpm_tis_data *priv = dev_get_drvdata(&chip->dev);
>> +	u32 intmask;
>> +
>> +	/* Take control of the TPM's interrupt hardware and shut it off */
>> +	tpm_tis_read32(priv, TPM_INT_ENABLE(priv->locality), &intmask);
>> +
>> +	intmask |= mask | TPM_GLOBAL_INT_ENABLE;
>> +
>> +	tpm_tis_write32(priv, TPM_INT_ENABLE(priv->locality), intmask);
>> +}
>> +
>> +static void tpm_tis_disable_interrupt(struct tpm_chip *chip, u8 mask)
>> +{
>> +	struct tpm_tis_data *priv = dev_get_drvdata(&chip->dev);
>> +	u32 intmask;
>> +
>> +	/* Take control of the TPM's interrupt hardware and shut it off */
>> +	tpm_tis_read32(priv, TPM_INT_ENABLE(priv->locality), &intmask);
>> +
>> +	intmask &= ~mask;
>> +
>> +	tpm_tis_write32(priv, TPM_INT_ENABLE(priv->locality), intmask);
>> +}
>> +
>> +static void tpm_tis_enable_stat_interrupts(struct tpm_chip *chip, u8 stat)
>> +{
>> +	u32 mask = 0;
>> +
>> +	if (stat & TPM_STS_COMMAND_READY)
>> +		mask |= TPM_INTF_CMD_READY_INT;
>> +	if (stat & TPM_STS_VALID)
>> +		mask |= TPM_INTF_STS_VALID_INT;
>> +	if (stat & TPM_STS_DATA_AVAIL)
>> +		mask |= TPM_INTF_DATA_AVAIL_INT;
>> +
>> +	tpm_tis_enable_interrupt(chip, mask);
>> +}
>> +
>>  static bool wait_for_tpm_stat_cond(struct tpm_chip *chip, u8 mask,
>>  					bool check_cancel, bool *canceled)
>>  {
>> @@ -65,11 +105,14 @@ static int wait_for_tpm_stat(struct tpm_chip *chip, u8 mask,
>>  		timeout = stop - jiffies;
>>  		if ((long)timeout <= 0)
>>  			return -ETIME;
>> +		tpm_tis_enable_stat_interrupts(chip, mask);
>>  		rc = wait_event_interruptible_timeout(*queue,
>>  			wait_for_tpm_stat_cond(chip, mask, check_cancel,
>>  					       &canceled),
>>  			timeout);
>>  		if (rc > 0) {
>> +			if (rc == 1)
>> +				dev_err(&chip->dev, "Lost Interrupt waiting for TPM stat\n");
>
> With my proposed patch to check for the interrupt storm condition I
> sometimes see this message. Do you think it would make sense to have a
> check here and in the request_locality location to see that
> TPM_CHIP_FLAG is still enabled? It will print a message about the
> interrupt storm being detected, and switching to polling, so I don't
> know if this will cause confusion for people to have this show up as
> well in that case.
>

I guess it wouldn't be too confusing since the messages will appear
close together.

