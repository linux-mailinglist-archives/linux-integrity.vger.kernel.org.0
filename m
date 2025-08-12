Return-Path: <linux-integrity+bounces-6805-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 24229B23196
	for <lists+linux-integrity@lfdr.de>; Tue, 12 Aug 2025 20:06:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B6D671AA36AD
	for <lists+linux-integrity@lfdr.de>; Tue, 12 Aug 2025 18:04:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07C222FF17C;
	Tue, 12 Aug 2025 18:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NaejbrL8"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 793522FE56E;
	Tue, 12 Aug 2025 18:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755021798; cv=fail; b=cV8nUEREtHgWzXo09PSwZ8t6yGX03U/joPhJGyYFz7pqBKubhzz8+EZTgI1bJnqTIzkU0BrikJ0CtLYKvru0/5Qvwx1Qa2Gx4jRco+Vdm/QvbX+lcJroOkte2eVE1bGrgnyxRwP3EpTMu24n1m3Li346aqlkQnGauOXHVqqRezg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755021798; c=relaxed/simple;
	bh=9VMmtud5u7vyIChnyZ6EbyIDUX4k2VOV3RkISjK08iU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=mDKZ8ULuFVbPzjAT74HvbGlZJjl4U1ImxHzQOZvb/UaIJgQV+C/SuVoljBxBRr4kKAJyGa3COXTYa9izpobCDwivlQ1WzqQUF6meVcSla4UN82ZWJHAzYYBjngzPYHjLncaWwXYamBjZZnf8XFunm9y8Ifts5QWZkeInoCqYuKA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NaejbrL8; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755021796; x=1786557796;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=9VMmtud5u7vyIChnyZ6EbyIDUX4k2VOV3RkISjK08iU=;
  b=NaejbrL8O5OM/ASDT7Cl0oXGaYuC04N1KsAZ1YmrR+wFuIHkjgsJO+m+
   ctdu3GJwvDlzZafkU5SxWxotDmbWp5OxUfJcttaWFEJOassAM9Ip+IZXN
   Q/Yv5DtpUkQdV0OveGkJfLtI00o87jWk1i0QE1kTCeh6KzrkbN/di64JL
   rx03RopzRfSlBS06V+7r6nCRFW5BuFdD1CwlVsW8Ct5gJjcncFROed0k7
   VHLgremkho/bkHGv8AyfZsdqn9lIHkRVjd5ypNgIwHcbPEnNUNCE8u+N6
   w9MljpZ/qjXpC3zscl3GtixWo4zhNa0cUIb10rGOBW0J4xXOn9reMSTCJ
   w==;
X-CSE-ConnectionGUID: KTGtvIM3Txm31WCeo1DGRw==
X-CSE-MsgGUID: 4BVuLsCnR5m/iOototRPRQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11520"; a="57388243"
X-IronPort-AV: E=Sophos;i="6.17,284,1747724400"; 
   d="scan'208";a="57388243"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2025 11:03:15 -0700
