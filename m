Return-Path: <linux-integrity+bounces-4021-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AF34E9BBEE6
	for <lists+linux-integrity@lfdr.de>; Mon,  4 Nov 2024 21:41:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 350ED1F219E2
	for <lists+linux-integrity@lfdr.de>; Mon,  4 Nov 2024 20:41:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A343E1E47D8;
	Mon,  4 Nov 2024 20:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="BAhw4W+C";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="uiiRil2y"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 249291CC159;
	Mon,  4 Nov 2024 20:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730752873; cv=fail; b=t9oFA2aUeAeWmDWMM+fq+IQHkt3PdDCNAMJ1iep3bRZrh//CMpl8uqgJBTL/vvHq08rANMKoo0meNX+B6sMEiHerlviwY40gN87XDllPtCsWsZOKWAX9c+LEwKunW6jxBlLOhrBaGH+7oDMiLN874ZucMpFOwNqTbtABI+ejB5k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730752873; c=relaxed/simple;
	bh=acwJheU9HKzD9bxJi/Yi1w/8HosQDG5vuYv2B1o0+MU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=j4iQU2mi7NihtZrtKUdIGglTQt+v70zIVheOnnQzb14DrJ4ItX9TZnMtlqeoSBieURP8UWLlGY+JfnWM9EkU9oPeyjy1Ec3c4hMSSam3gNlpm4uZ0qNwnhjEnNMBi/nbzRB3561EyBuBgNefeLlJHMmr1hDG+YC6b3TaxXbjYh0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=BAhw4W+C; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=uiiRil2y; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A4KMbEw007864;
	Mon, 4 Nov 2024 20:41:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=bxuSecDFpvEYL8vU38o29bc/G+HpEbtW8PGr2McknBQ=; b=
	BAhw4W+CArrlOt3U9fkHvF9xncA2Jg931osO2Wmz8sEA31x9YYFbGqzvE/VYvgsZ
	RIGM14xnIov/EnbUPO4oLH+dbRrNbXuQtIvYdcLgz/noalebpIPm8kvC9v3OK6Rm
	jSWCA6FFSEtHSFsQLRGQYOD8+6gCcwnwsHn0QhwfuKEUC1RBKfW9fye/jmpk+MrY
	jmJa7uvK3ZL8tyGxBudIWcOv35bAsRHHcPi7ux6ityN9QBI3PZ359ojNOBLrohBP
	nvPZYu/uKw37w39eXKHA7Ax5ka4A8OGU/mkgxoyhleD8ZdvmGmjBExuFEa/vdA2C
	x3d3D2zV9oE7ZML9drcvRg==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42nbpskt4x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 04 Nov 2024 20:41:00 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4A4Jn3Ur009083;
	Mon, 4 Nov 2024 20:41:00 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2173.outbound.protection.outlook.com [104.47.59.173])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 42nahcje7a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 04 Nov 2024 20:41:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=El98CR/8BJGNt5Iob0/BMx65fM0EbUlveVjmsmPwwF5niGJRLiu3FKi9hkABU2W/SELnUmKkrId9nGrtfvrkYo5Nn3L4bFAfHT3bPDz4MnJRr6IRPGmLUA5Jr+tSCP8oeSvL8jQPI/MKa0v9CkgIbJX0ezIOnUCQ5J6Ca4c/kubzP7jDB7JKKUUbkTi648oRoEXQFVnBCTf8YG4X7xog57PCwwEljhK00nmRjrOoe6gvXyVJE2YRr5UhXKTPmBd1T7gG0BghbIICJAzJvn98BsNXxW9XQlLZAg7hPtL1A8TAzICoWuZOLN6vhDHdZ3jhNg/oauqA3beyd3Zr97CGEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bxuSecDFpvEYL8vU38o29bc/G+HpEbtW8PGr2McknBQ=;
 b=BHLkSkekU+tmFWdudRwmXL7yVO6V+RNGJMwocMgEucdr2wXoR5knEGLXvBAtuhwbsgqty2oSvxr76NaqBo1Ic4MzaQv+/iATGdA4fPH7NIl19QTR8N+7TebqbDNnd6YNy3X7DaAbPj/OUw1cUQ9XiIv08PsRcv/nxIuv9z7t58R9M/Bb7HVejIynY6x3sU+DMMUJ8duWIeAnwl/8WSU2lgo9egttY80S7XXFtZNSDo/Ao6ATYoqQMrTHtIjm+XdQBG2kX0GWAsdfEc2Y2sgqWAOJnpv0DVxviSU5OSkLQwpXcHt0fE8YJal988Qa/e3ZsXKb/hnv87dZeDW8+f//2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bxuSecDFpvEYL8vU38o29bc/G+HpEbtW8PGr2McknBQ=;
 b=uiiRil2ykx6Ntuo+l8nELtkPoK10LH4AU+JjiwD0GDUw+FrjrR3PV3eb3oBIL4uJp+B7ePnnDu2CY/QAgKoSh7ksSUWJUSaGSA41sUyfJM90GNkjcpXzyMj6OacsXn2mTlGfDikfJLqR0xwayaKd07GGWzyZzHuJhoO/ha66dag=
