Return-Path: <linux-integrity+bounces-5134-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 67B03A54D93
	for <lists+linux-integrity@lfdr.de>; Thu,  6 Mar 2025 15:22:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 91BBD16ADE2
	for <lists+linux-integrity@lfdr.de>; Thu,  6 Mar 2025 14:22:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 891391624DB;
	Thu,  6 Mar 2025 14:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=polito.it header.i=@polito.it header.b="dqCR0MjK"
X-Original-To: linux-integrity@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11021098.outbound.protection.outlook.com [52.101.65.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95F2414F9FF
	for <linux-integrity@vger.kernel.org>; Thu,  6 Mar 2025 14:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.98
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741270975; cv=fail; b=IEBXBXFGhxMj1lmndYkI3lYLMTq9KtLS9+xjleUpcyF0gjbHeJZApVuE8kiY0hCP55ktl/Bwlk9sBCkMrCcYZebl6mm2DhDonX96oKg5WqncgKkWpdVCXAmOneFiy87YN+jgkkGn4HfrTeFrKzPoY7j3rQhYeJffol0p8al6Fz8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741270975; c=relaxed/simple;
	bh=I0gxw7txlsoQFh43554P92p57i0yY8rPCEtuZmG7QWw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=W3ua+6aOSzL9Tqp00bGH3IFLCzppofOSpv0JAkLDHrsoA+8oX6seKWcS2gCVvfolvUlDwz9kus7agLkqObLmYbPN5lfCUEBVY2ZfIkFhWqoSnE3KAXKu4NoAoirrDNcgG3KriJgZkUBGmtyruxDAvmHWP6JRYdGpfut6YZaP0aU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=polito.it; spf=pass smtp.mailfrom=polito.it; dkim=pass (1024-bit key) header.d=polito.it header.i=@polito.it header.b=dqCR0MjK; arc=fail smtp.client-ip=52.101.65.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=polito.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=polito.it
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a4bRMV3bpCy2NB8ezYHiM0gdB84OE067NRFcp0LSiWqCT1FgkNRa6d3Rz9Nef49P7bZqT4uacaC7N+IWv04F4pnisO/8qHNuo3XIlyVYGTO9RT0phU4gZwjJbM4H2EM5hwE+6wDPmqvFVxEyAoDbQ7814g9PE51WXm/DrssRJLZgs+JSC/sxbmPJ3jWV9ERgwxctDvBumaqZP+SQxH/ra2EF4xcHKm6hGVJLIKfjt71oZFfWm//lXuKHXUtRDJwPLR9JnRdc0wyuqNt2gmlO7z5sImfos07X4L0pfH1JGo6mEhWw8Uaa6MdloAQHi3P1i5LVHTMDILZjskG4R+eMaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I0gxw7txlsoQFh43554P92p57i0yY8rPCEtuZmG7QWw=;
 b=cmHidxnC4P1dgJDs2M5ahlrhgRZn4VzASKaLi5FwFEpGHxwoVXWNW/yBpyaBY/8P/tRzW++zDRrEYROWVTvpd2DkwO9bM5msM0OXEB7SeM0T+8XOtKSA2XndcP7Cu0vcbPdNKBSInSALQm3yD95eNuGPcd80WAc05re4ezo2W8Bvk1P3W0sI/NP5s4FNC7lSpdhYsjQUc0o7BAbaI6XHYrHrXIkDhFy4l9FpBA0GjULUKGEWVy47942LPLIQ23VcxOmnR8WU/i/IVR+U4EQVmTWwmVu6FjorEkmnN5IOX/QBTsZI0sj0UPHMOMefXUak/nIfqrkmolObbZ58+n/o6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=polito.it; dmarc=pass action=none header.from=polito.it;
 dkim=pass header.d=polito.it; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=polito.it;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I0gxw7txlsoQFh43554P92p57i0yY8rPCEtuZmG7QWw=;
 b=dqCR0MjKwROO5hTdXKUAavLM22bd3bG+FdBw5S3omUfvQptdpufr2Gbbqit5u80cnUeFEfsZRLgLPcYlnKC8NXZzkChumimiiwrpSJrt/DTGAe48XG9ous99SU291g9ikNelkvyf9iw1RY9c9uldwMmjrj1KnhW5JDVym89Efus=
Received: from AS2PR05MB9840.eurprd05.prod.outlook.com (2603:10a6:20b:5f5::20)
 by DB9PR05MB8219.eurprd05.prod.outlook.com (2603:10a6:10:23f::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.17; Thu, 6 Mar
 2025 14:22:48 +0000
Received: from AS2PR05MB9840.eurprd05.prod.outlook.com
 ([fe80::237b:12ae:525c:3bbd]) by AS2PR05MB9840.eurprd05.prod.outlook.com
 ([fe80::237b:12ae:525c:3bbd%4]) with mapi id 15.20.8511.017; Thu, 6 Mar 2025
 14:22:48 +0000
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
 AQHbh4kqbfMU9EdEvEuw3vrfgofl17NY02GAgAFgF4CAAEZNAIAAjvoAgAA164CABf/RgIADDGSAgAGHRgCAAAeRgIAAXa+A
Date: Thu, 6 Mar 2025 14:22:48 +0000
Message-ID: <0dc6f8091c9d5261a54fe988e473f4333da615aa.camel@polito.it>
References: <20250225131255.154826-1-enrico.bravi@polito.it>
	 <ecc4630b5e3161736aa1e32f037facb9123025fc.camel@linux.ibm.com>
	 <013864bca0b53d65b9546125090c8d7776ee565a.camel@polito.it>
	 <9fb7a98bb88c05d953fd90c84c78af0bbd58df9b.camel@linux.ibm.com>
	 <484b1563482aca871a147daeff916fcb0730c6d6.camel@polito.it>
	 <2a6924b36ab41fd5d9666de726b9f4a0754b9cbb.camel@huaweicloud.com>
	 <091e810e9225014ab61fedd868f7fff70e864da4.camel@polito.it>
	 <4679907583cfe4d406d43f8e46bada6e9a23c096.camel@huaweicloud.com>
	 <f0eb80a5e6e436721e22448de625951d60010013.camel@polito.it>
	 <a4081237104bc5fdb7e8e316f8ea281b3ed1617d.camel@huaweicloud.com>
In-Reply-To: <a4081237104bc5fdb7e8e316f8ea281b3ed1617d.camel@huaweicloud.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=polito.it;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS2PR05MB9840:EE_|DB9PR05MB8219:EE_
x-ms-office365-filtering-correlation-id: 0929a042-0861-4ace-f360-08dd5cba5efc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?dk1wMExIbzJmUmk4OXorSWo0MHMxdmk4cE9CcU8zNDQyVDZlc3BMa1d1Ny8y?=
 =?utf-8?B?c2s0NTY4bDBWTnRJOWhBV0VBaS9EU1RwN0hCa3JKR2dsV0x4TUF2a0Rhd0p1?=
 =?utf-8?B?VjB4aGdWWG5pQjFRc0NWeXlFeGxXRG1JblRReGZHY2xOYnB0Tm1rWWd3bHQr?=
 =?utf-8?B?Tm10S2VrdkY2WVZhR2VuS1JrWTdlSmFVSVZhNlJ0TmxBY051MDdHaTlGamNE?=
 =?utf-8?B?Y2YwS29EZDBlTTRldlA0Zk5tSVVGeDc3b3B3bEVCaDZpOWpnT054WEY0c2dh?=
 =?utf-8?B?VHdQcVBXaVl2YlpUN0xJUFpWUHY4SHpMek1OSHlUTXg3RUhsVThGTUQ3UlN2?=
 =?utf-8?B?L3lSazlqMWRIR1l1TGlQaVRJYmdTRThLbEkvSUVZR0ZnbytaUXprTzVFSEM4?=
 =?utf-8?B?dUNoaFIwR2hGT1FDbVpjTnZySkEwUGhFSzFOVnVIUkFMZ2pZc0hEUGRnK3g2?=
 =?utf-8?B?ZzNkNjBudzRjVFN5MGNtWHJXR2JjUzN3R1UvbTlNYWRsUmtkZUZQUzBLMTFs?=
 =?utf-8?B?T2R1ZERzTXc3ZERwa3ppdG90czZWem1Wdk9ZRXZjRTZFS1kvdUV0ZmxPNXhy?=
 =?utf-8?B?c0Y0V0trQm5hT24zZDF4WXFqanVnUlZyaFNnVlBLQ2lYZDZjOWt5UkF5ZUhW?=
 =?utf-8?B?dkh3WmJSc0xPMW1zV2IwZGZCRURzRmttc0QrcVpjWU9EMnMweGVBY3ArWDN4?=
 =?utf-8?B?MHRUS3J1NGNkczRVUTVGc09pZktJNnFEbUVTTkM2RFJUVXZla0NWNW40WXZR?=
 =?utf-8?B?MjFzZkNObWFSRHBKems1WlZmd2h2a2tqMlVvbnVjdUNlQ3JRajNtVWhsdENJ?=
 =?utf-8?B?VndWTm1tc1ZlU3pMV3NETGZKZGUrclM4SERCQzFCUnVuSzNqTkZCTENJK3k5?=
 =?utf-8?B?VHlqd05XS0U1WDdRUHF3azMxczVpQktoaGRKUUVVRHp0emM0NTFBQnBwbFl1?=
 =?utf-8?B?K0JHNFlIeFN3K3RRZStTSm5xRTVnVWF6aXZadUxOOVhhRTE1c3JhUjVpOEZC?=
 =?utf-8?B?MGxpVXYvdDJYTkZuNGZibXFzRXFwYlM3U3BiV3JuOE9hdk9xWDJvVytBZGZE?=
 =?utf-8?B?TVdSRlRIUmhORW56dWlJeFh2ZzVuclZDR0MyRWpWVnYxZ0l0Z0RvTGtVY2ZP?=
 =?utf-8?B?REdvblAvVnQyekxqTXJXb2RQWjNpQ1piWWxOZkszaStCWVVGakhSSWQ4NmIr?=
 =?utf-8?B?a2xMMGs1QlVtK3k3enBTWHpERENTa1N1U1p4aTNmZC84UGpTMTlrNGtOd3Uz?=
 =?utf-8?B?WEIvVVZaU1Vzak1DTUpZZWJWSS95TVZDcmdUQTRudGg5QTR0RFoxdXBYSjkx?=
 =?utf-8?B?OWZ0Q01QTlNiY29iTlZuY0E2dWhoTnpVK1F1OTVOMVc5eWRwZy8xNXduSnFM?=
 =?utf-8?B?V3lVRlRDSURub2QxR3locWxLYmQzckhSUDJZZ05NYXA0cmVYa2Z0REpCajNh?=
 =?utf-8?B?TDhFNXE0aTV0V09Kblg4SHFUOFN6K2dvZFhTNk5IVXBtZytIZGprbHYzYWZz?=
 =?utf-8?B?bUdYeHdiMDR4aDJaS3RkNDlXTTByeDJ5dWlUZ05VZDhGbGFsRzhETjNCb0dL?=
 =?utf-8?B?Z0FnSm93TjVNcXgweHJJOVNvV055dThIYXFQREZBOGZYcG1sOGNMaitCWGZw?=
 =?utf-8?B?VUdURWNYdENCQXJ5ekttbnc0MFJ4V3QvQ1huU2EvUTkxMWJyUUhmMnpYUHFR?=
 =?utf-8?B?bE1nUnM3WGhPYUNtK3NOZG5LUlVlQngzaW1LOC82eW1ndU8wWDViYkpvMy9k?=
 =?utf-8?B?dW05WWcwUFZrdlBTUjFaTVdTMThXZS9RVmZTenhiNlhkRzBzT3pkdWNXWVZS?=
 =?utf-8?B?UGxsUjZ6aWdzSnFMOXIxb0J4dHB4MVdZU3B0WWQvZkJ0UzRDNG9JM1ViRXFm?=
 =?utf-8?B?NkMzMGkxTWpodmc2SElkY0NSa0ptUUQ2L3g2Z1BSWnpCZGhDbTczVFVvOW13?=
 =?utf-8?Q?oXug81QgrJoVcpPak/XM9VGhq+g6gVPw?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS2PR05MB9840.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?UzJVR21DQktXeHJoWTBxdTJSTm1URm5CRzBYOFBiVmY1VXBTczJ4SWhkVVUz?=
 =?utf-8?B?SmVHdGNweGFXN2IwTlk2NmJnWlFHUjFMbEdrUmhLRlIrY0s5SHNJRVpQNG04?=
 =?utf-8?B?VW0yelJYM0NRS0Q5WmcxZ2NNMTlUdDJUR1htbWVPVHZsNk5YQk5yUDlmajA0?=
 =?utf-8?B?aXRJK1RqMUIrb0wyc1FUV2tXZE1sY09KcVFxMk13S3Y4RGtKVVFSVUdoM3pz?=
 =?utf-8?B?SHUzd0xoK3FxdUx1dGt6SzQrQXVyRHNkb3dmVUtCR1UycXQvU3hIQUltQ3Nr?=
 =?utf-8?B?VmlsRHlrSUtiWWZkWjFQV0wvenlIQzhIajBCSXY2b0ZvYjFGdnY1S21GalZl?=
 =?utf-8?B?bkc0NXhsU1VqNGdtdHh4eCsxTVJFVmdPMlRPZTlpdURNZ3lTVzFMM1RWSWpR?=
 =?utf-8?B?Q1pkYkt0djRpWDExRm9QcS9KZ0h6NU5TQjcwNkQvb0NmUXFLb0ZCQkpWZTE3?=
 =?utf-8?B?bEpFVGZQcmVlUjduM3d4QkFGSjFuNFo2NWlBTWF4dC81MlI1eHFCd3pMcXow?=
 =?utf-8?B?QnpCclBTQXhiSHQwRW1URm9NMTFsajRldEhSdk5kZmkyMngrdTAvWnh6T2VX?=
 =?utf-8?B?MnZmaEJxZlhaMlNrTW54bWRRUWhic0Q2QVMzRDltc2pTWEVZem5ETTBqQVNK?=
 =?utf-8?B?SFZkYjlhMjhsT2dLclBnWENhRlltb2JjeHNHMW1zektOZjJVK0lqUmdZQkZM?=
 =?utf-8?B?V241N1hsMzBsaFZreG1ORUdtZ2RzVkVseGpGVGp1YUlDVE80YTFlbG8zUDc1?=
 =?utf-8?B?cGx5T0dQUVpEV2JzdGNBalhyWW0wTDMvTkllOHJsSkxuZDAxWGxKODcyRlpa?=
 =?utf-8?B?N05QZm9EQktMdUI4cVlHTnVyeVdRNFJ2V1ZoN29ZY0pBMzFhdWpiejJTMjRH?=
 =?utf-8?B?MUVhWjByMTdJVW1RR1UxVG8xZmlKNlhRaW11c0xrV21CQVo3dk1BbytLdFhu?=
 =?utf-8?B?VUJnUjJEd1lQUDZHczBvZ29Kak5FS2F2ZTZqQ0ZjK08rUXFhKzQwZE41cXlT?=
 =?utf-8?B?T1FoKzV3cVM3MUE1SmYwQnFVcHI0YUhSaHpiMFMrcnp1TVRrNGxuem1EYkNJ?=
 =?utf-8?B?UXNGODhBcDBLdWN5dzhRakMrWitTU1pXaTJXbFMwdE5WOVdMV1gwZWFCNm1T?=
 =?utf-8?B?eFI2ZGIrRmxBSEJrQzI5Wk45Y2N0Z2xBcHpTL1hLN3k3bytFS1JEaTBOSERk?=
 =?utf-8?B?SUhyOWZlOThIak84N1E4UHhhNlBhRm9LL25aTXFvY2ZmZWZmK1FTOTVJY3NY?=
 =?utf-8?B?K2xKL0VVQ3IwSDdSUnlqVEZoZzZxVjVqL2Q5VWoycXBqd0FUaFBaUnlERWYw?=
 =?utf-8?B?b3FMSEVhb0JPOW9YclpqK0tXa0dZMHZselF4N0lSYVcrQzVzWjgydFdTN0xP?=
 =?utf-8?B?UHJYelNpMjh5LzJaMVg4QzV3YVRlVndacUZDYTZyb3lzVWhBQ29qQlBORzR2?=
 =?utf-8?B?cExTQTJVTW1tTjZrbVB1THp2UDltT1Z5bnk3UDV1UkZ5NXNMVGUyNnBKY0Iv?=
 =?utf-8?B?ZktJaldMT0NlWjExWlJjbUQ4RW5Ydlk5dEIvVEFlWGw2ZmIxSnpXWG1ZRFNZ?=
 =?utf-8?B?bDI2NkhJcVJaeGk1Z2x3WEZhcWFGclF6WDlZeHNZdFJONEFvY2pBVkQwL0VM?=
 =?utf-8?B?M1dUK2ZkMm1qVlFBU1NmUzhlRUFoRmVNb2pQVDloNzUzRi9XSjB1cFBmYXJn?=
 =?utf-8?B?dFRhc1N6ZzY4U2NJTFV5TERBVUR2cTdsalN2S3J6UHNWUnNzVlN1T3g2UnR1?=
 =?utf-8?B?L2ZINGQ5bHpSNUhoVi9vbE9kV0F2NUUwSGp6emxWM0JVTEF6S0ZxMDR1dWdT?=
 =?utf-8?B?eThiUVgxeUNrNnoxa3RsYXdBenJvTUZOaUxyTS9OY1Z2ZkVUN1hjclJzTytB?=
 =?utf-8?B?WnQ1dXJlYnBaNHRxQ24yN3pNMlFiZnExSE9NMmFpYTVVNUIwWm9MTmRZcXRh?=
 =?utf-8?B?OHZ3dnJQY0Jzam84RHB3aTRjTFEzRFdMUy9TQkQyb0RvTGorT1NUOFdMbnJ3?=
 =?utf-8?B?K0h5ZWdmNVQrbE9aM2RQWHdmVkNrdVZiKzVkNUxJN0grbmdlck9RZmtqV1Z6?=
 =?utf-8?B?S1JTNk5nNVpYZmIxU0RKdW5VYmFiNUVMWC8zTGcvelFkSG5ZY25ra1ducTA5?=
 =?utf-8?B?eWx2NmlCLzFtK1FBblNuaDJ6UnJ2aS9zcmU3RldDaHJEVFZpd3BSTkc5TGYz?=
 =?utf-8?B?SXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0CFB4443787CB84D899A4CA8AE2AB889@eurprd05.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 0929a042-0861-4ace-f360-08dd5cba5efc
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Mar 2025 14:22:48.3694
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 2a05ac92-2049-4a26-9b34-897763efc8e2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ckvMECnRAmV9yClXHUzEAVQUBXOBHb7Gqp41/9MhYn8E0n9a1qQWBMU2cYT3kwT2dFHkPdmdMTnw0b2tZYlIng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR05MB8219

T24gVGh1LCAyMDI1LTAzLTA2IGF0IDA5OjQ3ICswMTAwLCBSb2JlcnRvIFNhc3N1IHdyb3RlOg0K
PiBPbiBUaHUsIDIwMjUtMDMtMDYgYXQgMDg6MjAgKzAwMDAsIEVucmljb8KgIEJyYXZpIHdyb3Rl
Og0KPiA+IE9uIFdlZCwgMjAyNS0wMy0wNSBhdCAwOTo1OSArMDEwMCwgUm9iZXJ0byBTYXNzdSB3
cm90ZToNCj4gPiA+IE9uIE1vbiwgMjAyNS0wMy0wMyBhdCAxMDoyNiArMDAwMCwgRW5yaWNvwqAg
QnJhdmkgd3JvdGU6DQo+ID4gPiA+IE9uIFRodSwgMjAyNS0wMi0yNyBhdCAxNTo0OSArMDEwMCwg
Um9iZXJ0byBTYXNzdSB3cm90ZToNCj4gPiA+ID4gPiBPbiBUaHUsIDIwMjUtMDItMjcgYXQgMTE6
MzYgKzAwMDAsIEVucmljb8KgIEJyYXZpIHdyb3RlOg0KPiA+ID4gPiA+ID4gT24gV2VkLCAyMDI1
LTAyLTI2IGF0IDIyOjA1IC0wNTAwLCBNaW1pIFpvaGFyIHdyb3RlOg0KPiA+ID4gPiA+ID4gPiBP
biBXZWQsIDIwMjUtMDItMjYgYXQgMjI6NTMgKzAwMDAsIEVucmljb8KgIEJyYXZpIHdyb3RlOg0K
PiA+ID4gPiA+ID4gPiA+IE9uIFR1ZSwgMjAyNS0wMi0yNSBhdCAyMDo1MyAtMDUwMCwgTWltaSBa
b2hhciB3cm90ZToNCj4gPiA+ID4gPiA+ID4gPiA+IE9uIFR1ZSwgMjAyNS0wMi0yNSBhdCAxNDox
MiArMDEwMCwgRW5yaWNvIEJyYXZpIHdyb3RlOg0KPiA+ID4gPiA+ID4gPiA+ID4gPiBUaGUgZmly
c3Qgd3JpdGUgb24gdGhlIGltYSBwb2xpY3kgZmlsZSBwZXJtaXRzIHRvIG92ZXJyaWRlDQo+ID4g
PiA+ID4gPiA+ID4gPiA+IHRoZQ0KPiA+ID4gPiA+ID4gPiA+ID4gPiBkZWZhdWx0DQo+ID4gPiA+
ID4gPiA+ID4gPiA+IHBvbGljeSBkZWZpbmVkIHdpdGggdGhlIGltYV9wb2xpY3k9IGJvb3QgcGFy
YW1ldGVyLiBUaGlzIGNhbg0KPiA+ID4gPiA+ID4gPiA+ID4gPiBiZQ0KPiA+ID4gPiA+ID4gPiA+
ID4gPiBkb25lDQo+ID4gPiA+ID4gPiA+ID4gPiA+IGJ5IGFkZGluZyB0aGUgL2V0Yy9pbWEvaW1h
LXBvbGljeSB3aGljaCBhbGxvd3MgbG9hZGluZyB0aGUNCj4gPiA+ID4gPiA+ID4gPiA+ID4gY3Vz
dG9tDQo+ID4gPiA+ID4gPiA+ID4gPiA+IHBvbGljeQ0KPiA+ID4gPiA+ID4gPiA+ID4gPiBkdXJp
bmcgYm9vdC4gSXQgaXMgYWxzbyBwb3NzaWJsZSB0byBsb2FkIGN1c3RvbSBwb2xpY3kgYXQNCj4g
PiA+ID4gPiA+ID4gPiA+ID4gcnVudGltZQ0KPiA+ID4gPiA+ID4gPiA+ID4gPiB0aHJvdWdoDQo+
ID4gPiA+ID4gPiA+ID4gPiA+IGZpbGUgb3BlcmF0aW9uczoNCj4gPiA+ID4gPiA+ID4gPiA+ID4g
DQo+ID4gPiA+ID4gPiA+ID4gPiA+IGNwIGN1c3RvbV9pbWFfcG9saWN5IC9zeXMva2VybmVsL3Nl
Y3VyaXR5L2ltYS9wb2xpY3kNCj4gPiA+ID4gPiA+ID4gPiA+ID4gY2F0IGN1c3RvbV9pbWFfcG9s
aWN5ID4gL3N5cy9rZXJuZWwvc2VjdXJpdHkvaW1hL3BvbGljeQ0KPiA+ID4gPiA+ID4gPiA+ID4g
PiANCj4gPiA+ID4gPiA+ID4gPiA+ID4gb3IgYnkgd3JpdGluZyB0aGUgYWJzb2x1dGUgcGF0aCBv
ZiB0aGUgZmlsZSBjb250YWluaW5nIHRoZQ0KPiA+ID4gPiA+ID4gPiA+ID4gPiBjdXN0b20NCj4g
PiA+ID4gPiA+ID4gPiA+ID4gcG9saWN5Og0KPiA+ID4gPiA+ID4gPiA+ID4gPiANCj4gPiA+ID4g
PiA+ID4gPiA+ID4gZWNobyAvcGF0aC9vZi9jdXN0b21faW1hX3BvbGljeSA+DQo+ID4gPiA+ID4g
PiA+ID4gPiA+IC9zeXMva2VybmVsL3NlY3VyaXR5L2ltYS9wb2xpY3kNCj4gPiA+ID4gPiA+ID4g
PiA+ID4gDQo+ID4gPiA+ID4gPiA+ID4gPiA+IEluIHRoZXNlIGNhc2VzLCBmaWxlIHNpZ25hdHVy
ZSBjYW4gYmUgbmVjZXNzYXJ5IHRvIGxvYWQgdGhlDQo+ID4gPiA+ID4gPiA+ID4gPiA+IHBvbGlj
eQ0KPiA+ID4gPiA+ID4gPiA+ID4gPiAoZnVuYz1QT0xJQ1lfQ0hFQ0spLiBDdXN0b20gcG9saWN5
IGNhbiBhbHNvIGJlIHNldCBhdA0KPiA+ID4gPiA+ID4gPiA+ID4gPiBydW50aW1lIGJ5DQo+ID4g
PiA+ID4gPiA+ID4gPiA+IGRpcmVjdGx5DQo+ID4gPiA+ID4gPiA+ID4gPiA+IHdyaXRpbmcgdGhl
IHBvbGljeSBzdHJlYW0gb24gdGhlIGltYSBwb2xpY3kgZmlsZToNCj4gPiA+ID4gPiA+ID4gPiA+
ID4gDQo+ID4gPiA+ID4gPiA+ID4gPiA+IGVjaG8gLWUgIm1lYXN1cmUgZnVuYz1CUFJNX0NIRUNL
IG1hc2s9TUFZX0VYRUNcbiIgXA0KPiA+ID4gPiA+ID4gPiA+ID4gPiDCoMKgwqDCoMKgwqDCoMKg
ImF1ZGl0IGZ1bmM9QlBSTV9DSEVDSyBtYXNrPU1BWV9FWEVDXG4iIFwNCj4gPiA+ID4gPiA+ID4g
PiA+ID4gwqDCoMKgwqAgPiAvc3lzL2tlcm5lbC9zZWN1cml0eS9pbWEvcG9saWN5DQo+ID4gPiA+
ID4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+ID4gPiA+ID4gPiBJbiB0aGlzIGNhc2UsIHRoZXJlIGlz
IG5vIG1lY2hhbmlzbSB0byB2ZXJpZnkgdGhlIGludGVncml0eQ0KPiA+ID4gPiA+ID4gPiA+ID4g
PiBvZg0KPiA+ID4gPiA+ID4gPiA+ID4gPiB0aGUNCj4gPiA+ID4gPiA+ID4gPiA+ID4gbmV3DQo+
ID4gPiA+ID4gPiA+ID4gPiA+IHBvbGljeS4NCj4gPiA+ID4gPiA+ID4gPiA+ID4gDQo+ID4gPiA+
ID4gPiA+ID4gPiA+IEFkZCBhIG5ldyBlbnRyeSBpbiB0aGUgaW1hIG1lYXN1cmVtZW50cyBsaXN0
IGNvbnRhaW5pbmcgdGhlDQo+ID4gPiA+ID4gPiA+ID4gPiA+IGFzY2lpDQo+ID4gPiA+ID4gPiA+
ID4gPiA+IGN1c3RvbQ0KPiA+ID4gPiA+ID4gPiA+ID4gPiBpbWEgcG9saWN5IGJ1ZmZlciB3aGVu
IG5vdCB2ZXJpZmllZCBhdCBsb2FkIHRpbWUuDQo+ID4gPiA+ID4gPiA+ID4gPiA+IA0KPiA+ID4g
PiA+ID4gPiA+ID4gPiBTaWduZWQtb2ZmLWJ5OiBFbnJpY28gQnJhdmkgPGVucmljby5icmF2aUBw
b2xpdG8uaXQ+DQo+ID4gPiA+ID4gPiA+ID4gPiANCj4gPiA+ID4gPiA+ID4gPiA+IEhpIEVucmlj
bywNCj4gPiA+ID4gPiA+ID4gPiANCj4gPiA+ID4gPiA+ID4gPiBIaSBNaW1pLA0KPiA+ID4gPiA+
ID4gPiA+IA0KPiA+ID4gPiA+ID4gPiA+IHRoYW5rIHlvdSBmb3IgdGhlIHF1aWNrIHJlc3BvbnNl
Lg0KPiA+ID4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+ID4gPiA+ID4gVGhpcyBwYXRjaCBzZXQgaGFy
ZCBjb2RlcyBtZWFzdXJpbmcgdGhlIGluaXRpYWwgY3VzdG9tIElNQQ0KPiA+ID4gPiA+ID4gPiA+
ID4gcG9saWN5DQo+ID4gPiA+ID4gPiA+ID4gPiBydWxlcw0KPiA+ID4gPiA+ID4gPiA+ID4gdGhh
dA0KPiA+ID4gPiA+ID4gPiA+ID4gcmVwbGFjZSB0aGUgYnVpbHRpbiBwb2xpY2llcyBzcGVjaWZp
ZWQgb24gdGhlIGJvb3QgY29tbWFuZA0KPiA+ID4gPiA+ID4gPiA+ID4gbGluZS7CoA0KPiA+ID4g
PiA+ID4gPiA+ID4gSU1BDQo+ID4gPiA+ID4gPiA+ID4gPiBzaG91bGRuJ3QgaGFyZCBjb2RlIHBv
bGljeS4NCj4gPiA+ID4gPiA+ID4gPiANCj4gPiA+ID4gPiA+ID4gPiBNeSBmaXJzdCBhcHByb2Fj
aCB3YXMgdG8gZGVmaW5lIGEgbmV3IGNyaXRpY2FsLWRhdGEgcmVjb3JkLMKgDQo+ID4gPiA+ID4g
PiANCj4gPiA+ID4gPiA+IEhpIE1pbWksDQo+ID4gPiA+ID4gPiANCj4gPiA+ID4gPiA+ID4gSG9w
ZWZ1bGx5IHRoZSBuZXcgY3JpdGljYWwtZGF0YSB3aWxsIGJlIG9mIHRoZSBlbnRpcmUgSU1BIHBv
bGljeS4NCj4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+ID4geWVzLCBhYnNvbHV0ZWx5Lg0KPiA+ID4g
PiA+ID4gDQo+ID4gPiA+ID4gPiA+ID4gYnV0IHBlcmZvcm1pbmcgdGhlDQo+ID4gPiA+ID4gPiA+
ID4gbWVhc3VyZW1lbnQgYWZ0ZXIgdGhlIGN1c3RvbSBwb2xpY3kgYmVjb21lcyBlZmZlY3RpdmUs
IHRoZQ0KPiA+ID4gPiA+ID4gPiA+IG1lYXN1cmVtZW50DQo+ID4gPiA+ID4gPiA+ID4gY291bGQN
Cj4gPiA+ID4gPiA+ID4gPiBiZQ0KPiA+ID4gPiA+ID4gPiA+IGJ5cGFzc2VkIG9taXR0aW5nIGZ1
bmM9Q1JJVElDQUxfREFUQSBpbiB0aGUgY3VzdG9tIHBvbGljeS4NCj4gPiA+ID4gPiA+ID4gPiAN
Cj4gPiA+ID4gPiA+ID4gPiA+IEknbSBub3QgcXVpdGUgc3VyZSB3aHkgeW91J3JlIGRpZmZlcmVu
dGlhdGluZyBiZXR3ZWVuDQo+ID4gPiA+ID4gPiA+ID4gPiBtZWFzdXJpbmcgdGhlIGluaXRpYWwg
YW5kIHN1YnNlcXVlbnQgY3VzdG9tIElNQSBwb2xpY3kNCj4gPiA+ID4gPiA+ID4gPiA+IHJ1bGVz
LsKgwqANCj4gPiA+ID4gPiA+ID4gPiANCj4gPiA+ID4gPiA+ID4gPiBNeSBpbnRlbnRpb24gaXMg
dG8gbWVhc3VyZSB0aGUgZmlyc3QgZGlyZWN0IHdyaXRlIChsaW5lIGJ5IGxpbmUpDQo+ID4gPiA+
ID4gPiA+ID4gb24NCj4gPiA+ID4gPiA+ID4gPiB0aGUNCj4gPiA+ID4gPiA+ID4gPiBwb2xpY3kN
Cj4gPiA+ID4gPiA+ID4gPiBmaWxlLCB3aXRob3V0IGxvYWRpbmcgdGhlIGluaXRpYWwgY3VzdG9t
IHBvbGljeSBmcm9tIGEgZmlsZS4NCj4gPiA+ID4gPiA+ID4gPiBUaGlzDQo+ID4gPiA+ID4gPiA+
ID4gY2FzZSwNCj4gPiA+ID4gPiA+ID4gPiBpZg0KPiA+ID4gPiA+ID4gPiA+IEknbQ0KPiA+ID4g
PiA+ID4gPiA+IG5vdCB3cm9uZywgaXMgbm90IGNvdmVyZWQgYnkgZnVuYz1QT0xJQ1lfQ0hFQ0su
DQo+ID4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+ID4gPiBXaGVuIHNlY3VyZSBib290IGlzIGVuYWJs
ZWQsIHRoZSBhcmNoIHNwZWNpZmljIHBvbGljeSBydWxlcw0KPiA+ID4gPiA+ID4gPiByZXF1aXJl
DQo+ID4gPiA+ID4gPiA+IHRoZQ0KPiA+ID4gPiA+ID4gPiBJTUENCj4gPiA+ID4gPiA+ID4gcG9s
aWN5IHRvIGJlIHNpZ25lZC7CoCBXaXRob3V0IHNlY3VyZSBib290IGVuYWJsZWQsIHlvdSdyZSBj
b3JyZWN0Lg0KPiA+ID4gPiA+ID4gPiBUaGUNCj4gPiA+ID4gPiA+ID4gY3VzdG9tDQo+ID4gPiA+
ID4gPiA+IHBvbGljeSBydWxlcyBtYXkgZGlyZWN0bHkgYmUgbG9hZGVkIHdpdGhvdXQgYmVpbmcg
bWVhc3VyZWQuDQo+ID4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+ID4gPiBXaHkgb25seSBtZWFzdXJl
ICJ0aGUgZmlyc3QgZGlyZWN0IHdyaXRlIj/CoCBBZGRpdGlvbmFsIGN1c3RvbQ0KPiA+ID4gPiA+
ID4gPiBwb2xpY3kNCj4gPiA+ID4gPiA+ID4gcnVsZXMNCj4gPiA+ID4gPiA+ID4gbWF5DQo+ID4g
PiA+ID4gPiA+IGJlIGRpcmVjdGx5IGFwcGVuZGVkIHdpdGhvdXQgYmVpbmcgbWVhc3VyZWQuDQo+
ID4gPiA+ID4gPiANCj4gPiA+ID4gPiA+IFllcywgeW91IHJpZ2h0LiBUaGUgYWltIHdhcyB0byBt
ZWFzdXJlIChhdCBsZWFzdCkgdGhlIGZpcnN0IG9uZSwNCj4gPiA+ID4gPiA+IGJlY2F1c2UNCj4g
PiA+ID4gPiA+IGl0DQo+ID4gPiA+ID4gPiBzdWJzdGl0dXRlcyB0aGUgYm9vdCBwb2xpY3ksIGJ1
dCBpZiB5b3UgYXJlIG9rIHdpdGggYWRkaW5nIGENCj4gPiA+ID4gPiA+IGNyaXRpY2FsLQ0KPiA+
ID4gPiA+ID4gZGF0YQ0KPiA+ID4gPiA+ID4gcmVjb3JkLCBpdCB3b3VsZCBiZSBkZWZpbml0ZWx5
IGJldHRlci4NCj4gPiA+ID4gPiANCj4gPiA+ID4gPiBIaSBFbnJpY28NCj4gPiA+ID4gPiANCj4g
PiA+ID4gPiBpbiBhZGRpdGlvbiB0byB3aGF0IE1pbWkgc3VnZ2VzdGVkLCBJIGFsc28gbGlrZSB0
byBpZGVhIHRoYXQgdGhlDQo+ID4gPiA+ID4gUE9MSUNZX0NIRUNLIGhvb2sgY2F0Y2hlcyB0aGUg
ZGlyZWN0IHBvbGljeSBsb2FkaW5nLiBUaGF0IHdvdWxkIG1lYW4NCj4gPiA+ID4gPiB0aGF0IHRo
b3NlIHVwZGF0ZXMgd291bGQgYmUgc2VlbiBpZiB0aGUgJ3RjYicgSU1BIHBvbGljeSBpcyBzZWxl
Y3RlZC4NCj4gPiA+ID4gDQo+ID4gPiA+IEhpIFJvYmVydG8sDQo+ID4gPiA+IA0KPiA+ID4gPiBp
biB0aGlzIGNhc2UsIHdvdWxkbid0IGJlIHVzZWQgdGhlIGN1cnJlbnQgdGVtcGxhdGU/IFdvdWxk
bid0IGJlIGJldHRlcg0KPiA+ID4gPiB0bw0KPiA+ID4gPiB1c2UNCj4gPiA+ID4gdGhlIGltYS1i
dWYgaW4gb3JkZXIgdG8gaW5jbHVkZSB0aGUgdGV4dHVhbCBwb2xpY3kgcmVwcmVzZW50YXRpb24/
DQo+ID4gPiANCj4gPiA+IEhpIEVucmljbw0KPiA+ID4gDQo+ID4gPiBJIHdvdWxkIHVzZSB0aGUg
Y3VycmVudCB0ZW1wbGF0ZSwgSSBkb24ndCBmaW5kIGFueSBwYXJ0aWN1bGFyIGlzc3Vlcw0KPiA+
ID4gZm9yIGl0LiBTdXJlLCB3ZSBkb24ndCBoYXZlIGEgZmlsZSB0byBtZWFzdXJlIGJ1dCB0aGVy
ZSBhcmUgb3RoZXIgY2FzZXMNCj4gPiA+IHdoZXJlIGluIHByb2Nlc3NfbWVhc3VyZW1lbnQoKSB3
ZSBtZWFzdXJlIGEgYnVmZmVyIGluc3RlYWQgb2YgYSBmaWxlDQo+ID4gPiAod2hlbiBpdCBpcyBj
YWxsZWQgYnkgaW1hX3Bvc3RfcmVhZF9maWxlKCkpLg0KPiA+ID4gDQo+ID4gPiBXZSBjYW4gaGF2
ZSBib3RoIGNyaXRpY2FsIGRhdGEgYW5kIFBPTElDWV9DSEVDSyBtZWFzdXJlbWVudC4NCj4gDQo+
IENSSVRJQ0FMX0RBVEEgYW5kIFBPTElDWV9DSEVDSyBhcmUgc2VwYXJhdGUgaG9va3MuDQo+IA0K
PiBUaGV5IGNhbiBkbyBtZWFzdXJlbWVudCBkaWZmZXJlbnRseSwgQ1JJVElDQUxfREFUQSBjYW4g
YmUgZm9yIG1lYXN1cmluZw0KPiB0aGUgY3VycmVudCBzdGF0ZSBvZiB0aGUgZnVsbCBwb2xpY3ks
IHdoaWxlIFBPTElDWV9DSEVDSyBjb3VsZCBiZSBmb3INCj4gcG9saWNpZXMgc2VudCB0byB0aGUg
a2VybmVsLg0KDQpIaSBSb2JlcnRvLA0KDQpvaywgZ290IGl0ISBUaGFua3MgZm9yIHRoZSBjbGFy
aWZpY2F0aW9uLg0KDQpFbnJpY28NCg0KPiA+IEhpIFJvYmVydG8sDQo+ID4gDQo+ID4gc29ycnks
IEkgZGlkbid0IGdldCB0aGlzIHBvaW50LiBXaGF0IGRvIHlvdSBtZWFuPw0KPiA+IA0KPiA+ID4g
PiBJbiBhZGRpdGlvbiwgdGhlcmUgd291bGQgYmUgYSBuZXcgcmVjb3JkIGZvciBlYWNoIGxpbmUg
b2YgdGhlIGlucHV0DQo+ID4gPiA+IGJ1ZmZlciwNCj4gPiA+ID4gYW5kDQo+ID4gPiA+IG1lYXN1
cmluZyB0aGUgaW5wdXQgYnVmZmVyIHdvdWxkIHByb2R1Y2UgZGlmZmVyZW50IG1lYXN1cmVtZW50
cyBmb3IgdGhlDQo+ID4gPiA+IHNhbWUNCj4gPiA+ID4gcmVzdWx0aW5nIHBvbGljeSBlbnRyeSwg
YmVjYXVzZSBkaWZmZXJlbnQgb3IgbXVsdGlwbGUgc2VwYXJhdG9ycyBjYW4gYmUNCj4gPiA+ID4g
dXNlZC4NCj4gPiA+ID4gDQo+ID4gPiA+IEkgb3B0ZWQgdG8gcGVyZm9ybSB0aGUgbWVhc3VyZW1l
bnQgaW4gaW1hX3JlbGVhc2VfcG9saWN5KCkgYmVjYXVzZSBpcw0KPiA+ID4gPiB3aGVyZQ0KPiA+
ID4gPiB0aGUNCj4gPiA+ID4gbmV3IHBvbGljeSBiZWNvbWVzIGVmZmVjdGl2ZSBhZnRlciBpbWFf
dXBkYXRlX3BvbGljeSgpIGFuZCBjYW4gYmUgZG9uZSBhDQo+ID4gPiA+IHNpbmdsZQ0KPiA+ID4g
PiBtZWFzdXJlbWVudCBvZiB0aGUgbmV3IHJ1bm5pbmcgcG9saWN5Lg0KPiA+ID4gDQo+ID4gPiBJ
IHdvdWxkIHNpbXBseSBtZWFzdXJlIHdoYXQgaXMgcGFzc2VkIHRvIGltYV93cml0ZV9wb2xpY3ko
KSByZWdhcmRsZXNzDQo+ID4gPiBvZiB3aGV0aGVyIHRoZSBwb2xpY3kgd2lsbCBiZSBhY2NlcHRl
ZCBvciBub3QuIFRoaXMgaXMgbW9yZSBpbiBsaW5lDQo+ID4gPiB3aXRoIHRoZSB0cnVzdGVkIGNv
bXB1dGluZyBwYXJhZGlnbSBvZiBtZWFzdXJlICYgbG9hZC4gSWYgcG90ZW50aWFsbHkNCj4gPiA+
IHRoZXJlIGlzIGEgYnVnIGluIHRoZSBwb2xpY3kgY29kZSwgbWVhc3VyaW5nIHRoZSBwb2xpY3kg
YmVmb3JlIHdpdGggYQ0KPiA+ID4gdnVsbmVyYWJsZSBrZXJuZWwgd291bGQgYWxsb3cgeW91IHRv
IHNlZSB0aGUgbWVhc3VyZW1lbnQuIEFmdGVyLCBpdA0KPiA+ID4gZGVwZW5kcyBvbiB0aGUgc2Vy
aW91c25lc3Mgb2YgdGhlIHZ1bG5lcmFiaWxpdHkuDQo+ID4gDQo+ID4gT2sgcGVyZmVjdCwgSSBn
ZXQgeW91ciBwb2ludC4gVGhhbmsgeW91IGZvciB0aGUgZXhwbGFuYXRpb24uDQo+IA0KPiBXZWxj
b21lLg0KPiANCj4gUm9iZXJ0bw0KPiANCj4gPiBFbnJpY28NCj4gPiANCj4gPiA+IFJvYmVydG8N
Cj4gPiA+IA0KPiA+ID4gPiBUaGUgbWVhc3VyZW1lbnQgY291bGQgYmUgZG9uZSBhIGJpdCBlYXJs
aWVyLCB3b3JraW5nIG9uIGltYV9wb2xpY3lfcnVsZXMNCj4gPiA+ID4gYW5kDQo+ID4gPiA+IGlt
YV90ZW1wX3J1bGVzICh3aGljaCBiYXNpY2FsbHkgY29udGFpbnMgdGhlIGlucHV0IGJ1ZmZlcikg
YmVmb3JlIHRoZQ0KPiA+ID4gPiBzcGxpY2luZywNCj4gPiA+ID4gc28gaXQgd291bGQgYmUgY29u
c2lkZXJlZCB0aGUgY3VycmVudCBwb2xpY3kgYW5kIG5vdCB0aGUgbmV3IG9uZS4gSW4NCj4gPiA+
ID4gdGhpcw0KPiA+ID4gPiBjYXNlLA0KPiA+ID4gPiBpdCB3b3VsZCB3b3JrIGFsc28gd2hlbiBp
bWFfcG9saWN5PXRjYiBpcyBzZXQsIGFuZCBpdCBjb3VsZCBiZSBjYWxsZWQNCj4gPiA+ID4gcHJv
Y2Vzc19idWZmZXJfbWVhc3VyZW1lbnQoKSB3aXRoIFBPTElDWV9DSEVDSywgdG8gZ2V0IGEgcmVj
b3JkIHdpdGggdGhlDQo+ID4gPiA+IGVudGlyZQ0KPiA+ID4gPiBJTUEgcG9saWN5Lg0KPiA+ID4g
PiBXaGF0IGRvIHlvdSB0aGluayBhYm91dCBpdD8NCj4gPiA+ID4gDQo+ID4gPiA+IEJSLA0KPiA+
ID4gPiANCj4gPiA+ID4gRW5yaWNvDQo+ID4gPiA+IA0KPiA+ID4gPiA+IEkgd291bGQgaGF2ZSBy
ZWNvbW1lbmRlZCB0byB0cnkgdG8gYWRkIGEgcHJvY2Vzc19tZWFzdXJlbWVudCgpIGNhbGwgaW4N
Cj4gPiA+ID4gPiBpbWFfd3JpdGVfcG9saWN5KCksIHdoZXJlIHRoZSBidWZmZXIgdG8gYmUgcHJv
Y2Vzc2VkIGlzLg0KPiA+ID4gPiA+IA0KPiA+ID4gPiA+IEhvd2V2ZXIsIEkgZ3Vlc3MgeW91IG5l
ZWQgdG8gaGF2ZSBhIHZhbGlkIGZpbGUgZGVzY3JpcHRvciBpbiBvcmRlciB0bw0KPiA+ID4gPiA+
IHVzZSB0aGF0IGZ1bmN0aW9uIChtYXliZSBhbiBhbm9ueW1vdXMgaW5vZGU/KS4NCj4gPiA+ID4g
PiBpbWFfY29sbGVjdF9tZWFzdXJlbWVudCgpIHNob3VsZCBiZSBhbHJlYWR5IGFibGUgdG8gaGFu
ZGxlIGJ1ZmZlcnMsDQo+ID4gPiA+ID4gcGFzc2VkIGJ5IGltYV9wb3N0X3JlYWRfZmlsZSgpLg0K
PiA+ID4gPiA+IA0KPiA+ID4gPiA+IFRoYW5rcw0KPiA+ID4gPiA+IA0KPiA+ID4gPiA+IFJvYmVy
dG8NCj4gPiA+ID4gPiANCj4gPiA+ID4gPiA+IFRoYW5rIHlvdSwNCj4gPiA+ID4gPiA+IA0KPiA+
ID4gPiA+ID4gRW5yaWNvDQo+ID4gPiA+ID4gPiANCj4gPiA+ID4gPiA+ID4gPiANCj4gPiA+ID4g
PiA+ID4gPiA+IENvbnNpZGVyIGRlZmluaW5nIGEgbmV3IGNyaXRpY2FsLWRhdGEgcmVjb3JkIHRv
IG1lYXN1cmUgdGhlDQo+ID4gPiA+ID4gPiA+ID4gPiBjdXJyZW50DQo+ID4gPiA+ID4gPiA+ID4g
PiBJTUENCj4gPiA+ID4gPiA+ID4gPiA+IHBvbGljeQ0KPiA+ID4gPiA+ID4gPiA+ID4gcnVsZXMu
wqAgQWxzbyBjb25zaWRlciBpbmNsdWRpbmcgdGhlIG5ldyBjcml0aWNhbC1kYXRhIHJ1bGUgaW4N
Cj4gPiA+ID4gPiA+ID4gPiA+IHRoZQ0KPiA+ID4gPiA+ID4gPiA+ID4gYXJjaA0KPiA+ID4gPiA+
ID4gPiA+ID4gc3BlY2lmaWMgcG9saWN5IHJ1bGVzLg0KPiA+ID4gPiA+ID4gPiA+IA0KPiA+ID4g
PiA+ID4gPiA+IEkgdGhpbmsgdGhhdCB5b3VyIHN1Z2dlc3Rpb24sIHRvIGFkZCB0aGUgY3JpdGlj
YWwtZGF0YSBydWxlIGluDQo+ID4gPiA+ID4gPiA+ID4gdGhlDQo+ID4gPiA+ID4gPiA+ID4gYXJj
aA0KPiA+ID4gPiA+ID4gPiA+IHBvbGljeQ0KPiA+ID4gPiA+ID4gPiA+IHJ1bGVzLCBzb2x2ZXMg
dGhlIHByb2JsZW1zIG9mIGJ5cGFzc2luZyB0aGUgbWVhc3VyZW1lbnQgYW5kIGhhcmQNCj4gPiA+
ID4gPiA+ID4gPiBjb2RpbmcNCj4gPiA+ID4gPiA+ID4gPiBwb2xpY3kuDQo+ID4gPiA+ID4gPiA+
ID4gDQo+ID4gPiA+ID4gPiA+ID4gVGhhbmsgeW91IHZlcnkgbXVjaCBmb3IgeW91ciBmZWVkYmFj
ay4NCj4gPiA+ID4gPiA+ID4gDQo+ID4gPiA+ID4gPiA+IFlvdSdyZSB3ZWxjb21lLg0KPiA+ID4g
PiA+ID4gPiANCj4gPiA+ID4gPiA+ID4gTWltaQ0KPiA+ID4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+
ID4gDQo+ID4gPiA+ID4gDQo+ID4gPiA+IA0KPiA+ID4gDQo+ID4gDQo+IA0KDQo=

