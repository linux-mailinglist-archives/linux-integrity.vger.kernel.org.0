Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D491D70E6D3
	for <lists+linux-integrity@lfdr.de>; Tue, 23 May 2023 22:46:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230409AbjEWUqx (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 23 May 2023 16:46:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjEWUqw (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 23 May 2023 16:46:52 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2053.outbound.protection.outlook.com [40.107.6.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDCB18E;
        Tue, 23 May 2023 13:46:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=boi0NdcNJWmlrs+hRc/25hFqVHpIPoHcwdcAgHYgiyM2r3vnJDl9DhB0StVhlHxb4fAwgGPAN2hgcnpTYqaj8hEH7GFlP/ny61kIeD0a/3w6v/rxWUq65RpXZBVMplcMjvLbXniwnHnEXkX7X1B3w/x8Um0K4Mrtc1j/shPUxzshjlOerf4a+C28cVgu2Zevbj7Cilc95pQf69HZtuG7brgFDXDA+DEGU0gOFDU90EoSk+ieqyq4TU3lxRBi1Z9dRgF1yOqd/CMgRWGVg0YXWanDbwheSrFrFFFnwf32M3dW00af/4BNORQdDuB7aBB48bg852Ok3qrud1IqZJUBFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RmAWz9mb6Qh5s9aXFkooNaKtoUum47ArHaynU+Z+cOY=;
 b=ZGWVWlx/+dH6uZPG5s8WHdq4FlBS2WVenezrbXfai0L6GRCeV/ku/5io+VUZmg15sFCQv3au70A3k2fFpeSUOmn/bJf5H5ZN94+PJqNBVGgUOqLCL0mrud6UJE/pqlus92tbL/fX0k2sbAyUweQxCGEDa/H20o1IPlq9KE5IvQMhotefV7ilR/otCxTbHOFpSQqA7rBpDFg/knMHia1awkVFWiYQItiE8pCUWy3jUKkOoZbiI1hRY935zs5Q8RZlpcEXIhhKY+XPie8++jYZ7vjiS9MknkfgmYbno9mj0QnWVT/exZ2ba+Uy8U6MG9svlxGTl+GlVqh1H2xOaPT7BQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kunbus.com; dmarc=pass action=none header.from=kunbus.com;
 dkim=pass header.d=kunbus.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kunbus.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RmAWz9mb6Qh5s9aXFkooNaKtoUum47ArHaynU+Z+cOY=;
 b=yoycinwhRv4K3KN7xaI0T08FV4WB4ysW13jEb8OKnJFqXrJXVMkmXYtD/ci0toCLr7Uz8SokKBSPUX2gifVhVPz/KazESoZzU+Ob4ZVxYFaCPx1A2Q29HU9RBIg9TABp3HLPSTsLfszwU9rmsEl3eySg4oV0DvwqpWnD662E7lA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kunbus.com;
Received: from VI1P193MB0413.EURP193.PROD.OUTLOOK.COM (2603:10a6:803:4e::14)
 by AS8P193MB2192.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:444::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.15; Tue, 23 May
 2023 20:46:47 +0000
Received: from VI1P193MB0413.EURP193.PROD.OUTLOOK.COM
 ([fe80::6727:e3fb:8fec:72a6]) by VI1P193MB0413.EURP193.PROD.OUTLOOK.COM
 ([fe80::6727:e3fb:8fec:72a6%7]) with mapi id 15.20.6433.013; Tue, 23 May 2023
 20:46:47 +0000
Message-ID: <da435e0d-5f22-fac7-bc10-96a0fd4c6d54@kunbus.com>
Date:   Tue, 23 May 2023 22:46:44 +0200
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
 <CSTVVFNKUVJW.P69FKI6IF3ZN@suppilovahvero>
From:   Lino Sanfilippo <l.sanfilippo@kunbus.com>
In-Reply-To: <CSTVVFNKUVJW.P69FKI6IF3ZN@suppilovahvero>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0093.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a1::13) To VI1P193MB0413.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:803:4e::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1P193MB0413:EE_|AS8P193MB2192:EE_
X-MS-Office365-Filtering-Correlation-Id: 57f5fe86-08e2-4b5c-51d5-08db5bced343
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MimFHat8Gcf7WxfbCZLW2+uEaXdOyM05UH6bFuFVBa5l8AWwFIB8soP64bmuo7taYQedeQH29Xxpx7f+FDmEYAWffFbrhET/nUc+umyeEFLxUBRpnDaLeSltX2gYIEixydogqwIPz6Fm3tn/CvWdbmrTIQYXgVzbejEQSV5upp+XMjchIqxbZcB1RTjudO0Kx03TI0NqWPK/dsK7I187pUHML69+58aj7S49Ztd2RFGfg3BFJwJbCnVWNriiLEgZeHo41Pv5ESD6bfVVd+Qdd+FlE5OTM21yoB7flRuY6/vg2S/aSAlvegf8ApFnhSAXt/8nGwHkpQrTaCk/qVtjYXWB82hPltUpdztTqG8yFtCV8vsaz3U5gD2tXUPNzgWbQmV2562yjQ0uZGuzQF47ToHn3huT6IUVXJH+XKijtJJZDM0gNNeVnxLJnzDhwaY0XeY4PVK0LtyX74+JnRTvEkpUm1DyBtk3r2eL1r7f4bDCx+6OR/eSxNDBPgMpptP2GIE6RGGcesl7jnPC6d3FELbSrLnLkcc1IOekrZzjt+s6m94++wKrRpu/SBiEcwPb7Kzo5/GcoUHSoiZk/xZeyyIRdUzw7snosGt/TFaRSG6js2DxXihuftk2CpA7WEjRw1K+nlgn1Y0kunF+Xtxw7Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1P193MB0413.EURP193.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(366004)(39840400004)(136003)(376002)(346002)(451199021)(66574015)(83380400001)(6506007)(6512007)(31696002)(478600001)(86362001)(107886003)(53546011)(2616005)(186003)(2906002)(36756003)(38100700002)(8676002)(8936002)(7416002)(5660300002)(966005)(6666004)(6486002)(110136005)(4326008)(52116002)(316002)(41300700001)(66476007)(66556008)(66946007)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZEIyWEVkZUx1M1NQQ1NWYzdQOCsxYzUwUXlTZjZRRStyVkNtVk1WdnM0TjBL?=
 =?utf-8?B?V2dhT0tpWHhiTmJhRDZvc3BWdG5SMjNWblhpQlBFVUhqL0dOZ1VTRlN1Q0R5?=
 =?utf-8?B?K3hYbG5odVJYaTUvM3ZjQTFwOU9zVEpBOVBxbHd4VUsrZ2dRTUdTTllNRWJs?=
 =?utf-8?B?SWd5TCtBSlRCK2doVVdKS1cyT0YxRXQ4TEtZTE1XNnZZRGlzcXoyMnNjWUhB?=
 =?utf-8?B?MUVZM25tZGp5Q0lvdkowb2VDMTJiRmM2WTBXZlp0YUZPd2ZmWmI0Uk0zMnVL?=
 =?utf-8?B?VHg5VjZlYVozM21kVFVsT1RWNWRTMkpvRVBIRUk3YmNMNDVXcWpFb3pjcUI2?=
 =?utf-8?B?MUlYNytFa1c1Q0w0dk9laGxjNW5MTUxIUm8zN3JGMzVFUDlXL2RCQllsUG50?=
 =?utf-8?B?TXdxbVpxOEhZKzBRQWNVMkV5eW0zRDlpa3QyWUxqMUNSYlNxM1o5S3VUN2p1?=
 =?utf-8?B?czlnYjVPTnpzMHlVd3A0R0dmMjlMaG4wdVdqQUdNSVZhUzN1clkrZk5keVFF?=
 =?utf-8?B?eGY1N2E2Wnk1V2xCYWNNK1l4QWRvaVlENTFqbjMyTGdBajlhOVBkVk5UTlFy?=
 =?utf-8?B?dXUyN0lLRGRuODFUODBuYXlPM0pwWmR0Z2kxL0RhUFJMRmxRbzlYZjVJdStP?=
 =?utf-8?B?eExaWXZPWm1BaDE2RDVDZHh0VHNac1kvUG1VelZkanZQZTllb0NDM0RYSmxD?=
 =?utf-8?B?cGZldVo3eEp4UDZad291My91eXQ4YlR6MkxiRDRmR0FaeXVpby9manNGM01O?=
 =?utf-8?B?bFhJcUxKNmRiNlgzTWNBMGJTVWNZTXlmOVdDSnRlTnRWV255dE1OOTlDYUdz?=
 =?utf-8?B?ZndsWTVNQTBQZk1qTzV4MXNDZWhGVThFOXpEOE1lTTc1Wk1MZno0cVQ0a090?=
 =?utf-8?B?THlvaHYxM0VDeFpVTUphMVpWVkhyRUhRaGx1YzFwMkZtYkVBRWcwVnIzSjZ1?=
 =?utf-8?B?QzlQNEVMTTQwMlFVeFlhUDE1MzJoYzduR3ZjWWoyNmlhUW1EVDVRTFI2VmtV?=
 =?utf-8?B?ZjEycnI2cWowNm1PV1BpRDh4dVR3K2ZNbE5TeWo1MnFka1lFTEUwQVlBNmNP?=
 =?utf-8?B?RXlYU3JPQzFnd2VsYTI2dk5HakZoN3UxRCtDdG5qR0FhbUhOcFAzK1c3VU1N?=
 =?utf-8?B?TW9MWENsWjNMZ2Q0VThhNzNCWVppYUtSRlFBSTZHZ3dJTU1zYndvZnN4dE9t?=
 =?utf-8?B?MkFBL1BrdmhjOFd3N1duOWNxazU4dFMxQmpwZ3BoWmpKY3ptaEw1RXdoaHJB?=
 =?utf-8?B?d1FmV2x5dXdvSTdXMWZKa01xWmxHZm54QkVjU3Nadk5tWkJJNUE1UU5XNHZQ?=
 =?utf-8?B?K2VnaTJUcUFtS25iQ2tYa1dOdXVVS08xL0IrSnEzcW1wZlhEN0M1Vm9JVElW?=
 =?utf-8?B?M0NycmJ6VUhhMDhacFBENHRydG1lMTBEZVVYeVlURmF1YXNHeWNHR3pnLzNM?=
 =?utf-8?B?Zm9DL1Q5TkJleGVZZEJvWmYrcnYzSGpSRC9XWGhDcng1YUJKOC9la0ZrWTli?=
 =?utf-8?B?RUR4NGpMTmF3aWNqV0JsVUlQMnFuK1Y5Y0tkWmNLb012LzRsSVNYYm4zenk3?=
 =?utf-8?B?RlNXVmt2QUpjVk51cTJaTWpwMklMUHF0UkdPbGQ5REV2bXJJSXNwZDdUdElL?=
 =?utf-8?B?Q2VpZndaa281V1g4UkZXdjhBM25NMkdRY05PK3RYMmJmQWVGQmYxQUdERWZo?=
 =?utf-8?B?M3l3WTJjRTd1dXhIVGpBWGxFS01wUEZmdFJiT2w4blhjRFZsMzNTM2U0Z1Rp?=
 =?utf-8?B?ODBIa3UveFNXcTM5aUpnTnlSVEJueXBrcCtCc2lwZG9ieUYwS2ZVYm5TbWxY?=
 =?utf-8?B?YW5wcGJxU21hVVJMZ1d0aGs1S2g5REV3VlZGNWgrcElFQ1FmNlZtSlh4aFNG?=
 =?utf-8?B?SlVhaTJzR1VKTnQvOHNQTldYSm1WZmwxOFliTE9WWEVoc1FlRkp1U05ZcEJx?=
 =?utf-8?B?UzBxYmtkUWlJNFBJSlVqdEFOQkR5dEtNeXUxOThQbitZRmtPdFBaRlg3WU9i?=
 =?utf-8?B?aDlwdmJzMmQ4SGZiMG9kWWNZYmc4eXU2N1A2djVQL2tIbCtCdWl1RURpd2NK?=
 =?utf-8?B?S0JKRkNRVmp5cDVKOStZOFVZYXRaZ0dsaTBlNTc5MEh2MjB3VEYrZWI1VjZN?=
 =?utf-8?B?YzEyeW9xUGFWVURodXNwb1crTWtLTFBjcnp5Mi9aYkVMZE0xRnZMQnFQYmU4?=
 =?utf-8?Q?N9asAk4J/TOOsJUEL/Npf2XgoaEBFdZFEK6g3RyG/p+z?=
X-OriginatorOrg: kunbus.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57f5fe86-08e2-4b5c-51d5-08db5bced343
X-MS-Exchange-CrossTenant-AuthSource: VI1P193MB0413.EURP193.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2023 20:46:47.1288
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: aaa4d814-e659-4b0a-9698-1c671f11520b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Vd7iqpmxQ1TDVNVanAtiBefyUaVPsNllMXpS+5qAUridRKUapRVsBYImDBYDjuH2tvySByhICuOZrFWH/IlWqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8P193MB2192
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

On 23.05.23 20:53, Jarkko Sakkinen wrote:
> ATTENTION: This e-mail is from an external sender. Please check attachments and links before opening e.g. with mouseover.
> 
> 
> On Mon May 22, 2023 at 5:31 PM EEST, Lino Sanfilippo wrote:
>> From: Lino Sanfilippo <l.sanfilippo@kunbus.com>
>>
>> Commit e644b2f498d2 ("tpm, tpm_tis: Enable interrupt test") enabled
>> interrupts instead of polling on all capable TPMs. Unfortunately, on some
>> products the interrupt line is either never asserted or never deasserted.
>>
>> The former causes interrupt timeouts and is detected by
>> tpm_tis_core_init(). The latter results in interrupt storms.
>>
>> Recent reports concern the Lenovo ThinkStation P360 Tiny, Lenovo ThinkPad
>> L490 and Inspur NF5180M6:
>>
>> https://lore.kernel.org/linux-integrity/20230511005403.24689-1-jsnitsel@redhat.com/
>> https://lore.kernel.org/linux-integrity/d80b180a569a9f068d3a2614f062cfa3a78af5a6.camel@kernel.org/
>>
>> The current approach to avoid those storms is to disable interrupts by
>> adding a DMI quirk for the concerned device.
>>
>> However this is a maintenance burden in the long run, so use a generic
>> approach:
> 
> I'm trying to comprehend how you evaluate, how big maintenance burden
> this would be. Adding even a few dozen table entries is not a
> maintenance burden.
> 
> On the other hand any new functionality is objectively a maintanance
> burden of some measure (applies to any functionality). So how do we know
> that taking this change is less of a maintenance burden than just add
> new table entries, as they come up?
> 

Initially this set was created as a response to this 0-day bug report which you asked me
to have a look at:

https://lore.kernel.org/linux-integrity/d80b180a569a9f068d3a2614f062cfa3a78af5a6.camel@kernel.org/

My hope was that it could also avoid some of (existing or future) DMI entries. But even if it does not
(e.g. the problem Péter Ujfalusi reported with the UPX-i11 cannot be fixed by this patch set and thus
needs the DMI quirk) we may at least avoid more bug reports due to interrupt storms once
6.4 is released. 


>> Detect an interrupt storm by counting the number of unhandled interrupts
>> within a 10 ms time interval. In case that more than 1000 were unhandled
>> deactivate interrupts, deregister the handler and fall back to polling.
> 
> I know it can be sometimes hard to evaluate but can you try to explain
> how you came up to the 10 ms sampling period and 1000 interrupt
> threshold? I just don't like abritrary numbers.

At least the 100 ms is not plucked out of thin air but its the same time period
that the generic code in note_interrupt() uses - I assume for a good reason.
Not only this number but the whole irq storm detection logic is taken from 
there: 

> 
>> This equals the implementation that handles interrupt storms in
>> note_interrupt() by means of timestamps and counters in struct irq_desc.

The number of 1000 unhandled interrupts is still far below the 99900 used in
note_interrupt() but IMHO enough to indicate that there is something seriously
wrong with interrupt processing and it is probably saver to fall back to polling.


Regards,
Lino





