Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7A8670E6D7
	for <lists+linux-integrity@lfdr.de>; Tue, 23 May 2023 22:50:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238424AbjEWUuc (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 23 May 2023 16:50:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238095AbjEWUua (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 23 May 2023 16:50:30 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on0623.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe0d::623])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E06C8E;
        Tue, 23 May 2023 13:50:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=crDKVwMA58TYZT3d2k+1eknzBw0a7dExC/LrjamB8YNGUkIrMNMrjAzkibXjjI2KPVRZG99rFrxrmO1Lko7OwQ5Wt6kf1fNiQ2xKBnNj3aCeyVlaDIFNxU62RBMzv1lR5RF8n7ut5MXysZnHG58WXkSXBEQ6KLhVg03Hhhu+yr9Vy+1XgHqvqznvQ4c40s08IHpgJbBf9Q271wTTLQ+FhTbDUVHSFowDY7G0u8zl4EKJgnX2GZZT5C6aPM6RxAo/eUbXTgW1Icl0XGEjiyrtGZlgYUNP528ZfT7cy9JnLkzjw08HCgzXj94tP1IihtuoaLz5Q4G8qlvWoQ2F+ukv2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MREQLpgXMPp5hqFugSOst2Wpwa7K0YQwsTeiJXsY7zc=;
 b=TrQ5rTn/5LiUCuAoQCZmqukvC3WrjSDAJzcaPIjOaSZdW6TQvZiXBdyfBbt271meoqLSM+rtRk6IKjHw1WEH90cZEXQo9sojLkql4eLm7cApf3/XjG1t8qxImlYkJXcnf9EBArBfNYZLElUFsPK1W4a5iHcYxDoFY2g/oUvV4rjmLASbzWCf6SAxopnGDQdsJCGs+n1q3CvZl2geLOWA92UApSjansxQ2PCazh9eKBvSN6SNUsmpBf1nFoJDAAdmjjt8SWPerZHxwWYhHyNN9Rj1+u8VGC21cCEolv6VB2mlZ6tSt/wcltduc8pZ7OTFGSejoPQ8v+TgUDpPNeRrHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kunbus.com; dmarc=pass action=none header.from=kunbus.com;
 dkim=pass header.d=kunbus.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kunbus.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MREQLpgXMPp5hqFugSOst2Wpwa7K0YQwsTeiJXsY7zc=;
 b=sLCqlhH/EkqZ3R39qNRROLOv4qFXbLm4IrbZn5veB82H1t9ZPYd+ShNvjLkQwUGU9ruV5pJtXk9C1DXTGOiku9MCvsLOTMAJvuRzUJohFKKW8tS9WycgDS3q8Z5dNXiG1YI86w6Q3rhK9+tCJMOO5smNvpS1//84Gfxi/tfBk/c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kunbus.com;
Received: from VI1P193MB0413.EURP193.PROD.OUTLOOK.COM (2603:10a6:803:4e::14)
 by AS8P193MB2192.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:444::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.15; Tue, 23 May
 2023 20:50:25 +0000
Received: from VI1P193MB0413.EURP193.PROD.OUTLOOK.COM
 ([fe80::6727:e3fb:8fec:72a6]) by VI1P193MB0413.EURP193.PROD.OUTLOOK.COM
 ([fe80::6727:e3fb:8fec:72a6%7]) with mapi id 15.20.6433.013; Tue, 23 May 2023
 20:50:25 +0000
Message-ID: <6ca4496d-c125-ba01-8e1c-b05bb1fa57f2@kunbus.com>
Date:   Tue, 23 May 2023 22:50:23 +0200
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
 <CSTW066CTZ5M.2JR61D32CFSZL@suppilovahvero>
