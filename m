Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CBEE776C1E
	for <lists+linux-integrity@lfdr.de>; Thu, 10 Aug 2023 00:22:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229969AbjHIWWJ (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 9 Aug 2023 18:22:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbjHIWWJ (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 9 Aug 2023 18:22:09 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2050.outbound.protection.outlook.com [40.107.244.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C7DDAC;
        Wed,  9 Aug 2023 15:22:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DSO8KEQSD5b9Md0pw7of/zh1GqyQa8R8IzdLHFJq2/xrMWbA/pUHqY1qAeKPw9/2i1I6mwWqF+wzIaJoxsdGRmo9LgFNkIi2fMybEf5DTZTSUOwenMXXR8hWiZEHSSfo7od71S5Na+tsu9rXClHuGHrRPJZnNun5r/bjhxm0u9qybblNsicGf4z+gEPAb4Y2Jc7LTce9TvgJWGgM79niz0tVChSwtl1kjbdaM0gCF0oMbAd5lb/4iSyxWeBQSSu6BuaK7vllf64dNy3nlnEw1dbgztlqMamN5LscN7+XeL647Kt9FdvxBb+JDZLASona5xgXhVjv3RGfmXOFn9Hxig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZGhXk/N9cKWyy6azyDvbJKviclBnN6yT43PiqfAyskg=;
 b=i4T4C2kSbWGzeWmtHxsfhy7ScrM6NYJ/l6Vyg9dMxYXUPr74FYHnpQVgs3kEkKWrtbaVUgvTOXNRKq2UXa9jgj0M08to4GM0wEMEIsZXKyEDVGywODKYxixaPh3L0TWMQVa9JZrfcS23g5L5Tbq2xPrD9BpkbA8/XpkPeMOpPI+tlhrk4ZG8qvK11HTVEf17sePIxliNHy+P25kFSxEdUTVdaF0VmuhSZK5Z/GjcZR80j8ifd3zt+HeaWjZU2wPKm5aVt65/LNH0YyoCKfOAtvqg11WQwmG8CSwet92df9IQQUcMyRiI60We+COxUS2kYWY12brTxC7SKQEZMSlPiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZGhXk/N9cKWyy6azyDvbJKviclBnN6yT43PiqfAyskg=;
 b=DfHkXuzQL2+ag74PYTq1m6Y3zELlrFN9kwqJPGZm6ZllWjXl9mkr8rZ7xu2zkrORzk4IfWrkPn+71TsnMXzSvFElX9XDO+65jnmaZ8dGt0EDooXM7rQIE2tp495IklN1K3AKthhmPvtKLHT5t4mie3f/EFBXeIQLNtFQvj71WaE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6095.namprd12.prod.outlook.com (2603:10b6:8:9c::19) by
 CY8PR12MB8241.namprd12.prod.outlook.com (2603:10b6:930:76::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6652.30; Wed, 9 Aug 2023 22:22:05 +0000
Received: from DS7PR12MB6095.namprd12.prod.outlook.com
 ([fe80::44a:f414:7a0f:9dae]) by DS7PR12MB6095.namprd12.prod.outlook.com
 ([fe80::44a:f414:7a0f:9dae%7]) with mapi id 15.20.6652.029; Wed, 9 Aug 2023
 22:22:05 +0000
Message-ID: <26bcc3ca-0543-43b0-a43b-2d913505e000@amd.com>
Date:   Wed, 9 Aug 2023 17:22:02 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: AMD fTPM patches for stable
Content-Language: en-US
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>, stable@vger.kernel.org,
        gregkh@linuxfoundation.org, linux-integrity@vger.kernel.org
Cc:     jarkko@kernel.org
References: <ZNQGL6XUtc8WFk1e@zx2c4.com>
From:   "Limonciello, Mario" <mario.limonciello@amd.com>
In-Reply-To: <ZNQGL6XUtc8WFk1e@zx2c4.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR11CA0146.namprd11.prod.outlook.com
 (2603:10b6:806:131::31) To DS7PR12MB6095.namprd12.prod.outlook.com
 (2603:10b6:8:9c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6095:EE_|CY8PR12MB8241:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b1e2e68-768a-420a-be74-08db99270ffb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8Yj1xOxAk36u6QoPscPjz8yY2k7EU68y/QjFbw7mDC1L/c8p8s078Oarbvy1h9lbq5Jf8oe/O16zUzgbgHZxXFx+pbVqc4h1os+IQtjvt1WZQS8V4JPM56+IBgzJkKpTXd1iRsULm+p6tA8PEfww7rmwPJrB10SJQjHLdWcVz1kL8dfq9C3yZbD9pqOuNewAl/7IAH92ynrGDk7FBcYU+2T34cInjVdvUL/mLszdxHA7gGxk0TZy7sO5tBJin2vi1FVE7SICayLUyUOxEUPBBK11ZHBUOFEWs9jxpSG36rT1LuTVRmXUQ4SQ3ElhXlz8l8gFIhokwlHqzcxiztimrs5R/jdjNlyVhB6geR6Q1GbjclS2jUK6xih92TrPxNEdtR/g/GzxkHIp+F5nXrFGjeb203CtSD/wn7DaM7y0jjIW4C3J/siRikeO61HEvmG7AfK33Z9bwTEWKtEr8Golpg7HFBswlqe8J0VAHRULSAvP7W21QOhiaiFsUo/vfJR0ZX8v24DWvtS3gQ/KJNH7VBysmyD0gfdY7fyocfUSdR8GIhhJJITujFtxEj6/AqMr/pF3HgVmGsox3AoMm2vL/uHVbZEIBx+uS8WBudG/bKdzdemiybJgXGFmXFExhc2jD9m66LaRHdsdu5e9fZniszqoliag4yB8LUEmLaGE/VCIVcfgQBKQA35tQLSI4Fo+
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6095.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(376002)(136003)(346002)(39860400002)(396003)(1800799006)(186006)(451199021)(31686004)(6486002)(66946007)(66476007)(66556008)(26005)(53546011)(6506007)(6666004)(478600001)(36756003)(83380400001)(2616005)(41300700001)(316002)(4326008)(966005)(6512007)(2906002)(86362001)(31696002)(8676002)(5660300002)(38100700002)(8936002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RUdkMHZHSFpjVWxjSGJ2K3g0aTZ6NUl6cUlRMlJBSVpWVHY3cFlKVG9VSTBF?=
 =?utf-8?B?Y1o5R0wxMFJHUjBONEhOKy9zWTZsMk1ZOEF2OUNGdVlXcldRUzMrSzJhQkhw?=
 =?utf-8?B?MnB6Tm1kcUhReDAxazZxaWxsY3RjVVRPcFNHRlY2S3JsdVpDb2hMUGJKWmlU?=
 =?utf-8?B?dTIvM0ViQUtqUHpvTHZVUGlnRmMwbGVJTXRoSyszSmUwQlZJT21nVnpCR0lR?=
 =?utf-8?B?bmI5MFZSUE54Zm01NmNvc0orN3R2M2I2RXVqbXVsZzFJcGJreG1VekZ3eUlJ?=
 =?utf-8?B?SUlTYk4zR1ZmbzRtY3NNVER1SVpYZHJCYVNDTEQ2OFN0Uk8yYnZNTnFKZTJF?=
 =?utf-8?B?UUU5K0VTS2ErZzhLc3RLK256NTVNdFlNSS9Nc1d6K1ZoSnpuYWE5ZHNNQ0wy?=
 =?utf-8?B?VU1CUjdGeWRtNFZlVmRySFlMc04xRXA3VTdub012K2FIcHYxQ1l6MVZYZTY1?=
 =?utf-8?B?ODdxMnJLZTRCdEh4cTlYdFRCbnJ0NzRKYm11cHVRT0pZc1pyMUYxd3MyRHpw?=
 =?utf-8?B?YVVQMmRnRklVUE1oMks3M1NTMlpJZUlQYlZBMlNETm1vNDRKTjVWQTM5Ym9V?=
 =?utf-8?B?bHBJUUo5M3lYWEdWWjNsSlRwRXNkTXhyZGIwV0FTL3RxdlJaZ3dQZm43aTNQ?=
 =?utf-8?B?RGZDcWpKQVFJZklQL0czakhleTZGeGhKQldIM1hhTjZFc2tjc2hHSkJMcDJu?=
 =?utf-8?B?ekZKNGdOMTdCTkZNSk42WXRBVFBtQ1IxaTFvajR4ZzNVYnAzUExWYWpYZGZP?=
 =?utf-8?B?TVkwUEhwdnRzbEttRURkL1AzOG81ejJ2SDdoeHVSMlR4QUpkOExGaGl4d1A3?=
 =?utf-8?B?UUlSL3VTVlBPeVhWVWhIS0xrVkxCQjdubTNEaU11SnRMK1hwKzI4M2xvSm0z?=
 =?utf-8?B?ai8zZWhZcVRYTEFnUkhnRUQyTzZwVU1ReGZzd2h4OENaR3ZmdnlJejNOS2hu?=
 =?utf-8?B?THJnZXFMcEZ6eVRrazdQM0JxcDk3cnA4ZUdvMUd3cFdiVlhzMENocUN2UEZi?=
 =?utf-8?B?eTgrUVd0aHZ4NUtGTjg5bVA0Y0kwMW9ZTTdId3l1RElyWkxCRjI3bkxJRXNu?=
 =?utf-8?B?cmxFSjVma0tlSnZ3U1U0QkxJeURoZWhwQU5yRkgzT1hMWFlVdW4ybjF5T2tH?=
 =?utf-8?B?WmRvVmxnT2V6TGdMN0RrOFZCNE81KzhIbUVtSHplRHpGZ0FNWU1aU0trTXo2?=
 =?utf-8?B?T3VIZi9MVEo2WnYyWTBNOEx5OWJMRlVPekJWWnZ6bnNBYjltRzQwdGREL2xK?=
 =?utf-8?B?eVNyeURwVTQ4YXdDVStOTGVwNzFieEVwRi91QStlRzNjY0pPc1VZc1lQbEpy?=
 =?utf-8?B?NngrZXBmMS9PaUxsdkdQaVRKdnpvMUVyWVdtelBqTEJCSU1TU3BTam5BTUQ1?=
 =?utf-8?B?Q08xeVZhUC9RQTZhTVVXYnc3Q1hsYnZrczlRZjhVeHRxS2ZRMmhSSEhTU3pC?=
 =?utf-8?B?MWdORnBNNFpOcGVGWnQ4K1M0bFZXaUdaZ0RMTFUzREtCMGlsMUtvRGVqcUJF?=
 =?utf-8?B?QmpYZFNzWEhKdjNOWDdZdzRySUdLWlI0MmRpZ1o1QnFWVklobFlkS00vd2tL?=
 =?utf-8?B?cGYweHFRdlVPRlBKbU95MWxocFo2VGRmVHh0Wnc5SmVFQ1A0T3VkRVVYb3VB?=
 =?utf-8?B?VTdjVmMxSFJLamFBelJTSjBhMFZSdWNBbis4NCs1WEtxY2IycVd4ZUJMNThE?=
 =?utf-8?B?bmNPUGFxZTdwVExOWFY2RGxzS25qZDFOdDIxVkZ3R3ArOWZRY3R6aHV6OEVQ?=
 =?utf-8?B?ZFZpa3U5V0hCZFdNaVc5T3BWbXBmMnUrTjNVWFFBL25uak9ZM04vbUxiU3dD?=
 =?utf-8?B?L1pzRlZDaWJzcVhVUloxcDlQMENUY28yK1k0djVxY0pFY2tkZWdLbVo1VVlp?=
 =?utf-8?B?Mk5kTGc5OEdEeEpPK012bk5VcXNPckdyRWxoUWtlWFFSWllvM08yNzhRZCt4?=
 =?utf-8?B?elJ3c0xkdTdyQ1pzNGVNclM5MzRuMmhoTlBQWWRVWENJdTVZeE5oVytrc1dO?=
 =?utf-8?B?dW1RWWV2Wnc2RUVscWZ6bDJ1SDZqdHdybG0wN1JPd0MvcU1LK2tpd0R5Y21s?=
 =?utf-8?B?RE1RZkFERUR2RkV1SXlISWRSWGU4OEpwMWNoWXR1MGl5Y2QxaWo4eGtiZkNQ?=
 =?utf-8?Q?VtCmNCboOiSjNnbdWIXck2/8Z?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b1e2e68-768a-420a-be74-08db99270ffb
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6095.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2023 22:22:05.7173
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nr8nTiBNGZslEoOvTlqt4jNfGNO8zEP2CMgqTAUxl7aA1/K3QjSu/2iKAOxY4F7+vsb6miWsOoGmK8pbhMfgwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8241
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org



On 8/9/2023 4:33 PM, Jason A. Donenfeld wrote:
> Hey Greg,
> 
> There was recently a bit of a snafoo with a maintainer taking the wrong
> version of a patch and sending that up to Linus. That patch had
> incorrect stable@ annotations and had a bug in it. That bug was fixed
> with a follow up patch. But of course the metadata couldn't be changed
> easily retroactively.
> 
> So I'm emailing to ask you to backport these two patches back to 5.5:
> 
> - 554b841d4703 ("tpm: Disable RNG for all AMD fTPMs")
> - cacc6e22932f ("tpm: Add a helper for checking hwrng enabled")
> 
> I know the stable@ tag says 6.1+, but the actual right tags from the
> newer versioned patch that didn't get picked are:
> 
> Cc: stable@vger.kernel.org # 5.5+
> Fixes: b006c439d58d ("hwrng: core - start hwrng kthread also for untrusted sources")
> Fixes: f1324bbc4011 ("tpm: disable hwrng for fTPM on some AMD designs")
> Fixes: 3ef193822b25 ("tpm_crb: fix fTPM on AMD Zen+ CPUs")
> Reported-by: daniil.stas@posteo.net
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=217719
> Reported-by: bitlord0xff@gmail.com
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=217212
> Reviewed-by: Jason A. Donenfeld <Jason@zx2c4.com>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> 
> Let me know if you need any more info.
> 
> Thanks,
> Jason

So I had a quick try with the backports to see what happens.  6.1.y and 
6.4.y apply cleanly no problem.

However 5.15.y (and presumably 5.5.y) have a variety of issues that I 
think no longer make it a stable candidate.  I started going down the 
rabbit hole of dependencies and it's massive unless hand modifications 
are done.

Realistically the problem is most severe in 6.1.y because of 
b006c439d58d.  I don't know it's worth going back any further.
