Return-Path: <linux-integrity+bounces-4836-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 946E3A37BA9
	for <lists+linux-integrity@lfdr.de>; Mon, 17 Feb 2025 07:46:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A59503A6F16
	for <lists+linux-integrity@lfdr.de>; Mon, 17 Feb 2025 06:46:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9C991531E1;
	Mon, 17 Feb 2025 06:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TbmwoAn2"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BFB315442A
	for <linux-integrity@vger.kernel.org>; Mon, 17 Feb 2025 06:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739774775; cv=fail; b=YIPglQdopcarOJPlAn2/WIBaUiSR8HZfZBfTg/HEnPw0pJzROCzsljKb4fZyB9AwyGuMPiYS1RjgETyIrCpIFMk4rgaLXhLdwqwrbtqSbRjjom0u2XtwHdCFT08lG77WvxeSlSf8SKCEmEI1AElckvgbHvaKjYazYONzUZr6kPE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739774775; c=relaxed/simple;
	bh=ZdApXdDqvpcRSHht1uT3DDeJQIuee1+jA+X9+jEfoYc=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=gNZfpjPcuBlxBT2KNhb/iRjmRfclHFhUynwJffyQI8lxxdpXXcgzBU853eTsyoMvF7HjOL8mMROF47CB8GGPxfeAaIpgMQtx7d5tOCgzqFLjYKapvEv8Nz0Y/HRnWWZTZWgqzHy4WXDAhFCCVRU7jRHU45YtSs1ULAS8ag3dgAs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TbmwoAn2; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739774772; x=1771310772;
  h=date:from:to:cc:subject:message-id:
   content-transfer-encoding:mime-version;
  bh=ZdApXdDqvpcRSHht1uT3DDeJQIuee1+jA+X9+jEfoYc=;
  b=TbmwoAn2CMaOZ4irk6CHfJxhxa1H58BVu1sun0P7ap9dOkU1C7Xv8WGD
   jhDTCg4ceUXjvIrmAGyzFJojQQsFko7io+2xcYZWXwaaxLE7w7OvXqi3k
   u2x8gE84bk5YB6n9du3QeIUgmcnj9DekQnnSiTQcaLzSjWt05m6SPuHDV
   725LT1OQ9icqrPgs/uV1i7lM9uX2k8u2SgwhkTxMa5/yrIEpM8/xhTJjP
   jJM+sBpTb8sHji/M1/ecR9nWVQw5oqeVqIbV/qpOzSfp4XIIwrZMcjHLa
   tc8WohXWIVqobvtDTY8ibUXzqbQevcSmVBzyvua6CfJ1MtNpwyCH5etSk
   w==;
X-CSE-ConnectionGUID: /jA4oo0nRfKj2V444+ZhLA==
X-CSE-MsgGUID: qEFDTgBTQtyxrqwo3lkJMw==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="51872938"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; 
   d="scan'208";a="51872938"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2025 22:46:03 -0800
X-CSE-ConnectionGUID: Zx4lpevZT4WFc8I/jeH9JA==
X-CSE-MsgGUID: xVAThkVcRSGkZ6qAcyfd0A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="137270372"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 16 Feb 2025 22:46:03 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Sun, 16 Feb 2025 22:46:02 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Sun, 16 Feb 2025 22:46:02 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.176)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Sun, 16 Feb 2025 22:46:02 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vk2T1FdK/+toHMil+jjymOBAYRjHXuKu2minVlNs9YraQZuUKovMJtswbYepAkEFHIVcMFj8V+F/LBaNGB0rzw4anLE1pvgPBxmtRhgHLsCJB4GvaRhZ+YfCI7yiNvfu7yJgpT7/DLWvsT0EyVt9e/zjaz+B7tLRVLBQCo4uil4o1Th7+5pf2oT3oCj1/7dWGf6sdSZqlvEWr2YnpePFqlRFkilDjcbe7XmrgSve32ZRhvGH3uvb9/IIct/bJ6yzqLaiPx0xK1dVRXyLnRtaZ9FcAVT3Nzo7EZJmOHD2M5ioWm+QbJL1u3hxQ5Nn0NSbcYNunVwivbwPBfdwMTo6Fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zKOzehKUyAZMXmQ0Q4NssZ7PNaVcS4R1a2uYkO5El9I=;
 b=kDBIUwZ5Y4vFrRIQZm/JZ7iVVigD38NORo0gsLA90AArDSDue+V16F75HhId6QNxSA0OzCVA4lUkfevFToSmXzfh5LiZaVmaMqlprZUTyrz6JKjhHwMJpw5ApmlHxCTD/2qzbZQ+z6QrlGj2YcwPM40iSBDg+FT0ufw1a9dvJuONpmNpQAmR9uOP3zMuyXh1Gm24p0EvTnFhbvM6VwjdD9NUaBbETqvnFuTFlCgRn9GAk4Zoxc+PXDYDccIVF0ukF4dAkPoh55QY11bub+BqJESrD/Gvoy7Ni8oyhwQCGvEUZbxy0GeGHk0q+LlTSXUHWqsUYusFebBYyDHkNYsIMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by CH3PR11MB8384.namprd11.prod.outlook.com (2603:10b6:610:176::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.13; Mon, 17 Feb
 2025 06:45:32 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%3]) with mapi id 15.20.8445.017; Mon, 17 Feb 2025
 06:45:32 +0000
Date: Mon, 17 Feb 2025 14:45:23 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Roberto Sassu <roberto.sassu@huawei.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>,
	<linux-integrity@vger.kernel.org>, <oliver.sang@intel.com>
Subject: [robertosassu:evm-iint-ptr-v1-devel-v3] [evm]  e38e699a42:
 will-it-scale.per_process_ops 160.4% improvement
Message-ID: <202502171412.ec2e5b88-lkp@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR01CA0109.apcprd01.prod.exchangelabs.com
 (2603:1096:4:40::13) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|CH3PR11MB8384:EE_
