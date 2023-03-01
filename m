Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A2986A6D6A
	for <lists+linux-integrity@lfdr.de>; Wed,  1 Mar 2023 14:52:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229644AbjCANwN (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 1 Mar 2023 08:52:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229903AbjCANvy (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 1 Mar 2023 08:51:54 -0500
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2068.outbound.protection.outlook.com [40.107.100.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA6D57D9E;
        Wed,  1 Mar 2023 05:51:52 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SI9BkdCSM688Z8Bu2yp8O8N2cNBoZvEUmpuXik+9rbAZH+tSxhJhDT3qSssYNXTopICFODJLcew6OL7s8bKzjHHGHvW+4Un4SH9Ol9SlIUzk9jb53+P55DZ6FWniJS20w4Ij7AckdbqlzxkO9x1XsqN6tqPMdpU9SrR1G9PT51iANFLIhlt8XERUNJe2rjvL/hr0D3bfBUfjELuuC79iLl9s4MuE6FhO6F7mQeuW1BAVoFYGiLUf0DU2YdWPxUImdFN2lERgOYKCSNQ+oNEZTatwmmm5YsELJkKUxHIh0S4VY1LCZa/cYF5N8JJsm7ly/yixEIn5eK7siey3wjIyRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U1rl9g3FDy8vMW1jRSBJxQydRW4THa0KobJ3F3gTS/g=;
 b=h+PXBzOPKNTi4wLYZKfYLDMuvBmb/ayLihXwdUCEr6DDPwp3yrAHt22QpZXGM7kM1HRavNy/cs7QlRzIrawabdi15IjrrF2L8Qw8iNZ/nIXn0qB+Vx+jv6pl3PIRUCUF7/UDRaWjHEP+Pqhvw5kdp4Ice1XLF1Rx+QMdqZW122f9EGymbtqqEhOtAC/ArQ5U1a7uR+poRLVDwgamBRsAvf+AsuSJ+nFM67xnTVg5jg0+PHoyTpaYQLGUlE3KPRLPj5Ad5S8P6qRfTldeKhsz3Ib4ZbbF/ns5rvxoWxlsu/5An7+l2Ibn7Gx4XWT4CCZsAS8m8meEoqaoobFW0tRkuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U1rl9g3FDy8vMW1jRSBJxQydRW4THa0KobJ3F3gTS/g=;
 b=Y9/NG07EYgGmH8eOK0D3Bvpr+3BmOg9wAtlvPoPhSJcG9RXJaREcbxRWKOXOYm0MsPDmR80T2eFv+CA2DDlBlFk5iehJUQFwvXUDPJ+PGoXX7u2ru+am0ARzmQYbKvmx3Hx0tdm/dWnpKpczD8yJdbYb9DlRbRfdJA2d0XokMwdtASbHcyHEbl8SS22HX0A3L+2wh4/mZhFYafuS9HW5DScxNJl4Thnel1Qz8NFBcce9EQ3FxNY0NWTCQtKX8uDRpaF1dJchkN1neLEVWM7fWuxsdXsZjEpW/zwJB8+Oklh8Oay66aVFhay49s5g3Tsf9HkGD0cuh8JrqZTc//8xvQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CO6PR12MB5444.namprd12.prod.outlook.com (2603:10b6:5:35e::8) by
 BL1PR12MB5030.namprd12.prod.outlook.com (2603:10b6:208:313::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.18; Wed, 1 Mar
 2023 13:51:50 +0000
Received: from CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::5464:997b:389:4b07]) by CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::5464:997b:389:4b07%8]) with mapi id 15.20.6156.018; Wed, 1 Mar 2023
 13:51:50 +0000
Message-ID: <fc274097-93f5-1f01-952f-dda06b5ddaff@nvidia.com>
Date:   Wed, 1 Mar 2023 13:51:42 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [Patch V6 3/3] spi: tegra210-quad: Enable TPM wait polling
Content-Language: en-US
To:     Krishna Yarlagadda <kyarlagadda@nvidia.com>, robh+dt@kernel.org,
        broonie@kernel.org, peterhuewe@gmx.de, jgg@ziepe.ca,
        jarkko@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-spi@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     thierry.reding@gmail.com, skomatineni@nvidia.com,
        ldewangan@nvidia.com
References: <20230227172108.8206-1-kyarlagadda@nvidia.com>
 <20230227172108.8206-4-kyarlagadda@nvidia.com>
