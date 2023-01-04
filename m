Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 777F565DD83
	for <lists+linux-integrity@lfdr.de>; Wed,  4 Jan 2023 21:15:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240292AbjADUPm (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 4 Jan 2023 15:15:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240265AbjADUPQ (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 4 Jan 2023 15:15:16 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B392F41003;
        Wed,  4 Jan 2023 12:15:06 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 304FO9Ki000340;
        Wed, 4 Jan 2023 20:14:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=UQw86O5C3sU0Yn6lZwulPLD1wlLdYT0O+zMWOE7+MEs=;
 b=CxOIK7er6WEA7ZO/hV1bsP07/xvZ6ujBWESePkiPKgS40DqqwVjDmfUFsIdoIRN9Kf7S
 JF4qQAMu2q/7DrSQykJ4qYxDRoXJFHvr5ZebM+dLxM7HvIwDIUwqjYFvb9lFfyZkUMTV
 CeeO2qS7viLqhjbR/wzrM1JGItAs/tljLkDQn0m+AbNiFi2v9+vSssBoJf5i71FLOnM3
 0/44EghyWFnCvRvzYtmVgB+HSazr6iWYSZOlT+IA1ayOkinbO5Q+bnvk9UZta1kQ0km4
 lLzuW2076qzvpmfqiIdLnumhBRCmCIQB9YRAJwuh3Qnb7uzit9c6NSJHvVbnvzETpsC5 Ew== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3mtbgqqfav-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 04 Jan 2023 20:14:27 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 304IUM1f006588;
        Wed, 4 Jan 2023 20:14:26 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2048.outbound.protection.outlook.com [104.47.57.48])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3mwdeyfy6u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 04 Jan 2023 20:14:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b4Sx9zUDN5yuGdGkFOw8oD/VDePpj9Hc8csA82M/0N898zsyjfOdENyXGt3VX/uSmHHMcy4ETjnCnwWOWkW5FhEeOOnNJn6nJXzbsfyr+0s0YVxiYMwZspV3dKbFKEndBvEV+Hs2xr0WPzpHppP5fMyNlSEoTtLNurN8ylm6T4gMyuiva2YQq4pNtjF3sMeEV0T4Pwo9UmqYUT2Qfw/JLq2u03LbP9gokPPc5LUK04D0H2XQm9vdM7eCpdXSgLCxSNYkTyXM/EGzNw1cwvFNzWmjpyyhYC3PnEnZOczFxufJVBlpnvwBptbQxgMYsRIWqpoAvzSM135pY0e4uStt0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UQw86O5C3sU0Yn6lZwulPLD1wlLdYT0O+zMWOE7+MEs=;
 b=Kr9uaQPZqBfHo5SYO4yoxMYKnx7RYj6N7cpkLlSRarfMibJIvnTAQMzUQY4aMq7O2uiy1N6ca6jLSVCfvKEnYuVNl9T2+Yy9JkLuyS8SkiLUPw7ORnDeECXDQVuTH8KrOlITeVxB+R9zphzkgL6wY8/3OxPSJAVMxIpxPmGns3WhvwKigarubKuFI/UP5zcP3HaB32YuN9LG2pF5uKdzRG982MBn7tHVLZKvgqlhKf6PaoezuyKlon91Wozg1l0WNk6F5eeGyZucJwviyiVpSQvaqW7bau6I4J9pT5oe1uhAKN8waif5rEvS0bogX5eut/r3u4IIesnwL3b/Zyq5Lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UQw86O5C3sU0Yn6lZwulPLD1wlLdYT0O+zMWOE7+MEs=;
 b=ejJbez/p0DsNFPznqeFk6wU4JsFCR7KQZ5NCjo4lfw8pTZJjPsEYcGpqIwz6a2vL+CaW712ZlrVtO7l+wOEW3z7EASfuYGkaPFuc8w8YpUbiY4TmDqNKTLdcKKg7XkCPyZDhNF5jEDZSQhKmVKg1k0ORx91hZlfb2/3PHHVzI6E=
Received: from CH2PR10MB4150.namprd10.prod.outlook.com (2603:10b6:610:ac::13)
 by MW4PR10MB6321.namprd10.prod.outlook.com (2603:10b6:303:1e1::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Wed, 4 Jan
 2023 20:14:24 +0000
Received: from CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::f006:f411:9056:63a4]) by CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::f006:f411:9056:63a4%4]) with mapi id 15.20.5944.019; Wed, 4 Jan 2023
 20:14:24 +0000
