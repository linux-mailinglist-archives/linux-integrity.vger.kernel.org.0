Return-Path: <linux-integrity+bounces-6342-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68A1EAC81F4
	for <lists+linux-integrity@lfdr.de>; Thu, 29 May 2025 20:03:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A73AA3B43A5
	for <lists+linux-integrity@lfdr.de>; Thu, 29 May 2025 18:02:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 412F32309A7;
	Thu, 29 May 2025 18:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="e55dfprc"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9168C22DA10
	for <linux-integrity@vger.kernel.org>; Thu, 29 May 2025 18:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748541777; cv=fail; b=ZYWpKdRqERMIUrifjAdsEjpwj+LahyETJ5EsqDbxDYCbxS3hUNu+9G+oWE9ZIr8JeyBhpwaf2LQY/MqhYJgD2aqR3QXutAiS7cMZP5xFsrwkYEBOQ+NMpB48ezuISGODu5+0MgqUrgyM1jAVvPUfnCqCYD0XVArrxbwSZCKb8jg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748541777; c=relaxed/simple;
	bh=U3/zDe/iNbul45yPB+XTFztymAAS23W7kYS/+iYAkHM=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=IGg3fxJ1IkIfTtIJaWrWvCFzP1EJGN9TQvpacoM31r8dsScp4kPnbfbKX3fAy7oQzw2nL6poScByiLIGJcKLpOXQmcXyJeTgymCa/h7//5GY0uSZ7CVqKc9IhXtfkBOyI8vpxqBlpjkerIA5JzLEJ6/xdAB9RqOfJ2jS0F3WnPQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=e55dfprc; arc=fail smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54TDcskR008146
	for <linux-integrity@vger.kernel.org>; Thu, 29 May 2025 18:02:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=tMTNsZx/G9lAultkJLNe+Y+O2bo/QUHvmXkioJtDE2Q=; b=e55dfprc
	OhFjTcdVWDjew4+f4VmbYTgbhTtKkGKJT+hsodWlhBVFkj2OqbayQwIxZu7MQO0F
	9L78DsJaC6c863up2k4OBX+dTEkByO8L7Wn7O3TuQzf8JPIvgj1dREBxmWRE38x7
	+MSZe5bBdVXWf5OBicJDA0SAGq6lGkOr5c/taSKF7ovK27zPN/oAoihaTBNzCKjm
	A8Baa52Q+09WiP6ZhuLvpp3Lgy/7DXnzdiEnruCClSD/cQn2lXhlgjBmkbkuPO8p
	99pomRNKGDrb3lXX1NWMg6gJ9f0gnBIjH98sC5yTZlBCTME+VMklSUpJjTMjNfjO
	t0Cbh3YNYr7Brw==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46x40kf5wv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-integrity@vger.kernel.org>; Thu, 29 May 2025 18:02:54 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 54TI1vMi022048
	for <linux-integrity@vger.kernel.org>; Thu, 29 May 2025 18:02:54 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46x40kf5wd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 29 May 2025 18:02:53 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 54TI2q3I023564;
	Thu, 29 May 2025 18:02:52 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12on2077.outbound.protection.outlook.com [40.107.244.77])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46x40kf5wa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 29 May 2025 18:02:52 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UCWDd8ChjfSHRvmmQPO+fEwW2nIpe/V6dxKkh+QPgzbmV5GUu7BzF9FyOUzOlcY5Xknhox2m4iNmXusdbgZgJmXENk+0oWq0VcRiydUkgIbAZRvh90jFXvFGXZYF9s+zLxoU8phIxyKxHAlqyOvok4XNUJj5tw47fwnV+3+v19hf5SkMqLhxuLA2bS420ZBmUk1t5ntEF7sdejxSbpUIcw9BkK7Ajv7XG5MHCLCMbgHWvhlTq+afP8AgKEUF9uQ5Xs45+ICWqF+R+XfrNd0dlaBVyR1YAtdOxm67CMODbDWq7vA46Hd5AGqdhZkHRjss/XFYLV8JZpUR309u1Nd++A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=53aGocfvCJdy4BRQby4kEOtzmseN1RJQIRjJhLgWns4=;
 b=nH3tyODyLCQRgI2VXh9Mi79pZrdQKsjTG0cK4OdcodWz3b+PSwNgvk+Tviyz7BMpap3xdVZPmHmkuWTxttQOW3aopH3hCRBvCVs34X9A/y6lYDxctYLnMA1b4jYPZQchRbaylFYzjSTPm0LS3O0bsz96N1NbDK9Z74tlVKL9LqYVqRWFirMveYHlfCxcaTvDy2obV6tCV5Zv0AZkpW9ItOb/8ZzoRuObkIzNJKh8Nqb0lcWRk+BmXToDj+5Vv0l/mBC6jQY+EAPiSKnjxqxrdFNPLimqu3nWDc1caJX+t1IPKr6ac0RfMlRp/BGntCjiXFYqG31h9qvVi11TBuUh5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by DS0PR15MB5698.namprd15.prod.outlook.com (2603:10b6:8:145::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.33; Thu, 29 May
 2025 18:02:50 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::6fd6:67be:7178:d89b]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::6fd6:67be:7178:d89b%6]) with mapi id 15.20.8769.025; Thu, 29 May 2025
 18:02:44 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>,
        Xiubo Li
	<xiubli@redhat.com>, "twelho@welho.tech" <twelho@welho.tech>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "idryomov@gmail.com" <idryomov@gmail.com>
