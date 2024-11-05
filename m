Return-Path: <linux-integrity+bounces-4026-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35C789BD472
	for <lists+linux-integrity@lfdr.de>; Tue,  5 Nov 2024 19:22:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 86891B21352
	for <lists+linux-integrity@lfdr.de>; Tue,  5 Nov 2024 18:22:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E3DA1E572C;
	Tue,  5 Nov 2024 18:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="hCzKWjIs";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="vlOOyp/t"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5842213D51E;
	Tue,  5 Nov 2024 18:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730830930; cv=fail; b=eVMijo0emC3/FlI0ZQ1oMGFQ67l4RCz7YGtMDHg46X3nPkRyg5BZHMaLt9pBpJmr6XKpljMcHB4z5fxSUM8JyROvsvqB5NrttWgMhhJbLQV/ii+3ar5JcZ7A08fpS+Rhb/+SgFimfdfz/JqJET5loQ33dVl/bmfJJ0v0CxLJHiM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730830930; c=relaxed/simple;
	bh=x6vQXcAKaNS8dmreC9lUvrAt9o2rD4z/CW7shkZmeVY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=NQ556GN9KQOfitozTACwOoYBPKthfVLw/xi1fNYY8coLOvq5zcoz8vMr3fDXVTJBHpoP382CWt+a7GCFVnlBC6UE+OHbSW1C1xaNTupyOE4h4WpOljYBJ16AuOVb06EdJkNyIgdLDoqUL/6qtgBczUIUGZmn/5P8OIVROJERf/c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=hCzKWjIs; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=vlOOyp/t; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A5DiZoN030190;
	Tue, 5 Nov 2024 18:21:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=x4h04GxhEloWFk70VFjjL+rYMFK4WkeEJ9PGI3hn05I=; b=
	hCzKWjIs/xAblrwYgEKMcLlXj2LM8aQB6+JZSVtLMmFiMJ8qK/g8X65Ttbv54cFX
	wXpPCaJdflENphfTJXNM3eRF/2uvdC0rh2l4/crylbMH5BOcfpg1eD7MBqk2s/IV
	pfd+LnfbVXxAem4fTAr5AsKZvQ6eFMAOKlTQ77RHDJBGf1P3ImknEi/6AdpdMxSi
	fYUlwmKL00FDiuJpn85sm8OEkKj78M1SQqaqEPidDPP/JrHbP3onlTRpfnyGOvgz
	h/HwnF4Qm4Rk7SgO0Ow0AZIDlN79B2OuoyOx4NFdk8lcFn3pVHBCMI24fWxZ8M1L
	pKpshTiL++Ux9qazC+gs8Q==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42nanyx4qk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 05 Nov 2024 18:21:51 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4A5I3vPm005035;
	Tue, 5 Nov 2024 18:21:50 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2040.outbound.protection.outlook.com [104.47.56.40])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 42p87awmdy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 05 Nov 2024 18:21:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iUZiQY67XcaEsN9k15AUjOZlpPUO8Sanz2CcQHuFf6FrQ5Abd99gOWj1vv3r3IsQ+zmFK1dse20t3LwCeATXF+sMD+80lpNDvcI/a04YmvMOQY97dDTHgZMMJ/jbdRlRCK3na6CqBNISgIfegRH1Vg3XypI2ckXDSx5kbNirMZT2prSMbS8PeNiTOU3g3eXhaIO0GOT2fYTcFTAHfsdncHt0ODpAgZT1usfYRLsJXouyRFQRD3ET4TREYnfL+hNkwgr/q/oWQZMF6uFWLf4bS6KZtlr5ACMirvlYMj2H6chB5Rw0L2u6Gbr6rG7O6EINuWnQgUuLU6Y4R8P9X3hj6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x4h04GxhEloWFk70VFjjL+rYMFK4WkeEJ9PGI3hn05I=;
 b=SAby9MVpBVoGb34ic/dr841ITMwvy5GcwVXs4pugOkaFV3R3mvt1LOCbVJtW13XnPUu58/H7ykvYVpECGObVqApZUkfkFjV7uY2bwMAU7HUYDSVTJ3x7syugn7X6eyFKTKZWtkfl56G5GpTIL5LbqjaChB/zq30cpwCpu71o3AH5/3gguP6f/pSImxTulEeiBT2BwlSjIBH9+62G6VGXu357GkNtb7ou7zAkzq2PnwT8ranQto2SDh83TnNWQwxbwfWuZ4qFronFzs3/GBRsQsQOB95Kv7kamDaQqh62E47Gs+w29+F12MP291SDVYe3GfIujib1YHQYJcnzuPmu8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x4h04GxhEloWFk70VFjjL+rYMFK4WkeEJ9PGI3hn05I=;
 b=vlOOyp/t51RR699HimKo1MYcjMjDY/C+k8amZ3Wx8KPvexMOvvWlODHob/y2hppJjDfboV8jcAOpm/y1w9AY7IiWdm7lkeIRTb1RqC8fW4G2UATev6x9JoTqqphawdxe3dogCEV7+YKar2xnb2q98UafXEFloZJvXJiFHelBxOk=
