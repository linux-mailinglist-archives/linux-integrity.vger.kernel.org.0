Return-Path: <linux-integrity+bounces-9206-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0IN4LpqS4GmsjwAAu9opvQ
	(envelope-from <linux-integrity+bounces-9206-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Thu, 16 Apr 2026 09:41:14 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id F159E40B201
	for <lists+linux-integrity@lfdr.de>; Thu, 16 Apr 2026 09:41:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 073CE301490E
	for <lists+linux-integrity@lfdr.de>; Thu, 16 Apr 2026 07:41:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E01337C907;
	Thu, 16 Apr 2026 07:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FZRc503v"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DBAD346E56
	for <linux-integrity@vger.kernel.org>; Thu, 16 Apr 2026 07:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776325268; cv=fail; b=STCMjr0Vwg8j4Grx5Ty08ERoY0XaaM+TJZ7CvIHQALkHBb6gzoWEY7klNdrcRh3UAxC5cZpDRpXhhhnS0jPculZ31dXEDa9MbxfE1/ke2E9FJnOMJ3tVeZ3SYJz9Xw4jI/6OoNXqDwCozY6JAOJQyAHObmlRu6//F4FMU89H1Zg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776325268; c=relaxed/simple;
	bh=U/zKBWe9UsvgM2K+4V63HusQrYmQjJhEtjxjtfwG2e0=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=rONq3ffOWxo4WZ1m6utMO2TUKAU425AKBxhxVFn0Z2QbXupG+mhn4Zqm8oSGL2DhUU6Gao3o9oaKlGq9PB0BGmxApfhUqUK/HpOSeoIvfIEttH/NcIqUAU9AuRyP1zOKUMWNM6DEcuz2kZeA0t28vrVfqm56d9XkExtZwQ7Ga94=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FZRc503v; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776325267; x=1807861267;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=U/zKBWe9UsvgM2K+4V63HusQrYmQjJhEtjxjtfwG2e0=;
  b=FZRc503vbv3p2lqdlcX5la/+rfjUUAES7jqmmn9BkpYgBFfkpIZ8Bk3J
   eOwR/wwufPSnx/FNzZ5kRPpML0OegkKj5q75uSxCxY7hxMchB7aXyFexV
   PUoivl1qcNwqXNn6ktebCenkFf+EFH7YHmxSuUTo0LwJx5TDyq6V5RvEF
   upI2Pmen9fPv2J3qUeh1PWn2rSbthKhvdQo8/3brnKq95cWtmOO2cCjhI
   hB+fj8Oj04nr1EsailIk24UtUZ8D1lEx0+fZr2SsNt+UG2dcYH9blrEvt
   +WkrVod17aOuf8WvgBDWvPGQE7CMJhz2m23emQ7e2MI06PcbzDH0YBkGC
   Q==;
X-CSE-ConnectionGUID: xCWqfOvoSC+DhxKGTdgy/w==
X-CSE-MsgGUID: dfJJXbRFRWeXmQ1sifeirQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11760"; a="77224057"
X-IronPort-AV: E=Sophos;i="6.23,181,1770624000"; 
   d="scan'208";a="77224057"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2026 00:41:07 -0700
X-CSE-ConnectionGUID: S9veK5YSQvKcIQIR9Kj/xQ==
X-CSE-MsgGUID: rwkKAVi2QEaDgp3IxsfVWQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,181,1770624000"; 
   d="scan'208";a="261086782"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2026 00:41:05 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 16 Apr 2026 00:41:04 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 16 Apr 2026 00:41:04 -0700
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.52) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 16 Apr 2026 00:41:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UfpKT3as8Ee0vryLyJEnCu/IbBLjT06hmqh85hMcG4KyLFNSqD90gm/lmYg7YNoq4bnQ1gyx+EYgcdwGWfrNveH8LmN26qaVCGZzyzEchKZzWWqppNd06glaADx8RsYAHnh+FWo82VHuxwYUftTP4qh5IyHdG5Lz1nnjCsHVmrA6n/oUcRaZ3J0xRDS6Cr2TLehGgHjyIt4GWzfvGzkOMmNHgMgK8Gbx/swvreCsEGrxDTGj7VdiauROs3dbHUu9UQ8ttC9f9gw4duUt3wQI1M/DNMWDZX5qEkRqCxOtAmpw63N5w5nbrPx999/A9cyGOVrSeX142eDGzFTOJVu0wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WVpbgmevEaQv1XNgRuxallakuUERn5ibrEGKL2VBuqM=;
 b=e0FuLA3yFgiyRiQ7Clvxtp2FqmrE1f7KKihgGBAEA3jbSiZrS9SvJlvjyXvwgeLZNL9K4QiTyvk+Fl0pM9ZiEb1Gq91ggiS7ABKxVd6Qy1WPs5tGV2jiCPVyGkaII5xrW6GVRYcn6NNRNiTHgZ/x5EF7tYepP6M5m9JQ6zr7VDZmHcAKxKjRJYbEkahB9zrLyLyPdG08/7BdltOqAYontRRTMbyglO6Dl4VTKDpsVhHFoWTsabjfLA0jfIiJ9QJL8RpIMh1lPgz22la6v8wOSVd1/zTVkEnpqwDd+utJy51UX3YFWAUe9Bp6na2/hExXPxMfgSGqWCxYxrq5lk5CRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB5832.namprd11.prod.outlook.com (2603:10b6:510:141::7)
 by DM6PR11MB4578.namprd11.prod.outlook.com (2603:10b6:5:2a7::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.48; Thu, 16 Apr
 2026 07:41:00 +0000
Received: from PH0PR11MB5832.namprd11.prod.outlook.com
 ([fe80::106e:78dd:4c96:d707]) by PH0PR11MB5832.namprd11.prod.outlook.com
 ([fe80::106e:78dd:4c96:d707%3]) with mapi id 15.20.9818.017; Thu, 16 Apr 2026
 07:41:00 +0000
Date: Thu, 16 Apr 2026 15:40:53 +0800
From: Oliver Sang <oliver.sang@intel.com>
To: Petr Vorel <pvorel@suse.cz>
CC: =?utf-8?Q?Micha=C5=82?= Grzelak <michal.grzelak@intel.com>,
	<lkp@intel.com>, <intel-gfx@lists.freedesktop.org>, Jani Nikula
	<jani.nikula@linux.intel.com>, <oe-lkp@lists.linux.dev>,
	<intel-xe@lists.freedesktop.org>, <ltp@lists.linux.it>,
	<linux-integrity@vger.kernel.org>, Mimi Zohar <zohar@linux.ibm.com>,
	<oliver.sang@intel.com>
Subject: Re: [LTP] [PATCH v1 15/16] drm/i915/bios: search for VBT #57 by
 default
Message-ID: <aeCShTeoW+lmHjHF@xsang-OptiPlex-9020>
References: <20260331183332.1773886-16-michal.grzelak@intel.com>
 <202604150702.d409a2b6-lkp@intel.com>
 <20260416064051.GA281695@pevik>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260416064051.GA281695@pevik>
X-ClientProxiedBy: TPYP295CA0043.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:7d0:7::11) To PH0PR11MB5832.namprd11.prod.outlook.com
 (2603:10b6:510:141::7)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB5832:EE_|DM6PR11MB4578:EE_