From:   Eric Snowberg <eric.snowberg@oracle.com>
To:     Jarkko Sakkinen <jarkko@kernel.org>,
        Mimi Zohar <zohar@linux.ibm.com>
CC:     David Howells <dhowells@redhat.com>,
        David Woodhouse <dwmw2@infradead.org>,
        "herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "dmitry.kasatkin@gmail.com" <dmitry.kasatkin@gmail.com>,
        "paul@paul-moore.com" <paul@paul-moore.com>,
        "jmorris@namei.org" <jmorris@namei.org>,
        "serge@hallyn.com" <serge@hallyn.com>,
        "pvorel@suse.cz" <pvorel@suse.cz>,
        "noodles@fb.com" <noodles@fb.com>, "tiwai@suse.de" <tiwai@suse.de>,
        Kanth Ghatraju <kanth.ghatraju@oracle.com>,
        Konrad Wilk <konrad.wilk@oracle.com>,
        Elaine Palmer <erpalmer@linux.vnet.ibm.com>,
        Coiby Xu <coxu@redhat.com>,
        "keyrings@vger.kernel.org" <keyrings@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>
Subject: Re: [PATCH v3 03/10] KEYS: X.509: Parse Basic Constraints for CA
Thread-Topic: [PATCH v3 03/10] KEYS: X.509: Parse Basic Constraints for CA
Thread-Index: AQHZD1PFtzvXeG8h6ESgINuyeo8m365uzOgAgB+EsQCAAIIEgA==
Date:   Wed, 4 Jan 2023 20:14:24 +0000
Message-ID: <5F14DD59-7139-427E-A263-D5DED6EB57F8@oracle.com>
References: <20221214003401.4086781-1-eric.snowberg@oracle.com>
 <20221214003401.4086781-4-eric.snowberg@oracle.com>
 <b0f29738b919e2705d770017f2f1eb0542c2fad4.camel@linux.ibm.com>
 <Y7VxDloaHyF8cX5j@kernel.org>
