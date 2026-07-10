Return-Path: <linux-integrity+bounces-9908-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id VeVbDzb6UGpw9QIAu9opvQ
	(envelope-from <linux-integrity+bounces-9908-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Fri, 10 Jul 2026 15:57:10 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E9C873B7F7
	for <lists+linux-integrity@lfdr.de>; Fri, 10 Jul 2026 15:57:09 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "linux-integrity+bounces-9908-lists+linux-integrity=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-integrity+bounces-9908-lists+linux-integrity=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1FA6A303027C
	for <lists+linux-integrity@lfdr.de>; Fri, 10 Jul 2026 13:56:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35BD526ED45;
	Fri, 10 Jul 2026 13:56:45 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from LO0P265CU003.outbound.protection.outlook.com (mail-uksouthazon11022075.outbound.protection.outlook.com [52.101.96.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E3DC24BBF0;
	Fri, 10 Jul 2026 13:56:43 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783691805; cv=fail; b=hO3Afu1+eu03V1ZuHBptrHzz+8rVh9q4MDRUrd3gTb/TZN1Xn0Szg/9ckByIw/23DnGGmnJt3J9qld24JLVgn6+PnYqGiPb1L/BSO2IEiTYgHxVJ1tvjU3bYkMU+dZXPIaTdLc6X0CoczYPhWphHJrqbCDjtjkqUSO3sCe3nKwA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783691805; c=relaxed/simple;
	bh=wipI0/Tviq2lQp+4ATJxSDwh4bKj+fGrmrCqCl8zsNQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=tD4rZqdRkrC88bHtlMWppGlFIl9AZtRAjd4ySvP/GwrRKryVNATaKBxQ0SuzKsRr2a5aPaUKI/lg/NcnCsPgs2uibjYVsLkK7v+gty9PnAk/U300eYwzqXYIrxBbDmjjw0+9MTlOtygyzZRzzEczVJGvIuCGX/8DSQpCePjnONA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.96.75
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K/eK5FPY1v7UbmkKTGq8vRJgMioQA5UliEDeYgybMQDpd1V8dDw7z6dLjqOPLD47UJFe1FCT28DxGVWi4KQafhjTEFt/Q2NRh9mezfrImORUg7WMRrqwftlsm3sNLAvLvVBx+UMFwwQC7KC52JLh25pQEBbGxDUhocRNNU6XycpApxClvSmB+jCxum+tYL5fQ7bzh+af4G6cBjXmvlK5RwWMZ88c3+m3lNU4258xjy1Wo1FadMR0mQktU5WTWy6yvuZG4Y2dGShDQSWl+YsYJfLx9nugx4if91Ylp8utwkG/hectmRDh2i/D7lgA+e1LbNNKiPSqzlhCRhJa5AH1/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=SW/ewZIZrlgut/NjKX0iGLfdqS1i70zSTvGhoS7BjWY=;
 b=KrqmDsyl56BiKl1I8vp0lr/2a+DigfcSQ55aMYu6IL5VCP3q2xUdLsQePdlHNtd02nkF0ijAhCFWqZowZWWoY9ir6eiW+FMQgYrtCUE+g0BJ8DvTu+DftaR66Ja2ew1CaP27bM+NkVAglH7g5Kt6WVrW7C5puTsbVFTGGRucOw2Ulgv+R4HNbKEsWT1nqaQWBbUFdGyguH5Ar6vu+qqKnPoSlqe0oxq2A63STG2j18eI4DkeZeacURFrgWFi1HQ4jj0HFQXf5eNDpmoZt8ykFJw1xY4WCx5V9zHeLSYBx/khsvvFnLlstFhNj7P/Y3Sp8ap+B0zUkhtHoKb0u1BPRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:183::5)
 by LO0P123MB6448.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:290::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.17; Fri, 10 Jul
 2026 13:56:39 +0000
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230]) by CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230%4]) with mapi id 15.21.0181.014; Fri, 10 Jul 2026
 13:56:39 +0000
