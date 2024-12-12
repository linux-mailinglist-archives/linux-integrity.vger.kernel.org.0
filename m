Return-Path: <linux-integrity+bounces-4361-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E7DBF9EE238
	for <lists+linux-integrity@lfdr.de>; Thu, 12 Dec 2024 10:06:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 249F9161E48
	for <lists+linux-integrity@lfdr.de>; Thu, 12 Dec 2024 09:06:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F51620ADE2;
	Thu, 12 Dec 2024 09:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b="WqftByaH"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx08-001d1705.pphosted.com (mx08-001d1705.pphosted.com [185.183.30.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91108204C3D;
	Thu, 12 Dec 2024 09:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.183.30.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733994360; cv=fail; b=AAZTjhGYkSl6K9qcRac/08N0y/OxIJ44E8OMTwu4ZBpkUFvdpeX3HKaEieQguzJsbNVesEa4AyZY1PSbvRlv0kvDvP7eMJ4//cIIsBP4a8l7YjmzH6jrlkw8b9cLIIqqjJo5091IGM/kQR3BEIzSFfQmxCRokD8YNWxOU+IhRRc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733994360; c=relaxed/simple;
	bh=1EDtfWpqgbd3qf8LCnVfa85cbeY4+MEHxr4ibZ0WinM=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=toFn2ij7+7/e3p6ML+03adk93ivQFhxxz3dZEj0UuGdLUag/h5nZBtMPcZTXp8HxMLB+YOD5LF2ySWpWMVi+Zbz1XL2s5MTmi/uu+TJcorQnYTCFGF6NhuBDxAm9K4mk2Bc7G1BcRvA6NzsZwOD7OrBxa4989iixY2WzPD1LYwg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com; spf=pass smtp.mailfrom=sony.com; dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b=WqftByaH; arc=fail smtp.client-ip=185.183.30.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sony.com
Received: from pps.filterd (m0209322.ppops.net [127.0.0.1])
	by mx08-001d1705.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BC6Eg5P032268;
	Thu, 12 Dec 2024 09:05:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=
	content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=S1; bh=Yl80H2HXLTm6/0ouPQJ2aiWfS7dpkpC
	xu8UnSJRWiDI=; b=WqftByaHh5N7rqYj7gniYNNy7MRne99E0iEsHiY8CgO5xCq
	QPnt/e4VS+vEn6tOkdwuuaue/4CxgfziQ9Enxi74AeXHWkOc8Q3+tve450tmURZZ
	0TGoZWxe+B8okFmtIJSTgMa9n8To8MdTb1/CrAgkc8UPXz0L7kMOrlvuEpURyIWX
	MU+c0FdvttpcOFZBuvVZFkso5Z6d2axvO6DAXDpaCvmGgkA4TpyZSbYFCOv5+/Aw
	E7PGA2zCoQqKszeYEKGuCvMcmaJj1xtYovksuCOSFNVpNgCo09XGIb6NItkkCFoh
	0rshXeJhrEb82PKrya7q6blRrDIMHCjCdtxOwPg==
Received: from apc01-tyz-obe.outbound.protection.outlook.com (mail-tyzapc01lp2045.outbound.protection.outlook.com [104.47.110.45])
	by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 43cd54ccdp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 12 Dec 2024 09:05:06 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=egUp7en1ctMn/zyeNWgaZB522uI59w9Nbp8ea2W/tWYElhLhrZkKCw/OKjyWhelpB5/ZTZc7BS8yzb+jO8tYaliV5+KqZj7mFm7yhhCFM58AjK2qdE7l2xX08I0rMuh1LInUmv2hK/44wi9yw8LJHR1OABK8swZohVYg2ILBjgymBWZJIA32C4ySSg2/0IUlNBiScTyX6b15JGQzCuFIvzQSwiPozAIaTSaPOUDSOy0WA2I+yH1jGyfmadwzQs6XgitJR2y1gixOoTo7OGONGvj5aISur7VW3na0U6e0foK+KHSFrXkDiKgiF3njeCTfP5BMyQR6PJgQV/weDejJ0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yl80H2HXLTm6/0ouPQJ2aiWfS7dpkpCxu8UnSJRWiDI=;
 b=cgx478coeVjPKERp2upxidL8hf7/v4jKAMqXZdP2J8hWhiqSzUpiwb8v4gRhOPI3D+5+pos++OD2BV4bZCDEnsNyKQeTxMwPSHuGbSVNGxcvWC/NU7tOCeEHvQrPpzy/8CFUfIlrdh09xxGmLBFMJrLh36gPWoSIGNJVWTyui5ytgN7tzWkJOxdOA3UopyqbDiPK7AatfRrMgQBjvaYL++59fWFkBrIUPBeydnRsk14MUDIAU2MKlZbz0IqJQlBq45otsEWh9VXbstGbMDewST6rdc9P8w6IhTF5WZ3FjKIqeemBdZqGTrz9hfvWpRNB8JdbE9tZd3UY1tjJCBi1Eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com (2603:1096:301:fc::7)
 by KL1PR0401MB6211.apcprd04.prod.outlook.com (2603:1096:820:9b::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.15; Thu, 12 Dec
 2024 09:04:52 +0000
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::409e:64d3:cee0:7b06]) by PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::409e:64d3:cee0:7b06%4]) with mapi id 15.20.8230.008; Thu, 12 Dec 2024
 09:04:52 +0000
