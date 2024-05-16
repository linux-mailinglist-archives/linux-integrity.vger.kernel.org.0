Return-Path: <linux-integrity+bounces-2426-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D5238C72EA
	for <lists+linux-integrity@lfdr.de>; Thu, 16 May 2024 10:33:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 60BFC1C20BC0
	for <lists+linux-integrity@lfdr.de>; Thu, 16 May 2024 08:33:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00C001411C8;
	Thu, 16 May 2024 08:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Z4O37zu0"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60BE013E88C;
	Thu, 16 May 2024 08:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715848434; cv=fail; b=CxLwyJh2UY07sf1FO129uTHkENIzjHGgrHUs7cyTwfI5SoWc8aJ4T7QDwzKXFCo+34CJlRDndw6dkKAnov7ZidjZCBH/6tCuVDOPCXwTnZnmsI4AQlz3ni3Iwsxkq0oeG0nvBWR/3eQUjN6XmtD+Ts+o+qJbR7cv7JzRBabeZUE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715848434; c=relaxed/simple;
	bh=QyGdnZPYr3T+Fj/XQzJLLEg/lqL6IeGmCmGJyWZPXGk=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=SONzm8n0x6hPV1mAKJNSXFSC7Uvz6xe2UbcuZRQVal0pTZqW3eyZpeaqnXC8mSFpcv48/tBdvQtUmGnwNONUeZp54tlluVOM7thsTSJkDS0LzI++GiTj34Wm7Y19It6gtLZEr7pgVkc/vMS6lMeFOW4S/OuZl5+IEmGt+6GncVU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Z4O37zu0; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715848434; x=1747384434;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=QyGdnZPYr3T+Fj/XQzJLLEg/lqL6IeGmCmGJyWZPXGk=;
  b=Z4O37zu0MsB4oHjnnBYQdupSMPBZFvKDL90rUz6/S+CGbC62GHff1XVv
   aBpQ1YPCFpQ5sfbqL/6WBEcUNelZQnTKZBeLoaxBApVBM2oa3sjzC+zoY
   1XcqCzncaBjKp9ZKAZmjoDdUw8OlUvTlWA60IwkZF2tIlp6QH2yyYShxP
   gKgW9HKHPAQzzVfn0Grr0OIJAdctLN7EvfMLcwng7UH5jc2XtUenesjKL
   gjLOUHsJlLnIkDfcKxyXDwg12xRLgM+Kx2GdRz6HKQ6dKu4XyJhbh+lQD
   eJZC64AyQCl8WHY1bWhZXjiF+5ofnkGNLP0gxrUiq1EtmMprcb4a1UyHa
   Q==;
X-CSE-ConnectionGUID: c4a89DdIQx6fAuhbFtPYvw==
X-CSE-MsgGUID: OPni4tQ0RC68q9nKC+7r7Q==
X-IronPort-AV: E=McAfee;i="6600,9927,11074"; a="22547095"
X-IronPort-AV: E=Sophos;i="6.08,164,1712646000"; 
   d="scan'208";a="22547095"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2024 01:33:53 -0700
