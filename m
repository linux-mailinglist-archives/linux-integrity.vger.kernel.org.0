Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62994770C53
	for <lists+linux-integrity@lfdr.de>; Sat,  5 Aug 2023 01:21:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229486AbjHDXVc (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 4 Aug 2023 19:21:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229634AbjHDXVa (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 4 Aug 2023 19:21:30 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2046.outbound.protection.outlook.com [40.107.244.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D9AA46B3
        for <linux-integrity@vger.kernel.org>; Fri,  4 Aug 2023 16:21:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MI5BVncu4k9UWOjlzgXUXkDfTiZU4dN6PRgDzcbGiyxZCKYIduqt2duP+t7O13wVckymXahgmLIlWRoP5zVznfHjJbfxtIG7V7cv+TB+3QaRbPSUKD4zQWyw1NAU52v80cG6bWJXuBiVCxZt7MVJWNYUNkQoFu/e6phNHIjLZ7rJ92sduQgrjSPgRfF0DRUxd2UaWnHq26C3uLhoEA8VmVx8/wmyvFdE5qRWsSnDkeb+BeHJ4Y/s/jD65ejyjlQ3jLPvZkEGKqT1CmhQ0QSrlSwMPg4fZJejzWjt+yGRuOkpoVETpQElK9rR9Hdhv4/9/rUgPlB0DIQ6Ep0DkK39kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UzP85grKrxJQwgqZ/qKzKiXWFhziYhJvyvMR2hIKPSE=;
 b=VxdpmT3vNa6bfLylFCyVye/SO7s3TUAVeWNq85wIRf0DszkMpimfGRiojwHg/EaNsY9wqZHryBbGexi35mQn8a1u0ibC2zhZy9rUEZfrwG7WMcRVJzzYp4sFzQZDLA43TLMPfpMS1hqYE+f2zcHdzWD7eAC50SRh4v6c504VFgBu1vZJRz3xRBAPBbWAyqgYKfp0cbyyM/BCa3MmAV46cX8RLjKc1a9WuyYQyAZMa1xressMTztrFooE2St+8+8e3CiSc9zUR9k2cjHRcKHuKBaoB0FCEnSBgk+mJozcuyaI2hp9fW9fxYUadjPV28PUXLznWDG9L04Apm1/f4kKpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UzP85grKrxJQwgqZ/qKzKiXWFhziYhJvyvMR2hIKPSE=;
 b=dM4Km8diFTms/k5892ZnC1uMP7/WOfMrhOl4l1pQ/L4Lu82n8CmKViF3DNyLg48o/Li9iHQx70phYP/LERFLJcaSC3uSy2W+51CDh9pcoHAVAQ1f72hiD7nBECZee/bxcdNx3ou7/GQ2Qe420gPc0taOzrgb/swm/Eyh+bwdmPQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6095.namprd12.prod.outlook.com (2603:10b6:8:9c::19) by
 CY5PR12MB6478.namprd12.prod.outlook.com (2603:10b6:930:35::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6652.20; Fri, 4 Aug 2023 23:21:18 +0000
Received: from DS7PR12MB6095.namprd12.prod.outlook.com
 ([fe80::44a:f414:7a0f:9dae]) by DS7PR12MB6095.namprd12.prod.outlook.com
 ([fe80::44a:f414:7a0f:9dae%7]) with mapi id 15.20.6652.021; Fri, 4 Aug 2023
 23:21:18 +0000
Message-ID: <6bfc61fb-6432-cb17-3312-53c6268e2a46@amd.com>
Date:   Fri, 4 Aug 2023 18:21:16 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v3] tpm: Disable RNG for all AMD fTPMs
To:     Jarkko Sakkinen <jarkko@kernel.org>
Cc:     "Jason A . Donenfeld" <Jason@zx2c4.com>, jgg@ziepe.ca,
        linux@dominikbrodowski.net, linux-integrity@vger.kernel.org,
        daniil.stas@posteo.net, peterhuewe@gmx.de
References: <20230803182428.25753-1-mario.limonciello@amd.com>
 <CUK4PB8J51W8.2NQ3CSI1HNLDR@wks-101042-mac.ad.tuni.fi>
Content-Language: en-US
From:   Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <CUK4PB8J51W8.2NQ3CSI1HNLDR@wks-101042-mac.ad.tuni.fi>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN6PR08CA0003.namprd08.prod.outlook.com
 (2603:10b6:805:66::16) To DS7PR12MB6095.namprd12.prod.outlook.com
 (2603:10b6:8:9c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6095:EE_|CY5PR12MB6478:EE_
X-MS-Office365-Filtering-Correlation-Id: f38a231b-b1e0-4464-bbbb-08db954181c1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LeToife3aWZIHQoeGAVAFeVHbe/SxO9rp9DjyeSRwdONP8PAG91MXEfvOXDcrgMRnFTCJ+lR9J02MRVbmguEYne++eQJCfjvWuiwD3wsfEN2BjpSej28FL8vZ60JdRIsSwjYqPSLvc7Y44e/RtDqv3iya+5q1o/dkzIVcjPurJvgEImYtWLEGIkABnF3bU/IcchP8jul1LsciqdGRoQlE5SCD5GWSkJMLOI6Bf8j6TOmWSJwsQV1OotcaQcw4aL4QkHDOM46gNVmefDLG+yAKNrjIZZC+zvUKzHoAByCc0oUVLf0nYtsTNV1vJz+shDRctINHzmP+xdH6PxfjRAFh3Da83zYPz/du6+aneZX7TMMwIU+QTeAhmzXj+/j/WR1MnoMYoD9eM543MoNuUfg/fLEcinOlW5rK7+a51GHxz9SF6fv0rn4shZXggMhz4WJc3zbgK/mIDyKamhcglgQat2FbUvFnFi1XuBpGUZVsi3FQYOksb4CUFClPrVUVMCUGgX448eK0qdR3An3dMo2AC+Q88A9bsanoa7jaM52oQFvDqaaK2ezL0xaErdxq2eZOxQgfzaU3WBwJTTpAtJYudypOcBlbDvVEfxsZwR92CsEhuVQNLmZ8G+HRczONlzFu3fyUax/9OS7+H/FtN9040WIX3AoIx1jC98auNbf7WP9HRkhSAHTz0wQNSq4otWdX3SGztGwkJOsj1famyzVtg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6095.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(396003)(39860400002)(366004)(376002)(346002)(1800799003)(186006)(451199021)(41300700001)(8936002)(8676002)(83380400001)(53546011)(6506007)(31696002)(86362001)(38100700002)(2616005)(316002)(4326008)(966005)(6512007)(6486002)(478600001)(6916009)(36756003)(31686004)(2906002)(66476007)(5660300002)(66946007)(66556008)(44832011)(17423001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U0Y0ZnM2Q29JODlCVjZrWFREcHRkRnd0RFJaWVdQSkl6MVMwNzR5MTBYajJZ?=
 =?utf-8?B?bjAvN2psMTVoK01DZ3RFSVJtdXVFMk55NXBPUlhxaWpwY0tFZXVSQ2xOeVND?=
 =?utf-8?B?TnluRWtma3QyTEFQY2xtS3JBU2dxdndaWU1aaU9BeFBlNGh4ZnVOMCtUTEdV?=
 =?utf-8?B?NXFzZGZzVUZzVmZTbDQ1T1ZyMWcydnFrWlA3S1dEZG1SK1dVM2h3OFB0dytM?=
 =?utf-8?B?RnBEUktBdXkxbXNEa1dSZ1BhK1plaXhrajQ0SFk5UnN2dlNVMkhNaXU2SHVZ?=
 =?utf-8?B?bVBVeFR4akxESm1jMWxTRlJheis4WEY1Z3puZCtwdW05UVBQaW1pNGIwRUpO?=
 =?utf-8?B?d1A3MVdqMXFMLzdsbjBGMFF6aFZNbDlvRC9qbGJJTnl1alhYOG5WZHZvcDN0?=
 =?utf-8?B?OFJlSnRrU3lxTFdOWmp0dDRra090ejNMSm5QNjlsNmFyYWdYd0NqSmE1M2RT?=
 =?utf-8?B?ZkNmekljUzFpVHdpOGlSMVZqT1hUd0JOeEpMRllhQ0RaZEI3a3JiZU8rV0JQ?=
 =?utf-8?B?R1N5cU1LdHFrQ2k4MXdFY0x3ZUh4MmROdmxiSmFJMjVEWnl0YjV0eGdCYjZG?=
 =?utf-8?B?MVRzdzZyVjBqckxEYnRoWUVIWi9qTE9VbTNKSDNjODVkY0EzTG5DQzFWZkRX?=
 =?utf-8?B?MzUwRFZzTGVxS1Q2WHgyek5PeTRoSFMvYldhZ09OaW9HaUxzR0ozd1VJWXFK?=
 =?utf-8?B?YS9wYmJHWHlrM1czK0dpcmI3b1NnQUFwdFNXajZwNnR3TTVwZjFINkJvLyth?=
 =?utf-8?B?VWJkcThLYlAxU1Q5TzEycCtjSnhaQXB1VTBNSisxNytFcDNXdnRHdVY4eG1X?=
 =?utf-8?B?MGhBbEc3OFpnRzVJRlhXdWRXSEQxc0dQYlJtZW9JM0JLMDZJN0gwbk1iM2tB?=
 =?utf-8?B?NEJRTDFDN3d0TGNVdHA3TWVPenJOcjFkRCt4VlhqRkV3V01JSmR3c2V1SVY3?=
 =?utf-8?B?aS9WMnBjcUtuVE1vWElWemhkUW13cjZUcU5VUmVBdGprMDNiOTZ6QzVqWkRU?=
 =?utf-8?B?VnpUN3Y4UWpyVUNja1VFcjQ4QlVVbDcxS2hwNHdBaFdwZlhWSEVnbVRnV1JY?=
 =?utf-8?B?bVJ4R2J3MURSTDVYS2dRcVJEUXU0dkplVktiSHpTbE5LNEhRWHpBYm9FOWZK?=
 =?utf-8?B?MU80YjZ3bitsYlN4MFA2cmRpbEdYQjY3UTJiR3U4ejY1Q01NRVVObTJZVHRx?=
 =?utf-8?B?Kzd2UVh0emNlNkZ6Z20xTW91UFIrNVVwSGwrd1RoaTZmd09FWkZCTlFGT2ZT?=
 =?utf-8?B?YjREbzFtaHROL3oxV21HUG1IK3d5TU9pNktVOFNlL3ZhcUNYRlV2WUdJTHB1?=
 =?utf-8?B?eURMS0NLbktqR0xCT3QyMkp1TmE1enVUZXBHTmxaRzMvbE5HVmovNnJ2LzBh?=
 =?utf-8?B?WkZFOWsyNW93R0hPcW5BSGlmZzd0dE13aklHQ29ITVBWWC83NEhmbGVlRkFE?=
 =?utf-8?B?cHp2V3BjTUJIQTdKb0hCdGs5WFZDQ3R1VWR5NkpZYzN5M3VHOTErU3ZnNmR3?=
 =?utf-8?B?REppd1NVSGV2WWJpeFpQbEdqR2Z5VDl4ZnhaSTdQaTdOdEtuWWtjY2hGU21u?=
 =?utf-8?B?MisvTXdjbmdpTnlOTkR3bXBveE5oSUdMWHpVT21hZ3c2TGpPQnVtaytSNndY?=
 =?utf-8?B?ZzlCT3pZQmpOVyt6WEc5Y05PSSt2SUdXcFJ5WUNhWVlxazBlcFJLYThGL2NT?=
 =?utf-8?B?NXo3MEJvZWZWZGgxazk1c050OUtzNTRGNXN1MTFGZGVIRzhnbjFmSGxQK1Fv?=
 =?utf-8?B?OTRoSVdYTWs3Z05hVU1NOEFUU1crQUEzbVA1cFNDVGVHbmkvSHFsZktlOU1p?=
 =?utf-8?B?TFRyWG1Oa0F3RFNPQTJXdExDWFl0R3hiOTJnV293dlZrMGRwTXdmeFgzQmtX?=
 =?utf-8?B?VDJaTjRYRzdmRTI1U1JlM1cybEJYcVB0a1BhUmtpbnQrNnBzaXZka0RueC83?=
 =?utf-8?B?VEtNN3JSZ2tNMFJOR0NoaUhGaWVrdUVXUzA3QjZrMXpkdEtBdy9qaUU5K2xE?=
 =?utf-8?B?VXErbWNkUjJ0WjA0bmMyT3V0Q3ZiRDRRSDVhanc5STkrNVhRaE5vM3BDaGtn?=
 =?utf-8?B?ZTBvcFB2L25McG5meis0Si96eExPRXhNK3dpS1c1NFVkUzgzVjRQMjFoU3BD?=
 =?utf-8?B?TGtMNTZMZzNHTThkTXFiUEpWMmhwcDFsa1JuUUJiMzFuVWtjN0FhelN1aXYw?=
 =?utf-8?B?cnc9PQ==?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f38a231b-b1e0-4464-bbbb-08db954181c1
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6095.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2023 23:21:18.6549
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vyTjMBejs9kBmN9j6Zgb5wDtUIQU4Ly9ijVFKHg4gRHGwDmWuuM8Y926idUVS/sonfVQqOQP1y/U7ZD6dWUq5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6478
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 8/4/23 17:54, Jarkko Sakkinen wrote:
> On Thu Aug 3, 2023 at 9:24 PM EEST, Mario Limonciello wrote:
>> The TPM RNG functionality is not necessary for entropy when the CPU
>> already supports the RDRAND instruction. The TPM RNG functionality
>> was previously disabled on a subset of AMD fTPM series, but reports
>> continue to show problems on some systems causing stutter root caused
>> to TPM RNG functionality.
>>
>> Expand disabling TPM RNG use for all AMD fTPMs whether they have versions
>> that claim to have fixed or not. To accomplish this, move the detection
>> into part of the TPM CRB registration and add a flag indicating that
>> the TPM should opt-out of registration to hwrng.
>>
>> Cc: stable@vger.kernel.org # 5.5+
>> Fixes: b006c439d58d ("hwrng: core - start hwrng kthread also for untrusted sources")
>> Fixes: f1324bbc4011 ("tpm: disable hwrng for fTPM on some AMD designs")
>> Fixes: 3ef193822b25 ("tpm_crb: fix fTPM on AMD Zen+ CPUs")
>> Reported-by: daniil.stas@posteo.net
>> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=217719
>> Reported-by: bitlord0xff@gmail.com
>> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=217212
>> Reviewed-by: Jason A. Donenfeld <Jason@zx2c4.com>
>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> 
> I will skip rc5 and send this for rc6 on Monday.
> 
> Has anyone with suitable AMD system tested this?

Probably obvious; but I tested with a system that can support both dTPM 
and fTPM and swapped between the two before I sent it.

