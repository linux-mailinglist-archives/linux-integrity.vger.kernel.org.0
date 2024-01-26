Return-Path: <linux-integrity+bounces-897-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D758583D29C
	for <lists+linux-integrity@lfdr.de>; Fri, 26 Jan 2024 03:37:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 071021C23F52
	for <lists+linux-integrity@lfdr.de>; Fri, 26 Jan 2024 02:37:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72B2B1C17;
	Fri, 26 Jan 2024 02:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b="JreenOAG"
X-Original-To: linux-integrity@vger.kernel.org
Received: from rcdn-iport-7.cisco.com (rcdn-iport-7.cisco.com [173.37.86.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E76871C0F
	for <linux-integrity@vger.kernel.org>; Fri, 26 Jan 2024 02:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=173.37.86.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706236665; cv=fail; b=gYB5gfLwK4yFxHAORbWR0aa5OTYjq+VbX7ohz0d4i2vbjJNnnZvC9kHTYz/za/yGzpWZyXnHdWpnTH79eoipMpsxzXSQlsXUoGHWbQ+We3SO5idaHMJ3U1xVM20FjGIew7cLyzCj7Jyo1ZWn1t1q/gK+J4/2O0tZ99K6+M/ua7w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706236665; c=relaxed/simple;
	bh=X2OMAmRw/f3Hw+GFHLrB8GQazUn1jaTbgSD2VrUGELM=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=JLadqD6ALLc0+8drfvQrVNhq2LweNJ88pq6N+QZR7ik0HdqTCsggde/sZr9ZqjrCMBt9eL8ioYe+mMZ9QRGJx9a/k0Dp9Wo2qnV13pB0rmTbHuHSftbcf+dDk177q0ouRxMxJ9+w0/VwcciRZ+dRJAzYaVB4PG5Z3KMNmXb5vtg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com; spf=pass smtp.mailfrom=cisco.com; dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b=JreenOAG; arc=fail smtp.client-ip=173.37.86.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cisco.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=cisco.com; i=@cisco.com; l=1075; q=dns/txt; s=iport;
  t=1706236663; x=1707446263;
  h=from:to:cc:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=6UUsPmcSdviIlAY5MmH8KifnXb7vnqQHQ6WpBhTf9Zc=;
  b=JreenOAG1jpAc6K5QTiBpqcvTEGxMlcolqs8kFfanRWDJnFaGTnJnEZh
   H7gB+ziXXWPwUz1kM++GsBPrJ+3UkhiOSJkBNI0jTpjYYTVewdIJgCEaF
   5WEzey8FlUZ8P4qobTDNst0iD3Sx1RuueolxwUR7zHb5aGOiH8Z637XbX
   c=;
X-CSE-ConnectionGUID: ylrRXIqjQA6q3RcR0EZP4A==
X-CSE-MsgGUID: Ubi2d9uKRWG2ROpQh8CXUA==
X-IPAS-Result: =?us-ascii?q?A0C9AQCuGbNlmJxdJa1aHgEBCxIMQCWBHwuBZ1J6gQcSi?=
 =?us-ascii?q?GYDhS2hFIVbgX4PAQEBDQEBRAQBAYUGAodJAiY2Bw4BAgQBAQEBAwIDAQEBA?=
 =?us-ascii?q?QEBAQEGAQEFAQEBAgEHBRQBAQEBAQEBAR4ZBQ4QJ4VtDIZIFmcSAT1CJwQOD?=
 =?us-ascii?q?RqCXoJgAwGpbwGBQAKKKHiBNIEBghYFsn6BSIgiAYVlhD0nG4FJRIFXgmiBQ?=
 =?us-ascii?q?wGDP4QSgi8EghaDQ5MUgVMdA4EFbxsQHjcREBMNAwhuHQIxPAMFAwQyChIMC?=
 =?us-ascii?q?yEFE0IDQAZJCwMCGgUDAwSBMAUNGgIQLCYDAxJJAhAUAzgDAwYDCjEwVUEMU?=
 =?us-ascii?q?ANlHzIJPA8MGgIbGw0nIwIsQAMREgIWAyQWBDYRCQsmAyoGNwISDAYGBl0mF?=
 =?us-ascii?q?gkEJQMIBANUAyF0EQMECgMUBwsHeINKBBNHEIFCZgNEHUADC209FCEUGwUEg?=
 =?us-ascii?q?TYFnWUyojOBNKFJCoQRoU8Xqhouh1WQUSCoJQIEAgQFAg4BAQaBagsogVtwF?=
 =?us-ascii?q?YMjURkPjjmTWoExAgcLAQEDCYpnAQE?=
IronPort-PHdr: A9a23:lgLUphLh/ZlhDJCfaNmcua8yDhhOgF28FhQe5pxijKpBbeH/uZ/jJ
 0fYo/5qiQyBUYba7qdcgvHN++D7WGMG6Iqcqn1KbpFWVhEEhMlX1wwtCcKIEwv6edbhbjcxG
 4JJU1o2t2qjPx1tEd3lL0bXvmX06DcTHhvlMg8gLO3xAZPKp8+2zOu1vZbUZlYAiD+0e7gnN
 Byttk2RrpwMjIlvIbp5xhrS931PfekXjW89LlOIlBG67cC1lKM=
IronPort-Data: A9a23:ON71RagQ9T0WdPOHoA5ge+deX161YhAKZh0ujC45NGQN5FlHY01je
 htvWD+BPfnYZWf1fYtzYYrl8kkFscPWmNdmGQFvqSAyEyNjpJueD7x1DKtf0wB+jyHnZBg6h
 ynLQoCYdKjYdleF+1H1dOCn9CEgvU2xbuKUIPbePSxsThNTRi4kiBZy88Y0mYcAbeKRW2thg
 vus5ZWCULOZ82QsaD5Msvjf8EoHUMna4Vv0gHRvPZing3eG/5UlJMp3Db28KXL+Xr5VEoaSL
 woU5Ojklo9x105F5uKNyt4XQGVTKlLhFVTmZk5tZkSXqkMqShrefUoMHKF0hU9/011llj3qo
 TlHncTYpQwBZsUglAmBOvVVO3kWAEFIxFPICWm7q/aj7lTESlKy2q5UB3tuEL8gps8iVAmi9
 dRAQNwMRgqIi+Tzy7WhR6wxwM8iN8LseogYvxmMzxmAUq1gGs+FEv6MvIIGtNszrpgm8fL2b
 cMdcid3RB/BeBZIfFwQDfrSmc/x2SevImcG9QL9Sawf3mLSlgAgzZvXD/WPQPuSfMUFtXalj
 zeTl4j+KkpHbIPEk2XtHmiXruvOmz7rHYMUCLC37P92kXWNyWEJTh4bT122pb++kEHWZj5EA
 1Yf9ixrpq8o+Qn2CNL8RBa/5nWDu3bwRua8DcUr7Bu3+ovN4T+wWHFfdDV7MPEUjJMfEGlCO
 kCyo/vlAjlmsbuwQH2b96uJoT7aBcTzBTJSDcPjZVZVi+QPsL0OYgTzosGP+ZNZY/XvEj32h
 juNtiV72vMYjNUA0OOw+lWvb9OQSnrhEFJdCub/Bz7NAuZFiGiNPN3ABb/ztqkoEWphZgPd1
 EXoYuDHhAz0MbmDlTaWXMIGF6yz6vCOPVX02AE3QcN5qGj9oCHyIOi8BQ2Swm80Y67onhe0M
 SfuVf95uve/wVPzNPAnPdjtYyjU5fG4So2Nug/ogipmOcUpK1Tdo0mClGab3nvmlwA3gLojN
 JKAOceqBjByNEiU5GTeegvp6pdynnpW7TqKHfjTlk37uZLAPyT9YelebzOzghURsfnsTPP9q
 YgPbqNnCnx3DYXDX8Ug2dRLcQ9SdSNhbX00wuQOHtO+zsNdMDhJI9fawKgqfMpumKE9qwsC1
 ijVtpNwoLYnuUD6FA==
IronPort-HdrOrdr: A9a23:esf3v61R9AbJM9LP3cUKowqjBfhxeYIsimQD101hICG9Lfbo9P
 xGzc566farslcssSkb6Ky90cm7LU819fZOkO8s1MSZLXbbUQyTXc1fBOrZsnDd8kLFh5RgPM
 tbAsxD4b7LfBdHZKTBkXSF+r8bqbHtntHL9ILjJhxWPHhXgtRbnnxE43GgYzVLrWd9dP0EPa
 vZzPBq4xCnfnMaZNm6AH4qY8jvzuegqLvWJTQ9K1oC8gehsROEgYSWL/Gf5HgjegIK5Y1n3X
 nOkgT/6Knmmeq80AXg22ja6IkTsMf9y/NYbfb8y/Q9G3HJsEKFdY5hU7qNsHQeu+e08msnl9
 HKvlMJI9lz0XXMZWu4yCGdmzUIkQxeqEMK+2XoxEcLkvaJAA7SzPAxwr6xRyGpqXbIeusMlp
 6jkVjp7qa/Rimw4hgVr+K4Ji2C0HDE70bLVYUo/idiuUx0Us4IkWQSkXklYKsoDWb07psqH/
 JpC9yZ7PFKcUmCZ3ScpWV3xsewN05DVitub3JyzPB96QIm1UxR3g8d3ogSj30A/JUyR91N4P
 nFKL1hkPVLQtUNZaxwCe8dSY/vY1a9Cy7kISaXOxDqBasHM3XCp9r+56g0/vijfNgNwIEpkJ
 rMXVtEvSo5el7oC8eJwJpXmyq9C1mVTHDo0IVT9pJ5srrzSP7iNjCCUkknl4+6r/AWEqTgKo
 GO0VJtcovexEfVaPN0NlfFKupvwFElIb8ohuo=
X-Talos-CUID: 9a23:FZcNcWPEl5BXeu5DSS19zn41A8IcWyPEl03bGReVO141YejA
X-Talos-MUID: 9a23:vexJMAQvQv7CPwO5RXTRjjA4OJZ1wJ6RJxo3to0/u5mvBRFZbmI=
X-IronPort-Anti-Spam-Filtered: true
Received: from rcdn-core-5.cisco.com ([173.37.93.156])
  by rcdn-iport-7.cisco.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2024 02:36:34 +0000
Received: from rcdn-opgw-4.cisco.com (rcdn-opgw-4.cisco.com [72.163.7.165])
	by rcdn-core-5.cisco.com (8.15.2/8.15.2) with ESMTPS id 40Q2aXTE005850
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-integrity@vger.kernel.org>; Fri, 26 Jan 2024 02:36:33 GMT
X-CSE-ConnectionGUID: sk/8wuxvQcGda8HSMz5wIg==
X-CSE-MsgGUID: oXvU/EMkS8Sppo7YIjE6VA==
Authentication-Results: rcdn-opgw-4.cisco.com; dkim=pass (signature verified) header.i=@cisco.com; spf=Pass smtp.mailfrom=balsup@cisco.com; dmarc=pass (p=reject dis=none) d=cisco.com
X-IronPort-AV: E=Sophos;i="6.05,216,1701129600"; 
   d="scan'208";a="25584467"
Received: from mail-dm3nam02lp2041.outbound.protection.outlook.com (HELO NAM02-DM3-obe.outbound.protection.outlook.com) ([104.47.56.41])
  by rcdn-opgw-4.cisco.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2024 02:36:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hokvnRI0+bMsIY/JEhutKFvCd3Hj846R0XirZ66xs5EGBAxZMINplNtLuQUGnCwssOxCVIuF9YrwZ74VH4olrRiWDRjVEg6sW8EKKHbvQMIquu/UJx9vmQ/HrsJfINFuVncvRzVNxPoXtX8b6vrZynMNcLuGb8P8e8KRjwlXOq8/ZDGXEj035QsdT+V+7m5jhCQwWFGnWvjo/4EZJitFqaLQ5T1HX0khIjDoDHac13aGYgtsLZfiWQkjWPvEENL3WKdanbFLP6DD+yCcnfYkI2CxE8o/zONdNy/E8teQs5G+liCZ9tk2iwpLV6BIEG4R8/hrE8WPChyoX7iFmtuo1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6UUsPmcSdviIlAY5MmH8KifnXb7vnqQHQ6WpBhTf9Zc=;
 b=GQIUcLRK8288tstsxLHnsWolV+TpKQ5qw0ISqA8F4EVac1MNmzu6ugsRw5Ary+mQfmcpXw7Q4nW089Rtcql0cfroJdkUm1Bq6yRiSq5UzalvVxqaoVOe8m82XGbXEXCxefG9NDQZtEdzxdXRsMebCZy6/MVZdyk+9Jb7ogD8/d2DrwDgwnbVKasIc6QTtn4H0+9Ok2MUcj1X/XQ/d3fEH3L4FfJGIz+wfncNtvuNWWLlcCQRLh6Y69fq6IiR4b+GhlIHz2WxynaahHmrh1t66pHEyP5993v/u2KtOUZIzAnHF+gQhoPF4zhsTmsliMf28RX9v2GRngvDgKm+N3BLSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cisco.com; dmarc=pass action=none header.from=cisco.com;
 dkim=pass header.d=cisco.com; arc=none
Received: from BYAPR11MB3527.namprd11.prod.outlook.com (2603:10b6:a03:8b::26)
 by BN9PR11MB5228.namprd11.prod.outlook.com (2603:10b6:408:135::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.27; Fri, 26 Jan
 2024 02:36:32 +0000
Received: from BYAPR11MB3527.namprd11.prod.outlook.com
 ([fe80::2bd9:67d0:43ba:5f6a]) by BYAPR11MB3527.namprd11.prod.outlook.com
 ([fe80::2bd9:67d0:43ba:5f6a%7]) with mapi id 15.20.7228.026; Fri, 26 Jan 2024
 02:36:31 +0000
From: "Billie Alsup (balsup)" <balsup@cisco.com>
To: "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>
CC: "Billie Alsup (balsup)" <balsup@cisco.com>
Subject: ref leak in request_asymmetric_key ?
Thread-Topic: ref leak in request_asymmetric_key ?
Thread-Index: AQHaT/hyjB+cdCGonkelvMgjLj11TA==
Date: Fri, 26 Jan 2024 02:36:31 +0000
Message-ID:
 <BYAPR11MB3527851FFD46381325450F74D9792@BYAPR11MB3527.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR11MB3527:EE_|BN9PR11MB5228:EE_
x-ms-office365-filtering-correlation-id: 5d001bde-625f-46c4-e1ac-08dc1e179b07
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 7SqGR6k+WnBrpiga2wMqliXMzACgyfj+9U8pT2s9skoMq6F/63hAyhgO36eEzvT5hWQPSyF9pciar+s5PQv47nvQ7y7+3IxtF3r/DWh7SMvPfuHHoy60QeY4KU1HR0KogwKK3ftsWREtYrZNNDy6WVmx/jbAo3+3xGV4wUq7RnKFJz/XpLL4LKFlyiYmvvVRZCwlM93JWdk3RgAUt/FepbFX80+XjRJE/ZzOcffjkWtic3OzgRPMiLOTFQc36MEkGbgw4VzgKTXmnZzj0hBZ69ryHC7/bLN8fkHhWMlP3Ot+V101ggHNfD9dCBmgAqsLjbSehydaOlB79Dg+mTge9HTO4FqHYuGF3HA6ZlsrBmo4FAPTXBsWxL6hcxRua+1CWHV8BzwqypStdaoa0zr0Bdv/QPAs3v+ODC46DzW+Mq+i4sPaelIAyys5zvtP8gdJ/dD7/xgoTEcu4Jx7XFylYe055QYjXMvX8Bsfx4C6AkvMcAegv7CG38T01p0Csb/wN2eS9TZmcBEMXyC5E0hd5rj3nSK7xrJ3FRXhoqrOi7O3+tCjS/9G/vRU7t8jU3tPMgBxiuWmSDK6+/pv2vsYm8eKcU/+MHPCMlnR9en8zWA=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3527.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(376002)(366004)(39860400002)(136003)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(55016003)(71200400001)(9686003)(107886003)(7696005)(6506007)(33656002)(86362001)(478600001)(41300700001)(26005)(4326008)(76116006)(316002)(91956017)(6916009)(8936002)(8676002)(64756008)(66446008)(83380400001)(66476007)(66556008)(66946007)(38070700009)(2906002)(38100700002)(4744005)(52536014)(122000001)(5660300002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?cG1tmtn/bg0NtXGxyIupUs17QMnowa13QBVpvpRZPHIKO/CoG3AdiL7Ai9?=
 =?iso-8859-1?Q?ZYb/zoX7H9DW2CD3je0E/ZNuEHt0zMmRkrip7AMSw9ZH3QfW+HdwIE4WCg?=
 =?iso-8859-1?Q?6VOmdHlIAL51xXtFV3VtPu5D9wuLN+xFD02Ygij5ioU3RF3WkUbOPOJqzT?=
 =?iso-8859-1?Q?C6dbyzJIdNJxvvYUQu/RETQQzYmgim2gsQgHXIV80ZGefKpjx8qK8Eqtqm?=
 =?iso-8859-1?Q?zjCfNriB4tIo9rG8oZlzTfIc1QRFWOAs9AYfLQpIhcgKXmfA7WXGiuC9nE?=
 =?iso-8859-1?Q?l0vcq/uB1u8CEdiTHuWTX5QlGLLf4RmiUhLKYgiwOa63E39cBNuZSRJzm6?=
 =?iso-8859-1?Q?GtTA90E+gs7pf9TWoiPZFT0SU//Iuoh++ROz6ibd8W4Yp4CdLvnpo9oNxL?=
 =?iso-8859-1?Q?qKCv9wdQUtPRi+2DlGN2tzJTOZeJktpGgZo5o0U5PQbK6r6G6pzcgJuYyq?=
 =?iso-8859-1?Q?gurl7BDY8UjJvFqtsctScAEyr5jHopcvbfvEIIv1rCT1QnmBbOgXh6MOXR?=
 =?iso-8859-1?Q?YwmECOeliQZ/ouIeEfaFPAMjMb6OfOQlatzIrTb9Nfb58LNpEDIiCtbyTo?=
 =?iso-8859-1?Q?uCcnjDcchnNmG9p7GPJVtDyhCheSy9oMGChJ7YAO19NbIMWF/lZMTl+9r0?=
 =?iso-8859-1?Q?FKSfciZisL8/DhmXHW1gk3FfyKv4GXCiSW53WFZNjjRiWMeSuYs5vKmwEy?=
 =?iso-8859-1?Q?D01Y6vxtA0YPoU/dQU2bFQXRRXzUw2u8ZWAucxLNxTlNZuV8BfRNvz5Gt5?=
 =?iso-8859-1?Q?yewoJsyg1OiZRN3oeeej1XrhulkHGMMt0/i9IVI/4joeQCn6RHYsb7/p3a?=
 =?iso-8859-1?Q?jxISUafFdrO+HL+ZS+idWF0RuWqYYLSqNX2X1RNLONVsMuyvGEjuaJe516?=
 =?iso-8859-1?Q?OumcV0uHZux2fg55QdeX9wsShjvsHrF+ZkaR3mj3PjKzZF9h7Af+QssqRd?=
 =?iso-8859-1?Q?bfgS20UVN+I9x4+e+hmDDcK8VT82vsqX6tX3WaLOcziaCZ1QMTcytmS3vK?=
 =?iso-8859-1?Q?Oos8UdwXT46kD0TAEKGaO0/lhQQ6Yi9fnuKUxR6B8dWz/jNSdrWiIQo019?=
 =?iso-8859-1?Q?A1DEyQF5GGiTq2PhOGpEmr7vllvD/k9nnDek5oNsSmNkKItXKNabLHwnYS?=
 =?iso-8859-1?Q?jjknStAQmkPKtc1Gf+YuDCKx9pQ5CrdjHWL9bn6K6sC0ZQdelN2luV8QxD?=
 =?iso-8859-1?Q?ewBMVFerfSGUnxGEARMRXB+VcqVJkLWhPgDwt5i32LknDyyqqj9Ief7uF5?=
 =?iso-8859-1?Q?kC7q7uhxDzwAn0d0Ih75xV5jRv9zscevYD1H2Bi4FNIYPPvtK8mLtI4yQg?=
 =?iso-8859-1?Q?9vZ/DeLcjYKOgF7Fix+wyT+l7Vq9FD+CThqfhTaohaq4MHrD0WnFiB1Lnt?=
 =?iso-8859-1?Q?Rxg7bE5UPBLHLSimWcNWjGeAb+1ap9RPydPq03sUCOK6hUa5JlW48GG3PT?=
 =?iso-8859-1?Q?stmUqS3D+lQzzHiKT6ZN8qVedaQJ7lLaDziT1pCIDsfQ2/xfj8z5N/q2NI?=
 =?iso-8859-1?Q?BCR4Tkw4tCIiNbjzP8usmN57Wnf2l3dZvYWnfWYrTeyLPPuDjJeJ17iTZw?=
 =?iso-8859-1?Q?UAwT8UlPLF/o0Zuu60oOU5fzaqFJElirO1Sp3XxVpZ9aogL1wXt18lMS+x?=
 =?iso-8859-1?Q?6C0MyCk0fhwbw=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: cisco.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3527.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d001bde-625f-46c4-e1ac-08dc1e179b07
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jan 2024 02:36:31.3211
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5ae1af62-9505-4097-a69a-c1553ef7840e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: csmddjmEAkdRH3TNJXP5Cku/Rai+gRPPnrJl/Cr3Xh8FeY1/b/6XL3ptSbtjz5YzcfQ03aQnxErFo0I4E477wA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5228
X-Outbound-SMTP-Client: 72.163.7.165, rcdn-opgw-4.cisco.com
X-Outbound-Node: rcdn-core-5.cisco.com

In security/integrity/digsig_asymmetric.c function request_asymmetric_key, =
should we not do a key_ref_put() when the key is found in the ima_blacklist=
_keyring?=A0I'm working with 6.6.9 kernel but have verified it is the same =
logic in linux-stable master branch (top of tree is ecb1b8288dc7ccbdcb3b9df=
005fa1c0e0c0388a7)=0A=
=A0=0A=
I'm new to this area of code however, so I may misunderstand it.  This is w=
hat I'm thinking is needed.  =0A=
=0A=
diff --git a/security/integrity/digsig_asymmetric.c b/security/integrity/di=
gsig_asymmetric.c=0A=
index 895f4b9ce8c6..b969cd56e9ef 100644=0A=
--- a/security/integrity/digsig_asymmetric.c=0A=
+++ b/security/integrity/digsig_asymmetric.c=0A=
@@ -35,6 +35,7 @@ static struct key *request_asymmetric_key(struct key *key=
ring, uint32_t keyid)=0A=
                kref =3D keyring_search(make_key_ref(key, 1),=0A=
                                      &key_type_asymmetric, name, true);=0A=
                if (!IS_ERR(kref)) {=0A=
+                       key_ref_put(kref);=0A=
                        pr_err("Key '%s' is in ima_blacklist_keyring\n", na=
me);=0A=
                        return ERR_PTR(-EKEYREJECTED);=0A=
                }=0A=
=0A=

