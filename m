Return-Path: <linux-integrity+bounces-6807-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2653CB23567
	for <lists+linux-integrity@lfdr.de>; Tue, 12 Aug 2025 20:50:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2891E5625A5
	for <lists+linux-integrity@lfdr.de>; Tue, 12 Aug 2025 18:50:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F58F247287;
	Tue, 12 Aug 2025 18:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="c+2u/9lw"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 638E32ECE85;
	Tue, 12 Aug 2025 18:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755024595; cv=fail; b=QeQH3YGqQ1YC2FYi5Q40VRpRkcC/cJWBG6MUP8HDUhPiW3ssg5pbj3tJ8ziIWn8t/s6b2K5Xcg0v1+huB38OpGj3ieRlVrhFsinqBPBsGihYhvZGSptyJvuwkx5MxJln/Vw7eUu3+Tkr2Lqv/rnQ7PhWJV5KchmobdVdnSlr67Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755024595; c=relaxed/simple;
	bh=6envAb5eD86dXt9If+ehmxLVt5iGQI9BH7ez5b+cZjI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=CEcyVOmP5yl0tpR9hqUXZIbyLm42A2L95N1fx0ehKgnTAE/0ZM9jvHQTYtryWrTvqWsEoniTEd7YjIBoX7Sg/Gx6eZmOKPaq1RkuDn3iGSWWb4p7yALnSTlFSimRQckfnbcD6Z4zNQv8x7yVXltJqWRRjflM5h4vh8a6fQDncZA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=c+2u/9lw; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755024593; x=1786560593;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=6envAb5eD86dXt9If+ehmxLVt5iGQI9BH7ez5b+cZjI=;
  b=c+2u/9lw66fIWBM1riHVaRScCg21WFWkpAp1AsJ4GLwp4/bNLFHE9ny1
   ainQOvHa+RvK5emej8c04eZjlCG163G3L64NeuvswtEsHsOaL56aRw1Fv
   lRzsKkpxRlt/eR7WSCCqoo+V0ydpE9h6OUJHPea3RRgBN3Vrhszm2Ntgr
   1ZucDTKoe9aPEV9WNsZt1nHrK6uG4/5QVf44J6YE4QesBEh5Zh54G77kz
   LJ0sFof96ShiDkRwepKEujPsvVvz4JincH64IOOG9Q5lSbG+fHaCRUBw5
   hQaSUxz1rcS3qvCW6J0MVK0O1AqgAKAT2kTW1KgyBxBhPXnrngCx0DuX1
   g==;
X-CSE-ConnectionGUID: T3KIgloDSaCN/30JJl47/g==
X-CSE-MsgGUID: sRmC/K9MRzS127rLHAv/Ww==
X-IronPort-AV: E=McAfee;i="6800,10657,11520"; a="59929290"
X-IronPort-AV: E=Sophos;i="6.17,284,1747724400"; 
   d="scan'208";a="59929290"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2025 11:49:52 -0700