CC: "zohar@linux.ibm.com" <zohar@linux.ibm.com>,
        "roberto.sassu@huawei.com"
	<roberto.sassu@huawei.com>,
        "eric.snowberg@oracle.com"
	<eric.snowberg@oracle.com>,
        "linux-integrity@vger.kernel.org"
	<linux-integrity@vger.kernel.org>,
        "dmitry.kasatkin@gmail.com"
	<dmitry.kasatkin@gmail.com>,
        "serge@hallyn.com" <serge@hallyn.com>,
        "linux-security-module@vger.kernel.org"
	<linux-security-module@vger.kernel.org>,
        "jmorris@namei.org"
	<jmorris@namei.org>,
        "paul@paul-moore.com" <paul@paul-moore.com>
Thread-Topic: [EXTERNAL] [PATCH] fs/ceph: set superblock s_magic for IMA
 fsmagic matching: up to 60x speedup
Thread-Index: AQHb0MGCD1wWNYBJZ06VfFrpZz/x7rPp5jyA
Date: Thu, 29 May 2025 18:02:43 +0000
Message-ID: <d3a0a5caa69d3af5c9e09d1d15979c9306e5ae8e.camel@ibm.com>
References: <20250529174453.293618-1-twelho@welho.tech>
In-Reply-To: <20250529174453.293618-1-twelho@welho.tech>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|DS0PR15MB5698:EE_
x-ms-office365-filtering-correlation-id: 592e6c90-85e3-45c8-c8c7-08dd9edb02ec
x-ld-processed: fcf67057-50c9-4ad4-98f3-ffca64add9e9,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|366016|1800799024|10070799003|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?T2dGRXdjYzJxK1VDNFVKMk1FcFQvbVBjUmFnMzhHL3A0UmhpUlAzQ2VsVnhC?=
 =?utf-8?B?TURkczVFRCtWeEtjdTJjRjJXT0hJN2d6U0ZZRnBBRG5ac1VWbWFDU0NIOTRY?=
 =?utf-8?B?YnlYZGhNdlV6Sk05aG5JRTNwWEZ1NmNWaDZkRzZ6QkRKSGdTMEd0WXhTYkJa?=
 =?utf-8?B?NU1TcVdLZ3VuY1RZVjIrRjZuN3VCOEM5cVZNRkdHMGxGa0x2Q0thSXJDZVpZ?=
 =?utf-8?B?K1R5azIrL2wyYzVJd0ZhbGYrc2k3ZU1mNDNUTUx1VEE3d2orOVFncytuU2Mx?=
 =?utf-8?B?bVlkKzl2ZzQySnEyY1hjYVlmQ01Sb1hBK2lBT3BiL2JUNGdiQ25VdktMTmRK?=
 =?utf-8?B?NUdwZDFVSmxVZ1dCakJ6eDhFd254dHVzV0hNbGE0WjMwV3QyUmJhOHpSRUZy?=
 =?utf-8?B?ZVpjaU5DbmtGSERWVXBYQldzM2t5aW9FaWVYYzNFalFWMnd0Q2J4cklSMGll?=
 =?utf-8?B?SU1Uc3lYVTN2UmxLNnJpdmVNNXJxajhHNk15SzFQSjhHSXhRb21XbEUwcjBG?=
 =?utf-8?B?SFZ1WmdUUVU1eDQ0NHNlS1oyVmtSU1F1SWRVMXVLU1Vyc0I4ejAwMWhLNGEw?=
 =?utf-8?B?U2swZ2RSOGtOWW4rVHpWY1VHQm5YSnI2K1ZGV08ySk55MU0wSlBwd1VBQXNL?=
 =?utf-8?B?empkZWgzMmpVc2NXOWZmdkZ1Vi9MWnk1OHNZYkxNdHVydVRVR0l0a3JBbmIr?=
 =?utf-8?B?RG5VV1N1dUVqVHQvd2lTYWltQjVRaUd1aHlxdWc1cis4blEvbStnOFRlcU1M?=
 =?utf-8?B?MUlNWTBSdUltRXZ0bHJjQW1rb1NpZGt0blRHV045RVg2bGJMZGVvbTYwc2VT?=
 =?utf-8?B?VGp0eVE4RW1IaC8xeCs0Zll2UXRFenM1Y3dLTGEreHNQVVoyejVRcHM5Q1ZO?=
 =?utf-8?B?YVE5Zm9xOXEyVGRmKytCNlVzN1cxdDlyWmpNdlZnSStONGkwb09DeUtkSFUv?=
 =?utf-8?B?WTU3NGlCKzk2OHp6bE5POTJBV1g0YkRSckU2Q09weitKUXh0UXlFMDVySk9x?=
 =?utf-8?B?cGgzZ0dDME1GcWVNcHdLeFdZSXZnQndnbWs1QnI1Z09sUkZNdy9qVUFHNHY4?=
 =?utf-8?B?YWpTNjV1QW9sNWltWnlUcXk3dit0VHRpbHc5VjFSVjkrb09pcDRkYmkzWjl0?=
 =?utf-8?B?aUZoK1V1ZEEwcHBpbGhFVlNNSGl2OUsxYVlpTGdaWnRWZlM1Tzg4QmFPVHpI?=
 =?utf-8?B?WXBqTTVENmZsT1Jrc0g0VlFsTStBWjhYOEFpUmY0Z0hGWTd2NW83Tk54aldk?=
 =?utf-8?B?c0lQektsQlJNRVpXV2VvZitLZlVLWFYzRUpJR3g5aFVobWk4RGxkYytraEh0?=
 =?utf-8?B?WkFHY2RqTWhiR3dLa2thMWVMNlNzbzZ6Q3FLVk11Z2JEcUJlWkU3Q3pNdFBP?=
 =?utf-8?B?WitNVmx5MWtsMGVqVXYxWlpPdmdXMURFY1hLWTQwTk54VVNnZjIvZmNMR1VQ?=
 =?utf-8?B?ZlJCNHBuY1Q2TFFwcE40VHdDcUJJKzNyeEFnclVMdkZwSkt2c3dIazNSMzl4?=
 =?utf-8?B?QmR6L3RrOTR3SmRJT2VLRUM2L0FkdW1zOGtLc2NVbnJsaDNFTVdPU3FCWlds?=
 =?utf-8?B?dFhvZml5eUp5S01HaTBEeEw2dkZWc3pNaWR5Rlg5S296RWMzM2oweXRST081?=
 =?utf-8?B?ZForTkpZMnhNWmNrOVB2SE5lcitzdkIyaUh2NlQxQzVLZDc1QjQvVFRIRXdj?=
 =?utf-8?B?bUhHaXlCdndYVWkzUDJWeE5rZlFHbm5RRTJzNWdjU0xFQW9GTlI4VlJOZTA3?=
 =?utf-8?B?WU9QRG1qTVI4QmZvSXhTbUdDU1N1c2xGSk5MeVhBNjd1VGlQdEs1YmZ6YnlG?=
 =?utf-8?B?TURWS2k3Qmxub1V4SVRyb0Qrc3NlRHNUUDRLZlJYMi94S1I5ZytWY1k3T1pz?=
 =?utf-8?B?eFFWNDJNTy9JSVZST2tPTklYWk5kUGJNYjNJanpKeWZzYXNKT2VwVGtHZ3VQ?=
 =?utf-8?Q?sWIl3Ct4QIY=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(10070799003)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?aDhNeTR0VE0rVmhXU0dlNHFzdiswdXRVMmNHdGgvQWV5RzZVejJnbGNURHg3?=
 =?utf-8?B?V2kwSzZycnphNnczTU5ZOWJJSi8wNGlGKzZ6bUc0aUNWS3ZwYm42YzIrcjdW?=
 =?utf-8?B?eW9kamgyeVpFNExhbzNVbGJrQXpkbkdxMVBHSno3cXMwM012eDlEOWZvQjdF?=
 =?utf-8?B?SWhNU3JlY0RISlc5Yk90U3pOM3lzNDJUdlN5bm1Tb01oRFN4dHlDd28wL05F?=
 =?utf-8?B?OFVUSEczVlcrTGJQMEZUY0p5Q0hlUlZNTWF4UDdxc0ZPekpwNEFCdVpVQnNk?=
 =?utf-8?B?elNRRVdpUTV2OHZ3dGRScUI5QXdXWmFXWng4MThnRFFaMXdFK29wV3FrdVpV?=
 =?utf-8?B?V1VTVnpHWGJpR053VjhnaEttU1FzMnNpNTVmajl1ZVdyK1huR2tHYzZGdFoz?=
 =?utf-8?B?NVN0SW9VMGJBR0ZDb0FkMDJCbFExN0lPNEEwR2pOYzNBaU0vV1BVS1NRdUtt?=
 =?utf-8?B?T1h6VU5qQmIzZVRPaUJRVWxyME5XRGxwMzhFc0tJU1FzWFpsMFp2K3pUL3pw?=
 =?utf-8?B?UjZaNDFLejUwRDcrWnh6Y2tRZWxTbVQ3Z2F4QjJRNFJ3d1BkMDhFK2M2YkMz?=
 =?utf-8?B?SXg3VXhRcGx3Q21oWEFmUVNSbG9MdXp3SFZVRnhzSFh0c3BSbU5YVE5oMkNR?=
 =?utf-8?B?N2ZDb1NmZ0NmbUM4MGhTamZCaXcwTERHT216a2Y2d2YwWGU4Z2htcEJvRFZL?=
 =?utf-8?B?cWxyUVNXaUFaOGF0RHRBNGs3RHZ0T2pOaFFnSjRONnF0SXkvN2NMK0tPR0JG?=
 =?utf-8?B?OHZ6K1JONDZsb1BzZkFzNGc1clVHMnhDRHJLWXpFK09sS0VqRnNEeW01aG0z?=
 =?utf-8?B?b0FBcVJyeUdEa2FDVitWcXNId1MyaE5Ca2dJT2FoeFJ1emI2S1VEYUEyZ3ZD?=
 =?utf-8?B?ZjV3cTRyU2ZZNmJIOW9TSmFPMFo1a1hKZkZ5ZzRJRWE2ckpDVUtGRU10M1Zh?=
 =?utf-8?B?bi8zU3p1VjJxN2IxRzh5TTlTa2R2Q1lObmdwTG1nbXVrUkdKVjdkUWE1UkF3?=
 =?utf-8?B?Q2hoYnIxUCtvQTNWaFpkWDlWTkxmeWNHZjFSMWNVNmQ1RHlFTmZUbGhoSmRI?=
 =?utf-8?B?SWx0WTFNcGZ6L2dCTFYxK3N3cnBiaVdqOFdEQU1tS3ArMU9sYjRKTmc1b1Qw?=
 =?utf-8?B?cTRjb0I0cjhzKzZ0OXhzcC9iblNKL1JIWWJablFodzg3RWtTR1lLR09DaWU5?=
 =?utf-8?B?VnlKL2FuMTg1YUlRbm1LNGNLZGhnYktQMEpVK2pEYnRGazh5cVZpdTYzUEhp?=
 =?utf-8?B?VS93WHQrZ0F4dHViTHgrN0FXN1lMSHkyZlJZanRXc3NVbmVtdXhNSTQwdmlQ?=
 =?utf-8?B?VmZSWVc1ZktVNEIzYitLU3dyanlRYlZSR2JvZEY3anVhbUpWbDRVeGFTS1g3?=
 =?utf-8?B?U2ROTGJBV2dWa3ltakhweWhlckZwZ1dtVktWWC9lVkVDRmxOMDNkUk9KWWNx?=
 =?utf-8?B?Z1dIS3Ewb2N2cEE5NEFESmFqeGFTT1BXeEdSRlpDSWZpR0w0RitBQWthNmtE?=
 =?utf-8?B?WFh1MnZHYWxrQUJtTksrdm10YVpGbWFab01XaU1tUzExSE1FaVVqQ0hlMnZP?=
 =?utf-8?B?Z3BnOVgwenlQTUk1YkMwdkxhTDJWWEhGMnVDWndpZ2VEMldWOVdXbHlrbjFq?=
 =?utf-8?B?TzE2b2FsVzkrVURSWjBHdjUwbGNYM0p3QXBGWXZQalRvQkN5SEpDSnZNZXd0?=
 =?utf-8?B?bXFsVitVQ3ZEbDRwNHRUbWNLZDhjWnA3VmpwYlo3QmlUK2lXRWlsSlpSQnc3?=
 =?utf-8?B?cE9qQThlSUlQYUkzVGk0ZTdEdlBQSjRhckpTTHZja1B0TjV4ZFFRQWs2NW1C?=
 =?utf-8?B?THBnZ3dhT0t2cUNiTnBEMmRPQVpRL1R4VnJXcmhQVlBGUk5UbHFrckxRN1d6?=
 =?utf-8?B?dUcvdkVibm1ZZFBFWTZpeUpGbXREYWphSlB1Ylo3aVhIL1RGRGpZRi9hRWUy?=
 =?utf-8?B?YmFobVdxODN6THM1bFl6YWZCanBncURmTVhTbGw2TUVyNjhMVXllNmtZK1Rm?=
 =?utf-8?B?TXBEOXBJVG8xRXk5Ly81dmdjM1BoTmdIVnFrUXRoYVcyc0tLUGRWVTdmQ01L?=
 =?utf-8?B?Y1RFV2VFY2xDYjZvM0ZidElic1J0Y0Vja1ZJcENYS0lJS0hGMkpjOTFWd2dt?=
 =?utf-8?B?ZWIyYnFHcjlHN3F3eEFxcFBMdnhRMEZ5dUVuQW8xQlE2WE1mS1RjQ0kyVG1B?=
 =?utf-8?Q?FPebrW9dfFTYC6Xk+vDpdLw=3D?=
