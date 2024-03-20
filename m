Return-Path: <linux-integrity+bounces-1812-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A858C881084
	for <lists+linux-integrity@lfdr.de>; Wed, 20 Mar 2024 12:10:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 35B821F23A56
	for <lists+linux-integrity@lfdr.de>; Wed, 20 Mar 2024 11:10:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A29F93BBF7;
	Wed, 20 Mar 2024 11:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=politoit.onmicrosoft.com header.i=@politoit.onmicrosoft.com header.b="tSDBwloR"
X-Original-To: linux-integrity@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2137.outbound.protection.outlook.com [40.107.20.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 525FF3BBE0
	for <linux-integrity@vger.kernel.org>; Wed, 20 Mar 2024 11:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.137
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710933008; cv=fail; b=PfFz/cnwNJKCVh8NrUJxl7Hf8tLurfzwoBOc2wvj8MJLyrcBxYS9swXlZ2UyereiwcgbwQR3oDOMZVEhcW6nG0Knwi7s1tqP7MG7rGeoeaUjNmdZHGVFtoVdIUl5wN17WVv9uZyQdICbLdFheA7XuANiRSDcxFlsKNlEHBYspAg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710933008; c=relaxed/simple;
	bh=ZrQmisgNO7u8TRcXILT3QBX1M8ciNIAKVHUf07ahp4g=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=rmntS5KWN263U3EdP4lc3RDpqhUsqaQeXfRy/8zFYJXsLDbQGtpwLGx3BgqTFJ8s1nwc2/+zPs5LOzfcI17eC5HqAYlY4zhlh3mcIejTnpKO/uVUtNUF0vVnmLotPBXOq+u4w0IjnXm11xBRuIG8FQCZh6+3mvFyqH4dDiN9UrA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=polito.it; spf=pass smtp.mailfrom=polito.it; dkim=pass (1024-bit key) header.d=politoit.onmicrosoft.com header.i=@politoit.onmicrosoft.com header.b=tSDBwloR; arc=fail smtp.client-ip=40.107.20.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=polito.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=polito.it
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UM1NM63KH7Bn4nejfBMBWvzEUawx7Jm789WQ3KHJBgVCksowmSbPJ6iDHJgeUAYH7beVrYO23vpaNnOyF/QJR+NAJ1IiPqMBaN2fF5f2Tk4H7WyVS0cLhBXO+tipFLWd9TemkJNXkAuyOnpBxm5bted8A3yLHZAjaes0cPZPnFrf+D99xp+b5qUa0b3Lfr/CuM7hjB0jmUAz/7chXZQa8hoGQN2H7he5PbrehEeYq8/YnPAK49nMjTovu1QI0Bx2Yxerz1voj3BlS1AYGWQUqkzndS+xPt/gmlQku/wp7XRHSxf+BdbbuC92vh/zGsflBhuZINo9x8NlnHlNLWrTGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KM+eklWMJ6XN1L/eR6FP3X9GFWAIsCeEVyrJuXyDOlU=;
 b=Q3Mr7BUygpN35Ew2MfzaicX+mj4bhYc752ySraImmB201VpGobyVYCHbBQ4PBPujXl2ORPJM3WpZeS3IdL7Qd3H40H6bIVoar+z44RS6+70hSOST+KTW3VrlwRcrzzX3Hi64kA9+XirL4TCcwKHBflUmLg8mWhm0RKgvMn5No8Maau3lurH1gxAR/KbQnw2jndbaUmLmd1f5zUIdftPwGwwpE2I/ILyIAhMqHMbhrFkzaiyWFNkPlkltNLfWpOYzxelo/JAu+TLG0TbPXawHNgXxl6ZVMbFl405rT2XHhFsj7VBAVO7ltW6n5gup3jXy57ykopvUhEVFITk6v0F8xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=polito.it; dmarc=pass action=none header.from=polito.it;
 dkim=pass header.d=polito.it; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=politoit.onmicrosoft.com; s=selector2-politoit-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KM+eklWMJ6XN1L/eR6FP3X9GFWAIsCeEVyrJuXyDOlU=;
 b=tSDBwloRvqm+xfNPmspFHzTWLrchAdS/pPEuHAWPJIV1oqqQSN7aSPFmzyq4T6r7loruKZah/42Au8FR25lqJhnBzDrV2mwiA+X2RepeZmWEjYpqnaEbPcvPlB3t7rtRuplcAL1e+nxo7AOCXJgwe9pF75xwtFfjnCPXohpgT1w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=polito.it;
Received: from AS2PR05MB9840.eurprd05.prod.outlook.com (2603:10a6:20b:5f5::20)
 by PAXPR05MB9664.eurprd05.prod.outlook.com (2603:10a6:102:243::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.27; Wed, 20 Mar
 2024 11:09:55 +0000
Received: from AS2PR05MB9840.eurprd05.prod.outlook.com
 ([fe80::9351:e76:ff6d:29ba]) by AS2PR05MB9840.eurprd05.prod.outlook.com
 ([fe80::9351:e76:ff6d:29ba%7]) with mapi id 15.20.7386.025; Wed, 20 Mar 2024
 11:09:55 +0000
Message-ID: <dff8a481-cedf-40ad-96cc-e7d5780d8100@polito.it>
Date: Wed, 20 Mar 2024 12:09:52 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] ima: add crypto agility support for template-hash
 algorithm
Content-Language: en-US, it
To: Roberto Sassu <roberto.sassu@huaweicloud.com>,
 linux-integrity@vger.kernel.org, zohar@linux.ibm.com,
 dmitry.kasatkin@gmail.com
Cc: roberto.sassu@huawei.com, Silvia Sisinni <silvia.sisinni@polito.it>
References: <20240308104953.743847-1-enrico.bravi@polito.it>
 <a0bf6aa049ddebfd567a25446d05d73062a409ab.camel@huaweicloud.com>
From: Enrico Bravi <enrico.bravi@polito.it>
In-Reply-To: <a0bf6aa049ddebfd567a25446d05d73062a409ab.camel@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MI2P293CA0012.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:45::10) To AS2PR05MB9840.eurprd05.prod.outlook.com
 (2603:10a6:20b:5f5::20)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS2PR05MB9840:EE_|PAXPR05MB9664:EE_
