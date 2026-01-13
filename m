Return-Path: <linux-integrity+bounces-8211-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 34B38D15FBA
	for <lists+linux-integrity@lfdr.de>; Tue, 13 Jan 2026 01:26:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 46C69303C9E3
	for <lists+linux-integrity@lfdr.de>; Tue, 13 Jan 2026 00:22:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E85C221CC5C;
	Tue, 13 Jan 2026 00:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="no6AmeDU";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="KocGlEEs"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E54E722127A;
	Tue, 13 Jan 2026 00:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768263776; cv=fail; b=W1pXIPN397xU8lI3N51oLZNsf5b87eaYOGxWahDWmkfxTHsFwhC5+Xwyszb4DT0xDloroV5F4SaDcxT1HfPSFVpyOJs9YoBCS5b5k397HHjKQEzbFl48H+/ctfSgCfvp263o4rKccokRA1u5rZtsgZyKm9/rfnrJ4+dv5YYaAPM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768263776; c=relaxed/simple;
	bh=a0MP1w9ocP3fTPQZsn09gWuY+4yq/TilOsSw3WNOYLM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Mn2nKMRDvUuRBt19nMMn4xbSVubaiQ6i3zbGozJVGwfIrtJFAYnEtbS3EV0EyPguzjm3ivXy7HB0zRPjKOhS/8OOQz+0Iu+ig76IAalIKbDZZ+FEHWHKGWwp7qvJ9JTw3QKpOiCCu3kLLpccskK1U2KDu/GXQF/z2iOfekdtwOM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=no6AmeDU; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=KocGlEEs; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60CNELpU3089579;
	Tue, 13 Jan 2026 00:22:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=o0NmFcMWg43cnyOQoi/QHhSptlurQ4pocZfi++OFsMw=; b=
	no6AmeDU5DXQMvpgCF5ZqIH2U2nYXl7eEz8ar2RYdPpQCUAmn1sv/1UVrAXkTeDW
	WBqWJHactDDh4/bEy29Jee9uDXurtxeQSqIkKd9Oouz0WlKgD0ph0+hv6T5XWYTU
	nyLzdMN51iD0zbsW8ASf6wJHjIjpwI+ZUYSsROG0uewEVLdPYuEXqIrbDoIrtvwB
	SAmieQ3zGDm0x6zoro4MOPl3fKxohaXnkR7kax/0OpDYeeaUa4EfqKqWHw7oBbEG
	xhvR0p8H9RLF02f8fpr7uqMeVK5o/+0uO9MibwGHAeCojh5EpprC3bSjnI8FBXrr
	IzohypANVELQVDQYIOtZWQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4bkrp8jn2m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 Jan 2026 00:22:36 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 60CN44sm021296;
	Tue, 13 Jan 2026 00:22:36 GMT
Received: from ph8pr06cu001.outbound.protection.outlook.com (mail-westus3azon11012029.outbound.protection.outlook.com [40.107.209.29])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4bkd7btgqc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 Jan 2026 00:22:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=peUV6KDxYzwSoHGa9ljMYVZJMbvNRr2QmZSVWQ/omUm6Qt9kcFZPmN/jENlX9PGObXJsoL2NSEspbbAVemrPUpEzjWiN3+O+trL0cqvUOcWgzB4Lw2goE5iS/V7l5jxaLozYp4tJr6ggXVGVIvcg6ULJxo5Si7rDzTPO4aa3Yq8GOZ0/NJY8I4su5Y4fKhZJ476+W33kt+sObq47fctGz+bY+HFo31hfTpyTBpxc1GifwkM+E8gi7dXd/LpVl45z0tGk3gB5DzJlxGmCpX7fAnk8axKTHd0IR53AFIA7DCylKtetcdu+Ffgru+cZxxUyO8/VTBvkVu/ByJs58v2HGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o0NmFcMWg43cnyOQoi/QHhSptlurQ4pocZfi++OFsMw=;
 b=UOacTEAirkwp8pG5gBkY386e2rwwcpDKZ6g/6uv3x0YPB3bImfabjC6CTJE0s6u3KXRHP4M4TBibCGyEciSQjbwCKikWE4R3D8cqP5E7O7LW784cTBcAkab3hIEGoz4RAxXfUGBheVzN7GKk4dc/wCEPNMhJxp0AQhxRJIqrbSAI1acqBZNKkUQySPxPtQc0MHOhND2dQHyVZUdRklEyWZfcmP/+G3AdlKqu60LgD19sqETNGomULkXZ9VafNCs2quiTOyhwMJToPwjZuZNwu46UgU3Enmx+i6fALhnVioFdjrz9+LXK9nrq5tnRdYTZlujPTBAZ9FZomoJkKjqx1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o0NmFcMWg43cnyOQoi/QHhSptlurQ4pocZfi++OFsMw=;
 b=KocGlEEsq/HPlBxF/Vnj77HARkLJ8jNhOA3ecoOKQRt3OVqOJEsjAChuVBkECMHwp3hQXQt0O3fvW5i6cxxKes+BhWvWr3NcmmePp+IA9mmey3ZhzNZ0flltSQ5gwzlrWDY8NokEA6EaYtKfzmKI0U7LhZIjeCVCkUSQgzIFS7c=