X-OriginatorOrg: ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5819.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 592e6c90-85e3-45c8-c8c7-08dd9edb02ec
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 May 2025 18:02:44.0199
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kgUedIdZgRQeRYpVl2LjQgLmv6jLDkFjhjWwmTvNJRGffcrEfV0+R+GOAs7Dj7m2Sd5IZTlg3fM7dKfkEHYzgw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR15MB5698
X-Proofpoint-ORIG-GUID: DScpb0jNA5NQGOsldel84GXTIxCnQ8Qu
X-Proofpoint-GUID: qgPRAxTg9VohODsA_Rgejx_pkxI92A8h
X-Authority-Analysis: v=2.4 cv=fuPcZE4f c=1 sm=1 tr=0 ts=6838a14d cx=c_pps a=KSl2iKJTvN9PEcZNCff+AA==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=dt9VzEwgFbYA:10 a=wkFW3hplAAAA:8 a=NEAV23lmAAAA:8 a=VnNF1IyMAAAA:8 a=-Q0MHRTWNx2cPm1oo3AA:9 a=QEXdDO2ut3YA:10 a=x_DmA0Hg--CTPKTg6_F5:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTI5MDE3NSBTYWx0ZWRfX9VhiBWlxfiYB CRQvONRM4q0sttEvJHtPWM5SrlyEG4NzM0tItmlGo3LGqqweF9LolmU5K1KY3VTNWhW/VYK0b0r TA/Oig7Djwn3FZ8aquN1hfBOBNM4YS4+Xbk3HJXqaODLbW+8igvIZNXkTX2RCvt7U/Kx/Qv9Fah
 eFhcBDv9vFkZrwq01nnKICPDXn9fdkuhy6nuvxDbiTQK1CE4kKwOlgbFGJbguEGK92rpG8WIOAg ibOU4N3+h46ckI3PyTZXQ0tI0upzCTMrffKpg7P7nQRr/wQARbGUY5Ru3ZuGcAGj8KeQ7XEE3+J 6nj5uZTUknE3svwY3eAGr20GxodC0ffctuQVy72kBMsG6NHCahy5nCeibObMRD9PntyKs/Lr04d
 qLJQD5VOIaA4tb/SnERtNpIuwuvDxyf4AcfTVpdAdo16Z7wtvZN6AU6VRQ6hbYfiegjei3FQ
