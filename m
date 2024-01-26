Return-Path: <linux-integrity+bounces-898-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2740083D2D7
	for <lists+linux-integrity@lfdr.de>; Fri, 26 Jan 2024 04:05:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 261BEB225D7
	for <lists+linux-integrity@lfdr.de>; Fri, 26 Jan 2024 03:05:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59FC9A944;
	Fri, 26 Jan 2024 03:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b="MZMuOQF3"
X-Original-To: linux-integrity@vger.kernel.org
Received: from rcdn-iport-3.cisco.com (rcdn-iport-3.cisco.com [173.37.86.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD63A8F65
	for <linux-integrity@vger.kernel.org>; Fri, 26 Jan 2024 03:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=173.37.86.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706238310; cv=fail; b=CTFuVHHlqXxHQ2ZPEJRBSFGSq1sZw68GUdwxVeJ/rrjUwhjxgEt5CfJ5ORC1J4dRzMfJ+avKk3SelS2AgfXKNjV8i4P4ppSBi9n8QlxzD9W+7YuxCOIv+ZfO8gvjGkj9FCy78DLjIfXZyPZqYwQWe9Zzkx7npUT1WtpZurnz4Sw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706238310; c=relaxed/simple;
	bh=StYSg7p+/dhd3KczXxm1WU5Ps2gxe/1dWy2CoZJSjvc=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=nxEkb6sl6Kh187nA/2P28y5q0lOWFQs9zRAHVMtgI29PwBvrlGPyzfnmE7lb82w3KHLaYcnO/kUE6TtW4AtS4y3kKxk70OxqbSusQwYV5jM5F4BgZ9e6c9GucHgsNmiJKx/m0Q51baWhyJWB2m0am+TV5iZiUGbY4S+6ts+rSW4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com; spf=pass smtp.mailfrom=cisco.com; dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b=MZMuOQF3; arc=fail smtp.client-ip=173.37.86.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cisco.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=cisco.com; i=@cisco.com; l=657; q=dns/txt; s=iport;
  t=1706238307; x=1707447907;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=wjICtjOvQi/8mNcEeVkGgzxSMIwahVAQeW/ny0GjtKE=;
  b=MZMuOQF3s9NqBBFgYWT9oP9H9MBylvt38fCgRVIT3h3fqr0oDCHBx0OY
   Tja0EiVE3ot2NwnAofvTIIf+VRmuoWu3TpwpihYnEZoNk8/USR+njkbaZ
   DRjhyOXzHJ+84IaeME6fTf2Z3ObU2oIwBodHcHhCTq6z7EryCjb9ewWXD
   I=;
X-CSE-ConnectionGUID: dDtmrJTqQKqhME8wlH/CBw==
X-CSE-MsgGUID: MniKAHhjTayWoyFrrGHu0w==
X-IPAS-Result: =?us-ascii?q?A0BUAQBlILNlmJRdJa1agQklgSqBZ1J6gQcSiGYDhS2hF?=
 =?us-ascii?q?IVbgX4PAQEBDQEBRAQBAYUGAodJAiY0CQ4BAgQBAQEBAwIDAQEBAQEBAQEGA?=
 =?us-ascii?q?QEFAQEBAgEHBRQBAQEBAQEBAR4ZBQ4QJ4VtDIZGAgEDEncCAQg1ETElAgQbG?=
 =?us-ascii?q?oJegmADAal0AYFAAoooeIE0gQGCFgWyfoFIiCIBhWWEPScbgUlEgVeCaD6BB?=
 =?us-ascii?q?QGDPQKEEoIvBIVZkxRUfx0DgQUEXA8bEB43ERATDQMIbh0CMTwDBQMEMgoSD?=
 =?us-ascii?q?AshBRNCA0AGSQsDAhoFAwMEgTAFDRoCEBoGDCYDAxJJAhAUAzgDAwYDCjEwV?=
 =?us-ascii?q?UEMUANlHzIJPA8MGgIbGw0nIwIsQAMREgIWAyQWBDYRCQsmAyoGNwISDAYGB?=
 =?us-ascii?q?l0mFgkEJQMIBANUAyF0EQMECgMUBwsHeIIMgT4EE0cQgUJmA0QdQAMLbT0UI?=
 =?us-ascii?q?RQbBQSBNgWdZTKjZ6FJCoQRoU8Xg3KmKC6HVZBRIKglAgQCBAUCDgEBBoFjO?=
 =?us-ascii?q?oFbcBWDI1EZD445k1qBMQIHCwEBAwmKZwEB?=
IronPort-PHdr: A9a23:gn7GUhD+CgdAUH7X4MhKUyQVphdPi9zP1kY9454jjfdJaqu8usikN
 03E7vIrh1jMDs3X6PNB3vLfqLuoGXcB7pCIrG0YfdRSWgUEh8Qbk01oAMOMBUDhav+/Ryc7B
 89FElRi+iLzKlBbTf73fEaauXiu9XgXExT7OxByI7H/E4rJktyf3OGp8JqVaAJN13KxZLpoJ
 0CupB7K/okO1JFvKKs61lPFo2AdfeNQyCIgKQeYng334YG7+5sLzg==
IronPort-Data: A9a23:OFMXw6LkZEhcyfk2FE+R3pUlxSXFcZb7ZxGr2PjKsXjdYENShGRTm
 DFNUW3TP/rcZzT0Ltp0b9m080lQ6JDczdZnTFEd+CA2RRqmiyZq6fd1j6vUF3nPRiEWZBs/t
 63yUvGZcYZsCCea/0/xWlTYhSEU/bmSQbbhA/LzNCl0RAt1IA8skhsLd9QR2uaEuvDnRVvQ0
 T/Oi5eHYgP9gmQoajt8B5+r8XuDgtyj4Fv0gXRmDRx7lAe2v2UYCpsZOZawIxPQKmWDNrfnL
 wpr5OjRElLxp3/BOPv8+lrIWhFirorpAOS7oiE+t55OLfR1jndaPq4TbJLwYKrM4tmDt4gZJ
 N5l7fRcReq1V0HBsLx1bvVWL81xFaFq5LrdA0SmiO+Kz2jrI2To47JFJl5jaOX0+s4vaY1P3
 eYTJDZIZReZiqfvmvSwS/JngYIoK8yD0IE34y47i2qGS6d9B8mfE80m5vcAtNs0rspHGe3Df
 +ISaCFka1LLZBgn1lI/Uc1hw7z42yWmG9FegHeTpIkew2jR8AVg77/8HsDPVfyXHdoAyy50o
 UqdojymWUtFXDCF8hKB83SxlqrOmz/2V5gTCKyQ6PFnmhuQy3YVBRlQUkG0ycRVkWakUN5Zb
 kcT4Cdr9PJ0/02wRd67VBq9yJKZgvICc9Z8D+ggyj2U84nN4yO0VncAbnlqQsNz4afaWgcW/
 lOOmtroAxlmv7uUVW+R+9+oQdWaZHh9wYgqOH9scOcV3+QPtr3fmf4mczqOOLS+gtuwEjbqz
 nXT9m41hq4YiogA0KDTEbH7b9CE+Mahou0dv1m/soeZAuVRP9/Ni2uAsgez0Bq4BNzFJmRtR
 VBd8yRk0MgADIuWiAuGS/gXEbei6p6taWKE3wQ3QMVxrGv8phZPmLy8BhkjdS+F1e5ZKFfUj
 LP752u9GbcKZST6M/UrC25PI51ykvGI+SvZugD8NYcWPcMrK2drDQllZFWb2Cj2gVMwnKQkc
 ZadeoDEMJrpIfoP8dZCfM9EieVD7nlnnQv7HMmnpzz5iuD2TCDOFt843K6mM7pRAFWs+luFq
 r6y9qKiln1ibQEJSnOPrdFLdQtQRZX5bLivw/Fqmie4ClMOMEkqCuTaxvUqfIkNokifvr6gE
 q2VMqOA9GfCuA==
IronPort-HdrOrdr: A9a23:S9ifQqqlcWYGuXxtL0jAaCMaV5tkLNV00zEX/kB9WHVpm5Oj5q
 OTdaUgtSMc1gxxZJh5o6H+BEDhex/hHO1OkPcs1NCZLUbbUQqTXc1fBOTZskbd8kHFh4pgPO
 JbAtRD4b7LfBZHZKTBkXOF+r8bqbHtntHL9ILjJjVWPHxXgspbnmFE43OgYzVLrX59dOME/f
 Snl616jgvlU046Ku68AX4IVfXCodrkqLLKCCRtOzcXrCO1oXeN8rDVLzi0ty1yb9pI+9gf2F
 mAtza8yrSosvm9xBOZ/XTU9Y5qlNzozcYGLNCQi+AOQw+cyjqAVcBEYfmvrTo1qOag5BIBi9
 /XuSotOMx19jf4Yny1mx3wwAPtuQxeqEMKiGXow0cLk/aJAA7SOPAxwr6xtSGprXbIiesMlZ
 6jGVjp7qa/QymwxBgVrOK4Ji2C3nDE0UbK19RjzkC2leAlGeVsRUt1xjIPLH8NcRiKm7wPAa
 1gCtrR6+1Rdk7fZ3fFvnN3yNjpRXgrGAyaK3Jy8fB9/gIm1UyR9XFojPA3jzMF7tYwWpNE7+
 PLPuBhk6xPVNYfaeZ4CP0aScW6B2TRSVaUWVjibGjPBeUCITbAupT36LI66KWjf4EJ1oI7nN
 DEXElDvWA/dkryAYmF3YFN8BrKXGKhNA6dgP129tx8oPnxVbDrOSqMRBQnlNahuewWBonBV/
 O6KPttconexKvVaPF0NiHFKu1vwCMlIb8oU/4AKieznv4=
X-Talos-CUID: 9a23:3e2r32Gm4zpvPYbqqmJr2FIRAOIZa0T+1Xf1Dh+nDUYuY5eKHAo=
X-Talos-MUID: =?us-ascii?q?9a23=3A/JcaPwwMNjBUPIeeeSz1EbDykq6aqIGoCWMksZU?=
 =?us-ascii?q?Eh8CVCithFS2HoxSqGpByfw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
Received: from rcdn-core-12.cisco.com ([173.37.93.148])
  by rcdn-iport-3.cisco.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2024 03:03:59 +0000
Received: from alln-opgw-4.cisco.com (alln-opgw-4.cisco.com [173.37.147.252])
	by rcdn-core-12.cisco.com (8.15.2/8.15.2) with ESMTPS id 40Q33xoZ018183
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-integrity@vger.kernel.org>; Fri, 26 Jan 2024 03:03:59 GMT
X-CSE-ConnectionGUID: UpaTK+leS8OSsQo9cgkuYA==
X-CSE-MsgGUID: INCvLrZGR0m51yu4/6sBHA==
Authentication-Results: alln-opgw-4.cisco.com; dkim=pass (signature verified) header.i=@cisco.com; spf=Pass smtp.mailfrom=balsup@cisco.com; dmarc=pass (p=reject dis=none) d=cisco.com
X-IronPort-AV: E=Sophos;i="6.05,216,1701129600"; 
   d="scan'208";a="21460280"
Received: from mail-bn8nam11lp2169.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.169])
  by alln-opgw-4.cisco.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2024 03:03:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dvIKOg3/VbNI8oTNHaf0D9TR8dbmROLtAM02WLSJr/20s7japKSqR7Oz1G+UDGHJ7d2bnV1H3cL/A8//EopmUS7jmMvN0esgv09PbtDvEPLk8bA3jkMjA+T+s7fBoymStxq7X3uu+4pBFxPI4x2ZEm9RI8Rl6AV9I0AFxwcknrwDcPR1dAm67wYNw5kvKqjS1jDCakICj8CKsgptnt5Y0GiephKfxqIoZdT3NEhF/iDFx1e1G5Ia/tFVBftSYVt4HNHH7U3KkFafqLKH2efHVRhmm89CRhwbnngx9ox+CccXH/712MsryJ22W84613FJ+wJy59T1pbeeqLO/JKUdjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wjICtjOvQi/8mNcEeVkGgzxSMIwahVAQeW/ny0GjtKE=;
 b=kyH3jDSkYEyPELPgrOUDHPpcrbsknwHrgTdetfnU2z6nfl6AVtt3C7iAHfWSzaTH9uMdy7LMmaKfkFiwHbCpGQAlRmGUlGb9qjnEiUqL5H8VSpajpxMpso9qeAYacyvJ3pESYrkbw2lxLB4QLhhkMjtaF7XGF1Ap/8SZKBmkcA/XA9c3K4+2+ejnh93G/1jWKHwEFlPGcnpIIHGb6+efZmYTEVTTFwzenKwGXmqV6QLUjqMW3yCicV5n1yCJdeprCP+S3mCGF4zbWvGJBNnxkoMT1IqNbZ42TYJ/nc2f5VVpCrbJMbrpLMkPYW8ecSyqCCtt1DsP730Zgd5UYYeN4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cisco.com; dmarc=pass action=none header.from=cisco.com;
 dkim=pass header.d=cisco.com; arc=none
