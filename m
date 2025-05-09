Return-Path: <linux-integrity+bounces-6170-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A8FAAB0F10
	for <lists+linux-integrity@lfdr.de>; Fri,  9 May 2025 11:34:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 539C41BA150A
	for <lists+linux-integrity@lfdr.de>; Fri,  9 May 2025 09:34:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80637279330;
	Fri,  9 May 2025 09:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="i/nyMrmT"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 767224B1E7C;
	Fri,  9 May 2025 09:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746783274; cv=fail; b=MsV+dKZ2EEcE57gcRvctH6TmVMw+1pjOXpiI+VDFRdd6a3heRQMQMsqtV2yXA0mJ9IxIBfKI6ECCkzKoNGVu/+YxDA1KlDOV7V+65sJdRDoD9zF8f2BaE+hfxQUxZ149qnN6knXiXmcM2mSLozopBTGw2RgJ8L7IynFD8QDGpIc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746783274; c=relaxed/simple;
	bh=0o8CV+IvsEiN8kGiTxyeRqdB6DhRw0RiPGWeBAD3Hvs=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=J/HL07b9u+HDbQKQSI0oE0r/AE2vPv6WbEmAGwVQCT8N3QAUsh7vZbcNblPryCKR/ridj+dp0XZk58zYviSSLVUP8qBZWeHLhDOZFt6RFlPQ41jq4e5D3yfUYrCGBx99DlsY6M115ZDnr4J6FJ+7ChbGZmzvNepjdGreBnsaQF8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=i/nyMrmT; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746783272; x=1778319272;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   mime-version;
  bh=0o8CV+IvsEiN8kGiTxyeRqdB6DhRw0RiPGWeBAD3Hvs=;
  b=i/nyMrmTXJLCL+B3aBljb5ZvJyMzGmF8fQZSjmqIl6PpPKT4+aCmECLw
   PKjb1N9essPeWkFF60HMsBDaIH9WEbKRgBYjfwQzFJOQenIWuXmE8i16h
   ZnxhkmnAcSVyZss546KIr8GFqmJWphPr3ICtDVtj5t+RVK67Sq4fkdba0
   usvX9XwMNAnl5Cy5ulnullT2m3kQs1OEXdR5z1mmhmnGQvxIDJA9M5BC4
   HGGLC4kzCI5O7bIWiTuTJ9puGN7TLhwU5HBtfvj976jmMkwPG4AgEBSzn
   R3q4bWrCnFHrPOjpOcA4UIO8GI4IATF5WN2paQdDy3YUIxl5oOwFK25hp
   Q==;
X-CSE-ConnectionGUID: VAhWZI89STGzlWaFewj6yg==
X-CSE-MsgGUID: eWRboRLUSY+S6Xl/KAO5qQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11427"; a="66137625"
X-IronPort-AV: E=Sophos;i="6.15,274,1739865600"; 
   d="scan'208";a="66137625"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2025 02:34:31 -0700