Content-Type: text/plain; charset="utf-8"
Content-ID: <289F858EAAD07F4DAEF6A50DDA6F93A7@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re:  [PATCH] fs/ceph: set superblock s_magic for IMA fsmagic matching: up
 to 60x speedup
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-29_08,2025-05-29_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 suspectscore=0 clxscore=1011 priorityscore=1501 malwarescore=0 mlxscore=0
 phishscore=0 lowpriorityscore=0 impostorscore=0 bulkscore=0 spamscore=0
 adultscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=2 engine=8.19.0-2505160000
 definitions=main-2505290175

On Thu, 2025-05-29 at 17:45 +0000, Dennis Marttinen wrote:
> The CephFS kernel driver forgets to set the filesystem magic signature in
> its superblock. As a result, IMA policy rules based on fsmagic matching do
> not apply as intended. This causes a major performance regression in Talos
> Linux [1] when mounting CephFS volumes, such as when deploying Rook Ceph
> [2]. Talos Linux ships a hardened kernel with the following IMA policy
> (irrelevant lines omitted):
>=20
> # cat /sys/kernel/security/integrity/ima/policy
> [...]
> dont_measure fsmagic=3D0xc36400 # CEPH_SUPER_MAGIC
> [...]
> measure func=3DFILE_CHECK mask=3D^MAY_READ euid=3D0
> measure func=3DFILE_CHECK mask=3D^MAY_READ uid=3D0
> [...]
>=20
> Currently, IMA compares 0xc36400 =3D=3D 0x0 for CephFS files, resulting i=
n all
> files opened with O_RDONLY or O_RDWR getting measured with SHA512 on every
> open(2):
>=20
> # cat /data/cephfs/test-file
> # tail -1 /sys/kernel/security/integrity/ima/ascii_runtime_measurements
> 10 69990c87e8af323d47e2d6ae4... ima-ng sha512:<hash> /data/cephfs/test-fi=
le
>=20
> Since O_WRONLY is rare, this results in an order of magnitude lower
> performance than expected for practically all file operations. Properly
> setting CEPH_SUPER_MAGIC in the CephFS superblock resolves the regression.
>=20
> Tests performed on a 3x replicated Ceph v19.3.0 cluster across three
> i5-7200U nodes each equipped with one Micron 7400 MAX M.2 disk (BlueStore)
> and Gigabit ethernet, on Talos Linux v1.10.2:
>=20
> FS-Mark 3.3
> Test: 500 Files, Empty
> Files/s > Higher Is Better
> 6.12.27-talos . 16.6  |=3D=3D=3D=3D
> +twelho patch . 208.4 |=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
> FS-Mark 3.3
> Test: 500 Files, 1KB Size
> Files/s > Higher Is Better
> 6.12.27-talos . 15.6  |=3D=3D=3D=3D=3D=3D=3D
> +twelho patch . 118.6 |=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
> FS-Mark 3.3
> Test: 500 Files, 32 Sub Dirs, 1MB Size
> Files/s > Higher Is Better
> 6.12.27-talos . 12.7 |=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +twelho patch . 44.7 |=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
> IO500 [3] 2fcd6d6 results (benchmarks within variance omitted):
>=20
> > IO500 benchmark   | 6.12.27-talos  | +twelho patch  | Speedup   |
> > -------------------|----------------|----------------|-----------|
> > mdtest-easy-write | 0.018524 kIOPS | 1.135027 kIOPS | 6027.33 % |
> > mdtest-hard-write | 0.018498 kIOPS | 0.973312 kIOPS | 5161.71 % |
> > ior-easy-read     | 0.064727 GiB/s | 0.155324 GiB/s | 139.97 %  |
> > mdtest-hard-read  | 0.018246 kIOPS | 0.780800 kIOPS | 4179.29 % |
>=20
> This applies outside of synthetic benchmarks as well, for example, the ti=
me
> to rsync a 55 MiB directory with ~12k of mostly small files drops from an
> unusable 10m5s to a reasonable 26s (23x the throughput).
>=20
> [1]: https://www.talos.dev/ =20
> [2]: https://www.talos.dev/v1.10/kubernetes-guides/configuration/ceph-wit=
h-rook/ =20
> [3]: https://github.com/IO500/io500 =20
>=20
> Signed-off-by: Dennis Marttinen <twelho@welho.tech>
> ---
> It took me a year to hunt this down: profiling distributed filesystems is
> non-trivial. Since the regression is associated with IMA use, I received a
> hint to CC the folks associated with IMA code. The patch targets the 6.12
> kernel series currently used by Talos Linux, but should apply on top of
> master as well. Please note that this is an independent contribution -
> I am not affiliated with any company or organization.
>=20
>  fs/ceph/super.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/fs/ceph/super.c b/fs/ceph/super.c
> index 73f321b52895e..9549f97233a9e 100644
> --- a/fs/ceph/super.c
> +++ b/fs/ceph/super.c
> @@ -1217,6 +1217,7 @@ static int ceph_set_super(struct super_block *s, st=
ruct fs_context *fc)
>  	s->s_time_min =3D 0;
>  	s->s_time_max =3D U32_MAX;
>  	s->s_flags |=3D SB_NODIRATIME | SB_NOATIME;
> +	s->s_magic =3D CEPH_SUPER_MAGIC;
> =20

Yeah, makes sense. Thanks a lot for the fix. It's really non-trivial issue.

Reviewed-by: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>

Thanks,
Slava.

>  	ceph_fscrypt_set_ops(s);
> =20
>=20
> base-commit: adc218676eef25575469234709c2d87185ca223a

