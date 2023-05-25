Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EBAE711ACB
	for <lists+linux-integrity@lfdr.de>; Fri, 26 May 2023 01:45:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233074AbjEYXpc (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 25 May 2023 19:45:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbjEYXpa (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 25 May 2023 19:45:30 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2080.outbound.protection.outlook.com [40.107.6.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7DD012F;
        Thu, 25 May 2023 16:45:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iiN8LGS13Z47wo7Job8g/tcP71bcCqjdww2rcTt7W+G8XzMmqW1LxoBdSFHNaUwQr3Edwrt/vl3xTxN0pbZ0mcWT4NRt1S0DJxIBNcuJccG82fU4uOQY5loyJoW0Mm+M3M8slKwfaA0GDVH3r9O464TRT9E1ZC7RxXgYKBD/7ML02Pa1rHRg4wQdp+QijFbmABfg65O9v2PcsHTJEcMsqIJejEfJaNwqzsUfs01E8kXfyTGcnfSYIUNg7mSKsgLmx9iCW+fNYJvNFiHZZvIk/45tEntoHwW+2tEI8rxn2euqmS03MtM1YkGl6AUktA7mxByW/kNe2WXY1wPNsRWH7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/RWhauo1qmwWMi3s0Z/OtOnB2SD9paSgbZZghwCqtgw=;
 b=KRz7gImMqDsDJH4wJpwhWriigndVuBdLNILcGDlPbyjvbYAiC6l5XoUysT9GJetVuaLqkAQetPLF9+VgLdok1QPp8uHA9nE+hX7OU8PRw76WihNcrxjti4vXypR24/Zbef6o+kiZwhWO0DMuxC3/p87TAAZ5mS+hwkkjda2KNyu6YEns+2nzPSUIE4SVphVgcKWSKc49dFUuIyJm81QRUixKUirMTSbBH/G7F3LHsgKACUf/Wp+HmeZsSJBKtpJHeI2lOLx53W4FziNf0N0TrgyapjrAg9zTPZ8/tK0f4uspZwfHn1Iz4N2AAQLOlgBurS3Rjuc4cohro8xSmw6IjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kunbus.com; dmarc=pass action=none header.from=kunbus.com;
 dkim=pass header.d=kunbus.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kunbus.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/RWhauo1qmwWMi3s0Z/OtOnB2SD9paSgbZZghwCqtgw=;
 b=O+qe7CKTOi44VCfMSBedKPLZD65xjSO0THBgyVnbh9WK5S2ngQhQJwtwkJNM6H/PRbuiX/z+ewKN9XHcz/6x0oqLEn9XxT/SElDLjshkoASkGYHSzSRGmlFe2BndYqPU97GAtt5rJpgqvYq9ayg0pnoVUH1rE0RS+fit++7IXGg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kunbus.com;
Received: from VI1P193MB0413.EURP193.PROD.OUTLOOK.COM (2603:10a6:803:4e::14)
 by DU2P193MB2209.EURP193.PROD.OUTLOOK.COM (2603:10a6:10:2f9::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.12; Thu, 25 May
 2023 23:45:25 +0000
Received: from VI1P193MB0413.EURP193.PROD.OUTLOOK.COM
 ([fe80::6727:e3fb:8fec:72a6]) by VI1P193MB0413.EURP193.PROD.OUTLOOK.COM
 ([fe80::6727:e3fb:8fec:72a6%7]) with mapi id 15.20.6433.015; Thu, 25 May 2023
 23:45:25 +0000
Message-ID: <3d8e6d4e-9434-19d0-6307-c67fe9cfa867@kunbus.com>
Date:   Fri, 26 May 2023 01:45:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 1/2] tpm, tpm_tis: Handle interrupt storm
Content-Language: en-US
To:     Jarkko Sakkinen <jarkko@kernel.org>,
        Lino Sanfilippo <LinoSanfilippo@gmx.de>, peterhuewe@gmx.de,
        jgg@ziepe.ca
Cc:     jsnitsel@redhat.com, hdegoede@redhat.com, oe-lkp@lists.linux.dev,
        lkp@intel.com, peter.ujfalusi@linux.intel.com,
        peterz@infradead.org, linux@mniewoehner.de,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        lukas@wunner.de, p.rosenberger@kunbus.com
References: <20230522143105.8617-1-LinoSanfilippo@gmx.de>
 <CSU7G2UZSZ8K.22EGXU5CJTZBB@suppilovahvero>
From:   Lino Sanfilippo <l.sanfilippo@kunbus.com>
In-Reply-To: <CSU7G2UZSZ8K.22EGXU5CJTZBB@suppilovahvero>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0008.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1d::14) To VI1P193MB0413.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:803:4e::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1P193MB0413:EE_|DU2P193MB2209:EE_
X-MS-Office365-Filtering-Correlation-Id: c8a8b7a9-1cdf-402c-b21b-08db5d7a1cb3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: M0ZkKzvrqIkU9GQ1n+fZQWXFcGvYGRiYdn6Pd1MgAMpVMMVE47MIkZnZBcTwgU4cse90vTlQejmRDj9UW5+7c/4w1OG9kacpJ/9oSuLFB4+rtto/vq7ftgExSATU0wja1IgMYMRUgNY5x6OzQKIqcDN47aW2RJJ++0/jZ8RHELBJd6p/uGE4/+/+ZMdaX6KIuL6WSfRD/NXPjXYjEA+WV+x3BpQZqdlbfUhkMQtVZ2Tu3Uk6SmI25gD5BDEgDUm3S2rSgYQg2OJG0XQRSfy3/6qxAAdb4z5aAZ2uiUZhaLIyCI19VyTm2rBDj8CdYUNRP0Ibq1e5/cvw/9eEUy19qiK2y1tOLqCRrAxh1abOZAOJxHA1+t33Y0CZFIFQh08lduwm5Drd56bVh8CNAO7qW+S/Y6E8uDkkWhbBY/shH8JD/dajhwdV7h3ssx5yEiWHAwbRLyJewG9jhfdNwNhLEffrQTck7jYp3wS14ZTQsPxvT/B4Gz8MJ5h4PemD/fVX/X+3WhnSGyHUl252yyp4jvEKk1bLg0LoR7ATJ/nULfV9mQskBQf7giFgVrkHKiMhYwnhtCv1BLHgH1sXtR1ICt8E1Os+D+4ze14GzqWEbCFvVHTnzfkXCuD09WjEzImyTZcMh4VWP3CEUjYRNt+2Jw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1P193MB0413.EURP193.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39830400003)(396003)(376002)(346002)(136003)(366004)(451199021)(31686004)(110136005)(186003)(86362001)(83380400001)(31696002)(478600001)(2616005)(2906002)(107886003)(66899021)(66476007)(66946007)(36756003)(966005)(4326008)(66556008)(316002)(6506007)(6512007)(7416002)(53546011)(52116002)(6486002)(5660300002)(8676002)(8936002)(41300700001)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a3hQejJEVVBuY0NuL1g3NnlaQmUvU2kzMSs3L2dTQjdQQlhRcGFJMnBsdHA0?=
 =?utf-8?B?QXhpUEd4VTZUQVRpYnlhVTBMWjZlTWwwMGpnZnNUSWQyMCtBK3hUbG00SVJV?=
 =?utf-8?B?bUt4SldDNzFtZ051RDN4R21ZYkVZdncxUENRcG5JbERhQitoNitvVTBnVDJw?=
 =?utf-8?B?akZMWXNxRXpoT0txOXdKNGFxa1dLZHVQUjU4c0cxaXg0UmdGblNOTm1UTHYz?=
 =?utf-8?B?Q3UrV3gvNjVwTFliSFRGT3FYbW01dWphU0orSi9JZnFjdURrTXExL1h1VERW?=
 =?utf-8?B?RWtvRCtndVNPV0hJdVd3VTBtVEhIZFBaaHUzZ2ZvMGFZc0Z2ZTI4REVDYUVr?=
 =?utf-8?B?S0tiMFJCSEI0Z1pxeFdMMFhmaDg1TUpuM2tUd1IrcWpOWnUyL1Qrc05IRjZU?=
 =?utf-8?B?QVVnYldUdXdINEdKVDZtYXFtZWRYbEovSTkzeWQrVmVMcUNKcys5YVo1TW1S?=
 =?utf-8?B?SmkrKzZ6R1ZmbzdFK2dHUDJWMkpJZ1FGTXQwNFNiN29DN0lkcytMUVU4QlUr?=
 =?utf-8?B?N1pZRUg2Z2lqNUNVdVd2Mmx6UjBuMWdTVk5vMTMrMTZ3SkNpanZYWFdycTIz?=
 =?utf-8?B?N0N2UHZqME1wUjltZjFWOWdEMFVlMktDekF4b1FzbC9pUDRQYTUxSE5LTDBR?=
 =?utf-8?B?bElydklWTDN0ai92UG84RW5sWEdnNm5JMEQzQ3FHRS92TFFFbmRYU1RZRXFE?=
 =?utf-8?B?cDUrMW95R2U1eVJmSWZGOU9DVmVsbGs4VFNoYUpNM25vUlpzaUh0endrUWRj?=
 =?utf-8?B?UEJWU0IyelZqUURNVVdIaStWV3ZjdFVXWnZ6VEFwbHpsOEpvSDZOVkJ6d3lH?=
 =?utf-8?B?eFRzcnFOODhTTTJlUlRZNVcxd3dLcVlwNlZhMDgrenBDLytmeStrdHE4amtC?=
 =?utf-8?B?UUpyY1V5NmRicHZUUmZCNE1ldjhOUVg0L24rQ3JGN0pEeVZ5amI0OFJCUWFT?=
 =?utf-8?B?N0dIK3JmZlFIbFlEc3hDZXJFbmFPR3QvRy8wQ3pVY2x6TFlaVTZLdjBhVmZR?=
 =?utf-8?B?RVA5OTlNNWZyRzAxOVVSVW5OUUVaM0YwaHhlM1NNMllFNFgwNVVaK0pkTTB6?=
 =?utf-8?B?dnBtZ3k2OU1wRjJ1em1PR1F2UkxnYmsvb3NsQkV1R3hvSk1TQlRaWlRrc2tD?=
 =?utf-8?B?TkMzZjU0eHpDK3k5eHZUU2JSbTgveTJESGhhL1RuVzIvOGJrNVViQzlsZEpN?=
 =?utf-8?B?RFRacXhKbVdnSWR1WkJFbmkySGFZeDR4NWZlRTJjemFUbW5Uc1VuZ1FZd09I?=
 =?utf-8?B?R3BpaUt1WVRRNXhlOEREbkRTZ3dWQlJzdGpRdjBhZGo5YWI1alo4VXZPRE0w?=
 =?utf-8?B?TjNxTWpMRzdVSXh3VWtlOVpMU2Y3OEdJcll3M3RJT0hpTTQwVGxyZGd1RGgw?=
 =?utf-8?B?eVJyc0RrWjlrYU95cWNVaGgxSUFhdXZRYXk1S3VQcnlyT0NaQUVhTWlJd3By?=
 =?utf-8?B?T05jUmVZSUdFWm16Y3MzdnRINXpsNDhReFFGbTRxeHlIY3pWNDYwN1pWc25X?=
 =?utf-8?B?NFRHN2djRm1ycGwyOG81YWJWS1JOUFdDeStKblhDZzN1ZnI5OHlJSHZVQi82?=
 =?utf-8?B?WGdOdldSTnVaeVhyTkFoNHpQSjJIOVg2NEFneHZGbHYvaDNSTjJHeUdKcHRT?=
 =?utf-8?B?bjdrV2x4bDZsUXgzSG5XbmY2cmN0VWNUdTkwU1hLM01MQmk3R0ZSejBTU2Y2?=
 =?utf-8?B?djl3ZXFPdk1vckkzTGhsdnA0WmNIRHZIcUpTYVJYUWZCMFlGeGFkM3BlQXNw?=
 =?utf-8?B?VTBVS0d1WERpdERGQUVFeC8zUUtUY3BTNU9HNWw4TStlTFlvQWIzdVFFK2M5?=
 =?utf-8?B?K01ONkl1bE1qazlqaVZZUUJYbEMzQTVwbFBFRmxsamYvOEh2VzRsU2JFUGtr?=
 =?utf-8?B?blQxdU5XbFV2eDhXZkh0ajI5WWdCZHFMWGtPdWVjdUZucjE5Z25iOUtaSm91?=
 =?utf-8?B?bHkyMS9kaUVhSWd6WWJxZjR6QlM3YTdEWmprYVVMK3RodlNhUitjbnczZnZ0?=
 =?utf-8?B?WWFXRHF1YzZkbGRGSnJFZHQvZTM0Z2tyMXlidTVMeGFTRTZ2MU5uZml0WU0w?=
 =?utf-8?B?STRhM3dFenZkYmMxTWJXK0M0OWNCOENRc2FXckVsQlltRzg4WFdyMGE1WE8x?=
 =?utf-8?B?RXNqRFRNY01kWkFOQ1JHSFArbzFnWnZNMFFIK3c3OWpWQzNkbjJyZ1VsQlpV?=
 =?utf-8?B?NVoyUFV3S3c1NkpCRzd1TUNNd1hLWW1uSHRidXZvbVhCWXphRitVWHpYa2lO?=
 =?utf-8?B?QzRDTGVId2xOcVh4TUM5Q1dVZ3JBPT0=?=
X-OriginatorOrg: kunbus.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8a8b7a9-1cdf-402c-b21b-08db5d7a1cb3
X-MS-Exchange-CrossTenant-AuthSource: VI1P193MB0413.EURP193.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2023 23:45:25.4207
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: aaa4d814-e659-4b0a-9698-1c671f11520b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GaFPZnViDVFQ3EryJY0Ny7ab2J5qL7b5iMB+Niwu170hJtsX1TZuLWajA4DNu+9EPg47OeJ3Wwpka+s5h00g0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2P193MB2209
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

On 24.05.23 05:58, Jarkko Sakkinen wrote:

>> Commit e644b2f498d2 ("tpm, tpm_tis: Enable interrupt test") enabled
>> interrupts instead of polling on all capable TPMs. Unfortunately, on some
>> products the interrupt line is either never asserted or never deasserted.
> 
> Use Reported-by and Closes tag and remove this paragraph.
> 
> In Closes link instead from lore the email where the bug was reported.

Ok

> 
>> The former causes interrupt timeouts and is detected by
>> tpm_tis_core_init(). The latter results in interrupt storms.
> 
> Please describe instead the system where the bug was realized. Don't
> worry about speculative descriptions. We only deal with ones actually
> realized.
> 
>> Recent reports concern the Lenovo ThinkStation P360 Tiny, Lenovo ThinkPad
>> L490 and Inspur NF5180M6:
>>
>> https://lore.kernel.org/linux-integrity/20230511005403.24689-1-jsnitsel@redhat.com/
>> https://lore.kernel.org/linux-integrity/d80b180a569a9f068d3a2614f062cfa3a78af5a6.camel@kernel.org/
> 
> Please remove all of this, as the fixes have been handled. Let's keep
> the commit message focused.
> 

Ok.

>> The current approach to avoid those storms is to disable interrupts by
>> adding a DMI quirk for the concerned device.
>>
>> However this is a maintenance burden in the long run, so use a generic
>> approach:
>>
>> Detect an interrupt storm by counting the number of unhandled interrupts
>> within a 10 ms time interval. In case that more than 1000 were unhandled
>> deactivate interrupts, deregister the handler and fall back to polling.
>>
>> This equals the implementation that handles interrupt storms in
>> note_interrupt() by means of timestamps and counters in struct irq_desc.
>> However the function to access this structure is private so the logic has
>> to be reimplemented in the TPM TIS core.
> 
> I only now found out that this is based on kernel/irq/spurious.c code
> partly. Why this was unmentioned?
> 
> That would make this already more legitimate because it is based
> on field tested metrics.
>> Then we only have to discuss about counter.

I mentioned this in one of my responses:
https://lore.kernel.org/all/da435e0d-5f22-fac7-bc10-96a0fd4c6d54@kunbus.com/

> 
>> routine trigger a worker thread that executes the unregistration.
>>
>> Suggested-by: Lukas Wunner <lukas@wunner.de>
>> Signed-off-by: Lino Sanfilippo <l.sanfilippo@kunbus.com>
>> ---
>>  drivers/char/tpm/tpm_tis_core.c | 71 +++++++++++++++++++++++++++++++--
>>  drivers/char/tpm/tpm_tis_core.h |  6 +++
>>  2 files changed, 74 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_core.c
>> index 558144fa707a..458ebf8c2f16 100644
>> --- a/drivers/char/tpm/tpm_tis_core.c
>> +++ b/drivers/char/tpm/tpm_tis_core.c
>> @@ -752,6 +752,55 @@ static bool tpm_tis_req_canceled(struct tpm_chip *chip, u8 status)
>>       return status == TPM_STS_COMMAND_READY;
>>  }
>>
>> +static void tpm_tis_handle_irq_storm(struct tpm_chip *chip)
>> +{
>> +     struct tpm_tis_data *priv = dev_get_drvdata(&chip->dev);
>> +     int intmask = 0;
>> +
>> +     dev_err(&chip->dev, HW_ERR
>> +             "TPM interrupt storm detected, polling instead\n");
> 
> Degrading this to warn is fine because it is legit behaviour in a
> sense.
> 

Agreed.

>> +
>> +     tpm_tis_read32(priv, TPM_INT_ENABLE(priv->locality), &intmask);
>> +
>> +     intmask &= ~TPM_GLOBAL_INT_ENABLE;
>> +
>> +     tpm_tis_request_locality(chip, 0);
>> +     tpm_tis_write32(priv, TPM_INT_ENABLE(priv->locality), intmask);
>> +     tpm_tis_relinquish_locality(chip, 0);
>> +
>> +     chip->flags &= ~TPM_CHIP_FLAG_IRQ;
>> +
>> +     /*
>> +      * We must not call devm_free_irq() from within the interrupt handler,
> 
> Never use "we" form. Always use either:
> 
> 1. Imperative
> 2. Passive
> 
> I.e. to address this, you would write instead "devm_free_irq() must not
> be called within the interrupt handler because ...".
> 

Ok.

>> +      * since this function waits for running interrupt handlers to finish
>> +      * and thus it would deadlock. Instead trigger a worker that does the
>> +      * unregistration.
>> +      */
>> +     schedule_work(&priv->free_irq_work);
>> +}
>> +
>> +static void tpm_tis_process_unhandled_interrupt(struct tpm_chip *chip)
>> +{
>> +     const unsigned int MAX_UNHANDLED_IRQS = 1000;
>> +     struct tpm_tis_data *priv = dev_get_drvdata(&chip->dev);
> 
> Reverse order and add empty line.
> 

Ok.

>> +     /*
>> +      * The worker to free the TPM interrupt (free_irq_work) may already
>> +      * be scheduled, so make sure it is not scheduled again.
>> +      */
>> +     if (!(chip->flags & TPM_CHIP_FLAG_IRQ))
>> +             return;
>> +
>> +     if (time_after(jiffies, priv->last_unhandled_irq + HZ/10))
>> +             priv->unhandled_irqs = 1;
>> +     else
>> +             priv->unhandled_irqs++;
>> +
>> +     priv->last_unhandled_irq = jiffies;
>> +
>> +     if (priv->unhandled_irqs > MAX_UNHANDLED_IRQS)
>> +             tpm_tis_handle_irq_storm(chip);
> 
> Why wouldn't we switch to polling mode even when there is a single
> unhandled IRQ?
> 

As Lukas wrote, not handling an interrupt may be legit if it was raised
by a device that shares the interrupt line with the TPM.

Regards,
Lino
