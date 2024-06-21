Return-Path: <linux-integrity+bounces-2917-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3305791309E
	for <lists+linux-integrity@lfdr.de>; Sat, 22 Jun 2024 00:56:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 55F261C21051
	for <lists+linux-integrity@lfdr.de>; Fri, 21 Jun 2024 22:56:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A938415D1;
	Fri, 21 Jun 2024 22:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="FsT4B4F1";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="fscvPpDl"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C687E16DEC7
	for <linux-integrity@vger.kernel.org>; Fri, 21 Jun 2024 22:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719010609; cv=fail; b=ctHog5YpsaVpgMnI4vZoEnNuPghx3EOuAbaQLFBWt6eR0UYqBeYjIeDFMARBjYZhYiPZWgY5nFk5dnLN3iSGNnCEGjvPcWmL6DWhfKJP4qy4/uKOtT+rrmpthH8/rMBEqDqP2YXAMhLwJP0aXejm3JB3jOvh7KApdNcBHo8dpF8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719010609; c=relaxed/simple;
	bh=QtYUgE9awo/1LmrUvPM0F+gxJknvawdvF5dBbREMtwQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=PyDIVNEGXPh2/3ZQpNfjUOuKzWcrYu5HiMn0mF0Gn+9SGCabqOW77Q45HMz4sJejx2JoytgBk3sxquDGtvJTj00za34CUa6JUJ0zZL57NCTeI6j0uSjJGK2BH4Zw9AAPjs+O4JZdXeZC2/vmTG9hX9ZoEkfZwYe0iiDaL7w+gas=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=FsT4B4F1; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=fscvPpDl; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45LEXb2u016937;
	Fri, 21 Jun 2024 22:56:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=BnJMBRsTXfKnthAzMTCuFm0KIP+KGmaC5zvbPhzUXvA=; b=
	FsT4B4F1cXOof2WKu56DJ8a1pdqMacj434C55WPnK8nuwrKjF074zGqP4fG7jWSP
	enSS935/+bZY1PHimtINisM4L+4msntsbUti4JzYQX0qXsOzCQR2NdXcTKxQj2eK
	PzWjjs3ImIZnfVz6Axgv6iUHjxPx0kgcj7hciVRDrw/cfm/MQ4YYTPVhH++a3u2/
	civlXWBmRGUtIsEF9KqTmsdh59IAGOaE7F6i8NLh5AQCOXyMlKSLU8m0T8hUajDq
	Yq7kDT5jJhA021MBtkKVfLz2sr0MS4jz09azwyu/88hfAygGvbqqyfubx+2g34VH
	CDAtW08ASkD0tizh7ToCHw==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3yvrkgtpq9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Jun 2024 22:56:40 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 45LKeJ8p039931;
	Fri, 21 Jun 2024 22:56:39 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2049.outbound.protection.outlook.com [104.47.70.49])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3yvrn4wdh5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Jun 2024 22:56:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GcE3TuvCUmL58aHeTraWx2K93z9y7pMknowlYIZoyDGAL9J4aUtNzwm+CeXh+5DRF49fdF91+O77Drm7u1uaMLOYnZgbfj5yLCOXHF4F0tIindQA3u207dfPfcSvgSr3KBaduZOMpkC1TJ3Vrac2LpcY8ie/1MqkUjU3LDVCM8WjvGDFS7TxM8k2O6N0lMhDmOpY0FWWx7LhMElCyU3XF7eOX9Xd1UWMqnAA4FPFQBmh/gmX0gPJ+ur6hQA1hGQXfWREQyaXH4lAcG9sFKcdGv+X5pOojX1CxAIK8RfpXBaMrCSj0ndqguYtKTUXDO5wEoyEll1q8V8CmVOjGTdYVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BnJMBRsTXfKnthAzMTCuFm0KIP+KGmaC5zvbPhzUXvA=;
 b=GhiN2CcISXRpuf5LvAWWJKN3IS8ZNfoyDdXrs0zHvKX2z7WVs59IuhHk7f3eTlsgIKX0nO6L2RdgC0iXkwYlafGZ4feudqg6DW2hSWTRV99kioohBWBmEiBI5+6dZCKBiq2llj3/RK1DDYTh1wmiQGqktgHFo7oIkcHppcxRmNTMTmxdBjOqyyLC/8mOjE9MslELtiCuacwzqxfKGNEjix2+cQvscS9X1tQxZLNYKWupGr2x/M4YhAJGVNTD2CyqnEvfJGaAeXyxeR795+3yVq2FUh1edUbouBhfJNn9ski2Qq/HiTmi1+DojveSpbcEEnMpd4PBBxQ7d9LSnXQimQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BnJMBRsTXfKnthAzMTCuFm0KIP+KGmaC5zvbPhzUXvA=;
 b=fscvPpDlsvzDTMZxsHBEyfegA34z1GVzswVGCrfV8vuX/zV7TG+elAptT7Fr8oRE77erLW97DP6Tz6ZrHaCtHcgRuIUBopUBfq60egkDZINwJUNkMPKi4nTpKPAu4PWNuxutQVDUfqoxfVjpApL0d0ybqrHW+Ys9esGcEFZiPXU=