Received: from CY8PR10MB7218.namprd10.prod.outlook.com (2603:10b6:930:76::22)
 by SA6PR10MB8016.namprd10.prod.outlook.com (2603:10b6:806:442::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.30; Tue, 5 Nov
 2024 18:21:48 +0000
Received: from CY8PR10MB7218.namprd10.prod.outlook.com
 ([fe80::3bfd:d89c:954f:747f]) by CY8PR10MB7218.namprd10.prod.outlook.com
 ([fe80::3bfd:d89c:954f:747f%5]) with mapi id 15.20.8114.028; Tue, 5 Nov 2024
 18:21:48 +0000
Message-ID: <58d239d7-4a58-454e-808d-6fd5fc5d7856@oracle.com>
Date: Tue, 5 Nov 2024 10:21:45 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/4] Alternative TPM patches for Trenchboot
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Jarkko Sakkinen <jarkko@kernel.org>, x86@kernel.org,
        "Daniel P. Smith" <dpsmith@apertussolutions.com>,
        Thomas Gleixner <tglx@linutronix.de>, Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        "open list:TPM DEVICE DRIVER" <linux-integrity@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>, ross.philipson@oracle.com
References: <20241102152226.2593598-1-jarkko@kernel.org>
 <7412e1e0-0e28-41a6-a4aa-a3fc97d36468@oracle.com>
 <CAMj1kXGwwLycnUdEXJ0kobYYgNxNMxDZJf+aqYQZdXgB5hhLyw@mail.gmail.com>
Content-Language: en-US
From: ross.philipson@oracle.com
In-Reply-To: <CAMj1kXGwwLycnUdEXJ0kobYYgNxNMxDZJf+aqYQZdXgB5hhLyw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PH7PR17CA0066.namprd17.prod.outlook.com
 (2603:10b6:510:325::15) To CY8PR10MB7218.namprd10.prod.outlook.com
 (2603:10b6:930:76::22)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR10MB7218:EE_|SA6PR10MB8016:EE_