X-CSE-ConnectionGUID: v+OkkIV4Tc+utrq+yoPyLA==
X-CSE-MsgGUID: cPU/2dXLTrm6H/Vy4rdBXA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,164,1712646000"; 
   d="scan'208";a="31909113"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 16 May 2024 01:33:52 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 16 May 2024 01:33:52 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 16 May 2024 01:33:52 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.41) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 16 May 2024 01:33:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nZtsb6ZMIwXmK7OzaRpeJr/lsO8Ykp+sUe4/Ed1x9J14GEiXGZhlY9AVsg3HUc65+fR3sTuqTN/ZGSxTrVUS64Fh7tZcgm0FGqPUMtqtJUdu4m2RTuC/sgF7d2Z7ZDSTs9+S0n9fDxkKhxGcXrBSE0H1Cny5mk4kIdnk2E++vTAgrQ+Kf4UbyHQGmyPyJcrZ72gE7H6HP+zDSoYxoyvg/jbSOmbv4qTUS/81Lgvr2P/q6jZqIqyqxk4OX8/DsM8ztCvHRW/BULxEQw/MxgLTxn9po4ZAk4XBO54GZ3OjLiwucjUlvRvCKWZ6LmzwuKkydQ9r0NxM5w60uKnRKlFJhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZzbK+ch0XOQigcU3MR3+Xbcj2yU4v9kU5GmwhPtRbgc=;
 b=n8XbrpmCKUl2ZIg62q8ziRdafbBN4udfkA2xzkQD6gTQduBPy8x093WlZfMuSATqm2SfVhsfkNRDppDURdRjTkT6Lgd/tmINUbQbAfziR0nOdH0BgNF+Qbelyof5L13dMG6pihGxj/D0w318f5MJHZ6KusiI0AQFSiRLUfJr0ckoSoXtDiOg8+lQ5Zt35ypmycYy3dk+8qr+JWvv+G/Kagq4ssk5ACdBJVeXy94zy8e1CXKFVnn1x2tU4T0LLHLUn9ygIf5YXAL5pUTc0KPWrOMxyCe1fMqTvbt8+zhdDXE03Ykjm11S4DQMM87g/VMfwYCbrNoSaCqDqByWZGi4ZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS7PR11MB6269.namprd11.prod.outlook.com (2603:10b6:8:97::14) by
 SA2PR11MB4889.namprd11.prod.outlook.com (2603:10b6:806:110::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7587.28; Thu, 16 May 2024 08:33:50 +0000
Received: from DS7PR11MB6269.namprd11.prod.outlook.com
 ([fe80::af1f:dcc:49bf:1a26]) by DS7PR11MB6269.namprd11.prod.outlook.com
 ([fe80::af1f:dcc:49bf:1a26%7]) with mapi id 15.20.7544.052; Thu, 16 May 2024
 08:33:50 +0000
Message-ID: <e656039b-3883-46e6-b76b-a2343050b028@intel.com>
Date: Thu, 16 May 2024 01:33:45 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 4/4] tsm: Allow for extending and reading
 configured RTMRs
To: Samuel Ortiz <sameo@rivosinc.com>, James Bottomley
	<James.Bottomley@hansenpartnership.com>
CC: Dan Williams <dan.j.williams@intel.com>, Kuppuswamy Sathyanarayanan
	<sathyanarayanan.kuppuswamy@linux.intel.com>, Qinkun Bao <qinkun@google.com>,
	"Yao, Jiewen" <jiewen.yao@intel.com>, Dionna Amalie Glaze
	<dionnaglaze@google.com>, <biao.lu@intel.com>, <linux-coco@lists.linux.dev>,
	<linux-integrity@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20240128212532.2754325-1-sameo@rivosinc.com>
 <20240128212532.2754325-5-sameo@rivosinc.com>
 <ec7edddcf8c74e48cb392db0789b03243ab05692.camel@HansenPartnership.com>
 <ZkHoiYMseU0XqEbR@vermeer>
 <a8ea533bf30c658508875948f29341663360db57.camel@HansenPartnership.com>
 <ZkLxwacH9nt6U9dk@vermeer>
Content-Language: en-US
From: "Xing, Cedric" <cedric.xing@intel.com>
In-Reply-To: <ZkLxwacH9nt6U9dk@vermeer>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR03CA0004.namprd03.prod.outlook.com
 (2603:10b6:303:8f::9) To DS7PR11MB6269.namprd11.prod.outlook.com
 (2603:10b6:8:97::14)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR11MB6269:EE_|SA2PR11MB4889:EE_
