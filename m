Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95454711B5E
	for <lists+linux-integrity@lfdr.de>; Fri, 26 May 2023 02:37:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241012AbjEZAhl (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 25 May 2023 20:37:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229885AbjEZAhi (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 25 May 2023 20:37:38 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2064.outbound.protection.outlook.com [40.107.22.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B7C8EE;
        Thu, 25 May 2023 17:37:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KrgKQxf0QsxyHDgJROaDO9ZM8FmScLIXwhrF677hBukyYOadhMECt487XLzhNX1aLo95rM7xd39ArDgdi5VMnJze/S1paB6MG1fJ6ziaHMfETmZeOSjeUt+fsnljZ7QBfpwpKXoq6mW5Y5faoO0MH0dJyIFSiZluXltA5QYFojTigVemONTdWYWtxql+sRvGO9n90HN2ih9vQL1pMTDkVwzRoc57XxREapBCMtS8SuqNLhqhVSA3BXbg5zD1bfa0Pcs1UXvKk5eY6EZX+metErxMkZ/5AHv9M5Sp0Pr7Al1sDG8knXvme7IYgTYZA5KPaVtXJxhuUGWGOKEJ+9KC1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RKR3JqfKtoIwnBtYJWMLdRQks2VRgVvW6/Ixkqi6Al4=;
 b=Aaip/5BmNVp/p2kWmcCnCu4UIXRfu0GYxyemwA0H6pdWbXSpkABBbo/r6uZ0QSod4FgtdSNqO/Bn0WwmERTignMja0lh3carM/h0/7p8AXyOrFnEBj1HWu5ZLl1HOZuAthbtNiRqubTJf4ND973WtcK+L1e9EaudIM+LLsrqa0PQOLfpqdcL4LpgoEma6ITCrE45mulQsXKIwEZquON7C9dlNSboQ33YRz8sgWaDj+kMoq5tDWYZQl3dUIbrQqTSzvY7pRP5yZjKUbnCIk/SD1Iqfq/XGUsRIlVYbikIysFdV8ovuNrfYar9TE6PXVoT6y727qN8l4gHLFNBA1OcaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kunbus.com; dmarc=pass action=none header.from=kunbus.com;
 dkim=pass header.d=kunbus.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kunbus.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RKR3JqfKtoIwnBtYJWMLdRQks2VRgVvW6/Ixkqi6Al4=;
 b=MMKWEIiXDSEC93sQvOm6yY0C38mLAg6nAX23SdKm5Z3ZisOgmcdHebq0MfWIPYjnmh3B85XUP8GcRupWXpihhgdFog61fnSGwruFAtRIBrFYm5PsemPwJzfeQdYvYkoFJcI7CTbfA7318iJZYEvH6KsuGao2LtnRwvK/v4PQKjw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kunbus.com;
Received: from VI1P193MB0413.EURP193.PROD.OUTLOOK.COM (2603:10a6:803:4e::14)
 by PAXP193MB2059.EURP193.PROD.OUTLOOK.COM (2603:10a6:102:223::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.15; Fri, 26 May
 2023 00:37:32 +0000
Received: from VI1P193MB0413.EURP193.PROD.OUTLOOK.COM
 ([fe80::6727:e3fb:8fec:72a6]) by VI1P193MB0413.EURP193.PROD.OUTLOOK.COM
 ([fe80::6727:e3fb:8fec:72a6%7]) with mapi id 15.20.6433.015; Fri, 26 May 2023
 00:37:32 +0000
Message-ID: <b2c597c1-e596-55d9-1c1d-aec36ec30744@kunbus.com>
Date:   Fri, 26 May 2023 02:37:30 +0200
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
 <CSUM65JDEX5D.8GL20PUI2XDV@suppilovahvero>
From:   Lino Sanfilippo <l.sanfilippo@kunbus.com>
In-Reply-To: <CSUM65JDEX5D.8GL20PUI2XDV@suppilovahvero>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0113.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a3::12) To VI1P193MB0413.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:803:4e::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1P193MB0413:EE_|PAXP193MB2059:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ba82681-df81-4187-c167-08db5d816489
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: o40gjJrpl/5OCMv2sOzze9XklhE4myJ0E2St3wJYApLqb2JhVErdf4APmK7cmR19xYSX0GSh9nt0TCnaxY3w1L/5iXk6y9kH/3btdZUl4SDkqKBzv9+dXlvgh2LaZAty9ticy7rvZdkpqMFh+Tn1niW2jhVpicCcPjaMjnupXjIs/SQbEBLSayu6lhi4u3Zf08+gECz/pLM6pPXqqBSIuon1HTJK8pAXLzK4cVZ28yBP0r+8l6jLrpxfLCPoEvEoSa1XYvxZmuYPfKN+i6Zmo2exCfM2YNLbey7taSvhOEkVjN9rQ22soggMxJLwRHGcSbSoT7yHoO8ruseYeh1k5YUO17sHGHAXgK3piO2IqUzcdCsyb7MoYl64Ec3ILukIZFPoow/P0Af8yuKn4AUAeOFJd41gUNihkDJOwk/ZzS4IPJp8cPGkhgEuyZcz1VE0eE6ltKFIZwLdnAvVzkbIwwmL/7tCpcd6EU+kF8auXg2uFxq/EzdNurw3NbkvRJifJy5zc1HRU0PXLEZRjjFLo3pr+JMDYdZrL8o2j4CV8pSrRgjF+lTHZrjXd0tG0o7MUipsZY9Ly6Ih+CCPryAhtdaeYtDwM6f4pKXU8T3juaAW/Wf8dA7jsOIWarHeAYmLKkPi/30tNCHM9y6n9+0s7w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1P193MB0413.EURP193.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(39840400004)(376002)(346002)(366004)(396003)(451199021)(31686004)(2906002)(5660300002)(7416002)(478600001)(8936002)(8676002)(41300700001)(66556008)(110136005)(66946007)(316002)(36756003)(52116002)(6486002)(4326008)(53546011)(66476007)(86362001)(38100700002)(6506007)(6512007)(31696002)(2616005)(83380400001)(107886003)(186003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y0orVUF3dC9jck9XVTNPd3FDZEtqUDMyWEhRcDhuZWFBS0ZnQWxZdERDRS96?=
 =?utf-8?B?L0VONnhuekp6T3dvLytTa3ptaVBwT2ZKLzNJYnJQaURSc2lrb0NXNkE2aGdj?=
 =?utf-8?B?ZDhWNFJqdTFKOGlJNUdSZkdmNi80M0luRHpJdk9BbllyNEp4VHdkeUtNWW9k?=
 =?utf-8?B?RURmaXNrVXE1L0tIOVVpQmlzc2JCbzNGRE9JenVYMlk3NWJobmV3dlRacFZT?=
 =?utf-8?B?REg4Zks4U2pRZ09xVUtSN1ozTFpxM1dyMjVjTHFVTFRGTkgwUEVxS3FpSGdE?=
 =?utf-8?B?ajFKT09INUcyVUNZRktNZEl0ay95LzZpOUNsSXVBUzZkM1pacmFIMUtmNDN5?=
 =?utf-8?B?QVNGMUhsSURLVWN1TzJ4Q3g1dHk3cDJIQU1LbmxUM2ZNdU85NTk4QVFOYk9j?=
 =?utf-8?B?N3NmMDdMcE5jNGtBTTRyazBVQUtHMmpJV2F3UUdCYW9YRzJocGVpaDR1UjdP?=
 =?utf-8?B?WGFBd0VEYXA1dU1JNEtqTElsODFPTTJJTXRPVitiRzBDeU01bVFsMjNibnFj?=
 =?utf-8?B?Rkc5NDdvQXBkTUwwSXNhMnY4RHY3NEJGaVVZTnVBSmpLdFZOcFJBWlRiU3Br?=
 =?utf-8?B?WjBXZUk4bWdJOG9icjRrdVVBN0hCTHZqSHdmYTJKcE9GbWxLSGQvN1A1QUhX?=
 =?utf-8?B?K0k4MXVjQnNHM25KdnpMWElRdWpDc09Jd29tTHNVZ25Qdkdub0d2RzhNUURl?=
 =?utf-8?B?c1NMR3lnVGhneHF2aEpmWUdiZm5ZemFza1NISDZ1K3dBZ21jNW1vdEJzbWNv?=
 =?utf-8?B?ZGZpVlNlQ2F6bVk2UCtSWFl2OFR1SSszZlR4NktMdEdvWEJ4OTJDMHBQWXl3?=
 =?utf-8?B?MUltQ2xkem83OXhqVTRRVU9jbG1YaXZ0TTZKRkVjL3VTY0ZSUVdINHVWUkR0?=
 =?utf-8?B?L0ZrL1pzRmlHdHpJVnJxVmhwZm51b2NmcFdFT0R6TjR2TVBuRmZXNHkzQkNE?=
 =?utf-8?B?RkZHZVlzMGptQ0ZaQ1hhWWdiREdpUFZHRUZwQVhDaVYxSDh1T2RXTVJQQ3pv?=
 =?utf-8?B?U240K0RKUHdyeVBSZVBiTTRWcHQ0bXAwMHhuSmhaZjZnQ3pUT3FBME5LSUxW?=
 =?utf-8?B?T3pPWlIwMzd2cWhWbWpqbE13U0xYMGU4akpPbHpqUW5rTytzYnRwTWFJTEtv?=
 =?utf-8?B?V1dIc0trSUFtbXNqdnA1TFdraDY5OElFSTF5Vmw1c1RnWFdSS1hIMVRJamZq?=
 =?utf-8?B?Nnc1Z0FCaG01ampBMHZYa0xOVXNpU2xDc0R3MjV3S3pFQzhYNktPcFpJcHpH?=
 =?utf-8?B?YUZRVVBLREE5Qy8zckVJcVc3NnB2Y3VpYzIzVUJzS2JMb3V4aE10TVZVazNp?=
 =?utf-8?B?UDVUdXhYYW0wejdJQU10Y3V6QkVrdm8wazhIeU9zVUswOUJrK1FJalVzMUE0?=
 =?utf-8?B?UHczUGdkMGdMaXgzUHpnVTRiY0dRY3lScjN3b01KYXN2Sk02MGZGNlpuVG9h?=
 =?utf-8?B?YmdQNmt0ZnpjYzk3b1JCTEh0Uzc2ZUwrUW41VmpuRDhIdDA4OUlMMEUyNjN6?=
 =?utf-8?B?NUdJTzN3YS9PUW14Vk90V0RNRmlWMW1pSjFaYkhOK3hxbkt3OU9GZ1U4cHRC?=
 =?utf-8?B?RW4xa2VEdzRFUHJJOXZobFNLVU5udlJPNFJ5bHk0Z3pWNWtEOHhLbmsyNzQz?=
 =?utf-8?B?NWErc1UzOWJxV2tPNk9ZMGFnTWt3VGpWMjNWMmpCYlRRVUZHOUY4SmpDa0F1?=
 =?utf-8?B?bnFyMW95dDhpNFd0dkdPZVBNdnpGOVk2cXV2ZjBKRkZuUjh0UlBQRUVoSXpV?=
 =?utf-8?B?MzBHWFMrWEZBWkVtdzhXZS9lM0pzZGJ3ZTh6dGp1SEVkMDQyVHdTTjNWM24z?=
 =?utf-8?B?QzllM0gvcnVncHJsNllzN091ZDBQdkVkZTNURnZ4WHNjTnZ5VmZnTEJiWjFz?=
 =?utf-8?B?Q3p0eXhGaFZlR1pOWkM1WHRIMXBKYUJmRjRBTlFOUXBPdUFpVXUwODZBbjFQ?=
 =?utf-8?B?anBqTDZyREJ3bXovQ2JoSXVpS0tqRUo2VUkyMUQ5MHMrQmwwRE5rbVpmNit1?=
 =?utf-8?B?YnBzVDcvMnNmZ2phM2xveW0zTXZqK0djbzIvSHVxQWxVVDNCaUhtajBaeFM3?=
 =?utf-8?B?QWpVemdmUGFBQmJmejZlbWdTb3hpTktqQWM0NXpUWUNiVnhrQm56OVpLSnQ2?=
 =?utf-8?B?NC9LaHNPdFBxbkNHcW5JVUdQQTdGNTFpbGxwWVpsOWhrZ3hLY3JFNEgyWnNO?=
 =?utf-8?B?K0pTaCsySy8rVnpHUzhwVk9HbW9pdkd3SEtxNUZNeVFxUVdIeThTdHREbWkw?=
 =?utf-8?B?Q1JEZnF0TEZTQ3REQ2RMY2lBU1BnPT0=?=
X-OriginatorOrg: kunbus.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ba82681-df81-4187-c167-08db5d816489
X-MS-Exchange-CrossTenant-AuthSource: VI1P193MB0413.EURP193.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2023 00:37:32.4943
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: aaa4d814-e659-4b0a-9698-1c671f11520b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e7c4tH/z0Di1cM50EkZs4y5isAYm5itqhZ8fd/Rtsa3zaI1Nm+gAahzh1TaLlFF9ZsiMWsGWNv9lpSLUsTwAnw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXP193MB2059
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org



On 24.05.23 17:30, Jarkko Sakkinen wrote:
> ATTENTION: This e-mail is from an external sender. Please check attachments and links before opening e.g. with mouseover.
> 
> 
> On Wed May 24, 2023 at 6:58 AM EEST, Jarkko Sakkinen wrote:
>>>     rc = tpm_tis_read32(priv, TPM_INT_STATUS(priv->locality), &interrupt);
>>>     if (rc < 0)
>>> -           return IRQ_NONE;
>>> +           goto unhandled;
>>>
>>>     if (interrupt == 0)
>>> -           return IRQ_NONE;
>>> +           goto unhandled;
>>>
>>>     set_bit(TPM_TIS_IRQ_TESTED, &priv->flags);
>>>     if (interrupt & TPM_INTF_DATA_AVAIL_INT)
>>> @@ -780,10 +829,14 @@ static irqreturn_t tis_int_handler(int dummy, void *dev_id)
>>>     rc = tpm_tis_write32(priv, TPM_INT_STATUS(priv->locality), interrupt);
>>>     tpm_tis_relinquish_locality(chip, 0);
>>>     if (rc < 0)
>>> -           return IRQ_NONE;
>>> +           goto unhandled;
>>>
>>>     tpm_tis_read32(priv, TPM_INT_STATUS(priv->locality), &interrupt);
>>>     return IRQ_HANDLED;
>>> +
>>> +unhandled:
>>> +   tpm_tis_process_unhandled_interrupt(chip);
>>> +   return IRQ_HANDLED;
>>>  }
> 
> Some minor glitches I noticed.
> 
> You could simplify the flow by making the helper to return IRQ_NONE.
> 
> E.g.
> 
>         tpm_tis_relinquish_locality(chip, 0);
>         if (rc < 0)
>                 return tpm_tis_process_unhandled_interrupt(chip);

Agreed, this way we could spare a few lines in the interrupt handler (but note
that the implementation only returns IRQ_HANDLED never IRQ_NONE. This is to prevent
the generic irq code from doing its own interrupt storm handling before the TPM driver
had a chance to fall back to polling).

> 
> I'd recommend changing the function name simply tpm_tis_rollback_interrupt().

> Also tpm_tis_handle_irq_storm() is a pretty bad function name
> because handle also can mean anything. You are resetting to the
> polling mode, right?
> 
> So perhaps that could be e.g. tpm_tis_reenable_polling? I'm open
> for any other name but it really needs to give a hint what the
> function does.

tpm_tis_reenable_polling() sounds good to me.


Regards,
Lino


