Return-Path: <linux-integrity+bounces-5000-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B591FA46ECA
	for <lists+linux-integrity@lfdr.de>; Wed, 26 Feb 2025 23:53:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9B993A9704
	for <lists+linux-integrity@lfdr.de>; Wed, 26 Feb 2025 22:53:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BDFB25E828;
	Wed, 26 Feb 2025 22:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=polito.it header.i=@polito.it header.b="M9Y5IiD7"
X-Original-To: linux-integrity@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11023086.outbound.protection.outlook.com [40.107.159.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C01DD25E800
	for <linux-integrity@vger.kernel.org>; Wed, 26 Feb 2025 22:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740610427; cv=fail; b=DfOY0b69UjC7hwFHER+BqhiEhf8Rux8VT2FzM0te8wYn3x8n0Hmq2fCmZ92fucjmtENLKaIpwK8DZsbEPPHzCC+xh1CuMpg6tVfWWBBeyvHSPFIN3HoeHPgnPZRmtZuno/XUzdlTCcKT9NARxxPJD6+jE1qbfD+H10BwZmfbpSo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740610427; c=relaxed/simple;
	bh=PptAfPlXgp61GyWDNzqWoeVhUS0/Z0C8rT1SnzCixZ0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=fImtjQPGfOadoU86z+Pu8OP4loJZ4hZb3jQxU7kKrLvlNWJBaZH9Osa2FMjMhz7gc1VfA+bCBQp/FyaxcSHv6HFbho15ixYOB60n7paiPPxdCYzvobDwIZCgmdItTH8H3oCdW2y9+z0PFFLGhkJ9sOSP7J+1sqg6wkYNs2OsNd0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=polito.it; spf=pass smtp.mailfrom=polito.it; dkim=pass (1024-bit key) header.d=polito.it header.i=@polito.it header.b=M9Y5IiD7; arc=fail smtp.client-ip=40.107.159.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=polito.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=polito.it
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CZzQpJsOcgwOADZTFn6YUfcr0FBag1TfDzc56ETmoMN3Pu0NtMEWPZBqgByWN5ihWbjUg0D/Szt3YiLJM1F+u72xuat8CDPVID2byWBqG1EVSyqsqW/xIOz4HpsrR3kRIbo0N7KxJ61mJDJ+Z9YwY9ru+jBWGh4HefmOR9RkM9a8D/DDbjRgbYZ3GcFRUJlC5ZBQHUASIQnS8yh0+VsqDChdwelpNeJBOr4gsDltygZDOz8Ux7GDAdjaGlfmV9lGiJBirgCQ7xiQum43yDEjt8xnwPS3WjL7AAT+AMt3OHUvkDiAEJGJ3Q+C+6OqOoM4P/E0ZY8B8Jl8ozSKWN4nng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PptAfPlXgp61GyWDNzqWoeVhUS0/Z0C8rT1SnzCixZ0=;
 b=h79T3K7mbZtAIY5iD3tdfsbewbCh1g5g3sapeF5IbTgNjbJr5KRrD3mqb56cbsvIeDE+/dmRJxE2dpuqmOWfbMc0xIslEyR6P7i1UDuWxp+KJfJwE6Ai51qXYtZL5VrZwjeBi5Bsm9e4aT/v38aUdd1OnejHeNdktQfM5moJW8yhaU+Rqh0cd/x5Ph0dltWhPimjDgE8NHspRwAdbbybpQzpW7y1tkJj9L+HsdBapSDnV3maYJrgVFy63Um50gs6UhrVzdFcsQuWhqWGE2GdrGqEKJkUnZdApctzAx9ujL+r6hnCyZqlrD0V73teeTLUcrmff13kkngRWu3OlPt5Cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=polito.it; dmarc=pass action=none header.from=polito.it;
 dkim=pass header.d=polito.it; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=polito.it;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PptAfPlXgp61GyWDNzqWoeVhUS0/Z0C8rT1SnzCixZ0=;
 b=M9Y5IiD7i5FG+U9CoKfqNa01N+VYsES/5sleMJPwIemispqXeLqKlBwwaUr6Ce/FsTYSIjMvQFL6NoZWe5kkMckYXlNl0nSYDvbJWbIlcoluVMQopM7HGm9JwO0H0FX2DbEAEKdgiwiAnvZhHq7UGh1pf+2ZN/TSfVzIG2dV930=
Received: from AS2PR05MB9840.eurprd05.prod.outlook.com (2603:10a6:20b:5f5::20)
 by DBAPR05MB7494.eurprd05.prod.outlook.com (2603:10a6:10:1af::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.18; Wed, 26 Feb
 2025 22:53:38 +0000
Received: from AS2PR05MB9840.eurprd05.prod.outlook.com
 ([fe80::237b:12ae:525c:3bbd]) by AS2PR05MB9840.eurprd05.prod.outlook.com
 ([fe80::237b:12ae:525c:3bbd%4]) with mapi id 15.20.8489.014; Wed, 26 Feb 2025
 22:53:38 +0000
From: "Enrico  Bravi" <enrico.bravi@polito.it>
To: "roberto.sassu@huawei.com" <roberto.sassu@huawei.com>,
	"linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
	"zohar@linux.ibm.com" <zohar@linux.ibm.com>, "dmitry.kasatkin@gmail.com"
	<dmitry.kasatkin@gmail.com>
CC: "eric.snowberg@oracle.com" <eric.snowberg@oracle.com>
Subject: Re: [RFC][PATCH] ima: add measurement for first unverified write on
 ima policy file
Thread-Topic: [RFC][PATCH] ima: add measurement for first unverified write on
 ima policy file
Thread-Index: AQHbh4kqbfMU9EdEvEuw3vrfgofl17NY02GAgAFgF4A=
Date: Wed, 26 Feb 2025 22:53:38 +0000
Message-ID: <013864bca0b53d65b9546125090c8d7776ee565a.camel@polito.it>
References: <20250225131255.154826-1-enrico.bravi@polito.it>
	 <ecc4630b5e3161736aa1e32f037facb9123025fc.camel@linux.ibm.com>
In-Reply-To: <ecc4630b5e3161736aa1e32f037facb9123025fc.camel@linux.ibm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=polito.it;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS2PR05MB9840:EE_|DBAPR05MB7494:EE_
x-ms-office365-filtering-correlation-id: 28b660cd-b224-452e-64ad-08dd56b868b8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?OTM0dnN1YS92MlJGa0hmUm5JVGpscUI3U3NXbXZWejNsSFNETzFYK2dycG5E?=
 =?utf-8?B?dE9vVExUazJQd2VDMzBiSW5KTmZGWW5Db2Y0N2JyNVZIeDFOYjgyYU9BWFVa?=
 =?utf-8?B?TktIN3dEQUVsYm5iRmlHbUlCWTZVbmlIcnNrUzNUbE9kR0ZxbE1keHhqL0hn?=
 =?utf-8?B?bllFU0JMcXBUODBING9jdW9Ga1NFWDZsSlJIeE5wVmVZQnNuTGloLzVvUW1u?=
 =?utf-8?B?Qk15azZZRVZMcHFJem1tREhaR25OZkFUdU0wYlNMUHdoOFFCZGw4ZXZpMVYz?=
 =?utf-8?B?Q0ZnNHJ5K2c2U3JqdTJXUmVKK1R3SzVVaHhMaXlDRUZFNlB5YU5qN29Oa24v?=
 =?utf-8?B?dnluamZLMk9Td3BpWmJjSkVWenFJL1A2SUR5SENsNjZmbTJ3ZHdpTXR2bm8r?=
 =?utf-8?B?VTVMQjl0WlFqRSs1L2crMmNsWVYwd2xldEZ5aC9RZDM2NGRaVnY1UW0vVnRU?=
 =?utf-8?B?UDdscGtuRmNzbHZZd0R3ZEluZEpKT0dvTU03YjkweHY3ZDRYTVUySEV3Yzgx?=
 =?utf-8?B?ZFFScGZlWHlFZ2RabWxCSENlcG15dURKWmdha1ZlRlpZcHFnY1ZwVTZqdnl5?=
 =?utf-8?B?Q0NSdmFBbDZYZENTYzdZQ1IyZC96UzhxQ1p6d2lIREZrMW5TU1VHUnRPUnBK?=
 =?utf-8?B?R2E3ZHhXU2FkRnduS0JJcXNDVVNUN1BkZUU2OEllZmpwZ1U2Qm9KR3RTNDdo?=
 =?utf-8?B?ZktLY1hrOFM2R0x0cWZVWGgyM1ZWdlZCand6SUhzUFZhZE5ISnROblBUWk9P?=
 =?utf-8?B?UlBtWVZJWXNwM1VHQ3UyYysxejEvSlh1NUhENzVGazJIcFFXaDRNbVBJWUts?=
 =?utf-8?B?MlU0NW5vNk9TSnVFNlJtOENsWU9qcFBNRjFaN1NOK1NZWXdmelMzdHpLVTVz?=
 =?utf-8?B?MzZsSVA3dzV6WG1SbXJNWlhIUzkxRmdXZFlLdXdEeHFCQXFuODQ1YlljQ0M2?=
 =?utf-8?B?ZVZCbzhVaUtITExkUTRQYzM5ZGMrM1hlbXRNV2lYSUdwQ0ZIak0rdGV2QTVr?=
 =?utf-8?B?OEUyRThycTR5ZmxIM0NkQWFwUmdIY201NUdTUDQrSndNTG14VHVTL25sd0lP?=
 =?utf-8?B?N2hpSjRpOGQ0TVZram1raFoyNTVaTWRrbkRvbDRYS28zbU5GQ2FwQTBmaFAy?=
 =?utf-8?B?RmkxTDNRTVQ1cXcrZFkzZGY3RXJ6RUJGMHhlNEZ5NEloSjhnL3hEd1BCVVNF?=
 =?utf-8?B?YitRN2d1VTlGZVJmaElVU0pBY3V2SGQxNnlKTklJZHcvbXVYY3JiU2Y3alRl?=
 =?utf-8?B?emFVdnVFU000cUkvY2xQdUt4ZmF6alY4eklZcGhTN0JjeHZCcEZUaUpRQ0xm?=
 =?utf-8?B?MUZlRW5vTTNQbjJtVWREMW52T213aTE5R1FCYWdXWVUwaHhjRHhCZHJHZU16?=
 =?utf-8?B?QkpYUm12RC9tRlh1SkJkQ1pNY0tBakdsdWkrWmRTUXJ6M202V3I4UUpNTFls?=
 =?utf-8?B?eGJocFZySXhISnRMSlAwSTdvSlYxTk44Vk9KV3NCcEJMK1Bwcm9zWmxZYytT?=
 =?utf-8?B?TWQ0dVFPSXZuaGZxMnVMZlVlS2ZWN1AyQ2Z5VGxsdUpwODVVMXVOTlY2VWRV?=
 =?utf-8?B?QUgzWHZvODgwQkJCQ09XMi8rbzI0d2YxOTMveWFyRGFsNm1YdmdOdG9sWWo2?=
 =?utf-8?B?cUlXWUR5RjZ2aHM2NGVnVnlpRmgwY3R3VnBxeDI1ZUJWTWNHVWhyZUlveUNq?=
 =?utf-8?B?NWY2RGY4V3BhaWRKUzgwSHg2eE8wN0VMVUdicTFLVGZrZW1EZnhUSCtZVUNX?=
 =?utf-8?B?bE9VYjRBY3p1UE1xdFozR3hNUUJLS1pwSjNmM0R1TzVTTHN2M1Fxelgzakhj?=
 =?utf-8?B?RmpydmhYZDBjOEF6MFEyZ0YwQ3BGangwZlY5KzQwSXAwU1FOay9jc3dTRDhv?=
 =?utf-8?B?WjlpL1BFa0JINWxJWUp4K0VhSFFwbWN5Q3JjYXFUTEdUSVozVzI1b2I5NVVQ?=
 =?utf-8?Q?UeP8PEg5A+DCClpT0kjI6CDXyZMizePt?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS2PR05MB9840.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NXdIVVFXdGp1Yy9SR1dYVXBHMUpHTFFNU3NzdkJMUEVZMkhVUUt3YTNiYStl?=
 =?utf-8?B?K0NFUWc3bTBQd1ptc2ZzV05UcVkwbWtESFVOeElyZGk5QlhiSVZuMXBQaFkw?=
 =?utf-8?B?ejh3dkMyUUd1ODBqbzhDUkxVeVRPeUcydEY3MnZoVlNsZnJpWnN5VXhPK1lq?=
 =?utf-8?B?TTRpSFFpMGg4U2RwV25PZW5xTm1hU1BxVFhVbS9xVFErOFNIaDBqeW05UHJw?=
 =?utf-8?B?WXpCWlF2Nm1UdW9aZzJwR3pmUmF6Yk5UL0R3RUEzTTZmTjRKTHA5L2taWGxu?=
 =?utf-8?B?eUZGcWM1cTZyaWdxcVgreEVHLzFGeGRuRkZ6ZWdOcjRBUkM5Mk9XWnZtR3dK?=
 =?utf-8?B?VzNGZzk5YVB3MFlpY3MwOElldWdkQ00zWFVFY3o5WGY5aUJvRldWZGJjN3BE?=
 =?utf-8?B?b3I0bTNGZzVIZmtQZnBBaHJsajYvei95N2lmRFdxNmRRYWtBcDFKUDNrNkN5?=
 =?utf-8?B?VWtsdmtFU3RqRHkwdXdlTEhORW1VR1VwSUp3NEFWZFNvc0JHN2Jhek5LcjM0?=
 =?utf-8?B?RlExOVNmOEhGVXA4TFc1ZEZDZ1dhK05OUDUyVzNDUDJDcmY1WVIrYzM1UEY1?=
 =?utf-8?B?T0lxbWp2a2JKNEVGQmRyTzZPSm5HOU5FYWlYWUd2UW1UeVY2ZGZSSTBrWjhk?=
 =?utf-8?B?OVdqMlFUNmhsTks4eklPKzg4b3RHdGZiU09ySWt2SzBhR2FwUkhEeVJyVnh6?=
 =?utf-8?B?cmYwbEt1czZUMU1QMjFFN0tLbC9HS0VrVkk5bURuYitROGM1RThybXlmbnZC?=
 =?utf-8?B?U1pUUCtqZWpIc0ZSWHluRmdZNW5TU0c4eGNtMVhlYzRsa1RHQVJBVjJWdDRs?=
 =?utf-8?B?VFI0OXQxR2kyM3Ywd2Zsd0Q4dzhHZ3krM280UXlJcDJFUTlXbTdIcEpiNG1p?=
 =?utf-8?B?NXd6aVBDQmhkUlliMkluQm0vSVVLTzRWMmxZNVA2QmhkSDVKSFo3QlBYYWZG?=
 =?utf-8?B?d2VhSkQvMmY5SXlLV0FhelFQNFVJYkVvUi9jcjRwNDcvUE5TaFRrQ3JyUUVn?=
 =?utf-8?B?eFloQUpxVnhSVXFXOHFlQlBwNGw3cXlpNFRiU203Z3RIeDM3SHc2TmM1OUxW?=
 =?utf-8?B?N1doemszbU1zRmUzWEFyaGFHWENWZnp2Z0J0TzB1RThlejRpZzlvaHhJWmQv?=
 =?utf-8?B?c0NNSjhmekk3dkJpeklrVitCbHNRMFdSdk9IMzRRbDNqUDQwWkJPem13ZUNq?=
 =?utf-8?B?WXMvRGNjYmhPczB6bldrUkRDNkJjejJST1BjZ1Rhc1ZweUoyOE03Mm1UU1Jp?=
 =?utf-8?B?b2tFSG94SFR4UzJpeEVSWS9MUWdmZ0RFT0djZk51QjVmNDNkb1FzMm1vclo5?=
 =?utf-8?B?NE94MG5jNnMxeUtHNlc5bDYybFZIMmhmKzdSaFlHVzE0MFdnZHR5Y0RIcTdn?=
 =?utf-8?B?RzJKN25hOEYwYSs5T1BKNjVkb09VRmZsMUx2dGZFZFNaRE12Uy81Qit2VHBj?=
 =?utf-8?B?K09jbE8rQXNwR2J0SjlJWVNnV2t6QXZkYlhocTdZVzVONk5qaDVZcng1TEFx?=
 =?utf-8?B?cDVGVU5vL25jamhmRWtIUmZtRUE4RktlR2I4ZUk2bVdjQnp1WDlBT2RFM055?=
 =?utf-8?B?TXFtZlgydFRkbFptU2lzMWlwT2VFM256bHJrYkp2amxuV0hvQWxJUFpXVG03?=
 =?utf-8?B?cU5qc1FUdkxOb1ZEY0ppR2ZibVhBNFF2YWRmOGlwYUpvc1I3VWxJRURXQk4y?=
 =?utf-8?B?V21DWkNJRE9XODVtdnJ6UncvbTBNSm9ZWVlKL1EwdWVMM2ZtSU5uR3JpSWdJ?=
 =?utf-8?B?eGdtTmtZVnE3YWNwcGZoLzkzVzVkOXR2S1Y1WGFvUHpJdzJYUnBFRTJOUHU0?=
 =?utf-8?B?d0drUzFhYVFaNnNVeHVUMnVNeDU2SnJ6YTFua0tmSTBRanZKZTJpOHBZb25N?=
 =?utf-8?B?WkVJdGdsQkRGRjZxdUtxcGVhWVUyejRtbERHd1lldlVxWHJHcUkyS1N3TGN2?=
 =?utf-8?B?UjZFbHErUjloeXNZWXRkdm95TEZrRlVqMlRMcnoxc3M4ZHpmeDVucW5SdUJM?=
 =?utf-8?B?QWxtaC8yMmpYRWhMcTA1em5yRmxVN01selhWSmxsOXZ2dUIxOEQwdkQxV2JR?=
 =?utf-8?B?VGorUTlad3ZtekorU0REQ1dXNmRPRThQWFZGZ0s0bGQ0ZGFzM1A2ajFUV0Ry?=
 =?utf-8?B?aWtZOGVYY0t6ZURPNlJhSm1DTTE2OWwxU0hTM3Z2SDYrcE5GUklpSFlHVWQ5?=
 =?utf-8?B?TVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <75FA352FC08F4B4E942C8A9085D2F9F0@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: polito.it
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS2PR05MB9840.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28b660cd-b224-452e-64ad-08dd56b868b8
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Feb 2025 22:53:38.7289
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 2a05ac92-2049-4a26-9b34-897763efc8e2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: k7xl5khwgMWYVOtwg5wh45wf4VA0I16KeAzV4ZO+3od81u7b6aTntKz4sEj70Cup9YY7rDVz28eNNRR/EZKriQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR05MB7494

T24gVHVlLCAyMDI1LTAyLTI1IGF0IDIwOjUzIC0wNTAwLCBNaW1pIFpvaGFyIHdyb3RlOg0KPiBP
biBUdWUsIDIwMjUtMDItMjUgYXQgMTQ6MTIgKzAxMDAsIEVucmljbyBCcmF2aSB3cm90ZToNCj4g
PiBUaGUgZmlyc3Qgd3JpdGUgb24gdGhlIGltYSBwb2xpY3kgZmlsZSBwZXJtaXRzIHRvIG92ZXJy
aWRlIHRoZSBkZWZhdWx0DQo+ID4gcG9saWN5IGRlZmluZWQgd2l0aCB0aGUgaW1hX3BvbGljeT0g
Ym9vdCBwYXJhbWV0ZXIuIFRoaXMgY2FuIGJlIGRvbmUNCj4gPiBieSBhZGRpbmcgdGhlIC9ldGMv
aW1hL2ltYS1wb2xpY3kgd2hpY2ggYWxsb3dzIGxvYWRpbmcgdGhlIGN1c3RvbSBwb2xpY3kNCj4g
PiBkdXJpbmcgYm9vdC4gSXQgaXMgYWxzbyBwb3NzaWJsZSB0byBsb2FkIGN1c3RvbSBwb2xpY3kg
YXQgcnVudGltZSB0aHJvdWdoDQo+ID4gZmlsZSBvcGVyYXRpb25zOg0KPiA+IA0KPiA+IGNwIGN1
c3RvbV9pbWFfcG9saWN5IC9zeXMva2VybmVsL3NlY3VyaXR5L2ltYS9wb2xpY3kNCj4gPiBjYXQg
Y3VzdG9tX2ltYV9wb2xpY3kgPiAvc3lzL2tlcm5lbC9zZWN1cml0eS9pbWEvcG9saWN5DQo+ID4g
DQo+ID4gb3IgYnkgd3JpdGluZyB0aGUgYWJzb2x1dGUgcGF0aCBvZiB0aGUgZmlsZSBjb250YWlu
aW5nIHRoZSBjdXN0b20gcG9saWN5Og0KPiA+IA0KPiA+IGVjaG8gL3BhdGgvb2YvY3VzdG9tX2lt
YV9wb2xpY3kgPiAvc3lzL2tlcm5lbC9zZWN1cml0eS9pbWEvcG9saWN5DQo+ID4gDQo+ID4gSW4g
dGhlc2UgY2FzZXMsIGZpbGUgc2lnbmF0dXJlIGNhbiBiZSBuZWNlc3NhcnkgdG8gbG9hZCB0aGUg
cG9saWN5DQo+ID4gKGZ1bmM9UE9MSUNZX0NIRUNLKS4gQ3VzdG9tIHBvbGljeSBjYW4gYWxzbyBi
ZSBzZXQgYXQgcnVudGltZSBieSBkaXJlY3RseQ0KPiA+IHdyaXRpbmcgdGhlIHBvbGljeSBzdHJl
YW0gb24gdGhlIGltYSBwb2xpY3kgZmlsZToNCj4gPiANCj4gPiBlY2hvIC1lICJtZWFzdXJlIGZ1
bmM9QlBSTV9DSEVDSyBtYXNrPU1BWV9FWEVDXG4iIFwNCj4gPiDCoMKgwqDCoMKgwqDCoMKgImF1
ZGl0IGZ1bmM9QlBSTV9DSEVDSyBtYXNrPU1BWV9FWEVDXG4iIFwNCj4gPiDCoMKgwqDCoCA+IC9z
eXMva2VybmVsL3NlY3VyaXR5L2ltYS9wb2xpY3kNCj4gPiANCj4gPiBJbiB0aGlzIGNhc2UsIHRo
ZXJlIGlzIG5vIG1lY2hhbmlzbSB0byB2ZXJpZnkgdGhlIGludGVncml0eSBvZiB0aGUgbmV3DQo+
ID4gcG9saWN5Lg0KPiA+IA0KPiA+IEFkZCBhIG5ldyBlbnRyeSBpbiB0aGUgaW1hIG1lYXN1cmVt
ZW50cyBsaXN0IGNvbnRhaW5pbmcgdGhlIGFzY2lpIGN1c3RvbQ0KPiA+IGltYSBwb2xpY3kgYnVm
ZmVyIHdoZW4gbm90IHZlcmlmaWVkIGF0IGxvYWQgdGltZS4NCj4gPiANCj4gPiBTaWduZWQtb2Zm
LWJ5OiBFbnJpY28gQnJhdmkgPGVucmljby5icmF2aUBwb2xpdG8uaXQ+DQo+IA0KPiBIaSBFbnJp
Y28sDQoNCkhpIE1pbWksDQoNCnRoYW5rIHlvdSBmb3IgdGhlIHF1aWNrIHJlc3BvbnNlLg0KDQo+
IFRoaXMgcGF0Y2ggc2V0IGhhcmQgY29kZXMgbWVhc3VyaW5nIHRoZSBpbml0aWFsIGN1c3RvbSBJ
TUEgcG9saWN5IHJ1bGVzIHRoYXQNCj4gcmVwbGFjZSB0aGUgYnVpbHRpbiBwb2xpY2llcyBzcGVj
aWZpZWQgb24gdGhlIGJvb3QgY29tbWFuZCBsaW5lLsKgIElNQQ0KPiBzaG91bGRuJ3QgaGFyZCBj
b2RlIHBvbGljeS4NCg0KTXkgZmlyc3QgYXBwcm9hY2ggd2FzIHRvIGRlZmluZSBhIG5ldyBjcml0
aWNhbC1kYXRhIHJlY29yZCwgYnV0IHBlcmZvcm1pbmcgdGhlDQptZWFzdXJlbWVudCBhZnRlciB0
aGUgY3VzdG9tIHBvbGljeSBiZWNvbWVzIGVmZmVjdGl2ZSwgdGhlIG1lYXN1cmVtZW50IGNvdWxk
IGJlDQpieXBhc3NlZCBvbWl0dGluZyBmdW5jPUNSSVRJQ0FMX0RBVEEgaW4gdGhlIGN1c3RvbSBw
b2xpY3kuDQoNCj4gSSdtIG5vdCBxdWl0ZSBzdXJlIHdoeSB5b3UncmUgZGlmZmVyZW50aWF0aW5n
IGJldHdlZW4NCj4gbWVhc3VyaW5nIHRoZSBpbml0aWFsIGFuZCBzdWJzZXF1ZW50IGN1c3RvbSBJ
TUEgcG9saWN5IHJ1bGVzLsKgwqANCg0KTXkgaW50ZW50aW9uIGlzIHRvIG1lYXN1cmUgdGhlIGZp
cnN0IGRpcmVjdCB3cml0ZSAobGluZSBieSBsaW5lKSBvbiB0aGUgcG9saWN5DQpmaWxlLCB3aXRo
b3V0IGxvYWRpbmcgdGhlIGluaXRpYWwgY3VzdG9tIHBvbGljeSBmcm9tIGEgZmlsZS4gVGhpcyBj
YXNlLCBpZiBJJ20NCm5vdCB3cm9uZywgaXMgbm90IGNvdmVyZWQgYnkgZnVuYz1QT0xJQ1lfQ0hF
Q0suDQoNCj4gQ29uc2lkZXIgZGVmaW5pbmcgYSBuZXcgY3JpdGljYWwtZGF0YSByZWNvcmQgdG8g
bWVhc3VyZSB0aGUgY3VycmVudCBJTUEgcG9saWN5DQo+IHJ1bGVzLsKgIEFsc28gY29uc2lkZXIg
aW5jbHVkaW5nIHRoZSBuZXcgY3JpdGljYWwtZGF0YSBydWxlIGluIHRoZSBhcmNoDQo+IHNwZWNp
ZmljIHBvbGljeSBydWxlcy4NCg0KSSB0aGluayB0aGF0IHlvdXIgc3VnZ2VzdGlvbiwgdG8gYWRk
IHRoZSBjcml0aWNhbC1kYXRhIHJ1bGUgaW4gdGhlIGFyY2ggcG9saWN5DQpydWxlcywgc29sdmVz
IHRoZSBwcm9ibGVtcyBvZiBieXBhc3NpbmcgdGhlIG1lYXN1cmVtZW50IGFuZCBoYXJkIGNvZGlu
ZyBwb2xpY3kuDQoNClRoYW5rIHlvdSB2ZXJ5IG11Y2ggZm9yIHlvdXIgZmVlZGJhY2suDQoNCkVu
cmljbw0KDQo+IHRoYW5rcywNCj4gDQo+IE1pbWkNCj4gDQoNCg==

