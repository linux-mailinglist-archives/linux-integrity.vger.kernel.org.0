Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73D797251A5
	for <lists+linux-integrity@lfdr.de>; Wed,  7 Jun 2023 03:43:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240505AbjFGBnf (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 6 Jun 2023 21:43:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240512AbjFGBn3 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 6 Jun 2023 21:43:29 -0400
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2048.outbound.protection.outlook.com [40.107.13.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3A291BC5;
        Tue,  6 Jun 2023 18:43:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MoVliOYJb69eNzZjh1NAANyQyRnukpHSDaYrMIs85LoVrQkL98OCXK1SPfr1xNtlPoq9t/iMacuqJIP2hUzBkoSVXQOtAA3gQ9ENz/d2lsQgy8NcBguHY2G62y9wZt+CGLmjzWoSOQpxYVeF6JZOUJ0VZ6UUuo6Ptd9vT8yycJXJTxJMa4mjcWDtEdDwvtCGYxR3Gb4wlRmhuyuZur1+FJsuR3a2Y/TeHgcoDw7RGO/cPkCMrNcak4yr5b0r/hYe2/cpOChSRMwl1/mvZ/HVvLLIschBNdgfFdDSxCH0W+As9Fwep1zOI6nI21MFXBGgyTePlwNn6lztyXgrtY/qEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=42a/qFDfcJTcEMoGdsYdcatU5+XmxokpvLztZFTaBQ0=;
 b=j6BIBnGbIKmenBEcxIfTPHFeavmwcpuYqb8/L2aWChMXoFqFNXc244gn/TKRfmeXDv9K2LwQTFybFeSpieJS4CejexY2QAvm8TffUsiMcy+QO/uL0F/y1lcdjeskGaOfK7yEQRaf27dk3a+x7N7x5U2N2n7u5lXoZbr/Ey4kxGNs/SLDlGarYhVZ6PKhpttv/orbLeqATQHKzOInTkLjHRqGZRGAitwWpudooojSLUhgiCn4eihoOqrJzKkoLmxuKqkmk7OavK0thDYOE831TemoY1HQeiGnucwjKzfrO88VqBz1+bYbFEJ8qW3j1Peau0XqdzSdbcaImCRO3fxMgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kunbus.com; dmarc=pass action=none header.from=kunbus.com;
 dkim=pass header.d=kunbus.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kunbus.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=42a/qFDfcJTcEMoGdsYdcatU5+XmxokpvLztZFTaBQ0=;
 b=jOovSujWRVv8S1ONNgohgUWW4IfolkFrKXjfIoVRlmudBIHeiEefem6bodv4CcF9a+zMXTZ63aE+suY0exR14thfZcPl16QASuUTC2oWlJVhbu/PMD3LbqW/MnEM2xoANDh62qYrFaEaYebwqVS6x96VG1KO2JlzS5/gxKq3LO4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kunbus.com;
Received: from VI1P193MB0413.EURP193.PROD.OUTLOOK.COM (2603:10a6:803:4e::14)
 by AM9P193MB1127.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:1f1::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.10; Wed, 7 Jun
 2023 01:43:21 +0000
Received: from VI1P193MB0413.EURP193.PROD.OUTLOOK.COM
 ([fe80::6727:e3fb:8fec:72a6]) by VI1P193MB0413.EURP193.PROD.OUTLOOK.COM
 ([fe80::6727:e3fb:8fec:72a6%7]) with mapi id 15.20.6477.016; Wed, 7 Jun 2023
 01:43:20 +0000
Message-ID: <f905141c-1f8e-aec8-470c-19d476e567a3@kunbus.com>
Date:   Wed, 7 Jun 2023 03:43:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: New kernel warning after updating from LTS 5.15.110 to 5.15.112
 (and 5.15.113)
Content-Language: en-US
To:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Chris Packham <Chris.Packham@alliedtelesis.co.nz>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Sasha Levin <sashal@kernel.org>,
        Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Linux Kernel Integrity <linux-integrity@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Regressions <regressions@lists.linux.dev>,
        Lukas Wunner <lukas@wunner.de>,
        Philipp Rosenberger <p.rosenberger@kunbus.com>
References: <fe6f7aa0-56c2-3729-ce8c-0f2d943b33f4@alliedtelesis.co.nz>
 <ZHQIFLWvrWUNMVxb@debian.me>
 <6e470461-1a9b-ec51-bac5-f2beb1dc11c9@alliedtelesis.co.nz>
 <2b09d2ed-0852-bbc9-b792-aad92235c7fa@gmail.com>
 <03daca5c-e468-8889-4dc2-e625a664d571@alliedtelesis.co.nz>
 <ec5245bd-3103-f0c7-d3ef-85aabb4d4712@alliedtelesis.co.nz>
 <ZH6TIjXeXJVMvSKa@debian.me>
From:   Lino Sanfilippo <l.sanfilippo@kunbus.com>
In-Reply-To: <ZH6TIjXeXJVMvSKa@debian.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FRYP281CA0017.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::27)
 To VI1P193MB0413.EURP193.PROD.OUTLOOK.COM (2603:10a6:803:4e::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1P193MB0413:EE_|AM9P193MB1127:EE_
X-MS-Office365-Filtering-Correlation-Id: 53f7272f-e66c-4c0b-621f-08db66f892a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Y6jQpG815cZ8Umn62jlhderzMKEcanJrhBAYZ+KFeiFJlCYA9I0M6YG/i58EjMcsuR259thKfKi1kV5xVYxvsvQTRKpP8qIXCm/REID7c8eso539xJoWPfg8bfR/QxBXK5SUeTSqhtM0bLra+RYuEI7LpJdUDlVZguz96lcrxT4QaDVJlmAz2ybNEXKuQqehtM+iQdQtafw417G5VqjmfLyhealOOkfEMcSLhPJCYVwbFvGv+TBx/mXij9IHUb/y8ON3ouRezhdan+JXYaizqX4BsSHdAwKsiYhsNesuqOWl0FKJiHy2VMmZPwmhijg+Qtk7vwwTP1M6C4p59b+gQJNp5HiSIF6FVEvb49QZAQtoeLP57+P0/1ZDb8QnEEVYuQ2HfnF2kHA0GhOK704TXocXlBxy1eAnEuDGgeip8IuZ23dhACFo6rsVZxWUTpz9E/0p4MVG3HrxsFGCMljn7UY5Z41+HHSAzypLO0ATlDN5/mCR9qIP5+LNPI0xpg5s7cXahyzn+Ftg5uy9yO+YMfC52R6/bLo4Asxy1LvY2e8gDg7D/rVg+WaewdpVUOxGAaCqbe8YmNfhd8z2M24Ys5IoKL0w1SDfiTchd3SDYkEkYEccgscpWBmWWLEmJ1fB7VIXTB24FQUzEkf1TWQe9A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1P193MB0413.EURP193.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(39840400004)(346002)(136003)(376002)(366004)(451199021)(31686004)(38100700002)(86362001)(66476007)(54906003)(110136005)(478600001)(66556008)(66946007)(36756003)(31696002)(4326008)(52116002)(53546011)(6506007)(6512007)(186003)(107886003)(8676002)(2906002)(2616005)(316002)(7416002)(8936002)(5660300002)(6486002)(41300700001)(83380400001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RmFxMXlkNzNUcGlLeGRRQThIYUhITWNRQW91QmYrdGNURGtpVDZFUmFSZkxM?=
 =?utf-8?B?bGt5YnF1bnh2RWlHYjJadHRLS1E1Mmd4THV5T2pBR0VOM2dYVFVyRHBCS1o5?=
 =?utf-8?B?Vk9Ca0NFT2JqaFJqdEZ5WUMrbXpFQW10Wk9TdXVuY2xYZkgrZlI2U3BtNmRM?=
 =?utf-8?B?b3pxWHZaditlMmo3MUo1ei9VOU51UUFIR3Qxb3F4L01vSU9oSGE3TmZ4akIy?=
 =?utf-8?B?M2FaS2lPVEdlT3pXektWYkRxNnpVOVZhMmNUV2tFK3pnWFEyZFZZRURMbTB6?=
 =?utf-8?B?Rm0vU0Jkc1hRaGpISzBKZkJoVFdoMGc1UUIzUnIwY0pId2hlWjdIanBYMUpy?=
 =?utf-8?B?cjFtaElNdE1WclEvcllxYjJ1K1JqVDFkUm5MbFdJUjQ2YUw2WUtGU1JHZHBL?=
 =?utf-8?B?UGJiSnRXc2dUeHp3MTFzSG9MWGFycHdwWEpiV0grdGFlWnhBOGFUZXJzYnQ4?=
 =?utf-8?B?NzV1VWRNNTdpSjd2RDJtRVFIdFFMTHYvblBiNHlLU0dlWGxJOThveGd1M1pw?=
 =?utf-8?B?c2NYK29jTVk2aDRybm1GNzZaUG10N3JoYmlTQ0t5ZkhLbUlrdS9wNFpEU0pl?=
 =?utf-8?B?LzlJWWJpQjk4T3hjbkhLSzZrVjN4VVQzYyt5Z29oa09GczQ5M1BiSUExdkIx?=
 =?utf-8?B?cHlKWjBGa24weTZxS05FaGEvUDRCQk5LZ2M2bm8xTzk1R01yN0tueFJQZnor?=
 =?utf-8?B?WUFyMWZDRnVUc2dQOGFUMmxZZXZud2NmN1p1RU1laWw2aG1JMmNHUjVIL0hy?=
 =?utf-8?B?UE5kUHM3TVpqb1cxRm1xbWlxbEU3SDNxcWkxUTNHaVVqbGVrTzhXY3BWQWhz?=
 =?utf-8?B?cjJZcFNpSTBTQ25WZ3NkTmVZWk0yeVpWRkU2K0hXS2NxTVV2NXdibmZYMG4x?=
 =?utf-8?B?M25RWEpaaTdzc3REelF5RTJKL3lSN2FJcW1SYnFpOHBvanlkZzF0R3drSTdF?=
 =?utf-8?B?R3ZpNUhLbUcwS3p3a2Q4aEMrRG1HNUs1RmI3cXc4U2NlVkFBS0w3TUUxdEQ5?=
 =?utf-8?B?YWFLZUczdXg4cHdBM1JQNTA4ckpWK0J2QVpWVlUxSDE4QkpzcjZWZklhcHQ4?=
 =?utf-8?B?TjJBeDZZWFA0MDkzSHpMcVA4WklzVEV0VUNvWmJkVGFlUXUvMERmZXZNVnU1?=
 =?utf-8?B?b2M5QUErSGhMU0JVL3o2S0VSemZqdEtYa1BNR1hCQ0NTQkFtZVBBT3J2Vyt2?=
 =?utf-8?B?cDgvVjc1UWJGQjNMTXFvL3dpc2xVWHRLNGd4a2s0Zlg3KzFmWGxUUnZPejVN?=
 =?utf-8?B?cGltb2FuYzRzMkdGUWFyOFhjYnFtTzA4amQ1ZGMwMVZKK1VHR1VsWnZPT3lG?=
 =?utf-8?B?eDdwYSs5TWs4NzlYQkhGZ25hWEhMTVQyN25kZVhiVXRSa2lhUlZ2ZVNWSlZz?=
 =?utf-8?B?cEZIYk93bG5POVZ5ZmRyVGVaUXlsaTBMc2hOWFUwNysxdVNTSXpwLzF4OHdt?=
 =?utf-8?B?a1dJeFZNZmtQN010eFBDeTBwSzVpSzJOOG1WbUZWcVdFWDV2NmlPRWlva2Y2?=
 =?utf-8?B?VFhES2hGai9kMWdFaHIrZWx6WXZSNWpxaWo0NC94ME85QmF5NUVQM2xMeXRl?=
 =?utf-8?B?MTUwZGtNc2Q4N0xhY2ZTcVRKNnBEQVJrWjBISTFGYzNNdHhRL1dTOTZ2TjNo?=
 =?utf-8?B?N0RXOUFPQm8rQStWZzh2K3FRc3FmUFhiU3Q2b2Faa3YvU1NaZnV4SmVpWlRH?=
 =?utf-8?B?QzE4VC9nOHFvU3U5Slp0QnUwblBiVlBSWkRTbENrVXgvaTdZNVRObUU4c0JJ?=
 =?utf-8?B?R1BHUnlYTGxDODZGbDh2UllyQ2RrM21kQWRzR2o4dTlFVG02YlRrNFBrYTNq?=
 =?utf-8?B?OU00VXJDcTFYbE12Tk94a1RNSlgveTJ0TThoRnlUSWc5ZHZhd0JTWDJUNnB0?=
 =?utf-8?B?eGxUMVlMYnBrY0VuSG9HdTc4b3JSbGpGdGtPL1crcVBNd2tGTWRGZ005YVNy?=
 =?utf-8?B?bUdXcDJJOHVkblNOM1J5ZmM1czBGckg3bytrYVVJSUVXWG9Kb1dzRWllcE9M?=
 =?utf-8?B?Q0QrTnBIV2M2Sy9KZmVRR2RUQllaQXlNRFRHQ0hiRkhzcitGSGZYaEhlaGll?=
 =?utf-8?B?eS9kZitFMGJ1QXZJQVVLNnRIUDVKbkFnbTdPdTlNUUUycXE0ZlNaSUxURGI5?=
 =?utf-8?B?TXMyNTlwSDlFdmkrSlFrY1d2Q0hYWnpvM3N2Y3pFcG9IWGdRYXVhYzdzY2tY?=
 =?utf-8?B?Y1k0d2xia3lpVUpOMmxUVVBLdXdXNmhzV2ZPbmRmZGhjVi9ZS1NJWXFWNGY3?=
 =?utf-8?B?aUZ1NUV1YnZrbFMxaWtEV1VJTlFBPT0=?=
X-OriginatorOrg: kunbus.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 53f7272f-e66c-4c0b-621f-08db66f892a4
X-MS-Exchange-CrossTenant-AuthSource: VI1P193MB0413.EURP193.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2023 01:43:20.4982
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: aaa4d814-e659-4b0a-9698-1c671f11520b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ga62OdP+ko/yL5dfr8B3EloJd7HivZhW3icCIOQWv2M8ewqMe9w8YatlxROUj30wWQRLXqKlRFDnkl76OuqGsA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9P193MB1127
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


Hi Bagas, hi Chris

On 06.06.23 04:00, Bagas Sanjaya wrote:

> On Tue, Jun 06, 2023 at 01:41:01AM +0000, Chris Packham wrote:
>>

>>
>> Bisecting between v5.15.110 and v5.15.112 points to
>>
>> 51162b05a44cb5d98fb0ae2519a860910a47fd4b is the first bad commit
> 
> Thanks for the bisection.
> 
> Lino, it looks like this regression is caused by (backported) commit of yours.
> Would you like to take a look on it?
> 

Before commit 51162b05a44c interrupt activation has failed since the concerning register was accessed
without holding the required locality.

Now with the commit applied the activation is successful and the interrupt handler is called as soon
as an interrupt fires. However the handler runs in interrupt context while the register accesses
are done via SPI which involves the SPI bus_lock_mutex. Calling the (sleepable) SPI functions in
interrupt context results in the observed warning.

To fix this additionally upstream commit 0c7e66e5fd69 ("tpm, tpm_tis: Request threaded interrupt handler") is
required, since it ensures that the handler runs in process context.

Note that even with this commit interrupts will eventually be disabled since the test for interrupts
still fails (for the test to succeed at least upstream commit e644b2f498d2 "tpm, tpm_tis: Enable interrupt test"
would be required).

Chris, could you test again with commit 0c7e66e5fd69 additionally applied and confirm that the warning is gone?

Regards,
Lino







