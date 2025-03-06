Return-Path: <linux-integrity+bounces-5131-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BFF2A54499
	for <lists+linux-integrity@lfdr.de>; Thu,  6 Mar 2025 09:21:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A975171D0D
	for <lists+linux-integrity@lfdr.de>; Thu,  6 Mar 2025 08:20:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 650931DDC18;
	Thu,  6 Mar 2025 08:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=polito.it header.i=@polito.it header.b="ebhl9MWE"
X-Original-To: linux-integrity@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2134.outbound.protection.outlook.com [40.107.22.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 626DB1A5B89
	for <linux-integrity@vger.kernel.org>; Thu,  6 Mar 2025 08:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.134
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741249232; cv=fail; b=E8EF1t9PHQnGnbioIoi3iYuu4vOfH0+yfEjX+fRsFz8hls8QTX/1XNlEoIpSw5QldXDxANGze3YAwHxnIQh2ASRziuP479NYdaiTvWjxGU66naOzOSHtTvt5OWHOQEskm8UUDffJTvCtw/XOtKIwhTafnh0kM/kVr5mjTJUHu8c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741249232; c=relaxed/simple;
	bh=J5Qh7aF6+MHsH3tG10AK9IdqIn1AV7P3JiSsoPyaeSI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=DkJQTeFQrbusJzQt5CQT+lLNrTbuO6meyS5ltRY17j7jvP1JvAmUvaffcmNUHEKORenHbfdRuDhmat20rrm/pP4Sox3Iw71JHeERTI5Ndvr/+dL5BNU/vLSbas719wJp7csspgrvH/rgImFpT4IEFOgg4S9H73MQtAVMu8OLqRc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=polito.it; spf=pass smtp.mailfrom=polito.it; dkim=pass (1024-bit key) header.d=polito.it header.i=@polito.it header.b=ebhl9MWE; arc=fail smtp.client-ip=40.107.22.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=polito.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=polito.it
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q5xxXTSwvP+ck/jThEbXDN+P+EI9Gqv+IiW4LuCeZJebKLufx2Lbp6WjsYTMVaS949bdITWsM2Dyy/83KMjU27QOE3YbZSxZh8TbR74u6SpXKxgwWzpV8FXE122qFut24T7LDM+KI26t15RH1Pr6Sf66DkfjG8NxrguSLUHNE2uKiTKQ7eq1d9skzKgSSv/qUpK6BNpewx52EJm60yWVeq9VgvEA6+0njYVqlIfdRFu+AjCSJcMgWIfHbkLoA0khUYuPswjgpxg1tUy6h/v3cn/eaxXyHGUkcNN4W0GsExA4kTbe0WvLXAq9swzTvtv+Lzvcv9sAo9MJBRPChgqLVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J5Qh7aF6+MHsH3tG10AK9IdqIn1AV7P3JiSsoPyaeSI=;
 b=Ix4IWU/4HLI30Hwi8emOGonBQoeNpjbqfAMs5c3D4HZpXENoZ3FtaZ+qcAiyTm+DWTfzSQZlSrsD0UAq5Fr/BA/cr7mP3yUynjXp6n/KO4yrzs7Ud5Hy8x2eXMZSy9vCcL0PbWfTY+womqEPCJ4MGYohK5t2YBtp22IHkXJnIYZVgft7vc9r7bnud8kUC3GwA0Uu3nj1kEXoaKm7snQSwLcxBV+ABLSPjtttS92mTVDXayihijWci84445gjztCDDDEvnpn4ALiEJTs48RtzXrKLCkGBaLLV1BAGmL+mHr4/RYkwajoLEzENaAjE8Agto9LrjGHgCDOt4PQtCNH6lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=polito.it; dmarc=pass action=none header.from=polito.it;
 dkim=pass header.d=polito.it; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=polito.it;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J5Qh7aF6+MHsH3tG10AK9IdqIn1AV7P3JiSsoPyaeSI=;
 b=ebhl9MWEGZXz3Io5hISxKQL2GvL/+lgEmbg5mce6Ll4tzbh6XtXUw4Bm/fEmi0vr0fV4hAs6/d8OIpmfx6Yrde4pbcQw2HK4ApcJOkG2LAPDly0fntioYozdrg6eK57U5zz4Xc0zXA1SsxlCwQUy8loTEoLBauSMfIt96oq8mf4=
Received: from AS2PR05MB9840.eurprd05.prod.outlook.com (2603:10a6:20b:5f5::20)
 by VI0PR05MB11505.eurprd05.prod.outlook.com (2603:10a6:800:242::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.17; Thu, 6 Mar
 2025 08:20:25 +0000
Received: from AS2PR05MB9840.eurprd05.prod.outlook.com
 ([fe80::237b:12ae:525c:3bbd]) by AS2PR05MB9840.eurprd05.prod.outlook.com
 ([fe80::237b:12ae:525c:3bbd%4]) with mapi id 15.20.8511.017; Thu, 6 Mar 2025
 08:20:25 +0000
From: "Enrico  Bravi" <enrico.bravi@polito.it>
To: "roberto.sassu@huawei.com" <roberto.sassu@huawei.com>,
	"linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
	"roberto.sassu@huaweicloud.com" <roberto.sassu@huaweicloud.com>,
	"zohar@linux.ibm.com" <zohar@linux.ibm.com>, "dmitry.kasatkin@gmail.com"
	<dmitry.kasatkin@gmail.com>
CC: "eric.snowberg@oracle.com" <eric.snowberg@oracle.com>
Subject: Re: [RFC][PATCH] ima: add measurement for first unverified write on
 ima policy file
Thread-Topic: [RFC][PATCH] ima: add measurement for first unverified write on
 ima policy file
Thread-Index:
 AQHbh4kqbfMU9EdEvEuw3vrfgofl17NY02GAgAFgF4CAAEZNAIAAjvoAgAA164CABf/RgIADDGSAgAGHRgA=
Date: Thu, 6 Mar 2025 08:20:25 +0000
Message-ID: <f0eb80a5e6e436721e22448de625951d60010013.camel@polito.it>
References: <20250225131255.154826-1-enrico.bravi@polito.it>
	 <ecc4630b5e3161736aa1e32f037facb9123025fc.camel@linux.ibm.com>
	 <013864bca0b53d65b9546125090c8d7776ee565a.camel@polito.it>
	 <9fb7a98bb88c05d953fd90c84c78af0bbd58df9b.camel@linux.ibm.com>
	 <484b1563482aca871a147daeff916fcb0730c6d6.camel@polito.it>
	 <2a6924b36ab41fd5d9666de726b9f4a0754b9cbb.camel@huaweicloud.com>
	 <091e810e9225014ab61fedd868f7fff70e864da4.camel@polito.it>
	 <4679907583cfe4d406d43f8e46bada6e9a23c096.camel@huaweicloud.com>
In-Reply-To: <4679907583cfe4d406d43f8e46bada6e9a23c096.camel@huaweicloud.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=polito.it;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS2PR05MB9840:EE_|VI0PR05MB11505:EE_
x-ms-office365-filtering-correlation-id: 86289b12-e9aa-40bb-8986-08dd5c87bf22
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?MVlTbk9RVmpUVXZmR2FWd1laN2x2K0RxVXMvVXM1R0FLMTJXa2hWUmxmRVFX?=
 =?utf-8?B?UU9ubHpxdVl3cS9DeHNqZzFmbGZRc2Ftc3ErOW1oRWV3ZHREV1BCMmVUWkk2?=
 =?utf-8?B?OVMwSjJkR21vV1cvWkJBby9vZWpaT25iWkRTSUI4WHRYTUhKRGpJZ0NQUWUw?=
 =?utf-8?B?cEdCQ3pBcnVvYW1kM05pVWZIdnhPclkxR0VzZzJCTHRNY0xxNkpVZC93WjRw?=
 =?utf-8?B?aHpEN2ROaHF3d1pZeDFUSkQxcnV1bGJjd0dMUTJ2QUFZbTMxTEcvVVM4S1J3?=
 =?utf-8?B?SzJqRm14bUJWN2FianN6RXMrWEZzNzNJZm1CTFdISHVtblN5NXZFNnJHOTA0?=
 =?utf-8?B?dDZOUnQ0dGpNTHlNZEJVdmkxbjArcGpvTG5XTEg5M3JBSTJiYkl1M3B2clJQ?=
 =?utf-8?B?ZlIrUzVMY3BnaXVxTHNsYXVoT1I1TlZVcm5xN0l2S3EvdzVjMDVOeTRWai9w?=
 =?utf-8?B?T1ZVQUxkczhjNm1ZOHhLdTNoOGZ1U2gwTlRRajI5b1ZsNzAvR2svQlZUVDJW?=
 =?utf-8?B?Y3ZHVDRNbi9ZR0hNaTV2NzNJdkpCeHIvd2VsUDJuaTFaVlJldVdDdG94N2pp?=
 =?utf-8?B?cktWNlluYyt3bVdEME1qb3hBR0J4V1BReU1NVCtjZUw4SG9kZTFtbFIvVXdL?=
 =?utf-8?B?UW9GMk5UQm1pU1RWMGpMek5KUG15c1gzY1BMK2RISG9ZWjZuOTdTK2hHclh5?=
 =?utf-8?B?c256UnE2NlJxbi9QMzNDamxFZFlZTlQ3dlNiaUhVWEpNR2JzaVRtVFZsSnor?=
 =?utf-8?B?YlpoT0RUZXJ2MWYyYTE2V0ZPMXA0UGErQzV6azloeGE3T1puc2RldTIxVnFR?=
 =?utf-8?B?S2t1RVZSRS8zNlVvWHBzODVzT2ZmWmxhWW1IQS9zSFRrWUk0b1FqTm1QTFk3?=
 =?utf-8?B?b0ZFRE52TmtidDBES1hsZnRnSkY2SkEzaE5ta051MkZGZEd1SDhCMGZyUVRV?=
 =?utf-8?B?Ym80R21MS2RTdE11b2lDTTZNOEd3UGlOTTBrZit6cXJ6aDNEMVdMWlBBMmlS?=
 =?utf-8?B?dGJnSUdwL0lvK3NkUCtlVkRQNUNBYXJrSDJiUXdTQjJZQ2d6WEQzNkh1cU9O?=
 =?utf-8?B?aWdYUVQ1ZXZKcDNzU3BNV01sVlJxVmUwK3V6MjNieTJVYTllVGM3dzFsdHVL?=
 =?utf-8?B?dHovWmVtWjV2K3BmOFNaRGJmT0krNDRqcEQ1QzFCK2EyYjdHTWFRYy81NlBN?=
 =?utf-8?B?SWtiTlpmbzFwTk5PdXZJdkMwam5lRWN2YnRBVUtuZWphbXJISFdjREhBZ3Nl?=
 =?utf-8?B?UEwzK0FXcG5Fb0VVMkM0eEZ4NWFDbVBZb3E4MW5OVktTYTFkNmlvUkRHdjRQ?=
 =?utf-8?B?dkRoWXRtelh6YmJlaUcwaGtPSmEyTC9XV0ZiclB6ZXVXM1hiNTlBenphRDk4?=
 =?utf-8?B?YXprWWYwVkJtVENDcWpLSXJLbERic25FeTZmaE9yQnZIY2ltSFIxbHkzeE5H?=
 =?utf-8?B?V2JQdXdYbGdQWURMRFNDOE52L1M1Tk1lYjdLbVp4Ym9EbWVadlVoZ3ZSQUhF?=
 =?utf-8?B?VmQ0RFlkdFhvTDRzd2Nyck05aHgrT0RvWVd4M2tXeGpaU3VNWUtLdzJPMkdX?=
 =?utf-8?B?MlJRblZoSTgrUHNzcnJyYzczT2w5emF2RDVPVk1LMkdTdkkvTE5CVEJZSGpZ?=
 =?utf-8?B?VFdkNWJJT1R1aGN5WjhiNEJZbElPV3FzNUIyT1FNL2xBbUJKTk0raVgvOTlK?=
 =?utf-8?B?bEVGMzgxYUU5ZFVrNDVrY2NOQXUyM1hsNUhaaVhHbTBVdFlNNGZ3S3lZQU4z?=
 =?utf-8?B?d2JhT1owOGhaWnVmRUY4U2lQeUVpbFBneW5PNDlGZUNzYkpZUG9EbzJ0QWlo?=
 =?utf-8?B?dWFyZUM1dzB2TkY5UzRucDdQVXN0Rjd4N1VTNklxRXhoNGR2ekxNd1BFaW1k?=
 =?utf-8?B?OWFibEpNNHltQmozWVM2WkFyRFd0UVhTYm5yOG5NMGJKOHpPN2UzcTBlM214?=
 =?utf-8?Q?iekLegIae1PTkszVH/y320D5z1ZDpg/s?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS2PR05MB9840.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Qi8zajViTVA4VGxsejF1dmRoM2lLRDJsMEpHRG9ON1JyNXZIMk1xTzJvTExy?=
 =?utf-8?B?Qi9wdXA0L2F3bGp6YUFSdTJrM0trMktpbkZUZWxvK21JVkdQQWM0U0FNWW9Z?=
 =?utf-8?B?R1dJOUdqcFhSQWZrOUVraFgxTktlNHZ3am41cXJlNW5SZ09FclUzZk5jL0M0?=
 =?utf-8?B?RXB0Sm1Oak5GcnJyYURNYjdCaVNKNmNicmRCbCtJZUJtMUUxZkp4NU52UzVQ?=
 =?utf-8?B?UGUyeUk1Z2NYcFFJUGRwbkJOdEZReGVSVUNldkFkZE1VakMzcFJEUkVucENU?=
 =?utf-8?B?a3pBVUFFckJVZ29zTkdDcEZlMUVzVllRMjVKejZwTkozSk50eXU1enQyK0Qx?=
 =?utf-8?B?M3lzV1ppQVNyd0xFS1gvR2tZVE1XRTRHQVpCLzNPOXZCd3drOWZHaUU2ODdX?=
 =?utf-8?B?dFZRY3c5RFMvRHR5Zk91bG1UYWo5NEl4WXI1OWcyOWNCdCsyYVlqLzNrQlY2?=
 =?utf-8?B?WFNGS2ZWUW5yWTM4QjV4d1BRV0RvRmpNNzI4RTRINTkrZTR3RDZqYnA0RDJU?=
 =?utf-8?B?S0VtNXo3R3VSNEFVdll4RENGYnJQTE9qZFV1UmtLdjhSdjI3NWx0RkNDak9v?=
 =?utf-8?B?LzRuUC9RQ1NXRFUyQml3SFQ1d3NINUJPR2JMc2dIaU1ha0p0dm1vSEFMdmth?=
 =?utf-8?B?NHU5UDRzN2VGSTZxZnN2eFZJOWcrT2ZCdjd0SHREV2dtVDB3R21OZVRibGls?=
 =?utf-8?B?Vzg2c0k0NmU4SStmcjNMNm5odWRMbjNxejEwNlNoZ2ltdzRLK1N3Ull3L2Vo?=
 =?utf-8?B?RlY4cXRFMzllRUh5N2xML2crdzNKRkI3UEhWYlN2b0lZWllEMHIvUE9iMmxW?=
 =?utf-8?B?TS9iVXNZZmZjS1VtWVlNSzZMelVmcHk3eElpak9NaGw0NWkyUWZLRVh4TkVG?=
 =?utf-8?B?ZTJTOEh4VjlyY3BCVkxlNkZrMUxTdkVtTFI5WUtOUmFmZkUzdk5iTjh5NVNM?=
 =?utf-8?B?bE0xVXgyU3FrTEE4QVB3bHpsMFBKdFI5b203Yk9PWDBZZEdWaUZSbVZ3eTVW?=
 =?utf-8?B?ZzMrYlZrTTZiSFBxUmgxWDRRdjFQVWNvd0tlKytiYVltNE5mREloZDlBQk5C?=
 =?utf-8?B?bjNWeGdpU0ZVY0VBc2JzRDEzTDlPM0lhUENva2d5VUVsOUpLK2tYVUN3TVF4?=
 =?utf-8?B?Sml3YkhyWVNoVG0rVjd3N2pnUVEvRnkzRS91ektHbVFZL0tkNVFZVVVtMUln?=
 =?utf-8?B?N2NTUTE0Sk5GcVNPcjVoY1czL0hhcENCS2lCTkJMdEFubWZXTUpnbXV0OWF6?=
 =?utf-8?B?Vm93NllUUVI3cW1jYXpvRTJHdGtxejA2RnBtZVB1M3NFVjdhOVJBOUV2YmdY?=
 =?utf-8?B?MDF2ZDRyZmNpOERlY1JJYWI2Zlo3c1VSb3A0VGU1aHIzUWRuenJQN1VGQ2Ex?=
 =?utf-8?B?eElUTEtXWnlxSXJqYjBnN2lQMzNNMVI3RFcxWEpwQnVCbFp0MytDdFJtc00y?=
 =?utf-8?B?Kzk1WHRNcUJybVlkMCtmZGZJaURkVzFUMVhzRGl4d1NRVE1WTHhHd29Kbng0?=
 =?utf-8?B?bmMxclF5VXhUdDhzRTA4c1Q2eWtub01RMjJubmFMOUhjNnk4U2xpZGgvUWZ2?=
 =?utf-8?B?QzZHYWw3N3NEOWlWK1Z6Zm95NWd3aDZjejBySTZ0QUxSNnkwYVFsclNYNE1V?=
 =?utf-8?B?OGhidWtEelJKckZXSHNGYjV0SXhKYWt2bWgwWXdTMzVLNHBVUEExcWtuNm5s?=
 =?utf-8?B?MXV1K1EyQUxMaVNRYTc3ejd3NjBzVUlIRjc2QXFiUVFPcEYvaW1WeEhzV1Zo?=
 =?utf-8?B?WDU5dHpMSDlIbFpmUlFpSXM4aExKSFh4SXZWSzVzd043Sjg2NEZBU2ZIdHQr?=
 =?utf-8?B?SmIwY3NsdzZ5R3VpUDFzb1RjeW0xcU1SOXg5aWJXMlVaTGROZzJTblp2MUlW?=
 =?utf-8?B?cnlVaW85enRFODIza04zdFYzREdLS2JZcXl4OTRJRkZMeHNiMUhON3daTjBR?=
 =?utf-8?B?eHJwaW96WVhSZzBjUThTZXB1Q0FWdTNWNlNzRjZNdXVtMFZhUDlJS1EzYVgz?=
 =?utf-8?B?aFRDa0g0UHdFYnR6ZHNDcXNWQkxpZGVHMGNWSzhmRjhlRVhqd2s4QkQvZkpQ?=
 =?utf-8?B?Smw5M3ZLRWhGZlBIVW93NUtybVhXUFZlNWFYUjJ4NWlyMU9yNkVkSlZKTHJF?=
 =?utf-8?B?dzczV2JlS041OXEyYzZnQ010TGMxU0lrQ1JBOTlNTThGaFJ0WW44UFdua2g2?=
 =?utf-8?B?SUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E979A24D20301245BC8FC9BB7DAAEBB1@eurprd05.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 86289b12-e9aa-40bb-8986-08dd5c87bf22
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Mar 2025 08:20:25.3200
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 2a05ac92-2049-4a26-9b34-897763efc8e2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 44iAk0Lrd8SrMLYCRhLi7U/FugGxyYYaA2mtvU7vEN9KG7lMEuQz4ZyQ4fJfgPTKblFmP5SOe8fuNvl73w5jxQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR05MB11505

T24gV2VkLCAyMDI1LTAzLTA1IGF0IDA5OjU5ICswMTAwLCBSb2JlcnRvIFNhc3N1IHdyb3RlOg0K
PiBPbiBNb24sIDIwMjUtMDMtMDMgYXQgMTA6MjYgKzAwMDAsIEVucmljb8KgIEJyYXZpIHdyb3Rl
Og0KPiA+IE9uIFRodSwgMjAyNS0wMi0yNyBhdCAxNTo0OSArMDEwMCwgUm9iZXJ0byBTYXNzdSB3
cm90ZToNCj4gPiA+IE9uIFRodSwgMjAyNS0wMi0yNyBhdCAxMTozNiArMDAwMCwgRW5yaWNvwqAg
QnJhdmkgd3JvdGU6DQo+ID4gPiA+IE9uIFdlZCwgMjAyNS0wMi0yNiBhdCAyMjowNSAtMDUwMCwg
TWltaSBab2hhciB3cm90ZToNCj4gPiA+ID4gPiBPbiBXZWQsIDIwMjUtMDItMjYgYXQgMjI6NTMg
KzAwMDAsIEVucmljb8KgIEJyYXZpIHdyb3RlOg0KPiA+ID4gPiA+ID4gT24gVHVlLCAyMDI1LTAy
LTI1IGF0IDIwOjUzIC0wNTAwLCBNaW1pIFpvaGFyIHdyb3RlOg0KPiA+ID4gPiA+ID4gPiBPbiBU
dWUsIDIwMjUtMDItMjUgYXQgMTQ6MTIgKzAxMDAsIEVucmljbyBCcmF2aSB3cm90ZToNCj4gPiA+
ID4gPiA+ID4gPiBUaGUgZmlyc3Qgd3JpdGUgb24gdGhlIGltYSBwb2xpY3kgZmlsZSBwZXJtaXRz
IHRvIG92ZXJyaWRlIHRoZQ0KPiA+ID4gPiA+ID4gPiA+IGRlZmF1bHQNCj4gPiA+ID4gPiA+ID4g
PiBwb2xpY3kgZGVmaW5lZCB3aXRoIHRoZSBpbWFfcG9saWN5PSBib290IHBhcmFtZXRlci4gVGhp
cyBjYW4gYmUNCj4gPiA+ID4gPiA+ID4gPiBkb25lDQo+ID4gPiA+ID4gPiA+ID4gYnkgYWRkaW5n
IHRoZSAvZXRjL2ltYS9pbWEtcG9saWN5IHdoaWNoIGFsbG93cyBsb2FkaW5nIHRoZQ0KPiA+ID4g
PiA+ID4gPiA+IGN1c3RvbQ0KPiA+ID4gPiA+ID4gPiA+IHBvbGljeQ0KPiA+ID4gPiA+ID4gPiA+
IGR1cmluZyBib290LiBJdCBpcyBhbHNvIHBvc3NpYmxlIHRvIGxvYWQgY3VzdG9tIHBvbGljeSBh
dA0KPiA+ID4gPiA+ID4gPiA+IHJ1bnRpbWUNCj4gPiA+ID4gPiA+ID4gPiB0aHJvdWdoDQo+ID4g
PiA+ID4gPiA+ID4gZmlsZSBvcGVyYXRpb25zOg0KPiA+ID4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+
ID4gPiA+IGNwIGN1c3RvbV9pbWFfcG9saWN5IC9zeXMva2VybmVsL3NlY3VyaXR5L2ltYS9wb2xp
Y3kNCj4gPiA+ID4gPiA+ID4gPiBjYXQgY3VzdG9tX2ltYV9wb2xpY3kgPiAvc3lzL2tlcm5lbC9z
ZWN1cml0eS9pbWEvcG9saWN5DQo+ID4gPiA+ID4gPiA+ID4gDQo+ID4gPiA+ID4gPiA+ID4gb3Ig
Ynkgd3JpdGluZyB0aGUgYWJzb2x1dGUgcGF0aCBvZiB0aGUgZmlsZSBjb250YWluaW5nIHRoZQ0K
PiA+ID4gPiA+ID4gPiA+IGN1c3RvbQ0KPiA+ID4gPiA+ID4gPiA+IHBvbGljeToNCj4gPiA+ID4g
PiA+ID4gPiANCj4gPiA+ID4gPiA+ID4gPiBlY2hvIC9wYXRoL29mL2N1c3RvbV9pbWFfcG9saWN5
ID4NCj4gPiA+ID4gPiA+ID4gPiAvc3lzL2tlcm5lbC9zZWN1cml0eS9pbWEvcG9saWN5DQo+ID4g
PiA+ID4gPiA+ID4gDQo+ID4gPiA+ID4gPiA+ID4gSW4gdGhlc2UgY2FzZXMsIGZpbGUgc2lnbmF0
dXJlIGNhbiBiZSBuZWNlc3NhcnkgdG8gbG9hZCB0aGUNCj4gPiA+ID4gPiA+ID4gPiBwb2xpY3kN
Cj4gPiA+ID4gPiA+ID4gPiAoZnVuYz1QT0xJQ1lfQ0hFQ0spLiBDdXN0b20gcG9saWN5IGNhbiBh
bHNvIGJlIHNldCBhdCBydW50aW1lIGJ5DQo+ID4gPiA+ID4gPiA+ID4gZGlyZWN0bHkNCj4gPiA+
ID4gPiA+ID4gPiB3cml0aW5nIHRoZSBwb2xpY3kgc3RyZWFtIG9uIHRoZSBpbWEgcG9saWN5IGZp
bGU6DQo+ID4gPiA+ID4gPiA+ID4gDQo+ID4gPiA+ID4gPiA+ID4gZWNobyAtZSAibWVhc3VyZSBm
dW5jPUJQUk1fQ0hFQ0sgbWFzaz1NQVlfRVhFQ1xuIiBcDQo+ID4gPiA+ID4gPiA+ID4gwqDCoMKg
wqDCoMKgwqDCoCJhdWRpdCBmdW5jPUJQUk1fQ0hFQ0sgbWFzaz1NQVlfRVhFQ1xuIiBcDQo+ID4g
PiA+ID4gPiA+ID4gwqDCoMKgwqAgPiAvc3lzL2tlcm5lbC9zZWN1cml0eS9pbWEvcG9saWN5DQo+
ID4gPiA+ID4gPiA+ID4gDQo+ID4gPiA+ID4gPiA+ID4gSW4gdGhpcyBjYXNlLCB0aGVyZSBpcyBu
byBtZWNoYW5pc20gdG8gdmVyaWZ5IHRoZSBpbnRlZ3JpdHkgb2YNCj4gPiA+ID4gPiA+ID4gPiB0
aGUNCj4gPiA+ID4gPiA+ID4gPiBuZXcNCj4gPiA+ID4gPiA+ID4gPiBwb2xpY3kuDQo+ID4gPiA+
ID4gPiA+ID4gDQo+ID4gPiA+ID4gPiA+ID4gQWRkIGEgbmV3IGVudHJ5IGluIHRoZSBpbWEgbWVh
c3VyZW1lbnRzIGxpc3QgY29udGFpbmluZyB0aGUNCj4gPiA+ID4gPiA+ID4gPiBhc2NpaQ0KPiA+
ID4gPiA+ID4gPiA+IGN1c3RvbQ0KPiA+ID4gPiA+ID4gPiA+IGltYSBwb2xpY3kgYnVmZmVyIHdo
ZW4gbm90IHZlcmlmaWVkIGF0IGxvYWQgdGltZS4NCj4gPiA+ID4gPiA+ID4gPiANCj4gPiA+ID4g
PiA+ID4gPiBTaWduZWQtb2ZmLWJ5OiBFbnJpY28gQnJhdmkgPGVucmljby5icmF2aUBwb2xpdG8u
aXQ+DQo+ID4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+ID4gPiBIaSBFbnJpY28sDQo+ID4gPiA+ID4g
PiANCj4gPiA+ID4gPiA+IEhpIE1pbWksDQo+ID4gPiA+ID4gPiANCj4gPiA+ID4gPiA+IHRoYW5r
IHlvdSBmb3IgdGhlIHF1aWNrIHJlc3BvbnNlLg0KPiA+ID4gPiA+ID4gDQo+ID4gPiA+ID4gPiA+
IFRoaXMgcGF0Y2ggc2V0IGhhcmQgY29kZXMgbWVhc3VyaW5nIHRoZSBpbml0aWFsIGN1c3RvbSBJ
TUEgcG9saWN5DQo+ID4gPiA+ID4gPiA+IHJ1bGVzDQo+ID4gPiA+ID4gPiA+IHRoYXQNCj4gPiA+
ID4gPiA+ID4gcmVwbGFjZSB0aGUgYnVpbHRpbiBwb2xpY2llcyBzcGVjaWZpZWQgb24gdGhlIGJv
b3QgY29tbWFuZCBsaW5lLsKgDQo+ID4gPiA+ID4gPiA+IElNQQ0KPiA+ID4gPiA+ID4gPiBzaG91
bGRuJ3QgaGFyZCBjb2RlIHBvbGljeS4NCj4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+ID4gTXkgZmly
c3QgYXBwcm9hY2ggd2FzIHRvIGRlZmluZSBhIG5ldyBjcml0aWNhbC1kYXRhIHJlY29yZCzCoA0K
PiA+ID4gPiANCj4gPiA+ID4gSGkgTWltaSwNCj4gPiA+ID4gDQo+ID4gPiA+ID4gSG9wZWZ1bGx5
IHRoZSBuZXcgY3JpdGljYWwtZGF0YSB3aWxsIGJlIG9mIHRoZSBlbnRpcmUgSU1BIHBvbGljeS4N
Cj4gPiA+ID4gDQo+ID4gPiA+IHllcywgYWJzb2x1dGVseS4NCj4gPiA+ID4gDQo+ID4gPiA+ID4g
PiBidXQgcGVyZm9ybWluZyB0aGUNCj4gPiA+ID4gPiA+IG1lYXN1cmVtZW50IGFmdGVyIHRoZSBj
dXN0b20gcG9saWN5IGJlY29tZXMgZWZmZWN0aXZlLCB0aGUNCj4gPiA+ID4gPiA+IG1lYXN1cmVt
ZW50DQo+ID4gPiA+ID4gPiBjb3VsZA0KPiA+ID4gPiA+ID4gYmUNCj4gPiA+ID4gPiA+IGJ5cGFz
c2VkIG9taXR0aW5nIGZ1bmM9Q1JJVElDQUxfREFUQSBpbiB0aGUgY3VzdG9tIHBvbGljeS4NCj4g
PiA+ID4gPiA+IA0KPiA+ID4gPiA+ID4gPiBJJ20gbm90IHF1aXRlIHN1cmUgd2h5IHlvdSdyZSBk
aWZmZXJlbnRpYXRpbmcgYmV0d2Vlbg0KPiA+ID4gPiA+ID4gPiBtZWFzdXJpbmcgdGhlIGluaXRp
YWwgYW5kIHN1YnNlcXVlbnQgY3VzdG9tIElNQSBwb2xpY3kgcnVsZXMuwqDCoA0KPiA+ID4gPiA+
ID4gDQo+ID4gPiA+ID4gPiBNeSBpbnRlbnRpb24gaXMgdG8gbWVhc3VyZSB0aGUgZmlyc3QgZGly
ZWN0IHdyaXRlIChsaW5lIGJ5IGxpbmUpIG9uDQo+ID4gPiA+ID4gPiB0aGUNCj4gPiA+ID4gPiA+
IHBvbGljeQ0KPiA+ID4gPiA+ID4gZmlsZSwgd2l0aG91dCBsb2FkaW5nIHRoZSBpbml0aWFsIGN1
c3RvbSBwb2xpY3kgZnJvbSBhIGZpbGUuIFRoaXMNCj4gPiA+ID4gPiA+IGNhc2UsDQo+ID4gPiA+
ID4gPiBpZg0KPiA+ID4gPiA+ID4gSSdtDQo+ID4gPiA+ID4gPiBub3Qgd3JvbmcsIGlzIG5vdCBj
b3ZlcmVkIGJ5IGZ1bmM9UE9MSUNZX0NIRUNLLg0KPiA+ID4gPiA+IA0KPiA+ID4gPiA+IFdoZW4g
c2VjdXJlIGJvb3QgaXMgZW5hYmxlZCwgdGhlIGFyY2ggc3BlY2lmaWMgcG9saWN5IHJ1bGVzIHJl
cXVpcmUNCj4gPiA+ID4gPiB0aGUNCj4gPiA+ID4gPiBJTUENCj4gPiA+ID4gPiBwb2xpY3kgdG8g
YmUgc2lnbmVkLsKgIFdpdGhvdXQgc2VjdXJlIGJvb3QgZW5hYmxlZCwgeW91J3JlIGNvcnJlY3Qu
IFRoZQ0KPiA+ID4gPiA+IGN1c3RvbQ0KPiA+ID4gPiA+IHBvbGljeSBydWxlcyBtYXkgZGlyZWN0
bHkgYmUgbG9hZGVkIHdpdGhvdXQgYmVpbmcgbWVhc3VyZWQuDQo+ID4gPiA+ID4gDQo+ID4gPiA+
ID4gV2h5IG9ubHkgbWVhc3VyZSAidGhlIGZpcnN0IGRpcmVjdCB3cml0ZSI/wqAgQWRkaXRpb25h
bCBjdXN0b20gcG9saWN5DQo+ID4gPiA+ID4gcnVsZXMNCj4gPiA+ID4gPiBtYXkNCj4gPiA+ID4g
PiBiZSBkaXJlY3RseSBhcHBlbmRlZCB3aXRob3V0IGJlaW5nIG1lYXN1cmVkLg0KPiA+ID4gPiAN
Cj4gPiA+ID4gWWVzLCB5b3UgcmlnaHQuIFRoZSBhaW0gd2FzIHRvIG1lYXN1cmUgKGF0IGxlYXN0
KSB0aGUgZmlyc3Qgb25lLCBiZWNhdXNlDQo+ID4gPiA+IGl0DQo+ID4gPiA+IHN1YnN0aXR1dGVz
IHRoZSBib290IHBvbGljeSwgYnV0IGlmIHlvdSBhcmUgb2sgd2l0aCBhZGRpbmcgYSBjcml0aWNh
bC0NCj4gPiA+ID4gZGF0YQ0KPiA+ID4gPiByZWNvcmQsIGl0IHdvdWxkIGJlIGRlZmluaXRlbHkg
YmV0dGVyLg0KPiA+ID4gDQo+ID4gPiBIaSBFbnJpY28NCj4gPiA+IA0KPiA+ID4gaW4gYWRkaXRp
b24gdG8gd2hhdCBNaW1pIHN1Z2dlc3RlZCwgSSBhbHNvIGxpa2UgdG8gaWRlYSB0aGF0IHRoZQ0K
PiA+ID4gUE9MSUNZX0NIRUNLIGhvb2sgY2F0Y2hlcyB0aGUgZGlyZWN0IHBvbGljeSBsb2FkaW5n
LiBUaGF0IHdvdWxkIG1lYW4NCj4gPiA+IHRoYXQgdGhvc2UgdXBkYXRlcyB3b3VsZCBiZSBzZWVu
IGlmIHRoZSAndGNiJyBJTUEgcG9saWN5IGlzIHNlbGVjdGVkLg0KPiA+IA0KPiA+IEhpIFJvYmVy
dG8sDQo+ID4gDQo+ID4gaW4gdGhpcyBjYXNlLCB3b3VsZG4ndCBiZSB1c2VkIHRoZSBjdXJyZW50
IHRlbXBsYXRlPyBXb3VsZG4ndCBiZSBiZXR0ZXIgdG8NCj4gPiB1c2UNCj4gPiB0aGUgaW1hLWJ1
ZiBpbiBvcmRlciB0byBpbmNsdWRlIHRoZSB0ZXh0dWFsIHBvbGljeSByZXByZXNlbnRhdGlvbj8N
Cj4gDQo+IEhpIEVucmljbw0KPiANCj4gSSB3b3VsZCB1c2UgdGhlIGN1cnJlbnQgdGVtcGxhdGUs
IEkgZG9uJ3QgZmluZCBhbnkgcGFydGljdWxhciBpc3N1ZXMNCj4gZm9yIGl0LiBTdXJlLCB3ZSBk
b24ndCBoYXZlIGEgZmlsZSB0byBtZWFzdXJlIGJ1dCB0aGVyZSBhcmUgb3RoZXIgY2FzZXMNCj4g
d2hlcmUgaW4gcHJvY2Vzc19tZWFzdXJlbWVudCgpIHdlIG1lYXN1cmUgYSBidWZmZXIgaW5zdGVh
ZCBvZiBhIGZpbGUNCj4gKHdoZW4gaXQgaXMgY2FsbGVkIGJ5IGltYV9wb3N0X3JlYWRfZmlsZSgp
KS4NCj4gDQo+IFdlIGNhbiBoYXZlIGJvdGggY3JpdGljYWwgZGF0YSBhbmQgUE9MSUNZX0NIRUNL
IG1lYXN1cmVtZW50Lg0KDQpIaSBSb2JlcnRvLA0KDQpzb3JyeSwgSSBkaWRuJ3QgZ2V0IHRoaXMg
cG9pbnQuIFdoYXQgZG8geW91IG1lYW4/DQoNCj4gPiBJbiBhZGRpdGlvbiwgdGhlcmUgd291bGQg
YmUgYSBuZXcgcmVjb3JkIGZvciBlYWNoIGxpbmUgb2YgdGhlIGlucHV0IGJ1ZmZlciwNCj4gPiBh
bmQNCj4gPiBtZWFzdXJpbmcgdGhlIGlucHV0IGJ1ZmZlciB3b3VsZCBwcm9kdWNlIGRpZmZlcmVu
dCBtZWFzdXJlbWVudHMgZm9yIHRoZSBzYW1lDQo+ID4gcmVzdWx0aW5nIHBvbGljeSBlbnRyeSwg
YmVjYXVzZSBkaWZmZXJlbnQgb3IgbXVsdGlwbGUgc2VwYXJhdG9ycyBjYW4gYmUNCj4gPiB1c2Vk
Lg0KPiA+IA0KPiA+IEkgb3B0ZWQgdG8gcGVyZm9ybSB0aGUgbWVhc3VyZW1lbnQgaW4gaW1hX3Jl
bGVhc2VfcG9saWN5KCkgYmVjYXVzZSBpcyB3aGVyZQ0KPiA+IHRoZQ0KPiA+IG5ldyBwb2xpY3kg
YmVjb21lcyBlZmZlY3RpdmUgYWZ0ZXIgaW1hX3VwZGF0ZV9wb2xpY3koKSBhbmQgY2FuIGJlIGRv
bmUgYQ0KPiA+IHNpbmdsZQ0KPiA+IG1lYXN1cmVtZW50IG9mIHRoZSBuZXcgcnVubmluZyBwb2xp
Y3kuDQo+IA0KPiBJIHdvdWxkIHNpbXBseSBtZWFzdXJlIHdoYXQgaXMgcGFzc2VkIHRvIGltYV93
cml0ZV9wb2xpY3koKSByZWdhcmRsZXNzDQo+IG9mIHdoZXRoZXIgdGhlIHBvbGljeSB3aWxsIGJl
IGFjY2VwdGVkIG9yIG5vdC4gVGhpcyBpcyBtb3JlIGluIGxpbmUNCj4gd2l0aCB0aGUgdHJ1c3Rl
ZCBjb21wdXRpbmcgcGFyYWRpZ20gb2YgbWVhc3VyZSAmIGxvYWQuIElmIHBvdGVudGlhbGx5DQo+
IHRoZXJlIGlzIGEgYnVnIGluIHRoZSBwb2xpY3kgY29kZSwgbWVhc3VyaW5nIHRoZSBwb2xpY3kg
YmVmb3JlIHdpdGggYQ0KPiB2dWxuZXJhYmxlIGtlcm5lbCB3b3VsZCBhbGxvdyB5b3UgdG8gc2Vl
IHRoZSBtZWFzdXJlbWVudC4gQWZ0ZXIsIGl0DQo+IGRlcGVuZHMgb24gdGhlIHNlcmlvdXNuZXNz
IG9mIHRoZSB2dWxuZXJhYmlsaXR5Lg0KDQpPayBwZXJmZWN0LCBJIGdldCB5b3VyIHBvaW50LiBU
aGFuayB5b3UgZm9yIHRoZSBleHBsYW5hdGlvbi4NCg0KRW5yaWNvDQoNCj4gUm9iZXJ0bw0KPiAN
Cj4gPiBUaGUgbWVhc3VyZW1lbnQgY291bGQgYmUgZG9uZSBhIGJpdCBlYXJsaWVyLCB3b3JraW5n
IG9uIGltYV9wb2xpY3lfcnVsZXMgYW5kDQo+ID4gaW1hX3RlbXBfcnVsZXMgKHdoaWNoIGJhc2lj
YWxseSBjb250YWlucyB0aGUgaW5wdXQgYnVmZmVyKSBiZWZvcmUgdGhlDQo+ID4gc3BsaWNpbmcs
DQo+ID4gc28gaXQgd291bGQgYmUgY29uc2lkZXJlZCB0aGUgY3VycmVudCBwb2xpY3kgYW5kIG5v
dCB0aGUgbmV3IG9uZS4gSW4gdGhpcw0KPiA+IGNhc2UsDQo+ID4gaXQgd291bGQgd29yayBhbHNv
IHdoZW4gaW1hX3BvbGljeT10Y2IgaXMgc2V0LCBhbmQgaXQgY291bGQgYmUgY2FsbGVkDQo+ID4g
cHJvY2Vzc19idWZmZXJfbWVhc3VyZW1lbnQoKSB3aXRoIFBPTElDWV9DSEVDSywgdG8gZ2V0IGEg
cmVjb3JkIHdpdGggdGhlDQo+ID4gZW50aXJlDQo+ID4gSU1BIHBvbGljeS4NCj4gPiBXaGF0IGRv
IHlvdSB0aGluayBhYm91dCBpdD8NCj4gPiANCj4gPiBCUiwNCj4gPiANCj4gPiBFbnJpY28NCj4g
PiANCj4gPiA+IEkgd291bGQgaGF2ZSByZWNvbW1lbmRlZCB0byB0cnkgdG8gYWRkIGEgcHJvY2Vz
c19tZWFzdXJlbWVudCgpIGNhbGwgaW4NCj4gPiA+IGltYV93cml0ZV9wb2xpY3koKSwgd2hlcmUg
dGhlIGJ1ZmZlciB0byBiZSBwcm9jZXNzZWQgaXMuDQo+ID4gPiANCj4gPiA+IEhvd2V2ZXIsIEkg
Z3Vlc3MgeW91IG5lZWQgdG8gaGF2ZSBhIHZhbGlkIGZpbGUgZGVzY3JpcHRvciBpbiBvcmRlciB0
bw0KPiA+ID4gdXNlIHRoYXQgZnVuY3Rpb24gKG1heWJlIGFuIGFub255bW91cyBpbm9kZT8pLg0K
PiA+ID4gaW1hX2NvbGxlY3RfbWVhc3VyZW1lbnQoKSBzaG91bGQgYmUgYWxyZWFkeSBhYmxlIHRv
IGhhbmRsZSBidWZmZXJzLA0KPiA+ID4gcGFzc2VkIGJ5IGltYV9wb3N0X3JlYWRfZmlsZSgpLg0K
PiA+ID4gDQo+ID4gPiBUaGFua3MNCj4gPiA+IA0KPiA+ID4gUm9iZXJ0bw0KPiA+ID4gDQo+ID4g
PiA+IFRoYW5rIHlvdSwNCj4gPiA+ID4gDQo+ID4gPiA+IEVucmljbw0KPiA+ID4gPiANCj4gPiA+
ID4gPiA+IA0KPiA+ID4gPiA+ID4gPiBDb25zaWRlciBkZWZpbmluZyBhIG5ldyBjcml0aWNhbC1k
YXRhIHJlY29yZCB0byBtZWFzdXJlIHRoZQ0KPiA+ID4gPiA+ID4gPiBjdXJyZW50DQo+ID4gPiA+
ID4gPiA+IElNQQ0KPiA+ID4gPiA+ID4gPiBwb2xpY3kNCj4gPiA+ID4gPiA+ID4gcnVsZXMuwqAg
QWxzbyBjb25zaWRlciBpbmNsdWRpbmcgdGhlIG5ldyBjcml0aWNhbC1kYXRhIHJ1bGUgaW4gdGhl
DQo+ID4gPiA+ID4gPiA+IGFyY2gNCj4gPiA+ID4gPiA+ID4gc3BlY2lmaWMgcG9saWN5IHJ1bGVz
Lg0KPiA+ID4gPiA+ID4gDQo+ID4gPiA+ID4gPiBJIHRoaW5rIHRoYXQgeW91ciBzdWdnZXN0aW9u
LCB0byBhZGQgdGhlIGNyaXRpY2FsLWRhdGEgcnVsZSBpbiB0aGUNCj4gPiA+ID4gPiA+IGFyY2gN
Cj4gPiA+ID4gPiA+IHBvbGljeQ0KPiA+ID4gPiA+ID4gcnVsZXMsIHNvbHZlcyB0aGUgcHJvYmxl
bXMgb2YgYnlwYXNzaW5nIHRoZSBtZWFzdXJlbWVudCBhbmQgaGFyZA0KPiA+ID4gPiA+ID4gY29k
aW5nDQo+ID4gPiA+ID4gPiBwb2xpY3kuDQo+ID4gPiA+ID4gPiANCj4gPiA+ID4gPiA+IFRoYW5r
IHlvdSB2ZXJ5IG11Y2ggZm9yIHlvdXIgZmVlZGJhY2suDQo+ID4gPiA+ID4gDQo+ID4gPiA+ID4g
WW91J3JlIHdlbGNvbWUuDQo+ID4gPiA+ID4gDQo+ID4gPiA+ID4gTWltaQ0KPiA+ID4gPiA+ID4g
DQo+ID4gPiA+IA0KPiA+ID4gDQo+ID4gDQo+IA0KDQo=