X-MS-Office365-Filtering-Correlation-Id: c4deb9e7-1ccd-4bee-947f-08dcfdc6b613
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VXNjZjE4WFpHaFdTOVMzSVN3RjNEMDFOY3ltUE5BNnRtWW50VkF3a2lhS2My?=
 =?utf-8?B?K1JFa2o2aHVIVVhqVGc0d1EraHVtQ3hFeWZFSThqMkpGOTMvMW1Qdit3ZFIr?=
 =?utf-8?B?R3Z1OTdTTU1lZGZzMFNEVDdRNXg3akFHVUxtNjA2d0k1NCt1ZWRmbk9EbFlP?=
 =?utf-8?B?azVVTnpXWjRKRXJRWGlCMkxyM0FlNUswSUk5dzk0N1J5TmhYdm4wcExNRWpQ?=
 =?utf-8?B?R3ZJOS8zbEduWE1NNVVIb2NuT2R1Z2hIYmJGalNRU21uUk1PZkk0MisxMzd2?=
 =?utf-8?B?VktzazJPQ0JQRk44bFhxZnhIOGRKdk5oTFhoNjI0ejVzMzBsQmFGMXpYRlpT?=
 =?utf-8?B?T1VlaXd2MWpnSGtOYmdDazBNUE5DUWs0UU9lRGJiTzdTbURDWE9QcFZlcU5r?=
 =?utf-8?B?U0hGV2hrL1UxSEVBdVpWTDNMRWloUUpnNFpQOUpJU3Fmd3NzVWpSYmhjbzNJ?=
 =?utf-8?B?SVI0Vk15c3ZOVVNJQWhjc2swM1ZKSVFVa3B0Q3lIQkpFcHFFb2prdGl3NzBz?=
 =?utf-8?B?d09YQ2RvTnJwejdEd1VqUi9TL1grTjlSL1VDL2FwVG5GUlVSakVod3dWczF0?=
 =?utf-8?B?OGtpbVJRTE1OUWNqUmVPQjQ0elpUVml6a0dqN0NYRmpINkVocGZNWm9rem1T?=
 =?utf-8?B?Z1QyK0kwYTZuSW54cVdzSHczL1lNckNiUDBLT2ZyVk5GTDVnUlByTTZRTVNK?=
 =?utf-8?B?WEFvUlB6S2xsS1E4VEFxQ3Q3anVHNnpRTW9jcW9Pc1ByQVprZjBvNlpCbjZE?=
 =?utf-8?B?K2g1WFRYdStERzVtZ1hiTXp6Ylh2eVF4R2hOZ0FHM2U4TjZDWlQyQ2c5R1Q2?=
 =?utf-8?B?QmdaQk1mVUkwQzliT3BBeG91UDh1eWIrV2tEVGhmOTIvY0JOT0J0UmgyZXhL?=
 =?utf-8?B?OStrcjBtdExIenNodzhuZk5mMVJXYzN6SWRIanFSZk1rZ1NoYzU4MzEyWFly?=
 =?utf-8?B?ek1LbGc4WUhlY0tIK2xMZXVIaElDMkxDcFlkc0YzWWRDU2liK1B5MC82V1cz?=
 =?utf-8?B?SWRxSUU0K25sRURLZkYzU242dVFpNEpPNmYxdUN6QkZHVXZodWgvSDdMOXdw?=
 =?utf-8?B?VGFrdEEyRzUydDVGTjVndkFqMzJsNUlWTVA5S2hMenRyUmZQZHNmeFNHYk84?=
 =?utf-8?B?bERwYnB4WC9kYXVSN083M1ZQYVFTQ0NKdkFuS04wbTNmOWJpVnJzQXNzZ3k5?=
 =?utf-8?B?NEFpcmlhTURUU3ExRDQrcm5CWTlnZkhEdEVjTmhJczh4eHdZL05iSmsvMTR4?=
 =?utf-8?B?WFc2ajZrSEt6WE1NTis0RGJtOFE3QU4xOHU3QnpPVnlUSXhlcnB0NDJrOTVT?=
 =?utf-8?B?N1cvajRXclJCQzJ2VzJUTnRrOVJSNjFjbDRHdDBIbzNRU0Mwc0ZnY3RTdjNn?=
 =?utf-8?B?WlRFbW5PZElDeVhkeHlraHowL21OYVdiK2Z5R3FISjk5dkZzc1I0WEF2VUh2?=
 =?utf-8?B?ZXk5NG9iUE9Ca2ZnVUtyRFBDa3RCN1poZHhNTmgyL3I1NGExRi9MeWxKczVy?=
 =?utf-8?B?YjZMMzFTMDh2M1ZOWFlLMkpIbVNYeXNMemltUG56Nyt1WFo2NnZhZDdFZGNs?=
 =?utf-8?B?bmx1QmFJSzJoVzA3cFdGNXp0QUlPRElVbjZNYnhsK0o0MVgySVRoakpNck96?=
 =?utf-8?B?NmZ5WmVpcGpiNXdZWmltOG5qc1JDcHBqV0FjZElkbHVGcjU0aUVGV2V2cDBD?=
 =?utf-8?B?cmRzWkN0ekNFbzJCTnJrTlRQMkVRaDNxY011Y1RibUJuY0JPSmFIOGQ1QS9F?=
 =?utf-8?Q?1HnjsI+uhPd6ar/b2jSxjUu/oh5U786QQ5KX9Av?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR10MB7218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UlRsLzN0bUZzeGVSTVE5RXIwYWllNGVoNGM3YUtTZUpSM0pLWjdGWXN1MGxm?=
 =?utf-8?B?Ujg3V2ViVUtOdmQ0QnJQWlZGUE9aaC8rRGg2aHJPemx5TkIrb2doeDZBUy9X?=
 =?utf-8?B?UzNPTHVIMWtkb0hqZGRQWE5YQUsvVEs2N3I4bDdoUWl1NFVtT0o2cVJHSEU5?=
 =?utf-8?B?Z2x6RXFha2MvYlhpajU4bDFzdnhTRy9pMjlYTm1jamNXM0tnclJzelhTNWd2?=
 =?utf-8?B?a1k5RDVkZVRJbHEyZWlJbFhhU3JpZ1JRc1Z4K1lZTzdYOFVOclNManFQZDQ0?=
 =?utf-8?B?eDhPd3hZT3hOTjBjejMyaXNSYWV3RSsxckhzMkZOaE5yTUg1MldrZldjR3ln?=
 =?utf-8?B?UERBVW1Cb2ROa20wQWEzRkczNDBSbDRUOXpoTnZvVU5rMWFCL3lxZ25xY1FY?=
 =?utf-8?B?MjVpMlc2d0RZekxOT0poR0Z2UU1JLzBxelRNVEV0dU1NM3dlbFZTckFIN1Bh?=
 =?utf-8?B?Wm81dGlaSjlVN0NVa1ExRlZjWUpkUVM1anNXMmRIUmJUQlNsUkVGa291MGVC?=
 =?utf-8?B?Ri82YUlvZ3hjbEtpY1FjOER4VXRJVWRzZ0tCNlB2RDVlc0EramFJYUNqbGVj?=
 =?utf-8?B?dHFENWlFMGkzbk9yVkN0K2NYdzZsaXFWdkQwaUpXTnVGTGI4c3FlTVhNVDhJ?=
 =?utf-8?B?ZGNPc2JPU2FYMHJ5aFpaTDkxekVIbzJmcG0zZlVZTG8welhnL09oNWkvV1Nk?=
 =?utf-8?B?RVpYdGVNUWRQNjI2TnRYYWQ0UGFYY1k0TS9Hc2E3bVdsZlZweWd6VHZkY0wy?=
 =?utf-8?B?UVJWL1RXVDBNdVV6U0FrYVRlK1h4cG5DemEybUFWN1BWMWR4NzV6WkE5MTRn?=
 =?utf-8?B?VUJtS2k5NndhbDNQQkNIc1FGd2l6QXA4UGhaNTJZaDF2bXFqeDZRTjlPRUlm?=
 =?utf-8?B?cnkwYWJpUE5XSlZuN2hpRTA2YmdNUXRVaTNVdnJEVFBOcHNVNk1TaGJUcHY0?=
 =?utf-8?B?amMyQjhVTzE3cWpPT3pSK0V0VmNtM2V3OUQxanRBZnRrNG8xR00vS3VjSWlx?=
 =?utf-8?B?SHloRkFCdHlyMWxqK0g0UGFWZEgwN2VkTzZWTy9ob3dnTHF1M1k4QTRXQlBm?=
 =?utf-8?B?UzhMdzB4TUxlRDlBZGdBSkZYaXZRazBsR1pEOUlsbXV6QjhveHJ4WFhKNDRL?=
 =?utf-8?B?WmNnS3ZzWk1RbmU2cjdGOEs2YTlRUEZKQ2dSV0RJZEdmTWpJTHc0WHg0UjlF?=
 =?utf-8?B?dE1ickExejdPaG5UV2FXWEQvenQ0Szc4eU9KQU1jWjh5Y0ZNRCtXWnQ4TjIr?=
 =?utf-8?B?NDMyVlVvdXBUdVRZRGIwV0dBeVI0UklKSHlUeW5rTXRockFPTElwOTJWY3Zz?=
 =?utf-8?B?MDE3VEtxVEMyTUZNMkwzYzloNXI4cXUrUTFxbHdlRWNIYnFua1JleGc2Znk5?=
 =?utf-8?B?d1JYSGZhdEwybXByZXk0VWQyUmpvRTl3dEZWMS9nbEtkVi9wRmFRc2tvMHA2?=
 =?utf-8?B?TDlYQlRqdWJFOXB2bG1QYmtvelMxM29CNGQzY2xuak9scjFWRGVjWThQSklJ?=
 =?utf-8?B?dkMxajhtWS9UbUtEeFFGcXlRQlJ2bW1aTzFsVmRlamFnZDJZK0grOFNKUTRw?=
 =?utf-8?B?YXZaSXZvQk94QXdqZE9sbXpESVJPL0hPam56U0J2SVNaK3Y1c1ZMcUR6dnlj?=
 =?utf-8?B?L3FMbkw3cEFoM3FNZytVMHBHKzZaZ1NQZW0xbkNjMHY5aDB6SzJsMDdFSlUr?=
 =?utf-8?B?R0xMY1ZtdzBMWk0rcFhVa0x1cjFhdjRibVFNcGxPenh0TmQ4RUQ3ZGhLREpi?=
 =?utf-8?B?WlV3SnF0bXA4eE0rQnEzU3RMOTN0K0xOeXk5TXhEdmtvZkQyaWlRaUdRbFFo?=
 =?utf-8?B?MklMa2ZZQ3dRR3oycEV2Y0JmZUtrQjlRajkvZHFxU3lMN2ExTkVNb256UjVM?=
 =?utf-8?B?ZkM3K3FVd3VXL3E5VTVXRkM2UXF2VHlNYXpteEJBUnlyVTRSc3BGNFp6S0hv?=
 =?utf-8?B?ZXdtcUxJKzU2KzlscU5LY0NLNk1kbXFSSU85QzhsUm94bXZHYVdCeXI5MGk1?=
 =?utf-8?B?TElaYXhRaXVJK2kvWVFqMGZ0ZmpRUzR5QWw3TmdGcXVpRWZZR3hSZG1adWZF?=
 =?utf-8?B?Q21vdXl5V2RuMHhsNGhGZWNMcWdVdkdQZWNZUWxUZ0NNQm5odGxiSU53cmxN?=
 =?utf-8?B?UjlxazUxS2JabmFUb3RmYW5Bc2FpZlNHSG1jUGI5cXFrRVgySytTak9JU1Vz?=
 =?utf-8?B?VUE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Hptj7AzhEVGv442H5jFlepEa3l17dH3dnCLBg0OyR3HvSvokeER+ZLIY7/gcwrsJHuhqcgupgrbN+vsDjdQkLWcQ2K/x7u9DgkJL2OxoTbozeC0aodoA/o2Umvh44+ARQsJISmlXY87NZpzo/tXhRYLGjF2ASrbYjSMct9Nqz4oz5FR7lKoSIgQi2HOZnnPUGUUR9HiiRiC/CtCtndiwLAsBHRRxpnVl4T672CvZajRAweYwZtEn0Zm2pKOBMlYa6CeuaNKWFq3bOrmf/PBNwllZKB0BqSn/uYfYZ3vmFSlKblvpCJRseWFKgpwFwpcSoysr/BWT0mnwu/XoifFZpIXvPNLcgkJrK2QYxeOieY703NaWsOySiNK3ABDPrx6o94xPqYhgCQKMZYFMYJbykxUFS4JQJ1AhcLSwIlKf2yrk0rdWGMr8UKLFIvUpS7JN9Kkg9b9WGFRYg/ICHm4MzJ/9Krmi4+22peJRm4mfRSog4GVzLcDd1s1p343mRaFJKH+gKSa4TYkgxbJXtZOi+1WYJkkK5h5TFwl4jH1nwjgEtFkv0BSV/KhotRJs0eU+M0ZPth0oIQ+D9UoMjLDxwFoC5i4V0lYCPhni+RFWhhw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4deb9e7-1ccd-4bee-947f-08dcfdc6b613
