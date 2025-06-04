Return-Path: <linux-integrity+bounces-6362-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B75A7ACE2AF
	for <lists+linux-integrity@lfdr.de>; Wed,  4 Jun 2025 19:02:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 73B91160FD5
	for <lists+linux-integrity@lfdr.de>; Wed,  4 Jun 2025 17:02:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E25E61EA7CE;
	Wed,  4 Jun 2025 17:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="SnVW0jdU";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="wHTQ6Iok"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1929D1CAA82;
	Wed,  4 Jun 2025 17:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749056561; cv=fail; b=el3YVlEtgLOq175+YiE7U/RwK3DBvWqMzK9rBfslgx0nvLO497cYSTgztxKfYyXy7EaMh9K5j3WBpqXJM67PuavTcp+P+MXhXwFyXCxKTbhsgM0XCHdp6EzGdPPZ9+i/BJMARpkIrTeezgzPDloG22TVK9ZSnPBlRmdtLoHt0bE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749056561; c=relaxed/simple;
	bh=6yE7+eIxvaUwzXtzJFwTmiRCV7cNRiofdxOL8aVCDpU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=uTz+DqOD/KZ1NYQtd06FmcCJrqXGC1M2czWW7wW4K4Smpsp7KGikzx4cvi3nMVTRMED6LT7fhJQP9J2CzaQ+Hetfld0vDFTh+USp5H0VWuKmXkgJnILd+VJ9gr5g+1DUpzPHTr3fK31W6XtUe6VAu9vdUrkoCH6SebW6h8J6GHk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=SnVW0jdU; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=wHTQ6Iok; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 554FdvSn032156;
	Wed, 4 Jun 2025 17:02:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=6yE7+eIxvaUwzXtzJFwTmiRCV7cNRiofdxOL8aVCDpU=; b=
	SnVW0jdUz+RMkQa9r8YpLzu2tkik365YJbFePO6ECHVRPWXCh6cNNe1mdmjqiwXq
	aMYhW+u9OcS5RR6+5XTsmoAkNaHbA+whi9mb3B+ec9dwTWL/jHMt9prBCFMPzB98
	1zYmryuJMq4qaMqAXUYurWlDMSOcjpcS3SM+ipU07+78LSdeLJ2lrzgg1lIV+O5I
	ADXOTyDDENgDwO4G9oXahnn9DKr+Texm4SX0e74GFtEtbISncO3v7p60kXFj89+O
	FOCUx6AuUTQUQRAfdBYRUpLgejGHu6o2CElUNcVszSrV++LJpV/Y0Megr9kkGnGs
	ephImpYtWRs8I/+eMFfWcw==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 471g8dvg2k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 04 Jun 2025 17:02:02 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 554FroXf034871;
	Wed, 4 Jun 2025 17:02:01 GMT
