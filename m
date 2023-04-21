Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7B746EA744
	for <lists+linux-integrity@lfdr.de>; Fri, 21 Apr 2023 11:40:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231985AbjDUJju (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 21 Apr 2023 05:39:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232070AbjDUJj2 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 21 Apr 2023 05:39:28 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2069.outbound.protection.outlook.com [40.107.243.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02858AF00;
        Fri, 21 Apr 2023 02:39:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PpOtlFCVsCkIaKMUhh/nNr2VDPOrqWs03F5CgClBgcgyiOyN96ektoYXSk6vcO8bHjQ4/+nsADYcbXaRUdrUcgfTdgG5lcS37/AQ3SCx68apPtDlwuHUvfitsCKLhzseuvXtkvk01LCFTJmb8/VRbLjKMKGLeIwCvyGw5jT3EYN0BNEJI5gF2yVJysoaO7KOEohlgW4aDUYKNeisvdBNJA3BhmYGQflItBcO0IwP42HSajmpKsisqFWZVfqjpwX45f81foIqwGsChd/0rWl/PlFqhF3LT28SBC3vxng/yeROUyBpXOhDp8gkixVPPF+ojERX+oh7lAVKrZSjWUxojw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cUE16gZL4YOpOMQUR9+mQynDfKjPK3s+tSBTXAoD6TI=;
 b=eQJo1breDajJB4XDcoEmkm1cNKRqZFwxvLN8bDCXoO9jkcAYFEZzELM2jkXyWJEOYbwtA7iSI/+8C9iM6juYVXdnICNzcJ8+Y8MnVvSGr+wbFySrswJfnR4ZLf2LWt0shffP2QZJWjhjJAeobYXICHbb5YkeWw+7UWOGn7eVAq7U6O6kptxW+vKXKx0dPJBpKZ6eaGIniYvhueILMCzjHs0Bryi5eIB7OJTQe774wwK9CH+4NUfhBVZ8685TLHKdPps+b7ofFnOQW/YyWgHxtFxxBxpHAQ1IwTHZrSqngenaqLGUmA2VjBJ4v9zUrnjB5JYjH488LEmF25VdMSjcMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cUE16gZL4YOpOMQUR9+mQynDfKjPK3s+tSBTXAoD6TI=;
 b=KQlop4/FDJ2krVzagFYavyF6thKuOhl+xJ2iNid3O4uBL2E+thWTQchfoCp0IsuZUN4mKO4MlNeRjr/iecO1ps+TgNN+cz+ayZlWZziavg+TzaX+WuYVf61cw934VicZnz8O0UaKZfpE179NDNEcNVnN8Sc9ic5rEA1FkhkYM8jOjueXf/icP1YYEF8xV2HEOD41piFJMggZUZY9RGGEClCvg9keR5ryK2S9NxhoD/PI+duxBxfJH42TEEGqFobTglawuRu7hXU3lANVzdKBsbGw328u3/kLJK4nOzMeMI4mISmdXGPsEeaCAK/FqvYwZhC2mxDD9AaSqqcD7tobXA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CO6PR12MB5444.namprd12.prod.outlook.com (2603:10b6:5:35e::8) by
 MW4PR12MB7381.namprd12.prod.outlook.com (2603:10b6:303:219::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.22; Fri, 21 Apr
 2023 09:39:14 +0000
Received: from CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::3c6e:eaf0:e09:8fa3]) by CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::3c6e:eaf0:e09:8fa3%4]) with mapi id 15.20.6319.022; Fri, 21 Apr 2023
 09:39:14 +0000
Message-ID: <92bc772c-0cb9-d16d-65a3-a9bf1c260fb7@nvidia.com>
Date:   Fri, 21 Apr 2023 10:39:06 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [Patch V10 3/3] spi: tegra210-quad: Enable TPM wait polling
Content-Language: en-US
To:     Krishna Yarlagadda <kyarlagadda@nvidia.com>, jsnitsel@redhat.com,
        robh+dt@kernel.org, broonie@kernel.org, peterhuewe@gmx.de,
        jgg@ziepe.ca, jarkko@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-spi@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     thierry.reding@gmail.com, skomatineni@nvidia.com,
        ldewangan@nvidia.com
References: <20230421091309.2672-1-kyarlagadda@nvidia.com>
 <20230421091309.2672-4-kyarlagadda@nvidia.com>