From:   Jon Hunter <jonathanh@nvidia.com>
In-Reply-To: <20230227172108.8206-4-kyarlagadda@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0209.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:33a::16) To CO6PR12MB5444.namprd12.prod.outlook.com
 (2603:10b6:5:35e::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR12MB5444:EE_|BL1PR12MB5030:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d2ef74a-7388-4ddc-c67b-08db1a5c1b5f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: W3sORW5HmdILZRhG0N0eHornqDCGFxYDhAgJG73MDR+sZCDJzHAc9zn22ux8DxXs6TgCpFG9VRV7wA5x+tdGHdCFN9EaBXnB7QZrFTwHYKypxJsnexOvVOq7b8djGQruetcoaKi6KnRvTUbe0G7sb7BZLA1ZUr8OwOEeFOxI1iUG1MrZomdZYnxVoNbg4WISgBJB0DVS8znYOqlNhzzGZj4Q3PDOTiGR3iCDZqUPAucgzxKphE6qbmCiliOdDc7yafsiEDXlm5FcXxZSDVbR0/uO73WgaqEQaQA383afJlA8pD/Uyh+orzfv9WcCSPjQUAv1YIXzUqKaHPSTaY2MaLFDq6SWcS8wQy3qkxsPqwOrhgNVm0gHVTp5/m4XkcMGGnAUtCors5rFyjHNDv/8K37Pm87e2ywPcx/DK2Z6ngOcBouLqH9g+aKnUecfDpTYK5px6TdbIKjzGWIl68mTeehAoN5qqYvOny9twfhUD3CpUbDtYXeWeYiMZ/lE7IHHsMq40RJABAWnIb/5Yy74d3SI2yb14WHHpkk2w82YZtxAszWUuShX6KfU6DAZvMOhA6olYTXjylBF2zeo5ypLoNIc6/TtNibppyknU5ZLp4yhIwq1dRZU0pVesZSsC4dWOsgtTUpiJJIbusUWSlKtwi4xvqSyv1OrgXOZ0weKeWWwIfVVOCIv0iPRnoy6shsVtcCuOZmREFTwZl2huNfq6dwF0B2WBCdTSHsHBVagTI6whTODjoZT5xdcQ5JJezH4
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR12MB5444.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(39860400002)(346002)(136003)(376002)(396003)(451199018)(7416002)(66476007)(66946007)(38100700002)(4326008)(6506007)(186003)(53546011)(6666004)(66556008)(8676002)(31686004)(5660300002)(478600001)(107886003)(2906002)(8936002)(6486002)(36756003)(6512007)(2616005)(86362001)(31696002)(316002)(83380400001)(921005)(41300700001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZWY2eEswR21CRUlpcm03L3RRMUdMUXl6aWxzeWFGQzljNzI1RU96Y1QwT3Qy?=
 =?utf-8?B?L3BPb3pkb21zMC9zMUNJNE9tajVFM0d4bCsrM0k2U2JDNHpZREljTzhCbEhN?=
 =?utf-8?B?Ni91Q1RFM1BEYW8rTFdiNXVhak1iV3h1WVNhNXkyVmxUM2FqY29jcHJyVEwy?=
 =?utf-8?B?Nk1mRW50bG1ncVJpTjM5M0NIVUYwVHFsY1djQy9WOUNJMEphN01LZi9SKzZm?=
 =?utf-8?B?UWtUVk5YZE5YalpaYWxKejZPZzhhMmxSYlJoV0o3SXdSMFlLWmZSYUVRTWxH?=
 =?utf-8?B?em5BeDA5SlVFbUxDOUEzMk43VFRacUtSc1hSek1NU0pObUNtL2x1RVdtaHlm?=
 =?utf-8?B?VStkWXJqMlZzUytobGNVSXBKY2txc01ZdDVPN1RnMHpia2FveTBXK0ZGNEVn?=
 =?utf-8?B?MWpwOHlGczFSaEYwZ2ZiQ1JaWDRGT1I3bzkwdDBFV2FoR2FCMTljL1BoY1ph?=
 =?utf-8?B?YXo5WGduVkJZcFB4ZGpHeG5iVnJ6M1k1Vm5yRTkxVXE4Q3BWNmtyOWlKUUpI?=
 =?utf-8?B?c1dCVjdQWTBaRVlGcHBYT3VFWmRWNm5aNTlSQnZvWDFkWDMvM2Z4ckZHQSts?=
 =?utf-8?B?azhtZFI2Ky9BOXM1cXBWQ1k5b1ZhWFdDUTYrcFE4L00yMUcrbEltenRrRVlU?=
 =?utf-8?B?Ti9QN0phcHlUK1B0VzRkUE1CWEUyMFZHQVFuNzNRdzdZbHJ1em43My9aNHNo?=
 =?utf-8?B?MXEvdFMzQ2dZaU84YXZxYUJzMTJnOFJtOExsbEl0bUNaNXovUTJORWlRNWFH?=
 =?utf-8?B?UjNNQzRZVVFLRzNHcmhlM3JVTUk2MThkWUJBV094NW16RE9EeDBTTmlsRm5N?=
 =?utf-8?B?Y3lxenZTbnlua0Z5NHgvYmZ5NUxkVjVSaXBSRkt0ek4yOWJQSlk0bzIzWitP?=
 =?utf-8?B?TzRMQ016KzFjWlA3MnZYZGoxSTZhZFJ0UHc2V0tBM3l4UnI1VmduNlBkOUx1?=
 =?utf-8?B?L2l2dDZGaHY0SENVN0pkeUJSdER6S2d2cVZ1VFpFTFV3OVRKbktwNjE4QlV5?=
 =?utf-8?B?MWpueE9FQjVEeGd0bTNKbnByRVhRVXFrTnpDZDYxc25pUHhETXhaYW0rZ1NV?=
 =?utf-8?B?OUJZeWhWSGdBOExuekFMcVhpOTFWcmtrMnluNkJtQkhDSHBoUlhKQnhFa3hL?=
 =?utf-8?B?K1I3Q00xeDN1dTZnSmRSY2JJbTd1ZzBudWVFaGVyZThmdWxrRnBJN21CSjAr?=
 =?utf-8?B?TUd2RzRhMUFPdnUwV3Y1TmNNOHJ2SDNiNUZZRUJleFgyUVZzSVgwRTBLZFln?=
 =?utf-8?B?R28zNFVuVDQxdkw0d3VsMnNwbzhwZGlJYVhHMHVZcWVpZ2Z2aVliMmdQZXVE?=
 =?utf-8?B?d0dZOWloRmEySFh3ZmxuYTVPKzg0Z2ttZ2xlaDdhL1I2YnhUR3Bud1ZaVG1k?=
 =?utf-8?B?aTQwMXp5cTBhN3RIQzYyVjhVeVJ4NmRSNHpmdE8vNjJ5SXMrSmZKSFRTaFNQ?=
 =?utf-8?B?SU83OVZQNFdOSVIyZkYrRlNIVTJRc08vOURtR1oydVZWbUEvdTA5UklrVDZG?=
 =?utf-8?B?V2E1eFlIZ3V2QWhGbHBrZ3hROG5YWm1UdTQvOUxJbzRkaDA2ZVBxMWEwa1BX?=
 =?utf-8?B?cnRFWUFoOXFHamRwQm1IclZPSFZTZFNKOUlXeGtMdFluQk5DR0Rady9SZmxJ?=
 =?utf-8?B?S0gzUjdOTmNWSnQya1NUcWJDaDVMY0FFU0J2WHVJRVVCbHNYeG43b3ZXckZF?=
 =?utf-8?B?MnpvSTdBL05hRzMvNmdVL1M5OVlPcXM3djQ0NEREd0s5WWtHWW5HKzRwdktD?=
 =?utf-8?B?NDZ6Si9uWXM3RXQwMVc4a1gwbGRoUzVhWGtVekJTdXVEaUNKY0h1VGdjSVd6?=
 =?utf-8?B?ZkI4ZDdneUZ5OXdpZkRObFNWRDdmUjU1WjZBMzN5a2w1TXNRSjRuWFE4ckQ1?=
 =?utf-8?B?UXR4QU9iTFkvckt1bWQyWEVLWVcyTlhCRkNsUkt4ZlhUSE0zdlFpWks2a2xT?=
 =?utf-8?B?dzZ6Rkk5WjZRTVMzRlVTMmc4SUNrQ0lVSU04ZldMc1ZzOFFpTHYrRDduYzBl?=
 =?utf-8?B?TUpnY1diU2Q2Z2JuM2dRUlpnRjRmUnV2ZGg4V1NTOElMZVQwQWVRWHQzU1h3?=
 =?utf-8?B?blhmcStxOWUwenYrMFMzU1c2RDcyNXo5S2JvQ3pCKytQcXdKNUpraTdaNE1M?=
 =?utf-8?B?R2JTU3BJQVV3aEZteVlYMlNyOTg1Nlp0d08zeE56WEcyZVpBc3lGNjR3VXNv?=
 =?utf-8?B?Ukt6cHd6OWtHMTdTWFlEaExocUZ4NGNKZ2FSWkR6UG4vSVNTNUc4Q3BzQ3dM?=
 =?utf-8?B?K2pYbUM2eStJUjllN2o4QXQwckFBPT0=?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d2ef74a-7388-4ddc-c67b-08db1a5c1b5f
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5444.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2023 13:51:50.4287
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Bsy5i4VeW2uqV7rACsOmT16TwdR///+jMvLdD/Bu3NleGriEFscw9NxUfyzaA8WlJQlir3HxrHSNXkfFIJcFiQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5030
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org



On 27/02/2023 17:21, Krishna Yarlagadda wrote:
> Trusted Platform Module requires flow control. As defined in TPM
> interface specification, client would drive MISO line at same cycle as
> last address bit on MOSI.
> Tegra241 QSPI controller has TPM wait state detection feature which is
> enabled for TPM client devices reported in SPI device mode bits.

Earlier in patch 2/3 we say Tegra234 and Tegra241 but here we just say 
Tegra241.

>   static struct tegra_qspi_soc_data tegra186_qspi_soc_data = {
>   	.has_dma = true,
>   	.cmb_xfer_capable = true,
> +	.support_tpm = false,
>   	.cs_count = 1,
>   };
>   
>   static struct tegra_qspi_soc_data tegra234_qspi_soc_data = {
>   	.has_dma = false,
>   	.cmb_xfer_capable = true,
> +	.support_tpm = true,
>   	.cs_count = 1,
>   };
>   
>   static struct tegra_qspi_soc_data tegra241_qspi_soc_data = {
>   	.has_dma = false,
>   	.cmb_xfer_capable = true,
> +	.support_tpm = true,
>   	.cs_count = 4,
>   };
>   

We enable for both Tegra234 and Tegra241 and so the commit message 
should say so.

Jon

-- 
nvpublic