X-CSE-ConnectionGUID: 1Ge2LYMYReuHrfZHQTGXZA==
X-CSE-MsgGUID: 1alPiMjWTO+2IR3xHKoAqQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,284,1747724400"; 
   d="scan'208";a="166642289"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2025 11:49:52 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 12 Aug 2025 11:49:52 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Tue, 12 Aug 2025 11:49:52 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (40.107.236.71)
 by edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Tue, 12 Aug 2025 11:49:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NNjRJpDDkyIAqadKoxlvIKvlxTmrkTLGJXdtdWs576C3kpidiFOH0jRKefB/YDhNgpehBkLumKonsA3xwxOYgDlB/SCoPFc46wfdYKl3PT7wD0S7iIQjyf9TJouHtkplvAJuch3+IUjxG+c5ytcVOsH+j7NU7gr/RTFVTBlJS2hLOUeilxjQC9PO7SKttA5fliQ2SFLE8XzcNerjS1l3FfCU5hyTQTKzDtz8iNDga67BHGxPiwJtSb3TX6Q9ollAhyrpCLxJ4PiPaA6rE1L+WJV1qupt1h1yw4Ip4VA1G9Q9iKm3GYxE7rFEC5Tan+7+EaQ1A+1d+ABpqVpxDSaLQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6envAb5eD86dXt9If+ehmxLVt5iGQI9BH7ez5b+cZjI=;
 b=D17Jz/YcFWvzL+ij2xN5pP6zX+w+g43AyO+3Iv83d2hsTRK/7zwE2xsTxjSRJh31WA+PulM4WageCOEeRBpuGGDeAjDQI9ayissKEMhn1aE3+wJcsbp2YdBfl4jJVavdYUWmKek1omkP75O/8bDZ/5HLqu81tpRiTxlMfOO4QLJsArSCj4Uebn2Rfpb4KBozZqkKc9Q/y/MYuOnBsWxP4/lLtOfdQ/S5/Cd2HVIMHw03xxg0UEETtqAuhMW2HU0POtc6GX1p3JSS8RWki/Huz/zJgvW0xHEOd+zU6MUiBXoXwuLy5jocdqD6LpCHnh0DxJ7KVewyvgess4+3BBTwOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by SA1PR11MB6943.namprd11.prod.outlook.com (2603:10b6:806:2bc::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.14; Tue, 12 Aug
 2025 18:49:43 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::edb2:a242:e0b8:5ac9]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::edb2:a242:e0b8:5ac9%5]) with mapi id 15.20.9009.018; Tue, 12 Aug 2025
 18:49:43 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "glaubitz@physik.fu-berlin.de" <glaubitz@physik.fu-berlin.de>,
	"peterz@infradead.org" <peterz@infradead.org>, "mingo@redhat.com"
	<mingo@redhat.com>, "luto@kernel.org" <luto@kernel.org>, "bp@alien8.de"
	<bp@alien8.de>
CC: "sam@gentoo.org" <sam@gentoo.org>, "andreas@gaisler.com"
	<andreas@gaisler.com>, "nadav.amit@gmail.com" <nadav.amit@gmail.com>,
	"anthony.yznaga@oracle.com" <anthony.yznaga@oracle.com>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux_dti@icloud.com" <linux_dti@icloud.com>, "will.deacon@arm.com"
	<will.deacon@arm.com>, "deneen.t.dock@intel.com" <deneen.t.dock@intel.com>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>, "tglx@linutronix.de"
	<tglx@linutronix.de>, "linux-security-module@vger.kernel.org"
	<linux-security-module@vger.kernel.org>, "sparclinux@vger.kernel.org"
	<sparclinux@vger.kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
	"linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
	"daniel@iogearbox.net" <daniel@iogearbox.net>,
	"kernel-hardening@lists.openwall.com" <kernel-hardening@lists.openwall.com>,
	"ast@kernel.org" <ast@kernel.org>, "x86@kernel.org" <x86@kernel.org>,
	"kristen@linux.intel.com" <kristen@linux.intel.com>
Subject: Re: [PATCH v5 18/23] bpf: Use vmalloc special flag
Thread-Topic: [PATCH v5 18/23] bpf: Use vmalloc special flag
Thread-Index: AQHcC6hTrllX/niJ602agkO+d3kzKLRfT2qAgAAJhICAAAN8gA==
Date: Tue, 12 Aug 2025 18:49:43 +0000
Message-ID: <7e4dfc01e132196d3ff10df18622252a8455d1b8.camel@intel.com>
References: <20190426001143.4983-1-namit@vmware.com>
	 <20190426001143.4983-19-namit@vmware.com>
	 <14437e403ed8fceacafe0a89521d3b731211156e.camel@physik.fu-berlin.de>
	 <1738e24239cc0c001245fdd4bd3811175c573ce2.camel@intel.com>
	 <49b112b80b211ae05b5f3c36a55f67041783f51e.camel@physik.fu-berlin.de>
