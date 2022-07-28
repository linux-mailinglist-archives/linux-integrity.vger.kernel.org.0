Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9463358452A
	for <lists+linux-integrity@lfdr.de>; Thu, 28 Jul 2022 19:48:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230029AbiG1Rg3 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 28 Jul 2022 13:36:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229812AbiG1Rg1 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 28 Jul 2022 13:36:27 -0400
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-eopbgr130050.outbound.protection.outlook.com [40.107.13.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 150C27390C;
        Thu, 28 Jul 2022 10:36:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MoS6Iqenge9tctIhqikN5c18DUWfOemlopMOkhZvhwUD+lLwX2p19SssC3e+u/EU3hY1TZrzCltXhFfhjt8xC4m0c19GaAgthsLcuozudU9ep1uOrEMQ1eJPqCIFaQaFifSfdhM67+DvyLSngiQuh8qWpjHMaE7xWkIOvRMecA7SSHkFJJXE7TgMJOhFfsGwJB/Wl7LDRu5KHHWfslziPHvYKPexix+YFEgg3Uu2KQiNsxnYM/AkfLl7wXQ9veKDuwUBIe3IKB7+aOYK45RgNm3B2nT6d7k4q4+lWP7DlqPWSt2u9+dpRRoOfGged9/mZ6PtSQBPZq3kXXnRSge7GQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z7wA359+j2HQLoqdTLxzv+GEWrJNiRQ4gdTiQTCCWXc=;
 b=ff3gkk2iXiUD4iB1Qcvw0JoN5xYmLnyHu8cetmo+ssoHE0esAXt9JJJkGFLNr8zXKuu2pAzOaXsEtGuxczkOc5x5dYgKmov7SMJ3LAMRd5DfzXA2wu70KkPnnO/Nkw4wwSfPWhndQraVBXEFLc0Ntr7Z2L5aHZks44fBEszuDBLhBURpwHeoNFOisGxq1B947orPLOdna2b6Pldn7ZYofo0Id+OkDg5R96Uu20YTNvZJ1A1rWJM9TNQoG8v/QEYZV+ILlbr0H7/inywJcopIzBGEU/JkAEZyxLkFL0qMPbxYVG+OECkS2rrw+5ztBO22NJwEDhJpxenXn9lYmx9CMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kunbus.com; dmarc=pass action=none header.from=kunbus.com;
 dkim=pass header.d=kunbus.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kunbus.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z7wA359+j2HQLoqdTLxzv+GEWrJNiRQ4gdTiQTCCWXc=;
 b=VkToFfd6V35UaBVIPG8JKji+BbAjojtIDhViE59htd/PIKL4FRrlRBOZhtwoILCqcsvmOO8FNb5Wzsa4RtDJChXzdSbG5EM3QdM2W59/vIKj4qgQMWNBwoxJ+1/u9rE1gvTnjSWUA/kmGv8wbaSZrgXQlQ7/avmXWxVo0BrTZr8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kunbus.com;
Received: from VI1P193MB0413.EURP193.PROD.OUTLOOK.COM (2603:10a6:803:4e::14)
 by PAXP193MB1471.EURP193.PROD.OUTLOOK.COM (2603:10a6:102:136::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.19; Thu, 28 Jul
 2022 17:36:23 +0000
Received: from VI1P193MB0413.EURP193.PROD.OUTLOOK.COM
 ([fe80::10dc:b784:6939:db99]) by VI1P193MB0413.EURP193.PROD.OUTLOOK.COM
 ([fe80::10dc:b784:6939:db99%6]) with mapi id 15.20.5458.025; Thu, 28 Jul 2022
 17:36:23 +0000
Message-ID: <570976c3-8292-092d-5e0c-25eef63f7f3c@kunbus.com>
Date:   Thu, 28 Jul 2022 19:36:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v7 07/10] tmp, tmp_tis: Implement usage counter for
 locality
Content-Language: en-US
To:     Lino Sanfilippo <LinoSanfilippo@gmx.de>,
        Jarkko Sakkinen <jarkko@kernel.org>
Cc:     peterhuewe@gmx.de, jgg@ziepe.ca, stefanb@linux.vnet.ibm.com,
        linux@mniewoehner.de, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org, lukas@wunner.de,
        p.rosenberger@kunbus.com
References: <20220629232653.1306735-1-LinoSanfilippo@gmx.de>
 <20220629232653.1306735-8-LinoSanfilippo@gmx.de>
 <Yr4x6KRSvzlXNdH2@kernel.org> <f0e33bc4-335c-322a-9295-18d6bc0b8286@gmx.de>
From:   Lino Sanfilippo <l.sanfilippo@kunbus.com>
In-Reply-To: <f0e33bc4-335c-322a-9295-18d6bc0b8286@gmx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0140.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:95::12) To VI1P193MB0413.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:803:4e::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: faeea984-fba7-44f9-ade3-08da70bfb08c
X-MS-TrafficTypeDiagnostic: PAXP193MB1471:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hK2XTCG/RM8pKdEdCskbwpxMnRu9fnUnVh+vU+e7Z3qqcukF/sPR8UYg5m3lYeWAjXJ8q+Yns7DN7o7DRtqQ2yt0aYDN89XGzSthX6/c8lRrdjgPnhjUA1PaVKabfBbnikLlXemE4XpvDI2RiGf6Q5iP+nqeElp+wdxYfWL5NSuYk+sFUtdDkRGplO6DbOpRAT+PsX2Q7l0xzTxwe5BguEzjZXMn1DYZ81vEDaQ2Irqf/lakIS8gLfuWMtqULOCLlORcKoMRSg57e1yMwu9t4edvOaRqxOkpQOCU63svMkKydBwFwkqGpNUaJuJYEDRIoB6tBTixFsO4SCA4alXQD58SgJxK9AU7yRKY6M0ElOXOZH3L/u64BMQ2DaXE9HR5+oBK1wa6HlXE7OmlKGRKbZNpJZ/mE38CcyqpWcx2up+iEYPapREtZPfsBcwWFkOMvSjm5y0JaoqXjCskIUABtmbZGqrPBII4WDCAEVkC+83bHxDd+sV6L97mYPXYBZT7bFEkncLlw6sHLX1NT3l3PzxxX1LMKOy3TWcrr6uyqFFkSvCFEwR/1jG53thA3PfkmQJ6siuP6GXxI9+6S9WqdHBwQfU8VbGtRUgeytPbcvLQurZeBRxxOWgtDdeyaCtNegDMAhT2C1F6NQ40qhek4vgY//mQ8qtPxxJ5Rj1uDPTi13jue6K7oWlPu1k5MrR91yc0lL29fJJXGx5bH8li1lwW6R09//RUbcCsGXZcmJdF3n6hcKwNeRTnA2Myxhd2s5n/d//gdZ4tlVzb9nLrzv1FT7Ww/MGfE78IJW4bFiyLnZHyqzZDaE9Kioa+f5eqZnpZvhD3PYBAYnBmJhDARPx54+LnI8y7JDMZyJe0q8E=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1P193MB0413.EURP193.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39840400004)(136003)(376002)(346002)(366004)(396003)(316002)(66946007)(83380400001)(31686004)(36756003)(38100700002)(107886003)(186003)(110136005)(53546011)(6506007)(31696002)(2906002)(66476007)(38350700002)(86362001)(8676002)(6512007)(52116002)(6486002)(2616005)(8936002)(4326008)(5660300002)(478600001)(66556008)(26005)(41300700001)(6666004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Nkh0b0xlVWlTalFUdEpaTDJaRW1NK21GS1g4MjJkdmlnN0FwVmh2QkdDR3c2?=
 =?utf-8?B?RmtTN0U4U3Z6WE5yb3UvelNmcEpYc3JZZlJGcFY3THFnRU9Sb3ZWVkRHTzJV?=
 =?utf-8?B?eEViM3pzaVdOOG12bWZWQ0pnMTZUNUloSWczVEF0b3Z3b05NNVREdUF5NHJn?=
 =?utf-8?B?QUxRQzBKOUdWL0lsUU5BSXU4UmNiaUNsWEtXSytCWFJQYlhLODRxU2Y0c1pu?=
 =?utf-8?B?YUF3a1QzNTB3b2FRcTlITE1rTXZjQm4vTlo2WGtMU1FocFR5NHBzMThwck5m?=
 =?utf-8?B?QlBIMGlOZmg1U0RtOGNhQUFxblBqalFvV2lvTHlxZGFYR0pYbktidFZZWEMv?=
 =?utf-8?B?bnRiV2VOZU9hUEhQSU9HZWUvQXBUZjh2Q2Z1REZBYWNCb0I2MTRQbGtXUThQ?=
 =?utf-8?B?RHRvM29HN1d2bGFVWTFzemhBeEtuUzMyMWgwdnQ5SFM2RXhLSy9YMVhabjRi?=
 =?utf-8?B?VTFQYUZ0WUZKKzJOWU10SlBJMlUwQkYyc1h1dDUxTmViS0o1ZUhBa1p1SDUv?=
 =?utf-8?B?QTdnMmhSUlhkT3JuTGs2WkpTY1FLVEpLaXMrS1gvVjhlakQ0UFhxeWs4alVI?=
 =?utf-8?B?RkpmNkNQZHNBbDAzaHJOSmk3Sk1zVXlHMkdWci9NUGJ5MXpLRVNMODBYYlRI?=
 =?utf-8?B?MDlaV1hNdlFmOEJBRTlrbDY0MWhTMmJ3aERYaTcrSkpIdm1JWE9OejJySkNy?=
 =?utf-8?B?cUlVV0tCN1VGaW14TkFBQjljTTNBWjJmcDlIS0ZoMVBIbDV2KytCZkpOamIr?=
 =?utf-8?B?Nm1iTnJ4WXFDbEs2N0xxT0NnTGpVOW1OWGp4YytRa1ZUbERDb04wVXk1WkxD?=
 =?utf-8?B?b1FwV1hBUGx3T0hTS3dJSnYwVGNlcE5GSU1DdmpaREV2OTRDTWVXK0xITGdk?=
 =?utf-8?B?dFdCak5JMWxkV2RONlRwVHpkZjl1eVZrQ09FeDhHY0VNK0g2clI3L1kwMU9r?=
 =?utf-8?B?dnpmS0tFcWc2M3JqVlBhU002cjJNOFNWWThMckRUSCt2Z2RsM2c0bUZnZE95?=
 =?utf-8?B?TnpJYjJ3TXMxb1BaUWpvR3pWeG90ZHZ3U2NUbVJDQzlEZllYektxVzkwaG1I?=
 =?utf-8?B?d09SQ3JhVGZxdnArVFY4OHdYOWtmSlVYckQzNzNHWFVUeUc2c1E3MmNjemU0?=
 =?utf-8?B?QTh1NVRQM0VRcFNZcDh2SGd3ZFNaa0JrWDFLd1BXOUJvRk9RM0N2RndYSVFH?=
 =?utf-8?B?d2FTVzI4ZXAycDgwRWcxVkJwOWVDSTUvbkdNai9nOGxUL3JnbXlLRDkrS0tK?=
 =?utf-8?B?ZGhNbGo3QlZlSGVkNjFyZGlpL0l6Q2NIY25CMUM2dUNtdVQrN0dOVmZGS1dr?=
 =?utf-8?B?M2ZtcG9kUGtQMUgwd0g3Y1EzV2kyT3RVR0tQWU13Q0ppMENrWEhDSm4wdlFR?=
 =?utf-8?B?MncvVVo1ZXhHZVBJUDg4dVB5NmQrQVhGMWVBTjBJQkJUc0tUTE5rbkdseGM2?=
 =?utf-8?B?V3pNSmx6MHovMGo3Vnp5V216d3hTcEs4R3VOQVpVL25RUmV3ODR0Zm9CeFg2?=
 =?utf-8?B?WnN1VFNPRXRvQTFya09Wb1B5ckxjTzArSmFsdHA5R0xNU295cmtZV3BsZnZH?=
 =?utf-8?B?SW5FUTRRRUFqNUhsYW1LMUYxYit5bWJtcE9aNFFwcVhYUjBJT0VIeE5BMmFt?=
 =?utf-8?B?Zjh6bW5pU3ZxL01uWmEyMHZhM3hPbW1EZ0J5V2UvaHVFY3EzUVZVdGo5UHIr?=
 =?utf-8?B?MkR4ck5zQjEwaG1nVWJzVVBMdC9ZMGpjVElmT2pjRzk1dHdrQmpuMnVUbjRp?=
 =?utf-8?B?OGNoaG9TaHJCWE1meDQwdjlFNi9keG1YeTU4b1F0aFdVWEtiU0ZVcGZTTUJW?=
 =?utf-8?B?M1Fzc05YVklXVzZubmJrcmhkZzFYMW5uWVdWTzk3L1owSkUrNVZvVDVwbUJC?=
 =?utf-8?B?azhrQ0xabnZSMGs3VVY3S0xQMW0rajM2K08yR29MeTVRNGNQdzBzWk1qUVRw?=
 =?utf-8?B?ZWtxdXNXMFRtTGpkQjdaaHYzRDRrWFN6R2U0aXVtbVNXenRBYU1zdGJ3TTdN?=
 =?utf-8?B?M3VLVXh3RHkyK1AvRTVjTkN1TWtCTGIyN24yQlFla2xPcDBYaDltOGl1MHA1?=
 =?utf-8?B?NmljbW1JblI0cEF6NFNFTW5VcVNvTUNDY3Yvd1REMDlWUlFveTlpbE5nMWdZ?=
 =?utf-8?B?ZEVUb2haRC94YmhIQmhaSEozVnc1R2ZuL0paZnJ6UnVHR3k4OUZDU0Q2Z29K?=
 =?utf-8?B?RkE9PQ==?=