Received: from sj2pr03cu001.outbound.protection.outlook.com (mail-westusazon11012058.outbound.protection.outlook.com [52.101.43.58])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 46yr7b945v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 04 Jun 2025 17:02:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xw8ZEriaC/iq+JFclA9pMrqOhUvim/Q1NuNR6TYEj2r7SAVfQrI1UiA8lEbJBum7zEPgD8ggGVgVyH+qxZFcTZqf5pNLFJqaxb6/ohCrnPCPnKSXqP7wwR9dpWIItXcCJwNlL60YFb9f0My7lvjA09xVj9jKzhg3DRId5V2rJ1icXi2UZbBgFEqMX7gn8N7pKqEQ1PwP8ojEZfx51N6fr80jTlMdzCpsXD25BDRs8LxH1Oc536xPTo4svPbTsiHMJMifOypR3j/dMySVICKu27MCkmxPK6Im3Pq3JRnEeMZha3CPDrI+094nhCfyeucAlvYo81GhToq7rDZgf082iQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6yE7+eIxvaUwzXtzJFwTmiRCV7cNRiofdxOL8aVCDpU=;
 b=Yj9cePz1i4eLHI8iuUgIMkee3qzR8Fj7M4m6yc0gRad9BRxNbtybz8ivSBe5NSO9JDA/EODL5XLosPYgBk1EdWCDCGg9QK+1i3zAmXUkJSauZU4eByD089PsKV2yBWkb3jQq+sEIX386hsY6LTsgiuFQESYJBa7CcC/WVBFB0auQzye0d8IWGxETdhb/h/hY2MAPi+9jqNBRtXza9WCRS3uOvu9Uh6eeK0cMB+jIHeeKMA1kyvEmerQ7X0vyJYBd8tz/NL4B6cIPH77clugSTmNiSE1oZQLo+dx/sPgRhqZyTCa/VAMzBaGD02YKwqHW73PdDxXksGxL3RaNPD9dEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6yE7+eIxvaUwzXtzJFwTmiRCV7cNRiofdxOL8aVCDpU=;
 b=wHTQ6IokwGUptqS40nPCSVq0Y+aSTWKid6R4saYx5eWK0utT0RG6lB5Ui9aBxrf5901JaM9CySohiQZNgq/WI1rSt+tlW/rwHaYn8/8C+8qZ5sjPu4xualhLgh6NAq4t3qc1QrzIZhX52/roNOTfNAE/ICIPHTy423U51AwOddU=
Received: from PH7PR10MB7730.namprd10.prod.outlook.com (2603:10b6:510:308::13)
 by DS0PR10MB6152.namprd10.prod.outlook.com (2603:10b6:8:c4::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.41; Wed, 4 Jun
 2025 17:01:58 +0000
Received: from PH7PR10MB7730.namprd10.prod.outlook.com
 ([fe80::7ac6:2653:966f:9411]) by PH7PR10MB7730.namprd10.prod.outlook.com
 ([fe80::7ac6:2653:966f:9411%4]) with mapi id 15.20.8792.034; Wed, 4 Jun 2025
 17:01:58 +0000
From: Eric Snowberg <eric.snowberg@oracle.com>
To: Vitaly Kuznetsov <vkuznets@redhat.com>
CC: "linux-security-module@vger.kernel.org"
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
        James Bottomley
	<James.Bottomley@HansenPartnership.com>,
        Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH RFC 0/1] module: Optionally use .platform keyring for
 signatures verification
Thread-Topic: [PATCH RFC 0/1] module: Optionally use .platform keyring for
 signatures verification
