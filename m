Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5487F4F6E1D
	for <lists+linux-integrity@lfdr.de>; Thu,  7 Apr 2022 00:54:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237458AbiDFW4K (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 6 Apr 2022 18:56:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234084AbiDFW4I (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 6 Apr 2022 18:56:08 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67792202161;
        Wed,  6 Apr 2022 15:54:10 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 236LYtm0006418;
        Wed, 6 Apr 2022 22:53:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=7zT/vk/OJAPNT3/z8T4D5PxMUu2ob9FRXZWKwRoFBJQ=;
 b=QZuoIgW8iqOuynj3S6HgyS6Pjs2fahqg0IiVhK0WydyWOn9JvR8Ttw3UUK2k+WuSgXn/
 5vpMCoFi2FvSbH9hxDwhVJZ4lnsjS2mtFisUNq7wHYCQEwfTuCjWK7jtnfC7x6XlWBjy
 Aep+0+/U+m6pumo1sLm51GYEBvdSoEl2VZyIJOMHtI76Mf6rVj3zVCuXdCYlRNZPskba
 vGL5xxXKpezE+MRvrbfHQaXvLZgTs0LYR5Mkyn+kAqfrDeFMJ5etzxfR3iQ5snBCBN8P
 tWo65J72Iazckpy9xRN/AnPD0xjlkrn7FMCDFFaW8isVLlhGLfgRTo4I7WCevFePWeRo 0Q== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com with ESMTP id 3f6d31jdhs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 06 Apr 2022 22:53:33 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 236Mfb57018932;
        Wed, 6 Apr 2022 22:53:32 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2108.outbound.protection.outlook.com [104.47.70.108])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3f97tspe39-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 06 Apr 2022 22:53:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VO7WHR6JcGYZ0bKMOpchmkkLzu5XqYSCsuctjjHeMbEuB0h5ZAG/ohZtdUx4fGGb0qWGUVpuch+IpBz3v6fH6uTybLRXGhgdVrsRJyDzC+J7q3lG1fhfEprvyimPM6fnbpbwmlY1B5f3ke48xihYxqpmYiF5uRmKXErvq/skC7lO3wSbTUyUsWNA4Pq/f4MqXx8jd81XMMidn+3yp8mdDlGqGVAee3Z0IVuBOKpWipJdBHHX4zqWF3DSJai8qOJOBM6+TGJ55QmlfuPYzJvkgHfqznsc/xbRPNb57G1E1/8oqXJwQf4SrFh6xauZvAhLPti7XmFoQcHkqhimQORUlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7zT/vk/OJAPNT3/z8T4D5PxMUu2ob9FRXZWKwRoFBJQ=;
 b=NAAAj2fvyqdXem56aUpmJAKVViu6I7JssEkKTap/I/IItYRLgIv87NEgb6IthxdooQTYF7pYHffg3tnK3vJuRU2nKL2epDG+VpqHp47VXp1ET9KvjEdmE8E8L3p1T8Lhkx6VrHPDcK98c/g6P7GxRHTVLtf1r39hyqhFHbvj0isJ4TeToKb32Z7aG8bBzwqfr08KlNfBxNjNtE3iQ5XAO6LiI4v+6K6UnJ3iOeuLNJg3xj6p2O3Shows5NdO9HZCYXQNTPm7HUR1ujOCNslUKdx9v7LKwLwiCMg1FL5zWduT5o1JhRN26Tv7gn7mGwrxubhPutknODvBoDVo51fjPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7zT/vk/OJAPNT3/z8T4D5PxMUu2ob9FRXZWKwRoFBJQ=;
 b=v/ZDxLpUZJlxlPGH+1f0PjILgRFFNgkJQVLwVbxHg5s3fYNUKygEROFOvaoDTQH/ZOBVSGKlAsewYyeEcTLTrur0GavsmiJUOdiBMnvYQBK07c8UwcE3oLi/gM/DzuBjtnIMyoJ2s3hz+bsMC3k9yvXnfaTtQQBN5f8eWi1y944=
Received: from CH2PR10MB4150.namprd10.prod.outlook.com (2603:10b6:610:ac::13)
 by SA2PR10MB4491.namprd10.prod.outlook.com (2603:10b6:806:f8::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31; Wed, 6 Apr
 2022 22:53:30 +0000
Received: from CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::7ded:5b3:a28f:2e55]) by CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::7ded:5b3:a28f:2e55%5]) with mapi id 15.20.5123.031; Wed, 6 Apr 2022
 22:53:30 +0000