From: "Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>
To: syzbot <syzbot+91ae49e1c1a2634d20c0@syzkaller.appspotmail.com>,
        "dmitry.kasatkin@gmail.com" <dmitry.kasatkin@gmail.com>,
        "eric.snowberg@oracle.com" <eric.snowberg@oracle.com>,
        "jmorris@namei.org"
	<jmorris@namei.org>,
        "linux-integrity@vger.kernel.org"
	<linux-integrity@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "linux-security-module@vger.kernel.org"
	<linux-security-module@vger.kernel.org>,
        "paul@paul-moore.com"
	<paul@paul-moore.com>,
        "roberto.sassu@huawei.com" <roberto.sassu@huawei.com>,
        "roberto.sassu@huaweicloud.com" <roberto.sassu@huaweicloud.com>,
        "serge@hallyn.com" <serge@hallyn.com>,
        "syzkaller-bugs@googlegroups.com"
	<syzkaller-bugs@googlegroups.com>,
        "willy@infradead.org"
	<willy@infradead.org>,
        "zohar@linux.ibm.com" <zohar@linux.ibm.com>
Subject: Re: [syzbot] [integrity?] [lsm?] KMSAN: uninit-value in
 ima_add_template_entry (2)
Thread-Topic: [syzbot] [integrity?] [lsm?] KMSAN: uninit-value in
 ima_add_template_entry (2)
Thread-Index: AQHbHaL+d4YYZYraA06ZwOMR7289y7Lirhxo
Date: Thu, 12 Dec 2024 09:04:51 +0000
Message-ID:
 <PUZPR04MB631619A22F03DDBDC97905DD813F2@PUZPR04MB6316.apcprd04.prod.outlook.com>
References: <66fcf5a0.050a0220.f28ec.04f9.GAE@google.com>
 <670c1a2f.050a0220.3e960.0043.GAE@google.com>
