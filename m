Return-Path: <linux-integrity+bounces-8162-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CB25CF01A0
	for <lists+linux-integrity@lfdr.de>; Sat, 03 Jan 2026 16:18:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 80B0C3005088
	for <lists+linux-integrity@lfdr.de>; Sat,  3 Jan 2026 15:18:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D97A71DC198;
	Sat,  3 Jan 2026 15:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=polito.it header.i=@polito.it header.b="dxLPO9hU"
X-Original-To: linux-integrity@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11020077.outbound.protection.outlook.com [52.101.69.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FE3A10785
	for <linux-integrity@vger.kernel.org>; Sat,  3 Jan 2026 15:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767453514; cv=fail; b=CNJEUnIis/woEhkwCrZAuI3Iim2B2qWcMrQhoZbH7QtHw3dJaWWcsFB6PiFeKhJLa1OyodJKjQl/IrhtU1uOIRc8X2vSmpSxxKQWzCOg+CJ2bXfLWF4rdV33rdN759q61IcQ2qpENueHk1peuCq1bqOB02gaZQiBPvthl9G7rVQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767453514; c=relaxed/simple;
	bh=P9TA4qXMs+ETmj6Dg5TFUgJgnh4jQRyhyIkpXJcsC/g=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=HUdoIo2TmIArYF/oUOItkVdFwNQIFEDqO88iWt8pt1UlC+EgBidRt2+BwhOT1HONI5wWBCRG8CcLJUQiej7lhicZh+NHc7wvcMNXyeAL0c1l2DWVZQCenngdtfo5Ie6GEdnSyhokUZgSkREcwJ/82EUXp4ul/N2v1ya/UXVeZ2I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=polito.it; spf=pass smtp.mailfrom=polito.it; dkim=pass (1024-bit key) header.d=polito.it header.i=@polito.it header.b=dxLPO9hU; arc=fail smtp.client-ip=52.101.69.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=polito.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=polito.it
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fLBos8Ai1PxgfOYhDNpT32N8cRakcepDOEeNOMvVpXhlvov6Nim+Dt/Vu5sjxco5BiQNnSpL4HV9NBZuCSdKqpE1BlVviSTaDjHHBtF0w25FdxcKLVEEqGb+woQGIeqGPIDqK0ukhrpeU3jehfys/PpGM6spaZJOOE1f7tsd4oSk8RTR0AhTp+GK+s/yB/tI5ALDbUgT2UWLnj09APtA0ChZ+fgn+tMq62WGGg4+S93MWL7CUaonIVEALGCIKHPH1N4zh5ewPJk8jucdSRRC73JNzTXV97zzMmmE0h3XLrAD9ExBjTVeIsPO9JhZkmGuik5TsDBiFJCOiILYomAi5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P9TA4qXMs+ETmj6Dg5TFUgJgnh4jQRyhyIkpXJcsC/g=;
 b=daF5G9YZmQvw7B7iD34TKfejwswxqMDbyBjkQuFBlaWqwy/m/KNPRFl8YRGIsfVhyjM4/0A0c/HfGMLhHHMigDVTvvBmdVuWVx3SV187uaNZge9pzmR8KWkTEk9vN+U4CzmbxXcwB0wHP8K8OZyR/MigBGbUg+8y/1OihQGAOwVHgl3RNGdx6+FcNkeNw+mCsMzvosh3FYGHudGRlj8fghMu01YCHqQFKlGctjw8btL19kgZ7RPsQX/br2cDtcTXie+4X29z/9IGJt98cUTuCz4VuwrPLZKG0YCXephb7Zwkibcezgfa3H5eqv+Zkf/r3SCvS7nGvwlv/oVJhHaFIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=polito.it; dmarc=pass action=none header.from=polito.it;
 dkim=pass header.d=polito.it; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=polito.it;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P9TA4qXMs+ETmj6Dg5TFUgJgnh4jQRyhyIkpXJcsC/g=;
 b=dxLPO9hU6QpIjEcsuRJSRkNw1hJz9bRH/rhGj0ODb8/y/2XyFpjjXQxAOVvhI7Pdc4sR+XFXfLsTvk2O3gHUhEg443/Zr3FWxLhgZzzFQirxfZ3DKbjII1siwtCBKpAVJQt8E8h+25yMP5ZprYr4uQqmwUXiG2bOf8WIGT2OBOw=
Received: from DBBPR05MB6474.eurprd05.prod.outlook.com (2603:10a6:10:c8::12)
 by AM0PR05MB6818.eurprd05.prod.outlook.com (2603:10a6:20b:15f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Sat, 3 Jan
 2026 15:18:28 +0000
Received: from DBBPR05MB6474.eurprd05.prod.outlook.com
 ([fe80::a73d:a404:f0fd:dc2a]) by DBBPR05MB6474.eurprd05.prod.outlook.com
 ([fe80::a73d:a404:f0fd:dc2a%5]) with mapi id 15.20.9478.004; Sat, 3 Jan 2026
 15:18:28 +0000
From: "Enrico  Bravi" <enrico.bravi@polito.it>
To: "roberto.sassu@huawei.com" <roberto.sassu@huawei.com>,
	"linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
	"zohar@linux.ibm.com" <zohar@linux.ibm.com>, "dmitry.kasatkin@gmail.com"
	<dmitry.kasatkin@gmail.com>
CC: "eric.snowberg@oracle.com" <eric.snowberg@oracle.com>
Subject: Re: [RFC][PATCH v2 1/2] ima: measure loaded policy after write on
 securityfs policy file
Thread-Topic: [RFC][PATCH v2 1/2] ima: measure loaded policy after write on
 securityfs policy file
Thread-Index: AQHcbq2W85h//t/G60W4XZ1uktwhFLUpWaiAgBdRZYA=
Date: Sat, 3 Jan 2026 15:18:28 +0000
Message-ID: <22a3fe40aa1d67c4565ece43d7eea3b6b99e6d29.camel@polito.it>
References: <20250225131255.154826-1-enrico.bravi@polito.it>
			 <20251216165620.683529-2-enrico.bravi@polito.it>
		 <8808db9a7abcc3299b688537d19d53310be5c17e.camel@linux.ibm.com>
In-Reply-To: <8808db9a7abcc3299b688537d19d53310be5c17e.camel@linux.ibm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=polito.it;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DBBPR05MB6474:EE_|AM0PR05MB6818:EE_
x-ms-office365-filtering-correlation-id: 806603ee-f0fb-45dd-91b7-08de4adb58d2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|786006|366016|376014|1800799024|7142099003|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?dTh6YklFUWl2QzJMd0k4WStPdFk2bENKSVc1MjVxL0FoU0tzeUFWRVM5a1RB?=
 =?utf-8?B?MjRiZTZUVTczV1NDU251cWIwbksyRzNlYythbm5VM3lIamtQalp2cHJsM2pT?=
 =?utf-8?B?eGlpWHpnK3JOamhRTTRMc1hyY2x1bWFVRklQdHI4NDdzSHpKSlZRN2JZelZJ?=
 =?utf-8?B?ZDk1WDJwSFBaU0loNDM3K3ZXR0ZDWG9kbVpJT0dtelhxYzVtUXlPRVd3SVhs?=
 =?utf-8?B?M0hhUWYzUFBwTHhFOGRoS3JGdjZTN3pLS0tmcStpSWJwMlgwVVN1NVVSRHpt?=
 =?utf-8?B?QlkwVmkzbVlNd29oWVhXM0RBMktKWVh1MmFpVmkzODUwMEFpejZxTEpuMTRC?=
 =?utf-8?B?NzRxTEQxK2tKb2tNRS8yS0JKZ0pTR01IbmNoTUhFbzAwVVByZjRGQ21nMXNi?=
 =?utf-8?B?ajFsdW8vWVQvb0Z3VnlQUmdqQVpNaFZkMVVWeUVGbVQwdmlBNVB1dkdhUzlK?=
 =?utf-8?B?UFRJelZla3pqeVpBRG0wcUFxTXlqdHduaW0wbkhuTUpEWnB6ZXlsbzRiQ2g2?=
 =?utf-8?B?YVRuMzJzaHlLbWE0ckR4UWQwN2dyT3psWjhhK1JQVUlNMGo0QWdHUk1KeGxl?=
 =?utf-8?B?VWVydi9yYVpOamZ1SkY1YzNEQUlLRGZOeWFtOVl2OW9mTGQ0M1AyREZjUDFh?=
 =?utf-8?B?VjluTC9UN28zSFIwc0lVaGtBbEl6MUJaaHlxcEJsN0V0RkM4clJKc1d4Ymd1?=
 =?utf-8?B?alUxK3l4MnA3ei93c3NlUng4cUxEZEN3Y2txRWJmZlZlVkJYektBWE5mSGJr?=
 =?utf-8?B?RWlpRjdiQUVzRzl2bXFBQ1p5dm5mMEV6TmtDdGFia042RXJmeUJHNXNSVStF?=
 =?utf-8?B?b0VDaUFvTWxJNXgwMlhuUlBBbkx4QzJ1d3U0cG9KN2JLckZ4VXRhVG9Ed3Vk?=
 =?utf-8?B?ckZXWmtDMDhGNk1UOElZTGIra3RweGxFemQyYXpIZ0NsU3lnVTRyU2NKN0NG?=
 =?utf-8?B?L1ZrQ29HSzR2aEE4UEY2b3BuTVVVTjNia01hTDVVQVpnTTVOd25rQllwdGFh?=
 =?utf-8?B?NStnMi9STVVOM3ljRkFPNkN3L1NVdG1YR1ozZW9qb3FmNUlaN3RDY0tVU3p2?=
 =?utf-8?B?WklWRkxmUkFlSy9iRVFMbm56dHhna2tFRjZ6RGZyaHB6aHVLK2R5N2R4U0Nk?=
 =?utf-8?B?NEFHTFpybytjeXFRdjd6OHdYMnV3cTQwdFZuMWJMR2htcWZHRzFCNEJ6VG5t?=
 =?utf-8?B?L3gwendwa2NhUGpMUlJlcHhOS0NVVkp3Rm1jUENyYWFPYXhwdWsvMlFla2lx?=
 =?utf-8?B?b2pCMVNocXZOTVQvdTRRYndzNTViZ0FJTmZZWmV5aGIvbUMwSW9pUXlGVEFr?=
 =?utf-8?B?dms2SWlqN3pqUGdSSE9qcDNVeFUvbW9MaE9OcGhnTzJjei9OZTkrQTg5b2Y3?=
 =?utf-8?B?eEJsMDFHVHhvcUZna1RVck5xTkdCQTVIOXZ2TldUTitrcTNSQ1pkZ1BSc1h2?=
 =?utf-8?B?Y1VEV0IrZjRqd1NHQTQ5RHUxRldDNnFKTjZoN21obENxY2wzQnRzRDFRK3VM?=
 =?utf-8?B?dVdyNzhPMHMzRXZYd1NINWlMRXFUdmNSWHRyZ2p1VC9uQ2t1ZzNkSklHVFFz?=
 =?utf-8?B?QlMzUEhrSzc0WjVDZk05MitBdTMyeTRLamt2NU14TXBZU0k4RkRYRWVtOURK?=
 =?utf-8?B?Q3ZENUl1bEZtMStYZnJDbnFBL3Y4S3JzNXgvN0tiWDc2dDFSTHNkREp4SGhz?=
 =?utf-8?B?aWpSaFNFVmFDWnNQeGFFMi9TSVRnb3BQTDZZK0lFT3VpdVFzdGJqWkpyL2JO?=
 =?utf-8?B?REZvaVJIMDNCUm1ZUytnUzVDR1ZCY0swcXZ3ODVrTm9weUZVaHVGaUdDS1Vx?=
 =?utf-8?B?UWJGaVQvQ0poNlB1dGJyWHllajMwSlFpbjRmNlU1R09uSWJvdmJIMDdJRFF1?=
 =?utf-8?B?OE5JMHZUUXNDeWdpZE02eC9MZi8rRnNORklVZUlpc002TjQva0w4WHgvSGxn?=
 =?utf-8?B?V1M3TFBxd3dtOTBNVVROTkQ0VFpacWNuUnZMWndXNnIvbkczWTNkcDJLUHdI?=
 =?utf-8?B?TGM1NjEwMytQaVZYU1dBUGQwQU5CaG5XWmFqaVdacjg1TFc4TmtmdGw0cGk4?=
 =?utf-8?Q?xnldYU?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR05MB6474.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(786006)(366016)(376014)(1800799024)(7142099003)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Zjh6eVhEdjNnalBTdHYrK043UjJuZHRiUml5NC9oN2ZUcDVhUk9Qb0hleU1N?=
 =?utf-8?B?YnVaZEYxbGxtNjVibVZQY2FkZTJoZTYwZlZxcDJ1VnpwdHNCWkxKb09nMzg1?=
 =?utf-8?B?d2VyaGVkR29DS0xFTnI5SVBrRzl1VjZKZ2R2ZU1JUWIrMUtOZW8wZ21iUktJ?=
 =?utf-8?B?WDBJY3pXOHN4anRUbGs3UUt1S216VW5OZHdoOXBFZ3dxa2ZSVzB0L3RNcEpN?=
 =?utf-8?B?RjRtajJJcm1NNWVnanArSW1tcS9HWTE5UW1HWnB0Ny8yZW9KU2dVTk14TjBo?=
 =?utf-8?B?SllNMnFOaTlrZFVuYjkwQ1VMV3NneVRNd1QyNm94QlJLRlhVWGNRRTgzNjl5?=
 =?utf-8?B?bGpvQmxWRXJyODc4QnRWdDZEdTlQcXd6MngrOFhYZ0VNNnRYUkhGZHhaVmhQ?=
 =?utf-8?B?RitvaXE5MTJuMjlYQ01GOU1GUjhhT2xZTFFZODg3QVBOWFFEZnM1elh5T29F?=
 =?utf-8?B?TEtPcGtxZ0plVDFZRWhVNkd6aHptMWtncVVBd1M5MUoyT3pXVEdOYURYUTFt?=
 =?utf-8?B?VCswVmtCQmZWT01iZDdjQ1FZSldxZCtId3VyKzc4TVk4a1ZoSzh0bFRPck0r?=
 =?utf-8?B?WG1RSzdRNXFKYk1YVllkQkJNczMzTXVBbFFOdzV1T2w2VjI0dnlxZERwVjB4?=
 =?utf-8?B?d3VJd3JnaXkxS0hUUzk0alR4OWduUGJvWTRxLyswaXplbzVJNm9TWkYzM3Jo?=
 =?utf-8?B?R0Z6MGl5VGVzSVhwdm5mS3hKRUdMYkpoK2kvdmFWUktSK3RuTXhkUVBtb05I?=
 =?utf-8?B?WDdTY1VsaTBWaVpxcSsrRHRWbTRrNS9SM3BoYWdXVXR3QzliY0JBNXZKRnVx?=
 =?utf-8?B?M0xuSXQyQ3pBd2tvVTJML2czYWxvdFIvWHhRcGFwYUZNZVNIUWZDUjRTY2Vt?=
 =?utf-8?B?ei96S1laODV4WXk4aTFhcysyNEZOQ3R2QkhELzBvMFFNdVZoNnJZU1FmUVhH?=
 =?utf-8?B?STQ3Q2YvZm5MSWZtb01lQUdQWlRYWXU0QWhZV1llVGR1RmRrd0tuR3dnajVP?=
 =?utf-8?B?U0tMS0l2cjZiV05RTzJuZFZkT3FkeW1qLzRNR09GQk93Qzl6czYzOU1MdWpr?=
 =?utf-8?B?Y1NCTFR0VXF6WlZMOVFJUi9zU0FGU0ZzNjBPTWhjZ2ZaZnNRZjlOVm1wSVBP?=
 =?utf-8?B?YlIzN3g5V3ZueVZSeURtZnZVS3d4MjBGK2w5cmpReVB0MEJqcGQxWm5KZkVh?=
 =?utf-8?B?TW1hOVlYUEZreHlFK1NiZmYrKy9xVzQ5WHJJdmQ0bmZSSDJNWWtMeXNTMzIy?=
 =?utf-8?B?bFpOSTBicmltWW9yMFVxb09Pd1pkLzdGTzNDdDliTnd0WTdGTTJnVTZPSG9m?=
 =?utf-8?B?dVVmd29OaSsrWFVuRDFjKzUwa0tLN2tBTmZxWVNmNDA1TlRZQzlCZWJtM1NO?=
 =?utf-8?B?VWVpZGVLLzBaSEVwdjR6YUtFUldsdVJ2Z3FXL0hWTmV4ZkNXWk9JcDlBNTBI?=
 =?utf-8?B?QmtVUDVUODRFUmx0YWo4bDF4NXdKbHZzci9xV203ZmZ2R3NQZEJ3ZDZuYzBv?=
 =?utf-8?B?ejBlNjZ4Qzg0RjVYV0VqZjkrWm9RYVF0dk8vU2VZOFF3YkFpQkxXcEYvNWxM?=
 =?utf-8?B?MmNVWFJjQnBkdjgrTkQ0U1JGZjlGMlNJaTk3ZUFwbXJJT0YwRlRuUWdTWllO?=
 =?utf-8?B?UzUzcXpIeVA0UThZWVo0USsrMDN2UnM1RHplL0pqTFcwM0pDWmJORDlOU1p0?=
 =?utf-8?B?UXNiNHY3S0YwckZuNURER21GeW5jY2xLNExwQmkwdGpFV01wbkEzcUtTZTdt?=
 =?utf-8?B?QVJuNkJQaUJxUHJWNExaLzFweGJtREU4WUs3SmZ1WjdxNzNhYm1LcTNRZUw2?=
 =?utf-8?B?Nk53U1BiYWZGTWdLbkp3UjA1Zm5uaEIwQUxLWHhLTkRZZG1Zd053Vjd1TDY1?=
 =?utf-8?B?NDR0a1NzQllla01QblNNQjZxRlJGUXQ5WFcvSkdvSGRHQi9kSDlTRHFwWWsv?=
 =?utf-8?B?QWZ0cEtmWkluWVdvQ3E5RHNmT296bE5vWkdTRWl4M3RqZytTZE41eGExZ1h3?=
 =?utf-8?B?ZnVFL2Yxa2cySzVldlNUem9RMVNTRXVqTEF5UTk2clBLNzUxWUwwNzYrNGM1?=
 =?utf-8?B?cjcrTFhwL2FiQTIzZlVwRjhBWHpwaHNUM1lpbGdFcUh0YTBMZVd2R2JXVUhj?=
 =?utf-8?B?RVJYNG84UTI4OVNPOXJndE4wdU1SL050ajF0ZXR2MUtTek0wanMxeGhFWjFV?=
 =?utf-8?B?SUZTM1IxeTBlbDBheTY4RGluZEQ0dTgzeFMweGQwWDlLNTU3ckZ2WWdOa0pE?=
 =?utf-8?B?WjUrb2ZQRWJPNVFyL3RGMHE0dHcvZHU5UEhYRUVyWFhIdGtOWThESGo3aFRu?=
 =?utf-8?B?SWsxa1lWZHh4RXFoYmRCNHRBclM1TmtIN3ByS2drRWVDTnJMT1FJQT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <20EE3446CE52D147A3DDB2976DCD812D@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: polito.it
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DBBPR05MB6474.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 806603ee-f0fb-45dd-91b7-08de4adb58d2
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jan 2026 15:18:28.1147
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 2a05ac92-2049-4a26-9b34-897763efc8e2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +FVmlKIqai9nCxcB5xevYiQNxgDWVIyob8d5FSE4SNb7oan7eaIgtgeqEb6I5p0i10OsklVvWlKhMqd+7zXvmw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR05MB6818

T24gRnJpLCAyMDI1LTEyLTE5IGF0IDE0OjEzIC0wNTAwLCBNaW1pIFpvaGFyIHdyb3RlOg0KPiBP
biBUdWUsIDIwMjUtMTItMTYgYXQgMTc6NTYgKzAxMDAsIEVucmljbyBCcmF2aSB3cm90ZToNCj4g
PiBJTUEgcG9saWN5IGNhbiBiZSB3cml0dGVuIG11bHRpcGxlIHRpbWVzIGluIHRoZSBzZWN1cml0
eWZzIHBvbGljeSBmaWxlDQo+ID4gYXQgcnVudGltZSBpZiBDT05GSUdfSU1BX1dSSVRFX1BPTElD
WT15LiBXaGVuIElNQV9BUFBSQUlTRV9QT0xJQ1kgaXMNCj4gPiByZXF1aXJlZCwgdGhlIHBvbGlj
eSBuZWVkcyB0byBiZSBzaWduZWQgdG8gYmUgbG9hZGVkLCB3cml0aW5nIHRoZSBhYnNvbHV0ZQ0K
PiA+IHBhdGggb2YgdGhlIGZpbGUgY29udGFpbmluZyB0aGUgbmV3IHBvbGljeToNCj4gPiANCj4g
PiBlY2hvIC9wYXRoL29mL2N1c3RvbV9pbWFfcG9saWN5ID4gL3N5cy9rZXJuZWwvc2VjdXJpdHkv
aW1hL3BvbGljeQ0KPiA+IA0KPiA+IFdoZW4gdGhpcyBpcyBub3QgcmVxdWlyZWQsIHBvbGljeSBj
YW4gYmUgd3JpdHRlbiBkaXJlY3RseSwgcnVsZSBieSBydWxlOg0KPiA+IA0KPiA+IGVjaG8gLWUg
Im1lYXN1cmUgZnVuYz1CUFJNX0NIRUNLIG1hc2s9TUFZX0VYRUNcbiIgXA0KPiA+IMKgwqDCoMKg
wqDCoMKgICJhdWRpdCBmdW5jPUJQUk1fQ0hFQ0sgbWFzaz1NQVlfRVhFQ1xuIiBcDQo+ID4gwqDC
oMKgwqAgPiAvc3lzL2tlcm5lbC9zZWN1cml0eS9pbWEvcG9saWN5DQo+ID4gDQo+ID4gSW4gdGhp
cyBjYXNlLCBhIG5ldyBwb2xpY3kgY2FuIGJlIGxvYWRlZCB3aXRob3V0IGJlaW5nIG1lYXN1cmVk
IG9yDQo+ID4gYXBwcmFpc2VkLg0KPiA+IA0KPiA+IEFkZCBhIG5ldyBjcml0aWNhbCBkYXRhIHJl
Y29yZCB0byBtZWFzdXJlIHRoZSB0ZXh0dWFsIHBvbGljeQ0KPiA+IHJlcHJlc2VudGF0aW9uIHdo
ZW4gaXQgYmVjb21lcyBlZmZlY3RpdmUuDQoNCkhpIE1pbWksDQoNCnNvcnJ5IGZvciB0aGUgZGVs
YXkgaW4gYW5zd2VyaW5nIHlvdS4NCg0KPiBUaGUgSU1BIHBvbGljeSBjb3VsZCBiZSByZWFsbHkg
bGFyZ2UuwqAgRG8gd2UgcmVhbGx5IHdhbnQgdG8gaW5jbHVkZSBhbGwgdGhlDQo+IHBvbGljeSBy
dWxlcyBpbiB0aGUgdGVtcGxhdGUgZGF0YT/CoCBUaGUgb3RoZXIgb3B0aW9uIHdvdWxkIGJlIHRv
IGluY2x1ZGUgYQ0KPiBoYXNoIG9mIHRoZSBwb2xpY3kgcnVsZXMsIGluIGxpZXUgb2YgdGhlIHBv
bGljeSBydWxlcyB0aGVtc2VsdmVzLg0KDQpJIHRob3VnaHQgdG8gaW5jbHVkZSBhbGwgdGhlIHBv
bGljeSBydWxlcyBiZWNhdXNlIHRoZSBwb2xpY3kgY2FuIGJlIGRlZmluZWQNCnVzaW5nIHRoZSBz
YW1lIHJ1bGVzIGluIGEgZGlmZmVyZW50IG9yZGVyLiBGb3IgbGFyZ2UgcG9saWN5IHRoaXMgd291
bGQgbWVhbiB0aGF0DQphIHZlcmlmaWVyIHNob3VsZCBoYXZlIHNldmVyYWwgaGFzaCB2YWx1ZXMg
Zm9yIHRoZSBzYW1lIHBvbGljeS4NCg0KPiBQbGVhc2UgaW5jbHVkZSBkaXJlY3Rpb25zIGZvciB2
ZXJpZnlpbmcgdGhlIGNyaXRpY2FsLWRhdGEgKGUuZy4gdXNpbmcgeHhkKS4NCg0KWWVzLCBzdXJl
Lg0KDQo+ID4gDQo+ID4gU2lnbmVkLW9mZi1ieTogRW5yaWNvIEJyYXZpIDxlbnJpY28uYnJhdmlA
cG9saXRvLml0Pg0KPiA+IC0tLQ0KPiA+IMKgc2VjdXJpdHkvaW50ZWdyaXR5L2ltYS9pbWEuaMKg
wqDCoMKgwqDCoMKgIHzCoCAxICsNCj4gPiDCoHNlY3VyaXR5L2ludGVncml0eS9pbWEvaW1hX2Vm
aS5jwqDCoMKgIHzCoCAxICsNCj4gPiDCoHNlY3VyaXR5L2ludGVncml0eS9pbWEvaW1hX2ZzLmPC
oMKgwqDCoCB8wqAgMSArDQo+ID4gwqBzZWN1cml0eS9pbnRlZ3JpdHkvaW1hL2ltYV9wb2xpY3ku
YyB8IDYzICsrKysrKysrKysrKysrKysrKysrKysrKysrKystDQo+ID4gwqA0IGZpbGVzIGNoYW5n
ZWQsIDY0IGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQo+ID4gDQo+ID4gZGlmZiAtLWdp
dCBhL3NlY3VyaXR5L2ludGVncml0eS9pbWEvaW1hLmggYi9zZWN1cml0eS9pbnRlZ3JpdHkvaW1h
L2ltYS5oDQo+ID4gaW5kZXggZTNkNzFkOGQ1NmUzLi5jYTdiOTY2NjM2MjMgMTAwNjQ0DQo+ID4g
LS0tIGEvc2VjdXJpdHkvaW50ZWdyaXR5L2ltYS9pbWEuaA0KPiA+ICsrKyBiL3NlY3VyaXR5L2lu
dGVncml0eS9pbWEvaW1hLmgNCj4gPiBAQCAtNDI1LDYgKzQyNSw3IEBAIHZvaWQgKmltYV9wb2xp
Y3lfc3RhcnQoc3RydWN0IHNlcV9maWxlICptLCBsb2ZmX3QgKnBvcyk7DQo+ID4gwqB2b2lkICpp
bWFfcG9saWN5X25leHQoc3RydWN0IHNlcV9maWxlICptLCB2b2lkICp2LCBsb2ZmX3QgKnBvcyk7
DQo+ID4gwqB2b2lkIGltYV9wb2xpY3lfc3RvcChzdHJ1Y3Qgc2VxX2ZpbGUgKm0sIHZvaWQgKnYp
Ow0KPiA+IMKgaW50IGltYV9wb2xpY3lfc2hvdyhzdHJ1Y3Qgc2VxX2ZpbGUgKm0sIHZvaWQgKnYp
Ow0KPiA+ICt2b2lkIGltYV9tZWFzdXJlX2xvYWRlZF9wb2xpY3kodm9pZCk7DQo+ID4gwqANCj4g
PiDCoC8qIEFwcHJhaXNlIGludGVncml0eSBtZWFzdXJlbWVudHMgKi8NCj4gPiDCoCNkZWZpbmUg
SU1BX0FQUFJBSVNFX0VORk9SQ0UgMHgwMQ0KPiA+IGRpZmYgLS1naXQgYS9zZWN1cml0eS9pbnRl
Z3JpdHkvaW1hL2ltYV9lZmkuYw0KPiA+IGIvc2VjdXJpdHkvaW50ZWdyaXR5L2ltYS9pbWFfZWZp
LmMNCj4gPiBpbmRleCAxMzgwMjliZmNjZTEuLjE5OWM0MmQwZjhiMyAxMDA2NDQNCj4gPiAtLS0g
YS9zZWN1cml0eS9pbnRlZ3JpdHkvaW1hL2ltYV9lZmkuYw0KPiA+ICsrKyBiL3NlY3VyaXR5L2lu
dGVncml0eS9pbWEvaW1hX2VmaS5jDQo+ID4gQEAgLTYyLDYgKzYyLDcgQEAgc3RhdGljIGNvbnN0
IGNoYXIgKiBjb25zdCBzYl9hcmNoX3J1bGVzW10gPSB7DQo+ID4gwqAgImFwcHJhaXNlIGZ1bmM9
UE9MSUNZX0NIRUNLIGFwcHJhaXNlX3R5cGU9aW1hc2lnIiwNCj4gPiDCoCNlbmRpZg0KPiA+IMKg
ICJtZWFzdXJlIGZ1bmM9TU9EVUxFX0NIRUNLIiwNCj4gPiArICJtZWFzdXJlIGZ1bmM9Q1JJVElD
QUxfREFUQSBsYWJlbD1pbWFfcG9saWN5IiwNCj4gDQo+IFdpdGggdGhpcyBydWxlLCB0aGUgcG9s
aWN5IHdpbGwgYWx3YXlzIGJlIG1lYXN1cmVkLCBldmVuIHdoZW4gbG9hZGluZyBhIHNpZ25lZA0K
PiBwb2xpY3kgZmlsZS7CoCBJdCB0aGF0IG5lY2Vzc2FyeT8NCg0KTm8geW91J3JlIHJpZ2h0LiBJ
IGNhbiBpbmNsdWRlIGl0IG9ubHkgaW4gdGhlIGNhc2UgdGhlIHBvbGljeSBpcyBub3QgYXBwcmlz
ZWQuDQoNCj4gPiDCoCBOVUxMDQo+ID4gwqB9Ow0KPiA+IMKgDQo+ID4gZGlmZiAtLWdpdCBhL3Nl
Y3VyaXR5L2ludGVncml0eS9pbWEvaW1hX2ZzLmMNCj4gPiBiL3NlY3VyaXR5L2ludGVncml0eS9p
bWEvaW1hX2ZzLmMNCj4gPiBpbmRleCA4NzA0NWIwOWYxMjAuLjg5OTQ2ZDgwM2Q0NCAxMDA2NDQN
Cj4gPiAtLS0gYS9zZWN1cml0eS9pbnRlZ3JpdHkvaW1hL2ltYV9mcy5jDQo+ID4gKysrIGIvc2Vj
dXJpdHkvaW50ZWdyaXR5L2ltYS9pbWFfZnMuYw0KPiA+IEBAIC00NzYsNiArNDc2LDcgQEAgc3Rh
dGljIGludCBpbWFfcmVsZWFzZV9wb2xpY3koc3RydWN0IGlub2RlICppbm9kZSwNCj4gPiBzdHJ1
Y3QgZmlsZSAqZmlsZSkNCj4gPiDCoCB9DQo+ID4gwqANCj4gPiDCoCBpbWFfdXBkYXRlX3BvbGlj
eSgpOw0KPiA+ICsgaW1hX21lYXN1cmVfbG9hZGVkX3BvbGljeSgpOw0KPiA+IMKgI2lmICFkZWZp
bmVkKENPTkZJR19JTUFfV1JJVEVfUE9MSUNZKSAmJiAhZGVmaW5lZChDT05GSUdfSU1BX1JFQURf
UE9MSUNZKQ0KPiA+IMKgIHNlY3VyaXR5ZnNfcmVtb3ZlKGZpbGUtPmZfcGF0aC5kZW50cnkpOw0K
PiA+IMKgI2VsaWYgZGVmaW5lZChDT05GSUdfSU1BX1dSSVRFX1BPTElDWSkNCj4gPiBkaWZmIC0t
Z2l0IGEvc2VjdXJpdHkvaW50ZWdyaXR5L2ltYS9pbWFfcG9saWN5LmMNCj4gPiBiL3NlY3VyaXR5
L2ludGVncml0eS9pbWEvaW1hX3BvbGljeS5jDQo+ID4gaW5kZXggMTI4ZmFiODk3OTMwLi45NTYw
NjM3NDgwMDggMTAwNjQ0DQo+ID4gLS0tIGEvc2VjdXJpdHkvaW50ZWdyaXR5L2ltYS9pbWFfcG9s
aWN5LmMNCj4gPiArKysgYi9zZWN1cml0eS9pbnRlZ3JpdHkvaW1hL2ltYV9wb2xpY3kuYw0KPiA+
IEBAIC0xNyw2ICsxNyw3IEBADQo+ID4gwqAjaW5jbHVkZSA8bGludXgvc2xhYi5oPg0KPiA+IMKg
I2luY2x1ZGUgPGxpbnV4L3JjdWxpc3QuaD4NCj4gPiDCoCNpbmNsdWRlIDxsaW51eC9zZXFfZmls
ZS5oPg0KPiA+ICsjaW5jbHVkZSA8bGludXgvdm1hbGxvYy5oPg0KPiA+IMKgI2luY2x1ZGUgPGxp
bnV4L2ltYS5oPg0KPiA+IMKgDQo+ID4gwqAjaW5jbHVkZSAiaW1hLmgiDQo+ID4gQEAgLTE5ODMs
NyArMTk4NCw2IEBAIGNvbnN0IGNoYXIgKmNvbnN0IGZ1bmNfdG9rZW5zW10gPSB7DQo+ID4gwqAg
X19pbWFfaG9va3MoX19pbWFfaG9va19zdHJpbmdpZnkpDQo+ID4gwqB9Ow0KPiA+IMKgDQo+ID4g
LSNpZmRlZiBDT05GSUdfSU1BX1JFQURfUE9MSUNZDQo+ID4gwqBlbnVtIHsNCj4gPiDCoCBtYXNr
X2V4ZWMgPSAwLCBtYXNrX3dyaXRlLCBtYXNrX3JlYWQsIG1hc2tfYXBwZW5kDQo+ID4gwqB9Ow0K
PiA+IEBAIC0yMjc3LDcgKzIyNzcsNiBAQCBpbnQgaW1hX3BvbGljeV9zaG93KHN0cnVjdCBzZXFf
ZmlsZSAqbSwgdm9pZCAqdikNCj4gPiDCoCBzZXFfcHV0cyhtLCAiXG4iKTsNCj4gPiDCoCByZXR1
cm4gMDsNCj4gPiDCoH0NCj4gPiAtI2VuZGlmIC8qIENPTkZJR19JTUFfUkVBRF9QT0xJQ1kgKi8N
Cj4gPiDCoA0KPiA+IMKgI2lmIGRlZmluZWQoQ09ORklHX0lNQV9BUFBSQUlTRSkgJiYNCj4gPiBk
ZWZpbmVkKENPTkZJR19JTlRFR1JJVFlfVFJVU1RFRF9LRVlSSU5HKQ0KPiA+IMKgLyoNCj4gPiBA
QCAtMjMzNCwzICsyMzMzLDYzIEBAIGJvb2wgaW1hX2FwcHJhaXNlX3NpZ25hdHVyZShlbnVtIGtl
cm5lbF9yZWFkX2ZpbGVfaWQNCj4gPiBpZCkNCj4gPiDCoCByZXR1cm4gZm91bmQ7DQo+ID4gwqB9
DQo+ID4gwqAjZW5kaWYgLyogQ09ORklHX0lNQV9BUFBSQUlTRSAmJiBDT05GSUdfSU5URUdSSVRZ
X1RSVVNURURfS0VZUklORyAqLw0KPiA+ICsNCj4gPiArc3RhdGljIHNpemVfdCBpbWFfcG9saWN5
X3RleHRfbGVuKHZvaWQpDQo+ID4gK3sNCj4gPiArIHN0cnVjdCBsaXN0X2hlYWQgKmltYV9ydWxl
c190bXA7DQo+ID4gKyBzdHJ1Y3QgaW1hX3J1bGVfZW50cnkgKmVudHJ5Ow0KPiA+ICsgc3RydWN0
IHNlcV9maWxlIGZpbGU7DQo+ID4gKyBzaXplX3Qgc2l6ZSA9IDA7DQo+ID4gKyBjaGFyIHJ1bGVb
MjU1XTsNCj4gPiArDQo+ID4gKyBmaWxlLmJ1ZiA9IHJ1bGU7DQo+ID4gKyBmaWxlLnJlYWRfcG9z
ID0gMDsNCj4gPiArIGZpbGUuc2l6ZSA9IDI1NTsNCj4gPiArIGZpbGUuY291bnQgPSAwOw0KPiA+
ICsNCj4gPiArIHJjdV9yZWFkX2xvY2soKTsNCj4gPiArIGltYV9ydWxlc190bXAgPSByY3VfZGVy
ZWZlcmVuY2UoaW1hX3J1bGVzKTsNCj4gPiArIGxpc3RfZm9yX2VhY2hfZW50cnlfcmN1KGVudHJ5
LCBpbWFfcnVsZXNfdG1wLCBsaXN0KSB7DQo+ID4gKyBpbWFfcG9saWN5X3Nob3coJmZpbGUsIGVu
dHJ5KTsNCj4gPiArIHNpemUgKz0gZmlsZS5jb3VudDsNCj4gPiArIGZpbGUuY291bnQgPSAwOw0K
PiA+ICsgfQ0KPiA+ICsgcmN1X3JlYWRfdW5sb2NrKCk7DQo+ID4gKw0KPiA+ICsgcmV0dXJuIHNp
emU7DQo+ID4gK30NCj4gPiArDQo+ID4gK3ZvaWQgaW1hX21lYXN1cmVfbG9hZGVkX3BvbGljeSh2
b2lkKQ0KPiA+ICt7DQo+ID4gKyBjb25zdCBjaGFyICpldmVudF9uYW1lID0gImltYV9wb2xpY3lf
bG9hZGVkIjsNCj4gPiArIGNvbnN0IGNoYXIgKm9wID0gIm1lYXN1cmVfbG9hZGVkX2ltYV9wb2xp
Y3kiOw0KPiA+ICsgY29uc3QgY2hhciAqYXVkaXRfY2F1c2UgPSAiRU5PTUVNIjsNCj4gPiArIHN0
cnVjdCBpbWFfcnVsZV9lbnRyeSAqcnVsZV9lbnRyeTsNCj4gPiArIHN0cnVjdCBsaXN0X2hlYWQg
KmltYV9ydWxlc190bXA7DQo+ID4gKyBzdHJ1Y3Qgc2VxX2ZpbGUgZmlsZTsNCj4gPiArIGludCBy
ZXN1bHQgPSAtRU5PTUVNOw0KPiA+ICsgc2l6ZV90IGZpbGVfbGVuID0gaW1hX3BvbGljeV90ZXh0
X2xlbigpOw0KPiANCj4gTm9ybWFsbHkgYSBmdW5jdGlvbiBpcyBkZWZpbmVkIHRvIHByZXZlbnQg
Y29kZSBkdXBsaWNhdGlvbiBvciBmb3IgcmVhZGFiaWxpdHkuDQo+IEluIHRoaXMgY2FzZSwgaXQg
ZG9lc24ndCBhY2hpZXZlIGVpdGhlci4NCg0KT2ssIHllcyB5b3UncmUgcmlnaHQuIEknbGwgbW92
ZSB0aGUgaW1hX3BvbGljeV90ZXh0X2xlbigpIGNvZGUgaW4NCmltYV9tZWFzdXJlX2xvYWRlZF9w
b2xpY3koKS4NCg0KVGhhbmsgeW91IHZlcnkgbXVjaCBmb3IgeW91ciBmZWVkYmFjay4NCg0KRW5y
aWNvDQoNCj4gQWRkIGEgY29tbWVudCBoZXJlLCBzb21ldGhpbmcgbGlrZToNCj4gLyogY2FsY3Vs
YXRlIElNQSBwb2xpY3kgcnVsZXMgbWVtb3J5IHNpemUgKi8NCj4gDQo+ID4gKw0KPiA+ICsgZmls
ZS5idWYgPSB2bWFsbG9jKGZpbGVfbGVuKTsNCj4gPiArIGlmICghZmlsZS5idWYpIHsNCj4gPiAr
IGludGVncml0eV9hdWRpdF9tc2coQVVESVRfSU5URUdSSVRZX1BDUiwgTlVMTCwgZXZlbnRfbmFt
ZSwNCj4gPiArIMKgwqDCoCBvcCwgYXVkaXRfY2F1c2UsIHJlc3VsdCwgMSk7DQo+ID4gKyByZXR1
cm47DQo+ID4gKyB9DQo+ID4gDQo+ID4gDQo+IA0KPiBBbmQgYW5vdGhlciBjb21tZW50IGJlbG93
LCBzb21ldGhpbmcgbGlrZToNCj4gLyogY29weSBJTUEgcG9saWN5IHJ1bGVzIHRvIGEgYnVmZmVy
ICovDQo+IA0KPiA+ICsNCj4gPiArIGZpbGUucmVhZF9wb3MgPSAwOw0KPiA+ICsgZmlsZS5zaXpl
ID0gZmlsZV9sZW47DQo+ID4gKyBmaWxlLmNvdW50ID0gMDsNCj4gPiArDQo+ID4gKyByY3VfcmVh
ZF9sb2NrKCk7DQo+ID4gKyBpbWFfcnVsZXNfdG1wID0gcmN1X2RlcmVmZXJlbmNlKGltYV9ydWxl
cyk7DQo+ID4gKyBsaXN0X2Zvcl9lYWNoX2VudHJ5X3JjdShydWxlX2VudHJ5LCBpbWFfcnVsZXNf
dG1wLCBsaXN0KSB7DQo+ID4gKyBpbWFfcG9saWN5X3Nob3coJmZpbGUsIHJ1bGVfZW50cnkpOw0K
PiA+ICsgfQ0KPiA+ICsgcmN1X3JlYWRfdW5sb2NrKCk7DQo+ID4gKw0KPiA+ICsgaW1hX21lYXN1
cmVfY3JpdGljYWxfZGF0YSgiaW1hX3BvbGljeSIsIGV2ZW50X25hbWUsIGZpbGUuYnVmLA0KPiA+
ICsgwqAgZmlsZS5jb3VudCwgZmFsc2UsIE5VTEwsIDApOw0KPiA+ICsNCj4gPiArIHZmcmVlKGZp
bGUuYnVmKTsNCj4gPiArfQ0KPiANCj4gVGhhbmtzLA0KPiANCj4gTWltaQ0K

