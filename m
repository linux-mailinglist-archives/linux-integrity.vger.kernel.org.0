Return-Path: <linux-integrity+bounces-5314-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54A15A67708
	for <lists+linux-integrity@lfdr.de>; Tue, 18 Mar 2025 15:58:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20A5488455D
	for <lists+linux-integrity@lfdr.de>; Tue, 18 Mar 2025 14:54:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FA3620E016;
	Tue, 18 Mar 2025 14:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="OeUf40Ev"
X-Original-To: linux-integrity@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2087.outbound.protection.outlook.com [40.107.236.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BE8F20E003;
	Tue, 18 Mar 2025 14:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742309680; cv=fail; b=Ns/Cjah/EpYC6eCaFsb7TI7EILKcTTkNPBsj2SyfKpGSdMlnZ7yGDo27HctCmeMuA/+BuPhfH+0YX/NKrtRFKJiBglERVJO74MnMCJgcchICPctjY+rnmRafEPPF5fVAHljceu2VtXpPrRtvrZGiwOLP6z8uw/F3pPdpYMq2yrc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742309680; c=relaxed/simple;
	bh=nLN0DzAvnI/20E3Q0JNbi4OBmKgKviJ0d7vZCil2O94=;
	h=Message-ID:Date:To:Cc:References:From:Subject:In-Reply-To:
	 Content-Type:MIME-Version; b=KU/tiZ59g/DxribKPIiuKHlXQ1N3hqyF4TynEpGUo/nLKUeb87bj/X0OSlSeTkZzQkZGEENaGBEceAvyUH+RaXjKy+hzTheCdDEMyqKnNL9S76Vaej+NVOAz9fbJzrlT6bESpS2OaUZMafUW23UxPqdCsIeW0VX/aw5JXmifVIc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=OeUf40Ev; arc=fail smtp.client-ip=40.107.236.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hp9rs1extPcNJqLS2Ej/nV9sHCKdpoWJvkP0kp1+XFBB6hw6QrjZFzG5NCwqq594rjlkzaONnhRytH+esg4PGkHRPzW70gcKukRKJ+FYGwKwxpGFbTwSxCYPSB083CJvbiBmhbBg49mmouoNl5JaSyyxBbUhxsil7GyH2voAhbhojaMEi1cQDTBLwd/XchaeQeHF6nIPfs7QIGmT23H9zfFrkgYmcmoS55/AGSX6cuTPplj1XcqxW0tPH3brB79ku1YvXh2/D/9x5GeidJop7+nDdTpAW3vwr33pgZH/1ejSsJYHDM31OSV8/ALxLsaW7c/K7BLu18482RX52jGYLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WTZ6uJcFzL2LXs7wUyc8iaQhCh3oiB5yR8N3h+Axb3g=;
 b=gb7+YFViHT/I2aFRQQ5CRMFMB09lfKH1mCYaWq7TdaVvde/JKNdX2qWbv69iJNNIInlWRfV6abBH+X/uvXlh4chtZdLT2SMIv4S0CFQT2+bttEHnFsYnkKo3CyYsTCIFpdrrE0GKH7D9wAqab6j1xWvkLIxBn59CqWVlQQTo4y2k+zAb+EzUgwu8FqjhmgRlp4h13ckX/Kgo3fIWJ2t5pAczEGs7Hou5NPMRSIKXh/vHaGQw7fcHn3opYFKd16zuo4wwouqh+JzBgok1IbUOZqVt4BI1UMnFhQVPJQbwadKX1iMKaiJXqI+vfYz2MvyNAziVzIEoi/c6GEcTp5CXQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WTZ6uJcFzL2LXs7wUyc8iaQhCh3oiB5yR8N3h+Axb3g=;
 b=OeUf40Evd6PSdVf/QyfXFEB6uIIQnWE9J2gifYw3b6PEMdA0x4dxlS17SMt9IAcJjMVHVK+OCbQhsC7e82KAuQ2nZNbsFoFRP4zNR1t/VtssZTene1qDyFlcuQ4X9+ouUqtklp8ARBX1R0mFhrSHGZMBMTkNp2Gql5/8bbtjLcI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5070.namprd12.prod.outlook.com (2603:10b6:5:389::22)
 by CY5PR12MB6622.namprd12.prod.outlook.com (2603:10b6:930:42::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Tue, 18 Mar
 2025 14:54:35 +0000
Received: from DM4PR12MB5070.namprd12.prod.outlook.com
 ([fe80::20a9:919e:fd6b:5a6e]) by DM4PR12MB5070.namprd12.prod.outlook.com
 ([fe80::20a9:919e:fd6b:5a6e%4]) with mapi id 15.20.8534.031; Tue, 18 Mar 2025
 14:54:35 +0000
Message-ID: <1262fa5b-0822-b8d4-26c5-426ffa4e0265@amd.com>
Date: Tue, 18 Mar 2025 09:54:31 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Content-Language: en-US
To: Stefano Garzarella <sgarzare@redhat.com>,
 Jarkko Sakkinen <jarkko@kernel.org>
Cc: Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
 x86@kernel.org, linux-kernel@vger.kernel.org, Borislav Petkov
 <bp@alien8.de>, linux-integrity@vger.kernel.org,
 Dov Murik <dovmurik@linux.ibm.com>, Dionna Glaze <dionnaglaze@google.com>,
 linux-coco@lists.linux.dev,
 James Bottomley <James.Bottomley@hansenpartnership.com>,
 Claudio Carvalho <cclaudio@linux.ibm.com>, Ingo Molnar <mingo@redhat.com>,
 "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, Joerg Roedel <jroedel@suse.de>
References: <20250311094225.35129-1-sgarzare@redhat.com>
 <20250311094225.35129-4-sgarzare@redhat.com>
 <e4eeaead-2277-1f6f-86eb-f80deae2135b@amd.com> <Z9gm9iWhk5Zs2NvI@kernel.org>
 <CAGxU2F7fdAi148rB-4c==-qCOW1SJjwf4AzC2=TUhfPXMhR5pQ@mail.gmail.com>
From: Tom Lendacky <thomas.lendacky@amd.com>
Subject: Re: [PATCH v3 3/4] tpm: add SNP SVSM vTPM driver
In-Reply-To: <CAGxU2F7fdAi148rB-4c==-qCOW1SJjwf4AzC2=TUhfPXMhR5pQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR18CA0022.namprd18.prod.outlook.com
 (2603:10b6:806:f3::21) To DM4PR12MB5070.namprd12.prod.outlook.com
 (2603:10b6:5:389::22)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5070:EE_|CY5PR12MB6622:EE_
X-MS-Office365-Filtering-Correlation-Id: b9e1e4e3-2f09-4ae3-866d-08dd662ccc7b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TTZ4R2hIcnp6M0Y1QWhGVEdCZ2xQQVhYM3lTVEdUTkl3VTAva0VMOG9mRVpI?=
 =?utf-8?B?K3EyQzh6VktKa2pVRml6RC93Vm41c3dJaHR4L09JSVgyUXdTM1RMTlBpSmNp?=
 =?utf-8?B?L0hqemREWXZ4dXJRL1RHTWhEaEROaXMyUVdSM29ET2tDWjJJSWVwejI2NDU0?=
 =?utf-8?B?QVhNOEdhYnlrUHg4d1loYnAwT1ZhTmg2TDdEbVl1dERjbk1GNlNqMFptbGpM?=
 =?utf-8?B?cUVwN0g0RjhvV1RleW4xRkhhZUtRaFhwZlJiRGt1L1hPNGo2R0k4T1ZxNGh5?=
 =?utf-8?B?ZGtlOWUvRXQ5ODcrblR3WllQNGY1RG5laFAwRWFXblJPWldmTzZ3MjhHM2lt?=
 =?utf-8?B?cG9zQThDcXJJUWxRS3JxblJrZFlEZmlENHQ0bCtFZTZ2MjRiRGRLbFRXdHRO?=
 =?utf-8?B?aENtSzZ2QlNQQ3Mya0s2TTYrdDMyakR4OFBjTDEzT2V1dEVmSDRSWjMwZXFv?=
 =?utf-8?B?dXZrL1Fqc0JPZEs1ZkN6WDdDMFByR216SWEwQ0Z4RUNMcUZmYy9yWFRxZFNC?=
 =?utf-8?B?STVvZmVOTWRhOVFEYW9Xa1Z5NzNsaStiY1hwcnhaQk5rVE5aNnk3UlhyV2t2?=
 =?utf-8?B?Q056WFZqMmNIUTVFS3pNU1FIaFBIRVlPZWxRa0hDaEVrb0IxeFB6WS9lYVZZ?=
 =?utf-8?B?YXNaWXNXK3ZCRFBPWXRvRkhUekJHTkQ0YUpDK1NTOWIrV3J6YURBZkdmYk40?=
 =?utf-8?B?QllPdDZIc1FLTjNEeUVORzZOR0JtNkljanRyenlCVzE5dVc0THZKeGRJTXVP?=
 =?utf-8?B?RGRUT1JVcUQ2N3VCa2hXWGxwU2lCdUNGT1VrYzhYS1o3ZlhIdGVaQllVZFB1?=
 =?utf-8?B?d1dycW5QWnl0SmJ5ZURER2NPN0xvYUR5T1pZY2E0TEs4R2tmMkRSNzVOVDNw?=
 =?utf-8?B?U2VoaXZxRkJqbWFrTllYSkFLQ21wL2ZuVFJYcEVMWVU3dlM1WWlXalVBT2hK?=
 =?utf-8?B?MXR3WEQ1NXc3alhnK1VIb0NkdEZMR2hvcXoyZmxJazRpam9Ka2J0cnM5dFJy?=
 =?utf-8?B?dVJqTVdaY0RkYWRWaGhaeG04dm9HaU9DRWpiWG1wS2NRcGFlNnFzQzlqS1Iv?=
 =?utf-8?B?R1VYUGNmazlOaW53OURrbGdpK3cxb2VqNkxEaUd0djAzdDFxenNaSG9xaGxL?=
 =?utf-8?B?RVpyQTZuU2h2aWZEUnRBTi9SaGNKS1duNWFzdWdic3ZQOHZXOVNXV0hKbmVV?=
 =?utf-8?B?OUZrU3V6QmFsVXpSSkt5NlBqbzltYkx1Mk5ONGdpbTNRTmJKK01ZT2U0ZGZw?=
 =?utf-8?B?V1ZCQk16bU1KNXNab3V0MWlIL0lKMWo0RzNRNmhTTmlNVi82WW1zTENCdGpC?=
 =?utf-8?B?L0ZHUjZ2WGpCckpwdnJFZFVTMUZxVFM2Ylhwd2ZGQTF4UU4va1lrK3pZMnlw?=
 =?utf-8?B?Sms3c3A4amYyL2xhZ1RwVDRFRzdkSTRBRWcxeVpEWTFtQWZYWCtCdVViNElh?=
 =?utf-8?B?OXZKODdhQkdyVXlmOTJNcUpoeFNWOTBKTk5lU01wUDQzSGhWbHlxVmN1WnJS?=
 =?utf-8?B?U1dqcEkwb0c5SWlDR1dqa2NzZXFOUFp6aE9ncHUxVHVzRXlFSkZNQmxDZzF4?=
 =?utf-8?B?bkVIZkN2M0l0Rlo1dzRud1c4Q01ZUmV3alpLUlh4UXBGS3c0UDlCUlNTcFZH?=
 =?utf-8?B?YXdGNDBwcTluWExYM1p4ZjUwZ2xtOGhKL04ySGpiUHBLMUQvNWNXZkJBVERV?=
 =?utf-8?B?TUtwSmhHeU1oRUkyZkF1ekQ1MjFjN1Rmb2R4N3FNQlhTc3FVbTkxQU15cFZS?=
 =?utf-8?B?SUpmVGFaRnBPNmhtclQwTktVbUlOTFg5anZiMlM2VWZiRjEvNXJidDkvcVNW?=
 =?utf-8?B?cC9hY0R4amxYMkU2Y0pJSjR0LzB4QjlDc1ljZVQ0a08zbGw4NG9QRzMrNlUy?=
 =?utf-8?Q?N7VIP2Qbdc/mF?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5070.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QlJxUzVvUFJDN2FzQmU5RTREVWNGYkFGd2RodTl2bnp0ZGJVWEpiOXYrd0pm?=
 =?utf-8?B?T29BcUlhNE41cHVPazdKdDV5UGw1R2lZcEtuMGpjUVNVbmZnQW9YMDRTSzd3?=
 =?utf-8?B?VGlSL2s1N1FEVmVCWXBVNGVKblV2SzZhYjBCYU9MU3pqcUVWcm1rQWhBTDBa?=
 =?utf-8?B?VkVrZmJOdHBjc3NTdllBK3dDekNqL21sQ0FwZ0h6L0c0UHpiZ3BtQUNTZ1hF?=
 =?utf-8?B?dTMwVVovRmVYcVBpNVN2WGhuV1BUWXF1SlAvcHpnMGpKMU1Id04yaFYxOFJT?=
 =?utf-8?B?TDVYNzFLK0JaUW9lWDZiVHhFcGc3dTR6K0FITVc0ekpGWWFvNVNzYmhpK1Ay?=
 =?utf-8?B?RnFuSW9aMXIxY2R0empIWmtRbXVhamx6aG5xVURuQ0NxU3R1Qm1CN291d3FU?=
 =?utf-8?B?UkY3c2ZCQU92QTROZ3JBcnp1R1Q4TzgyMjE2UVZBSTFzR0VWdnR0L24zaG4r?=
 =?utf-8?B?dGlKS0VuZlRidTlLYkRFV1ZicTM3eVZhYXlnTzV0ejE3cmhCY1ZLL0hEVGhj?=
 =?utf-8?B?RTdhclZIS1FYZitJTHlnM0dsTnczd3dlRTNwODBaZURIRFFQelJHSmNsUkI3?=
 =?utf-8?B?YzNlTFZBNkkvc1k5Q3d0SW9Hc1ZpWGxZS3Fxbk0xN0pRQ2RpbnN2NHA0aWRO?=
 =?utf-8?B?UzZEei9OTXNDNXQxamNvOVZ4OENSQUFMaDErTTVyOHhYREY5T1BuYjZ0RHRm?=
 =?utf-8?B?Nlp4OXRGanFBM1JuMitwaXEwVXRTSHVoZTVIRE4vUFFTTi9xRnNOZHdnck5m?=
 =?utf-8?B?TEFXZGR4VGxtV25ueHJJbUh5WGhGanZEblNiTkxQREp1bkNaazQ0ZEpzOHcy?=
 =?utf-8?B?K0M2TjdpUGFKY2FiOEVkeUlaZ0pXTHFpK2I5KzR6WkxhZE5FemtETGg1SUpm?=
 =?utf-8?B?Y25PTVhYMHJhUTE2MlBqRFdNcHpSYWw1UUtGUVVYa1ZFcGpNYll3RG1DVkI5?=
 =?utf-8?B?L1IvUlRpeVpZNmZWYnJ1dVgxQkZ6Q0ZoUFhJcndod0VkRmE2a0Z5bUlYQ1NI?=
 =?utf-8?B?d1ZIRkZuVDZUY1FJMzlHeHgvSUd3RkVHMHA4WW1ZdGxCdGR3WlBnQzJGc0lo?=
 =?utf-8?B?NGlaNmg3NlVJYlZaWDI5SzAweXpSK0ExRXdjdExiSHV6cWh5ZUVzeGgzaFA4?=
 =?utf-8?B?NHNiUWE3aGE5V3pWVGNtMHVScDdzTlduZWFaUmRLT3NRSnpDQW9xODJMbjc1?=
 =?utf-8?B?ME9nTVJLTW51aXdDaGdRTlh1L3VrSldzQVdRSDQvbVpiS1ZlblJReHRJVkdw?=
 =?utf-8?B?UGNmZXp2cGFad1dlZDdldzNwc2hKR1oxZmdTY0RWbE5Cai92a0VQMjBiRVNB?=
 =?utf-8?B?MWFjaDRLdXBDc0VGYjg5UUt2R1VESTF2dGN1ZjRjU05qVStUdWxSTXJHMkVN?=
 =?utf-8?B?c1Z5bk1xNlA0TktHMkpyNEVaZXMzK0VwbEtwWTc1WWhFVlpHQVo1elhCLzJM?=
 =?utf-8?B?c3doS2VjZ3lRbWFDcVBjZU1vVGJEWFdaeXJ0bUorcnA1MysxcmY5RHhwOXox?=
 =?utf-8?B?cjdLVkRxdWdkQ2I5dDhKdzVkRUhnN3lKUG9aR3h6a1ZuWlEwbXlJMEFqYk1h?=
 =?utf-8?B?NHczL0FRajg1NkJSZFcwMHk2YStnOGYreFEwOFdXMVo1T0paRmNGT0dMZ282?=
 =?utf-8?B?bjNVVHZMZ1cvWXNjNTlVMENWanY4YTRqbnpGODg3TVhPb1I5YlVsUE80eVNR?=
 =?utf-8?B?WUJyVUswbkorWkNxZklBN1AyeDhkVDJYTEJSVk9KQUFqV3I5YW5GeVpsRGNv?=
 =?utf-8?B?YmllYk9uNFRlVUJGcVZFanVZdkFCL2F0UU8wY3FUSCtGeTZMcFhyK0FDNFZt?=
 =?utf-8?B?Sm5XTElJMXNTWElsSTh0QUg2dUZ4b1FCVkJoVlR5ZUUyK3lpYWtWaXphZFM0?=
 =?utf-8?B?Q1N6aUh0YWl2ZXJENjhZNS9zQXoyWlpBbmdvTjgwRk9FVmhHdGs2OHdHTHlJ?=
 =?utf-8?B?Skd3c0JYeDlXclNCaVpJWWphY2Q4WXU3VXFDVGg1VTJ3ZFhhTEt0NVhDSzVF?=
 =?utf-8?B?cjUyNm0xVmF6bWRML1JyaUJSSXQvaEtMR3N4WEhjS043b0RGS094c2RIcnhj?=
 =?utf-8?B?WDI3L0pFSlpPb3RzV2VWK0orYzg0WGtUb0xUY0J0OFpNMGJFa1JRQUpiWGN4?=
 =?utf-8?Q?Kwi8wu3oYXV5QeRFKYO6GmTxt?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9e1e4e3-2f09-4ae3-866d-08dd662ccc7b
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5070.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2025 14:54:35.3433
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: egw/DRJlY86WeJMzEsyPRCsDwN2oMiZ6gGwOKQQl5pWNDvNCLwWMu1iC5lTIKG0iuBWdAP85arWePflwN7a9cA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6622

On 3/18/25 05:38, Stefano Garzarella wrote:
> On Mon, Mar 17, 2025 at 03:43:18PM +0200, Jarkko Sakkinen wrote:
>> On Fri, Mar 14, 2025 at 11:48:11AM -0500, Tom Lendacky wrote:
>>> On 3/11/25 04:42, Stefano Garzarella wrote:
>>>> Add driver for the vTPM defined by the AMD SVSM spec [1].
>>>>
>>>> The specification defines a protocol that a SEV-SNP guest OS can use to
>>>> discover and talk to a vTPM emulated by the Secure VM Service Module (SVSM)
>>>> in the guest context, but at a more privileged level (VMPL0).
>>>>
>>>> The new tpm-svsm platform driver uses two functions exposed by x86/sev
>>>> to verify that the device is actually emulated by the platform and to
>>>> send commands and receive responses.
>>>>
>>>> The device cannot be hot-plugged/unplugged as it is emulated by the
>>>> platform, so we can use module_platform_driver_probe(). The probe
>>>> function will only check whether in the current runtime configuration,
>>>> SVSM is present and provides a vTPM.
>>>>
>>>> This device does not support interrupts and sends responses to commands
>>>> synchronously. In order to have .recv() called just after .send() in
>>>> tpm_try_transmit(), the .status() callback returns 0, and both
>>>> .req_complete_mask and .req_complete_val are set to 0.
>>>>
>>>> [1] "Secure VM Service Module for SEV-SNP Guests"
>>>>     Publication # 58019 Revision: 1.00
>>>>
>>>> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
>>>> ---
>>>> v3:
>>>> - removed send_recv() ops and followed the ftpm driver implementing .status,
>>>>   .req_complete_mask, .req_complete_val, etc. [Jarkko]
>>>> - removed link to the spec because those URLs are unstable [Borislav]
>>>> ---
>>>>  drivers/char/tpm/tpm_svsm.c | 148 ++++++++++++++++++++++++++++++++++++
>>>>  drivers/char/tpm/Kconfig    |  10 +++
>>>>  drivers/char/tpm/Makefile   |   1 +
>>>>  3 files changed, 159 insertions(+)
>>>>  create mode 100644 drivers/char/tpm/tpm_svsm.c
>>>>
>>>> diff --git a/drivers/char/tpm/tpm_svsm.c b/drivers/char/tpm/tpm_svsm.c
>>>> new file mode 100644
>>>> index 000000000000..5540d0227eed
>>>> --- /dev/null
>>>> +++ b/drivers/char/tpm/tpm_svsm.c
>>>> @@ -0,0 +1,148 @@
>>>> +// SPDX-License-Identifier: GPL-2.0-only
>>>> +/*
>>>> + * Copyright (C) 2025 Red Hat, Inc. All Rights Reserved.
>>>> + *
>>>> + * Driver for the vTPM defined by the AMD SVSM spec [1].
>>>> + *
>>>> + * The specification defines a protocol that a SEV-SNP guest OS can use to
>>>> + * discover and talk to a vTPM emulated by the Secure VM Service Module (SVSM)
>>>> + * in the guest context, but at a more privileged level (usually VMPL0).
>>>> + *
>>>> + * [1] "Secure VM Service Module for SEV-SNP Guests"
>>>> + *     Publication # 58019 Revision: 1.00
>>>> + */
>>>> +
>>>> +#include <asm/sev.h>
>>>
>>> Typically the "asm" includes are after the "linux" includes and separated
>>> from each other by a blank line.
> 
> Yep, I already fixed it in v4, since I found that issue while
> backporting this patch to CentOS 9.
> 
>>>
>>>> +#include <linux/module.h>
>>>> +#include <linux/kernel.h>
>>>> +#include <linux/platform_device.h>
>>>> +#include <linux/svsm_vtpm.h>
>>>> +
>>>> +#include "tpm.h"
>>>> +
>>>> +struct tpm_svsm_priv {
>>>> +  u8 buffer[SVSM_VTPM_MAX_BUFFER];
>>>> +  u8 locality;
>>>> +};
>>>
>>> I'm wondering if the buffer shouldn't be a pointer to a page of memory
>>> that is a page allocation. This ensures it is always page-aligned in case
>>> the tpm_svsm_priv structure is ever modified.
> 
> @Tom Should that buffer really page aligned?
> 
> I couldn't find anything in the specification. IIRC edk2 also doesn't
> allocate it aligned, and the code in SVSM already handles the case when
> this is not aligned.
> 
> So if it is to be aligned to the pages, we should reinforce it in SVSM
> (spec/code) and also fix edk2.
> 
> Or was yours a suggestion for performance/optimization?

No reason other than the size of the buffer is the size of a page.
Allocating a page provides a page that is dedicated to the buffer for
the SVSM. To me it just makes sense to keep it separate from any driver
related data. Just a suggestion, not a requirement, and no need to
update the spec.

Thanks,
Tom

> 
>>>
>>> As it is, the kmalloc() allocation will be page-aligned because of the
>>> size, but it might be safer, dunno, your call.
>>
>> This was good catch. There's actually two issues here:
>>
>> 1. SVSM_VTPM_MAX_BUFFER is same as page size.
>> 2. SVSM_VTPM_MAX_BUFFER is IMHO defined in wrong patch 2/4.
> 
> I put it in patch 2 because IIUC it should be part of the SVSM
> specification (the size, not the alignment).
> 
>>
>> So this constant would be needed, it should be appeneded in this patch,
>> not in 2/4 because it has direct effect on implementation of the driver.
>>
>> I'd personally support the idea of removing this constant altogether
>> and use alloc_page() (i.e., same as you suggested).
> 
> Do you think it's necessary, even though alignment is not required?
> (I'm still not clear if it's a requirement, see above)
> 
>>
>> kmalloc() does do the "right thing here but it is still extra
>> unnecessary layer of random stuff on top...
> 
> Yes, if it has to be aligned I completely agree. I would like to use
> devm_ functions to keep the driver simple. Do you think
> devm_get_free_pages() might be a good alternative to alloc_page()?
> 
> Thanks,
> Stefano
> 