Received: from DS0PR10MB7224.namprd10.prod.outlook.com (2603:10b6:8:f5::14) by
 CO1PR10MB4788.namprd10.prod.outlook.com (2603:10b6:303:94::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8114.31; Mon, 4 Nov 2024 20:40:57 +0000
Received: from DS0PR10MB7224.namprd10.prod.outlook.com
 ([fe80::c57:383f:cfb2:47f8]) by DS0PR10MB7224.namprd10.prod.outlook.com
 ([fe80::c57:383f:cfb2:47f8%7]) with mapi id 15.20.8114.028; Mon, 4 Nov 2024
 20:40:57 +0000
Message-ID: <dcc1f58d-b514-47e4-9dde-279567196981@oracle.com>
Date: Mon, 4 Nov 2024 12:40:53 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/4] Alternative TPM patches for Trenchboot
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: x86@kernel.org, "Daniel P. Smith" <dpsmith@apertussolutions.com>,
        Ard Biesheuvel <ardb@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
        Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
        "open list:TPM DEVICE DRIVER" <linux-integrity@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20241102152226.2593598-1-jarkko@kernel.org>
Content-Language: en-US
From: ross.philipson@oracle.com
In-Reply-To: <20241102152226.2593598-1-jarkko@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1PR13CA0337.namprd13.prod.outlook.com
 (2603:10b6:208:2c6::12) To DS0PR10MB7224.namprd10.prod.outlook.com
 (2603:10b6:8:f5::14)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7224:EE_|CO1PR10MB4788:EE_