X-MS-Office365-Filtering-Correlation-Id: e5b3b72a-1d9b-445d-387f-08dc7582e902
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|376005;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aVFJOUpNQm1EaVYzNzM2Qkh6VmUwSG85emVFbFZaMVVUSlo5bVIzcmRtbkVt?=
 =?utf-8?B?R0MrVHVsMzZJZVFEZjFkVWtvWjhkSnFQSWRsTVpscmtwYzQwRWhGdi9EbjNz?=
 =?utf-8?B?NUF6RllSb3lHUE1CVzE3OFFjVlFYY2RpNUhRQk9IMWh3OVlTUXRWRU5aYkVY?=
 =?utf-8?B?MnlVcnh5VXE1Q1V6b2ZVZkM2QjlZeFVUdVFjOTErekROVW4xcmtDS2RKV0xG?=
 =?utf-8?B?SVBuZC9KRHB6ZEFrZjA4cGpCZ0pUcXpPYjFBclc2cElqMExTbGxxUE90WnRR?=
 =?utf-8?B?NVptMnc1Umw2WjJNeStwUzFlRGNJMWwwdHd1RHVGQW9haUxSa1RnTWFSTkNE?=
 =?utf-8?B?MWRiYjNpazdnN01FNDFtNmI2TWVMYW96bmZuY202ZmpZeFh0TEVjK3B1Snp2?=
 =?utf-8?B?NzJnWVNQU2VhT2JRRy8xbG55R1RPTGtKZkMvaGltVmQ5Z2V6eCt0UFVySEFV?=
 =?utf-8?B?V05McHQ5OVZXRzhGOThWdkd3akhPeC85cTRjUk5FUnFxeU1rUDExMUQ1dFhM?=
 =?utf-8?B?Q1BDbGh4a3E1WDFCMUI0VVM4aGl5WDI4cmdMQTljQU5HNDYrR0RqR1BQR1V1?=
 =?utf-8?B?aEtOTUdTZ2Y4WTdzbHBXRy8zM1phc0lIemorOWJEY0g0cGhVb1hFOGllcGda?=
 =?utf-8?B?NXN2aU9VVnlZaS9hWXcvdjNGbm1ZWUs4L01wSGtXdzU5bjE5OGFTQ21mcGtn?=
 =?utf-8?B?SDZkckJFQitrcGp1d1hDcVVOQXdsdUNhVDJhN3hKMDRCNmx0aHd5bkJOZ0NG?=
 =?utf-8?B?T1NpWU5nYzhXWWM4SytFaHdqUmcveS9ZQXByWGpod0k5Lzd1Tzg3MVFVSFlP?=
 =?utf-8?B?TW1GSHFDazdMZExxWW1vVWtTdWlSOERNM2NWNlBTemtYME5sN2Z1Yjhabm9V?=
 =?utf-8?B?YUhyQjFqWDR0S2FyYklSVDR2VUhwS01iclJ2SWhRaGFJOXgvdkxFYjVWL1Jo?=
 =?utf-8?B?b2svZEN0Vmcra0VteHJEYnFTR3BtTTIrNFUrc00zZHNvN2RkK0UvaUZxUVJu?=
 =?utf-8?B?ekxZbm1Ib1BDdVJXL0xtQlBIdXkyZ2o4WlE5elpFT1VRVDc0MWYwQlA0eTVz?=
 =?utf-8?B?cEc5QXl3S0E3UGEwZWNPcCtQb3BZcHpVWms0R1JFck1kQ0swUDFNREpLRTVD?=
 =?utf-8?B?M1JpTW9hckRRV2d2TXl1U21CLzJYdWNHb00rb1lldVBrVFhSNEVXTFJhRUU0?=
 =?utf-8?B?NWRNdlVkZ2RKWDFmSVZwYkUySndyM0xER2RPdEpTcGFwdlRRQXBuRVhRWTF3?=
 =?utf-8?B?L2FIODdCU3pYSVZzRzNTZWRoT0hSVDhxeCt5QlN1Z2ZKMldzRmFrcWNEWWhO?=
 =?utf-8?B?TjA1eVM5NE8yajdZMzVrYmVxTDNZYUVhb0ZjTmtmZThmb1ZCVHExbmpyS1M4?=
 =?utf-8?B?WHIyb2pvZkZGRzhWMlE0aDVTS2grSHJuZmpUTm9MZUV4L3BlaWgyTTZKMndl?=
 =?utf-8?B?TjNXWk8vdW91blBwUlplcDdKa1BxbU5mSld0K2U2RnM1MnJVQTNHSTB6RVRU?=
 =?utf-8?B?dXhtUTdGZVVOUjBxV2lVZEhkeFp2QXA3b1c2RjFKV1pBcnN2a015QzE1RFVm?=
 =?utf-8?B?by8rODBQTE5nTkcxUUlIUzdEWUo5Z2dvWkJqMlRZNlhGY1praEhFZHBzRklT?=
 =?utf-8?B?bzRKU3FJZ0hCYU5iMTFsN0JmZktJdDRCMjhLZXd3ZkphZk9mUXdnMWg3d01T?=
 =?utf-8?B?QkxiUXBaZWVnV0JoM1hsNGRndXM4OVYzc1MrMmxrUDNEajBJREt2WE1RPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR11MB6269.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y3RNdjVmZ1luVXlvUm1kaXRDYlpidW5NeXpwSm9KYXFkVWFoZGJpbWZZbXVR?=
 =?utf-8?B?Uk12R0F2YmNiRFlVSWI1ZWM2WkIzVCtNK0JSMEl5dUF5NEhlenlsWmdXSTJh?=
 =?utf-8?B?U3UxWXRpNHIyT0ZYNFhPOHBmQ1g3MHA0ejNUenE0bVh0akZ2UVNsZ3ZnYm1y?=
 =?utf-8?B?SXhHYnZSSHZvalh3TU1nTUpOOTVSL0tHTlg2Y2dzeE81Znpaai9FRm84UjR5?=
 =?utf-8?B?VTN6enhaQWlydUxYK01WRXB6MXh3aVZGVUd4RTNaN2I5N3VNL1dyUUpvN1By?=
 =?utf-8?B?THRuSjJTdHZwOWNKaXBuWldsMG5FUTVlczQxTmFYbXRBODgwemJOa0czTER3?=
 =?utf-8?B?VnFUL3lwSjlGdndUN3JRZldJbHFWZkUya2NtdWh0d29CeDlZUGNQd09Ua2NR?=
 =?utf-8?B?cS8vZVM2RzdqODRXRzM2RmZ5ME0rM2F3cXRzRm8xWG14YnZmWmN6NTVKZzR6?=
 =?utf-8?B?TEJja3JobnJBZm0xQXgzOTMwRHBVZEJ5anBmSTUvalcxV3RSZ3NReG1NVGNk?=
 =?utf-8?B?Unc0SzVIS1E0blpuNlZhNE5DSk1uSXlVdXVQUHRJS3B2Njk3S2tLdzJtUXJ2?=
 =?utf-8?B?emU3b2RuUGNTUUduUkpLeHF2MEw0WEYwUEJKdFZHUUhoaXlONk03bkJ1Z0tu?=
 =?utf-8?B?bzI1QWkzMGViZStWTmExWUwyQUNTeWNTaWtGZFdLVDMzOS9GZEQ5c2UwNXhQ?=
 =?utf-8?B?Mnk4aW9BVzVLL0lndm5kaDVQNFcrb0ZuQWdNTzd0ZnZKaG1yNkNQZVBkMCt5?=
 =?utf-8?B?blVUZGZWTUVUOTIvaWlWUS9ZRWZtQUptYzcxVC93MW5IY1hFSUVQSzhpRDFk?=
 =?utf-8?B?WEFWZ0dtTEFUYllqYnNDdTA1OE5HU2Z4NUhUMG1wRzVHZzh2ZVg3dmdYR1hY?=
 =?utf-8?B?ZUpUSjIzblZvRi9zbnhmMEdqWk9Xc1hLV0ovaFNEaHpWR3J0TnU1R3ZidGJy?=
 =?utf-8?B?NmRJck9icWJYQ3htZ2FueXZOQktxMEpwQVpDTjNvMHRsSHJRR2p3OU5LSkRy?=
 =?utf-8?B?WUh0bXkvVXVjUE1tNGZyeGRjNndYWTVrV3h6Y1pOZEY4Z3JtRHNVRG40UXY5?=
 =?utf-8?B?UEhsNnBOZTZmeUpzSDB5VjBzb1M4L1E4Z2EwenUreTZtbjVCMW1vVDRaay9G?=
 =?utf-8?B?NXZjdjh0Y0F2czhTOU5sbytEUDh4SUljY3k0Zk1IQmI1ME44R3VuV0FNU1hy?=
 =?utf-8?B?a2ZqU1B6aDNUcUtYZlhSNndGYjl4TVBBcHU4V2tHNHZYZ3FTVURGbnpxN2Ey?=
 =?utf-8?B?c3BZM2k1MUNzZXovSWh6MHZBajl1MTVCditWYmJDdU8xckEyY0Y2VzgyNkJq?=
 =?utf-8?B?ZDYyN2FYMjQva0hvTE1LNVg2VUgvUE5zbVJEQmtRZitERGZNRllQV1FCVTAv?=
 =?utf-8?B?NTZDQTFJcHFPOW43MTFJdFpnRXo3WlJhS2ZNWVpJaHR6bFFBUUJFaEdIaTFO?=
 =?utf-8?B?RGpqcjhwRnR4NDBpeWdGWHc5bWM2UU1aanZpVkV4QlRmb3lYcU5zWnkwaVRi?=
 =?utf-8?B?ckhHNksyYWJoOWMvYTduTXN0Rms5bjFsTzd1UWEzTnZyM2hVeGJvd0JXeXVa?=
 =?utf-8?B?STBSUTcyVG1DOXpFZDhCUjdqY3VEbkM2ZVFJTVI3NklkWm5RdXM3YWtQSEZt?=
 =?utf-8?B?aWlzSGVVNFVqb1ZQaWk0eTNBcUpwZm16ZmsxaEk3NndpVkZjU3owNHhzQzVi?=
 =?utf-8?B?akt0UjdsVkFSTEZheHVNMnY0R00vMGJiOHp5ZURRam8ySzZNMXJaODRWTExD?=
 =?utf-8?B?QmxmT1gzVmhuR0VGM1E2cmFnYm0yeTkyc2FGWWk4b3dkR2l0RXFVMGdidTVw?=
 =?utf-8?B?RHNuYXMvanhIVlBzM1RVdmZIblhVL0FDOFdVU3p6TmF5R2d5Tks4VGJsWlRH?=
 =?utf-8?B?N04xTlExVlBHTkJiR25pYnVkWEhwODhZM3pVejRMVWYyS2llYVhvOHd3T1g1?=
 =?utf-8?B?bWJxOERDd2ViY29xWSs2ZFRMQWVRK0p6R2I0RWtwc3NaL0x3MkNhd0l5dWNj?=
 =?utf-8?B?S0M2T0hDYll5ejBHMzVBVHpIU2lnNVVWbGJCdHd5aXYvN21VNTYzQkkwV1hF?=
 =?utf-8?B?dUhDbVVwYWpHdFpTRXpFQ2hvY0h2VDgrR3BaSUdmUU5wV2tqL0k3U3VMMGM3?=
 =?utf-8?Q?X0+PfLGX6DcHCXfIPxasf3pqp?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e5b3b72a-1d9b-445d-387f-08dc7582e902
