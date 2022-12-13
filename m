Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C96064ADDB
	for <lists+linux-integrity@lfdr.de>; Tue, 13 Dec 2022 03:42:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234274AbiLMCmW (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 12 Dec 2022 21:42:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229690AbiLMCmO (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 12 Dec 2022 21:42:14 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F23FFF4;
        Mon, 12 Dec 2022 18:42:08 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BD1NXqf010473;
        Tue, 13 Dec 2022 02:41:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=z0Aobqa7G8red1K9BtaVHmr9gQa2RC/hAcNSSsvyIgI=;
 b=pEKPBxpk5wZh4kDHY22Kf8YwxpEQ9INDSzKkZeif/daNqa1BNvqvdkLPJ7x29bYMYlAg
 vMsBnAN30NZ71XqGdqVLm5YoV+jD7TFhxaKF2W5rLGTQo/W3Q1Z1sKtLBIKpqmHh1UFr
 t1uCywL4VnABPZ/IXDhiKMj+EFu5xcx8rHPJ1tkhy20QZgLCNHPyoYBq7bKx27yulX8h
 WAyeQ6sHbqpCCzwsAnA4fqUKERjsfts9y542qOoIjJ/2R4vsxMO6uzkuFULuIH+s4KUl
 5hycJl/g0/Ab94IiUTOG3HBcQeAMetpJ84ovjm2LmMKZsom64ae8gEnqZf141L9Gc5YF Ag== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3mcgq0cd6p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 13 Dec 2022 02:41:27 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2BD0mCa7018570;
        Tue, 13 Dec 2022 02:41:26 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3mcgjbhhuj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 13 Dec 2022 02:41:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OjXEMu2faH5o8rFC6CHsPAjWf/n+raEgejjyt4KtRbVBazWsCE50UBUkFiRN95fVMwsyMi3iGsyOlkEOOTyKYGlG8M3aTv8C05Ha7UyB9A8VQAbVjQQa0bD0kYSKpHzRbNfO/DEisdVZGK+azFEYpLpI5j2mRcYYfIaK8oc0GMV8xPhaOL62TkpCaeEJPjqENoPL4a+k8HLoyy8NR/xtS0jPkaTC3e4doby3WKEdlm5GVwbiYjAVBxk+TIUvhyG5LfQgO73q9PJK3nx2vEK3qxuFn2EQNau3wjsx40yfoTui5J2C4vmbmX5qP4E1s0v+8UAxEi7t+CV+zJJW1Q9kxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z0Aobqa7G8red1K9BtaVHmr9gQa2RC/hAcNSSsvyIgI=;
 b=UzMUo6HpPhCm6eMGnIh/0AyCS9YxqUgXXoE5i/zAKe0DIXlxMuPm0I9HeoMPBg8RJvIhXO0Ap3C42RQZ63cKsCsDB771Z3ZhoX5aGcy/3JIgsGQfM9cZHU3IXvQegRHR8B/PZcjpnB8nxyMfvCk7rCu4ZU46i+udUw7j3vnbm2tYD5ldOBS6IBTqNzvc4YsGzBMeEStdk1wPPJ6vezL2ROm6eahRQT8zNDOeVKsk797aCU4YX7V4f2ZCekE/0stIoBCNlL8YlTHN3dwe00pX3M/qbY3O/NqK0VC0zF5jO+gC/sDRZlHdi4IiPe8jxoGjW3nYyVkVBZafIHYDklxe5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z0Aobqa7G8red1K9BtaVHmr9gQa2RC/hAcNSSsvyIgI=;
 b=JJhCeOocftOtv/kupmQkCS8oPQiWubjOXrhRLK89Wv6wsKq8HRPKpeJUGsUnbOy86aVes/iwCwyYtnI/Vl4jfdAnS1lESqJrf0PTP7h9yJtKhs1VRlSnyQjaiQZtoOhsMg2fQr0dASrPznhW5ld9yoJuJDDmqTRN7dDG4vq/ICg=
Received: from CH2PR10MB4150.namprd10.prod.outlook.com (2603:10b6:610:ac::13)
 by CY5PR10MB5964.namprd10.prod.outlook.com (2603:10b6:930:2b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.19; Tue, 13 Dec
 2022 02:41:23 +0000
Received: from CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::f006:f411:9056:63a4]) by CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::f006:f411:9056:63a4%4]) with mapi id 15.20.5880.019; Tue, 13 Dec 2022
 02:41:23 +0000
