Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46B4170D186
	for <lists+linux-integrity@lfdr.de>; Tue, 23 May 2023 04:45:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229605AbjEWCpZ (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 22 May 2023 22:45:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234920AbjEWCpX (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 22 May 2023 22:45:23 -0400
X-Greylist: delayed 70986 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 22 May 2023 19:45:21 PDT
Received: from smtp.cecloud.com (unknown [1.203.97.246])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0FACE185;
        Mon, 22 May 2023 19:45:20 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by smtp.cecloud.com (Postfix) with ESMTP id 7B48A7C0112;
        Tue, 23 May 2023 10:45:18 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-ANTISPAM-LEVEL: 2
X-ABS-CHECKED: 0
Received: from localhost.localdomain (unknown [111.48.58.11])
        by smtp.cecloud.com (postfix) whith ESMTP id P3330305T281461580820848S1684809917609798_;
        Tue, 23 May 2023 10:45:18 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <1d9276b933edfbb380a09e82d5628178>
X-RL-SENDER: shaopeijie@cestc.cn
X-SENDER: shaopeijie@cestc.cn
X-LOGIN-NAME: shaopeijie@cestc.cn
X-FST-TO: pmenzel@molgen.mpg.de
X-RCPT-COUNT: 6
X-SENDER-IP: 111.48.58.11
X-ATTACHMENT-NUM: 0
X-System-Flag: 0
From:   shaopeijie@cestc.cn
To:     pmenzel@molgen.mpg.de
Cc:     jarkko@kernel.org, peterhuewe@gmx.de, jgg@ziepe.ca,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Re: [PATCH v2] tpm_tis_spi: fix:release chip select when flow control fails
Date:   Tue, 23 May 2023 10:45:07 +0800
Message-Id: <20230523024507.4277-1-shaopeijie@cestc.cn>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230522070140.33719-1-shaopeijie@cestc.cn>
References: <20230522070140.33719-1-shaopeijie@cestc.cn>
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

Thank you, Paul.

>Dear Peijie,
>
>
>Thank you for your patch.
>
>The fix: tag in your commit message summary is uncommon. I suggest:
>
>> tpm_tis_spi: Release chip select when flow control fails
>

I will change it in v3 version.

>
>Am 22.05.23 um 09:01 schrieb shaopeijie@cestc.cn:
>> From: Peijie Shao <shaopeijie@cestc.cn>
>> 
>> The failure paths in tpm_tis_spi_transfer() do not deactivate
>> chip select. Send an empty message (cs_select == 0) to overcome
>> this.
>
>Does the standard require to deactivate it?

Yes.
<TCG_PCClientTPMInterfaceSpecification_TIS__1-3_27_03212013.pdf>, section
6.4.2 Electrical Specification, Figure 4 Timing Diagram, describes the timing.

Moreover, when multi devices are sharing with the same SPI bus, only one cs can be 
activated simultaneously. If two or more cs are activated, corresponding devices 
may response at same time, cause bus conflicts.

>
>A note on your test setup would be nice to have in the commit message.
>
>> Signed-off-by: Peijie Shao <shaopeijie@cestc.cn>
>> ---
>> Changes since v1:
>>      1. Deactive cs all of the failure path, not only flow control.
>
>Deactivate

Sorry, will be fixed in v3 version.

>
>
>Kind regards,
>
>Paul
>
>
>>      2. change and update comments.
>> ---
>>   drivers/char/tpm/tpm_tis_spi_main.c | 8 ++++++++
>>   1 file changed, 8 insertions(+)
>> 
>> diff --git a/drivers/char/tpm/tpm_tis_spi_main.c b/drivers/char/tpm/tpm_tis_spi_main.c
>> index 1f5207974..9bfaba092 100644
>> --- a/drivers/char/tpm/tpm_tis_spi_main.c
>> +++ b/drivers/char/tpm/tpm_tis_spi_main.c
>> @@ -136,6 +136,14 @@ int tpm_tis_spi_transfer(struct tpm_tis_data *data, u32 addr, u16 len,
>>   	}
>>   
>>   exit:
>> +	if (ret < 0) {
>> +		/* Deactivate chip select */
>> +		memset(&spi_xfer, 0, sizeof(spi_xfer));
>> +		spi_message_init(&m);
>> +		spi_message_add_tail(&spi_xfer, &m);
>> +		spi_sync_locked(phy->spi_device, &m);
>> +	}
>> +
>>   	spi_bus_unlock(phy->spi_device->master);
>>   	return ret;
>>   }

Peijie, Shao