X-CSE-ConnectionGUID: N8D0aeIzRCOntS33cHLqnw==
X-CSE-MsgGUID: Pu/stXzIRZOC/ml1swGQAA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,284,1747724400"; 
   d="scan'208";a="166633120"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2025 11:03:15 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 12 Aug 2025 11:03:14 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Tue, 12 Aug 2025 11:03:14 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (40.107.220.77)
 by edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Tue, 12 Aug 2025 11:03:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FSKNc+xw306IaEd/P1YyA1UzzUr8Ab41OOJ7dvcAwXKYeEf5ygYDs/DH+9E/H4ROUjpSfPxIDem05Y+/fsHPi+DkGrmTbCVsii8ukncRBvYDr56/1I8voK0LHPmzS6YPdfvG2GhRvK5id1AeTBBWMbPmTFQV3BcwSb4NeNFQQztEYneIW2+aiR8RMa9+mHHcR+LjYcK5ZddXkrLBU7pOCtW8QpZVL7hbEB0uqEANWmX7iQx/PDN1esAxLu96+2QO9GhATqgNG2mjnwL2RuWdudV+dsJ+6oY/k9iAC2UwMCx3iKBbWl8tiJgXeQ5N0Pfs1+vGWPEJfhP1U3u+FGxFEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9VMmtud5u7vyIChnyZ6EbyIDUX4k2VOV3RkISjK08iU=;
 b=AAo6IrvzyxEhJuxXvcMRYFVEulJV1VB/2obiBZOCNa4w91x+gt84FlFHaoiyjQyeHbA9KxYMAdLHgEuZQf0N2LXYE2Kdi/96cPResylJil2rob7coUO8yj+1IMIHE5ktbJ5/LvbmHu09b5FtpqvTatVwi6TFw448TsN2YMp9avJnt5P76pCyt+LfjYHUlgW1fD9iAq0uwzEfUB0Ev44S4FNN9/Sna8rZnCNy6d0uCMoDmX1vCIh5IaBbG+WF+HQgTD0pKlZxkbyrBVxoFQJouU2+x1+c17uqvc0JAECv9zrGvWdN/JFsGOs5KjD3AOMWCm919gQ7N5FsZ8oCgi1/7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by PH8PR11MB6755.namprd11.prod.outlook.com (2603:10b6:510:1ca::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.22; Tue, 12 Aug
 2025 18:03:12 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::edb2:a242:e0b8:5ac9]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::edb2:a242:e0b8:5ac9%5]) with mapi id 15.20.9009.018; Tue, 12 Aug 2025
 18:03:12 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "glaubitz@physik.fu-berlin.de" <glaubitz@physik.fu-berlin.de>,
	"peterz@infradead.org" <peterz@infradead.org>, "mingo@redhat.com"
	<mingo@redhat.com>, "luto@kernel.org" <luto@kernel.org>, "namit@vmware.com"
	<namit@vmware.com>, "bp@alien8.de" <bp@alien8.de>
CC: "ard.biesheuvel@linaro.org" <ard.biesheuvel@linaro.org>, "sam@gentoo.org"
	<sam@gentoo.org>, "andreas@gaisler.com" <andreas@gaisler.com>,
	"nadav.amit@gmail.com" <nadav.amit@gmail.com>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, "anthony.yznaga@oracle.com"
	<anthony.yznaga@oracle.com>, "akpm@linux-foundation.org"
	<akpm@linux-foundation.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "will.deacon@arm.com" <will.deacon@arm.com>,
	"linux_dti@icloud.com" <linux_dti@icloud.com>, "deneen.t.dock@intel.com"
	<deneen.t.dock@intel.com>, "linux-mm@kvack.org" <linux-mm@kvack.org>,
	"tglx@linutronix.de" <tglx@linutronix.de>,
	"linux-security-module@vger.kernel.org"
	<linux-security-module@vger.kernel.org>, "sparclinux@vger.kernel.org"
	<sparclinux@vger.kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
	"linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
	"daniel@iogearbox.net" <daniel@iogearbox.net>,
	"kernel-hardening@lists.openwall.com" <kernel-hardening@lists.openwall.com>,
	"ast@kernel.org" <ast@kernel.org>, "x86@kernel.org" <x86@kernel.org>,
	"kristen@linux.intel.com" <kristen@linux.intel.com>
Subject: Re: [PATCH v5 18/23] bpf: Use vmalloc special flag
Thread-Topic: [PATCH v5 18/23] bpf: Use vmalloc special flag
Thread-Index: AQHcC6hTrllX/niJ602agkO+d3kzKLRfT2qA
Date: Tue, 12 Aug 2025 18:03:11 +0000
Message-ID: <1738e24239cc0c001245fdd4bd3811175c573ce2.camel@intel.com>
References: <20190426001143.4983-1-namit@vmware.com>
	 <20190426001143.4983-19-namit@vmware.com>
	 <14437e403ed8fceacafe0a89521d3b731211156e.camel@physik.fu-berlin.de>