X-MS-Exchange-CrossTenant-AuthSource: CY8PR10MB7218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2024 18:21:48.2858
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3I+P4xG2HEGDnPn/3FDNgxsW6qTKkMN0P1STlFgXSx/2zawHRmqxYNArKiSQZ2xwHcyQdd78mV9LI0+ropQhv9tezyK5Owl4RPaCWUNDMWQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR10MB8016
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-05_06,2024-11-05_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 spamscore=0
 mlxlogscore=999 phishscore=0 malwarescore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2411050141
X-Proofpoint-ORIG-GUID: YeXP_BsnTALfAbmwhEX0DnSzdOAnviXY
X-Proofpoint-GUID: YeXP_BsnTALfAbmwhEX0DnSzdOAnviXY

On 11/5/24 8:24 AM, Ard Biesheuvel wrote:
> On Tue, 5 Nov 2024 at 01:52, <ross.philipson@oracle.com> wrote:
>>
>> On 11/2/24 8:22 AM, Jarkko Sakkinen wrote:
>>> This is my alternative patch set to the TPM patches included into
>>> Trenchboot series v11. I don't mind to which tree these are
>>> picked in the end. All the patches also have my sob's, so in that
>>> sense things are also cleared up.
>>>
>>> At least slmodule needs to be patched in the series given that
>>> tpm_chip_set_locality() returns zero on success.
>>>
>>> It is not really my problem but I'm also wondering how the
>>> initialization order is managed. What if e.g. IMA happens to
>>> initialize before slmodule?
>>>
>>> Cc: Daniel P. Smith <dpsmith@apertussolutions.com>
>>> Cc: Ross Philipson <ross.philipson@oracle.com>
>>> Cc: Ard Biesheuvel <ardb@kernel.org>
>>> Cc: Thomas Gleixner <tglx@linutronix.de>
>>>
>>> Daniel P. Smith (2):
>>>     tpm, tpm_tis: Close all localities
>>>     tpm, tpm_tis: Address positive localities in
>>>       tpm_tis_request_locality()
>>>
>>> Ross Philipson (2):
>>>     tpm, tpm_tis: allow to set locality to a different value
>>>     tpm: sysfs: Show locality used by kernel
>>>
>>>    drivers/char/tpm/tpm-chip.c     | 33 ++++++++++++++++++++++++++++++++-
>>>    drivers/char/tpm/tpm-sysfs.c    | 10 ++++++++++
>>>    drivers/char/tpm/tpm_tis_core.c | 18 ++++++++++++++++--
>>>    include/linux/tpm.h             | 10 ++++++++++
>>>    4 files changed, 68 insertions(+), 3 deletions(-)
>>>
>>
>> Jarkko,
>>
>> We have tested with this latest RFC patch set and it does what we need.
>> Things also functioned correctly when we closed down the TXT DRTM and
>> brought up a follow on kernel with kexec. So we are good with dropping
>> our TPM patches and adopting these. The last question is do you want to
>> take these in directly as a standalone patch set or do you want us to
>> submit them with our next patch set (v12)?
>>
>> And for what it is worth if you want it:
>>
>> Tested-by: Ross Philipson <ross.philipson@oracle.com>
>>
> 
> If the patches as proposed work for you, please incorporate them into your v12.

Ok will do, thanks.
Ross


