Return-Path: <linux-integrity+bounces-845-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5677836F75
	for <lists+linux-integrity@lfdr.de>; Mon, 22 Jan 2024 19:16:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D98E31C29207
	for <lists+linux-integrity@lfdr.de>; Mon, 22 Jan 2024 18:16:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71A394174B;
	Mon, 22 Jan 2024 17:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=politoit.onmicrosoft.com header.i=@politoit.onmicrosoft.com header.b="oxuTqZ3P"
X-Original-To: linux-integrity@vger.kernel.org
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2119.outbound.protection.outlook.com [40.107.6.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50B4840C00
	for <linux-integrity@vger.kernel.org>; Mon, 22 Jan 2024 17:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.6.119
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705945299; cv=fail; b=ggtFt8uqY2HXYG7aT9EnoaDJKIUHBcY03HRi/KvYoaslLX3UoOCwYPOgyy06GbrVSepmadKuomI/nBT2TL1uBCzXx7lu9HKlaL6Mef1sPsXuHGUVKKc6VcQ1Bz07AlJV2xsEdoymh2+Qd5VRU9Bl5vY8Yvnbt84PgA9JDJCS9A8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705945299; c=relaxed/simple;
	bh=9FyQC03WjbvbhNxhvtTnaaMJhja8Tc9fL91ClQxl+uE=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=OXdm8RGLogAStnetBk1WAsTnRpGUUV3x+QNh/+P/nliecNe63kq5UOsaMjMnO/TknyK1NmeeB0QV/iQJ2Hy/MoYb9XEupHztWIVh5KGWxG58oggwh/RRxGg0xaKmOr55yU20MN+gQcQXlkBzSMDK6fyuUvSgki5/5pfLv+nTbE4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=polito.it; spf=pass smtp.mailfrom=polito.it; dkim=pass (1024-bit key) header.d=politoit.onmicrosoft.com header.i=@politoit.onmicrosoft.com header.b=oxuTqZ3P; arc=fail smtp.client-ip=40.107.6.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=polito.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=polito.it
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SvYPZT6bn5zTiSi5mF2nFElNvFiaPtCcdF0gRNIrL+OUScXpHwb/j9zIqg4b532o7jfTGGaojjhcM02tHLENNb5J6b+f6mrPmmA9tzhFMBLz2vI5TldDw3vmLEwqPxXCIZkxi2cz2D6EDHCPr90gKwk9/Cl3czjti0QbmdPEM9rG8PFiP33UGuUD0yEhOMdk+sbYyllHOA7gs67tptdVW2IPBgtonVs4YbHK4aRV2knfx9QoQj03k1to1zSMRrlBkvDEesg5yqzPo6KasdFmvHV9IyWyY8tCzNyja4i57Drs0LXdbN6VC1MEKu9lDkWUKNKH+zcVwJyEX8ax8uNfaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q7r1ZphosAT2243ypCEpCdV8dDat/GNJwQ8qoeS1Dv4=;
 b=CF5Gtj7xw6CZPQ9RwkgMT5fWW03HUAqF5n1ot2SRC9CdDt2Z5venNj+rVK5H+k1h0YmvAdXQvkO7sGBnR8hJKMLqvtKy5K7eHeHsuafZvX+sFNHohpZwi355YbTwlEt7rKpJk3xtyJWDLa01AHXaRaMVO8FoJ1cU/Lv/z+kQNXYPGEvWW7zx1mlde54dZdRuZDAboeH7nKnphuxIFMswVCyU3exAwosUG8Q0plAOuqj/Df0i2A9DcnZfwsQYvjY5al2b7Yn7PAtn03M9tEIOLA/y9Clk/PJiwQtau3jleV0CCN1vAQaOqSkihv/STnMTZbKa/hKuVRXx8EOPdLp5Tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=polito.it; dmarc=pass action=none header.from=polito.it;
 dkim=pass header.d=polito.it; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=politoit.onmicrosoft.com; s=selector2-politoit-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q7r1ZphosAT2243ypCEpCdV8dDat/GNJwQ8qoeS1Dv4=;
 b=oxuTqZ3PnePLDk6Q/AdJlGBTFalhIXrpmtIZk/NoMhGlYJWplOHqPpBU9P5VGYyR/g4XXqhpIWtgobbDzdXm60akhpqWxn6wRd94PAjS6qCn1c03uMflUBexEdYDNaDOdJ095qXs7RBVJfnN3+raHG0LwC9J9RgpW7eNa5ta6k4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=polito.it;
Received: from AS2PR05MB9840.eurprd05.prod.outlook.com (2603:10a6:20b:5f5::20)
 by PA4PR05MB9305.eurprd05.prod.outlook.com (2603:10a6:102:2ad::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.31; Mon, 22 Jan
 2024 17:41:31 +0000
Received: from AS2PR05MB9840.eurprd05.prod.outlook.com
 ([fe80::3351:44:a53e:99a9]) by AS2PR05MB9840.eurprd05.prod.outlook.com
 ([fe80::3351:44:a53e:99a9%4]) with mapi id 15.20.7202.027; Mon, 22 Jan 2024
 17:41:31 +0000
Message-ID: <e0664bb2-8caf-42f3-9344-ee4159782eda@polito.it>
Date: Mon, 22 Jan 2024 18:41:29 +0100
User-Agent: Mozilla Thunderbird
From: Enrico Bravi <enrico.bravi@polito.it>
Subject: Re: [PATCH v2] ima: add crypto agility support for template-hash
 algorithm
To: Roberto Sassu <roberto.sassu@huaweicloud.com>,
 linux-integrity@vger.kernel.org, zohar@linux.ibm.com,
 roberto.sassu@huawei.com
Cc: Silvia Sisinni <silvia.sisinni@polito.it>
References: <20240121161633.2302285-1-enrico.bravi@polito.it>
 <aa50966e78c74539f6379c7c2215880db22d2752.camel@huaweicloud.com>
Content-Language: en-US, it
In-Reply-To: <aa50966e78c74539f6379c7c2215880db22d2752.camel@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ZR2P278CA0079.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:65::18) To AS2PR05MB9840.eurprd05.prod.outlook.com
 (2603:10a6:20b:5f5::20)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS2PR05MB9840:EE_|PA4PR05MB9305:EE_
X-MS-Office365-Filtering-Correlation-Id: abb7213d-0032-4781-f356-08dc1b715ead
X-politoEOL-CGPAlias: 1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	npLDRE7xwGLZBPnjACTN20Ni6vJByodRpxGkQvtKCSwyPqzygqfxgBT1FLKIeP75kfMzltisIWMSXlI26OY43Wzb0CdrNj4bFYst+U3AfKuFmuSzFyF4TtVB+AC3StPDLPAkr3CG3LvUOk/17IpRtjzsdYnUF4m2bQZdGFexvgSvQRNF6IocfXbxELblSiDdk372eEtnDFQ7l+90WIr03JNvEhnWpGUt8IPTz0ZMz12yyHOG8S9NaXPDoULOvCJv6TqtwUEn2hSyqF47ouN/sbA/HdBokgCjHHeOeLHungM3gkzR/v1Ruqbi9Sv2YbsLiOw1I/zlJlNwnUPfgkEmpD1n2O/ICsaKsYoeDeq7Cy5nWrH8+JuwaEKcHXf0AMdVFtTexKuhf6fkFAzUWGxuhYyxvgK9vY2E4eKsZPiy7W8Ie8OpXElMVVkvhmw32MJYKpJya6Y+TLWMfQ5ND9QojXVblqVnr7o2+D+0lt6O2kaS+0Vext2UHN9uNGcKakA0fLkv0AU/1ISVLKssPMTFqoGgwgbMGg97yGsauTXyFiVIEJybQfqihCkM+23hMjksbqnLw7CH7Yc/IQNyovkxScBpXdsDdbyiF1z/OsGAY0n20patJH3C2uRsM1g0PfhtkYqNs4Zsmflui4gYHae5pQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS2PR05MB9840.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(346002)(39860400002)(396003)(366004)(230922051799003)(451199024)(186009)(1800799012)(64100799003)(31686004)(83380400001)(31696002)(86362001)(36756003)(4326008)(8936002)(8676002)(53546011)(107886003)(2616005)(38100700002)(26005)(6506007)(66556008)(6512007)(6486002)(316002)(66946007)(786003)(66476007)(41300700001)(5660300002)(2906002)(478600001)(30864003)(44832011)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NE04MmcxL0IwTi9vKzZqd3h5REFQKzdsMnc4N2VaUWRBbm54Qk85RWowTDJI?=
 =?utf-8?B?ME8yWC95RHFLWXJWWVBXU1RkQms4UW5zQlZIOWlOVktUOUJjYUM5aTVidVdk?=
 =?utf-8?B?QzlWYjVGSmwwRGxmRTNZN25WczgvQTU2YW1sRGl6UGJkYyt0NUxKTDFNeDJl?=
 =?utf-8?B?TG5IMkZUTC9wREZVcEMrblFLY05NTGZTMkFRcHdhekV4OXpGWlVkTkJSWDJs?=
 =?utf-8?B?MWYwZ2VVSElMTUJBa3VXNWFEVkR2YXkrcjM1UTBuaEsxOGFNUDJrT0g2OWdo?=
 =?utf-8?B?VVhxa1ZnRDlQMmgvcW5TcStPZURBV1VEQnFtVDUyamlUYm1KWWttUmdJUHkx?=
 =?utf-8?B?b3dNdVVmSXdwOENkTnZqQ1dtVCt3T0lwMXgvZGFGa3YvSTl1V29XdE9yYWto?=
 =?utf-8?B?TVZ5STVvSmRIK1huYkhVY3hkV1IwNHJBRTB5YjBKN2d4MzRYNGJTdDFmdWdV?=
 =?utf-8?B?SFUrMXEySGRlNHc2SExhazh4TTI2S0tMRVdvL3h6OUtXc3VmYUQ2WFlsMG1i?=
 =?utf-8?B?RDhEZVh3ejRaMm5FeG5Qc2k5Wk9lVzVLd0ZzZHVReWxhUlQ5bXp2NUcwcTRs?=
 =?utf-8?B?M05BMDZXWEQ2MkNzNnBJeEJYN3VOem8rS2xRa3JvMmIvNzRFSkMvYjMrSnlz?=
 =?utf-8?B?TE1PWDZmTlZPZVRPWG9WdGQ5c01PR2RaK1AwNzEwbW9NY00wSU4reVNSMUdR?=
 =?utf-8?B?aDBmRnVIKzViZVl0amlOTW45blo3ODN5VG9ma1hCVTYycWRNNHJTMXZUdUFS?=
 =?utf-8?B?dGsyWU9RSnNheUxoSVFiZG5TK1lzUE9pdGg2bW5EWitnejlDKzR6MmwwcUNX?=
 =?utf-8?B?RG5JOVlvQUtSRXNjaU5ObFhCKzlwR3piMnZUenFCSDliS1JkVm4xbzR6T0ph?=
 =?utf-8?B?d2dmN3Y1eGxjNjhwazNuamVvNHFjMHl4M1NsallwUk4wdEdPWkZYZ1FoRUlD?=
 =?utf-8?B?MEhLWkpnMXJXTVdrV2xFTW51djJDc3ZPSGtHK0VUWm4zbmJjbEVRNzVsUmNN?=
 =?utf-8?B?NXpGTG9KOEJpaTM4Ulo3U1JVM0pLdTVpTFJYSUNxbmVGMXhIRkE2TVFKOVU4?=
 =?utf-8?B?SE9CWHE0UlFaUFMzTE0rdjBib2MwZFExSTVEbFZBaitOUEYvdUYwWjQzdjVP?=
 =?utf-8?B?OUgwdUpBNVZKckNxbkNITFZ3dUIrTkZ5SHFuVTNOdm5pbWlMRkdnZTFMekRj?=
 =?utf-8?B?Y0kzZGdNcUFCTTMrT2gzRUhsNm5uMTBNQmYxeHA2Rjd4NE9KSk4wNC9HT0FF?=
 =?utf-8?B?UW4veVlzVlZDbVVvcllXVysrTmNwT0crRytFa3A5N2hCazdmeEkrcENWNndG?=
 =?utf-8?B?aWRsNVIxRGJMNXJVd0tFZ0trYkVRdUxDdWhuU0F5SlpFZmdTaDJ4RnJWMk80?=
 =?utf-8?B?VktYUlpDRHlvVUlacXgwUC9ZdXl3OHlFWHc3Y3MwZGYvdUtXRkdRYlBUWXgr?=
 =?utf-8?B?SkJtdUNrOFhTQW9NckxYOWxOTXZsVnJHZWVNYTNEK251NGJFeml6MWNRS3pX?=
 =?utf-8?B?Z2pWbUJPYzl0cWpGTWkyZFVlSytjdG5aUWQydy8zVjUxTjFKOGZwOS9XY1RW?=
 =?utf-8?B?OVFZV0VKODh6V1BCZVBCM1FxeEVRTnRHM3ZGREM4VUExeEhjL0ZFZllUZFhn?=
 =?utf-8?B?Z0ppU3VhR09IWmVodisyQTVqbk4weHpUcXlRcDRwc1czUVorM1ZXZFdMYUR5?=
 =?utf-8?B?K1N2QlRPV3ZSeUp6YTNZV2U3S3VqTnBoNXY0WHd0VTJKdVMzQ0F4anhTTkk3?=
 =?utf-8?B?ZGh2NS9NQ3Y1UnJxZDVkTFdTZnM1RVUxT3V2d29HOGxLWUlreHlIVG9vTkNa?=
 =?utf-8?B?YW5sMHVoeEFhTTV2OGhpT1c5NzA5aE1aRUxrQjdqS0pQTnBxdm8xSUpBeUFp?=
 =?utf-8?B?d3loWGNXcDd3RmdjeWRrSWpHd2tkR0hQaEFFRnluZENrY2FxaUl6TFNYVVMv?=
 =?utf-8?B?TDFDY3Nid3JkRWMwTHV6K1NsbGJPeFhzVzdKT0JoNmRpcGZuUGNaNU9yN3p1?=
 =?utf-8?B?SW9adGhKdWZPbW5KSUNubmlZallsNGt3T3RMREsyeFAwZE1BdVZmVDdTV3pC?=
 =?utf-8?B?VTZEaFdxdTZoRHJmZlQyTXlWbzdlRlVpR2tlOE5FVzRVSkRLVzVVdjdUUE5l?=
 =?utf-8?B?R0FpTExrR05kcTM0YW9odUN4Z2R3YVo2R01UNU9ZY3FGbi9maXRaQkl1TzVJ?=
 =?utf-8?B?U1E9PQ==?=
X-OriginatorOrg: polito.it
X-MS-Exchange-CrossTenant-Network-Message-Id: abb7213d-0032-4781-f356-08dc1b715ead
X-MS-Exchange-CrossTenant-AuthSource: AS2PR05MB9840.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2024 17:41:31.6316
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 2a05ac92-2049-4a26-9b34-897763efc8e2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aTKsH6+bVZtxmHybSOv2VnFOF+Uxb0QMTRRWtqjZcPqCg2EYU5LBoFuitXmEa6OWdL+tLwOIdDG94jwgNnJfEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR05MB9305

Hi Roberto,

thanks a lot for your quick feedback.

On 22/01/24 09:20, Roberto Sassu wrote:
> On Sun, 2024-01-21 at 17:16 +0100, Enrico Bravi wrote:
>> The template hash showed by the ascii_runtime_measurements and
>> binary_runtime_measurements is the one calculated using sha1 and there is no
>> possibility to change this value, despite the fact that the template hash is
>> calculated using the hash algorothms corresponding to all the PCR banks
>> configured in the TPM.
>>
>> This patch introduce the support to retrieve the ima log with the template data
>> hash calculated with a specific hash algorithm.
>> Add a new file in the securityfs ima directory for each hash algo configured
>> for the PCR banks of the TPM. Each new file has the name with the following
>> structure:
>>
>> 	{binary, ascii}_runtime_measurements_<hash_algo_name>
>>
>> except for sha1 which it remains associated with the standard file names.
>> The <hash_algo_name> is used to select the template data hash algorithm to show
>> in ima_ascii_measurements_show() and in ima_measurements_show().
>>
>> As example, in the case sha1 and sha256 are the configured PCR banks, the
>> listing of the security/ima directory is the following:
>>
>> -r--r----- 1 root root 0 gen 20 15:06 ascii_runtime_measurements
>> -r--r----- 1 root root 0 gen 20 15:06 ascii_runtime_measurements_sha256
>> -r--r----- 1 root root 0 gen 20 15:06 binary_runtime_measurements
>> -r--r----- 1 root root 0 gen 20 15:06 binary_runtime_measurements_sha256
>> --w------- 1 root root 0 gen 20 15:06 policy
>> -r--r----- 1 root root 0 gen 20 15:06 runtime_measurements_count
>> -r--r----- 1 root root 0 gen 20 15:06 violations
>>
>> v2:
>>  - Changed the behaviour of configuring at boot time the template data hash
>>    algorithm.
>>  - Removed template data hash algo name prefix.
>>  - Removed ima_template_hash command line option.
>>  - Introducing a new file in the securityfs ima subdir for each PCR banks
>>    algorithm configured in the TPM.
>>    (suggested by Roberto)
>>
>> Signed-off-by: Enrico Bravi <enrico.bravi@polito.it>
>> Signed-off-by: Silvia Sisinni <silvia.sisinni@polito.it>
>>
>> ---
>>  security/integrity/ima/ima_fs.c | 164 ++++++++++++++++++++++++++++++--
>>  1 file changed, 157 insertions(+), 7 deletions(-)
>>
>> diff --git a/security/integrity/ima/ima_fs.c b/security/integrity/ima/ima_fs.c
>> index cd1683dad3bf..db57edeb112d 100644
>> --- a/security/integrity/ima/ima_fs.c
>> +++ b/security/integrity/ima/ima_fs.c
>> @@ -118,7 +118,7 @@ void ima_putc(struct seq_file *m, void *data, int datalen)
>>  
>>  /* print format:
>>   *       32bit-le=pcr#
>> - *       char[20]=template digest
>> + *       char[n]=template digest
>>   *       32bit-le=template name size
>>   *       char[n]=template name
>>   *       [eventdata length]
>> @@ -130,9 +130,37 @@ int ima_measurements_show(struct seq_file *m, void *v)
>>  	struct ima_queue_entry *qe = v;
>>  	struct ima_template_entry *e;
>>  	char *template_name;
>> +	const char *filename;
>> +	char algo_name[16];
>>  	u32 pcr, namelen, template_data_len; /* temporary fields */
>>  	bool is_ima_template = false;
>> -	int i;
>> +	int i, rc, algo_idx;
>> +	enum hash_algo algo;
>> +
>> +	filename = m->file->f_path.dentry->d_name.name;
>> +	rc = sscanf(filename, "binary_runtime_measurements%s", algo_name);
>> +
>> +	if (rc != 0) {
>> +		for (i = 0; i < HASH_ALGO__LAST; i++) {
>> +			if (!strcmp(algo_name + 1, hash_algo_name[i])) {
>> +				algo = i;
>> +				break;
>> +			}
>> +		}
>> +		if (i == HASH_ALGO__LAST)
>> +			algo = HASH_ALGO_SHA1;
>> +
>> +		for (i = 0; i < NR_BANKS(ima_tpm_chip); i++) {
>> +			if (algo == ima_tpm_chip->allocated_banks[i].crypto_id) {
>> +				algo_idx = i;
>> +				break;
>> +			}
>> +		}
>> +	}
> 
> Hi Enrico, Silvia
> 
> I would find more efficient if you create an array of dentries in the
> same order as ima_tpm_chip->allocated_banks, so that you can compare
> dentry addresses and find already the right index.

Your are absolutely right, there is no need of two loops.

>> +	else {
>> +		algo_idx = ima_sha1_idx;
>> +		algo = HASH_ALGO_SHA1;
>> +	}
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
>> @@ -220,7 +248,35 @@ static int ima_ascii_measurements_show(struct seq_file *m, void *v)
>>  	struct ima_queue_entry *qe = v;
>>  	struct ima_template_entry *e;
>>  	char *template_name;
>> -	int i;
>> +	const char *filename;
>> +	char algo_name[16];
>> +	int i, algo_idx, rc;
>> +	enum hash_algo algo;
>> +
>> +	filename = m->file->f_path.dentry->d_name.name;
>> +	rc = sscanf(filename, "ascii_runtime_measurements%s", algo_name);
>> +
>> +	if (rc != 0) {
>> +		for (i = 0; i < HASH_ALGO__LAST; i++) {
>> +			if (!strcmp(algo_name + 1, hash_algo_name[i])) {
>> +				algo = i;
>> +				break;
>> +			}
>> +		}
>> +		if (i == HASH_ALGO__LAST)
>> +			algo = HASH_ALGO_SHA1;
>> +
>> +		for (i = 0; i < NR_BANKS(ima_tpm_chip); i++) {
>> +			if (algo == ima_tpm_chip->allocated_banks[i].crypto_id) {
>> +				algo_idx = i;
>> +				break;
>> +			}
>> +		}
>> +	}
> 
> Same.
> 
>> +	else {
>> +		algo_idx = ima_sha1_idx;
>> +		algo = HASH_ALGO_SHA1;
>> +	}
>>  
>>  	/* get entry */
>>  	e = qe->entry;
>> @@ -233,8 +289,8 @@ static int ima_ascii_measurements_show(struct seq_file *m, void *v)
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
>> @@ -363,6 +419,8 @@ static struct dentry *ascii_runtime_measurements;
>>  static struct dentry *runtime_measurements_count;
>>  static struct dentry *violations;
>>  static struct dentry *ima_policy;
>> +static struct dentry **ima_ascii_measurements_files;
>> +static struct dentry **ima_binary_measurements_files;
>>  
>>  enum ima_fs_flags {
>>  	IMA_FS_BUSY,
>> @@ -379,6 +437,31 @@ static const struct seq_operations ima_policy_seqops = {
>>  };
>>  #endif
>>  
>> +/*
>> + * Remove the securityfs files created for each hash algo configured
>> + * in the TPM, excluded ascii_runtime_measurements and
>> + * binary_runtime_measurements.
>> + */
>> +static void remove_measurements_list_files(void)
>> +{
>> +	int i;
>> +
>> +	for (i = 0; i < NR_BANKS(ima_tpm_chip); i++) {
>> +		if (ima_ascii_measurements_files[i]) {
>> +			securityfs_remove(ima_ascii_measurements_files[i]);
>> +			kfree(ima_ascii_measurements_files[i]);
>> +		}
>> +
>> +		if (ima_binary_measurements_files[i]) {
>> +			securityfs_remove(ima_binary_measurements_files[i]);
>> +			kfree(ima_binary_measurements_files[i]);
>> +		}
>> +	}
>> +
>> +	kfree(ima_ascii_measurements_files);
>> +	kfree(ima_binary_measurements_files);
> 
> Oh, you actually put them in a array and order the elements by PCR
> bank.
> 
>> +}
>> +
>>  /*
>>   * ima_open_policy: sequentialize access to the policy file
>>   */
>> @@ -452,7 +535,10 @@ static const struct file_operations ima_measure_policy_ops = {
>>  
>>  int __init ima_fs_init(void)
>>  {
>> -	int ret;
>> +	int ret, i;
>> +	u16 algo;
>> +	char file_name[50];
>> +	struct dentry *dfile;
>>  
>>  	ima_dir = securityfs_create_dir("ima", integrity_dir);
>>  	if (IS_ERR(ima_dir))
>> @@ -483,6 +569,69 @@ int __init ima_fs_init(void)
>>  		goto out;
>>  	}
>>  
>> +	/*
>> +	 * Allocate a file in the securityfs for each hash algo configured
>> +	 * in the TPM but sha1 (for ascii and binary output).
>> +	 */
>> +	if (ima_tpm_chip) {
>> +
>> +		ima_ascii_measurements_files = kmalloc_array(NR_BANKS(ima_tpm_chip),
>> +					sizeof(struct dentry *), GFP_KERNEL);
> 
> Since you added a function for freeing the arrays, I would do the same
> for adding.

Sure.

>> +		if(ima_ascii_measurements_files == NULL) {
>> +			ret = -ENOMEM;
>> +			goto out;
>> +		}
>> +
>> +		ima_binary_measurements_files = kmalloc_array(NR_BANKS(ima_tpm_chip),
>> +					sizeof(struct dentry *), GFP_KERNEL);
>> +		if(ima_binary_measurements_files == NULL) {
>> +			ret = -ENOMEM;
>> +			goto out;
>> +		}
>> +
>> +		for (i = 0; i < NR_BANKS(ima_tpm_chip); i++) {
>> +			algo = ima_tpm_chip->allocated_banks[i].crypto_id;
>> +
>> +			/* Skip sha1 */
>> +			if (algo == HASH_ALGO_SHA1)
>> +				continue;
> 
> I would go ahead, create also the dentry for SHA1 and add a symbolic
> link for the legacy files.

ima_ascii_measurements_files and ima_binary_measurements_files are allocated
just in the case a tpm chip is detected. What you are suggesting is to allocate
in any case these lists, with at least one element, and creating the legacy file
always as symbolic links? Or to define them as symbolic links only in the case a
tpm chip is detected, otherwise creating them as usual?

>> +
>> +			dfile = kmalloc(sizeof(struct dentry), GFP_KERNEL);
>> +			if (!dfile) {
>> +				ret = -ENOMEM;
>> +				goto out;
>> +			}
> 
> I don't remember if the lines above are really necessary. You actually
> overwrite the pointer below.

Yes these lines are definitely not necessary.

Thanks a lot,

Enrico

> 
>> +
>> +			sprintf(file_name, "ascii_runtime_measurements_%s",
>> +						hash_algo_name[algo]);
>> +			dfile = securityfs_create_file(file_name,
>> +						S_IRUSR | S_IRGRP, ima_dir, NULL,
>> +						&ima_ascii_measurements_ops);
>> +			if (IS_ERR(dfile)) {
>> +				ret = PTR_ERR(dfile);
>> +				goto out;
>> +			}
>> +			ima_ascii_measurements_files[i] = dfile;
>> +
>> +			dfile = kmalloc(sizeof(struct dentry), GFP_KERNEL);
>> +			if (!dfile) {
>> +				ret = -ENOMEM;
>> +				goto out;
>> +			}
>> +
>> +			sprintf(file_name, "binary_runtime_measurements_%s",
>> +						hash_algo_name[algo]);
>> +			dfile = securityfs_create_file(file_name,
>> +						S_IRUSR | S_IRGRP, ima_dir, NULL,
>> +						&ima_measurements_ops);
>> +			if (IS_ERR(dfile)) {
>> +				ret = PTR_ERR(dfile);
>> +				goto out;
>> +			}
>> +			ima_binary_measurements_files[i] = dfile;
>> +		}
>> +	}
>> +
>>  	runtime_measurements_count =
>>  	    securityfs_create_file("runtime_measurements_count",
>>  				   S_IRUSR | S_IRGRP, ima_dir, NULL,
>> @@ -515,6 +664,7 @@ int __init ima_fs_init(void)
>>  	securityfs_remove(runtime_measurements_count);
>>  	securityfs_remove(ascii_runtime_measurements);
>>  	securityfs_remove(binary_runtime_measurements);
>> +	remove_measurements_list_files();
>>  	securityfs_remove(ima_symlink);
>>  	securityfs_remove(ima_dir);
>>
>> base-commit: 88035e5694a86a7167d490bb95e9df97a9bb162b

