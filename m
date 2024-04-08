Return-Path: <linux-integrity+bounces-2028-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF07D89C8A1
	for <lists+linux-integrity@lfdr.de>; Mon,  8 Apr 2024 17:44:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48177280DCA
	for <lists+linux-integrity@lfdr.de>; Mon,  8 Apr 2024 15:44:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFE151411E2;
	Mon,  8 Apr 2024 15:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=polito.it header.i=@polito.it header.b="Mv+jr3Lx"
X-Original-To: linux-integrity@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2136.outbound.protection.outlook.com [40.107.20.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C23812561F
	for <linux-integrity@vger.kernel.org>; Mon,  8 Apr 2024 15:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.136
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712591042; cv=fail; b=P76N/LLd9XXEdaB7ngHQo4+te2jixslAZlGpHXyp1vJ5M8PKtVA0a/OCQSIQj2wvpsDwhskiykhA2VC6Yo09ypGIwUhXUm6+FDOf3XgQVBDyfefW4i16erTxvIKueYQNckeBO0v/heaAfE50XKBwletJ29E9tyvmu8D1t2aK0zU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712591042; c=relaxed/simple;
	bh=GksgII5/zw8+pBy2vc4cH99IKmeflP1zO7jfelnXCy4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=gq078iMps6PMXJqcLCBxi+zULDYge0ZLqHVPUEI0CPTTkZJMzAnyOCKjxv9MM1irSP/RZCo3W32qRn0o1JDPZ5wbmhqWeYVYpQWoJx0hHmoMu2Lc8CANQkpKhrEx3Em5dEw7m6bhPHQPzqdsQM/S6UW0U16lNHO0fhl4HamXtnc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=polito.it; spf=pass smtp.mailfrom=polito.it; dkim=pass (1024-bit key) header.d=polito.it header.i=@polito.it header.b=Mv+jr3Lx; arc=fail smtp.client-ip=40.107.20.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=polito.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=polito.it
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B+ih3GzeboUVnW/n9qNd8UfKqqcMHUY8E1MtlCrUH/UnWtf7bMggT1frs4oY1DVX1/I34O8hLgMLv8SmiZRLNmFc/xv9IJz6qy/USMKamDhkyhabQO6AWCVuk1B+gGE1zzvG90TQlsVdRTwRrycdACfmwKTkuDivYs0nqBT9KXRTUDkN5B9eHyEqHOoSTQzVzXkJYI6HX48bBJ2MpazH1eEzEMbwD2pXAZa2yI5HXmLSnPl3dvDMkovCViaRE7bLUuaUXMXMqOhDOInUgZvcgzPQEsilzeYQI81xKd33+Naj5qku5XyBjjNXiSpmQbWucWxAMzNdhzf3EF2DOEWqVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n+f9LboS89PnL7NFcW+2hocZDy9/Z78uoKL1tFKnIHU=;
 b=cLp+XpsSpvGVJEGabYzvCVZ9/Rx0i+GrnUaC0JBpmx3byKpzG5RaJzMcluEjqJHnYJR64925qENNXDb8ofhoWZq1qTi4uiY0we4IVnHiZab+ccK0Qn4rlXsEcJ/JHDvh/QVPb7eXjYcPFiMq4OBr1UPhlglYu0jAeI/UUyE/r5wHzv/oqgSC9BXzRDOCQO4wNT90D/AL0iMRUDOtJaoYddesAZQEiPDxVW/44VBBFs/yifLDHojXW69Saf7L7939Ie8ZuJRw755iJdnWGu0wvtGOE8pClkorcv6xsDNvlU/2gpQAip4rrqRHREbCbWQxsuv2CqGxYvvxeFgSAC+5nQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=polito.it; dmarc=pass action=none header.from=polito.it;
 dkim=pass header.d=polito.it; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=polito.it;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n+f9LboS89PnL7NFcW+2hocZDy9/Z78uoKL1tFKnIHU=;
 b=Mv+jr3Lx1hHfVFcBTXkuOAOt6ENZIK8s8I0KuIASxaBYo2HTiLsBNKsiGqVUle/z8lD7n/fmATHd5mgpLAhfsgkB92HlIcWpn0VV/oakhe+Ov3gE0tkQHWotRhy2aubWXOO7ksHqB0sKKM3O7tULYjPbjpFqUV7ff/+uWMj2ue4=
Received: from AS2PR05MB9840.eurprd05.prod.outlook.com (2603:10a6:20b:5f5::20)
 by DB9PR05MB8377.eurprd05.prod.outlook.com (2603:10a6:10:29c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Mon, 8 Apr
 2024 15:43:55 +0000
Received: from AS2PR05MB9840.eurprd05.prod.outlook.com
 ([fe80::87c7:ebd:309f:8e5]) by AS2PR05MB9840.eurprd05.prod.outlook.com
 ([fe80::87c7:ebd:309f:8e5%5]) with mapi id 15.20.7409.042; Mon, 8 Apr 2024
 15:43:55 +0000
Message-ID: <eb69441f-08aa-40b2-a667-437367a83c2a@polito.it>
Date: Mon, 8 Apr 2024 17:43:54 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] ima: add crypto agility support for template-hash
 algorithm
To: Roberto Sassu <roberto.sassu@huaweicloud.com>,
 linux-integrity@vger.kernel.org, zohar@linux.ibm.com,
 dmitry.kasatkin@gmail.com
Cc: roberto.sassu@huawei.com, Silvia Sisinni <silvia.sisinni@polito.it>
References: <20240408111727.404486-1-enrico.bravi@polito.it>
 <b82cceaa6505f75acd7c1702dfc4a70406a0a9d7.camel@huaweicloud.com>
Content-Language: en-US, it
From: Enrico Bravi <enrico.bravi@polito.it>
In-Reply-To: <b82cceaa6505f75acd7c1702dfc4a70406a0a9d7.camel@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MI0P293CA0012.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:44::20) To AS2PR05MB9840.eurprd05.prod.outlook.com
 (2603:10a6:20b:5f5::20)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS2PR05MB9840:EE_|DB9PR05MB8377:EE_
