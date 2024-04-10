Return-Path: <linux-integrity+bounces-2044-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD13B89EDC1
	for <lists+linux-integrity@lfdr.de>; Wed, 10 Apr 2024 10:38:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62E8228397D
	for <lists+linux-integrity@lfdr.de>; Wed, 10 Apr 2024 08:37:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B524144312;
	Wed, 10 Apr 2024 08:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=polito.it header.i=@polito.it header.b="OqAd4lrj"
X-Original-To: linux-integrity@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2109.outbound.protection.outlook.com [40.107.22.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CB1613E3F3
	for <linux-integrity@vger.kernel.org>; Wed, 10 Apr 2024 08:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.109
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712738276; cv=fail; b=efDo1dyYzxOBFBxEcUpGckkM3J9FentLNQz6USu25lyta+lq0oUuqx4sg4MKCK7VffTWqJHZyyh3+g9QpYN2eLgbUmQ9KEsqKIyF96lH7e4Gk1PeYPyfZ43slCzk3NtQjXu3kSsUTinsocAjc2q/hvckxd81Dn2ei5ZRqQmHUBY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712738276; c=relaxed/simple;
	bh=s5KWNhKtCiGVomz4+DkIxhGfSPgchLvuc5g/mEU3a0g=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ktUOzAR5XhiPgPmILcTDtJzmsRB3gPuejYpHBelFW8wmfZNbBHEpyeCXXOLrwGvxqD/R4UxD7WiuJpWMmOjrAZUnjFVu3ldNZ5UKch9WsySv+05Xyex6nAkwGoOPIVlG8AfLsRsKlzr9FCHwysRXDWb0j87RbrTe3MLARdQ3hqQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=polito.it; spf=pass smtp.mailfrom=polito.it; dkim=pass (1024-bit key) header.d=polito.it header.i=@polito.it header.b=OqAd4lrj; arc=fail smtp.client-ip=40.107.22.109
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=polito.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=polito.it
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mZ4htaG/1hpA23tca3CAYZF6JcOOPPhqhtvRPNKOwaB3TmoNTae8CV0/+avc9bUOzwPK52Xmx8c+vKMSiilXlmjZfDb9WQY+LhgLjEJiW11w3JuoRRXglyRSo3cROhF6P3+wGHf4/AyhAfNXtxjS3bdYRsmNtfwFYwJfKCZZyaM4ffmEVP3Q4IXdQvag7tYtXQYW1imT0zDgEbrVwt21C8lsFPH9IHzVZ7BNy0w8xmiiU1lslUsrfLYQ5GmSgelJkRca7ZjkENOaJSlb8coWAfTbKBh1kdGjbYHngSDdBffjOma2om1KF9AOjuzvqQW6gg3LMZ2aJbN5I+7CPI6a7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ieA8BNDKXKXLq2oNP8bpqZgPBEkUtaHYlA2oik9IrPM=;
 b=Lps7wkaTcAMcgyjfj1rWN/JIKONI8cwxB3h/0Uab19pHNbEW88uqZIDFaLvTkbau87aMDXMzIqdM915ityQR5pz1l9TCWfeOYKeYRZYCWHR777nqa6POkwKCw49RmNT7nOh+HRGq5a8O/BVd7yu8p+mzRlGgm+NtXT0TleX+j2FInhW3Kkj1t99FSziineGYqT/eAd2yy0g35frM51rwGWDFqyiiU0wdTQX5tb0N7wxs7RF1btWSqkuX8rX++vwsQ0ybz9/HApbE4/fOgLcKRwJ4gWAL87I0nLjQwaYVNxu8DpZouNKNAGpdFR8LS9uPL5Xo6OBKAWbBh9knXilKOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=polito.it; dmarc=pass action=none header.from=polito.it;
 dkim=pass header.d=polito.it; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=polito.it;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ieA8BNDKXKXLq2oNP8bpqZgPBEkUtaHYlA2oik9IrPM=;
 b=OqAd4lrjKh4V9grYJTpkF3MBUf8AodAL9+dbBcrDIvAcK3b6y2Z0LQ0HL1Q2lIfBgrSw+Bmn4Vhj1SeTWXoax2ZtpOkQTRkKs4JQCQMmF2D0jdz+NCgU9hkFaKCY92J1T0ayE61hoIJBq6frzIU8kkDISK72iS1dfJM0Jb+MAt8=
Received: from AS2PR05MB9840.eurprd05.prod.outlook.com (2603:10a6:20b:5f5::20)
 by AM9PR05MB7779.eurprd05.prod.outlook.com (2603:10a6:20b:2c7::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Wed, 10 Apr
 2024 08:37:47 +0000
Received: from AS2PR05MB9840.eurprd05.prod.outlook.com
 ([fe80::87c7:ebd:309f:8e5]) by AS2PR05MB9840.eurprd05.prod.outlook.com
 ([fe80::87c7:ebd:309f:8e5%5]) with mapi id 15.20.7409.042; Wed, 10 Apr 2024
 08:37:47 +0000
Message-ID: <e2a10f8c-aa70-43c1-93b8-2e07430ab6a9@polito.it>
Date: Wed, 10 Apr 2024 10:37:45 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6] ima: add crypto agility support for template-hash
 algorithm
To: Mimi Zohar <zohar@linux.ibm.com>, linux-integrity@vger.kernel.org,
 dmitry.kasatkin@gmail.com
Cc: roberto.sassu@huawei.com, Silvia Sisinni <silvia.sisinni@polito.it>
References: <20240408212810.1043272-1-enrico.bravi@polito.it>
 <74f8f5fa75629c41455f28544ab8c430ebd9006a.camel@linux.ibm.com>
Content-Language: en-US, it
From: Enrico Bravi <enrico.bravi@polito.it>
In-Reply-To: <74f8f5fa75629c41455f28544ab8c430ebd9006a.camel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ZR0P278CA0080.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:22::13) To AS2PR05MB9840.eurprd05.prod.outlook.com
 (2603:10a6:20b:5f5::20)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS2PR05MB9840:EE_|AM9PR05MB7779:EE_