X-MS-Office365-Filtering-Correlation-Id: 25789160-6895-4afe-1e80-08de9b8b80ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: 5MK3psunPu2DMT95HYj5HK+kGX0PcClD800cDFGnbn6tsi9PVvHKpr4qzSIFi0kJVVuILNoCYpm1XnNYduhQt01jxOas3rTtJIkqSDGgd8ns4FxwDMKcFUMrz8Ay2ZCau32pdL2v+eMn7Lmo7wqM73jSTPMLWZixOtUYi9wHXKg3VGrFRfNILhYqAXY6BWngslZPgqVRrwl+6dOvWtx4B7+KzNJkLGDbyaiCOiS8HHrQ16WaS/J4KVHT4u0xH4wZVOR/C/C4nlFSlHPerl4ONGYbP0/xEvWG9WtACMj1NdHG9oCB4plh8F17dq/s7FZlxKXraBF/vKDwYF3Jdm+1HurVSssNAKDTZZUb7DfAHdDooTeVVdR7FyiCwBsYPg3jxsswCnZeeqFrtQmk5wTFoUoA8IOTWOwtnR4aGe0spp5upYQQ+CGTfFmgPhRBUl4x2rwBpnRxNx0ahWKuNVG9dNmROqIBgVRXDN6qtKZAurGItaqpM61jFOrTzpycCP/fP7ehG/zoJcG2xFPAluq+4WcAYgpWVkOoTI726Ix19dwWthwf5llXgyX4yayMTHp287dfBuPwJk8j/B9sjK6inE1TgEwgFlOoFFwvvJE1IYnvaF0KjWp4r13uWidJ1JTQj/M9AVeYbxy8eZrXn323JrgjhixbWAzP6esytoVWm52qtetDWqCXR1jCyl+nHajd
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5832.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?f1pciagU4NqU2WVN9+a9gfH5NRL1sOht6bGexo1r1nhiT9cE2Kb8m2gjZG72?=
 =?us-ascii?Q?FmdX8qwLhHCKAQgjDhTo5TmuIKjDq/XWU9B6cKC5EDCOMKacZVePuncvgcT4?=
 =?us-ascii?Q?PQP/91WyOSvptyqQt9Ff0gX2mtkXApR1o+JWbmSaAkg2c6LC8jSlmD5UKwYk?=
 =?us-ascii?Q?17AJlp1EMztWsjtwN1AXGm5dGtsp/qsuE3pDqMqNTel+4G7lcVLi6vVTpr6l?=
 =?us-ascii?Q?qEjVUFvUa9tg6XWeK3jb9q+FqYf9Yg/N35cmectkNqP+6QYoUvmplTUDNWPJ?=
 =?us-ascii?Q?gmnk0E2Af0YpVOgDpAETQiYvpzFmoXBxnN8TgJG6HRu1i8kCOR7YCxYyAu5M?=
 =?us-ascii?Q?TVKoNUuvJzQP4ZunLGqKufoiIljLV0rhJwKQJYGsoSbI1/ZABcJwjwTkaDSV?=
 =?us-ascii?Q?Ffi1Rx3lxbkHGfP91gC2Tw6UXouiqH1gI8QQwnQb3rxd7bLzkvSRNJI6pqc2?=
 =?us-ascii?Q?M2C1xtJ/saqioB7EwKlxlApIIaVz5IunXle+3P0IyGbCz1MV7A/Ocnwo2BDF?=
 =?us-ascii?Q?SdZr+NgjmDj8ly7QBOeVZOqu7W3gJyTEbOzZtuY2LtUS3idMJ7ox21rdD0hF?=
 =?us-ascii?Q?TR2clFqO/WP7Abs/b9ZVfcTgHK3HPy7Spn6gu1A6sRl8AKiqsMekLZYcote2?=
 =?us-ascii?Q?TRPeT5Ou1yxEc7Hu9P+stdyTxr/BTnfh5/KF4mOkKWzxsuQAUbcGLd8jQ6M4?=
 =?us-ascii?Q?73jgGE+RrCUexpHyk3EuFadrO9lk/wBTS6tO66rbTEGQPbeD3709p9C3HcvU?=
 =?us-ascii?Q?9FXmRvDqkLP3dJFwochiz3HXgLSTdahl1r+GtyNtJ1wL7XKeZXn8qdjPI4kq?=
 =?us-ascii?Q?UWAX7h6ZRJWdmmonEOigqd8II/AzwfyqMm7up6KW/yy5nt4VU8kM4tMhSg3z?=
 =?us-ascii?Q?W0TLcgStcXyduwpbwQU7o+UQlXCXy1i5qtNVt1m2+cCRsz6fXAiS7yB87nni?=
 =?us-ascii?Q?s0k4sodWd7MAzKHb3Qsbzt+U53Wh1lPEPqXY6/8jlfXxBBpqLdU3qD3W3e0O?=
 =?us-ascii?Q?2ZFhZ1hADr8r1IE8JohAc8cknVzcUF2GBwtAoZ26eUjOsHg+PcO9PnA+eODZ?=
 =?us-ascii?Q?mtXh3cBeGlIcK6sNN3iSThkP9GpG0OG2EemUSSgnbGNyOKlWnXwHlhsjKNfL?=
 =?us-ascii?Q?ZNMiY6Xa0W/ldVv04ny+ADtgUziJzQOAQWKKonweBB569N4yf14EX2ObkZhV?=
 =?us-ascii?Q?f89AeUdO8zAcWPEp+RzW7eCm6p5g1zq7C4MGgKjRXy87mnVkqkbg78yUzWK1?=
 =?us-ascii?Q?37Y0sowY2AXWOIRXmxCgY1t/7+61fn0W6ZUheJRRutCjcrDDizx2IQGVHbpX?=
 =?us-ascii?Q?6H7UbLR27Uz/q2uiC0Uzm0DPPTqXdEEFYoWGT1FmDpsmAgF1f1pYbBDLDzgL?=
 =?us-ascii?Q?iQQETKz8X7M5c0K0HoVBv+c6TtoFR3VkaBQeTZ1BQgVhSHGKp1uV7P4Y7H8J?=
 =?us-ascii?Q?MVLCufJcQgZqzFMyINgeb6yrzp4hLW4zMXOAO6rRvbBeBszSe8LXRgWKECmu?=
 =?us-ascii?Q?oIxQZH/F6QHzTR0L8KHcBXzNfGA5stQtqBhakbZgFPIq33jpx5Be6K2ePrq4?=
 =?us-ascii?Q?aC9Gdv2OQJU0Vh3YGnAa2JCt5WpTE1Qt+XEzM1W5sunzT44zMNhXE4jK9uql?=
 =?us-ascii?Q?Ykz9XucoVyisVdihS1uLoizm16nsNdqlVq7weT9MohEgNhNAAJ2RS2Ne/WbB?=
 =?us-ascii?Q?aEq+ipLMJsPE9DQZi8eJ/7EmolVCPQCcDzSvv5kwOdHao9PIO+QgJadcfpZL?=
 =?us-ascii?Q?DviCyFSMGQ=3D=3D?=