X-MS-Office365-Filtering-Correlation-Id: 6798b72f-7067-46d5-3ccc-08dc48ce4594
X-politoEOL-CGPAlias: 1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ktzF52DlSjkD/rMHcmUOGB+IAI20qHATKcu0hMt/ydTTyl1CyXSP21PpuMj6oqd+0pvEg+bytSM48bi4lSnwWgGz3fFF/HuxpGnp4eSKhSDKG6cWZoAl5aWRkN3Btc0zt+vzK1qSIDaIQKmVQszSuDq0nAH1KgUsW4YDo5sTWrWDIUBI3AshBqumYL4mhNg3E5ELJLuEeww/qSHLQZ++/FrT41OlAGPCM3ODT32oR4gqh5FwNOdZF2vEL27GP3IulNFsFvYn0OC/1DNpUDJ3ak3J0sh89zUf/Ag8KhVJz+dhoMA5UiDxj7kf2ABegILAxAYKiDaHRJT1h/Z1QQZKNySFwYsIon47VudMub0azGu5Uboi8xEWpCxF50h/AsgFS/exKBVbWmLpYDOIelRpwn+5e180dgY087oJUA5OUXbVRJM+MXUF19kC7tQ2ceFXN+kbY25Hgz1ZlpKrTwqzPtgoPi0kLwQgmdmYrDBuNXLNHbPIJaC6Tws/BBDX24g3RaRvCnViJtd9E3khTxlSRX6vKkCkJx9s3GXK5ySMXg2yQ2KsEnC0rtLNXrafVRDCE/Nu2OX0P3D4WXrxTn5tK+NvFd6Q8p5FrM9kf3d8tzmmaciFy0g/GL3P8PS9DLb3r/uHXosjGGOF1GCzzExAnIv9fVjBEVLVxDIzwArfWvQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS2PR05MB9840.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?R2M3NWNvMWpSd3pva1NSWDcrcVBZZXp1Uk1TUXZvamhOR0lQWGhKT2p0ZUVj?=
 =?utf-8?B?RGVJMzIvNzhsMUZ1aXBFZmFVejNoYVU4ckpocTRPV1E4cWpOWmFyaTRpSXM2?=
 =?utf-8?B?S2lIWjljZDRxYTVTQk5kQkJMWDBqYnNsMXdOQjlQM29XakVUK2RsL3Z6MXBS?=
 =?utf-8?B?Ync5dDVBMGVNR20zRVpRd3pnVjd0c043NUlPdUhTZmdXM3lmK0EzMHFuQmRk?=
 =?utf-8?B?N0pnc1dRRHlXNW1mNTRCNVBSSjdBemFTUVlhZGF3WGRtQ2Q3cnNCUGxrcGZC?=
 =?utf-8?B?aklCVFo1eGZmSEZxM3c5eVVmV2VkczdLanFBMlQvdFBzY09WeEZwdncrTkZv?=
 =?utf-8?B?ZVo1cU9CQ1orZGVseTNVZ05IZVZneFY2N0Q0YTA2SEdTSFYzY2hCL1ZqRjNu?=
 =?utf-8?B?RW9lMDNNR3JHa0t3dDc1SVdFN1NWbklTbWNMQlEzVE9yY2xoMEhLWk5QYnph?=
 =?utf-8?B?RzBsUjNzM1hzOTBCZ3o2NzNYYStMUCtVVkNkN1hkOENMYjRRc1NRdXhuckM5?=
 =?utf-8?B?WTNtWkJJUnJBUS9pVC9majlhMHZsNlNoRnAyaDNhOVBwWGtTcDVaWHhGZTRs?=
 =?utf-8?B?SkN5dURPamorZ2RjcWZRakx3cWdMa1h1UldQNjRvN01uWmhwMjh5bEJUNXdy?=
 =?utf-8?B?ejc4SzIvd0tITTdNNGZRNUVXaWJQeDV2aDExdE9nS1FpdFo0cUplY0g3Tkgz?=
 =?utf-8?B?QTdISmEwbXdmZjhQN01wOXJFUnZXQWQ4UStoRVY1ZFM5RStNcHNVMFhPbWxO?=
 =?utf-8?B?ZUJBRFVJR2FOaXlCT3hCT1p4T2xqU1pFdmlQcVZyWWNRWVd2Vk9PQUNPYysw?=
 =?utf-8?B?VXFjK3d6K3piMktIMWd3SHc3cTMxb1VtZk82T0tTZC9iWERlTEJ3S0lJd2w2?=
 =?utf-8?B?dU1uckRxWXhnOTJ3Ymp0c282eXIraTBrK05TV0o3QVM0c0VhRHp1b2tqNEUr?=
 =?utf-8?B?eGpHL1pMZ3hpUGxHaTVsNWhvOFgxaTlxMlhHYVo4aVhZSExEL25vdnFCNHox?=
 =?utf-8?B?b0pXU0JsMlVacTI0YWxLeGpQTEk4cXJnMStvcmIrVEh3RzczU0JYbW5aRVBa?=
 =?utf-8?B?d1Bmd2x5NGZyZCtBMU5uZ2tKaHFNb3Q2VmFJY3NxUjdNRWRxa3JROVZYNldN?=
 =?utf-8?B?VWk5bVhBZWt4NHpKbTQ5WUJnWTRpbkx0LzFkampvbnVRS3dqVVpuc0Nvd0h6?=
 =?utf-8?B?dzgzSVRxUW5vMk9HcTFaaXpvaXU0ZnpjQzZKMW0ySWg1NnNpSG5ML3FSeGdx?=
 =?utf-8?B?SFQ3emxHSmhuR2p1b1JLRHR0SFdUVmd3VGdVL2pReHV5VmM4Q1RIczZSTHU4?=
 =?utf-8?B?SFVtanFKMWZ2Q2YvMUxtQ0hZanJjdXhPVjNmc0VqQy9sNlFCZkVmdEQ2SWtv?=
 =?utf-8?B?SUV0d3JxNCswOVdHSWMzcll3a0tSVjBSbGN3QUxsRUZCZVNreWJYS2k1UjZH?=
 =?utf-8?B?MzZNeHpxZ2EyWVI1cllEeTBUMk0rTFhzais4aStvMk9SZ3BxVzZYVTQ2algz?=
 =?utf-8?B?c0cvM2lYVG1Ua3hLd0R3cTNoY3R1Tm1EZHJRTGJNb0RCYnFycW40K2V1Q0JJ?=
 =?utf-8?B?S0N4aGZ0OEMwZnJ4VG1rYW9nRFFvV2xVNUp5eHp5TXNMNzFxZ1MxZmhoOUdh?=
 =?utf-8?B?eTFkMTBPNWx1MEdWTWhDbTdMQXZZZkxtLzZsSjV1OVRjdUR6Ritua1BJY2tB?=
 =?utf-8?B?T2FBSGd2RUFtQVQvZk1YNC9uS3NtY1dXWk5jZXlKbW5sZVVFM3dkYUNkdExt?=
 =?utf-8?B?K3h6TUdISE8vUWNGWlNpT3kxbGlTeHl5bDhEcGhrRWpxSElmaFpGY01YdUVV?=
 =?utf-8?B?SnpYUFRzK1FRWXpFSVVkcVFXRXlIMk1LdUhsODN3NXlyM2pEcEZtWmFZWXND?=
 =?utf-8?B?b3hmQzR6eVdaeDRQNDJHRGJlQ0Z2aDNFZmpzTVo2RWRxWWNZb0JGaE16Q0hX?=
 =?utf-8?B?eFhXSHgwM0FIWXFYeFBsaFVZM1NYZEd5dTlFNVllZkZpc0p4S1BCcTh3Y3lD?=
 =?utf-8?B?WDJnZ0VvWFArMWxyampNU3BmSXJHU2tqQ2o1N25oNG9yU3VLcGpEc0puWDYx?=
 =?utf-8?B?ZlIwNkwrNGY4dERJY3FldzFZald5dTRaWFJZMDJTNTJraE9QVHJKT1IxbEFw?=
 =?utf-8?B?QTdQdHF5aFJhei8zWEZPUW1FVHpVY1dLYm13cTZDSVFCRlZqeldzaUhjRGJE?=
 =?utf-8?B?TEE9PQ==?=
