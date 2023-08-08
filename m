Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B92A773558
	for <lists+linux-integrity@lfdr.de>; Tue,  8 Aug 2023 02:15:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229962AbjHHAPw (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 7 Aug 2023 20:15:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbjHHAPv (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 7 Aug 2023 20:15:51 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2040.outbound.protection.outlook.com [40.107.243.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CFE3D9
        for <linux-integrity@vger.kernel.org>; Mon,  7 Aug 2023 17:15:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Djgq0Dvoi3NwfqdxZZdCA9B9Knq0eoWaumTWvRYJHHcQrF44+QMYbv3z3jXjMXj8EUZ2nLwp7P6hX7tfNUquLogjTtyiPhpb8tdLEvbr0mC3adQM24W4r3HcU0b4zOI8Wle53w0fSvlJWmtNHrRPRidxcPd4J5E4ZLp4M97ibpRLrQ1myjdSfyyjajqsXPeGqUyBZy+s2goii5J5wSzH0yI2edG4VK5tuYc07JZR/ZbiBGSlKBWH0UsfLR7YOxht/iV8C5sYzGVcZ19IYdlxpoTLL4DdeumBKGfAWbJZ8XhJFkjNR9mwj3EP3TdCySt/mBU6MPd3Mq91SEznmWHLdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M5J7LkgwwKKZTDaYjyaQ3LiGLQEaaLFPvCidgGVBQdc=;
 b=FuGTj6vfE9o5P45btfdG99EXi3F4bddtnfzK8WID9cygOdJ0+Q7JlO8yVVx/Alhm71s9/v0DdjxMHksdUSjYuyPgU9Qv8JEQH3qB/KI0t7LtFsTreCr+cSXWPuOKInARgB7kArle45XHvlAsyZVI7A1HCWwfUro58qSrHy/EIzW4311+EIUB4Auboln2Wj+gI1aam1Xr0FxU+QTLB7tBgKAlvQfkbzMr7R1TsQexoTbn2Cs1WCZXS2KaylI+68v7V0KNdJxryXgZDQ/vru4mDs6Rv9a5vfd6ur0pVo4KzwsyjLbU86bXzQ6tsfU3DPmb/r4EF6Ui9pvmuHUAIVsV1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M5J7LkgwwKKZTDaYjyaQ3LiGLQEaaLFPvCidgGVBQdc=;
 b=a7C8gPzMOq0+J2lIMmZEfaziNo0X/ODEI9GudAoiGKt2RbRuKvSG19NG0Hspb8BzIU6HG5gCShNyOxUV5eRpXIA15oBTwnFLTQf2ASjKMpEkm5DqrAJzYk7tNEyPrMsT0RPTDFxlF1R5oWaKKhdYEeRA2p/Wz3huqL12Do2FyBo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by BN9PR12MB5384.namprd12.prod.outlook.com (2603:10b6:408:105::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.27; Tue, 8 Aug
 2023 00:15:47 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::36f9:ffa7:c770:d146]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::36f9:ffa7:c770:d146%7]) with mapi id 15.20.6652.026; Tue, 8 Aug 2023
 00:15:43 +0000
Message-ID: <f7f9be14-b5f6-4c2c-a4e3-8d44bfa4b36c@amd.com>
Date:   Mon, 7 Aug 2023 19:15:44 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] tpm: Disable RNG for all AMD fTPMs
Content-Language: en-US
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Jarkko Sakkinen <jarkko@kernel.org>
Cc:     jgg@ziepe.ca, linux@dominikbrodowski.net,
        linux-integrity@vger.kernel.org, daniil.stas@posteo.net,
        peterhuewe@gmx.de
References: <20230803182428.25753-1-mario.limonciello@amd.com>
 <CUK4PB8J51W8.2NQ3CSI1HNLDR@wks-101042-mac.ad.tuni.fi>
 <6bfc61fb-6432-cb17-3312-53c6268e2a46@amd.com>
 <CUK5NKQKDAWO.2RCNF768IKZ9Q@wks-101042-mac.ad.tuni.fi>
 <ZNFv8f3r86zq3JSh@zx2c4.com>