Thread-Index: AQHb08HkgcEyJxmAAEWMnJeO5wKlP7PzPTKA
Date: Wed, 4 Jun 2025 17:01:58 +0000
Message-ID: <0FD18D05-6114-4A25-BD77-C32C1D706CC3@oracle.com>
References: <20250602132535.897944-1-vkuznets@redhat.com>
In-Reply-To: <20250602132535.897944-1-vkuznets@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3826.600.51.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR10MB7730:EE_|DS0PR10MB6152:EE_
x-ms-office365-filtering-correlation-id: 9e5fb36e-eaf8-4f55-e2eb-08dda389846f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?QTB2TTY0UnA0NmZvME9xdFRBekV4SkdoWVlzZDFFZVNZbndHWFczYUZROHN5?=
 =?utf-8?B?dVRqM2E4bVpvb2NGeWNXRUhqRGswQjhpTkkxWk1SK3htbDNuZFdSUVVnWmhH?=
 =?utf-8?B?NkNLb3lXYjBGUlZVWk0vOEorcG9pMXRJQkV6TXBZazhvbG5uYktUVW43ZlMw?=
 =?utf-8?B?VUZwa2xmNXZFNVhJNU12SVZ4MzF3RFBwMmhOcXBkQnQwVFV0dkpQaTlGVDVp?=
 =?utf-8?B?aHEwU2p3NG9oTS9aMHJqUk44Y3dKQ2RNTzhvSlhZdjJldmhRTU1sMmQ3TS9n?=
 =?utf-8?B?RGJUelhtZGhuMFlsbGJPRk5Yc05WK0REeU1DQ0ZudmRFSXBDaVlhRVBrZlIy?=
 =?utf-8?B?OEV6Rk5iMjVnOWlqa0VlUW1tZ29xaitJYkxFMEdqVi93cHhLWGRJNHVMTkRS?=
 =?utf-8?B?NzZqeXVXN1BKRnJNZXExWWxsY1hIVHBoV3ZJcUdTMnpkaUdxa1RoOGZLV2pm?=
 =?utf-8?B?Z0lCdEttUmkyemMzdXAvWXJVRVpTZ2hydjhqV3V3Nld2MUdmWHVYdFRSS2hL?=
 =?utf-8?B?VU02Vkg4ZDJFVGp2clFjRXZkbUlFS3ovMml1MDQ3bjdaQUR0UmI1RVh6NnVW?=
 =?utf-8?B?ZlVkSW9OU1pRMytrQzRRdnR1WkVHN2dRcFB1ZGNubkM3MkdWa1FNcmptVGhl?=
 =?utf-8?B?NFhXQVVoNHRoTDJ6ZWVWQWhta0ZCRER1NXFJdkxlQjA1QldMeWlxVkNQZlZl?=
 =?utf-8?B?QjJzU0FqNk43dm1sSFBMZzhYMXNHMnE0UStjbUxneGhWZFVxd1JKUk1IcTA1?=
 =?utf-8?B?RlIyR3YzdVRwVEsxTThCVUlISURVd0lOQmVLUFlpdXM3aTZKREZBWFZmQmVi?=
 =?utf-8?B?Qk1KaUdURUhYQ2QrZ1pCTXZlZFZrQ1EyL3h4alBGK3g2ekJVc1VJR3lhRHpa?=
 =?utf-8?B?eXI0TkZuWXhnSWszZlFTREQ5MXV2WjI1ODBKNTFjT2d5Sko4M1F5VG5oclIv?=
 =?utf-8?B?NHFBUnEvcDVISXlQN2pXR1Bad1cwUmlSbmRJKytWL1YxT0dHRE91MmtlNkt0?=
 =?utf-8?B?TWNaS2FMcjAvOGNYNi9OU3hNNnUzSnVYeVBqY0RPd3dYcHZrY2ZDcGF1bFJV?=
 =?utf-8?B?NUtuMXd6K0J0OGJZQkIwdXRIbGh2ZTlYTHdvdWFBakNVdFc2U2NOb1FQTVY0?=
 =?utf-8?B?VmFXL0xkMEd3OEtWb0hNVFZWL21tMUl0bDc1c1pWazRobDFTSVlOMXJTWFRU?=
 =?utf-8?B?a0FBdzFJekpjNE93MjJzRUpKRXFRV1daR1NuY0MyQUQyVVowcmR6T09PZ3da?=
 =?utf-8?B?RWsrWEp5NWRTd3BUb1hVUHpQVzV2enFyZ2c0WUlXem1tV2hnRFBzaHAyTjZL?=
 =?utf-8?B?U2FyZnZCVUtvUCs3bURYK0VNcU9HOVFqemZuVWdCcC9WRVhuZXp5bEV2cTkw?=
 =?utf-8?B?NW9yRDYvdnlyYk1uSzNuSDc5T3djTWpRaUxmYmdQSTZVak5vSkh2R01sM0J4?=
 =?utf-8?B?S1hBQTNJdlRySXZNZUpzb3VaNENoemtPTS9VeFpvbUUrNFZJcVBFL1NWcExy?=
 =?utf-8?B?ZU5NZnlQTEhNZldyS3BXTFRNNW80cDVKRUlxS3A3cXY3T3AyOXJuczlVbXd5?=
 =?utf-8?B?QnpRZlorUHN6V2tRaUFBSW92eHB4OGFhbXNPTHAyUzhnSHlpTU05QXZlRmNn?=
 =?utf-8?B?dTU3ZEptem9qTEZidnhhejdvOGg0VFRVRjNReXpNQUxRZVUrcEI0Y3IxVEpk?=
 =?utf-8?B?L0h3aUdzcHZBZnVuYk5ZV3RRSU5BaTZxQ0pCR3oxbTJncEpmUnNqQ1RBdUYv?=
 =?utf-8?B?OFdPeHk4aEo2Ukx2cklTVS9FWHlUMDI1MjQwYUZYbk1xRytwVkJ4M2k5K2pv?=
 =?utf-8?B?WW1kMzJjTGZkaUVSVUMrbW5tclp2aXdudFlvbXRjdHkvQlFMZTVkeEtPeXA4?=
 =?utf-8?B?UDJOblgwa0ZEVmpvejNrQnZMenNSUUpSeVNuZ2dMOGQwNXE2YUNzU2RQQTFE?=
 =?utf-8?B?MHJZVU9Ra21Lci9ZYndiN2JEdkJpdjR1TS82WlAybzhCS2FKaTRpOEUzbWd5?=
 =?utf-8?Q?nrFCrl86j5ZMBAOJmNL/aY1i+1cDoU=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR10MB7730.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?M3ZiaktVTDQwa3Z0bDZ0TmdvSmd6WDQzdmVOK3BiN1oxNlhVeDRPMFFEMHVi?=
 =?utf-8?B?ZHJHWmRtQzFJTXhhYUtBYWJNdlloWFVNZFpMbk9HcFl2MTBOd0RxVWJyN2Mr?=
 =?utf-8?B?L0UvVjJIeVFZcVJFSUhuSmMrNm4rQnhuWUYzVXFEN2VZNDdlREFzSFF1ZmtF?=
 =?utf-8?B?VVRBK00ybGtDcVNkeVkrRG1KSkptWTBMTTA5VVRMdTVVRkFnSkFDSDY2Wk9n?=
 =?utf-8?B?SlpOTmlQSWx5NXBxOVNQOHJyZXlCL0EvdHFEZ1FybnJvazNIMTdzc2lHMmV4?=
 =?utf-8?B?RXpDNXNacGlZK3FYSFJ3aDZCdEZ2dWtJNmw4K3dnTUs3R0NOMzFYUkxmS1lR?=
 =?utf-8?B?VVh0ZUdpdlByTGh5Si83amsrM05VU1prWWFlSkU1YzNaT3Z0cHNsM0FFKzJK?=
 =?utf-8?B?U3ViaytsbFZsaVVBdlpBYjM4N0F1aVBqZ2dNMGRGYkZzZTUvNTZWOWlmZ25j?=
 =?utf-8?B?REx4cW5HbWFieVFQZFdHdXZTWHh0anZvSWNoNTI4STAxTVc3bElPaEFwbHU2?=
 =?utf-8?B?dTgxTHNoaFFQdEVzcDFPZ0ZMU2NCV01ORURaWGxOUUpHKzRTREE3TktMN1hi?=
 =?utf-8?B?cU4zV0lFTFRQUkxoZTAyaFZNRDB4QUNzQ1JQRy85aEp1d0FPeDE1OURKTnhC?=
 =?utf-8?B?MWdFS1UyUmR4emJpeXV2RDFidTJhd1pvaEtUT1JFWUY2VEVINVdFR0g5ZlFS?=
 =?utf-8?B?MDlBMjhocnA4NVBsbDNySTUzQVp5VWVNaXVuM21kbHQxMElramh5ZmhxNGdh?=
 =?utf-8?B?cWM3OGtaSFhiZmwzbDFzWXBpbUNNZUV0Um81YWd6cmtnakkyQzdxVkV4S0JT?=
 =?utf-8?B?eWIyTmVPc3FNVGRUcmJhVmFMNC91Si9HSW9RbE9HalFHQVFINzFNRDhjMldy?=
 =?utf-8?B?Y1pZQklEMmFUeklYU3ZGTGZXSlIvaFlCSDZSWVZIZ2xjakJxbVd3aDNNNmtq?=
 =?utf-8?B?T0VHbHY5UXZST3h5emdYMGYyNFlYd08wdkNyYjBKVk5mbGNMdjNFV2NSTFNh?=
 =?utf-8?B?ZXhXcTI5a25LZkpiVmpqV041UVk5UFhrUEh1RVphSE9tanFZaDFXcVlRaHVu?=
 =?utf-8?B?emxMY3FPUGxTREVTeHczZHRia1pjOGdsQTQ1ZGRleERMaGc5eG5DYU05ZElQ?=
 =?utf-8?B?dDBGbzRGWmoxWUZxTFZMSVVnemNoMDN1WlR1WHR4eTh1cklEWWUyY09abU5z?=
 =?utf-8?B?Tld3amdxdnkxLytveVNYNTRzWE5PWDZXOTFGVkxQMDBJaUZTeW5FaHBkSTVD?=
 =?utf-8?B?MTdxR08vZFlkcWxMSElHL0tXUjhWVlNkUGo4Y25BZmhCdWM3akpIUG5LVDJZ?=
 =?utf-8?B?NG92WkhjRXloaWV1UXF6MjVKdS9xT1NFTlZYdUtjV2Z6WWROQnVlUmlHaUtH?=
 =?utf-8?B?TlNZM3ljR3AwTUUxdlFQV1NmUDR0NVJjZXY1UjBmRVVBZ3dEYkRPNTVzb3h1?=
 =?utf-8?B?emI1SFBsckFjTHgyODZHb3ZNWXVUZnJ5SzVXWndLQU5YNEwycms1MDR5T0xx?=
 =?utf-8?B?SElEL0pMS044L0l5RlkyV2IxOXkxeGJtY2lsMEtoMU9DZmhlbm5KR1ZwSFdK?=
 =?utf-8?B?S3F2NFFCVUowNzBmNkI2d25QMUhwcXFtc2R4Uis4eUtsRm9TVUJtcEVwbjNo?=
 =?utf-8?B?dTkvNEZLcXRhbWlWQ29PN2F0UEVJMVJMZGk5U0xLL3dTdVRZc1hscnd1ekQ0?=
 =?utf-8?B?YnFXa2tTK25PZnE5bkRnNG1jQ1ZSNmFMdU95a1UzV1hDRHFudzRpbllQdEg5?=
 =?utf-8?B?SDhZeEdaMU5KN3Z3d0NEYUZSbEZlMldORjZIdmQ2RDgyN0cxTDY5NWpDYUht?=
 =?utf-8?B?TG1xTnFOZmdia3dCS0ladVVEbXUzRmNMU1ZOL0svOE1mZ3VpMmQzaGJLRkpR?=
 =?utf-8?B?MWtkOUFSdFJVOWZwVE51LzJjY25Sb0Jvck5ZYW15QjdrR25odFk4eGFDcnZo?=
 =?utf-8?B?emJDMU9qd0UzQ0ZLUFRMaW43aHNWd2xzMWNFUUpZc2RXOGFkdHQxVkZPSEJL?=
 =?utf-8?B?Z2NjTGNPQU90YVlkMkNiN1ZuUUluNVJSMU5veDZXMGNGL3drcTl6aEpFZTFR?=
 =?utf-8?B?eUFsSnRJOTRveitBZFFTTk4rMDNvZHBkSmtTQWJrRVhmZ0w2bHVZT3Z6ZDMr?=
 =?utf-8?B?eVd5aHRZb1VSdXd1Q0lTZDBLN0k1S2pWcDB5THM2SG1GemFxbVV3cnpUVnM5?=
 =?utf-8?B?ZVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <619B304D7BC4A4479E8ADA5FDAC8E57F@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	xqZ0k1J1OSqHJziUxaOogpSdQ2F4FvOGGvEwVTCM9fkSD4E6VcAol/m3A1nk0QlGSMATDIalwkf7PXFqFQ+JRIvs0SUjTpFhKF/7EHT/EsmlZL09L8qofEWi7l5VgZEgBpFXdi+3CL7twhxaRS9WFf9XIJSc/82UEdbFJ2VkZv1CIf+Ae5rd5q6kpK+xFq6D+jXy29Q+x86QVGFLuF/o810WbgRxXS3cwK1IHMOmBQdeafoQwRu4c8NT0oAuFc8BYEgNJPulgxf3391KeuBd/jACX4VtPudppU0YKEKRRR63OGyLhf9iGvOugbG5QZUOFh0RlFg1ICEqEo86N1zd7hs5ERVYEwhtCZqJ+3HfE+1aqww4dBQCSeIneF3IxDQ9mtl7TdukTUnZ4V7Z+iTkBvfsApg1Q9l3gAVoiTnj8GMRET5evPgoRqAJX4Nnx/BkUCW7PQtJqopmvBlEkxUUPDhjj+WP9h47ebjfyNg6JWA8U2UzT0qy3KgznBGrS532Hnk8xW9FtNwQBOYPkH111W7LpWybWs5qQdhh7A8eNFQeDC+Z6zsxOrTOez9f7ykMqcYLQvbOAZ3tLkCKmd16FwQ8qasH4kx/vpcJ+NapCvY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR10MB7730.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e5fb36e-eaf8-4f55-e2eb-08dda389846f
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jun 2025 17:01:58.3981
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yhm5aM/VK2KeXeA+A1WfEayBhxQ/pnJceLoEkcNn8QxLdM+gpITU/DwMcPo5Y6ZzqIB0TQDAain7t4MdDWrlBmrkibHjGXVuBzbzdf5BFB8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6152
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-04_03,2025-06-03_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999
 bulkscore=0 spamscore=0 suspectscore=0 malwarescore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2506040130