From:   Jon Hunter <jonathanh@nvidia.com>
In-Reply-To: <20230421091309.2672-4-kyarlagadda@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P302CA0011.GBRP302.PROD.OUTLOOK.COM
 (2603:10a6:600:2c2::7) To CO6PR12MB5444.namprd12.prod.outlook.com
 (2603:10b6:5:35e::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR12MB5444:EE_|MW4PR12MB7381:EE_
X-MS-Office365-Filtering-Correlation-Id: 0be4cf27-354e-43a5-b1da-08db424c44e9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JMA5yJPJvE1MvXEyltFuWA1cO+p7h86rElJjn5Yic/q+FzNKaILvuXmu3nRiG+p//K7ByRGGcJb8x9jcp9ILI+Pp9tE8QRj28grC6hHLrAgvdAx/fxRDJlptu4xunyCzQT2Ahazqez9DyiUDHH88JhEUz9P7R4iNmP2KN6jYMqcYYS2SLoXkOMcwryFi+ErFH69R/G9wEH+iGQtgVPu/1yUDXpA0n+fqO7kkJnVBG4UbbXw+aOYX5N58MbF63xCjYfKsj5/yWW0l9u7q6OjsPO2orwQV9/RrR6BuSRuZnwtuYsfeNlBTaDamYnhA0Aub51xneVn62zwCvuvuBB/i/tXYW6fuqYcUiVHd8zjuZyemHliKs47fqacMVx/X2XpxJ07NF0yq1jEmzMrYjVhrzA+Ug1evHXP3g2akHgmnVOoEXSxc40W32ufJQAx0nqsoJLRg3MknFvA43mbjOAH6UKX1xIRzoa5MnkXD4rpvyYt379wbWb0B0WTSsgMUJoioL332owUQPAtqDygbO71g4bVlEy1VFpekuI+ytVdm5hrdswG/xqpaLZpHpTzu86osQ2LdzRtLHGpNgQ4hsaCBz19AhjtQT5v71sQgG0tmk01WzjNMAyxPpPHtGSn/1GmU811CJhdeM8/G04danr8Pr590qsvBEA9aN/hkUibvMMA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR12MB5444.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(39860400002)(346002)(396003)(376002)(136003)(451199021)(41300700001)(66476007)(66946007)(66556008)(316002)(107886003)(4326008)(478600001)(8936002)(8676002)(83380400001)(7416002)(2616005)(5660300002)(6512007)(53546011)(6506007)(186003)(31686004)(6666004)(36756003)(6486002)(2906002)(38100700002)(921005)(86362001)(31696002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VDBTQWpSWUFzakFuRkNnVUMxUjV1dmdhdEUvSHE4VWtmM3ZaSUM1NnpKTkEx?=
 =?utf-8?B?VmVxVkhwWUh1dXJjOWljZGEvNEJLNDREWjF3UFlFOEhrc01DSktNcHdaalNj?=
 =?utf-8?B?OTJUNHhGeDdpa3Y1aTFYK2VNaWJUbDVlditxdTYyK2RQbkY5RVZ3YTdhd09N?=
 =?utf-8?B?REE0alBnZDRlaTlXMW1vakIxYW50K09MVEIzdk1pcXdIaEo0U3lzclVwR2tI?=
 =?utf-8?B?QUlzNDg0a3FTNzRJVkxRanFSa1lqUVZQOVl3MzNjK2ZhNFpvVzI5QjQ5bjVs?=
 =?utf-8?B?QnBHT21jZkpmSGhoOGpWcDA4V1ZqNjZ2VTFNcnVKTnV4bTdEQVQvM2l0QmJL?=
 =?utf-8?B?YStyTDhhWDVYVjNSQXM4L3E0UktSd0x6c3pMUUw0bkRzWUdwb2hlUWY4bVp5?=
 =?utf-8?B?OGhYVTQwNkF4WHovcnNzZjBWZjdKOHVYTHpqenYzUlF6VzUzbUZJOXNqdDl0?=
 =?utf-8?B?c29nS0I1NGc4em9KT2ZxdWRBUVhFcFFJbVZNRFo0MnpFNjZrYlNxL21YKzd3?=
 =?utf-8?B?TFNoMGpwNjZFS3NCRHlzSldoTGtBUHZEdmpzZVJlVHVGTk9CVDVWT1pNMlhH?=
 =?utf-8?B?ekIyNkkzbkNCZ1Zidm5GaGh5TXpzT3NCellqSWJ2UE44Z1daMjJ1QTloM0x2?=
 =?utf-8?B?Z3N6NUxYZDZUOGpDdTFwZHhuTFVNb2lPblczYUhMSldWZHppZlpDOWlGTjh6?=
 =?utf-8?B?UGlseXBDQUt2U0F1em9DVzFYNTg3Z1pQUGxHTXFySjVRSldCMUJFbWFmaVdx?=
 =?utf-8?B?RFFLelRZYWFtcFl5a3VZc3BCcEpoYTRKVFlwZkdHblNiMXdsNU1LV2hZYkMy?=
 =?utf-8?B?U1laT0FIQ0dJVExyb0lOUWo1Nk04ZGE3T1I5LzVwZ0ovcnpyTGhTTXR6T1c1?=
 =?utf-8?B?YzgzZE5qR2MxeDUydnFIUFVqdkIwRVp3N0swWjZ4SW0rdFBDN3BBU01oT3Nu?=
 =?utf-8?B?MVI5d1pmNGx5TjkwWTBKMU8wMEVULzVCdHJ3SWFYN252VWJiOVZtREIzb0Z3?=
 =?utf-8?B?bVk1RUpReWRJUGllTFZ3b3VsdUxRNUh0RVYzaWFTU1kyZ0ZOc3o4TGhrWWI3?=
 =?utf-8?B?UURjTktEZmprTE9LcDRoektqMnJNVnkyNW9CS0tWbFdhdHlaUmIvWDI1RVc0?=
 =?utf-8?B?Vm5EQUZuU3hibzNhTzJLUGcvbkJPUzFOTGM4YWwzd1NRZCtFTHJoMEQvbHY1?=
 =?utf-8?B?dXBnMHRjT1dBK1NKb3RmZkpubEJCSk41UTQ3K3ZzOE5JU0M2TjFYK29hRVlS?=
 =?utf-8?B?a1E3b1hxMTVieWsrRmYrRE5ZbTNXSjc4TUJGQnd4TU1aQnJCSU9mUmY0cGtR?=
 =?utf-8?B?YVdBaDEwb3NIZHNBQ3R2SVdWR1lqSnIzRE8yUUphWXYrNXRYVjgzY0dWMW4y?=
 =?utf-8?B?WFNQeWIrOEJZZFVOUGxBYXVsblNRa2FPQVNrTEpFcFBCY2JGSjB0WXpadlQx?=
 =?utf-8?B?RnhKbXdUZXZvaXZIQUMwYzlyTmZVU1BMSytiei9CanlVZVFHdEFOQ3NBdDVh?=
 =?utf-8?B?d1EvNlRQVVFUc1JBWFpRdnpUaHlGN2lJdlh4WDJtNnpCK3FiV3JSMytRbWRk?=
 =?utf-8?B?dkFDQ0Q5RStzMjVLYkpCbDlRRFFrU3Y5YmVzcnEwTUpEWHNod3pZdU9XV0g1?=
 =?utf-8?B?dG9VU3FWN2hwUjBaWERUQnFZNi9DUmFVL3NqV09YZ2ZlWndZWEl3SVc3dGJ1?=
 =?utf-8?B?cHhiVGhFeHM3VHJiRFpDQzlLRjRxU2Q3YStZclNpdWxJRHZETTdUM0ZIL3hH?=
 =?utf-8?B?R2JuVXVDTlQwTUhlSTUwSjhQOTJ0S2xubXdyZHFtRDNBMEtaSmk4VWdSSW1M?=
 =?utf-8?B?RmJUWnR2WWlLSFNCdVV0K00ycXZ4TGZ0U3ZGOHdYQURZWC9wc2FWd0dVRndY?=
 =?utf-8?B?RzNDcW1CNlpFZW5YSStObTJjN2dST1RIRmdxNFRCOGJnY2xjNVVRekQxMjdF?=
 =?utf-8?B?THFBcTEzRUJFUjBEQ0V3cndHeThVcTdac0M2cDFFZm13cDk5QWVZcmM3Yysr?=
 =?utf-8?B?MEdTNWlpenJkRkQ5V3NoNjZVeHpIMEMwemVVRTR3TFpyZFM0dW16L3AzZ0dV?=
 =?utf-8?B?dm4wN3BSL2RTOTFGWEJxNG5UZWpvTHVhTGlPamM5VDlnUGd3K09MUVRsRThk?=
 =?utf-8?B?alpKVWNJV1owN0tHaGppeWdnS3c4RDEyUGlRT0pyYWtDdm1vWjFBN2o4Y0d0?=
 =?utf-8?Q?IewYEkyPlqvPZlVJUj29ELatheekAQEfSbjnpzGuHjKI?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0be4cf27-354e-43a5-b1da-08db424c44e9
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5444.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2023 09:39:14.7580
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G0yMqc9p6LY4FabgYxI6Fd43c6BPeiObyW0ORlAtWWnO4tATK9UI7W+TkGNeJbb9vceuvDg1J82ozVpfq8x/rQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7381
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


On 21/04/2023 10:13, Krishna Yarlagadda wrote:
> Trusted Platform Module requires flow control. As defined in TPM
> interface specification, client would drive MISO line at same cycle as
> last address bit on MOSI.
> Tegra234 and Tegra241 QSPI controllers have TPM wait state detection
> feature which is enabled for TPM client devices reported in SPI device
> mode bits.
> 
> Signed-off-by: Krishna Yarlagadda <kyarlagadda@nvidia.com>
> ---
>   drivers/spi/spi-tegra210-quad.c | 14 ++++++++++++++
>   1 file changed, 14 insertions(+)
> 
> diff --git a/drivers/spi/spi-tegra210-quad.c b/drivers/spi/spi-tegra210-quad.c
> index bea376acea1f..fbd14dd7be44 100644
> --- a/drivers/spi/spi-tegra210-quad.c
> +++ b/drivers/spi/spi-tegra210-quad.c
> @@ -142,6 +142,7 @@
>   
>   #define QSPI_GLOBAL_CONFIG			0X1a4
>   #define QSPI_CMB_SEQ_EN				BIT(0)
> +#define QSPI_TPM_WAIT_POLL_EN			BIT(1)
>   
>   #define QSPI_CMB_SEQ_ADDR			0x1a8
>   #define QSPI_ADDRESS_VALUE_SET(X)		(((x) & 0xFFFF) << 0)
> @@ -164,6 +165,7 @@
>   struct tegra_qspi_soc_data {
>   	bool has_dma;
>   	bool cmb_xfer_capable;
> +	bool supports_tpm;
>   	unsigned int cs_count;
>   };
>   
> @@ -1065,6 +1067,12 @@ static int tegra_qspi_combined_seq_xfer(struct tegra_qspi *tqspi,
>   
>   	/* Enable Combined sequence mode */
>   	val = tegra_qspi_readl(tqspi, QSPI_GLOBAL_CONFIG);
> +	if (spi->mode & SPI_TPM_HW_FLOW) {
> +		if (tqspi->soc_data->supports_tpm)
> +			val |= QSPI_TPM_WAIT_POLL_EN;
> +		else
> +			return -EIO;
> +	}
>   	val |= QSPI_CMB_SEQ_EN;
>   	tegra_qspi_writel(tqspi, val, QSPI_GLOBAL_CONFIG);
>   	/* Process individual transfer list */
> @@ -1196,6 +1204,8 @@ static int tegra_qspi_non_combined_seq_xfer(struct tegra_qspi *tqspi,
>   	/* Disable Combined sequence mode */
>   	val = tegra_qspi_readl(tqspi, QSPI_GLOBAL_CONFIG);
>   	val &= ~QSPI_CMB_SEQ_EN;
> +	if (tqspi->soc_data->supports_tpm)
> +		val &= ~QSPI_TPM_WAIT_POLL_EN;
>   	tegra_qspi_writel(tqspi, val, QSPI_GLOBAL_CONFIG);
>   	list_for_each_entry(transfer, &msg->transfers, transfer_list) {
>   		struct spi_transfer *xfer = transfer;
> @@ -1454,24 +1464,28 @@ static irqreturn_t tegra_qspi_isr_thread(int irq, void *context_data)
>   static struct tegra_qspi_soc_data tegra210_qspi_soc_data = {
>   	.has_dma = true,
>   	.cmb_xfer_capable = false,
> +	.supports_tpm = false,
>   	.cs_count = 1,
>   };
>   
>   static struct tegra_qspi_soc_data tegra186_qspi_soc_data = {
>   	.has_dma = true,
>   	.cmb_xfer_capable = true,
> +	.supports_tpm = false,
>   	.cs_count = 1,
>   };
>   
>   static struct tegra_qspi_soc_data tegra234_qspi_soc_data = {
>   	.has_dma = false,
>   	.cmb_xfer_capable = true,
> +	.supports_tpm = true,
>   	.cs_count = 1,
>   };
>   
>   static struct tegra_qspi_soc_data tegra241_qspi_soc_data = {
>   	.has_dma = false,
>   	.cmb_xfer_capable = true,
> +	.supports_tpm = true,
>   	.cs_count = 4,
>   };
>   


Reviewed-by: Jon Hunter <jonathanh@nvidia.com>

The Tegra change looks good to me, assuming that everyone is happy with 
the other patches in the series.

Jon

-- 
nvpublic
