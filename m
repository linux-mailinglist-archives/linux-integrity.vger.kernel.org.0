Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E0EA6EC650
	for <lists+linux-integrity@lfdr.de>; Mon, 24 Apr 2023 08:32:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229907AbjDXGcn (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 24 Apr 2023 02:32:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbjDXGcm (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 24 Apr 2023 02:32:42 -0400
X-Greylist: delayed 338 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 23 Apr 2023 23:32:39 PDT
Received: from smtp.cecloud.com (ba-smtp01.cecloud.com [15.184.121.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D49701997
        for <linux-integrity@vger.kernel.org>; Sun, 23 Apr 2023 23:32:39 -0700 (PDT)
Received: from smtp.cecloud.com (unknown [103.166.174.66])
        by smtp.cecloud.com (Postfix) with ESMTP id 4CF35100
        for <linux-integrity@vger.kernel.org>; Mon, 24 Apr 2023 06:27:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
        by smtp.cecloud.com (Postfix) with ESMTP id 87F2D7C0112;
        Mon, 24 Apr 2023 14:26:57 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-ANTISPAM-LEVEL: 2
X-ABS-CHECKED: 0
Received: from localhost.localdomain (unknown [111.48.58.11])
        by smtp.cecloud.com (postfix) whith ESMTP id P2249396T281467997385072S1682317613644726_;
        Mon, 24 Apr 2023 14:26:57 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <9e37d15d2253b57ed9181b54bf6399af>
X-RL-SENDER: shaopeijie@cestc.cn
X-SENDER: shaopeijie@cestc.cn
X-LOGIN-NAME: shaopeijie@cestc.cn
X-FST-TO: jarkko@kernel.org
X-RCPT-COUNT: 6
X-SENDER-IP: 111.48.58.11
X-ATTACHMENT-NUM: 0
X-System-Flag: 0
From:   shaopeijie@cestc.cn
To:     jarkko@kernel.org
Cc:     peterhuewe@gmx.de, jgg@ziepe.ca, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org, shaopeijie@gmail.com
Subject: Re: [PATCH] tpm_tis_spi: fix:release chip select when flow control fails
Date:   Mon, 24 Apr 2023 14:26:43 +0800
Message-Id: <20230424062643.19392-1-shaopeijie@cestc.cn>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <ZEMEQE4Cym+A4XTG@kernel.org>
References: <ZEMEQE4Cym+A4XTG@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Sat, 22 Apr 2023 00:46:40 +0300, jarkko@kernel.org wrote:
> On Fri, Mar 31, 2023 at 02:56:25PM +0800, shaopeijie@cestc.cn wrote:
>> From: Peijie Shao <shaopeijie@cestc.cn>
>> 
>> The TPM's chip select will leave active after spi_bus_unlock when
>> flow control timeout, and may interfere other chips sharing the same
>> spi bus, or may damage them dule to level conflict on MISO pin.
>> 
>> So the patch deactives the chip select by sending an empty message
>> with cs_change=0 if flow control fails.
>> 
>> The reason why flow control timeout for me is unfortunately I got a
>> damaged TPM chip. It always pull MISO low during cs active(this can
>> be easily emulated by wire MISO to the ground), not responding anything,
>> and dmesg shows below:
>> ...
>> [   311.150725] tpm_tis_spi: probe of spi0.0 failed with error -110
>> ...
>
> We don't really cease to support damaged hardware but it is true
> that the *software* failure paths should probably be robust enough
> to deativate chip select.
>
> I would rewrite this as
>
> "The failure paths in tpm_tis_spi_transfer() do not deactivate
> chip select. Send an empty message (cs_select == 0) to overcome
> this."
>
> That's all there needs to be. We do not care about broken hardware.
>

I agree. The patch is to robust *software* path, but not support 
broken hardware.

>> 
>> Signed-off-by: Peijie Shao <shaopeijie@cestc.cn>
>> ---
>>  drivers/char/tpm/tpm_tis_spi_main.c | 13 ++++++++++++-
>>  1 file changed, 12 insertions(+), 1 deletion(-)
>> 
>> diff --git a/drivers/char/tpm/tpm_tis_spi_main.c b/drivers/char/tpm/tpm_tis_spi_main.c
>> index a0963a3e92bd..5c8ff343761f 100644
>> --- a/drivers/char/tpm/tpm_tis_spi_main.c
>> +++ b/drivers/char/tpm/tpm_tis_spi_main.c
>> @@ -105,8 +105,19 @@ int tpm_tis_spi_transfer(struct tpm_tis_data *data, u32 addr, u16 len,
>>  		/* Flow control transfers are receive only */
>>  		spi_xfer.tx_buf = NULL;
>>  		ret = phy->flow_control(phy, &spi_xfer);
>> -		if (ret < 0)
>> +		if (ret < 0) {
>> +			/*
>> +			 * Release cs pin if the device is not responding, regardless of the reason.
>> +			 * Notice cs may alreadly been released if the failure was caused inside
>> +			 * spi_sync_locked called by flow_control, in this situation, a pluse may be
>> +			 * generated on cs.
>> +			 */
>
> Please replace above comment with:
>
> /* Deactivate chip select: */
>

I agree.

>> +			memset(&spi_xfer, 0, sizeof(spi_xfer));
>> +			spi_message_init(&m);
>> +			spi_message_add_tail(&spi_xfer, &m);
>> +			spi_sync_locked(phy->spi_device, &m);
>>  			goto exit;
>> +		}
>>  
>>  		spi_xfer.cs_change = 0;
>>  		spi_xfer.len = transfer_len;
>> -- 
>> 2.39.1
>> 
>> 
>> 
>
> There's three call sites, why are you taking care of only one
> of them?
>
> I'd consider instead:
>
>        return 0;
>
> exit:
>        memset(&spi_xfer, 0, sizeof(spi_xfer));
>        spi_message_init(&m);
>        spi_message_add_tail(&spi_xfer, &m);
>        spi_sync_locked(phy->spi_device, &m);
>        spi_bus_unlock(phy->spi_device->master);
>        return ret;
> }

I found that spi_sync_locked() will deactivate cs if any failure
is generated inside it.

    spi_sync_locked()
	...
        spi_transfer_one_message()
            ...
            if (ret != 0 || !keep_cs)
                spi_set_cs(msg->spi, false, false);

spi_transfer_one_message() is the default transfer method, I think 
other spi controllers who implements .transfer_one_message should 
have the same behaviour.

Sending an empty message when cs is already deactivated may have a small
side effect: cs will go activate and deactivate in a very short time,
means a pulse will be generated on cs pin. This may also happen when
failure is generated by spi_sync_locked() which called inside ->flow_control().

So to reduce this, I prefer deactivating cs only when phy->flow_control()
fails. If the side effect is totaly acceptable, your advice maybe better.

Waiting for your suggestions.

>
> The the rollback would apply to all call sites.
>
> BR, Jarkko

Thanks!

Peijie, Shao