X-politoEOL-CGPAlias: 1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	iLxD3gA0pOVKGahIr/Eo9QHzTUUxdxaknHnzX4fzEcvvSBQwmhy6gk9kRE2WlOEzsjRoTnXAoOnKK4dCkQKpMLpih9pogpxAI6w/gNBxavqrVFs28KAUetCq8Fh/aMoMdH1Bs+w6MPjx40XXcWH6BhLky3cQXQbqeGMY4vYgI7L37QljZKmZVOi8Wbztpti7gtoynFx6RoisJLKOgUdSSwyAjjm3ORFLolwQQG6P575x2cnpFzRkjzLfiPU0/XIEA+ffg+WhXFWXhfozYaxs+GLmvZ6FbGrYR/etkhajfT4wmOSC7k/3KX6cYbsOUkOKjYiB1TKzkIg1b0Yvft9C/sxzO3XcL8S3G0yksrMblEp9k95c5TK3cfjaxCXNAz82y9jUn+FY3/GK5ZS7VhLbE6FhYSfCl6vGmfzrhy/2OZLE+fbKI9TuHh65Y6DdLw9E6RRPEoUs+juo+NW/kB3Ixi/djqy04QNNxls1n3xt7Tl9iWcKWyYEOT6DVjrAiWms0iJTUt+vB/rSvyPd3pDhhjYmb9kji6t1Mck8/ZHKhOMvMLqfDIkMOmG0uEtrFF88Pck7abAXNPMc1gn87wZpeLVdLHMHZAuqECmixvC0ivTAb5d/RrEAZsKXsqWiswgojHfGQr6zdSjLEJ3wuUM9/MLPYfiKzjJQ5IMkH5XHQwI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS2PR05MB9840.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Ny82ZHZTanpPM3NJcXJKSENPbm43RS91QWtRZWJUc2kvSG9ZcUNxemE2QmFu?=
 =?utf-8?B?VURZV3JiZGFWT2VIMTJjRldtS01nS2JHaHR6eHVhVTh6NGJSOUJ5bmtuR2pH?=
 =?utf-8?B?T2tJc1R6NHRVWUpnM0xCSXBYck9lYzRSWmE3clBnYTdsSGs0VG5yMVB5TUx3?=
 =?utf-8?B?SDhtUWxjcFh0Y0xOUWN2Z0pPNWhmRlFPWEJ3WkErMXVDa0cxRGhUdG1KZnRs?=
 =?utf-8?B?WHkyZE1UTlhkdDJMQXQzNzlUelREdUZzZ3piUmxNWm1QbzFYWVQxb2ZJdHBw?=
 =?utf-8?B?REdKc0oyREFML0RvVnlCZWR6VXB0QVZFSEkzdTBEZytmN0NPdW5FRE8weHpB?=
 =?utf-8?B?dkZIckExclFsbW51UFVQQ1p0L0Z2cGsxNi9sekwyTGJnZGIwSmh0dEtmR3hT?=
 =?utf-8?B?WFQrMytvRCtOYkdOMi9oRkVwdnRuZjlmaTNvT3Y0bk5hZjJHNWxMQmswbjhv?=
 =?utf-8?B?Mmp5SkFZMkVyOEtTMHVSWlhyRjFxQldhWlViUGN0eWl2c1JoZWdSVkJqdDdO?=
 =?utf-8?B?TDhnN1Z1QXRPMWViNVAycURJU1c2cWdlSExDVXppYVZWMnFiLzlDeGpYVkJv?=
 =?utf-8?B?WE0rbitCOUphTUZuazNIRlNpcGxSMm8zeEFhYzlBM2RsRE9YK0hNaUVrWkN6?=
 =?utf-8?B?cmxubW9sZFAzdlZZZ1VoU2h4VnpiZmNHNjdIWmRYb0xUNnh2b3lFbWdFaitD?=
 =?utf-8?B?RWZZelZ5bFpPVUh3MWRCbytpNCtNTjZVV25OSHVjT2RSU3FiWWI4cUhXdEpI?=
 =?utf-8?B?Q2xtT0Z1Y1R2WHFhcG9JSFRub2ozS05MRVBWbEFqNENRRE01bVdRUXVtTnVz?=
 =?utf-8?B?bTFTT2VqWjByUzZvMlpWVW5YdGVMc054dXpBOGdod0NJR3FyeVkzSDgrUUdU?=
 =?utf-8?B?c1U1TUhBSUZBdG1Edlg5dzRqUHBsREIwekVwR0ZNVGFnODBHUk91cE5hV0Ur?=
 =?utf-8?B?MGxlUTU1ZlJnYWJxN1hucTVmQzFpM3FvQnlib0NlcSsxa1dzeFZlazFhNHJI?=
 =?utf-8?B?ZC8za1hwWGVqN2Q2Z1g2T2NQcnJVNnUzS0I4ZGR0N1R2cnRmMDRhNUdLcGRH?=
 =?utf-8?B?VklrZHFsWmE4YXNvUVNzY0VXcldhelhVaG0yZ0dtU2pjWWkrckUxdlU0a2FS?=
 =?utf-8?B?N1NSek5EUkNGSXVQZTJnMWZ2UHBmKzA1Tm9heGVNQXNEVVhtN3VUR0t3aXlj?=
 =?utf-8?B?WGQrR0dOOTNXK2J4S1BrVmRZdnVZOS9IbXhHNWxPSll4OGp2ZzFpenhoYXhq?=
 =?utf-8?B?a2lQWHNoeHBpM0xjZFZNSDBvcmE0NWRQZjBHVHdScnp0ZnRvdmt4ZnlwMDMy?=
 =?utf-8?B?eGtBd0x5WVpMOUoxMEJ3OE1ic2ZTSUQ2VlUyZzdJY1FGdjg1c1lqWjBCZ2Nl?=
 =?utf-8?B?YkJzT05jOGNDR09UZlV6VVpNN24rUUhhT1pBV1F6Vnd1SG5qYzViSGEwc0FS?=
 =?utf-8?B?ZGF1NmpMVVNxWHk5SnB2dU1Qc2k3aVd6NmtRREU3U2hKZWJVZE5abUFEcFVY?=
 =?utf-8?B?c0RnN1NhdEkrUWdLRC9QZnUxcEVNZ2c5MkFQUDdpQllCNXRrQjBzdUFGNDBO?=
 =?utf-8?B?aTNVNEpGbUFGTWE1MWFLcitlSTFVRm9mMFpWbHh2M3FuK2Fva2dwWW9QQWht?=
 =?utf-8?B?aVNGQXRzUTZicDlZTFVTR3NLM29CMzJrYllOSk9UY0Z1dHVqWUV3TmQ3dnI1?=
 =?utf-8?B?Tk9Sd2l4bEVEUFl6bTNrWW1kZFM5ZGFVZ3NOM3NMcCtmbVhpYVRDakpOdk95?=
 =?utf-8?B?NHIwTnlxT2tRS3BUeDFOVmpwMURndVBGTUZZQk0rUlNoMkJvTnBsS05Gbmdw?=
 =?utf-8?B?dlNpK0prUXdSejZoMlJ5cGhkRUpLNEpZOWFCd3ZLeTdTSXVGT3hLY1ZZbXhk?=
 =?utf-8?B?ZzFOcDZ6Q2RaY0s1TmdZZU5XMWdkblZGRXloOEhCMFFjZTJPV1JTdkZ2eG9i?=
 =?utf-8?B?T1dhd2N5SWZBaWRZSCs5S0kreWMxeVl0NG1oTTI2L3RkVHF6cFhpeFppalhs?=
 =?utf-8?B?MXB5YlJJbmtTR21KU1NaZHF6RFk2TFR1QmVxTVA2TFVtcnR6aFIrRldNQnRR?=
 =?utf-8?B?NFU4QmtiOXdIdDFHYkU0bGFSQXdlS0VkUTJvTXk0aW5MdEkxZHBNV1l1QWk2?=
 =?utf-8?B?VXV0Z202NWc4VTYzbFczbWxkeEc1QU96VTdub2t0eS9hUUhva3c1V3FlUlAx?=
 =?utf-8?B?ZHc9PQ==?=