From:   Lino Sanfilippo <l.sanfilippo@kunbus.com>
In-Reply-To: <CSTW066CTZ5M.2JR61D32CFSZL@suppilovahvero>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0250.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:af::20) To VI1P193MB0413.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:803:4e::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1P193MB0413:EE_|AS8P193MB2192:EE_
X-MS-Office365-Filtering-Correlation-Id: a8744d78-fc22-4fbb-8946-08db5bcf5514
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZKMm9vcw/OKzkp+yw+OtacR1+wGyoR00xnJIVbepnoubSO2PJtjfjKvWVvZMol4Cb5CDpOyFnMvV2s0Z+1DiHNDQ9zeo1vHrUIYbsZ1xVL6fxLtVIdCQeo60ZGh9Ywa5lpkSgYqcOFLScdMm2qi8JcPTMdEya9idw4ZbauXi5gAPLUvLgVbRbBAdN4XXcl4x1IBfSa9LboMH3P8vSHnYVNdXrSOJ2GgkWYubWz3isZTaU6NwK/CxsliOLKWLRuzshACw2udACFZDN9SK3+/nqh/RO3RCXIzOyp5ftLLXD/5I4gFbL4OVGA9JAo9gAkCnc6dHjJt3krIPXYZ/rP+MmY/pMNhjoNDdAHMcYRCCHaw7AIVo94WF6tn1SLUCHD7AcMtHY3C6fnSPmNxvvgQPlL+0ALmRAUYbFnf+8BuQjcQvlkkSPiSb1NmCQkz7eZtKKsBjjTp/vk7AiHkAB3AJdfNtSgP6qY6mOO43DKKRKsN+MXJfFXy8y0KpIv7UIwRK3PsoGbvFYZkeXVAiqcpaCcryV711nhP6XynR6KD03xorCEJ2tcrUPJ7zaXzvta1ghI3V3/uwteBG+P2ddvy/spap+/48zRxR5KPTedC9P2RWeiXTafr35K/rT8tcsi/gcPVOwueHdQfNVaqY9yG13Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1P193MB0413.EURP193.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(366004)(39840400004)(136003)(376002)(346002)(451199021)(83380400001)(6506007)(6512007)(31696002)(478600001)(86362001)(107886003)(53546011)(2616005)(186003)(2906002)(36756003)(38100700002)(8676002)(8936002)(7416002)(5660300002)(966005)(6486002)(110136005)(4326008)(52116002)(316002)(41300700001)(66476007)(66556008)(66946007)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L2kyVE5ZV1I2WGZncmpzK1VmU3RKQUd1dUovVUM2a21HQWVjY2R0RmI5NDBO?=
 =?utf-8?B?MmJPMnViQlpjRU1Ta0hzRlhzUFo3cmNkQVpOcEt1TVAxNGpOWHZ5ME9KaVZH?=
 =?utf-8?B?NmMvd2hxY1JOSjFKSmJwMk9ndnJGREc1bmxkVDQzVklZSmh0YndYb2NLbGFQ?=
 =?utf-8?B?cTd5djVFKzBLVUZRZHdSWjZBN2V1ZnQxeEpZT3lHZWFKdi9KVGVvdkQ3eHc0?=
 =?utf-8?B?Z2tlNFN2N3hteXVic0xBLytLdFN1SE5rdHBIUFByYUV6STZGeE5SY2QzS1Zu?=
 =?utf-8?B?QTJ5NEtMeU8vcEVZRUREMW16bHljM3cxZ29NUWIyZFcyKzQxZHFWV2Y5ZnNj?=
 =?utf-8?B?VmVWT1ZhLy85WE0venBDUVNLZTUwZ3pBSFdESGF1ZmFpL3A1WTNVcDdXSkg1?=
 =?utf-8?B?T2p6ZXNHNVMySjIwbTdyUC9tQWF2NWtsOFpUckxwdithUkIvaXdyVGJXRWlG?=
 =?utf-8?B?U0pyUUt4UEVKWFd4WDY1WjJtMDlMaGJKTmYvcGlrcEh3b1VNeGR3b1A1N0Nz?=
 =?utf-8?B?Z0h6MHVTbVlQRUQ2dmpMNEZUWnZONG1UcUdqMTVWOW1TQmpQUGdGM3lvd0Zq?=
 =?utf-8?B?OWlBMFQzWk5TNGtmSFY4Wk5EM3lIUnZxc2dwcWR6QzdSN2RPSXpkZjlhWjlJ?=
 =?utf-8?B?T2JCM01tR3RKcFlzSk9xTEoxcTlLdm1SN1o3ODBlb1Y0NVpxYzIyV25DNEZP?=
 =?utf-8?B?UGRzNW1wditWWE1nN2xZdGh3bGNSRlZhbmR6Ym83YWEyUlhKOFdzNnpRLzQw?=
 =?utf-8?B?UU9tRkpRN0Y0b3lsTDJoWktoVXFyaUFXbm1PWHAyd04yWWd0aEgrS2xDZ0pp?=
 =?utf-8?B?cVNuUjlBT0g0Wnd3MkZEQVhKMGRFbGlQNC9VZnZrT1p6ZzhCVit5N096S3BP?=
 =?utf-8?B?eWQvUHRGV1ZpaUlwRGFhTnVYYmd1WEdOQURnSS9kMjVqWnlGcGFXbGVRRm5C?=
 =?utf-8?B?SVBSdFAweWtZTU1lRmlDeFB3cFQ5WmJ2RXhyd0dYYTRTN1BSQlQ2OTllK2tF?=
 =?utf-8?B?SEdlYVVCdUtRcTQyMDVDd0dlVDk0MzE1d210eXYveDRxa3JoMld6K2E3K3Uv?=
 =?utf-8?B?RW1VeEsyU1VRWlgydFFlcFZJME5KODZuRTJtMzdMbDBuaHN2ZTRKSE1kSkU1?=
 =?utf-8?B?dmx4NVBCcW5Cc2lhS01UN0Z0dElLYWZTdVNIeGVNeisyamc2dVBQQUNJQ0h3?=
 =?utf-8?B?Y2Naai9KK0JMbGQzRVZhdkhYQS9kQ0orZ3dLUmFnRkJmQ25CVkJVTm03TnZJ?=
 =?utf-8?B?dmJEb3RJSzdWVEtiNDFzbUpNcUsrQzBlUzk3eFFDUjNZQU1TN3lnQm04Mm1k?=
 =?utf-8?B?enlFRGtBT0VsVnI1Q0R4QlFrNWtIU0JyQWRnTlRjdW5TOWMxT1A3VDVEdkZu?=
 =?utf-8?B?SkM3VzEza2ZYOXBiOXpya1dOQ3F0bGdrTmQwTTRmNjdBbTVXdzgycTcwY3Fh?=
 =?utf-8?B?UDBLUFVEbXhURlM4SFZlb3dvVW1QdWFrNnpyWTQwQVVaMytJYlU5U3FIVFdF?=
 =?utf-8?B?WEtQNmhkU2o3VmIzaEx2WVVCL2dmK2hseVZBQVlQRktOSG1iQ2F0bVU4djQ3?=
 =?utf-8?B?cXBWYWtGTWN6ZkRuQXFoNkVHV1NORm9zM2RSY0s3S0lleS92Y29pYWN1STNr?=
 =?utf-8?B?Z25ZSHdEUWE5bFM0Y0V0NWMzK1YzR3RiK2EzYlVUOFRVRlJULzI5QjEvOG1x?=
 =?utf-8?B?Nitjelg5MmpMNTMyOFFOMzZMeWpaVXZ3UUZqOVM1R2tGOGRXNXViWnZBNElM?=
 =?utf-8?B?aFlmV3paejBESU5LOCtEZmVOS1hHdEJ5cDBPQzNybzE1MjZNU1FPSWtTL0hP?=
 =?utf-8?B?RzN5TmZ3S1YwR2J1N2IyK2VFb2J5UFI5bjVGNll6NmxNdUtVRS9WR0lJMkg4?=
 =?utf-8?B?dlE3WUwwL0tDSmUyMGJuRkZTVGJjSzV6dGpuQzdNVm41TVFORHVuSlB4WWhC?=
 =?utf-8?B?Y3NJSGFTdUlpUi9mamcvbk9yZFIreXNUU1p3YUJ0VjJiWWJlMnkvMk1IVFZy?=
 =?utf-8?B?REZGZTFTTlJ0Sm1OcU4zV1pObkhiZUNBNFhiTG1FT2JrekkydFAxVkN0UUV6?=
 =?utf-8?B?b0ROb2FCa0pDMDRhcFNMcDdQSkNMT2M0Q0xhdys1Z3VCamU3MDIwd0lXQWpZ?=
 =?utf-8?B?cG5vU0FyNzNId0dMWFZLZ0dPUVJXMzBlbUIrL09RVEE1SklLZHNTWlArWjBa?=
 =?utf-8?Q?z0VqVrvtkek9HlJgqH4QCwtkVQ5gklqOqbqRYyY4+vJU?=