X-Exchange-RoutingPolicyChecked: liB0O6w2S+/ykpwf4I17e4wnwNBDuHnIrdHWG7ffYAIqsBkH40Puc6hTFSBz0zwkKegiiz0plfpM5bAR/KUkVrCiDzg5Fy1OJaPelpv4STQ9T+Uq6rz4q/KCoDGAxVU7ayeyonyc4cBhvGxs/M6L8NpNshjCPgo3RUbAOW2acpTe9Sk5l3bfViGNPxHy0zpO2T3mFMzawNeiY2bxR08WqPwBZDISl2/nj1NbVnJZS7LECAXqVW4+RRCOkYgLBlensfTqwDhinuaYswDnWN3on3nYqo5JmN/lGa7YXr1ZIOMFwPKQCWeZIpl9nW7CE2GyM/z2eCKAkKbrNVWJftCJDQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 25789160-6895-4afe-1e80-08de9b8b80ff
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5832.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2026 07:41:00.1510
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uyT+VciXLuvWt42D66vzdKzvSUg3KzTwpD47j7iNQpbuI9Uqw6xZxIpfdVhZ5oUQ2zKW8ziIQyooIMfslSESBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4578
X-OriginatorOrg: intel.com
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	ASN_FAIL(0.00)[4.211.64.104.asn.rspamd.com:server fail];
	TAGGED_FROM(0.00)[bounces-9206-lists,linux-integrity=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_SEVEN(0.00)[10];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[oliver.sang@intel.com,linux-integrity@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-integrity];
	RCPT_COUNT_SEVEN(0.00)[11];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,gitlab.freedesktop.org:url,01.org:url]
