Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B34CE692A51
	for <lists+linux-integrity@lfdr.de>; Fri, 10 Feb 2023 23:40:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233589AbjBJWj4 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 10 Feb 2023 17:39:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233348AbjBJWjz (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 10 Feb 2023 17:39:55 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1882471F25;
        Fri, 10 Feb 2023 14:39:55 -0800 (PST)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31AHwiai005567;
        Fri, 10 Feb 2023 22:39:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=g31F+4HsFNwYPusYvfMyZUnVe5d9KtzzXW7XRRDdJP8=;
 b=o+wh31pllC0rVeGr2wNHEf3gYh43qe/7nlTEX/xZ0oelgy6+qvwj8VOD3JosZjlqMyzH
 DwF8leMbB6vD8lwAh5ijYCwYO6ax/bsmCStOV1LIVq/2hDKl5u5Czu7CCcZZ7aF+STef
 tPt8BNpIbQ4GUFOQygpXFEtY4H4Rhb4R5rgOeTRSfPjFGvU8+NOxmnIul6yAEKPAoysC
 JSPOrjVZb+JrMSXha5C91ZYOdOon2x9/PIx/cWAH5qMk+UR9vTDrlv90qoIhAi8oqdNH
 SFYJb+QDhWR0Z2kGWNf5Ocswcr9obGIFxF4a/b1VyhqYxxFKQPnmDzdIKeWi6Kk4pIw6 Bw== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3nhe53pe0c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 10 Feb 2023 22:39:37 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 31AKxKW5015189;
        Fri, 10 Feb 2023 22:39:36 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2177.outbound.protection.outlook.com [104.47.59.177])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3njrbfcxsk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 10 Feb 2023 22:39:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CRkSG61QIuN8eksfiOeDdADqmvAhrHAnbeGpN/Q536V7gWm89g0rh5+9H/0lenoC8cE3RbPpyUkGjh4B7d9fOvygwbXwNET6Z4uwnw0pGkTctNzjNRuG8Iuj2X8e6BEKYZlQ0y2G1SH2rSfeDyA4/Ya6YE4YP9g8zsnzzFGV7SnYtQtG6CZ/U26sAWjN2pSP+DRgxSnUw68NMgu7qhbyNvEtVpEFxkYn3qChEdkp0AL7dcZlQWH5Q2BNJl1AK96+cNL6JNQw0QZD6yYzBu3iZH0qF9aubfx7MTlsl6em+jaJjXNraVgYpPtjms/snaIaAUf2T3CjILeYQSvsi7C6hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g31F+4HsFNwYPusYvfMyZUnVe5d9KtzzXW7XRRDdJP8=;
 b=oWUhr+6hjvuYvqnTStEdZjd4YppBm8eJYr2LvCh9R7J4YM54+zP5gd4pzEotlYt33iQ4YI1OPpd50dguxIPp6vBI1/JB3j1YSPm9WCzXsbCmLTcBWEXg/CVv8n1QS7aBPNWYpNqgTHYfWJpF8YlLMbNu1avl3eUijlLsOaRf8DjBOI752AH3velo9o3xOFqt68soLl/ql0HVMmHldB+BVU63IOSy/5CFMwjD+QqkOAZ6OQHtcQrZBfv08R0Dt5R+09RIkk5T9NKoLlvhaKeH9w30MlnvGznWdV/qL3k263yfGBPgvo1HbiEY4ulskJt0z6+PVT9BhNfdHBf1Cfukww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g31F+4HsFNwYPusYvfMyZUnVe5d9KtzzXW7XRRDdJP8=;
 b=ERU2+HqsZ2DcUMdoSjsYd6Unwd8bBlRosKMF9cVJWkJwzv/PNzV9c5stVqCOqM/wEgjQskdcn3yBeoIzIhMYt6r0F94bTHmPyNwZsUmZMowtUKbtRskAA0l/F4hgbvpP8/ly9HRNYRqMNjDKyk/IKjlmzjBQs7AzJS8K4zRTI7A=