X-MS-Exchange-CrossTenant-AuthSource: DS7PR11MB6269.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2024 08:33:49.9901
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BGRAVe8/3tpTkynLdcdm0IlgJj3L8VBCnm4OTPtAbmWxh3MW/LmPJ/Yg9s3o52STURvtr+USVnmTcwl9JY6OIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4889
X-OriginatorOrg: intel.com

On 5/13/2024 10:08 PM, Samuel Ortiz wrote:
> On Mon, May 13, 2024 at 08:03:53AM -0600, James Bottomley wrote:
>> On Mon, 2024-05-13 at 12:16 +0200, Samuel Ortiz wrote:
>>>> However, it struck me you missed a third option: use the ima log
>>>> format.  This has the advantage that we can define additional
>>>> events and have them published with a kernel patch (the IMA log
>>>> format is defined in the kernel).  Thanks to the TCG, it's also CEL
>>>> compatible but doesn't require any sort of TCG blessing of the
>>>> events.  Plus we also have existing kernel infrastructure to log to
>>>> that format.
>>>
>>> That's an interesting idea. It may avoid having to extend the CEL
>>> spec with a new Content Type, but otoh the current spec defines which
>>> IMA events are supported. So adding new ones may require to also
>>> eventually extend the spec. But I guess since IMA is a Linux kernel
>>> subsystem, changing the kernel code and ABI would de-facto extend the
>>> TCG CEL IMA spec.
>>
>> That's what I was assuming since the TCG is currently deferring to IMA
>> in that regard.
>>
>>> Here I assume you're talking about the IMA_TEMPLATE CEL specified
>>> format, which is designed to accomodate for the current kernel IMA
>>> log format. The main drawback of this format is that the digest does
>>> not include the whole content event, making the CEL content type, the
>>> IMA tag name and both lengths (for the content event and the IMA
>>> content) untrusted for event log verifiers.
>>
>> That's only because IMA doesn't yet have such an event.  If we're
>> assuming effectively designing an IMA log format for non repudiation of
>> external events, one can be added.
> 
> If we were to follow the IMA_TEMPLATE format as our output RTMR ABI for
> the event log, adding one or more IMA events would not change the fact
> that the event and content type would not be hashed into the extended
> digest. Unless we want to specify a different behaviour for each IMA
> event, and then verifiers would have interpret the digest construction
> differently depending on the IMA_TEMPLATE nested event type. And that's
> not pretty IMHO.
> 
Agreed. This misses the design objective of separating storage from 
semantics of event records.