From:   Eric Snowberg <eric.snowberg@oracle.com>
To:     Mimi Zohar <zohar@linux.ibm.com>
CC:     David Howells <dhowells@redhat.com>,
        "dwmw2@infradead.org" <dwmw2@infradead.org>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "dmitry.kasatkin@gmail.com" <dmitry.kasatkin@gmail.com>,
        "jmorris@namei.org" <jmorris@namei.org>,
        "serge@hallyn.com" <serge@hallyn.com>,
        "roberto.sassu@huawei.com" <roberto.sassu@huawei.com>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        "pvorel@suse.cz" <pvorel@suse.cz>, "tiwai@suse.de" <tiwai@suse.de>,
        "keyrings@vger.kernel.org" <keyrings@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>
Subject: Re: [PATCH 0/7] Add CA enforcement keyring restrictions
Thread-Topic: [PATCH 0/7] Add CA enforcement keyring restrictions
Thread-Index: AQHYSVko0FaTAwO/wkyht4hUdft6wKzjW/AAgAAjoYA=
Date:   Wed, 6 Apr 2022 22:53:30 +0000
Message-ID: <8ECDC8D2-433B-4F7E-9EEC-BB85C75ED198@oracle.com>
References: <20220406015337.4000739-1-eric.snowberg@oracle.com>
 <6bfe3fe98eb7c11520264503fd10da478d6a3fd3.camel@linux.ibm.com>