Received: from CH2PR10MB4150.namprd10.prod.outlook.com (2603:10b6:610:ac::13)
 by IA0PR10MB6746.namprd10.prod.outlook.com (2603:10b6:208:43e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.15; Fri, 10 Feb
 2023 22:39:33 +0000
Received: from CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::a326:1794:402f:1adb]) by CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::a326:1794:402f:1adb%3]) with mapi id 15.20.6111.006; Fri, 10 Feb 2023
 22:39:33 +0000
From:   Eric Snowberg <eric.snowberg@oracle.com>
To:     Jarkko Sakkinen <jarkko@kernel.org>
CC:     Mimi Zohar <zohar@linux.ibm.com>,
        David Howells <dhowells@redhat.com>,
        David Woodhouse <dwmw2@infradead.org>,
        "herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "dmitry.kasatkin@gmail.com" <dmitry.kasatkin@gmail.com>,
        "paul@paul-moore.com" <paul@paul-moore.com>,
        "jmorris@namei.org" <jmorris@namei.org>,
        "serge@hallyn.com" <serge@hallyn.com>,
        "pvorel@suse.cz" <pvorel@suse.cz>,
        "tadeusz.struk@intel.com" <tadeusz.struk@intel.com>,
        Kanth Ghatraju <kanth.ghatraju@oracle.com>,
        Konrad Wilk <konrad.wilk@oracle.com>,
        "erpalmer@linux.vnet.ibm.com" <erpalmer@linux.vnet.ibm.com>,
        "coxu@redhat.com" <coxu@redhat.com>,
        "keyrings@vger.kernel.org" <keyrings@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>
Subject: Re: [PATCH v4 4/6] KEYS: X.509: Parse Key Usage
Thread-Topic: [PATCH v4 4/6] KEYS: X.509: Parse Key Usage
Thread-Index: AQHZOqBGePNjIHDDnk6LYMBec21YRa7Hj8UAgAE8EAA=
Date:   Fri, 10 Feb 2023 22:39:33 +0000
Message-ID: <BAE02BFF-FDC9-4168-BB78-484DC0D6FE78@oracle.com>
References: <20230207025958.974056-1-eric.snowberg@oracle.com>
 <20230207025958.974056-5-eric.snowberg@oracle.com>
 <Y+W+glb35hn9AS7H@kernel.org>