X-OriginatorOrg: polito.it
X-MS-Exchange-CrossTenant-Network-Message-Id: 6798b72f-7067-46d5-3ccc-08dc48ce4594
X-MS-Exchange-CrossTenant-AuthSource: AS2PR05MB9840.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2024 11:09:54.9558
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 2a05ac92-2049-4a26-9b34-897763efc8e2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VF2appkDj/FeuW4Xo10HC7jr2pwpg0yJqvZQ056ygmyrZmodCZLXWA9GBSf5IYRPc1fRCzssoyxu47fHTXUC8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR05MB9664

On 18/03/24 09:25, Roberto Sassu wrote:
> On Fri, 2024-03-08 at 11:49 +0100, Enrico Bravi wrote:
>> The template hash showed by the ascii_runtime_measurements and
>> binary_runtime_measurements is the one calculated using sha1 and there is
>> no possibility to change this value, despite the fact that the template
>> hash is calculated using the hash algorithms corresponding to all the PCR
>> banks configured in the TPM.
>>
>> Add the support to retrieve the ima log with the template data hash
>> calculated with a specific hash algorithm.
>> Add a new file in the securityfs ima directory for each hash algo
>> configured in a PCR bank of the TPM. Each new file has the name with
>> the following structure:
>>
>>         {binary, ascii}_runtime_measurements_<hash_algo_name>
>>
>> Legacy files are kept, to avoid breaking existing applications, but as
>> symbolic links which point to {binary, ascii}_runtime_measurements_sha1
>> files. These two files are created even if a TPM chip is not detected or
>> the sha1 bank is not configure in the TPM.
> 
> Configured.