X-CSE-ConnectionGUID: D46UGLE+TtS3YZ+pBDeK1Q==
X-CSE-MsgGUID: l05xFqAFQsCkUMiiZ17gOQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,274,1739865600"; 
   d="scan'208";a="167499543"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2025 02:34:31 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Fri, 9 May 2025 02:34:30 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Fri, 9 May 2025 02:34:30 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.170)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 9 May 2025 02:34:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JaRR45r6zDxd5qBzMep87QrsEZq7uOpv9RHtKsI/dDP0S9TkUwfvxnhkqKGL11AjpmX5ekoVz0gjO0ddjrXTc6WfgZ21NjnqFSAho+uLoGx969U+gMthFYSVNXLGujlmx27ha/PUKeyPHpuNWxfsOkf/KmTwAo/122LHwTR/tRX6PqUBSTLswXSaPwdMkyxhQIUNa/ls856NAyjXvSAa1uqMgOYMkyDU8wiFoZPX1KQO/ewz2VgOwDwvZtJtFSJm/tIaLrjHeXXsBLQyffQMpBwtbo0Jx9nNLDiPxBELZ5Q0b/OEi/q1dBTYl+MUaw/PjSLprMbwMCXjCkw0YY1tsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2tTurUHspoI76NSKWddFDKhABqGbX3pH349gVo0gHJ4=;
 b=cngTTonflaivj7lPsWwcu0w4lKwPf2l+TMOXDOzfacg+dkpWmSNahUTjFOyR7bvpjgIeIkyXdq1vgBsf7pl/212eeeFrDLTyDI7iyI6XOMRQgtCC3wy29URZfDpSe2Iru9Ult5LZwT9z0AWJ0LdWO6B7iSq4qdyHSxnX+gmrFx9hu6wxgrb64taCTO+L2unlZcNUQ2zLBFqs9iQXfp6xXs5f+TuvtSKCR+MkNBl41ytKo9fclw+A8eROcghybnzxsMq1BVnsebNnCdNhgG6rXU5k4RZMcbPzXurYHcwRdTSPP7VcMqMbO179IkkG8v22MBKIuaq4rtISSqiJzDCayQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by CO1PR11MB4914.namprd11.prod.outlook.com (2603:10b6:303:90::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.20; Fri, 9 May
 2025 09:34:22 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%4]) with mapi id 15.20.8722.021; Fri, 9 May 2025
 09:34:22 +0000
Date: Fri, 9 May 2025 17:34:09 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Herbert Xu <herbert@gondor.apana.org.au>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <keyrings@vger.kernel.org>,
	David Howells <dhowells@redhat.com>, Jarkko Sakkinen <jarkko@kernel.org>,
	Lukas Wunner <lukas@wunner.de>, Ignat Korchagin <ignat@cloudflare.com>,
	"David S. Miller" <davem@davemloft.net>, Peter Huewe <peterhuewe@gmx.de>,
	Jason Gunthorpe <jgg@ziepe.ca>, Paul Moore <paul@paul-moore.com>, "James
 Morris" <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, "James
 Bottomley" <James.Bottomley@hansenpartnership.com>, Mimi Zohar
	<zohar@linux.ibm.com>, <linux-crypto@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-integrity@vger.kernel.org>,
	<linux-security-module@vger.kernel.org>, <oliver.sang@intel.com>
Subject: Re: [v2 PATCH] KEYS: Invert FINAL_PUT bit
Message-ID: <202505091721.245cbe78-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <aBccz2nJs5Asg6cN@gondor.apana.org.au>
X-ClientProxiedBy: KU2P306CA0083.MYSP306.PROD.OUTLOOK.COM
 (2603:1096:d10:3a::10) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|CO1PR11MB4914:EE_
