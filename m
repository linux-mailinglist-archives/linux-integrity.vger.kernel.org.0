Return-Path: <linux-integrity+bounces-5293-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 48714A65AEC
	for <lists+linux-integrity@lfdr.de>; Mon, 17 Mar 2025 18:36:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B77F16677F
	for <lists+linux-integrity@lfdr.de>; Mon, 17 Mar 2025 17:36:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D3481A8F61;
	Mon, 17 Mar 2025 17:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=toradex.com header.i=@toradex.com header.b="L07/JWne"
X-Original-To: linux-integrity@vger.kernel.org
Received: from de-smtp-delivery-113.mimecast.com (de-smtp-delivery-113.mimecast.com [194.104.111.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 857821A38E3
	for <linux-integrity@vger.kernel.org>; Mon, 17 Mar 2025 17:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.104.111.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742232970; cv=none; b=gAM8nFXp0pm9xgPr5EuqPVfw6L9WTch2rIDsKkpRCzurKYmrbO9d24Iz+Q92hB22ZLbJa8bgso437ydtqPkHv2uHswYS2WhA2rNWx1Lde7Dv6ltabiFFf5GxKz32rybxZec6viOFTa9OlzxlbGMM6gM2wjuXHKFIYr5BybdBFu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742232970; c=relaxed/simple;
	bh=qySI4OnPCejaqsYREjO5w43Y0R42PTGctKRJG8xDFMA=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=YjBHQ+2s2Zgjdq9A51YjddX/kmuWfve81P07oBHea2vsOKsZPNpekI0G8sAg9BhVaWvGJZQEMK5Z9asDitlZ5MAvkgUWSCBBIRfGdjCqhbzrKjG+XDVkCFMYOoFxcy+jxI7UYGo7vN7BUhssX+feJHrGm6QZtHZ+07AjJT7FCXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=toradex.com; spf=pass smtp.mailfrom=toradex.com; dkim=pass (1024-bit key) header.d=toradex.com header.i=@toradex.com header.b=L07/JWne; arc=none smtp.client-ip=194.104.111.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=toradex.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toradex.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com; s=toradex-com;
	t=1742232966;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=qySI4OnPCejaqsYREjO5w43Y0R42PTGctKRJG8xDFMA=;
	b=L07/JWne3g+lg//BHja2p1N5o3n0Sy9C+GPM2mxUl+5kxcBVwX3liFiBw2jHI0nwZge4Gt
	SN1p27dqDafXYE935mlsZCBhVcni/x7nODuY+RS0VCEDby/QjPdLlw4Y8L8zWipjj6/zwP
	G6clF/pODFAh3wTwREG/tvr29x+dCQI=
Received: from ZRAP278CU002.outbound.protection.outlook.com
 (mail-switzerlandnorthazlp17010001.outbound.protection.outlook.com
 [40.93.85.1]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 de-mta-12-m9TCG9quNXKAYVkrfa4IsQ-1; Mon, 17 Mar 2025 18:36:05 +0100
X-MC-Unique: m9TCG9quNXKAYVkrfa4IsQ-1
X-Mimecast-MFC-AGG-ID: m9TCG9quNXKAYVkrfa4IsQ_1742232965
Received: from ZR0P278MB0460.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:34::12)
 by ZR2P278MB1109.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:60::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Mon, 17 Mar
 2025 17:36:04 +0000
Received: from ZR0P278MB0460.CHEP278.PROD.OUTLOOK.COM
 ([fe80::d337:170d:b47a:e4be]) by ZR0P278MB0460.CHEP278.PROD.OUTLOOK.COM
 ([fe80::d337:170d:b47a:e4be%4]) with mapi id 15.20.8534.031; Mon, 17 Mar 2025
 17:36:04 +0000
From: =?iso-8859-1?Q?Jo=E3o_Paulo_Silva_Gon=E7alves?=
	<joao.goncalves@toradex.com>
To: "rust-for-linux@vger.kernel.org" <rust-for-linux@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
	"linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>
Subject: 
Thread-Index: AQHbl2LooOsf7uMMp0CUUVsufjBe3Q==
Date: Mon, 17 Mar 2025 17:36:04 +0000
Message-ID: <ZR0P278MB0460DCEA52F66AEB5223C40989DF2@ZR0P278MB0460.CHEP278.PROD.OUTLOOK.COM>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: ZR0P278MB0460:EE_|ZR2P278MB1109:EE_
x-ms-office365-filtering-correlation-id: 63b4a392-f7a2-495a-819f-08dd657a3155
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|4022899009|366016|1800799024|376014|38070700018
x-microsoft-antispam-message-info: =?iso-8859-1?Q?KKq/vgpyRLtkfZGyzt/LZYU1W4Ai9Ix1u5k4D/CaoJ/gF+MXhaQiCdPgPK?=
 =?iso-8859-1?Q?sB9bVjc2gP/BlGDnUcO8tYriov5ei+kXRPfokUxJ3qLsQfC9WIpH4SeMWS?=
 =?iso-8859-1?Q?WXW1PKMAaZ8Z2xUjt6bjCJzxX3ztGXZRxfXUVCXnGy6Z5rUwsTz17FKNEh?=
 =?iso-8859-1?Q?YPyXBiJoOI7UgIL1PsViVi3E71CeJaG3/ohUHtOWLp+J1yMdiiqxb5PkiK?=
 =?iso-8859-1?Q?1w7ID/rFa/Xwc1c/q2rN5Fv3MjSpUaW/L81c/7iicHX+nZduMLuuyMiDkJ?=
 =?iso-8859-1?Q?4l0OysUlrWD9YyHo9jlZp+IqPgT67PVxqJdrZqIKAEZV8w/sIoKZMc0MD0?=
 =?iso-8859-1?Q?0oDC8w24e4AjfS0OXMo/RRjfXighVebiU00iMTek6E/zy4YmkVbQqK2Z2P?=
 =?iso-8859-1?Q?XBpuJ7eHVHRcF6MbinwQs63MBz5wvecClu2DdFXXyeT5g+3AaCP39WLjzG?=
 =?iso-8859-1?Q?Z6shGi+75k4Lsr27u0jsDpUClelIergrgWTpjBInvdld6Ka+wmh/4ZNvcb?=
 =?iso-8859-1?Q?pBYcaZmyr5lbtximrxKpsmX970pt/3NBZVna1OEpjebk+PCLvBOZhC/w7z?=
 =?iso-8859-1?Q?rJQ58pn+/IVS91xAeGV096RbugIkLR+G2LNbNLJE3LbcOUUPAT8w6JOLeD?=
 =?iso-8859-1?Q?XSdY62ENikHtJVMQssrTzLZLfsBU6PDopKkXw+K4nvQM+qsEe9xipTT/3C?=
 =?iso-8859-1?Q?fecF5I1nWz7tqNhGfntarT0/uZujVlAs4sCLY7wgEgTyP+jWGqDOl5Uym3?=
 =?iso-8859-1?Q?gT1I1PoDViinCTy3kMaANSfUbQPg+LyNiGhl0vwo/oqfNpOlzDkeH2VKQG?=
 =?iso-8859-1?Q?kwA2FUHD8c9MODOzPBedKiGVMR9F4pNlVKof89giRdnNl6630obTWMn0MI?=
 =?iso-8859-1?Q?i49YRP4D190p/Vl8NYL9o22ifJuqM3VmgngfzGOeqkTDL2BIcb0Y9K8szm?=
 =?iso-8859-1?Q?XZpCX+E//z75kWauFCBou2QgORqXQAkCszYNg/oUWsMafdA+xdlZghaTUi?=
 =?iso-8859-1?Q?1bs+VuJOXotttHj9PKIUG2rPq11SgWTZ445Xcl2fCbLzA+Pl+iSXVGv127?=
 =?iso-8859-1?Q?X1Zl7yPnREp3iLPBow6nmqpQUCWwfYlobX5FcWmO+vYrlc0mHfXRYTEGZa?=
 =?iso-8859-1?Q?KUgSTEQf9FlWhzKbFozUDalBGEfRpYhkKcletkohprYVrt2Xxh9A8zwYgv?=
 =?iso-8859-1?Q?4GG93EkkGGFWYLfha1UdBg8Z1IZ3GkflxSnhye7w1yI/0XGikDa5ETYmHz?=
 =?iso-8859-1?Q?WTJIVja2EvBbAIbIM1avCo8vR88ahdEtkYCP4fjteeBD+GCO/sBCaRF+GR?=
 =?iso-8859-1?Q?dTOkxV+wOF0I3H/BZZSQF2zLoGC2uG1ayCvlx4e+DGUOOmeU8bXnkK1qd5?=
 =?iso-8859-1?Q?4qpF8OiHvbHhV44jZ5D8BxIH8M+4+A0soxucTqXpaEE9/usfzm8g3K5Nij?=
 =?iso-8859-1?Q?OVOAE+M1qwhZht+JuVQXwU6d08gYk7m8sN/ZUvCuStWz4Ge5QEEtq8jP9Z?=
 =?iso-8859-1?Q?V8u0LU5+6MMwyg/R07+yk6?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:pt;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZR0P278MB0460.CHEP278.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(4022899009)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1102
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?O3ZZ30fD2Dt5hQmMRhqSJa/YzHvMdB1oeVWRngZxDdmLXeR7h9dUIBHzD6?=
 =?iso-8859-1?Q?gcz/cTtZlbZ2UYosW4ANlXyzbDZStaGmzzSV+yCucSys9u0KQ+F0KroEOs?=
 =?iso-8859-1?Q?A315IeorS6YlLwdrL5AvYwdjLgF9KKsawnrDD5fRDFASV24GFU9dunngP4?=
 =?iso-8859-1?Q?56xHxf9ZxAOHMc0qAuA328cGHS1D+YRdllHFpP3Nwp16SO9Tg4ra8uAAP0?=
 =?iso-8859-1?Q?zcaP+F1p9QjBGoNSZS3w9xYvB84LJkHLZmXliFqyyLLX9WJMdK6pAw5hKO?=
 =?iso-8859-1?Q?iUMAtRKrn9s5H7JclF1hbN0GW5sF3iUd8tZLPPOQDfRMldTsV7jStwwtqB?=
 =?iso-8859-1?Q?xCEXR+5+LKFqxqGPFSxjIbXMeahW9INq4wynpraIRf9jzD0L8RxGUev7Ky?=
 =?iso-8859-1?Q?25CbHev7xDlkHEmadY4PhHJCFBvVF6yNxjfSeggbyymK7jpJ/8vqyT34B2?=
 =?iso-8859-1?Q?ykNLXWInx/5JKjr8VhVxDrdqP+wtGW449xuNRUOO1bPE83hGRJIWPcYOEP?=
 =?iso-8859-1?Q?PLcEKyjCsJcpVnLEWKVLRHXXsy+K3CzFVLXM2dIKyWXA0QaEY7yjknLYgl?=
 =?iso-8859-1?Q?lW/ERfV95TLLsDT9+NcfOLS+47iq/KdCrABHzIf5cesbZ5K0KoHrv/hQ5R?=
 =?iso-8859-1?Q?iHyIGjhaOR0G6x/G1LsnfgSU2E9eYQrOdtMWeJQel5uGGjAoiWXuWOi7yi?=
 =?iso-8859-1?Q?GgvyS+f9pbq7CWzOCCC/E/DAhP9TBY2NSQ4BLOPKwIU4Jrma7IBW6Z2a43?=
 =?iso-8859-1?Q?jsK8ClsaTYpG7sLf5DXivu0Q3s5KgcynkTSXC5bgWS3SW5+dgi1poltcB9?=
 =?iso-8859-1?Q?z14/TcB4FOL+742yP4eK64YOJ/Yhoj+jAbC0ieXDJlkXIJSM4SPgN8Q73j?=
 =?iso-8859-1?Q?SzvV/YG6vCDObkn4BYIc5MPxiShGN+QxWxzZuZMzUo/JVCtMxSsRYDL44n?=
 =?iso-8859-1?Q?C9ZUfp+7MIAwWuMQeXX28IjkvK+4GQL5T7Z7J9SExZ+aXFL3fG+QNqJsNw?=
 =?iso-8859-1?Q?s7kOvRdJgbz2hvJDsqqWP4N8HUKEaF0k/tACbi0ddzs0W4FDQOz2Xxk4KU?=
 =?iso-8859-1?Q?kWPZqY18Df8nvv3KnT5xJmZt0WqVgB3Y+AEnGWoDZZa2mmlmMafYzY926G?=
 =?iso-8859-1?Q?WQR8TLczmu3N2bO77Gf51ON3xYoQtlL7k3MTlB/rC6HAbME9Br7Z8COulx?=
 =?iso-8859-1?Q?qfmAfdUEykImp9f8pyxOwG1r90n9Vzxv+l+vRL2p9RhMVHe5w6ybZAaX1l?=
 =?iso-8859-1?Q?CbEG/BwYBJc70KyAjL6mnjP7FhSva8FqU52SNjQuXr/DR2d/uiXBR2hmH4?=
 =?iso-8859-1?Q?iihs1y2+AbcLupML5PzCT8/DnFJvHdNleLp3Pd9WxfDzjIcuTfnlHv1diZ?=
 =?iso-8859-1?Q?I26aH9/AgkQUUlGI+mSEkGqe09pedBAjoV6B2Wcx+HBPSugSU3I4X1SFzx?=
 =?iso-8859-1?Q?zKerSWrloc2jz5KRFHNufmeaqcWtRGqGjxlE7NgiDmanTm+c6ULvDwWiZA?=
 =?iso-8859-1?Q?lNWNHElPvJchR4TTdFNAmsfDr/dbFDnIKT/nH8OgmQ4PzqvW/cVcYI2JqS?=
 =?iso-8859-1?Q?zQWw6xkce9xctbXCFEV7WyLFGvWcv7PcyxeRsiB0EV5cLzMLa8144G7pHM?=
 =?iso-8859-1?Q?PQOFlIH3CDx546ngu9SCVTrlLabIXIQXwy?=
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: ZR0P278MB0460.CHEP278.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 63b4a392-f7a2-495a-819f-08dd657a3155
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Mar 2025 17:36:04.4381
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6yHONaXsJDE+X0INJxeNKwQBHn3enTccDE/DukeFAO8zqs2CcykRXayKYgLXEM50kFi9j51xpSlWxLIX1ZzYbmpQiJWNn/LbaaMrXG2Q/L0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZR2P278MB1109
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: NGWe6elxI3Xvvj4DM1-8cFRynRXgt9E_x6vWA4TRWxo_1742232965
X-Mimecast-Originator: toradex.com
Content-Language: en-US
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable

unsubscribe=0A