X-Rspamd-Queue-Id: F159E40B201
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

hi, Petr,

On Thu, Apr 16, 2026 at 08:40:51AM +0200, Petr Vorel wrote:
> Hi all,
> 
> [ Cc Mimi and linux-integrity ]
> > Hello,
> 
> > kernel test robot noticed "BUG:KASAN:slab-out-of-bounds_in_parse_vswing_preemph_snps" on:
> 
> > commit: 07d1ee54da4966c1457602dc088a8a43b29254cb ("[PATCH v1 15/16] drm/i915/bios: search for VBT #57 by default")
> > url: https://github.com/intel-lab-lkp/linux/commits/Micha-Grzelak/drm-i915-lt-align-xe3plpd-with-VS-PE-Override-layout/20260401-092928
> > base: https://gitlab.freedesktop.org/drm/i915/kernel.git for-linux-next
> > patch link: https://lore.kernel.org/all/20260331183332.1773886-16-michal.grzelak@intel.com/
> > patch subject: [PATCH v1 15/16] drm/i915/bios: search for VBT #57 by default
> 
> > in testcase: ltp
> > version: 
> > with following parameters:
> 
> > 	test: ima
> 
> 
> 
> > config: x86_64-rhel-9.4-ltp
> > compiler: gcc-14
> > test machine: 22 threads 1 sockets Intel(R) Core(TM) Ultra 9 185H @ 4.5GHz (Meteor Lake) with 32G memory
> 
> > (please refer to attached dmesg/kmsg for entire log/backtrace)
> 
> 
> 
> > If you fix the issue in a separate patch/commit (i.e. not just a new version of
> > the same patch/commit), kindly add following tags
> > | Reported-by: kernel test robot <oliver.sang@intel.com>
> > | Closes: https://lore.kernel.org/oe-lkp/202604150702.d409a2b6-lkp@intel.com
> 
> 
> > The kernel config and materials to reproduce are available at:
> > https://download.01.org/0day-ci/archive/20260415/202604150702.d409a2b6-lkp@intel.com
> 
> 
> > kern  :err   : [   27.966990] [    T399] ==================================================================
> > kern  :err   : [   27.968126] [    T399] BUG: KASAN: slab-out-of-bounds in parse_vswing_preemph_snps+0x2dd/0x430 [i915]
> > kern  :err   : [   27.969712] [    T399] Read of size 4 at addr ffff8881eba2c49d by task (udev-worker)/399
> 
> > kern  :err   : [   27.971135] [    T399] CPU: 4 UID: 0 PID: 399 Comm: (udev-worker) Tainted: G S                  7.0.0-rc4-01496-g07d1ee54da49 #1 PREEMPT(lazy) 
> > kern  :err   : [   27.971139] [    T399] Tainted: [S]=CPU_OUT_OF_SPEC
> > kern  :err   : [   27.971140] [    T399] Hardware name: ASUSTeK COMPUTER INC. NUC14RVS-B/NUC14RVSU9, BIOS RVMTL357.0047.2025.0108.1408 01/08/2025
> > kern  :err   : [   27.971142] [    T399] Call Trace:
> > kern  :err   : [   27.971144] [    T399]  <TASK>
> > kern  :err   : [   27.971145] [    T399]  dump_stack_lvl+0x47/0x70
> > kern  :err   : [   27.971152] [    T399]  print_address_description+0x88/0x320
> > kern  :err   : [   27.971156] [    T399]  ? parse_vswing_preemph_snps+0x2dd/0x430 [i915]
> > kern  :err   : [   27.971355] [    T399]  print_report+0x106/0x1f4
> > kern  :err   : [   27.971357] [    T399]  ? __virt_addr_valid+0xc4/0x230
> > kern  :err   : [   27.971360] [    T399]  ? parse_vswing_preemph_snps+0x2dd/0x430 [i915]
> > kern  :err   : [   27.971533] [    T399]  kasan_report+0xb5/0xf0
> > kern  :err   : [   27.971537] [    T399]  ? parse_vswing_preemph_snps+0x2dd/0x430 [i915]
> > kern  :err   : [   27.971704] [    T399]  parse_vswing_preemph_snps+0x2dd/0x430 [i915]
> > kern  :err   : [   27.971868] [    T399]  intel_bios_init+0xcc1/0x14b0 [i915]
> > kern  :err   : [   27.972042] [    T399]  ? drm_vblank_init+0x147/0x330 [drm]
> > kern  :err   : [   27.972105] [    T399]  intel_display_driver_probe_noirq+0x8d/0x870 [i915]
> > kern  :err   : [   27.972295] [    T399]  i915_driver_probe+0x209/0x9f0 [i915]
> > kern  :err   : [   27.972445] [    T399]  ? __pfx_mutex_lock+0x10/0x10
> > kern  :err   : [   27.972450] [    T399]  ? mutex_lock+0x91/0xf0
> > kern  :err   : [   27.972451] [    T399]  ? __pfx_i915_driver_probe+0x10/0x10 [i915]
> > kern  :err   : [   27.972597] [    T399]  ? drm_privacy_screen_get+0x2bf/0x370 [drm]
> > kern  :err   : [   27.972628] [    T399]  ? intel_display_driver_probe_defer+0x41/0x70 [i915]
> > kern  :err   : [   27.972814] [    T399]  ? i915_pci_probe+0x2ab/0x3b0 [i915]
> > kern  :err   : [   27.972963] [    T399]  ? __pfx_i915_pci_probe+0x10/0x10 [i915]
> > kern  :err   : [   27.973110] [    T399]  local_pci_probe+0xdb/0x1b0
> > kern  :err   : [   27.973114] [    T399]  pci_call_probe+0x153/0x4f0
> > kern  :err   : [   27.973116] [    T399]  ? __pfx_pci_call_probe+0x10/0x10
> > kern  :err   : [   27.973117] [    T399]  ? __pfx__raw_spin_lock+0x10/0x10
> > kern  :err   : [   27.973119] [    T399]  ? pci_assign_irq+0x80/0x2f0
> > kern  :err   : [   27.973121] [    T399]  ? pci_match_device+0x38d/0x6b0
> > kern  :err   : [   27.973123] [    T399]  ? kernfs_create_link+0x164/0x230
> > kern  :err   : [   27.973127] [    T399]  pci_device_probe+0x173/0x2f0
> > kern  :err   : [   27.973128] [    T399]  call_driver_probe+0x62/0x1f0
> > kern  :err   : [   27.973132] [    T399]  really_probe+0x197/0x770
> > kern  :err   : [   27.973134] [    T399]  __driver_probe_device+0x18c/0x3b0
> > kern  :err   : [   27.973137] [    T399]  driver_probe_device+0x4a/0x130
> > kern  :err   : [   27.973139] [    T399]  __driver_attach+0x18c/0x4f0
> > kern  :err   : [   27.973141] [    T399]  ? __pfx___driver_attach+0x10/0x10
> > kern  :err   : [   27.973143] [    T399]  bus_for_each_dev+0xef/0x170
> > kern  :err   : [   27.973145] [    T399]  ? kasan_unpoison+0x40/0x70
> > kern  :err   : [   27.973147] [    T399]  ? __pfx_bus_for_each_dev+0x10/0x10
> > kern  :err   : [   27.973149] [    T399]  ? __kasan_slab_alloc+0x2f/0x70
> > kern  :err   : [   27.973152] [    T399]  ? klist_add_tail+0x132/0x270
> > kern  :err   : [   27.973154] [    T399]  bus_add_driver+0x2a7/0x4f0
> > kern  :err   : [   27.973156] [    T399]  driver_register+0x1a1/0x370
> > kern  :err   : [   27.973158] [    T399]  i915_init+0x57/0x160 [i915]
> > kern  :err   : [   27.973307] [    T399]  ? __pfx_i915_init+0x10/0x10 [i915]
> > kern  :err   : [   27.973453] [    T399]  do_one_initcall+0x8d/0x3f0
> > kern  :err   : [   27.973455] [    T399]  ? __pfx_do_one_initcall+0x10/0x10
> > kern  :err   : [   27.973457] [    T399]  ? kasan_unpoison+0x3b/0x70
> > kern  :err   : [   27.973458] [    T399]  ? kasan_unpoison+0x40/0x70
> > kern  :err   : [   27.973460] [    T399]  do_init_module+0x281/0x830
> > kern  :err   : [   27.973463] [    T399]  ? __pfx_do_init_module+0x10/0x10
> > kern  :err   : [   27.973464] [    T399]  ? kfree+0x195/0x430
> > kern  :err   : [   27.973467] [    T399]  load_module+0x173d/0x2070
> > kern  :err   : [   27.973469] [    T399]  ? ima_post_read_file+0x18f/0x230
> 
> I'm surprised, but indeed it's could be triggered by IMA.
> 
> Looking at full dmesg [1] I'm surprised that this is triggered before tests are
> actually run and there is no IMA specific kernel command line parameter. That
> means that error is not related to any LTP test.
> 
> Is it always reproducible or just a random glitch?

