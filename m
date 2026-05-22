Return-Path: <linux-integrity+bounces-9632-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aH3+FhXwD2omRgYAu9opvQ
	(envelope-from <linux-integrity+bounces-9632-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Fri, 22 May 2026 07:56:37 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 529E45AF4D4
	for <lists+linux-integrity@lfdr.de>; Fri, 22 May 2026 07:56:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B7661301063D
	for <lists+linux-integrity@lfdr.de>; Fri, 22 May 2026 05:56:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C37AC3A48F0;
	Fri, 22 May 2026 05:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eDCkGRU6"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 735E5392C57;
	Fri, 22 May 2026 05:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779429394; cv=fail; b=gQWokTWy8h7mCC+9y7imDCI6g8x614inOLpVslSPwJ7Eui7dgo1jj8Rm3myYsMIKj2zhtF/KhOdIwKw9t1Vln2tJKHmWiIy4LIqKiMvEgEQwmU5kODTeATVAKe658ixF/2Hocl9r90LlFJgBP5pJlY1PhLjKOwpd23O77pNAU0I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779429394; c=relaxed/simple;
	bh=QxD741jcWj7IelqttWwErgbMHi71RS0bSe3e2Vo6BrU=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=g+lEviXSUtZpepHuK1+El4RPBjhy6PrnVagYn0YYpceKoAS08o367y4wV8PFqf/8y3QrJsLCLG1WWA6mcpSEATRTty12tFPlMhpPAOdTM7W3aryveLLKg99rS8Phyke6db+Ls0qFt+oRLsqKpfBOUkzMM36JsuEU+nn6t/hCa4Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eDCkGRU6; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779429391; x=1810965391;
  h=from:to:cc:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=QxD741jcWj7IelqttWwErgbMHi71RS0bSe3e2Vo6BrU=;
  b=eDCkGRU65wICDgdfX7FcVzJRSgznXGnldYZUT3WSXqFPvPeN9wwx0VgG
   iJXS5sQ26sqR0vxQ1p76iAjvItu94wa33GgTDUT12wkrIzZ4SQ6JgkdVo
   WQokSlQ6Rj5LnF74OTb81e67PqmdMOh/nF4e33pVW6x/98i3+1DrFCmup
   XB+w+zqrjyAyE/KwBvkeOKsuPVnEooI0mdR21/JbUXwTfKSAobMEKccrp
   +w0hPBvDcSN5+XK+tKK+NpcEKixZkja0xe3Qv1bQGHyR4wEzuilFUfIGW
   gfUTwAH2A1VTasJYF+QGbGotOU9OchPkIHSxOUItarXrgILEbiEjjGfCt
   w==;
X-CSE-ConnectionGUID: jtiE0AYjTTqtc9E8tQpNNQ==
X-CSE-MsgGUID: K7G8J8eqQc+u/yMtuAFWsw==
X-IronPort-AV: E=McAfee;i="6800,10657,11793"; a="105820875"
X-IronPort-AV: E=Sophos;i="6.24,161,1774335600"; 
   d="scan'208";a="105820875"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2026 22:56:30 -0700
X-CSE-ConnectionGUID: aUD+gGE8SNaT96+FcTOPsg==
X-CSE-MsgGUID: s75t/VTpQ/CFWr3Dl9aOWw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,161,1774335600"; 
   d="scan'208";a="241049277"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2026 22:56:30 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 21 May 2026 22:56:29 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 21 May 2026 22:56:29 -0700
Received: from BN8PR05CU002.outbound.protection.outlook.com (52.101.57.66) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 21 May 2026 22:56:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m6AGNfBrI80IV+R8SN0Cb7bGpfu0fS8VMu6f0Ys3G7yXD0Ty8WW7GOr6uUGJzT8g50IYEiJwH4iaMjKPKQOKLpnnE0aS3mQcGgzLeSJ5wHkJfr1wV0lC4p+NMPylA3X7Am4gA5gKVwKjHtX1aY+laWYgYXImy0n8epBv85rOhpzLI5UZ44Sn4E5KetAPztEBtlmZXawQ2yIWLmdKC9bZSyFJX8H6D/FTnVntmd4mMYWy4uN7je/Q0VD1B6zhUrES6huLYV//eIt/ku/EnqJ1KDIz0paSMCd5uQDqzg5xGXxQhiCvXyiJnyywLrfjcJMg0Sqdg+9LrauwT+0GHKttuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QxD741jcWj7IelqttWwErgbMHi71RS0bSe3e2Vo6BrU=;
 b=HoQeFSUvVscuDgjryJdB5E9UX65fDV/wahPvx9sD/r7bpFD4iEFq9DuQWfs8uZG1x/6ovqYWBxZwcuXHSqnjcM2ZI0pH6bzcyxSr1G/+xjF1fhVkIgoIRgqzgljZfjhKocgj+LFRtPSQV4raSGvzGQOr0d0TaWBFrSFoBbf2RbKBTWTwNtdumFPwU0X3aR2wGKfgiD4FuuHqxyhlE8AL5nn2kytyFV7ydE0z6Uroqm/amoh2cjnV/VNnJh4VROXChKER+RFTpJTmQ6vspsT8c20dVgrEyYnNq4mAr3nOfB8bVKNBLwPfRyO1GYRbtrqujwbipGcMfwmSrC4lxP+aNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA1PR11MB9495.namprd11.prod.outlook.com (2603:10b6:208:59f::17)
 by CH3PR11MB8384.namprd11.prod.outlook.com (2603:10b6:610:176::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.23; Fri, 22 May
 2026 05:56:25 +0000
Received: from IA1PR11MB9495.namprd11.prod.outlook.com
 ([fe80::7e17:f6fb:7cf6:aa44]) by IA1PR11MB9495.namprd11.prod.outlook.com
 ([fe80::7e17:f6fb:7cf6:aa44%3]) with mapi id 15.21.0048.016; Fri, 22 May 2026
 05:56:25 +0000
From: "Reshetova, Elena" <elena.reshetova@intel.com>
To: "linux-security-module@vger.kernel.org"
	<linux-security-module@vger.kernel.org>
CC: Linux Security Summit Program Committee
	<lss-pc@lists.linuxfoundation.org>, Friend <linux-kernel@vger.kernel.org>,
	"linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
	"lwn@lwn.net" <lwn@lwn.net>, "linux-crypto@vger.kernel.org"
	<linux-crypto@vger.kernel.org>, "keyrings@vger.kernel.org"
	<keyrings@vger.kernel.org>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>, "kernel-hardening@lists.openwall.com"
	<kernel-hardening@lists.openwall.com>
Subject: [ANN] Linux Security Summit Europe 2026 CfP
Thread-Topic: [ANN] Linux Security Summit Europe 2026 CfP
Thread-Index: AdzpruMcxMQ6EdupQQuBXtRrmOF66A==
Date: Fri, 22 May 2026 05:56:25 +0000
Message-ID: <IA1PR11MB94953FF344D75F9634A4F7C1E70F2@IA1PR11MB9495.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR11MB9495:EE_|CH3PR11MB8384:EE_
x-ms-office365-filtering-correlation-id: 3171fa55-c99a-4f6c-beed-08deb7c6dbeb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|10070799003|366016|1800799024|376014|56012099003|38070700021|11063799006|18002099003|6133799003;
x-microsoft-antispam-message-info: J14SDIjEYv2ZDW14IdABWGkMLS4tuxui6jNDWVJTP/uFew3W7mx99VCDracgRVooVMc3WEvZRFAx0G4zkalIGK2AasesSjdl1KWd9Hz3QoJelKmoTB1TQopbqpU/ajzDEu4lvoDLryn/BBSF+km31vvsAcobiUaomECg81t1jKM6INkByfds8qmyTt2yF6mWdhBALDOPwYpdrbpu+n9zwpcH4cyBMrsy8pXIFrWkphl+eTB2+elI5zNGUk7e7xgxqbjNdw3ANLIoXnoYK2AS9laZLcEHaxeSmZ1UHcRYf0WFDtkPJ0wFwA/eehd9G4fy//xqU7NaVbpWO4O4+yM6X8fWtapFMozpzt8UAwgDGfQbLszddPh+D2k9DoG5Xz0nJKmjB6vwCLOOjxaCu46ceVRbFoGf1ueGGfU58tdpGvs3MSEeUs71uapWsSxCp8vfmAZuovBAlul0Gg8nSD6/YzoiKnimWNU70e9VzXBvETWbOuW7PWlCzh+zmX6xtaaXpOQqcLVtkloyw7GXgOgR47C38doov86rqlMpW+2f5IlfoIFH12oXlctm3umxtjFHK/2vecch2SfrIkq2kPPqgcwX5HbM//jamL6pG4zpMxASmmuCYrP54u6kp4oI7zLFIxPkIRzm6P5aDJ086hMa4BMpJ/5CXUH7Ee/QGkG31I5vE651KhVN7Fdza4InvZgf
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB9495.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(1800799024)(376014)(56012099003)(38070700021)(11063799006)(18002099003)(6133799003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?N0l3UW9iU0dzRGl6SlliYk5zZWJZUHQ3N3NSQld4SlNjOXBtVkN6UEtNMkdw?=
 =?utf-8?B?Ri9vLzRLWkh2dGEzSW10UDNiQnlpTE55NXRLb0RnSEZybGc3ZHJOSkJLUEw4?=
 =?utf-8?B?bkk2NFZrcFVOazNNMk5SaXFXQ3RNdlFvdFQ4RE1jai81c3JoL0hqS0NqZkFn?=
 =?utf-8?B?Z00wemowY2FwY0psWkNOdWc0a1hreGlSbUkvYi84N3FoNnFsVVlDZ3BpRE9V?=
 =?utf-8?B?T1E1TWI4VFh5bTJHeThjOW5KbmtKUEF6VGZkUUk5L0dJUFFBV212SWd1N1VM?=
 =?utf-8?B?U3o1RGx4T0xPMjJ6Tlo2NTFpSWZkNG9HUUs1bE0xaE95UWRxMXpJeDZxZTVn?=
 =?utf-8?B?U1paaXBvVUFPeTdtb2ZCSXQ4YUgxQTFUYWNKZFkvejNNSzNVRVRFTDRJSHJQ?=
 =?utf-8?B?cFpmdXViSVM1K2IwMFh4UnJKaFl2bDVLU0xFMDlERENoRmVwYzdMRERHVG5u?=
 =?utf-8?B?MGxkSWp2a0RPazl5TWJ0S215SGcrY3l0bVdNcTJZT0ZBMWhNdnRRTU9maGh1?=
 =?utf-8?B?OVFHMHAxY2Z6VjhYaGlLUzVncHpBakN0WkJnWGM3dForb24zM3gxVmRHMmdL?=
 =?utf-8?B?d0lWakVtZnpiQm81eUxuZElqQlFlUVFBMktHZG9uT2VIZmJsUXR4NEU2SXow?=
 =?utf-8?B?RkVqc2d4aEp3ZXRkUWJtYnVmRzhlNVFXTVQxTXNzMnoxNGdWMVZYQW9JSFRR?=
 =?utf-8?B?cWxBdTNzUmlCQzl1L1Z0QXlwWGxnWnBSSGFybUFBMUNGS1R2WHRjT0pvbDNr?=
 =?utf-8?B?Vmhsa0JmSTFjelRUeTRhTEU0VjdSWHhkekJCc3JhY2ZmeEhFVXFObGNIVk5y?=
 =?utf-8?B?Y1lLd3ZMVUE3TXM3dDhhOFBGd1Q2alZBbURHVjdYMlN5ZzBBb2RmcDROc1dt?=
 =?utf-8?B?TEVlbkNPV3g3aTcvbGNpRzZWTDJ5eTlDOXc0OHJUVnVYUEcyU0hQeW5sTzh1?=
 =?utf-8?B?WXBQcTE1UkY1c0FjdDZNYzZUdExwQmJhb01xcjFiZzVPWnRtN3NBVk5DZVll?=
 =?utf-8?B?bVkxaTdkcktVSkJ0MUpabGs4dXJUclBhalJjNWlaOWZzMDg3NXZMNzRqVC9B?=
 =?utf-8?B?NjJhVGJzZXdYeWx3KzFQQXJ1MWxtdEhYMGY2VlphWHlSV1ZHYVpNYzZwSU5h?=
 =?utf-8?B?NS9qclRvRGh0TlFYaDBWSVpmclJ1SlFQZGxuRHF3bkUrVTRYY0FhcTZielVt?=
 =?utf-8?B?QStMeWYvMFZET1VkQnNteVYveHhiRTBZYy85akRNUTkrUXpieHBSYlV0ZGtB?=
 =?utf-8?B?aDVDT3JVejZFZzRpRUVKcTdvSkJzVGkwa3NpR1pqVzF3eStCU1JqamxOT3pI?=
 =?utf-8?B?RlJSbFdua3RQYk95NGdGMUsrcmFvK1VzMXBOTDdLc2x5a2xxc1ArYmVsZkFK?=
 =?utf-8?B?Y1pJMDRYK2RuSzRSTzVvemoxMnB4SWhPRkE2UnpNUDVZeHFQN2NubDludUVU?=
 =?utf-8?B?WmFLdTFIamdwWFBwWDRyQ05RaHlvU29qb2N4aWVLR3dxMTZNTFdXSjZJeHZu?=
 =?utf-8?B?K0JMYm5XM3JBOWxGeXh5UVhWVG1zdnJkNktybUw4MVNVaDBBT2R2RWZicEVI?=
 =?utf-8?B?Z3c3dGpHNDBOVXN5ZWJxanNYeVlnK1FPMzNqd1BTQUFIdW5xeHZPbVhGRXpm?=
 =?utf-8?B?RkdteEFuc0IrTjE2YWwvUjdIeXRReldrelI4YTduSE9scmhtSHZJbzFVQmh6?=
 =?utf-8?B?UDViSGtQRHIxVHVLMHI0R1BRSXRRU01jbkJ5OGZjdk1aMWU0ZGM5bFUwTHdm?=
 =?utf-8?B?NEV2dFpKbVk1NTR3NlZIa0NuN3NaU1JjNTd1WEJBOEphZEg2eERVMHNuZVV1?=
 =?utf-8?B?c0QvK21nV0tBcTlvd3NIaVlUN2dEVTd6dTljdU1oc1hUT29NZUFwRFhveVZT?=
 =?utf-8?B?eVo2bTVLc0toNU5EbDVBaDdHSWszK2RqUFJLb0E0Z1BoVG1Ub0VWMWN0WnFZ?=
 =?utf-8?B?TXZMOExKUklKZEJHRFg3NWxYb3d6SEZMeDVqN242QWRYOXhPZGc5M3lHNlNx?=
 =?utf-8?B?ZFdTNkR4RHRXcFhSaW04c2o3ckxvOC9GZ1NySW1mdDI4Umg2S3BndCtjamQy?=
 =?utf-8?B?ZGVQdHBBN0NCblYyTFNiSzUwWitZaHhyZmhLYnE2eE9oVWdPd05QQjJMQ0Fs?=
 =?utf-8?B?WWc3VTV1a3FKUm5ER2Y0QjhOOFBSYkJPNnZ3Z2NVRmhjcXBMZ0NyV2FqUHB0?=
 =?utf-8?B?TlVCNm16ZVNCSFhLcWxMalM0Z0NKSHM2VVFKckVEOTQyYWFyNmNLc09uWmYv?=
 =?utf-8?B?ejl3dUQzSDRNUTRuRXZzNzN2TS9DZ1JmcmNiQXRmMmlHdjdOaUFBN0huT095?=
 =?utf-8?B?eUt0NnBEREEveXQyR0REaXdRL0NVVDVCQWxxNTZsQnEvNXNRc1VRcVFXeDNl?=
 =?utf-8?Q?HzVUrKK9OQ6ROFJ3GlDKE/vRdOWJojI/lUg53DgWvVGc+?=
x-ms-exchange-antispam-messagedata-1: IYRXUWmXtYMFfA==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: jCF/N3hDdCaqgIxRF9EkGT5cnAet/D3M+3CnKSGeVCJNf1qjVznefm6iW/Z1O8+6rVLLzgflKYZV+Dp5v01c05NkKxf4W9ByVg6+fAmMlF39C5rhopag8iqNEkwxUutXQ3Gu9CMvpdqXMHXjkWTs3VRtLssAaL1PKE/4uD5JxE3jfAoqWfztbbvzXr1UCaGfeDPiZ/6LmS7VPXGlFYK3UGmw8HIJ2cCGCG9kxXfT4452JtG1aIdPp3lLM2O/e94stVnLiwScDU/qtF10gZ2UzwbnqUjOwlkpsPS8qtSKEaqWXtL7ZTGiuJKAyCWddOxLDjNBZG2V/CM6bhs6bYJOXw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB9495.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3171fa55-c99a-4f6c-beed-08deb7c6dbeb
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 May 2026 05:56:25.3952
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ekh3hNQYnkfFP8BiYZ6r+iXmnju36bM7btnx/2/iCvRNpzQ/r77uQztvnAqSgG4Z/pcoNtyK9oJyVsRyTiW+M7IM4MImX1Nd+4kTggtvLKE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8384
X-OriginatorOrg: intel.com
X-Spamd-Result: default: False [0.94 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9632-lists,linux-integrity=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,intel.com:dkim,lpc.events:url,linuxfoundation.org:url];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[elena.reshetova@intel.com,linux-integrity@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-0.922];
	TAGGED_RCPT(0.00)[linux-integrity];
	RCPT_COUNT_SEVEN(0.00)[9];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 529E45AF4D4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT0NCiAgICAgICAgICAgICBBTk5PVU5DRU1FTlQgQU5EIENBTEwgRk9SIFBBUlRJ
Q0lQQVRJT04NCg0KICAgICAgICAgICAgICAgICAgIExJTlVYIFNFQ1VSSVRZIFNVTU1JVCBFVVJP
UEUgMjAyNg0KDQogICAgICAgICAgICAgICAgICAgICAgICAgICBUaHVyc2RheSwgOCBPY3RvYmVy
DQogICAgICAgICAgICAgICAgICAgICAgICAgICAgIFByYWd1ZSwgQ3plY2hpYQ0KPT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT0NCg0KREVTQ1JJUFRJT04NCg0KTGludXggU2VjdXJpdHkgU3VtbWl0IEV1cm9wZSAoTFNTLUVV
KSAyMDI2IGlzIGEgdGVjaG5pY2FsIGZvcnVtIGZvcg0KY29sbGFib3JhdGlvbiBiZXR3ZWVuIExp
bnV4IGRldmVsb3BlcnMsIHJlc2VhcmNoZXJzLCBhbmQgZW5kLXVzZXJzLg0KDQpJdHMgcHJpbWFy
eSBhaW0gaXMgdG8gZm9zdGVyIGNvbW11bml0eSBlZmZvcnRzIGluIGRlZXBseSBhbmFseXppbmcg
YW5kDQpzb2x2aW5nIExpbnV4IG9wZXJhdGluZyBzeXN0ZW0gc2VjdXJpdHkgY2hhbGxlbmdlcywg
aW5jbHVkaW5nIHRob3NlIGluIHRoZQ0KTGludXgga2VybmVsLg0KDQpUaGlzIHllYXIgTFNTLUVV
IGlzIGEgc2luZ2xlIGRheSBldmVudCBoYXBwZW5pbmcgcmlnaHQgYWZ0ZXIgTGludXggUGx1bWJl
cnMgMjAyNg0KaHR0cHM6Ly9scGMuZXZlbnRzLyANCg0KUHJvcG9zYWxzIHRvIExTUy1FVSBzaG91
bGQgYmUgc3VibWl0dGVkIHZpYToNCiAgICBodHRwczovL2V2ZW50cy5saW51eGZvdW5kYXRpb24u
b3JnL2xpbnV4LXNlY3VyaXR5LXN1bW1pdC1ldXJvcGUvcHJvZ3JhbS9jZnAvDQoNClNVR0dFU1RF
RCBUT1BJQ1MNCg0KICAgICogQWNjZXNzIENvbnRyb2wNCiAgICAqIENhc2UgU3R1ZGllcw0KICAg
ICogQ3J5cHRvZ3JhcGh5IGFuZCBLZXkgTWFuYWdlbWVudA0KICAgICogRW1lcmdpbmcgVGVjaG5v
bG9naWVzLCBUaHJlYXRzICYgVGVjaG5pcXVlcw0KICAgICogSGFyZHdhcmUgU2VjdXJpdHkNCiAg
ICAqIElvVCBhbmQgRW1iZWRkZWQgU2VjdXJpdHkNCiAgICAqIEludGVncml0eSBQb2xpY3kgYW5k
IEVuZm9yY2VtZW50DQogICAgKiBPcGVuIFNvdXJjZSBTdXBwbHkgQ2hhaW4gZm9yIHRoZSBMaW51
eCBPUw0KICAgICogU2VjdXJpdHkgVG9vbHMNCiAgICAqIFNlY3VyaXR5IFVYDQogICAgKiBMaW51
eCBPUyBIYXJkZW5pbmcNCiAgICAqIFZpcnR1YWxpemF0aW9uIGFuZCBDb250YWluZXJzDQoNCkRB
VEVTIFRPIFJFTUVNQkVSOg0KDQogICAgKiBDRlAgQ2xvc2U6IFN1bmRheSwgMjggSnVuZSBhdCAx
MTo1OSBQTSBDRVNUIChVVEMgKzIpICAvIDI6NTkgUE0gUERUIChVVEMgLTcpDQogICAgKiBDRlAg
Tm90aWZpY2F0aW9uczogVHVlc2RheSwgMTQgSnVseQ0KICAgICogU2NoZWR1bGUgQW5ub3VuY2Vk
OiBXZWRuZXNkYXksIDE1IEp1bHkNCiAgICAqIEV2ZW50IERhdGU6IFRodXJzZGF5LCA4IE9jdG9i
ZXINCg0KV0hPIFNIT1VMRCBBVFRFTkQNCg0KV2UncmUgc2Vla2luZyBhIGRpdmVyc2UgcmFuZ2Ug
b2YgYXR0ZW5kZWVzIGFuZCB3ZWxjb21lIHBhcnRpY2lwYXRpb24gYnkNCnBlb3BsZSBpbnZvbHZl
ZCBpbiBMaW51eCBzZWN1cml0eSBkZXZlbG9wbWVudCwgb3BlcmF0aW9ucywgYW5kIHJlc2VhcmNo
Lg0KDQpMU1MgaXMgYSB1bmlxdWUgZ2xvYmFsIGV2ZW50IHRoYXQgcHJvdmlkZXMgdGhlIG9wcG9y
dHVuaXR5IHRvIHByZXNlbnQgYW5kDQpkaXNjdXNzIHlvdXIgd29yayBvciByZXNlYXJjaCB3aXRo
IGtleSBMaW51eCBzZWN1cml0eSBjb21tdW5pdHkgbWVtYmVycyBhbmQNCm1haW50YWluZXJzLiAg
SXQncyBhbHNvIHVzZWZ1bCBmb3IgdGhvc2Ugd2hvIHdpc2ggdG8ga2VlcCB1cCB3aXRoIHRoZSBs
YXRlc3QNCmluIExpbnV4IHNlY3VyaXR5IGRldmVsb3BtZW50IGFuZCB0byBwcm92aWRlIGlucHV0
IHRvIHRoZSBkZXZlbG9wbWVudA0KcHJvY2Vzcy4NCg0KTUFTVE9ET04NCg0KICBGb3IgZXZlbnQg
dXBkYXRlcyBhbmQgYW5ub3VuY2VtZW50cywgZm9sbG93Og0KDQogICAgaHR0cHM6Ly9zb2NpYWwu
a2VybmVsLm9yZy9MaW51eFNlY1N1bW1pdA0KDQogICNsaW51eHNlY3VyaXR5c3VtbWl0DQoNClBS
T0dSQU0gQ09NTUlUVEVFDQoNCiAgVGhlIHByb2dyYW0gY29tbWl0dGVlIGZvciBMU1MgMjAyNiBp
czoNCg0KICAgICogSmFtZXMgTW9ycmlzLCBNaWNyb3NvZnQNCiAgICAqIFNlcmdlIEhhbGx5biwg
R2VpY28NCiAgICAqIFBhdWwgTW9vcmUsIE1pY3Jvc29mdA0KICAgICogU3RlcGhlbiBTbWFsbGV5
LCBOU0ENCiAgICAqIEVsZW5hIFJlc2hldG92YSwgSW50ZWwNCiAgICAqIEpvaG4gSm9oYW5zZW4s
IENhbm9uaWNhbA0KICAgICogS2VlcyBDb29rLCBHb29nbGUNCiAgICAqIENhc2V5IFNjaGF1Zmxl
cg0KICAgICogTWltaSBab2hhciwgSUJNDQogICAgKiBEYXZpZCBBLiBXaGVlbGVyLCBMaW51eCBG
b3VuZGF0aW9uDQoNCiAgVGhlIHByb2dyYW0gY29tbWl0dGVlIG1heSBiZSBjb250YWN0ZWQgYXMg
YSBncm91cCB2aWEgZW1haWw6DQogICAgbHNzLXBjICgpIGxpc3RzLmxpbnV4Zm91bmRhdGlvbi5v
cmcNCg0KDQo=