From:   Eric Snowberg <eric.snowberg@oracle.com>
To:     Mimi Zohar <zohar@linux.ibm.com>
CC:     Coiby Xu <coxu@redhat.com>, Jarkko Sakkinen <jarkko@kernel.org>,
        David Howells <dhowells@redhat.com>,
        David Woodhouse <dwmw2@infradead.org>,
        "herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "dmitry.kasatkin@gmail.com" <dmitry.kasatkin@gmail.com>,
        "paul@paul-moore.com" <paul@paul-moore.com>,
        "jmorris@namei.org" <jmorris@namei.org>,
        "serge@hallyn.com" <serge@hallyn.com>,
        "pvorel@suse.cz" <pvorel@suse.cz>,
        "noodles@fb.com" <noodles@fb.com>, "tiwai@suse.de" <tiwai@suse.de>,
        "bp@suse.de" <bp@suse.de>,
        Kanth Ghatraju <kanth.ghatraju@oracle.com>,
        Konrad Wilk <konrad.wilk@oracle.com>,
        Elaine Palmer <erpalmer@linux.vnet.ibm.com>,
        "keyrings@vger.kernel.org" <keyrings@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>
Subject: Re: [PATCH v2 00/10] Add CA enforcement keyring restrictions
Thread-Topic: [PATCH v2 00/10] Add CA enforcement keyring restrictions
Thread-Index: AQHZCl8bkpg6/vUjKkKDWz2KOwAYDq5lXJMAgABY3gCABRubAIAAUvsA
Date:   Tue, 13 Dec 2022 02:41:23 +0000
Message-ID: <31AEC478-DEF9-49EC-AF4B-E7189E027A49@oracle.com>
References: <20221207171238.2945307-1-eric.snowberg@oracle.com>
 <20221209102612.wa3oftpqupzplx6h@Rk>
 <5AF81A9E-C4E7-4BEB-86E1-4D2DB613FBF1@oracle.com>
 <d9060f9765e59b5fd46c9f7c6a8682a29e712120.camel@linux.ibm.com>