X-politoEOL-CGPAlias: 1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	HkaWUuGRa1VIrobcAMVVCA39a/jzvRQ2vPoNumfHllS71WC8V+hosfEuCjdKahu/8A6uoKhVDe1PsWPnjeGsexPrmH4uAbyA9samOHnPZ9X9HKFoTONlOMEYus4F69JawsKJ+cwwOkdYg8G0pWDyLrsb9dxkio3BKcJ6Q5ZUJJ/Yk4PnMavRxmpTWYC3orWQBp+DFRjz0R6VeUvMfaSXrOneqLP2SxcaBwqtpI0CY1RIbrFW82lfECGcpMNHtuxq3/1gmB+sp68Antkz0YxU7JtZon9rxim9S+aCRQyNzZEXuz45Ae/EVTJMWb94sT0u8fjy7k0DJmHBDF3ehtzQ7W6ZVmWmtZSoVNfH7eYmf5EFCQzUhax2AKESKOOvPQ5di9JJ5gKcoUjU/h/vCwrk2HbsOV2PKgHA2K7NMoV9jOoaq8uXgvAspmmyOsQ8yOITPeKlw0Z4T1vKY2/UDhgSCQIROJjjl2fa+MQ22+ymax8TWDAlbN5gCljx91iThhWZU3qAuGzZf/VKj15lAfwfyprcL6TjgtJ1yEVge+NV2gpra+6gKG3lOkfZ09WEzQ1idKmAI7qmCsWNMPTm2C3O0u/MSY2fhAKhnRYSN85ZgQBNIEIcXbxgKNDPzmcsj2zIR86lSpWL/PGV0ickrCGFgVaBuPoIPGvkHb/xBxoiLF4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS2PR05MB9840.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RlpGYW1XMDB0OGFnOEQ1MmxCeGVOTENEUys1YlJna0d3MDc2U1pKVTNMblBs?=
 =?utf-8?B?ejFQZU9tVzcza1NUSkxwNFZ1Y1FSazRtcUJPZjdhUG56UVJEQWFhVzcyWDRW?=
 =?utf-8?B?bGZuN3ZGN29uQ0l2M2FSdUFuMUxZc1ZsMDl0ZUJyU2FGeHBHbG5KVCtITU1S?=
 =?utf-8?B?UDRwMUNVSzhEelYrYjBlZlJFeDBVY2Q2SUJYU2FXRnV6enZNRldqSFRlY05z?=
 =?utf-8?B?K21ZajlDcUJMdzR4M0ZXNjFXb3FzZHE1UnlWYjFkaFVjYTczZmJIeUhtU0Rn?=
 =?utf-8?B?MlBsdlpYcThDWWR5eEMxb2ppR0czWlFyYm4wcnUzeDFqZmtDZ3lNK2RqMzlJ?=
 =?utf-8?B?eC9CRFJLV0tYNVMzQ1dXM0dkcVhNZFFnWVYwUzBXcFhnYmx2ajg5OHF1dW9F?=
 =?utf-8?B?VEZDeVNVN05HTkZ5UXkrbU43NTM5TFlKZGtwS1RJNGtsbzRNYzIvcUlFVkcr?=
 =?utf-8?B?SytvREt1MERCVGVvUGhvc0djSlFwakp5U21aK3FiU1VqLysyRHlaQzlMT0h1?=
 =?utf-8?B?cTFOUGcxeDFvZnNQN0NUMDlxNUJsRGxJNTY5b1M0SkQ1dU83U3BqZjU0bXlq?=
 =?utf-8?B?ZUMvOWNwMWdKR2Rxc3p1OW9oQk9kRjA0QkVpM2pFQkl3K25jTnRqWlpJRFBB?=
 =?utf-8?B?aEVKQkxTbGR5Ym85OTlwWUZ5TEdBaGJXazRha2dPa0xSalR4U05CeHBMN3o1?=
 =?utf-8?B?NGJFUUQ1ZVpuNngySmxqZThJZU5tRTl1cmE3bnpVa2NuZmViQndYV3FPS1Zw?=
 =?utf-8?B?czllOEhMSnEwVzB6NjhiTFh3L2hiVFcybWpCSlNSQ2tiWkxvNmpqNGdHU1ZD?=
 =?utf-8?B?RlBCbktkNUYvOTRoemxYM0N3VitHUGdTUkZXNURhYWt3VHVvSCtJSXh3Y05V?=
 =?utf-8?B?OWJLZnpRK1hWbTNlOVJXSUdGTFovVmxURGR3QVVnSVRhVWE2ellDYXJhUzlP?=
 =?utf-8?B?NXo0Z3FGUGpUdU5pUWZXM1JmaS9JWk5JeHVwU0VOaE41WWdoaysveGpybXJa?=
 =?utf-8?B?b3RJNGhKL29JUWx0QkdOYjdnaTFkRkpHMkxqY0NhQU45bmxsem9CNVE4aElM?=
 =?utf-8?B?VXFIR0IxemU4ZStiSWM5U002ZUg5M1hqNForS2ZqT2NRdUx4bTNzUjdGMFk0?=
 =?utf-8?B?T1hPQWdNZG8vajQ2UlZkbU44dFZSQmNlcmtkRjhPZ0ZiVTJtT2NobUg1UXFh?=
 =?utf-8?B?RmRuVndodGlLUnhJK3l6a3kvN1ZDc0xTMFVvdWdkSkI3VzJrQUdBSFVoSWtq?=
 =?utf-8?B?ejJRVGo3REIvaUdDQUtubnB4ekJSa0VjampDOWRTd2trTlJDNHJzN2ZsUFZ4?=
 =?utf-8?B?QS96ek9OSFlRT1NESnd3NzZTU3M2Rll2N1BKdlR0KzVHRkM3a1RYTHhiaVo0?=
 =?utf-8?B?Z2l4bkljaGNKZ1A3Y0FLRHBZZ3ZxVHByUE5ZS2pjVEdhMzBCR3VqSE1ocHRn?=
 =?utf-8?B?WDFwb09tQ0cyYzZKdy9nckRVSlREaDRJU01OSGV6T2NWcU4vdzk4WXZJNUNK?=
 =?utf-8?B?cVhHcWdSdkpqMzJOTWhUUmdlTEkrRk9POWpZMmZFUkYvN1grVUdjd2NsRTJo?=
 =?utf-8?B?NFFwQUw4N3lkQXNReTJxODJTRmdULzR3VVIyMHNIWUU5bEFGLzhmZXp5My9H?=
 =?utf-8?B?c2NPQmJleG14Y1J5eUZ6RVZ4TlVReHZZcVl5Q0tBR2tkM0x5WVdoQzcveFVz?=
 =?utf-8?B?SWw5WWRHREVqM1ZGcG5iNm1uVFFpYTF3S2pUN0ZrL1BqOEFPUjV5RjFCb0ds?=
 =?utf-8?B?R21xNExvSzc5cE5hMENPa1htdUdZbFU0TURqb3JtSEdPazBUU0NsWlN3ZnZV?=
 =?utf-8?B?Qm1JdzJxdjA3Y29TQUEwZTNIVnQyRzF6M20wMXQ2K3RyZHMxM2ZTZVJ6N0Vo?=
 =?utf-8?B?b0FJZjk4RVNrWEsyYUtlOEl4MVcyeENVUFZuMCtva1pDRllYS0hiL3NFMmhY?=
 =?utf-8?B?dW5RV0RQbiszYVQ0ZGhwSUpsa1JORGRyWlo5Y2JFRlEwNTBNdkloYUN3UnIr?=
 =?utf-8?B?M3FXN2NJNDdydTRpeWtoSVc0clJpV1Z2UDlPelp4YzBOMElvclk1Y0g5VnBj?=
 =?utf-8?B?cS9Gd0JqeDJRekFvcXpsWUdRVXBGM3J0K293eVF5VTFLK1RoemJSV2d0blJ5?=
 =?utf-8?Q?lDFWQOumGwkw3NMbYvPCaebDt?=