Received: from DM6PR10MB3817.namprd10.prod.outlook.com (2603:10b6:5:1fd::22)
 by SA2PR10MB4555.namprd10.prod.outlook.com (2603:10b6:806:115::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.22; Fri, 21 Jun
 2024 22:56:36 +0000
Received: from DM6PR10MB3817.namprd10.prod.outlook.com
 ([fe80::a996:a7a7:bc4c:b960]) by DM6PR10MB3817.namprd10.prod.outlook.com
 ([fe80::a996:a7a7:bc4c:b960%4]) with mapi id 15.20.7698.017; Fri, 21 Jun 2024
 22:56:36 +0000
Message-ID: <f5476da1-08c4-4c04-8e59-588688de9b83@oracle.com>
Date: Fri, 21 Jun 2024 15:56:33 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ] ima: fix buffer overrun in ima_eventdigest_init_common
To: Mimi Zohar <zohar@linux.ibm.com>, roberto.sassu@huawei.com,
        dmitry.kasatkin@gmail.com
Cc: eric.snowberg@oracle.com, linux-integrity@vger.kernel.org
References: <20240620194632.3996068-1-samasth.norway.ananda@oracle.com>
 <e667feaa37e186a2a240ca70c994c27e88724876.camel@linux.ibm.com>
Content-Language: en-US
From: samasth.norway.ananda@oracle.com
In-Reply-To: <e667feaa37e186a2a240ca70c994c27e88724876.camel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR11CA0086.namprd11.prod.outlook.com
 (2603:10b6:a03:f4::27) To DM6PR10MB3817.namprd10.prod.outlook.com
 (2603:10b6:5:1fd::22)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB3817:EE_|SA2PR10MB4555:EE_