Received: from DS0PR10MB7224.namprd10.prod.outlook.com (2603:10b6:8:f5::14) by
 SN7PR10MB6546.namprd10.prod.outlook.com (2603:10b6:806:2a9::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9499.7; Tue, 13 Jan 2026 00:22:27 +0000
Received: from DS0PR10MB7224.namprd10.prod.outlook.com
 ([fe80::c57:383f:cfb2:47f8]) by DS0PR10MB7224.namprd10.prod.outlook.com
 ([fe80::c57:383f:cfb2:47f8%4]) with mapi id 15.20.9499.005; Tue, 13 Jan 2026
 00:22:27 +0000
Message-ID: <b19c064b-9dfe-45d6-b23d-1bfaca6afb02@oracle.com>
Date: Mon, 12 Jan 2026 16:22:24 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 05/11] tpm2-sessions: Remove AUTH_MAX_NAMES
To: Jarkko Sakkinen <jarkko@kernel.org>, linux-integrity@vger.kernel.org
Cc: Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
        David Howells <dhowells@redhat.com>, Paul Moore <paul@paul-moore.com>,
        James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:KEYS/KEYRINGS" <keyrings@vger.kernel.org>,
        "open list:SECURITY SUBSYSTEM" <linux-security-module@vger.kernel.org>
References: <20251214153808.73831-1-jarkko@kernel.org>
 <20251214153808.73831-6-jarkko@kernel.org>
Content-Language: en-US
From: ross.philipson@oracle.com
In-Reply-To: <20251214153808.73831-6-jarkko@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PH8P220CA0032.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:348::10) To DS0PR10MB7224.namprd10.prod.outlook.com
 (2603:10b6:8:f5::14)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7224:EE_|SN7PR10MB6546:EE_
