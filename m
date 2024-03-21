Return-Path: <linux-integrity+bounces-1831-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B03FD885B9C
	for <lists+linux-integrity@lfdr.de>; Thu, 21 Mar 2024 16:26:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D1D121C21449
	for <lists+linux-integrity@lfdr.de>; Thu, 21 Mar 2024 15:26:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E989185943;
	Thu, 21 Mar 2024 15:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=politoit.onmicrosoft.com header.i=@politoit.onmicrosoft.com header.b="bSrMQZOd"
X-Original-To: linux-integrity@vger.kernel.org
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2104.outbound.protection.outlook.com [40.107.104.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBB7D3A1DD
	for <linux-integrity@vger.kernel.org>; Thu, 21 Mar 2024 15:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.104
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711034802; cv=fail; b=HNrUpUbbulwk47864IRdhnGDGVf8gzoXI7hFwTPhaOPVcZCs0aFJ/DQ8UeuZG00/+ZVRzhm6fakNnBi+UtQfqM3yGr8eYY73vifw9bMmYfgS/nGcxayjaPGVSp5QJjY7tPjkYzBShp1GRpXL9VVtFehgEZ93AL5GZ/dXHplRWv8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711034802; c=relaxed/simple;
	bh=O2H9vmJ502j6UX9PxlChLKS5T+o+u/TZD0lHA29ijLQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=mghy0zcNUL2CKh6qSZS+qB827LJXrzJE0lRRIkRSmLBxSD9ZfKmS96qmmlUrRFMRDoabRJnbUvis7xgfmhi8Juk3HiDv26R4B5u/+Gu2WjsCB2l2fq7n0CEXmTc0KvILmaMR55rIf3eljytDBBQwD0+APmtf7Xd7/R6xhsVxiRU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=polito.it; spf=pass smtp.mailfrom=polito.it; dkim=pass (1024-bit key) header.d=politoit.onmicrosoft.com header.i=@politoit.onmicrosoft.com header.b=bSrMQZOd; arc=fail smtp.client-ip=40.107.104.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=polito.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=polito.it
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C7pvTzh1Soaw5aYtLo4PPGbqB9FX+4EK4Re8UfwmlA+J69JYGjaw8ro358XmDKGZTKKYwJQcaTAxs0Zu63/VdlvYysFUP56DLMQ0Jb5QGRiSW57nxOSCUkWy126iIOrDAYeF+2+Iu07ubeNA0aL5RN3MtHWc71yA5kfVBxd3Vi40hZt9+jBb4oaLNB5PaFhtZVY31e4gQyQlDeIj1S6GhML2Bh55sYIVws1sBdcQjVQbK9vpBD6PIBihxI2bd8BjS12+vy3vWLGgWDv2+UXl4Z9Ogif+gywSLUX+h/gIyJyAM3oYQTnrJxrxI1avz026Tfp5eIttbUe5h5lx+l0D2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=foFZPmSFxIpLlB09L6w4Ps2aqEikidUP9cAyRLGsibA=;
 b=aLmK92Nzoyb0DjmBFeJko8lxM2/abnmUfZK5CwysDSD7VFlM2zG5am839vrMTaA16qZlezRw5TeJ+PwsoO4TGt4bIuq/Hprxq3vLJ6dxkeaurcNM3KLKXvx7UGUWi+KAqsOzcuX3lDTgP9nISvziuhBG5Pd3Z1YnR/V8zPRkKp7wOFggthjFxChXDyWYnn6G8Lt4a6dcpwctDtB0ChpGVsUEEjrxP/m5b+N1P0dnyuYG9jleVQUJNAsmnzb+8tlPTMHN8I35pBlgrBDYUg7lo7jLS2t0xZQsR57Y1Xo0mG2WdLYUn1XMVl55BRZl1ih4I5psErED1hMHBKMqXaUMgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=polito.it; dmarc=pass action=none header.from=polito.it;
 dkim=pass header.d=polito.it; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=politoit.onmicrosoft.com; s=selector2-politoit-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=foFZPmSFxIpLlB09L6w4Ps2aqEikidUP9cAyRLGsibA=;
 b=bSrMQZOd6qyAcMXbGhkAT6fIx2/9wR+6YbpwxeqOev+FabbrcAHYZBPB732P+s6kDmAy4pg/i791pRPG0QY6HYpqyjH5XGJUh75E5wnQRyjJEKZT6Ts/Sd1eU77kZcavKWZbSI70ObIY0MeuSGodUF9mBrOjAptPj3sWYktb3jY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=polito.it;
Received: from AS2PR05MB9840.eurprd05.prod.outlook.com (2603:10a6:20b:5f5::20)
 by PAXPR05MB8526.eurprd05.prod.outlook.com (2603:10a6:102:1a3::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.29; Thu, 21 Mar
 2024 15:26:36 +0000
Received: from AS2PR05MB9840.eurprd05.prod.outlook.com
 ([fe80::9351:e76:ff6d:29ba]) by AS2PR05MB9840.eurprd05.prod.outlook.com
 ([fe80::9351:e76:ff6d:29ba%7]) with mapi id 15.20.7386.025; Thu, 21 Mar 2024
 15:26:36 +0000
Message-ID: <6b5da02f-de8e-4633-bf46-de7fbfa1db5b@polito.it>
Date: Thu, 21 Mar 2024 16:26:34 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] ima: add crypto agility support for template-hash
 algorithm
To: Mimi Zohar <zohar@linux.ibm.com>, linux-integrity@vger.kernel.org,
 dmitry.kasatkin@gmail.com
Cc: roberto.sassu@huawei.com, Silvia Sisinni <silvia.sisinni@polito.it>
References: <20240308104953.743847-1-enrico.bravi@polito.it>
 <18e212c7d947e8a39297fd84e1765d2bc0e82140.camel@linux.ibm.com>
 <f2ed3e2a-9052-4a95-b31f-85047a01d1dd@polito.it>
 <eb70d9dbb54da5606eda1ecb8a87d653d801f441.camel@linux.ibm.com>
Content-Language: en-US, it
From: Enrico Bravi <enrico.bravi@polito.it>
In-Reply-To: <eb70d9dbb54da5606eda1ecb8a87d653d801f441.camel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ZR0P278CA0082.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:22::15) To AS2PR05MB9840.eurprd05.prod.outlook.com
 (2603:10a6:20b:5f5::20)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS2PR05MB9840:EE_|PAXPR05MB8526:EE_