X-MS-Office365-Filtering-Correlation-Id: 78e8f834-8bfc-4583-3888-08dc9245675b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|366013|376011|1800799021;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?UnV2aXNHK21TaFZ0QXUxUkVxb0pEd0Y1ODJocXlJbXNUSytoUkVocnF6SmtL?=
 =?utf-8?B?YnhmdWxwaUMvdi9VZmZBYm4vZWhxSXp2L3FhbWsweENHbkkxNjdxZEoyQzBJ?=
 =?utf-8?B?QWJpaHh3K2lUemJpR2g2cFlXRW4vYklrckxQWEptR2dJK0NnTW5GMThEUmlv?=
 =?utf-8?B?eElGTEpzMVgwYTFsWEVTMEJHZnBzVk9EYUhCcWRsYW9BTFlQM1BBUStLT3Fm?=
 =?utf-8?B?a3ZuY2lSVWVCZFc5S3FxK0FKeWVVSXpzd3BMNGE1Y0lPV242b0taWjFxcmw3?=
 =?utf-8?B?ZEFMVFBlQVNwQ1ZDQ2YvN2V3ekpKelpKZmMxQ2M4b1NVSUxaN3NqMFlXOWpG?=
 =?utf-8?B?cCt6NG9RZk0vZTdtWTFhYXB6TDBYSU9UN2RDK0hsdHArelYxYnh3N2k0T0I1?=
 =?utf-8?B?YjFSNjVJT2Z3bkNkY2FVeXJLa1VlcHhxUEoyVTZDTnRwa2oyNEpPZ1hodFFm?=
 =?utf-8?B?VU9ZOUk4S3hZUHpCd1hlazF4UEt1bjVjTUpqU0JUR21yajgyR2liaFJNV2Q0?=
 =?utf-8?B?T0VZTldDcHB4T1VkNlNNOU9DU01QTzZ5dDAvQzRCRUhpN1FvZHFBSE56RU5T?=
 =?utf-8?B?UWkyV0xtWURiM0N6dzNKRFNMZmhRTkR2K3pRd2NKVmtXN1VGcDJkTzd5VU9x?=
 =?utf-8?B?dUE0LzVPbmplVlVQRnFYZEZDcVU3dklKdXBlczBSMWs2Vkx5S3czelZKWVMr?=
 =?utf-8?B?UVVaV3pYaDVCcVYzL2tQRzlSSHdBcURiZ1lBWWY0a1pmUDRNL0RUL3oraTVY?=
 =?utf-8?B?OUV5cU5QbjVXOHkrQlpESTJiYzRIRUtKWDNjNU0wWm1JdklRREgxbnNGK2Q5?=
 =?utf-8?B?Tm4wellKL2pSWitOVmlPLzdaQXNaS3lxcjVJTFpFejZNMlJRb3FZVE94ZVJ0?=
 =?utf-8?B?NEg4TGhYZzFlNkxMRHlTYkR0azVoTFpLYmdZY2NzMTBBV2lPUWtaVUVnbWl5?=
 =?utf-8?B?R2wyK2dhZ3YxOWRqY0NpQ2FZT1hHbXRKZGZrTUJWR2l0NnpLRkdHVzdxV1pt?=
 =?utf-8?B?VGVrSjR2dWR0bTF5bnM3Z3ArTzdURzkwV0ExVTRSaGNtdkM1T2w3UDl1bFN4?=
 =?utf-8?B?ZHBwLzBQTmRBc2lSaHhlMFlIc0t1NVA3UVpqYXR6U2xjcC82QzVPL0l2bUU3?=
 =?utf-8?B?Nm12ZjJvZWxURVlWZFUzYWxqOFYwVzR2cDgzUWRabmEvYy83empUa1BPL3pQ?=
 =?utf-8?B?bndFL0Q0cGtBclduVlFHdzJvcTM0clk0ZTkxYUVPbmZnY3NoeWhvcm43aHFw?=
 =?utf-8?B?c2cyVkdYK0kwRC9BVEJOMlFoTTFaSkxsbFNXQmFCSWhZc1Y5b2VCQWxMOHlL?=
 =?utf-8?B?cEpkNFVpbWVJUXlUc2xvZU5xN012Vy9FMElFT0R5TG1rTWJ5cTJNbnRrVDYr?=
 =?utf-8?B?bTlDRWlPVHNvWTdJNnB5RS9tMkx6bHBlQ2V3YTNzSVhKTmt5RDR2aFZYLzBq?=
 =?utf-8?B?Wk12NEZFdHpOc0loYk9BT0Q5MUM3RU81bFJSMGxoM3Bkcy9meXl2ZmcxVnZ3?=
 =?utf-8?B?MmNFM01MdWIyVTExT1lXVS9NWS9jQmNIR2pFWis2c1AydWRJaG9WTTdmOXJl?=
 =?utf-8?B?c08zUmR3SnMwTVFKcVd4ZFBNa2N1VXVEVGw0S2lWZE5iTDhMdUVIZFhBU2ZV?=
 =?utf-8?B?WFlZTWwxS2VudnJuQnhXS0JqWWx5OEhqaUtpT2pobnBSQlhhMEZ6ZFFqUXdP?=
 =?utf-8?Q?l+v9VbG26dffI6BMU12d?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB3817.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(366013)(376011)(1800799021);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?OTI4emgxQUZaQzB2WXpkNnQxYy9FUHE1Y3pxQlUya2JZaE1objVKd1lwVExI?=
 =?utf-8?B?Z3VJdGlNYU94VGpUVjhZaE1uUVltV045ZVdaaVRYSXdXWGgxaEY2bkZLWnF2?=
 =?utf-8?B?TU1YNnJoaEtTS2JlNzBBNVIxS0g1UDJJRk1aNUtQNHJiSjY3RXl5b0ZxTFVm?=
 =?utf-8?B?QTJKSHNLcnRJbzdmN2licEcyTy9CcEd2aGNrTEJnbC9jakFndTdSejVRQmRl?=
 =?utf-8?B?K0FVOVoyOC93bnI0K2VmRzJHRHpsNnluVWtGZlA1T1E1Y1VMVzRsL25DdzJ6?=
 =?utf-8?B?RXlKRldjZm92dkFxc2hTYjZKNTg4RXE2MEE5NCt3bEpmZXBDRGw0SFdpVmpG?=
 =?utf-8?B?RnFGcllyZkJqeUtTSUR5a0U3KzFqb0VETm9CQTA3ODlxcXYxQStsamFjSjZ5?=
 =?utf-8?B?R2pGVEZXTGNpZlFmNWQvdGFMVEx1aWJWM2FFVExLNWhvdTNGSjNmcEpneUVB?=
 =?utf-8?B?MEN0VmVEOGxpRklBM1dpMlIxNXprVThwYXZWRUlhWjYyalIyNDFudVBWNE03?=
 =?utf-8?B?QUR5R1lidEwzWXkxek51MHZzbjdSWU5iVjJmNWFOV0I1Vnh4R1Rua011dGlS?=
 =?utf-8?B?ZWpoS3FQS1RKYjIvTmNuc1RFdExNUVU5MGtJUndaang2bkJrbTBEaGQ1OU1I?=
 =?utf-8?B?My9WaWY5ZFhCMXo2YWlJY0x0cmc0VXFJNmUyUC9YRW9DaDhEQTJvTURDdG5r?=
 =?utf-8?B?YklaQkUxU3RNWE4yYkRxSDhxNmdpTHVLWTA1SEhZQ3ZnQXgwZkMybmUvNndR?=
 =?utf-8?B?NzF0bFBUdC9nMmZMYjZVUGY5TW5HR09iU2gxaEFBRlMweHlSNE9DZ2FqQ0dk?=
 =?utf-8?B?RnBveTNWdVJMVHNmQnpBOFVjQ3MwM2xQdXBoOGRMT3BOcWVWVWdMSW5NYmUz?=
 =?utf-8?B?L3ZuM1FtOWZzV2RaSE9yS2x0cWwzdHZaeDc4Z2lOQUphcE5GRUwydjN2Zmho?=
 =?utf-8?B?L3lRWGs3YlBhdXNyL01SY2IrWC9WOEs4S1FrTHVLcnRaM1BOc25LSkhqZjZK?=
 =?utf-8?B?Vkw1Yk0wUzArWFdYY2pkcUVNYlB6dWpHMk84UHVHSzljMjNSN2V3NVZEdVIw?=
 =?utf-8?B?TGo0Z3hiK0djMEhnYzNVeWZnbUtLYkM1YVU0NUhHam01N294cVA0aEJ1R0xL?=
 =?utf-8?B?WTJTRnBJL2tWQzRaeThLTTZJcUNOc2xZSEpkczdqanVLNnVMZlk4U3JNZ3ZB?=
 =?utf-8?B?RXRXY1cyWkxDTElWMWExY29VcnJDTW9YZ2IrMTRpZGU1QUUzOG01dVNZallz?=
 =?utf-8?B?dHhhVnZHSmdsRm91L1FlYXlCUlpYL1R3elVYWm9kR005SGV2RktpY3l6OXZn?=
 =?utf-8?B?bzdLUnVQTGtZRnhkQ0V3TGVXVmpiYnZsMVFwVVFXQmFGakNFbmtTVG5tQS9p?=
 =?utf-8?B?bk5nRDYwZ3dqVXJpaXRmdHgvaytxSEI3RGxLc2R2MDFDUURsUDdLZjZrYWt5?=
 =?utf-8?B?VGZTck1UZW13bW9EdFovcWs4a2tLemtlcForcCt0ZklsMTFqZ0tMYzY5Zmlv?=
 =?utf-8?B?OHFndlkxUnhnMllvdjZWOFd0WU9PS2JIb1RMUVFUMmJTVzl6REVlZFpJY3dk?=
 =?utf-8?B?Q2pWclZuR21WT0VVRlRmRnd4elA3TlZVVWZSaVlmMzNkb3VJSFpvcjcwMjFQ?=
 =?utf-8?B?Mlh6cjRiR08wZm1Rb3AzODB5cWZqWmxCZFppMkM2WEl5ZnRNMjlkTWZvMXpq?=
 =?utf-8?B?eUtiYjlRUnlsQ2F4RGFUVk1lV2RDVUxib0lXN0lQSi9QYUdZMzllK3FxUktF?=
 =?utf-8?B?SzFLYm5DanVMVXdqSVczRXR6dE9QekFHcFg0ODU0c3ErcnZEOGhrQ3VhNXBy?=
 =?utf-8?B?M0QzYTVtN092cVhyL1dxTjAwYXd6UVJVQVE5RUg2ZVB4b0kxSW9CdUl0L0tp?=
 =?utf-8?B?TjBQYW80TVlvV0V3Wll3Umpkb3NIb1dwRVZTNGh2QW9PS2V3ZHp4N3ZXTjBP?=
 =?utf-8?B?L1hoT1plYkh3UE8wNDBUK3RFd1o5SUhORzVnNkUwdngvWnRnemc1by8rVUo0?=
 =?utf-8?B?by9Rb2V5U1k0Q2NNQi85eXZ4VzVobkNsT3E0MEJ0R0Z2YnhadkRZWnhCOFR0?=
 =?utf-8?B?SmNGRERLVFg2dDdsbGlLaXNFeDkzMUdkYnlkN3l1Sld1cjRTTGRoaGpGQWRj?=
 =?utf-8?B?Qi91ck50Y3ZPMDNaSWN1QnhRN1Q3bTVZRUZ5aDBZVDU0UjA2Y3JUekJFSC9Q?=
 =?utf-8?Q?Rh3I0kJJw9d2QWMWKTWpbP0=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	hsH83sj29mQOzKrm9y89EGDfGf2WBXUpCr2hglrTDnx5mj3qA1pwlSXRJ8ClFxQKjZdX32bLbAPFq7MRZEupF7/xifW8MlZAEKHC8xqTYsLjm5eZd6SeFyJTB7qmES8jQpPdA9Pi0AKime2ElZsE2aHnZU8sbw/Y+3xuFPSr2zEf0GM+kljuDZsqGAfuYpEElivCzH/6PvSZaMVd89YFU/gE04cx9E4GC3LeYe04vrl4Mh+45WbstpleJSgc7WUoJ97xM7pETPNmrCHVBHLdFRWjeEaaoEFtyDIlb0uECIQmXKKwheO45oRxPOlCTAFvQaQ+91NpZgzsQh/7jd4HJ1+sfqD3t+2PSguiJV24pkZL6bPNZQpw+zLjJ+7MPH1pWm2IUVn6EQ+z2L+DjViEyts8INYFKjiwjsFc3VKh5yjgZg04XA3Lp4g8a7lZPFcpwlyCjmkCGKV6bWnti0WewjIVmBolTp43rHzrz2OjpJVtu8NHJEfPE5f7LoBm7nF1T2Dk+cYRR6W1ofQCQSMWxIxim1FK1nzvW6VLvRBCx0u48Of6WVdwlsAJRIVHYravhLg01QbCTJm3SIm51eCjawbKCTHts31JfJtF0V/gNac=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78e8f834-8bfc-4583-3888-08dc9245675b
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB3817.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2024 22:56:36.6429
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pW3Pp3oC8mu0ZpoYIarUSwXURKU3n9JBZJL77RAHMI/zrUA9WDZtJFRmZG69qVO3RafI/cs6bDsIdDSrwjzFA2iZssiMckJetElcQULB+2xbJO3kVNnAN+rlXc31JG6N
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4555
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-21_12,2024-06-21_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 spamscore=0 mlxlogscore=999 adultscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2406180000 definitions=main-2406210167
X-Proofpoint-GUID: c-pHeCkatloGiLrfkFmbnKIiBj-POs6m
X-Proofpoint-ORIG-GUID: c-pHeCkatloGiLrfkFmbnKIiBj-POs6m



