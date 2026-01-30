Return-Path: <linux-integrity+bounces-8375-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sIOcEfMXfWkGQQIAu9opvQ
	(envelope-from <linux-integrity+bounces-8375-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Fri, 30 Jan 2026 21:43:31 +0100
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E002EBE7DB
	for <lists+linux-integrity@lfdr.de>; Fri, 30 Jan 2026 21:43:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AF94430125CB
	for <lists+linux-integrity@lfdr.de>; Fri, 30 Jan 2026 20:43:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 614A334679C;
	Fri, 30 Jan 2026 20:43:19 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from CWXP265CU008.outbound.protection.outlook.com (mail-ukwestazon11020103.outbound.protection.outlook.com [52.101.195.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE2AC34B19A;
	Fri, 30 Jan 2026 20:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.195.103
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769805799; cv=fail; b=VvGfg3cmJp0yXzrMok3twYKU0clUxBO4reBLEYCzoQwbu0LWQs9qBulR5U76o9ztq8vBxGPUidpbP+ghx2KloUj2FpD2Q1mrNOU49cag4/tBtW7iHODM+Xbg7L9Yik353yZiQBM3XUMbFnKg8bfL9oOJvjDW8PzhGGO/xLiY5ds=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769805799; c=relaxed/simple;
	bh=sL4aD3rjVYlmU74w5cTDakAws2W4suXUmyn0wavfs1I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=rAe0njRfqXIDAG92SzIbhT9vOGgB/2HH1CVmy/FgoSAWXO5oEtPVJKfl58SEWgSeSSR6oodb7hqq93014+7PdPBp6SuPF8c9SZskZ4XCW+H4KFuv0dbv1xG4Vzx0ysEeCqEoeEJdiJqOOZxRSsSPAedocwS4Kh2rF286NK8OMOU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.195.103
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iBZJP7JApQspslM3F4qR9jQiqwcCDILsu23xy1Xa6o/aWJN/3rcj8NxhUpg4h5M9UsTKKoa5sDxb812wcklPIxHl2OvWyT/pCo6nfKpwN39M0DFYXEPh+jwCRqw+iDZpl7VGPImNuuHPWSVVThHktX21IrxhR2s/3tlvhf+8Y9twMvmK2dVgcKZ9chNDu7+/9nTeQQyYLTUmQixxiwc//iZg1N2MA2g4b4AKFSkPi6FTY7cvKcXIzK7mNiFWm5k68LU8P4C806MQaHtbr6xeWIOyrOKKXNGxUJRlbRRsLpNGDdJM+W087abdSLJIrc+NjV6DbX1Q0Iwzl748OZqHnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VSL8a4FZwAQNCsjd1TPx/M0sz4aci+2DeAw+UeBSiTU=;
 b=F6xpMp8cxPIgcxT+jYtEhuY8PQJsYOcTrOCcuBhGjveWJ4LSHs52R968Ulk4hhL5m92bpBSKhbQlL5Np6hCJqK/Jx4J1suMK2TQGbcRa7XNSajDyLbiVGtyE7ROB0AkGaT4fuBVQvu83wfBKIyt4rfT8IGGsaKIMbaZCJjHKJzW9x9/VwrwG6EBZYygmrypOAOGmwIhuQkNyYFY+Cf4jMfyMmT4gDStEWOd5mnyPWRKzpZkBQu4Hsgk8A9pYuwO+28Ewq7ZBIJK4Yc6fJcMmqPPda1apBhPGIuzf6Ki9HjvWFMUkasIAeLw82ao7Nzf8NBSjslRIsMWUTFfRHWgGIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:70::10)
 by CWXP123MB3559.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:7e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.11; Fri, 30 Jan
 2026 20:43:14 +0000
Received: from CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 ([fe80::de8e:2e4f:6c6:f3bf]) by CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 ([fe80::de8e:2e4f:6c6:f3bf%2]) with mapi id 15.20.9564.008; Fri, 30 Jan 2026
 20:43:14 +0000
Date: Fri, 30 Jan 2026 15:43:09 -0500
From: Aaron Tomlin <atomlin@atomlin.com>
To: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc: Nathan Chancellor <nathan@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>, 
	Sami Tolvanen <samitolvanen@google.com>, Daniel Gomez <da.gomez@samsung.com>, 
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, Jonathan Corbet <corbet@lwn.net>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	Nicholas Piggin <npiggin@gmail.com>, Naveen N Rao <naveen@kernel.org>, 
	Mimi Zohar <zohar@linux.ibm.com>, Roberto Sassu <roberto.sassu@huawei.com>, 
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, Eric Snowberg <eric.snowberg@oracle.com>, 
	Nicolas Schier <nicolas.schier@linux.dev>, Daniel Gomez <da.gomez@kernel.org>, 
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, Nicolas Schier <nsc@kernel.org>, 
	Nicolas Bouchinet <nicolas.bouchinet@oss.cyber.gouv.fr>, Xiu Jianfeng <xiujianfeng@huawei.com>, 
	Fabian =?utf-8?Q?Gr=C3=BCnbichler?= <f.gruenbichler@proxmox.com>, Arnout Engelen <arnout@bzzt.net>, 
	Mattia Rizzolo <mattia@mapreri.org>, kpcyrd <kpcyrd@archlinux.org>, 
	Christian Heusel <christian@heusel.eu>, =?utf-8?B?Q8OianU=?= Mihai-Drosi <mcaju95@gmail.com>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arch@vger.kernel.org, linux-modules@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-doc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	linux-integrity@vger.kernel.org
Subject: Re: [PATCH v4 02/17] powerpc/ima: Drop unnecessary check for
 CONFIG_MODULE_SIG
Message-ID: <oajou3fo7blggwdswz2gsblc4ddvtjb3sha4pblobrtzih5awo@hk6ootw3vajt>
References: <20260113-module-hashes-v4-0-0b932db9b56b@weissschuh.net>
 <20260113-module-hashes-v4-2-0b932db9b56b@weissschuh.net>
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="4vvmek6m3nom5z42"
Content-Disposition: inline
In-Reply-To: <20260113-module-hashes-v4-2-0b932db9b56b@weissschuh.net>
X-ClientProxiedBy: BL1PR13CA0395.namprd13.prod.outlook.com
 (2603:10b6:208:2c2::10) To CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:70::10)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB3523:EE_|CWXP123MB3559:EE_
X-MS-Office365-Filtering-Correlation-Id: c17f73d9-1cd3-4e37-24fa-08de6040302b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?a2x4WGE3MTUyRmx2RW9EdU1BNlZudDRmSFFxMW9jZFFydmZVZElPTDZKdHVu?=
 =?utf-8?B?OXVQdHBtdjVZV1FDdFZoZndFZjZDK0lReGU3TTdVdWw3a2dPN1hJNlVtNGNE?=
 =?utf-8?B?QjRFYnpod2xTRDJKTFRNSEplSk9MbFJaMTFObjFZbTNtVUgzaStUTmpFTDNY?=
 =?utf-8?B?S1NyeGZMRlNZYjN2aGVZVFplOEJybEl5WGF6UDhHQkRFZExLNlpBMVlRYm1u?=
 =?utf-8?B?Q2V0VjZ0aEo5OThYTS91djQ0clRsM0FXS3cyanlEc2VZRm1GSHY3QnNHTEgy?=
 =?utf-8?B?TUlTT2VPQTB5UU9uRzRyK01HTmJMa24xdU92WWVzM1NYaGdZQzhCUDZqOUk4?=
 =?utf-8?B?a1Q3MmZwS09EMEFEeUEzWTdVK2ZidXluY3doOUp0M0NtSDFRVlQxT1EvZGdE?=
 =?utf-8?B?ZG1jSVpISHkwOUtBMFRIZVk2OHlsRWptNXRLenpJMWVEWGZOaEppbUxQbkVm?=
 =?utf-8?B?bUIvOUMyTnNDWjBGT1VWYm9HWVAzZ0pRRFZXYTNabDNXRHF3cVJzVmV4aFI1?=
 =?utf-8?B?TzJXTnVWaHZoalJTYm90NUxFV2FoSXJYVWRnMmQzYmd0Tkc1eDRVeGgvS284?=
 =?utf-8?B?MnovdGIzcmVndUN1TlFIL0lDa0hLMk5pL0FKZVdYV0ZWNE9mUngwbUV0bU5x?=
 =?utf-8?B?RWViQ1BBRlVDc0Vhb2xhQk81dzNQZENzeVZEZ2xQZVB1S0V6cnI3Q0x4bmFW?=
 =?utf-8?B?OE1RV0JSTXY4NStBVFJKK0hmb0ZoeUFGcVRYTkVZdG1iZkNhN3FYR0xDamMv?=
 =?utf-8?B?bk5ZRUVBaWJ3RTlJZm9WRVFJVTg5ckFteVUwVHhPQm9WT21VcnpZbUVwL2dG?=
 =?utf-8?B?cHVkSkNDYmVUaGlBRjB3VENoSHBlSEZsbEpQNFdYbFNmbysrU1NTc2RmU0h6?=
 =?utf-8?B?dVM2QjBWSmEyMU54Tm1GazNQY0JWS3A3TCtRWHMxZkhGbzROci9zNjZlczZD?=
 =?utf-8?B?bk5Rc0svd2liS056VFhpRzd1L2xsQ292djgzZGZzYm9BbGpKUjdYVE1Kdklz?=
 =?utf-8?B?b1EzaUI4clk4eUZNOFUwUEg5bWJQQnM4aWtMVXJJOUdMUlpnSkV5dk1MZWMy?=
 =?utf-8?B?aUtXY1VtV1FaNmxSdTUrU3Fpa2c2U0h2Rk0yaTNScklIT0ZJL2hjVEh0WGVV?=
 =?utf-8?B?UWsvZEs3WUhRSHpzdjR6Y1JDYXFvZy9ua3RaeWtKRmJSUDE4Q0ZjSWcySDVn?=
 =?utf-8?B?S1cwUDRBaG1LdmlYdnhsRVpNQVVaNHFRSjR2SGdSNnY0N2ZzeFhKOUVjWk9H?=
 =?utf-8?B?L3VpTXdaT083cmVMTll0NWw4cVdQSXpUYytDQnVnenFPZ24reGNFdzV0MFZy?=
 =?utf-8?B?bllFWEh1dUdyRkxvZmY0S3pYN0wzZUxmbFRWMWY0WlBFcEtUM24xMHQ0Rit5?=
 =?utf-8?B?UGkrenZHb3hsb3Rldk8rMFl4MWdocTBqTWtlQWcyZDlDSDVqRVlvNWlwNTA1?=
 =?utf-8?B?aks1bWtUODlXRy9sTldNcUlJMjZoOGpjOFJveGcrN3Q1dDIzVFVOdVFlcjBE?=
 =?utf-8?B?RG1FamtuR2ExOUR5MjFBZmNzN2NvRGl3V2ZFZXNyY0JGRVJKSUQ1MU0ySjRs?=
 =?utf-8?B?bGovSzIxMHFpRW9wNm9qNkkyamRZOXJUWmpJcm8vRW5tcDh3bXRaZjdselQv?=
 =?utf-8?B?Ujc0d2dQSlhYSFdHQnBBNlRCYlRnNkY4RTJsVnFlZUU3djErcXhOTjVOOUMz?=
 =?utf-8?B?VnVXZ21jTlYzeFVKSEdnVHlXS3JKd3E0Z0NMWjBhRGdLblkySEdEaXovQzZK?=
 =?utf-8?B?enBrVytCRjFNNVlvNFN6aU0xY1pXelVFV2svbTFPckFGQitjd2x2M1F2QjVZ?=
 =?utf-8?B?L3hvekpvN2R5OHF5Z0lLbjBXUDFlSTNFck5QSXJsM0tnYVd2a3pmUW1aU2xC?=
 =?utf-8?B?YWp2bnE3SzRmbHNBUWtFS0MrY2J3YndseXY3c2hCb1J6SFI2ZmRHRUxzS212?=
 =?utf-8?B?aTBPRFFVRjkvc2EwdUcxSmVtSk9IVmRxNkxMd1dHUjhJNk9ZeGc1NVVMb0ZJ?=
 =?utf-8?B?dEVaUnNiSzc4UEpuTkxEVVBQenB6TXhyc3pwdm9KN0s5eEVnZWMxSzRtcG9H?=
 =?utf-8?B?N3lCMENNVHZYRzRDU1RLQ3R4emtUVXh5MEFRd0NOL0JKZVRnSFRoNCt4RG5n?=
 =?utf-8?Q?0urE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dWlyaWFsV0hkMWNIcS9XRTJES1o5SVFqbVAvektBcDNqWnN5TFVVc0lOSDNx?=
 =?utf-8?B?ckdySjdzRkNHd2g5VG5laDJzT1RSRDVrT2ZUSnB1eEtITExmNXpKNWVnZFpB?=
 =?utf-8?B?UWVKa1YwYXV0TkNRQTBlN0haRUR2aFdQaHREaHNkT2YwUHJFUTJ4b2FmZHAy?=
 =?utf-8?B?aDFZWWd3cndsT0NVMmtlTXBNY2xZL2xlQXlEV2pIcFd3RnBFVjB0NlBZcEo3?=
 =?utf-8?B?UGZ6VFBYUllzcERweEs5WUpkNkorTTdQcXZMNzg0T1IwMmpmUXI3OTA5eXhp?=
 =?utf-8?B?SjU0aU9IVEd6ZmlDZ2JkNGNONk9hbVFpV0pmOUhIZkx2cHlOc3ZJOEIxVUxO?=
 =?utf-8?B?SkNxMWRVNnN2bVBOeHRYaWpUZzlVeUdFbEwwQXFqOENqV0V1RThnbnBTNVAr?=
 =?utf-8?B?YnN3azdrSjREaVZ0enhLK3FUSWFOOWY0SjNpaFZSV2JNY0pSOGNLRzJ6KzV1?=
 =?utf-8?B?OWwwSXpUaVVYZlhEUGpVZUJwSUkxYm9oSWVYY0c5b05mZFZpNDlhaDFHb3A3?=
 =?utf-8?B?aFIrQmlsem5tdzVvbnh4eG9TRWtZdzhpQlVoSFhOMlVTSndtUW92SFVMZm5T?=
 =?utf-8?B?ZEpydUxOaVJUdTlwL2RySHpVdytNTm5XK3pGeW9mQjZhbEVnSm1DcnFMcDBG?=
 =?utf-8?B?TVlGWGFuMzJqL2g3YU1EYVAyZG5oQ0p5NGFBdWprYk80TFBEM1BBMm1yTmRj?=
 =?utf-8?B?OXpuUXVjejZCTVh0N2FMZkNERTJiVHJHZU16L3ZpVm84a3RMN05kVkp3N0cy?=
 =?utf-8?B?UEVIZWljRUl4SVhDVHlnSlhYdE9BZFM1dkFkNHlCRm5TTzZSWUQ0MkNzUE0w?=
 =?utf-8?B?MzFBZkM2L0JoSUl4bXdublNVcXRNam1RZExZU09WOTMvYmNpcTBVWmdGZkNt?=
 =?utf-8?B?ZE1uWUhvNi9tclZBdHlUTGgrZ29GcHQzeWdPM056eGxVMFBKR2RDQ2c4NzBn?=
 =?utf-8?B?ckQ5UGUvcmdxNVM5bEVIRTZBWFE1U3F6bldkc2x1b3VVazE5c2VOMS9pNTRi?=
 =?utf-8?B?dkxGaFNIYTNPM3ZpTGZndFlwS1l4OWtlMCtSNEVVTDdZSE16cEQrR01VQVFG?=
 =?utf-8?B?aXBqaDZXTTFnQ2VISmdZaitHakVGd295aGV4N1pYSTFhcFQ5ZWpERnArcHUv?=
 =?utf-8?B?OXNqWFJuN0tpbWlIeHpLcWZjdlRDUk9peVNod2w2NnV6S1dra3hMdEdwd3VL?=
 =?utf-8?B?enNGK2MzZytpVmQ3c1pjcDkveGZoQWNCTCttM2tPb3F4YjJ1UnhwSWNyY0pj?=
 =?utf-8?B?R3ZkK1NDbjd0YlpPTTRBNHVUcmR1RXhaSHAreFpuVjVaLzFpQ3JYTWFjVytM?=
 =?utf-8?B?N1pwbTZuT0hhOW42b04vcWppakJNemF0a2pBaVlZdk9Zc1kzVlZtT3FEak5D?=
 =?utf-8?B?ay9ldFBhMkpObVdWV1gxQWxnT1Jhb250S0hsVlRlUFl5SGNERGZGN2RhY1F3?=
 =?utf-8?B?eXZPbzFYamJpQTRIaGh3NFh6dEJqYWFIcVJ5bnl6S285c0ZhQkxMb3VQZVJX?=
 =?utf-8?B?emdXbEQyWkdaeG9rV1VuSmVzV1F2TU1lUnZCYTYwUjkrL3E0NHFVQStObVJh?=
 =?utf-8?B?WWhrK2lRUkE3bXlCK1N0OTNiVFRUZTdLWlN2WWc0QjNrNnNGVXhsYXN2ZzVo?=
 =?utf-8?B?ZC8wdVM1c01XeFFLeXVhMlEvV05hbGlZcUZid3AxdVpUZkJTbDVHVVpXT1Bv?=
 =?utf-8?B?WEtQVHVvL2U1VnZNczd0Q25HV0pJUnRwMVpzOStYR2pWNWY3R21JU2ZYL2hR?=
 =?utf-8?B?Yyt6eVhTc3JpbmVWVE1rNWFmejUwUTd5NXA0WVF2dHNnUEcxem5ra0s2d0Ir?=
 =?utf-8?B?NTNuNUpGNDJDOHRHdEpnMzVEKzBkSXBBTTRCT3BmRGdFbktlaERMU0FMb05D?=
 =?utf-8?B?MWhyZW8yYU1OaFd4KzlzaUZ3dzlNSVBHc3piY040a0J1TTRVemtXNHlvbHV5?=
 =?utf-8?B?aG4wcnp2aU45cFl1Q2diUW9QbzdxbUxBWHYzeEpmOGZFMnlHT1pqL0dKL09w?=
 =?utf-8?B?RDYwSk1yTERVZnFkWjVWUXpFelN6R0cvbWxtUGwrTFNUU2wwS2IzTHNHTzJY?=
 =?utf-8?B?eGdvTko5R1JjMFowYVV0dU5RWHliS1VoZFd2WFR2UU9iYlRmdDFSTVl4b3RP?=
 =?utf-8?B?UHZXRng2am0wLzZtd21LRGJaYnU3YjA4cWZuSEx4OWxJQUhUZEdnM2JpaHdS?=
 =?utf-8?B?T2hyRlFXQnFVbDBEaDlKRFM1UUtaVVNQeXlvc3B2c21MVk1kdW1GN1FiM0xR?=
 =?utf-8?B?WHl0ZU10TnFrWHZxazlSdTVHZEpUa01kZDRmcFdCVnpiWDdpZlUvVWRXeVJS?=
 =?utf-8?B?NXo3NkNZRXhCSkFjY096ZjIxeGFXSVlGN1d0TUlmeGpuYWhBdUl4dz09?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c17f73d9-1cd3-4e37-24fa-08de6040302b
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2026 20:43:13.8387
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /HWWA/J2D/Ho4HqntLHB4NTUn5G65P7tFTHxnTXzwkvkE6y/hOjr/jPz5iAn4Ldu0SontbcpZi1va++rZ1dYPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWXP123MB3559
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.44 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8375-lists,linux-integrity=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[atomlin.com];
	RCPT_COUNT_TWELVE(0.00)[40];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FREEMAIL_CC(0.00)[kernel.org,arndb.de,suse.com,google.com,samsung.com,paul-moore.com,namei.org,hallyn.com,lwn.net,linux.ibm.com,ellerman.id.au,gmail.com,huawei.com,oracle.com,linux.dev,oss.cyber.gouv.fr,proxmox.com,bzzt.net,mapreri.org,archlinux.org,heusel.eu,linutronix.de,vger.kernel.org,lists.ozlabs.org];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[atomlin@atomlin.com,linux-integrity@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-integrity];
	R_DKIM_NA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E002EBE7DB
X-Rspamd-Action: no action

--4vvmek6m3nom5z42
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v4 02/17] powerpc/ima: Drop unnecessary check for
 CONFIG_MODULE_SIG