In-Reply-To: <Y+W+glb35hn9AS7H@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH2PR10MB4150:EE_|IA0PR10MB6746:EE_
x-ms-office365-filtering-correlation-id: ae378c8f-9cb1-4db4-f49f-08db0bb7ae30
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VT/tIBB4rVwwZTDW4GWb43RPdjkzWhBSzhE1D6lDJj9L7nXPCMKShmWpqHtR7zu13BYsRWion79XFZvhKYFqxeE7grNV3mTrf1xnWc3C5vjGktGnigZN+VwQPFwwkEvy5Ezk2kt7KuFphbCADOEHG3+lveNN3Y+6HdQ9g1ewqPz1wLKA5IKXwtOnF2me9XFtUdFVEBiLinCqRL6NSvfGj0qMXdH4LKhp24qqh/IeWoIEbhZdt8aqiNgRwnre8OgjWS6wVQ30zvRhsnSIb0r3nuV1sb/XyDAfI3iPYGv1Fp3ABRU5xxM/QXRZjP6c16rcGKyWZIOvvpfIEGyimkPYofYDVvjNcgbcXBuoRapKmluPOASS8lPTI3OnG4Bi+p+Aw33iaBQxc3Eb4F15Uxt7SrFdGb2n62c7WpEbbNNBca4uiYD/G+wwF0KMw7oPZQZij7sNPVjrbai1l6N/KicTS+heZ+VD7vH/B9r4aZLrT/0nbdwiJwoRwAAA6dSF3xvrfmi6apAJrO0ejv5zMQFx/6b003hHUmsN+7YdwvZbue17ygFISiIE6BTMj1hsiIKNdPzRIcH4AjpvcYDTHwl9TLxWWfbXPfjwhp/5qqJZLZjbz6WerD2OuJwOdlMvtmGQGDWOC8jhKE+wKLRoyJTGLWldV+xIG3BHHrgqIy1mtrwDLpRlx2lONzY6JkInwdc+PVjHb9/PmEz51fLqWC02TG7BepATlJxHClD5H4LXPHE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4150.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(346002)(396003)(376002)(136003)(366004)(39860400002)(451199018)(66946007)(6486002)(26005)(186003)(6506007)(6512007)(66476007)(66446008)(53546011)(71200400001)(478600001)(2616005)(91956017)(5660300002)(38100700002)(7416002)(54906003)(8676002)(64756008)(4326008)(76116006)(66556008)(36756003)(41300700001)(6916009)(4744005)(33656002)(122000001)(86362001)(44832011)(8936002)(38070700005)(316002)(2906002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MkpUU2hXUE9WY0FVL1pPd2VtcERTbXRaemsyK0d3UGJ4bFJ1d0t1S2l1ejd4?=
 =?utf-8?B?V2Y0cmZsdzNpWEVVSEpFRnEra1hLNXZuVHk3b2k2d0dINjBrTmJ0Mll1eU95?=
 =?utf-8?B?N2xiUEV4aExEcGEvb1J2aTM0ZTMrN1lqSmpqZlhMZTRGeWdzeUFXQ1FnK0RB?=
 =?utf-8?B?SVgvZGVLTjJPVWNwenVHd3crQmdhMmpKemsxUUFVcHE0VUhsTkJTTklBV24r?=
 =?utf-8?B?RDV6Z3lwZ1dmWTQvMzY3T1JOWFd2QmJTUGYrVVJSRTgyMWo4b244NlpsYmN2?=
 =?utf-8?B?Tm91cnVXYit0WEdMaVdXRVVlRXk4elM4cEJ5NGFaTnBNZzV4dmFzQ3N1OGpC?=
 =?utf-8?B?UmxkMjVCRUNodzhnY1d4UE51NHRlZHY1SVBTR2xkcVJMb2Y1cW54SGU2Mkdl?=
 =?utf-8?B?QjkweVFBaXFNZGlBVXlJa1VSK0xLMnl6bVJZSFZwR1hyUmVsZ0lvMzh3NGhj?=
 =?utf-8?B?cmprMnRWMGVrUUs3LzZnWUxTcytQUC9McG1hSUxoZWtXVWNmbDlaY2tSMWt1?=
 =?utf-8?B?a1g5ZWVLZkJWZTBQdXpxelQvM3FYWFNuczlxYWpqWkdaamRLaGt4bUp0NkpS?=
 =?utf-8?B?dzhUNXZuSDl0dmttYnNud2hlemtGRVFhMWY0U2U4MHI4MGNJSVJyQ3Nrb2Nt?=
 =?utf-8?B?U3lmcGxFWVBWMndNaTVsOHlFR1FqYzFvbWsvdGNFNmNaWjRHN1JxdHNKMWo0?=
 =?utf-8?B?dmJ2aWhTMUV4WWl6SDNPSmZybFU0aFlVRG9ia0w2VzNTMTVVNWcvL3o2N3B2?=
 =?utf-8?B?aERweWR2OWdiMEluT1NCYjlVQmdqYnQ5T2kvMUtWSGhXS25zU2xsSGh2VEZU?=
 =?utf-8?B?bCtoc2t1M0ppeTFpMlVqQW1sU0gyNStJUVpPWVovZ0RFUEo5eGNqVmpEVlJB?=
 =?utf-8?B?SlczcE1IbWRMT0JSQjNNblRPWmsrVG5MUE5keDJqZ25QcnJhNDg3dHE4akxW?=
 =?utf-8?B?VENIakd2THBXYkt6KzdUbGozSGpJWU54VGx4bS9TcE5QOExKQTk0NDh3bWI0?=
 =?utf-8?B?bm1sRjN0VjBiWEVScEdxd1Y4ekFTYXBPKzVJNlJkRDY1OEdvTVB6ZXRhQkNy?=
 =?utf-8?B?V1hma3dpNXA3cllEUHNwSnAvZ1A2dk9oTzk1VytzNzNtTllTaXRXeWJIQjNo?=
 =?utf-8?B?U2FEenVLK1dpNVVDY2pFZGFZaUlCYk12NU5FQXV2dEpnYlE3S2FtaDY4S05Y?=
 =?utf-8?B?ZUphbERHR3hWOGRML29xM1ZSRHlKbnUxWXdHVUNxUXl5RHlBS2QrMEsvRWsx?=
 =?utf-8?B?eDQ2WGZZeXUxVkVGYy8rRXRidFd4RG1sanYzaEZjU21UOE1zZ0E5eWxaY3Vn?=
 =?utf-8?B?M1VGWVl4SjJqcE5lNDF3dVNlSi9SR3lNbDl6RkhKV3lxVEJEZ0g3T0p6OXVS?=
 =?utf-8?B?dlV0VmpSMDAvVXZ5emRUby9PY0ZadlZyUFNWVnJRNDBhNlJ4WDB2ZlphU0cw?=
 =?utf-8?B?ZitEU1VOR0hrNkE3aHRBVGtDVi92OXRUWmkwMGI4R0FzM21SemNNOGU5ejJK?=
 =?utf-8?B?eWN2Z21OcC81OEM4N09HRUJMVk1qRjBscjRSWW1YMVVnOE1iUk9UYVByT3Er?=
 =?utf-8?B?OEFXUG9MSXpZUGF6Z2E2STJsMW84SzlOLzg1alFIVVNDODRRdkFQMlhJdHRH?=
 =?utf-8?B?aGI1blhST3hiRE1HcE9qQXdMRDc0a3hpL1FiL3I1OUZQUGNsN2QwcDJDQWpD?=
 =?utf-8?B?VnQ0MVMrT2RtdUYwMDk4Zm1Qa0ZBNEVISTFZYWsrNkZHSFpqNDk5Q0FxaFJi?=
 =?utf-8?B?ZHJ4MnRnTWZmLy9aMjROVWdiN0pZQzJhTmNtK0laczBLYTJxUFVRY0t1MUZN?=
 =?utf-8?B?Lzl6TEVBZnBXRFZIY2RxSGJWMlVaZys3K1VjTHlXV3RkOWVqSzducXQ0Wk10?=
 =?utf-8?B?ckg2SzljeFg1YzYzZ0NlenVsNTBkb1M5Skpna0JTQ3RjcjBsNDJVeGVLc2V1?=
 =?utf-8?B?dmIrdE51SE5odW1rcnYrazVkZlRTa1pSU2RtWWVuaE9BTVFMa2tBbEN4MDIw?=
 =?utf-8?B?KzVKSFBWTTJZM25tYzYyZjNjWHNJbE5OYVRkYUpQbkFmWlRCekkycnhGR2l1?=
 =?utf-8?B?d05aQWd0SThQS1JXNEltYUNmbEJOdFFjYlRZRGc2OW55T3BMdzZZUjlGTFVJ?=
 =?utf-8?B?aC9JTENST3Fka0duRXlWS0t3K3pnSnpYYmtjVWNLbXFYVEhIMHVLNHVKYmg5?=
 =?utf-8?B?cGc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <650244F978452345AFACC467A82508F2@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?TkVYVFJ4bUZydDRXRU5IZzBmYXIxQWpCMVQ4cHhpOFloOHpBUG9oK2gzdHdF?=
 =?utf-8?B?V0NwUFBNeVhKbHVGYkVjbTBCdEYyaXBkQ2piSFZmY0hrNlBITktpYmNOTmFr?=
 =?utf-8?B?OWN3dW9EcUd3eDZ6VmhMSFhvRVVaMEJzRVNnQ1lNZ05WdTBVLzRlQ3lmTE9v?=
 =?utf-8?B?OUFXelE3cjRndGNML29xZ1dQNjh1NnRlOHhzWmJOTXRkRjE5Unl5ck5NV25x?=
 =?utf-8?B?bzBzaE13RUcrUzhGbWdaMldCaWdxSDVQZnJYY1U4ejMwaGQxR01LQUJFeDBz?=
 =?utf-8?B?eUxaanI0ZG5nMTNyQjdaZjBNc2VHaXQrQkF6UjJmKytlOC9La0hya0ZqRWxQ?=
 =?utf-8?B?cmo4YnV5Q1Q1MVhvUjMvNnFBYXZocElFTlg0d0RmZXhQa0JzQnJ5Z2NrREph?=
 =?utf-8?B?QklrTWY5OHo5eCtoWVNJektWUXhrMnZJaEdKQjVEQ0MyNFZrTGxvN3p2eERC?=
 =?utf-8?B?ejlpTk1jYXlyNTNxR1pHTEdYREorMTE5QzNRc056R0VpYjJTaXdaY0tOY3gy?=
 =?utf-8?B?V3NqdExOa2hDZXBHekF3Ymx2bkhPSkdtS3BETDQ1Qzd5S2F3bFV1UVZFWUxL?=
 =?utf-8?B?dG83YlhGWnp3SVE4eDZUVU53Vk51Vmx1UFBCZm40cFgzNXliRHRHOFhXL2J5?=
 =?utf-8?B?TXJCN3MwVW1KT1lieVpXN0RQY0lRd0oyUHFEQmpCUjBZYjlraHJtTUJIVGxI?=
 =?utf-8?B?VXdlUzZMYXNjZzNkMEZoczhIeFMyZEIwRXJBcnJwM1BnZnZ3K1FyWS9pelk0?=
 =?utf-8?B?aC81NVdFK1NTRVBiaHBSeFdxZXcvblBHUFF0THRPeHhHaXlVcXRqVVhZMUMw?=
 =?utf-8?B?ejRNV3RmTzJ6VzR0bnB2V3p2WS9SMDVlVWVSNWNMUm5DOGY5Y3pFem9tdEhr?=
 =?utf-8?B?Tmg1WE5iWTZJOUJTVkNQRy8xR2c5aldDS0U1TVBjTldCWjZ6NkdYN0hUYjRQ?=
 =?utf-8?B?R0R1OEFMeVhINW1TK0tPWnJOb2dhZEVJWVhkd0dMRXN4dkU2Qis0bGE3N1V3?=
 =?utf-8?B?RnBFdUFzQWE1UTQ3ZkhrZmpobk9VSTczbk4vUjQvb0lBaGFIckxZYVZ0a2pj?=
 =?utf-8?B?b2Q5OUMybHFHZzJ1VXBNdWFockpaUmN3OTlWdjNHUW5kc1FmbXZsTjVmV2FT?=
 =?utf-8?B?aXkyVGY2akJjTDYvbHRqcS85ekxqVWJkcHhKL0thV3V2VlU4ZXRXbXpnTzQ0?=
 =?utf-8?B?WHFjWTBjbEIrMlowSHlvRVlZNlNyMmdvSUxXVkd5bHlVak5PaVU5QlJSYkZl?=
 =?utf-8?B?R3pyUkdjQ2dndTh1eGkvTjdYOVRVa01NckkybkpQdVJ5UlExSUlDdjZ1V0ZB?=
 =?utf-8?B?bEY3ZWxhN01WdEYyamgyK0RHWWwzRWpFbVYrWjc2YkNQZ1BpLzFmUDROTldr?=
 =?utf-8?B?R1MrL1k5bFJ1TGE2NmwydnQ5MnAxVGc5SDJMaUZMYXFQWEsvcHVNalB4Yndl?=
 =?utf-8?B?TU9hbUorSG5kUnloSWl6RHBmRmtDcXpEb3FubEt3OUsrRlNsZnluMkFYZEk1?=
 =?utf-8?B?RTlHbGJlSmZwRXBrczFiR2ZXRnR1cjdmVjNMdktESmxTQTN5WFZyaThwb1Ex?=
 =?utf-8?B?QlBRM1lRSTNWUmlienYyMFZNelZrVHVma3M0b21tclBselFZdndFbmEyNExJ?=
 =?utf-8?B?NFB2UGM4c0wvTWNQcHdxK29oaXpPd1E9PQ==?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4150.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae378c8f-9cb1-4db4-f49f-08db0bb7ae30
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Feb 2023 22:39:33.1796
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HiwI8iuB8yBErP8HfwwCLL7jp1xEt4K+aSQXMvi+46aMHrUdtqwgXMKvJ0jgep1KXrtYYR2fAVI8kfjWchRjsLHOyANPfgu36KIsodteMHQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB6746
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-10_15,2023-02-09_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0 spamscore=0
 malwarescore=0 suspectscore=0 mlxscore=0 mlxlogscore=866 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2302100194
X-Proofpoint-ORIG-GUID: a0FtKv_Y1PmrBc5k1gx07J4J2ggouZAx
X-Proofpoint-GUID: a0FtKv_Y1PmrBc5k1gx07J4J2ggouZAx
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

DQoNCj4gT24gRmViIDksIDIwMjMsIGF0IDg6NDggUE0sIEphcmtrbyBTYWtraW5lbiA8amFya2tv
QGtlcm5lbC5vcmc+IHdyb3RlOg0KPiANCj4gT24gTW9uLCBGZWIgMDYsIDIwMjMgYXQgMDk6NTk6
NTZQTSAtMDUwMCwgRXJpYyBTbm93YmVyZyB3cm90ZToNCj4+IFBhcnNlIHRoZSBYLjUwOSBLZXkg
VXNhZ2UuICBUaGUga2V5IHVzYWdlIGV4dGVuc2lvbiBkZWZpbmVzIHRoZSBwdXJwb3NlIG9mDQo+
PiB0aGUga2V5IGNvbnRhaW5lZCBpbiB0aGUgY2VydGlmaWNhdGUuDQo+PiANCj4+ICAgaWQtY2Ut
a2V5VXNhZ2UgT0JKRUNUIElERU5USUZJRVIgOjo9ICB7IGlkLWNlIDE1IH0NCj4+IA0KPj4gICAg
ICBLZXlVc2FnZSA6Oj0gQklUIFNUUklORyB7DQo+PiAgICAgICAgICAgZGlnaXRhbFNpZ25hdHVy
ZSAgICAgICAgKDApLA0KPj4gICAgICAgICAgIGNvbnRlbnRDb21taXRtZW50ICAgICAgICgxKSwN
Cj4+ICAgICAgICAgICBrZXlFbmNpcGhlcm1lbnQgICAgICAgICAoMiksDQo+PiAgICAgICAgICAg
ZGF0YUVuY2lwaGVybWVudCAgICAgICAgKDMpLA0KPj4gICAgICAgICAgIGtleUFncmVlbWVudCAg
ICAgICAgICAgICg0KSwNCj4+ICAgICAgICAgICBrZXlDZXJ0U2lnbiAgICAgICAgICAgICAoNSks
DQo+PiAgICAgICAgICAgY1JMU2lnbiAgICAgICAgICAgICAgICAgKDYpLA0KPj4gICAgICAgICAg
IGVuY2lwaGVyT25seSAgICAgICAgICAgICg3KSwNCj4+ICAgICAgICAgICBkZWNpcGhlck9ubHkg
ICAgICAgICAgICAoOCkgfQ0KPj4gDQo+PiBJZiB0aGUga2V5Q2VydFNpZ24gb3IgZGlnaXRhbFNp
Z25hdHVyZSBpcyBzZXQsIHN0b3JlIGl0IGluIHRoZQ0KPj4gcHVibGljX2tleSBzdHJ1Y3R1cmUu
ICBUaGlzIHdpbGwgYmUgdXNlZCBpbiBhIGZvbGxvdyBvbiBwYXRjaCB0aGF0DQo+PiByZXF1aXJl
cyBrbm93aW5nIHRoZSBjZXJ0aWZpY2F0ZSBrZXkgdXNhZ2UgdHlwZS4NCj4gDQo+IEl0IHdvdWxk
IGJlIGJldHRlciB0byBzaG9ydGx5IGV4cGxhaW4gd2h5IHdlIHdhbnQgdG8ga25vdyBrZXkgdXNh
Z2UNCj4gdHlwZSwgcmF0aGVyIHRoYW4gZ2l2ZSB6ZXJvIGluZm9ybWF0aW9uIHdpdGggImZvbGxv
dyBvbiBwYXRjaOKAnS4NCg0KT2ssIEkgd2lsbCBhZGQgdGhpcyBpbiB0aGUgbmV4dCByb3VuZCwg
dGhhbmtzLg0KDQoNCg==
