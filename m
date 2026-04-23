Return-Path: <linux-integrity+bounces-9294-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SBOwCDL86WlyqwIAu9opvQ
	(envelope-from <linux-integrity+bounces-9294-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Thu, 23 Apr 2026 13:02:10 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D2708451086
	for <lists+linux-integrity@lfdr.de>; Thu, 23 Apr 2026 13:02:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8F807301494C
	for <lists+linux-integrity@lfdr.de>; Thu, 23 Apr 2026 10:58:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9095E3E4C99;
	Thu, 23 Apr 2026 10:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="WSOoM4FM";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="WSOoM4FM"
X-Original-To: linux-integrity@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011054.outbound.protection.outlook.com [52.101.65.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35ADD348469;
	Thu, 23 Apr 2026 10:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.54
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776941881; cv=fail; b=X3upKOVHJBAo5l5rU/Ep3Dr59mxxBYh5Cdbjxxb5Pxz/CvpH5ntui2R4saflDd3Cnkai6RiXwCcY8Wo1Qpu2IcMcPQnT0IZudpjL9cQX3uZLBnuL+ly/Y90XS9Bc5p2L9jX9ZJbZLXosan4qxbyzzJN3QiZx1ISCNgF4mPFGQ0I=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776941881; c=relaxed/simple;
	bh=IsUYOY5RrJ3U3YfXNM1mTb7b9ct/UvIUjK34QOaBXVk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Fnu6Q0s0TBFL67Vvydi75uI1FIztxR5CsM3g6vZuvE5ebTnpF1I/rdy5Tn6PZGovaN8840c6eTOhOXzYK6gXwpWpWqNqf3bDEq+Bf7veclR2SoUPljOaXUcmQG/71ly37nCRdAHShIwLi2xtorITIefqId4AS2K75qo25zTMGeE=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=WSOoM4FM; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=WSOoM4FM; arc=fail smtp.client-ip=52.101.65.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=tFUdErxT9oTEm/A6lfo2XGsxySZshD5o6wpUMi/JxaqskqTBa+JJTRKgrZdpj+vBvx8GG3JosXyF+5E2lIWezgJmQfbKIqorog66UqupKUmI3OQEvkXQIV6tZhopbiRTsyPFrDTB8O78lAX9gh8ssiXybcy4NyqZ3yG6/gEw4rT4fisp5D7ptd9oND1bUra097cHA+ztfpFnbX3refMTJGbDgycCu9ZeTPBrJLw8GsmJ/zjs29a/BN9kvzUbKjyV97JE4FAaSQjGSomB7wTgensJmKYf1JZs4vBRHE9hGdK7I2DZ7b4tBj3cGhJK6d2Jw1OhALSARFtavm69b+YgwQ==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=REZmYsJnGZxN/JBzOKPE6iHCGaRwRhr1OeqXDLvUVAA=;
 b=yB9fISI2Vyzr0tACq8oWt9GvCfhTpSvIRUHhVVo3fpyQwn+bMr6wJz+VsQkFY22ZQoFZNKxCjd10trco1Cwg4JEkUdhAG0BYPPF7UsFHictrCY/7DqJchaSDS+uIy8N/5sM/42H0flyja66LHnfPGQGYkM765wT/AzNCgqHM1J5aLy5OQouOdskYwurjQ7/aaXGrEWtlDg2Edv42dX5zDfAqtieDrnTvdFjSF3MhpYaSl5lc7h1hRponaGeayBYmS4oges41tRP63ezUpWkQGwCAcjgb0iHVI2OJdWLmQz9kusD4dInT6hmeilZD0Oe/7kYviJr9rhpJjcGnt0kMgA==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=kernel.org smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=REZmYsJnGZxN/JBzOKPE6iHCGaRwRhr1OeqXDLvUVAA=;
 b=WSOoM4FMta51R+PeK6dhG6CT5w5X/l3b24OxXJhTqwG1yske7LpHxOyRCvQiwFznnjK1wJS4HB5f1LMzNWzxDP1fxctJbm0C2FaM8g2oZeaivsGWdmozsgl5urss1CqMJMfISKFn1M1R/QYT6ghnLabyB+Wcvo7P1Kk0nycpg+U=
Received: from DUZPR01CA0090.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:46a::8) by DBBPR08MB10771.eurprd08.prod.outlook.com
 (2603:10a6:10:53a::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.17; Thu, 23 Apr
 2026 10:57:54 +0000
Received: from DB5PEPF00014B9B.eurprd02.prod.outlook.com
 (2603:10a6:10:46a:cafe::31) by DUZPR01CA0090.outlook.office365.com
 (2603:10a6:10:46a::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.21 via Frontend Transport; Thu,
 23 Apr 2026 10:57:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DB5PEPF00014B9B.mail.protection.outlook.com (10.167.8.168) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.18
 via Frontend Transport; Thu, 23 Apr 2026 10:57:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kM7M7bRke9wBq5GcYyp8hnhsplcAUlHRf/JIuz4fo4oRHtsG7G+nHaUmlSH2lYIXm1UkHlYDO1GYSlgpjl9Xsy/WsOBtxxwrfKKX7lx/dh7m596qHkR7IRWEwT0gGHVOTlXRLrjdTZAqrp18X+ik5icaMhoDCZH3SefQ4eixeFdsLK+7hW9HKvp6/MBYrT/VhOw+q/Q1IHJlKzgIGKyLRdyq6syAE4jMS8b2pROo4zcfQTOL3svmcBCuLHO5/M9y6PCE2j66/zdu+qbqEtQ5TbvNFl907h9uypScrPTAc++7V3BsAtF0N+GWi9LSxExNLMX0XshfOe6Cko5GPW/aqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=REZmYsJnGZxN/JBzOKPE6iHCGaRwRhr1OeqXDLvUVAA=;
 b=TGf0f95njdJ6Wujt6uR1ykeXzIR2LP/kjvF3SNAX5Bu2b8m8C+2Abb1QrqxiV9T8mnn15mpG0dRh/PQOuvlEtDqlwNruSfpMsfeoXNdtYpoN8vdj0nSHXb0tT0ebW7foQLep8X6a6FSDvHpKRETPYdvvMGKdGexJo0SRcfVl3zslGbbEhcQCIiLFKVDHykdVK/mgA4q/ZrZ45B86Z47xwqQbxhTpL+WxVBZDDGM8+suCXkOMGByNdTBmCkQO+v4UqdBCQKqvpjSJRswAuRGZIK7T1sc2hxOUYLxPCd3vV6fmPaLzRqEk6Q28Dx+KZ5VIYSahMGqhAFG5ypJcdsoVQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=REZmYsJnGZxN/JBzOKPE6iHCGaRwRhr1OeqXDLvUVAA=;
 b=WSOoM4FMta51R+PeK6dhG6CT5w5X/l3b24OxXJhTqwG1yske7LpHxOyRCvQiwFznnjK1wJS4HB5f1LMzNWzxDP1fxctJbm0C2FaM8g2oZeaivsGWdmozsgl5urss1CqMJMfISKFn1M1R/QYT6ghnLabyB+Wcvo7P1Kk0nycpg+U=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from GV1PR08MB10521.eurprd08.prod.outlook.com
 (2603:10a6:150:163::20) by GV2PR08MB8270.eurprd08.prod.outlook.com
 (2603:10a6:150:c1::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.21; Thu, 23 Apr
 2026 10:56:47 +0000
Received: from GV1PR08MB10521.eurprd08.prod.outlook.com
 ([fe80::8c9b:58d2:2080:eb98]) by GV1PR08MB10521.eurprd08.prod.outlook.com
 ([fe80::8c9b:58d2:2080:eb98%4]) with mapi id 15.20.9846.016; Thu, 23 Apr 2026
 10:56:47 +0000
Date: Thu, 23 Apr 2026 11:56:44 +0100
From: Yeoreum Yun <yeoreum.yun@arm.com>
To: Will Deacon <will@kernel.org>
Cc: Sudeep Holla <sudeep.holla@kernel.org>, Marc Zyngier <maz@kernel.org>,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-integrity@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
	paul@paul-moore.com, jmorris@namei.org, zohar@linux.ibm.com,
	roberto.sassu@huawei.com, dmitry.kasatkin@gmail.com,
	eric.snowberg@oracle.com, jarkko@kernel.org, oupton@kernel.org,
	joey.gouly@arm.com, suzuki.poulose@arm.com, yuzenghui@huawei.com,
	catalin.marinas@arm.com, sebastianene@google.com
Subject: Re: [RFC PATCH 4/4] firmware: arm_ffa: check pkvm initailised when
 initailise ffa driver
Message-ID: <aen67JwO0rBxo28A@e129823.arm.com>
References: <20260417175759.3191279-1-yeoreum.yun@arm.com>
 <20260417175759.3191279-5-yeoreum.yun@arm.com>
 <87se8sbozv.wl-maz@kernel.org>
 <aeNeNjfO7i128TIP@e129823.arm.com>
 <87pl3vb5bm.wl-maz@kernel.org>
 <aecf57rWloQwDh6v@e129823.arm.com>
 <20260421-married-liberal-ammonite-dffda8@sudeepholla>
 <aec/YSxYO1bOhXhn@e129823.arm.com>
 <aejN52lwaqfoMuGJ@e129823.arm.com>
 <aene4KFD5kbSbFRm@willie-the-truck>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aene4KFD5kbSbFRm@willie-the-truck>
X-ClientProxiedBy: LO3P265CA0026.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:387::9) To GV1PR08MB10521.eurprd08.prod.outlook.com
 (2603:10a6:150:163::20)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	GV1PR08MB10521:EE_|GV2PR08MB8270:EE_|DB5PEPF00014B9B:EE_|DBBPR08MB10771:EE_
X-MS-Office365-Filtering-Correlation-Id: 9bf7e3eb-8f7a-421d-f284-08dea1272bd1
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|366016|1800799024|376014|7416014|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info-Original:
 Kb0ytJZrrIFfrnS2a98qRqdjShl+Y5O7mPXwvI34WBFO6ONbQccB6lz74/MB9eMlaDmZgL3TR+pWgeDIDjjYG62M2K+nv4DEGoB+uI1QUnSVA6liVHxBSilzPtxDmr7JjOnn5VQT4hzdYVjIZSKQFEJyqrqs0SnYJT4Ar7JYw7xBDmFUpO/xJl4d8q2QMrif16HPupDWu9nwLF3mNPbdmLj04tjqt3MddyrVR7iRsjeoqg64nNoX6It9rha/zCZUWPszGYPZQwXVfa71cw5hgWAVuK6hIKMBTjDTjdHtu1sACwPbD/uPR5uPsXqtuE+/JUxvM1He/Mfc/xV7C3+X2kZKbwJn3wt64gXFieOwzCjcn+KFTW7IqCKmKlUQsfemt74+7ax2Yi+ZrqHR4p9MMm+t1Ck8fh1aZ97iLphnwoTVNApITvfBnvXhhv/Mw5dtUXkOopJYBwcrJ3nSy7BU9koJGKKEec/0swKAmT84UyAP6/lfx0+NKpo5tyIBy6+U2DnXJpuIYFF7L6V7CKXpCsA/QRCpd698yf1auJuxByyaeMaEShAXTf+Sru9vPivfiKlVdGz85fMGJQIOW4R5R5Hwl1r8uloPLCBD3fgZJMHOjG007Z5bk1MNnt2PC9ZXPIzWGiArbSWnNOkFgGjrV8OMwY5tvASr/mXJXVHxdKy0w0gl6FMPyHvNtKZDkYIP
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR08MB10521.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-Exchange-RoutingPolicyChecked:
 OWLEgDINKvKM3lTjYq+eHZb39eXMXdTL4C0lZY4/ZO6Bybdl8f4F5Py+uvwR1HAJgQI4DzyofNiWclSOoBPbz70yEwPmIHCjnrD8ifaOBY+Shje8IGk8+31bjWG2RlBGng7m6jawtMGh0rWs7Tq02DzviJnI0ouWsRqcfyXj90SPrZUq55pyY4cKflsAcxeSPNr5uFDZLi4Qy4s7UAflr2vc2+iYyOktWUxUVFhygHHHUA1Vc+XA+UDHoluHJgCtZIV1dRbOIwlpr8341DjB05WW4e0C8J6QgfZDVA2MavOFqSaKlovcd2cQ+9Gsoo7XCVC4U2JVbSPUwEGwl60XCg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR08MB8270
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DB5PEPF00014B9B.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	79563b92-c3e6-4beb-b1f7-08dea12703c8
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|36860700016|14060799003|376014|35042699022|82310400026|13003099007|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	R+JrgPyfhqBEyzj9KyW6aU1S/STIEG/XxtdDJTW5zv1An2zXrFzOSmemeVK4Syu82eL5acqjqLgHqtTCFjhir6KIW3pcZJaL/eGw4Y390+9Z89pMZoLXrtApWoIN9dkjGow3GLQGLlQgGUkJHM+tdZXVNuM/fhePY1eVkxVFRAWkF3lAdGFbRvLnTcuBZ8Xq5h0/G0SOB715sb8CH/8pkFh+7H+WdHnd7h7a72DqYLErbLkP/mSx0eybsv0/jybs6aJLjTOQVphmXqzSI9Gav2EYtHObHSc3zJTohhWK3oppR/dRNNUBo6i141p/gszmlGE+ZcR+KkD44njEoxUdYBiYaK3LNaBa98leCBUvQo2vYleEWmL69l4T3DOORJRlPuCXApIT1WEw6mUemqkdOVjKhrYPfrbIefVF3R3yB1nNzHlmBkJdOyUw2KvnXHPXvmW1TTeBM2Z4cp6ylybcb6T8nJQd0S4PMo/R+UkPqUz67NLY7iSp93YhjP4RCSSHt/QTUAecKLLDJxcep6OO9XMGnec/J+e7spclIGrobnCNCBPuJqeJJiiDLSU0VYKm1fn/+/HgchHBnlxFcCroIYW5zfmdFsrTlpYgwYp1VzpYwjiSmjaA/XCFflTPSGHzrIt7Vb6P5/R5rXQzvlI3n6MNrXtdEsaXJQgXoezS6GiORsRInXdBANjuh+BI60A50fOmK7UR96dJ7CXBvYFIYGDMPqS2F6acRcODKS7GeSs=
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(36860700016)(14060799003)(376014)(35042699022)(82310400026)(13003099007)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	GBcsgrT+iHrqPfhZAm/G65l/7KJQcgFLxXkDNmHgd3b/zuGofkreQUusRmKAXCDLE0mS2Ivl7bp99gq9nZ4BuTkl+38F02/Up4zOet17KItB/EkkgWvIDmkFIngsPV26LqAg2ulKkTld+J5tKdtsjmf09ni6lKWnQ/3QtC0OUDfh7593sU8vkXfOEnIbqabwSc0NU5tE3d0rLkioI9gkO1JIwRhmHgjTA/XkJQeXpa2b1bg8JF5DUOhrhCADrlp2rhBekPGacEHODORRBfvFrUMVDDGMRe+Aj2j6h7zu+CzaZ3mNjYv6qwQumTmo777i7efZrYPHCkCo4sH8Y5ycITUtA43cYgMFGI5lbDZNlOiR0Wtsbimw0oVQ0NZAoPKD9v2aJDEs/PG2HCpTYyFnRZ6MHxKaem53/oQDv+dDFe8fg9FM1L1eo5noZsrOI0LL
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2026 10:57:54.3176
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9bf7e3eb-8f7a-421d-f284-08dea1272bd1
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB5PEPF00014B9B.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR08MB10771
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=3];
	DMARC_POLICY_ALLOW(-0.50)[arm.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[arm.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[21];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9294-lists,linux-integrity=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,lists.infradead.org,lists.linux.dev,paul-moore.com,namei.org,linux.ibm.com,huawei.com,gmail.com,oracle.com,arm.com,google.com];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,e129823.arm.com:mid,arm.com:dkim];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yeoreum.yun@arm.com,linux-integrity@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[arm.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-integrity];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: D2708451086
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Will,

> On Wed, Apr 22, 2026 at 02:32:23PM +0100, Yeoreum Yun wrote:
> > Hi All,
> >
> > > > On Tue, Apr 21, 2026 at 07:57:43AM +0100, Yeoreum Yun wrote:
> > > >
> > > > [...]
> > > >
> > > > >
> > > > > Also, the FF-A initialization is not driven by a device probe, but rather
> > > > > happens as part of the bus registration itself,
> > > > > so it does not fit well with a device_link or probe deferral based approach.
> > > > >
> > > > > Instead, perhaps we could go with the idea I mentioned previously:
> > > > > either introduce a notifier, or create a pseudo ffa_device
> > > > > once pKVM initialization has completed, and
> > > > > then let the ffa driver perform the additional initialization from there.
> > > > >
> > > > > Am I missing something?
> > > > >
> > > >
> > > > In order to handle/cleanup some ugliness in interrupt management in the
> > > > FF-A driver, we may introduce DT node eventually. But it will take sometime.
> > >
> > > Unfortunately, I think this DT node wouldn't be helpful to solve
> > > this situation for dependency with the kvm misc device...
> > >
> > > IMHO, current situation, the notifier seems to good option. unless
> > > we make the initcall to recongise this dependency.
> > >
> >
> > I think the best approach for now is to introduce a notifier to handle this situation.
> > If there are no further suggestions, I’ll send a v2 based on:
> >   - https://lore.kernel.org/all/aeS4rAeVQ0yJIPYw@e129823.arm.com/
>
> I can't say that I'm a huge fan of that :/
>
> The notifier will literally fire once, for a single listener. That's
> called a function call.


I revisited Marc’s suggestion about using device links
(https://lore.kernel.org/all/87pl3vb5bm.wl-maz@kernel.org/)

but unless I’m misunderstanding something, I don’t think it would be a viable solution:
 - https://lore.kernel.org/all/aen0j3qM2k06OdXC@e129823.arm.com/#t

Also, calling functions defined by FF-A from KVM would introduce
an unnecessary module dependency between the KVM and FF-A drivers.

I’ve been trying to find an alternative approach,
but I’m not confident about what would be appropriate.

If you don’t mind, could you share your thoughts on this?

Thanks!

--
Sincerely,
Yeoreum Yun