Date: Fri, 10 Jul 2026 09:56:34 -0400
From: Aaron Tomlin <atomlin@atomlin.com>
To: Petr Pavlu <petr.pavlu@suse.com>
Cc: Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
	Alexander Gordeev <agordeev@linux.ibm.com>, Peter Huewe <peterhuewe@gmx.de>, 
	Jarkko Sakkinen <jarkko@kernel.org>, Luis Chamberlain <mcgrof@kernel.org>, 
	Daniel Gomez <da.gomez@kernel.org>, Sami Tolvanen <samitolvanen@google.com>, Xin Li <xin@zytor.com>, 
	"H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>, 
	Christian Borntraeger <borntraeger@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>, 
	Janosch Frank <frankja@linux.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, 
	David Hildenbrand <david@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>, linux-s390@vger.kernel.org, 
	kvm@vger.kernel.org, linux-integrity@vger.kernel.org, linux-modules@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] module: Limit ELF includes in linux/module.h to
 uapi/linux/elf.h
Message-ID: <4ogmo7leahb4p7c2dke7epdtu2nd7lm7nmv6y4axcvcnkcrcd4@dmoguf2nk64j>
References: <20260707153819.4172541-1-petr.pavlu@suse.com>
 <20260707153819.4172541-5-petr.pavlu@suse.com>
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="zjubmoucclkdeek2"
Content-Disposition: inline
In-Reply-To: <20260707153819.4172541-5-petr.pavlu@suse.com>
X-ClientProxiedBy: BL0PR05CA0015.namprd05.prod.outlook.com
 (2603:10b6:208:91::25) To CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:183::5)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB6607:EE_|LO0P123MB6448:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d4469f2-cbdf-468b-abfe-08dede8b100a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|23010399003|7416014|376014|22082099003|18002099003|56012099006|4143699003;
