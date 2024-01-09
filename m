Return-Path: <linux-integrity+bounces-711-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B04A3828AAB
	for <lists+linux-integrity@lfdr.de>; Tue,  9 Jan 2024 18:05:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 262CF1F24AE2
	for <lists+linux-integrity@lfdr.de>; Tue,  9 Jan 2024 17:05:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E20AF33CF4;
	Tue,  9 Jan 2024 17:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=politoit.onmicrosoft.com header.i=@politoit.onmicrosoft.com header.b="DnE9gt8V"
X-Original-To: linux-integrity@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2102.outbound.protection.outlook.com [40.107.20.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C04213A1C2
	for <linux-integrity@vger.kernel.org>; Tue,  9 Jan 2024 17:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=polito.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=polito.it
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ev7oLZhVSxUXAISLrKTDtl1yzu9erpceBHBnqVvH+3rnWoMvJJAR8sPn36GJCSol6HzA10vRzRoCFSJUd7ch1WWIHrv7tQ3mAOlKizRbJ8tyiHS0W9nUh5yV0+nBKw9XgUo5iFU2fPsNDe0zGwOin/wdfi7AUOoyMe3gw+gIcvGzjNMCbgYb0K7IJDUUOHP5TrxQNIXxIt7Usd9QVm/BmamPK8xcNh4tDJrx+9ONVGL72rv0uYK/GcM8AtEKv5bg8G5H8CaL2pdoxOTj776X27wrYJd3hVSG9dua056AUU7B+XSxwwEuMkqQY8NBHAx/ZR7eeE8bVnDGoJ9Xp54Rww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HvMe4NhL2Et1P6XTX2LzMlSBS46T7Q7dS450K3EwaG0=;
 b=Zjdv+JlUKKylT/ytit7OS2vsEr1vNHrhfMGNBWqWNUy9Px+6q3kyaViHuPObYF5cIR/3OnRY5e/FeOQ6IECAJIyZekioNtK96zhhHE8EEcVuYCwbb/gGBXxoolP3AQwqPApcIBwvQiI/LOmdjnCj3K3Freid9C3fO8W2BRpd380D2gQlTXX6bqauqhU4mbJ4m0P2ukp0EG/gcpERfjroKuzGnxWhENLl/i0SNyJuTTV13P6ngd4W3X4vthCWKv5SFa2y40K/wFJeC7o6KGKMitXA/So6GpKZWdbVpFqNvYhU4P46VPsfUhFQ6rlTVjZQFUeF+f6eTj6ZwcEX9Xi63w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=polito.it; dmarc=pass action=none header.from=polito.it;
 dkim=pass header.d=polito.it; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=politoit.onmicrosoft.com; s=selector2-politoit-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HvMe4NhL2Et1P6XTX2LzMlSBS46T7Q7dS450K3EwaG0=;
 b=DnE9gt8Vb/htXnSSBDClvbM4nxVCI0SKv3yrgbqhsIgpSG8YDsOWiL1Bm2Nceu1Y/w/q3ZMrAMHPStU9htL/wkTQz2rrcMNQSjhbLiP03Vjmru+lev9ssCilZ6gtDLv/MAWGJ2Y0/Dxl9HGEwl/wLWX7zHGmd+3K9uW7YOrb7LU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=polito.it;
Received: from AM6PR0502MB3896.eurprd05.prod.outlook.com (2603:10a6:209:2::18)
 by DU0PR05MB10058.eurprd05.prod.outlook.com (2603:10a6:10:467::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.21; Tue, 9 Jan
 2024 17:05:30 +0000
Received: from AM6PR0502MB3896.eurprd05.prod.outlook.com
 ([fe80::dc79:fd70:525:92fa]) by AM6PR0502MB3896.eurprd05.prod.outlook.com
 ([fe80::dc79:fd70:525:92fa%5]) with mapi id 15.20.7159.020; Tue, 9 Jan 2024
 17:05:30 +0000
Message-ID: <7ffd4706-5629-4309-8dd0-790fdc05c7c1@polito.it>
Date: Tue, 9 Jan 2024 18:05:30 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC][PATCH] ima: add crypto agility support for template-hash
 algorithm
Content-Language: it
To: Mimi Zohar <zohar@linux.ibm.com>, Enrico Bravi <enrico.bravi@polito.it>,
 linux-integrity@vger.kernel.org, roberto.sassu@huawei.com
References: <20231214145152.36985-1-enrico.bravi@polito.it>
 <8bf7eaf170cf609fb4280475d3340179283fd196.camel@linux.ibm.com>
 <a27cd216-ab70-46a1-8c2c-4640728c99b2@polito.it>
 <89cea05a61ac4616774446683bf612165ba2f43c.camel@linux.ibm.com>
From: Silvia Sisinni <silvia.sisinni@polito.it>
In-Reply-To: <89cea05a61ac4616774446683bf612165ba2f43c.camel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ZR2P278CA0072.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:52::9) To AM6PR0502MB3896.eurprd05.prod.outlook.com
 (2603:10a6:209:2::18)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR0502MB3896:EE_|DU0PR05MB10058:EE_
