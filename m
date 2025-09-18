Return-Path: <linux-integrity+bounces-7150-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 11692B83BB5
	for <lists+linux-integrity@lfdr.de>; Thu, 18 Sep 2025 11:16:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D9EFB540605
	for <lists+linux-integrity@lfdr.de>; Thu, 18 Sep 2025 09:16:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA9BF2FF651;
	Thu, 18 Sep 2025 09:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sealsq.com header.i=@sealsq.com header.b="hx8L+q4h";
	dkim=pass (2048-bit key) header.d=sealsq.com header.i=@sealsq.com header.b="hKgjZasm"
X-Original-To: linux-integrity@vger.kernel.org
Received: from dispatch1-eu1.ppe-hosted.com (dispatch1-eu1.ppe-hosted.com [185.132.181.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FFF32FBDF4
	for <linux-integrity@vger.kernel.org>; Thu, 18 Sep 2025 09:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.132.181.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758186947; cv=fail; b=ec2NAZolYj71T1pO16F8zVPPxazx+osWsA2epVFi4Y3xSmuKJH4yUaHObZSPOomKXKIDKkpTpElr+9ZyjM4Ug5CKLzTqdizq2zfJPW8iC/PZK4G/S+aPplggHLE/XCJjJ4djZ7w3pPOf6LZxfQOwRBXygZZ1cklnwMO64RUELEA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758186947; c=relaxed/simple;
	bh=D9AIPkZK+Ihm4Df6FK/DwCDnWVlPhlPQ+Ec4EC4jsyI=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=ghN9rB73NSaJBF5ty73NZf+F+yws/QIulz7vby6o8YFlvK2grWaDhOjURuaYV5OWCBtW5258k06mXGqZGOAQ5+uLbzD+VbaQy5Vk6z6TGbQLwCWkDWyeuFKNslbvVGl4CLUaApGrVtiwIs0/iG7jF6UoYBoGXgNRb4iOD2/GTNg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sealsq.com; spf=pass smtp.mailfrom=sealsq.com; dkim=pass (2048-bit key) header.d=sealsq.com header.i=@sealsq.com header.b=hx8L+q4h; dkim=pass (2048-bit key) header.d=sealsq.com header.i=@sealsq.com header.b=hKgjZasm; arc=fail smtp.client-ip=185.132.181.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sealsq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sealsq.com
Received: from dispatch1-eu1.ppe-hosted.com (ip6-localhost [127.0.0.1])
	by dispatch1-eu1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 6B854240DA1
	for <linux-integrity@vger.kernel.org>; Thu, 18 Sep 2025 08:50:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sealsq.com;
 h=cc:cc:content-type:content-type:date:date:from:from:message-id:message-id:mime-version:mime-version:subject:subject:to:to;
 s=selector-1728642771; bh=/OAQxxXgOUqBS0D0xN7eJfH8aEA0ygcJyB6HLVhC69w=;
 b=hx8L+q4hX8CrIt858nweWIHprYWAVZLA859zwLJqNSRHaSBrF61eyZuMjL+hPBJYDQ+haYTRvlfto8Pi2Yz84kiiQShRD9bFHmfkSJKR5d8C5Z2HxLieBHlcGUCdHfr+t9TSLIodViC6QhKqy7btUuaEs8devg4AFNlSVVMAuRd8mWi6oH8pfrPez6B776tFhIaxTqde+Mu5mLEe8K9I2v6hJSwk4IVy6JVk3y+VOWTTmaCjNqNCU6WJmJBNg9uRN1c26eY6iC3rk5BCY+hsXCcbczzhA/WoPPECd+PpTAW1MaubNG0kVcQaeDOylIIvmO++CZfAtENbhkoCBF5pQw==
X-Virus-Scanned: Proofpoint Essentials engine
Received: from ZR1P278CU001.outbound.protection.outlook.com (mail-switzerlandnorthazon11022111.outbound.protection.outlook.com [40.107.168.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mx1-eu1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id E4D7F74005C;
	Thu, 18 Sep 2025 08:50:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EWToLb1lY47zJLk4GMHnGQWsHF+db2sVcaomE8GPqPDb/lQ/JZtpijfbkJoG8SrDpX9V44jyIy500dGHBXVlzhM/VNDOXGTv68aMX0FB2WZH2ArUslKNzdGtnmf1pIDkIEifkIQBEHogDsusu4+Bdt14SZJxhpsXGIV22gjc4ZsgM9tGKCP1oSIToQXrdHCq9djwUFW9yWVLrLDmyaF73opRC4r10j4F3za2N+Y8TkpfdQvhrqd7zruwCTfq+a8u/4IdZ5oRUb4YF3nHr2cW/vUnFp+OYWo1MTwNLNxGw9rdCpm1YI9WSLWJ6yo/mRywB0Oj38mH+jeMYJd1OB4LvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/OAQxxXgOUqBS0D0xN7eJfH8aEA0ygcJyB6HLVhC69w=;
 b=jCNRYH6f+FT6kOddmcCwtxYTjPLMrHup/GsN+da79feWKTQJ30DB+xHcXJPKMlQVjxM4PrSJByKAeFicWF/fAuD2Qdm73k7MFp5hjwPg8ZcGdmOwfcEmgbCUqMy/KYzIDQL43JwVrjtsT1YWnlgQTzkfzfbxyGSH3MY/j2c5WeBzIsGNtQEmmIcOI+iLg9Y/NW+vv+iz6xbVZNwYLQJskSiPc/nuHif37iefyPmqc7KyxA5bVQusx5O5nP0/CeRVdixTRGktXJqh+Sg+RH2xX83HDJk+Cif3Ygf4gPYI/xRy5PYROa1isVfnp7rV4r50kmmIsfIARGAMdEl+ImTJNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sealsq.com; dmarc=pass action=none header.from=sealsq.com;
 dkim=pass header.d=sealsq.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sealsq.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/OAQxxXgOUqBS0D0xN7eJfH8aEA0ygcJyB6HLVhC69w=;
 b=hKgjZasmO6pFumfyU+fBccco9o4hzTeD7AnZU3Oi54PoYtNBPxLmJ7HUvvYKr6Mm3CTUmdgxk1IocRy85cr6CmL+wH5Lc2cgDsBeb44fezUohOKRjpcxREYqj7MSR++Rdqyz6BboghhZ9ar4LNfBC6TamKT3Yol2Mz+tXqopF16X3zzPJNF5h4TNZNRH3WF+umKXfj7+kWiMme5k2hksIWTyd4qO8SDhQZKzNih0/BYh8GbT1H9VBsLJnpu+u78QFutOF4enmGEMsU2lFi019Mxd/kNVprDVbkJdqQ/L43p9EE6DdAeW3dTxyWpUQxm98bpJFwGOCykju2MuXcAQ8g==
Received: from GVAP278MB0280.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:3b::12)
 by ZR0P278MB0798.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:43::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.14; Thu, 18 Sep
 2025 08:50:39 +0000
Received: from GVAP278MB0280.CHEP278.PROD.OUTLOOK.COM
 ([fe80::a383:3706:fc55:cced]) by GVAP278MB0280.CHEP278.PROD.OUTLOOK.COM
 ([fe80::a383:3706:fc55:cced%4]) with mapi id 15.20.9137.012; Thu, 18 Sep 2025
 08:50:39 +0000
From: =?iso-8859-1?Q?Fr=E9d=E9ric_JOUEN?= <fjouen@sealsq.com>
To: "peterhuewe@gmx.de" <peterhuewe@gmx.de>, "jarkko@kernel.org"
	<jarkko@kernel.org>, "jgg@ziepe.ca" <jgg@ziepe.ca>
CC: "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>
Subject: Issue with TPM kernel code
Thread-Topic: Issue with TPM kernel code
Thread-Index: AdwoeAF1kBToPDIGQ92AB2R3SuLqCg==
Date: Thu, 18 Sep 2025 08:50:39 +0000
Message-ID:
 <GVAP278MB0280F83F8CE1884D26A0BA35B116A@GVAP278MB0280.CHEP278.PROD.OUTLOOK.COM>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sealsq.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GVAP278MB0280:EE_|ZR0P278MB0798:EE_
x-ms-office365-filtering-correlation-id: 626c7f68-0c2c-46e1-3d35-08ddf690716c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|366016|13003099007|38070700021|4053099003|8096899003;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?zigpx6H3y9jSuZuA9jPizBUDZhT6S8m9xMIInzyK1vFz2/v6tvU5dpjQe7?=
 =?iso-8859-1?Q?w8Sbz+km/QLoaKPKZK5pz3DPAavPi0/9c5NVBD9IIW64dYX9Fu86EW/KGw?=
 =?iso-8859-1?Q?KlVa4tCnw9gefP30pZjNltJDeO13FY1zL9McusNsy0UBHS3RljKSiz/PVW?=
 =?iso-8859-1?Q?2HKVff5exRkepTOjOYEHx5I+DAdNS3kImg3zAb4z6R1+LuxwZvlUAtssGG?=
 =?iso-8859-1?Q?HSkx8yt7L6ZX08ZeKN2o8usbz/zktN76MzHRbYjlOu5xRlj67jfZVMjxp6?=
 =?iso-8859-1?Q?OVrkwdBn/X6RC5XlUkWGMJx5XyvJbK56+ALcGXpN6460YihM1H75Zbb29M?=
 =?iso-8859-1?Q?cXZkEwbKCEYTqtC8csAEVtPwVckDYMBpV3VX+KmfbU2b+l13gOnW5yURSn?=
 =?iso-8859-1?Q?sTz1jCo6DzXyQQ5XBL+AUBL0Tll/kmUC5JNYRyNo8li/6P0l9je6s0YoWZ?=
 =?iso-8859-1?Q?Syb/4SJzAOP7oULnc+cLoXaAlY/kBEqrUl3FQNGxQtZEBzQR+Opu3PbySr?=
 =?iso-8859-1?Q?UWkjzqi+SCCbpXGBeY1G9d/EpdbXk+F3tOZWw+4rEuxHU+vxV9XTln1txn?=
 =?iso-8859-1?Q?04j9sQsY520Vdvb/88G4b47OsDLix76eVTwzuBjTtz/+CcDq1DQZqSl+HY?=
 =?iso-8859-1?Q?rIQIFdVw1VKzx5cnu55VwBVX9O3TiqZRkiG3VYnF7qGTQiRuEcAhNqRJxW?=
 =?iso-8859-1?Q?8+eqQ1plyxc21WNaTOVsBirmrILTj4IyhDH2ZotkDKEtIzCSSSLSYfUCwT?=
 =?iso-8859-1?Q?wLPeJZBTgAJWkf8fzPR0b3vRQ5j5l6Hf0pP5ZsYzsDZwcprDFS9eJkC/LA?=
 =?iso-8859-1?Q?CFTH0C3AUa8MILV2yO5tDNecB37uJXxV3GhSnDoWopYl1W95Fi++T1yH63?=
 =?iso-8859-1?Q?6ObZJ1vKAnSiZf1uP5E/+1b7QoUWLZ1OujqkyVYFsskbcN/Dj6ekNSCkzV?=
 =?iso-8859-1?Q?NomXDC9b99fFIZ0qzFNOITWE1RAZ3BtKkmvqG5SmqGakpRoBAES/BACszF?=
 =?iso-8859-1?Q?fTD4ZRRMd65QS0jrAyzX+XWs4AAJfz284KpdkVkhk6VC04KRyY231r1sBD?=
 =?iso-8859-1?Q?np65lRN5FkJNp3nAOxmIMUPmbf5beL9E1+TYK+pKni4EksyOcM+2Vj9g18?=
 =?iso-8859-1?Q?vQR08r5+QLsiIbZJNM95zjsv9hhvyPRN26htAlDZKluN4crt6ZuV01oWBS?=
 =?iso-8859-1?Q?hp46GYYQ8G6CctJvvUcCTMfOLPdLPg+V/V3HcCGv4AM0j9noYi3p3NX4+O?=
 =?iso-8859-1?Q?weZco946Tk+2ZqC9tU5KkMPCpN5VoUphr4vsYkG+EPPGsbxzt06nxUqQ8j?=
 =?iso-8859-1?Q?0hueD+HFZuqOGzMNXqshsmaFGy0Dt9hU62HgG5z8OezpLviSx1Oyx9UFlx?=
 =?iso-8859-1?Q?8RoVqfSKtDLQqQ1I7M2cja8Eg42BFX2H7lKZN+TTrIm8EcHSXPbnHNMkLX?=
 =?iso-8859-1?Q?QrUNjrmIQejb69dHNHRHIIISCd37YjhZ/wuou4ms5kCQ4WD2RbO5fm6taV?=
 =?iso-8859-1?Q?FOTTFPZ8ahWs6jJRz7D0ceEjjhOYYEJX3LmyKbBP/HeolodX0G80QwirLz?=
 =?iso-8859-1?Q?oOiUWgQ=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GVAP278MB0280.CHEP278.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(13003099007)(38070700021)(4053099003)(8096899003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?AMKNpRYJODbKrrb4tnL7N51LrZIJzN4vSRN9rHInXXQ7AuKmhSXCv5iL5C?=
 =?iso-8859-1?Q?MKvk+Rv2tD5O4UG1IYwP+Kgu4iLOPbMxj/0mqB1tuc4IkEJHSUYoQgGAhC?=
 =?iso-8859-1?Q?67fDcB9merQ8yOTwkNyvkP114FceFrlQ98YvgqnlVQXW62jle/8zjmBCoV?=
 =?iso-8859-1?Q?quTKKP96PcaZTGCBMy643+UntCm5WecCdYo+gxHqqxgdiyOdFBCGkzAkVV?=
 =?iso-8859-1?Q?d9LNjuSzsDCfLH94F+PFDKqrGZDVPdmvtSbBXs8IrYqgPRWZCwq3KPSjpj?=
 =?iso-8859-1?Q?NSXPD0+YPW//8bR3fXNn4ERBBltS6TC0bfAOkP9QSils+Eus5NRxXmrqEE?=
 =?iso-8859-1?Q?DAt/QiCdsadMg7Wci4lUrO3XrpCY2O6Ht9fYYmGNAIs+9AXNYc8GSd0vC+?=
 =?iso-8859-1?Q?eKfBb+diSHB6u0zdlmDGeh4Fg59nZ0GfwS1UsFCrO8dOmcqgdRn6ggMz70?=
 =?iso-8859-1?Q?7UcWPM7M6Xl02MqlsEBAtDpSfb6oAEWPf0E0cHrGrbqPygPwuJ4FoGdQli?=
 =?iso-8859-1?Q?fqhWqlpyHulHHrpxEMr0UKKEkdG+8phajlIsp/MyQ91aWe/13znOTPhw+Y?=
 =?iso-8859-1?Q?to+oQ7Dy4MmuG5qHzB1K1upopnTQBQaQ168Si43n3tQAKvdzYiXXr0QU7S?=
 =?iso-8859-1?Q?baSD2gQR9oX7IDq/I7jodmehJyLxkTy8DkV25DcBxnQnoMESnTUAjkUKjt?=
 =?iso-8859-1?Q?MxqBaUqE2cHUn2TMSSbTxwqlPBno8DKTAGztcUoiDnWcKjZ6mk4S+TiEs4?=
 =?iso-8859-1?Q?4bvDXUmcREPkxaNCeL+WKjKMtA0WAnjYajQPKma+PFFItyVrBf96IHdbeJ?=
 =?iso-8859-1?Q?0bhneycsC4ev3BaJWAU2r1iNuKvA0eWaMWzHIlX+hMJ56dc8+bxVPyO3mW?=
 =?iso-8859-1?Q?RvusfxaiFXX8Us1dO2jnVPqXtNqyzjVEm5VC9HjQiiWHU9Xp78Udaq7W2S?=
 =?iso-8859-1?Q?QO93tkMAi5hu0Ix9eo9idOkEltDIbYWAh/UYp3C2mJ4APzdEAIJ0AqST3O?=
 =?iso-8859-1?Q?k7ucSt7FZcdwSEElSvUde3kBTiJ+OODrg0aO6BFj/Ezbxs3U3VpiqMVw3e?=
 =?iso-8859-1?Q?30IciFw9yRR6MrNWNsmiy8XyBQjLkv1Kx7ZMgShSfxHdjisiqs/xj18JWF?=
 =?iso-8859-1?Q?SarGkcUebrg6bYaTkUpCp+9WXnPXLM3LGt1MnCLg126gIuggqvziplqSXM?=
 =?iso-8859-1?Q?uTrqTvQDxnIx1Ag1q266rcnSGXRmOH9oI+6bii6NIT0D5Rj//iN9akMAvC?=
 =?iso-8859-1?Q?AjTy9Q2vEp0P2ShvbSH8/cwufl41tOi6KH1ai2+q3OKiP+mQOpv9f4IqxA?=
 =?iso-8859-1?Q?8zDq7LPrMbNOnNbEWCpS5Nc4lA6kAmosPFNM9w+w8HMchOodO4I4WvrqaO?=
 =?iso-8859-1?Q?Ozcfoz+/xkfFeTvQJg5Lqj2YNwUbgcZvZtw6H2Oj6mANW1q3rvEdzD5wjf?=
 =?iso-8859-1?Q?KPbilkkYgOaYwDRFaaptEVdLA38CeVoTP3zdcJQJNDaH6laPoD9xTaZnwB?=
 =?iso-8859-1?Q?BwmAec34rE0tw25paMXFpzWG7/Tk+rfH5FBhZ22mNGYfI5kyQY+wJMiaDH?=
 =?iso-8859-1?Q?Wki2KHUk+B2cgtmGw2v5u+pB1XyvNwE0fdV0BxdVHyBWmn/e1cb6ZJIuVK?=
 =?iso-8859-1?Q?SqovQtk4Zl6RZ7C70SuH98CrM2eMu4aALP?=
Content-Type: multipart/signed;
	protocol="application/x-pkcs7-signature";
	micalg=SHA1;
	boundary="----=_NextPart_000_0013_01DC288A.11C7D8E0"
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: sealsq.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: GVAP278MB0280.CHEP278.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 626c7f68-0c2c-46e1-3d35-08ddf690716c
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Sep 2025 08:50:39.4663
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 157a18b4-75b6-4854-b030-3eba9da2b7ca
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MB/tte+e9t5gVQWoJzBolgluxRBf5+MH7Iw5twmDmqucQXnPZWbZL//6x7HRzZpBGMaVOpFDSwO3qdBRDG33Bw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZR0P278MB0798
X-MDID: 1758185448-t0hA03OUftzY
X-PPE-STACK: {"stack":"eu1"}
X-MDID-O:
 eu1;fra;1758185448;t0hA03OUftzY;<fjouen@sealsq.com>;d867992156adb6d2c6b16f88e0a0db26
X-PPE-TRUSTED: V=1;DIR=OUT;

------=_NextPart_000_0013_01DC288A.11C7D8E0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_001_0014_01DC288A.11C7D8E0"


------=_NextPart_001_0014_01DC288A.11C7D8E0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Good morning All,

=20

I have created two issues into the raspberrypi linux github regarding =
the
TPM driver interface. =20

Issues are :

*	https://github.com/raspberrypi/linux/issues/7053
*	https://github.com/raspberrypi/linux/issues/7054

=20

For both Phil Elwell redirects me to you. =20

How can address these issues in a proper way ?

=20

On my side I=92m currently working  in SEALSQ France (a WISeKey =
company). =20

We are about to release a new TPM device including PQC features.=20

But today we are facing some troubles such as the issues listed above =
with
using current linux kernel.=20

=20

Best Regards,

Frederic Jouen

=20


------=_NextPart_001_0014_01DC288A.11C7D8E0
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" =
xmlns:o=3D"urn:schemas-microsoft-com:office:office" =
xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" =
xmlns=3D"http://www.w3.org/TR/REC-html40"><head><meta =
http-equiv=3DContent-Type content=3D"text/html; =
charset=3Diso-8859-1"><meta name=3DGenerator content=3D"Microsoft Word =
15 (filtered medium)"><style><!--
/* Font Definitions */
@font-face
	{font-family:Wingdings;
	panose-1:5 0 0 0 0 0 0 0 0 0;}
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#0563C1;
	text-decoration:underline;}
p.MsoListParagraph, li.MsoListParagraph, div.MsoListParagraph
	{mso-style-priority:34;
	margin-top:0in;
	margin-right:0in;
	margin-bottom:0in;
	margin-left:.5in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-family:"Calibri",sans-serif;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
	{page:WordSection1;}
/* List Definitions */
@list l0
	{mso-list-id:691494838;
	mso-list-type:hybrid;
	mso-list-template-ids:603480060 -1638629028 67698691 67698693 67698689 =
67698691 67698693 67698689 67698691 67698693;}
@list l0:level1
	{mso-level-start-at:0;
	mso-level-number-format:bullet;
	mso-level-text:-;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;
	font-family:"Calibri",sans-serif;
	mso-fareast-font-family:Calibri;}
@list l0:level2
	{mso-level-number-format:bullet;
	mso-level-text:o;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;
	font-family:"Courier New";}
@list l0:level3
	{mso-level-number-format:bullet;
	mso-level-text:\F0A7;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;
	font-family:Wingdings;}
@list l0:level4
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;
	font-family:Symbol;}
@list l0:level5
	{mso-level-number-format:bullet;
	mso-level-text:o;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;
	font-family:"Courier New";}
@list l0:level6
	{mso-level-number-format:bullet;
	mso-level-text:\F0A7;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;
	font-family:Wingdings;}
@list l0:level7
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;
	font-family:Symbol;}
@list l0:level8
	{mso-level-number-format:bullet;
	mso-level-text:o;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;
	font-family:"Courier New";}
@list l0:level9
	{mso-level-number-format:bullet;
	mso-level-text:\F0A7;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;
	font-family:Wingdings;}
ol
	{margin-bottom:0in;}
ul
	{margin-bottom:0in;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]--></head><body lang=3DEN-US =
link=3D"#0563C1" vlink=3D"#954F72" style=3D'word-wrap:break-word'><div =
class=3DWordSection1><p class=3DMsoNormal>Good morning =
All,<o:p></o:p></p><p class=3DMsoNormal><o:p>&nbsp;</o:p></p><p =
class=3DMsoNormal>I have created two issues into the raspberrypi linux =
github regarding the TPM driver interface.=A0 <o:p></o:p></p><p =
class=3DMsoNormal>Issues are :<o:p></o:p></p><ul =
style=3D'margin-top:0in' type=3Ddisc><li class=3DMsoListParagraph =
style=3D'margin-left:0in;mso-list:l0 level1 lfo1'><a =
href=3D"https://github.com/raspberrypi/linux/issues/7053">https://github.=
com/raspberrypi/linux/issues/7053</a><o:p></o:p></li><li =
class=3DMsoListParagraph style=3D'margin-left:0in;mso-list:l0 level1 =
lfo1'><a =
href=3D"https://github.com/raspberrypi/linux/issues/7054">https://github.=
com/raspberrypi/linux/issues/7054</a><o:p></o:p></li></ul><p =
class=3DMsoNormal><o:p>&nbsp;</o:p></p><p class=3DMsoNormal>For both =
Phil Elwell redirects me to you.=A0 <o:p></o:p></p><p =
class=3DMsoNormal>How can address these issues in a proper way =
?<o:p></o:p></p><p class=3DMsoNormal><o:p>&nbsp;</o:p></p><p =
class=3DMsoNormal>On my side I&#8217;m currently working =A0in SEALSQ =
France (a WISeKey company).=A0 <o:p></o:p></p><p class=3DMsoNormal>We =
are about to release a new TPM device including PQC features. =
<o:p></o:p></p><p class=3DMsoNormal>But today we are facing some =
troubles such as the issues listed above with using current linux =
kernel. <o:p></o:p></p><p class=3DMsoNormal><o:p>&nbsp;</o:p></p><p =
class=3DMsoNormal>Best Regards,<o:p></o:p></p><p =
class=3DMsoNormal>Frederic Jouen<o:p></o:p></p><p =
class=3DMsoNormal><o:p>&nbsp;</o:p></p></div></body></html>
------=_NextPart_001_0014_01DC288A.11C7D8E0--

------=_NextPart_000_0013_01DC288A.11C7D8E0
Content-Type: application/pkcs7-signature;
	name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename="smime.p7s"

MIAGCSqGSIb3DQEHAqCAMIACAQExCzAJBgUrDgMCGgUAMIAGCSqGSIb3DQEHAQAAoIINyDCCA7Uw
ggKdoAMCAQICEHaxIFJ08IWHRrP4Ixr2wsAwDQYJKoZIhvcNAQELBQAwbTELMAkGA1UEBhMCQ0gx
EDAOBgNVBAoTB1dJU2VLZXkxIjAgBgNVBAsTGU9JU1RFIEZvdW5kYXRpb24gRW5kb3JzZWQxKDAm
BgNVBAMTH09JU1RFIFdJU2VLZXkgR2xvYmFsIFJvb3QgR0IgQ0EwHhcNMTQxMjAxMTUwMDMyWhcN
MzkxMjAxMTUxMDMxWjBtMQswCQYDVQQGEwJDSDEQMA4GA1UEChMHV0lTZUtleTEiMCAGA1UECxMZ
T0lTVEUgRm91bmRhdGlvbiBFbmRvcnNlZDEoMCYGA1UEAxMfT0lTVEUgV0lTZUtleSBHbG9iYWwg
Um9vdCBHQiBDQTCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBANgXtxxKJCrWl7HK4h77
fTjvmPWyOZhOJ7gRXXvSJZSIghUmahsxu6hbISEr2A9On1rxsVrkedYyIyvhU8yZRVx7T628v4dK
C0uXWqj2SOx9ew3NIQbfnhX9QYpItyD0oXobV9RdUP+6Z9gjmR/IP+Pe/29bd7FrbrjJZPfhykFG
Dilx0Lkj/MmBX073b9+/hK1zZLu3Qo5p9tR2HX6dp7hXilFnctfUqLiVVEBzA/bq9Ov+KEJ3P50j
G7K2PYAUB0wuT/fVChYNvWZDN34jQ3nDQIb1TCnajpqtDaUEh4gehePpU9WbyIsDY3jr4BlKbrsv
azNkWJOtab+PG++CSMcCAwEAAaNRME8wCwYDVR0PBAQDAgGGMA8GA1UdEwEB/wQFMAMBAf8wHQYD
VR0OBBYEFDUPyDZjXuKj7Pk7ZhXOUVLjkZo9MBAGCSsGAQQBgjcVAQQDAgEAMA0GCSqGSIb3DQEB
CwUAA4IBAQBATPuHspmBkH6dxbCwJs2IeysyjW64IXFYl32uNxSvPuf3muJ99nGYmQSqQ3R4o+NJ
YT5zjE2U4PlxxLYWDlN4H9aihy8COYEpPK8VmCEw/iiQAIzR4cv6Xsj9+BBGO6J4QpEXdFUK3lBn
TWbRp//92cC1qKOKzmb1D0PNpytXe2NGaqouUtj07eFtrSmQeEi64SOqo4nstauWwLRLoh2Xnnry
bkBx32jxZU3OfAXfU2WppfCxlwRwFUYDmNTSv1S0oFh9Um/aViZi1NjbiTFvHPAiwtNiHDXNTGkV
VBqQmN7rHl/Kd8fLjj1DaZyaWNAkO98bQJZ+Na2Bx05xuogTMIIE1jCCA76gAwIBAgITMwAAABuB
YchfBitbzgAAAAAAGzANBgkqhkiG9w0BAQsFADBtMQswCQYDVQQGEwJDSDEQMA4GA1UEChMHV0lT
ZUtleTEiMCAGA1UECxMZT0lTVEUgRm91bmRhdGlvbiBFbmRvcnNlZDEoMCYGA1UEAxMfT0lTVEUg
V0lTZUtleSBHbG9iYWwgUm9vdCBHQiBDQTAeFw0yMDA3MDQxNTEyMjFaFw0zOTEyMDExNTEwMzFa
MEwxCzAJBgNVBAYTAkNIMRAwDgYDVQQKEwdXSVNlS2V5MSswKQYDVQQDEyJXSVNlS2V5IENlcnRp
ZnlJRCBQZXJzb25hbCBHQiBDQSAzMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEA4cA6
tdKsNDPOBN92GLKvgHtRfihS0BdiIzr/6GXWz5+0/Um1Ytk/ePBZEJNAdWms/doTRsNUTqKK2Ao6
mpVy0Ng3Icmv3rVYcJyEhDxIXYvfC5xDK9VPL014+682tRsHPbrKqV1yA1/nltcn2HInkc3QjxFY
zanMac+NV52TeceMCwIMNXImPXUrnOFGsuLd625UqxJxJCR91yiyXyd+edvuK5JbKGTKFrAwkJtx
2NO+CzFQk3WpT4R9Ra3hdMuJUq3QMRPRLkJ/d7mK/yMVuSbjbUEii8/eqSoqNWvlPZIe+8GSWIei
ymrcmBG4eYc29EsPKehJhLwiyqGGYa4KqwIDAQABo4IBjjCCAYowHQYDVR0OBBYEFOWndkBVsAF/
9AD6TMosb+qcELA2MB8GA1UdIwQYMBaAFDUPyDZjXuKj7Pk7ZhXOUVLjkZo9MDsGA1UdHwQ0MDIw
MKAuoCyGKmh0dHA6Ly9wdWJsaWMud2lzZWtleS5jb20vY3JsL293Z3JnYmNhLmNybDBsBggrBgEF
BQcBAQRgMF4wNgYIKwYBBQUHMAKGKmh0dHA6Ly9wdWJsaWMud2lzZWtleS5jb20vY3J0L293Z3Jn
YmNhLmNydDAkBggrBgEFBQcwAYYYaHR0cDovL29jc3Aud2lzZWtleS5jb20vMEIGA1UdIAQ7MDkw
NwYEVR0gADAvMC0GCCsGAQUFBwIBFiFodHRwOi8vd3d3Lndpc2VrZXkuY29tL3JlcG9zaXRvcnkw
NQYDVR0lBC4wLAYIKwYBBQUHAwQGCCsGAQUFBwMCBgorBgEEAYI3FAICBgorBgEEAYI3CgMMMBIG
A1UdEwEB/wQIMAYBAf8CAQAwDgYDVR0PAQH/BAQDAgEGMA0GCSqGSIb3DQEBCwUAA4IBAQAd57kZ
oN16RGmIhbBwX15BKYrRMQ3NSjo7j3p4WiMNtBRqr+/3tC/3PFLJvUuZC77qFoNZyCgQMv6xIYOo
n5tb7Qwz4eMz/PtdysDoBKG1RyIMf2c+S8sPRbs65znIx6ID8yNJxywx6A2/yDxCXhD+LX1yjdwj
kWZlQpaPCXBufFDFHjCIeb1XvXqiSDuIVKM9jcB+1TDZHO8Aec5vAaScMxIjuAK/ODRewFwTIaza
A2jCE9xcgEn0agNCpbSJ8JW1rkIwht/A1JrV3dsEq5++L214ESFjra6U3DTjtY8LniJgH6MMBcPI
6EJ1hAo1VPk9djPH3doyS94zc5HWgIwgMIIFMTCCBBmgAwIBAgIUHODCiCtBO4YhJVWfYw9W9bSo
bzMwDQYJKoZIhvcNAQELBQAwTDELMAkGA1UEBhMCQ0gxEDAOBgNVBAoTB1dJU2VLZXkxKzApBgNV
BAMTIldJU2VLZXkgQ2VydGlmeUlEIFBlcnNvbmFsIEdCIENBIDMwHhcNMjQwNDExMDkyNDQzWhcN
MjYwNDExMDkyNDQyWjCBmTELMAkGA1UEBhMCVkcxHzAdBgNVBAgMFlZpcmdpbiBJc2xhbmRzIEJy
aXRpc2gxFDASBgNVBAoMC1NFQUxTUSBDb3JwMRYwFAYDVQRhDA1OVFJWRy0yMDk1NDk2MRkwFwYD
VQQDDBBGcsOpZMOpcmljIEpPVUVOMSAwHgYJKoZIhvcNAQkBFhFmam91ZW5Ac2VhbHNxLmNvbTCC
ASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBALVK3xTeXvN9suHImy3Yqo3Q3tQZwIoqSuaS
MQcD39of2s4q2IN3Z/HdcifZ4Cy/32+qAaU4ERB2XUOw9zi3/DiL/9IfEr7V9DdxHraAUdZ2c+H0
ot8ayaaQ1kVlRsSvviZ8eA5Y4iLlsZPmEPKSdKOc0JCvkK83tzY3zcNQcm9SbfpcPxXVKqsZEfyb
2fiiLh9J3kisqI9jZhGdPNr5iS/fwyIXzQMoH5RZ4iCO+f2JGAYvve3k3jpN5f3jJUkgn/U5lSQP
JsMUnJqaOB0R+Xw6Vj9AlHazUTWXhPrmBzN7kL1ihsXBdzCfnE4J3wfrgLRWfUKCtbOlVaK01jaA
m/sCAwEAAaOCAbswggG3MAwGA1UdEwEB/wQCMAAwHwYDVR0jBBgwFoAU5ad2QFWwAX/0APpMyixv
6pwQsDYwcAYIKwYBBQUHAQEEZDBiMDsGCCsGAQUFBzAChi9odHRwOi8vcHVibGljLndpc2VrZXku
Y29tL2NydC93Y2lkcGVyc2diY2EzLmNlcjAjBggrBgEFBQcwAYYXaHR0cDovL29jc3Aud2lzZWtl
eS5jb20wMAYDVR0RBCkwJ4ERZmpvdWVuQHNlYWxzcS5jb22BEmZqb3VlbkB3aXNla2V5LmNvbTBS
BgNVHSAESzBJMDwGCGCFdAUOBwQCMDAwLgYIKwYBBQUHAgEWImh0dHA6Ly93d3cud2lzZWtleS5j
b20vcmVwb3NpdG9yeS8wCQYHZ4EMAQUDATAdBgNVHSUEFjAUBggrBgEFBQcDAgYIKwYBBQUHAwQw
QAYDVR0fBDkwNzA1oDOgMYYvaHR0cDovL3B1YmxpYy53aXNla2V5LmNvbS9jcmwvd2NpZHBlcnNn
YmNhMy5jcmwwHQYDVR0OBBYEFI5vUUU5vpJy1avNfwxjDNtjDAH4MA4GA1UdDwEB/wQEAwIFoDAN
BgkqhkiG9w0BAQsFAAOCAQEANDmKqHBZYT+VtdKM6bZkvBnAnTeTfFHA8PRo+9ujywt+rwXIBWn8
b3sGTt6NAlxpS1JauGjLX6WY0RSx+R7mqoqw+qFLeB8bTXRppX6OoBbpKySFNjYPqjGUMSjm2tTJ
O983/wP4HqGGlLkpm9NqAGhNs5hUO0lmlFNFhCcXB9K6+FwrVSgmqn2LbsY+r6RKaDWwSAV9Wope
pIKb0g0VjyZqTbVwM/aXigQLrqyYqDnuyU/I6Ep9h+nhuKDsMgivUW0m0zfRD+dbeNzSbSNM54u3
0vB32LWDxW1lzep58Z8kV1G+KQCO6e9iV0vXBFdP4T4y/I4oB0qJFzoGqqV90DGCA24wggNqAgEB
MGQwTDELMAkGA1UEBhMCQ0gxEDAOBgNVBAoTB1dJU2VLZXkxKzApBgNVBAMTIldJU2VLZXkgQ2Vy
dGlmeUlEIFBlcnNvbmFsIEdCIENBIDMCFBzgwogrQTuGISVVn2MPVvW0qG8zMAkGBSsOAwIaBQCg
ggHfMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI1MDkxODA4NTAz
OFowIwYJKoZIhvcNAQkEMRYEFM90uaHLUT4qQJxtDiA1qUsRXhRIMHMGCSsGAQQBgjcQBDFmMGQw
TDELMAkGA1UEBhMCQ0gxEDAOBgNVBAoTB1dJU2VLZXkxKzApBgNVBAMTIldJU2VLZXkgQ2VydGlm
eUlEIFBlcnNvbmFsIEdCIENBIDMCFBzgwogrQTuGISVVn2MPVvW0qG8zMHUGCyqGSIb3DQEJEAIL
MWagZDBMMQswCQYDVQQGEwJDSDEQMA4GA1UEChMHV0lTZUtleTErMCkGA1UEAxMiV0lTZUtleSBD
ZXJ0aWZ5SUQgUGVyc29uYWwgR0IgQ0EgMwIUHODCiCtBO4YhJVWfYw9W9bSobzMwgZMGCSqGSIb3
DQEJDzGBhTCBgjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAoGCCqGSIb3DQMHMAsGCWCGSAFl
AwQBAjAOBggqhkiG9w0DAgICAIAwDQYIKoZIhvcNAwICAUAwBwYFKw4DAhowCwYJYIZIAWUDBAID
MAsGCWCGSAFlAwQCAjALBglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEAanRGVcUBDqQLvqnm
jcnMono8wBpqqTwruHDEVhVYWVfci+DMiHZonGpPTx/5Hc8da/+t6VcaTZxHJDc9w8TkbPk1SGK7
ji7hAWn7lpfJ7Ble9fyzbf75deld8MIJzzLhkgI9e0W2jzczLc2qGO0K3kwO3+iDeNbz/6qhf9WX
0dA4OC853p1JhRdOybunRY6Zs4k31abG09Kh8b+e9/TLcgxHRxAOw27A4Foqdo/FWZGnm0gWHuE+
0P+OMFEiP49t+kLuD0/yQcJslg9PWFlQHECpRN1fhMLy+igmJodas4VC0/n+w2js2mVfm0BCxatn
aTuAq0TrzyCWPYmr6xn6zgAAAAAAAA==

------=_NextPart_000_0013_01DC288A.11C7D8E0--

