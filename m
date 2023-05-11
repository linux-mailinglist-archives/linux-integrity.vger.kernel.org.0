Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3092A6FF3F2
	for <lists+linux-integrity@lfdr.de>; Thu, 11 May 2023 16:22:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238407AbjEKOWY (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 11 May 2023 10:22:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238414AbjEKOWV (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 11 May 2023 10:22:21 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2083.outbound.protection.outlook.com [40.107.8.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1BC5D2D3;
        Thu, 11 May 2023 07:22:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lqQAX5Ybpz3djPLRrOHXsRfzB0TWBIclFNtwxkvW6FAplwQei+1M4pIG1i3gP9DIgdRx+zgKanhpUesD0C9LZ2cq9QAsJitVG/oBCcwEyVSC20GEA2R7jzj5ePHtLjJGm+yrrDeNboc2owl5TGFeEcrN5CnaQooVsrhyn+XAhAGlTjRdjGo70ncXhn2vZh8zjLLuDpOar4UMJQhy7teioJsALqdKNbCxwkKeGs6OGMFp1OoaXgiLjfXxXmepvlDFeWNbLJAYyNQcYIDo8ENKNjDaFGtALZT/nN40Vk49f+KtghsnjD2ytSk9SG/Ilr1Bs2jLebJvcIazRHMJYjZZTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XHEswNYGD4isK3XikShGJsjsdVHpmKUFb/aFmyj7e4Y=;
 b=dXQsdl2YdiGYYM8yRYqomTixF8PCcrNJ7lj/cBke3RR4QOwBrjXJWPOPninNco9hyd5+zRvsTjLoqMyPTtC1NOW6PbYnWwRbWSnj1MFBD2nA8bUpJGYH0Z28hxEVj9yokEsKb+DRFTfebU/AsW1rnBAXhByjExtF6S3hAVF5FGhFOFmbGp/tjnlOZTVPnCHcbCvJEVI2LOF7VU9t+0K6da1sYj6yS4iXVYoLkiwUK5beSAAAmgIupqtlNXE8RNZiz1nrWKWZ0f/NqFn6GLyR1wKuH5X9Wjrf2Ca93mZNKp5EcBh1mt4bgA1oVkJwRBSmnc4WU+iijDKS7D6dsUz+tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kunbus.com; dmarc=pass action=none header.from=kunbus.com;
 dkim=pass header.d=kunbus.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kunbus.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XHEswNYGD4isK3XikShGJsjsdVHpmKUFb/aFmyj7e4Y=;
 b=GsIf+SSP89uwiSg76zucjH3vJ74mC7O0rTsv6e1vu4Bj/6pKb2JYHVIesAbm3VPsjKSBDPqAhq/5qc9j0w7yGgFNGHe8NYmNdw1pRAm71lH6h/wg4O9ghUMI4zIZlE34JGYa+qeCT25bDfVCmo9zJaUek+Ub8GKBSNi+IscW0KQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kunbus.com;
Received: from VI1P193MB0413.EURP193.PROD.OUTLOOK.COM (2603:10a6:803:4e::14)
 by DB8P193MB0695.EURP193.PROD.OUTLOOK.COM (2603:10a6:10:147::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.6; Thu, 11 May
 2023 14:22:04 +0000
Received: from VI1P193MB0413.EURP193.PROD.OUTLOOK.COM
 ([fe80::6727:e3fb:8fec:72a6]) by VI1P193MB0413.EURP193.PROD.OUTLOOK.COM
 ([fe80::6727:e3fb:8fec:72a6%6]) with mapi id 15.20.6387.019; Thu, 11 May 2023
 14:22:03 +0000
Message-ID: <1a8ecf90-80a4-9aac-95e1-9ce0c4e09ba5@kunbus.com>
Date:   Thu, 11 May 2023 16:22:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [linus:master] [tpm, tpm_tis] e644b2f498: RIP:acpi_safe_halt
Content-Language: en-US
To:     Lukas Wunner <lukas@wunner.de>
Cc:     Jarkko Sakkinen <jarkko@kernel.org>, oe-lkp@lists.linux.dev,
        lkp@intel.com, linux-kernel@vger.kernel.org,
        =?UTF-8?Q?Michael_Niew=c3=b6hner?= <linux@mniewoehner.de>,
        linux-integrity@vger.kernel.org,
        Philipp Rosenberger <p.rosenberger@kunbus.com>,
        jsnitsel@redhat.com, peterz@infradead.org
References: <202305041325.ae8b0c43-yujie.liu@intel.com>
 <d80b180a569a9f068d3a2614f062cfa3a78af5a6.camel@kernel.org>
 <42ea93a1-3186-b8ff-c317-d51f3e13856e@kunbus.com>
 <20230511141607.GA32208@wunner.de>
From:   Lino Sanfilippo <l.sanfilippo@kunbus.com>
In-Reply-To: <20230511141607.GA32208@wunner.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0016.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:15::21) To VI1P193MB0413.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:803:4e::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1P193MB0413:EE_|DB8P193MB0695:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b8228b5-72c2-4a44-ef7d-08db522b1798
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oHkQanu5B6MeIMRBCRbFXIo3g5iU6AaW1LEb7g/3OdHqCTsVCBpQ2eyLg6dBZQefx3sXGqjJKptWtVjpKvtCJFoLt3hDRKgeU+cZLPyrQy/Nq6h5/3q8m2K3e7q2V3pNoUFgx3ef0nk1kzXU+AX7hiPNOPBtzHuZ+GZEP10rMjI+TlYr2+2oQqsHBPvs9F2WE2mfDCrO26egSk0+AcA6/LQJXcYc1WUqU7datn/+dL4rMgVtCTGMEIThT3vMHNhPbgRTIr73QvMUfdFbFpsl0/r1IopcuvbXJaP6fFUQg2kyNb1LnxD4kgVSK4B6asOPFVMykO8aC9lMt44y5rwTrwB1GykHz6CZKtG5h5nGCRbk3Ae+Oxan0FIeOIiAZVG9wBmx+H6sJsLx6ZH0J8X8jkqGdjF7Qid2fRgK663wksmU6kqgu5D2u9Ld4KoCNYJytNpUyruvAOWi37MVanOpc8Lgf88Qwcan7gcRJAP0CJAKKm7Z+FPcA08KVx6N7diNQbh0Dc5OmHGJXqimSOhQEgH7PmbOlqsS/RV7NyOQ8gRc9fqB0gVQyUBYb+hL3tqEWfemP95NSEtmo7ZwXu7KO76cEkaOjzklQslCuuX7phwZdJ+CbMmQPr3q3WHPXIDKfZlIkEEFd7w/YgbTySrYmw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1P193MB0413.EURP193.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(396003)(376002)(366004)(39840400004)(346002)(451199021)(36756003)(38100700002)(86362001)(31696002)(31686004)(8676002)(52116002)(5660300002)(478600001)(6506007)(6512007)(6486002)(8936002)(186003)(53546011)(2616005)(83380400001)(2906002)(66946007)(66556008)(54906003)(316002)(41300700001)(66476007)(6916009)(4326008)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VE9pNGVsTWFuTnorNG9XU3VTeUlEbUJiR25nUk16MkdpTU55ck9lSStkTG0v?=
 =?utf-8?B?RFRiQW42WXB1RXA0UVNiZyswa0xvaGdNdU9DY0M2T3dDV2UzVUpZRDk2V3g0?=
 =?utf-8?B?bTJMbDhYdjhibHU0YjFETUc4VHpOWndxSytWaGMrVnAzWVJUNmx1Ymx5Z2dJ?=
 =?utf-8?B?T3kyQlJpQ0g4QnhEdG02b2lmTytUTGFVcURkS1paRWJHMWh4S3dBd1FPSVEr?=
 =?utf-8?B?TzlYZExLNHoxNWpCU2tGNWlHMUMxMVJ6NWpXVTFlOE9WOUFNZkY1K1g1THRZ?=
 =?utf-8?B?RlJqMmNndVoxbFRkbEp4NHhoTXlqaEFBblBEVUluVXVkdU9HU1RLOVQ0Y3VG?=
 =?utf-8?B?ZzEwVGdmOVplK0hSaTZ1SlN5aVJ2RWwybEdJakRKU24zeEhhVGlDZkZDVFRy?=
 =?utf-8?B?cWxWT2pFN0UzcnpSaytyZWtLMTJxcy9oRERKckJDS0FOajJiY2JUajFtTTYw?=
 =?utf-8?B?Wk5UUUxVZU5USlVpa1ROajdDVUNFZEVnOWZ1UE1kUmZCWDNYYkZKQ1ZpWmxP?=
 =?utf-8?B?Q2dxOEphVFJWWlNtQWtCTCtZMjdDYzMzbE9LcnlhVU9xVU15cWFVUGlXNXZa?=
 =?utf-8?B?U2l2d3ZNMTlHUEE2T2ROS2pqSHdQSVVyUEJUNTdsdzRYUCs1OWhHTk85a2tB?=
 =?utf-8?B?RVpXcms0QmdLWnJEdE5RdGNUdlBNVHUyNVpLbit4NkRWUnhnMWxwUWphUHkz?=
 =?utf-8?B?c3NtSXM3UmdVVkdVblkzQ25HdjFsclZHYUJmTVlSWXN0Yjd4eVdvSjV6SnND?=
 =?utf-8?B?cHhrbmhDWXA0SlRHNVRUaVJZWjJ2N25TTUR0WmswcU8zRHlQUmRYb3VSV2Ji?=
 =?utf-8?B?dURGWDZXUFBNTWVYZ2lUWDRFeXZYZTBvVEREZzMwaGJ3YVE4b2ZGb3pCdTkz?=
 =?utf-8?B?Nzc2SEJ0SHhwcEIvZVFrZjl5dXVyUmRCSENmUzMxRnNscnR3eVhreGt2d3hC?=
 =?utf-8?B?V1FaNWMxazMyWDlXSW5TVk11d2NlVml4WE1mODRwUnA1Sy8yeGdIQS9TSTBl?=
 =?utf-8?B?U01qUXdQY2FYaHhEeStwYVlac0NqSHpLb0xMOGRiSWIzbWJxY3E3WjU1bENW?=
 =?utf-8?B?RTFGT0pwdXpva3RmaStrcWl3bUZIdW5JUGhpVEg3Vjc4TW8xT3k5K3pnY09H?=
 =?utf-8?B?ck1IR2owSFVRZWFvNlhUcUM1NVppV054TWh0d01vZ3UwMUpVQnQwZlRxSWpt?=
 =?utf-8?B?TW84elp0eDI1em56RXlpSTJObHdlbjJMWFVrbUppcXVweVR3UWJPRlk4Zkox?=
 =?utf-8?B?OSt0Tm5FaXJjNHV3ckVmZU5iK3BhT1dyRlhkUk1yaUVNWnN2b0d1RzNDd1cz?=
 =?utf-8?B?TFB2aFVsV3dNTnp5bFBQSU9wUmdwc3V0akNXMDZUY0N0U2VQWGZvNHBrOW9Y?=
 =?utf-8?B?MHlnbmo4a1QrUmFYRjkxaThsRExzL1IwcEE3N1FhTUVCblVrY0NlNkhwb0w2?=
 =?utf-8?B?bk9UV0ozbFdrb2puOU0ycnhGbkRhQ2RuTEMwNTZDR3p4cmNHZm1QaGF3UkN2?=
 =?utf-8?B?bDIvZEM5U0VNZUx0QklmOVB6eEpWU2xNT3J0c0daV2pHa3hxSVFhdC9oN2RN?=
 =?utf-8?B?eFNTcTgzZDBDaDJWR1hqb2FPTzNTTjN1Vld6MVkvWDJDMG9FTmJNdUtRNUh4?=
 =?utf-8?B?cysxbDgzaHNQU3dQUHZWRE9WaWhaNG1Xd1QzTzlrN3dVVlV4V2wrZmdpNkJS?=
 =?utf-8?B?ZDZRbVhZaGtkRUFJejF4VVQ3NDFGcnhab3NMV0JQTzRqWmNCRWRLNjdFS3Rp?=
 =?utf-8?B?S3pyemV2NWZDTlV6d0NtWnh0c1IxVitJV3hkTzFDZ3VXUXN0b1Fza3hGZjRS?=
 =?utf-8?B?K012Z2RReDRHcTB3TFIyT3gzeWpXRCtiOFYySkt2TGtRT1dvWnZiU1ZKblhk?=
 =?utf-8?B?SThTdlhPNk44ZDgzZ2dwSUlWdWVURDQybDRMUWdnTVlBWjBVYVRVS0ZGeUxB?=
 =?utf-8?B?UjZucmVEYnVkZE9tZTdpOCtNMVlqZk96RDhwL3RnZkpkZFZ4UW0wRmFLR0Jp?=
 =?utf-8?B?dlJNWDhDaVRSM1lUUGxsOVJobENHNzZOM2dLa2EzVS9zeGRvdVNjdUlEM0Zw?=
 =?utf-8?B?emM3bUVOTmJIaU9lUXlFWkdIV3RDdGw1YTRPeHliV2FBUXN2aFRxeThZVVpq?=
 =?utf-8?B?bFB6VTdzVk5ESEUzN2NDS2ozV1lsbGNtMTEzTlpLRElzNS8zUktHajVTVHh2?=
 =?utf-8?B?WkZ0NU9pd0xFbURDUkh4Y3J3N3dBUHhqMDBqTk8wQTdWT1BZREROTWFtQkY0?=
 =?utf-8?B?eVRObDVQdUNDQTZTallOUXRLVklnPT0=?=
X-OriginatorOrg: kunbus.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b8228b5-72c2-4a44-ef7d-08db522b1798
X-MS-Exchange-CrossTenant-AuthSource: VI1P193MB0413.EURP193.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2023 14:22:03.7548
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: aaa4d814-e659-4b0a-9698-1c671f11520b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a0Cwl47axlk1/eRzaOHWWR/U/jO2OLp+rj2HwhWN0738V6/vaf+UMq6aG9e8jbe+Lsysn4m0sd5ZpxbwTUoGsA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8P193MB0695
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


Hi Lukas,

On 11.05.23 16:16, Lukas Wunner wrote:
> ATTENTION: This e-mail is from an external sender. Please check attachments and links before opening e.g. with mouseover.
> 
> 
> On Thu, May 11, 2023 at 01:22:19PM +0200, Lino Sanfilippo wrote:
>> Since beside the one reported by Peter Zijlstra
>> (https://lore.kernel.org/linux-integrity/CSJ0AD1CFYQP.T6T68M6ZVK49@suppilovahvero/T/#t)
>> we have another interrupt storm here, it is probably the best to handle those in general
>> and to disable interrupts in this case to fall back to polling (this is also what Jerry
>> suggested in the thread above).
>>
>> I will try to provide a patch for this.
> 
> In tpm_tis_probe_irq_single(), after you've requested the irq,
> you could convert it to a struct irq_desc (via irq_to_desc()
> from <linux/irqnr.h>) and cache that pointer in priv.
> 
> Then in tis_int_handler(), you could access the irqs_unhandled
> member of struct irq_desc (from <linux/irqdesc.h>) and check
> if it exceeds, say, 5000.

This is the solution I am currently working on, but thanks for confirming that 
I am on the right track with this :)

> 
> If it does, schedule a work_struct which calls disable_interrupts().
> You can't call that from the IRQ handler because devm_free_irq()
> waits for the IRQ handler to finish, so you'd deadlock.  You *can*
> of course clear the TPM_GLOBAL_INT_ENABLE bit from the IRQ handler,
> though it's unclear to me if that's sufficient to quiesce the
> interrupt line.
> 

Will try this, thx.

> By reusing the genirq subsystem's irqs_unhandled infrastructure,
> you avoid having to reimplement all of that.
> 

Agreed.

Regards,
Lino

> Thanks,
> 
> Lukas