X-MS-Office365-Filtering-Correlation-Id: 4353390f-0ad0-4eec-859f-08dd8edcae18
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?lD+9mkDYVGsdiGRe+jitGY55v47+LJgKU8qncVZs2BH1Aui3hePPQAm0jsox?=
 =?us-ascii?Q?WX1X9VoATgj2O0YowhbjpCVxYUCrhCwiMDR3IXF8FNjniHDJiKy+YGH+DXwR?=
 =?us-ascii?Q?xzmUwjGZAs5INxPVYoD/38dM+HfYhUnPIKkNW1Lyec+ZgLqKld8JZjbczzRh?=
 =?us-ascii?Q?8cEaYSv0d77RFrowt2g6CTQpfTk4Fzk83kq2eij+Su1DYi6nRn2S0c722gGH?=
 =?us-ascii?Q?BZVo81KjaaMzuM3tt1I2/cgHJr7L00hpjUqHb0FPoF6dc6mfKpVnZiV9+RBS?=
 =?us-ascii?Q?p/kemRJjWXgZjmy0SImf2Kk0BJng4uY40wk2rpfv4WFLTbnWI6hi9/iDYRxN?=
 =?us-ascii?Q?Nur55lKQK8dUHYNZRUpEYwHgRhDPTWdaAbGknkwwzLVgSNRJigRy29qyYywd?=
 =?us-ascii?Q?zsbpT/ktRpo/R4VQFTJJjjgkDuW4xYGno3k9hpUuwliYBV88Hk3Df3oEtGsT?=
 =?us-ascii?Q?bGsRafbQje6y3wa1NKzwWwfcijgWAMXNs0GdZsqy0dt8B7fTid3h87yFSsop?=
 =?us-ascii?Q?0t5gJtKyjkfEBpjGhyZfJj32pBjN5sUI6oCX7SXd784QxsidZ+0PL7dJLrs1?=
 =?us-ascii?Q?27UxOuWfZow74qJq0EJJNhwg1fhBreHzmF8uvr63aFNo9MNPtbC0X17T09i8?=
 =?us-ascii?Q?1vjjltoY5qvLjUQwJZw1WZdjeMLDU0QCVln4y3Sk/FyKrslISGPgVRKpw7Tg?=
 =?us-ascii?Q?OALqQqEv1jt0EfguBgQ7De3bAR8cTo5uI76K31eG0Aq5FQyObTKrrQcvqexi?=
 =?us-ascii?Q?dN8XaSM4VxGldidzDIK2DZE1GxrJdCdmEVfbyn4SaQ2Z7XKhyrQNJNz5v3Fz?=
 =?us-ascii?Q?lOifeJEmrXvIeGC19vRAcjmDsal+EQMT+g83u1Xg3ZBUnIdo8N0zckElgCbr?=
 =?us-ascii?Q?/FVEXwWR4lbxyEWJRlULDycQmmfBr3zVT4ToaRSwiTu1kHENesexpSO7RsqV?=
 =?us-ascii?Q?t7aQ0bl2CGnHu38AiTDasswFSQibbQSaWOVBGs4cxeAeELwG0CJJBDycU/6R?=
 =?us-ascii?Q?g1kL1+2toaj4eV6DY8OgG+q4uPDFiy0jd6FkxDF9DsAR+9eLaWu2qCenQb97?=
 =?us-ascii?Q?BXxh2Dcx7+R9n2wCyUPNsHsltfSleUh5dI+Jk7fhElZKnlYMsHDiAdm868uK?=
 =?us-ascii?Q?lh0aGgIrQ5w/ZH2D+LUwOosJoYRAVitvyKlp75gV52NlW0ZqHfUkoyjW8VHU?=
 =?us-ascii?Q?TjNt+jwXrR49DqJOMlxZRUnOxg3E00xYcba1SWU6LnmtnOnA/Nw5r52Bn/7g?=
 =?us-ascii?Q?QbytOOWinh7E4jpwS/FXEjKwmCRLzxFGG8dhmdX4jNRz2FYdVkekbPdJox/A?=
 =?us-ascii?Q?wCH77r/cAtJTspirjEO2NGlRjPYJW3z/RJ7YgbURM95w6Zlt/Oun1f0acLMo?=
 =?us-ascii?Q?hYLKhDHh1ArfNNDxyddqXTMDts5e?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RK195qBP3BWbBWgiWOHw/JookeTklOO138tAoKUt9H6+Pm2gIbmdTXwG6+Nk?=
 =?us-ascii?Q?xEvlwZebukb/oxq5m/ETFQjx/Y1gNCuiNW0y/rhwiZ92w5d87DSyOKbP+iyf?=
 =?us-ascii?Q?7sN21OxzT0MEYRW4tx70rU+R8K+SbzqXhii/QFQ1XZqKMRCQJ1q5bl19z+eX?=
 =?us-ascii?Q?nJ1zUb0pvjMdupa2MBmh/uTIl0GbtN59P+yBKaz8YTRQmEUbTSGfgNauo3ar?=
 =?us-ascii?Q?49EJ6IE7HcHu/lh2COMQN+gTPp9Ch/XI18Um0A4a0Wtn7RSJ8JFNLMZvVfW9?=
 =?us-ascii?Q?hdEE3B2SQq4bwyIVtu4PYTUSgUAmlfvEqCcf6dRdig8kd07w8ZSekB1TpPL1?=
 =?us-ascii?Q?giE/rKXtKp8ZcujEv0xc1ruRVKPt8o6otZQ6iPFOx7kBf0CpfI4P+v51aeWD?=
 =?us-ascii?Q?qM5hzeqLN3MyM1W5mWQjLmdc/UYgtDnB6ELPsaAb5BGJLCMQH5Am2JiKKVY/?=
 =?us-ascii?Q?l1cphDX/onNQmhbxetGnyy974p4ddR3IZfPzIIJB7rUV0f2UVIZNewaIwIKR?=
 =?us-ascii?Q?brzUFNRvYQsNCN45Cj6+DDquR1Gf2GFgo0YV4UTDD3NwjIDHdar6d9qaIRHk?=
 =?us-ascii?Q?4P3VnE/YxT5qSu5GPE5tSzKeIQLCR7I3Jl6RpcIayjFZiZXAETukRulClgSw?=
 =?us-ascii?Q?2futsXTfHmcxbuwTAtP7n+bL1tLxDSHe5waybBwbQIEESdeWYvFyIv2NyMkw?=
 =?us-ascii?Q?xk1uJyIZnjanW46xeWzDlRmuaGaenWC/NAVr3eHudnNEXTx9p2saXndH9Lzd?=
 =?us-ascii?Q?BSIElMgqlJqcQgG3O2GA+jlxqLc9sr66FStG30QZRAs4sjrXHoP1vnH1ZUtP?=
 =?us-ascii?Q?t8iDudDXPMyTAru7LNIQm0rLFJHmsVsTGWgGXJCs2buwmeTKcSjamuV0yp9M?=
 =?us-ascii?Q?nJ/M7SK0oesI+U6wb6Av0yDwz814gFsiHM+YSMNWkxBJLtC4N68XzE8gmzuV?=
 =?us-ascii?Q?RvSqe1BPmslCg8zkgzlUXpYVwkfpyKNTrirXsS0KFloKzX7W8n9U55Yk2HaT?=
 =?us-ascii?Q?R/Y3OsUVu7icfTP+Ub7W14Uf5TL3YaoQqO4nL/5BbypJYkx4nyCI0UT1+eD9?=
 =?us-ascii?Q?Fq/zq8lxSeVCTD/CRndl+dLgo4nXd1gkoNqZ95NKvy1fpcbVfByDAJfG+vDA?=
 =?us-ascii?Q?TIzsFOETIugBSrq9giL5fPE1a2XEAXuLnDz6enISyrNR6VbsWy9rVBo1NDEO?=
 =?us-ascii?Q?HT5O/hCVyACa9SbFdTt3PZBosUHZIbQKl7/R7BL0/R9j4fu+H5tTwhNt74gR?=
 =?us-ascii?Q?V9k9KW+10l5uMnnsnQQ4rhKvtsERm3s2qmC3D/iHTZZzGzKkCyW4sL2FPGAE?=
 =?us-ascii?Q?WdB5aWlfyDHQrrFjPYW1MZJogGVMApSeIDRDQyF8XcEcBV/utheaAncTTdD9?=
 =?us-ascii?Q?wH/4s2jbSMaL5o3jNwNPJgdmvYs+bErnQ8Ew2PUeBGtRphF3czf+fxvn3jJ0?=
 =?us-ascii?Q?smQFmFMTVAjenSWbFsJANyTjedfZqqY6zc7KZvi0pHv3pfxDh/d1P5BHWqQt?=
 =?us-ascii?Q?bTvK3VmbPliN0O92yZsxyqTUJCWrnzlrqKqJ35xbdvIBeMwEesinmVYe8kCN?=
 =?us-ascii?Q?DNhSwSOoCjaVu9p/EOiUBKNG0aFkrmgW+JJzcren6NVYGHCYNOJjYirHahnx?=
 =?us-ascii?Q?6w=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4353390f-0ad0-4eec-859f-08dd8edcae18
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2025 09:34:22.4762
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZSgdPzf1vqVjYQH5fBMEvF39e5EpXY5WMCaKHgvbww8HVS25x4bOi/loSDfCJaTM7UIuPxMsIwPcbEkdRbqmAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4914
X-OriginatorOrg: intel.com