X-MS-Office365-Filtering-Correlation-Id: 79f61c16-9e43-497b-1427-08dc49bb4bed
X-politoEOL-CGPAlias: 1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	kavpuH/VWsqqCARM+YlknYP3t9ESKXHuch2ChgIHPaKHqLyWKk8jj4xCO3+5w7pCkBrhf42G9ExDnPjiir0gDB6FsZB3bJq3qOJ3lZYHezsV+zgUs7R+N8Nt4GcEidWBrMEBVEzkc8EcAhYb8jgAP1Wjsj9inhuVYnl+YJx/UnxYoRoo0EyNY1FtChQ7I9bvZQolj8awLzhji5AJGdofXP9Bnvj1BPpCnXcMgUAGUKyZTMAst9SK+WyjjVg4W8h6EajgzrBm63L8kG1CFcxb0WDKBBW0zlaa6Y5CoIxDJibI/IHmysl84nX3zxHMJAQXjtuf8Sy4ZgWNCKaQt03S6q/Xvz0wpUxMVMpPUjR+AD7mn3kwfFuqZMO2022+WxTSVtAMZGqWfn1qpdpZjDb4BUMKRTFXCz7a4zuzon4A29tQStYzQH+uhA9nph6SkngZ4Nn44WSD0wEqKbVIqtglE50nhTRjkm/BNyWv1Fcn2WPZXApcYzFHGw/pCtsfSzd8DGJ4HbnAqB20VkJ//yR0qKSnnWdGu6f58RJyyxmeXm8OLU4J1o+Tp5qdKy4M/RUFQB41LSnF05uoCIvrkC8Es1IZuE3/4OZSaosQA95OTZaal6nCX2AyIi8Jo1K1sYXCz3yLJhM6BTzZkzsP8RPgg/2rAw5cTWnfZQMZie7ay1o=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS2PR05MB9840.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Sm4reEtXRUFZZ1ZnT3ZMNGRndVgxdlBIaGxwMU43aVFZRDkzbXQxcFYvZ01j?=
 =?utf-8?B?dTRIV0lxQll2S2JvL2tCdG1XTXo0L29jczZrWXQwVDRZZktLeFN5VXYxcWps?=
 =?utf-8?B?VjQzSVdMb0kyZm51QjJ0TUdlUmlHV2owWUkyR0JSU2Fzc2IvbGQ3d0t5NWFN?=
 =?utf-8?B?U1Q2cTRvT0dYeTc2SzdNc0pMZWRKZWxNQmVQT29WbWJ5T0dVSUxXb203MkVM?=
 =?utf-8?B?Z0N3WmJnN0FqaTJqNXdwZXZJY1VPUzBzRTU0Y1NYWXBKN29hb08vek1sbVBj?=
 =?utf-8?B?OVgweVBIc0psTC8wQmw1V29hNmxpYWZpajROUUsraDB5UnZMS2sxUWJneWRn?=
 =?utf-8?B?OTNpN3gyNTl3YkNpRVlLS0V3NndRYmt6QVpSRDNqcGdwYmtFT3hKdzViQ21U?=
 =?utf-8?B?amZ4anZ2eDJndHliYW45bUZ1WkdhUURhaWZ1ODJyMGJCUUFMdVdBRVh2bTJa?=
 =?utf-8?B?RmgzbjdsVWtSYWVYTFpybUwzT3lXaE9IR0NUcy9yekw5SE1nVjBnZFViRHNT?=
 =?utf-8?B?WFBNMzJBZ1dUem50R1VibXdkYmpBbURybzdnekN2NzYycEtmejFIYms0MXl4?=
 =?utf-8?B?aUIzWG50OWZSQmViY0xCQkNyaFdtb25BU05vQW81bG1NUzJkR0pSYTVsNXF0?=
 =?utf-8?B?K2J3R1FSTHFVREVoNUtpcENzd083aUVNTFYxVVlZczVnNjIzeFc5aWRxcWdq?=
 =?utf-8?B?NVdLTmpoclFsbDdhRU9PazNmSUJLNkgwY1pMRldvOFBNNmRzVzlsaVkwNzNs?=
 =?utf-8?B?cXpUUDJ5amVmMWhnU0VqemEvVExpMlBIUGNvR2JmNFhuMW51b0djcXJWaFdj?=
 =?utf-8?B?N284YTJXZlk2UFJLTVV4Tk54U2pqWmEvcVdUODRtRDN3LzdWSVlXZnAxNnpE?=
 =?utf-8?B?SE1Kc2NrSjRYeTkvVHJyQm53a1VRR1cwWUN0ZVk1VXdzRW1vcHdXTHFJWjdV?=
 =?utf-8?B?RW5hdHNKTmkzSzlIWlBONmlzeWxmaTB4cTAzaVl0N1daMXF3anRNc25ucW91?=
 =?utf-8?B?T1Z1RVBINnFyUUJSNnU3T3Y3REhDTUZQc09DYUY3L3pVWWkwS0o4U2FxODVS?=
 =?utf-8?B?bU5LUngxRmtlZUVuN3o0dGVkOWtjSVUwY0xyV2Jwa3hpMjhJeWI0WGtNVXN2?=
 =?utf-8?B?cWJqRzJ6eHFKQUFxOEQ1ZDN5bGN3bHZXVEgydFd6Y1JicGxwR2ZiQ05UUmRX?=
 =?utf-8?B?OERDTWRiS3dYL0ZXL25WR2F0WVpjSDA2TTRZaUZyS01oZ01WT0s4ZE9wcmtu?=
 =?utf-8?B?Vlg2QmN1VERGQi9TR2V0bXhkRGNMUUlyYnBvOXFCS0JmUjZ3RG9uZHRJZmVO?=
 =?utf-8?B?RVhyYXFLVll3L2VSOWVwRHBxZXBZUUdIV0ZzSkdGdzBnZTBhaDZnMENmOE5k?=
 =?utf-8?B?SDJ6SWJqWHAxemx4ZDFwSHNhMTdIVGwzM28vMFRmaTNPby9IYWlmdXdFenV0?=
 =?utf-8?B?QmJEb0puR1VZUXRZS3N2TlRycHBHcHk3VkYxQ2FTUS9BMXF4dW5PVCtnODBR?=
 =?utf-8?B?eEVRRkJ4bXg2azdyWHFsWUErZ3BPSlFjYXNPN1d6UWc1SkZmZGhaN1VzdzRp?=
 =?utf-8?B?a1dWSzI2STlJSVBRVmd0bjZRbVIzOU9KR1hYYXVJNTRFSEx1MlN1cUdDVFZn?=
 =?utf-8?B?dmRSd1NpTkhZTUN4TUdubDByTUNLZ3Z5RWhIU2JhL0ZBcmRuNi9VYzREck9m?=
 =?utf-8?B?UFhIUjE5SDZ2Y2Mrbncxa0MvamVlRXBSVmJEUnZMN1FYN1hxbXhRRzM1R2pN?=
 =?utf-8?B?TXNuV2hNTXVvUnE4bVZMVVU4NXZ6MlNHVmxYSGVUWGQ4NkV4My95K2xXaGNS?=
 =?utf-8?B?UTBGcEt1YVFFbU9KN2dLdVZFTDlrYnFLcDl6d1loYk05a1Yvam44am00bjNn?=
 =?utf-8?B?WFg1UUdmQmZrc3dHS0I3TWNCUk9qejBXMitqcmI0NW1sRzNhRFl5N0xZb3BG?=
 =?utf-8?B?YjhublJoakRpMnRzeGh2NVlVZjVTVGNVSVVpNENsN0xDelQ2cUxTcStLdUxh?=
 =?utf-8?B?NUdEWnUwdThFU2JiWnJQQTVyL2RyNUVQYXRKSTdaSm5BbmRSTExCOGJjQkFV?=
 =?utf-8?B?MmRWY2ZCMnVmUFJYZlROMk9NampiSUkrSk1jMElPNGFXWlVOb1lYT2NVMUdr?=
 =?utf-8?Q?SCUQrW7W21/uV7YpJJqfgEFiA?=