MIME-Version: 1.0

On Tue, Jan 13, 2026 at 01:28:46PM +0100, Thomas Wei=C3=9Fschuh wrote:
> When CONFIG_MODULE_SIG is disabled set_module_sig_enforced() is defined
> as an empty stub, so the check is unnecessary.
> The specific configuration option for set_module_sig_enforced() is
> about to change and removing the check avoids some later churn.
>=20
> Signed-off-by: Thomas Wei=C3=9Fschuh <linux@weissschuh.net>
> ---
>  arch/powerpc/kernel/ima_arch.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>=20
> diff --git a/arch/powerpc/kernel/ima_arch.c b/arch/powerpc/kernel/ima_arc=
h.c
> index b7029beed847..690263bf4265 100644
> --- a/arch/powerpc/kernel/ima_arch.c
> +++ b/arch/powerpc/kernel/ima_arch.c
> @@ -63,8 +63,7 @@ static const char *const secure_and_trusted_rules[] =3D=
 {
>  const char *const *arch_get_ima_policy(void)
>  {
>  	if (is_ppc_secureboot_enabled()) {
> -		if (IS_ENABLED(CONFIG_MODULE_SIG))
> -			set_module_sig_enforced();
> +		set_module_sig_enforced();
> =20
>  		if (is_ppc_trustedboot_enabled())
>  			return secure_and_trusted_rules;
>=20
> --=20
> 2.52.0
>=20

Reviewed-by: Aaron Tomlin <atomlin@atomlin.com>

--=20
Aaron Tomlin

--4vvmek6m3nom5z42
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEeQaE6/qKljiNHm6b4t6WWBnMd9YFAml9F90ACgkQ4t6WWBnM
d9ZXig//a4ajs49o3h/ZoZl+rcKBwaks2Y3tVhhHlfcBbwsKHUV9xn7mrWaGnM0N
BmOP5ukIJOLmAA2zD8msl7CQ9eT/gCWdMTHd3Llmb74mfCktO9WYsEXYYCIdUJH9
3CFdmm9UFpv+oF1FseSLcerMzYS/D+ftgmelQiSqpNQakY/IGk2PeTbGRSuMX+Jw
9/G16MtjlIasyJzaaFco45pYQ4pUeSQpkLQEyx2nNzMZttPdk8W2NlFtZ+W23yIi
c0AuH6s+gr9rtjepFTH4yUNXCi43XwxHa5evw8C7hlBYj9esvhTWxBtZ2W38QyyJ
4GY60dU9jxLVMgNzR9OJLC6ZJbMuRrApCI7Z2NDj0Exhj0f0k7XZOcx7uqWaefek
tBsaX8IFiCloerMxjQE1OmfuSpntyYTfBWEfTtbCrgkBgy7/Wax8CS3ug7BmYqKO
6OD64AQSAjdw6EFDRpWHVd6hx7GCQ7LHLeCx2i7A630dDfT8L9WbiYYz1xIF7RRS
jiNakZf6Jhr1U+kTBEOzpYICBH7GTjIWivG81Oh08jLK/j2iA6SqoK5Fa65rTXU0
aR+rmmRVry1GSBVn1xAVUz61mZMSrutBqwUMNUXsDrm8lbL6i2kmGw0FD81A8BYp
B4t9SUODhSQ88dilmT99+AhZod7PTzfJI9iZMZbeC9474s9MTY0=
=VbTv
-----END PGP SIGNATURE-----

--4vvmek6m3nom5z42--

