Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A5693ED8CE
	for <lists+linux-integrity@lfdr.de>; Mon, 16 Aug 2021 16:18:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230177AbhHPOTC (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 16 Aug 2021 10:19:02 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:3560 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229902AbhHPOTB (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 16 Aug 2021 10:19:01 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17GEI6Ep020807;
        Mon, 16 Aug 2021 14:18:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=MIdAye8xo6aQMjED8robJOssu9sZZJF3UpOwStP+CHU=;
 b=WPC5ytFrzSLySjnMwZmU1S/qXw8o7ELBvq/KEvPxBkahTtxmCqMJwhu3xsUD+9XltQHN
 ISsNH7mnTcMxO0rxi+vghDFBMXwMIUzzC4LOF7D4PFSfKkqV4fiD5hdmUtj9cVs4nmMu
 NSvl5ndVdCWELnSjB1tICvx8GIlZoEvZxvxOwA+JVGVFkJu177eSSpSlpJZnb6A9ugBh
 ILU826NGJiYW5VI8mRZx8RPgHf5XSkgZkXutVezvCo2wQa7Egy326Y6vL3vUM1VArBeB
 c8l2t6vbbA3IPQOkgOXZxMGgiTGT8kU61oUpgj1nSxzAKmhAOg3qDeiHJU5f1laTkO44 nw== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=MIdAye8xo6aQMjED8robJOssu9sZZJF3UpOwStP+CHU=;
 b=w1TIs9/bv4lz86rLqMQ8VGieJqs64syciYaIHOsdhhl6U5XIkW1g/qOD5EHVIPfCgxa6
 r12U1hM1kgmnvnhfEE5dm9LxzCwyHna1z3jdndVsjgMrqkudocWox469p8K2zieAvxrF
 bdsluLDvC5xqOYkr3FOHWXAJ7SacDdI/m1VWZww86lshXAoOqqRLKDghliP5erO54HVX
 vxz7VQrMacRwKmm2iAvQA7QqePlF8qyUDgAajgghKWWQnprJ/9mcCMWVGSDP+z7RqEdw
 TfaRQGp7V4yyssa/msNNEA4yn560Kn0PHS+ySXRyykdTbRYyRk9GQ+Gb208h1tiATG1W pA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3af1q9a9xa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 16 Aug 2021 14:18:17 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17GEEla7135381;
        Mon, 16 Aug 2021 14:18:15 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2176.outbound.protection.outlook.com [104.47.55.176])
        by aserp3020.oracle.com with ESMTP id 3ae5n5s2yw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 16 Aug 2021 14:18:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NMIQJvU6CoUMucdoBWmbP3B4amEeIivsqhRn7wFNndrxsBHSlff3H10Stg09MDyOmhroikE7jPmhInsoVtVSZGiA3EFgWL5Dl1Z5oh5kjsLOn/LlWatjVOdZvUXlIVNuCpnKDdVMQL/wmMO8KZ5HH5cX6ZxblBZjLkc+JeLHwAX+Q9DFAXFAvJkx5PZHxWUD6fOnPi0ixQTRQWFTiarMdST7+aHqh2uVBOITi2aoaVUB1dX04/b4r9UUs47TMhELPV0ofIWgtPFzYR0KluZcLGPuv6bm92k/rktuuLrjgM+avq2H/SshwkMsC/yHlItHpPPLUX4ZuLrb+DtylgpjCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MIdAye8xo6aQMjED8robJOssu9sZZJF3UpOwStP+CHU=;
 b=hsad7qRruFD5AQpyBpCh1aJChVpfcD9YAocknepxIt+AbEoBbAzHA3h53fMF3atJhPp7af5tLOLA7ELew7t3LXIyIwwz1mywuPhS3iN6jK6oft8ExOMFBP7bhwZpOfJxzVFPrmrc8HyE2/5WNbcAeOhND1UJdTycLvo4geFww02wSjZU+xaz+Td+y1PBkZtUf5udfzyVRIzDg59IPqrNba0ThCrhFg7eyjUXQ4n8OaAIRDtAAwjFypeF6+JYDgAoDy02Ub44QfzSBi2QgehZ4hg3R4uVg2bKlW3z5OcqguwrlvqW36Da9nP8EV3/ab/7K74cZQaThw+zVZbxrl4l8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MIdAye8xo6aQMjED8robJOssu9sZZJF3UpOwStP+CHU=;
 b=JdbEID+ukQApmLcG7uZooPgpgicv3Gvw2dPeVipLBslCqubJbiyogp1b/LnDtc9f0N2OXmC933Z38p+PyyNaVetoRLZPMowrEg8UYRsYYPGQjvPpL1AfXo5SvS6be+0W63+tv/NlK+fZ0OJ2VLSHtEqHwpoA8/wP3uiMNsLiJgM=
Authentication-Results: googlegroups.com; dkim=none (message not signed)
 header.d=none;googlegroups.com; dmarc=none action=none
 header.from=oracle.com;
Received: from BY5PR10MB3793.namprd10.prod.outlook.com (2603:10b6:a03:1f6::14)
 by SJ0PR10MB4589.namprd10.prod.outlook.com (2603:10b6:a03:2d0::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.14; Mon, 16 Aug
 2021 14:18:13 +0000
Received: from BY5PR10MB3793.namprd10.prod.outlook.com
 ([fe80::e035:720f:86fd:bae3]) by BY5PR10MB3793.namprd10.prod.outlook.com
 ([fe80::e035:720f:86fd:bae3%4]) with mapi id 15.20.4415.023; Mon, 16 Aug 2021
 14:18:13 +0000
Subject: Re: [PATCH v3 14/14] tpm: Allow locality 2 to be set when
 initializing the TPM for Secure Launch
To:     Jarkko Sakkinen <jarkko@kernel.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        iommu@lists.linux-foundation.org, linux-integrity@vger.kernel.org,
        linux-doc@vger.kernel.org, dpsmith@apertussolutions.com,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        luto@amacapital.net, kanth.ghatraju@oracle.com,
        trenchboot-devel@googlegroups.com
References: <1628527136-2478-1-git-send-email-ross.philipson@oracle.com>
 <1628527136-2478-15-git-send-email-ross.philipson@oracle.com>
 <20210810162119.htk366pmacrnzdmh@kernel.org>
From:   Ross Philipson <ross.philipson@oracle.com>
Message-ID: <86751be8-8f18-41b4-763d-ac981f53f7ed@oracle.com>
Date:   Mon, 16 Aug 2021 10:18:10 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <20210810162119.htk366pmacrnzdmh@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR18CA0024.namprd18.prod.outlook.com
 (2603:10b6:208:23c::29) To BY5PR10MB3793.namprd10.prod.outlook.com
 (2603:10b6:a03:1f6::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2601:191:8500:cff0::40e4] (2601:191:8500:cff0::40e4) by MN2PR18CA0024.namprd18.prod.outlook.com (2603:10b6:208:23c::29) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.13 via Frontend Transport; Mon, 16 Aug 2021 14:18:11 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 28ecb8db-bdca-4aa3-cf52-08d960c0aed7
X-MS-TrafficTypeDiagnostic: SJ0PR10MB4589:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SJ0PR10MB458964A26ADF6CC98DBC1883E6FD9@SJ0PR10MB4589.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lQB2PQvvpMhFxauVS+lwQ3PDCpERB+Ds4++44gvRnOVxoXhbAiBM5SIU5p0P6+NRTkx9iNiDpFwf+YGMR4zOnaQvb3k8ksh0FpWEgL1eTXp3ijMHxacWrk0eGIziB1nFfRA0y6RwCkdSngEFo/IqQ4Hm3yJUv9yj8I+3Xa0bYgaQHm817R30HgOAb0Gq+Lwkgj1kWregvSg3HevkJJO+oDdGh9xRBlSAq0ezE+wdmNyTgj2jonqEV80j1CH55Z6J7tRkRG2bv7gNKGgc7tYM30Y4KcxiauxrAvwhTmfAYLhvzqZycxxFOA8VqB9YjMJk08cSQGIsGv2znYTbwM6cGKgNE3Q4xjSAY7gxG1FBI6k1bw+t3wtAzJ8rmCQPq8Sf1+jFxqOLLmI93ZOOxfR8amjDb2kZiFI49GSilUu+FhQNUTwopsgd0nZk0Uok7prFDijfbXOlyl+6WmAao7Qg8VB2gQRUPpYHYkcy+7QPsiC0Uc2xHU36hTlb556MuSh5y4kGC6r8w/mNVXantdv09x9Z7R/j2f+b8alOd1iqcQjBN1qduZmDEbnVDuX2NAo3T9BGO8M0Nts3cMaz6dr5gVVTyTud+dvWmYs8G2artcxDnxqQ4paTytkIoowG3Bb5VgPuJuXl77NlQpwZSXUhFI10Q2ZFFwGSWbSXfCSHg1+bZf8+MCKjC+Rz+8QNDubypoBuq86j/6NO2dagzhEIzbS7XMqXjYV3Q9sy5NjjJBQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB3793.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(39860400002)(136003)(346002)(366004)(376002)(8676002)(8936002)(66476007)(478600001)(53546011)(31686004)(6486002)(86362001)(66556008)(83380400001)(31696002)(2906002)(4326008)(66946007)(2616005)(5660300002)(316002)(44832011)(6916009)(186003)(36756003)(7416002)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TnRxTDl6SnlRb1c4TFZHNllBdjJ0UTJYcGZLakVzYlhpVnRGZ1Z2K2puZ2M2?=
 =?utf-8?B?TThQY1BIUURnQTRnVTVGUENuMzc1VGFNVTc4WmVIVXRvNkdwVVY1QmQ3UGJC?=
 =?utf-8?B?b3BCMjN5UWkzZTVMdk5tUC9IZmxlNzBadWtFT0lwS3J1VVhCNVhicVBKWGZi?=
 =?utf-8?B?ZDRHMGRKTjVlOEhUWVVwb281RG1saGUwYWJPUDRoaGVkYlI0MUwxRk1leFRo?=
 =?utf-8?B?a0RXUTRCRFc1NEJscXNlM2VJU1lYdHVlRzUxNGtEWU9BS2l2UVFqSmtGUHIx?=
 =?utf-8?B?TWx2VlRYVWcrbVBEcDNXajNhNFJybDdIQ3RhREZraDJ4bHZCbytvaHM1TC9Y?=
 =?utf-8?B?Yk1UWFBFRG8xWCsrN01OeitwblNzckZ1bDM3dVNuVXd5TVpUSmVzNUFoQjlU?=
 =?utf-8?B?dzFRSVAwV1gyZlVYZUFVSytpMDU0TFUwNjg0b1k1ZE1PaWp2Y0w0aUN5dVp4?=
 =?utf-8?B?Q2dQSVN1Kzc4U1ZOMExsTm43NlVucmtFSFRZdnZ2UHgzR0lvL05CcXplTE1B?=
 =?utf-8?B?YmYxWkxQQVkraXowR0pBdUZNSEFoTENyenFIaWNVQytWYTN5RGRScjZMVzR2?=
 =?utf-8?B?NFNmNndUSkErMGFYdWV2TkNheTYwUm9JN3BrbDlET1luQ1R6Mld6WVVxa0Jl?=
 =?utf-8?B?ZG44YkRvVUUrSmY0SnkrWVBCVHNaemhZWFdCTEs0b0RMYlphcTlmQmREOU5q?=
 =?utf-8?B?RE5lb3hZM01PZlVrTjVwYkJBdUpoRGp2cFBuUUJIbHBKQ09uSW9Lb2dWRkRa?=
 =?utf-8?B?S2toaEJmNzVrNmFlRXd5QXpvUklzaytWeCtQRENMckhvc2doZld6bnJmSGRJ?=
 =?utf-8?B?dk5jWEVHZ0NpelE3VjZWUk84Zjd0NEkyQm44bG5tOFFMdjBVMkRwSVhnMzN2?=
 =?utf-8?B?SzJ3akpRYjl4Sm9SYzRqaGRsQjZrK3c1K2dLUXJ2S00vTkxLZEFUNTUrdXl2?=
 =?utf-8?B?NVluanpyZlZudFZsNzk3cFdwVVE1dmZKUk0rdVg3c2RybVBqb2JRY1lDWXh6?=
 =?utf-8?B?cUdIUFRTNk4xakVjRXd2cUptWmhHMUlmRnptcHJzYVgzQVpNOWtpc1Z6R0Fa?=
 =?utf-8?B?WHJVZkZOczB1SERmbkYxRndCZFlkNXdYeFE0WjlYdWxQMUxtRnBrVzd3d3Rm?=
 =?utf-8?B?SWsvMVk0V3RnWUVHaGJBb2tiYUcyN2dZWXlRQlc2QzJnT1ozT3pZRmpYb3BV?=
 =?utf-8?B?VkVBTjR1UHZqT1Jjd3FuNDNxdWMrMW82TkZsc2g3OGJFakw2YWtHeDUxdkpH?=
 =?utf-8?B?ZnllNS95U1NweVFPZjYvb2hMTGpHMjdpdG9BNmM1ems4bzcrSytZemI5bEVM?=
 =?utf-8?B?NUppTGIvdndLdVUwbHlEOHUrb0h1S3FDTGh0TStML3cyVjE0KzdWVzlVYkFE?=
 =?utf-8?B?RjlER1NiS2ZTMGtkS0Z0eG1yY1lVM0pBWTA5NVJhZXNxbGRhYnNMWjZUVGFZ?=
 =?utf-8?B?SUM3YVY4TmpkWFBtQkZmM0RxTk04WE1sei84SU1WbDFNY1E0TEZOMDhUQWZH?=
 =?utf-8?B?SjlkS0lqSnBKdXJ1Y0JTckpFWGozOUZpY1ExK2NsSHNidXN4cC93SmJRdDln?=
 =?utf-8?B?LzlpLzhIQ09NS2VxK0xLKytwek14dWRUamtCNXBpOFYvVDJyVmxJbVlpemFC?=
 =?utf-8?B?REZ4WXBpczJpZWpOZ1Z5VVlpMlN6R1pxY1E0bk5jSDRZOFVsTmkwY2s2bXIy?=
 =?utf-8?B?eHo4OE9Zb1E2OW5VRGtzNkVnUWQ5elVBclo5Z2VTa0ZydUxPNXJSWW9TZ2Jy?=
 =?utf-8?B?VDc0THVOaE5Oc056YmNWajZmajhpMjl0WjRaa0dpWnlPUXJndEl6elg3eHUr?=
 =?utf-8?B?L0FJSHY3NEVZZGdEMzZXUT09?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28ecb8db-bdca-4aa3-cf52-08d960c0aed7
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB3793.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2021 14:18:13.5770
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fJ1FSAh7yNQdx2mefY67XKpv9aU0CAItfvU5YeGjlSlGg+d8nnOF6t/yqk6yu9+n19CFY5VEEylLU2leLBU6lVtFcj5RxHAlq70UMxta+8w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4589
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10077 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0 bulkscore=0
 suspectscore=0 mlxlogscore=999 phishscore=0 mlxscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108160091
X-Proofpoint-GUID: QNqkqJb2Gx1nPRDV9qFOdNFAk1az6_9Y
X-Proofpoint-ORIG-GUID: QNqkqJb2Gx1nPRDV9qFOdNFAk1az6_9Y
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 8/10/21 12:21 PM, Jarkko Sakkinen wrote:
> On Mon, Aug 09, 2021 at 12:38:56PM -0400, Ross Philipson wrote:
>> The Secure Launch MLE environment uses PCRs that are only accessible from
>> the DRTM locality 2. By default the TPM drivers always initialize the
>> locality to 0. When a Secure Launch is in progress, initialize the
>> locality to 2.
>>
>> Signed-off-by: Ross Philipson <ross.philipson@oracle.com>
>> ---
>>   drivers/char/tpm/tpm-chip.c | 13 +++++++++++--
>>   1 file changed, 11 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/char/tpm/tpm-chip.c b/drivers/char/tpm/tpm-chip.c
>> index ddaeceb..48b9351 100644
>> --- a/drivers/char/tpm/tpm-chip.c
>> +++ b/drivers/char/tpm/tpm-chip.c
>> @@ -23,6 +23,7 @@
>>   #include <linux/major.h>
>>   #include <linux/tpm_eventlog.h>
>>   #include <linux/hw_random.h>
>> +#include <linux/slaunch.h>
>>   #include "tpm.h"
>>   
>>   DEFINE_IDR(dev_nums_idr);
>> @@ -34,12 +35,20 @@
>>   
>>   static int tpm_request_locality(struct tpm_chip *chip)
>>   {
>> -	int rc;
>> +	int rc, locality;
> 
>          int locality;
>          int rc;

Will do.

> 
>>   
>>   	if (!chip->ops->request_locality)
>>   		return 0;
>>   
>> -	rc = chip->ops->request_locality(chip, 0);
>> +	if (slaunch_get_flags() & SL_FLAG_ACTIVE) {
>> +		dev_dbg(&chip->dev, "setting TPM locality to 2 for MLE\n");
>> +		locality = 2;
>> +	} else {
>> +		dev_dbg(&chip->dev, "setting TPM locality to 0\n");
>> +		locality = 0;
>> +	}
> 
> Please, remove dev_dbg()'s.

Will do.

Thanks
Ross

> 
>> +
>> +	rc = chip->ops->request_locality(chip, locality);
>>   	if (rc < 0)
>>   		return rc;
>>   
>> -- 
>> 1.8.3.1
> 
> /Jarkko
> 

