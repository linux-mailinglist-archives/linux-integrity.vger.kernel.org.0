Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E958C5A4473
	for <lists+linux-integrity@lfdr.de>; Mon, 29 Aug 2022 10:03:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229675AbiH2IDZ (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 29 Aug 2022 04:03:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbiH2IDY (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 29 Aug 2022 04:03:24 -0400
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-eopbgr150058.outbound.protection.outlook.com [40.107.15.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 873C845992;
        Mon, 29 Aug 2022 01:03:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F5v1WxGZY4pYxRlOVWVCZPtTD6ULjutWAuYzQ27XfRILGGeoAkWb1Oc8ZaBsHmX3VrKQa+5HrL2zcD8GD4jX/9+G/22Xs1f68El4c9RYpZFNtZLgKXPiToVPGARtyicxe1/msXTRQPwpfN4EudrZSt9P26fsi+JhqEwycILiYfGYfn9wh5/kunibRL7NRUaT+GjIYUrPptQ5pLmbV3A3ylZzh1zGgw5pzcCsZzCcUMrHVNGIeWwnkJjYy4tdJZjl293/NYw17KIdZQhFvfHGoS16UuMHXdxtoJ1TrjNgZ0xiyDTH3crgVm9dlIQsIG4M4wlWAIM6XNfv1/6KP4ksfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7DxuRSZd/TWS9kqIW8wL8qKJf3qezIaM46pfKUuJ6bY=;
 b=PDDdYPT/gex+UjhaGGeAYi4g9x3U+emq3BTHk0lgcLUMYm8wpTXTHY7Iu4aREyQXQPWCMJZyGx5JxJIFh5pxF4qbtAPQK1AlvUEXFMNNZchC2azVN33vB4GUJPzbDJmHYhQMuhvTKHLavXStbrOYA8UDdOx5a1Wq9iWlHrpg5e+w1B7qOWckqCoJXQmQbzeGfVjqXPuSpx+txVrlrDPF9ziTMyJ2gG/feAQCN5lztqpkthmZXK3bA6lEGxY5Xras+uXh0yxNBj+Ym6baiXL5bl0FTqsYZu8b3pFHgyF38hQl67zBWnj/mKKVFXyVkRx8C6TF80tcb7Xfbv2Dumm7xA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kunbus.com; dmarc=pass action=none header.from=kunbus.com;
 dkim=pass header.d=kunbus.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kunbus.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7DxuRSZd/TWS9kqIW8wL8qKJf3qezIaM46pfKUuJ6bY=;
 b=GqxXiuojOaYjzEFLZwxTHjGl5t4XT47nu/4zjAA/kbWWbYbgvkGLwDD0/YbskwHPlhUPkroTlkKyJSIOuH8ipkFovlQREvKqYP7rVq2a5QNphDmtKzbzf2QEwvCVt1YlJRk19ZXBAyx5G6YNHrM23dRRbtMIBUf81cPzDr8mVwk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kunbus.com;
Received: from VI1P193MB0413.EURP193.PROD.OUTLOOK.COM (2603:10a6:803:4e::14)
 by PR3P193MB0912.EURP193.PROD.OUTLOOK.COM (2603:10a6:102:97::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Mon, 29 Aug
 2022 08:03:16 +0000
Received: from VI1P193MB0413.EURP193.PROD.OUTLOOK.COM
 ([fe80::c59f:e594:1134:eb56]) by VI1P193MB0413.EURP193.PROD.OUTLOOK.COM
 ([fe80::c59f:e594:1134:eb56%7]) with mapi id 15.20.5566.021; Mon, 29 Aug 2022
 08:03:16 +0000
Message-ID: <c9dffd4f-91f6-cf49-f88d-e099881fe102@kunbus.com>
Date:   Mon, 29 Aug 2022 10:03:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v7 05/10] tpm, tpm_tis: Only handle supported interrupts
Content-Language: en-US
To:     Jason Andryuk <jandryuk@gmail.com>
Cc:     Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Stefan Berger <stefanb@linux.vnet.ibm.com>,
        linux@mniewoehner.de, linux-integrity@vger.kernel.org,
        open list <linux-kernel@vger.kernel.org>, lukas@wunner.de,
        p.rosenberger@kunbus.com
References: <20220629232653.1306735-1-LinoSanfilippo@gmx.de>
 <20220629232653.1306735-6-LinoSanfilippo@gmx.de>
 <CAKf6xpsc9KRUKo5Z-kPqDcSCdpf9-tjf+ZdREnEiJUdHwyDQcA@mail.gmail.com>
From:   Lino Sanfilippo <l.sanfilippo@kunbus.com>
In-Reply-To: <CAKf6xpsc9KRUKo5Z-kPqDcSCdpf9-tjf+ZdREnEiJUdHwyDQcA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS9PR06CA0468.eurprd06.prod.outlook.com
 (2603:10a6:20b:49a::23) To VI1P193MB0413.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:803:4e::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7fac2d1d-a385-4643-d914-08da8994ed43
X-MS-TrafficTypeDiagnostic: PR3P193MB0912:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wQhHSaTDnlT5x5geYhSEmCn5N/MQOFG5cAtGU+SRLyuwy6w88KgMNmULAqFTHoXMejq32w4sSvY6fbOnsiGtlUp7AmWUvoNgwh3hfA+1wGWnRIbm3miG628tK9iWu+uKqeKJEmqwAbe3OsXGMZv7NWGtJZ14aigKwxtyg4z6aoCY1iKlRWtvxZmBbKFfgQqaRMwTVXeNzbjRjMu7aRXM1EUEtgd2SJe3vEEyfYpIR69buhYAxVFHbwXgcEnu/Ly98igq9yVIfY2FUBlx8A3NnQz9+CSIyaBtqdIluyDxG03G3hdPIEgSawfa8p9aEOrfdfI8vE3hX3ogdfzO1hSyJzy1LOErkQXIll7ViNVw5VZ+8wtNA3+fR/cEsM+BgfTg0o57cTXDdMA79ezatKvPDg8Rr0IphT3NYcRsEftXGs3AgbUb5AZZmuhRYLzwBc0x0nBdxr9VHH/I4TGp+HAEEBwgTKUwTLBNhpbH1xklUyjHf2YA0uDowOr3YBFWLTFHpX7yTCBzYW9YS2udRO7Yw3RsNDG1T0FBF+BmyBbKQlatFSDLF8FkkjTscyu7fROOrcd+1HNdiPGP7Brlip+CM58Lza20kA/Bd3ncUJoaQlHXXUtCCwCLujymq4WDMNAIPBsKCRhzaLmUXKZSd9CDcwrSUBncm1ilAGElcoUJVwmSgnsuv8gFf3uHRML9WVkAgiYuNlxX+elRBR83U6P5wii4uStvF49MpMrpKEmL/KV8HagaxpJ9jsnoqRlf8XeRCfywu+jlNMh9NxF1s6ePnTqJXvPynt6y0Wfwvr2DhoA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1P193MB0413.EURP193.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(346002)(39830400003)(396003)(376002)(366004)(53546011)(6666004)(6506007)(107886003)(6512007)(2616005)(6486002)(41300700001)(83380400001)(478600001)(2906002)(5660300002)(8936002)(7416002)(186003)(52116002)(6916009)(316002)(54906003)(4326008)(8676002)(66476007)(66556008)(66946007)(31686004)(38100700002)(36756003)(31696002)(86362001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UXhKYURGNnhnZzdFWjBIQzlIaGJtRTdrdHhJQ0RPaWhSVTYwaXZ5V2ZjNXRD?=
 =?utf-8?B?b1VJSjJueW1PSHNGYW5IN3M1c0NzSWNuL25Qa3dtcEs2TWtoL052Myt3Y0c2?=
 =?utf-8?B?TFRMZUZPUUQwQzg3blhUeGVnUTVLaHErNk5FN2hid1pqZFpUY1pwdDhNQzVN?=
 =?utf-8?B?NkU4cnNZQXBhUFhrSmxsR05ZSU0rcHUyYTZmaWFKZDlWUXRpNEtMbE8yTVF1?=
 =?utf-8?B?TSswYTVMb3hJN1hvb0xXMXNSaHlHaU40T2N6Uk11ejRkVkRMRUNtWTRPOVgx?=
 =?utf-8?B?MUgrOVA3alVlZXlNaDJUeGJpMnRYNGdIVWYvTVdYMWpzVFJMaXQ4NVRhSkdN?=
 =?utf-8?B?azltc25lMm92bnBHL2FUTnQ0WE5BU0hFVUtMM0JoTTZ6dTZIcGJhOHM4K0ZW?=
 =?utf-8?B?MEJjc1ZXZUlqbmk4R3o2REVFZnBBa1h4c2RORXRkREpKb0xSZ05jQ00yNWtk?=
 =?utf-8?B?ZEJHOFhSVDNtWkM0VG5rbHNZdTJHZ0pWUTRwbTBpUUFHc2JLRDRTSVlhdWVu?=
 =?utf-8?B?WmtPUU5hTWFrRUhXQ1NDR3QzVkFYNU1mTityYjgyMTFZMVBEalN0L05qVzZq?=
 =?utf-8?B?d091aUdsZ0ZGcnI5VzQvNUxpOTcveS9tMWUyOFNwb2JobWZLVUFvVExzcGdH?=
 =?utf-8?B?NXhvb3lxQzlwM2duUTl1ejM2WnVNSWd4UVVzWlJCdkpkL0tVeWppSERqSmhV?=
 =?utf-8?B?eExTRTVqQ2pIWXVObWpucWFIMWluU3pLYXdPbE42U21xeVErcTFOUzZPVG1s?=
 =?utf-8?B?R3hNa0w0WnM2UXFuMEgzKzgwSmNLNkJKTStrYVBmc2VycnlNdE1Fb1pYdFBz?=
 =?utf-8?B?ZkdaOHRWU3V4RGlrNERUNlpuTTUybVIrV3BoaG9meWhERUI0bWZHNlovcGtB?=
 =?utf-8?B?SHRDS0E0MTBEK2IxSlh1azA3REsycXFVeHpGQitIRzMycko2b0xNT05XbVl1?=
 =?utf-8?B?ZTVqdERkT2txQUEzUFRrZlFMZG90ekI5WEJndmd5SjR0enJsSTIyaEF2bzlk?=
 =?utf-8?B?SXlocGhrVDlRNXNzV2p4NGsyc2VLYnRMc3YwT1g0eVNRaEREOXU1TXBHWXJH?=
 =?utf-8?B?eHc4ckhEZHRXQkVUUmRpa0s1SXI3WnNrRDFZZHJIQ3lYMk9EcldmWG00NGk3?=
 =?utf-8?B?WjV4MS8wMXNZeU9NTy8wUGsyUlROOXFmR2pnODUrSHFvem8yN0J3SkZybTY3?=
 =?utf-8?B?V0xHYWtobXdaZVh2bU1tVXMyMTJ2cmtMLy9PL0pNWWJ1cmdoTWJydW1QdkFO?=
 =?utf-8?B?cE4xOTBWN1MrQ0NWb1VDUjJqVWZ6SkpDTVBLbWFTOStacGtrVWNYSFFMMHRE?=
 =?utf-8?B?UTRmY3pNWU56UFBhYlh1NUZaNGowaDZodWZUTUZqSnYyUG5VR3ZzZjBjNXZH?=
 =?utf-8?B?ajhBM25OOERPcnh2VzJDb2d4Wlpub0tOdUxQcG4raUlDeG8vM3JXVWNWWlJT?=
 =?utf-8?B?SXFsdm00NmlZL2g2eFhhMGEzQ3NoZTBDM0RrUzM1ckYwSjdjQWJBZ253KzNn?=
 =?utf-8?B?SktERWllcDJEKzRYNHhPU0o1TUxMTzRUeW9ydEJ4RkVJWnBIRklYMk5TaGg4?=
 =?utf-8?B?STNoN3ZjZFdjNVYyOHNJVFc2KzFNWDI5eDhwbzNjeS9sOVdvTm9GMDZIUTlT?=
 =?utf-8?B?SU03TzBmYmF1WkNYcllBN3JpRHFidUtnazEzTTRvcDFqeVIvblpzZHZ2L1cw?=
 =?utf-8?B?cU9qeGpDbzBST3MxUC91UGFQVEtwbDNza0YwUm15YlpzT2MrbkxGZ21Fby80?=
 =?utf-8?B?Z0R0cU5rTHVRQlF1VUhnL2NNeU5MckZuMlF3TmVnbW1mTTl0S080YlZ4UDBX?=
 =?utf-8?B?NFB6aDNKbHpQL3hVaVh2MVVSajRnT2xxR1lBUlppUmJNQWVTTjd3eXhaeW1u?=
 =?utf-8?B?UHIzZTY4cU9oeHpORXVVanA1MWRraGlmNktic2Iyang5L3NPU3lkbytrcVRS?=
 =?utf-8?B?V3pmcE5IMyt5Z3haN2VSMkZNZFljWWFLWUt1VnlGa1R1MkRQS2ZWR3lHZExN?=
 =?utf-8?B?RWRxdDdUYkx5TnNZWFpHeEdoRlZENzdvUjVvMGpvTEppUmNhQk5yOThhWlV5?=
 =?utf-8?B?eG5EVGJrSnhHTGtDNkJINmVKRTRmSTVESTN6V0dZRWY5YXRTOGRTOXNTVi9n?=
 =?utf-8?B?dEwydTJEcGdiakF5OHhUdkljUFlYTVVlNWdqK2RmSlRlSzlYUjVxMlVNOGls?=
 =?utf-8?B?WXQ1RFVwV09HZDF0RUdLbjFnL0x3K1pLaU0zUVJCVXordVhLdU5QUjZCcDk0?=
 =?utf-8?B?bDN4OXFnNHovQktabnA0ZlNsUGZBPT0=?=
X-OriginatorOrg: kunbus.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fac2d1d-a385-4643-d914-08da8994ed43
X-MS-Exchange-CrossTenant-AuthSource: VI1P193MB0413.EURP193.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2022 08:03:15.9845
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: aaa4d814-e659-4b0a-9698-1c671f11520b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n0bXnEpmqGHoZHxPagaTI3c7IzJSeUDdy6nJRB3usHA4Q+zlCJ5OgvciuYNSnUvjk7PUNG3xMvMgd5Dt2DTf9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3P193MB0912
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


Hi Jason,

On 26.08.22 19:43, Jason Andryuk wrote:
> On Wed, Jun 29, 2022 at 7:28 PM Lino Sanfilippo <LinoSanfilippo@gmx.de> wrote:
> 
>> @@ -1007,8 +1029,39 @@ int tpm_tis_core_init(struct device *dev, struct tpm_tis_data *priv, int irq,
>>         if (rc < 0)
>>                 goto out_err;
>>
>> -       intmask |= TPM_INTF_CMD_READY_INT | TPM_INTF_LOCALITY_CHANGE_INT |
>> -                  TPM_INTF_DATA_AVAIL_INT | TPM_INTF_STS_VALID_INT;
>> +       /* Figure out the capabilities */
>> +       rc = tpm_tis_read32(priv, TPM_INTF_CAPS(priv->locality), &intfcaps);
>> +       if (rc < 0)
>> +               goto out_err;
>> +
>> +       dev_dbg(dev, "TPM interface capabilities (0x%x):\n",
>> +               intfcaps);
>> +       if (intfcaps & TPM_INTF_BURST_COUNT_STATIC)
>> +               dev_dbg(dev, "\tBurst Count Static\n");
>> +       if (intfcaps & TPM_INTF_CMD_READY_INT) {
>> +               intmask |= TPM_INTF_CMD_READY_INT;
>> +               dev_dbg(dev, "\tCommand Ready Int Support\n");
>> +       }
>> +       if (intfcaps & TPM_INTF_INT_EDGE_FALLING)
>> +               dev_dbg(dev, "\tInterrupt Edge Falling\n");
>> +       if (intfcaps & TPM_INTF_INT_EDGE_RISING)
>> +               dev_dbg(dev, "\tInterrupt Edge Rising\n");
>> +       if (intfcaps & TPM_INTF_INT_LEVEL_LOW)
>> +               dev_dbg(dev, "\tInterrupt Level Low\n");
>> +       if (intfcaps & TPM_INTF_INT_LEVEL_HIGH)
>> +               dev_dbg(dev, "\tInterrupt Level High\n");
>> +       if (intfcaps & TPM_INTF_LOCALITY_CHANGE_INT)
> 
> Hi, you may already have fixed this, but I just saw:
> 
> error: this ‘if’ clause does not guard... [-Werror=misleading-indentation]
>  1144 |         if (intfcaps & TPM_INTF_LOCALITY_CHANGE_INT)
>       |         ^~
> 
>> +               intmask |= TPM_INTF_LOCALITY_CHANGE_INT;
>> +               dev_dbg(dev, "\tLocality Change Int Support\n");
> 
> You need { } for the block.
> 

thanks for pointing at this, I will fix it in the next version of this series.

Regards,
Lino


> Regards,
> Jason
