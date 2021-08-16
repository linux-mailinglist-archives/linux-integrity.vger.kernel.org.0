Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02F773ED8C5
	for <lists+linux-integrity@lfdr.de>; Mon, 16 Aug 2021 16:16:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231175AbhHPORF (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 16 Aug 2021 10:17:05 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:49380 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230094AbhHPORE (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 16 Aug 2021 10:17:04 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17GE7uTh021784;
        Mon, 16 Aug 2021 14:16:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=Mmcl6jmTckqLsvTb91RGeqcPElpW65Jydr9nQF+a674=;
 b=IxnKmmJbc3+MSh7LPaUubyw7ZjAaBo3W6LyO+Sy9STYRT9D48fxnUFHpsTKX0QLkxAiP
 QDQNNqm0bWAYepHk5FcgJcPCiVPp12BR17Fs+fZp1mwDtknbmnWaxoRSFLPYdoKLFVQ5
 Ucghm8nErbBruWGdz9Y/61Q9PzBlKCYtGdKj3JIVLbgZpHu108EJVytf2qy9RD6si+MV
 TVbSk+6OKye2tpEUM91uzqDcP00w4TbtX67lOfTSSrXnL0recD+M9zzeAJFZdcIs0T65
 Yx8tLmgeLoxurZBcRwSTs1ZSlO742pn1axqX2TiQmx/B+/9MRG3sgS46gUDhxtIdN1+m Iw== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=Mmcl6jmTckqLsvTb91RGeqcPElpW65Jydr9nQF+a674=;
 b=UusfJ8xmrtUw9IfTPvZrG2me44WvNU1cDxKvH6VX/3cV+vq5Xw1Jtz8eKJKZqhmSo50u
 q3Wkd9pMu0JdZn/5evku4c/l6y3tLzLlFjuh2B8V9fK6rd7vFY/5H/QKaXtQmkh73hdC
 cuwQGB6mRS99X0hDBNt/LTGFkvTfvVVqwS2BOj+zgEFTL6eNgPogVlWKpMqBmWu5Hozy
 yT04eF9aUP/AOgX2isNyKtcMtY/SR6+hrB+PscnPNn/kujM1WiFHj0347vTZz9mlvbwV
 QD7xw8VvfyGDZdclBobwOsXKsBN8XRoETSisr7OExDBqNN5/qIIBQWNHln9gUIsU+kLS aw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3afgmb96da-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 16 Aug 2021 14:16:08 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17GEEkiZ135308;
        Mon, 16 Aug 2021 14:16:08 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2107.outbound.protection.outlook.com [104.47.70.107])
        by aserp3020.oracle.com with ESMTP id 3ae5n5ry20-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 16 Aug 2021 14:16:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iiJn2Enl6AXkV0IUglgAv4c8m37lLL5HhN4MakqPwOiBj6eVfQbzpsCCXWYzEHmyTDdU9yw6z1aZHDVVOH4UayFEkJsaGPC/ePUxcYi/idHqcYhrCTNMK94EdJv1sA4VBiXVehyL4xNYJlkXDv++kdxIhbkkVXt43BOO+k2OnGMDiqNdaM4Por2+oZv8BfSExAYjVI01mDjWHnwyH6cNOWzUHoO1Z3k2Ojkmqx5r/6PQQXh6wAF/P68XVEPlfIsHub1tM6nHJPmLPFRuBwioAo/X4Uv5KKRfAf2BSw9oD0oSbVnWg7Ki47FFreAd2N5GJ96SVtjMZwe2geK6NDZuNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mmcl6jmTckqLsvTb91RGeqcPElpW65Jydr9nQF+a674=;
 b=a0IQdtIky71V41iuv+QxUAVTfr9wah8YgSqTxoO4iv2yUGQ+O9HZFlem3nA6nV7p/0u0sP6nGNEsLVvl/WRYEnRUyTVtbq9iB9ouRSlngQAbc3ZkCupeypc9d2/BbSS3oyunBXaIENY9ddAbUUkBTopeFjwJR0aZ4IJ75vjDWEUiDgCQ6ovANdtZsIE1ULYrTDqowWjZko7e8VhWDGDuqzQ6/MrYlws9GgiLmewmvZSVKixPgsdOJL4gCjXj6XuV5quRROZb653dhW2wOd8VtZcLAFiv+Pr4yKV6NxbJsRZkot2TITzka5v/CK5Ro1I9sW8jkGvdZKIZSM03gaOwjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mmcl6jmTckqLsvTb91RGeqcPElpW65Jydr9nQF+a674=;
 b=k1DK/vtTZgMuTMC010en/bgHSkG66j22x+bCMOxTGUpVbLL8/Ih5eNNGNRVUwDrjDUZciF806mlSFGXvORGStLUr2dGC/AamJDdQzTJA+znlGrSGKGdnY5eR+O6JronzsWHD4oY048CtWAyasUHqycZciTE1MHgMoEZwxWlR1ug=
Authentication-Results: googlegroups.com; dkim=none (message not signed)
 header.d=none;googlegroups.com; dmarc=none action=none
 header.from=oracle.com;
Received: from BY5PR10MB3793.namprd10.prod.outlook.com (2603:10b6:a03:1f6::14)
 by BY5PR10MB4338.namprd10.prod.outlook.com (2603:10b6:a03:207::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.14; Mon, 16 Aug
 2021 14:16:05 +0000
Received: from BY5PR10MB3793.namprd10.prod.outlook.com
 ([fe80::e035:720f:86fd:bae3]) by BY5PR10MB3793.namprd10.prod.outlook.com
 ([fe80::e035:720f:86fd:bae3%4]) with mapi id 15.20.4415.023; Mon, 16 Aug 2021
 14:16:05 +0000
Subject: Re: [PATCH v3 02/14] x86/boot: Add missing handling of setup_indirect
 structures
To:     Jarkko Sakkinen <jarkko@kernel.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        iommu@lists.linux-foundation.org, linux-integrity@vger.kernel.org,
        linux-doc@vger.kernel.org, dpsmith@apertussolutions.com,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        luto@amacapital.net, kanth.ghatraju@oracle.com,
        trenchboot-devel@googlegroups.com
References: <1628527136-2478-1-git-send-email-ross.philipson@oracle.com>
 <1628527136-2478-3-git-send-email-ross.philipson@oracle.com>
 <20210810161932.wdwfu3wosjytdj4h@kernel.org>
From:   Ross Philipson <ross.philipson@oracle.com>
Message-ID: <87c42ae4-dfd7-c7e1-071c-7f32cf719954@oracle.com>
Date:   Mon, 16 Aug 2021 10:16:01 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <20210810161932.wdwfu3wosjytdj4h@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL0PR02CA0054.namprd02.prod.outlook.com
 (2603:10b6:207:3d::31) To BY5PR10MB3793.namprd10.prod.outlook.com
 (2603:10b6:a03:1f6::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2601:191:8500:cff0::40e4] (2601:191:8500:cff0::40e4) by BL0PR02CA0054.namprd02.prod.outlook.com (2603:10b6:207:3d::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.14 via Frontend Transport; Mon, 16 Aug 2021 14:16:03 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 279718e5-5c74-43ec-70e3-08d960c0629b
X-MS-TrafficTypeDiagnostic: BY5PR10MB4338:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BY5PR10MB4338C132172A3636E3595F7DE6FD9@BY5PR10MB4338.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1417;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: krVH2KuXecgUzRIF8FAmL+7UY/k/PoiQA+0lFhn+Yt6EniWKADTAHXSy7lRAilZXs5PEbkuWT/H9oJmkp8mT8qcL6PsVCldIU9KRZz0Lyu2pBPl0CYUZb2HfT3RSNL2NJh+P0SjqPSn2PJtxHdMSVECozEoqjNY+BQkh8fBu1jkBrnen9K4jXZdP+kZmFlRUL5ejvdSvggkT4UfU35m7ckl5Ur849BKaJQhIs72EX1QSyawyaehobB3EM0et7GKp9wl8JdzYqBihCaX9T4W663LKg2KdtL+ghfR/CdmTc7UAGuGtgTXmczE45oPGtCgtAv0DKHiH5B9TpyX97EiVZrypPOagtYkSY1dzbt1J6P/vDkqwbiZg+8unGRnsto7927SXiuOF568Y3wbj0+mSFyE/CS+hniimoIkFSR6XV1xLSp4LYQNyOrEq42hgtkWTvF+v6CvSHMA5xB4O1u7qH19iaxEkcdUJOAXyVlODKSmCVxAdvIBkKVgtYDHhrfl5SV/yj+7wQrArDZLi3Ywe1Usf7mErQFxX9YJtI9A5LF5WahKHdb24uYzZgyhYl3odPBGAbW1aCVehuFXxpKXyiuFcihv6QNoj4Bqi96sjYqwiNEXVg2fXNayBtnlKggWZEmFtJ3bkiFJFaipZttaCD4W5NY8cIAZSW6VOHNjmP6XEjIzhOHsIXcexloFuf9ZvVaSmYv/QlS7d1S+4a6SH6yvEjDLHYimV3sXSn6d/VE0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB3793.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(66556008)(2906002)(6916009)(8676002)(66476007)(186003)(4326008)(66946007)(8936002)(38100700002)(86362001)(6486002)(508600001)(36756003)(83380400001)(5660300002)(31696002)(53546011)(316002)(44832011)(2616005)(31686004)(7416002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a2pCMmJhbEg0UnBaYW0rU2Z0ODRGSlVhT1R2K2wyTDdnT0Z0SWtQR3pBdVVC?=
 =?utf-8?B?TXZ0RHhTZUQwLzRIM09RUlNOc2VlSXRHbklZZUlZd2FWZE5qSjVGRUM4UElK?=
 =?utf-8?B?bWFza2NQNmRTNkwxdTA5VzNPeVFvSGZQOU16QmN5WUprVjBoU1I3NEVqRlZM?=
 =?utf-8?B?UHg4Q0VZcE9uSjdrMmcvKzdYM1BXVlo3UEZvRnpCN1hYTmFOQ21PcERlTTA2?=
 =?utf-8?B?SDFTcXFOM3U1L1NiL083TGMzWC83aVZVUDBRbVBqM2NDazQ2dDJ6TytvVXRO?=
 =?utf-8?B?c3ppMFlZRjFCVzRuaFFuN2NIalNHRGdzMk56MGVUbW85QVFCR0FqeGVBamV5?=
 =?utf-8?B?RkpJLzlKSlZZWTJWZ1lvQzhrelhvYmVBRTQrUFNMTjNuSDNwYTNxZmN5eitn?=
 =?utf-8?B?dGJHMnVOZ0xsdkp6bDdsdXZVNE9lN2w4Z2FkQnAvdzVzcW1wdDZoL0hFREhr?=
 =?utf-8?B?WkU3QjVhUmdYUmNyU21BQ1FQc2ptUnJhbDZNU0treTBMMExxbGcwY3FDUm56?=
 =?utf-8?B?MFNhMlNJUm5YbXUrS2luS3ZIRFhzbll4ZHpKM0x5TmxTM0I4OUVlWG9nRHJ0?=
 =?utf-8?B?VUJUY0JkbmdIVUFiNmZXajBQUTh3cURLaVZMR2VqbFNQWGVqRmFMNSs3L2Jh?=
 =?utf-8?B?YkN2VlN2MHJvUUFOcDFMR0xtNVgrVUVBN1R3ZlVPVGJzaUZweThhaVE4SEJT?=
 =?utf-8?B?SjdNZG5KdGg3R3NUYU5XQ21zMUNmSllvR2Fvd083a0ZSTHhVUUZRTm40cWg1?=
 =?utf-8?B?a1JpTlgyelNVOGFNblM0bFlKRkFsS1V4d3pKbEdqQVBwdXNrV1ZsaEgwTDcv?=
 =?utf-8?B?U0xlR1FUTHAzRUZUSklta2VJWTVkalg0RCt2dzZwNHdMUHJGQ3FDbWlkbmpa?=
 =?utf-8?B?NVRwNDlGSkhCL1JGME5ocWR3SkoyMzhhRHVYSGRJNHZ2dWNDZTh0eUNWOGpH?=
 =?utf-8?B?OHNmZWpKeFlYYVBYdzZlb20vT0JCMllVNnFYbXdFbnFRbHZIK3FOdUM5Y0s0?=
 =?utf-8?B?NEF6NHJlekpURmMvNW5YNTNVQXcwdnBJZ1pacFdqS3kvai9JQ3dsNFlJNDMw?=
 =?utf-8?B?aEZZOVlOb1ZGUWdFZ3hwU3Q3cHE5UDRsYS9ablpUOWZLVlo2L0VwQkJGbDQ0?=
 =?utf-8?B?aFkzemZJNzQ1aHgrVi8yay9ycVNEMzRhLzNpd0hYWDVXUkhRZytEQXBUcktF?=
 =?utf-8?B?MzZYV1pXY3ZyOGR5U1pGSWorRWJKbDB0N2d4bU5JMnIxeHBkc1lBekhUbHNM?=
 =?utf-8?B?NmlUdVhqbHpmWmh1SEMwQkc2Smxhc3F6UFJ6VXRoaEExWkxBNTE4Wmd1am05?=
 =?utf-8?B?c2RDNWRjM0FrVHoyVnRUVVpKNzBqUW9IUVJFU3VqRVdoUk9Pb0NwS2djeW9M?=
 =?utf-8?B?SlF3L0lQcjFoblJ3Zkx2bzJWR1Nra3N5UG5TN0V4Rk80NlV3QWZEZFlCelNM?=
 =?utf-8?B?OXVIZkJjNHRTTVNLSExFM0QvSG44OFFrRzhKK1MraG8yWDZ3WCszN0dxOVVR?=
 =?utf-8?B?V3R5OW5pMWZ4L2tvUXdsUVN2Z0Q4Wm80eEtHUVlsRDQ4NWdpcENmcy9OWm1y?=
 =?utf-8?B?OHBNL0pueG1odnBzQ0hRNVNkdWtld2Y0eVMxRFJ4V3hYVUl4YnU2LzhuMEVQ?=
 =?utf-8?B?WVRnWGRoT2RGQ2RPSDVtNlZJMFRPMkNZUkRZd0M2YXZBc2Z3ZmZLcHFzWVRl?=
 =?utf-8?B?dzloV2pGSzQ4Y21UU0lGT1prVVFGOExadDdQakFreVpiQlZNNzFFeVJYa21C?=
 =?utf-8?B?MDBvWXVmN3pSYnFWT01RdVphY3dWT3Uya0R1K2g4bUVVdE0zSHVnM2xDeDJh?=
 =?utf-8?B?MU1naEkrRk83THBrOU4xZz09?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 279718e5-5c74-43ec-70e3-08d960c0629b
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB3793.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2021 14:16:05.7765
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Gy31QnRHWO/VXd1e/d9yD0wgw9UMEMjcJcWkSS2Hh9sbsLFGU6RwtTsLhTymArxoj++EOnX9/0/JrpGHbyFop8TaeEIl5W2ROPzoVONuChc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4338
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10077 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0 bulkscore=0
 suspectscore=0 mlxlogscore=999 phishscore=0 mlxscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108160091
X-Proofpoint-ORIG-GUID: ebKm7AKE13dfh5D6yeChAUiauK23idQ9
X-Proofpoint-GUID: ebKm7AKE13dfh5D6yeChAUiauK23idQ9
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 8/10/21 12:19 PM, Jarkko Sakkinen wrote:
> On Mon, Aug 09, 2021 at 12:38:44PM -0400, Ross Philipson wrote:
>> One of the two functions in ioremap.c that handles setup_data was
>> missing the correct handling of setup_indirect structures.
> 
> What is "correct handling", and how was it broken?
> 
> What is 'setup_indirect'?
> 
>> Functionality missing from original commit:
> 
> Remove this sentence.
> 
>> commit b3c72fc9a78e (x86/boot: Introduce setup_indirect)
> 
> Should be.
> 
> Fixes: b3c72fc9a78e ("x86/boot: Introduce setup_indirect")

I will fix these things and make the commit message clearer.

Thanks,
Ross

> 
>   
>> Signed-off-by: Ross Philipson <ross.philipson@oracle.com>
>> ---
>>   arch/x86/mm/ioremap.c | 21 +++++++++++++++++++--
>>   1 file changed, 19 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/x86/mm/ioremap.c b/arch/x86/mm/ioremap.c
>> index ab74e4f..f2b34c5 100644
>> --- a/arch/x86/mm/ioremap.c
>> +++ b/arch/x86/mm/ioremap.c
>> @@ -669,17 +669,34 @@ static bool __init early_memremap_is_setup_data(resource_size_t phys_addr,
>>   
>>   	paddr = boot_params.hdr.setup_data;
>>   	while (paddr) {
>> -		unsigned int len;
>> +		unsigned int len, size;
>>   
>>   		if (phys_addr == paddr)
>>   			return true;
>>   
>>   		data = early_memremap_decrypted(paddr, sizeof(*data));
>> +		size = sizeof(*data);
>>   
>>   		paddr_next = data->next;
>>   		len = data->len;
>>   
>> -		early_memunmap(data, sizeof(*data));
>> +		if ((phys_addr > paddr) && (phys_addr < (paddr + len))) {
>> +			early_memunmap(data, sizeof(*data));
>> +			return true;
>> +		}
>> +
>> +		if (data->type == SETUP_INDIRECT) {
>> +			size += len;
>> +			early_memunmap(data, sizeof(*data));
>> +			data = early_memremap_decrypted(paddr, size);
>> +
>> +			if (((struct setup_indirect *)data->data)->type != SETUP_INDIRECT) {
>> +				paddr = ((struct setup_indirect *)data->data)->addr;
>> +				len = ((struct setup_indirect *)data->data)->len;
>> +			}
>> +		}
>> +
>> +		early_memunmap(data, size);
>>   
>>   		if ((phys_addr > paddr) && (phys_addr < (paddr + len)))
>>   			return true;
>> -- 
>> 1.8.3.1
>>
>>
> 
> /Jarkko
> 