On 6/21/24 3:44 PM, Mimi Zohar wrote:
> Hi Samasth,
> 
> On Thu, 2024-06-20 at 12:46 -0700, Samasth Norway Ananda wrote:
>> Function ima_eventdigest_init() can call ima_eventdigest_init_common()
>> with HASH_ALGO__LAST which is then used to access the array
>> hash_digest_size[] leading to buffer overrun. Have a conditional
>> statement to handle this.
> 
> The original 'ima' template ("d|n") digest is not prefixed with the digest
> algorithm, since it is hard coded to sha1.  ima_eventdigest_init() intentionally
> calls ima_eventdigest_init_common() with HASH_ALGO__LAST.  To avoid ...
> 
>>
>> Fixes: 9fab303a2cb3 ("ima: fix violation measurement list record")
>> Signed-off-by: Samasth Norway Ananda <samasth.norway.ananda@oracle.com>
>> ---
>>   security/integrity/ima/ima_template_lib.c | 8 ++++++--
>>   1 file changed, 6 insertions(+), 2 deletions(-)
>>
>> diff --git a/security/integrity/ima/ima_template_lib.c b/security/integrity/ima/ima_template_lib.c
>> index 4183956c53af..14c000fe8312 100644
>> --- a/security/integrity/ima/ima_template_lib.c
>> +++ b/security/integrity/ima/ima_template_lib.c
>> @@ -320,13 +320,17 @@ static int ima_eventdigest_init_common(const u8 *digest, u32 digestsize,
>>   
>>   	if (digest)
> 
> Please add a brace after "digest" and before "else".
> 
> Refer to the section titled "3) Placing Braces and Spaces" in "
> https://www.kernel.org/doc/html/v4.10/process/coding-style.html.
> 
> 
>>   		memcpy(buffer + offset, digest, digestsize);
>> -	else
>> +	else {
>>   		/*
>>   		 * If digest is NULL, the event being recorded is a violation.
>>   		 * Make room for the digest by increasing the offset by the
>>   		 * hash algorithm digest size.
>>   		 */
> 
> Please update the comment to reflect the case when the hash algorithm isn't
> specified.
> 
>> -		offset += hash_digest_size[hash_algo];
>> +		if (hash_algo < HASH_ALGO__LAST)
>> +                        offset += hash_digest_size[hash_algo];
>> +               else
>> +                        offset += IMA_DIGEST_SIZE;
>> +	}
>>   
>>   	return ima_write_template_field_data(buffer, offset + digestsize,
>>   					     fmt, field_data);
> 
> Please fix the other scripts/checkpatch.pl complaints.

Thanks for correcting me Mimi. I should have checked that before 
sending. I will make the changes and send a v2 of the patch.

> 
> thanks,
> 
> Mimi
> 