X-OriginatorOrg: kunbus.com
X-MS-Exchange-CrossTenant-Network-Message-Id: faeea984-fba7-44f9-ade3-08da70bfb08c
X-MS-Exchange-CrossTenant-AuthSource: VI1P193MB0413.EURP193.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2022 17:36:23.0826
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: aaa4d814-e659-4b0a-9698-1c671f11520b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /rT86NylAdSPQmtQDADp42UL59YwbUVblyTXDJ//TeM2vrtTUb7hbk0Q8MUB9GeBdUo7oRmwd6lqnuM6KnyWNQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXP193MB1471
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org



On 04.07.22 19:45, Lino Sanfilippo wrote:
> 
> 
> On 01.07.22 01:29, Jarkko Sakkinen wrote:
> 
>>
>> I'm kind of thinking that should tpm_tis_data have a lock for its
>> contents?
> 
> Most of the tpm_tis_data structure elements are set once during init and
> then never changed but only read. So no need for locking for these. The
> exceptions I see are
> 
> - flags
> - locality_count
> - locality
> 
> 
> whereby "flags" is accessed by atomic bit manipulating functions and thus
> does not need extra locking. "locality_count" is protected by the locality_count_mutex.
> "locality" is only set in check_locality() which is called from tpm_tis_request_locality_locked()
> which holds the locality_count_mutex. So check_locality() is also protected by the locality_count_mutex
> (which for this reason should probably rather be called locality_mutex since it protects both the "locality_count"
> and the "locality" variable).
> 
> There is one other place check_locality() is called from, namely the interrupt handler. This is also the only
> place in which "locality" could be assigned another value than 0 (aka the default). In this case there
> is no lock, so this could indeed by racy.
> 
> The solution I see for this is:
> 1. remove the entire loop that checks for the current locality, i.e. this code:
> 
> 	if (interrupt & TPM_INTF_LOCALITY_CHANGE_INT)
> 		for (i = 0; i < 5; i++)
> 			if (check_locality(chip, i))
> 				break;
> 
> So we avoid "locality" from being changed to something that is not the default.
> 
> 

I wonder if we need tpm_tis_data->locality at all: the claimed locality is already tracked in
chip->locality and in TPM TIS we never use anything else than locality 0 so it never changes.

Is there any good reason not to remove it?



Regards,
Lino