In-Reply-To: <14437e403ed8fceacafe0a89521d3b731211156e.camel@physik.fu-berlin.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|PH8PR11MB6755:EE_
x-ms-office365-filtering-correlation-id: 2baac09e-51e7-43dc-c910-08ddd9ca8089
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?ZzF3bGF5MERrR3dJS0dmQ3pKTG5OREFxb1ZUK1RyQmdSMnJ0bkQ5VkR6NVdD?=
 =?utf-8?B?TS9HNmxiaERXdnNsb21ZOCtCbEwrK0Ezd2VGNVFYS2RnMUxEZkhSU29uOXNl?=
 =?utf-8?B?UktKQjdlK2VaTnBCTjRBSTdPUmJZTnR4OHAwQjFoTk9SbVVKMEluM3BzMFEw?=
 =?utf-8?B?UGNoanF2d1Z1bjNMUEJUWDc2SVlYN0FMcG44SFAvQ1FmYzR3K0ltTHZBemsr?=
 =?utf-8?B?SGFjKytCcFM4MmRmN3lSTUNlM3EwUEtkeHZ2NEVuaFR1WDRtRVYyc0NlOHRC?=
 =?utf-8?B?QmErK0lMS3R5QmdJV0dHUXRNU1VSVW8vam1tbmNreFk1Tlp0UDB2dlEvWGFs?=
 =?utf-8?B?M1ROd2gwTzFJVTRETXFBKzRkWTBTcXhpV3pHKythVlJ4OUMwNnVadk5EbXpG?=
 =?utf-8?B?d2syY2pkSWpSTmdLWCtSYWRCV01GVG9sVHMwSTZSUG5OUnoyRzZVMExKMWND?=
 =?utf-8?B?alNFdWx4SW1wVXBQdmlhMmxBODFCdjU1TkI3SW9GWHpoOTZsTzEzb3M3emdQ?=
 =?utf-8?B?OFM0M3VZNzl4UFA3S2prcnJsU3FqMHE5NXNYamtiN2pFOGl0U2VIVU1XQXhW?=
 =?utf-8?B?aXlBd0lJcGhRZ1lTTy9PVEZucWNsSG5vZlRvbUpDbzMyMXNrVzZPQ1FrSEoz?=
 =?utf-8?B?VllDbjVUeStDK3lJeVR4NE5HQlNLTUczWUJOMWVoU3JINzRyTHUrR0Z5WG9D?=
 =?utf-8?B?SjJEOStCbHJtVlFaaWdHbFpadzV3aWwwV3ZMZTBrZkI4UjZBUk9NdWltMDlj?=
 =?utf-8?B?YXArZGVscjJuS1RXYWNkOFNpWlBxWEpPaFZJTjU0eU5XMzZGTHNCOExsSzVq?=
 =?utf-8?B?OUxibmliTGRGaTR6M2pKWnVVdyt1U0plUm9WdW1tei9FbTVqUXRKTHl1V3kr?=
 =?utf-8?B?Y0tvVzFUWXZSZzlEZm5MdHdWSFpjMEpOWnp2ZllxK3N0WEZkMjFvMzZzK3d2?=
 =?utf-8?B?Rm1OanQ5MngzRW10WUVGUWRqVE9XaGNUd09CbWtsT2gyU05SRGIzUGc0TFpC?=
 =?utf-8?B?VWZ3YWx0Z0RodVAyMzhEb0pXUFV2d05DSEorQW5zanQ1dlo4U1NwMUQ3eGNI?=
 =?utf-8?B?aUtieHAyZWxHODUrNGhZdnJXTVljb2dVYXpGajlqY1haOUpvQkNielZJTFhT?=
 =?utf-8?B?SWIzL1hTbjVxbmFxMU5YM0VQeXNqVDcyWTgzSy9mWlJTamkvN3hOZkhvY2cv?=
 =?utf-8?B?M1Mydk9lOGRCSlNSMnlCSzZ1UmpkK25hRFlXSmcrZldNU2tUVzlXTjJkREtM?=
 =?utf-8?B?Z0cwTm4va012ZklYaTJkamNXUlZxVTg3clFJcHovbG8ycGdtMm5kckpyRHRW?=
 =?utf-8?B?M090NW1leEtOdmY5cDJTcGZsUCt5MlFocVlmS0doa2x2RXRIemkxeXphZFFs?=
 =?utf-8?B?Y2g3eUNRYmxnQTlRYm82MzRkWDR5MDdGNER1MlFMazlEZTdFNTBqQWxMTVg0?=
 =?utf-8?B?V0hkd24zWnMxcE5GQVJpZy9BelNMb1dJZHBiR2UrdDhhams2L3dGT0lnSEty?=
 =?utf-8?B?YWhYdzRxSUx4bXZ5M1Z6RVlmcERCUGpsbFNZMWMrdEs1MVhJOU92anlaOThj?=
 =?utf-8?B?QUUyQU5FT0Zac2txTUdzQllwc0h1b2ZsdkpBa1lUZ0FaSENsYVJvTW1DTjdR?=
 =?utf-8?B?YkMxSGtlZDVGMnMrc2lTU1FuaUNpaUtyVGtIQ2Rkb0gwWUxzaGlWcHY0MjZC?=
 =?utf-8?B?ZEpicE9XWkR2QWg4SVBlZXkzNXV0RTJjZS9jdjd4U3B3SDVEYU9WQUl6cnFN?=
 =?utf-8?B?Wk9paVpHWjVYK0hCRTFTWjRTdW1QdzUrcXRKMVBWby9UbkppbTk3WCtQWlRh?=
 =?utf-8?B?WUx2Rm5hVzM5SSswaElqUEIyYytWdm1uN3lJQjNtaWJjaCtTanFNVzExR1lL?=
 =?utf-8?B?c1BCUWk0Qk5OVDBWNFgyZDg0QUtoN1VKMzNwYVVQSTNhUkE9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?K0VJLzZjVkJpaHJ3ZlJ3QWF0OE1XTG9ERUtZZWg5S3E1SWJVSkUrSE5jdXpN?=
 =?utf-8?B?eTR4NW1QUW1kRGNnWXJrd0JMMmNlSWl5OFMxREV6TStOcFRySmJNbTRZM1I1?=
 =?utf-8?B?NDlxN0MvcEFPdnhOWEdYcTRoa2VMSC94ZVRzdDVzSW92cHk1bEJMNERGeHE3?=
 =?utf-8?B?TklJTjNQRUVQcitXY1RVQUJXSncxRGxQaEFMbjgxRElvNFZvcHVjR2ZMUDZy?=
 =?utf-8?B?WFVIYXpMWGh6WkZ1UmZkNFhrSzlBRXBtU2RHSnNwRFVEQUFDTmRydUdoNTJ6?=
 =?utf-8?B?U0h0Qit5OHF1V3BOTWxqWEFDVU1oalRDc3pOR3QxRWM1dWJZUzlWczJKYlVm?=
 =?utf-8?B?SWNVZHg1Z28rb2JDZDlrY2tKa3YzcmtGR3pJWHlLckx3bDdBN3l1dWZPMGx3?=
 =?utf-8?B?YS9lNURqeG01MzE4VUpBMEZ1VDdyNll2U0Jmc3pBdk5QUzMwR0ZXOFpZcUQ2?=
 =?utf-8?B?RlZaOEM0RmZvdG0rbWFrRXBsMUc0VkNsV3NGUE12UkdXdGVsRlNZNUdJRE1q?=
 =?utf-8?B?d0c5ODB3KzBWa1NHU2RNeDlVa0dONHNqMmZLSzV3aDVXc0FpZmcrMS91OHc0?=
 =?utf-8?B?dm51cVJCZzd6U0dJUERTZE9MOEllWFFvYzdMVkpCWXQ2ZDlpWHJpd2VPbG1Z?=
 =?utf-8?B?MXBwUnFiakllTUFDcldiVWJSZTN6dDAwazN2bjJ5ZWhEbS81RVFJNi9tVHJz?=
 =?utf-8?B?bVRHQXNLYlpRN29QL0Fmc3VFU0hHUW0ybXVtSjBQN0FRM1AvOUVQbW01MXVv?=
 =?utf-8?B?b0RrL3pSOVN4bVdlNW85YVF4bUFQRUhmaCtwVEFrVUNoc3JGVjR2cXpXY2VP?=
 =?utf-8?B?c0R2RllFb1k3ZnhRZ3pSNTNMNEt5Y0lVU1VzcXBZSDJ2MzhuK2xzRU9JTzNJ?=
 =?utf-8?B?MjZXQzZKb0JhMXlra1RESzFCam9DWkVPeDRCOHg4aWNpdzJ1UitFVFNHZDlw?=
 =?utf-8?B?NVJUR2k3WWVvOUFOSHdIa0QwN2VTK1N5SkpkVUY3bUJwQ2d1ZUs1dDNwTE9Q?=
 =?utf-8?B?ektJSXlzWVR2a0RxcDZQM2lPU2xXSGlaVzBlZmhPRVFMUmRPcEtYb1hmTUJi?=
 =?utf-8?B?a1hDSm5VMGRaRllNVkllZUZNaUNWNm1ocW02cGx6WUxVNkJPVXFLV01KMkxx?=
 =?utf-8?B?OWxGdFF1SEkwdGVBRFNiS09VSEkzbGxiQmJoNFVuZWttWWllNWZBYVdka3hn?=
 =?utf-8?B?MkJBbkVqUWJua1hPVXpkWUxoeWtPNHFDZ1UydHFQNDdGSVMxOGFQczRHRXZD?=
 =?utf-8?B?OTdEZGZtQTlVSmIzNlFIQ2Vvd2gvamJwcmkzUmlnbDlna3Q4WFpHUVBvNG1x?=
 =?utf-8?B?c0IrcHhqSmRiMmwvekdIUERCNlFsSnRWVGltQTdqWXdEYVlGazFGSTdyL0U1?=
 =?utf-8?B?SmlsWlZ6akQ5NlphalNLOWNYT3pVSURjUUFod3dldFN6VHFzWVVGYkovWEts?=
 =?utf-8?B?eHpLaVVSaFpucmhJM0FHa25rdDRIL3oyc2w5VjZlTG9FTzBQcy83VnlPTUEz?=
 =?utf-8?B?ZkNFbTFOaDVIQ203bU9KTGlSR0hWMGlKdXRLMmtqdVZ6Z1l0MmJ1WkVYUXYy?=
 =?utf-8?B?TlVkSHRJcm91Tk1PVlpVd25OUWc0OXJ5YXJ0TnVPa2NsbkxlYzN0QVptR2NC?=
 =?utf-8?B?a0I0cFZ1akZHMGFKSzdpL21hSkcyY0VidFRZR0tNZllFWHlpRFJqOXRtK2NU?=
 =?utf-8?B?ME90Zi80bFppSmNQaVpBZ25PNm9hdGJjSnREMGZvVHFiaDUzWDk3d0FTbUJY?=
 =?utf-8?B?RWgyZGJYRlJHM3JEY2w2LzlPM0hyVzlaMmVhQ3ljTjVFTGN5WEFzSVRmSTNh?=
 =?utf-8?B?S200SFJzSGxIN29pRy9VNVlnTFoxZ1NuRldDaUVHQkpxNnlyK3l5WlpKQ0sr?=
 =?utf-8?B?MU1DS2hjbmFJaXBZdGh5UGhNcERLeWxCM090cU5SRi9JT0NyNW5lOWhJQzE2?=
 =?utf-8?B?U2RLM0NFM1ZRWHlBK3BBSHU4dFpsTm1zSU5Tak01M1RiV0RXQ2loQUwwRkdt?=
 =?utf-8?B?QWQ1US9OSGwyNWZ6RGJBWHdsSmpzZ2RhL3JmbEVCV0xUSmZhSnhucE1QWVZW?=
 =?utf-8?B?aTJycXd4QUFVMWlvN0tCWitMQ2tVVXZuRHNlaFkxVWpudS9xN3pvTW95M3dG?=
 =?utf-8?B?VVh6TkZlelVwN1h4NkFmYW5mUTZvcVBjUExNQTdDODZPMkV3Y1VzZlY0RjJ3?=
 =?utf-8?B?eXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CCEB683B6B927D428D047AB18D9954FF@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2baac09e-51e7-43dc-c910-08ddd9ca8089
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Aug 2025 18:03:11.9051
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Z7mb6VKwCB92LdsxloZmyyyiPEsCXNzyK/968Rk0Hguzey63nshnQGreBz70ciTZuPC4YeWVP9LpreoyT8klhEcctyrwUht1XcErMrz8R9s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6755
X-OriginatorOrg: intel.com

