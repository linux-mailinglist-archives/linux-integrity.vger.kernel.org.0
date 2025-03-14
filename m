Return-Path: <linux-integrity+bounces-5286-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CED9A614D6
	for <lists+linux-integrity@lfdr.de>; Fri, 14 Mar 2025 16:27:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 172D51B61F98
	for <lists+linux-integrity@lfdr.de>; Fri, 14 Mar 2025 15:27:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60D1A202964;
	Fri, 14 Mar 2025 15:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="slGQaWyE"
X-Original-To: linux-integrity@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2063.outbound.protection.outlook.com [40.107.95.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF8E5201264;
	Fri, 14 Mar 2025 15:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741966037; cv=fail; b=W81yZA0GHOHQsLO2z+RtnmBdI3TropMZ4FH8W2LDEmjsLblsBAdMj2O2Zj2PG53/MMe1QfF+0Oir99O9gmd8MhrJs7qHgdPeyWbLpOjFBztAf3iYZ2OS+0kBbmDbMMZdazpsdEjP+EaoESvE4bBPFWd0BUoZ4Cdp1wkCUk/19P4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741966037; c=relaxed/simple;
	bh=irZCQjDt1BZWCwykosN14uyZb9Sd4I68LJpeDxlkghQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=iwqFRwLIpv9LG9HSpMAE70bW5TRl2OKC6IQXrOvADa4uoWX3WzbEJqBfTrzqJ3USpxiOAnoz1g3bYWea3YFXhhrmVeEgXdzn4e7JE52KuSAJwOg/kHPS+xWWIVsA760wq8AnnmhPZARcebeUO34lx2YuWHRYMOYgeH1XY60XPRM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=slGQaWyE; arc=fail smtp.client-ip=40.107.95.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w7cib8FVEZuoGquY/znsGf8Iu2yjXBgZZZSADE4o1uW2C+5q1n0btZ4LR7vQvFePPYayIFQ+5/IJ7SJHESBUbH/fLeNxNTQ9//mLHd6ZTCsqLr+NrsuLw31+p9sAykWsE6/5ebzkJYE7VdrikaXD5c9+GFMqu+hlCRiM7XekdsfW2qEXPoqjyCjeURu9hZl94Uuzki6EBzWuP2Ou7c9yydkxglccnqgKt5lgB958lZntmW9ZfXa9UVM+RPZksGdZjGusojJB/w1v02qVWunyplWijRTLvGw4C8xF5Kr4lkqLo707uHtUAYHSt7Ja+5pNkM04f6CDYozU9eD6QSI1BQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vAbv4sLRtiHz89LiRYzwsGlMfwNeXUophYiH1250Qbc=;
 b=UtQ2nTw8waPQtj+q/3dQDcQ+iCeEK2l9W+0ne9Xio32KF/mIJ6B6R8YygHeOC1+nJJzaaIf+Fg2XKiRY7Kehp5kGLZQvUiD+6CJP4/+Wavw+cyq4wp5t31Q3Y9pG0iZ0RMfMaq8jbidz8vYtkDF1m7nT0dii0MW5bsCZ5FFa6XpYlM+XsYRVsjnZ9nGgQs3jm0hcyvVBeBSCegsOJe56muGicSNXMzEdUDP1QxK9bJ0TOv6W7WPXl2ReK0uJoqdjyqt1CzBW1H+1Yl+j0O8AHcIoujI2eoOPJEmd41f7p0Tg8140QcnqhhsgM3m1ciepX6xvqQGn4sHezLYAWpQtoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vAbv4sLRtiHz89LiRYzwsGlMfwNeXUophYiH1250Qbc=;
 b=slGQaWyE5BX3bjd9igAEVXbStnzEYfHCKKBrpiQLCWTeodeBPE0H3Ub+gsPt7D+SPGigmmpnTfWB8E7I0qSe8nbkqYKQwuwXdwGQWvMPotbkSviEUifepJHgybvOPpHK8rMTKjFvoi3EKXesBRbvanVOMDoyEJAJoYfbAL1/pso=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5070.namprd12.prod.outlook.com (2603:10b6:5:389::22)
 by BL1PR12MB5996.namprd12.prod.outlook.com (2603:10b6:208:39c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.28; Fri, 14 Mar
 2025 15:27:12 +0000
Received: from DM4PR12MB5070.namprd12.prod.outlook.com
 ([fe80::20a9:919e:fd6b:5a6e]) by DM4PR12MB5070.namprd12.prod.outlook.com
 ([fe80::20a9:919e:fd6b:5a6e%4]) with mapi id 15.20.8534.027; Fri, 14 Mar 2025
 15:27:12 +0000
Message-ID: <d7e5a1d2-5fcc-bf7f-a67d-7871a1627c98@amd.com>
Date: Fri, 14 Mar 2025 10:27:07 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v3 1/4] x86/sev: add SVSM vTPM probe/send_command
 functions
Content-Language: en-US
To: Stefano Garzarella <sgarzare@redhat.com>,
 Jarkko Sakkinen <jarkko@kernel.org>
Cc: Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
 x86@kernel.org, linux-kernel@vger.kernel.org, Borislav Petkov
 <bp@alien8.de>, linux-integrity@vger.kernel.org,
 Dov Murik <dovmurik@linux.ibm.com>, Dionna Glaze <dionnaglaze@google.com>,
 linux-coco@lists.linux.dev,
 James Bottomley <James.Bottomley@HansenPartnership.com>,
 Claudio Carvalho <cclaudio@linux.ibm.com>, Ingo Molnar <mingo@redhat.com>,
 "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, Joerg Roedel <jroedel@suse.de>
References: <20250311094225.35129-1-sgarzare@redhat.com>
 <20250311094225.35129-2-sgarzare@redhat.com>
From: Tom Lendacky <thomas.lendacky@amd.com>
In-Reply-To: <20250311094225.35129-2-sgarzare@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR04CA0014.namprd04.prod.outlook.com
 (2603:10b6:806:f2::19) To DM4PR12MB5070.namprd12.prod.outlook.com
 (2603:10b6:5:389::22)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5070:EE_|BL1PR12MB5996:EE_
X-MS-Office365-Filtering-Correlation-Id: 6225e395-fb86-4607-8265-08dd630cb107
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WG9XOFNWWUNhdkRzYmJWV0JFL05aU3lYNjNUcWIvTG9FMW4rZWxiQm1pNWwz?=
 =?utf-8?B?WndiNnpIdmE4ZjZOVHB6TnpMSHVQWENUc0dsYnowazlDTEFZcFAvcWpYbFp5?=
 =?utf-8?B?dlc3RnJaenREajlCTEVFWm43aVVrVk1tSUdsZzJpaGFkWS9BQTR4MjF0REtK?=
 =?utf-8?B?dWJvRkJMV2R4NFBXM0JwMTlzaXh0cjBtMFQ3L05ybkt1WjRNLzVIeVdXb3VS?=
 =?utf-8?B?OGF5dVJSeUMxcmo3amZpdVloNjA1Q2tyc0QvS2ZVVkpmVHFaUXRIb0dwV2lX?=
 =?utf-8?B?QUFjOVFZS250L0dUNHlYZmxPVlJxQlpMd0lqaEdKNzRpUVphMFJZeUQ4ZXUr?=
 =?utf-8?B?elNBUnp2bENMSThqMlNnSDFkR3ZpSHd1ZzNGNHh5ZU5ONGUrTXZ6cFdMSDZN?=
 =?utf-8?B?VnFzT05pbGlCY3lET3J3VVNYWFcvTHVET0diM3dFa2VzYkZOZDJVQlljY1Fy?=
 =?utf-8?B?Uk5oeEk2ZE5BT1loUEwzaVZOL3pFMXpFVU5QenphZVVTK1l1TDRvdzBrRW9u?=
 =?utf-8?B?cTJnd1Zkc3RNaTlDNGNlZ1RJc3RFKzR3TjRSd00wZzBFbmoyc3pmRUdPODBq?=
 =?utf-8?B?bDI1UG5VMTJScFRnRERLWE54Zkd0b0FBdUJvTkRSTkJ1RDJYbHZEcVpraGJW?=
 =?utf-8?B?aFpXNERxV3pneDNNYzN1OEpYZjR4WGluRnI3YWhueTJLNDNmL3VwUFNYWUFN?=
 =?utf-8?B?ZnR6cytFamdTWGU5ZGhhZFkwNjl2Wk4zek4rMzFjbG0zV24xUk1SYzNDQTdS?=
 =?utf-8?B?QXQxa0J0K2V6VGgzNFU4T2ZWOGhtUmlxOTI0ZFBTY0JvYzdzZXVqMWRhK2tV?=
 =?utf-8?B?d2tsWE1MRFNkZDFzWW00SjBpSTk4dGF2Y29ScTNGZmllWk50d0h1bzhxMHRx?=
 =?utf-8?B?MzZNalRKSnFORGpOZCtQWUNuNVhkVDhpaElEMDJ1RUY2U1JURlYvRGhWZnNq?=
 =?utf-8?B?QXRhejFhTlM5SkVrQTYwbUhTNUNYdlBiei9HenFBZVBJY3Q4UlJnQlpSdzBR?=
 =?utf-8?B?RXNWUTNFdjZ6NXR1QVJRNEloa2JxekhNRHJmRTlqM2x3VEpZVkdjVzRSMkJ2?=
 =?utf-8?B?RGkwcVhRS2J3MHhoZU93QzU0Y1FSdHpYVUdvS01nM3FIMlB6MFk2N2xqTGlv?=
 =?utf-8?B?RUlpbTlVbDNzellFWFNDUE5IMXRLOEh2ZFoySjJuWVdrNGw2dkViaTdLdFF3?=
 =?utf-8?B?aVR0bmRtWnNxUEFLbVdnUFhxOVNIZ2dFMWd6eVJ1VGJIeGkvKzBtUDRERHZj?=
 =?utf-8?B?bjRrdzdwVlJabXhMaWRrOVgvMllnODlVZVh2UkU4OXlDV1FsN0tOd0RuWXNl?=
 =?utf-8?B?WitWVE1DdCtyZVZYcU5WRWh0bUJxOWpyNVRlTGtsWElYNUpEaUtwanpkZEtP?=
 =?utf-8?B?Q0lhdS9MOWs5MTVNT3ZBQjc4cjhmc3l1dG80WHZKSDloYS9IUWd1L1FURHFJ?=
 =?utf-8?B?QWV2Wkt4Uk52K2lSOE95YVVTYTZrcjJTYkgzdTh4QmxPanAyd1Bvb2hESHFI?=
 =?utf-8?B?Q3dYR1c5Y08xQUtmRCtNaG93cnRLejV3eGFyTjVpbU8xbHdmMUZkYWxoNHdm?=
 =?utf-8?B?ZUZRTENvYmxJa3ZBZzB3a1lyZ2o2eTBFeVBNcDkwdHAvQWxnT3VDa2UvanNH?=
 =?utf-8?B?UFBGYXdWRlYyem41VVIxdTc2eVBxYkNaUTdOWmlpclpXb3pFMlFUOTArejdN?=
 =?utf-8?B?UFlUZ0NrTTB0YlFkYmJuUUtveUswSEN1aXNaWGl5dzNNc3N5MUdkSkhqVGdP?=
 =?utf-8?B?N0FiUlJ6dUVCT1FadE1Xd2U5OTY0VzhTU3lpSlhUVExBbDR6Sk9CdzVMM0la?=
 =?utf-8?B?UzNYczVETTBjS0lDN3JPeGhWMVZEQmlSSkkwMWI5d1BHd3BDODFtMzFBWkRi?=
 =?utf-8?Q?YsgQM0A40MaP4?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5070.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OUVkSGxOR3VxaEt5aitXK2tmLzV5aTROcGFsWldaQnhWN1dJb3ZDUGkvRWpm?=
 =?utf-8?B?WUJUS2R1YmVROVFZOUtTWWhucER0Tk40R3ZCOVkvNUg2d2pqUENvaTF2eG9j?=
 =?utf-8?B?b0c0WmJuNkxLZ09KNWp2N3VrRXZjY05kWklPTXFLK0wrcEFIRUswdHBaRFVT?=
 =?utf-8?B?RDRRWkVidWM5Vm1xRFQwNE1UOWZYeHd1TEtGNHRnTnp0Z1ZtcWthd3ZPT0t4?=
 =?utf-8?B?aXNGNENZVGlIcEw4cGdpdDZzamNpdFB1TEpFSGR1eFR4ekNEYW0wMW5XU25T?=
 =?utf-8?B?NVl5L3ZsdFdDMlEzY0FTcnNlWG5GVzM5UkE5WnBEUDFHdCtuZlZnMmdWWXYx?=
 =?utf-8?B?UFE0S1BVVzdCOXhDRXN5S2NqRm0yOVRuODBiR21KSHFCT3lyY05Nc2ltMHcr?=
 =?utf-8?B?SE9rSy9UOTZTSHV6WnlYOVNiTHlHZFZ1aU5hT04vaGdydjhGVmZORncxSWRz?=
 =?utf-8?B?SnpIcjkwOVJEc3lQbkhlOSt5em0relZqWm1PU1hNTWtYNkFhaFZZdnBXMDNz?=
 =?utf-8?B?eFFiZWR0MDhrcHEvbi9zS1dtQlRuQ1FFYzJLOENUaXlNTmVMRkVMckFGMjRQ?=
 =?utf-8?B?QmgvRGtPZi9hWklMQkVzS0RhZkxpZ3FET2w3cFZIM0QxWFlyS3VZd0dNbGNt?=
 =?utf-8?B?d3FGTUd5bG52NGVWNGlXREN4UDdMcDRkYk95WklpSE5tbGNuMkJwemV3ZEpq?=
 =?utf-8?B?WTdmUWk2ZjFRUTF0ZGJLVWVPdzgzSTNucHJLeWVOZnJCR3g4ZU9EaU1hQ2pn?=
 =?utf-8?B?d0ZpQWhsOVZ3SUlmbS9pTXJNbHhTdlNqSTZaY1J4V2YyS2VSNkVrN1JESVA1?=
 =?utf-8?B?RHAvMGUwQUZyWGxXbzB3ZFJUYjJTQVQwWnljQm82eXNFL3BhdzJYSFFReVlO?=
 =?utf-8?B?RXpHRlhMVVkvaW1NbjBKaitHanN3Nk5SSmxWL0R6ZHlLWitHM0wxR1o2bnpr?=
 =?utf-8?B?aHJwaG5kZzlNZE9rYmxra0FqdzhqdzhxRUNpMjJaUVQrOFgxK3J0NHo3allE?=
 =?utf-8?B?YjFMVWdnSHlsWWFsODZxK3pCRG1DM0ZLZlFxaGlFSDAySVZHUWlVNkJRV3l5?=
 =?utf-8?B?K01IaHRyNTVtUk1vNnphemRmWHd4dlVhQnM2MGFBVDMrZkxiamR1Y2xSWnVy?=
 =?utf-8?B?MjV0OWRkRzhPejZ6aFdqMExtWmU1QzBPdkJqajVDSUdHM2pCZ1FMQzNaV3hG?=
 =?utf-8?B?NUlxTlNRV212R241aElPTWJzTTNyQmZzM1JEdWF5cnpaM3BvWmdqM2hrRWFi?=
 =?utf-8?B?a1NZNm53VW5YMUV4b3M5TU5XVGllNjVJODdQU054SmkxdUhSajJRZnE2elpF?=
 =?utf-8?B?cVpjcFBFTW1YQnE2dURCb2JFM3FRNnlUVXRqY1ZFOUtqWngrZVlrdFduRFRB?=
 =?utf-8?B?SUJzai9GY1FwbXVGTkQ2aVVrYUtnTVkrSGtoSkNXY2V0Q2J3aG8yZWFLb2pZ?=
 =?utf-8?B?VXhtbWlzWEZlZkNsMkVMVUxjckk0OElZQUd6YlBEZE4yUUxtU3lNMHUvd3Q2?=
 =?utf-8?B?L3VTeXl3MFZwYWt6ejIyODZJT1FJSlBJem9qS2w4U3dnd20yeVZKTUNtSHdk?=
 =?utf-8?B?Vm9SdjZGTGhMUVNzbGd2OVpsQmVMdGF2VkRUSHFUd3VxSDlraW15Rk5tUE90?=
 =?utf-8?B?d3hkaWxrVnRFN1hYMmd0eXpGWjVNNkV0U3owdlEwaWpoNmNlOGtmOGlYYkZC?=
 =?utf-8?B?TnVvcHFRMTA5Wi8vWFJ6S0RGdUt4MG1jclJ4WDNycklLaVNQY1JYVi9waHY2?=
 =?utf-8?B?VjRVZ3AyblJnWDZDK0JhRUZ0TFNNR1UyZ3R3ZDJ2SlMrcDBZeXo0ZW9VUXFv?=
 =?utf-8?B?cjJaaDhzQ2dOMTg5Tm1OdjFnakRONGVPUUV6alhDZllORjJyNmszWVI1RFZR?=
 =?utf-8?B?ZGpJeWNGNGVaSjhVR2pvbjcyMU1GR1J6T3FPNjBwMGhzRGFRazNsTkd6Z21M?=
 =?utf-8?B?Y1E1cUZ5OU9uUVlsOTcySmNnbk1iSFUwdnhERXQ2Y04velNnN0krcVZIaG5X?=
 =?utf-8?B?YmQ5VmtpNEFNb1NpYjNEMFhzbkQwTkJ4QXhuZkhid2I5dlBoTmJCRkh6dHR3?=
 =?utf-8?B?NmZqYm8yOGtjaHYzVTl0RG9nQURibkVQcmpzRTZMZW9uZXBFbW1sTlRuV2gz?=
 =?utf-8?Q?zArzDpWlGEMjixDAlH9w2DlFg?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6225e395-fb86-4607-8265-08dd630cb107
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5070.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2025 15:27:11.8847
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4q188Mm149U4Hm12XGGILazi72wDTicG9PZzQxblsqRRagjAyFLP55ts8YhYhKZ0ZIKmsGaXHLRD+LdCAbhtdw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5996

On 3/11/25 04:42, Stefano Garzarella wrote:
> Add two new functions to probe and send commands to the SVSM vTPM.
> They leverage the two calls defined by the AMD SVSM specification [1]
> for the vTPM protocol: SVSM_VTPM_QUERY and SVSM_VTPM_CMD.
> 
> Expose these functions to be used by other modules such as a tpm
> driver.
> 
> [1] "Secure VM Service Module for SEV-SNP Guests"
>     Publication # 58019 Revision: 1.00
> 
> Co-developed-by: James Bottomley <James.Bottomley@HansenPartnership.com>
> Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>
> Co-developed-by: Claudio Carvalho <cclaudio@linux.ibm.com>
> Signed-off-by: Claudio Carvalho <cclaudio@linux.ibm.com>
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>

One minor nit below, otherwise:

Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>

> ---
> v3:
> - removed link to the spec because those URLs are unstable [Borislav]
> - squashed "x86/sev: add SVSM call macros for the vTPM protocol" patch
>   in this one [Borislav]
> - slimmed down snp_svsm_vtpm_probe() [Borislav]
> - removed features check and any print related [Tom]
> ---
>  arch/x86/include/asm/sev.h |  7 +++++++
>  arch/x86/coco/sev/core.c   | 31 +++++++++++++++++++++++++++++++
>  2 files changed, 38 insertions(+)
> 
> diff --git a/arch/x86/include/asm/sev.h b/arch/x86/include/asm/sev.h
> index ba7999f66abe..09471d058ce5 100644
> --- a/arch/x86/include/asm/sev.h
> +++ b/arch/x86/include/asm/sev.h
> @@ -384,6 +384,10 @@ struct svsm_call {
>  #define SVSM_ATTEST_SERVICES		0
>  #define SVSM_ATTEST_SINGLE_SERVICE	1
>  
> +#define SVSM_VTPM_CALL(x)		((2ULL << 32) | (x))
> +#define SVSM_VTPM_QUERY			0
> +#define SVSM_VTPM_CMD			1
> +
>  #ifdef CONFIG_AMD_MEM_ENCRYPT
>  
>  extern u8 snp_vmpl;
> @@ -481,6 +485,9 @@ void snp_msg_free(struct snp_msg_desc *mdesc);
>  int snp_send_guest_request(struct snp_msg_desc *mdesc, struct snp_guest_req *req,
>  			   struct snp_guest_request_ioctl *rio);
>  
> +bool snp_svsm_vtpm_probe(void);
> +int snp_svsm_vtpm_send_command(u8 *buffer);
> +
>  void __init snp_secure_tsc_prepare(void);
>  void __init snp_secure_tsc_init(void);
>  
> diff --git a/arch/x86/coco/sev/core.c b/arch/x86/coco/sev/core.c
> index 96c7bc698e6b..2166bdff88b7 100644
> --- a/arch/x86/coco/sev/core.c
> +++ b/arch/x86/coco/sev/core.c
> @@ -2628,6 +2628,37 @@ static int snp_issue_guest_request(struct snp_guest_req *req, struct snp_req_dat
>  	return ret;
>  }
>  
> +bool snp_svsm_vtpm_probe(void)
> +{
> +	struct svsm_call call = {};
> +
> +	/* The vTPM device is available only if a SVSM is present */
> +	if (!snp_vmpl)
> +		return false;
> +
> +	call.caa = svsm_get_caa();
> +	call.rax = SVSM_VTPM_CALL(SVSM_VTPM_QUERY);
> +
> +	if (svsm_perform_call_protocol(&call))
> +		return false;
> +
> +	/* Check platform commands contains TPM_SEND_COMMAND - platform command 8 */
> +	return (call.rcx_out & BIT_ULL(8)) == BIT_ULL(8);

It's a bool function, so this could simplified to just:

	return call.rcx_out & BIT_ULL(8);

Thanks,
Tom

> +}
> +EXPORT_SYMBOL_GPL(snp_svsm_vtpm_probe);
> +
> +int snp_svsm_vtpm_send_command(u8 *buffer)
> +{
> +	struct svsm_call call = {};
> +
> +	call.caa = svsm_get_caa();
> +	call.rax = SVSM_VTPM_CALL(SVSM_VTPM_CMD);
> +	call.rcx = __pa(buffer);
> +
> +	return svsm_perform_call_protocol(&call);
> +}
> +EXPORT_SYMBOL_GPL(snp_svsm_vtpm_send_command);
> +
>  static struct platform_device sev_guest_device = {
>  	.name		= "sev-guest",
>  	.id		= -1,