Received: from BYAPR11MB3527.namprd11.prod.outlook.com (2603:10b6:a03:8b::26)
 by DS0PR11MB6544.namprd11.prod.outlook.com (2603:10b6:8:d0::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7228.26; Fri, 26 Jan 2024 03:03:57 +0000
Received: from BYAPR11MB3527.namprd11.prod.outlook.com
 ([fe80::2bd9:67d0:43ba:5f6a]) by BYAPR11MB3527.namprd11.prod.outlook.com
 ([fe80::2bd9:67d0:43ba:5f6a%7]) with mapi id 15.20.7228.026; Fri, 26 Jan 2024
 03:03:57 +0000
From: "Billie Alsup (balsup)" <balsup@cisco.com>
To: "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>
Subject: Re: ref leak in request_asymmetric_key ?
Thread-Topic: ref leak in request_asymmetric_key ?
Thread-Index: AQHaT/hyjB+cdCGonkelvMgjLj11TLDrZ5cR
Date: Fri, 26 Jan 2024 03:03:57 +0000
Message-ID:
 <BYAPR11MB3527F7232A143CE35774DB9DD9792@BYAPR11MB3527.namprd11.prod.outlook.com>
References:
 <BYAPR11MB3527851FFD46381325450F74D9792@BYAPR11MB3527.namprd11.prod.outlook.com>
In-Reply-To:
 <BYAPR11MB3527851FFD46381325450F74D9792@BYAPR11MB3527.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR11MB3527:EE_|DS0PR11MB6544:EE_
x-ms-office365-filtering-correlation-id: 417e17dc-99b2-4986-1974-08dc1e1b701f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 6XY+dHFYgQouk3fmrCeObJC/TJQ8mb5h12xbLZuXog1xl93+rmOQEubXAnueLec4Z9CZV2ZJ24dk9a8UOw0I/eIA1yA9EKlNdFejh8JJ1OYDPPbYiX8gAKDrdnqpsFYkbuSUyYof0uiLsOPw1hBJLvDWLb24JJ+xPAqY71X8RuvE0DfkOCcJtGMfplkA0A0pyy1xNDL8ems2WN7JwcVpRV2mn10XOFyQpZ+hblOUTH5EVUy6FsmFeN75hxhpQ/pj98kw/lZof/y1BgPaBW5Txkk4otgS3eRFtuS6WR2OY+Pg105elbcGlehbWZjjpya+QpphK6kYCgkjRVVFdbPGqm+rvTBV1x5Mzgj7XOYKc8X2/PZsr9MHVohRrqRkOYYQnw5LER1Yon89eiDOlZFMatNKdmkjbdPOTIwNqAUG3GvpD5pvFCBnnG2x+qWUTnUbjsXejPPG1fOtq6GYL0xHemixjYQ0Bu2jX7lJzh7pvsQNfo/MxtuYrDp4UfQ5qMfyvBo/y8ua6Ew2EeVy7JDmk/lwG2n4RjbzWqCWWscDcc2iIYeQvFdVa4KD2UfKRz/HbNgb0TzvmuvuWKWLvLVli+tdsVwh3nXQm5jhiF5R19kLDXq9RKXuLqqHKsFLTXDW
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3527.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(376002)(366004)(396003)(39860400002)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(26005)(9686003)(6506007)(7696005)(83380400001)(8676002)(8936002)(52536014)(66476007)(66946007)(478600001)(316002)(76116006)(66446008)(71200400001)(66556008)(91956017)(122000001)(86362001)(6916009)(64756008)(38100700002)(55016003)(2940100002)(38070700009)(5660300002)(41300700001)(33656002)(4744005)(2906002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?KmpU5qJjBpn2HSViE6zEvnakkd9EK1ZHVD6Y9NdnFOte0k5vtJkUeqP9YX?=
 =?iso-8859-1?Q?20wRWiW2B3TQ7nmUcJRvukf8DbwAV8/zbC+2dtaUGVaUbHYhIPis/mUVfY?=
 =?iso-8859-1?Q?oDSpmu1mIR47AGld81ygSRMn42rzIEcQy4NPwBs8W/cL/17J+Uiww4mmhf?=
 =?iso-8859-1?Q?GC+xXD1ft0pkIQGoYlZJjL9Seo0nkzO+NabX2Y7DjMFcjVOtxD8CrJy0kh?=
 =?iso-8859-1?Q?TSIUoeHCw8p4UDFaTenXfKOC2fyBCCYK+yR54CwHRReD0kBcmgLcRB4Ndx?=
 =?iso-8859-1?Q?6Df1wP0PRHdF9Mu+4QT8bv0UXXLavs49iHZSiG64zjB5SrVzgZnJYxqwen?=
 =?iso-8859-1?Q?PZpALuXmnrJDCvsxR2hKDw3kvlaktefDiCAfg/u72SHpVYAUAHmSIRDhsX?=
 =?iso-8859-1?Q?RQ3KNv5NIFiKlnhg1HrVMUsGHh8q9P+KJj+gdL05MalOsPn3qxBefZHWfz?=
 =?iso-8859-1?Q?6fRgn/KAR8aAm3UNrN+3q6IAEn8+nKBB8EdzcbXNSDy50ElUDbh5+2G56I?=
 =?iso-8859-1?Q?yltr6AcN/pGVxC6b4ycqXnpWDY6d8K2WU/H9RpT/z7+9Mect8aFZXDvDZX?=
 =?iso-8859-1?Q?8mB3gqRtrBp6rc9EY2onBCqnPe7aqMxwcT+6njaobeMFHqmp22A1nJ60gW?=
 =?iso-8859-1?Q?qRystWlhkFNoQKYofcpEBEkddbejPk0/N5BHAGclveaMwAq45NjKBkat2h?=
 =?iso-8859-1?Q?iganN+E8seW7prFkdw/fHEdGWggB1cb4g4EPLTXPo6vuidQWz5GLB3wAIm?=
 =?iso-8859-1?Q?aV2hNfFLfc4PqG/00z97+JcefWOMFlkxw77KndKOWqSRhjha45dmetAsyD?=
 =?iso-8859-1?Q?FXuSmEusVV3kx0IseYPVUvJ4knn3kftpcPIU45GD7FmqLGE1BXiywaYHJJ?=
 =?iso-8859-1?Q?6lhow0NByaFLAcu3rQcMO22Q2U5gyYTSQShJK25yeIfuBUOek6Gw2gyH5c?=
 =?iso-8859-1?Q?vVj9CfTx5T+Iubd/xF0/nNr9XR2lTcvQRo/Dc4BZBrGPCZaqFDHTDnhriO?=
 =?iso-8859-1?Q?5CDr91mj+fc3qJ5vR1LzW/QFHttnKaGo2+zjBNs8oXpEDH0psPmh3t+tpT?=
 =?iso-8859-1?Q?7CXQmnbtqOayKiMtAXcLXZM2L9yo511MwcZeWdbcQZeYFle7O9tmIN8zIk?=
 =?iso-8859-1?Q?nOvatgXMNKnSq7fBnetc59sH3tI5/4+EUrog46hCSFo4ZXdCFBVnJ8Zhfc?=
 =?iso-8859-1?Q?yBMaDiS2UVEvFFpIJGouMcOErCwhgVVwk39K3c+4Mm/I+5rn8o9vBWLxKG?=
 =?iso-8859-1?Q?/6MlhaBehB2AqQiPennk17wc9bgKkkjtgh9bp6WNE2JmOp4AKNw1LnHnEh?=
 =?iso-8859-1?Q?2mQx9fQha2ny5lOKmmdh+WBDKV313LyGMDAo3IN0YE5YdtPkzXZUR+awJv?=
 =?iso-8859-1?Q?C/9dXAA+kP8mt8PbVWPCZTolJJgy5GwLJ8Ke9+LrAYuY7G458scB0Odrj1?=
 =?iso-8859-1?Q?iEiKaATW/9eSYWdNe2Hv3Au+iYT54nLW7dyJbB8ArRNjZH5gfcGhSuLTDy?=
 =?iso-8859-1?Q?rdjW5qtwQZT+gmQBg8QYjrNvlNOZy6Qxq0GrOCn/1sgE1jEAGDm3CsD16H?=
 =?iso-8859-1?Q?FbnVPLdPk+HGbSGQR2Dof2WToa9FkDxElEyxfPtHUBpoDKqAF2Vz3bgBDT?=
 =?iso-8859-1?Q?JJCOfsceZgch8=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: cisco.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3527.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 417e17dc-99b2-4986-1974-08dc1e1b701f
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jan 2024 03:03:57.3636
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5ae1af62-9505-4097-a69a-c1553ef7840e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HHJwxUviIGXG9oP1V7UdhEsmKIRy65h/U4/vpCqL6FtAqOrTP/Eqwrm8HT6FBiZAyJHeXSSqBzW9H3yuFiPgtw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB6544
X-Outbound-SMTP-Client: 173.37.147.252, alln-opgw-4.cisco.com
X-Outbound-Node: rcdn-core-12.cisco.com

>In security/integrity/digsig_asymmetric.c function request_asymmetric_key,=
 should we =0A=
>not do a key_ref_put() when the key is found in the ima_blacklist_keyring?=
=A0I'm working =0A=
>with 6.6.9 kernel but have verified it is the same logic in linux-stable m=
aster branch =0A=
>(top of tree is ecb1b8288dc7ccbdcb3b9df005fa1c0e0c0388a7)=0A=
=0A=
I guess it does not matter, as there doesn't appear to be a function to ins=
ert anything =0A=
into the ima_blacklist_keyring.  Seems like we should simply use the system=
 blacklist_keyring,=0A=
or perhaps the add_key_to_revocation_list function should take a keyring ar=
gument.=0A=
=0A=

