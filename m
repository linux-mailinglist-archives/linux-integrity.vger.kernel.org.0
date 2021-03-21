Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 570173434D1
	for <lists+linux-integrity@lfdr.de>; Sun, 21 Mar 2021 21:50:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231134AbhCUUta (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 21 Mar 2021 16:49:30 -0400
Received: from mail-eopbgr20076.outbound.protection.outlook.com ([40.107.2.76]:52302
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229990AbhCUUtF (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 21 Mar 2021 16:49:05 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=krlA1lS97XlnBCegX8oJb3rnkQSR2ozwOYN9AbgxWEeuCVWuyeRcSueng40QTXtj/sSwqDqX1bdtM8/ncoykckPDJrPIzoz4ECtbn3wR+AWOq1cR5Djxc2CALGRprup7FjPle3ImSOBgeco2/1R0sh1QU0ib48ZE/Efi0Jif/siixg9JIwAvIaMqqMztfnqnJWo/9aQStTB0WmCoufdiMtZhzxhwehqpqTK0X56i+V66Vjc77FL7f3U06a2e2h5Krx3xsYmnjXAYipev4UebOYczucWQXor8tU1enNoqWkmcJXEBtA9B+NcaXoVnwHzOh6DKWAA2l7GgCGJud/SaGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6YE4Vwd6gHHMEYEh30nRhJnLDc7kEXVY1QZ/PrQS1S4=;
 b=aZHb4Vkto9QnazIDQ0RByr4YP1N+xWSubUfu1inBXUv98b5LUpb1ocpKUXINm/56LCQYcvZr82hB0AyIQLilS/tHomtGdl4HbKXILwzcFiVLpyfJhlXZxMRSmrFhf5kWHXEs0yaMB5UDWmJLBmDAygEz/NVN+01PefskpFl4IcR4N6ZxUc+vp1ayf/7jZ+Q1hvykqDsyJjcy0cETLZ/6rZqJ8rujWJAi0o6OPXnX6AoXh2UJlol4D0i7X+AbyuDVwONdUWHRDOy82npay0Orfd5Vz5jxUXL3fMAoMCixzQkCG0geUsxtJbNqkttWqZVIdEyJMayUBu6X0sgtmZpV0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6YE4Vwd6gHHMEYEh30nRhJnLDc7kEXVY1QZ/PrQS1S4=;
 b=bjw6Z+8yy+bbgAmRyHFBf3zx0CBZsdqn3OthqdFQGxhD9SrIHV0BymKzH+A7tMIWY0fQRBOXDBvTA+NllcpK7XSRASr1m6/Hd4G6UpXRkp8vjEjITPZKhQrxF4/vTp/A/xdwdjwhTMFBGXWYKXN//xFgyVt0oq5XzCu5CZuDbU4=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4038.eurprd04.prod.outlook.com (2603:10a6:209:44::24)
 by AM6PR04MB6182.eurprd04.prod.outlook.com (2603:10a6:20b:bb::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18; Sun, 21 Mar
 2021 20:49:01 +0000
Received: from AM6PR04MB4038.eurprd04.prod.outlook.com
 ([fe80::ec5b:262e:8c27:c742]) by AM6PR04MB4038.eurprd04.prod.outlook.com
 ([fe80::ec5b:262e:8c27:c742%3]) with mapi id 15.20.3955.024; Sun, 21 Mar 2021
 20:49:01 +0000
Subject: Re: [PATCH v1 3/3] KEYS: trusted: Introduce support for NXP
 CAAM-based trusted keys
To:     Ahmad Fatoum <a.fatoum@pengutronix.de>,
        Jonathan Corbet <corbet@lwn.net>,
        David Howells <dhowells@redhat.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        James Bottomley <jejb@linux.ibm.com>,
        Mimi Zohar <zohar@linux.ibm.com>
Cc:     "kernel@pengutronix.de" <kernel@pengutronix.de>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Aymen Sghaier <aymen.sghaier@nxp.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Udit Agarwal <udit.agarwal@nxp.com>,
        Jan Luebbe <j.luebbe@pengutronix.de>,
        David Gstir <david@sigma-star.at>,
        Franck Lenormand <franck.lenormand@nxp.com>,
        Sumit Garg <sumit.garg@linaro.org>,
        "keyrings@vger.kernel.org" <keyrings@vger.kernel.org>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>
References: <cover.56fff82362af6228372ea82e6bd7e586e23f0966.1615914058.git-series.a.fatoum@pengutronix.de>
 <319e558e1bd19b80ad6447c167a2c3942bdafea2.1615914058.git-series.a.fatoum@pengutronix.de>
From:   =?UTF-8?Q?Horia_Geant=c4=83?= <horia.geanta@nxp.com>
Message-ID: <01e6e13d-2968-0aa5-c4c8-7458b7bde462@nxp.com>
Date:   Sun, 21 Mar 2021 22:48:58 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
In-Reply-To: <319e558e1bd19b80ad6447c167a2c3942bdafea2.1615914058.git-series.a.fatoum@pengutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [78.97.206.147]
X-ClientProxiedBy: AM0PR03CA0018.eurprd03.prod.outlook.com
 (2603:10a6:208:14::31) To AM6PR04MB4038.eurprd04.prod.outlook.com
 (2603:10a6:209:44::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.0.213] (78.97.206.147) by AM0PR03CA0018.eurprd03.prod.outlook.com (2603:10a6:208:14::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18 via Frontend Transport; Sun, 21 Mar 2021 20:49:00 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 0ce46492-767b-4613-fb5d-08d8ecaac1e2
X-MS-TrafficTypeDiagnostic: AM6PR04MB6182:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR04MB6182CCE05D87581414B1259898669@AM6PR04MB6182.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1923;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XAJQAvIbHTIKaz4O+IHRwrNjj/4joRLATDU9N6m6kOjHpMU4Ot+KR6ix14VvebhxXe5oauC+kKHndihXa+ia1S1LdNqRna9fe5w4o5/EVBZxNRvjA2B3Wk5hvXXvuo3iCKLiRdXcwPNMqJNs7LXVQrzzqpAo/puhZPcpyiLSwvtsHXnC/a3RvF63uYQvHRRFXbOcpaQCoR8x0ThxplqaLFMBWPuifdYLd2Pr/f1Vk6JcQbrgVfLEgJwQOBUoyeh00A6REKNVKTfuo/DnxAVisGfp6w4kuxEJ/nIjQ2QVfosYF5d5D1cbyXZt2PoRTk89baRuydu6t9hdGkbenpwaguy87SAyNG9nFIWTKBYV103SeZf/i04LUJ7ZHNwiczVRxcsO1aSsyobtkK5KkARtecm6zluMcANxYUx881voZqL91xpTTWxkeJQ8po2jBPh32l9mXzey8nnygZiC8RSYfCK4xlxiCnmDv+r1sdrAeAleW8f7inxEH3+HUCfRCQ+ls4pqs+sKe9VyzXjH4ykwnf5xhKOJffgtRvd7XxmXt0SNTQyucpgv1yCDZRfdHkHD/WcvWxm9z8GSTT32OzYuW/qE8mS4L1Ruejbn2TWZlUzyaDC0FG76okty9nvjWw+T4siSt8ylE3muJ4lTJoDLAwAqWxadxTIvZrz7gtQMLeWISe6MpGMdyOwTodJuRrlAig/p+KBQupHSHC1DPJyQvw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4038.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(366004)(376002)(346002)(396003)(136003)(86362001)(110136005)(6486002)(956004)(2616005)(38100700001)(5660300002)(54906003)(186003)(66556008)(16526019)(66946007)(66476007)(316002)(8936002)(52116002)(26005)(31696002)(16576012)(2906002)(7416002)(31686004)(8676002)(36756003)(4326008)(478600001)(4744005)(53546011)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?N2drYzlYcWRrcGJrM0EyYjZOWjlDdFh4SlBwQjEwTlVhU0xTUDRHK0lVQ3ps?=
 =?utf-8?B?YStkbVlQNG5MaGEwL3ZpbS9aZVBqL0YrcVdRa1M0TjNUWTllOE1iTExCaGR2?=
 =?utf-8?B?VVRoazFJdDdRK2VvY1pYRERZMDdaTnYva255NVFDSm4yMWVyUENITlorTjJI?=
 =?utf-8?B?MitwUE5GaHd3T0NhVWxPeU82ZHpYMEtqM2pyK2VsODYwaG9RK2tITnRLSlNK?=
 =?utf-8?B?Z2hmZXNVYjRYbDJCSzZ6andOSXlUS2kwYW00MW9RRERiUVJrL0JSNVFrMlM4?=
 =?utf-8?B?TzB5ZVJSbmhNUms3ZHY4MG9lN3kwQnVwamZnQnkxNWU0T01OcnJIb1pHQnYw?=
 =?utf-8?B?TWFGMUlOUk53RWluL3RESHR0Y2pzK05ZSzUwTURsWmJXOGNlV3VzUHdkZ2cv?=
 =?utf-8?B?NDJqQjlySUpTSmFQRktOQ1NCSHNFY3FUQXNQS3hDZHFqWU94K3VHUHRZWWxT?=
 =?utf-8?B?dnYrMlFtNCt5Q205NDR2NUh4QzZoK1F3ZXk3NWFWald0Nm1jcGx4TXhLc3NW?=
 =?utf-8?B?bThaSVB4cTh2U3dNeFZ4eEpUNUY1VE9SWjVBdlFzanZQY0dKMDMydmZCVDJJ?=
 =?utf-8?B?enIxV0Y4cEo4U3Zmb3BaZHREbWtOQVAvenBZajAyQldXSmtBd0EyOHBVNTNa?=
 =?utf-8?B?c0JoWXJSUkU2T21odGd6T2dranJhb3g4SlIvUTdzNU5vcDhyTmE2MU5rWDgy?=
 =?utf-8?B?alRqYTd0QkdIaktzeGNBazQrMGVPLy9CNXc5N2ZjM29WcGpnVWMvaFoyNDBD?=
 =?utf-8?B?bnhXNnA1eVZoeHI4VUs1eE8yc2gvand3U2N0MHNBdVZ2NUNuREYzR3lvVEg4?=
 =?utf-8?B?NTdLbXBPWkVqaHNvdVpxdnZrVklDVzhOVWFQUkMwbjJYZ28rOUU0UU0ycm5l?=
 =?utf-8?B?TXpzaFFwaElsSi8zUExySHpmZW9yRnJTa0I4RW5FSk1Rd0tnVzg2ODJvKzFm?=
 =?utf-8?B?Vy9ETllNb0FnTEZkRUxxS2VyTll0K2hYRUlZSDFlUUFTejRmUkdkZURkcTBC?=
 =?utf-8?B?eDNMTDFLandYUGNHdFVqREh6UURkYmo5Q1lmSmhiQXBvOTJ1aGdpdklaVFBD?=
 =?utf-8?B?eVpvV3hyRWRWajFibXFYNnFvdHRVYytLRnJrTmFuWTQ0WHpHWHVEM3ZNbFdr?=
 =?utf-8?B?UVgwN0NDSURjWFQ4blc2T0xKWWl2WEhmY1A4NlJhZ3RBcUdqZlV0QjQ2aXFT?=
 =?utf-8?B?cDdwSGo0TjdTS3dMbVpqa2xVNDJKd2JoR0dXSWUyNEd4SjRFUnRsdEU4ZUVP?=
 =?utf-8?B?VHB4NGZxa0d3RDRjTFZtb3VDQWdnbVhITnc3ZndUN0xNUEFOcDA4c3ZoYWhk?=
 =?utf-8?B?Z0E4T1dhNFVkcDZlTWVuWUpJSFBHY3BwOFFmaTlTMFRhWWNXa1NRS29Eb0Rz?=
 =?utf-8?B?SUhBb2l2VWhHdFFWdDZtbktURkwwZUJ0TWJvcVZzMFFQOUNaVU9CSFlxeFhw?=
 =?utf-8?B?cmdvZHBZelZkUkdrNnFUamZiMmU0ejR6WElMdWpCbTE0UlUreHA2eHFNL2pS?=
 =?utf-8?B?akxUOGUzcUM3RW5JYnFMNnhuZ3dFM21WNEFmOVRBVndXVVl3VUZ2cjhuZWVm?=
 =?utf-8?B?VCtvNjNKdTA5RGttV0pMNWhuYkdJR2dqa2ZlU3loUlEvaXU0TitUd1dVZ3RR?=
 =?utf-8?B?VllhNUw2dUJWVTNUNmNBb3RVeXY0b1QxZ01KZWZOUnF5WXlhd0o5UXU0U2Rv?=
 =?utf-8?B?eUFYRHVqenA2SitTUFU1QWt3ZzRuNDVlZjl3REQwenN2ZlpQb05LMHZUZ2hD?=
 =?utf-8?Q?HaUgxmmdv6DiOGLmufcqyj+hCNGdSuLsRqQnufF?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ce46492-767b-4613-fb5d-08d8ecaac1e2
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4038.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2021 20:49:01.6827
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OITSzcuoxSyoMpb8yf4axE6pMidWR4qyts7RAIFSEim8TkdYMr79ZslMrQ3sHQ83E/lkzDzBc1ix0SJ0pzDiaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB6182
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 3/16/2021 7:02 PM, Ahmad Fatoum wrote:
[...]
> +struct trusted_key_ops caam_trusted_key_ops = {
> +	.migratable = 0, /* non-migratable */
> +	.init = trusted_caam_init,
> +	.seal = trusted_caam_seal,
> +	.unseal = trusted_caam_unseal,
> +	.exit = trusted_caam_exit,
> +};
caam has random number generation capabilities, so it's worth using that
by implementing .get_random.

Horia