Hello,


our bot applied this patch directly upon v6.15-rc5. could you let us know if
this is a correct appliment?

* a78cdfa4388ab9 (linux-review/Herbert-Xu/KEYS-Invert-FINAL_PUT-bit/20250505-122533) KEYS: Invert FINAL_PUT bit
* 92a09c47464d04 (tag: v6.15-rc5, 


below reports is based on this appliement.


kernel test robot noticed "refcount_t:underflow;use-after-free" on:

commit: a78cdfa4388ab9b210c804b92453f14bbe199cbf ("[v2 PATCH] KEYS: Invert FINAL_PUT bit")
url: https://github.com/intel-lab-lkp/linux/commits/Herbert-Xu/KEYS-Invert-FINAL_PUT-bit/20250505-122533
base: https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git 92a09c47464d040866cf2b4cd052bc60555185fb
patch link: https://lore.kernel.org/all/aBccz2nJs5Asg6cN@gondor.apana.org.au/
patch subject: [v2 PATCH] KEYS: Invert FINAL_PUT bit

in testcase: trinity
version: trinity-i386-abe9de86-1_20230429
with following parameters:

	runtime: 300s
	group: group-04
	nr_groups: 5



config: i386-randconfig-014-20250509
compiler: gcc-12
test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G

(please refer to attached dmesg/kmsg for entire log/backtrace)


there are other (random) issues as below.

+-------------------------------------------------------------------------+-----------+------------+
|                                                                         | v6.15-rc5 | a78cdfa438 |
+-------------------------------------------------------------------------+-----------+------------+
| boot_successes                                                          | 80        | 0          |
| boot_failures                                                           | 0         | 48         |
| refcount_t:underflow;use-after-free                                     | 0         | 48         |
| WARNING:at_lib/refcount.c:#refcount_warn_saturate                       | 0         | 47         |
| EIP:refcount_warn_saturate                                              | 0         | 48         |
| addition_on#;use-after-free                                             | 0         | 46         |
| saturated;leaking_memory                                                | 0         | 44         |
| BUG:kernel_NULL_pointer_dereference,address                             | 0         | 31         |
| Oops                                                                    | 0         | 41         |
| EIP:keyctl_read_key                                                     | 0         | 27         |
| Kernel_panic-not_syncing:Fatal_exception                                | 0         | 36         |
| BUG:unable_to_handle_page_fault_for_address                             | 0         | 10         |
| EIP:key_put                                                             | 0         | 1          |
| Kernel_panic-not_syncing:Fatal_exception_in_interrupt                   | 0         | 5          |
| EIP:kmem_cache_alloc_noprof                                             | 0         | 2          |
| BUG:Bad_rss-counter_state_mm:#type:MM_SWAPENTS_val                      | 0         | 1          |
| EIP:keyctl_describe_key                                                 | 0         | 1          |
| EIP:keyring_gc_check_iterator                                           | 0         | 1          |
| EIP:dst_destroy                                                         | 0         | 3          |
| EIP:_raw_spin_unlock_irqrestore                                         | 0         | 1          |
| EIP:put_pid                                                             | 0         | 4          |
| EIP:rb_erase                                                            | 0         | 1          |
| EIP:kernel_init_pages                                                   | 0         | 1          |
| EIP:lookup_user_key                                                     | 0         | 1          |
| EIP:strlen                                                              | 0         | 1          |
| INFO:task_blocked_for_more_than#seconds                                 | 0         | 1          |
| BUG:kernel_hang_in_test_stage                                           | 0         | 1          |
+-------------------------------------------------------------------------+-----------+------------+


If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202505091721.245cbe78-lkp@intel.com


[    8.510562][   T60] ------------[ cut here ]------------
[    8.511283][   T60] refcount_t: underflow; use-after-free.
[ 8.511950][ T60] WARNING: CPU: 0 PID: 60 at lib/refcount.c:28 refcount_warn_saturate (kbuild/obj/consumer/i386-randconfig-014-20250509/lib/refcount.c:28 (discriminator 3)) 
[    8.512948][   T60] Modules linked in:
[    8.513488][   T60] CPU: 0 UID: 0 PID: 60 Comm: kworker/0:2 Not tainted 6.15.0-rc5-00001-ga78cdfa4388a #1 PREEMPT  231a29fdcec5e4259d3c91818150ae4baf2b3615
[    8.514973][   T60] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[    8.516145][   T60] Workqueue: events key_garbage_collector
[ 8.516849][ T60] EIP: refcount_warn_saturate (kbuild/obj/consumer/i386-randconfig-014-20250509/lib/refcount.c:28 (discriminator 3)) 
[ 8.517490][ T60] Code: fa c2 82 01 68 28 15 60 82 e8 e3 88 72 ff 0f 0b 58 c9 c3 8d b6 00 00 00 00 c6 05 2e fa c2 82 01 68 d0 14 60 82 e8 c7 88 72 ff <0f> 0b 59 c9 c3 66 90 89 c2 8b 00 3d 00 00 00 c0 74 12 83 f8 01 74
All code
========
   0:	fa                   	cli
   1:	c2 82 01             	ret    $0x182
   4:	68 28 15 60 82       	push   $0xffffffff82601528
   9:	e8 e3 88 72 ff       	call   0xffffffffff7288f1
   e:	0f 0b                	ud2
  10:	58                   	pop    %rax
  11:	c9                   	leave
  12:	c3                   	ret
  13:	8d b6 00 00 00 00    	lea    0x0(%rsi),%esi
  19:	c6 05 2e fa c2 82 01 	movb   $0x1,-0x7d3d05d2(%rip)        # 0xffffffff82c2fa4e
  20:	68 d0 14 60 82       	push   $0xffffffff826014d0
  25:	e8 c7 88 72 ff       	call   0xffffffffff7288f1
  2a:*	0f 0b                	ud2		<-- trapping instruction
  2c:	59                   	pop    %rcx
  2d:	c9                   	leave
  2e:	c3                   	ret
  2f:	66 90                	xchg   %ax,%ax
  31:	89 c2                	mov    %eax,%edx
  33:	8b 00                	mov    (%rax),%eax
  35:	3d 00 00 00 c0       	cmp    $0xc0000000,%eax
  3a:	74 12                	je     0x4e
  3c:	83 f8 01             	cmp    $0x1,%eax
  3f:	74                   	.byte 0x74

Code starting with the faulting instruction
===========================================
   0:	0f 0b                	ud2
   2:	59                   	pop    %rcx
   3:	c9                   	leave
   4:	c3                   	ret
   5:	66 90                	xchg   %ax,%ax
   7:	89 c2                	mov    %eax,%edx
   9:	8b 00                	mov    (%rax),%eax
   b:	3d 00 00 00 c0       	cmp    $0xc0000000,%eax
  10:	74 12                	je     0x24
  12:	83 f8 01             	cmp    $0x1,%eax
  15:	74                   	.byte 0x74
[    8.519470][   T60] EAX: 00000026 EBX: 85c8c9c0 ECX: 0000025c EDX: 00000000
[    8.520241][   T60] ESI: 85d4ede0 EDI: 821a0f00 EBP: 8405fe6c ESP: 8405fe68
[    8.521168][   T60] DS: 007b ES: 007b FS: 00d8 GS: 0000 SS: 0068 EFLAGS: 00010286
[    8.522055][   T60] CR0: 80050033 CR2: 77ecb6a1 CR3: 040b8000 CR4: 000406f0
[    8.522824][   T60] DR0: 00000000 DR1: 00000000 DR2: 00000000 DR3: 00000000
[    8.523614][   T60] DR6: fffe0ff0 DR7: 00000400
[    8.524161][   T60] Call Trace:
[ 8.524619][ T60] key_put (kbuild/obj/consumer/i386-randconfig-014-20250509/include/linux/refcount.h:400 kbuild/obj/consumer/i386-randconfig-014-20250509/include/linux/refcount.h:432 kbuild/obj/consumer/i386-randconfig-014-20250509/include/linux/refcount.h:450 kbuild/obj/consumer/i386-randconfig-014-20250509/security/keys/key.c:652) 
[ 8.525119][ T60] keyring_free_object (kbuild/obj/consumer/i386-randconfig-014-20250509/security/keys/keyring.c:390) 
[ 8.525736][ T60] assoc_array_destroy_subtree+0x7b/0x17c 
[ 8.526446][ T60] assoc_array_destroy (kbuild/obj/consumer/i386-randconfig-014-20250509/lib/assoc_array.c:445) 
[ 8.527048][ T60] keyring_destroy (kbuild/obj/consumer/i386-randconfig-014-20250509/security/keys/keyring.c:432) 
[ 8.527617][ T60] key_gc_unused_keys+0xfb/0x134 
[ 8.528301][ T60] key_garbage_collector (kbuild/obj/consumer/i386-randconfig-014-20250509/security/keys/gc.c:305) 
[ 8.528967][ T60] process_one_work (kbuild/obj/consumer/i386-randconfig-014-20250509/kernel/workqueue.c:3243) 
[ 8.529586][ T60] worker_thread (kbuild/obj/consumer/i386-randconfig-014-20250509/kernel/workqueue.c:3313 kbuild/obj/consumer/i386-randconfig-014-20250509/kernel/workqueue.c:3400) 
[ 8.530157][ T60] kthread (kbuild/obj/consumer/i386-randconfig-014-20250509/kernel/kthread.c:464) 
[ 8.530681][ T60] ? rescuer_thread (kbuild/obj/consumer/i386-randconfig-014-20250509/kernel/workqueue.c:3346) 
[ 8.531244][ T60] ? kthread_fetch_affinity+0x34/0x34 
[ 8.531930][ T60] ret_from_fork (kbuild/obj/consumer/i386-randconfig-014-20250509/arch/x86/kernel/process.c:159) 
[ 8.532498][ T60] ? kthread_fetch_affinity+0x34/0x34 
[ 8.533164][ T60] ret_from_fork_asm (kbuild/obj/consumer/i386-randconfig-014-20250509/arch/x86/entry/entry_32.S:737) 
[ 8.533766][ T60] entry_INT80_32 (kbuild/obj/consumer/i386-randconfig-014-20250509/arch/x86/entry/entry_32.S:945) 
[    8.534333][   T60] irq event stamp: 3905
[ 8.534868][ T60] hardirqs last enabled at (3917): __up_console_sem (kbuild/obj/consumer/i386-randconfig-014-20250509/arch/x86/include/asm/irqflags.h:42 (discriminator 1) kbuild/obj/consumer/i386-randconfig-014-20250509/arch/x86/include/asm/irqflags.h:119 (discriminator 1) kbuild/obj/consumer/i386-randconfig-014-20250509/arch/x86/include/asm/irqflags.h:159 (discriminator 1) kbuild/obj/consumer/i386-randconfig-014-20250509/kernel/printk/printk.c:344 (discriminator 1)) 
[ 8.535880][ T60] hardirqs last disabled at (3928): __up_console_sem (kbuild/obj/consumer/i386-randconfig-014-20250509/kernel/printk/printk.c:342 (discriminator 1)) 
[ 8.535891][ T60] softirqs last enabled at (3856): handle_softirqs (kbuild/obj/consumer/i386-randconfig-014-20250509/kernel/softirq.c:426 kbuild/obj/consumer/i386-randconfig-014-20250509/kernel/softirq.c:607) 
[ 8.535896][ T60] softirqs last disabled at (3851): __do_softirq (kbuild/obj/consumer/i386-randconfig-014-20250509/kernel/softirq.c:614) 
[    8.535904][   T60] ---[ end trace 0000000000000000 ]---


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20250509/202505091721.245cbe78-lkp@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