X-OriginatorOrg: polito.it
X-MS-Exchange-CrossTenant-Network-Message-Id: 78a62591-d589-487b-2f8d-08dc59397ff2
X-MS-Exchange-CrossTenant-AuthSource: AS2PR05MB9840.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2024 08:37:47.5240
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 2a05ac92-2049-4a26-9b34-897763efc8e2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iyESngH6XUitq2OlTuvSYpNVtSaclDimDj6uARTqCweq3xxQZ4hW7/SMr9CYry6zkyz1c37yvDpxqjD9k4z7rg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR05MB7779

On 09/04/24 14:43, Mimi Zohar wrote:
> Hi Enrico,
> 
> On Mon, 2024-04-08 at 23:28 +0200, Enrico Bravi wrote:
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
>> Reviewed-by: Roberto Sassu <roberto.sassu@huawei.com>
> 
> Much better. Just a few comments inline.
> 
>>
>> ---
>>
>> v6:
>>  - Fixed format error when applying the patch.
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
>>  security/integrity/ima/ima.h        |  10 +++
>>  security/integrity/ima/ima_crypto.c |   7 +-
>>  security/integrity/ima/ima_fs.c     | 131 +++++++++++++++++++++++++---
>>  security/integrity/ima/ima_kexec.c  |   1 +
>>  4 files changed, 131 insertions(+), 18 deletions(-)
>>
>> diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
>> index 11d7c0332207..72ac73ebc83e 100644
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
>> diff --git a/security/integrity/ima/ima_crypto.c
>> b/security/integrity/ima/ima_crypto.c
>> index f3738b2c8bcd..3606931fc525 100644
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
> 
> ima_algo_array should probably be defined as __ro_after_init, especially now
> that the scope is changing.