X-OriginatorOrg: polito.it
X-MS-Exchange-CrossTenant-Network-Message-Id: 79f61c16-9e43-497b-1427-08dc49bb4bed
X-MS-Exchange-CrossTenant-AuthSource: AS2PR05MB9840.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2024 15:26:36.2463
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 2a05ac92-2049-4a26-9b34-897763efc8e2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8g3d1ffAe0Jj2EaTmA7H7ZE8VcGvVDeRDkm50hbVwuqi1JVhGsslpP8STIpGanSQWtSLwlzLeGw4p/4XxYVGhg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR05MB8526

On 20/03/24 13:07, Mimi Zohar wrote:
> 
>>>> diff --git a/security/integrity/ima/ima_fs.c
>>>> b/security/integrity/ima/ima_fs.c
>>>> index cd1683dad3bf..475ab368e32f 100644
>>>> --- a/security/integrity/ima/ima_fs.c
>>>> +++ b/security/integrity/ima/ima_fs.c
>>>> @@ -116,9 +116,13 @@ void ima_putc(struct seq_file *m, void *data, int
>>>> datalen)
>>>>  		seq_putc(m, *(char *)data++);
>>>>  }
>>>>  
>>>> +static struct dentry **ima_ascii_measurements_files;
>>>> +static struct dentry **ima_binary_measurements_files;
>>>
>>> The variable naming isn't quite right.  It's defined as a 'struct dentry',
>>> but
>>> the name is '*_files'.  Why not just name the variables 'ima_{ascii, binary}
>>> _measurements'?
>>
>> Hi Mimi,
> 
> Hi Enrico,
> 
>> thank you for pointing that out. What do you think of naming them 'ima_{ascii,
>> binary}_securityfs_measurement_lists', to have also coherence with the names
>> of
>> the new functions defined.
> 
> As these are static variables, prefixing them with 'ima_' isn't necessary. 
> Either way is fine.

Hi Mimi,

perfect, in this way they would be even shorter.

Thank you,

Enrico

>>>> +static void remove_measurements_list_files(struct dentry **files)
>>>
>>> And remove '_files' from the function name.  Perhaps rename it
>>> remove_measurement_lists or remove_securityfs_measurement_lists.
>>>
>>>> +{
>>>> +	int i;
>>>> +
>>>> +	if (files) {
>>>> +		for (i = 0; i < ima_measurements_files_count; i++)
>>>> +			securityfs_remove(files[i]);
>>>> +
>>>> +		kfree(files);
>>>> +	}
>>>> +}
>>>> +
>>>> +static int create_measurements_list_files(void)
>>>
>>> And remove '_files' from the function name.  Perhaps rename it to
>>> create_measurement_lists or create_securityfs_measurement_lists.
>>
>> I think that keeping this structure for the names
>> 'remove_securityfs_measurement_lists' and
>> 'create_securityfs_measurement_lists'
>> makes sense.
> 
> Agreed.
> 
> thanks,
> 
> Mimi

