Return-Path: <linux-integrity+bounces-558-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D5F881B9B0
	for <lists+linux-integrity@lfdr.de>; Thu, 21 Dec 2023 15:38:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A1E271C2359A
	for <lists+linux-integrity@lfdr.de>; Thu, 21 Dec 2023 14:38:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D364A55;
	Thu, 21 Dec 2023 14:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=politoit.onmicrosoft.com header.i=@politoit.onmicrosoft.com header.b="X0Uggb33"
X-Original-To: linux-integrity@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2112.outbound.protection.outlook.com [40.107.21.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18EEF360AD
	for <linux-integrity@vger.kernel.org>; Thu, 21 Dec 2023 14:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=polito.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=polito.it
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FpoQLVxTfzr0uMQBRIMOiLdFc3dsqq31WeM9VLFKFnrnj1V4AaBI0HjEsx9cIpV4aS4ZarhypLdammYt3OmGZlVBWYhmzF+2itdVEvGizLpiCqANLKxcbfvgRuQj+dU2o5KYV7aZF8fzKcJO6/Xx8RAgxRv9/1mKdSq0+0ASzuHHhEB8qSNoWtOK+voNgInm4zfUO/YqtHghlLflEQSSa4iSG2uXgNSHeq4/chpvEsO0WwiWoQ7NseRSGla/BLhbP0Ierfp7tfvcLr8ul4wjJmRGp6qL+f1IBeYY4muf2qzvkZC1JJ3CczK7n7nRsy97klQojyDaD/Zp0cGVlbdo1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VgEiVXtStfbF8IBsKSMzpAO4s74yNBwpKFu/4gZeWHI=;
 b=H+nCFEvmSzWTsAAe62HZvROS6R9cBJtbaG6oBPo3eGq9qqejeBjh13IqQ3OfrzeFydSxKAc+3elBmSAACDZCEZk4vccZBPjW70+7WPEHTPpaA2F9H0k/0kTcAAgjChJ2wbLQhgOXBoocz+otR3Ycfhm0WLw08FEqD4TLqhEm+Pf0hLzwOmoQAjn+wV8Fls0PxgLVoZ0xM2yrEGrFx/3NyMtMxFi3kqoOe7GiggihySQmWHXLsl+Kb9z1zeDXreJlDXcNuehl7c0qsgCAbhaK1HMd6IQeej6XX86pybAvuqf+L06kEwRfxx0nuMipjTikOyReQJb9WJWFP5ihLhRK9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=polito.it; dmarc=pass action=none header.from=polito.it;
 dkim=pass header.d=polito.it; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=politoit.onmicrosoft.com; s=selector2-politoit-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VgEiVXtStfbF8IBsKSMzpAO4s74yNBwpKFu/4gZeWHI=;
 b=X0Uggb336a4zlHn1Ub00dyTxicvs3ILdOiqu57VhpHh7YlTVBhrxNlM69GomJUA90jSRrbDrX5b/EgOjMQH4mXAUSev32rEx9v8QVzlF0GcbjeErjC/TrdlXQD6oC/HrdosHWGUEoSMdq8nJOEgdyq42u8JroakQ6NjZyzyMA+0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=polito.it;
Received: from AM0PR0502MB3603.eurprd05.prod.outlook.com
 (2603:10a6:208:23::21) by PAXPR05MB9615.eurprd05.prod.outlook.com
 (2603:10a6:102:23e::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.38; Thu, 21 Dec
 2023 14:38:19 +0000
Received: from AM0PR0502MB3603.eurprd05.prod.outlook.com
 ([fe80::8b05:2cac:f9ea:f12e]) by AM0PR0502MB3603.eurprd05.prod.outlook.com
 ([fe80::8b05:2cac:f9ea:f12e%6]) with mapi id 15.20.7113.016; Thu, 21 Dec 2023
 14:38:18 +0000
Message-ID: <a27cd216-ab70-46a1-8c2c-4640728c99b2@polito.it>
Date: Thu, 21 Dec 2023 15:38:16 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC][PATCH] ima: add crypto agility support for template-hash
 algorithm
Content-Language: en-US, it
To: Mimi Zohar <zohar@linux.ibm.com>, linux-integrity@vger.kernel.org,
 roberto.sassu@huawei.com
Cc: Silvia Sisinni <silvia.sisinni@polito.it>
References: <20231214145152.36985-1-enrico.bravi@polito.it>
 <8bf7eaf170cf609fb4280475d3340179283fd196.camel@linux.ibm.com>
From: Enrico Bravi <enrico.bravi@polito.it>
In-Reply-To: <8bf7eaf170cf609fb4280475d3340179283fd196.camel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ZRAP278CA0013.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:10::23) To AM0PR0502MB3603.eurprd05.prod.outlook.com
 (2603:10a6:208:23::21)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR0502MB3603:EE_|PAXPR05MB9615:EE_
