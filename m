Return-Path: <linux-integrity+bounces-6369-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CFA2FACF0F1
	for <lists+linux-integrity@lfdr.de>; Thu,  5 Jun 2025 15:40:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4588B3A8962
	for <lists+linux-integrity@lfdr.de>; Thu,  5 Jun 2025 13:40:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C14D725D549;
	Thu,  5 Jun 2025 13:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="QV2V9Q8L";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="J0BKzBt+"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABBB72494F8;
	Thu,  5 Jun 2025 13:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749130848; cv=fail; b=P4bdjbjT1pzxPESQbsD3Wro466WlEXE1c0l5EiGnGk0uJlBeUEhfqpeV+fZ0v6i3BCzvhpQnAAmSTSc/mGq4Dpb7DuWgK2SFkIIpneqKcAcdvXVMr9OuY2fvYE73pt7P0AzWQ5fErM1fcOKy2xyj0sTDxOAhWb1v9v8EAwpZAn0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749130848; c=relaxed/simple;
	bh=NJpGOLZCTmEhuSUyk+BEq8AMY7OI+5/o7khhilrfrfs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=X8j5uRXWwSPIeTe8Zm44QZ6BduSwqAotAKwsux/DXzQhsozBW4oJlo3R6vltsoTp0uLP2m/G1pquH90VLqI726d38I7KeVpoPCPqrGFpC9YjsRk04TQkHEUwQkI2s6AFCrr7az/Cf2yH/5Ci3+eD5Jrf6qBz5POhrj8qVUuzQJE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=QV2V9Q8L; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=J0BKzBt+; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 555AtZoG004885;
	Thu, 5 Jun 2025 13:35:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=NJpGOLZCTmEhuSUyk+BEq8AMY7OI+5/o7khhilrfrfs=; b=
	QV2V9Q8L+Ot1j+gCaz9WiEwmijXF4/yWa9a372gsIn7Mj6d3g3s76GibzqgBzw2T
	I+5dwNWBhQfm9LTwiJwWmT063fxqJeomIR9Si30/U26vSuwCSOjliymy5XtoqL3R
	54bHHUm7gRJG90uz9n6AQDN4MaIzK2jr8Ozjk84HFQeJ501Oq3yLkj44O4vS+D0z
	5UfcDhKQnMTWC7arGwK5dSmHPoNrw4iy3hZOLu/HJxIuVwfZxYZp6dPJ4IUF46EU
	rWPIB9k6PVGU3fk1czw/o/sHKi0QfHe2ae4tueUO332WyWV1mHkX+4hQVngbSSWo
	8OiabZ+CndhBcfvJuiqABQ==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 471gwhdyv2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 05 Jun 2025 13:35:12 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 555C0bHd040645;
	Thu, 5 Jun 2025 13:35:10 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11on2063.outbound.protection.outlook.com [40.107.223.63])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 46yr7carmb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 05 Jun 2025 13:35:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pgVxQHBbTvp1Et/uFJwwVGfrrVzrpC87Ew4Hx8xDhsZI5v57odavwL24cjhe2gG/iX7K51DIXmvVWwRy0TsNnK3UdllR0D6wMQTbOGywfLIONFxyatq4kfgytGBfqf16ssCtWgo0e+BLCjY/LK1xXUyqLS3hGq6CR+0h+yH5SQte2c4y77HmtOYdq2qLspMtMtYtrXKbLGNTlLMTW75fn1FoEsAJK+etFZMw5NjRgVkVNfFPDiyrznVUAQ2TzeBQXGe325rHJeB4U03ZIDBFC/v+JqpJfQB8XzlyTyyxmM7QkykaG1QfktNYwokV5wtcIBDAqNHVZqXq3A93neaI8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NJpGOLZCTmEhuSUyk+BEq8AMY7OI+5/o7khhilrfrfs=;
 b=XfpfBYzEpwPuZ3ImxbtemyUXv6+Z1CzWpTxDSbehU9nofNvi+1XCuD+KkYpNeWjMpBNlRzLRLlhIhBA7Nef4LCkBPnvGdSRGia0vuTJWQ6mZBxJbUhq7rVygVdpvKXkYhstA3bQ607iP/yw8QMFS5JmkKEymWJafSrOkMNm5ZX5ZkQNAx5HqrpYzkbsQEEPjnUUdTLdCP/y5Eizq5kPpG9eC8RrkCP2beSFUNiIzfhSx3u68j1n4DMQbM6iKIcKbnYmQGP8TvKwYLNJJB06nfWi3X8hzl2w7HD77bG+bYveESTeNNWwGvp4SjSLLIp7HDzzf3ol/iQ92x6t256wSAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NJpGOLZCTmEhuSUyk+BEq8AMY7OI+5/o7khhilrfrfs=;
 b=J0BKzBt+H6X+PIRm9N7GD4jEj5Iq3bb8S6qXpw0hZDMbIfAmkkGz1K4njmXPNGJYCtI7qa6XJe52f6Cs/2CoLxf26x6RfCS1kk0W4L+LzF2UBI1w7tEk3X2FwPOFHKQI1sPg8dRFKIQ4p6VO5zpTmhUqAdBn0/sF/OiydenngmE=