X-MS-Office365-Filtering-Correlation-Id: f2fe657e-e0f4-40c8-7a51-08dc11352f51
X-politoEOL-CGPAlias: 1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	f3SKnbU8upM0pAJaAKHEW6puymmHh878f3bbh6MYZxv5zr/VOFxbr04TkY6BgTD451C/vJcJQhECCxE+AOhKUgDShX8mhls27cIyCYup1hLRpF2d2FuG/BwSHMKFaZFzHJMC7KnhrO62EoJHmGPx0jnCtfJAVRLasYq6vrneNnN8BAQcUZw2XeeKb6ajAG7rDKkLmUnYYUcxE+/1YtkNxQcwSM/1oKoPCIEFUCy33GROACkRwZTluchbNb6DIZi3mPg3RA9NLBydYDH3bNZ18djGtoBnMA0pIhl7qd4ODbCbVGo9YKFYL6YleQw15GR/qT11aumf9inAxUs0nlriuXUO20R0xATInaW4JL+X0nWueW5UuF1W0bv5H1tx9lGxy+BGrnFjJ0pcRqVNj+uP0xPdhxLdQqeupRNAkdeimAvdPp2PE782Zmwwgtg0IGdS2TNLCqfLHC6/reqGZtKIdz9X+b0cwIb/fJq+/j552jh61Y7CUfLddcxPo7tk5BenyOzEKhF4vNp5AhdSGCJuXxUkv4NEj1HL4kRnXlgsloM9/nD8V1Z2M4dS1hAZombRBFrLnExXnXoxGzgSw/glLWRsUBj4qRtlSvqUBcRnw0ws6CV8Z9xvcx2BWiT9oDQO5GCdqtQFMg+niSwwGLvFNA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR0502MB3896.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(366004)(396003)(39860400002)(346002)(230922051799003)(451199024)(64100799003)(186009)(1800799012)(6506007)(478600001)(786003)(110136005)(66556008)(66476007)(6486002)(66946007)(8936002)(316002)(8676002)(2616005)(53546011)(6512007)(83380400001)(26005)(44832011)(2906002)(4001150100001)(5660300002)(41300700001)(36756003)(38100700002)(86362001)(31696002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bzhBM3FnZmlZbVVtdDZnRG0xRCs5OXM0bUVpS3A2SWM1ZGthUkxNNDViUml5?=
 =?utf-8?B?aHhNN0VVQU1iemQ4YUxMNEx1YUI0TmFLNmVPUjd1Mm8zY0h1aVlnU0syd3J6?=
 =?utf-8?B?VTFSc3BEYmo1cnMxcDhOUHVUVVdyYnZFaU9kVVVmNng4WnZHRWw4dmU3UWxs?=
 =?utf-8?B?WmdTeEs0SVhCQTNuNkxkMzVYMEpaRlkvcHhCeE16dmdhTkRabXpZTERSQWNG?=
 =?utf-8?B?K0pkajRoTVhSYVBEaWZjYkFWb1VKekpLaE5jb1hieFMzSzNsTEg2Mm04d0ht?=
 =?utf-8?B?NUtsRmVYYmJCWHN3RFJkZkJBNzU5cnA2WE9PY3BoYTBrcmFUQ0JqSkcxQ1pq?=
 =?utf-8?B?UXNndjhPV3NEY25QaUVoMFVHN3I5T0loVlVnbnRPL21BZFNOVUhGSHk2NVZN?=
 =?utf-8?B?T3AxNEdGaWlmUXVwT3c5ZEMzOHU4Ri9xOFE4dkNjZlNxSUlvYTJTR0hQUmpK?=
 =?utf-8?B?eVZlMnpLamVTR2JYbkI1SEpLdkVVbWtUdkY5YnVoeDVuOGUxUnk2eVpXOGti?=
 =?utf-8?B?ODlxT1krOG42RERYTStwelJHM0U0cnFISmVZV1pkZVRxU1UrUTFDa0Q3WmJy?=
 =?utf-8?B?T1ZTNGk2Rm92VVNGU1ZVKy9hSnJ6Q1U0cmZFTFpuS0dTd2M2Tndidy9BVVpI?=
 =?utf-8?B?UTBLZGQ1dWpObFFNQW5UaDFOVVpSeXBvMyt2MkhLNlNuYjBJNGNVK3lJRi9P?=
 =?utf-8?B?MGE4RmR6ZkNKalZFbk1SZ0VxYXIrekd6NzlyRUxjaW04Zmh1UkMxVnBTMFFs?=
 =?utf-8?B?SGpsbGxPSzBpTWNCMVZ3em5pK2ZWa3BBNkRNaERGSDN1UlR2Wi9Wc2NObnRI?=
 =?utf-8?B?ckU2VUNBOHNBZGJOWHdkVGhHTGczWGtCcnArM01iSXJVcHhqSnVHN1NhMkp2?=
 =?utf-8?B?aWhoenNPbStSRVRITy83eFlXSzBIL2dMdVZHSmZ2M2xtVWZmdEk3c25vQXhj?=
 =?utf-8?B?ZzVnSEFNL1d0bW5YRlhwRVRXVWZqd3JEK0lqVkRvTTcyV1JpQzJhM0d1L3Jo?=
 =?utf-8?B?b2RuTHZOUENOY3IvK3laODNLVExxUWVJZkQ1QXl4ZTRUV2pudjBJaU54eEtR?=
 =?utf-8?B?NGJoZ001MDJoQStzbXJiN1ExeFo2ait0LzZ0QUZqeXNDN2FkcWs2SmFFN0pW?=
 =?utf-8?B?ekNGbU5JajFPZjJxVjc4cFdtL1BMODc4bkR5U1ZRdm1CbldxT2haZGNQVjg2?=
 =?utf-8?B?YXFITEk5ZDRncmJ6bXAvUDVDYWFVTXN4YWtkdEFESExnemI5b29HNU9JeDZ2?=
 =?utf-8?B?UGJwempiNldDanluVVJialBCZzF1MEM1NnR2dDdqMm1RUDFoY2ZoN2VxQ2tv?=
 =?utf-8?B?ZDNOeDNyQjVnVlJjb3JmeXVMdi9QQ2lRZUVsbUthQkR2R1RlWlpTbThka0N6?=
 =?utf-8?B?cVJEdWhjUjZmcFlOVlI3OVBlU1FoclFiNkF5c0FwV1FmeUJzTnI2NWdnTDhh?=
 =?utf-8?B?K2IrRUs5ZEc2dW9ZZzZldW5hVmdvWU40NEx4U1RwZndxWEdCL1RjSFVOTkJ3?=
 =?utf-8?B?MDBEbFgxZzdYWkIybzE3TVBNTVNBdHBlbW9LcFNlY1orUklycmtSSHR5bnNU?=
 =?utf-8?B?TUFMb2JkM1g3TitEdFM4V01kQWdpR2p0OGlzektEWEZwUks4eVRmOFRueFdS?=
 =?utf-8?B?Z2FtaTdUa3k2aGRFclNSeXE0YmlRZ0NxZ0VhK0NhMVNZdHFiOXIzUmZjQSts?=
 =?utf-8?B?aUdhVHNjdlRjTjVzMUpjWTJMMnIrd1hyZWFISmhyUmFiTTdxenBGcWlxY1k4?=
 =?utf-8?B?blBmOTBMVm1SQS9OWnFZb2hOTER5OXJNNm9ySXRkUHo2RTBaNXVUejZnMlZi?=
 =?utf-8?B?VmVUQm5IUlBFejU3WjVWV1NhbUcyN1JUWmpQejJ3WEVHWFcvMy9lQVQrUDFT?=
 =?utf-8?B?d3NRbndYWVRsSXFhYm5YL1BVNjYwb3hKSHFhYXpJR3p4b0FTSUIyeVhKaTZi?=
 =?utf-8?B?ZnlxL2cwRTlHQ1NPamp0cUtzellIb3k2bEZNVTdrQ2FxdlZyaEZQbEZMTlVj?=
 =?utf-8?B?ajVEd0MyQ055M00vOXUwWU5GTHptU3FNK2g0QVpZUzFaNEt3UmZBbkl0a3RW?=
 =?utf-8?B?dldOeXY3ekViVkJQNjhPbUtkcXJlNjRYdlI5T2wrZFluQlNRdXlLbTBqOVp6?=
 =?utf-8?B?ZnZ6eTh4ek1kMGIyenRFTFh3OFFldWw0Y2p3VWVtaG9rZmpsVDEwWGR0UTlU?=
 =?utf-8?B?anc9PQ==?=
X-OriginatorOrg: polito.it
X-MS-Exchange-CrossTenant-Network-Message-Id: f2fe657e-e0f4-40c8-7a51-08dc11352f51
X-MS-Exchange-CrossTenant-AuthSource: AM6PR0502MB3896.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2024 17:05:30.5816
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 2a05ac92-2049-4a26-9b34-897763efc8e2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lzyuIl+ZCON5k2bWHfJIlNV4PXsZaWMB/5jzC+XzD9u2SvTUvCz6nvmeWANLEM6xBWHWnbG9tQabde+a9aoIj+zjvOvfSf1/GMG+4y+wWLk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR05MB10058

Il 12/21/2023 11:05 PM, Mimi Zohar ha scritto:
> On Thu, 2023-12-21 at 15:38 +0100, Enrico Bravi wrote:
>> Hi Mimi,
>>
>> thank you for your feedback.
>>
>> On 19/12/23 21:54, Mimi Zohar wrote:
>>> Hi Enrico,
>>>
>>> On Thu, 2023-12-14 at 15:51 +0100, Enrico Bravi wrote:
>>>> The purpose of this patch is to add the possibility to configure the hash
>>>> algorithm to use when calculating the template-hash.
>>>
>>> The patch description should be written in the imperative mood.  For an
>>> explanation, please refer to "Describe your changes" in
>>> Documentation/process/submitting-patches.rst.>
>>> For example:
>>>
>>> The second field of the IMA measurement list, the template data hash,
>>> contains a fixed sized SHA1 digest.  Add support to replace the SHA1
>>> digest with other hash algorithms.  For backwards compatability, only
>>> the new larger digests will be prefixed with ...
>>>
>>>> The ima_template_hash command line parameter has been introduced to enable
>>>> this configuration.
>>>
>>> The term "ima_template_hash" could be misconstrued to refer to the hash
>>> algorithm used to calculate the file digest.  To differentiate between
>>> the hash algorithm used to calculate the file digest, the term
>>> 'ima_template_data_hash' is longer, but I think clearer.
>>
>> Yes you're right, this name is ambiguous.
>>
>>>> The entry will contain the hash_algo_name before the actual template-hash,
>>>> separated by a colon (:).
>>>
>>> This chnage will break existing userspace applications, unless the SHA1
>>> digest isn't prefixed.
>>
>> Yes, in the current patch, this value is present even in the case of SHA1. We
>> can modifying the patch by omitting it in the case of SHA1; as an alternative,
>> the addition of the hash algorithm information can be made configurable in the
>> ima log to maintain backward compatibility with existing applications.
> 
> After thinking about this some more, I realized that we didn't discuss
> carrying the measurement list across kexec.   How will the kexec'ed
> kernel be able to differentiate between the original and new
> measurement list?   Neither the Kconfig nor making SHA1 backwards
> compatible address this.   How will attestation servers be able to
> differentiate between the two logs?
> 
> Obviously the new measurement list with larger digests won't be
> backwards compatible. Can we support carrying the original measurement
> list across kexec to a new kernel?
> 
> As long we're making changes to the IMA measurement list, we should
> mention that we could include multiple digests, but I don't think it is
> necessary.
> 
>>>> An example of the resulting ima log is the following:
>>>>
>>>> 10 sha256:64326[...]25313 ima-ng sha1:5fc9b[...]974e6 boot_aggregate
>>>> 10 sha256:afd64[...]e3123 ima-ng sha1:5a493[...]f9566 /init
>>>> 10 sha256:99329[...]a6353 ima-ng sha1:8c87d[...]3d8c7 /usr/bin/sh
>>>> 10 sha256:a16ad[...]2ac0e ima-ng sha1:59d4b[...]330b0 /etc/ld.so.cache
> 
> The template DATA_FMT_DIGEST_WITH_ALGO field is a composite field
> defined as <hash algo> + ':' + '\0' + digest.   The above ascii display
> looks like the template composite field, but isn't.  It is two separate
> fields.  Perhaps it should look differently as well.   Consider instead
> of a string use the hash_algo value (include/uapi/linux/hash_info.h).
> 
> binary measurement log:  <pcr> <hash_algo> <digest_len> <digest>
> 

Hi Mimi,

sorry for the delay, thank you for your comments.
What you are highlighting about the difference with the 
DATA_FMT_DIGEST_WITH_ALGO field is correct. To avoid this problem we 
could add the normalization of the measurement list, dumping it with 
SHA1 without prefix. This would resolve the problem because the 
restoring of the measurement list implies the re-computing of all the 
digests corresponding to all the hash algorithms configured for PCR 
banks in the TPM. So, by adding this modification, kexec could execute 
both a kernel compatible with this feature and a kernel that is not.

BR,

Silvia