X-MS-Office365-Filtering-Correlation-Id: 16175371-5022-490c-504a-08dcfd10fc11
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZnRISFR1bTBTRzJTMm9WWFBackJER1RZRUZwK0M5RDRROWdPSS9sUExKYUxk?=
 =?utf-8?B?Zkl6SUxEbk5GNU5aTlZSSlB1aGxqWHptQkRGRHlQOWpIajI4UjhINWZ6cS8w?=
 =?utf-8?B?SWpFQzRpSXpGaHZHY1JzOURSSnFmVEN3TDZoazJGRHpkcytvYkxGMEhqOHpt?=
 =?utf-8?B?K3FHMGpXY2lPOCtmZzZtVmVrRmlZT0Q1dVIrUXdaV3k0T1BBSng3TDczbmJ0?=
 =?utf-8?B?VFArYU5RYmlUelBybHd2NzZCRE9lbDlMRGpjcXRvSXlGcGlJN2t2blpQem5J?=
 =?utf-8?B?NGlKcHFRaDd0dDNSbDlOVEY3NUR5Y0F5bVNQczNuMVZLS2lHNWFEYjl6RjFQ?=
 =?utf-8?B?U05vKyt3eUptc1FneE5EK0YwcjdDWkVtZUR5elQzQXhtb3d5ei9vVjJlS2h4?=
 =?utf-8?B?cTJuVFpsQUVaUUl0OFpvZElCbnNScTNVdGU1R3dYY0FDZ3BQY0o1VitLdlk0?=
 =?utf-8?B?b010Zys1Q3grT2s2UkRzOGJvRTlIZ3NhMURpOW5xZU1BRkhZTURaWkhqNUk1?=
 =?utf-8?B?clZsNFN0NHpVK0VFemVyeSt5eXo4azI3UEFXT2F3UnV5bk00dU1XU053WllH?=
 =?utf-8?B?QmFtVVIxZkhsRHlhc2lHSWpBK2xJSHJ1MUNVMUVFdVhCMXNZNm9aY3dUTXRC?=
 =?utf-8?B?bmNvd3NRbkl4Y0dxcVB4YmNqaXEzYjlSNFZmY3AyMkRQTDNsWlp6NkREZjFR?=
 =?utf-8?B?Z1NLMk1uTTE0S1hjZ1ljMlRFb0pjUWliMmhua29UUjUxWTVZZ3NYRlNYQTVL?=
 =?utf-8?B?TmJLYWJxNmJobnhSdVBjVTRZNmd1WHRMOTh2dWFqK3lKU0h0VCt1dGI1cmdE?=
 =?utf-8?B?UGFsc1RGY291cnVETVRRWWc2S3JSUjBGTzgvMFhVa2NSeGlNaWlXcEFFS2VM?=
 =?utf-8?B?UnE1SFAyeHZDWjJmSFB0UGRvTXh1V1VWMFdEV0lSeHF4OFZoRGwrVjJSdHNr?=
 =?utf-8?B?NTdhc2ExTWtRcFlrNHRTN1Q0UUVCT3h0QTNvaEtBa3g0aCtEcHZNNHo0Q3VD?=
 =?utf-8?B?UG1jc2dNVTNMNmFoWVBVRXNkbGk1ODN3Y0RaOUd3NU1TRmlTM2Zya3FnMmh4?=
 =?utf-8?B?dkZidzVBdFFEMkxPSjNsRC9McUxNa2I5bmFBQkVKWUgxdytlMGJ0RysvRUVO?=
 =?utf-8?B?c3ZFNXVyR1BIc0V0cjA2YzUyckwrOU1pMmRvbmt3K0pRZkltS0tmMVM1dWFQ?=
 =?utf-8?B?U2F2eVVONCttdldKeGFKdXZ3Q2ZSYkxhUnJMQ1d3YzlDZ3VhUVNsOUt0cnJL?=
 =?utf-8?B?V1dQS0UxcW1waDNDSFEyd3VxdTg1T0d1SHY4VzkvY0J3c3g4MjRDWnlOLzYr?=
 =?utf-8?B?MmdEWkdSZHU1UjlsNVRZTyttUEtkT1hlbThUa2tScXpuaUlMZ1lQL0RHb2t2?=
 =?utf-8?B?N2FnT0k4QVJRWkFKeWc1Y2R5VkdLbXFJbUdkV2V3RXVMYUpxc2FMNUNieFZl?=
 =?utf-8?B?RGhtU24wTklHekdUWHk0OGRNb1hIV1JDQm5YOVNtWmFSQzdJM1ZwcDByUmhz?=
 =?utf-8?B?L25weC9COVhwOGlTNHo2Q0syM1RVVzhuSzVMNTlSV3dqL0FONWVOSzNOVG5z?=
 =?utf-8?B?M2pCbGl1MmFmQW9SYXVIMytYZzViMnN5ME1tNDBsTUVNT3dkSlNJRDZ6TURz?=
 =?utf-8?B?K0VYSldRWHhTbVFaSERrMWJqRXNYbXF6MCtsS3AxYnNjOGFFRUF3L1gvOGZk?=
 =?utf-8?B?RE9OTld6NUt0Wm1iZkxiamxvQW4raXE4Ry93YlhMRFNUTXQyK24zSGxwcFc0?=
 =?utf-8?Q?8K2qsnau8JUImo8djxXyZlIxovr+XzLnu9Ttc3W?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7224.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aW5veVpkVjkyM1EzZFNhTk9FWWYvdk9nVm9CVGZpaDAvVGZnV2ZsbHlFS2h4?=
 =?utf-8?B?TnVVaXF4K2dHcUlzZkdGcDZrVWg5dmMxQlBsQ2RMT1RIdTFjNWJGelpMaVFC?=
 =?utf-8?B?QmtacmRhM216NFhqYTVqdjhndWtiM2Iya3BkbDJVT3BMdFZBTXVwME1WWmJN?=
 =?utf-8?B?WllkeTFqNTJraHVKalNKanROU01TMzhmclo4R3RHcFpZaHpjc2NLOVRLdWh5?=
 =?utf-8?B?MXlqWjJ4SFJVU09DUmxLVFk0NTZNMnZKRmZpREVNY0pBb2dpdzAzTUltVFlt?=
 =?utf-8?B?NDFXSVdpUjlza3lMa3E0RHhVd0FCbUVSQmRwamNndGtKelB2MEtPOUVIeU0z?=
 =?utf-8?B?NG9IZ3ZQalJLY3liMU4zbS8wQzIrOWZGNDNCbEJKL0thdVRGekp2U3lzZTQx?=
 =?utf-8?B?WldVNitvQmRDYkFlb1hLNWtIbXpjM1ZPYkhRcE44eFRlWXpVWVBsSEhGMHRr?=
 =?utf-8?B?cXlKWXRyQUpsNkQ0ZDFaQW1KcVB4Umo1UDFRbCtTRU1GNy9MM3lkdUhQVTBX?=
 =?utf-8?B?YnUwazZsNkZVNFBlWkw2cnB1MDhWeDRwcGkzR0lZWGFhdG1tU1RsQllFMXZF?=
 =?utf-8?B?RzRoTXF5VC9XNmYxSzFFa1VoVm9rNGNtQnJJeFdaTm0xREo5dzFxYmVhUGxn?=
 =?utf-8?B?L3BXTFlnNmFycWVvMkJJYStERWhTOHZpVlJzSjF3czZQWnFBU1V2ZVVzL21Y?=
 =?utf-8?B?WmRNdFJLQSs3cDFxTERPQm5JUS8vOXo5ME9WS0ZIeEt3d3N5aGI3S2prU3NM?=
 =?utf-8?B?V1JIcG9XczJjWU1rR0IwQjJOcDVuZXlLQ0JxZk9Ub1cvM0RzeStaWkQ5dUc0?=
 =?utf-8?B?a1lWS3Q5eXc0S1BmZGhzeUptVUYvUy9DOWppWURkOEw4QWM2S1hTbVlsUWJy?=
 =?utf-8?B?a0lhR0RaZGJLZTUrZ0pPbWZVYzd3UFlGNE9VWnp4Z0cwNFJiU0k0djhOMlY0?=
 =?utf-8?B?dnJ0bHMycDA4ZFRSakVCU0lVcTJUTDhmK0VkTjM3SVhtRzJZR0lIMmp6bnc1?=
 =?utf-8?B?Y0tNU0R0S09lbXh2VHVPNG53Y3BSVWo4TXN4MGtKOFhQVExkQ2lRNklQZm1m?=
 =?utf-8?B?Y0tXbHFoWWxnWUEvQ05IRUg4N3RrdmZTT2V5NVhYL1FyWXBTK3pHcEI5Tjln?=
 =?utf-8?B?TEV5VmF4OXZ2WG5HU2VuNFhFaGdRejdPR2dnVVY3bUovM3dkU3VqclRWVDQ1?=
 =?utf-8?B?Y0lUYzlkcGFqZnV0dVN2bEtaRlQ3Q2FWSGpVU0xHV205bmczWVpqV0hIQmhu?=
 =?utf-8?B?K0dhd0dYYnVjSlJWd0hnbEdycEVuSFVFQXo0QzFOOUtLTnpRNTF6Tlp3UXhH?=
 =?utf-8?B?dm9jMGdBQjZUSVowaUNUTWlsdXBvV2VDYXhRNjF4cUFOS3dVTFBOZ1B3UmhW?=
 =?utf-8?B?dldyRS9MRGFOSWdCMUVIOVBGZWM2bGx6MGUrZ3JyNTMzanVzWERZMEJYMmRp?=
 =?utf-8?B?WWxKWXd1UlNzaHhxekdGZVEyRzd6YWl1U0hodm4wOXNCblR6SElMSXd0akk3?=
 =?utf-8?B?ZldVelQ5dVcva0wrRVJJaEQ5cmdjYUhDMDVqZ1ZIT2JKN3NuemE5dFA1b0xu?=
 =?utf-8?B?RGhPcjBibGlXVHlIZUd2ZitoT1JpOEl1RjdNV2UwYm9wdzQ5VTRJM3hXb3lr?=
 =?utf-8?B?MzBuVVU5cmNsUThsQjJpUjZtUUZGc0VrVkVzeFhnakVReTRZNmtPNW5sUU9N?=
 =?utf-8?B?MW00dHpLVitpZjBQUmlzaVZxU3RQU0FhdzdyUDQ2Qm9lWUJrUXFUTjVqTWVD?=
 =?utf-8?B?OURRcXdnNHJMR0JJbG9jUlhYNmM2alV0M0JEMWZMUlpvdTkvdlFsbFVQRy9G?=
 =?utf-8?B?czYyalk4VFFnR0duUllaNkF0aDVuRmR6cVFZaFBOS3JENW5hSjd1cWFudW5v?=
 =?utf-8?B?UWVWbWhQNktNZmZZWjBqZWZibTVVQllmL0hwM2ZPWjFJNEc5S2ZDZEdsZFpz?=
 =?utf-8?B?M3N0NVA0NW1UZ0F2MXhXUVdtR3ltWDNEUW8zNGxTalQvaVZXS0FHelJ2eXNX?=
 =?utf-8?B?N3RqcFRaV2kyV0o4aGF3OXBjT05hU3BvdUlzUGVINHNuSVMyQW1WVkRQRW9t?=
 =?utf-8?B?VllQTDVrOW5TOUFMR1lMOGpyVm10Z21SQVVkWlliYm10VFNGc2N2aHdmMytz?=
 =?utf-8?B?UU1mNFRRakh1ckxmVlRxbllNbnpSWTFlYXFPdFhZTnNFS1hvcU5BK21VVXdO?=
 =?utf-8?B?Q3c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	o4bXNTN8Y/kEmQvf97zhYtVpFFNF/F0xXElF8g29gxowTenJgXIX52by7poFbZW5EDt1gk8LlA1YjcJEeGOofpSKaeMT2mKOR9mwP8wsvpNUVvPs5ErDWSraJZU2Vl+smWcXPIBRprSOUrVabi8vbPBBNFS/ph0vM4jP2zd9r0E+7kknJrg3ULaFL++09LOuO0M5RJjvL4BFfjucvbtkvtlsHc04woNdUN+FWqKifRXH9ik4QpM8j5qRbTx0BcA0UNaYheByjrfP6kXEsJvVxoxegIVnJ0ER/HodyJtoF1f7sBcvru7F+27FUSnLxO/h3K3mc1MiyAs+Bzo6htZ2D80mQiSkh86WbJlnohtlQdj0zp0nZJNEmJ9DBaGYVmn/AoQ25yPI9x5CHvfc5qxD6slp7xp4qSY0/VZNhXnudF4afmTeMXZSGoGJcPkpgJ+nRGU3lVThvVepKl5kI3a5BD0+1+FcXTl6JgfS/L/Ph9O1YwoHD7fI+CIlrkLMBjXTTdUjfvRsmP6lCbrWf/y+34p8kyCd/nvcpnZ+FAGSQr6gq3KZzx0wRTc3VzwGGbsXJWK0iKuvlQHUP0DXqw7YlMLC+JtqaZZRrJ/K5+IkQIs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16175371-5022-490c-504a-08dcfd10fc11
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7224.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2024 20:40:57.1631
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +kRw3rMjUNFUzdQLMTpa0bjgz9fq5euLbkQ+IsInCyB56rY/CFYoqD8IyogmBcbhrF659D42TIuvItujqLj8eR2hVNLktUu6AgacH8Yejfs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4788
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-04_18,2024-11-04_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 mlxlogscore=999 mlxscore=0 suspectscore=0 bulkscore=0 malwarescore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2411040166
X-Proofpoint-ORIG-GUID: 76Z9MF5ew6U05IPgQtPEXPXbChilKlZT
X-Proofpoint-GUID: 76Z9MF5ew6U05IPgQtPEXPXbChilKlZT