Hi Roberto,

thanks for the correction.

(more below)

>> As example, in the case a TPM chip is present and sha256 is the only
>> configured PCR bank, the listing of the security/ima directory is the
>> following:
>>
>> lr--r--r-- [...] ascii_runtime_measurements -> ascii_runtime_measurements_sha1
>> -r--r----- [...] ascii_runtime_measurements_sha1
>> -r--r----- [...] ascii_runtime_measurements_sha256
>> lr--r--r-- [...] binary_runtime_measurements -> binary_runtime_measurements_sha1
>> -r--r----- [...] binary_runtime_measurements_sha1
>> -r--r----- [...] binary_runtime_measurements_sha256
>> --w------- [...] policy
>> -r--r----- [...] runtime_measurements_count
>> -r--r----- [...] violations
>>
>> Signed-off-by: Enrico Bravi <enrico.bravi@polito.it>
>> Signed-off-by: Silvia Sisinni <silvia.sisinni@polito.it>
>>
>> ---
>>
>> v4:
>>  - Added NULL check on m->file for measurements list dump called by
>>    ima_dump_measurement_list() on kexec.
>>  - Exported ima_algo_array and struct ima_algo_desc declaration from
>>    ima_crypto.c to access this information in ima_fs.c.
>>  - Added ima_measurements_files_count global variable to avoid extra
>>    logic each time the number of measurements file is needed.
>>
>> v3:
>>  - Added create_measurements_list_files function for measurements files creation.
>>  - Parameterized the remove_measurements_list_files function and add NULL
>>    check before freeing files' list.
>>  - Removed algorithm selection based on file name during ima_measurements_show
>>    and ima_ascii_measurements_show, and selecting it comparing dentry address.
>>  - Allocate also sha1 file following the schema
>>    {binary, ascii}_runtime_measurements_<hash_algo_name> and keep legacy
>>    files as symbolic links to those files.
>>  - Allocate measurements files lists even if a TPM chip is not detected,
>>    adding only sha1 files.
>>
>> v2:
>>  - Changed the behavior of configuring at boot time the template data hash
>>    algorithm.
>>  - Removed template data hash algo name prefix.
>>  - Removed ima_template_hash command line option.
>>  - Introducing a new file in the securityfs ima subdir for each PCR banks
>>    algorithm configured in the TPM.
>>    (suggested by Roberto)
>>
>>
>>  security/integrity/ima/ima.h        |   9 ++
>>  security/integrity/ima/ima_crypto.c |   7 +-
>>  security/integrity/ima/ima_fs.c     | 135 +++++++++++++++++++++++++---
>>  3 files changed, 131 insertions(+), 20 deletions(-)
>>
>> diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
>> index c29db699c996..81318e294175 100644
>> --- a/security/integrity/ima/ima.h
>> +++ b/security/integrity/ima/ima.h
>> @@ -54,6 +54,15 @@ extern int ima_hash_algo __ro_after_init;
>>  extern int ima_sha1_idx __ro_after_init;
>>  extern int ima_hash_algo_idx __ro_after_init;
>>  extern int ima_extra_slots __ro_after_init;
>> +
>> +/* export hash algorithms configured in ima */
>> +struct ima_algo_desc {
>> +	struct crypto_shash *tfm;
>> +	enum hash_algo algo;
>> +};
>> +
>> +extern struct ima_algo_desc *ima_algo_array;
>> +
>>  extern int ima_appraise;
>>  extern struct tpm_chip *ima_tpm_chip;
>>  extern const char boot_aggregate_name[];
>> diff --git a/security/integrity/ima/ima_crypto.c b/security/integrity/ima/ima_crypto.c
>> index 51ad29940f05..d42ea0d350a1 100644
>> --- a/security/integrity/ima/ima_crypto.c
>> +++ b/security/integrity/ima/ima_crypto.c
>> @@ -57,11 +57,6 @@ MODULE_PARM_DESC(ahash_bufsize, "Maximum ahash buffer size");
>>  static struct crypto_shash *ima_shash_tfm;
>>  static struct crypto_ahash *ima_ahash_tfm;
>>  
>> -struct ima_algo_desc {
>> -	struct crypto_shash *tfm;
>> -	enum hash_algo algo;
>> -};
>> -
>>  int ima_sha1_idx __ro_after_init;
>>  int ima_hash_algo_idx __ro_after_init;
>>  /*
>> @@ -70,7 +65,7 @@ int ima_hash_algo_idx __ro_after_init;
>>   */
>>  int ima_extra_slots __ro_after_init;
>>  
>> -static struct ima_algo_desc *ima_algo_array;
>> +struct ima_algo_desc *ima_algo_array;
>>  
>>  static int __init ima_init_ima_crypto(void)
>>  {
>> diff --git a/security/integrity/ima/ima_fs.c b/security/integrity/ima/ima_fs.c
>> index cd1683dad3bf..475ab368e32f 100644
>> --- a/security/integrity/ima/ima_fs.c
>> +++ b/security/integrity/ima/ima_fs.c
>> @@ -116,9 +116,13 @@ void ima_putc(struct seq_file *m, void *data, int datalen)
>>  		seq_putc(m, *(char *)data++);
>>  }
>>  
>> +static struct dentry **ima_ascii_measurements_files;
>> +static struct dentry **ima_binary_measurements_files;
>> +static int ima_measurements_files_count;
>> +
>>  /* print format:
>>   *       32bit-le=pcr#
>> - *       char[20]=template digest
>> + *       char[n]=template digest
>>   *       32bit-le=template name size
>>   *       char[n]=template name
>>   *       [eventdata length]
>> @@ -130,9 +134,26 @@ int ima_measurements_show(struct seq_file *m, void *v)
>>  	struct ima_queue_entry *qe = v;
>>  	struct ima_template_entry *e;
>>  	char *template_name;
>> +	struct dentry *dentry;
>>  	u32 pcr, namelen, template_data_len; /* temporary fields */
>>  	bool is_ima_template = false;
>> -	int i;
>> +	int i, algo_idx;
>> +	enum hash_algo algo;
>> +
>> +	algo_idx = ima_sha1_idx;
>> +	algo = HASH_ALGO_SHA1;
>> +
>> +	if (m->file != NULL) {
>> +		dentry = file_dentry(m->file);
>> +
>> +		for (i = 0; i < ima_measurements_files_count; i++) {
>> +			if (dentry == ima_binary_measurements_files[i]) {
>> +				algo_idx = i;
>> +				algo = ima_algo_array[i].algo;
>> +				break;
>> +			}
>> +		}
>> +	}
> 
> Since you duplicate the same code below, I would put it in a separate
> function, like lookup_algo_by_dentry().
Thank you for the suggestion, we will wrap that logic in a function.