X-MS-Office365-Filtering-Correlation-Id: 5eb67ea0-0c2c-42b8-661f-08dc023278ff
X-politoEOL-CGPAlias: 1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Bh6MqWQ142ZE9RgHDfxA249fJ0qI9HcwZ39yx2zVPLtdkWW5BKLgnWVkjDwzTzRAgr2YZgyV7Qy51+c+vgbjZ2NCC7DGY3DvCPit28ewAclruwFeIMeGHudwCRYs+Dr41M1XpVGyADADCSm+wSuLyADZJpCwlPFCdPbdWFAB/2s3jRD1D83Y0AiQyQ4V5VlI6BzP57PI2egkcPG2Ie1qwI972+emda4kSqPxpobnBl7BLtbTKli7rw7EmmI4iXJFE8YTto9Va8JX2MRdjKWf0m01AmBY0oXgVrfMTU98oo5i2nXaRv6IIp0P0tK2v4z/s2OcUdGUnXgydTDIWYcvFjeCr9Fs0DbVf0FF0OX1DdQ2MdUxBQ+LvIGojdz9+SwJmq6Iuj6fDJfOdjaFkKK3ZUXIrbv4JlJURrUbWGbYffi3we9MOWGzfDrqDq2ba9DtG62FMBczHuD6UeWlH1fiICbwVamITYGhY2KqLyzzzE28C9AtVtx5UT2AWOyE1rZg7mTurHoroTZ7Wjb8t1ziNllKR2ROzrPxekB/H0YOBFeLoVwRICH7mvGOb9L33PY+AIOHcnWxkwntdikXvnGYqaVI/qjQoy9Cw6ANIBmUaHSP4k0m7eLIu/3T2qF5szSA/eGPJSCo+YwrB7FBaWKw3w==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR0502MB3603.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(136003)(346002)(39860400002)(376002)(230922051799003)(186009)(64100799003)(1800799012)(451199024)(66556008)(8676002)(8936002)(6486002)(4326008)(26005)(786003)(2906002)(478600001)(316002)(44832011)(66476007)(31686004)(66946007)(6506007)(5660300002)(53546011)(6512007)(86362001)(31696002)(2616005)(38100700002)(36756003)(107886003)(41300700001)(4001150100001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RjB3R2t3NEpXQ25FU0JkR1UrV3VGc0lEY280RlYrYjdJTUhjS1NqS2FNdUh0?=
 =?utf-8?B?ZmxML3FmRGUzVlhNaVo3Njg3ZlJBVUxibmRuQVM4Rnc5RkxtaVVFZndpanZy?=
 =?utf-8?B?LzZrb0NtVnhJWjY2ZVcxMzFTOUlxeTNxNkVERmFqSVd6Zk1NK25uQndRRlUw?=
 =?utf-8?B?NlJlN1lKelRDak5XZjlsR001YkI0cGNnaExPK0tRcHFSRGRjdmgwNG1CNm55?=
 =?utf-8?B?YVNEVVpzODRlUFdlcFBDVXdtdG9YM2Y5T1VPWjc1eUVCaXFxQXFDNytzV0RW?=
 =?utf-8?B?THpHRlg2NFZaemhpeFk4RUZhNkswNkJScXhDM20rajY2SmJsY1AxTVRqdnBG?=
 =?utf-8?B?R1ZlT29YNjV2K0xRUi91bFFLc0dYMWlRWHNseGllUkxxWURGY0hnK2RKN1ZL?=
 =?utf-8?B?akVPWGZsQjVTR3FhYWUzckZqaDIvbTl3bzJTd0loYjZHUHJkZnUvNnFXNGw0?=
 =?utf-8?B?YmE2eGFRYjkvZTJZdWJTSi9wRWl4SVpIb3ptM2NqSWg3Ky91OU1rQ3RHK3B5?=
 =?utf-8?B?aVpYRjVXRDAydzNFNEpycldzTzlpaStDV1gvTXlGa0J1ZndMTzYxa2wxdmkw?=
 =?utf-8?B?TkdZTVpIdDM2VWJsSzhDVVQwRWMrdTNSREhLeVZKaEppZXAvZGkyWjBYRmVI?=
 =?utf-8?B?TlByQ1k4SG9yOEVhNzJzcTBJZzdrQmlCNVpGZXd0Q1dwVXdsbFlWb3R2MmQ2?=
 =?utf-8?B?dTd0bENoQVc4SFV1bS9mbnpQK1dzN2lLT2k2dER5aE8yQkliQnBzRXJpWEwv?=
 =?utf-8?B?OHVoRllUYXJBdTNYemEwZzYrQlZZcWtzTm5jcTB4TXk0cXcxVFNTQmlEa3U1?=
 =?utf-8?B?TC8wc240SkpVcHh6T1dKRU94WnJwZTNsUWdNVnB0RmtsVllLbnRVdVZYekk0?=
 =?utf-8?B?dmY0ZUpwNnpuRmM2Y21KNElYcllwbVIzcTM5cUczTEFLNENIa3lDbFRFYno4?=
 =?utf-8?B?bnEwa29xZU5QUDRVUnh6TXoyVE1tcWJFdGNROWJJTWJvM1ZzVEtnMjVqQ2Jx?=
 =?utf-8?B?Zm42QzJtZ1hEMnZCdElHWWZzYkhYSlJtN29ibkpBTS9xbE1OQ01EeHRnQk42?=
 =?utf-8?B?eGJjYWZUeUd4NDZ0VUxaeFdRNnJRZFhNTm05eUtjSmpwcy9RZFNPVUhvb1JT?=
 =?utf-8?B?Y2p4SGswcGNMTnJ4T1FrM25MVDFwN1BaUjlKclRrdXFxRGxkR09BaG5PdnpG?=
 =?utf-8?B?VWpkTGhaMGhvdEZFYzhkZjF5QTdrQlZudnovV2h1OTRWM25iV25aT1FKRFBW?=
 =?utf-8?B?RFpTa2MvRW5yeTU2WlhwVzlVNXJmaG9sUjBKcU5Fc1kvMVRsMEVaN1RRRHBS?=
 =?utf-8?B?Q3owOGtuek5Nc0pQWG9VNHVYNnB5UDIxVTZ6NmN3a01VS0I5VXVpcVY4VzVR?=
 =?utf-8?B?UXpVRmxFTk1PbC96NkxkbmZlZmxFcU13dkhKVHhtRDJuYitxdXFkdzQ2R3VB?=
 =?utf-8?B?Vy9yVC91UThqRzRMUEJNczR2RHgxRnlqZ1VpNkFXQVpicDhqeWtiZUNTS0hq?=
 =?utf-8?B?TU16clZuNlN3NHBaaW40THBDYkJGbno5ZnR2ZUZjaXFVTThDMVVrOUQvZHhr?=
 =?utf-8?B?c2o1QXlSRENWZkpEY0VGUDZTalBYYnhmTFBucjVINlZuT2VGa2xmcEM1VEI5?=
 =?utf-8?B?MVdmY0RORW5va0cyei9tM0tCeTBUeHRmY3EydlUramhYc2dyMGdRM1c1RGlT?=
 =?utf-8?B?YTQvNUhqd1BYa2tlU2Y1Ym1kRjlhRVUrVGdjMFJ1Zm44bjVvT2dpc1ZwZmlW?=
 =?utf-8?B?SHh0K2pnZmEwemM3MXVZZDA4V3BvRkwyRFpxY083eVB6em5qVEN0bUFoVzFN?=
 =?utf-8?B?bVh3enIrSFZleUhUdmxESVlVNWRvM2dldTlsajlRTVAxRzZSWUc0VlY2QU5o?=
 =?utf-8?B?KzcrOHZXK1pHNGJSR05Kb1p6VTBCY3FYOXFFRFZZNjFBcFRHODgyZ2NjWWty?=
 =?utf-8?B?WHMvM2tTMHJzc1VGWC9QNHZBcHpJQ0RLTWxaTjRDeHd6MXZQdkI5eThZcWk0?=
 =?utf-8?B?dW9md1BDbXBzbjc5UU5nR2dnSkg2NHAwSFZyZTVqZFQ4K1pyUFE4ekh6UEVZ?=
 =?utf-8?B?aGhqbHpjUEdISTNwYWtYeUhwWUdUdUFnK1BtU3JvNmVIbDVDRkREUnJDNlVV?=
 =?utf-8?Q?Ur3wgcDh9aUn1anaZOOZUA3WP?=
X-OriginatorOrg: polito.it
X-MS-Exchange-CrossTenant-Network-Message-Id: 5eb67ea0-0c2c-42b8-661f-08dc023278ff
X-MS-Exchange-CrossTenant-AuthSource: AM0PR0502MB3603.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Dec 2023 14:38:18.3197
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 2a05ac92-2049-4a26-9b34-897763efc8e2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hj28AT07bJI7i6WZrSSEwPMaV2ACHxdjs7bwmH83TMz7cGRMGNT1oM2tMHNWNoG+uMah0ElrY9XVB9jxrGiQAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR05MB9615

Hi Mimi,

thank you for your feedback.

On 19/12/23 21:54, Mimi Zohar wrote:
> Hi Enrico,
> 
> On Thu, 2023-12-14 at 15:51 +0100, Enrico Bravi wrote:
>> The purpose of this patch is to add the possibility to configure the hash
>> algorithm to use when calculating the template-hash.
> 
> The patch description should be written in the imperative mood.  For an
> explanation, please refer to "Describe your changes" in
> Documentation/process/submitting-patches.rst.>
> For example:
> 
> The second field of the IMA measurement list, the template data hash,
> contains a fixed sized SHA1 digest.  Add support to replace the SHA1
> digest with other hash algorithms.  For backwards compatability, only
> the new larger digests will be prefixed with ...
> 
>> The ima_template_hash command line parameter has been introduced to enable
>> this configuration.
> 
> The term "ima_template_hash" could be misconstrued to refer to the hash
> algorithm used to calculate the file digest.  To differentiate between
> the hash algorithm used to calculate the file digest, the term
> 'ima_template_data_hash' is longer, but I think clearer.

Yes you're right, this name is ambiguous.

>> The entry will contain the hash_algo_name before the actual template-hash,
>> separated by a colon (:).
> 
> This chnage will break existing userspace applications, unless the SHA1
> digest isn't prefixed.

Yes, in the current patch, this value is present even in the case of SHA1. We
can modifying the patch by omitting it in the case of SHA1; as an alternative,
the addition of the hash algorithm information can be made configurable in the
ima log to maintain backward compatibility with existing applications.

Best regards,

Enrico

>> An example of the resulting ima log is the following:
>>
>> 10 sha256:64326[...]25313 ima-ng sha1:5fc9b[...]974e6 boot_aggregate
>> 10 sha256:afd64[...]e3123 ima-ng sha1:5a493[...]f9566 /init
>> 10 sha256:99329[...]a6353 ima-ng sha1:8c87d[...]3d8c7 /usr/bin/sh
>> 10 sha256:a16ad[...]2ac0e ima-ng sha1:59d4b[...]330b0 /etc/ld.so.cache
>>
>> This patch has been created starting from the master branch of the main tree:
>> <git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git>
> 
> With the base-commit included at the end of the cover letter, this
> comment is unnessary.  Please remove.
> 
> thanks,
> 
> Mimi
> 
>>
>> Signed-off-by: Silvia Sisinni <silvia.sisinni@polito.it>
>> Signed-off-by: Enrico Bravi <enrico.bravi@polito.it>

