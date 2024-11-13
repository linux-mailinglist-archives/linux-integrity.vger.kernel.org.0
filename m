Return-Path: <linux-integrity+bounces-4100-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6A6E9C6787
	for <lists+linux-integrity@lfdr.de>; Wed, 13 Nov 2024 04:01:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 08A0A2821B6
	for <lists+linux-integrity@lfdr.de>; Wed, 13 Nov 2024 03:01:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9B0A382;
	Wed, 13 Nov 2024 03:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b="hzLZp5dr"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C6A42D057
	for <linux-integrity@vger.kernel.org>; Wed, 13 Nov 2024 03:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.143.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731466861; cv=fail; b=gSuY1/rZHxJKipeBkywXoOZuge3Wn9M6B7FlVpZOei/P8d4f5XRb9wDyPy4c8iuS/3DCwm9MXFzoODeup/BKhFnltJwD2WqIPA9w+RtsbtpAAVN4ucfnqPR/aX1HK7Yq1RVqexRv16CkLbqYu1CfQ7W6V4WgOUyiCFvGp9UVEXk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731466861; c=relaxed/simple;
	bh=1+33/5DrRgG3R/nTiCipBAKMzxXw/CvdQsCDiXf2pbs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Wg9vdb0feKJ7pa5VKF77epr45ShcnVLWjR34SkyDHo1npNol2l7m0EAQ9Iv8MFqoFhneK6MBTN/QzcXwetWfOumflW3ii62Z362mT7Wnixnrluan9U27Sony0WfRpZv+lTJBOE8M+YCMZo7MNvfVwHGHDJ55KUqY7gYaRA7p4/k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com; spf=pass smtp.mailfrom=hpe.com; dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b=hzLZp5dr; arc=fail smtp.client-ip=148.163.143.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hpe.com
Received: from pps.filterd (m0134424.ppops.net [127.0.0.1])
	by mx0b-002e3701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4ACMwl2r030820;
	Wed, 13 Nov 2024 03:00:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps0720; bh=1+
	33/5DrRgG3R/nTiCipBAKMzxXw/CvdQsCDiXf2pbs=; b=hzLZp5drpRLprYwvxG
	08proBEetWV2KapsGdf9pMhD3NnGAbWJ7YLcCLdI0fs/fWY9v9WJtcbbrRjKgLl3
	Rwzi9gi/5sX7beLUdOF2AJKK0V/Ym1xVNngjVChgA3OByZfDOg2fvEzLEKJ4oeYw
	T3eoCKJBDgSI1fQaIPWmUFZw92cqJ4KVh9kdGFr+yZI4kjXCtVGdsGaBgB2T+mqU
	AmRIR/9wsyGLiZe23MEDYQpd+SxjKruwgLetQ0QZDldSCGKJpcIeGEuy06riSYVr
	lFjy7LJi7cT/3T7plP2lpKKymVFSbAx6wDgo+jLYtzqeq3yFccqkCHEcv+VC8MDW
	ZQeg==
Received: from p1lg14878.it.hpe.com ([16.230.97.204])
	by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 42v8v6ds4c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 13 Nov 2024 03:00:15 +0000 (GMT)
