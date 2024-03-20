Return-Path: <linux-integrity+bounces-1813-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 33B2A881085
	for <lists+linux-integrity@lfdr.de>; Wed, 20 Mar 2024 12:10:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DDD8328344B
	for <lists+linux-integrity@lfdr.de>; Wed, 20 Mar 2024 11:10:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC7443B2BB;
	Wed, 20 Mar 2024 11:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=politoit.onmicrosoft.com header.i=@politoit.onmicrosoft.com header.b="d3iKPjhs"
X-Original-To: linux-integrity@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2104.outbound.protection.outlook.com [40.107.20.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A1F539FFB
	for <linux-integrity@vger.kernel.org>; Wed, 20 Mar 2024 11:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.104
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710933034; cv=fail; b=NSYUQI/Ww0vUVqJ8HrC4MWm5oRaNjjJsskiXIetEWERUt6E9FYDUN0o9AatnjFlVIqoM0M4Bc7RoeB+hGUfmh/xPo/v2FyNvVS6JNuhsccvMNXdQCmnL0IgbneeEpF9ah6UToK+7W2fRNDEshiyZE/H0aZ13ICZ9f49X7m7Klkg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710933034; c=relaxed/simple;
	bh=8UMyXnMuMSwJ5eIje7tej1brdwQhbzRKErrGIFTbhkw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=kWJ81f9hl9ccbzg7wH97WCMOggN7fjSzl6bQqsZW9z3bkSaKbWFBbhZmm1ZhnfYHHABJ+K9L/G7xCGQUrogfnLTv/Q61o3WoBSIXukCU2SjxlpWXhnTqs+cZdhe3O2U35jmE686bAOrduaBq9tTdD/0nYcCCeXaIhc/gYKBj6so=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=polito.it; spf=pass smtp.mailfrom=polito.it; dkim=pass (1024-bit key) header.d=politoit.onmicrosoft.com header.i=@politoit.onmicrosoft.com header.b=d3iKPjhs; arc=fail smtp.client-ip=40.107.20.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=polito.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=polito.it
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X844jNSgKv3HTm3LPdQXr/JYpNzsESfyokRdCCFmimLrOdnsZtaiOy4Wqhx8yt2pkF2KIXSx6f/p2zc9ZHvRhs0GNSRW6F2JocEQEnfrYHmnu5oOeJfJlCDfIlSv7AuwYJ8P9P55JkSWltKKJ5JqaSrF+xGoilnhrVPOyggrQgMaPd7N04whqNdDL6I8B/CALwUF4yYKMA83d66dpT5TEZxxCXtmETJzzS/Ypo5K9qUh31QGzwmEBcyubGgTpb8GbyACK06ftTB9FaEP5loq3OtsUWdor6Y/SGMlcXQLlg7I7kQugzjbXEzkiuG/NbaY75cxwgoSDD1/8R6xnkKwtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XDDccHErFVBAfZ8O9isThoKLqkrPnc8ACD+ictd0Nt4=;
 b=GtltNMKVsi9FEkkUXtvgWyb2R4kUN9+yQdV3U5KsR2YWUwld+gYInXBRz2kfgQ7BGa9Uz4qfXB5xgl0r3UPprI0wd9Vf31rFUOTc21ZJM78FHMN3XDIgQ0GZkGwKNrIGCZCm04t23yZixmJNMK8upR2mOEDXnCl1KvDDqywI0uzpykPnT4PCbcLW662rGJo0mrfPt/aXpOga08R0DurrOow1S2Z6E02Qpy8c58moyBomdGFMPLAWiL9sOfSwcg3RZFWjbqHVsxcFrTjWhXEnGd1U5FqMRN1f9jvrSlPNa8QbyPrHMGCpU/W64twCCnHkE/1U004E4YdjkXY+MuGzEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=polito.it; dmarc=pass action=none header.from=polito.it;
 dkim=pass header.d=polito.it; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=politoit.onmicrosoft.com; s=selector2-politoit-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XDDccHErFVBAfZ8O9isThoKLqkrPnc8ACD+ictd0Nt4=;
 b=d3iKPjhslpzBnQZXkERNWzqCQKMKIMzbNfmuZAjJIrYgJfC16aV9w3s9RnfVUSySXTiMbbEG8BrhexXNXzPhX3JbEJA7TXyO/V9KGak2dZLl1nDHCUNbKHzf+jeF3qvRye8UWUKJQFJyE74sW+vfHe7GCZi4HJXMKbzWiqAE+6M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=polito.it;
Received: from AS2PR05MB9840.eurprd05.prod.outlook.com (2603:10a6:20b:5f5::20)
 by PAXPR05MB9664.eurprd05.prod.outlook.com (2603:10a6:102:243::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.27; Wed, 20 Mar
 2024 11:10:28 +0000
Received: from AS2PR05MB9840.eurprd05.prod.outlook.com
 ([fe80::9351:e76:ff6d:29ba]) by AS2PR05MB9840.eurprd05.prod.outlook.com
 ([fe80::9351:e76:ff6d:29ba%7]) with mapi id 15.20.7386.025; Wed, 20 Mar 2024
 11:10:28 +0000
Message-ID: <f2ed3e2a-9052-4a95-b31f-85047a01d1dd@polito.it>
Date: Wed, 20 Mar 2024 12:10:27 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] ima: add crypto agility support for template-hash
 algorithm
Content-Language: en-US, it
To: Mimi Zohar <zohar@linux.ibm.com>, linux-integrity@vger.kernel.org,
 dmitry.kasatkin@gmail.com
Cc: roberto.sassu@huawei.com, Silvia Sisinni <silvia.sisinni@polito.it>
References: <20240308104953.743847-1-enrico.bravi@polito.it>
 <18e212c7d947e8a39297fd84e1765d2bc0e82140.camel@linux.ibm.com>
From: Enrico Bravi <enrico.bravi@polito.it>
In-Reply-To: <18e212c7d947e8a39297fd84e1765d2bc0e82140.camel@linux.ibm.com>
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
X-MS-Office365-Filtering-Correlation-Id: c25e8b22-58ab-4c29-9374-08dc48ce598c
X-politoEOL-CGPAlias: 1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	wAahemp3wTXFJFLSx8h9OmoSF3OsTbBdApYeiiml2RlSUd3/0HqGJltERl4jk1I7LBE6wrzU41kDdBy9sKf8qQtAWccf4DvFnZwdmKhERM8jrzz+m0vkc/Z0Ll2tGROUkuSHNdcATRf/WEnwTd1Bc446vTXNIMHOLizwcd7MCv7UC10MC0FlAoB2C/fdyD105f1jXhVotYX63lYGK5ffBCCqrhwrDIgQRQPlSsoz4irj2eR+wcXojDzy0H6e0ER0LTBmflIIyyQKJKzk/hdKxnFCutCEeY0YdAM4WUE3XJEahSkgtgibVUUYt449j2y84hNqJiyH4AQjgOVA4IAu5g/4QBvatcuw+HuZaHCPsMSFNTCQMen5mRX5uKrHkVT1APlxVrmKkep4Hwe9lWDZe8hq5iW1rjZSuUoykQCmKHUxszIBBydPC3wP/Gc/dmuj9X9guCcK4nBDEjmAJ3gVGJujq+LnDN3kpMi2fIru+29EU4OIXS2TkhbxkXLnVOnIjRz0ceKKwpHqI+3MWrKr8J/bryA9+52wplgKl+bVnVEhFFMDzJ2H41xwKCEUIkMlY7t9ydN0WeYzSPE9BpkhurMhz1QdYRerhwFVh3gyhPnn/gxK39C2Cd0IcB+atT3X0r6Y2s4G3try3AXpNx6Ob7T/SDz4pR2V/9mOF2qp7GQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS2PR05MB9840.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UkhqblRDN1IvOGloRldlVi9vWUtPQTBoaUZ0TkxJcWJwVStRZjJtY283enRw?=
 =?utf-8?B?Z1lHZnZjSE5XYVZrUjlOWHJPWTdNdjZCSkIvTDRzZFhhazRUd2Z6eGc5b1ZB?=
 =?utf-8?B?WHRFVGFzY2hFTk9VakJXc2s2UEpQNUZZdnA4WmM0ZkxlYUQyeGkyUGlEMWk3?=
 =?utf-8?B?OGtKbUNwclhXTkgxdy9wS3dTZk90Ni90czFFQTE1elNRUTAvSTRwZzQrZU1N?=
 =?utf-8?B?NUgzd1J2RnV1RjRYQWRIb05hbzlMMGJIS05YN0dxSUF3QzcwMDI4QWtoU25x?=
 =?utf-8?B?NVJjazBSQWt4eG5CNUZ6RWxRYUU2ZjVCaU5saE9yd2pCdDlyRTJkQ3lraXM3?=
 =?utf-8?B?VGoxc1NpVXVmcmZaVGNhakNLWnNydHhkWElwRWJxR1hkSnB4cWYvSmtNbE5Q?=
 =?utf-8?B?dDBpTk9EYVFpM055K2hKcnJTQ0JYYUp6WnlRajNic2RyTUNMTE5td3F4VWE1?=
 =?utf-8?B?RTF4YjhyQk1hRStGY2J2SHhtUUJxRmJ4YXFVU2FHeE5Ma3FDZkc5N0lzZ0U1?=
 =?utf-8?B?SkVITFcramU1MzRoejZrWW5hazFRRTFXOGJvamc0TDE3KzhFZlFpcEgzS0sx?=
 =?utf-8?B?TnY2aFRLRHBrZTFXWWswMlNWQjJFMVFUNUxYNTZId2ZVeVdhcFBRSGlYaUsz?=
 =?utf-8?B?TkJOWTFndjBuVWd0UEozckxYb1FieWpLOWtvcGJjL2RXQXAzaUoydTVGZEJo?=
 =?utf-8?B?YVd2TXhvRG5QcG0wQ0ZTMWd3WC80Y2xhVVJXTXpDWTVsOFRCSUEyM0lhYTBo?=
 =?utf-8?B?OW1rc05uQkRncDFqY3Z1VW8vVnBmRG4yTXowUDV4RThvUVM2endBS3FNVnBE?=
 =?utf-8?B?Rkd0REpSb2NJeC9ObmtiQzNxWWE2MlhhRVR3MmFPeGMwYXBKeTZzb0pRSy9m?=
 =?utf-8?B?WkFpa2o0RUJJVnNBNVdCV2w1a0ZxWTRGWnVEb283UGYwSGRUcXMxVm5MVXhy?=
 =?utf-8?B?amh3YUJhcTdsaUw2VnUvOGxweFQzclVnN1A2WXFUVyt3WUpsWnRuOXRZWG12?=
 =?utf-8?B?ZTFFYXZBWjc0VE12Mk5ycENQRXRoUFhxbVdnVHBwTjZJLzBTWno4MUVITVZS?=
 =?utf-8?B?MS96OGFYcWhTZUpNT2VxbkhsRFh6VmI2T3IwYkJLSUI2L09HOEtkRlU2ZnR6?=
 =?utf-8?B?Kyt4RnNNeWRVUncxTmVkTkVFRmJ6Z2R2clo1dEpZMjRSRFlEdjFheGxtSER3?=
 =?utf-8?B?dXNmUDNINC9aY0RKVzh1MytJZUtSSncvdjgybnFKOTkxdXB5Y2RrN2FzaVlp?=
 =?utf-8?B?Vm5aeWNyVGsvYk1vVTNGeDVzeERJSkplMXhoSEFSRHVzSGIwekFHTmJVcWVy?=
 =?utf-8?B?dEZCUktnRkpRRUtua3J5Mmt5dHVCU2JuczM4dzlKS2NpdW5ET1dkaG5PQmh4?=
 =?utf-8?B?Z0Y2V1QwVFNxa3hDanEyZm5uRHBVakJvNUxPcW54UEtkd3JUVTdEMjVHZUxU?=
 =?utf-8?B?bitvVUZuOHJ0MFNPYlBDVUxEeWJpNkJSZjBPRUl1R1BNeXNFWFFNcTVDbVpt?=
 =?utf-8?B?VGFsQUpsOGJqQlFDV0FHaUYxenZheG1USDlZNlVQdnQxTFZLMHVhTDc2REpD?=
 =?utf-8?B?ampjdHEwUW5nMGFzNHlPb2VyZllkOHY4bi9OSHVqVzV1MVp2RDg4M2JsWE9F?=
 =?utf-8?B?ZmFiT05IQks3V3BHRUw5aFBKNXNnT2lxRzc4UFgzV211c1dWQWFlNSs3Y2tZ?=
 =?utf-8?B?MFNEeG9DNStLb3kvN0hVaGlnaW5UOXdSZm9JeG1UZis0dVRiTWFmcjlWYU1q?=
 =?utf-8?B?MmlaL3B6N3dHUjliRUVWRU5aSjgxZjNLZS9weFZNeHE2MHZobkozUEZpYWJs?=
 =?utf-8?B?ZkpMeGpEWU9yejJiZ2FhQ3VvaUhEc3ZCNnNyU3plUTNLeWEzMFd0Z3ZwYlQ1?=
 =?utf-8?B?SFBRUWljb0poYXRGRnRYdkVwWUtRK2ZOMTVtRDIrRlJqdXFqME9CYjhWY3hh?=
 =?utf-8?B?ejR2RCtOMDBTWmZTaFliRmtQcjU1dndlWGZORE1VTCtkcG5PQVAyMWxXRkth?=
 =?utf-8?B?c2xLQ1V0S0VVWC9acHVXSytydSt4NlByNjJ2eDJnTnczT2xjUm5GbGNuTjBZ?=
 =?utf-8?B?NXNkWXRMcTIzVEQrbEZKWjJQSFg2NlV3eGE0Nk5pa0NKSUxldGNpRzRwRktY?=
 =?utf-8?B?ZXVwM08raHpVWkhNWkNqeSsvbzErMmtEK2Q1bk96eTZrcmZ1MTBPYkZxTDJR?=
 =?utf-8?B?Y2c9PQ==?=
X-OriginatorOrg: polito.it
X-MS-Exchange-CrossTenant-Network-Message-Id: c25e8b22-58ab-4c29-9374-08dc48ce598c
X-MS-Exchange-CrossTenant-AuthSource: AS2PR05MB9840.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2024 11:10:28.4568
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 2a05ac92-2049-4a26-9b34-897763efc8e2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qzDSgbjFuEJGIiHlKEE99iR/y71pSxpZWhdPL0UBqpIWmtOAMqIx4NNpmDv1eA3dQqXXwO8JTLI9peOZ1xqzNA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR05MB9664

On 18/03/24 14:05, Mimi Zohar wrote:
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
>>
>> As example, in the case a TPM chip is present and sha256 is the only
>> configured PCR bank, the listing of the security/ima directory is the
>> following:
>>
>> lr--r--r-- [...] ascii_runtime_measurements -> ascii_runtime_measurements_sha1
>> -r--r----- [...] ascii_runtime_measurements_sha1
>> -r--r----- [...] ascii_runtime_measurements_sha256
>> lr--r--r-- [...] binary_runtime_measurements ->
>> binary_runtime_measurements_sha1
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
>>  - Added create_measurements_list_files function for measurements files
>> creation.
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
>> diff --git a/security/integrity/ima/ima_crypto.c
>> b/security/integrity/ima/ima_crypto.c
>> index 51ad29940f05..d42ea0d350a1 100644
>> --- a/security/integrity/ima/ima_crypto.c
>> +++ b/security/integrity/ima/ima_crypto.c
>> @@ -57,11 +57,6 @@ MODULE_PARM_DESC(ahash_bufsize, "Maximum ahash buffer
>> size");
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
>> @@ -116,9 +116,13 @@ void ima_putc(struct seq_file *m, void *data, int
>> datalen)
>>  		seq_putc(m, *(char *)data++);
>>  }
>>  
>> +static struct dentry **ima_ascii_measurements_files;
>> +static struct dentry **ima_binary_measurements_files;
> 
> The variable naming isn't quite right.  It's defined as a 'struct dentry', but
> the name is '*_files'.  Why not just name the variables 'ima_{ascii, binary}
> _measurements'?

Hi Mimi,

thank you for pointing that out. What do you think of naming them 'ima_{ascii,
binary}_securityfs_measurement_lists', to have also coherence with the names of
the new functions defined.

