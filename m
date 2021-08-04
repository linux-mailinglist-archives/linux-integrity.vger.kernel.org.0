Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B70173DF9D7
	for <lists+linux-integrity@lfdr.de>; Wed,  4 Aug 2021 04:57:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234765AbhHDC6I (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 3 Aug 2021 22:58:08 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:58638 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231396AbhHDC6H (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 3 Aug 2021 22:58:07 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 1742vGeO016426;
        Wed, 4 Aug 2021 02:57:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=NVnSAIjX9PFH2dZjY2gQkDLXOaMfr7zJ/LORR38TIgE=;
 b=iRQ8n479AMLBbuUa9YJIFs5aPjTHXQsjZJwThW2tqh3LLauu55oHNf6YPaTO65Ni5mpW
 /93YbwLNEms5mFX82Fv0wvbtK7XZyZr9bwmcFNaK0a7ITvmH6XkGJ9B/b7B4SmexO6Z3
 f3ZqJBt0nXVzFI+HMq50rW//MCDHt075+gpmop26Jnj8PjVHCQUbEFiClKFJGj8WRUf1
 6j0FvbCMyhYKeMJs0tyoz6M4Klk5IPrc768IO5riynQoBUHSE5A6DLALw7YH2LK1h9zT
 YLPj3LV9VY16ju0olhmkgytRu2ErnKXsMomNXOf8mm3+0s0tUn+9xfMAf95nOuIR7yuF FA== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=NVnSAIjX9PFH2dZjY2gQkDLXOaMfr7zJ/LORR38TIgE=;
 b=imgsMylTuZMbbOSOQhkcO7kTwTC7ibnQbJ/vWl7hKUjFzurnnkkmmn3rwnTkpG+mL0jF
 dkmncinfzQgPcjtFKJrnCA5Q1TjtSbsaPZj7QFDKQbP2K/QcSMVkd1Wt8WWkt/hEHi30
 0R53TuvGgUi7cGtGJPmDkLMhLTnpCw9hVBQcjcWnZh6nM+0QvaQs1QuBjO556tS71GlD
 BsbtFXP/HeTmJkI+pkMDkFSdDF1E45OdhWJlg+VNqfTv9CmjQPKsAUXfMU3zgF9206Ss
 WpV7X90pERfT2ymYooZnRPjioQKN00vpg5BQG0ee5xC6wZS0L8ysXkki07p8hDpaf0nv JA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3a7cxn0fjp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 04 Aug 2021 02:57:16 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 1742tQHq181196;
        Wed, 4 Aug 2021 02:57:03 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam08lp2040.outbound.protection.outlook.com [104.47.74.40])
        by userp3030.oracle.com with ESMTP id 3a4un0sra5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 04 Aug 2021 02:57:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QnCAotaYCYhagdECNIgvqmG94Vmd1gfnYqNgZgSvwo/ki0d3Rvpp4G2ftffb4ZfZ20MboDFE6Im7EH69kuzyfQtcWSgElb48VY4S+2q0IUXBZqjICWp+hAoFto3FIYVpEvnTNNsSBGWA9l9NqAnroM1KXyqsTjdCKrVrzAo+1sZ2nTDzThiQkIOeLCUtmIGZ8KxjQHYP5v6IwudK3k1EJ5Sf3+GDQyiYXf81icwWxIJkiNT6a1uDHXAPgtRnohyHuIblhuryKjVrfu75MTC29hyz/lFroexQwuyi/7VXaVUDRO8da/IZ9BdeAVqFqSJKHZgeR26zMYp/j95fR/GfTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NVnSAIjX9PFH2dZjY2gQkDLXOaMfr7zJ/LORR38TIgE=;
 b=iuii2CDUd676QU3nE5xok5Px0yhUi6Hjm1u1qRRUkj10zD22hUDYShYCZsiVk9Gh30kSUgTBpyyPwHJO+cjfwK9jyjIysPEuP1GDAIYjVfxjmkrqIezRSEin4K8kQjbIrADBOr6CQtAfcFBEoUw3ym3y1R22w6TubjMfisrNU91DgY0h6pGMCjNKH3m2P5TBAw8Cf8Sz8petWgwTWs5PpbCVXPgJdx/rvGyg/Xz2TBqSlOE/yo0E9NsK0F3/3khaqjo3X6a+TZRvSrI18lnop6zVQtWfJH7I3wf0DPZTho+CDU5/TfA9Yf+yzfyLWmA4IjgqVstB461RBer0DGCO9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NVnSAIjX9PFH2dZjY2gQkDLXOaMfr7zJ/LORR38TIgE=;
 b=c2G7iVfQhPtZ6L1hfiW4pLQOW0dOZsPxkTbviPHd+ffKoHkOirHJBCra32iSDxNMNAITzzpaCP7GfDMWoTwZ5nTmvhjGxJb+Im37/O3wY9vzdV3PQbEnx+ftG3d9urCGRDprisfAFexYvZNWn5YhhHrTfv4PAVYd6aP8x1CkcA0=
Received: from CH2PR10MB4150.namprd10.prod.outlook.com (2603:10b6:610:ac::13)
 by CH0PR10MB5210.namprd10.prod.outlook.com (2603:10b6:610:ca::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.18; Wed, 4 Aug
 2021 02:56:59 +0000
Received: from CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::1d17:4a7d:92cc:8fc3]) by CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::1d17:4a7d:92cc:8fc3%7]) with mapi id 15.20.4373.026; Wed, 4 Aug 2021
 02:56:59 +0000