In-Reply-To: <49b112b80b211ae05b5f3c36a55f67041783f51e.camel@physik.fu-berlin.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|SA1PR11MB6943:EE_
x-ms-office365-filtering-correlation-id: c8056472-480d-4651-f43c-08ddd9d100a7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?TzgyWHlwalh5anFSdzdRNjMxRXJ3eTYvemV2Nlp5bnBXRmdRTXp3MVpIUUtP?=
 =?utf-8?B?Qlplcnl3STlYOGFhZVlYRmpLT3VsYmVpN3JzTXFWTVBmdmg4MkFvMFRDUUhu?=
 =?utf-8?B?Vlk1aUl4K3N6Y0QvaWZhQXZMYlhIeVlmUERtYzg0YkdJVWVZQi9LWm5wTWdj?=
 =?utf-8?B?ZXdraFROcTFkWFRJcDhNWkQxRlFpb0UzSkxmNlBnZ0hXdE85OFpoZ3ViNGlH?=
 =?utf-8?B?Z3JETDR0RnpocVhNNWdOUGNnWWtwUk5lcktFdDdZSVN4VmpkenA4NFBkd0dU?=
 =?utf-8?B?QnZXUmJVMXJ2Z2ZFWkNzQnVhVm1UWUw4MUhGUFZnMHdJSkV6MzVXM2lXSzdT?=
 =?utf-8?B?VFpsaHZJbnZ5Nnl1dUxaSEtKaGZKc2JDY0MrTGZoWFpucEtVVE1NQjhRV3dj?=
 =?utf-8?B?UmFZM2NHcHdrV0FhY2ZLT2x4OVJjcGpzSWVxN2pzclZ3S3JqM0EzQzMwMWRW?=
 =?utf-8?B?Z2F2RldUa3BYVXBROFNZM2pQRmsxUUN4Z2g4b3NkZzRwZExqUEZoN290TzRz?=
 =?utf-8?B?bG1UTXdvMWJFeWV1QmFiU2w0eXJiREFZU3d5bEY2dGw3L250R1hBSXExbXNZ?=
 =?utf-8?B?VHZxUUtnb0dCVkRmc3ppTXMxaTJFengveEYwcUVIUW03NDk0YTJIb3drak51?=
 =?utf-8?B?RE1TR0NNcG1aVVB1TytQZTR3bEcrUlZDOGIrWGUvdnlzYmpKSEVGSVpIbGFY?=
 =?utf-8?B?MTBrK0xmdnVnMHA5clBMT2VjbjlwOXRONW5heU94aTk4VmhPaVRuZjlQZ0lK?=
 =?utf-8?B?cHdVWE1NQ1EyZzFaZktSdjNQQ1ErVE5xdHJ3UzI0amRPSVRoMUFTM0ZNU1d2?=
 =?utf-8?B?QXk4bFdHZjllVmNZZDNUb1lodldoQ3lScnhIUWprb1gyYnY1dUVqaEJuWEl5?=
 =?utf-8?B?TXpIak9JQ3Z0MWR5UlFud2VpdXhHWndnYlBzMmNlcnljYk9MZXZKcTBXZjFT?=
 =?utf-8?B?ZXpOeWlaWU9lSHFFdDFRbEY2YXExV3A5TW00bU40dmZmMXl5NnpNMGEvZmQr?=
 =?utf-8?B?UitscnpjeDNRekllY2xSNUtrOXBxNjUxYTNISHZDSFMvOHBqOFdya2U5Rm42?=
 =?utf-8?B?UzZGN2wzV0dGT21ldG9sWDdadHhYWnpwYXRYNlBCT3VpYW5BVjdKQzVDTkI2?=
 =?utf-8?B?YmNxUW1NdFhDSmdFV0R3QTFCbktLWlFvZHZ6ME5UK0hrcnlEVE4xcVJvUzAy?=
 =?utf-8?B?dnhiZ3ByWWY1cUF2TG1iaDVVWTNhSUY5YzJLbDk5eHVJeE1oUmRuSzAzeVRV?=
 =?utf-8?B?ZzU4WWFmeVdqYUwrVGh6cEQ4dHF5K3cwcjFvVGJReGdWVWRCUm4wcmpoT3o3?=
 =?utf-8?B?eUExUit6NEMrV0Q2SUozKzErcXR3Nk1oYnl2WHhhakZNNG1CRzdoRGEyQ0Rv?=
 =?utf-8?B?UDJ6dnRzOEhGejBCMXRpWU4rSG5WbkNhU2VmM3JTODRybmhGNWJiNXI2VlhR?=
 =?utf-8?B?dlp1ZkR3end3TnZkNkhIME1PcWlVQmUrYTdTYS9YbjZHMHlOOUZEWnJZTUtm?=
 =?utf-8?B?c0tKR05rRkZUYzYyWmxHWEx6MGo1b2RSNTVFaldzcmFrRi9YbnU3azhJYjVT?=
 =?utf-8?B?TGdJUGtzanlucy9VNjBObitBNk04WkZaN2ZaVGxzRzNoV1JXUDA1QkkwbFpB?=
 =?utf-8?B?ZTVSdVNlNnNMcnA2Qm5ISVpKN2lLenlsUTR1WlRDZUZyZzdhUzV1ZUMxeGJY?=
 =?utf-8?B?NGFIcXY5ckRyZXl3WmJ3bUl5SndIWVNaYks2UGhQTlhoTHFXQStWd1o2WWZ4?=
 =?utf-8?B?VXlIOWVrLzI5K2JnRHIrN3A4RlZVOFZSUTBwYzFrSEdnVlBTcTZRK3ZuMTZZ?=
 =?utf-8?B?ZzJtUVMwa2FFVHhuWStDUCtBSThrcmxMWUlmaU42aVlRamdnNGFjOGxQenlU?=
 =?utf-8?B?NnkrcjlDRUR4TjU1Z0s3OVNHMExCbG91QjF2WVc1MEI4MkQrYnFvUWE2eWJi?=
 =?utf-8?B?elhyY3NNSXh5bTBPZ3JlazZ6S2RzMVpnWnhiR2xMeUdPNW1vdFk5dTQ2UEVz?=
 =?utf-8?B?SVpGUC9tRFZnPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZmV5RnduTDg3UXNVV3REZEw3MDhHUytRUmRMNnpZNFJPb25WK1JwczhQWktF?=
 =?utf-8?B?SExXaG00Z2M3aXBiSU85YldHZ3F5SGJUZWVFYnBVM1hhNzVjZVJmR0I0dkJq?=
 =?utf-8?B?NTRGV3VCZW5yMVhLWlYwbWlpcFhRTUEzOWluSGRKR1lwbS85NGpVZlI2dUx1?=
 =?utf-8?B?UmYyM1F6aE9qUWl4Tkd6ZVQ1RDZ1L3B0SEFmd2tuTHBaRGRTK29zME9QWVls?=
 =?utf-8?B?TFV1bDM3RXQ3UHdmUUhVb1Fvc0RkZytvKzFFd1kvN0JQeVpxeHVwMmVkS3JJ?=
 =?utf-8?B?VkhMOEVEU1hqc0ZURGZ5NVNsYmVHcEMrR1ZqVmNOYmV4STJ1MWFNemFXQmRO?=
 =?utf-8?B?VExFSzlmV1U1L21ITzhMUW1FZ25mblZVWm02bnRBS0hNMnpkZHRGcGlmZmVT?=
 =?utf-8?B?UnR2a0xBK3ZRbGRsQjFJajQwMjNSK0lJTmxBQlFyTWFsNWNhclJ3UTZRZmJC?=
 =?utf-8?B?VWlFVXhnMzhVMDY5clB6U2dVTklxWFlMOTlqYXk4TFhjQnY0MVhYZ0dyZDB0?=
 =?utf-8?B?WG5paWpoTGRhTkQ0VVpGd2JzMzRnT3JwQkRlSEs4SGxIdW51NkVERTFMS3Zo?=
 =?utf-8?B?NFdGZjQwU0xKV2V0ODZ3SVBCNnJ5amsraVFFWCtjS2NTdURpYWpNYnlCclZT?=
 =?utf-8?B?VUxFTHlRcUZic2N1YlJWS3FwL01hTWcrTHhtdmxzYThIQk9oUU9NRXJER2RL?=
 =?utf-8?B?VHhrZ0ZhdjJmemZMVDNWbExYbW1lS0N1OW43TUNxTU9TQVdVVE9rVDFaVmoz?=
 =?utf-8?B?NGxVWDA0TXUyVXNTNk5zMmN1T0hTR1lua2M0K3c2WEQ3VzArenVEb29JM3lM?=
 =?utf-8?B?elNuTFhWQ0phRHNOZDkrQWlSVEE4b2IrQ1RwMUMrNmxzZ1VZaWJHOUREcXlH?=
 =?utf-8?B?dUUvNzhRUWR4MTBpTGNxNjYwRVo3MjZJbzVOMkhVcjhBWHdjRWdOTzExTTlO?=
 =?utf-8?B?SlYzaTBhaE11U3ZFVGthandJbVVPaEQ5d05IMm5BbUJBZkNaTlhGT0h2KzFW?=
 =?utf-8?B?MlhZMWtuSVZoaE4wVlhTQ1VHS3lwMk9DK2kyVXBqK09TcnRFRXAvK1BHeW9w?=
 =?utf-8?B?eTQ0VFl4MEpiWGlFb1B5ZzFueXdlWjlaMEtSUGo5NmFEZmxMcW1lVWFCNmsv?=
 =?utf-8?B?UVp0MWZKUlc0akRKakoxQmtOQlQ2ckl0L1BDSW5ybTBTQS9ZTElCTjlBSHBS?=
 =?utf-8?B?cG10QXEvbk1JQVJZTjFVZFNUcUp3M0RRRk9WNHNFRXpPWElsanRxS01rdlhY?=
 =?utf-8?B?UHJob2ppZVp4cnNyTlJSc0FGNWF5N2w1enMvTFFuakJIemM3bWVqY0dsUWFC?=
 =?utf-8?B?UFRGQ3JDeUhhTVRTcytGSmFFeTZWT2U3L0VuNm9MZUNCTEJ6bVVJK0hVZEhj?=
 =?utf-8?B?RndCcVp4S2MyRmowdEZTUVZaWVpWWmRwSGc4SDBZS0d4QzQrbGN1eDRaZnRO?=
 =?utf-8?B?ZGc3b3V6KzczaVdsUjgvU3dRc3lHUDBaR3ZFa0pvYUZKZjhrS1VVbldKMWo3?=
 =?utf-8?B?ZmJQSFRmN0VuRDUyMy9zNDM0T2J3UUhhTzJQQ3d4OEZFUm1kR2oxRyttZjdX?=
 =?utf-8?B?UEhuUnNkVnp6QXZ2Ny9NcnVXVG81NlBYZnNPa1U3QnIrVGdVQWVpdUJTOE5u?=
 =?utf-8?B?dlhGVkNoK3kwdVNZZE9COWVSY0VFVVNJZ2lFQjBiYUJxNHFIMEs4bjZhbmxE?=
 =?utf-8?B?RUxpN0NOUE9SYS9scjhMTER0UkZ1QUk1RHBHcDZ2cjljNlJMdG1VOGF3c2FT?=
 =?utf-8?B?WEE5dXEwL1JhWGJobUFMRFFYZlBtQTVCN2ZWWTVTYWJPWXV0WEJxZ2Z0Y21z?=
 =?utf-8?B?Vi80NlFnc2dSMGJPcWo0L1QxWDd1b3NUSkRwZUVxNzBmYjlIM2RnYnhveEZ6?=
 =?utf-8?B?dTZYeXpWT0M1OWsxQnYwK29WNGNVSjdhczdmVXBaZWZ2OUFWbGtzczVGQWcr?=
 =?utf-8?B?N0JJQ2tvZUJocUovdWE1bzRLdXovYlVscDE4TExmNzVsZTRvLzJtaCtJOE1R?=
 =?utf-8?B?UlR3bXJTakt0MkZBOFppbmpPcWZMUXR4b3plL2hzKzQwbVRMMy9JMmVPZUVy?=
 =?utf-8?B?SmhlZGJFcFBYMjUxTXFXWTloYzFOQVhqRGtwTmFKV08zWFhuaTYrd01tclZh?=
 =?utf-8?B?UTJONlR2NlpIMjNNMWU4Yzgrd0RCOHcwaGJrbzBQdVNsZjI0cjF5bm54QU5N?=
 =?utf-8?B?NHc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F6CA8DD45F72DC4D84D01684082F018C@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8056472-480d-4651-f43c-08ddd9d100a7
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Aug 2025 18:49:43.8661
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: F0JvZ0M1oJrHkkdM5WYXz87hp/zEIDMxcRpsznLVAXdR98UhSs6Rev4y45XF+sC++vJs+VU3dKv3BgndnVYYC8kS2VmDH3TUQITJBWYq3xE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6943
X-OriginatorOrg: intel.com