> Variables that shouldn't change after '__init' should be annotated as
> __ro_after_init;

Thanks we will fix it.

>> +static int ima_measurements_files_count;
> 
> Removing '_files', in this case, from the variable name could be confused with
> the number of measurements.  Perhaps rename the variable to
> ima_measurement_list_count or ima_securityfs_measurement_list_count.

I think that 'ima_securityfs_measurement_list_count' is better, just to point
out that is the number of entries in the securityfs.

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
>>  
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
>> @@ -220,7 +241,24 @@ static int ima_ascii_measurements_show(struct seq_file
>> *m, void *v)
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
>> @@ -233,8 +271,8 @@ static int ima_ascii_measurements_show(struct seq_file *m,
>> void *v)
>>  	/* 1st: PCR used (config option) */
>>  	seq_printf(m, "%2d ", e->pcr);
>>  
>> -	/* 2nd: SHA1 template hash */
>> -	ima_print_digest(m, e->digests[ima_sha1_idx].digest, TPM_DIGEST_SIZE);
>> +	/* 2nd: template hash */
>> +	ima_print_digest(m, e->digests[algo_idx].digest,
>> hash_digest_size[algo]);
>>  
>>  	/* 3th:  template name */
>>  	seq_printf(m, " %s", template_name);
>> @@ -379,6 +417,71 @@ static const struct seq_operations ima_policy_seqops = {
>>  };
>>  #endif
>>  
>> +static void remove_measurements_list_files(struct dentry **files)
> 
> And remove '_files' from the function name.  Perhaps rename it
> remove_measurement_lists or remove_securityfs_measurement_lists.
> 
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
> 
> And remove '_files' from the function name.  Perhaps rename it to
> create_measurement_lists or create_securityfs_measurement_lists.