Hi Mimi,

yes you're right, thanks.

>>  
>>  static int __init ima_init_ima_crypto(void)
>>  {
>> diff --git a/security/integrity/ima/ima_fs.c b/security/integrity/ima/ima_fs.c
>> index cd1683dad3bf..7d9c2ef5b86c 100644
>> --- a/security/integrity/ima/ima_fs.c
>> +++ b/security/integrity/ima/ima_fs.c
>> @@ -116,9 +116,30 @@ void ima_putc(struct seq_file *m, void *data, int
>> datalen)
>>  		seq_putc(m, *(char *)data++);
>>  }
>>  
>> +static struct dentry **ascii_securityfs_measurement_lists __ro_after_init;
>> +static struct dentry **binary_securityfs_measurement_lists __ro_after_init;
>> +static int securityfs_measurement_list_count __ro_after_init;
>> +
>> +static void lookup_algo_by_dentry(int *algo_idx, enum hash_algo *algo,
>> +				  struct seq_file *m, struct dentry
>> **dentry_list)
> 
> Please rename the function without "_by_dentry". Consider naming the function
> lookup_measurement_list_algo().  Instead of dentry_list, consider naming the
> variable measurement_lists or just lists.
What do you think of lookup_template_data_hash_algo()?

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
>> @@ -132,7 +153,15 @@ int ima_measurements_show(struct seq_file *m, void *v)
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
>> @@ -151,7 +180,7 @@ int ima_measurements_show(struct seq_file *m, void *v)
>>  	ima_putc(m, &pcr, sizeof(e->pcr));
>>  
>>  	/* 2nd: template digest */
>> -	ima_putc(m, e->digests[ima_sha1_idx].digest, TPM_DIGEST_SIZE);
>> +	ima_putc(m, e->digests[algo_idx].digest, hash_digest_size[algo]);
>>  
>>  	/* 3rd: template name size */
>>  	namelen = !ima_canonical_fmt ? strlen(template_name) :
>> @@ -220,7 +249,15 @@ static int ima_ascii_measurements_show(struct seq_file
>> *m, void *v)
>>  	struct ima_queue_entry *qe = v;
>>  	struct ima_template_entry *e;
>>  	char *template_name;
>> -	int i;
>> +	int i, algo_idx;
>> +	enum hash_algo algo;
> 
> The preferred variable definition ordering is reverse fir tree.  Reverse the two
> lines.