T24gVHVlLCAyMDI1LTA4LTEyIGF0IDIwOjM3ICswMjAwLCBKb2huIFBhdWwgQWRyaWFuIEdsYXVi
aXR6IHdyb3RlOg0KPiBUaGF0IGNvdWxkIGJlIHRydWUuIEkga25ldyBhYm91dCB0aGUgcGF0Y2gg
aW4gWzFdIGJ1dCBJIGRpZG4ndCB0aGluayBvZiBhcHBseWluZyBpdC4NCj4gDQo+IEZXSVcsIHRo
ZSBjcmFzaGVzIHdlJ3JlIHNlZWluZyBvbiByZWNlbnQga2VybmVsIHZlcnNpb25zIGxvb2sgbGlr
ZSB0aGlzOg0KPiANCj4gW8KgwqAgNDAuOTkyODUxXcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgXHwvIF9fX18gXHwvDQo+IFvCoMKgIDQwLjk5Mjg1MV3CoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgICJAJy8gLi4gXGBAIg0KPiBbwqDCoCA0MC45OTI4NTFdwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCAvX3wgXF9fLyB8X1wNCj4gW8KgwqAgNDAuOTkyODUxXcKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgXF9fVV8vDQo+IFvCoMKgIDQxLjE4NjIyMF0gKHVkZXYtd29y
a2VyKSg4OCk6IEtlcm5lbCBpbGxlZ2FsIGluc3RydWN0aW9uIFsjMV0NCg0KUG9zc2libHkgcmUt
dXNpbmcgc29tZSBzdGFsZSBUTEIgZXhlY3V0YWJsZSBWQSB3aGljaCdzIHBhZ2Ugbm93IGhhcyBv
dGhlciBkYXRhDQppbiBpdC4NCg0KPiBbwqDCoCA0MS4yNjI5MTBdIENQVTogMCBVSUQ6IDAgUElE
OiA4OCBDb21tOiAodWRldi13b3JrZXIpIFRhaW50ZWQ6IEfCoMKgwqDCoMKgwqDCoCBXwqDCoMKg
wqDCoMKgwqDCoMKgIDYuMTIuMCsgIzI1DQo+IFvCoMKgIDQxLjM3NjE1MV0gVGFpbnRlZDogW1dd
PVdBUk4NCj4gW8KgwqAgNDEuNDE1MDI1XSBUU1RBVEU6IDAwMDAwMDQ0MTEwMDE2MDcgVFBDOiAw
MDAwMDAwMDEwMWMyMWMwIFROUEM6IDAwMDAwMDAwMTAxYzIxYzQgWTogMDAwMDAwMDDCoMKgwqAg
VGFpbnRlZDogR8KgwqDCoMKgwqDCoMKgIFfCoMKgwqDCoMKgwqDCoMKgIA0KPiBbwqDCoCA0MS41
NjM3MTddIFRQQzogPGVoY2lfaW5pdF9kcml2ZXIrMHgwLzB4MTYwIFtlaGNpX2hjZF0+DQo+IFvC
oMKgIDQxLjYzMzU4NF0gZzA6IDAwMDAwMDAwMDEyMDA1YjggZzE6IDAwMDAwMDAwMTAwYTE4MDAg
ZzI6IDAwMDAwMDAwMTAyMDYwMDAgZzM6IDAwMDAwMDAwMTAxZGUwMDANCj4gW8KgwqAgNDEuNzQ3
OTYyXSBnNDogZmZmMDAwMDAwYTVhZjM4MCBnNTogMDAwMDAwMDAwMDAwMDAwMCBnNjogZmZmMDAw
MDAwYWFjODAwMCBnNzogMDAwMDAwMDAwMDAwMGU3Yg0KPiBbwqDCoCA0MS44NjIzMzhdIG8wOiAw
MDAwMDAwMDEwMDYwMTE4IG8xOiAwMDAwMDAwMDEwMjBhMDAwIG8yOiBmZmYwMDAwMDBhYTMwY2Uw
IG8zOiAwMDAwMDAwMDAwMDAwZTdhDQo+IFvCoMKgIDQxLjk3NjcyOF0gbzQ6IDAwMDAwMDAwZmYw
MDAwMDAgbzU6IDAwZmYwMDAwMDAwMDAwMDAgc3A6IGZmZjAwMDAwMGFhY2IwOTEgcmV0X3BjOiAw
MDAwMDAwMDEwMWRlMDI4DQo+IFvCoMKgIDQyLjA5NTc2OF0gUlBDOiA8ZWhjaV9wY2lfaW5pdCsw
eDI4LzB4MjAwMCBbZWhjaV9wY2ldPg0KPiBbwqDCoCA0Mi4xNjQzOTRdIGwwOiAwMDAwMDAwMDAw
MDAwMDAwIGwxOiAwMDAwMDAwMTAwMDQzZmZmIGwyOiBmZmZmZmZmZmZmODAwMDAwIGwzOiAwMDAw
MDAwMDAwODAwMDAwDQo+IFvCoMKgIDQyLjI3ODc2OF0gbDQ6IGZmZjAwMDAwMDAxYzgwMDggbDU6
IDAwMDAwMDAwMDAwMDAwMDAgbDY6IDAwMDAwMDAwMDEzMzU4ZTAgbDc6IDAwMDAwMDAwMDEwMDI4
MDANCj4gW8KgwqAgNDIuMzkzMTQzXSBpMDogZmZmZmZmZmZmZmZmZmZlZCBpMTogMDAwMDAwMDAw
MDRkYjhkOCBpMjogMDAwMDAwMDAwMDAwMDAwMCBpMzogZmZmMDAwMDAwYWEzMDRlMA0KPiBbwqDC
oCA0Mi41MDc1MTddIGk0OiAwMDAwMDAwMDAxMTI3MjUwIGk1OiAwMDAwMDAwMDEwMDYwMDAwIGk2
OiBmZmYwMDAwMDBhYWNiMTQxIGk3OiAwMDAwMDAwMDAwNDI3ZDkwDQo+IFvCoMKgIDQyLjYyMTg5
M10gSTc6IDxkb19vbmVfaW5pdGNhbGwrMHgzMC8weDIwMD4NCj4gW8KgwqAgNDIuNjc3OTMxXSBD
YWxsIFRyYWNlOg0KPiBbwqDCoCA0Mi43MDk5NTNdIFs8MDAwMDAwMDAwMDQyN2Q5MD5dIGRvX29u
ZV9pbml0Y2FsbCsweDMwLzB4MjAwDQo+IFvCoMKgIDQyLjc4MzE1OF0gWzwwMDAwMDAwMDAwNGRi
OTA4Pl0gZG9faW5pdF9tb2R1bGUrMHg0OC8weDI0MA0KPiBbwqDCoCA0Mi44NTUyMTRdIFs8MDAw
MDAwMDAwMDRkZDgyYz5dIGxvYWRfbW9kdWxlKzB4MTljYy8weDFmMjANCj4gW8KgwqAgNDIuOTI3
MjcwXSBbPDAwMDAwMDAwMDA0ZGRmOGM+XSBpbml0X21vZHVsZV9mcm9tX2ZpbGUrMHg2Yy8weGEw
DQo+IFvCoMKgIDQzLjAwNjE4OV0gWzwwMDAwMDAwMDAwNGRlMWU0Pl0gc3lzX2Zpbml0X21vZHVs
ZSsweDFjNC8weDJjMA0KPiBbwqDCoCA0My4wODE2NzddIFs8MDAwMDAwMDAwMDQwNjE3ND5dIGxp
bnV4X3NwYXJjX3N5c2NhbGwrMHgzNC8weDQ0DQo+IFvCoMKgIDQzLjE1ODMwN10gRGlzYWJsaW5n
IGxvY2sgZGVidWdnaW5nIGR1ZSB0byBrZXJuZWwgdGFpbnQNCj4gW8KgwqAgNDMuMjI4MDc3XSBD
YWxsZXJbMDAwMDAwMDAwMDQyN2Q5MF06IGRvX29uZV9pbml0Y2FsbCsweDMwLzB4MjAwDQo+IFvC
oMKgIDQzLjMwNjk5NV0gQ2FsbGVyWzAwMDAwMDAwMDA0ZGI5MDhdOiBkb19pbml0X21vZHVsZSsw
eDQ4LzB4MjQwDQo+IFvCoMKgIDQzLjM4NDc3Ml0gQ2FsbGVyWzAwMDAwMDAwMDA0ZGQ4MmNdOiBs
b2FkX21vZHVsZSsweDE5Y2MvMHgxZjIwDQo+IFvCoMKgIDQzLjQ2MjU0NF0gQ2FsbGVyWzAwMDAw
MDAwMDA0ZGRmOGNdOiBpbml0X21vZHVsZV9mcm9tX2ZpbGUrMHg2Yy8weGEwDQo+IFvCoMKgIDQz
LjU0NzE4NF0gQ2FsbGVyWzAwMDAwMDAwMDA0ZGUxZTRdOiBzeXNfZmluaXRfbW9kdWxlKzB4MWM0
LzB4MmMwDQo+IFvCoMKgIDQzLjYyODM4OV0gQ2FsbGVyWzAwMDAwMDAwMDA0MDYxNzRdOiBsaW51
eF9zcGFyY19zeXNjYWxsKzB4MzQvMHg0NA0KPiBbwqDCoCA0My43MTA3NDFdIENhbGxlcltmZmYw
MDAwMTA0ODBlMmZjXTogMHhmZmYwMDAwMTA0ODBlMmZjDQo+IFvCoMKgIDQzLjc4MDUwOF0gSW5z
dHJ1Y3Rpb24gRFVNUDoNCj4gW8KgwqAgNDMuNzgwNTExXcKgIDAwMDAwMDAwIA0KPiBbwqDCoCA0
My44MTkzOTRdwqAgMDAwMDAwMDAgDQo+IFvCoMKgIDQzLjg1MDI3M13CoCAwMDAwMDAwMCANCj4g
W8KgwqAgNDMuODgxMTUzXSA8MDAwMDAwMDA+DQo+IFvCoMKgIDQzLjkxMjAzNl3CoCAwMDAwMDAw
MCANCj4gW8KgwqAgNDMuOTQyOTE3XcKgIDAwMDAwMDAwIA0KPiBbwqDCoCA0My45NzM3OTddwqAg
MDAwMDAwMDAgDQo+IFvCoMKgIDQ0LjAwNDY3OF3CoCAwMDAwMDAwMCANCj4gW8KgwqAgNDQuMDM1
NTYxXcKgIDAwMDAwMDAwIA0KPiBbwqDCoCA0NC4wNjY0NDNdDQo+IA0KPiBEbyB5b3UgaGF2ZSBh
bnkgc3VnZ2VzdGlvbiB3aGF0IHRvIGJpc2VjdD8NCg0KVGhpcyBkb2VzIGxvb2sgbGlrZSBrZXJu
ZWwgcmFuZ2UgVExCIGZsdXNoIHJlbGF0ZWQuIE5vdCBzdXJlIGhvdyBpdCdzIHJlbGF0ZWQgdG8N
CnVzZXJzcGFjZSBodWdlIHBhZ2VzLiBQZXJoYXBzIHRoZSB1c2Vyc3BhY2UgcmFuZ2UgVExCIGZs
dXNoIGhhcyBpc3N1ZXMgdG8/IE9yDQp0aGUgVExCIGZsdXNoIGFzbSBuZWVkcyB0byBiZSBmaXhl
ZCBpbiB0aGlzIGFub3RoZXIgc3BhcmMgdmFyaWFudD8NCg0KU28gZmFyIHR3byBpc3N1ZXMgd2Vy
ZSBmb3VuZCB3aXRoIHRoYXQgcGF0Y2ggYW5kIHRoZXkgd2VyZSBib3RoIHJhcmUNCmFyY2hpdGVj
dHVyZXMgd2l0aCBicm9rZW4ga2VybmVsIFRMQiBmbHVzaGVzLiBLZXJuZWwgVExCIGZsdXNoZXMg
Y2FuIGFjdHVhbGx5DQpub3QgYmUgcmVxdWlyZWQgZm9yIGEgbG9uZyB0aW1lLCBzbyBwcm9iYWJs
eSB0aGUgYnVnIG5vcm1hbGx5IGxvb2tlZCBsaWtlDQp1bmV4cGxhaW5lZCBjcmFzaGVzIGFmdGVy
IGRheXMuIFRoZSBWTV9GTFVTSF9SRVNFVF9QRVJNUyBqdXN0IG1hZGUgdGhlbSBzaG93IHVwDQpl
YXJsaWVyIGluIGEgYmlzZWN0YWJsZSB3YXkuDQoNCg0K