> Using the IMA_TLV content type would make that cut cleaner at least. A
> digest is built on the whole content event, for all event types. And the
> content and event types are trusted, i.e. the verifier can securely map
> events to the reported event types.
> 
The numerical T would need to be allocated/tracked by a central 
registry. This won't work for applications designed/developed outside of 
the kernel community, as they won't have a reliable way to avoid 
conflicts with each other. Thus, T needs to be a string, but that 
violates IMA_TLV definition. This is kinda fitting a square peg into a 
round hole IMHO.

>> Although I wouldn't want to be
>> hasty: one of the big problems of all options is that no existing log
>> format really covers the measure container use case and we're not
>> completely sure what other use cases will arise (the firewall rules
>> measurements was one that regulated cloud providers seem to think would
>> be important ... and that has a periodic rush of events, but there will
>> be others).
> 
> Right. A new CEL content type would give us more freedom in that regard,
> as it would allow us to define our own event content value in a more
> flexible way. Instead of the nested TLV approach that IMA_TLV follows,
> having one where the T would be a max length string defining the creator
> of the event (a.k.a. the attester), would avoid having to formally
> define each and every new event. That's where option #2 in the
> presentation was heading to.
> 
Agreed. In fact, the 2 primary design objectives of this event log are 
(1) to separate storage from semantics of event records and (2) to allow 
applications to define custom events and avoid conflicts with each other 
reliably. IMA_TLV meets the 1st objective but misses the 2nd; while 
IMA_TEMPLATE meets the 2nd but misses the 1st. And that's how we came to 
this Option #2.

-Cedric