In-Reply-To: <Y7VxDloaHyF8cX5j@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH2PR10MB4150:EE_|MW4PR10MB6321:EE_
x-ms-office365-filtering-correlation-id: dee4bffb-bf90-44ad-5bde-08daee9045ef
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Cadbitusg75IKT4NdttGnEowvSMMYddWRwJiJI6Ki6kGO/VfAPRFR6s3/8IDi8B7YQb/mIxDF9sRzILUfWcfFYdIIgl6EXJn01dWMNdRjwZSLlcfqiubrDq2skVQfQsLR9rk/xU4E6F52+Ce13mV88xyxxnGcpk+cnpzhCun8kRCd5GQlaVcKeqWddhZwfE91pgLroGCITTixiWbTBt1PAA4gWDczmFJrdHGhtfFD1ey650zuPTmwKCrbuIGi5AGQOZte6QXIzOZOS0kleAxWa/vBcUF4ycqXH2KDriqdSHYIsdkl33WuVGd53051XgsAjSM9Yj0IOnShj3sD3N6EmUSA7kFgmLT+/OhHpVG6k5Kz1tm6K1afp66uve3jtQbT1WQjpyWPmOsSoz5RBPRm/VvnMMzYTSZikNCieWrMDtduLfeL8pi3ziKeQrHmfaPDgRLgsM6W1nCHEO0khc5FODTsw9c4olh+O+mxhB6knTAJOGdTEZnQxAe4jfR/OyOaIlBfeDZwCDIrwsUxGDvuan6e8vMuAz/3lt25Zs/8IfkMngCNZpWMl7lVn8SKFgxgncvD3WBquX7S+HFXqMB0iVVCqRK5dIsyLXWPOj0ccrfKKooCDel4aG4PNAyze0/y03ThHvwfflTMgSH9k+hxYZtA84egZxriFHAbApYO9lUvus2TmwrS0PZqZA3mJYvMX9S4cdEnXvK8cNtlbvldzSeV7oRi4baYqOf1Jidimbs/0r0GE9KO8tq0fS3A/a80xTvWIWMQFbztaeM7o35bg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4150.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(366004)(396003)(376002)(346002)(39860400002)(451199015)(6506007)(53546011)(36756003)(71200400001)(110136005)(478600001)(86362001)(38070700005)(38100700002)(122000001)(6512007)(186003)(33656002)(2616005)(6486002)(966005)(91956017)(4744005)(76116006)(44832011)(5660300002)(7416002)(64756008)(66556008)(8676002)(66446008)(66946007)(66476007)(8936002)(4326008)(41300700001)(2906002)(316002)(54906003)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TEYwdFNZNHNFcnRBelIzNURQWUszSzhKc0RVNURyWDVLMEpBem1ZN2l1dEJu?=
 =?utf-8?B?Vkw1czJwU1JRRU9CWkwwMUduWDRsMHlGNnNWeFhsaDVQOFI5NUkrVFZsaFcw?=
 =?utf-8?B?NjA4eU9kYkhuK0FUODI5ZDhjTmk2anhPQ3I5eUY3bkNublArZ2lpZlVDRTJN?=
 =?utf-8?B?OHNkNVBUaC9yaDFHRnh6ZkM5U0taaG5xMnd0OFVOdWRnYW9VUnhobjVqSE9T?=
 =?utf-8?B?WUNORnI2UThnMnF5YXVQYVZQbnQzNk1idjB3UDVMZ1JaZUxKRG5NRTU5NHRi?=
 =?utf-8?B?RHkvK0FSUWxOUG01Umo3dklZSXF2VzZFZDByamg0WThnOTJVYVh0dGxMTUtP?=
 =?utf-8?B?SWg4Tno1SElNSlNqQzhnOHl2OUJIdzNYdExUeUEwQlp4Y1RJTnBPcC9uZURU?=
 =?utf-8?B?aDhhWVN1SjQ4ZXpLTGcvYWdPYWV4Qm04VG14d29XTWxHbE9xbEdDRlRDaDRL?=
 =?utf-8?B?SWd5NjJNVWJYbnVnck8wcTRkdFNmYUhGMUg1NUNXYk5qODNGNVB1cTBGMVNX?=
 =?utf-8?B?QXE1K283M1dlVlJKZ2dkSnFwekJHLzVJclNuS09zUjF5T2ZxNGdDTStnOEhN?=
 =?utf-8?B?N3JyZnRpNmpySStJY3NubmduaTRDWkxueStUQVZ2R0EvbERzcGo3Si9xSVF6?=
 =?utf-8?B?dE10dUUzalRFL0FrMDUzaDJmRGxRcHJPdHJKWkpkTmFQbHEweU9lTnFSRHdR?=
 =?utf-8?B?QS8rZzQySGdpVFpHMG0vUk9idGhhLzBVTjd1d2xxRkxxT3BwTmNZYUNpUkdO?=
 =?utf-8?B?QjVldUdvVCtRQng3Zktacm51VmZpdG9BQjI4cVNGUlVXWm1CVHhtSjNKSFpN?=
 =?utf-8?B?RE1BM1JlR2VQamFMcXkrY084ZGV1TFdQc2xmNE11TWFRWkNsU3VFRzlBTGZq?=
 =?utf-8?B?T2xlbVRCMzhEUWVrTURLY2dGNzVWZWovWDh3TmtRY09ySC8zcEFjYmo3Q1FX?=
 =?utf-8?B?dE5LWU5IWkw4ZHp4S3N1U0dycnhtRk02ZmVzNDhHa3o2VVdtVUUxRTlKSU45?=
 =?utf-8?B?R3FwY0IveDNSZWRvU1VJYTV0MFYwNTJmZmtWVk0yZUUvcXlKSjkvL3NSbmU2?=
 =?utf-8?B?cklvbmdwaFNGUnNlMy9FVXRFQ3RKZnRQMjZ4eFpwazE2RTlheW5nYUNCY255?=
 =?utf-8?B?MDZLR0lrOWdQbVZ3Yjc5Z1AwcVpUMWVNNWVVVGdiamxKT3FQYVNVc2pVL2R2?=
 =?utf-8?B?cmNibUpJTUZ2bFlzN1hZS1pXelNvYzBtbjg1MWxtUVNmUXMwcklVQW5mK1lu?=
 =?utf-8?B?ZzhkUjB0Q2lKMXdrUVJFQ21kbVFQbURlajNieHp5RWVDRUtCMWRSK1NFa2Nl?=
 =?utf-8?B?UWZqdGtYYUZscS9ZTG8yMElWNU8vVVlLdjRFSU9VUURnSEx2MllLM2ZmODhE?=
 =?utf-8?B?Vzg1bmRkbzc3M0pOeWcydWhMYmxRS3pzc0JicThCSmN3aXRUYlhha2ZTK2tX?=
 =?utf-8?B?WnhxVGlxQUdHYmJkOVJTVVB2TFVleUV5b25jejhYMURCa1FhbG1waUhwdWFs?=
 =?utf-8?B?OStVVWg5aXBGL0dPSnhoUlVlVTgvSmdLeFVZU0FERlZTSHRrbVIzZGhqeDRZ?=
 =?utf-8?B?RHdEQW9uMnplNHg3Ly83WllXRjAwR3hqR28wSFpyakIwTFBiYVlPS2NCYTFS?=
 =?utf-8?B?dXYzSlJUUmZHM0M3Uy9iMFRpOWRFZktuSmVnS0VLV2FHOVJ0d2orSDlOWk8r?=
 =?utf-8?B?Vk8ybzNzS0NibnlUQmZQY0FzNGpSN3Bac1d5UmJ5QzN3dVJvU1gzSHg2ZFRs?=
 =?utf-8?B?MUk3RjFYOGtHbWRiZzJIZWFwY0NkbXdPNXNINnJuN1RDNkJMdDVrT3RjWk16?=
 =?utf-8?B?bnFrRktybmJuSGFYTXczRWdtSHNuYjlwMWhQc1NOVHRNZ2JsQi8yVWlzNjRF?=
 =?utf-8?B?WXBuRW9YaWRJR3J1bndaSW1jUDFkQVV6VXpEUTBnTGpCc3dlb0dLNmk4SmVS?=
 =?utf-8?B?Y3hxMWdjTGxtVTVXRytGSnQ3N3BGenhiOWV1S25JRDBlTE93Zm55NXJIcVBZ?=
 =?utf-8?B?Z3FuNURGYTR0aDJJRmVXOFBsWlVNK2dVUEFnYTdmMVRvYkVxM0lVUUd4UE1x?=
 =?utf-8?B?QmRiL214OTN4NEU3NFhjYjJuUjhoaFNnQmg2REF3WmptUU5qQzBDcGhyRmVo?=
 =?utf-8?B?WUFuS25DbU1PbXFXR3hGakE3Tm1iN1d3N0poSGVuUXdmV0N3aXRaL25RcTR2?=
 =?utf-8?Q?fTvq8AUCOQaRhC+KCyOXNgULyVTyRTQqCG9m2W+Z/at4?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B8BFD356FE80634CADEB66B55C890049@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?VDlhOUVPL2ZFRlRuNkordmhlUnp5L1QzTGdBZnFJc0xKM3dHaWdYNjVTclJ6?=
 =?utf-8?B?c2pxODMwUWkyNFNQdlpXR0JtVGVqeUtmRG15NDRwTDIrdTQ1ZEo2d0UyMkZS?=
 =?utf-8?B?ZU13R2dGY2h2ZjZqQ09tZFlqVTIrckhpRDZCV1haaWt2aHFLa3VRS2M3SkYv?=
 =?utf-8?B?d3lEZTYxak1qU2RhRXBFb3lhQm5tU1YwaWdqdk1BRnB0QVk0SExnd280eUQ4?=
 =?utf-8?B?UW41Z2UyUlNmYUcvYnFKNFBmaTV6UmFUQmRUOFJCNTZnWTBkQ0pvTnRocGUx?=
 =?utf-8?B?L2RINEtac09oNjFzNit4NGw5S0RMb0RuZHRxMlkwWFF2aTJDS1d4T2NrRXpL?=
 =?utf-8?B?UXhGTXgrY3RyMDNCNm5GYmg3cEZjNGNCZ1Fncjd3UjhsVGtRSGVvZC8vN2I5?=
 =?utf-8?B?Q24wMHZ2WVJ4aFUvcE9kZ2I1QWlBQnhXcVFvR3d2UDVKb1RCT3hCckdqaGto?=
 =?utf-8?B?blhzL3pzOUZCWDZ6S3NrYXpSdlE0cHdtaVBvSDFoejFGWXo1Q3BNM0hENXd3?=
 =?utf-8?B?L1JCR2VyT3hGNGpVV1BjK2k0ckRzU3pVWmkycUZYN3d3S052WFNaWHM5cksr?=
 =?utf-8?B?alhoTzBTYndOWHZaVU03MWdGQXNUcUQzOXpjV251TWhLWUliUXFFZ3l5OHJ1?=
 =?utf-8?B?K1RRbUdCNEVVSnFEeWQvNkszYWo2WldjK0xmaHlSYS9HUnBmN0krVmx0TVpp?=
 =?utf-8?B?bTBDTFEvbjNuc3BHdXhCQWducTA3cWwvNklYUCszZnFFOGZvYlppS3R1WXN4?=
 =?utf-8?B?UHJMa3AvRmNoWjRnYWZsdkNMTkJTNGVDc1lTK2hrcWxjb1J3U0lLb0N6aWpl?=
 =?utf-8?B?bTlyS1p0T0VwVmlKVkFPd2t1YjZwWmdQN1ZMZlF0VzVqL0lvYkVXL0c4bEky?=
 =?utf-8?B?Tk5aM1YydmdTL3BpVW1aMlRETUxtY1ZLbGVIRmtrSjdwMHBoS1Z5RU5qWmgr?=
 =?utf-8?B?YWhCTVM1YlpranZGQklmZm9oazRydGo2ZjVYcUpRc2FDby9vNjU3Y3l2bEZ3?=
 =?utf-8?B?L0oxVEU3TWpmVENONUxBN3B0MTJqOWd2U0gxUENNUEptcWNIUWQxYzdTTW9T?=
 =?utf-8?B?cnFQU1paa2FoL3NBazArV2hHQUVoSklLSkFFdlNndlZ3NmJaUEN1VFZpc1BJ?=
 =?utf-8?B?TkRyeGJmMUIwRHNubm1FOGgzd3BoR3FtWjB4aVF4bU9mbUlmZHRFdjZEa29P?=
 =?utf-8?B?d0FjZlExdDNwT0hINzdMTlIzaC9Td2FWOEFNUWtPbG43QWQ0SnM4VksrVGxJ?=
 =?utf-8?B?VkQ3V3pwNlUvVHFwQUlEVGgzQ0RjcHZoenBiQUl5ZHcwSmlYaC9mRTR3UEIv?=
 =?utf-8?B?Wk9vczVETWNETThzWjRnNUR2cnBSWWcvWjJPR1RzWnFEVTh0YjcwQ0RkZDJK?=
 =?utf-8?B?Y0hpZk5LS1NrVG16ejhhcVVlN01aTWVtMkc4TE0vKy9jdmsyYzlFLzhZNnRZ?=
 =?utf-8?B?VUhtWWJTbFRXRmNYNmdLTmlsZTBXNWVYdGZZK1l4akxEQTAvQVpHQzNOODlk?=
 =?utf-8?B?OHh6ZjZDZUlYdG1KUWx1MFI0MlpUOXdzOFh3eGppUVVCcDBvdkVwSXEySzZX?=
 =?utf-8?B?dExJSElLd1V2SXpvOXRSM2RQVDYybnpmN0JwalpQbTgzL0RXYmJFQkVhOE5D?=
 =?utf-8?B?eHE5R1RzVVF1WGlKRWNQUmszY253aXJpQnVJYUNNOUgzUXMzSUpKSXEvYlB0?=
 =?utf-8?B?NzVZdTBQTVVmMlpBS2pnWm9EcW9jcDR4ZG9kYW5NUzY3OWxnTUt0TCtMeUNq?=
 =?utf-8?B?SDNObGNYRzZwWkpuWkQrWU9tN241dHlocGVvanQxSnJMVTgvNEduWkIzc1FL?=
 =?utf-8?B?Z1RNa2VNTXdkai9jT2RpK0xMelBQemhqMDMzZlZFYW1hdU1tWVJ5VEhHemQ3?=
 =?utf-8?B?SSt3VlowZzQ2V2xBU1ZHaGV2WjRMU3VrdWRMTEpHcXBsN2c9PQ==?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4150.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dee4bffb-bf90-44ad-5bde-08daee9045ef
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jan 2023 20:14:24.1738
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: r7SsyldrYpazYCPZVGh5LVmBqDcT2XumB4DVUsM5/XqTK0MqDyHN3+Ww98deN+Kfhkpq3zoq9HqAeuXxJXUrwxGbdZydwaxBGzMEheB0Us4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6321
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-04_07,2023-01-04_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 spamscore=0
 mlxlogscore=999 malwarescore=0 phishscore=0 adultscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301040164