I think that keeping this structure for the names
'remove_securityfs_measurement_lists' and 'create_securityfs_measurement_lists'
makes sense.

>> +{
>> +	int i;
>> +	u16 algo;
>> +	char file_name[NAME_MAX+1];
>> +	struct dentry *dfile;
> 
> Use 'dentry', if needed.>
>> +	enum hash_algo sha1_algo_idx = -1;
>> +
>> +	ima_measurements_files_count = NR_BANKS(ima_tpm_chip);
>> +
>> +	if (ima_sha1_idx >= NR_BANKS(ima_tpm_chip))
>> +		ima_measurements_files_count++;
>> +
>> +	ima_ascii_measurements_files = kcalloc(ima_measurements_files_count,
>> +						sizeof(struct dentry *),
>> GFP_KERNEL);
>> +	if (!ima_ascii_measurements_files)
>> +		return -ENOMEM;
>> +
>> +	ima_binary_measurements_files = kcalloc(ima_measurements_files_count,
>> +						sizeof(struct dentry *),
>> GFP_KERNEL);
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
> 
> The new functions should be annotated with '__init'  as well.

Yes you are right, we will add it.

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
> 
> Please use scripts/checkpatch.pl to check formatting.

Yes thank you, we will fix the format.

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
> 
> And here ...
> 
> thanks,

Thanks to you for your valuable feedback.

Enrico

> Mimi
> 
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
>>  	securityfs_remove(ima_symlink);
>>  	securityfs_remove(ima_dir);
>>
>> base-commit: 88035e5694a86a7167d490bb95e9df97a9bb162b 