From:   Eric Snowberg <eric.snowberg@oracle.com>
To:     Mimi Zohar <zohar@linux.ibm.com>
CC:     "keyrings@vger.kernel.org" <keyrings@vger.kernel.org>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        "dwmw2@infradead.org" <dwmw2@infradead.org>,
        "herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "jarkko@kernel.org" <jarkko@kernel.org>,
        "jmorris@namei.org" <jmorris@namei.org>,
        "serge@hallyn.com" <serge@hallyn.com>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
        "scott.branden@broadcom.com" <scott.branden@broadcom.com>,
        "weiyongjun1@huawei.com" <weiyongjun1@huawei.com>,
        "nayna@linux.ibm.com" <nayna@linux.ibm.com>,
        "ebiggers@google.com" <ebiggers@google.com>,
        "ardb@kernel.org" <ardb@kernel.org>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        "lszubowi@redhat.com" <lszubowi@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        "James.Bottomley@hansenpartnership.com" 
        <James.Bottomley@HansenPartnership.com>,
        "pjones@redhat.com" <pjones@redhat.com>,
        "glin@suse.com" <glin@suse.com>,
        Konrad Wilk <konrad.wilk@oracle.com>
Subject: Re: [PATCH RFC v2 00/12] Enroll kernel keys thru MOK
Thread-Topic: [PATCH RFC v2 00/12] Enroll kernel keys thru MOK
Thread-Index: AQHXgkGQDJNMCBs2NE2Cm66++H2geKtiDd4A///LT4CAAL52AIAAHKEA
Date:   Wed, 4 Aug 2021 02:56:59 +0000
Message-ID: <3D8EF15C-E3D6-4C9A-9BA2-9F4201AC3ED3@oracle.com>
References: <20210726171319.3133879-1-eric.snowberg@oracle.com>
 <820cd72cd77c4716bff2bf344c64d7bcb59fc4d3.camel@linux.ibm.com>
 <2BBC3A71-6E0D-47A2-842A-11C279A5DC56@oracle.com>
 <5ac7f5fc866dd271ecfc9be17fef7fa47babbc6e.camel@linux.ibm.com>
In-Reply-To: <5ac7f5fc866dd271ecfc9be17fef7fa47babbc6e.camel@linux.ibm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3608.120.23.2.7)
authentication-results: linux.ibm.com; dkim=none (message not signed)
 header.d=none;linux.ibm.com; dmarc=none action=none header.from=oracle.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 000eaaad-f28f-448d-8003-08d956f38757