X-Proofpoint-GUID: 3LnAXJb5zXuhCQF3zdF19Qsluv17QRcP
X-Proofpoint-ORIG-GUID: 3LnAXJb5zXuhCQF3zdF19Qsluv17QRcP
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

DQoNCj4gT24gSmFuIDQsIDIwMjMsIGF0IDU6MjkgQU0sIEphcmtrbyBTYWtraW5lbiA8amFya2tv
QGtlcm5lbC5vcmc+IHdyb3RlOg0KPiANCj4gT24gVGh1LCBEZWMgMTUsIDIwMjIgYXQgMDY6MTA6
MDRBTSAtMDUwMCwgTWltaSBab2hhciB3cm90ZToNCj4+PiBkaWZmIC0tZ2l0IGEvY3J5cHRvL2Fz
eW1tZXRyaWNfa2V5cy94NTA5X3BhcnNlci5oIGIvY3J5cHRvL2FzeW1tZXRyaWNfa2V5cy94NTA5
X3BhcnNlci5oDQo+Pj4gaW5kZXggYTI5OWM5YzU2ZjQwLi43YzVjMGFkMWMyMmUgMTAwNjQ0DQo+
Pj4gLS0tIGEvY3J5cHRvL2FzeW1tZXRyaWNfa2V5cy94NTA5X3BhcnNlci5oDQo+Pj4gKysrIGIv
Y3J5cHRvL2FzeW1tZXRyaWNfa2V5cy94NTA5X3BhcnNlci5oDQo+Pj4gQEAgLTM4LDYgKzM4LDcg
QEAgc3RydWN0IHg1MDlfY2VydGlmaWNhdGUgew0KPj4+IAlib29sCQlzZWxmX3NpZ25lZDsJCS8q
IFQgaWYgc2VsZi1zaWduZWQgKGNoZWNrIHVuc3VwcG9ydGVkX3NpZyB0b28pICovDQo+Pj4gCWJv
b2wJCXVuc3VwcG9ydGVkX3NpZzsJLyogVCBpZiBzaWduYXR1cmUgdXNlcyB1bnN1cHBvcnRlZCBj
cnlwdG8gKi8NCj4+PiAJYm9vbAkJYmxhY2tsaXN0ZWQ7DQo+Pj4gKwlib29sCQlyb290X2NhOwkJ
LyogVCBpZiBiYXNpYyBjb25zdHJhaW50cyBDQSBpcyBzZXQgKi8NCj4+PiB9OyANCj4+IA0KPj4g
VGhlIHZhcmlhYmxlICJyb290X2NhIiBzaG91bGQgcHJvYmFibHkgYmUgcmVuYW1lZCB0byBqdXN0
ICJjYSIsIHJpZ2h0Pw0KPiANCj4gUGVyaGFwcyBpc19jYT8NCg0KSSBhbSBvcGVuIHRvIHJlbmFt
aW5nIHRoaXMsIGJ1dCBuZWVkIGFuIGFncmVlbWVudCBvbiB3aGV0aGVyIHRoZSDigJxpc1/igJ0g
c2hvdWxkIGJlIHVzZWQgb3Igbm90Og0KDQpodHRwczovL2xvcmUua2VybmVsLm9yZy9sa21sL2Iy
OGVhMjExZDg4ZTk2OGE1NDg3YjIwNDc3MjM2ZTliNTA3NzU1ZjQuY2FtZWxAbGludXguaWJtLmNv
bS8NCg0K