In-Reply-To: <670c1a2f.050a0220.3e960.0043.GAE@google.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator:
msip_labels:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PUZPR04MB6316:EE_|KL1PR0401MB6211:EE_
x-ms-office365-filtering-correlation-id: 2458293c-0ded-4344-3b1d-08dd1a8c09a4
x-proofpoint-id: d8690225-876f-412f-87c6-a7cb45557a4c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|1800799024|366016|10070799003|921020|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?F+9TOPRNadHT/ZHqDa5M70Rw4h67+sTt0D7TXkKcFAhkm3aCbCCLbksTua?=
 =?iso-8859-1?Q?GZMwm3FAGf3v7MCyWwJzcdXTxdLuAwstinYwGU3P9KltuhTtvSR5nCV+56?=
 =?iso-8859-1?Q?Dz5VzHWgMSmtdharcShvSII8Co5M/J9jShyYwWH68JH86SnZYJb5qYaZpZ?=
 =?iso-8859-1?Q?l97ZVI6PfIkMJEwUxKLOTKm4/96mS5IcY5jkWD6kI5uLrGgRZZOv1b7DQL?=
 =?iso-8859-1?Q?yOihvdXEP5FauExFCpwGPIHbhTblg2HUoaWpACsYmMQoSIBN78b5uFkDIi?=
 =?iso-8859-1?Q?7JVS7mHky0N3kifxTlZ+2HhnEZg88ajSl/z1Q4SrFseSe6OgthVxqV2M0W?=
 =?iso-8859-1?Q?tQwKYqPNQkeLkj4IXTeJvzxp9gV+d4lHydu3YZBB2+mKbQlYGBIhyhWNwL?=
 =?iso-8859-1?Q?CSL8eapWQuC/+oX798ph/gC++dhKl53PHdygDHDn+D/USBF8WKrcCdhUtd?=
 =?iso-8859-1?Q?6CnraBMkf7/cYSXQkVBK0BG+5yBZ0NdanM5NXzDTVA1yj8smwREsVJ91oI?=
 =?iso-8859-1?Q?Mw+O1gibQo7dZp7qqezeWcokmPgN3xgWdNa7vXyAXonDZ3X+GeSNqZV815?=
 =?iso-8859-1?Q?w5zycWb351eOIFFdzP5Tu6sCynSOouY4LXYLIBbxzUfIbgeWzmhvRf+PMB?=
 =?iso-8859-1?Q?QHoTHiNai1E9eHpa5VVkp/fcH0kbwCqn5Fpelnys0kG+vorkScyPFGrxMb?=
 =?iso-8859-1?Q?m0z2dnldt8LzBKayv9AuHeH+AmsXLxAJ84Oop9yU4+ghA7KcemTwEDjjo+?=
 =?iso-8859-1?Q?t+8c6rNjlfnvq1dnPdMchU4Bb4m7+0e7UWQ6GBM6+xK6+JvJezzN4KzwbA?=
 =?iso-8859-1?Q?2vMk7EceEpB/pzF01iybzg34OChVAjBXvCUBhmFeLXQ3YrcKDpxFOUbBr5?=
 =?iso-8859-1?Q?bWN169EaxDMJJ/yepdxzBtyBUzFAWFHCohlBBtpOIR0+Q3X/dAjD6VboeY?=
 =?iso-8859-1?Q?BcxgF9GyHBJ35A2W3r2Ggwhh1KfhEui6x9lQimAhni++CVWPFki+fe3Pzn?=
 =?iso-8859-1?Q?2M4Vk34JBxdmz+twiwnecaeMLsTTXNmNJyZLwwc8w/iovtSOF2kItuJOYM?=
 =?iso-8859-1?Q?NXxgaG4Rz1cPpPmtDHenKsJDnAEU16Qh64eZ+iF8vtTxEU77xikcA5O9Rt?=
 =?iso-8859-1?Q?VkE7QN/M6HFFc46SH6cRKDpawNNbAUE1UQzSeRBxAh8mdD10r94rQgag7e?=
 =?iso-8859-1?Q?dQdc3Agi3M5x72c/QyFAyH+7GzFUZMzyY/4=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR04MB6316.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(10070799003)(921020)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?k1DfZB3Tuy/9v51XfunBHvPTt6ofrZJANRHOj7SwrkE2rUTx5dPWYRkLXk?=
 =?iso-8859-1?Q?jagGHABwQ4uhPBAMavJSWwLi9k1EsJYrzgeNNVfBj1prRZyhkeC0aOk7gi?=
 =?iso-8859-1?Q?IJKoZQG1dRLVkpPbWKEHb7y7zPXWWMuWMhYKqlHjKudc4xx4JEIrXMYPUS?=
 =?iso-8859-1?Q?DNyiyKXLNUcrAMfxUo2Ok579FB0zV+BpA5ZOLwxaNbXw+7E0B2AN1u0UrA?=
 =?iso-8859-1?Q?l9/w76XMlGKgv/ednoVwSqovyC5ieRGAopexy3iChVlhshw5uR9zjwZwQ/?=
 =?iso-8859-1?Q?O1fz6ncc+HSDDaBYX2VWB9xNhHS8GEyUm2+YKrX9H2PbhuBNTwQoSBZdvF?=
 =?iso-8859-1?Q?kFiTYXCFWweO8dNITMclCWMCcVNque4U69ZQFR+CH3pisvOK5hDzobs0fG?=
 =?iso-8859-1?Q?ymgRS7NsfnI6LBYxg+fXIDE4vGgkX8WRA22dkdv802G6zmtrSHqgGOhvPN?=
 =?iso-8859-1?Q?SZz/ufHgZX76u2JJ/xDu0NeND6SPmso0W+rauHiQ7Zvbcs58fCTA4RY1V6?=
 =?iso-8859-1?Q?nVTDyV4+CPAulAyxk/+/E/gdMrls+Ezgc2Ur7ctgarp2EVWJnCezrSAaga?=
 =?iso-8859-1?Q?vtN5Lw3AfawggjqxD+prwRo6+Elr/XZQFLTab22cJT9nFw7jgOBf6CKFdX?=
 =?iso-8859-1?Q?Pl9Peu0iUsFa9OyM2DLMl4WdV1Moq6foJnVTmAVmHPJ91jq1m1XiFaMP8k?=
 =?iso-8859-1?Q?S37YHI1iuD6vKs7grXFoy3EakhYNOhkY/+2EFiTlwpkvDE/onF3n8l9A0r?=
 =?iso-8859-1?Q?dHRhVcB//qCFNBkyjPU5qiIxtRXTqzEV3KzU2cEf5VK3apoJ+qj7AD+jR8?=
 =?iso-8859-1?Q?RLqUeZDNqmuuF7Up/B0Q2cTcTOhLtYgPTE92RGheDeayC/wedkGoA9vsII?=
 =?iso-8859-1?Q?k5z1dNWkrebWquIxVCwG9xBNtuqWBa5ylUANxhaMbXC4rd/Kfoj5aPCsI9?=
 =?iso-8859-1?Q?L5kR7aD9kNUnSIdF00egFsmoKl3koCZJ7sX2h9iCImC9wwHK7U0oYUqjn0?=
 =?iso-8859-1?Q?uKnMi1ddQlLG8HOhbFz7Sza3roizJd20EwGQB9RCs0cCfxhrdot7arZoU4?=
 =?iso-8859-1?Q?nfmwa3foG3TNDmicnhDoFaOf30Ch7LC2R1ta8BHfr3peu6sT5GV55FljNL?=
 =?iso-8859-1?Q?0ftX3JoKvAvDXQRAsILgqkEtOVD2PJkptGc47MdYGN7HULxuidIIsQWmY7?=
 =?iso-8859-1?Q?T1OgItCxf/2XXOIk6Usm6z8Wh9dAwq2Hncqbuaa5sQAViyHJAqUN1+d6l6?=
 =?iso-8859-1?Q?t8baZgFC34huDNGyYM4vs7rXGIT9zXYOXfReqG8SntlcC/o+4S0KnHAEHF?=
 =?iso-8859-1?Q?UnXvX+h5iyRVPgQGtl5Kmc2Cxxej0BSMtvxbzLtlqF7RI8vXjHPhpaedtC?=
 =?iso-8859-1?Q?HbVWVvN7q4zxLaBTbiqECXJknubbjLkFnN8DBhdCRD11hBWfOp9e73I6nc?=
 =?iso-8859-1?Q?972QbbEhXtvTmcxJvfARRwkm5A+NNQhpOZVdAHlXxMKCvObwrqDxL69Le1?=
 =?iso-8859-1?Q?yYz3eBwaPqdiF5mYkdFqLLGa1QbaB0J1JaEhMIZXyUOo07hgyrP+2c0Zxm?=
 =?iso-8859-1?Q?TOr4MfttV8jyFYOEx6tbNiIzeJ1hvLyDa3TosOILNyIKa9f7UY7YWOVvUb?=
 =?iso-8859-1?Q?m7sV93LeIJU4+jSHjrLtYKvqqnLX4MZK7RUJa5N0KnLnjdBZ8y7LnID7Wa?=
 =?iso-8859-1?Q?XAgfEbgsBS5kbfGyzXY=3D?=