Received: from p1wg14924.americas.hpqcorp.net (unknown [10.119.18.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by p1lg14878.it.hpe.com (Postfix) with ESMTPS id A5ADE2BAE4;
	Wed, 13 Nov 2024 03:00:12 +0000 (UTC)
Received: from p1wg14928.americas.hpqcorp.net (10.119.18.116) by
 p1wg14924.americas.hpqcorp.net (10.119.18.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Tue, 12 Nov 2024 15:00:06 -1200
Received: from p1wg14927.americas.hpqcorp.net (10.119.18.117) by
 p1wg14928.americas.hpqcorp.net (10.119.18.116) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Tue, 12 Nov 2024 15:00:05 -1200
Received: from p1wg14920.americas.hpqcorp.net (16.230.19.123) by
 p1wg14927.americas.hpqcorp.net (10.119.18.117) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42
 via Frontend Transport; Tue, 12 Nov 2024 15:00:06 -1200
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (192.58.206.35)
 by edge.it.hpe.com (16.230.19.123) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Tue, 12 Nov 2024 15:00:06 -1200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U2VI89tPu5GC0gCGjdbVMkikLIGFofWwMDwZFBlBydCt1bL4SAzokLLfB8QpT4C09bfekpbL8+KHLCjYlVe2sLLI+knSuLbsb259FeJa2XVOwsmri4+IoV00qi5f0Y5a6o7TTcfBMWXim+fs/uBQ90rmuB40vDWFHznZrv8FQB4Un0kDuKpnItPyCGCr/TdGEB7sVwijBcYthGjffjsNXFCwqq1zKYCvNWGiPBsd39fFMGRsn7M2XuVyDzNrTIVTOT/H0HJ7QU9pJDFVw8epgmtpbZeRpHNF8Z1V2UwFY2RQVnjp20kt54FnLXl1oB0oRJjqHkTZbFImKM399+DKPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1+33/5DrRgG3R/nTiCipBAKMzxXw/CvdQsCDiXf2pbs=;
 b=nZplBJvaUPMPhkqeh2Xl7ha4H5mhtm/8t3uom1rosa5zp3Xcp9XhBtn/fj9Wq2JCG7hHCI/Il1gsyp3HT67duWhz02plOjOK+yZpTNTA6PBzm/AHVu9ahLJlNFeljuJNyRzq9KSE2R1xRLOzN4h2w6X491oRcVp2tHDN2AjOxNDkdXYaKF1g+Y9hFWDhJtcAlIFZdCtFc9UGLrwDjNdGb2LALHGKTe/YcIK72iobGo8KW1fmqYW7E94B9+WldOii5g46hhSdsydW7XFWi7vDuAcyCtftBwewBxqZX8trKJl1RhG4F+sUvMmwIyyKWCTUaKBtDvxkN49fN6BlKgQalQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from PH7PR84MB1957.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:510:154::16)
 by SJ0PR84MB1579.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:a03:431::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.28; Wed, 13 Nov
 2024 03:00:03 +0000
Received: from PH7PR84MB1957.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::5bb3:55b3:afd7:c204]) by PH7PR84MB1957.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::5bb3:55b3:afd7:c204%3]) with mapi id 15.20.8137.027; Wed, 13 Nov 2024
 03:00:03 +0000
From: "Liang, Andy (Linux Ecosystem Engineering)" <andy.liang@hpe.com>
To: Jarkko Sakkinen <jarkko@kernel.org>, Takashi Iwai <tiwai@suse.de>
CC: Stefan Berger <stefanb@linux.ibm.com>,
        Paul Menzel
	<pmenzel@molgen.mpg.de>, Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe
	<jgg@ziepe.ca>,
        "linux-integrity@vger.kernel.org"
	<linux-integrity@vger.kernel.org>,
        "Golmitz, Jenifer (Linux Ecosystem
 Engineering)" <jenifer.golmitz@hpe.com>
Subject: RE: [PATCH] tpm/eventlog: Use kvmalloc() for event log buffer
Thread-Topic: [PATCH] tpm/eventlog: Use kvmalloc() for event log buffer
Thread-Index: AQHbMQcujKUx7uXr+ECzX2mQ2FnQK7Kru/2AgAAF0ICAAGyMAIAABuuAgADX1gCAAAOJ4IAADm8AgASpgdCAAi22gIAAl7jQ
Date: Wed, 13 Nov 2024 03:00:03 +0000
Message-ID: <PH7PR84MB19579DA3710913907C301943995A2@PH7PR84MB1957.NAMPRD84.PROD.OUTLOOK.COM>
References: <20241107112054.28448-1-tiwai@suse.de>
 <87f11490-06ab-43a5-8058-102722a3c3ba@molgen.mpg.de>
 <878qtvi5he.wl-tiwai@suse.de>
 <262eff2e-90c5-45db-81d7-30b1cc217ef4@linux.ibm.com>
 <92a9ca13-ead3-41f8-88fd-ab9540c0e9b3@linux.ibm.com>
 <875xoygml3.wl-tiwai@suse.de>
 <PH7PR84MB19575D91A43C2D4C7C842038995D2@PH7PR84MB1957.NAMPRD84.PROD.OUTLOOK.COM>
 <87o72qf51h.wl-tiwai@suse.de>
 <PH7PR84MB1957D36D4A45C385E3DF2DFF99582@PH7PR84MB1957.NAMPRD84.PROD.OUTLOOK.COM>
 <D5KE6WL7C0ZW.1BRXVU03QDC0C@kernel.org>