In-Reply-To: <d9060f9765e59b5fd46c9f7c6a8682a29e712120.camel@linux.ibm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH2PR10MB4150:EE_|CY5PR10MB5964:EE_
x-ms-office365-filtering-correlation-id: 98d0415d-95a4-4187-700c-08dadcb38646
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: seX3+xlOHuHqJ8qUCEaWJ63Rk7e7DofoEhLSsAPUbVF9h4T+rnd6XIbnYb2kqcVQ5YUCAa+qgchO2FnJFO+D87E06jbBs1H52/G+Zx6peYGJP3LbwTF7pLxFUzJVAP9hWO4cVyndJDlafYpRiLXDnWEZ3cHuxZdhib0Z2hKgwmronINTPuyBA9srBKImE8zvIUshtwjUTqVTRB+s3NlT+CdMbPkntaAyoN0T5MQ2oE/IXe2gRF+8IGS2SIq/osNrtGVIsTof7ZNSWeR2R74AicwGOaOsi112ye0EwN5rw9WlhmI00TxZjcYd2SIjQDPe15GdmVQujhaCnXYgitaop929oQu0MBWwfw0iF3E7/b5FXvVS2pJb7Yg4x1tgNUy9gVO+9Pk4aEGGOVis3DKXTMT3I7aE729xKHCoa0dBpHSNu7v5HFPqwPqWfXjvXGuQDk7L/8PKGWE31PaavJSgoAkJKedNnwupTstwmqeITuJ17cgi3FlqnDJAJMDhgHSZgjm/EWqknLrr9LJqdFwcZdRTgFOjIOk74TMFJIHXBO2E9uRTlk8/BBUKsXH16L2j+gBKber39xnQYY3sp3h3O7lv6s4BadJLI/AzIh2QtkYwOnJjpxuNwongN7kxFjQ0Xen2rY4BbNj/yMeX9jbNBqRbAlovgb7L7Zq1UcPzfQDCDDGsK2Xj/6oF9En6k/5cfLK8Ll2C7OJa1wozTAY7Ai+HOUB4a5APvOVn1qoieBM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4150.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(376002)(346002)(396003)(39860400002)(136003)(451199015)(33656002)(66946007)(6506007)(86362001)(53546011)(83380400001)(54906003)(6486002)(26005)(6512007)(6916009)(186003)(478600001)(41300700001)(38070700005)(7416002)(8936002)(91956017)(5660300002)(44832011)(2906002)(71200400001)(38100700002)(66446008)(66556008)(64756008)(8676002)(2616005)(66476007)(4326008)(76116006)(316002)(122000001)(36756003)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?WMx7EENuf6lgzoTBGQVe+FkJrzTq6XHAT31f1f0VnRdhkvWxwitSWSpJNJP9?=
 =?us-ascii?Q?8EkMr2mqN6IZI6wGzWnRD/N70rvVV+otXDbqa++eMX1pmVaipuH/XCqQzfv0?=
 =?us-ascii?Q?qqkNPUv5viCBJnEjn/LmhUUdHYDeU3JGiKcM2edcCj6/OKIkJhMfG06NZLvV?=
 =?us-ascii?Q?djKBQVPsq0LNFNL2sZ4RxdY0NIrIz+q9uzP4rLIuHOP28s/Twk5xoIiIEqZT?=
 =?us-ascii?Q?49N0kWX/Q5ZCwsHBGrZHCSLGN5nQW8Ix49fqxcUjYb6r4XHoZ3lJ69vpecsx?=
 =?us-ascii?Q?8PYD+5LuOvDfng4uuQRuQQ6sxjTygLZlln+soJdybH65Uq49bC/etFrhnixk?=
 =?us-ascii?Q?i7mEMAQlD3tusgNtppYeNAfWrqdsPA+ob3C/YRTuIBossIAQlmuHWtBqdfxa?=
 =?us-ascii?Q?xr2G67u5OKb+jRNKyIIqGYnf4Sszbzvcn5ttTfuMlV7iOzY0jh6NBI9HKMYr?=
 =?us-ascii?Q?ggAQoZOfzXfKr5z83W0RNlDQWiMfZsbekANovUyFYq/SWAw5ifdHo2gH7ekD?=
 =?us-ascii?Q?BGDSfMEtkncFtmx73tJzgsds+vOOIiEgCIy01COxu+o+qhEtNr+fjO99YJl3?=
 =?us-ascii?Q?ew7vW+5pVC7tdm2LQEP4Gu49keRJwGDNkUtCHabbZCZb3im7FLHcbfev+9Do?=
 =?us-ascii?Q?UplfIwm5fbgK9yMlVoCvYt3/rz+6O81Kzu0olMvmBnV0GHX2FltRP4vJiioz?=
 =?us-ascii?Q?YUJm7EHQeZPuVbOKCUZmJ7/G56iefslP+hrGc57LouJQSMWuwEsfDZNXHP9F?=
 =?us-ascii?Q?vLU5/vCAorgRJL/3zMMrUZjhxAs9/7uWn5irk8busz1cjqpJ76b2KzRxNfsY?=
 =?us-ascii?Q?t1liS6vJ7BbEd99vwTeF+Y8Xi8Ka1BHeb4dIeRVkNdZpfxtWhHriXHyH9pgZ?=
 =?us-ascii?Q?kCqG1s36N8SHw2OCa88Oc6WkudxOTd7rN/BBq92FZOGxfwGyDYDMany7JjNu?=
 =?us-ascii?Q?o39oyRoJoUDiw8B8wGRcgF/Hs4NbdiNHtXMZihcJfXgcmOmdFRjW0Y914sDH?=
 =?us-ascii?Q?hyFqpW2PvcDbenDcop+jxJWdbWpVZIhRgwim+bziyouACbD22ONsaMHlwZF1?=
 =?us-ascii?Q?0D6F0TKfQIiAsqoxwES8VpASu2z37nN3c70MVTVs4BIp/wkq/kCc9guWBwC9?=
 =?us-ascii?Q?uu0/jMhLHNmFr62v6T7IHemOrtToNteb6UtqqWKeeCHs0G4FPPcCnn0YN3KG?=
 =?us-ascii?Q?sJ5D7v+ylLbErvrMYwNJ85ktgTzQYTMiaJgxjjbMhILB3f5ObJv3UQ5G79R2?=
 =?us-ascii?Q?4yc4GGKKd38RkgGDtNHGPP9SBO2q9KHqUZv0vT/lFI/G3crFaA1C320Dexxf?=
 =?us-ascii?Q?L/XANcthZSClQ08Ou5n/dXsIJjsCzlCyMLUIQQqr02iqg5iIfEemcYkGnHq7?=
 =?us-ascii?Q?4L/tMLKeVQVPzcVmgnAHwFToiEJ1MLmt7vKWk0t89Qlf66CNVUIlWt8uLvNI?=
 =?us-ascii?Q?+0ZfmV2zTuZbp74Wzd2kQgR0FU7xKvOP9DHexKJRWO6UsCEDc0iP/la1NuGU?=
 =?us-ascii?Q?NRYPa4g6V/zR/Cj7JSK/Qq+BznfhO0QSd1YFO+y3UbqqIb7XSL46QUmb8Ykv?=
 =?us-ascii?Q?u0YYns9/ACdVFeO/WT40nfyRkAV9WuQ+eFttX91AgSEWnftivmQvpgtXO2kc?=
 =?us-ascii?Q?Og=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <6994071301C04346BB1A5AACFFD27BFA@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4150.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98d0415d-95a4-4187-700c-08dadcb38646
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Dec 2022 02:41:23.6053
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HR7QgXxJvgAxyvq3A2Ltz//W9ReubOc6rUOyagy49Yvx8UyEg6V5tO7+4nd5q9H0BdFXrso8pfntlzLk+OOyatmfaer4Dk9jhPq5M/3yOCI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB5964
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-12_08,2022-12-12_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0 mlxscore=0
 mlxlogscore=999 malwarescore=0 spamscore=0 phishscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2212130024