X-MS-Office365-Filtering-Correlation-Id: b6c9ff82-d204-4abb-ea24-08dd4f1eac76
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?+o7fK08oVz13X3aDO0ntt+CyWxeN3KXbOM8rWY4KlcE1SZBDQ2JssonA22?=
 =?iso-8859-1?Q?jX1tk1/DgeffGHwoRIEPD7r2n2xnipend91PHCdQqMx2x2ET2i9QTzPZml?=
 =?iso-8859-1?Q?JjVkLjvzvj+cr5Ha6z1dK4ZN7s55KGaP4UpuFCzoJ5nSdSqoIHEYPlFUhk?=
 =?iso-8859-1?Q?iEEjRGpWVmXesISBR5Tt+SNuuTGKKZ+/a4sEJ5zXWGaeI3hdYTYvy2W9e4?=
 =?iso-8859-1?Q?ynbheUJi63TIy3qWjxQ151Z4Ndc09Q+zEqbz1nmgmUA6ETPEu04J34K9lc?=
 =?iso-8859-1?Q?b18J7bOeea2vhDDISUjz322KxHNhrdVAxUePS1u7KjD1CaDUlZK1U/WZir?=
 =?iso-8859-1?Q?SayLCFSABvugBuqq6EB9Eg5E7TLqbmpW2AD5L8gnRmnDzVIcfrVxKGglaj?=
 =?iso-8859-1?Q?+GHNX7SKOX4zMa/IuAbiwAiMvbsobrDHjjNJcQs200skgVtX3tR9kD4njw?=
 =?iso-8859-1?Q?rC7GvMCulP7NzSSuPUV825Mrxj70UfgcocGIGu3RbGSi5tV1FBej5b/YH8?=
 =?iso-8859-1?Q?2WCrNP0zvw3eesG6itmxmIqQzFQz4fZ43iUhT7KlVRUS749P9m0JGNfdFJ?=
 =?iso-8859-1?Q?1bydoiaiSYbWtmzoabLiFbv+2037n//DiXOIqsy+ThtxVQ15FPXPxLc5l+?=
 =?iso-8859-1?Q?nFbwZk5TGsWXv2npUKd5WcXWCIGY2pyIMdXy4Y1RvT8UI/PFxFoQ1ykOE0?=
 =?iso-8859-1?Q?y12VA+rkzxFwJIwMdhPiQzpwjYvfcycVyAS6cTKZwNdsw9bfexNpfjUfie?=
 =?iso-8859-1?Q?M4xx4MB4PMZ4Hx0kI8HSwvARBVbNId5W1obhtyIhIhizIRlX9gGV7aK1Cp?=
 =?iso-8859-1?Q?RF5aLMA2mEUGte1UCvZSUwk6S/iqBrINy0cVB+mhxkksGWVlaSZv5Uw3gs?=
 =?iso-8859-1?Q?ncEB5xcTCqdqev7ohTSW4kmKeGubF3vnBk3UMM2bcLV0eSp6SDm6lpFZSl?=
 =?iso-8859-1?Q?TA6l7ueXnchG9nqULAT7KIhmL5A24ys7kz/vay5ibbcVkTlx8Civ4U5bnl?=
 =?iso-8859-1?Q?oOpAuWb0s8nL8MBcbxAX0bncCvvBCUL6iOvYw9Hasf2LC22dBPSbrmbkyd?=
 =?iso-8859-1?Q?GupY+eUaZkQ67+3SjP1PcayhuPhh8aSUAWQby7ohlZM94zzI3BztdNDHzi?=
 =?iso-8859-1?Q?E2pVeMTf7PlmTgJkZ9exwGBQLz4ensdly5kLpirIzn+ZbxAoc32pTmr4mX?=
 =?iso-8859-1?Q?CEb973Pt3aBwGrncpRgH4qgWSr61x7ODhV5nPG6DWq/zWl6ieaPm8194Gb?=
 =?iso-8859-1?Q?uoYM/e+7MjCleTykNyjWwKbGR/D9Ay46NbxpkMdzLS8SdR2iGZtCyzPyNO?=
 =?iso-8859-1?Q?8gIFC6YoshhTDkurORBZPF/LA7xiyDJblVdVWAvENcOaXN/3EQ45GCTr76?=
 =?iso-8859-1?Q?TK8JBNQira7qcz4+K7TVRprFTc7S6w4g=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?HNUwKCPETtzKZOP+0X8hyNTmPcFjSJdCIX0xBhH2otOWOT4snmNaho2Fc+?=
 =?iso-8859-1?Q?O2RTnH6jqBvQ9W3bvTsmpTVojp1PLuG1nZuphhd5XeqxLmD5+9QOXpMGK0?=
 =?iso-8859-1?Q?CyFsYjbX0RO5Y1a4ZviXO/uf6Uq6WvJIAso3lPZrZNFqhfw8s6HC0ZQjLY?=
 =?iso-8859-1?Q?swk0ph5pAXGKFAfguSnOWgazsM8P8ZZeb7OxxWcVDf2vLCbZ7D6t3x2x4y?=
 =?iso-8859-1?Q?H774UOUsKC0ZxJ6uC0LwM5dapA88aUWAW7VuCYB3PanMZTaNqaQAXJEu+r?=
 =?iso-8859-1?Q?K0R7pICnAa9klUsDLdte9jw0cKAvTgA7gRvO5xFpMonKpdWH5sNoT/kZnZ?=
 =?iso-8859-1?Q?gcK4YfSAonIUO+ISswjyxnOtKYMyhyQMgJQKtLg6ElukDUzY/0LuUlaaQ2?=
 =?iso-8859-1?Q?IQiqoA9yydrfnsdBKK+AimGsvf9w0xssL2FyY1sohHt0KPN2+DbxGNrK/1?=
 =?iso-8859-1?Q?xOLCVtpRVHplZELulH5bT5hmy9PB6kwAS6KrqYutUPtiVLfgM2O8FsDvIC?=
 =?iso-8859-1?Q?am1pEExTThpc7R90aJ0ZUIcn+fduTD/fqhzerGUOmoEVpnVQIvRMp7Lts2?=
 =?iso-8859-1?Q?g63X/5aMe47Fenh9H6VSoAqH4aPmJF0eFpkC1uV9UlBToHkG80pSxybjCH?=
 =?iso-8859-1?Q?YA9BNMfyBZYpwmjjCRbu8dYqsa7aQx+x2XMYxwQJm3UonV5fJ+j08NSTpO?=
 =?iso-8859-1?Q?8CjUJQJVMRZq1mL95a+/zNVpeXgejGL7m7YAwq5d7v60bqqHraAETAKTyD?=
 =?iso-8859-1?Q?vWyT8minMCTPN6Kyk1W0cLeCNhOwc80fH/f891nmsppXXCC0yCo3rq9bZx?=
 =?iso-8859-1?Q?voaJjRMM4+1Zs1cTOkJZvxQFLCmfZesKCGPq2999z3guBHw+RbOR4g8A9K?=
 =?iso-8859-1?Q?QXVBSKxLKZIV50vqvd5i17IMniaj6BkWwEVkbuAuMzauybjRrPsJA+omVs?=
 =?iso-8859-1?Q?94BeVM6jnzuRPc0YV1DMhLntdC2LKo+rTn6jMNPH8/dS5p1zS3ou/kg4Q4?=
 =?iso-8859-1?Q?nI2x3gq9L99Hh4MTs7jx0HoltBxLxY3F52FXw91WEb3OXJR6f+CCLZDcU6?=
 =?iso-8859-1?Q?qZrZch6bleYP9uKO2dsE6FZeKodXSiGR6QgSTXRVWN5pYivsMWrIzfideZ?=
 =?iso-8859-1?Q?XCaIRkdIVJNj797Yc7+uLoU/oVblnbp9KFbR3T5XFONn22/veOrPr2Wgmn?=
 =?iso-8859-1?Q?lvjdViC7gAHSAeBrfQm/VW7m+pHpUFq+bCsEESUUjdJK4X6Wouok3A4T8T?=
 =?iso-8859-1?Q?zIlNTQel7PxkNdvxxX9tN+qcS1FCoiEYpPcISg3sUe9rx2gvyDq8/sw2jB?=
 =?iso-8859-1?Q?LXDSoU5bGLlCCma2v3ijKRk6Yb0hsXHeM8hgQQMC0tamS4qctLsUGbNcMF?=
 =?iso-8859-1?Q?IqRWIIc6p+r8QR0QYLztKKWOhnT8usD0SPuo75/52XZSSgzw8WAaGXuDn3?=
 =?iso-8859-1?Q?4utH/SAaTB413hSx6Ce39nWauIJTe1QVBvTigRJXppyQH2xq2obEXbtKFi?=
 =?iso-8859-1?Q?uxJ9VHUxWHd0ON89aX3KbTGo24hGLNiQpTQ0dPy/VID6fJCF6LRmjSPX2e?=
 =?iso-8859-1?Q?NOQtfPyfDFVPeLiZXwbbsn3hlzQ20u0xKhJbFyLjEgAH8cQr3r4pSxEM/k?=
 =?iso-8859-1?Q?/Gj397KnhfnBVI1JJDc1/otdkKrkr95LnktZggWBuN5iSHj3w7HXeHaQ?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b6c9ff82-d204-4abb-ea24-08dd4f1eac76
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2025 06:45:32.0677
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AYHxOALTssH0NhoqrU1fkdHPkt3BohpAqjK1Ytt5fuohjt9eTLB1J9mOiswWUKkhHSy0WqzLLOR1zl3Ln8QSkQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8384
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed a 160.4% improvement of will-it-scale.per_process_ops on:


commit: e38e699a42b4db5daf7dac453759fdc8ba0dab31 ("evm: Move metadata in the inode security blob to a pointer")
https://github.com/robertosassu/linux evm-iint-ptr-v1-devel-v3

testcase: will-it-scale
config: x86_64-rhel-9.4
compiler: gcc-12
test machine: 224 threads 2 sockets Intel(R) Xeon(R) Platinum 8480CTDX (Sapphire Rapids) with 512G memory
parameters:

	nr_task: 100%
	mode: process
	test: open3
	cpufreq_governor: performance






Details are as below:
-------------------------------------------------------------------------------------------------->


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20250217/202502171412.ec2e5b88-lkp@intel.com

=========================================================================================
compiler/cpufreq_governor/kconfig/mode/nr_task/rootfs/tbox_group/test/testcase:
  gcc-12/performance/x86_64-rhel-9.4/process/100%/debian-12-x86_64-20240206.cgz/lkp-spr-2sp4/open3/will-it-scale

commit: 
  d7a782797d ("ima: Reset IMA_NONACTION_RULE_FLAGS after post_setattr")
  e38e699a42 ("evm: Move metadata in the inode security blob to a pointer")

d7a782797df7c64e e38e699a42b4db5daf7dac45375 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
    194348 ±  2%     +42.5%     276904 ±  9%  cpuidle..usage
      2032           +69.8%       3451 ±  8%  vmstat.system.cs
    219050 ± 22%     -53.4%     101970 ± 46%  meminfo.AnonHugePages
    224488 ±  6%     -14.1%     192753 ±  6%  meminfo.Mapped
   1151621           -10.9%    1026208        meminfo.Shmem
      0.62 ±  3%      +0.1        0.70 ±  2%  mpstat.cpu.all.idle%
      0.16 ±  4%      +0.0        0.20 ±  2%  mpstat.cpu.all.usr%
      3.00         +1650.0%      52.50        mpstat.max_utilization.seconds
   1221925 ±  7%     -16.7%    1018311 ± 12%  numa-meminfo.node1.FilePages
    123310 ±  9%     -25.6%      91721 ± 12%  numa-meminfo.node1.Mapped
   1085554           -18.7%     882893 ± 12%  numa-meminfo.node1.Shmem
    305498 ±  7%     -16.7%     254488 ± 12%  numa-vmstat.node1.nr_file_pages
     31041 ±  9%     -25.1%      23250 ± 12%  numa-vmstat.node1.nr_mapped
    271405           -18.7%     220634 ± 12%  numa-vmstat.node1.nr_shmem
    620152 ±  2%    +160.4%    1614732 ±  2%  will-it-scale.224.processes
      0.13           +46.2%       0.19 ±  4%  will-it-scale.224.processes_idle
      2768 ±  2%    +160.4%       7208 ±  2%  will-it-scale.per_process_ops
    620152 ±  2%    +160.4%    1614732 ±  2%  will-it-scale.workload
     32.33 ± 13%   +1535.6%     528.83 ± 12%  perf-c2c.DRAM.local
      3917 ±  6%     +54.6%       6054 ±  5%  perf-c2c.DRAM.remote
      5456 ±  7%     +25.3%       6835 ±  7%  perf-c2c.HITM.local
      3562 ±  7%     +22.8%       4376 ±  5%  perf-c2c.HITM.remote
      9019 ±  7%     +24.3%      11212 ±  6%  perf-c2c.HITM.total
    487248            -6.8%     454278        proc-vmstat.nr_active_anon
    107.00 ± 22%     -53.4%      49.84 ± 46%  proc-vmstat.nr_anon_transparent_hugepages
   1164233            -2.7%    1133175        proc-vmstat.nr_file_pages
     56483 ±  5%     -14.1%      48516 ±  6%  proc-vmstat.nr_mapped
    287834           -10.8%     256778        proc-vmstat.nr_shmem
    487248            -6.8%     454278        proc-vmstat.nr_zone_active_anon
     25013 ± 34%    +124.4%      56137 ±  5%  proc-vmstat.numa_hint_faults
     11595 ± 47%    +102.3%      23462 ± 38%  proc-vmstat.numa_hint_faults_local
   1728407            -1.8%    1697091        proc-vmstat.numa_hit
   1493274            -1.7%    1467674        proc-vmstat.numa_local
    179326 ± 15%     +70.1%     305113 ±  2%  proc-vmstat.numa_pte_updates
   1881688            -4.2%    1802948        proc-vmstat.pgalloc_normal
   1350178            +3.0%    1390538        proc-vmstat.pgfault
     64622 ± 17%     +29.0%      83367 ±  6%  proc-vmstat.pgreuse
  46897964 ±  2%     +23.2%   57779828 ±  5%  sched_debug.cfs_rq:/.avg_vruntime.max
  30929943           +10.8%   34256347        sched_debug.cfs_rq:/.avg_vruntime.min
   1297707 ±  7%    +112.5%    2758168 ± 11%  sched_debug.cfs_rq:/.avg_vruntime.stddev
      0.75 ± 11%     -29.6%       0.53 ± 11%  sched_debug.cfs_rq:/.h_nr_running.min
      3452 ± 10%     -29.5%       2433 ± 11%  sched_debug.cfs_rq:/.load.min
      3.00 ± 11%     -29.6%       2.11 ± 10%  sched_debug.cfs_rq:/.load_avg.min
  46897964 ±  2%     +23.2%   57779828 ±  5%  sched_debug.cfs_rq:/.min_vruntime.max
  30929943           +10.8%   34256347        sched_debug.cfs_rq:/.min_vruntime.min
   1297707 ±  7%    +112.5%    2758169 ± 11%  sched_debug.cfs_rq:/.min_vruntime.stddev
      0.75 ± 11%     -29.6%       0.53 ± 11%  sched_debug.cfs_rq:/.nr_running.min
    761.36 ± 10%     -27.3%     553.17 ±  7%  sched_debug.cfs_rq:/.runnable_avg.min
    673.31 ± 12%     -24.7%     507.00 ±  9%  sched_debug.cfs_rq:/.util_avg.min
    407.66          +107.2%     844.62        sched_debug.cfs_rq:/.util_est.avg
    755.11 ±  6%     +98.5%       1498 ±  8%  sched_debug.cfs_rq:/.util_est.max
      7.03 ±147%   +6359.7%     453.97 ± 21%  sched_debug.cfs_rq:/.util_est.min
    972664           -69.0%     301696 ± 18%  sched_debug.cpu.avg_idle.avg
   1514330 ±  4%     -51.5%     734068 ± 11%  sched_debug.cpu.avg_idle.max
    161784 ±  3%     -97.2%       4568 ± 49%  sched_debug.cpu.avg_idle.min
     26.03 ±  4%     -13.2%      22.60 ±  8%  sched_debug.cpu.clock.stddev
      5158 ±  7%     -25.0%       3867 ± 18%  sched_debug.cpu.curr->pid.min
      2243           +41.7%       3179 ±  4%  sched_debug.cpu.nr_switches.avg
    783.47 ±  4%     +45.8%       1142 ±  2%  sched_debug.cpu.nr_switches.min
      0.18           -14.7%       0.16 ±  2%  perf-stat.i.MPKI
 1.286e+10          +143.1%  3.126e+10        perf-stat.i.branch-instructions
      0.11            -0.0        0.06        perf-stat.i.branch-miss-rate%
  12831155           +25.5%   16098495        perf-stat.i.branch-misses
     30.76 ±  2%      +3.9       34.69 ±  2%  perf-stat.i.cache-miss-rate%
   9505547          +150.7%   23827336 ±  2%  perf-stat.i.cache-misses
  32785522 ±  2%    +112.8%   69779552        perf-stat.i.cache-references
      1988           +71.3%       3406 ±  8%  perf-stat.i.context-switches
     12.29           -66.5%       4.12        perf-stat.i.cpi
    266.62            +7.4%     286.36        perf-stat.i.cpu-migrations
     69838           -60.9%      27322 ±  2%  perf-stat.i.cycles-between-cache-misses
 5.257e+10          +198.1%  1.567e+11        perf-stat.i.instructions
      0.09          +188.2%       0.25        perf-stat.i.ipc
      0.18           -15.8%       0.15 ±  2%  perf-stat.overall.MPKI
      0.10            -0.0        0.05        perf-stat.overall.branch-miss-rate%
     28.59            +5.5       34.11 ±  2%  perf-stat.overall.cache-miss-rate%
     12.31           -66.5%       4.13        perf-stat.overall.cpi
     68150           -60.2%      27152 ±  2%  perf-stat.overall.cycles-between-cache-misses
      0.08          +198.3%       0.24        perf-stat.overall.ipc
  25547531 ±  2%     +14.4%   29237729        perf-stat.overall.path-length
 1.282e+10          +143.1%  3.116e+10        perf-stat.ps.branch-instructions
  12599626           +27.1%   16009955        perf-stat.ps.branch-misses
   9468988          +151.0%   23763879 ±  2%  perf-stat.ps.cache-misses
  33116170          +110.4%   69681456        perf-stat.ps.cache-references
      1970           +72.2%       3393 ±  8%  perf-stat.ps.context-switches
    262.57            +8.5%     284.83        perf-stat.ps.cpu-migrations
 5.239e+10          +198.1%  1.562e+11        perf-stat.ps.instructions
      4015            +2.3%       4106        perf-stat.ps.minor-faults
      4015            +2.3%       4106        perf-stat.ps.page-faults
 1.583e+13          +198.0%  4.719e+13        perf-stat.total.instructions
      3.48 ±  7%     -88.4%       0.40 ±223%  perf-sched.sch_delay.avg.ms.__cond_resched.__alloc_pages_noprof.alloc_pages_mpol_noprof.folio_alloc_mpol_noprof.shmem_alloc_folio
      3.63 ± 11%     -94.0%       0.22 ±223%  perf-sched.sch_delay.avg.ms.__cond_resched.__do_fault.do_read_fault.do_pte_missing.__handle_mm_fault
      0.13 ±  3%     -74.7%       0.03 ±  7%  perf-sched.sch_delay.avg.ms.__cond_resched.__wait_for_common.affine_move_task.__set_cpus_allowed_ptr.__sched_setaffinity
      0.02 ±108%   +1600.0%       0.28 ± 35%  perf-sched.sch_delay.avg.ms.__cond_resched.dput.__fput.__x64_sys_close.do_syscall_64
      0.77 ±  4%     -45.9%       0.42 ± 18%  perf-sched.sch_delay.avg.ms.__cond_resched.dput.terminate_walk.path_openat.do_filp_open
      3.65 ±  4%     -93.0%       0.25 ±222%  perf-sched.sch_delay.avg.ms.__cond_resched.generic_perform_write.shmem_file_write_iter.vfs_write.ksys_write
      0.09 ± 47%     -97.4%       0.00 ±143%  perf-sched.sch_delay.avg.ms.__cond_resched.kvfree_rcu_drain_ready.kfree_rcu_monitor.process_one_work.worker_thread
      3.50 ± 16%     -92.6%       0.26 ±223%  perf-sched.sch_delay.avg.ms.__cond_resched.shmem_inode_acct_blocks.shmem_alloc_and_add_folio.shmem_get_folio_gfp.shmem_write_begin
      0.05 ± 10%     -74.1%       0.01 ± 85%  perf-sched.sch_delay.avg.ms.__cond_resched.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      0.87 ± 11%     -26.2%       0.64 ± 16%  perf-sched.sch_delay.avg.ms.__cond_resched.stop_one_cpu.sched_exec.bprm_execve.part
      0.61 ±103%     -99.3%       0.00 ± 14%  perf-sched.sch_delay.avg.ms.ipmi_thread.kthread.ret_from_fork.ret_from_fork_asm
      0.07 ± 16%     -89.8%       0.01 ± 11%  perf-sched.sch_delay.avg.ms.irq_thread.kthread.ret_from_fork.ret_from_fork_asm
      3.83           -27.8%       2.76 ±  9%  perf-sched.sch_delay.avg.ms.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt.[unknown]
      3.40 ± 19%     -90.7%       0.32 ± 38%  perf-sched.sch_delay.avg.ms.irqentry_exit_to_user_mode.asm_sysvec_reschedule_ipi.[unknown]
      0.12 ± 35%     -67.6%       0.04 ± 42%  perf-sched.sch_delay.avg.ms.pipe_read.vfs_read.ksys_read.do_syscall_64
      0.53 ± 16%     -77.4%       0.12 ± 64%  perf-sched.sch_delay.avg.ms.schedule_hrtimeout_range.do_poll.constprop.0.do_sys_poll
      0.14 ± 37%     +97.9%       0.28 ± 10%  perf-sched.sch_delay.avg.ms.schedule_timeout.__wait_for_common.wait_for_completion_state.kernel_clone
      0.06 ± 35%     -88.2%       0.01 ± 70%  perf-sched.sch_delay.avg.ms.schedule_timeout.msleep.ast_astdp_connector_helper_detect_ctx.drm_helper_probe_detect_ctx
      0.07 ±  4%     -49.5%       0.04 ± 50%  perf-sched.sch_delay.avg.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
      0.02 ±  4%     -65.4%       0.01 ± 23%  perf-sched.sch_delay.avg.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      0.74 ±  5%     -65.9%       0.25 ± 67%  perf-sched.sch_delay.avg.ms.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
      0.23 ± 45%     -83.4%       0.04 ± 96%  perf-sched.sch_delay.avg.ms.usleep_range_state.ipmi_thread.kthread.ret_from_fork
      4.13           -83.9%       0.67 ±223%  perf-sched.sch_delay.max.ms.__cond_resched.__alloc_pages_noprof.alloc_pages_mpol_noprof.folio_alloc_mpol_noprof.shmem_alloc_folio
      4.14           -84.0%       0.66 ±223%  perf-sched.sch_delay.max.ms.__cond_resched.__do_fault.do_read_fault.do_pte_missing.__handle_mm_fault
      0.03 ±156%  +21902.3%       6.42 ± 77%  perf-sched.sch_delay.max.ms.__cond_resched.dput.__fput.__x64_sys_close.do_syscall_64
     18.15 ± 42%     -74.4%       4.64 ± 30%  perf-sched.sch_delay.max.ms.__cond_resched.dput.terminate_walk.path_openat.do_filp_open
      4.15           -83.9%       0.67 ±223%  perf-sched.sch_delay.max.ms.__cond_resched.generic_perform_write.shmem_file_write_iter.vfs_write.ksys_write
      0.10 ± 39%     -97.6%       0.00 ±143%  perf-sched.sch_delay.max.ms.__cond_resched.kvfree_rcu_drain_ready.kfree_rcu_monitor.process_one_work.worker_thread
      4.09           -83.7%       0.67 ±223%  perf-sched.sch_delay.max.ms.__cond_resched.shmem_inode_acct_blocks.shmem_alloc_and_add_folio.shmem_get_folio_gfp.shmem_write_begin
      3.28           +13.5%       3.72 ±  6%  perf-sched.sch_delay.max.ms.__cond_resched.stop_one_cpu.sched_exec.bprm_execve.part
      1.05 ±119%     -99.6%       0.00 ±  8%  perf-sched.sch_delay.max.ms.ipmi_thread.kthread.ret_from_fork.ret_from_fork_asm
      0.16 ±  9%     -92.7%       0.01 ± 21%  perf-sched.sch_delay.max.ms.irq_thread.kthread.ret_from_fork.ret_from_fork_asm
     13.59 ± 16%     -64.6%       4.81 ± 41%  perf-sched.sch_delay.max.ms.pipe_read.vfs_read.ksys_read.do_syscall_64
      3.98 ±  4%     -80.3%       0.78 ± 42%  perf-sched.sch_delay.max.ms.schedule_hrtimeout_range.do_poll.constprop.0.do_sys_poll
      0.06 ± 81%     -92.7%       0.00 ± 83%  perf-sched.sch_delay.max.ms.schedule_timeout.__wait_for_common.__flush_work.__lru_add_drain_all
      0.09 ± 50%     -88.3%       0.01 ±101%  perf-sched.sch_delay.max.ms.schedule_timeout.msleep.ast_astdp_connector_helper_detect_ctx.drm_helper_probe_detect_ctx
      0.20 ±  9%   +2615.7%       5.51 ± 60%  perf-sched.sch_delay.max.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
      2.40 ± 36%     +53.4%       3.68 ±  8%  perf-sched.sch_delay.max.ms.wait_for_partner.fifo_open.do_dentry_open.vfs_open
    144.41 ±  3%     -31.7%      98.62 ±  7%  perf-sched.total_wait_and_delay.average.ms
     10694 ±  2%     +33.0%      14221 ±  5%  perf-sched.total_wait_and_delay.count.ms
    143.83 ±  3%     -31.8%      98.07 ±  7%  perf-sched.total_wait_time.average.ms
      3.50 ±  5%     +85.0%       6.47 ± 12%  perf-sched.wait_and_delay.avg.ms.__cond_resched.__wait_for_common.affine_move_task.__set_cpus_allowed_ptr.__sched_setaffinity
    411.43 ± 20%     -58.3%     171.38 ± 70%  perf-sched.wait_and_delay.avg.ms.__cond_resched.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      0.87 ± 11%     -24.7%       0.66 ± 19%  perf-sched.wait_and_delay.avg.ms.__cond_resched.stop_one_cpu.sched_exec.bprm_execve.part
    683.93 ± 24%     -22.0%     533.76 ± 35%  perf-sched.wait_and_delay.avg.ms.do_nanosleep.hrtimer_nanosleep.common_nsleep.__x64_sys_clock_nanosleep
      1.90 ±  6%     -17.9%       1.56 ± 13%  perf-sched.wait_and_delay.avg.ms.do_wait.kernel_wait4.do_syscall_64.entry_SYSCALL_64_after_hwframe
      7.66           -27.8%       5.53 ±  9%  perf-sched.wait_and_delay.avg.ms.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt.[unknown]
    188.08 ± 32%     -57.5%      79.88 ± 23%  perf-sched.wait_and_delay.avg.ms.pipe_read.vfs_read.ksys_read.do_syscall_64
      1.39 ± 16%     +20.1%       1.67 ±  7%  perf-sched.wait_and_delay.avg.ms.schedule_timeout.__wait_for_common.wait_for_completion_state.kernel_clone
      2265           -96.8%      72.33 ± 46%  perf-sched.wait_and_delay.count.__cond_resched.dput.terminate_walk.path_openat.do_filp_open
    123.00           -24.0%      93.50 ±  9%  perf-sched.wait_and_delay.count.__cond_resched.stop_one_cpu.sched_exec.bprm_execve.part
    102.00            +9.5%     111.67 ±  2%  perf-sched.wait_and_delay.count.do_wait.kernel_wait4.do_syscall_64.entry_SYSCALL_64_after_hwframe
    409.00 ± 25%    +135.5%     963.33 ± 27%  perf-sched.wait_and_delay.count.pipe_read.vfs_read.ksys_read.do_syscall_64
      2450 ±  5%     -81.0%     466.00 ± 76%  perf-sched.wait_and_delay.count.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
      1003          +348.9%       4506 ± 23%  perf-sched.wait_and_delay.max.ms.__cond_resched.__wait_for_common.affine_move_task.__set_cpus_allowed_ptr.__sched_setaffinity
      3.28           +31.6%       4.31 ± 33%  perf-sched.wait_and_delay.max.ms.__cond_resched.stop_one_cpu.sched_exec.bprm_execve.part
    143.48 ±139%     -99.7%       0.40 ±223%  perf-sched.wait_time.avg.ms.__cond_resched.__alloc_pages_noprof.alloc_pages_mpol_noprof.folio_alloc_mpol_noprof.shmem_alloc_folio
    116.07 ±216%     -99.8%       0.22 ±223%  perf-sched.wait_time.avg.ms.__cond_resched.__do_fault.do_read_fault.do_pte_missing.__handle_mm_fault
      3.37 ±  5%     +91.1%       6.44 ± 12%  perf-sched.wait_time.avg.ms.__cond_resched.__wait_for_common.affine_move_task.__set_cpus_allowed_ptr.__sched_setaffinity
      0.02 ±108%   +3587.0%       0.61 ± 34%  perf-sched.wait_time.avg.ms.__cond_resched.dput.__fput.__x64_sys_close.do_syscall_64
    361.12 ±160%     -99.9%       0.26 ±223%  perf-sched.wait_time.avg.ms.__cond_resched.shmem_inode_acct_blocks.shmem_alloc_and_add_folio.shmem_get_folio_gfp.shmem_write_begin
    411.38 ± 20%     -54.1%     188.90 ± 51%  perf-sched.wait_time.avg.ms.__cond_resched.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
    683.63 ± 24%     -22.0%     533.55 ± 35%  perf-sched.wait_time.avg.ms.do_nanosleep.hrtimer_nanosleep.common_nsleep.__x64_sys_clock_nanosleep
      0.79 ± 76%     -74.2%       0.20        perf-sched.wait_time.avg.ms.ipmi_thread.kthread.ret_from_fork.ret_from_fork_asm
      3.83           -27.8%       2.76 ±  9%  perf-sched.wait_time.avg.ms.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt.[unknown]
      3.40 ± 19%     -90.2%       0.33 ± 43%  perf-sched.wait_time.avg.ms.irqentry_exit_to_user_mode.asm_sysvec_reschedule_ipi.[unknown]
    187.96 ± 32%     -57.5%      79.84 ± 23%  perf-sched.wait_time.avg.ms.pipe_read.vfs_read.ksys_read.do_syscall_64
      0.02 ± 48%     -91.7%       0.00 ±223%  perf-sched.wait_time.avg.ms.schedule_timeout.__wait_for_common.__flush_work.__lru_add_drain_all
      0.35 ± 30%     -37.1%       0.22 ± 18%  perf-sched.wait_time.avg.ms.usleep_range_state.ipmi_thread.kthread.ret_from_fork
      1386 ±141%    -100.0%       0.67 ±223%  perf-sched.wait_time.max.ms.__cond_resched.__alloc_pages_noprof.alloc_pages_mpol_noprof.folio_alloc_mpol_noprof.shmem_alloc_folio
    790.56 ±222%     -99.9%       0.66 ±223%  perf-sched.wait_time.max.ms.__cond_resched.__do_fault.do_read_fault.do_pte_missing.__handle_mm_fault
      1002          +349.5%       4505 ± 23%  perf-sched.wait_time.max.ms.__cond_resched.__wait_for_common.affine_move_task.__set_cpus_allowed_ptr.__sched_setaffinity
      0.03 ±156%  +48113.7%      14.06 ± 79%  perf-sched.wait_time.max.ms.__cond_resched.dput.__fput.__x64_sys_close.do_syscall_64
      1464 ±141%    -100.0%       0.67 ±223%  perf-sched.wait_time.max.ms.__cond_resched.shmem_inode_acct_blocks.shmem_alloc_and_add_folio.shmem_get_folio_gfp.shmem_write_begin
      1.21 ± 98%     -83.2%       0.20        perf-sched.wait_time.max.ms.ipmi_thread.kthread.ret_from_fork.ret_from_fork_asm
      0.05 ± 47%     -96.2%       0.00 ±223%  perf-sched.wait_time.max.ms.schedule_timeout.__wait_for_common.__flush_work.__lru_add_drain_all
      2.40 ± 36%     +53.4%       3.68 ±  8%  perf-sched.wait_time.max.ms.wait_for_partner.fifo_open.do_dentry_open.vfs_open
     75.05           -72.6        2.42 ± 10%  perf-profile.calltrace.cycles-pp.path_openat.do_filp_open.do_sys_openat2.__x64_sys_openat.do_syscall_64
     75.05           -72.6        2.43 ± 10%  perf-profile.calltrace.cycles-pp.do_filp_open.do_sys_openat2.__x64_sys_openat.do_syscall_64.entry_SYSCALL_64_after_hwframe
     75.14           -72.6        2.57 ±  9%  perf-profile.calltrace.cycles-pp.do_sys_openat2.__x64_sys_openat.do_syscall_64.entry_SYSCALL_64_after_hwframe.open64
     75.14           -72.6        2.58 ±  9%  perf-profile.calltrace.cycles-pp.__x64_sys_openat.do_syscall_64.entry_SYSCALL_64_after_hwframe.open64
     75.16           -72.6        2.61 ±  9%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.open64
     75.16           -72.5        2.62 ±  9%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.open64
     75.18           -72.5        2.66 ±  9%  perf-profile.calltrace.cycles-pp.open64
     50.23           -48.6        1.66 ± 12%  perf-profile.calltrace.cycles-pp.do_open.path_openat.do_filp_open.do_sys_openat2.__x64_sys_openat
     25.20           -25.2        0.00        perf-profile.calltrace.cycles-pp.lockref_get.do_dentry_open.vfs_open.do_open.path_openat
     25.16           -25.2        0.00        perf-profile.calltrace.cycles-pp._raw_spin_lock.lockref_get.do_dentry_open.vfs_open.do_open
     25.16           -25.2        0.00        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock.lockref_get.do_dentry_open.vfs_open
     24.88           -24.9        0.00        perf-profile.calltrace.cycles-pp._raw_spin_lock.lockref_get_not_dead.__legitimize_path.try_to_unlazy.complete_walk
     24.87           -24.9        0.00        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock.lockref_get_not_dead.__legitimize_path.try_to_unlazy
     24.73           -24.7        0.00        perf-profile.calltrace.cycles-pp._raw_spin_lock.dput.terminate_walk.path_openat.do_filp_open
     24.72           -24.7        0.00        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock.dput.terminate_walk.path_openat
     24.92           -24.5        0.46 ± 45%  perf-profile.calltrace.cycles-pp.lockref_get_not_dead.__legitimize_path.try_to_unlazy.complete_walk.do_open
     24.46           -24.5        0.00        perf-profile.calltrace.cycles-pp._raw_spin_lock.dput.__fput.__x64_sys_close.do_syscall_64
     24.92           -24.5        0.46 ± 45%  perf-profile.calltrace.cycles-pp.__legitimize_path.try_to_unlazy.complete_walk.do_open.path_openat
     24.93           -24.5        0.47 ± 45%  perf-profile.calltrace.cycles-pp.try_to_unlazy.complete_walk.do_open.path_openat.do_filp_open
     24.93           -24.5        0.47 ± 45%  perf-profile.calltrace.cycles-pp.complete_walk.do_open.path_openat.do_filp_open.do_sys_openat2
     24.45           -24.5        0.00        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock.dput.__fput.__x64_sys_close
     25.28           -24.2        1.05 ± 17%  perf-profile.calltrace.cycles-pp.do_dentry_open.vfs_open.do_open.path_openat.do_filp_open
     25.28           -24.2        1.07 ± 17%  perf-profile.calltrace.cycles-pp.vfs_open.do_open.path_openat.do_filp_open.do_sys_openat2
     24.76           -24.2        0.60 ±  6%  perf-profile.calltrace.cycles-pp.dput.terminate_walk.path_openat.do_filp_open.do_sys_openat2
     24.76           -24.1        0.61 ±  6%  perf-profile.calltrace.cycles-pp.terminate_walk.path_openat.do_filp_open.do_sys_openat2.__x64_sys_openat
     24.50           -23.9        0.57 ±  7%  perf-profile.calltrace.cycles-pp.dput.__fput.__x64_sys_close.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00            +0.5        0.54 ±  6%  perf-profile.calltrace.cycles-pp.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.osq_lock.__mutex_lock
      0.00            +0.6        0.55 ±  5%  perf-profile.calltrace.cycles-pp.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.osq_lock.__mutex_lock.evm_file_release
      0.00            +0.6        0.56 ±  7%  perf-profile.calltrace.cycles-pp.lockref_put_return.dput.__fput.__x64_sys_close.do_syscall_64
      0.00            +0.6        0.58 ±  5%  perf-profile.calltrace.cycles-pp.asm_sysvec_apic_timer_interrupt.osq_lock.__mutex_lock.evm_file_release.security_file_release
      0.00            +0.6        0.60 ±  7%  perf-profile.calltrace.cycles-pp.lockref_put_return.dput.terminate_walk.path_openat.do_filp_open
     24.57           +72.2       96.75        perf-profile.calltrace.cycles-pp.__fput.__x64_sys_close.do_syscall_64.entry_SYSCALL_64_after_hwframe.__close
     24.63           +72.4       97.02        perf-profile.calltrace.cycles-pp.__x64_sys_close.do_syscall_64.entry_SYSCALL_64_after_hwframe.__close
     24.64           +72.4       97.09        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__close
     24.65           +72.5       97.10        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__close
     24.66           +72.5       97.15        perf-profile.calltrace.cycles-pp.__close
      0.00           +95.1       95.15        perf-profile.calltrace.cycles-pp.osq_lock.__mutex_lock.evm_file_release.security_file_release.__fput
      0.00           +95.5       95.52        perf-profile.calltrace.cycles-pp.__mutex_lock.evm_file_release.security_file_release.__fput.__x64_sys_close
      0.00           +95.7       95.71        perf-profile.calltrace.cycles-pp.evm_file_release.security_file_release.__fput.__x64_sys_close.do_syscall_64
      0.00           +95.9       95.87        perf-profile.calltrace.cycles-pp.security_file_release.__fput.__x64_sys_close.do_syscall_64.entry_SYSCALL_64_after_hwframe
     99.26           -99.3        0.00        perf-profile.children.cycles-pp._raw_spin_lock
     99.23           -99.2        0.00        perf-profile.children.cycles-pp.native_queued_spin_lock_slowpath
     75.05           -72.6        2.42 ± 10%  perf-profile.children.cycles-pp.path_openat
     75.05           -72.6        2.43 ± 10%  perf-profile.children.cycles-pp.do_filp_open
     75.14           -72.6        2.58 ±  9%  perf-profile.children.cycles-pp.do_sys_openat2
     75.14           -72.6        2.58 ±  9%  perf-profile.children.cycles-pp.__x64_sys_openat
     75.18           -72.5        2.68 ±  9%  perf-profile.children.cycles-pp.open64
     50.23           -48.6        1.66 ± 12%  perf-profile.children.cycles-pp.do_open
     49.26           -48.1        1.17 ±  6%  perf-profile.children.cycles-pp.dput
     25.20           -24.8        0.44 ±  6%  perf-profile.children.cycles-pp.lockref_get
     24.92           -24.4        0.54 ±  7%  perf-profile.children.cycles-pp.lockref_get_not_dead
     24.93           -24.4        0.54 ±  7%  perf-profile.children.cycles-pp.__legitimize_path
     24.93           -24.4        0.56 ±  7%  perf-profile.children.cycles-pp.complete_walk
     24.93           -24.4        0.55 ±  7%  perf-profile.children.cycles-pp.try_to_unlazy
     25.28           -24.2        1.06 ± 17%  perf-profile.children.cycles-pp.do_dentry_open
     25.29           -24.2        1.07 ± 17%  perf-profile.children.cycles-pp.vfs_open
     24.76           -24.1        0.61 ±  6%  perf-profile.children.cycles-pp.terminate_walk
     99.88            -0.1       99.80        perf-profile.children.cycles-pp.do_syscall_64
     99.88            -0.1       99.81        perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
      0.15 ±  4%      +0.0        0.17 ±  2%  perf-profile.children.cycles-pp.task_tick_fair
      0.24 ±  4%      +0.0        0.26        perf-profile.children.cycles-pp.sched_tick
      0.38 ±  5%      +0.0        0.42 ±  4%  perf-profile.children.cycles-pp.__hrtimer_run_queues
      0.38 ±  5%      +0.0        0.42 ±  4%  perf-profile.children.cycles-pp.tick_nohz_handler
      0.35 ±  4%      +0.0        0.39 ±  3%  perf-profile.children.cycles-pp.update_process_times
      0.00            +0.1        0.05        perf-profile.children.cycles-pp.entry_SYSCALL_64
      0.00            +0.1        0.05        perf-profile.children.cycles-pp.kmem_cache_alloc_noprof
      0.00            +0.1        0.05 ±  8%  perf-profile.children.cycles-pp.alloc_empty_file
      0.00            +0.1        0.05 ± 13%  perf-profile.children.cycles-pp.mutex_spin_on_owner
      0.51 ±  6%      +0.1        0.56 ±  5%  perf-profile.children.cycles-pp.__sysvec_apic_timer_interrupt
      0.00            +0.1        0.06 ± 16%  perf-profile.children.cycles-pp.evm_iint_find
      0.00            +0.1        0.06        perf-profile.children.cycles-pp.link_path_walk
      0.00            +0.1        0.07 ±  5%  perf-profile.children.cycles-pp.syscall_exit_to_user_mode
      0.00            +0.1        0.09        perf-profile.children.cycles-pp.getname_flags
      0.00            +0.1        0.11 ±  8%  perf-profile.children.cycles-pp.osq_unlock
      0.00            +0.1        0.12 ±  4%  perf-profile.children.cycles-pp.mutex_unlock
      0.00            +0.1        0.13 ± 14%  perf-profile.children.cycles-pp.mutex_lock
      0.05            +1.1        1.16 ±  6%  perf-profile.children.cycles-pp.lockref_put_return
     24.57           +72.2       96.76        perf-profile.children.cycles-pp.__fput
     24.63           +72.4       97.02        perf-profile.children.cycles-pp.__x64_sys_close
     24.67           +72.5       97.17        perf-profile.children.cycles-pp.__close
      0.00           +95.2       95.17        perf-profile.children.cycles-pp.osq_lock
      0.00           +95.5       95.53        perf-profile.children.cycles-pp.__mutex_lock
      0.00           +95.7       95.71        perf-profile.children.cycles-pp.evm_file_release
      0.00           +95.9       95.87        perf-profile.children.cycles-pp.security_file_release
     98.69           -98.7        0.00        perf-profile.self.cycles-pp.native_queued_spin_lock_slowpath
      0.00            +0.1        0.05 ±  7%  perf-profile.self.cycles-pp.mutex_spin_on_owner
      0.00            +0.1        0.05 ± 13%  perf-profile.self.cycles-pp.evm_iint_find
      0.00            +0.1        0.11 ±  8%  perf-profile.self.cycles-pp.osq_unlock
      0.00            +0.1        0.11 ±  4%  perf-profile.self.cycles-pp.mutex_unlock
      0.00            +0.1        0.12 ± 13%  perf-profile.self.cycles-pp.mutex_lock
      0.06            +0.2        0.22 ± 23%  perf-profile.self.cycles-pp.__fput
      0.00            +0.2        0.19 ±  7%  perf-profile.self.cycles-pp.__mutex_lock
      0.00            +0.4        0.43 ±  6%  perf-profile.self.cycles-pp.lockref_get
      0.07 ±  5%      +0.5        0.59 ± 29%  perf-profile.self.cycles-pp.do_dentry_open
      0.00            +0.5        0.54 ±  7%  perf-profile.self.cycles-pp.lockref_get_not_dead
      0.05            +1.1        1.16 ±  7%  perf-profile.self.cycles-pp.lockref_put_return
      0.00           +94.6       94.60        perf-profile.self.cycles-pp.osq_lock




Disclaimer:
Results have been estimated based on internal Intel analysis and are provided
for informational purposes only. Any difference in system hardware or software
design or configuration may affect actual performance.


-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