In-Reply-To: <D5KE6WL7C0ZW.1BRXVU03QDC0C@kernel.org>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR84MB1957:EE_|SJ0PR84MB1579:EE_
x-ms-office365-filtering-correlation-id: 104527c1-1b9e-45e1-8467-08dd038f4554
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?alp0S0RUMHZmQzUzcHV4YTNZOTEzMG9UTVZyYlBQUG5aOE5sekRaZXpRcjZp?=
 =?utf-8?B?Z045eXlBajhFRmIwS1k4M2d5ZktMZVdXY1ZvZGhuQ1hOUkV6L2pwcnVuYTBq?=
 =?utf-8?B?UlB4MkUzQ2NGREZjVzJud2hCbWVYaVdLbFRuMzl6bDFIWWpEd3FaME9qeERv?=
 =?utf-8?B?R3lZZlE3dnJLcFlCTWlqc3NWZ3NuZE5CVU14MEI1eFRjTGhaM3lISlc3a2ZZ?=
 =?utf-8?B?UHowOVNIREN5Y3hzRVMrM01lRWtVRmJRZnhQT1N4ZEFFSnY4RkwxSXgrR2I1?=
 =?utf-8?B?NHJKam9xR0c0VnMycGQzQTdmblg0VWdOVGdHWXhrZFJGenZrQnZZV3RGc3Nw?=
 =?utf-8?B?Z0RRTlN6c01hZnV5K3dZTzhsaG1xQ28yeVMrQ2RDdndld1Bsejl5VFpoTyt6?=
 =?utf-8?B?MkovOHFDUWZNclgyUFBpd29GcGd0QTlHelpSaURTTVVwa0JEWlEzRnp3NzJl?=
 =?utf-8?B?WlZKVjFjYm5YVkMyUmJRMStsVHpDTy8zcExPQlQxdXlYQUhzYkxtdWcyN3hU?=
 =?utf-8?B?QmFadEdWeGE5UHZNSnQveUhMV0FtUVFUWWpsTGFKTjZKOU44Rm11YU0rVDl4?=
 =?utf-8?B?ZFdXLzJka0Y1clpmeFJWS0ZqbzB3ZUJmZGxwYUxDenpPS0ZldE1SRWdFbzIr?=
 =?utf-8?B?U1BTSC9tZDlVbFRERDlMSXBmUm1IVDVMdDJhZEE5bkx4cVI4UDM3ZXBWazhG?=
 =?utf-8?B?RVRsWDJVSlBscXBGelZENWRhWk9Pa3lrbWJBSGpJT2RvZmcyNUdkUzZPbDRV?=
 =?utf-8?B?MDFVT0xmY29sQ2JybXNDY2xCVXU1SVVLYUQ3TXg4U0ZPYUdKR0tndVhSWTZP?=
 =?utf-8?B?MEFlQXRaVnoxQWN6WmNKZ2ZHUExHT2x0TUFhMndjeWVrdWFWcFNieFRjaW5L?=
 =?utf-8?B?RVZISXVWTitiRWZTQUhvSjY0K05qZDNpM0FEOW42TnkzRW5od2k5NEc0WVBn?=
 =?utf-8?B?S09BQzRDLytwc0hmdUl2UlZnSW5YYXlySlhnVFM4bHozK3g4cTlsQWdTNlVi?=
 =?utf-8?B?UGVSSHJBT2NCZHhhYk5GNzlnYW1JU3V4b09iUERHT3lBblBxbHo4Zm1Vcnow?=
 =?utf-8?B?RUpGRW43bTV3UEovMDZSN3NwTlhEME0wSVZxRVhsTzF0ODVtZEF3V1Z0MW5G?=
 =?utf-8?B?SFhMeXVKN1ZLYzFGNWE3cVBqelBXZmhFZ29WWkNtYjdud09rdEZkMU9NUjBj?=
 =?utf-8?B?cTdVNW5iM0xCalhwSENSbW1DYzliZ0VNL21JclQ3dE1ONzlSQ2hVYXQ5Nk5v?=
 =?utf-8?B?dm9SQzFyT3ZaT1BXNUNtdnJza0l2ZlJPV3J6REZOTUZtaG5KNGd0S2dxbUNS?=
 =?utf-8?B?cWNueUsxMkx1QnkxTHZ5QlRwUG5tOEJXdzdLMDlqbTZtdENzb2RXWmpnRDJN?=
 =?utf-8?B?Zjc4VkhKcExIUGIwRFVRS1lJRCtXMUxpUzJhMCtJbGxwMXBwazZETEFkTXRK?=
 =?utf-8?B?NHg3SEdkRjJTclZLSE1iYTFJVXN4TG9nemdwc3VLa3lmcEdTbnlXU2YvR05X?=
 =?utf-8?B?TU1vckpkV3UyV0Z5MnBaelV6MWVkdHVtNSt4ZHRzZy8vQjI1UUNpRVVYSGN5?=
 =?utf-8?B?Y2d4VnBreEh3UTlFbTRhR1VmeXNCQUV2UlQxSEM4VlNHcVM2UHdxVmdNNklp?=
 =?utf-8?B?ZkFlaS9xUWJENHNLWUlCaW9yaHRUZXVxWks1Y1JqbFVIVEhxQ21xM3V1dFZR?=
 =?utf-8?B?LysrZ3JzTWEyRi9ZdTJCeFRzK3BQVys1dC93QjlZSHZZblhTTnB3dDk1MWla?=
 =?utf-8?Q?W8ZmnY3CRKXai3G8vM9vhLifs1hci6xNj95NcUk?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR84MB1957.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cWhNTUVBVXhlNmxZTEt6UHVnbkErb3Fibk96QkN4VG5KNG1iV0NRaHJOYzZp?=
 =?utf-8?B?STZIWEY3K0d5OWNHWE9XdHY0djFRUGF0djFITXkyTzROTDBCaGxPdlg2eTNZ?=
 =?utf-8?B?T0RPdGM1UTdWeVIwYVhxNXlXVE1PNlNUaVUyT2lac1RjUXhhYWIzcy9ERzMr?=
 =?utf-8?B?cVRVQ0NBRCs5czNlb1dwcXNQVUcxNDR5TGpmUWV3NjBlSTFSTkxpMlNaaGJv?=
 =?utf-8?B?a1Q4SjRMV2lIWEZZUHErTUVvU3J2b1BQQ1pQRmU4NkFCd0tDNkNaMWllMXp2?=
 =?utf-8?B?aG1PZSttTnJHOTBwYUVJYlAxOUFJd2hGTzRqNFhUdy9qenVQSWpQQS9SSVJJ?=
 =?utf-8?B?ZGxCUVVYUlZ3ckMxQWRXd2hTQnNIQ2FmdHpnc0RBRnI1M3JBVStXR2RuckYz?=
 =?utf-8?B?ZjIvQmdTVXUrNTdqSGEwUHNjZ2VOZytrTUZWVEs1UUNXOVNBOW1qSHpMQUVt?=
 =?utf-8?B?RE5rMWVSaG92TkZwTmpGUFk3YjV4WGJxN0NuNERVZW1DOStkL0xWalVhbWhw?=
 =?utf-8?B?ZStVUzd6czBYTFNhMUdvbGNjMWhCRXFubTBROUZEV2V2ZTMrOXh3V25uNEx4?=
 =?utf-8?B?ZHNDdUZ1eGllVHZrYXczdGtOOGpQN0Eya2plNkJtdXN3MkFMb0NKMEUxSHZ6?=
 =?utf-8?B?c3FSM0dQaDRnTzZxS01uQmJjdjlzcFovaU5RYyttbGxaTFRiWUZBMGdzQ3M1?=
 =?utf-8?B?TU1wTFdWRWdXc244VTJkQU5YQ2Mybmk5K1d3RCtHTGwwN3pucmd2MjY5bVRL?=
 =?utf-8?B?RXdWeGhzUi9oR2p1WlhQUGxYYVo5V3NKdExIRmEyZ2R6L0p6SHpBempaUWRY?=
 =?utf-8?B?Ump1VEtLVEVqcXhhNzJxeFd5OWRaamhSSlk0ZzNEUVlBbFMzYktpQVZtdmNR?=
 =?utf-8?B?SndOMDJhMFJTOHBNN3p4RW5lVE8wcUhYK3pVL204b1MzUmg2REc3SkhqbWhW?=
 =?utf-8?B?SEtQdmNUWXFqK3RRUjFGVHRXUEoyVEVZa3BWUGZ1alNRT3NDRnhKSVNpb2hR?=
 =?utf-8?B?VzVBd1o3eFNGb2ErM2JDdStQczZnL1RZT0xIbHJLMDB6dDhPZm5TSktEYWlW?=
 =?utf-8?B?QlNqSXBjQ2FSSldvc1pzdjU5OFBaVk1CT2M0azZVNHpaakVpWFZ1bWdTNzJp?=
 =?utf-8?B?b3VyRVVWWGw1ZVh1RUI3SmtlTWJ0ODJRdGl3SEtGRG81bnhVK2hCdkhNTnI1?=
 =?utf-8?B?SFFKNENld2t1VUQ0V2lXUmpKOW5laHY3d1doSHY3Q3o4aDVDdCtSOWthcUJ3?=
 =?utf-8?B?dFNrekhkY3k2dkFPWWFtZ0FGeU01RVBJY2RGMjNsOVZOQTQ5V05UMHhaSUlU?=
 =?utf-8?B?SXBXNnhNckJ2S2NaQ2tDM2JvZENuNkZxQU8wQ0xmdzFlck9ZbXE3ckZZT3RV?=
 =?utf-8?B?WlpsYUZsOHJNck0yalczd2wzY2ZCR1UyZGF2UnFQYmFlcGNLMVQ4MnJlYzlB?=
 =?utf-8?B?WTZwYTdjV0JHaVVjTFovVDI1UTIraWRMYWhOOUpWNWNOczVOREhBbHN2Z0NL?=
 =?utf-8?B?VEJUQ0FRNEF5akJpRkpWRDFsb0tkVDZoTnBxREVkM3FtUWo0UmRpSzNPOHYy?=
 =?utf-8?B?d3haekF4U1FLd21wUDJtQ1NtU0xob04yNkFYTVBzeEd1SU11S0dmMlpOb3la?=
 =?utf-8?B?VDM1MHVrVTV3b090S3luVnJ2V3NYUllWQlE5TWJHQmw2QmtrdDVYNEwzeEFj?=
 =?utf-8?B?T0I3bHR0ekZYU0NIYXNxVVNxVVZtZkNHS3JWQlEyMmltV0RiTVFQUVdUVm5r?=
 =?utf-8?B?ZlJ0Q1dzTlhsZzRxZTlyMDAvSnlENGJxMjc2UXhpaC9BcnNIcGdEMG5ZNXox?=
 =?utf-8?B?RkF0emNiR3VYV043UjN1dTlEWlAzOWx6WXNaVzVhOTltTHNPOUVpczBvaGZQ?=
 =?utf-8?B?L1RpTFJkQ3Z0cDR0amNBUElscTk0a3NpSlhHVUdCb0JXYkhuT3ZrV09xZTF1?=
 =?utf-8?B?YktSSWw0YVhTcGdGeWcrTERWbEtTRS96Qm5Jank2alg4ZTlLQXUySmlIOENk?=
 =?utf-8?B?L1BpTkdHUUpscWhNMEZVeVA4NS8weTU0OUE5LzJpM1lETTNTL3F1K1RYNEhX?=
 =?utf-8?B?OEY4NVBzd2NTZzBZNThTRU1ucnp3YTZzS3ErYTJBdHpwSmRBMFdUSHd4TWM1?=
 =?utf-8?Q?VQ6Yhpb4rX8rjeBe43QnCOonK?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR84MB1957.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 104527c1-1b9e-45e1-8467-08dd038f4554
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Nov 2024 03:00:03.4205
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: echIx6CPgs+OewmsGngXeHg4rtN5EIxBjX2VB2fHO5lGwyw7PuDyqbusTXH3kl/4ncf01UGHAOr/GxNjCq2oLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR84MB1579
X-OriginatorOrg: hpe.com
X-Proofpoint-ORIG-GUID: LKgWL14Z-ISXxZuRl6eOqXRK5NuX3uGQ
X-Proofpoint-GUID: LKgWL14Z-ISXxZuRl6eOqXRK5NuX3uGQ
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-05_02,2024-10-04_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 clxscore=1015
 malwarescore=0 priorityscore=1501 phishscore=0 impostorscore=0
 adultscore=0 mlxlogscore=999 suspectscore=0 bulkscore=0 spamscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411130025