Ok, I'll fix this also in create_securityfs_measurement_lists() where I'm
noticing there is the same issue.

>> +	algo_idx = ima_sha1_idx;
>> +	algo = HASH_ALGO_SHA1;
>> +
>> +	if (m->file != NULL)
>> +		lookup_algo_by_dentry(&algo_idx, &algo, m,
>> +				      ascii_securityfs_measurement_lists);
>>  
>>  	/* get entry */
>>  	e = qe->entry;
>> @@ -233,8 +270,8 @@ static int ima_ascii_measurements_show(struct seq_file *m,
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
>> @@ -379,6 +416,69 @@ static const struct seq_operations ima_policy_seqops = {
>>  };
>>  #endif
>>  
>> +static void __init remove_securityfs_measurement_lists(struct dentry
>> **dentry_list)
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
>> +	ascii_securityfs_measurement_lists =
>> kcalloc(securityfs_measurement_list_count,
>> +						     sizeof(struct dentry *),
>> GFP_KERNEL);
> 
> Although lines > 80 characters are permitted, it isn't needed here.  Like the
> original ascii_runtime_measurements initialization, split the line after the
> ascii_securityfs_measurement_lists variable name.

Ok I will fix this and check for other changed/introduced lines > 80 characters
where it is not necessary.

>> +	if (!ascii_securityfs_measurement_lists)
>> +		return -ENOMEM;
>> +
>> +	binary_securityfs_measurement_lists =
>> kcalloc(securityfs_measurement_list_count,
>> +						      sizeof(struct dentry *),
>> GFP_KERNEL);
> 
> Same here.
> 
> 
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
>> @@ -454,6 +554,9 @@ int __init ima_fs_init(void)
>>  {
>>  	int ret;
>>  
>> +	ascii_securityfs_measurement_lists = NULL;
>> +	binary_securityfs_measurement_lists = NULL;
>> +
>>  	ima_dir = securityfs_create_dir("ima", integrity_dir);
>>  	if (IS_ERR(ima_dir))
>>  		return PTR_ERR(ima_dir);
>> @@ -465,19 +568,21 @@ int __init ima_fs_init(void)
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
>> +		securityfs_create_symlink("binary_runtime_measurements",
>> ima_dir,
>> +					  "binary_runtime_measurements_sha1",
>> NULL);
> 
>> 80 characters here and in a few other places.>
> thanks,
> 
> Mimi

Thank you for your suggestions,

Enrico

> 
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
>> +					  "ascii_runtime_measurements_sha1",
>> NULL);
>>  	if (IS_ERR(ascii_runtime_measurements)) {
>>  		ret = PTR_ERR(ascii_runtime_measurements);
>>  		goto out;
>> @@ -515,6 +620,8 @@ int __init ima_fs_init(void)
>>  	securityfs_remove(runtime_measurements_count);
>>  	securityfs_remove(ascii_runtime_measurements);
>>  	securityfs_remove(binary_runtime_measurements);
>> +	remove_securityfs_measurement_lists(ascii_securityfs_measurement_lists);
>> +	remove_securityfs_measurement_lists(binary_securityfs_measurement_lists)
>> ;
>>  	securityfs_remove(ima_symlink);
>>  	securityfs_remove(ima_dir);
>>  
>> diff --git a/security/integrity/ima/ima_kexec.c
>> b/security/integrity/ima/ima_kexec.c
>> index dadc1d138118..52e00332defe 100644
>> --- a/security/integrity/ima/ima_kexec.c
>> +++ b/security/integrity/ima/ima_kexec.c
>> @@ -30,6 +30,7 @@ static int ima_dump_measurement_list(unsigned long
>> *buffer_size, void **buffer,
>>  		goto out;
>>  	}
>>  
>> +	file.file = NULL;
>>  	file.size = segment_size;
>>  	file.read_pos = 0;
>>  	file.count = sizeof(khdr);	/* reserved space */
>>
>> base-commit: 38aa3f5ac6d2de6b471ecb6e1cd878957ae7e8de
>