On 11/2/24 8:22 AM, Jarkko Sakkinen wrote:
> This is my alternative patch set to the TPM patches included into
> Trenchboot series v11. I don't mind to which tree these are
> picked in the end. All the patches also have my sob's, so in that
> sense things are also cleared up.
> 
> At least slmodule needs to be patched in the series given that
> tpm_chip_set_locality() returns zero on success.
> 
> It is not really my problem but I'm also wondering how the
> initialization order is managed. What if e.g. IMA happens to
> initialize before slmodule?
> 
> Cc: Daniel P. Smith <dpsmith@apertussolutions.com>
> Cc: Ross Philipson <ross.philipson@oracle.com>
> Cc: Ard Biesheuvel <ardb@kernel.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> 
> Daniel P. Smith (2):
>    tpm, tpm_tis: Close all localities
>    tpm, tpm_tis: Address positive localities in
>      tpm_tis_request_locality()
> 
> Ross Philipson (2):
>    tpm, tpm_tis: allow to set locality to a different value
>    tpm: sysfs: Show locality used by kernel
> 
>   drivers/char/tpm/tpm-chip.c     | 33 ++++++++++++++++++++++++++++++++-
>   drivers/char/tpm/tpm-sysfs.c    | 10 ++++++++++
>   drivers/char/tpm/tpm_tis_core.c | 18 ++++++++++++++++--
>   include/linux/tpm.h             | 10 ++++++++++
>   4 files changed, 68 insertions(+), 3 deletions(-)
> 

Jarkko,

Thank you for your efforts here - we appreciate it. I am testing your 
proposed patch set to see if it meets our needs and if we don't run into 
the earlier problem of leaving the TPM in a bad state when kexec'ing the 
next kernel.

Ross