X-OriginatorOrg: polito.it
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b1b6649-a4b8-4f8f-b76c-08dc57e2b2ed
X-MS-Exchange-CrossTenant-AuthSource: AS2PR05MB9840.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2024 15:43:55.7216
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 2a05ac92-2049-4a26-9b34-897763efc8e2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sUVG4RaLVFH9t+7QyZv8MXlWWMiMiB6K6EiuOUZ1WxVim1OZdFNtPkSF5V6F66BQH76nmjjKdnO/gWiFHNj+fw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR05MB8377

On 08/04/24 13:35, Roberto Sassu wrote:
> On Mon, 2024-04-08 at 13:17 +0200, Enrico Bravi wrote:
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
>> the sha1 bank is not configured in the TPM.
>>
>> As example, in the case a TPM chip is present and sha256 is the only
>> configured PCR bank, the listing of the securityfs ima directory is the
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
> 
> Reviewed-by: Roberto Sassu <roberto.sassu@huawei.com>

Thank you Roberto for the tag!

I noticed an error in the number of changed lines which produces a format error
when applying the patch. I will send shortly a new version which fixes it.

I'm so sorry about that.

Enrico

> Thanks
> 
> Roberto
> 
>> ---
>>
>> v5:
>>  - Added lookup_algo_by_dentry() function to select the hash algo during
>>    measurements dump. (suggested by Roberto)
>>  - Renamed remove_measurements_list_files() to
>>    remove_securityfs_measurement_lists() and create_measurements_list_files()
>>    to create_securityfs_measurement_lists(), and marked both as __init.
>>    (suggested by Mimi)
>>  - Renamed ima_ascii_measurements_files to ascii_securityfs_measurement_lists,
>>    ima_binary_measurements_files to binary_securityfs_measurement_lists and
>>    ima_measurements_files_count to securityfs_measurement_list_count, and
>>    marked them as __ro_after_init. (suggested by Mimi)
>>  - Added missing NULL assignment for file.file in ima_dump_measurement_list()
>>    during kexec.
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
>> ---
>>  security/integrity/ima/ima.h        |  10 +++
>>  security/integrity/ima/ima_crypto.c |   7 +-
>>  security/integrity/ima/ima_fs.c     | 129 +++++++++++++++++++++++++---
>>  security/integrity/ima/ima_kexec.c  |   1 +
>>  4 files changed, 129 insertions(+), 18 deletions(-)
>>
>> diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
>> index c29db699c996..e5e45cce4d0e 100644
>> --- a/security/integrity/ima/ima.h
>> +++ b/security/integrity/ima/ima.h
>> @@ -54,6 +54,16 @@ extern int ima_hash_algo __ro_after_init;
>>  extern int ima_sha1_idx __ro_after_init;
>>  extern int ima_hash_algo_idx __ro_after_init;
>>  extern int ima_extra_slots __ro_after_init;
>> +
>> +/* IMA hash algorithm description */
>> +struct ima_algo_desc {
>> +	struct crypto_shash *tfm;
>> +	enum hash_algo algo;
>> +};
>> +
>> +/* hash algorithms configured in IMA */
>> +extern struct ima_algo_desc *ima_algo_array;
>> +
>>  extern int ima_appraise;
>>  extern struct tpm_chip *ima_tpm_chip;
>>  extern const char boot_aggregate_name[];
>> diff --git a/security/integrity/ima/ima_crypto.c b/security/integrity/ima/ima_crypto.c
>> index f3738b2c8bcd..3606931fc525 100644
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
>> index cd1683dad3bf..d0c8f7daa2e2 100644
>> --- a/security/integrity/ima/ima_fs.c
>> +++ b/security/integrity/ima/ima_fs.c
>> @@ -116,9 +116,30 @@ void ima_putc(struct seq_file *m, void *data, int datalen)
>>  		seq_putc(m, *(char *)data++);
>>  }
>>  
>> +static struct dentry **ascii_securityfs_measurement_lists __ro_after_init;
>> +static struct dentry **binary_securityfs_measurement_lists __ro_after_init;
>> +static int securityfs_measurement_list_count __ro_after_init;
>> +
>> +static void lookup_algo_by_dentry(int *algo_idx, enum hash_algo *algo,
>> +				  struct seq_file *m, struct dentry **dentry_list)
>> +{
>> +	struct dentry *dentry;
>> +	int i;
>> +
>> +	dentry = file_dentry(m->file);
>> +
>> +	for (i = 0; i < securityfs_measurement_list_count; i++) {
>> +		if (dentry == dentry_list[i]) {
>> +			*algo_idx = i;
>> +			*algo = ima_algo_array[i].algo;
>> +			break;
>> +		}
>> +	}
>> +}
>> +
>>  /* print format:
>>   *       32bit-le=pcr#
>> - *       char[20]=template digest
>> + *       char[n]=template digest
>>   *       32bit-le=template name size
>>   *       char[n]=template name
>>   *       [eventdata length]
>> @@ -132,7 +153,14 @@ int ima_measurements_show(struct seq_file *m, void *v)
>>  	char *template_name;
>>  	u32 pcr, namelen, template_data_len; /* temporary fields */
>>  	bool is_ima_template = false;
>> -	int i;
>> +	int i, algo_idx;
>> +	enum hash_algo algo;
>> +
>> +	algo_idx = ima_sha1_idx;
>> +	algo = HASH_ALGO_SHA1;
>> +
>> +	if (m->file != NULL)
>> +		lookup_algo_by_dentry(&algo_idx, &algo, m,
>> +				      binary_securityfs_measurement_lists);
>>  
>>  	/* get entry */
>>  	e = qe->entry;
>> @@ -151,7 +179,7 @@ int ima_measurements_show(struct seq_file *m, void *v)
>>  	ima_putc(m, &pcr, sizeof(e->pcr));
>>  
>>  	/* 2nd: template digest */
>> -	ima_putc(m, e->digests[ima_sha1_idx].digest, TPM_DIGEST_SIZE);
>> +	ima_putc(m, e->digests[algo_idx].digest, hash_digest_size[algo]);
>>  
>>  	/* 3rd: template name size */
>>  	namelen = !ima_canonical_fmt ? strlen(template_name) :
>> @@ -220,7 +248,14 @@ static int ima_ascii_measurements_show(struct seq_file *m, void *v)
>>  	struct ima_queue_entry *qe = v;
>>  	struct ima_template_entry *e;
>>  	char *template_name;
>> -	int i;
>> +	int i, algo_idx;
>> +	enum hash_algo algo;
>> +
>> +	algo_idx = ima_sha1_idx;
>> +	algo = HASH_ALGO_SHA1;
>> +
>> +	if (m->file != NULL)
>> +		lookup_algo_by_dentry(&algo_idx, &algo, m,
>> +				      ascii_securityfs_measurement_lists);
>>  
>>  	/* get entry */
>>  	e = qe->entry;
>> @@ -233,8 +268,8 @@ static int ima_ascii_measurements_show(struct seq_file *m, void *v)
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
>> @@ -379,6 +414,69 @@ static const struct seq_operations ima_policy_seqops = {
>>  };
>>  #endif
>>  
>> +static void __init remove_securityfs_measurement_lists(struct dentry **dentry_list)
>> +{
>> +	int i;
>> +
>> +	if (dentry_list) {
>> +		for (i = 0; i < securityfs_measurement_list_count; i++)
>> +			securityfs_remove(dentry_list[i]);
>> +
>> +		kfree(dentry_list);
>> +	}
>> +
>> +	securityfs_measurement_list_count = 0;
>> +}
>> +
>> +static int __init create_securityfs_measurement_lists(void)
>> +{
>> +	int i;
>> +	u16 algo;
>> +	char file_name[NAME_MAX + 1];
>> +	struct dentry *dentry;
>> +
>> +	securityfs_measurement_list_count = NR_BANKS(ima_tpm_chip);
>> +
>> +	if (ima_sha1_idx >= NR_BANKS(ima_tpm_chip))
>> +		securityfs_measurement_list_count++;
>> +
>> +	ascii_securityfs_measurement_lists = kcalloc(securityfs_measurement_list_count,
>> +						     sizeof(struct dentry *), GFP_KERNEL);
>> +	if (!ascii_securityfs_measurement_lists)
>> +		return -ENOMEM;
>> +
>> +	binary_securityfs_measurement_lists = kcalloc(securityfs_measurement_list_count,
>> +						      sizeof(struct dentry *), GFP_KERNEL);
>> +	if (!binary_securityfs_measurement_lists)
>> +		return -ENOMEM;
>> +
>> +	for (i = 0; i < securityfs_measurement_list_count; i++) {
>> +		algo = ima_algo_array[i].algo;
>> +
>> +		sprintf(file_name, "ascii_runtime_measurements_%s",
>> +			hash_algo_name[algo]);
>> +		dentry = securityfs_create_file(file_name, S_IRUSR | S_IRGRP,
>> +						ima_dir, NULL,
>> +						&ima_ascii_measurements_ops);
>> +		if (IS_ERR(dentry))
>> +			return PTR_ERR(dentry);
>> +
>> +		ascii_securityfs_measurement_lists[i] = dentry;
>> +
>> +		sprintf(file_name, "binary_runtime_measurements_%s",
>> +			hash_algo_name[algo]);
>> +		dentry = securityfs_create_file(file_name, S_IRUSR | S_IRGRP,
>> +						ima_dir, NULL,
>> +						&ima_measurements_ops);
>> +		if (IS_ERR(dentry))
>> +			return PTR_ERR(dentry);
>> +
>> +		binary_securityfs_measurement_lists[i] = dentry;
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>>  /*
>>   * ima_open_policy: sequentialize access to the policy file
>>   */
>> @@ -454,6 +552,9 @@ int __init ima_fs_init(void)
>>  {
>>  	int ret;
>>  
>> +	ascii_securityfs_measurement_lists = NULL;
>> +	binary_securityfs_measurement_lists = NULL;
>> +
>>  	ima_dir = securityfs_create_dir("ima", integrity_dir);
>>  	if (IS_ERR(ima_dir))
>>  		return PTR_ERR(ima_dir);
>> @@ -465,19 +566,21 @@ int __init ima_fs_init(void)
>>  		goto out;
>>  	}
>>  
>> +	ret = create_securityfs_measurement_lists();
>> +	if (ret != 0)
>> +		goto out;
>> +
>>  	binary_runtime_measurements =
>> -	    securityfs_create_file("binary_runtime_measurements",
>> -				   S_IRUSR | S_IRGRP, ima_dir, NULL,
>> -				   &ima_measurements_ops);
>> +		securityfs_create_symlink("binary_runtime_measurements", ima_dir,
>> +					  "binary_runtime_measurements_sha1", NULL);
>>  	if (IS_ERR(binary_runtime_measurements)) {
>>  		ret = PTR_ERR(binary_runtime_measurements);
>>  		goto out;
>>  	}
>>  
>>  	ascii_runtime_measurements =
>> -	    securityfs_create_file("ascii_runtime_measurements",
>> -				   S_IRUSR | S_IRGRP, ima_dir, NULL,
>> -				   &ima_ascii_measurements_ops);
>> +		securityfs_create_symlink("ascii_runtime_measurements", ima_dir,
>> +					  "ascii_runtime_measurements_sha1", NULL);
>>  	if (IS_ERR(ascii_runtime_measurements)) {
>>  		ret = PTR_ERR(ascii_runtime_measurements);
>>  		goto out;
>> @@ -515,6 +618,8 @@ int __init ima_fs_init(void)
>>  	securityfs_remove(runtime_measurements_count);
>>  	securityfs_remove(ascii_runtime_measurements);
>>  	securityfs_remove(binary_runtime_measurements);
>> +	remove_securityfs_measurement_lists(ascii_securityfs_measurement_lists);
>> +	remove_securityfs_measurement_lists(binary_securityfs_measurement_lists);
>>  	securityfs_remove(ima_symlink);
>>  	securityfs_remove(ima_dir);
>>  
>> diff --git a/security/integrity/ima/ima_kexec.c b/security/integrity/ima/ima_kexec.c
>> index dadc1d138118..52e00332defe 100644
>> --- a/security/integrity/ima/ima_kexec.c
>> +++ b/security/integrity/ima/ima_kexec.c
>> @@ -30,6 +30,7 @@ static int ima_dump_measurement_list(unsigned long *buffer_size, void **buffer,
>>  		goto out;
>>  	}
>>  
>> +	file.file = NULL;
>>  	file.size = segment_size;
>>  	file.read_pos = 0;
>>  	file.count = sizeof(khdr);	/* reserved space */
>>
>> base-commit: e8f897f4afef0031fe618a8e94127a0934896aba
> 


