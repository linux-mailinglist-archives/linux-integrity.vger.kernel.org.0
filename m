Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B7BE729F91
	for <lists+linux-integrity@lfdr.de>; Fri,  9 Jun 2023 18:03:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242033AbjFIQDc (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 9 Jun 2023 12:03:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231976AbjFIQDb (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 9 Jun 2023 12:03:31 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2065.outbound.protection.outlook.com [40.107.21.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A67826B9;
        Fri,  9 Jun 2023 09:03:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WPMa9ErVR3W4tpFC/XHUroVCdAMFnlNg+HdOG5G7AOgKGiLNW1lkxwQD3FIKzPZkVar8rJ2gJnq4qTMayFmo6Tr22jj1k1kMOYOtS21oLT8FVMJtRrUcPT8v9AsEO4gS0UxdvMP030xfmQSceut++hxdpYgIyjbKcyrZmZ4ehE2NPu8rEuYd4CzxbRluwL+e9NNlO1OfKf8JLbBwO2vGoyfuHU3QbYiGH3X2+MWpJGFNrD3xeInKSnL+rjVjUDJA83uz0DQhsMtujdjrcGmmZs1fuCr9TxVJ/5UXP5I9t9vE/9GWa6+9cyBwEFoFGiVg8EULgiSKvtZKYMSUi9x5Xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FNxcGLdRFVLqX8dNv6CUspqdUM6xV5rsBtYB/2gXz90=;
 b=WJ2lLInwKihzMSNwZ8adeT30GtAlFTfhJJvgYD2lC0th/NgtDWh19UV0ZIfyaj8GLx0ETQ6bcaihvzLY3W7gpOyxTWeaMWeDztKG5nUML8SjazffS1B2ZrxCqUxNyf7tb6YhIdUEttZKzqrSay2Vntd2Sag16ZVBOVQd/fE6zMFZnnV4S43LBaSqwACqdvUXTadMrvRxhglk6LxD2RmQ26WKS0pXmAJjFCVy4eBHI7eQ1oAeHsikqmuXw0u9t+6XtPZQIEov3DOWNekjV7iba1zXXoJX945pncnI6aDCek7fZuOc3W4qjnwUkUT9JRh0bMRMqJxiueGrGbyWsEE3KA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kunbus.com; dmarc=pass action=none header.from=kunbus.com;
 dkim=pass header.d=kunbus.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kunbus.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FNxcGLdRFVLqX8dNv6CUspqdUM6xV5rsBtYB/2gXz90=;
 b=nxN8+dK4nQjbgr1/+AEpJFTpuS69lZgcv4T1rLLBQnCJRcjCHjeMb7bu1DTiF9p0MRABgLHzCMqyoL2jIBZV3eb9tupdcFGP2+blvPL4d1VPNKRoDi0JdycL06C8OdlgmRRN+xM93IXaaylj93Y81PErY4EnjXP4p1OBF7oH1YA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kunbus.com;
Received: from VI1P193MB0413.EURP193.PROD.OUTLOOK.COM (2603:10a6:803:4e::14)
 by GV1P193MB2055.EURP193.PROD.OUTLOOK.COM (2603:10a6:150:28::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.14; Fri, 9 Jun
 2023 16:03:24 +0000
Received: from VI1P193MB0413.EURP193.PROD.OUTLOOK.COM
 ([fe80::6727:e3fb:8fec:72a6]) by VI1P193MB0413.EURP193.PROD.OUTLOOK.COM
 ([fe80::6727:e3fb:8fec:72a6%7]) with mapi id 15.20.6500.015; Fri, 9 Jun 2023
 16:03:24 +0000
Message-ID: <550f0928-73dd-0dbf-0763-c9cc529847df@kunbus.com>
Date:   Fri, 9 Jun 2023 18:03:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2] tpm,tpm_tis: Handle interrupt storm
Content-Language: en-US
To:     Jarkko Sakkinen <jarkko@kernel.org>,
        Lino Sanfilippo <LinoSanfilippo@gmx.de>, peterhuewe@gmx.de,
        jgg@ziepe.ca
Cc:     jsnitsel@redhat.com, hdegoede@redhat.com, oe-lkp@lists.linux.dev,
        lkp@intel.com, peter.ujfalusi@linux.intel.com,
        peterz@infradead.org, linux@mniewoehner.de,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        lukas@wunner.de, p.rosenberger@kunbus.com,
        kernel test robot <yujie.liu@intel.com>
References: <20230530174712.6989-1-LinoSanfilippo@gmx.de>
 <CT86Z65L4O9A.2FIOFZUI6BVB4@suppilovahvero>
From:   Lino Sanfilippo <l.sanfilippo@kunbus.com>
In-Reply-To: <CT86Z65L4O9A.2FIOFZUI6BVB4@suppilovahvero>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0134.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:97::18) To VI1P193MB0413.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:803:4e::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1P193MB0413:EE_|GV1P193MB2055:EE_
X-MS-Office365-Filtering-Correlation-Id: fe9db4b5-a598-4ea1-187e-08db69030da3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PVdiOd6w6YG/cU8qX6+TCnX0o6rFdsI8AW/7DvIo4weLyPEv/jDb/K8g6yQL9W4mp4aQGHZNhT0iHvF2F5oFLVDdTyc9Nf6JZYvlcgdC2mAbm0P/9osbvh3+EBZeVbcTBSIjZHVWeowSYN1lArOtm7hMbr9vFZXqyHV7svrfRwq9+3mIlpElTorNMRdxu92xncLuuxUHft17CVdVqdUDz4ROXmR854fVcuohOT9e6yFAAoyOicXdK9P/tfq3Vq6JG+lelcBW3ZKgVicYTUtkdI1sKdzA+ruzBtAB8CMXhYjdLkdZCufH8CdL8IYbDwqIRokuceRiCvkSQ0I97n37gRau1TJh6tJSnG+pxvVu7hhC9OhXaMR0iufeUzFAKXLb8N0ejokOG4SEhLBY7bt2A9/9LZSwifiMgUHERcFdcNGn6LoZ0FSD7BJUNEghplbqnXtGzGLoiQ0Ra5gEyM6U5OX0SGS4owzpT4fXt8CrjBnE03QsofE8c3vCz2+zl9TObakAWD1RXz4HjAEQDx1oc9MU6Bh56wAM4h5oFK5TsS3AYNWB5n1zZHUNda6NRNyO415eyH/Q3sCem/Pb/3h99PRD2QKmvEjxfvN45MTdlGzBEuBZOGLFI4+2P5e6wlI/i5RoCSMYt8P2YXUk9JWuiw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1P193MB0413.EURP193.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(396003)(366004)(39840400004)(376002)(451199021)(31686004)(2906002)(7416002)(8676002)(8936002)(5660300002)(41300700001)(4326008)(316002)(66476007)(66556008)(66946007)(110136005)(6666004)(478600001)(6486002)(52116002)(6506007)(6512007)(966005)(53546011)(38100700002)(83380400001)(31696002)(86362001)(186003)(2616005)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NVN2Z1pVTGVUTTVoaWxsdzI0VjNZVHNkSEVVejh3N24raW9JT212TjVicW1n?=
 =?utf-8?B?NFN3VVF3S3d5bXVIZG40T1VFaXExTXRRK3l5NEE2dWZ6K2RMMTVKb0RENTR3?=
 =?utf-8?B?M2IyVVdyNTYrYzBaUHJsUmRFNVZuSkZZeVN3VE9SMk9uQ2RxTzZsWE84b2Q0?=
 =?utf-8?B?MXRvem84U3VEanFOMENCRWxTUDUybDFaeXBUbGM1bVA4WTBwcUZKT3QyWDR6?=
 =?utf-8?B?RDVFdjN1UWlkaERwNnVvTDJLL2F2RlczRFR4U0NqaUxHQ2VVQWNQTTdkdDIr?=
 =?utf-8?B?VHJqcWtvTE5Kdi93eGNPUVUxSk01bHJGMFNvcWFIQWU4ZFg4WGlsTmMwRHNl?=
 =?utf-8?B?Y0tpSTIxM1l2N0NTK254NHFjRElBU3FQRnlHYzN0MStWTm4vZVZQT2xGckpi?=
 =?utf-8?B?VC9kaXhFdGxDSWhqNUpYLzNRMGpFYXdXTHJRZ0Y4dVd0QW5LcEp6OTBnMHRW?=
 =?utf-8?B?UzZ1S1RSMmNXcWJxRnhlZ05LTVhjdjZFWmJFbGNjc09TOEdiVWM3RE0yd3Jl?=
 =?utf-8?B?VExidGZTM01mWm9aMWNybGUrUFl4THhiT1hZR0p2dVZOTVJQRzA1aW5Ta3Jq?=
 =?utf-8?B?eHYxajFqU3Vja25rRk1neDhqcWVDRys4UWszUlR3Q3VrQVFtcVU1azlZWGxJ?=
 =?utf-8?B?UkVCVnNlcUNMN0FpRTltV3RzMk1BdmpiUDJPb0V2YU5SY1lENXJtY1pDeFNH?=
 =?utf-8?B?MWg3SWFwOXNWeWxRR1lDZ0RZWUxOQXVoQ2hpVzRTUU4zTzFzRVpCb1RjUGpt?=
 =?utf-8?B?ckd1OVpuNVR5RHZHays0QUR1MXpVL01TcVdyOHZjZkdCcTMrVW0yMFkvV2c3?=
 =?utf-8?B?elRDbkNnWWxyVm5aYkZJeXo2dEEwQ3NSRGQrYklHNmovQzNOMVl6SVJQc2Fq?=
 =?utf-8?B?MGovU1dzY3JVMlo5ZThrdDhud0k4TzdjaGZQa2ZSWld1UmtscDRnN1E4M3VB?=
 =?utf-8?B?RDFhajhvdGd3Mzh2VWE1eEFzNEU1azVxSFRwVjR1LzNDdGVrR051ZFVxRk1D?=
 =?utf-8?B?a3hYQkZCaUszL0pYalBCUHhkYjFLakZtaXY4cTNQZU1aL21kb2krMHM0dVJM?=
 =?utf-8?B?bjNtZ21MeGRFM3kyME94NmpvTncvNUZ3UUZDRi9lQTJReTdsSHRtSE5UR25G?=
 =?utf-8?B?UmxRd0tHOFRYeHBHaEVvWWMya1BMcmJCb1MzQkk2eXFWRi9pN2Y5dkJNQ3Nt?=
 =?utf-8?B?VysvRjdWbENMSUNGSmt5WWg5d09KcUpucGcxNGVqVG5VOWdtT2ZsR05RZFY0?=
 =?utf-8?B?YTE3YmhpMXJYaTNBVkZLWkpZT3VxSHovL3JYUzc5TVNEZFpoRTFSR1JJMVJX?=
 =?utf-8?B?Z28rRjhhWlluN3BpaUNhZWxHU1NiVlpTUFREbDNDR2RBVEp0Zk5RL09aaGIr?=
 =?utf-8?B?M3pRUWExcTBLd3NFMGR6ODJ4WnR2ZUVtV05sdGlDWTByS2dUVno2VEFGTEFp?=
 =?utf-8?B?S2RzcDF4dlBwcVdGTklTNElSQVBFZE5KaGVmUENSdE5yZE9ZclZwWTY0cVlF?=
 =?utf-8?B?ZXFCaVRxeGVxYzlxMjRac21ZTWFWSzRTcWZERHdLY3ovcHB4c3FocUI2VlJM?=
 =?utf-8?B?c0txMVdKcVR6Ri9YcS9ZRlh5WTRtZDJxQ0EwWFQvT0J6TlBRb2hqcFFxTDJi?=
 =?utf-8?B?bzZqa2lSOWtYVWhNMlMybm92TkRoclhiL2xQa3I3TjZVSnB0T1RUWHo5VEhX?=
 =?utf-8?B?b25CZUZ3ZDBmUys2bkpuOEFhZWdPbDYrT0M2bXNUZnhBcklyd3hFTEdLWmFj?=
 =?utf-8?B?TUdoTmNrcURSRUlod0J5UWdkUlVBTTYyNTBkd1NRa0lsbVo4bmlUbG5Ddk92?=
 =?utf-8?B?c0VSMmhiZ3h0ZElYNi80eW9mTWdjRElpVEVTZ3hZcDlZa1RPd1ozN1kvMkJT?=
 =?utf-8?B?L09WbENFSWpJYm9URWY5QVhITWlVek1MZkVDem0vNG1tQmNQaG1BSDV4cDJ2?=
 =?utf-8?B?bDFsdzJFNFNkejh3ZVB0U1FUVW5kQVUwQk9yeFdvZDlVTThmdU5CQ3ZvRGlW?=
 =?utf-8?B?c05XczZmd0RUaGdjZ2JzSGw2TDlRMXlaMUEzMU10RjdESnFwOGFJRm5SRXI3?=
 =?utf-8?B?dkIvcXBjOWxFclhnZ1FqVHp1T3cxL20rN3VMVUtrZUtiWmRkSlQyQjNyVFlh?=
 =?utf-8?B?aVRza2NQblRZMENiWmJvQlo1MVgyeFc1S1Q2ZGNXQnhhZFZSWXNHS21TZFVZ?=
 =?utf-8?B?T3MzMDZMZDh6ZVJSejNYc0o1Nis1RUQrd2RRSndYQTJ4Nm5TbzQreFhMM3gw?=
 =?utf-8?B?Qk5yUXVwa1lkTDMzdFlKTFFhdktnPT0=?=
X-OriginatorOrg: kunbus.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe9db4b5-a598-4ea1-187e-08db69030da3
X-MS-Exchange-CrossTenant-AuthSource: VI1P193MB0413.EURP193.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2023 16:03:23.9471
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: aaa4d814-e659-4b0a-9698-1c671f11520b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EdePdS0anbW2gOhFLNZMnTcL0AsYxFIYDJYJXACffIOwyinPikVLdfO5ReANcy/p2vAR1apS7huV162JkiWP7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1P193MB2055
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


Hi,

On 09.06.23 16:33, Jarkko Sakkinen wrote:

> 
> On Tue May 30, 2023 at 8:47 PM EEST, Lino Sanfilippo wrote:
>> From: Lino Sanfilippo <l.sanfilippo@kunbus.com>
>>
>> After activation of interrupts for TPM TIS drivers 0-day reports an
>> interrupt storm on an Inspur NF5180M6/NF5180M6 server.
>>
>> Fix this by detecting the storm and falling back to polling:
>> Count the number of unhandled interrupts within a 10 ms time interval. In
>> case that more than 1000 were unhandled deactivate interrupts entirely,
>> deregister the handler and use polling instead.
>>
>> The storm detection logic equals the implementation in note_interrupt()
>> which uses timestamps and counters stored in struct irq_desc. Since this
>> structure is private to the generic interrupt core the TPM TIS core uses
>> its own timestamps and counters. Furthermore the TPM interrupt handler
>> always returns IRQ_HANDLED to prevent the generic interrupt core from
>> processing the interrupt storm.
>>
>> Since the interrupt deregistration function devm_free_irq() waits for all
>> interrupt handlers to finish, only trigger a worker in the interrupt
>> handler and do the unregistration in the worker to avoid a deadlock.
>>
>> Reported-by: kernel test robot <yujie.liu@intel.com>
>> Closes: https://lore.kernel.org/oe-lkp/202305041325.ae8b0c43-yujie.liu@intel.com/
>> Suggested-by: Lukas Wunner <lukas@wunner.de>
>> Signed-off-by: Lino Sanfilippo <l.sanfilippo@kunbus.com>
>> ---
> 
> Sorry for the latency. I've moved home office to a new location,
> which has caused ~2 week lag. Unfortunate timing.
> 


No prob :)


>>  drivers/char/tpm/tpm_tis_core.c | 93 ++++++++++++++++++++++++++++-----
>>  drivers/char/tpm/tpm_tis_core.h |  4 ++
>>  2 files changed, 85 insertions(+), 12 deletions(-)
>>
>> diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_core.c
>> index 558144fa707a..7ae8228e803f 100644
>> --- a/drivers/char/tpm/tpm_tis_core.c
>> +++ b/drivers/char/tpm/tpm_tis_core.c
>> @@ -468,25 +468,32 @@ static int tpm_tis_send_data(struct tpm_chip *chip, const u8 *buf, size_t len)
>>       return rc;
>>  }
>>
>> +static void __tpm_tis_disable_interrupts(struct tpm_chip *chip)
>> +{
>> +     struct tpm_tis_data *priv = dev_get_drvdata(&chip->dev);
>> +     u32 intmask = 0;
>> +
>> +     tpm_tis_read32(priv, TPM_INT_ENABLE(priv->locality), &intmask);
>> +     intmask &= ~TPM_GLOBAL_INT_ENABLE;
>> +
>> +     tpm_tis_request_locality(chip, 0);
>> +     tpm_tis_write32(priv, TPM_INT_ENABLE(priv->locality), intmask);
>> +     tpm_tis_relinquish_locality(chip, 0);
>> +
>> +     chip->flags &= ~TPM_CHIP_FLAG_IRQ;
>> +}
>> +
>>  static void disable_interrupts(struct tpm_chip *chip)
> 
> Add tpm_ prefix here too. It makes tracing/grepping/etc so much nicer.