X-MS-Office365-Filtering-Correlation-Id: 88695e2f-3e3b-4a5c-b8e5-08de5239d4cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OWg3SjNLc3hURFZ3SzA5MTNlejBMeTVQanVhOGN4RDFXekFLaU1BaHBXcnhK?=
 =?utf-8?B?LzRyV2hudjRweDBQWkl4RFVoZkpMSWsxVGE4RFVzM0lqWXFvZGdqQVdZemxZ?=
 =?utf-8?B?NDdaZzdvTlE0UHdJMFQ2eGtFVi9Bb1FHQVRxYVF6cmgvL1dIdEx6dndOSFBE?=
 =?utf-8?B?THNGMjQvMXN5Y0hBYTZsMEVVU1ZCei9tV2tkTjdrd09VT1BTZWdzby84RUhw?=
 =?utf-8?B?S05MRU53UHNCb2pObVhIV1NQaWx0MnM3cmpEYXZmQVJMb1l1ZWU0RkVGeGlh?=
 =?utf-8?B?R2xUU1IxWnlHWFovWDJ1eGdEUGZnKzVPZkhsVGJ4dHdCWTBOejRNczNXR2hY?=
 =?utf-8?B?V1Jab2taYjRHMEV1eGk5N0lxVmRlNXJ5K2VrV1NQaTdrT1FWWWM3bDZTM2pC?=
 =?utf-8?B?VW5JcTd4NEhSS2U5S3E0NTNXbEFrZEVJeERjQWlHOW51RXFiaEMvL2xMWVZa?=
 =?utf-8?B?UDloeTV2YUtPQllmWTJSdzUrY1NSWGUyeE9LR0hyVkxOYkRxaFBjMlNncGhF?=
 =?utf-8?B?aEx3U1REZzNtSlBvMWlnVnlJeG1Eek5ndHBGWkkwN28zdGR5WDBxVzNjL21l?=
 =?utf-8?B?NkwrRFVYRFhPOFlEYkZ1bFpsZmVjcDRSRmNtN29EUGhaS09PbFJGcmtpelV0?=
 =?utf-8?B?cmVNcG03dmg4VEw4YnU3bnFjdzAraVRkNkxCSkphMVEyUDNZd0syZzc4TU5n?=
 =?utf-8?B?cEVROU5hbk8walc5QnZGVW94dTBoNlEwNzJtY2R1a3djU25LZUJONy9pa0ph?=
 =?utf-8?B?a1FabWxJMlg1b2hLRmxpV05wWGtsRWFaZjkwUEpHeE1XTGZnWWxCVGNtZTRq?=
 =?utf-8?B?bU5vRVgzVEdDVjA5U0tRekVOSU9mQkdvaXgvMzArQ0FmTkdhanhONDJ6WkxC?=
 =?utf-8?B?V1hJZGFvRTBxQ0JsbTNHNmR1VjVnUGptcW9hZnF3NThyZVRBZDBtZHExYVFU?=
 =?utf-8?B?amxKdVh0dDhQaWNWdkZuaDB2M0ZoVVQxdEFiRFdvakVrdWk1S2xVcW4yL0Ft?=
 =?utf-8?B?QS9MUWs3dmYwWmdld2FadGVWUFdIM2VWVEtkMkFTK2NyWEZDTDhEbWVqL2lW?=
 =?utf-8?B?SmswbmRpbUNMN21QRzhXa09KUUhad3h4MjZGVUxTVmVabndEdmMzZ3BJWXJM?=
 =?utf-8?B?Q3NOMlA2SDBQamF3MWkwNkIwYTRuOUtmMmlhSVZlM1BXTm11YkJ6RlhhYVhh?=
 =?utf-8?B?RTJsMm9DY2NFYlh3TFhSZkRTWGFwVnJlOGwrcy9LSGdVN1cySDBDbkdMM3Jj?=
 =?utf-8?B?YVdsUUpBQ0Z1M1dmQlN0WEFJcXR6U1lFL09abGZZMUxHWGFnYmprWHdqWnVM?=
 =?utf-8?B?aEVmcXpzd2pQMlU0c3lHd3VGczdWc2ZTb2tuTUZPcEgxZ3hiN2p2RFpVZk1j?=
 =?utf-8?B?TmFoNVdJd3c2aGFVL2syV2hiaXdDekJEbnZzckRsMU9xc3VvZS9lVE9BaEdZ?=
 =?utf-8?B?KzREdlUyL0FkRWVPRmJ5eElIMm1Cb1J2R2pSQ3BwUG9sN3RsUTVoNGNITXNO?=
 =?utf-8?B?di95KzhzYStUODFtMi9vRCtwYjY3NWhDZVA3elBYR0Nhcml3NkpkRWJJWDBM?=
 =?utf-8?B?T2JXNUFsRjhwQ05McFpMNXhzNC9YYlVxUHJMa0JxZitlQkhoN1NEVlhxZnk4?=
 =?utf-8?B?dUtQdTJSMTJ4KzZKbFdiZUJqSyszUXpPOHFYM0NYNm5xenE3aGJibG5MeG1q?=
 =?utf-8?B?dmRqWDBOY0hDdGhQSk5kVGtMbTBLK3AwbEgwclR6MVJjQmdoM3lUenRaWFpC?=
 =?utf-8?B?bk1BSGQ2STM4endQcWp1UnhyTGRZVTk3SjF3UEJjWlJwUmpVbFJsQXk5Y3R3?=
 =?utf-8?B?b0JCanRqR2FXM09ueE1JQXM2QWJYK2FQZFFaazdPeEJ2ZFg0bm00ZVd2NHkx?=
 =?utf-8?B?RkJIS042S1BVSGRnc2hGWTcyMjY2ay9ieTdJZm9FSm05L1dCTGw3ZGsyZG9Q?=
 =?utf-8?Q?PTzNT4ByQ5cUu0FtGKgexRBsIiucqwfX?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7224.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aDZZL29qSE5DUTZqbzdVWEkwQ1AvaGxmSy92NlRsMXA1c1k2Nm9Yam9YOUFV?=
 =?utf-8?B?NURjV3V1QTI0ekZKaW5odWxQc2xIZzdPQjM1TW9sTVFWZWRoZVVTSmlWZGZU?=
 =?utf-8?B?aXM2YkR0SWdkZ1poQjVXeUViUmJtVVJTeHFvMzZzNGNzem9iWDVjWnJPRHFM?=
 =?utf-8?B?RW5rU0VBTU1pMytJWjN3NDJIN3ljUnhGRFMwcVM0QWhXQ1VDeVZZWnpBc1Bp?=
 =?utf-8?B?dTcxbjlpelJpaERWaExwYU9kN2VKaGh4QlpGMlNaQ1BDSVF0Y0l1c2pwSHNt?=
 =?utf-8?B?VlduN1cydy9MTHpiOGd1TlM2ejNFbThEbUcwd1I1MlNERGV2YTdoZ01ySndO?=
 =?utf-8?B?cmU1VVpUdlk5MnkzU3h0TUxORk5LSy9vLzJhc0wzeWR2MmxKRVhjTVRsd0p5?=
 =?utf-8?B?YUp1T1pRbjZnTVpJVVdPblcyaGNhK2h5Y1p4RHh2REdxU3NQa2VMNDM4QS80?=
 =?utf-8?B?bTVRQ1ZxMVlUMkVKL0g1MGdKdkRpWDdTNkVPRW9qZ010WnhMendlcGxHa2Vt?=
 =?utf-8?B?VWZuZjJnMEhTQXhUR3poWUt3Y2RLd3YzbWhCSSs5TVl3cmh5YlRta0NtK05i?=
 =?utf-8?B?Z2tSNVJGVmNsUmJFdFB6Ti9XWXJReDRvb0JsdWI1WFJkT3NlQlhkdURpektx?=
 =?utf-8?B?ZGQzZFlMSmpOK2JVZTdiQXduTnd5aXdCTXRVaHZkYlZmTThzRys0WWN2WWpl?=
 =?utf-8?B?Sk1NM2pNS05JWUp5KzRMcG00SWpFTFBqZkcwTXNsb0xtUEVUNG14bUN3SmpM?=
 =?utf-8?B?QktXazBpTlpvWXlIa0FtUlRZOGJ6Zzgvc3lVTHIzN0N6dnp1TFNlS1RoeDFw?=
 =?utf-8?B?dy9Id1pMeUJhYXNKbmJ2MEMveENWU2p0VVQvSFVrK2Q3cEF0aEVDajhMaUhi?=
 =?utf-8?B?ZTRxaytDNHA5U1dJdTBES1pTbVZNeUYva0FSN0M1VTZKdUh2OHFSWVZDTmV4?=
 =?utf-8?B?cnVGYkZtaXk4NGZ6Z25FOTdXK3VLR0FjUEJXQVBidVJSUVRrbkJhaUxNdlhl?=
 =?utf-8?B?ajMxNmlKVWFHQkEvdXExd0VoZXR2UUordnFEbS9UeHlXRThiSExndW5PdmZY?=
 =?utf-8?B?REtiZzZDajhUaGFvOXZYV2cyWnFJTkh0MktiSnFWQ29ZQVRYWHR2dkNrV0Q4?=
 =?utf-8?B?U3FWUGhiUGl2cEExMFJ1eE5IRUQ4aC9sNTdQRnlmclFGdlU2djlsTUZyLy83?=
 =?utf-8?B?UHRuRCtXc0FVQ0Q1SGtOM3o2aHhvdm5lUG0xS3hyNUNldy9DQ25SdG9OR2w1?=
 =?utf-8?B?OEpQZmtDbTJCVFB6NHB5N00rSXp3Q3FyZmpkZTFNZi9UcTErU2RZT1pVb1Jx?=
 =?utf-8?B?MGhJYTZIdUR4Z00vbmxuN2RFOEl4b1RLYVBxMEVBanh3K3MzK1lIZW1sdHRT?=
 =?utf-8?B?Y2RuUTlOTTkxb29YZ2NWTjZEMldpN3FDNHBWdWVSV0xTK1RNM2dyZkVXUkc1?=
 =?utf-8?B?SXVscjhDa0FKY2U1M0VMK0RERms1ZkpZa1BHRFY1SmRoQ2Y5dUtjWG5FeVdu?=
 =?utf-8?B?SDZSZ0MzbUJmd28rTnBEYUl0TlJNUVNzcTR1ZmpWNy9Od1ZGQlVQbFpJU0V4?=
 =?utf-8?B?dnduWTFjcFlpTzFXd0hXd0YzTktFYzBEY09NVWxTa09ETUp1Nm5rUTRmU3hX?=
 =?utf-8?B?ZGN1VTdNSmNMVWVSQ3d0ZHE4NnhCYStzMnZyVXpSbEowSmYxdGEzOHpNYWJW?=
 =?utf-8?B?dUZadldpVGhRSklXL1hYUlBISVhwY1J6VzhZZ3p0MlFBL1dMRE1Hb0FMdDU1?=
 =?utf-8?B?MnI0U1RiRlhncTB5c0tTcXcwN3pNWnhNUHRrQVRrWWlicjdHazQ4YSs5OThJ?=
 =?utf-8?B?Rk1NT2o5YmYvSEFlemhWY3lSaVE2MVA0SkNSSklnSGVkdjIvUXhkWkQ2Vnh4?=
 =?utf-8?B?MnA1dGVIdzJRVDMvdURFRE1mRHdCTk1ZVE1YclpWdnIyTnNSLzZDN3hvT2NT?=
 =?utf-8?B?L2xvaHdFdlNKNTVQMFJ1VlRJM2J6THNVYzd6ay9Kc0VHbU5iZ3lJVUErSDJE?=
 =?utf-8?B?QXg4K1AxR3Qvcm5Gb3lkbjVtVGJVTXM1dWFyeFRTeFpXbXc5akN5bUJUZUlF?=
 =?utf-8?B?RDIvNE11bi9SSGphbUVvVHhsZDlINU1UT2diVnMyYThiaGludnRYeVc5d29s?=
 =?utf-8?B?MXh1MUI1dXExb3ovRjhVV00yNDVtaGpmWHhqdXMrMllyWTJlK2NRbVlmbHh2?=
 =?utf-8?B?SXVWc00rSHdhZituU1BpWU4zR2lldXlVVWVJWTFhYThHTmlncGh4RVhydFFw?=
 =?utf-8?B?Nms3dHJEK3IzaGVVclNtTjVhZEh0cVNZSnFmelBFVkZkWnNxSFlIOGtScStX?=
 =?utf-8?B?bFlKR1J5RnVwZXhkUHlwbXUvVktZZExXakU2SS8zYnJrUkl2b1Ntc3VOSUdq?=
 =?utf-8?Q?9S9jFiYQFtKABR+4=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	fBe8LGoPRW8YHYB/EG9b97Lp7CPVAhkAc0b5UmRQZnDd0PkIaUkRlYGk5VjqyAry67xb58sJo4vubGxsFNX9VnJ9mey0D+rj3r2THVTfrNRwujPYhY1WqMTobP/U9hZLaacYJw0eV67qzjw81ZjuqVVragWfIU7CcuhMefICpHzaN0XG4WJnMy01gsbAbf+MDvPMAOljNKXXyhTBVwNfs//JmBBQwEi4EElM9XWv7PAaHEydgCITkLYuusn9REAjNSLaKBeHlKmSoKMpppITbqBtu7pO5vF7oMF6grUAPv5+9Hz3c7eGwykGOMvpK7GpOG900ATh56ve8AiCQFk70Hjyj13Pbx6aZ+w3AfxRFkyj1UU9JW+SQTBGOyy9m+bPoDfLufAWM1q23+dOitzO55Ihky3sU3VyzIRn+c5c8Bi2nCXVcdI+y/7yLdC0bD6u2rdnbueiS99MfVFlkufTSChwQi5cw9/2dOyz97h5ucAO1ZaYJPCLmYsbeU6nRWgab/oU3gaeoNOEnv/7z82IZpr+Z43n2hOshxzib54G7AcZZsjajuMEL/ZFF1PVZrTA9lMBQiQgM8hBIjrlUM4UMW+66Eh8ib6sL2DqdzEF9uw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88695e2f-3e3b-4a5c-b8e5-08de5239d4cd
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7224.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2026 00:22:27.2313
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lyBDxGkr1LUBofNFiuPHwDnAcSFvKfbh8yGKMOtQpAn9EmswFJRkJxHbgBdnGENVDO7ScIabuVNkbAipTbPcszgEBBZa53gwG7CPsWdFFxc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6546
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-12_07,2026-01-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 bulkscore=0
 suspectscore=0 spamscore=0 mlxlogscore=999 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2512120000
 definitions=main-2601130001
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTEzMDAwMSBTYWx0ZWRfX38ZinUnQ1bMO
 WMDJhnaREVh+HhX3aIHBawI97ZS3oYqeXKnEr3Mt+9Hd4AMkZFqeeaI8j7cKVCvP53ti+yhgr6w
 rioPJ/AOqtHHbBMKz/fmOGWqT3HBmUedOL3dXwsp4YnH31J/WrsFJHhcTQ34Q0+hRaYcOSxi0lH
 skNnIltKPiErBHPPpl3UfgxvT4sR1P2Sqv4qU3k6yTbjdSe6Y5uafGremrW7R5XoKgnE8oZfKHR
 cMq+WaZR2qDz80bs/ESDUyAVRUk5TlqS1q+F1V1iqHJhOz2w9/NM1JBA0iHote1+UYxSJs/yjdv
 6w/WBqg7fJoC+ZfkznpENXe/fFo0rlqSgchEMeH6itJP0ZY6YmB4HFI+9b1zcV4zafo5lW77X54
 17Oj0Um+jvpXuRJqdbu7QHpF8juGgPK4JfAjod/4wv5PUpfuseFfhPX+vPZQPdcjlzgBZ9fwaPy
 ryJNdIY6E5JHoAmNEnY4PFzHREKihOjkpY5xibDg=