From:   Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <ZNFv8f3r86zq3JSh@zx2c4.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM6PR02CA0108.namprd02.prod.outlook.com
 (2603:10b6:5:1f4::49) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|BN9PR12MB5384:EE_
X-MS-Office365-Filtering-Correlation-Id: fd9016ea-2396-42f2-d478-08db97a49af4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yEHMoB2kulOds8S1wnxidyTpGxzbZ07MiYJxsmhXbL4Xz59FSufsx2lxhref8M022E3qRhgj8YZS1x6E8mOIQkXzrpdsfulhAppEFzVkVQeuszM7OPDUhGcDo58fM1KkoZdBmDXCCNujWm8tcTSKodNyZi7qaEntXCOkQ0phEqunYbNlOZLsYEVHHv8OuHnm97SEFKcDdFIF8G4PmmS4012d2IZZVWPBbXdT3/DX4FLvb0TdM7r45SAAHE8CHpbcGuwUZvlmfxT2hibP/NOgSu2pS2ur6EzWnXgtL1YqjpgnrHKPoBXZ5mCiI6jtBP0zYiveqM0FGZrfS1zJH8kE4P/ji4+zWeVRsWbvc9KtOZiajGfnMn41QUpSIy1/9v9nAcQfQt/hqYarLRCZVrBKd1/UyooiB36mSOBlwsE8sNzfn2RNGn/RpDOJQkKVbwu7sDGYDPfzmn1pvtV1HnYcHT59u1SSCvB4dvgKbMW1UNNx+PEGc2lhBKDYuobpCEYvE+Ld6yi757KtujTaI/dzZhI9NHqtd+u6ke9+/TAZCGJQMSn/bc9CQ5bvR5JMush59icL/BYY+fdYbEuv/aeIPXmRdx91nuAMbzGi4Ls01SwWy4JCi+4NJfQgbe/1l11mhY/JUiCklworYaj/ZNXXACZ1Frq+Qt9lK17DLO1xrkZnwP0LRt4QquKMoQRoEDVFcULTcuKjpymLHCTkJZma/hwjPT3JIhpiYMDDxitoRJq9GydK4OnouKe84icbKLtaI0YNrUsJTuhtDHnMcIlbDQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(366004)(39860400002)(376002)(346002)(396003)(1800799003)(186006)(90011799007)(90021799007)(451199021)(53546011)(31686004)(6506007)(478600001)(86362001)(966005)(2616005)(4326008)(66946007)(6512007)(66556008)(6486002)(66476007)(110136005)(38100700002)(316002)(41300700001)(2906002)(83380400001)(31696002)(36756003)(44832011)(5660300002)(8936002)(8676002)(17423001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bCtQQ3A5dkpKOG1FNmEvWU5kVUNSUG04d0p2cytWS0Y3WHVXajA5a01EdWN2?=
 =?utf-8?B?STV5UnJObWxuUXMyL21pZ2g2eDMrTmp5QThIaDBTQ3dQREhQVndPd0JNTE0w?=
 =?utf-8?B?Zm9BcUJQRit0VU1Rd3p1ZFRuRC9uOFhvOHpHTmVkRy85VE9jbzNGZjJTQUNT?=
 =?utf-8?B?aG5DbjgwTXdhcCtHUmpmbGtVYnJDOXM1OFYvZCt4OTV0WUxSb0lRRHJhYkN4?=
 =?utf-8?B?dll6dkxIWitIekd4RU56MmJTRVFsLzY2KzVvMVFsQzVDcm5HbXR3WXA0RDIr?=
 =?utf-8?B?YmRqSnp5OC8xNmxGbS9XaHlZNWY3SEdzandqa1J6ZlViQ2pneUpvMlhNK0o1?=
 =?utf-8?B?dXUrZ3ZEQmJjNnBsNnhQY2p0NXZyeGdvYXRHTjI3VWJJZTEremt5UHZPcFBm?=
 =?utf-8?B?REVxTzdmZytKRldzVDM4VXhLeVJuQ01kU25RWFJISUhqK0tzc1d6WkxaVUc4?=
 =?utf-8?B?dmh6U29MVmVLNmN1NDlRRXhYdEdBU2V6UVFNL0NDbWhieDBadDhBQ3RuYTBW?=
 =?utf-8?B?QVZzWjI5N25McE5tMStqUzlNRndNUDRIUWZMTFlsbXRmR3E4VzNsQWxObHJM?=
 =?utf-8?B?Y0pldGxIUHdmeDErdWdoWjk1amF2UFdoTGFHbDZ5NWJDWHlmWWVkdCtjcFIx?=
 =?utf-8?B?QUU4MjVBeExKNmZZampIdDMwWkxWa0IxaWlaVVhhekg0Uzc1YXl3MjNadTFU?=
 =?utf-8?B?Z0Q1YWRhbkVmbldpdTc0QXlCek8rcFpJdDZJWitDUVJuUDlqRFE2akJrVlh6?=
 =?utf-8?B?cTByVnBFdGJ4N0FMM1NRdDgrNEQ0SWE5YzkxSnFBZ2s1Ui9Nam1aekRwUW1p?=
 =?utf-8?B?bEo1eTg1UWIvaUJPdGVOQkVPaGpDdXlVRXNLTFk1c0JZQTFMYU8rdi9BZnRU?=
 =?utf-8?B?aFhjMmFZR1pVa1NvWkJhQWFiTWYwaWFDZTJ5QUlMNmsyaTRxQkxrN0QzMW1r?=
 =?utf-8?B?OVlJQmV5V2FRcTc4MFZnWm1oUXc4WnlIQlpnNzAzOGtVQXJERWtGbEplSDA1?=
 =?utf-8?B?Tm1MeHp0ays1Vm51a3BDYjNzUkUxRW9VM1VjQ29vbE9DWjJ1d2xPckN4dENW?=
 =?utf-8?B?Ymt4clVnZW1VOFhMU2RHeG5VT3BrTmxuajJTRHJ1L3pkaHlNWjI4cFVIMzVI?=
 =?utf-8?B?Yk44UXJ5ZEpCRnNnOUFEaFVYNTZFbGx1eElRbkdyL0J4TEJ0bXZOR2dFZXFQ?=
 =?utf-8?B?L0ZMR3k4a1djd1dmdkcvckZoaXMyV3lLZnRUYmpJd0hnZ2pCRDNVendtbGNi?=
 =?utf-8?B?VmxzNFpacThWSkp4a0YxY2p6bHgyTGZSeWo1M1VERE5VeS94VHlMMUplT2U0?=
 =?utf-8?B?QXRQQnpGdyszWGgrVy9IY2RUdldpdkFQQVg5dzlLSVA1eUgrazdjbVlsM0pM?=
 =?utf-8?B?OFMyK0RrWnlndklBVFZnWlA4Yi8yVllGdnNJa21xUUJxMGp4UE00S1VqcjJP?=
 =?utf-8?B?Zzd2c3YzamhiZ3duN1NCVFpXOUE4WExyVGtvY2RVQ2F2ZmhBSmxMME9HVEF5?=
 =?utf-8?B?Qm1RcS9TOWF2eXdwUXd3SXpKQmVNaVZyMDRGTzdsdkVwZ3BEUTVZYzFIYVlT?=
 =?utf-8?B?L3RpMVRUQXlhd3pQL01Kdyt1WGxET3pSR1N5aXVXT25GeUhJVnFjMlVzL29y?=
 =?utf-8?B?K0ZrcitzTkhKYWg2UXR6TkphWWpTOTNXSkpPcFpRYnoyUWVRYWl0QXRmMzdo?=
 =?utf-8?B?aXV4YWU3ZTJ5K1RuMFZKTCtxM1piTWF3THlENVNsU3VBMUFvZnN6MDUxcGg2?=
 =?utf-8?B?RFlhdXgzcjBTT3BDNWc1YlZheGJ5Z2NJZlFYV25FeFRqQzlYUlNnSU45Y1g4?=
 =?utf-8?B?S2ZKYkRoNk5jQWltZWpQZVZMcHhxaHVqQm02TGxQeXNHYUUwczR1M1NhRGlx?=
 =?utf-8?B?Q3M1c0E1WU9UbFZOQnJFYzZFUFZzdHFEZjBaSkVYYjdudWN2R0lVNHExYWhs?=
 =?utf-8?B?blQvNUFrQ25BTGRxVXNyR3lJY01FUmlTMXovbGVaLzlkYndka0xEaDVJbmti?=
 =?utf-8?B?QjRraGcyNjVyRkpPZUs1SGlVbFJOUGRheWpVUm8wOWRJdXR3UEdySDcwV2NB?=
 =?utf-8?B?eFBhNlVLZTZDMXE2Z3lNVllDQnNSVmQ2bzNONWd6dzEyV2JNblowTGoweGVw?=
 =?utf-8?B?MjlBL3pFM3RZL0VRMnh5SmhtZWkzOFlINUJOYmkrWTVvOXBic2dpNE9MSDM1?=
 =?utf-8?B?Wmc9PQ==?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd9016ea-2396-42f2-d478-08db97a49af4
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2023 00:15:43.6033
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LH2Jylc/G8rLBdPAV+IYxhyk9+dPbfjtmE4k04pYRLkUyKzN6OEMHKMTqbJ9pc25biVEJVhUzoy0Ttbrqf+ICA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5384
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org



On 8/7/23 17:28, Jason A. Donenfeld wrote:
> On Sat, Aug 05, 2023 at 02:39:11AM +0300, Jarkko Sakkinen wrote:
>> On Sat Aug 5, 2023 at 2:21 AM EEST, Mario Limonciello wrote:
>>> On 8/4/23 17:54, Jarkko Sakkinen wrote:
>>>> On Thu Aug 3, 2023 at 9:24 PM EEST, Mario Limonciello wrote:
>>>>> The TPM RNG functionality is not necessary for entropy when the CPU
>>>>> already supports the RDRAND instruction. The TPM RNG functionality
>>>>> was previously disabled on a subset of AMD fTPM series, but reports
>>>>> continue to show problems on some systems causing stutter root caused
>>>>> to TPM RNG functionality.
>>>>>
>>>>> Expand disabling TPM RNG use for all AMD fTPMs whether they have versions
>>>>> that claim to have fixed or not. To accomplish this, move the detection
>>>>> into part of the TPM CRB registration and add a flag indicating that
>>>>> the TPM should opt-out of registration to hwrng.
>>>>>
>>>>> Cc: stable@vger.kernel.org # 5.5+
>>>>> Fixes: b006c439d58d ("hwrng: core - start hwrng kthread also for untrusted sources")
>>>>> Fixes: f1324bbc4011 ("tpm: disable hwrng for fTPM on some AMD designs")
>>>>> Fixes: 3ef193822b25 ("tpm_crb: fix fTPM on AMD Zen+ CPUs")
>>>>> Reported-by: daniil.stas@posteo.net
>>>>> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=217719
>>>>> Reported-by: bitlord0xff@gmail.com
>>>>> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=217212
>>>>> Reviewed-by: Jason A. Donenfeld <Jason@zx2c4.com>
>>>>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>>>>
>>>> I will skip rc5 and send this for rc6 on Monday.
>>>>
>>>> Has anyone with suitable AMD system tested this?
>>>
>>> Probably obvious; but I tested with a system that can support both dTPM
>>> and fTPM and swapped between the two before I sent it.
>>
>> Ok, great. I've tested that with non-AMD system things continue to
>> work so I guess that is sufficient enough for:
>>
>> Tested-by: Jarkko Sakkinen <jarkko@kernel.org>
>>
>> BR, Jarkko
> 
> Why is
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=554b841d470338a3b1d6335b14ee1cd0c8f5d754
> in Linus' tree? After we told you on several email threads to take the
> v3, and you said you would, you still took the v2? What are you doing?
> I'm frustrated because this is not the first time you've been out
> to lunch about this stuff. Now there's the wrong stable metadata and the
> fix is incomplete. Shame.

I guess that means I need to re-send out the other fixup that was missed 
in v3 separately and with a new fixes tag against that hash that landed 
in Linus' tree?  Or Jarkko are you going to resolve the differences?