Ok.

> 
>>  {
>>       struct tpm_tis_data *priv = dev_get_drvdata(&chip->dev);
>> -     u32 intmask;
> 
> int_mask is more readable

Ok.

> 
>> -     int rc;
>>
>>       if (priv->irq == 0)
>>               return;
>>
>> -     rc = tpm_tis_read32(priv, TPM_INT_ENABLE(priv->locality), &intmask);
>> -     if (rc < 0)
>> -             intmask = 0;
>> -
>> -     intmask &= ~TPM_GLOBAL_INT_ENABLE;
>> -     rc = tpm_tis_write32(priv, TPM_INT_ENABLE(priv->locality), intmask);
>> +     __tpm_tis_disable_interrupts(chip);
>>
>>       devm_free_irq(chip->dev.parent, priv->irq, chip);
>>       priv->irq = 0;
>> -     chip->flags &= ~TPM_CHIP_FLAG_IRQ;
>>  }
>>
>>  /*
>> @@ -752,6 +759,53 @@ static bool tpm_tis_req_canceled(struct tpm_chip *chip, u8 status)
>>       return status == TPM_STS_COMMAND_READY;
>>  }
>>
>> +static void tpm_tis_reenable_polling(struct tpm_chip *chip)
>> +{
>> +     struct tpm_tis_data *priv = dev_get_drvdata(&chip->dev);
>> +
>> +     dev_warn(&chip->dev, FW_BUG
>> +              "TPM interrupt storm detected, polling instead\n");
>> +
>> +     __tpm_tis_disable_interrupts(chip);
>> +
>> +     /*
>> +      * devm_free_irq() must not be called from within the interrupt handler,
>> +      * since this function waits for running handlers to finish and thus it
>> +      * would deadlock. Instead trigger a worker that takes care of the
>> +      * unregistration.
>> +      */
>> +     schedule_work(&priv->free_irq_work);
>> +}
>> +
>> +static irqreturn_t tpm_tis_check_for_interrupt_storm(struct tpm_chip *chip)
>> +{
>> +     struct tpm_tis_data *priv = dev_get_drvdata(&chip->dev);
>> +     const unsigned int MAX_UNHANDLED_IRQS = 1000;
> 
> Please declare this in the beginning of file because it is non-empirical
> tuning parameter. I do not want it to be buried here. It is now as good
> as a magic number.
> 
> Or perhaps even tpm_tis_core.h?
> 

For now that constant is only used in tpm_tis_core.c. So I would favor to define it there.

> Why MAX_UNHANDLED_IRQS is exactly 1000 and not 1? I would rollback eagerly.


Because the IRQ line may be shared with another device which has raised the
interrupt instead of the TPM. So unhandled interrupts may be legit.

Regards,
Lino