x-ms-traffictypediagnostic: CH0PR10MB5210:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CH0PR10MB52100583B0382AD4253BF50587F19@CH0PR10MB5210.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NfAsx2eCiFzXhsXK8qWvmDNOqQH2x9ORDpcKobw6CnZ9yQyRvPn2mWLywgfbSH4EXa/u+HQ0sHP0Q4FW0UIxWsFXTgVl9+cYwyG8urjnoshkTiY6jZpM7565mLYm7CRkNy6aeq7q6JkQ6bhlWhOrCuu8zqXRMvjvOKnbZyVuipkhETwD6we3D60KJ2mWkaZ/N3xcxM0lsye+z+921CwmdyrduOPhxt6CZ9aqTnWGYsqM+W1efm+J9EEQB41cy4B6kfbrOeC7tKPvX2Mwb0y017wiYSvJECekbEUKC9H755BJvHID2JiVdCKfWgPW7mp1upm9rtqaEcNH/pSLG62RWGj6w+z3C57YoRcBcntAF0neeVIX7HECpxnu1SDHqJBpMTs6gDNYuD8Luwce0/eWqVbgOI3GJoCVpv1nr1FISAuxk0EgW7xsNg4ZXUZm3ozPG8rUmKQPC3oGaGKNix5DHNA3fiMVNJDHQbkHGWKP8tTppUGFXp+C6XH9VSLBuZiQbI0qYZYVC7QFREKXbFWjUCPp8EfJ26pxwjkDWeLMSEuo+ulRK7LSKvYNk3fdCtyfu1ZitlgWB2HcdXF8H1DcfvdNKhkfQCbOFUICt75xYfrdnZKdak83MmVpOiZBX1iXZNKbhGa7y8tUSTQD1jxJTcaS4zddUukT3k5bn0A0RqgbMabtoo57a9wkzKwMjExOyap1TVMe8Y5fjoT6puDKJOU+TT0UwlnqKz3LwjyT1qU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4150.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(396003)(39860400002)(376002)(136003)(346002)(478600001)(6512007)(36756003)(316002)(44832011)(4326008)(107886003)(83380400001)(2616005)(76116006)(7416002)(66946007)(66476007)(54906003)(186003)(5660300002)(38100700002)(6486002)(8936002)(66446008)(122000001)(6506007)(53546011)(38070700005)(66556008)(2906002)(64756008)(26005)(71200400001)(33656002)(8676002)(86362001)(6916009)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ak1ydmV4SXIxbEpxakNrTXZPdHptN0wzdUVMdk9FWEtvaHBzeW1paldNVlF0?=
 =?utf-8?B?NGNTazdQc1hpSFEwSk1VWk9Rb1ZXcExkOEFubEduZDAxVkhNMWRpT1dyQ3I5?=
 =?utf-8?B?VU5hcmlTVUY5UE1mM3VvQWtPVVRlNFd0L1owQ1o1TVlQL3FBenJZTnhGMVFV?=
 =?utf-8?B?WW9HY2w1QkVqMERzaDFCbVdqTGxKL1B5ejE4SnNWZXpIcDVVZnp3WUhQREc4?=
 =?utf-8?B?NGdKRDdQZFVCTm1CTmxPU3hJbm1BV0lpNkl5QzhaZ0xaMEMyOEpqVkZBWEw1?=
 =?utf-8?B?OFovUHA2UkJXaGw0MXIwb0lteVRuS0UralNadTFUOUNkVWpaVzlUZ1ZKaHZq?=
 =?utf-8?B?V21hVnNLTjRrWC9lTjhQckV6emZacUVpbDI1T29MY3dLdHE0cUJjbEc2dEdk?=
 =?utf-8?B?aS9hWW5uNW9kV1l0ZmE0L0pKOFRnc1o5U095SnkvREtvYzlLUGxEZW03TFFy?=
 =?utf-8?B?ODBscFBzeE94SnJjbjNUbTJpSWEraUdwcGZ0aFZjRVZPTWFiRjhVR24rTDRR?=
 =?utf-8?B?Sk1FcmJlRGhQSVlhV0s1bzIyZDlZWDFrY1hGVE1QMEVmbmVCTEVSMytteEZr?=
 =?utf-8?B?RzU2bU1LL1preFVWYkROSnVTMHloV2dCT2hoVVh3aUxKWCt2VGMxcEJjOFkr?=
 =?utf-8?B?bmIyS0NKQWFwYUpaOFlWMnpNeGo3U2tuNkdsK3N0MkJnZ1RaNnZuQ0ovTkty?=
 =?utf-8?B?RXpra1JNbHplcG8vYkRlbGxkek5kbGVzWnFvRWN4UmxDeGNOQ1l0QWhQMks1?=
 =?utf-8?B?TTNZSWlmMWxQUm1QN3FDZHVsWXBVWGNaU2VqSEh5K1crNVZMbGNCN1RNcTgv?=
 =?utf-8?B?TEdESlhGRWVybVloNWNTZmZsVDRxeWd0WU9yclZBNEhpVXdjMjUxRzVSOTZR?=
 =?utf-8?B?RG5QcHJ4anhORHFnam5zcUpNOVlMZVI2c0EzSG9lc2RucjZxV3F0SHZIWDdJ?=
 =?utf-8?B?UXVYOWlKK2VTVW1zTnZtRm1SQUVFQjIrSHIycVlLZkY4eFh5UzRoK0xDa3hX?=
 =?utf-8?B?U0tnMjJXTHNibUpPNFVzVFVNdUFrRVlkNGhSRTg2U3VaOGNlQTZTRjZJdkZ0?=
 =?utf-8?B?STBjRERENWpDNG4xT3c0UnB3T0h2TUJaMGswUng5UkVmTXYyT2s4QjdhSk55?=
 =?utf-8?B?TUF3L0hkSFhOTUdlZk9WV3Qxbm1TWjNCeU9GeFZ1RjNudWFndU5zYnpyUkNh?=
 =?utf-8?B?cVpnSXRoUDB5a1AxWnQvNmJ4SXo2Y2MyQTZTYzlwSHRQYWI1WWs4d2lYZC9R?=
 =?utf-8?B?bFF0QnpwRTFXL21nQk9VNXVXMmF2SEVDTU9nME11RklIRnBaR3hBMDhLeGhk?=
 =?utf-8?B?Zk9oVkhvbFlYZEE4YUN0OUxLQ2xBaUVoU2JkUXM0OGxRcnBKQXRacHNKWWZP?=
 =?utf-8?B?N0dlSmxUdTd3bldJbEozZWM2TmxDaW9XVGRXTE5qN1d2cXovdU1KYjV0eUZO?=
 =?utf-8?B?eEQrUFRDQTQ2TXdrNVlEeFdCNHVudjZoQXNxeFp5T3pSMHo4RkNxTWxWWEdw?=
 =?utf-8?B?T2hxYkRsVTF3eW1GWjc2ekgwaHlKcnlKNVJZRlZ0NGtMb0tkYzI0MWVYTTFu?=
 =?utf-8?B?VFFHTXgrcnJDbjhXcHdKYlZiL3Z2ajV6ZGdudHhmc1NxVldUTTR3Y0pxaTg2?=
 =?utf-8?B?RzFzbUhQU0h5ODlpL1o2NUgzMU9oZnVmWERPSlArUS9LSUVySDlpTkdJTGRL?=
 =?utf-8?B?YkliallsVWtYYnFseHdYRS9jdk5zSWhkblRYdFdTN2lBODZDcU1IVjNMRmdE?=
 =?utf-8?Q?Dm+o6Fy2sYdIfAhvVuEJBBeDZRDx7oFEh5K9mge?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1DBC5B08017F9441898C5F7C2BF9F9A1@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4150.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 000eaaad-f28f-448d-8003-08d956f38757
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Aug 2021 02:56:59.6211
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: e928jYlYm4zLJ96OZlGNqkFnKv+6iBZFm0Jjnd0jtmPElshdq+5UxqjEIhW19CFOhKKNSyBw155OmWw8p0zuzNLqKiDL+7ixfVclV46W4oI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5210
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10065 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0 malwarescore=0
 suspectscore=0 mlxscore=0 adultscore=0 mlxlogscore=999 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108040015