X-Authority-Analysis: v=2.4 cv=Va/3PEp9 c=1 sm=1 tr=0 ts=68407c0a b=1 cx=c_pps a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=yPCof4ZbAAAA:8 a=20KFwNOVAAAA:8 a=uNL9aFTXj9Qd37RXVEYA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjA0MDEzMCBTYWx0ZWRfX70ItgEH5h5Ad sbZ968wXX4AA0HiyGFViLlWIaMvyPnPDX7r4lOM6FvMx10y7pFA35ysO11Sbi3qt7otSvX1kDZj fxjuJIYNofMQEkf1RR3NIbXsgcTpPGagGAyoOQZjzlrF9J6r/ejsgViROCPZeogHaT5XkCmFnZY
 orcRgrKX083Jm8t39bxPoEyhJyuhxWeIMoP37Oy7sEsN2sOYGlaLFNhzav3aIC5kMGf4XW4jYrY ak4uf5st3iruNYbil79xAar4N46nLQanlXHAjrEN3LakD23cf+53c9a0NUI0GGOCjYCpkUQHxri j4lNl/ii8kajCsbLKTdZEIxytNyQ6kmV57jrI57qTiL9flBacMYYEVQxi1ysBQn6vZJvH2ovVIR
 i7Vzp8H5OMh+6B9Zi36n1HzaiTrWDLIlGgJE/PVo48izrKp8PKCS53/uUA24avO4sKl+5PdY