Received: from PH7PR10MB7730.namprd10.prod.outlook.com (2603:10b6:510:308::13)
 by IA3PR10MB8735.namprd10.prod.outlook.com (2603:10b6:208:576::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.21; Thu, 5 Jun
 2025 13:35:06 +0000
Received: from PH7PR10MB7730.namprd10.prod.outlook.com
 ([fe80::7ac6:2653:966f:9411]) by PH7PR10MB7730.namprd10.prod.outlook.com
 ([fe80::7ac6:2653:966f:9411%4]) with mapi id 15.20.8792.034; Thu, 5 Jun 2025
 13:35:06 +0000
From: Eric Snowberg <eric.snowberg@oracle.com>
To: Vitaly Kuznetsov <vkuznets@redhat.com>
CC: James Bottomley <James.Bottomley@HansenPartnership.com>,
        "linux-security-module@vger.kernel.org"
	<linux-security-module@vger.kernel.org>,
        "linux-integrity@vger.kernel.org"
	<linux-integrity@vger.kernel.org>,
        "linux-modules@vger.kernel.org"
	<linux-modules@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>,
        "keyrings@vger.kernel.org"
	<keyrings@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        David
 Woodhouse <dwmw2@infradead.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Luis
 Chamberlain <mcgrof@kernel.org>,
        Petr Pavlu <petr.pavlu@suse.com>,
        Sami
 Tolvanen <samitolvanen@google.com>,
        Daniel Gomez <da.gomez@samsung.com>, Mimi
 Zohar <zohar@linux.ibm.com>,
        Roberto Sassu <roberto.sassu@huawei.com>,
        Dmitry
 Kasatkin <dmitry.kasatkin@gmail.com>,
        Paul Moore <paul@paul-moore.com>, James
 Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>, Peter Jones
	<pjones@redhat.com>,
        Robert Holmes <robeholmes@gmail.com>,
        Jeremy Cline
	<jcline@redhat.com>, Coiby Xu <coxu@redhat.com>,
        Gerd Hoffmann
	<kraxel@redhat.com>
Subject: Re: [PATCH RFC 0/1] module: Optionally use .platform keyring for
 signatures verification
Thread-Topic: [PATCH RFC 0/1] module: Optionally use .platform keyring for
 signatures verification
Thread-Index: AQHb08HkgcEyJxmAAEWMnJeO5wKlP7PzPTKAgAAJQICAAPA0gIAAXxYA
Date: Thu, 5 Jun 2025 13:35:06 +0000
Message-ID: <435F53C6-DC08-49CA-AA36-9747FC1B50DF@oracle.com>
References: <20250602132535.897944-1-vkuznets@redhat.com>
 <0FD18D05-6114-4A25-BD77-C32C1D706CC3@oracle.com>
 <f0b37bc55ed3c02569c74f0fbdb6afa8efd329e2.camel@HansenPartnership.com>
 <87zfemoc76.fsf@redhat.com>
In-Reply-To: <87zfemoc76.fsf@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3826.600.51.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR10MB7730:EE_|IA3PR10MB8735:EE_
x-ms-office365-filtering-correlation-id: d381516e-0f78-43d5-f0c2-08dda435c8b0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|7416014|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?WTBlZkRmaG5pQk9oWlZ5Nmh4bCsyaUVJb1k1L3N4c1FVUzYyTGpiNmxDUnlB?=
 =?utf-8?B?K2w0bmtiQXJ0dGN3UHlDem5EbWtCdzh4eVNwbFhFeTVPWjhPSEZQR21hZHBl?=
 =?utf-8?B?ZmM0WFNNWDJZejRmckN3SUFrNDY0RDBFbElNL0VFRWhvSC9NMW50dGRIdFVG?=
 =?utf-8?B?bmlieTFuQnVwZTY1ZU03Q2cvT3YyVWI5WkpmQW5ocDA4T09iYlZiZGw1c0VN?=
 =?utf-8?B?Y1BvWTRsOFFubTNERHNEZ2o4akVaejBTaXNUNlZ1RVJpbzc2YlM5enFMZFlQ?=
 =?utf-8?B?N3ppTUhoY2hpR0RWNDRDcUdtZ1NabHNmNkM0OGV6bEV2bFNSb1ZzcnFOajVo?=
 =?utf-8?B?ZVAxemZQL2FWdkV3cFZmQUV5cUdCRlVIdllRZXVMaXE3aTJSY0NLTERLRHF6?=
 =?utf-8?B?dDliLzBYcHllSE0wWHZqbHNJdjdaYmU5blFkUDlSNzB5a3pqT0JVeHdBNGtp?=
 =?utf-8?B?ZlhjckJsaDdWTHZqa3pFQzZPVGlZUTc5V21hVXREK2xzQzB5ZHJZQkpqdkdt?=
 =?utf-8?B?T1pPUTYwNzlsSjAyZ1pncThZdFBCTUFKMHV2RzVuOWNIdHA0YVdiNy9tOVNO?=
 =?utf-8?B?cWRRM1VNR0psMm5OakVXeHZwc1pWbE03NjN1RXdna2xkKzdZZjVmQlF3Yjlr?=
 =?utf-8?B?VWhFMk5iWjB2Y3BGOGY2dno2bUtPWGpGOHE5bC9GTnJ5dlB2bWQ5c2FnS29K?=
 =?utf-8?B?R09ZMkpEbjBBb2JrdGZROXcvUXBrQUVpMno1NGRhWGNlMHV1T2tlWnlLYngr?=
 =?utf-8?B?ak8xcm1vcFZLMWgxVkgyWHByQW42UGsxOUlaMlhiYkpNci93NVVhN1hiaWdD?=
 =?utf-8?B?M21WZ29YQVRQU0kvcXl3OVhjcTJrVXRyUHB6UHJGNk44YlBKQVZsNSs3a3V0?=
 =?utf-8?B?ZEFCbGlLUzE4M25qcVI5L2Z2K3RlMGlXa1VqQmdRUE1pOUlVN0tCTldVeGM3?=
 =?utf-8?B?K21JdGVpa3NiSEtiMkVCMnh1TjVGNnRTaEJaczFQRDdaN1E3VHJmYkVKMWFx?=
 =?utf-8?B?UDRvMXl2V2dLb1RmWHoxT0lCMU9xRXJSdldkUVRtTGhXNTMyYjBSS0VCMnhp?=
 =?utf-8?B?bTZaN01aT0xNOWNHeWkzeVVhMnNTTjVQT2dPR0Zya2hCVkRVVGFoZGJWeHhm?=
 =?utf-8?B?aURGbUJpTkdkVmtXZ0dOWHl2bmoyRnJWR053Um1XNVdEOGRPUmUvZ3c3REs5?=
 =?utf-8?B?d0NBeFMyTUlZY2ZVUGxLdytUWitFekFQVndMVlM1TDRPWlo5R3d4d1dTQy9N?=
 =?utf-8?B?UHhJenNGVXpQZ1RiWTNHRW9HWlJybHAyUzMyYVJkdTZpWXAxS2xzM1Nyb0lv?=
 =?utf-8?B?eUJzWW5WQ2RqdExVY1pzRm1CalpVRENjU3R1Z2FkM1FUbWVjVFVVM29vWXgz?=
 =?utf-8?B?Z0hHQlg4ckNheFRlWEVHWUR1WE1hRzZQN3dXMElMQ1MxK280OXdxR0JrUERC?=
 =?utf-8?B?Z1FrY2hpK3I1Nmk3VXVyVUZXTFNUdUFsR0dCZ0lkcDd1Z0dGNytFY1BrNzJ4?=
 =?utf-8?B?UHRmSmxXMlVkdWQ1YVBlZGVxdkZ0RG5iaW1JTWtpd1dyekg3WGh1MU04U25n?=
 =?utf-8?B?OEc0dHlPck1lZm1ybHBudVFiS1FMR2dqbVBwMktDdXlzZWxlNDdtMGMvbmkz?=
 =?utf-8?B?ZS9oR2QzVmxPZU40S25paGZSdFFCckRPbHkxSmY5U3FxSTZtT0VYcTRDb3Jt?=
 =?utf-8?B?Ujh1UFR5NldMSmF5TURvWk5uYzVWTnduTXhwenphS2dsanN1TnljaTNqcWRO?=
 =?utf-8?B?OEdiRkNsZyt0QlJ0ME1FOTd6TWFQcjVDZVdFRis3aTNyb2ptRXlDNWF0UGdJ?=
 =?utf-8?B?SXBQMWZJcXBkZE4wQlB6OENCa3lKbmliUnRUR1JRdGV2VTZweVJMd3EvVy85?=
 =?utf-8?B?U2RRTVhXV2w3cGk0TEtoSzgvNWZQTzVYMWFkODJEK3FQRGRTTWlPOFY1LzdG?=
 =?utf-8?B?U28zUTBuaGlBaVdtVk04UVl5TTVhS05PdlQ4Z0dQRUpNQzdDVFNjZWJVSkpz?=
 =?utf-8?Q?n+mRFF2tcQM8HvuLenze/ubHnK18Cg=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR10MB7730.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?MS96QWF2WERYTDhEUEwxYjY2Zm1zRGROWkVZY2dCZGxpZTFDN3p5RE1Uczd6?=
 =?utf-8?B?QWVhSmhrVzNXM2NRQWx4UGZxclNjTXgyVmJRemRnSjdyc1FYU0djdWl4STJM?=
 =?utf-8?B?MVQ5b0J2MVU2OUI1bGgvT1RVYlFXRHVqMm9Cd1NZV3FRbzhrNzZkbDNOcjZZ?=
 =?utf-8?B?SXZGZUN3aG5YbHlYeDVCbWVEcWErMGlJb0llbFViQkZyOHNtWDh4WXphUnFG?=
 =?utf-8?B?Qk1PUzlBZWhqYzFxbFlLdTdiWkZtRXhaMzRmdmdGSzEvbnlRczNTcmN5R0ZC?=
 =?utf-8?B?Zms5MHlWZ3NTSm8yV1N6ckU4UXdiYUZIM3c0M0VydXlnNld0ZnVkWjZ0U0tn?=
 =?utf-8?B?cjUwNUlyeHYwTDJUa2hiZ09ZUEJTTHJaNGFhNWJLVkhrbGdtbjZxLzMrTThE?=
 =?utf-8?B?a2J5YnN2Z3NvZjFKVnRyUWxWdHpkK01TeWNzM2pMSmN3NHRPTmhBQ2pwdHVs?=
 =?utf-8?B?ak9RODUvRnI1U0RhVTE4c0tPckZBTGZiRnpkTUo4RmphUFlRNC9LQUREZkdE?=
 =?utf-8?B?WDRHbkJ4K2Uwam9XWjFKbytYVzZrdVdER1BsL3YzelVIclk3Y0poTnUrc29h?=
 =?utf-8?B?QXlPQThONHJjSXlVRHNsYnZka3FzK0VOSWZkd2s0bitHVWdJV05xVzFHZ0hP?=
 =?utf-8?B?VlZwZWpjRm9QSHlxSE9WZ1I1MDZGVUNnZXUrS0s4M01EaEw2dGxZbThiR09P?=
 =?utf-8?B?Z28rNUlFcTdUbXlSSzJPbXNOZFk0ZmlNNmFLWWVscks3eHQ0YlgwS1cvUzFT?=
 =?utf-8?B?RXFmcUNGV0xKc3RkbG4rTlNjSG1jTEJvZ2RnL0oyWDZhMmFpaWZsMGhZc1Zr?=
 =?utf-8?B?cHNzMTVweW9sWmlKSWZBSUJsRFZJMzVPVWg2MGhGdm95azBFb3lYWksyQnM0?=
 =?utf-8?B?bW5BZ0RBdDczNWZYMFRyckRHTnVHRnJsU21LWWFmR0NuQUlrREpuN1pFeXhl?=
 =?utf-8?B?ZG9ZSXRBMkwzV2RyQnE5S2lsRmRKWnRtN295a1IvL1ZpL0ZKQ3VvdzUrSGhl?=
 =?utf-8?B?VWRpMWw5QTQ5TitmU2RmZHNld3M4MWhkSjVRVzRQdnN0M2JYNzFDemJiTTZM?=
 =?utf-8?B?dXRhSFhlVzBIUWRNdjN6N2R1Ky9qTmlrVGcwOVFwTVhhRTBySWhVaDhXWUFZ?=
 =?utf-8?B?TS9uTlpKUkpGZ3RZakRId05NV0o4M29zQzVxY2tHUHFPd0JMdExwTkJBcW40?=
 =?utf-8?B?VWZtOE9PSFpvaVZPaXdIVEE0Q1E3SlhVOEFSd0cvWUxYZU95S0JjOXc5VCty?=
 =?utf-8?B?WkwxQndOcy9DNWNzeHc3ZDc0VmpjR3BLQlVaZ3I3dU1QNFd3dzhOdStIRW90?=
 =?utf-8?B?VUxobjB4VStPYWNnM1lBc1lWcTgyT3QxVjNlOGQ1VElCUmFpKzZhSHBVK3Vx?=
 =?utf-8?B?VjZKcmN0TGN5WkUveVR2djFtMHpZY2JJbFp6dmZBTldVM29nNWI1NjlCbmtV?=
 =?utf-8?B?VHU4bDVrKzV3NHNpNVIxWVAvcVZaMVJYcXpSQ3RsMDR3U3NHakNTdzdVRFht?=
 =?utf-8?B?UHFPNDVHblJoWGxCUjFGYzN4QUlkVERRM21uK1NEYkxUb09VRC9Mc0FBOXFF?=
 =?utf-8?B?NU9Vc0g0YjNsVU9oUEFpbzRCUGRKYjh6N2diNUlsdGd4WEptdG05dEtxRUQz?=
 =?utf-8?B?R2F5aGhKQUtqZHZCdjZ3dldPV2RKTWcvTGRKejNJUzhlK3hPRis5TzM2d3pQ?=
 =?utf-8?B?TzdXQlE4VkduR2xsaVdoT1FNM2hoMGFQemtWL0JOZTYwZGx5UFdHRm1RRlV2?=
 =?utf-8?B?UnFPRFJHTkZXN0ZPTGd1eGt2K3hkTXEyODRpRGNrelducTZDSTJKY2dJY01U?=
 =?utf-8?B?L2JZakFSeXB2OUdpZlJSODZXSXFuS2pUdmRTb3ZvMEQ2TlBlVDNsbUJJRURP?=
 =?utf-8?B?a3cxZTVyNGlvTldOMVd1N2U4NnZvV0gwbmRNcWdsVmh3MW12YmdPZFF0cE5a?=
 =?utf-8?B?V3B0SjgxSWovblhpd2hTN0FUU1NJWE9jRmRMNWR3Sy9iVDZnQXUvNjFKWEUr?=
 =?utf-8?B?cHNURTVsK3NvMVFCVkVmRWNRRDVPd1lNK2dVS1BiQ1Q4ZHZxR3hla2lwUC9J?=
 =?utf-8?B?ZmZsbzBzdU02a1BscTZSUXVlZWt4QXFzSEFnVzVzOHNkSHozdkZHN0FKUEZU?=
 =?utf-8?B?cGw3TDFtWjh1UUI2ODZTd08zemQxU2NKY1ZCRWNXSCt6N1VGQVgrODBJQ2Jj?=
 =?utf-8?B?M3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D255CFBBC372794CAB3EAFE926B75A76@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	JdxL4gK7no71E+wuRbTGQ71y9SGUaqFBhc4pdR4IQKgAQsFmsAO4j4UwjyFJ70XHJNYgG968bz7r4jN4AZfLuU3mf2FD4aYLbJH00xo6ZvChpGIOjeywzWL+EjtmiMkVUUpNmdGwP2Uc6EpCK8GT8+lN/aCTqyoF4cXNdDAE2ic8Qj4Uf0k1Ey1ypPFbH6f4E31f7GQ5flV4oIEzcQpWlGXwmUCoy6oyWOce8inQwJcF2WfaDIslz6ZRJlnjMTApL0anXaG1oi2lEU+rzmGosKQpT/juLvpA7kpq2FnkaLoUuCeCZl+xdFG1YFeQnXaKH8DyYCUS3avGyONnwULv7/sT8hap/SHrr7r2+GxVnx3Xlq/39k5muMaRiw2sRJFymZR8W6HovMLwhfbttXfEl4MPAWQ4RPgPPHBNBiH6BlpYgvVcwmzid2Kht6hfrasd+IFNPomcCckYUJy/vu7/K5g5ALd6Ytkv/onkIjQuK9mZhshjI38BDC0Ct5W2BVjp5P6g85Dc1V/P17ORQ0Ug7yzSXAmIBXv82E56yh6cwrKT0vR5KxHhTkfoMeiZw+md1ZSyu5McG6jZKLfa+H6RrtoK/L5INxaBJEUtp3qHwKs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR10MB7730.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d381516e-0f78-43d5-f0c2-08dda435c8b0
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jun 2025 13:35:06.3686
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2wqvVyUQ4139JIBB7s6EAUSchPamQtM/1MXrBnhAOSLSchUBxJ1Db+DGexlfg78p8GLOoiA7+2mL6jh6U2agozPrjU/KhZGJCuLgDfqz1Eo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR10MB8735
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-05_02,2025-06-05_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 malwarescore=0
 phishscore=0 mlxscore=0 mlxlogscore=999 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2506050116
X-Authority-Analysis: v=2.4 cv=Wu0rMcfv c=1 sm=1 tr=0 ts=68419d10 b=1 cx=c_pps a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=GoEa3M9JfhUA:10 a=20KFwNOVAAAA:8 a=2vAUyIlJduZ2o82CzcAA:9 a=QEXdDO2ut3YA:10 cc=ntf awl=host:13206
X-Proofpoint-GUID: mIy77nOP2KnZYwFJgL5KXsmDscglV0H5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjA1MDExNiBTYWx0ZWRfX8HfcwnsQhf5o bTbCALPefxpKHqzDiAZu2d2+xWXBFHoIbu51FmWGPirUdzMmfE87VN1fmtMND9CgRmL+jxurqyl x/lSiH4/QV1AcpgB50P8hSPO6feuRd4ubjPyaP/JQrPy/Ng2oXy1mgEnwhHh39gxuvPi61SJ67C
 hqTZyOmE5Kbp2hToLE7CdVcwLjiY7XYoZgmo78aCH0MasfQgrhqJHaVN51DbXtx2mjPk+LMP3Y/ KaCgjBgQ/pDA3zks5lfne9ej8xUcTJ1LiQ+PVG2B3QBHBMTCqe9UyTznuDoNOyIRqM9rCpYrdTE gSeAAwqaek49plwxx4IBYvwslo53YOPRIBnundCR73/VGJ8lJCdh1nNLLHca3hq7xpXFQuvFR4X
 UPc9gwflgleD8F0JIHx+ahfLvYKyVKLJUZ0VnUhtAhsZqtWxYMDhWciKRc3tGZEJ0WyKF1Th
X-Proofpoint-ORIG-GUID: mIy77nOP2KnZYwFJgL5KXsmDscglV0H5

DQoNCj4gT24gSnVuIDUsIDIwMjUsIGF0IDE6NTTigK9BTSwgVml0YWx5IEt1em5ldHNvdiA8dmt1
em5ldHNAcmVkaGF0LmNvbT4gd3JvdGU6DQo+IA0KPiAnY2VydHdyYXBwZXInIG9mZmVycyBfYV8g
c29sdXRpb24gd2hpY2ggaXMgZ3JlYXQuIEl0IG1heSwgaG93ZXZlciwgbm90DQo+IGJlIHZlcnkg
Y29udmVuaWVudCB0byB1c2Ugd2hlbiBhIHVzZXIgd2FudHMgdG8gcmUtdXNlIHRoZSBzYW1lIE9T
IGltYWdlDQo+IChlLmcuIHByb3ZpZGVkIGJ5IHRoZSBkaXN0cm8gdmVuZG9yKSBmb3IgdmFyaW91
cyBkaWZmZXJlbnQgdXNlLWNhc2VzIGFzDQo+IHByb3BlciAnY2VydHdyYXBwZXInIGJpbmFyeSBu
ZWVkcyB0byBiZSBwbGFjZWQgb24gdGhlIEVTUCAoYW5kIHRodXMNCj4gd2UnbGwgZW5kIHVwIHdp
dGggYSBidW5jaCBvZiBpbWFnZXMgaW5zdGVhZCBvZiBvbmUpLiAnZGInIGlzIGRpZmZlcmVudA0K
PiBiZWNhdXNlIGl0IG5vcm1hbGx5IGxpdmVzIG91dHNpZGUgb2YgdGhlIE9TIGRpc2sgc28gaXQg
aXMgcG9zc2libGUgdG8NCj4gcmVnaXN0ZXIgdGhlIGV4YWN0IHNhbWUgT1MgaW1hZ2Ugd2l0aCBk
aWZmZXJlbnQgcHJvcGVydGllcyAoZS5nLiB3aXRoDQo+IGFuZCB3aXRob3V0IGEgY3VzdG9tIGNl
cnQgd2hpY2ggYWxsb3dzIHRvIGxvYWQgdGhpcmQgcGFydHkgbW9kdWxlcykuDQoNCkNvdWxkIHlv
dSBwbGVhc2UgcHJvdmlkZSBtb3JlIGRldGFpbHM/IFRoZSBrZXJuZWwgbW9kdWxlIGlzIHNpZ25l
ZCB3aXRoIA0KYSBzcGVjaWZpYyBrZXkuIFRoZSDigJhkYuKAmSAga2V5IGluIHRoZSBjbG91ZCBp
bWFnZSBtdXN0IG1hdGNoIHdoYXRldmVyIGtleSANCndhcyB1c2VkIHRvIHNpZ24gdGhlIGtlcm5l
bCBtb2R1bGUuDQoNCldoeSBjYW7igJl0IHRoZSBSUE0gcGFja2FnZSB0aGF0IGNvbnRhaW5zIHRo
ZSBrZXJuZWwgbW9kdWxlIGFsc28gaW5jbHVkZSANCnRoZSByZXF1aXJlZCDigJhjZXJ0d3JhcHBl
cuKAmT8gV2hlbiB0aGUgUlBNIGlzIGluc3RhbGxlZCwgdGhlIGFwcHJvcHJpYXRlIA0K4oCYY2Vy
dHdyYXBwZXLigJkgaXMgcGxhY2VkIG9uIHRoZSBFU1AuICBUaGVyZSBjYW4gYmUgYW55IG51bWJl
ciBvZiAnY2VydHdyYXBwZXJzJyANCmluIHRoZSBFU1AuIERvZXNu4oCZdCB0aGlzIHNvbHV0aW9u
IGFkZHJlc3MgdGhlIGlzc3VlPw0KDQo=