In-Reply-To: <6bfe3fe98eb7c11520264503fd10da478d6a3fd3.camel@linux.ibm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3608.120.23.2.7)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3588f5e5-6ee4-48a2-25d7-08da182044f5
x-ms-traffictypediagnostic: SA2PR10MB4491:EE_
x-microsoft-antispam-prvs: <SA2PR10MB449100E3DF2B048A2ADBF5CF87E79@SA2PR10MB4491.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uwVSd/xsxqKfebejCWqKVRVRRc9kjEN18fqgIxnkQGbFEr51NU+Jt+br4c0NLKeetCbP6Pf0iL0EE7vTmWZkUPyCZ6Y6xN6KRPG8uV878Mt5SmuZyhRXgY2a7hQxOGwNU3zrrdp29Nkg3bFFs/7SYdwthtixtalVg49NABRPQitW29rvjAsKQ3mnFF2AkjyRXKMqvE3r7S+m85mOievyow3BjAP4DjLX8JfLVBKk4CAAOUcY+++hL0xjPpBbbGFOa10+4hgom84nU6VIcHmnxe27hReYPmKZVe9l50f8pT5NyQzkRA5Rtyyd2+twtr2JULHpk/fQww4OK0zr/Kl5NT1T8L9FYMyzwOsANTLNMOFY+qkoR4XeJShOuN9Jy0u4u6EuHQRtaofNavxTwc8rC5iiG5Tf2F5GqidIIeCdUkM7AMPY5PaXTn9GIJjv+yeU48VzKBXe+c/GFgLH4XRP0di3tD47nAhBiXM5I2zYEM6ASRllM8LIu6BFJBGjWqeSVdX8H7dYD1NZsSYE6c/cyIS7cbLkB4uw/897WFFncYDv3bnUDMiI0e0GPfqe26kq5MT+9hD0MxBuouN9DHzFOQUmShLUU8RNoP9IV1yQiICap4/Afy/r5Y6JIc4luzo8g+d5IBvB211fDiaPkHbmGQq4d+Si65tMBBvo8zpEndhDpEamXn6o2klbKNoyV0qlwqDwkQly9oKXMM7S31ma2W8KADLE5AHHCDVpt5WZbK0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4150.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(76116006)(5660300002)(53546011)(8676002)(86362001)(7416002)(4326008)(8936002)(6512007)(6506007)(6916009)(508600001)(91956017)(44832011)(26005)(186003)(2616005)(66446008)(66476007)(316002)(66556008)(66946007)(71200400001)(36756003)(64756008)(6486002)(54906003)(122000001)(2906002)(38070700005)(38100700002)(83380400001)(33656002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SS9OUXNiMEtkeGxHZFEvOWl1dWtISzBXRS9KeFI4NWVFcGxuem4xeFhlWDJy?=
 =?utf-8?B?L0hpZ01HNnJJSUF6NmY2NzdjVU1HQjdmMkdueXZpZEdCN2lETFZwa2hISWdt?=
 =?utf-8?B?ZHlFUktoTFhHbldvSXU0Rlp3WURnK1BNUjlSSFZjUG4weEkxK1hUcU05SnRM?=
 =?utf-8?B?djQzc2FZSGFQNGEyUC85WUpjdE9vTXlNcWVmTnFhR0w0MDNZZVR3TEF4N2RE?=
 =?utf-8?B?NkUvYU9tQldSUXJ1MEduY0RncjZlazZXY2FtTWswaEJrRWN6S3FVRVRCUFI3?=
 =?utf-8?B?c3hBVk5BKzFFanFFRlJOeUpQRUJreE9JdzR6RjAyVkF2bzBWZFYwVTMwVFQ4?=
 =?utf-8?B?WFZvSUlpdk9pSkRIZE5nTFFhd01iOWVSUlBOVXlyNGxOa0JIUDA0R3dGTEp5?=
 =?utf-8?B?N3loM21NNCszRnpWS01aT0M4WlBTZHhmNGpEQk9KQ2Q0cDhpM2RSKzg2ZCtU?=
 =?utf-8?B?RDRaVTRTQ09FYUJPbFhMYlR2QjJLb2tHVHNWTm1KMEh1UE1UR2dqKzBZSTRZ?=
 =?utf-8?B?N3pjYVZXY0pvRldPQnNCdE4rQ2VrOE5hMm9GMW1KYzNjc3RHM3J5alFaUlV3?=
 =?utf-8?B?bjMvNUdlVU5XU1J3ZHJWNGdORTMyQlpRM2tTc1c2Y2FUcVRuTU9NYWhjSUVl?=
 =?utf-8?B?UWcrRnNaTWpMUEZlcUFvN0poQ3FyKzdrMWJHY3JmL3FHVUcvZnc2Rm5nSXNR?=
 =?utf-8?B?ODJ0OHNrdzkxY0xrYmE3OTNraHEvVlh4bUdJdUZEU2MzckFrWmhTRW9vREQ5?=
 =?utf-8?B?WEdPN2FMenZYOEluQnh1VzRMQ1hOdjRWc2pHSnI2amVZWUZ6c1B2dzNUVTVh?=
 =?utf-8?B?Vm4vaEEwSWlBNzVUbmpWQ04rMW9nRDNpUFB2QW5HT0lNcmVKZUZGb1BBbGkx?=
 =?utf-8?B?YkFLdU0zQmFLeXFTZ3ZtdnNMZ0xaaWVFQzNQNGdYdG5lRVZ6MUJqQjVyYm1S?=
 =?utf-8?B?clJwbVVmc2N0YVd3MDl4cHRTYXYrdm1lV0Y0TFlVRzNVVXJTTDFaUDZETm9k?=
 =?utf-8?B?K2RaSVNMMHhwYWkvekZ2bk5ocXBtbUZWS2d6NU1peWFETllnZWt5VVp0L0o0?=
 =?utf-8?B?dm9aaHEvUlVDSWpqTFRpZFMrc01GSk9yTk0vZmRLMjU1K0IzWFhZdEtuQ21Z?=
 =?utf-8?B?Y1JkQW40eFZ2ejcxL2xTdHJpbHdRaCs5TFVvRmxST3NDYTJlNWk2TlNsN1Uv?=
 =?utf-8?B?TTJvVXpCV1hPdUZ4Zis3Yjh1eWlKRTk3cEYwdE1OSUovRjZIdGZCVUpYeU1a?=
 =?utf-8?B?UlAwNGVHdm5qS1hHb3FvVE5VNFVHYmIvZDhyZ1NuSkxDeVp1cEN3ZGVxcFBm?=
 =?utf-8?B?WUk4NmpwaWtONVdZK2pQbzFNR1A5aVFuWmJDdzdBUmxDaUFxbjVqN2dhbHdu?=
 =?utf-8?B?Q0pRVWZCR2VuaG5WdGtkdTlmWWNmSThmTjcrUVlCVXhVOWpFZGxJOU1WQito?=
 =?utf-8?B?UVc2TS9wdzRteDdUTjgwZGlud3ZOSjYvOWVab0toS2V1UDk1WjVqZkx0MCtL?=
 =?utf-8?B?Z2k2bVJOV0xTbEFDOU9JSDN1RGp0R1IzSW5vM1Z2TlVKVWx6WEVTbHBWTWNY?=
 =?utf-8?B?T2ZrSjFwZDB6R2hkc0N4N3BNRjRMWGRCckhIUGRnVTFLbHVyemlVVFhpeW55?=
 =?utf-8?B?eVdERUN3YzlNUWU3TmxNazNaeno2OVhSaEdYQ1JIWGRWelk0SzRBdFVIaDdD?=
 =?utf-8?B?V0d6K1Jtajd0U05IM2lYY1pLZm1qcFlsZnNudkMxSFJiWk1hQjhpU0dNNTdQ?=
 =?utf-8?B?WEFlditqMkVtVk1WcWlHMjYrdWVUaXBPVGtwSUxsOWNaQlpWVW1DdUtFRkd3?=
 =?utf-8?B?cERFR3NKTXV4LzJHSks2Q1VZSmh4V0FuQ2lOSXFaNHdxN3hmMHhPcDRmak5H?=
 =?utf-8?B?WE9qdWpOOE0ybFBza2tCbzlEL2R2aTkzQWY2SWtOZ1NSTVMyQ3BwWTRhWjJq?=
 =?utf-8?B?QWNZU2szWkQ3UHk2VDB0M2pmUCtJWXRUakQ5TDhIM1NSaG5PVytvQzd2UktS?=
 =?utf-8?B?U1Bsd3VsaFZqc0ZpaUJ2REVhWFFnM2E1cjUwK1c2SkV3NUZrL1hDbG1adkdM?=
 =?utf-8?B?UFo0bnhQTGxGc2lKVlQwcEJGMTQvc0tFRENPZUwzRndSaEttRWZOT1pTeDBz?=
 =?utf-8?B?aXJhVXB2MGxHUHk4dE9rV3E4eDZHL1kvcjZ0MXhDMFFpY1MwZlA0ajhEWUly?=
 =?utf-8?B?RnErU0FxRHN2QkNtUFlaZklRRGp3ZVJSTHZLMkxaamVsdk9jRmU0NmZaNCt1?=
 =?utf-8?B?SkVROVg4Q0o0ME40b1BTMmtQOGtlWFhncmRkZDdySXN6WVNGcHVXNzBNakJj?=
 =?utf-8?B?QURkTGJKNmlwU3hpUVJCVHJNZldjT1hXTUE0bCtZTkZMTTV4OTNFM2FQMjlP?=
 =?utf-8?Q?iBZDQ8BzK7OH1Jl8=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6C0D3AE140A5DF4F98580070DA1A5225@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4150.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3588f5e5-6ee4-48a2-25d7-08da182044f5
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Apr 2022 22:53:30.0189
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cOCN0rva6H6WNMx8q9uKvrP4OA0ebh0BJdSkj8IjmUJ9DZrdy5Q3nzyw4gELCYdM9/YOC4GL0d8aRfjjkwN05nNKUQlZe3I+pTdekItr0A0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4491
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.425,18.0.850
 definitions=2022-04-06_13:2022-04-06,2022-04-06 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 mlxscore=0 suspectscore=0 bulkscore=0 adultscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204060112
X-Proofpoint-GUID: Zg318lgg1NB6nRNRhtFggu0U1a3T4pMT
X-Proofpoint-ORIG-GUID: Zg318lgg1NB6nRNRhtFggu0U1a3T4pMT
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

DQoNCj4gT24gQXByIDYsIDIwMjIsIGF0IDI6NDUgUE0sIE1pbWkgWm9oYXIgPHpvaGFyQGxpbnV4
LmlibS5jb20+IHdyb3RlOg0KPiANCj4gSGkgRXJpYywNCj4gDQo+IE9uIFR1ZSwgMjAyMi0wNC0w
NSBhdCAyMTo1MyAtMDQwMCwgRXJpYyBTbm93YmVyZyB3cm90ZToNCj4+IEEga2V5IGFkZGVkIHRv
IHRoZSBpbWEga2V5cmluZyBtdXN0IGJlIHNpZ25lZCBieSBhIGtleSBjb250YWluZWQgd2l0aGlu
IA0KPj4gZWl0aGVyIHRoZSBidWlsdGluIHRydXN0ZWQgb3Igc2Vjb25kYXJ5IHRydXN0ZWQga2V5
cmluZ3MuIEN1cnJlbnRseSwgdGhlcmUgYXJlIA0KPj4gQ0EgcmVzdHJpY3Rpb25zIGRlc2NyaWJl
ZCBpbiBJTUFfS0VZUklOR1NfUEVSTUlUX1NJR05FRF9CWV9CVUlMVElOX09SX1NFQ09OREFSWSwN
Cj4+IGJ1dCB0aGVzZSByZXN0cmljdGlvbnMgYXJlIG5vdCBlbmZvcmNlZCB3aXRoaW4gY29kZS4g
VGhlcmVmb3JlLCBrZXlzIHdpdGhpbiANCj4+IGVpdGhlciB0aGUgYnVpbHRpbiBvciBzZWNvbmRh
cnkgbWF5IG5vdCBiZSBhIENBIGFuZCBjb3VsZCBiZSB1c2VkIHRvDQo+PiB2b3VjaCBmb3IgYW4g
aW1hIGtleS4NCj4+IA0KPj4gVGhlIG1hY2hpbmUga2V5cmluZyBjYW4gbm90IGJlIHVzZWQgYXMg
YW5vdGhlciB0cnVzdCBhbmNob3IgZm9yIGFkZGluZyBrZXlzIA0KPj4gdG8gdGhlIGltYSBrZXly
aW5nLCBzaW5jZSBDQSBlbmZvcmNlbWVudCBkb2VzIG5vdCBjdXJyZW50bHkgZXhpc3QgWzFdLiBU
aGlzIA0KPj4gd291bGQgZXhwYW5kIHRoZSBjdXJyZW50IGludGVncml0eSBnYXAuDQo+PiANCj4+
IEludHJvZHVjZSBhIG5ldyByb290IG9mIHRydXN0IGtleSBmbGFnIHRvIGNsb3NlIHRoaXMgaW50
ZWdyaXR5IGdhcCBmb3INCj4+IGFsbCBrZXlyaW5ncy4gIFRoZSBmaXJzdCBrZXkgdHlwZSB0byB1
c2UgdGhpcyBpcyBYLjUwOS4gIFdoZW4gYSBYLjUwOSANCj4+IGNlcnRpZmljYXRlIGlzIHNlbGYg
c2lnbmVkLCBjb250YWlucyBrZXJuQ2VydFNpZ24gS2V5IFVzYWdlIGFuZCBjb250YWlucyANCj4+
IHRoZSBDQSBiaXQsIHRoZSBuZXcgZmxhZyBpcyBzZXQuICBJbnRyb2R1Y2UgbmV3IGtleXJpbmcg
cmVzdHJpY3Rpb25zIA0KPj4gdGhhdCBub3Qgb25seSB2YWxpZGF0ZXMgYSBrZXkgaXMgc2lnbmVk
IGJ5IGEga2V5IGNvbnRhaW5lZCB3aXRoaW4gdGhlIA0KPj4ga2V5cmluZywgYnV0IGFsc28gdmFs
aWRhdGVzIHRoZSBrZXkgaGFzIHRoZSBuZXcgcm9vdCBvZiB0cnVzdCBrZXkgZmxhZyANCj4+IHNl
dC4gIFVzZSB0aGlzIG5ldyByZXN0cmljdGlvbiBmb3Iga2V5cyBhZGRlZCB0byB0aGUgaW1hIGtl
eXJpbmcuICBOb3cgDQo+PiB0aGF0IHdlIGhhdmUgQ0EgZW5mb3JjZW1lbnQsIGFsbG93IHRoZSBt
YWNoaW5lIGtleXJpbmcgdG8gYmUgdXNlZCBhcyBhbm90aGVyIA0KPj4gdHJ1c3QgYW5jaG9yIGZv
ciB0aGUgaW1hIGtleXJpbmcuDQo+PiANCj4+IFRvIHJlY2FwLCBhbGwga2V5cyB0aGF0IHByZXZp
b3VzbHkgbG9hZGVkIGludG8gdGhlIGJ1aWx0aW4sIHNlY29uZGFyeSBvcg0KPj4gbWFjaGluZSBr
ZXlyaW5nIHdpbGwgc3RpbGwgbG9hZCBhZnRlciBhcHBseWluZyB0aGlzIHNlcmllcy4gIEtleXMN
Cj4+IGNvbnRhaW5lZCB3aXRoaW4gdGhlc2Uga2V5cmluZ3MgbWF5IGNhcnJ5IHRoZSByb290IG9m
IHRydXN0IGZsYWcuIFRoZQ0KPj4gaW1hIGtleXJpbmcgd2lsbCB1c2UgdGhlIG5ldyByb290IG9m
IHRydXN0IHJlc3RyaWN0aW9uIHRvIHZhbGlkYXRlDQo+PiBDQSBlbmZvcmNlbWVudC4gT3RoZXIg
a2V5cmluZ3MgdGhhdCByZXF1aXJlIGEgcm9vdCBvZiB0cnVzdCBjb3VsZCBhbHNvIA0KPj4gdXNl
IHRoaXMgaW4gdGhlIGZ1dHVyZS4NCj4gDQo+IFlvdXIgaW5pdGlhbCBwYXRjaCBzZXQgaW5kaWNh
dGVkIHRoYXQgeW91IHdlcmUgYWRkcmVzc2luZyBMaW51cycNCj4gcmVxdWVzdCB0byBhbGxvdyBl
bmQtdXNlcnMgdGhlIGFiaWxpdHkgInRvIGFkZCB0aGVpciBvd24ga2V5cyBhbmQgc2lnbg0KPiBt
b2R1bGVzIHRoZXkgdHJ1c3QiLiAgSG93ZXZlciwgZnJvbSB0aGUgZGVzaWduIG9mIHRoZSBwcmV2
aW91cyBwYXRjaA0KPiBzZXQgYW5kIG5vdyB0aGlzIG9uZSwgZXZlcnl0aGluZyBpbmRpY2F0ZXMg
YSBsb3QgbW9yZSBpcyBnb2luZyBvbiB0aGFuDQo+IGp1c3QgYWxsb3dpbmcgZW5kLXVzZXJzIHRv
IGFkZCB0aGVpciBvd24ga2V5cy4gIFRoZXJlIHdvdWxkIGJlIG5vDQo+IHJlYXNvbiBmb3IgbG9h
ZGluZyBhbGwgdGhlIE1PSyBrZXlzLCByYXRoZXIgdGhhbiBqdXN0IHRoZSBDQSBrZXlzLCBvbnRv
DQo+IHRoZSAibWFjaGluZSIga2V5cmluZy4gIFBsZWFzZSBwcm92aWRlIHRoZSBtb3RpdmF0aW9u
IGZvciB0aGlzIGRlc2lnbi4NCg0KVGhlIG1vdGl2YXRpb24gaXMgdG8gc2F0aXNmeSBib3RoIExp
bnVzIGFuZCB5b3VyIHJlcXVlc3RzLiBMaW51cyByZXF1ZXN0ZWQgDQp0aGUgYWJpbGl0eSB0byBh
bGxvdyB1c2VycyB0byBhZGQgdGhlaXIgb3duIGtleXMgYW5kIHNpZ24gbW9kdWxlcyB0aGV5IHRy
dXN0LiAgDQpBIGNvZGUgc2lnbmluZyBDQSBjZXJ0aWZpY2F0ZSBkb2VzIG5vdCByZXF1aXJlIGtl
cm5DZXJ0U2lnbiBpbiB0aGUgdXNhZ2UuIEFkZGluZyANCnRoaXMgYXMgYSByZXF1aXJlbWVudCBm
b3Iga2VybmVsIG1vZHVsZXMgd291bGQgYmUgYSByZWdyZXNzaW9uIChvciBhIGJ1ZykuDQoNClRo
aXMgc2VyaWVzIGFkZHJlc3NlcyB5b3VyIHJlcXVlc3QgdG8gb25seSB0cnVzdCB2YWxpZGx5IHNp
Z25lZCBDQSBjZXJ0cy4gDQpBcyB5b3UgcG9pbnRlZCBvdXQgaW4gdGhlIEtjb25maWcgaGVscCBm
b3IgDQpJTUFfS0VZUklOR1NfUEVSTUlUX1NJR05FRF9CWV9CVUlMVElOX09SX1NFQ09OREFSWToN
Cg0KaGVscA0KICBLZXlzIG1heSBiZSBhZGRlZCB0byB0aGUgSU1BIG9yIElNQSBibGFja2xpc3Qg
a2V5cmluZ3MsIGlmIHRoZQ0KICBrZXkgaXMgdmFsaWRseSBzaWduZWQgYnkgYSBDQSBjZXJ0IGlu
IHRoZSBzeXN0ZW0gYnVpbHQtaW4gb3INCiAgc2Vjb25kYXJ5IHRydXN0ZWQga2V5cmluZ3MuDQoN
CiAgSW50ZXJtZWRpYXRlIGtleXMgYmV0d2VlbiB0aG9zZSB0aGUga2VybmVsIGhhcyBjb21waWxl
ZCBpbiBhbmQgdGhlIA0KICBJTUEga2V5cyB0byBiZSBhZGRlZCBtYXkgYmUgYWRkZWQgdG8gdGhl
IHN5c3RlbSBzZWNvbmRhcnkga2V5cmluZywNCiAgcHJvdmlkZWQgdGhleSBhcmUgdmFsaWRseSBz
aWduZWQgYnkgYSBrZXkgYWxyZWFkeSByZXNpZGVudCBpbiB0aGUNCiAgYnVpbHQtaW4gb3Igc2Vj
b25kYXJ5IHRydXN0ZWQga2V5cmluZ3MuDQoNCnJlcXVpcmVzIGtleXMgdG8gYmUg4oCcdmFsaWRs
eeKAnSBzaWduZWQgYnkgYSBDQSBjZXJ0LiBMYXRlciB0aGUgZGVmaW5pdGlvbiBvZiBhIA0KdmFs
aWRseSBzaWduZWQgQ0EgY2VydCB3YXMgZGVmaW5lZCBhczogc2VsZiBzaWduZWQsIGNvbnRhaW5z
IGtlcm5DZXJ0U2lnbiANCmtleSB1c2FnZSBhbmQgY29udGFpbnMgdGhlIENBIGJpdC4gV2hpbGUg
dGhpcyBoZWxwIGZpbGUgc3RhdGVzIHRoZSBDQSByZXN0cmljdGlvbiwgDQpub3RoaW5nIGluIGNv
ZGUgZW5mb3JjZXMgaXQuICBPbmUgY2FuIHBsYWNlIGFueSB0eXBlIG9mIHNlbGYgc2lnbmVkIGNl
cnQgaW4gZWl0aGVyIA0Ka2V5cmluZyBhbmQgaW1hIHdpbGwgdXNlIGl0LiAgVGhlIG1vdGl2YXRp
b24gaXMgZm9yIGFsbCBrZXlzIGFkZGVkIHRvIHRoZSBpbWEgDQprZXlyaW5nIHRvIGFiaWRlIGJ5
IHRoZSByZXN0cmljdGlvbiBkZWZpbmVkIGluIHRoZSBLY29uZmlnIGhlbHAuICBXaXRoIHRoaXMg
c2VyaWVzIA0KdGhpcyBjYW4gYmUgYWNjb21wbGlzaGVkIHdpdGhvdXQgaW50cm9kdWNpbmcgYSBy
ZWdyZXNzaW9uIG9uIGtleXMgcGxhY2VkIGluIA0KYW55IG9mIHRoZSBzeXN0ZW0ga2V5cmluZ3Mu
DQoNCj4gUGxlYXNlIG5vdGUgdGhhdCBQYXRjaCA2LzcgcGVybWl0cyBpbnRlcm1lZGlhcnkgQ0Eg
a2V5cywgd2l0aG91dCBhbnkNCj4gbWVudGlvbiBvZiBpdCBpbiB0aGUgY292ZXIgbGV0dGVyLiAg
UGxlYXNlIGluY2x1ZGUgdGhpcyBpbiB0aGUNCj4gbW90aXZhdGlvbiBmb3IgdGhpcyBkZXNpZ24u
DQoNCk9rLCBJ4oCZbGwgYWRkIHRoYXQgaW4gdGhlIG5leHQgcm91bmQuDQoNCg==