X-Proofpoint-ORIG-GUID: XUklkQZnEWxVHbmfd-RISP_tgs5KpRIi
X-Proofpoint-GUID: XUklkQZnEWxVHbmfd-RISP_tgs5KpRIi

DQoNCj4gT24gSnVuIDIsIDIwMjUsIGF0IDc6MjXigK9BTSwgVml0YWx5IEt1em5ldHNvdiA8dmt1
em5ldHNAcmVkaGF0LmNvbT4gd3JvdGU6DQo+IA0KPiBVRUZJIFNlY3VyZUJvb3QgJ2RiJyBrZXlz
IGFyZSBjdXJyZW50bHkgbm90IHRydXN0ZWQgZm9yIG1vZHVsZXMgc2lnbmF0dXJlcw0KPiB2ZXJp
ZmljYXRpb24uIFJlZEhhdCBiYXNlZCBkb3duc3RyZWFtIGRpc3Ryb3MgKFJIRUwsIEZlZG9yYSwg
Li4uKSBjYXJyeSBhDQo+IHBhdGNoIGNoYW5naW5nIHRoYXQgZm9yIG1hbnkgeWVhcnMgKHNpbmNl
IDIwMTkgYXQgbGVhc3QpLiBUaGlzIFJGQyBpcyBhbg0KPiBhdHRlbXB0IHRvIHVwc3RyZWFtIGl0
IGFzIHRoZSBmdW5jdGlvbmFsaXR5IHNlZW1zIHRvIGJlIGdlbmVyYWxseSB1c2VmdWwuDQo+IA0K
PiBQcmV2aW91c2x5LCBwcmUtYm9vdCBrZXlzIChTZWN1cmVCb290ICdkYicsIE1PSykgd2VyZSBu
b3QgdHJ1c3RlZCB3aXRoaW4NCj4ga2VybmVsIGF0IGFsbC4gVGhpbmdzIGhhdmUgY2hhbmdlZCBz
aW5jZSAnLm1hY2hpbmUnIGtleXJpbmcgZ290IGludHJvZHVjZWQNCj4gbWFraW5nIE1PSyBrZXlz
IG9wdGlvbmFsbHkgdHJ1c3RlZC4gQmVmb3JlIHRoYXQsIHRoZXJlIHdhcyBhIGRpc2N1c3Npb24g
dG8NCj4gbWFrZSAucGxhdGZvcm0gdHJ1c3RlZCBieSBkZWZhdWx0Og0KPiBodHRwczovL2xvcmUu
a2VybmVsLm9yZy9sa21sLzE1NTYxMTY0MzEtNzEyOS0xLWdpdC1zZW5kLWVtYWlsLXJvYmVob2xt
ZXNAZ21haWwuY29tLw0KPiB3aGljaCBkaWRuJ3QgZ28gdmVyeSBmYXIgYmVjYXVzZSB0aGUgYXNz
dW1wdGlvbiB3YXMgdGhhdCB0aGlzIGlzIG9ubHkgdXNlZnVsDQo+IHdoZW4gdGhlIHVzZXIgaGFz
IGNvbnRyb2wgb3ZlciAnZGInLiBJIGJlbGlldmUgdGhlcmUncyBhIGZhaXJseSBjb21tb24NCj4g
dXNlLWNhc2Ugd2hlcmUgdGhpcyBpcyB0cnVlLg0KPiANCj4gVGhlIHVzZS1jYXNlOiB2aXJ0dWFs
aXplZCBhbmQgY2xvdWQgaW5mcmFzdHJ1Y3R1cmUgZ2VuZXJhbGx5IHByb3ZpZGUgYW4NCj4gYWJp
bGl0eSB0byBjdXN0b21pemUgU2VjdXJlQm9vdCB2YXJpYWJsZXMsIGluIHBhcnRpY3VsYXIsIGl0
IGlzIHBvc3NpYmxlDQo+IHRvIGJyaW5nIHlvdXIgb3duIFNlY3VyZUJvb3QgJ2RiJy4gVGhpcyBt
YXkgY29tZSBoYW5keSB3aGVuIGEgdXNlciB3YW50cyB0bw0KPiBsb2FkIGEgdGhpcmQgcGFydHkg
a2VybmVsIG1vZHVsZSAoc2VsZiBidWlsdCBvciBwcm92aWRlZCBieSBhIHRoaXJkIHBhcnR5DQo+
IHZlbmRvcikgd2hpbGUgc3RpbGwgdXNpbmcgYSBkaXN0cm8gcHJvdmlkZWQga2VybmVsLiBHZW5l
cmFsbHksIGRpc3Rybw0KPiBwcm92aWRlZCBrZXJuZWxzIHNpZ24gbW9kdWxlcyB3aXRoIGFuIGVw
aGVtZXJhbCBrZXkgYW5kIGRpc2NhcmQgdGhlIHByaXZhdGUNCj4gcGFydCBkdXJpbmcgdGhlIGJ1
aWxkLiBXaGlsZSBNT0sgY2FuIHNvbWV0aW1lcyBiZSB1c2VkIHRvIHNpZ24gc29tZXRoaW5nDQo+
IG91dC1vZi10cmVlLCBpdCBpcyBhIHRlZGlvdXMgcHJvY2VzcyByZXF1aXJpbmcgZWl0aGVyIGEg
bWFudWFsIGludGVydmVudGlvbg0KPiB3aXRoIHNoaW0gb3IgYSAnY2VydG11bGUnIA0KPiAoc2Vl
IGh0dHBzOi8vYmxvZ3Mub3JhY2xlLmNvbS9saW51eC9wb3N0L3RoZS1tYWNoaW5lLWtleXJpbmcp
LiBJbiBjb250cmFzdCwNCj4gdGhlIGJlYXV0eSBvZiB1c2luZyBTZWN1cmVCb290ICdkYicgaW4g
dGhpcyBzY2VuYXJpbyBpcyB0aGF0IGZvciBwdWJsaWMNCj4gY2xvdWRzIGFuZCB2aXJ0dWFsaXpl
ZCBpbmZyYXN0cnVjdHVyZSBpdCBpcyBub3JtYWxseSBhIHByb3BlcnR5IG9mIHRoZSBPUw0KPiBp
bWFnZSAob3IgdGhlIHdob2xlIGluZnJhc3RydWN0dXJlL2hvc3QpIGFuZCBub3QgYW4gaW5kaXZp
ZHVhbCBpbnN0YW5jZTsNCj4gdGhpcyBtZWFucyB0aGF0IGFsbCBpbnN0YW5jZXMgY3JlYXRlZCBm
cm9tIHRoZSBzYW1lIHRlbXBsYXRlIHdpbGwgaGF2ZSAnZGInDQo+IGtleXMgaW4gJy5wbGF0Zm9y
bScgYnkgZGVmYXVsdC4NCg0KSGFzbuKAmXQgdGhpcyBhcHByb2FjaCBiZWVuIHJlamVjdGVkIG11
bHRpcGxlIHRpbWVzIGluIHRoZSBwYXN0Pw0KDQpUaGUgYWRkaXRpb24gb2YgdGhlIGNlcnRtdWxl
IChub3cgY2FsbGVkIGNlcnR3cmFwcGVyKSB3YXMgcHJlY2lzZWx5IGFkZGVkIA0KZm9yIHRoZSB1
c2UgY2FzZSB5b3XigJl2ZSBkZXNjcmliZWQuIElmIHRoZXkgY29udHJvbCB0aGUg4oCYZGLigJks
IHRoZXkgY2FuIGNyZWF0ZSBhIA0KY2VydHdyYXBwZXIgY29udGFpbmluZyB0aGVpciBrZXkuDQoN
CldpdGggdGhlIG1hY2hpbmUga2V5cmluZywgdGhlIGVuZC11c2VyIGlzIGluIGNvbnRyb2wuIElm
IHRoZXkgZG9u4oCZdCB3YW50IHRvIA0KdHJ1c3QgTU9LIGtleXMgaW4gdGhlaXIga2VybmVsLCB0
aGV5IGhhdmUgdGhlIGFiaWxpdHkgdG8gZGlzYWJsZSBpdC4gVGhpcyB3aWxsIA0KcHJldmVudCBz
aGltIGZyb20gY3JlYXRpbmcgdGhlIE1va0xpc3RUcnVzdGVkUlQgdmFyIGFuZCBwcmV2ZW50IExp
bnV4IA0KZnJvbSB1c2luZyBNT0sga2V5cyB0byB2YWxpZGF0ZSBrZXJuZWwgbW9kdWxlcy4NCg0K