X-Authority-Analysis: v=2.4 cv=YcGwJgRf c=1 sm=1 tr=0 ts=6965904c b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=vUbySO9Y5rIA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=QwYWw1Kfs7qqeFnCQtsA:9 a=QEXdDO2ut3YA:10 cc=ntf
 awl=host:13654
X-Proofpoint-GUID: X8HbUCPy0lFOtSXyoJeEtiNlHPasFzPo
X-Proofpoint-ORIG-GUID: X8HbUCPy0lFOtSXyoJeEtiNlHPasFzPo

On 12/14/25 7:38 AM, Jarkko Sakkinen wrote:
> In all of the call sites only one session is ever append. Thus, reduce
> AUTH_MAX_NAMES, which leads into removing constant completely.
> 
> Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
> ---
>   drivers/char/tpm/tpm2-sessions.c | 31 +++++++++++--------------------
>   1 file changed, 11 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/char/tpm/tpm2-sessions.c b/drivers/char/tpm/tpm2-sessions.c
> index 3bc3c31cf512..37570dc088cf 100644
> --- a/drivers/char/tpm/tpm2-sessions.c
> +++ b/drivers/char/tpm/tpm2-sessions.c
> @@ -72,9 +72,6 @@
>   #include <crypto/sha2.h>
>   #include <crypto/utils.h>
>   
> -/* maximum number of names the TPM must remember for authorization */
> -#define AUTH_MAX_NAMES	3
> -
>   #define AES_KEY_BYTES	AES_KEYSIZE_128
>   #define AES_KEY_BITS	(AES_KEY_BYTES*8)
>   
> @@ -136,8 +133,8 @@ struct tpm2_auth {
>   	 * handle, but they are part of the session by name, which
>   	 * we must compute and remember
>   	 */
> -	u8 name[AUTH_MAX_NAMES][TPM2_MAX_NAME_SIZE];
> -	u16 name_size_tbl[AUTH_MAX_NAMES];
> +	u8 name[TPM2_MAX_NAME_SIZE];
> +	u16 name_size;
>   };
>   
>   #ifdef CONFIG_TCG_TPM2_HMAC
> @@ -261,11 +258,14 @@ EXPORT_SYMBOL_GPL(tpm2_read_public);
>   int tpm_buf_append_name(struct tpm_chip *chip, struct tpm_buf *buf,
>   			u32 handle, u8 *name, u16 name_size)
>   {
> -#ifdef CONFIG_TCG_TPM2_HMAC

Removing CONFIG_TCG_TPM2_HMAC here causes a warning during compile since 
the auth variable is only used in the CONFIG_TCG_TPM2_HMAC block below.

Ross

>   	struct tpm2_auth *auth;
> -	int slot;
>   	int ret;
> -#endif
> +
> +	if (tpm_buf_length(buf) != TPM_HEADER_SIZE) {
> +		dev_err(&chip->dev, "too many handles\n");
> +		ret = -EIO;
> +		goto err;
> +	}
>   
>   	if (!tpm2_chip_auth(chip)) {
>   		tpm_buf_append_handle(chip, buf, handle);
> @@ -273,12 +273,6 @@ int tpm_buf_append_name(struct tpm_chip *chip, struct tpm_buf *buf,
>   	}
>   
>   #ifdef CONFIG_TCG_TPM2_HMAC
> -	slot = (tpm_buf_length(buf) - TPM_HEADER_SIZE) / 4;
> -	if (slot >= AUTH_MAX_NAMES) {
> -		dev_err(&chip->dev, "too many handles\n");
> -		ret = -EIO;
> -		goto err;
> -	}
>   	auth = chip->auth;
>   	if (auth->session != tpm_buf_length(buf)) {
>   		dev_err(&chip->dev, "session state malformed");
> @@ -287,16 +281,14 @@ int tpm_buf_append_name(struct tpm_chip *chip, struct tpm_buf *buf,
>   	}
>   	tpm_buf_append_u32(buf, handle);
>   	auth->session += 4;
> -	memcpy(auth->name[slot], name, name_size);
> -	auth->name_size_tbl[slot] = name_size;
> +	memcpy(auth->name, name, name_size);
> +	auth->name_size = name_size;
>   #endif
>   	return 0;
>   
> -#ifdef CONFIG_TCG_TPM2_HMAC
>   err:
>   	tpm2_end_auth_session(chip);
>   	return ret;
> -#endif
>   }
>   EXPORT_SYMBOL_GPL(tpm_buf_append_name);
>   
> @@ -665,8 +657,7 @@ int tpm_buf_fill_hmac_session(struct tpm_chip *chip, struct tpm_buf *buf)
>   	/* ordinal is already BE */
>   	sha256_update(&sctx, (u8 *)&head->ordinal, sizeof(head->ordinal));
>   	/* add the handle names */
> -	for (i = 0; i < handles; i++)
> -		sha256_update(&sctx, auth->name[i], auth->name_size_tbl[i]);
> +	sha256_update(&sctx, auth->name, auth->name_size);
>   	if (offset_s != tpm_buf_length(buf))
>   		sha256_update(&sctx, &buf->data[offset_s],
>   			      tpm_buf_length(buf) - offset_s);