X-Proofpoint-ORIG-GUID: EolK0HH6PobEpAcMkxmhSEgiMslTtb3D
X-Proofpoint-GUID: EolK0HH6PobEpAcMkxmhSEgiMslTtb3D
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org



> On Dec 12, 2022, at 2:44 PM, Mimi Zohar <zohar@linux.ibm.com> wrote:
>=20
> Hi Eric, Coiby,
>=20
> On Fri, 2022-12-09 at 15:44 +0000, Eric Snowberg wrote:
>>> On Dec 9, 2022, at 3:26 AM, Coiby Xu <coxu@redhat.com> wrote:
>>>=20
>>> Thanks for your work! The patch set looks good to me except for the
>>> requirement of an intermediate CA certificate should be vouched for by =
a
>>> root CA certificate before it can vouch for other certificates. What if
>>> users only want to enroll an intermediate CA certificate into the MOK?
>>=20
>> This question would need to be answered by the maintainers.  The interme=
diate=20
>> requirement was based on my understanding of previous discussions requir=
ing
>> there be a way to validate root of trust all the way back to the root CA=
.
>=20
> That definitely did not come from me.  My requirement all along has
> been to support a single self-signed CA certificate for the end
> user/customer use case, so that they could create and load their own
> public key, signed by that CA, onto the trusted IMA/EVM keyrings.
>=20
>>=20
>>> If this requirement could be dropped, the code could be simplified and
>>> some issues could be resolved automatically,
>>=20
>> Agreed. I will make sure the issue below is resolved one way or the othe=
r,
>> once we have an agreement on the requirements.=20
>=20
> I totally agree with Coiby that there is no need for intermediate CA
> certificates be vouched for by a root CA certificate.  In fact the
> closer the CA certificate is to the leaf code signing certificate, the
> better.  As much as possible we want to limit the CA keys being loaded
> onto the machine keyring to those that are absolutely required.

Ok, I will change this in the next round.  The confusion around the require=
ment=20
comes from the request to validate the cert is self-signed.  The intermedia=
te in this
case will not be self signed.  As long as this check is not necessary, I wi=
ll drop it from
the code and allow the intermediate to vouch for the ima key without the ro=
ot being=20
present.  Thanks for clearing this up.