Content-Type: multipart/mixed;
	boundary="_002_PUZPR04MB631619A22F03DDBDC97905DD813F2PUZPR04MB6316apcp_"
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	7YYSGdVxyTJoa8xSOFhAfo2q1ttLAYCo3ggqX4aQKqc/N0dHf8J9u8BqLZgEjPof97k6l8GoxP3kvAmr4n3wEuFepECHDYJF2eU13kSPRCHX/tC8ccYB/kgAcElDD+npMrkRH2qDp110nv2EfUi+L60hjuOTFFEM1ffa1WQ6HUq3c+xnlFZZ688Fc1L2LGfarqJW9DRn3jrV4/tSDwR5L4HVq64vmLJX5ub0+yYZvTrE3XJMq8gA9MhaCCU4PH5tYCDmKvmbh07uh5sr+jP4KCUtuO9qT2Ysm5VvThm0/x+A/9Ve35YYIBEl6WAIBQCN7xb4vE5JSIsJOqKo7/d4gHNmnY4bA8gcBH7eH/MKnbe0/Yi9CN7GJAwm4hzIoSMaq4KJjRw+JfHB6Nahdd+zA9VF3AR+nLzl1XBAeyL5196Zeas5AtzrWXLG/bcp7yuCMIqxUrkd1/FsgIX5Yvh4oP52st8uvBInHd0EIvrixL2+zXDKgyD8Qykjm/95MqHRVpXZ1UTVdr+zhN8H8S0M/qf60d0HoYyznWUMG0Gr6ECOxhCAoXj6PYAuswPbkLCu63hDtzX1kAcZ3QDwJ1HTAil6km554gxVLpUcfBm41TL37OukrTvUxP2g6cYOiubq
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PUZPR04MB6316.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2458293c-0ded-4344-3b1d-08dd1a8c09a4
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Dec 2024 09:04:51.5451
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lopiPFS4sVoBYKgdlpZ1WRm799DkMkgEFS2DKpL3Qi8NXg7j45E46nqAdspNRp6AUscjaWhPKqNk/LIsljLSaw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0401MB6211
X-Proofpoint-GUID: -5AijMovdV9yg1Rsmq1Wxi-fhm8shWBg
X-Proofpoint-ORIG-GUID: -5AijMovdV9yg1Rsmq1Wxi-fhm8shWBg
X-Sony-Outbound-GUID: -5AijMovdV9yg1Rsmq1Wxi-fhm8shWBg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-12_03,2024-12-10_01,2024-11-22_01