X-Microsoft-Antispam-Message-Info:
	R9OX+iWT7XwITD4KxXDdAMrd4HaKa/lGWqEOJEuAxeVJx89zZvNpDFAS/U3m3ZFWzFHjV00gQY444Y6Do1cmYnY4FDxOISWsf3sTikeIsWJIOgHJ0iuLcw0iU2mGLuTRzsUxz3fBu/cWT+77CFtESnt5BKB3+ueepppKT8t2I9ZKLpLvJQ6Oa3OYHdbeUACEz7SyekrQUFx+mspnt56OI6l5kC7pLro7Khwwhwhv0nf0SCMedRL9V+TchnvkuR8XuVP1C1ZPw5om98nktt5TTUXJJtmm8Zr18EQiu1gQLRDoVZycqeZc2GeWyuUGhDSIIbyju8M8mD8csbL+JKCe6jaGzTMoyX4vayq3D3FjIA1G1AQXBZKQ/KVpl3EuWKknSSYs1Xt+peUk3d/4AZ+7B6lwxocu8XQXfO1l89DJ28n21pB4fUVsth5SOYBWAdZ9sEjiS0cby1FnArJ+KfqBggBoOCxgu7AK7ousjEw/CkpxLg24JgT0Ny5WMVymCbcabIHV1KfgJFWSsXmef82tG+9191rdPGnkIuNmD5gmLMay1p09y6uAFNFnH8fR6EiqzqsS2/ABaSxMRXY8/lwH53FIlT0a8TeYkxBpLebP5Vk7Ug+shbkDcOphLQ/QxK5QpMpkU2hZDHWb1Cts9xiF0WmnFkQEHOhEesQLJ1B1vtU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(7416014)(376014)(22082099003)(18002099003)(56012099006)(4143699003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UnVkaTVSa1gxQnVwOVZLbjJVY0pQYVVRejlTUTRaL0Z3RCs0QllYUmtqcnZm?=
 =?utf-8?B?TzRCc2NwUS9HaXAxK1RyQ2RWRmxvOUIxY29iU0N4eFBqUzFLY2k2OUJaa1ds?=
 =?utf-8?B?MGZzaGdxR1RYaUN1eWVQTTZpdUs0R2l2UmV2aFM1cmdPMFV6dVBFdlZMWkps?=
 =?utf-8?B?S21GVUQ1RHFvOVZCRno3NzIrZTRmUlZRRTVZOVg0cUdZVCtvblQrK3NTblVX?=
 =?utf-8?B?Y0ZtN2tlSlNuMlptdmJLVkdDQVB2TUp4dDNXbGdCUit5ZEFaODh4Z2tTQVla?=
 =?utf-8?B?RG9UQzdTYUhCUGFkcTBzTkhMbURtaCtUS1VJUWNDR1pPRTFiNlBqY3Z1NkVk?=
 =?utf-8?B?NG9Hd1E1cThvcXJCYzk0dDNFaVkrcEhyck4vR21xNnBvdERnK2ZTMW8vc3hW?=
 =?utf-8?B?VW9FMVJBVDBabGY0SXpFV3V4OElNU0xZVXdpVDg2YlZDSlpxTWZjZEVHSnF0?=
 =?utf-8?B?SE5KdDVXdCs3SmFYQk9GaE10N3dXRnNDZGxqZWtZWXdUbGJoNldWZ0ZCRjZj?=
 =?utf-8?B?djE0YjNYOUdlVkMwbDlXWUZSQzZLY0NuZURiZUpxV01aNERTLzR3WEljTnd1?=
 =?utf-8?B?UGxlQkZWZW95SjFwaDc3eUxBeUZlV25yUS9ETmVFR3RpeENsN0ZlZEt3NXZP?=
 =?utf-8?B?VnltUVZQSHowY2I5MVVIRGpOcWY1a3c5TW1DZjVSUzY5STFCS2tHUUxrODl1?=
 =?utf-8?B?eFE5K0RBU2ZZQVNxQnRKbUxMYmVtU2RuaE5Tc1BDbmsvdEROeDkybmRtcHVV?=
 =?utf-8?B?WlVkQWl3R2NuMEs1b1BQUnVJTGN2a0JUSFlTYWk5YTdWRERwbzNrMklmeXBU?=
 =?utf-8?B?YktMczI5RUFhRjVzRmlNWkZQeTMwSDhpTG54R0xUUStCcUpHZEE1SDhKWlZy?=
 =?utf-8?B?ZmtuR3N6bUdWTFg0VjlKMzBOV1Y3SGdGUHlaYlBicWR2UHhyL1AzdDF1Y0Fa?=
 =?utf-8?B?dXl0N2VpUTROZzErOWphRTBQdTJRT2wrZEs5UWhmRXlzcDJVNXdSRFF1VkpQ?=
 =?utf-8?B?K3BNeS9lNk9jUmNMd1B2V0F4UXdNNjFaZnpHYk1CdENoazFuL2M2TktLa0lG?=
 =?utf-8?B?L0paVEZPWDdIb1F5Nncxd3NVa0crZlNvZ2VGU1V6a29RcjErVVFBYmNEcWs5?=
 =?utf-8?B?SlJPWmk3NytmTTZLdGkySUV2V092bmNTK1Zzd1JoWngweXJYWnN6Y3QrVVQ5?=
 =?utf-8?B?cjkrOTFqRzZRUmFTcmFPYkp1UW5QNjZGbkdXMTNoNVkwbCs2a1M0aXNaaCs5?=
 =?utf-8?B?dXVrRmJ4N0VEMjJiVngvUndOcnlFUmJoT0tMeUYxU0k3VHZmN2x1akdjVk1j?=
 =?utf-8?B?cnRRUVhZNFpkZ1BaNzFhVGYvNG5MMUZneUo3Um5MOUtVdTJvRGoxcWVPRlBn?=
 =?utf-8?B?R3NRbkJGdnFJQlhsM2hnZEtDVDF0ZTJUaUxIWXBwaGxmS0xMZElhOUk0TWhh?=
 =?utf-8?B?bHB4ZDhnelQ2RzVFT3lnblJac2gxOFhNaGZsb0RoUmxEaWZLajZ0NE1NeERZ?=
 =?utf-8?B?TVZiMzExK0RhYXdUNnRyN0I4ZE5SbGNIaGozTzFieFR2UlM1cDV2dkZZVU5o?=
 =?utf-8?B?NzJGKzB5VEpnNFJGNHhpZmdqT0tjUG1JNXI2SlpQT1B2NTE5Z2gwWUhNQ0VL?=
 =?utf-8?B?WSs3MU5TMzNlQzQyQnp1YjVsMk1Qa1B6UHk5UW94Q1ExVDk4c0xNZTdCSnNZ?=
 =?utf-8?B?TWROWXVwNWp1eVJIbUl0RCtLQ1Z0TFlJME1VTDBGall2aVNTSjRPQkhwSXhC?=
 =?utf-8?B?YUk4QzFGd0xMbER3Uy9ad0RaSHZ0elo1MEl5RGo3RC8vVkVjNlM1dWtuejNC?=
 =?utf-8?B?c3MwcC9kR2xnaGlpL3NwTjZXN3RoRkFQWFNOMHFaenQ3ZkViTFZ1MmNJZ2t3?=
 =?utf-8?B?cG5NUldPNkIwM1ZZc2I1elRka1F0SHZLcmJuekMxd0NPbktRT3BpMUVVN1dW?=
 =?utf-8?B?ekh2Y2VCdDVtNi9nUGZoSFUxSGkrQjc1YXlacmswOGJQNjJOOGNmQXpOT2VU?=
 =?utf-8?B?VFEreHBJczRvdFg4QlJ2Slh0NVhqSHp5RWJQUWg5Rmt2cy84eU5Nc1hBTnlw?=
 =?utf-8?B?ZDh2WkYwOFhPUDhDTFFzUW51dUlrdnVySlhqWXFyd1JWbjkzOHRuckEyVWc1?=
 =?utf-8?B?M1IwRUNKbkJnWkpDTjNlOWpoMFRFWjJtdTF5MTc0U0x3bDBNODduM2J1VWV4?=
 =?utf-8?B?Vk5ubDdaR0RoaVloK083M0NjUWljK2JwUkVCR2o2eHdZMWhNUGJqc2V1R3BC?=
 =?utf-8?B?blJFSi95cXdUT0MxdFJML1EyamRVQWlxWHBQM3dpOEQrSGplaXFBbVZscEV3?=
 =?utf-8?B?czhvY3ozVXJjVUtiQlZIdzZrZVZGalp3SlBOMW1MYWlmOGJaQmwyZz09?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d4469f2-cbdf-468b-abfe-08dede8b100a
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2026 13:56:38.7948
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8jN2+PY2eerX6S1dvp+H1W+So9hwhh6gd4U39A8DRjp9529QRel7+nlxPLB9RxOBvCmcNNaxAk1RiOtCVmS2UQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO0P123MB6448
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.06 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[atomlin.com];
	TAGGED_FROM(0.00)[bounces-9908-lists,linux-integrity=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[atomlin@atomlin.com,linux-integrity@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[28];
	FORGED_RECIPIENTS(0.00)[m:petr.pavlu@suse.com,m:tglx@kernel.org,m:mingo@redhat.com,m:bp@alien8.de,m:dave.hansen@linux.intel.com,m:x86@kernel.org,m:hca@linux.ibm.com,m:gor@linux.ibm.com,m:agordeev@linux.ibm.com,m:peterhuewe@gmx.de,m:jarkko@kernel.org,m:mcgrof@kernel.org,m:da.gomez@kernel.org,m:samitolvanen@google.com,m:xin@zytor.com,m:hpa@zytor.com,m:luto@kernel.org,m:borntraeger@linux.ibm.com,m:svens@linux.ibm.com,m:frankja@linux.ibm.com,m:imbrenda@linux.ibm.com,m:david@kernel.org,m:jgg@ziepe.ca,m:linux-s390@vger.kernel.org,m:kvm@vger.kernel.org,m:linux-integrity@vger.kernel.org,m:linux-modules@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,redhat.com,alien8.de,linux.intel.com,linux.ibm.com,gmx.de,google.com,zytor.com,ziepe.ca,vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[atomlin@atomlin.com,linux-integrity@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-integrity];
	R_DKIM_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp,suse.com:email,dmoguf2nk64j:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9E9C873B7F7

--zjubmoucclkdeek2
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 4/4] module: Limit ELF includes in linux/module.h to
 uapi/linux/elf.h
MIME-Version: 1.0

On Tue, Jul 07, 2026 at 05:37:07PM +0200, Petr Pavlu wrote:
> The linux/module.h header is included by every *.mod.c file to provide
> `struct module` and other related definitions. This makes it a "hot"
> header, so it should avoid pulling in unnecessary definitions.
>=20
> The header currently includes linux/elf.h but this is largely unnecessary
> because it requires only the base ELF structures, such as Elf_Ehdr and
> Elf_Sym, which are declared in uapi/linux/elf.h.
>=20
> Replace the linux/elf.h include with uapi/linux/elf.h. On x86_64_defconfi=
g,
> including linux/module.h alone results in 2.2 MB of preprocessed data. Th=
is
> change reduces that to 1.5 MB.
>=20
> Signed-off-by: Petr Pavlu <petr.pavlu@suse.com>
> ---
>  include/linux/module.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/include/linux/module.h b/include/linux/module.h
> index 7566815fabbe..7661faadbedd 100644
> --- a/include/linux/module.h
> +++ b/include/linux/module.h
> @@ -17,7 +17,6 @@
>  #include <linux/cleanup.h>
>  #include <linux/kmod.h>
>  #include <linux/init.h>
> -#include <linux/elf.h>
>  #include <linux/stringify.h>
>  #include <linux/kobject.h>
>  #include <linux/moduleparam.h>
> @@ -29,8 +28,9 @@
>  #include <linux/srcu.h>
>  #include <linux/static_call_types.h>
>  #include <linux/dynamic_debug.h>
> -
>  #include <linux/percpu.h>
> +
> +#include <uapi/linux/elf.h>
>  #include <asm/module.h>
> =20
>  #define MODULE_NAME_LEN __MODULE_NAME_LEN
> --=20
> 2.54.0
>=20

Thank you Petr. LGTM.

Reviewed-by: Aaron Tomlin <atomlin@atomlin.com>

--=20
Aaron Tomlin

--zjubmoucclkdeek2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEeQaE6/qKljiNHm6b4t6WWBnMd9YFAmpQ+g0ACgkQ4t6WWBnM
d9aq9RAAsLy6+NOcgwZEYAtqHH2Vs/cK9PSXklxGAJTZg1PJpqeZA7SusemTQ4bm
YKpQ7gLSZcSe+n0pRNoVwgw70vx/b3614wy0RSoZASNZmZgCjOxBt2rTadZ2aY3T
MPrE9bcrm7NvN3c4iujaRJZ0S/XGnkleJgIsO17NTX7u9d8IWwCyLn3AHqnrd52i
a8F+PFehXnCQDdoN8RDmOV9JbmmwIcLGBZG/3H0FNW67bs2d/zXK1vJVxzevzQng
mpJDL5odKHknjoYbCoyoeLNP78cvwbTRuDcbpXm92ldjQQSj+3/I82m1I8RwDasn
YPImKQlbeO/EhXUnyk5xJiKC7GO9yRSNeWtR8TdZrI2iFqLApFfHcA8G9AH+7aUy
cPk2QbujDbdiuE8O8543UmAVR8+famKXHQi9JFYqVvFiAjYTurpkDe9l7B6Qe6mX
Lm7ahNj8KiwSkj3bxqKkQwTY1MKcYCsNsjh6Sv2pmfo+gk188kYAAaUKzwr1+xl6
uuIqyJtMMlavCbdA16P46NlI9FmD9SeND3cYJjK1bANTfUWViTTurQ/YfN+pEd/V
6fbCQUQhXP27kvg/e/x85vAXn7FoFlUzF+wQCz/3iMpVb4SPLlgxmRByHvh9Ra60
dz28uSikieachFtGH0F+UPGaO2T0WnsfBWsmDAdSV1h3gH9x2Ao=
=f5TE
-----END PGP SIGNATURE-----

--zjubmoucclkdeek2--

