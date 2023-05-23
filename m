Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA78570DAA5
	for <lists+linux-integrity@lfdr.de>; Tue, 23 May 2023 12:35:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236470AbjEWKfp (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 23 May 2023 06:35:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236238AbjEWKfo (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 23 May 2023 06:35:44 -0400
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2086.outbound.protection.outlook.com [40.107.104.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFD49119;
        Tue, 23 May 2023 03:35:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZTuQGpRu/MX6PnixnmXsserwuftsIK4GF+p1fNnpHZs+OLBuPTtlyW7o9RB2mS2XaXNnkCxcVtsc+4L8zZGlQG5gJqcdDXzCm9pLva8rT9kbyVmR1y9IbyEqXoNi30pVmlf750vgOHUTxmHTe5dsfOAxn8viiKEOFbTZb9ctlpMJlt1Wnr4InKBPT5/s7tspUl2jttF9A3yZNpSpbjNC5JXFBQg6CqDdxBS6ntQRBtiVLhqvjGqt5urknT3OMsbqwH8dCr6CzCLAof5qGGDsw6X7gJvfyJOit4BBkZmf42mQ3TBy/w3yYqIclIUOn6qYKiIsZYw/9KLeP7SwMgDGsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dQlFvuwT0/SNBM88i67BYfaeZPGnVYuz5vC3ZgbTrjk=;
 b=AKfn+BPWbO6zvuIz7gazHNYVAtraUugZbeUuir2TtTa1TnxbcbDzmf7h5FuTGtbBADvZdvPQVrSpLFTGbQvav4UmREV5KJssmoRJTNQJMk8pYlgrmBBTVp9qhmPZzFkJvwSygdw63hNt2tl7RmvmgTFM9nS2Jehg+ZomsUliqHMLPbKqJ8w4uXJkd2XUUATz3IYfMGVlpvH+/jr3yV3QVas6s53qbY7OpaWv6VB/S7Jw60bZ6d7td5YQ1LsRDj/fUQhHImzvcyTEUmKcQ9EOdS16ePjnmz7XO1cYSmMSJg7SJk2XBT6ootckSVwmYY1/7DcOlxOc2WLFv3AllGvheQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kunbus.com; dmarc=pass action=none header.from=kunbus.com;
 dkim=pass header.d=kunbus.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kunbus.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dQlFvuwT0/SNBM88i67BYfaeZPGnVYuz5vC3ZgbTrjk=;
 b=CTWqCjmcz54UhiwkzLna9ZeOOCyUuzXDh9+IDpeMUYqL/9sOAmF40NkjKO+unXnenn+6P5W9YxVoNWhHNcGT+YINPQ51EVZUhyKxhxOSOXFEEFwvrysLtd79fXRNRotLuq4VEb0vz+N2wzDvd8ftHR8PZQKUgaEjQaIQ1/1OKtM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kunbus.com;
Received: from VI1P193MB0413.EURP193.PROD.OUTLOOK.COM (2603:10a6:803:4e::14)
 by GV1P193MB2389.EURP193.PROD.OUTLOOK.COM (2603:10a6:150:26::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.14; Tue, 23 May
 2023 10:35:35 +0000
Received: from VI1P193MB0413.EURP193.PROD.OUTLOOK.COM
 ([fe80::6727:e3fb:8fec:72a6]) by VI1P193MB0413.EURP193.PROD.OUTLOOK.COM
 ([fe80::6727:e3fb:8fec:72a6%7]) with mapi id 15.20.6433.013; Tue, 23 May 2023
 10:35:35 +0000
Message-ID: <7fc97ab0-0963-a5c0-2753-b329ed9ad930@kunbus.com>
Date:   Tue, 23 May 2023 12:35:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 1/2] tpm, tpm_tis: Handle interrupt storm
Content-Language: en-US
To:     =?UTF-8?Q?P=c3=a9ter_Ujfalusi?= <peter.ujfalusi@linux.intel.com>,
        Lukas Wunner <lukas@wunner.de>
Cc:     Lino Sanfilippo <LinoSanfilippo@gmx.de>, peterhuewe@gmx.de,
        jarkko@kernel.org, jgg@ziepe.ca, jsnitsel@redhat.com,
        hdegoede@redhat.com, oe-lkp@lists.linux.dev, lkp@intel.com,
        peterz@infradead.org, linux@mniewoehner.de,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        p.rosenberger@kunbus.com
References: <20230522143105.8617-1-LinoSanfilippo@gmx.de>
 <c772bcdf-8256-2682-857c-9a6d344606d0@linux.intel.com>
 <20230523074443.GA21236@wunner.de>
 <98f7dc1a-6bed-a66f-650e-10caeb7d0bca@linux.intel.com>
 <4a94b44d-1b51-2656-786e-07bf97063c3f@linux.intel.com>
From:   Lino Sanfilippo <l.sanfilippo@kunbus.com>
In-Reply-To: <4a94b44d-1b51-2656-786e-07bf97063c3f@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0267.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b5::13) To VI1P193MB0413.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:803:4e::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1P193MB0413:EE_|GV1P193MB2389:EE_
X-MS-Office365-Filtering-Correlation-Id: b1d4afef-991e-420c-44d9-08db5b797106
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Z6AGlaIfrM2yT1wEorLU7v39HzdjSyIS2eiVolQQQaB/4Al116x1FhR9lzq+Qhm3BOw9ctjVMM1eveDaqkYwUSNGiRyNLCP9Bq8aQA8tUIK/WSG7VtTLNnpl9eybZmAd5S0ATCebSi759727YCEo5ku+OZPZAUd6GBJ3APml5CzwDcyIUpzJlE6ENr61sPSHQ1JWZf6q4oQibcTo7VESpADtIcIIypsLvXNefho1wmVfq4fEtgpMJXP78ZWrKDgBl7kwovE2u/vmn059sFZVSEuxZC1iljsRwAPaPE7Q7i4CYY5EZwJCMuvNeQ8ddcL93A0KQhg1Ul0S0OqbNVdLe72t+N0oY8IDLRRrEYsHGzAq+p/Ge4aheDoeSPn2xpLWvV7jtZqU5QXPiHVMbBIT7Y5H52+5mKyug52X4R90pqdJkOpCiaiEdUdEJbUjydcMwe6IIjJyVCnUJtf7GRu9b+xxFWt0QvQ95SsARy/7Hh0DuIm0bX/If6jkCmJp1gDy/DoqqHiczaOui7WwG1zr/sXuQKugPr4rq9EUwMjiuTbUHDBdeRXFM6nwG7cEdtEJo/CFWxuWtYpQ+gHYr5GM85QkUmfMt5WMRWaGPCNTPdFKrVk1AhOvgaaZOHRsx6wrCId2S5uUu1LAlyZ3fkWZrQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1P193MB0413.EURP193.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39840400004)(346002)(376002)(396003)(366004)(136003)(451199021)(6506007)(107886003)(53546011)(2616005)(66556008)(66476007)(186003)(478600001)(110136005)(66946007)(6512007)(316002)(86362001)(4326008)(31686004)(31696002)(41300700001)(36756003)(2906002)(83380400001)(966005)(66574015)(5660300002)(38100700002)(8676002)(8936002)(7416002)(6666004)(6486002)(52116002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QWFBSUN3MlRKd1BiWk56alRYNGRSQWhrZVhUWmZEYUJvMEgvMGFBZXhKeTc1?=
 =?utf-8?B?YmkyYzlvVlNxcWhhRDIzblU5YnZtRis0Szh2WWIxYzdnMzBmdmlQNXpnUUgw?=
 =?utf-8?B?WXJGcDZXS3BMV200UDhvZ2NVZm1iV1NkZDFqZXRxWEwwQnUvOHFJRmNNNXUz?=
 =?utf-8?B?NWRKU1VtU0lqWW5rSlpKYXB3Y3p0NW1rd1RZVno0VEo2UEhYWGtnaTJ6alhp?=
 =?utf-8?B?Ym9RTlZGZGUrUXltbHlHenk5STBUZXVWNnRqQkM4Yk5yUWJnQ0cxN0dZWmoz?=
 =?utf-8?B?aVc5cHcyRjN5SnFHZFE4NEEyOU05SGlUTE1hOEdPZ0J0a2F5NE5ZT3M3R3ha?=
 =?utf-8?B?djBCaVpHbWZwc212ZEhPSnRIc0VqQVFxUGJwOWRJSFFiZFpUVFpyNFZTRVg3?=
 =?utf-8?B?alA1SXlWS0t4K201L3pJbVdDOXlmSUdwZmtpUFJGeS9FSGlpMTJsckh5c05Y?=
 =?utf-8?B?cWhxeThnOW1EODhsUlhmME95dVF5aUFQWlBYWnpIN3p5Uk9BMmtUVC8wLzBM?=
 =?utf-8?B?cjM4MWFtNHM4b0h0dHNsWGhSeS9FbGF2bytZRUdwQXdGamtTNVE1b0doWWNQ?=
 =?utf-8?B?Y3RBeHpvSlFyb2Q5anAzcDcxMFJTL3F3VjQrYTVRc2p1TmRWVDdRdjRXRGlV?=
 =?utf-8?B?U2xzVVVZTzlURm5TTkhKL2VSSWJlS0lFMU1MWDJnQkduUGgrUENsMWZQQndF?=
 =?utf-8?B?RklnTVlscnJ5cFBhN0VwTHJ2T2QwT1hHb3NRemcrY2Y5S1ZkL2pwUDNnS2sy?=
 =?utf-8?B?d2hoekhXbjRtMEZHWWpPVk1kR0kraFhaamdwTnhodDFWa0I3ZHFubytuR0Rw?=
 =?utf-8?B?cUVwRE1jUTNwaXFVYklBV1J3MnBOSlBVS0FBb0NJN1oxSDhDVEN4ZkdmSWw5?=
 =?utf-8?B?SEJBYUsyZWhoNkV4T3NMS3JNdEFUc2V2MHlWWXRVZ0pKQlFta3hlT2tNNFpC?=
 =?utf-8?B?Mk9iZlNiazRzVHhTRXA0enNQNGxOWklmbHlRTXVtNUJJUzlBRk1UOEswMGNE?=
 =?utf-8?B?VHYwdVRmSlVQcW9LeFc0ZTU5RWdZTFVnTVczUy80cUFYM245U0xBSVdpbDhl?=
 =?utf-8?B?OU5XOFdxeEhHMG1ZS0V6b0xCQ2YrcEppQjNZUWdRMU5LZXg1cUI3Tnk5S0pn?=
 =?utf-8?B?c20yY2c4ejJ1L29RdUNNWG1UR2l6TkJZQUNsZGt1YkI3MmE3TFdJRnROMGdH?=
 =?utf-8?B?eCtHSDYzeHFrb1hCSDZjaUViTC90cEtIN2pGS1RYMTBEM09uVXB0dGloaXh4?=
 =?utf-8?B?VFFqSDNWcjRKUXk3N1JwdCttcjlFZGZLTmFWamxFTDVMRWR4dVhoamR3SElm?=
 =?utf-8?B?MXJyL0xYalU5SVpGN1VLYkljajNySlJVbXBBeWdzNnFqRm5Od010ZjdTNnd0?=
 =?utf-8?B?QTg3WWpWVU5uemNEbzh0cnEzSEI3aVBKb0tXaU1nNDV1aEdLMER2dkYwRGZH?=
 =?utf-8?B?M3NsREtMR3pxMDYyT0RIdGd2ODA2OWY0S1B4VTVhZC9pOHAyOUt1eldhYlFR?=
 =?utf-8?B?Z2FsZ1JuaDRGbnY1RFdEWHhtTkEwTGM3LytnZWVuelduZnJ2THlNV0RoNUpM?=
 =?utf-8?B?WGxjNmdiT3cxb05RNFA4Rm5WSkw0VWExclZpUHBmVXpmSjJDNUxnQjdxVlVG?=
 =?utf-8?B?ZERsQi9lOHVHd20wY3hSN3hGTTZDQXA4RUZmLzVBc0liVEpjTUV3M0ZlL2NE?=
 =?utf-8?B?T2JGWjBQYkRoNHdTeUpReVRvdWFsZkpDQjdqakJLakNEYWRSTTM0a3A2Nkx5?=
 =?utf-8?B?aEVZajFOM1ZUUjRma1NGNDNUV0UrV0lVMHdSTlJoNmZ6WlVMYStLQjFqWE1G?=
 =?utf-8?B?MkhvcHBiWE9xeWZITmxVNVZXZ2RzWlhUbUFnZG95ZSt6TWFSZllzQWFxTFhm?=
 =?utf-8?B?S3E3VnZSZjJCcXlwYjlkOTNheFl6ZVZpeTYwd2FET0dsUDJZaGdJcU83Znpy?=
 =?utf-8?B?cGlsM2NkdFpwd0drR2xmUXJpOUNyeS9tVnZaVXBZSUZTNDk3RjJqNnF0NFRw?=
 =?utf-8?B?d0h3MU9vT05YSFIvR2lzcVNtakUyVzQ2ZElGUFRUY29jOXdYZ0N6TkxNaEJr?=
 =?utf-8?B?OC81dWVjUk5PNzhYME45d3JiRkpjTmN2RnVTdGFlRzRWcEluQkI2RmlHVm1U?=
 =?utf-8?B?TDJlaXBLVGszN3VTYWFlb01vK1JEb1Vab2dZOU9vNWtYVzJybnh6Yi82bVRq?=
 =?utf-8?Q?Fpc5M7QCMk7Bch0M1APNJibpNVmt91pvs5dtuGky+Lwo?=
X-OriginatorOrg: kunbus.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1d4afef-991e-420c-44d9-08db5b797106
X-MS-Exchange-CrossTenant-AuthSource: VI1P193MB0413.EURP193.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2023 10:35:35.0945
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: aaa4d814-e659-4b0a-9698-1c671f11520b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kJmg0xiYKsjBmfV/TTCFxKgCxe4H5yEhS5nfpRSEkxqa5+BMInli558OnLzcFaUl9Qe7nD6CmsE0GR5xWk6D/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1P193MB2389
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi,

On 23.05.23 11:35, Péter Ujfalusi wrote:
> ATTENTION: This e-mail is from an external sender. Please check attachments and links before opening e.g. with mouseover.
> 
> 
> Hi,
> 
> sorry for the unwrapped lines...
> 
> On 23/05/2023 12:14, Péter Ujfalusi wrote:
>>
>>
>> On 23/05/2023 10:44, Lukas Wunner wrote:
>>> On Tue, May 23, 2023 at 09:48:23AM +0300, Péter Ujfalusi wrote:
>>>> On 22/05/2023 17:31, Lino Sanfilippo wrote:
>>> [...]
>>>> This looked promising, however it looks like the UPX-i11 needs the DMI
>>>> quirk.
>>>
>>> Why is that?  Is there a fundamental problem with the patch or is it
>>> a specific issue with that device?
>>
>> The flood is not detected (if there is a flood at all), interrupt stops
>> working after about 200 interrupts - in the latest boot at 118th.
>> I can check this later, likely tomorrow.
> 
> With the patches and this diff:
> 
> diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_core.c
> index 8f4f2cb5520f..6a910d3277d5 100644
> --- a/drivers/char/tpm/tpm_tis_core.c
> +++ b/drivers/char/tpm/tpm_tis_core.c
> @@ -795,6 +795,7 @@ static void tpm_tis_process_unhandled_interrupt(struct tpm_chip *chip)
> 
>         priv->last_unhandled_irq = jiffies;
> 
> +       pr_warn("[PETER] %s: unhandled_irqs: %d\n", __func__, priv->unhandled_irqs);
>         if (priv->unhandled_irqs > MAX_UNHANDLED_IRQS)
>                 tpm_tis_handle_irq_storm(chip);
>  }
> 
> 
> In some boot I don't get a print at all and reboot takes
> 2 minutes (tpm timeout), or as it happened now:
> 
> # dmesg | grep tpm
> [    4.306999] tpm_tis MSFT0101:00: 2.0 TPM (device-id 0x1B, rev-id 22)
> [    4.325868] [PETER] tpm_tis_process_unhandled_interrupt: unhandled_irqs: 1
> [    4.325908] [PETER] tpm_tis_process_unhandled_interrupt: unhandled_irqs: 2
> ...
> [    4.329579] [PETER] tpm_tis_process_unhandled_interrupt: unhandled_irqs: 91
> [    5.129056] [PETER] tpm_tis_process_unhandled_interrupt: unhandled_irqs: 1
> ...
> [    5.129561] [PETER] tpm_tis_process_unhandled_interrupt: unhandled_irqs: 10
> 
> # cat /proc/interrupts | grep tpm
>   28:          0          0          0        133  IR-IO-APIC   28-fasteoi   tpm0
> 
> Reboot takes in all cases 2 minutes to pass the timeout for the TPM2_CC_SHUTDOWN
> 

Thanks a lot for testing.

The patch was originally created to fix a reported interrupt storm:

https://lore.kernel.org/linux-integrity/d80b180a569a9f068d3a2614f062cfa3a78af5a6.camel@kernel.org/

My hope was that it could also fix the issues seen with ThinkPad L490 and ThinkStation P360. But
in some of your test cases there seems to be no storm at all, so this patch wont help. So for now
I am afraid we have to keep the DMI quirks to handle these devices. I will adjust the commit 
message accordingly.


Thanks,
Lino



> --
> Péter