X-Proofpoint-GUID: WrS2UdJBfOUM5G1sYTStYK3C0St8cJK1
X-Proofpoint-ORIG-GUID: WrS2UdJBfOUM5G1sYTStYK3C0St8cJK1
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

DQoNCj4gT24gQXVnIDMsIDIwMjEsIGF0IDc6MTQgUE0sIE1pbWkgWm9oYXIgPHpvaGFyQGxpbnV4
LmlibS5jb20+IHdyb3RlOg0KPiANCj4gT24gVHVlLCAyMDIxLTA4LTAzIGF0IDEzOjUyIC0wNjAw
LCBFcmljIFNub3diZXJnIHdyb3RlOg0KPj4+IE9uIEF1ZyAzLCAyMDIxLCBhdCAxMTowMSBBTSwg
TWltaSBab2hhciA8em9oYXJAbGludXguaWJtLmNvbT4gd3JvdGU6DQo+Pj4gDQo+Pj4gT24gTW9u
LCAyMDIxLTA3LTI2IGF0IDEzOjEzIC0wNDAwLCBFcmljIFNub3diZXJnIHdyb3RlOg0KPj4+IA0K
Pj4+PiBXaGVuIHRoZSBrZXJuZWwgYm9vdHMsIGlmIE1va0xpc3RUcnVzdGVkUlQgaXMgc2V0IGFu
ZA0KPj4+PiBFRklfVkFSSUFCTEVfTk9OX1ZPTEFUSUxFIGlzIG5vdCBzZXQsIHRoZSBNb2tMaXN0
UlQgaXMgbG9hZGVkIGludG8gdGhlDQo+Pj4+IG1vayBrZXlyaW5nIGluc3RlYWQgb2YgdGhlIHBs
YXRmb3JtIGtleXJpbmcuIE1pbWkgaGFzIHN1Z2dlc3RlZCB0aGF0DQo+Pj4+IG9ubHkgQ0Ega2V5
cyBvciBrZXlzIHRoYXQgY2FuIGJlIHZvdWNoZWQgZm9yIGJ5IG90aGVyIGtlcm5lbCBrZXlzIGJl
DQo+Pj4+IGxvYWRlZCBpbnRvIHRoaXMga2V5cmluZy4gQWxsIG90aGVyIGNlcnRzIHdpbGwgbG9h
ZCBpbnRvIHRoZSBwbGF0Zm9ybQ0KPj4+PiBrZXlyaW5nIGluc3RlYWQuDQo+Pj4gDQo+Pj4gSSBz
dWdnZXN0ZWQgb25seSBsb2FkaW5nIHRoZSBDQSBrZXlzIHN0b3JlZCBpbiB0aGUgTU9LIGRiIG9u
dG8gdGhlIE1PSw0KPj4+IGtleXJpbmcuICBMaWtlIHRoZSBidWlsdGluIHRydXN0ZWQga2V5cmlu
ZywgdGhlIE1PSyBrZXlyaW5nIHdvdWxkIGFsc28NCj4+PiBiZSBsaW5rZWQgdG8gdGhlIHNlY29u
ZGFyeSBrZXlyaW5nLiAgIEFzc3VtaW5nIHRoZSBzZWNvbmRhcnkga2V5cmluZyBpcw0KPj4+IGRl
ZmluZWQsIGFsbCBvdGhlciBwcm9wZXJseSBzaWduZWQgTU9LIGRiIGtleXMgIC0gc2lnbmVkIGJ5
IGtleXMgb24gdGhlDQo+Pj4gYnVpbHRpbiwgc2Vjb25kYXJ5IG9yIE1PSyBrZXlyaW5nIC0gd291
bGQgYmUgbG9hZGVkIG9udG8gdGhlIHNlY29uZGFyeQ0KPj4+IGtleXJpbmcuDQo+Pj4gDQo+Pj4g
QXMgcHJldmlvdXNseSBkaXNjdXNzZWQsIHRoaXMgbWlnaHQgcmVxdWlyZSByZWFkaW5nIHRoZSBN
T0sgZGIgdHdpY2UgLQ0KPj4+IG9uY2UgdG8gbG9hZCB0aGUgQ0Ega2V5cyBvbiB0aGUgTU9LIGtl
eXJpbmcsIGEgc2Vjb25kIHRpbWUgdG8gbG9hZCB0aGUNCj4+PiByZW1haW5pbmcgcHJvcGVybHkg
c2lnbmVkIGtleXMgb250byB0aGUgc2Vjb25kYXJ5IGtleXJpbmcuDQo+PiANCj4+IEnigJltIG9u
bHkgbG9hZGluZyBDQSBrZXlzIG9yIGtleXMgdGhhdCBjYW4gYmUgdm91Y2hlZCBmb3IgYnkgb3Ro
ZXIga2VybmVsIA0KPj4ga2V5cyBpbnRvIHRoZSBuZXcgbW9rIGtleXJpbmcuDQo+IA0KPiBUaGUg
Y292ZXIgbGV0dGVyIGltcGxpZXMgdGhhdCB0aGlzIHN1Z2dlc3Rpb24gaXMgY29taW5nIGZyb20g
bWUsIHdoaWNoDQo+IGl0IGRlZmluaXRlbHkgaXMgbm90LiAgTXkgcHJlZmVyZW5jZSwgYXMgSSBt
YWRlIGNsZWFyIGZyb20gdGhlIHZlcnkNCj4gYmVnaW5uaW5nLCBpcyB0byBsb2FkIE9OTFkgdGhl
IE1PSyBEQiBDQSBrZXlzIG9udG8gdGhlIG1vaw0KPiBrZXlyaW5nLiAgIChBbmQgZXZlbiBnbyBv
bmUgc3RlcCBmYXJ0aGVyLCByZXF1aXJpbmcgdGhlIE1PSyBEQiBDQQ0KPiBrZXkocykgdG8gYmUg
aWRlbnRpZmllZCBvbiB0aGUgYm9vdCBjb21tYW5kIGxpbmUuKQ0KDQpPaywgZ290IGl0LiAgSSBn
dWVzcyBJIG1pc3VuZGVyc3Rvb2QgYW5kIHdhcyB0aGlua2luZyBidWlsdC1pbiBzaG91bGQgYmUg
DQpyZWZlcmVuY2VkIHRvbyBmb3IgdGhpbmdzIGdvaW5nIGludG8gdGhlIG5ldyBtb2sga2V5cmlu
Zy4NCg0KPj4gQ3VycmVudGx5LCBJ4oCZbSBub3QgZG9pbmcgYW5vdGhlciBwYXNzLiAgSSANCj4+
IGNvdWxkIGFkZCBhbm90aGVyIHBhc3MsIGJ1dCBpdCB3b3VsZCBub3Qgc29sdmUgdGhlIGlzc3Vl
IHdpdGggc29tZW9uZSB0cnlpbmcgDQo+PiB0byBsb2FkIGFuIGludGVybWVkaWF0ZSBDQSBhbG9u
ZyB3aXRoIGEgbGVhZiBjZXJ0LiAgVGhpcyB3b3VsZCByZXF1aXJlIHlldCANCj4+IGEgdGhpcmQg
cGFzcy4gIEkgd2FzbuKAmXQgc3VyZSBpZiB0aGlzIGFkZGVkIGNvbXBsZXhpdHkgd2FzIG5lY2Vz
c2FyeS4gIA0KPj4gDQo+PiBDdXJyZW50bHksIGFueSBDQSBjb250YWluZWQgd2l0aGluIHRoZSBN
T0sgZGIgd291bGQgbm93IGJlIHRydXN0ZWQgYnkgdGhlIA0KPj4ga2VybmVsLiAgU29tZW9uZSB1
c2luZyBhIGtlcm5lbCB3aXRoIHRoZSBzZWNvbmRhcnkga2V5cmluZyBlbmFibGVkIGNvdWxkIA0K
Pj4gbG9hZCB0aGUgaW50ZXJtZWRpYXRlIGFuZCBsZWFmIGNlcnRzIHRoZW1zZWx2ZXMgZm9sbG93
aW5nIGJvb3QuDQo+IA0KPiBDb3JyZWN0LCBhcyBwcmV2aW91c2x5IGRpc2N1c3NlZCwgdGhlIG90
aGVyIHNpZ25lZCBNT0sgREIga2V5cyBtYXkgYmUNCj4gbG9hZGVkIGJ5IHVzZXJzcGFjZS4gICBU
aGUgb25seSByZWFzb24gd2UncmUgaW50ZXJlc3RlZCBpbiBhbnkgb2YgdGhlDQo+IG90aGVyIE1P
SyBEQiBrZXlzIGlzIHByZXZlbnQgYSByZWdyZXNzaW9uLiAgQXMgeW91IHByZXZpb3VzbHkgcG9p
bnRlZA0KPiBvdXQgYWxsIG9mIHRoZSBNT0sgREIga2V5cyBhcmUgY3VycmVudGx5IGJlaW5nIGxv
YWRlZCBvbnRvIHRoZSBwbGF0Zm9ybQ0KPiBrZXlyaW5nLiAgU28gbGVhdmUgdGhlIGV4aXN0aW5n
IGNvZGUsIHdoaWNoIGxvYWRzIHRoZSBNT0sgREIga2V5cyBvbnRvDQo+IHRoZSBwbGF0Zm9ybSBr
ZXlyaW5nLCBhbG9uZSB0byBwcmV2ZW50IHRoYXQgcmVncmVzc2lvbi4gIEl0J3MgYWxyZWFkeQ0K
PiBiZWluZyBjb250cm9sbGVkIGJ5IGEgVUVGSSB2YXJpYWJsZS4NCg0KV2l0aCB0aGlzIHNlcmll
cywgSSBkbyBub3QgYmVsaWV2ZSBhIHJlZ3Jlc3Npb24gZXhpc3RzLiAgV2l0aCBhIHNpbmdsZSBw
YXNzLCANCmtleXMgYXJlIGVpdGhlciBsb2FkZWQgaW50byB0aGUgbW9rIG9yIHRoZSBwbGF0Zm9y
bSBrZXlyaW5nLiAgU2luY2UgdGhlIG1vaw0KaXMgbGlua2VkIHRvIHRoZSBzZWNvbmRhcnkgKG9y
IHRoZSBidWlsdC1pbiksICBkdXJpbmcga2V4ZWMgc2lnbmF0dXJlIHZhbGlkYXRpb24sDQphbGwg
a2V5cyBhcmUgcmVmZXJlbmNlZC4gDQoNCj4+IFRha2luZyANCj4+IHRoaXMgaW50byBhY2NvdW50
LCBpZiB5b3XigJlkIGxpa2UgdG8gc2VlIHR3byBwYXNzZXMsIGxldCBtZSBrbm93IGFuZCBJ4oCZ
bGwgYWRkIA0KPj4gdGhhdCBpbiB2My4gIElmIGEgc2Vjb25kIHBhc3MgaXMgZG9uZSwgZG8geW91
IHJlYWxseSB3YW50IHRoZXNlIGFkZGl0aW9uYWwgDQo+PiBrZXlzIGFkZGVkIHRvIHRoZSBzZWNv
bmRhcnkga2V5cmluZyBvciBzaG91bGQgdGhleSBnbyBpbnRvIHRoZSBtb2sga2V5cmluZw0KPj4g
aW5zdGVhZD8gIEkgd2FzIHVuZGVyIHRoZSBpbXByZXNzaW9uIHRoZSBzZWNvbmRhcnkgc2hvdWxk
IGJlIGVtcHR5IHVudGlsIGENCj4+IHVzZXIgYWRkcyB0aGVpciBvd24ga2V5cyBpbnRvIGl0LiBU
aGFua3MuDQo+IA0KPiBBZ2FpbiwgbXkgcHJlZmVyZW5jZSB3b3VsZCBiZSB0byBsb2FkIE9OTFkg
dGhlIE1PSyBEQiBDQSBrZXlzIG9udG8gdGhlDQo+IG1vayBrZXlyaW5nLg0KDQpPaywgSeKAmWxs
IHVwZGF0ZSB0aGUgY3VycmVudCBjb2RlIHRvIGp1c3QgbG9hZCBDQSBrZXlzIGludG8gdGhlIG1v
ayBpbiB2My4gIFRoaXMgd291bGQNCnNpbXBsaWZ5IHRoZSBuZXcgcmVzdHJpY3RfbGlua19ieV9j
YSBmdW5jdGlvbi4gDQoNCldpdGggdGhhdCBjaGFuZ2UsIGRvIHlvdSBzZWUgYW55IGlzc3VlcyB3
aXRoIGhvdyBJ4oCZbSBkb2luZyB0aGUgbGlua2luZz8gIFdpdGggdGhlIA0KbW9rIGtleXJpbmcg
bGlua2VkIHRvIHRoZSBzZWNvbmRhcnkga2V5cmluZywgdGhlIHBsYXRmb3JtIGtleXJpbmcgbWF5
IG9ubHkgY29udGFpbiANCmEgc3Vic2V0IG9mIHRoZSBrZXlzIGl0IG9yaWdpbmFsbHkgY29udGFp
bmVkLiAgQnV0LCBhcyBJIGRlc2NyaWJlZCBhYm92ZSwgSSBkb27igJl0IGJlbGlldmUNCml0IHdp
bGwgbGVhZCB0byBhIHJlZ3Jlc3Npb24gc2luY2UgYWxsIGtleXMgZ2V0IHJlZmVyZW5jZWQuIFRo
YW5rcy4NCg0K