DQo+IE9uIE1vbiBOb3YgMTEsIDIwMjQgYXQgMTA6NDMgQU0gRUVULCBBbmR5IChMaW51eCBFY29z
eXN0ZW0gRW5naW5lZXJpbmcpIExpYW5nIHdyb3RlOg0KPj4+IE9uIEZyaSwgMDggTm92IDIwMjQg
MDk6NDg6MzggKzAxMDAsDQo+Pj4gTGlhbmcsIEFuZHkgKExpbnV4IEVjb3N5c3RlbSBFbmdpbmVl
cmluZykgd3JvdGU6DQo+Pj4+DQo+Pj4+DQo+Pj4+PiBPbiBUaHUsIDA3IE5vdiAyMDI0IDIwOjMx
OjM3ICswMTAwLA0KPj4+Pj4gU3RlZmFuIEJlcmdlciB3cm90ZToNCj4+Pj4+Pg0KPj4+Pj4+DQo+
Pj4+Pj4NCj4+Pj4+PiBPbiAxMS83LzI0IDI6MDYgUE0sIFN0ZWZhbiBCZXJnZXIgd3JvdGU6DQo+
Pj4+Pj4+DQo+Pj4+Pj4+DQo+Pj4+Pj4+IE9uIDExLzcvMjQgNzozOCBBTSwgVGFrYXNoaSBJd2Fp
IHdyb3RlOg0KPj4+Pj4+Pj4gT24gVGh1LCAwNyBOb3YgMjAyNCAxMzoxNzozMyArMDEwMCwgUGF1
bCBNZW56ZWwgd3JvdGU6DQo+Pj4+Pj4+Pj4NCj4+Pj4+Pj4+PiBEZWFyIFRha2FzaGksDQo+Pj4+
Pj4+Pj4NCj4+Pj4+Pj4+Pg0KPj4+Pj4+Pj4+IFRoYW5rIHlvdSBmb3IgdGhlIHBhdGNoLg0KPj4+
Pj4+Pj4+DQo+Pj4+Pj4+Pj4gQW0gMDcuMTEuMjQgdW0gMTI6MTggc2NocmllYiBUYWthc2hpIEl3
YWk6DQo+Pj4+Pj4+Pj4+IFRoZSBUUE0yIEFDUEkgdGFibGUgbWF5IHJlcXVlc3QgYSBsYXJnZSBz
aXplIGZvciB0aGUgZXZlbnQNCj4+Pj4+PiBsb2csICA+Pj4+IGFuZCBpdCBtYXkgYmUgb3ZlciB0
aGUgbWF4IHNpemUgb2Yga21hbGxvYygpLiAgV2hlbiB0aGlzDQo+Pj4+Pj4gaGFwcGVucywgID4+
Pj4gdGhlIGRyaXZlciAgPj4+ICA+Pj4gV2hhdCBpcyBrbWFsbG9jKCnigJlzIG1heGltdW0NCj4+
Pj4+PiBzaXplPw0KPj4+Pj4+Pj4NCj4+Pj4+Pj4+IDEyOGtCIG9yIHNvLCBJSVJDLg0KPj4+Pj4+
Pj4gQW5kIGFjY29yZGluZyBBbmR5LCB0aGUgdGFibGUgY2FuIGJlIG92ZXIgNE1CLg0KPj4+Pj4+
Pg0KPj4+Pj4+PiBDYW4geW91IGNvcHkgdGhlIGNvbnRlbnRzIG9mIHRoZSBmaWxlIG9uIHRoYXQg
bWFjaGluZSBhbmQgdGVsbA0KPj4+Pj4+IHVzICA+IHdoYXQgc2l6ZSBpdCBoYXM6DQo+Pj4+Pj4+
DQo+Pj4+Pj4+IGNwIC9zeXMva2VybmVsL3NlY3VyaXR5L3RwbTAvYmluYXJ5X2Jpb3NfbWVhc3Vy
ZW1lbnRzIC4vDQo+Pj4+Pj4NCj4+Pj4+PiBBY3R1YWxseSwgeW91IG1heSBuZWVkIHRvIGhhdmUg
dGhlIGNvbnRlbnRzIHBhcnNlZCBieSBhIHVzZXIgc3BhY2UgDQo+Pj4+Pj4gdG9vbCBzaW5jZSB0
aGUgZHJpdmVyIGRvZXMgbm90IGRldGVjdCB3aGVyZSB0aGUgYWN0dWFsIGVuZCBtYXkgYmU6DQo+
Pj4+Pj4NCj4+Pj4+PiAgdHNzZXZlbnRleHRlbmQgLWlmIC4vYmluYXJ5X2Jpb3NfbWVhc3VyZW1l
bnRzIC1zaW0gLXYNCj4+Pj4+Pg0KPj4+Pj4+IFRoaXMgbWF5IGdpdmUgeW91IGEgZmVlbGluZyBm
b3IgaG93IG11Y2ggaXMgaW4gdGhhdCBmaWxlIGFuZCB0aGVuIA0KPj4+Pj4+IHlvdSdkIGhhdmUg
dG8gdHJ1bmNhdGUgaXQgaW50byBoYWxmIGZvciBleGFtcGxlIGFuZCBzZWUgd2hldGhlciBpdCAN
Cj4+Pj4+PiBzdGlsbCBwYXJzZXMgdGhlIHNhbWUuIE15IHBvaW50IGlzIHRoYXQgd2UgaGF2ZW4n
dCBzZWVuIHN1Y2ggDQo+Pj4+Pj4gZXhjZXNzaXZlLXNpemVkIGxvZ3Mgc28gZmFyIGFuZCBmb2xs
b3dpbmcgdGhlIHBhcnNpbmcgYWJvdmUgd2UgbWF5IA0KPj4+Pj4+IGZpbmQgc29tZXRoaW5nIGxp
a2UgdGhpcyBtb3JlIHVzZWZ1bCB0aGFuIGFsbG9jYXRpbmcgcG9zc2libHkgbGFyZ2UgDQo+Pj4+
Pj4gYW1vdW50cyBvZiBtZW1vcnkgdGhhdCBhIGJ1Z2d5IEFDUEkgdGFibGUgaW5kaWNhdGVzICgr
IG5vdGlmeQ0KPj4+Pj4+IG1hbnVmYWN0dXJlcik6DQo+Pj4+Pj4NCj4+Pj4+PiAgIGlmIChsZW4g
PiBNQVhfVFBNX0xPR19TSVpFKSB7DQo+Pj4+Pj4gICAgICAgZGV2X2VycigmY2hpcC0+ZGV2LCAi
VHJ1bmNhdGVkIGV4Y2Vzc2l2ZS1zaXplZCBUUE0gbG9nIG9mICVkIA0KPj4+Pj4+IGJ5dGVzXG4i
LCBsZW4pOw0KPj4+Pj4+ICAgICAgbGVuID0gTUFYX1RQTV9MT0dfU0laRTsNCj4+Pj4+PiAgIH0N
Cj4+Pj4+Pg0KPj4+Pj4+IElmIHlvdSBzZW5kIG1lIHRoZSBsb2cgSSdkIGxvb2sgYXQgaXQuDQo+
Pj4+DQo+Pj4+PiBJdCdzIHJhdGhlciBhIHF1ZXN0aW9uIEFuZHk7IGNvdWxkIHlvdSBjaGVjayBn
aXZlIHRoZSByZXF1ZXN0ZWQgaW5mbz8NCj4+Pj4NCj4+Pj4NCj4+Pj4gaHR0cHM6Ly9lbGl4aXIu
Ym9vdGxpbi5jb20vbGludXgvdjYuOC9zb3VyY2UvYXJjaC94ODYvaW5jbHVkZS9hc20vcGFnZQ0K
Pj4+PiBfdHlwZXMuaCNMMTANCj4+Pj4gI2RlZmluZSBQQUdFX1NISUZUIDEyDQo+Pj4+ICNkZWZp
bmUgS01BTExPQ19TSElGVF9NQVggKE1BWF9QQUdFX09SREVSICsgUEFHRV9TSElGVCkNCj4+Pj4N
Cj4+Pj4gaHR0cHM6Ly9lbGl4aXIuYm9vdGxpbi5jb20vbGludXgvdjYuOC9zb3VyY2UvaW5jbHVk
ZS9saW51eC9tbXpvbmUuaCNMMw0KPj4+PiAwDQo+Pj4+ICNkZWZpbmUgTUFYX1BBR0VfT1JERVIg
MTANCj4+Pj4NCj4+Pj4gaHR0cHM6Ly9lbGl4aXIuYm9vdGxpbi5jb20vbGludXgvdjYuOC9zb3Vy
Y2UvaW5jbHVkZS9saW51eC9zbGFiLmgjTDMwOQ0KPj4+PiAjZGVmaW5lIEtNQUxMT0NfTUFYX1NJ
WkUgKDFVTCA8PCBLTUFMTE9DX1NISUZUX01BWCkgVGhlIG1heCBzaXplICA9DQo+Pj4+ICgxVUwg
PDwgIE1BWF9QQUdFX09SREVSICsgUEFHRV9TSElGVCkgPSAoIDFVTCA8PCAoMTAgKyAxMikpID0g
Ml4yMg0KPj4+PiA9NCwxOTQsMzA0ICg0TUIpDQo+Pj4+DQo+Pj4+IEZvciB0aGUgeDg2LCB0aGUg
bWF4IHNpemUgaXMgNE1CLg0KPj4+DQo+Pj4gVGhhbmtzLCBpdCB3YXMgYWxyZWFkeSBjb3JyZWN0
ZWQgYnkgSmFya2tvIDopIEJ1dCB3aGF0IEkgbWVhbnQgd2FzIGFib3V0IHRoZSByZXF1ZXN0czoN
Cj4+Pg0KPj4+PiBjcCAvc3lzL2tlcm5lbC9zZWN1cml0eS90cG0wL2JpbmFyeV9iaW9zX21lYXN1
cmVtZW50cyAuLw0KPj4+DQo+Pj4gYW5kDQo+Pj4NCj4+Pj4gIHRzc2V2ZW50ZXh0ZW5kIC1pZiAu
L2JpbmFyeV9iaW9zX21lYXN1cmVtZW50cyAtc2ltIC12DQo+Pj4NCj4+PiBtZW50aW9uZWQgaW4g
dGhlIGFib3ZlLiAgQ291bGQgeW91IHByb3ZpZGUgdGhlIGluZm8/DQo+Pg0KPj4gUGxlYXNlIGNo
ZWNrIHRoZSBhdHRhY2hlZCBmaWxlLiBUaGUgZmlsZSBoYXMgYWxzbyBiZWVuIHVwbG9hZGVkIHRv
IHRoZSBTVVNFIEJ1Z3ppbGxhLg0KPj4gVGhhbmsgeW91Lg0KPg0KPiBQbGVhc2UgY3JlYXRlIGEg
YnVnIHRvIGtlcm5lbCBidWd6aWxsYSBhbmQgYXR0YWNoIHRoZSBmaWxlIG9uIHRoYXQuDQo+DQo+
IEJSLCBKYXJra28NCg0KSSBjcmVhdGVkIGEgdGlja2V0IGF0IGJlbG93LiBUaGFuayB5b3UuDQoN
Cmh0dHBzOi8vYnVnemlsbGEua2VybmVsLm9yZy9zaG93X2J1Zy5jZ2k/aWQ9MjE5NDk1DQo=