X-OriginatorOrg: kunbus.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8744d78-fc22-4fbb-8946-08db5bcf5514
X-MS-Exchange-CrossTenant-AuthSource: VI1P193MB0413.EURP193.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2023 20:50:24.8723
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: aaa4d814-e659-4b0a-9698-1c671f11520b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bigWRwioUa8+yTAOCmYYD+FcHAEcs9XNgxmXvT6L5hyk209ZV71OQsW8VBDOlaLgvqdoV3rhoPiQJtV2n4C8CA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8P193MB2192
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org



On 23.05.23 21:00, Jarkko Sakkinen wrote:
> ATTENTION: This e-mail is from an external sender. Please check attachments and links before opening e.g. with mouseover.
> 
> 
> On Tue May 23, 2023 at 9:53 PM EEST, Jarkko Sakkinen wrote:
>> On Mon May 22, 2023 at 5:31 PM EEST, Lino Sanfilippo wrote:
>>> From: Lino Sanfilippo <l.sanfilippo@kunbus.com>
>>>
>>> Commit e644b2f498d2 ("tpm, tpm_tis: Enable interrupt test") enabled
>>> interrupts instead of polling on all capable TPMs. Unfortunately, on some
>>> products the interrupt line is either never asserted or never deasserted.
>>>
>>> The former causes interrupt timeouts and is detected by
>>> tpm_tis_core_init(). The latter results in interrupt storms.
>>>
>>> Recent reports concern the Lenovo ThinkStation P360 Tiny, Lenovo ThinkPad
>>> L490 and Inspur NF5180M6:
>>>
>>> https://lore.kernel.org/linux-integrity/20230511005403.24689-1-jsnitsel@redhat.com/
>>> https://lore.kernel.org/linux-integrity/d80b180a569a9f068d3a2614f062cfa3a78af5a6.camel@kernel.org/
>>>
>>> The current approach to avoid those storms is to disable interrupts by
>>> adding a DMI quirk for the concerned device.
>>>
>>> However this is a maintenance burden in the long run, so use a generic
>>> approach:
>>
>> I'm trying to comprehend how you evaluate, how big maintenance burden
>> this would be. Adding even a few dozen table entries is not a
>> maintenance burden.
>>
>> On the other hand any new functionality is objectively a maintanance
>> burden of some measure (applies to any functionality). So how do we know
>> that taking this change is less of a maintenance burden than just add
>> new table entries, as they come up?
> 
> I feel also a bit resistant because leaf driver framework is really
> a wrong location in the kernel tree for IRQ storm detection.
> 
> It would be better to have it signaled above the TPM driver, and the
> driver would then just act on it.
> 

I agree. But currently I do not see how to achieve this as there is no way
to let a driver be informed about a detected interrupt storm. So the only solution
I see for now is to implement it in the driver itself.

Regards,
Lino