in our tests, it's quite persistent and clean on parent:

=========================================================================================
tbox_group/testcase/rootfs/kconfig/compiler/test:
  igk-mtl-nuc02/ltp/debian-13-x86_64-20250902.cgz/x86_64-rhel-9.4-ltp/gcc-14/ima

e3d53a63657f3213 07d1ee54da4966c1457602dc088
---------------- ---------------------------
       fail:runs  %reproduction    fail:runs
           |             |             |
           :6          100%           6:6     dmesg.BUG:KASAN:slab-out-of-bounds_in_parse_vswing_preemph_snps


> 
> ima_post_read_file() is a part of IMA core therefore issue might be not related
> to any config, but just FYI kernel config [2].
> 
> Kind regards,
> Petr
> 
> [1] https://download.01.org/0day-ci/archive/20260415/202604150702.d409a2b6-lkp@intel.com/kmsg.xz
> [2] https://download.01.org/0day-ci/archive/20260415/202604150702.d409a2b6-lkp@intel.com/config-7.0.0-rc4-01496-g07d1ee54da49
> 
> > kern  :err   : [   27.973474] [    T399]  ? __pfx_load_module+0x10/0x10
> > kern  :err   : [   27.973476] [    T399]  ? security_kernel_post_read_file+0x35/0xf0
> > kern  :err   : [   27.973479] [    T399]  ? __pfx_kernel_read_file+0x10/0x10
> > kern  :err   : [   27.973483] [    T399]  ? __pfx_current_time+0x10/0x10
> > kern  :err   : [   27.973486] [    T399]  ? init_module_from_file+0x157/0x1b0
> > kern  :err   : [   27.973487] [    T399]  init_module_from_file+0x157/0x1b0
> > kern  :err   : [   27.973489] [    T399]  ? __pfx_init_module_from_file+0x10/0x10
> > kern  :err   : [   27.973491] [    T399]  ? touch_atime+0x1bc/0x4f0
> > kern  :err   : [   27.973493] [    T399]  ? _raw_spin_lock+0x80/0xf0
> > kern  :err   : [   27.973494] [    T399]  ? __pfx__raw_spin_lock+0x10/0x10
> > kern  :err   : [   27.973496] [    T399]  ? __pfx_filemap_read+0x10/0x10
> > kern  :err   : [   27.973498] [    T399]  ? do_sys_openat2+0xeb/0x170
> > kern  :err   : [   27.973501] [    T399]  idempotent_init_module+0x21c/0x770
> > kern  :err   : [   27.973503] [    T399]  ? __pfx_idempotent_init_module+0x10/0x10
> > kern  :err   : [   27.973505] [    T399]  ? fdget+0x54/0x3b0
> > kern  :err   : [   27.973506] [    T399]  ? security_capable+0x35/0xf0
> > kern  :err   : [   27.973509] [    T399]  __x64_sys_finit_module+0xca/0x170
> > kern  :err   : [   27.973511] [    T399]  do_syscall_64+0x108/0x5b0
> > kern  :err   : [   27.973513] [    T399]  ? vfs_read+0x3be/0x9b0
> > kern  :err   : [   27.973514] [    T399]  ? vfs_read+0x3be/0x9b0
> > kern  :err   : [   27.973516] [    T399]  ? __pfx_vfs_read+0x10/0x10
> > kern  :err   : [   27.973517] [    T399]  ? __pfx__raw_spin_lock+0x10/0x10
> > kern  :err   : [   27.973519] [    T399]  ? fdget+0x54/0x3b0
> > kern  :err   : [   27.973520] [    T399]  ? __pfx___seccomp_filter+0x10/0x10
> > kern  :err   : [   27.973523] [    T399]  ? __x64_sys_pread64+0x18d/0x1f0
> > kern  :err   : [   27.973525] [    T399]  ? __pfx___x64_sys_pread64+0x10/0x10
> > kern  :err   : [   27.973526] [    T399]  ? fdget+0x54/0x3b0
> > kern  :err   : [   27.973528] [    T399]  ? security_capable+0x35/0xf0
> > kern  :err   : [   27.973530] [    T399]  ? do_syscall_64+0x140/0x5b0
> > kern  :err   : [   27.973531] [    T399]  ? arch_exit_to_user_mode_prepare+0x9e/0xf0
> > kern  :err   : [   27.973533] [    T399]  ? do_syscall_64+0x140/0x5b0
> > kern  :err   : [   27.973534] [    T399]  ? __x64_sys_openat+0x104/0x1f0
> > kern  :err   : [   27.973536] [    T399]  ? __pfx___x64_sys_openat+0x10/0x10
> > kern  :err   : [   27.973538] [    T399]  ? do_syscall_64+0x140/0x5b0
> > kern  :err   : [   27.973540] [    T399]  ? do_syscall_64+0x140/0x5b0
> > kern  :err   : [   27.973541] [    T399]  ? irqentry_exit+0x76/0x4f0
> > kern  :err   : [   27.973544] [    T399]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> > kern  :err   : [   27.973546] [    T399] RIP: 0033:0x7f3689aa8779
> > kern  :err   : [   27.973549] [    T399] Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 67 76 0d 00 f7 d8 64 89 01 48
> > kern  :err   : [   27.973551] [    T399] RSP: 002b:00007ffca3326338 EFLAGS: 00000246 ORIG_RAX: 0000000000000139
> > kern  :err   : [   27.973555] [    T399] RAX: ffffffffffffffda RBX: 000055c94afdd3e0 RCX: 00007f3689aa8779
> > kern  :err   : [   27.973556] [    T399] RDX: 0000000000000000 RSI: 00007f36882ae44d RDI: 0000000000000053
> > kern  :err   : [   27.973557] [    T399] RBP: 0000000000000000 R08: 0000000000000000 R09: 000055c94af65b30
> > kern  :err   : [   27.973558] [    T399] R10: 0000000000000000 R11: 0000000000000246 R12: 00007f36882ae44d
> > kern  :err   : [   27.973559] [    T399] R13: 0000000000020000 R14: 000055c94afb65f0 R15: 0000000000000000
> > kern  :err   : [   27.973561] [    T399]  </TASK>
> 
> > kern  :err   : [   28.051757] [    T399] Allocated by task 399:
> > kern  :warn  : [   28.052350] [    T399]  kasan_save_stack+0x1e/0x70
> > kern  :warn  : [   28.053001] [    T399]  kasan_save_track+0x10/0x30
> > kern  :warn  : [   28.053646] [    T399]  __kasan_kmalloc+0x8b/0xb0
> > kern  :warn  : [   28.054278] [    T399]  __kmalloc_noprof+0x1d8/0x5f0
> > kern  :warn  : [   28.054944] [    T399]  init_bdb_block+0x128/0xc30 [i915]
> > kern  :warn  : [   28.055915] [    T399]  intel_bios_init+0x4de/0x14b0 [i915]
> > kern  :warn  : [   28.056854] [    T399]  intel_display_driver_probe_noirq+0x8d/0x870 [i915]
> > kern  :warn  : [   28.057984] [    T399]  i915_driver_probe+0x209/0x9f0 [i915]
> > kern  :warn  : [   28.058917] [    T399]  local_pci_probe+0xdb/0x1b0
> > kern  :warn  : [   28.059565] [    T399]  pci_call_probe+0x153/0x4f0
> > kern  :warn  : [   28.060210] [    T399]  pci_device_probe+0x173/0x2f0
> > kern  :warn  : [   28.060878] [    T399]  call_driver_probe+0x62/0x1f0
> > kern  :warn  : [   28.061547] [    T399]  really_probe+0x197/0x770
> > kern  :warn  : [   28.062168] [    T399]  __driver_probe_device+0x18c/0x3b0
> > kern  :warn  : [   28.062894] [    T399]  driver_probe_device+0x4a/0x130
> > kern  :warn  : [   28.063587] [    T399]  __driver_attach+0x18c/0x4f0
> > kern  :warn  : [   28.064243] [    T399]  bus_for_each_dev+0xef/0x170
> > kern  :warn  : [   28.064898] [    T399]  bus_add_driver+0x2a7/0x4f0
> > kern  :warn  : [   28.065543] [    T399]  driver_register+0x1a1/0x370
> > kern  :warn  : [   28.066202] [    T399]  i915_init+0x57/0x160 [i915]
> > kern  :warn  : [   28.067030] [    T399]  do_one_initcall+0x8d/0x3f0
> > kern  :warn  : [   28.067677] [    T399]  do_init_module+0x281/0x830
> > kern  :warn  : [   28.068320] [    T399]  load_module+0x173d/0x2070
> > kern  :warn  : [   28.068951] [    T399]  init_module_from_file+0x157/0x1b0
> > kern  :warn  : [   28.069678] [    T399]  idempotent_init_module+0x21c/0x770
> > kern  :warn  : [   28.070417] [    T399]  __x64_sys_finit_module+0xca/0x170
> > kern  :warn  : [   28.071143] [    T399]  do_syscall_64+0x108/0x5b0
> > kern  :warn  : [   28.071777] [    T399]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> 
> > kern  :err   : [   28.072915] [    T399] The buggy address belongs to the object at ffff8881eba2c000
> >                                           which belongs to the cache kmalloc-2k of size 2048
> > kern  :err   : [   28.074832] [    T399] The buggy address is located 0 bytes to the right of
> >                                           allocated 1181-byte region [ffff8881eba2c000, ffff8881eba2c49d)
> 
> > kern  :err   : [   28.077135] [    T399] The buggy address belongs to the physical page:
> > kern  :warn  : [   28.078017] [    T399] page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x1eba28
> > kern  :warn  : [   28.079226] [    T399] head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
> > kern  :warn  : [   28.080389] [    T399] flags: 0x17ffffc0000040(head|node=0|zone=2|lastcpupid=0x1fffff)
> > kern  :warn  : [   28.081460] [    T399] page_type: f5(slab)
> > kern  :warn  : [   28.082008] [    T399] raw: 0017ffffc0000040 ffff888100042f00 dead000000000100 dead000000000122
> > kern  :warn  : [   28.083180] [    T399] raw: 0000000000000000 0000000800080008 00000000f5000000 0000000000000000
> > kern  :warn  : [   28.084355] [    T399] head: 0017ffffc0000040 ffff888100042f00 dead000000000100 dead000000000122
> > kern  :warn  : [   28.085541] [    T399] head: 0000000000000000 0000000800080008 00000000f5000000 0000000000000000
> > kern  :warn  : [   28.086725] [    T399] head: 0017ffffc0000003 ffffea0007ae8a01 00000000ffffffff 00000000ffffffff
> > kern  :warn  : [   28.087909] [    T399] head: ffffffffffffffff 0000000000000000 00000000ffffffff 0000000000000008
> > kern  :warn  : [   28.089093] [    T399] page dumped because: kasan: bad access detected
> 
> > kern  :err   : [   28.090297] [    T399] Memory state around the buggy address:
> > kern  :err   : [   28.091073] [    T399]  ffff8881eba2c380: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> > kern  :err   : [   28.092175] [    T399]  ffff8881eba2c400: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> > kern  :err   : [   28.093276] [    T399] >ffff8881eba2c480: 00 00 00 05 fc fc fc fc fc fc fc fc fc fc fc fc
> > kern  :err   : [   28.094376] [    T399]                             ^
> > kern  :err   : [   28.095041] [    T399]  ffff8881eba2c500: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
> > kern  :err   : [   28.096145] [    T399]  ffff8881eba2c580: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
> > kern  :err   : [   28.097247] [    T399] ==================================================================
> > kern  :warn  : [   28.098668] [    T399] Disabling lock debugging due to kernel taint