>>  	/* get entry */
>>  	e = qe->entry;
>> @@ -151,7 +172,7 @@ int ima_measurements_show(struct seq_file *m, void *v)
>>  	ima_putc(m, &pcr, sizeof(e->pcr));
>>  
>>  	/* 2nd: template digest */
>> -	ima_putc(m, e->digests[ima_sha1_idx].digest, TPM_DIGEST_SIZE);
>> +	ima_putc(m, e->digests[algo_idx].digest, hash_digest_size[algo]);
>>  
>>  	/* 3rd: template name size */
>>  	namelen = !ima_canonical_fmt ? strlen(template_name) :
>> @@ -220,7 +241,24 @@ static int ima_ascii_measurements_show(struct seq_file *m, void *v)
>>  	struct ima_queue_entry *qe = v;
>>  	struct ima_template_entry *e;
>>  	char *template_name;
>> -	int i;
>> +	struct dentry *dentry;
>> +	int i, algo_idx;
>> +	enum hash_algo algo;
>> +
>> +	algo_idx = ima_sha1_idx;
>> +	algo = HASH_ALGO_SHA1;
>> +
>> +	if (m->file != NULL) {
>> +		dentry = file_dentry(m->file);
>> +
>> +		for (i = 0; i < ima_measurements_files_count; i++) {
>> +			if (dentry == ima_ascii_measurements_files[i]) {
>> +				algo_idx = i;
>> +				algo = ima_algo_array[i].algo;
>> +				break;
>> +			}
>> +		}
>> +	}
>>  
>>  	/* get entry */
>>  	e = qe->entry;
>> @@ -233,8 +271,8 @@ static int ima_ascii_measurements_show(struct seq_file *m, void *v)
>>  	/* 1st: PCR used (config option) */
>>  	seq_printf(m, "%2d ", e->pcr);
>>  
>> -	/* 2nd: SHA1 template hash */
>> -	ima_print_digest(m, e->digests[ima_sha1_idx].digest, TPM_DIGEST_SIZE);
>> +	/* 2nd: template hash */
>> +	ima_print_digest(m, e->digests[algo_idx].digest, hash_digest_size[algo]);
>>  
>>  	/* 3th:  template name */
>>  	seq_printf(m, " %s", template_name);
>> @@ -379,6 +417,71 @@ static const struct seq_operations ima_policy_seqops = {
>>  };
>>  #endif
>>  
>> +static void remove_measurements_list_files(struct dentry **files)
>> +{
>> +	int i;
>> +
>> +	if (files) {
>> +		for (i = 0; i < ima_measurements_files_count; i++)
>> +			securityfs_remove(files[i]);
>> +
>> +		kfree(files);
>> +	}
>> +}
>> +
>> +static int create_measurements_list_files(void)
>> +{
>> +	int i;
>> +	u16 algo;
>> +	char file_name[NAME_MAX+1];
>> +	struct dentry *dfile;
>> +	enum hash_algo sha1_algo_idx = -1;
>> +
>> +	ima_measurements_files_count = NR_BANKS(ima_tpm_chip);
>> +
>> +	if (ima_sha1_idx >= NR_BANKS(ima_tpm_chip))
>> +		ima_measurements_files_count++;
>> +
>> +	ima_ascii_measurements_files = kcalloc(ima_measurements_files_count,
>> +						sizeof(struct dentry *), GFP_KERNEL);
> 
> Second line not aligned?
> 
> Try scripts/checkpatch.pl --strict
> 
> 
> It should tell about these issues.

Thank you, we will fix the alignment.

> 
>> +	if (!ima_ascii_measurements_files)
>> +		return -ENOMEM;
>> +
>> +	ima_binary_measurements_files = kcalloc(ima_measurements_files_count,
>> +						sizeof(struct dentry *), GFP_KERNEL);
>> +	if (!ima_binary_measurements_files)
>> +		return -ENOMEM;
>> +
>> +	for (i = 0; i < ima_measurements_files_count; i++) {
>> +		algo = ima_algo_array[i].algo;
>> +
>> +		if (algo == HASH_ALGO_SHA1)
>> +			sha1_algo_idx = i;
>> +
>> +		sprintf(file_name, "ascii_runtime_measurements_%s",
>> +					hash_algo_name[algo]);
> 
> Alignment.>
>> +		dfile = securityfs_create_file(file_name,
>> +					S_IRUSR | S_IRGRP, ima_dir, NULL,
>> +					&ima_ascii_measurements_ops);
>> +		if (IS_ERR(dfile))
>> +			return PTR_ERR(dfile);
>> +
>> +		ima_ascii_measurements_files[i] = dfile;
>> +
>> +		sprintf(file_name, "binary_runtime_measurements_%s",
>> +					hash_algo_name[algo]);
>> +		dfile = securityfs_create_file(file_name,
>> +					S_IRUSR | S_IRGRP, ima_dir, NULL,
>> +					&ima_measurements_ops);
>> +		if (IS_ERR(dfile))
>> +			return PTR_ERR(dfile);
>> +
>> +		ima_binary_measurements_files[i] = dfile;
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>>  /*
>>   * ima_open_policy: sequentialize access to the policy file
>>   */
>> @@ -465,19 +568,21 @@ int __init ima_fs_init(void)
>>  		goto out;
>>  	}
>>  
>> -	binary_runtime_measurements =
>> -	    securityfs_create_file("binary_runtime_measurements",
>> -				   S_IRUSR | S_IRGRP, ima_dir, NULL,
>> -				   &ima_measurements_ops);
>> +	ret = create_measurements_list_files();
>> +	if (ret != 0)
>> +		goto out;
>> +
>> +	binary_runtime_measurements = securityfs_create_symlink(
>> +		"binary_runtime_measurements", ima_dir,
>> +		"binary_runtime_measurements_sha1", NULL);
>>  	if (IS_ERR(binary_runtime_measurements)) {
>>  		ret = PTR_ERR(binary_runtime_measurements);
>>  		goto out;
>>  	}
>>  
>> -	ascii_runtime_measurements =
>> -	    securityfs_create_file("ascii_runtime_measurements",
>> -				   S_IRUSR | S_IRGRP, ima_dir, NULL,
>> -				   &ima_ascii_measurements_ops);
>> +	ascii_runtime_measurements = securityfs_create_symlink(
>> +		"ascii_runtime_measurements", ima_dir,
>> +		"ascii_runtime_measurements_sha1", NULL);
>>  	if (IS_ERR(ascii_runtime_measurements)) {
>>  		ret = PTR_ERR(ascii_runtime_measurements);
>>  		goto out;
>> @@ -515,6 +620,8 @@ int __init ima_fs_init(void)
>>  	securityfs_remove(runtime_measurements_count);
>>  	securityfs_remove(ascii_runtime_measurements);
>>  	securityfs_remove(binary_runtime_measurements);
>> +	remove_measurements_list_files(ima_ascii_measurements_files);
>> +	remove_measurements_list_files(ima_binary_measurements_files);
> 
> Other than the issues above, looks good.
> 
> Did you try to dump non-SHA1 measurements after kexec?

Yes, the porting of the list seems to work fine. I put an example with the
following configuration:

- TPM 2.0 with only SHA256 bank configured
- ima hash algo before kexec: sha1
- ima hash algo after kexec: sha384

Here it is the dump of the ascii_runtime_measurements_sha256 list:

10 8328[..]a07e ima-ng sha256:065c[..]8023 boot_aggregate
10 afd6[..]3123 ima-ng sha1:5a49[..]9566 /init
10 9932[..]6353 ima-ng sha1:8c87[..]d8c7 /usr/bin/sh
...
10 58e3[..]9996 ima-ng sha1:f969[..]ad47 /etc/pam.d/sudo
10 f85f[..]a2f2 ima-ng sha1:8525[..]a168 /usr/sbin/kexec
10 01bb[..]e97f ima-ng sha1:235a[..]8ddb /boot/vmlinuz-6.8.0-dirty
10 64c9[..]e5c8 ima-ng sha1:7341[..]cd48 /boot/initrd.img-6.8.0-dirty
10 8328[..]a07e ima-ng sha256:065c[..]8023 boot_aggregate
10 93ca[..]0de0 ima-ng sha384:4d80[..]f38b /init
10 a240[..]7f27 ima-ng sha384:8dd5[..]6f31 /usr/bin/sh
...

> Thanks

Thank you for your feedback and suggestions.

Enrico

> Roberto
> 
>>  	securityfs_remove(ima_symlink);
>>  	securityfs_remove(ima_dir);
>>
>> base-commit: 88035e5694a86a7167d490bb95e9df97a9bb162b 


