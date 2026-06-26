Return-Path: <linux-integrity+bounces-9843-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 6ZO1B5JIPmpkCgkAu9opvQ
	(envelope-from <linux-integrity+bounces-9843-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Fri, 26 Jun 2026 11:38:26 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 721836CBBF8
	for <lists+linux-integrity@lfdr.de>; Fri, 26 Jun 2026 11:38:25 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=polito.it header.s=selector1 header.b=babRiYSy;
	spf=pass (mail.lfdr.de: domain of "linux-integrity+bounces-9843-lists+linux-integrity=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-integrity+bounces-9843-lists+linux-integrity=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=polito.it;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 052C430048D6
	for <lists+linux-integrity@lfdr.de>; Fri, 26 Jun 2026 09:37:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17F453E9281;
	Fri, 26 Jun 2026 09:37:07 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11021107.outbound.protection.outlook.com [52.101.70.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D6133A7F4F
	for <linux-integrity@vger.kernel.org>; Fri, 26 Jun 2026 09:37:02 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782466626; cv=fail; b=NrWjNidkixVVLsQwuJywCpKAJ7xoSO1a8HMEtEMHcVqG5iGG62j31R8ImwTj6N0cb4tGi0TZivNKmomRCdfszmJgkzibndXkRmYtnM6Ntfj0azN/NWz1q7lZilGV6UdM7OdA0QpyImiTSJj9Kns6LXU7KcdUFXX6FB3B4wUn/Wo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782466626; c=relaxed/simple;
	bh=FLdSofaf1Z6/7AhznG3oYXoSUTANz+jmJu191RL9ODk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=NnG0KQguwRnCcyscL17xnLar3ZG70S3uvGeHEM/DnkyU1h09eQwTsWwzV4oi0VJkm3ODOMwiArakf94gOsnWwyeJdEr6Lk2XZLdi/gDI9YT822oIV/moHw6fYIcjBfwNh8WqH1Zd28hEnNZ1EWqOJkYmcwDSqYqzgTBW3qn+5JA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=polito.it; spf=pass smtp.mailfrom=polito.it; dkim=pass (1024-bit key) header.d=polito.it header.i=@polito.it header.b=babRiYSy; arc=fail smtp.client-ip=52.101.70.107
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mpKMWyoubmWU9KnSYD2NS1OKW9n3oSLMTIPGDDE/04Da5QCyZIv1vR3rN2JIbFBkzzoHMZWIyZYYSbpYcOowCHjIAOrmdMAShob3xqvXjFLeTvQmq541ZesbnuAP+tuowvG6JixbIQK8os56f4mW9VMECanFD+MgqYi3TQZ6YXQZYcXJDV4Ecdnb+OYAXKBWb65KID1tgIb3onD0Ztnp04a/2cAd8IlkDLV9Pqjgk8o6dkkUrZoDXQrB9pM/wW+6tL3FRkiUFcOdOZoOy9NUkUQAzBL6qx0WdvcDb4MpoDISiMeX+oge6Gs7AfNKrXDFqoo3pg3F/RvwYcMMB1wOpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FLdSofaf1Z6/7AhznG3oYXoSUTANz+jmJu191RL9ODk=;
 b=J+ZJyi8A/u3yfiBRxq+jxm5OLJSA7Hv3UZVC44V5yfNrHTlkLhykdvt+nEphCb/m68F7vyoDm2d+ehV8x2NHA3EHIVj2iFdxYt/99viYm1yceU0RsnlvxCobegG9UqAyPuSzDhV5xI/t32a+kX/giogiAN1Jcr6sNLDj7nqQGEpmZqDfoCmV24wlytVqrRzSP9RmxT9SRy4dafyxgVAbI7DEO/0mUl8CX44xSaAkzWPSuNLLIjnY+N9ZwywvsRrUWpvEtmXF+yqKIMLSGhIIcXsOdyR5DEvrCtupCSw8O77lO+gdZBVuV7/9PopIoIwJHPEzQF8S7bgtUFbfSF8WdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=polito.it; dmarc=pass action=none header.from=polito.it;
 dkim=pass header.d=polito.it; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=polito.it;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FLdSofaf1Z6/7AhznG3oYXoSUTANz+jmJu191RL9ODk=;
 b=babRiYSy/ZpzfAbd99fwelOzNEcdIJZNTOR7vnn95xESDSNgnLAkrT3352OLW+WZsjobFbarojLT9glmJD8nRDwh7zqjbE4MPDXD3cpuoRzi/Up04IgBqcGP+EpsX/rIGaICNcq6h8Y9E2x7ebbyyeBOtD0AncdAZ5Hd/ZPpDDM=
Received: from AS8PR05MB7880.eurprd05.prod.outlook.com (2603:10a6:20b:253::20)
 by VI0PR05MB12658.eurprd05.prod.outlook.com (2603:10a6:800:32f::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.13; Fri, 26 Jun
 2026 09:36:59 +0000
Received: from AS8PR05MB7880.eurprd05.prod.outlook.com
 ([fe80::b739:4a27:cccc:cd64]) by AS8PR05MB7880.eurprd05.prod.outlook.com
 ([fe80::b739:4a27:cccc:cd64%5]) with mapi id 15.21.0139.018; Fri, 26 Jun 2026
 09:36:59 +0000
From: "Enrico  Bravi" <enrico.bravi@polito.it>
To: "roberto.sassu@huawei.com" <roberto.sassu@huawei.com>,
	"linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
	"zohar@linux.ibm.com" <zohar@linux.ibm.com>, "dmitry.kasatkin@gmail.com"
	<dmitry.kasatkin@gmail.com>
CC: "eric.snowberg@oracle.com" <eric.snowberg@oracle.com>
Subject: Re: [PATCH v4 1/2] ima: measure loaded policy after write on
 securityfs policy file
Thread-Topic: [PATCH v4 1/2] ima: measure loaded policy after write on
 securityfs policy file
Thread-Index: AQHc/nNlfixRMSHkm0WWEbcS7ec3nLZONRmAgAEoygCAAUPhgA==
Date: Fri, 26 Jun 2026 09:36:59 +0000
Message-ID: <ba1477e46c5cac389bc97fb9f9b36a464a3adfa5.camel@polito.it>
References: <20260617155832.434517-1-enrico.bravi@polito.it>
			 <20260617155832.434517-2-enrico.bravi@polito.it>
		 <1f23b6cb35538f471dbb68534308784616130cb9.camel@linux.ibm.com>
	 <6bc5e716ce0e9b1b3a9d2adacdc63474e342c30e.camel@linux.ibm.com>
In-Reply-To: <6bc5e716ce0e9b1b3a9d2adacdc63474e342c30e.camel@linux.ibm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR05MB7880:EE_|VI0PR05MB12658:EE_
x-ms-office365-filtering-correlation-id: 34adf4cf-6d7d-462e-3a7f-08ded366787e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|23010399003|376014|786006|1800799024|18002099003|22082099003|4143699003|11063799006|56012099006|38070700021;
x-microsoft-antispam-message-info:
 DZhiI6HWups4oF46ef1fKUPgC8XI5j++k8GxKT/ZisY14W/G6BJsuhcpIC2gfn30XeMTmpWTnKa1mKywXXeUuY5POc/yzsARt3h1FbD/1iy3FlH+PBk4WKkuYname6yZapVYRTwY26vPKiJvOfYiCM7qOcMF0B0Xa/8e68EqZehqIIM9MyilGCug1WOcs/HFWFnWhh5NYQErn0/iyGaLG/2eOrUoGP5tTUXJ21qz969UXAJ6Edc9A79rSBkShrwEz00rek61OcdIYFB2soEZGTXbsNZPr4HgIFJ/pNCel4PUBATq7DQMB9+lBtyL7oiN98YiGJ9DdZ4deDEx+O7WoobWFld00uXc/VligTCAUrG1tKU9uoYwTZwkC8l74AZQqCxuxHCYDY19QyW4AhGDZQvWs3Xu5+kWhx/Vrb+cvy8UmQBXFJTWMKlQUpYoVHCB3r7XeHNt6p1+2Og1BEJhZ3tGhPowf9OytEFa5nijuOkbq6TZTHSKf6ESKHofLiF8MnNBNW5NZE+v1WOksOt8GvumfYnrdKzcaZKbIt9/y7zYvD3cq23Ci5/nW1g3mV425l3anhdxjISBHRSVH9oq7MOXooiezs677iLvtoQjoWRVIuXsRwDbrS4o9VU5+p2BS6g48yK7yZY/PyOxzFE3Tmvx993oMDuYP/GGVzuNTi38Y405u9VWuCK6kqN4TpYw+60U6obFuk7MbPWpElxoAWlcDwjW9PtnGlDs1CfXunE=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR05MB7880.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(786006)(1800799024)(18002099003)(22082099003)(4143699003)(11063799006)(56012099006)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?cnVrNElXYlBjaFVaZVJrT3FLQkhkTjRpZVdUOFpRTW1heXl3WHhudGRSUDFT?=
 =?utf-8?B?ZUpFYSs1d2Z0OU1sQjE2QjdjWGRXWkxUeFhKbnF1ZW9IYjZnMWxOSlBnTC8r?=
 =?utf-8?B?U1BJNW5EVmZhaytmNXQzSjV3TDN5WmZSU2xLZDh6ZEMyZVJIcTRkdnM3bmMr?=
 =?utf-8?B?SGpINlJoRFlaN1dJa2tMRjBuWGZPWHd5dzNCTGVPNVlvN1BobVlJYlduM3Nx?=
 =?utf-8?B?eWdZaytKeUM4L2FURitYaXB4b0dySjlKbnFiL3F6VmFHSmZoQnlZeVRCRWc2?=
 =?utf-8?B?ZUlJRWNOcEtSQnVSdFFYRkpuaUkxcmhGY2xRTDJzMVI3dElROFpjT3Q3TWlS?=
 =?utf-8?B?cW9VNFJUYnB1TEh3TWdXRmFhZ2ZtOE1qYm8xQW5zYUpPbGNPemxKaEgyalYy?=
 =?utf-8?B?WkpYdUFPZmo0MjlRc0xnb1c5V0ZncmU1ckZCQkFqZlN2WnRrQ28xQld0VlZ4?=
 =?utf-8?B?dk0xUHZZbmFOWDBYSzd2K1NXam81ZXVJbU5BUk1GVVArNmRZall6MGxMakZi?=
 =?utf-8?B?NkhyWTJBTG1PSEJ5OTQzZ0M2cTNWbHdWS3NVK1pjNUJuTFkzVG9LekRWNGlt?=
 =?utf-8?B?cFVyUHFCdERHdE9SbWlONjMzZzZIMjdURTV2OVhCRjIwbVhIQTZBTVl0K1Rv?=
 =?utf-8?B?d29neGZEZlU2cW1qZ1dKN2Z2K2RqYXgzZCtRNFk0Yk53V3BDT3FLcHBWZmVu?=
 =?utf-8?B?S3JQaVdqbUVCaTFZdEJFdFpsZENwZjF6S1M3S2lSanFsR1pPdytjT21iNjZh?=
 =?utf-8?B?MGNhMnBSK3hOOXA1ZzA0Z1NUbWZ1VFdWTzZGRFczODJ2L2txSldPa1IzSFBu?=
 =?utf-8?B?dEVlcytrbkFBcDBaeXhSZzgrSHp2Y2xEWk5LbmU2c050djhmdTZaVmg2YjZo?=
 =?utf-8?B?NWpBTklRejdtd29ZMXFoZlNyT2wzSHhGQ0lwZDNsYk5WQTVHUXNEQlpScG9T?=
 =?utf-8?B?RlJsbUw0OW9ldFJ1K1RnMWpSb0NLSS9YaG5aTEVuUjd1ZmVGRTZYanpGRUsr?=
 =?utf-8?B?WTk5dHRDTEIwUlBuY1lnNUp3cnp1NHNVNXpQUWl1eGpKNktlTnNZMTZaVGFJ?=
 =?utf-8?B?ajdMellPRGJzaW1jMDBoVzV4cEthTkM5TnY3eEVLSzQ0ZlhSbFpsdW0vQnNO?=
 =?utf-8?B?bStGV1lkMFhZVTFnOU92VlpBbU5TaXhzNm5DUFFnMThaWE9Sc0pocUkvNkV2?=
 =?utf-8?B?VmZvblFwaFB6c3hrQlppb0dIazU0bkhOR0Y2azdlK2NtcHBlZFFUa1lEM1Fv?=
 =?utf-8?B?YmV1dmpCa1NCNldJNmoyWDE5RitrZUdENGVSdU82eHlGdEtIa0ptc1V3OUVa?=
 =?utf-8?B?c2R1dVFIU2dTaUsvK09wbzFrOWtXVW9OaDlVMCt0ZFlrN3FndWhaWjk5OENz?=
 =?utf-8?B?V3BMQ3h2ejRIUHpZd2x1NW9CNFU3clk1ZXhSbVVmQm9xd2lNbVJjRzVNdU1H?=
 =?utf-8?B?ejJ1Zko4cFRneHFXT0t0SXloNGRMbHMzTE5UN214dXBXZVNqcmR3UkNkekRD?=
 =?utf-8?B?T0Z4aDh6SU1DOTVIWkZ5eU8rMUdIdlFzNTczSlAwQ2ZIcDZmeWVDR2pTelgw?=
 =?utf-8?B?eXVGTElmQW90VUVDNkZBZWQyTTRGbVNzVjlTejkvY3haOVRmQXl5aGJudHRs?=
 =?utf-8?B?ZDJVandjVEdZLzI3ZTNmMktlVUtCNW13ZTE2REdZL2d3SmE4T0ZJMytra0xh?=
 =?utf-8?B?N0p4RzJPM1kwMXlQczUwSkUyQWpNa3RZcTJBU08zaFRraGFoM0hyQnEzenE0?=
 =?utf-8?B?M05pU3AxMXhoU0M5MU5nbDBWTGpDdzlDaFhRTjNmcnBnYXVSd01rY3NVN0ly?=
 =?utf-8?B?RjhBSDNCT1hLek9acW9kZ0VtNDJya2hMb3dvYmlMWWRaQms0bXUyekw4emJv?=
 =?utf-8?B?VHp3WHlmNThrQVl4eHJaMkRIamo4Q2kyU3orT2xZd21RVVlObGp4NFRGZUFV?=
 =?utf-8?B?Nkl3YXc2VEJTa0xQVG1ybVBQZTBKL3ZGUlZiUkR1ZXczVytFRkNGci9MT0ph?=
 =?utf-8?B?RENoajJidm01SWYvdWU4UGlzVTR5RVZRU0ZDbnd0V24wZnhnc2VBL05WM2NU?=
 =?utf-8?B?dVBpd0VRR01XQjY3QWx0bFZPMkFGc3VlZ3I5VFUxNW1XbmRXb212L2xaKzFv?=
 =?utf-8?B?OHJiMHJZb2ZCdUZPbEV5WE0zTFZ3UXVYR0FRZGYwOGsxRjdianRvS1ljajc2?=
 =?utf-8?B?NjlITzA4eTdzWDA0VnV5UWVjekwyY1g2Q2o1Szhxd0xmUEk3NnQ4MjJqYzhU?=
 =?utf-8?B?VGhIajJXN2E2dnl1bDcyT1JOdXE3c3M3S2NNY09MdE14V1RBaW93RjRkTGRJ?=
 =?utf-8?B?MU00Z0JVSXhtSTdLM0FMbCtjL3o0N0FkVDJrTzAwdzUvbHlpMzFBdz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E6B31155AE28144DBEB735FD8CB0552E@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: polito.it
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR05MB7880.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34adf4cf-6d7d-462e-3a7f-08ded366787e
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jun 2026 09:36:59.4631
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 2a05ac92-2049-4a26-9b34-897763efc8e2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jmgXcevRefG0aJoKwJdtvYijpG1CrHgBW5W0sMUx165RvARSf4N4cMaZbJCMAq1pUbqODk8WZ0d4IC82VmruaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR05MB12658
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	FROM_NAME_EXCESS_SPACE(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[polito.it,quarantine];
	R_DKIM_ALLOW(-0.20)[polito.it:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:roberto.sassu@huawei.com,m:linux-integrity@vger.kernel.org,m:zohar@linux.ibm.com,m:dmitry.kasatkin@gmail.com,m:eric.snowberg@oracle.com,m:dmitrykasatkin@gmail.com,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-9843-lists,linux-integrity=lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_SENDER(0.00)[enrico.bravi@polito.it,linux-integrity@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[huawei.com,vger.kernel.org,linux.ibm.com,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[polito.it:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[enrico.bravi@polito.it,linux-integrity@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-integrity];
	RCPT_COUNT_FIVE(0.00)[5]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 721836CBBF8

T24gVGh1LCAyMDI2LTA2LTI1IGF0IDEwOjE3IC0wNDAwLCBNaW1pIFpvaGFyIHdyb3RlOg0KPiBP
biBXZWQsIDIwMjYtMDYtMjQgYXQgMTY6MzUgLTA0MDAsIE1pbWkgWm9oYXIgd3JvdGU6DQo+IFsu
Li5dDQo+IA0KPiA+ID4gZGlmZiAtLWdpdCBhL3NlY3VyaXR5L2ludGVncml0eS9pbWEvaW1hX3Bv
bGljeS5jDQo+ID4gPiBiL3NlY3VyaXR5L2ludGVncml0eS9pbWEvaW1hX3BvbGljeS5jDQo+ID4g
PiBpbmRleCBmN2Y5NDBhNzY5MjIuLjBhNzBkMTBkYTcwYSAxMDA2NDQNCj4gPiA+IC0tLSBhL3Nl
Y3VyaXR5L2ludGVncml0eS9pbWEvaW1hX3BvbGljeS5jDQo+ID4gPiArKysgYi9zZWN1cml0eS9p
bnRlZ3JpdHkvaW1hL2ltYV9wb2xpY3kuYw0KPiA+IA0KPiA+ID4gQEAgLTIzNzksMyArMjM3OCw3
MCBAQCBib29sIGltYV9hcHByYWlzZV9zaWduYXR1cmUoZW51bQ0KPiA+ID4ga2VybmVsX3JlYWRf
ZmlsZV9pZCBpZCkNCj4gPiA+IMKgCXJldHVybiBmb3VuZDsNCj4gPiA+IMKgfQ0KPiA+ID4gwqAj
ZW5kaWYgLyogQ09ORklHX0lNQV9BUFBSQUlTRSAmJiBDT05GSUdfSU5URUdSSVRZX1RSVVNURURf
S0VZUklORyAqLw0KPiA+ID4gKw0KPiA+ID4gKy8qKg0KPiA+ID4gKyogaW1hX21lYXN1cmVfbG9h
ZGVkX3BvbGljeSAtIG1lYXN1cmUgdGhlIGFjdGl2ZSBJTUEgcG9saWN5IHJ1bGVzZXQNCj4gPiA+
ICsqDQo+ID4gPiArKiBNdXN0IGJlIGNhbGxlZCB3aXRoIGltYV93cml0ZV9tdXRleCBoZWxkLCBh
cyBpdCBwZXJmb3JtcyB0d28NCj4gPiA+ICsqIHNlcGFyYXRlIFJDVSByZWFkIHBhc3NlcyBvdmVy
IGltYV9ydWxlcyBhbmQgcmVsaWVzIG9uIHRoZSBtdXRleA0KPiA+ID4gKyogdG8gcHJldmVudCBj
b25jdXJyZW50IHBvbGljeSB1cGRhdGVzIGJldHdlZW4gdGhlbS4NCj4gPiA+ICsqLw0KPiANCj4g
SGkgRW5yaWNvLA0KPiANCj4gSSBmb3Jnb3QgdG8gbWVudGlvbiB0aGF0IHRoZSBrZXJuZWwtZG9j
IGZvcm1hdHRpbmcgaXMgb2ZmLsKgIFJlZmVyIHRvDQo+IGNoZWNrcGF0Y2gucGwgZm9yIHRoZSBk
ZXRhaWxzLsKgIEVpdGhlciBjaGFuZ2UgaXQgdG8gYSByZWd1bGFyIGNvbW1lbnQgb3INCj4gZm9y
bWF0DQo+IGl0IHByb3Blcmx5Lg0KDQpIaSBNaW1pLA0KDQp5ZXMsIEkgZm9yZ290IHRvIGNoZWNr
IGl0LCBJJ20gc29ycnkgYWJvdXQgdGhhdC4gSSdsbCBmaXggaXQuDQoNClRoYW5rIHlvdSwNCg0K
RW5yaWNvDQoNCj4gdGhhbmtzLA0KPiANCj4gTWltaQ0KPiA+IA0K