T24gVHVlLCAyMDI1LTA4LTEyIGF0IDE4OjQzICswMjAwLCBKb2huIFBhdWwgQWRyaWFuIEdsYXVi
aXR6IHdyb3RlOg0KPiBJIHN1c3BlY3QgdGhhdCB0aGUgbWFpbiBpc3N1ZSBpcyB0byBiZSBmb3Vu
ZCBpbiB0aGUgZm9sbG93aW5nIHBhdGNoIHdoaWNoIGludHJvZHVjZWQgVk1fRkxVU0hfUkVTRVRf
UEVSTVMNCj4gd2hpY2ggbWF5IG5vdCB3b3JrIGFzIGV4cGVjdGVkIG9uIHN1bjR1IFNQQVJDIHN5
c3RlbXM6DQoNCkkgdGhpbmsgdGhlIHByb2JsZW0gd2UgZm91bmQgd2l0aCBWTV9GTFVTSF9SRVNF
VF9QRVJNUyB3YXMgdGhhdCB0aGUgc3BhcmM2NA0Ka2VybmVsIFRMQiBmbHVzaCBpbXBsZW1lbnRh
dGlvbiB3YXMgYnJva2VuLiBTaW5jZSBWTV9GTFVTSF9SRVNFVF9QRVJNUyBjYXVzZWQNCmtlcm5l
bCBUTEIgZmx1c2hlcyB0byBoYXBwZW4gc29vbmVyLCBpdCBqdXN0IHNob3dlZCB1cCBzb29uZXIu
IFswXSANCg0KVGhpcyBvdGhlciBpc3N1ZSBzZWVtcyB0byBiZSBhYm91dCB1c2Vyc3BhY2UgbWVt
b3J5LiBTbyBJIHdvbmRlciBpZiB0aGVzZSBhcmUNCnR3byBzZXBhcmF0ZSBpc3N1ZXM/IEJpc2Vj
dGluZyB0byB0aGUgb3JpZ2luYWwgVk1fRkxVU0hfUkVTRVRfUEVSTVMgd291bGQgaGF2ZQ0KaGFk
IHRoZSBrbm93biBzcGFyYyBrZXJuZWwgcmFuZ2UgVExCIGZsdXNoIGlzc3VlLiBTbyB0byBiaXNl
Y3QgdGhlIG90aGVyIGlzc3VlDQp5b3UgbWlnaHQgbmVlZCB0byBhcHBseSB0aGlzIFsxXS4NCg0K
DQoNClswXSBodHRwczovL21hcmMuaW5mby8/bD1saW51eC1zcGFyYyZtPTE1NTkxNTY5NDMwNDEx
OCZ3PTINClsxXSBodHRwczovL2xvcmUua2VybmVsLm9yZy9hbGwvNTczODVBQUItQzlBMS00NkFE
LUI3NDMtNDQ1RDRFQ0NBOTAyQGpydGMyNy5jb20vDQo=

