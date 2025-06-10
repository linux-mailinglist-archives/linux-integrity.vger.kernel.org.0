Return-Path: <linux-integrity+bounces-6387-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A071AD2D8B
	for <lists+linux-integrity@lfdr.de>; Tue, 10 Jun 2025 07:57:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C0173AF4F0
	for <lists+linux-integrity@lfdr.de>; Tue, 10 Jun 2025 05:57:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5FE125F7A2;
	Tue, 10 Jun 2025 05:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="idiA8F+x";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="idiA8F+x"
X-Original-To: linux-integrity@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013067.outbound.protection.outlook.com [40.107.162.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADD9525F797;
	Tue, 10 Jun 2025 05:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.67
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749535047; cv=fail; b=MV+ApCLDEY+ZcbqNSDvfvDSziTYMdAVQ+CZiLliM2debh3iaGnb45xr/BUtSx6Pkvv2BFevsJdLqcB6e1aRLGkhI1ySqSK6STpdALfsgBCVOT+sUZB4rb26X7BL9GEOgIC6+ycdI3keOqIFv1aw88pr4SkSbLEhFQUa71VNw8Js=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749535047; c=relaxed/simple;
	bh=MffW84hdz5E9iDibzz7gl/rACfj2+Qzd/EUYjKnDLZ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Uk5rXqK8FedWWCIJ7MufPRiD156TCWpJLCvHifiLMYQmp9OW0vOFgr42NjO0XLCjWT6NINq0RmykMjgVrQ4mqYHMjfHZ8gGfVPliMojoUKLLknfN6kkT2r0P8XlhhKWvd7oBqJ4fPJHfHgxFMqxtFCB2cdbmamAS9jbFQi4a5XY=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=idiA8F+x; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=idiA8F+x; arc=fail smtp.client-ip=40.107.162.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=Sl0cBLVm1YVrUqFIWOIiBVegZ4aqovnnMeW/i85Yr0J3cIS6Lwgx03Vrej9USSE8DSLlwUrNnC3AfBkfbAk/aMVmnPxfgtCNzyDXq+yxhaVBHwWiBzQqyGa3vsBUqsoticzkuHD0xSazRTQF4OGpDXQhsv6kB6SwlKhDo0WnQBxYmYbfnk2zSjFtleMuW2dNoVE1ih8bMTIgr6DlbuKIPsBVunIPg7+WEj012w7dVcMmazdNX+ihxtnlv/xE2yXlTlUh2CyxXKLYKViouL50pG5f1swHBZ82izQcKJVKcObVCgG5JldAhYikYeK2wMSFg5Jb3gaRukjJViH/dvr32w==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MffW84hdz5E9iDibzz7gl/rACfj2+Qzd/EUYjKnDLZ0=;
 b=hnD+IqXFFV6xOX70o2rItrc5yYAzzjo29f2HnZbB/ryRvgGmCKsESNQIgti29/QfAEFxwjszF9gbD5Dd/TYxz6recXyGZNhn3z8oFObc75F2TgUb1cQ+2DsvbZtdvpDqZpH5vhRVT4t62ELuWfSAbPvK7usi7qKFZ2CPGH8za1EP8SszAOcgB+7DGV6x8U3VuGBWwrUmzmgE4S3WmS7aLJvxEa/gyFw0Pm9c6dxMXpvK1lEHSoTcHKcQrlynLsjLtVukOsvGyM1d0VPf99FzCnGfvFwtaHCB29dUYQZrAgZlaM3ge5Utog8evrw65bDGuMDOSGHEQTaUNuC00vW4Ag==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=kernel.org smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MffW84hdz5E9iDibzz7gl/rACfj2+Qzd/EUYjKnDLZ0=;
 b=idiA8F+xB2hPO6vcLTBqDBkRACUKsTx26vNlCKst4C9xRT0j2+RdChtE2uzq8SE1mayX+G19V1klIkM8gGZayPrDr4hSb2tg6vOEucLoG9ZMzgZz8bOmEA+nx6EetkSkFqfMJ4IilZWv3GfL6fPRSGPgtX2pkV50Y66W9HTcdAA=
Received: from AM0PR02CA0105.eurprd02.prod.outlook.com (2603:10a6:208:154::46)
 by PA4PR08MB7460.eurprd08.prod.outlook.com (2603:10a6:102:2a7::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.25; Tue, 10 Jun
 2025 05:57:22 +0000
Received: from AMS0EPF0000019E.eurprd05.prod.outlook.com
 (2603:10a6:208:154:cafe::b5) by AM0PR02CA0105.outlook.office365.com
 (2603:10a6:208:154::46) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8792.35 via Frontend Transport; Tue,
 10 Jun 2025 05:57:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 AMS0EPF0000019E.mail.protection.outlook.com (10.167.16.250) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.15
 via Frontend Transport; Tue, 10 Jun 2025 05:57:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rI57qrnGj8TeEiaIDRaGTgHUKEn0hzwigRN4EIQ7JiGWnvqyn98N+tHACcwcuClJUYZkwdMdBeekNq0ElK2xDepYft85QBx7DVg5SsdcukLkboC6pWsk2uUPoUJ8UYsV391KSZrJVGZvaPbypkzCLE2ZKwhXUtR19ZYQxzAvc/bxy00w1hNDNi0LK+bJ+LotwmkZ4RlCNjYvJPfo7RiqMhQ8HoTLWZ7SBZ/DhO5+hKu7J2fBN2ZL4lgAA4JmZOF9lZAZEebV5oci29pT7v7DWloi0lRskSa8FRRuSNxVowzoe60dTPXGYZfiyBDzz1fV8jYZlE1KjN1v26CLUuDDaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MffW84hdz5E9iDibzz7gl/rACfj2+Qzd/EUYjKnDLZ0=;
 b=gWbUQRMy7UQ3G98WvPmVmICe5BMHoKXxwmkJdxHH2pt8EOdwVeXCpEL8zTo0pMAX+C/dSFAJ9rMcbDcdfu3d7DCSllKZjjiCr1BSPCLE/Rf0qC6AMRma9pTmHfV4VaiaBeUJfMXKsuyU9Pk3xLLH3WcuRHRVknFiPHmM+EZmguinHk5GfGExck77jEWZEVAzZlFsuy6uy/UO2RbyEl3GAECNkfJ2ptUvxTz+ks9xBXmCiDXXr+FIL/f1Mj4Qv0/dAWsNlR1NDAFAsZRhLOWACIfI4BMfS6ISQMM60Yt+qj0fDqlf3o93zdBZ1ZjQOp+wsFXCndTbEmb9aR6p4SdMyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MffW84hdz5E9iDibzz7gl/rACfj2+Qzd/EUYjKnDLZ0=;
 b=idiA8F+xB2hPO6vcLTBqDBkRACUKsTx26vNlCKst4C9xRT0j2+RdChtE2uzq8SE1mayX+G19V1klIkM8gGZayPrDr4hSb2tg6vOEucLoG9ZMzgZz8bOmEA+nx6EetkSkFqfMJ4IilZWv3GfL6fPRSGPgtX2pkV50Y66W9HTcdAA=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from PA6PR08MB10526.eurprd08.prod.outlook.com
 (2603:10a6:102:3d5::16) by PAWPR08MB9996.eurprd08.prod.outlook.com
 (2603:10a6:102:35a::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.26; Tue, 10 Jun
 2025 05:56:47 +0000
Received: from PA6PR08MB10526.eurprd08.prod.outlook.com
 ([fe80::b3fc:bdd1:c52c:6d95]) by PA6PR08MB10526.eurprd08.prod.outlook.com
 ([fe80::b3fc:bdd1:c52c:6d95%7]) with mapi id 15.20.8813.024; Tue, 10 Jun 2025
 05:56:47 +0000
Date: Tue, 10 Jun 2025 06:56:44 +0100
From: Yeoreum Yun <yeoreum.yun@arm.com>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: sudeep.holla@arm.com, peterhuewe@gmx.de, jgg@ziepe.ca,
	stuart.yoder@arm.com, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org
Subject: Re: [PATCH 2/2] tpm: tpm_crb_ffa: maunally register tpm_crb_ffa
 driver when it's built-in
Message-ID: <aEfJHBdLjVIrmWpq@e129823.arm.com>
References: <20250606105754.1202649-1-yeoreum.yun@arm.com>
 <20250606105754.1202649-3-yeoreum.yun@arm.com>
 <aEMdGXXBSym7cXmK@kernel.org>
 <aEMvm2MW9bBXf2gM@e129823.arm.com>
 <aEdLOb3V3EgBZJof@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aEdLOb3V3EgBZJof@kernel.org>
X-ClientProxiedBy: LO4P123CA0479.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a8::16) To PA6PR08MB10526.eurprd08.prod.outlook.com
 (2603:10a6:102:3d5::16)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	PA6PR08MB10526:EE_|PAWPR08MB9996:EE_|AMS0EPF0000019E:EE_|PA4PR08MB7460:EE_
X-MS-Office365-Filtering-Correlation-Id: 510ee06c-170d-41fb-5786-08dda7e3aa7c
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?REhySHJRdVhGbzJpR3Jlb1Z3N3V1M2UvWnNGWCtzMHoyUlhmc3RQR3RiaTE0?=
 =?utf-8?B?YnN3a0Z0cHVqQWpYTnAzREJiem9HYk1wOTJ5elFPb090Si9QNlVOZ25Xem10?=
 =?utf-8?B?NE5SbEhpeTduTVMzV29URnBWdUpTYmJFYk5ITUtZejJBL0MwL29kSjFBcHdD?=
 =?utf-8?B?eUlQT2Y5Vmh3Sm1LcVhkU053YnVraG4xdkZXcGdaL0wwRzIzVHBacU14SnNz?=
 =?utf-8?B?QmY0MjlaYTQxbnZaMStKbHJPMGhqSiswdUQ0VVF4Y1RCUGtvMzB1TzFrL011?=
 =?utf-8?B?VUNkMStIcEh6aTlnWHBjc21EcUtsVU54L2lidENnUlZMTW5GMFJEN3ljTm1S?=
 =?utf-8?B?VjF0UndleEV1b0Nxb2dKSkNuaExOSThTTG15UnhnQTNCUXduWjE0NncvR0hr?=
 =?utf-8?B?ejdkd0grSlo3clRkTXZMb1dCZ3N2K1JpODdyQW56aGIvNm9ZY2hZamdlNVFP?=
 =?utf-8?B?VWRCMzBwbm9jV0laVlhnMlZBM21yU0xXdkFmNjNCL0EwNmcrdnVtZlQxcHZk?=
 =?utf-8?B?YkJuUnR0UW9DZy92WHpyKzZTSHl4b1BLV0xGMlQ3bFZDd0kvazZuRm51UWNn?=
 =?utf-8?B?MnNsVlpEaDhGUUdVTmtTZzRERG5KR1pwcEUwNldDNVQ4Q2V1b1Q2V1B3NXh4?=
 =?utf-8?B?ZWQzTjljaS8xRlRoWmVLUDM1bVc3aWRjd250NU1GWnM5TEV3ZDNEY0hYOU5C?=
 =?utf-8?B?VEdyUUJ2eVU5cmhBS096aFQrTXErZVJ2bFZYNVdYd2QvYlN6YkRVNDA3UUQ0?=
 =?utf-8?B?NXhmTUY1K1Y4bit5UzM4M2x4bHR0L20wbW5OMjNJUmVaV1Ntam1GcDljOW1M?=
 =?utf-8?B?UVR4Tkx2a2pIOTF3ZGdoR1B0VWU5YzlNK0RxVHpySEE4eWtxMmN2c01DYjVQ?=
 =?utf-8?B?QWQ0TVJ1V2pyMGt0cFFGWkY3MzU3ZytUNkdEMGFnRUpPYjdVUGxIZGFmY3Ja?=
 =?utf-8?B?a21XQjVXVXZrRWoxN0tNUThBSmxBUlAxaHNTTzN4ejlXK0JEK3VHMy9YUnlk?=
 =?utf-8?B?djJPN21maExRdjVBL3FtOU01V0gza28vUm41c3czVGpZcDVlaEUxTUM1Z1F4?=
 =?utf-8?B?NGxLaXNCZUdUdTFSMVhMUlVXdkZwdUdLWW4wcmJvWXNBRmJ5dE5tK3BFNEky?=
 =?utf-8?B?Qi9mODA5YVlPOUZXQXEzV05mRFIyQytEbTFGRlMrREJqVWVFOVo4SHBrZi9E?=
 =?utf-8?B?WEdhTDRkb3FiR25KRWk4cklSTXFtYmh0WlRhcU1MV1IzYVE0L1U0bzlVcjZ1?=
 =?utf-8?B?UzJZdUhXcExYWDdDYlczd1kxNzFjTUZtOFJnK1lEMnpBeHRHYjM1Q1M1Y3Q3?=
 =?utf-8?B?alVXb1hHWk9tUGtmTndCVWZUV0tGNHU4YXAzQmdpMmZjTTlaTUpUeHZMN05T?=
 =?utf-8?B?SHJJdW95L1NVSkRNa2NQRXFFOGl6cGpuWVM1MjR5QUFIcFJhWnpwaVlEaitX?=
 =?utf-8?B?WTQyS0IvRG5yYmJOWU9sdCsySlFwZzBlcTBpeklQNm5tRnBhQThBbnJDUFNX?=
 =?utf-8?B?bUJ2N1JLOVJLNzlKUkZja01YZEc0cGZwRFB1Vm5ueWVmZkVWREc4bFFhMjY4?=
 =?utf-8?B?d0lTeHlQMEJwcS9qdENQcUR0cXMreUIrckM5SzIxRVQwRTR0VHJRQ2Z2aTZk?=
 =?utf-8?B?TWRrYTZLWGREWWxtaDJONVJQdFhFbXlmUU45ZlhGMHVYMmlkR2pndmcvSmMz?=
 =?utf-8?B?QkFiSXZTN0FKTEc3NWZ4Q2pGSFZqODRRNk0wYXVnVmdPc0hIendKL21rOVZQ?=
 =?utf-8?B?OWN4T2czSUtsOGNKSHRST29QMXYyaXZ0YVE0bHpQU2NaNWhOMTRuT3RVZy95?=
 =?utf-8?B?aUdhMjZ2ZkthaDlhZEl2S2VXSEswdHR6QVdLdmdTNjJmaVUvbjk2NVRmbFhz?=
 =?utf-8?B?am00MTVlaVJpc2ZkTmNxalkyTnNCNUtBUzFNQmJoRUR4OEE9PQ==?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA6PR08MB10526.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR08MB9996
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AMS0EPF0000019E.eurprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	d4c312c9-5559-4ea3-bdf3-08dda7e395c8
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|14060799003|36860700013|376014|82310400026|35042699022;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dEx6aldvQ1JyL1QyZGlMZmNTNlh0UjQxTnJXUzZ6SUx0OE9FT2h3Z1MwUkps?=
 =?utf-8?B?MnpMclhBOGlGOFRyckJQTmdkU3VyTHZaRkVtTFozYVVJN2pCZ1Fab0VsQkZX?=
 =?utf-8?B?ZFdqblFaaVNkMHZ1RElkSEFWc2JRUXEwZ1N3Q282cWxvdWplWlJaZFlRMkxT?=
 =?utf-8?B?dFJxdG1EaUJGczlVZ21LL0REVGhhNnRXaHdXZ1NBN2dPa2xXTUZzTVk1NDgx?=
 =?utf-8?B?RXN4QjdYUmExQXhtelFWcERaQlBjYm5yTjQwU1I2MVhRVmtBcTBjMEZKYzZV?=
 =?utf-8?B?NFhLS2V0REx1QkhrMXkvRmxMRWE3dFYyTlhBcDhLaTFXWVNCOUpVbllqblJK?=
 =?utf-8?B?MHNYNWZMaVhiYXZKNCtJZTY1WG9JdjVENDhLak5wWDNuUlhsdkhHTC9mOUd0?=
 =?utf-8?B?N0FkUUhyT1llaFBKZUthQzZYMUZYMStxTHMyRUpvakNFdWtHejhnaHBvd1Vj?=
 =?utf-8?B?ZUR4clVnMFNSSWxWdHJLckpzL3dYc2x5TkhBZWI5RGtERXNaZEZQUDJYeDNn?=
 =?utf-8?B?MHZZRmFRajZhK0ZYSG5HYUJYQWY2d1AyZ0VmY2QwMEErNHlCek15Y2pKVzl0?=
 =?utf-8?B?dkJVNzJkWklUaVZSMnp1Z0pjenZGSitOQ2JMK3h3SjVpMzNHYk5Xcnl0UnJU?=
 =?utf-8?B?Tm02NzNjMENkNG8vM3R5eTd2Vmo5WkQ0SXJtVEQzbU9xVEtIeGdTR2c3UW1n?=
 =?utf-8?B?ZEhIU2c1Y0Q1K1JtaVlUR0RQcVM2ZG5hdnBVcHNJQUkwN2FFaEx5bWJMTGJu?=
 =?utf-8?B?dUpNRVRGbnByakZERUpSWm1jYVhhYkYxVDVtOHoxZ0NBNklHSVFMQlA5b2Ir?=
 =?utf-8?B?aTdVVk9tQXhoZGJEVUp1L2JtSm1TV2JBNVJ4R0VPcTVReHF2ZUNaZUd0Ykcw?=
 =?utf-8?B?amtleVhoQ3c4WW9UK0NyUTZBeXpDSEE3U2tlWkJ6b0d5ZE1HRkhnNXdrQmk3?=
 =?utf-8?B?NWpKenROVWxGSlAyR0tBZE1iRWduT1Jaek8rSUtEQkw0bjNhS3NKT09TYjhj?=
 =?utf-8?B?UU0wY1ZKU3Nva0t6aHh1VHBTZ2hpNFVLWkNsWVFPZUk1aC9sQXg0NmM5Sk9L?=
 =?utf-8?B?Q0NCZW5oZXJaN0VaR2dJWEcvUE9uWC9FeWY4K0JLSWlFdFF3Ui9MY0Q5NmVk?=
 =?utf-8?B?OFZHN1Fqc0ZvVWNvWE1NaDJJWlMweDdHdlNXdjZyZjFST1ZCV2F1MXB2bFlD?=
 =?utf-8?B?Q01vQzkzdExsUlJ6OXRsYWdZNW83MjYvWmNlelB6SnZCMktEbW5oajlUdytz?=
 =?utf-8?B?bkFrRkthanNjS3FXTDFuZUdHazNmekw0Y2tQZ05QSXhWK2NBSmEzdkU5WU4x?=
 =?utf-8?B?R3JrK3pEcHorWkRYYlpYaEdFOHJ0REkwaHVqak5Scy90TFltQURDRWFKazdB?=
 =?utf-8?B?a01qWjU3VjY5L3ZpNlBkb1RVZGdWYWFBZldTWCtMVTQ2bWZtNFEvbnFZOFEr?=
 =?utf-8?B?VVhBWTFzdnNzejFBY1QrUWFLTExrWEpYMjZwMUJ1bVVKeURlZGRTV0poK3Ra?=
 =?utf-8?B?eFM0YmVRaXdESm1HL1kxYjd0ckFVQkNpQzg1VVRhOE45TTlPNWRxU1h0YmpJ?=
 =?utf-8?B?QUZGL014aXJJbnhWKzhodVlNZGgrM2wzbzBvTkhGZnZyZnhrVmwwRXpEUlA3?=
 =?utf-8?B?ejlBb0tCcW14UWo1MlROS3BKNk0yWUNVaE9pQ2Z2MjBnbEhxMkVTSEhDWEht?=
 =?utf-8?B?b2Y2RVpEV2t5RjBOV3NOeUhzaE8vYlB4UnllWHRQZVNvUndLa0lIMXpmQ1Yz?=
 =?utf-8?B?VnAveGN4Nm1UaFdzc3RhSUNOcitqMFNQd2s2d3pWc244aXpHa0VDUmkyNUdO?=
 =?utf-8?B?TG9NaWUzY2t2TjNWNzduM3g2YXFtTDFqaXdaZHlXWi9RSCtWNTNGOWdVVklL?=
 =?utf-8?B?SVZFNjVhakdNUHBWZm1ZcG1rd3BZY0JYRGcxWFQzaXZ0UkIzYW1mWEtTZ1hU?=
 =?utf-8?B?d3RoSkJuT0lKalcrcFRGcnZXbmhmVkV2MmhEclV2WG9vcGhuWG9tOEFYeEpD?=
 =?utf-8?B?cVVHc2VmajZDWEZFNmcxakVCRzRZR3FpZTA0YklUcSsyWE1acFQ5eUFUUXBa?=
 =?utf-8?Q?9nozvg?=
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(14060799003)(36860700013)(376014)(82310400026)(35042699022);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2025 05:57:21.5252
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 510ee06c-170d-41fb-5786-08dda7e3aa7c
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS0EPF0000019E.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR08MB7460

Hi Jarkko,

[...]
> Your description in the cover letter and commit messages in unclear
> and convoluted. Please describe exact causalities instead of something
> not defined could cause "failure" (which is also abstract concept).
>
> I'll check the next round.

Hmm, I'll do my best to rewrite them
But I’m not sure if that would work well for you…

Thanks.

--
Sincerely,
Yeoreum Yun