--_002_PUZPR04MB631619A22F03DDBDC97905DD813F2PUZPR04MB6316apcp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

#syz test=

--_002_PUZPR04MB631619A22F03DDBDC97905DD813F2PUZPR04MB6316apcp_
Content-Type: text/x-patch; name="v1-0001-exfat-zero-new-buffer.patch"
Content-Description: v1-0001-exfat-zero-new-buffer.patch
Content-Disposition: attachment;
	filename="v1-0001-exfat-zero-new-buffer.patch"; size=1196;
	creation-date="Thu, 12 Dec 2024 09:03:54 GMT";
	modification-date="Thu, 12 Dec 2024 09:03:54 GMT"
Content-Transfer-Encoding: base64

RnJvbSA1MWIwZTNjZmM1YzBjNGFjMDAwMGZmOTdkMjM2ZDI0MzQ2MThmN2ZjIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBZdWV6aGFuZyBNbyA8WXVlemhhbmcuTW9Ac29ueS5jb20+CkRh
dGU6IFRodSwgMTIgRGVjIDIwMjQgMTY6Mjk6MjMgKzA4MDAKU3ViamVjdDogW1BBVENIIHYxXSBl
eGZhdDogemVybyBuZXcgYnVmZmVyCgpTaWduZWQtb2ZmLWJ5OiBZdWV6aGFuZyBNbyA8WXVlemhh
bmcuTW9Ac29ueS5jb20+Ci0tLQogZnMvZXhmYXQvZmlsZS5jIHwgNiArKysrKysKIDEgZmlsZSBj
aGFuZ2VkLCA2IGluc2VydGlvbnMoKykKCmRpZmYgLS1naXQgYS9mcy9leGZhdC9maWxlLmMgYi9m
cy9leGZhdC9maWxlLmMKaW5kZXggYTI1ZDdlYjc4OWY0Li5kOTE0Mzc4MzE4MzUgMTAwNjQ0Ci0t
LSBhL2ZzL2V4ZmF0L2ZpbGUuYworKysgYi9mcy9leGZhdC9maWxlLmMKQEAgLTU0NSw2ICs1NDUs
NyBAQCBzdGF0aWMgaW50IGV4ZmF0X2V4dGVuZF92YWxpZF9zaXplKHN0cnVjdCBmaWxlICpmaWxl
LCBsb2ZmX3QgbmV3X3ZhbGlkX3NpemUpCiAJd2hpbGUgKHBvcyA8IG5ld192YWxpZF9zaXplKSB7
CiAJCXUzMiBsZW47CiAJCXN0cnVjdCBmb2xpbyAqZm9saW87CisJCXVuc2lnbmVkIGxvbmcgb2Zm
OwogCiAJCWxlbiA9IFBBR0VfU0laRSAtIChwb3MgJiAoUEFHRV9TSVpFIC0gMSkpOwogCQlpZiAo
cG9zICsgbGVuID4gbmV3X3ZhbGlkX3NpemUpCkBAIC01NTQsNiArNTU1LDkgQEAgc3RhdGljIGlu
dCBleGZhdF9leHRlbmRfdmFsaWRfc2l6ZShzdHJ1Y3QgZmlsZSAqZmlsZSwgbG9mZl90IG5ld192
YWxpZF9zaXplKQogCQlpZiAoZXJyKQogCQkJZ290byBvdXQ7CiAKKwkJb2ZmID0gb2Zmc2V0X2lu
X2ZvbGlvKGZvbGlvLCBwb3MpOworCQlmb2xpb196ZXJvX25ld19idWZmZXJzKGZvbGlvLCBvZmYs
IG9mZiArIGxlbik7CisKIAkJZXJyID0gb3BzLT53cml0ZV9lbmQoZmlsZSwgbWFwcGluZywgcG9z
LCBsZW4sIGxlbiwgZm9saW8sIE5VTEwpOwogCQlpZiAoZXJyIDwgMCkKIAkJCWdvdG8gb3V0OwpA
QCAtNTYzLDYgKzU2Nyw4IEBAIHN0YXRpYyBpbnQgZXhmYXRfZXh0ZW5kX3ZhbGlkX3NpemUoc3Ry
dWN0IGZpbGUgKmZpbGUsIGxvZmZfdCBuZXdfdmFsaWRfc2l6ZSkKIAkJY29uZF9yZXNjaGVkKCk7
CiAJfQogCisJcmV0dXJuIDA7CisKIG91dDoKIAlyZXR1cm4gZXJyOwogfQotLSAKMi40My4wCgo=

--_002_PUZPR04MB631619A22F03DDBDC97905DD813F2PUZPR04MB6316apcp_--

