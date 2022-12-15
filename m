Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67A9464E377
	for <lists+linux-integrity@lfdr.de>; Thu, 15 Dec 2022 22:46:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229636AbiLOVqM (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 15 Dec 2022 16:46:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbiLOVqK (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 15 Dec 2022 16:46:10 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA1A314020;
        Thu, 15 Dec 2022 13:46:07 -0800 (PST)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BFL3goN028003;
        Thu, 15 Dec 2022 21:45:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=vr6dQhsnrUzsbvKu7DPi7CQjlNopj17Ddj1ugUG7vvQ=;
 b=j1WBpNKXlaUlrWTL+wa7b033/WGf3YTJSL+sCeNpBBZI9ulOm2RuvEAEgIDZmoXEjEFE
 ZIvMF2JDJcig+QfrvAEEW+EUFtBo3SNV9rKYeVyLRTjxv3OCCwAQCv92oZDi3xz56hSD
 jKsEUXYbRtXBzzFhw/nbcaWvycWPDiZt/213fZvDonpVwh3VhL1y7BqV4o3wMRyL1Oyx
 4GSt09gsFkEbOpuMBl5qHt0JEBorsHTvVs7Oct8rGxZQ/JrVU1ZdDZnBL5sCdyi/qwVo
 sSkfmBajFZHMSvRoFIDKnQETzVUFpXI8J5hhTxF6oo+bP5sl755Kt+oooWt6baRQ5LGw 9Q== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3meyeu6bnh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 15 Dec 2022 21:45:41 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2BFKxE3B010004;
        Thu, 15 Dec 2022 21:45:40 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2109.outbound.protection.outlook.com [104.47.70.109])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3meyepnjtn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 15 Dec 2022 21:45:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BlL3F1H3a5Q9x9+PDrbxayfoNwecdnKpBIG2zyOLujq5/B9mylCSTQlRLo8TkNlrlChp8ouUsfmutURWZjaunBQ/onQnoLUlGdunanD65xb+db6c8F4rH40LiIi4taEdbpsz0nnU9lXPCTgOPJgpHDC310ytDPzBiyw8XCTEx8ib+KE2r9kFTnjfb22v649X8uluOR+lwGM2rMsGAKXYLSw04vWe9UV7AArGY9mXJ4c2T5CY4xCQxES90dDt94NMtmQY1gFVknuK1IfCEh8ntnX9J9N7QhX4puqoLftsoqDJu9KSecoIGVu+qohqoRAc8+X1k/SgnRJHoovangEwSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vr6dQhsnrUzsbvKu7DPi7CQjlNopj17Ddj1ugUG7vvQ=;
 b=PyfyES+xYn+ZmXfX1u50RGeYbSkFEi2s/RLLCgkyCaSCGq2zXHnpeSl1wZpY4yZR8k95i7qqan8Pm9pGS1/KBVTJPup/J3mPVS+IXcoR3wdoTBnUPMqwBoDky/pAsienOSQXholnZdeK9e5vfMIM5edJe8BOMCJ3kHLzMcCaKcctaiAUils+o0Bbhn8PpvuGtlSkL1pXVxItxGWp1aAKsEg+bnegT8mDSyj0yOmxYdLypbYL+9ocFF03vPN41Al7h5sRdPvMkTotd6s80uYaWy/uOkD5POJkjg9uTldDVgIj5iTfMFgzlXEh9/7jt5CcwJTKsKS8/m7AHgAHtGjhRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vr6dQhsnrUzsbvKu7DPi7CQjlNopj17Ddj1ugUG7vvQ=;
 b=MB3bHYsEzhijYrYwpC5kxSXLA1J8uu4noJaw4a/XrYizS8PVz4ADONIo3GPpeGtsVRVtTk1sQ4PK5L6yJcX4vJBrrDvm2uSi2xyoAS48NY/9dhfub2LBjuPVPnpXSFhT496g/4ET5YOt84DXu3SHE9vKOjHVWWU1awhaK5ahJh4=
Received: from CH2PR10MB4150.namprd10.prod.outlook.com (2603:10b6:610:ac::13)
 by DM8PR10MB5397.namprd10.prod.outlook.com (2603:10b6:8:39::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.12; Thu, 15 Dec
 2022 21:45:38 +0000
Received: from CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::f006:f411:9056:63a4]) by CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::f006:f411:9056:63a4%4]) with mapi id 15.20.5880.019; Thu, 15 Dec 2022
 21:45:38 +0000
From:   Eric Snowberg <eric.snowberg@oracle.com>
To:     Mimi Zohar <zohar@linux.ibm.com>
CC:     Jarkko Sakkinen <jarkko@kernel.org>,
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
Subject: Re: [PATCH v3 00/10] Add CA enforcement keyring restrictions
Thread-Topic: [PATCH v3 00/10] Add CA enforcement keyring restrictions
Thread-Index: AQHZD1PCFegbrli1zUCp/3TmJTzIr65uvzMAgABmOoCAADsnAIAACGGAgAAJu4CAAAvJAA==
Date:   Thu, 15 Dec 2022 21:45:37 +0000
Message-ID: <21E52C3E-0778-4908-AF44-F65D57BEC4E0@oracle.com>
References: <20221214003401.4086781-1-eric.snowberg@oracle.com>
 <b8e54d077da633132eb6da03ea536face095a425.camel@linux.ibm.com>
 <4CE6F17D-9D87-4024-9E1A-FDFE7C29D5FC@oracle.com>
 <1c51910a35a1d113256494827fd66ccc7473632e.camel@linux.ibm.com>
 <17855993-519C-4DAC-B62F-9DB473CF249B@oracle.com>
 <7df94da37c100c160436892a6996ba30e3fd6dc8.camel@linux.ibm.com>
In-Reply-To: <7df94da37c100c160436892a6996ba30e3fd6dc8.camel@linux.ibm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH2PR10MB4150:EE_|DM8PR10MB5397:EE_
x-ms-office365-filtering-correlation-id: 798f99b1-66ce-4878-68b6-08dadee5b441
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /ekekQbWdKSBAVnlg9nPXAL6In5uRIv+0O8eT9V6Wtb8qxdGODjU+AniyP8JLYHlwd1zUNgE9C23FFClFRc8xU5FxbE7vYqgZniB5FP26mtN2PiuMD61IBRaqPkXLxIwxn7vOup3iDDZWM8Td6Ojj6JPO0pzXppThGJY+Y6JujHN8eaPLPuvxj07Ty+gt5bNX/cGkjMl6CXgibgCGrRFlWykEiSTL8oeD7EzAC0RLROtDnEnPd+QUsGLsy0yu1kznV7v4nEsKD2e/R3zcmI88rh7aRb9yTRsLGRHl57fMPX69r8DRmVECpUsEU75QV5IL5VXybUTGKo73urfC8LvgYMi8uYB6kGtT0eBXXRwd8/SU8it0v31tlh78YAKId5YCR2o2xOAc4wOofyrfO7cGh625w6Nkt7NdvTnyROM3M2JBxeODfNbO9lGxbP0a81g+PhmITPTn1S3DoIVLOawrpKsO7bFoe4RW4acEMf5U2lf8aQoMCDs8QNl9XB5ka1MSxWD/15VTK40SbL2KkCe20hBVyQjF0Pnrz6OoHvniDb1tK6z8v/2tj9ZsYD806Vt8s+V2JnMXFTbHskAvOsc/iKQiqeX84BLZMDOMMWF5REwQUbwyAeelgHCUjJDH/UCtGbfZmV4ihUypPIrjtAp6hY2nIyCuq4+NjDgdNsyTnU0etCylnedGWVOSH+OKg84aoOf0G6SzJY1eebtTuxeKf9ji3R4Bp/pu9wvK7XkmEs=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4150.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(346002)(376002)(366004)(396003)(39860400002)(451199015)(44832011)(316002)(83380400001)(6916009)(38100700002)(122000001)(8936002)(36756003)(41300700001)(5660300002)(64756008)(7416002)(66446008)(66556008)(66476007)(76116006)(2616005)(8676002)(91956017)(4326008)(54906003)(66946007)(6486002)(478600001)(71200400001)(186003)(6512007)(4001150100001)(33656002)(86362001)(2906002)(6506007)(53546011)(38070700005)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZmZ1bUMzTEhZWkROampUdk90V1VlS3djZEtscFByZXRIMDNGL3IxUVFoS2Rk?=
 =?utf-8?B?TUdON0puWHZqOXkyaXJEYkR5Wng0ZEZuSlB5SnZiRjRqOWF1MlVCcFlxcTRw?=
 =?utf-8?B?TkhxK2UyZHUwTzRzZ1pkbGwyU2F2SlZBcFFINXRaZTl3a1ZhQWlzdDdUUzBt?=
 =?utf-8?B?bTBsY0tYZTJBRW5TSVc0NnZHMmZRNnhheFJmMkhrUnAyb2dqdjVuMjhESkxP?=
 =?utf-8?B?Z3lreERpMm9hNno1WmcrWEY2RUQyRTZ3RUc0ckpEbHBzUXhKRlRsdnJCMWps?=
 =?utf-8?B?NFZRZEtubFJlaGJlVGMyUUppUXdoclhMc2dMUWlWVU5EWnlCNkNuVmpCVmhQ?=
 =?utf-8?B?QkM3ZXpTQTV6cXNDdWlTRkRQQ3BVYnpMOWliK2d4QVNZMDNsTHFoVWlaWTEr?=
 =?utf-8?B?VmNrcjlDM3dMN2RtZ1pPRGdOck9DR3JVcWNZNXo4MGpXUW81U2pKbHp6YWJm?=
 =?utf-8?B?VDFXclhMa25YQXpTVWxZU3J3VllLMm1FanhsdklPVVVyVy9UcXAveVp4dm1Q?=
 =?utf-8?B?OWFKYUZoY2ZJZm0rOG9yalJwRDJ4WnpNZ2Nuc0xnbUd0N1JBamtReGxFcWFP?=
 =?utf-8?B?dTd0elpjQWVmcXUzUTFXTFJkcG5DdUN2M3hudW5VUFlPZFp0ajlkTm1JVlkx?=
 =?utf-8?B?bG90VFNWbFZwZHRrZnZaQTgvNHNydWFkY3ppSnlaa012bjVoOFgxc3ZaRTY3?=
 =?utf-8?B?Vlc2M0JMRytRSWs0aHEyRDZucDhMQVo1S1diSno1VVUvY0FOa3FrZ0p6Ny9h?=
 =?utf-8?B?N2kzRlJWbm02c0NXZzBLZ001T2QwV2Y1WkVLRm5CblJ4K0FDcXQzbTdnUHl0?=
 =?utf-8?B?ZFg0MEVZWU5YUjdhb292ektqbjRsQ0ozejAreVErWC9RcVM1Nmk5ZG9GWEth?=
 =?utf-8?B?VlRkNHZjRmExRXk5VUVNajh5dVI1czYyaVBRZTVDalNlZ1UraGpXMDJ6endu?=
 =?utf-8?B?MWxsNG9SN0YwUnNUUlR5ZmNKRmk1MWJoVlJmVU9Xd1dYdVFvaXVNRnM2Tk5Q?=
 =?utf-8?B?RzRqT2t2blo2UmQvTDBKSDFUVEhZL0xXVGhva09KRUhFY1MxS2syWHpuQjZy?=
 =?utf-8?B?cUd2WEhVeHptR1dYYUVJTnkvNzBGcXVJN3RuNTB6NHBQQmNscWl0YzVjTUZK?=
 =?utf-8?B?ZmtxMDg0Q1FodmYwRlhybU45elJaSXJYaG03WDdIaEJETExHb1U1cTJqVEM0?=
 =?utf-8?B?RHJ1YzdqQTJETjhGWU9mdXFsSENJWmQxTFhpb2hyOU9sWHlUSyswL01jNCs2?=
 =?utf-8?B?cllMQWFVa0tVSUFsRERhZXZFaUIxS3dFcjVuQmRpSGp3ekNpQ0k2NGZQNEhE?=
 =?utf-8?B?QUI4WXVMa2NlYmh0dUJnQ2tXM3V4NFpRbllWL3B3c0dqdks1ZTVrdTJPbzZJ?=
 =?utf-8?B?Z3RkUEZteTlqZGtKaEJPaW5oR0hxdWduOXNCMU1mNkgxZlNjQVU0WStZdE9u?=
 =?utf-8?B?cHRUU3FQWjBvWDJjS0hjRDdyNkt1L3dldG9peFNRL2FsZUFBWms0S3pDWlFk?=
 =?utf-8?B?eXF5YlN2SGhUdW5qUlJYUzB2bGtoYUw5Q3ZXK2NRZzNpT1doSlptUHJWNzIx?=
 =?utf-8?B?NUlXQ3UxWHdzaGRNK0wvSXRMWlhEeC9wKzRXQk9Xak5QMHhSUXh5WTNqY0Rk?=
 =?utf-8?B?OW5pVXBnK0R2WHJCUUZOQnFRbTlXNnNtK0Q4Sk9UTEQvTlk5R2w1NjJEOWtJ?=
 =?utf-8?B?YXcvZzh4dlVpSWpKbm1UajczODRzQXV6TzNXUlF3VEdSUU0vOThORUFsNmFZ?=
 =?utf-8?B?THVIckU5RFYvbXQ0TEI4T3ZLQXYwN2w2L0pPUnh0c3UrVzNUQUZPUk16U2NY?=
 =?utf-8?B?ODREdmRxKzQzQy8wVlV0UFEzL0xFVk5hcWtmSWd3ekhBZk1iUG9PcUFJcGhL?=
 =?utf-8?B?Q3FOTXRuR1QzcGZjaVA3Y0dEKzlLSzlLU21vZEFsMnhrSlhEWXBzVFQzQ3Nm?=
 =?utf-8?B?cE5QQWdER2hrNmk3N2dBV3lHRXNFcDROTlpZSE83SzJPVkJMUklzS1d0ZStL?=
 =?utf-8?B?WEJKUU5DYjhhWUdYbUpXRExBRGplN1lEUXgvUjFNREtDVEJTRXBmY2dDMlpa?=
 =?utf-8?B?ZFU3UXU3aE1hMldPb0w4N3RHbW4rTnBzRjVZdk1FeUhPcklha2dCSTh6WWhy?=
 =?utf-8?B?Wk1KbjNxalFRaTFIaDNjSkVDcjlpRDA5eEdGdFFTUS9XNzBHWVlNL3c1bnl3?=
 =?utf-8?Q?Rt6IUtNn1N10FUqOIJvp+GHjzF8Z8VMpV3eXXVxAU6Or?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <67EC6CF00690274E94600F280F52FD7E@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4150.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 798f99b1-66ce-4878-68b6-08dadee5b441
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Dec 2022 21:45:37.8784
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WZi3AsFL5id+R3sEaOo7dnlUOLGOY0MxBO7gRFoRKkDYapIPf6Rc+3YjDNqlSf7gcJ31QaL8gUb0gUIa2sVv9/QDxPX56lYDiMWhAfkRQOw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR10MB5397
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-15_11,2022-12-15_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 phishscore=0
 mlxlogscore=999 suspectscore=0 spamscore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2212150181
X-Proofpoint-ORIG-GUID: DucpHKEhUvbm_xkLZgt7RgBwFx6RwtSi
X-Proofpoint-GUID: DucpHKEhUvbm_xkLZgt7RgBwFx6RwtSi
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

DQoNCj4gT24gRGVjIDE1LCAyMDIyLCBhdCAyOjAzIFBNLCBNaW1pIFpvaGFyIDx6b2hhckBsaW51
eC5pYm0uY29tPiB3cm90ZToNCj4gDQo+IE9uIFRodSwgMjAyMi0xMi0xNSBhdCAyMDoyOCArMDAw
MCwgRXJpYyBTbm93YmVyZyB3cm90ZToNCj4+IA0KPj4+IE9uIERlYyAxNSwgMjAyMiwgYXQgMTI6
NTggUE0sIE1pbWkgWm9oYXIgPHpvaGFyQGxpbnV4LmlibS5jb20+IHdyb3RlOg0KPj4+IA0KPj4+
IE9uIFRodSwgMjAyMi0xMi0xNSBhdCAxNjoyNiArMDAwMCwgRXJpYyBTbm93YmVyZyB3cm90ZToN
Cj4+Pj4gDQo+Pj4+PiBPbiBEZWMgMTUsIDIwMjIsIGF0IDM6MjEgQU0sIE1pbWkgWm9oYXIgPHpv
aGFyQGxpbnV4LmlibS5jb20+IHdyb3RlOg0KPj4+Pj4gDQo+Pj4+PiBPbiBUdWUsIDIwMjItMTIt
MTMgYXQgMTk6MzMgLTA1MDAsIEVyaWMgU25vd2Jlcmcgd3JvdGU6DQo+Pj4+Pj4gUHJpb3IgdG8g
dGhlIGludHJvZHVjdGlvbiBvZiB0aGUgbWFjaGluZSBrZXlyaW5nLCBtb3N0IGRpc3Ryb3Mgc2lt
cGx5IA0KPj4+Pj4+IGFsbG93ZWQgYWxsIGtleXMgY29udGFpbmVkIHdpdGhpbiB0aGUgcGxhdGZv
cm0ga2V5cmluZyB0byBiZSB1c2VkDQo+Pj4+Pj4gZm9yIGJvdGgga2VybmVsIGFuZCBtb2R1bGUg
dmVyaWZpY2F0aW9uLiAgVGhpcyB3YXMgZG9uZSBieSBhbiBvdXQgb2YNCj4+Pj4+PiB0cmVlIHBh
dGNoLiAgU29tZSBkaXN0cm9zIHRvb2sgaXQgZXZlbiBmdXJ0aGVyIGFuZCBsb2FkZWQgYWxsIHRo
ZXNlIGtleXMNCj4+Pj4+PiBpbnRvIHRoZSBzZWNvbmRhcnkgdHJ1c3RlZCBrZXlyaW5nLiAgVGhp
cyBhbHNvIGFsbG93ZWQgdGhlIHN5c3RlbSBvd25lciANCj4+Pj4+PiB0byBhZGQgdGhlaXIgb3du
IGtleSBmb3IgSU1BIHVzYWdlLg0KPj4+Pj4+IA0KPj4+Pj4+IEVhY2ggZGlzdHJvIGNvbnRhaW5z
IHNpbWlsYXIgZG9jdW1lbnRhdGlvbiBvbiBob3cgdG8gc2lnbiBrZXJuZWwgbW9kdWxlcw0KPj4+
Pj4+IGFuZCBlbnJvbGwgdGhlIGtleSBpbnRvIHRoZSBNT0suICBUaGUgcHJvY2VzcyBpcyBmYWly
bHkgc3RyYWlnaHRmb3J3YXJkLg0KPj4+Pj4+IFdpdGggdGhlIGludHJvZHVjdGlvbiBvZiB0aGUg
bWFjaGluZSBrZXlyaW5nLCB0aGUgcHJvY2VzcyByZW1haW5zDQo+Pj4+Pj4gYmFzaWNhbGx5IHRo
ZSBzYW1lLCB3aXRob3V0IHRoZSBuZWVkIGZvciBhbnkgb3V0IG9mIHRyZWUgcGF0Y2hlcy4NCj4+
Pj4+PiANCj4+Pj4+PiBUaGUgbWFjaGluZSBrZXlyaW5nIGFsbG93ZWQgZGlzdHJvcyB0byBlbGlt
aW5hdGUgdGhlIG91dCBvZiB0cmVlIHBhdGNoZXMNCj4+Pj4+PiBmb3Iga2VybmVsIG1vZHVsZSBz
aWduaW5nLiAgSG93ZXZlciwgaXQgZmFsbHMgc2hvcnQgaW4gYWxsb3dpbmcgdGhlIGVuZCANCj4+
Pj4+PiB1c2VyIHRvIGFkZCB0aGVpciBvd24ga2V5cyBmb3IgSU1BLiBDdXJyZW50bHkgdGhlIG1h
Y2hpbmUga2V5cmluZyBjYW4gbm90IA0KPj4+Pj4+IGJlIHVzZWQgYXMgYW5vdGhlciB0cnVzdCBh
bmNob3IgZm9yIGFkZGluZyBrZXlzIHRvIHRoZSBpbWEga2V5cmluZywgc2luY2UgDQo+Pj4+Pj4g
Q0EgZW5mb3JjZW1lbnQgZG9lcyBub3QgY3VycmVudGx5IGV4aXN0LiAgVGhpcyB3b3VsZCBleHBh
bmQgdGhlIGN1cnJlbnQgDQo+Pj4+Pj4gaW50ZWdyaXR5IGdhcC4gVGhlIElNQV9LRVlSSU5HU19Q
RVJNSVRfU0lHTkVEX0JZX0JVSUxUSU5fT1JfU0VDT05EQVJZIA0KPj4+Pj4+IEtjb25maWcgc3Rh
dGVzIHRoYXQga2V5cyBtYXkgYmUgYWRkZWQgdG8gdGhlIGltYSBrZXlyaW5ncyBpZiB0aGUga2V5
IGlzIA0KPj4+Pj4+IHZhbGlkbHkgc2lnbmVkIGJ5IGEgQ0EgY2VydCBpbiB0aGUgc3lzdGVtIGJ1
aWx0LWluIG9yIHNlY29uZGFyeSB0cnVzdGVkIA0KPj4+Pj4+IGtleXJpbmcuICBDdXJyZW50bHkg
dGhlcmUgaXMgbm90IGNvZGUgdGhhdCBlbmZvcmNlcyB0aGUgY29udGVudHMgb2YgYQ0KPj4+Pj4+
IENBIGNlcnQuIEFueSBrZXkgaW4gdGhlIGJ1aWx0aW4gb3Igc2Vjb25kYXJ5IGtleXJpbmcgY2Fu
IGJlIHVzZWQuIA0KPj4+Pj4+IA0KPj4+Pj4+IFRvIGFsbG93IElNQSB0byBiZSBlbmFibGVkIHdp
dGggdGhlIG1hY2hpbmUga2V5cmluZywgdGhpcyBzZXJpZXMgaW50cm9kdWNlcw0KPj4+Pj4+IGVu
Zm9yY2VtZW50IG9mIGtleSB1c2FnZSBpbiB0aGUgY2VydGlmaWNhdGUuIFRoaXMgc2VyaWVzIGFs
c28gYXBwbGllcw0KPj4+Pj4+IHRoaXMgZW5mb3JjZW1lbnQgYWNyb3NzIGFsbCBrZXJuZWwga2V5
cmluZ3MuDQo+Pj4+Pj4gDQo+Pj4+Pj4gVGhlIG1hY2hpbmUga2V5cmluZyBzaGFyZXMgIHNpbWls
YXJpdGllcyB3aXRoIGJvdGggdGhlIGJ1aWx0aW4gYW5kDQo+Pj4+Pj4gc2Vjb25kYXJ5IGtleXJp
bmdzLiAgU2ltaWxhciB0byB0aGUgYnVpbHRpbiwgbm8ga2V5cyBtYXkgYmUgYWRkZWQgdG8gdGhl
DQo+Pj4+Pj4gbWFjaGluZSBrZXlyaW5nIGZvbGxvd2luZyBib290LiBUaGUgc2Vjb25kYXJ5IGtl
eXJpbmcgYWxsb3dzIHVzZXINCj4+Pj4+PiBwcm92aWRlZCBrZXlzIHRvIGJlIGFkZGVkIGZvbGxv
d2luZyBib290OyBob3dldmVyLCBhIHByZXZpb3VzbHkgZW5yb2xsZWQNCj4+Pj4+PiBrZXJuZWwg
a2V5IG11c3Qgdm91Y2ggZm9yIHRoZSBrZXkgYmVmb3JlIGl0IG1heSBiZSBpbmNsdWRlZC4gVGhl
IHN5c3RlbQ0KPj4+Pj4+IG93bmVyIG1heSBpbmNsdWRlIHRoZWlyIG93biBrZXlzIGludG8gdGhl
IG1hY2hpbmUga2V5cmluZyBwcmlvciB0byBib290Lg0KPj4+Pj4+IElmIHRoZSBlbmQtdXNlciBp
cyBub3QgdGhlIHN5c3RlbSBvd25lciwgdGhleSBtYXkgbm90IGFkZCB0aGVpciBvd24ga2V5cw0K
Pj4+Pj4+IHRvIHRoZSBtYWNoaW5lIGtleXJpbmcuICANCj4+Pj4+PiANCj4+Pj4+PiBUaGUgbWFj
aGluZSBrZXlyaW5nIGlzIG9ubHkgcG9wdWxhdGVkIHdoZW4gU2VjdXJlIEJvb3QgaXMgZW5hYmxl
ZC4gIEENCj4+Pj4+PiBzeXN0ZW0gb3duZXIgaGFzIHRoZSBhYmlsaXR5IHRvIGNvbnRyb2wgdGhl
IGVudGlyZSBTZWN1cmUgQm9vdCBrZXljaGFpbg0KPj4+Pj4+IChQSywgS0VLLCBEQiwgYW5kIERC
WCkuICBUaGUgc3lzdGVtIG93bmVyIGNhbiBhbHNvIHR1cm4gU2VjdXJlIEJvb3Qgb2ZmLg0KPj4+
Pj4+IFdpdGggdGhpcyBjb250cm9sLCB0aGV5IG1heSB1c2UgaW5zZXJ0LXN5cy1jZXJ0IHRvIGlu
Y2x1ZGUgdGhlaXIgb3duIGtleSANCj4+Pj4+PiBhbmQgcmUtc2lnbiB0aGVpciBrZXJuZWwgYW5k
IGhhdmUgaXQgYm9vdC4gIFRoZSBzeXN0ZW0gb3duZXIgYWxzbyBoYXMgDQo+Pj4+Pj4gY29udHJv
bCB0byBpbmNsdWRlIG9yIGV4Y2x1ZGUgTU9LIGtleXMuIFRoaXMgc2VyaWVzIGRvZXMgbm90IHRy
eSB0byANCj4+Pj4+PiBpbnRlcnByZXQgaG93IGEgc3lzdGVtIG93bmVyIGhhcyBjb25maWd1cmVk
IHRoZWlyIG1hY2hpbmUuICBJZiB0aGUgc3lzdGVtIA0KPj4+Pj4+IG93bmVyIGhhcyB0YWtlbiB0
aGUgc3RlcHMgdG8gYWRkIHRoZWlyIG93biBNT0sga2V5cywgdGhleSB3aWxsIGJlIA0KPj4+Pj4+
IGluY2x1ZGVkIGluIHRoZSBtYWNoaW5lIGtleXJpbmcgYW5kIHVzZWQgZm9yIHZlcmlmaWNhdGlv
biwgZXhhY3RseSANCj4+Pj4+PiB0aGUgc2FtZSB3YXkgYXMga2V5cyBjb250YWluZWQgaW4gdGhl
IGJ1aWx0aW4gYW5kIHNlY29uZGFyeSBrZXlyaW5ncy4NCj4+Pj4+PiBTaW5jZSB0aGUgc3lzdGVt
IG93bmVyIGhhcyB0aGUgYWJpbGl0eSB0byBhZGQga2V5cyBiZWZvcmUgYm9vdGluZyB0bw0KPj4+
Pj4+IGVpdGhlciB0aGUgbWFjaGluZSBvciBidWlsdGluIGtleXJpbmdzLCBpdCBpcyB2aWV3ZWQg
YXMgaW5jb25zZXF1ZW50aWFsIA0KPj4+Pj4+IGlmIHRoZSBrZXkgb3JpZ2luYXRlZCBmcm9tIG9u
ZSBvciB0aGUgb3RoZXIuDQo+Pj4+Pj4gDQo+Pj4+Pj4gVGhpcyBzZXJpZXMgaW50cm9kdWNlcyB0
d28gZGlmZmVyZW50IHdheXMgdG8gY29uZmlndXJlIHRoZSBtYWNoaW5lIGtleXJpbmcuDQo+Pj4+
Pj4gQnkgZGVmYXVsdCwgbm90aGluZyBjaGFuZ2VzIGFuZCBhbGwgTU9LIGtleXMgYXJlIGxvYWRl
ZCBpbnRvIGl0LiAgV2hlbmV2ZXINCj4+Pj4+PiBhIENBIGNlcnQgaXMgZm91bmQgd2l0aGluIHRo
ZSBtYWNoaW5lLCBidWlsdGluLCBvciBzZWNvbmRhcnksIGEgZmxhZyANCj4+Pj4+PiBpbmRpY2F0
aW5nIHRoaXMgaXMgc3RvcmVkIGluIHRoZSBwdWJsaWMga2V5IHN0cnVjdC4gIFRoZSBvdGhlciBv
cHRpb24gaXMgDQo+Pj4+Pj4gaWYgdGhlIG5ldyBLY29uZmlnIElOVEVHUklUWV9DQV9NQUNISU5F
X0tFWVJJTkcgaXMgZW5hYmxlZCwgb25seSBDQSBjZXJ0cyANCj4+Pj4+PiB3aWxsIGJlIGxvYWRl
ZCBpbnRvIHRoZSBtYWNoaW5lIGtleXJpbmcuIEFsbCByZW1haW5pbmcgTU9LIGtleXMgd2lsbCBi
ZSANCj4+Pj4+PiBsb2FkZWQgaW50byB0aGUgcGxhdGZvcm0ga2V5cmluZy4NCj4+Pj4+PiANCj4+
Pj4+PiBBIENBIGNlcnQgc2hhbGwgYmUgZGVmaW5lZCBhcyBhbnkgWDUwOSBjZXJ0aWZpY2F0ZSB0
aGF0IGNvbnRhaW5zIHRoZSANCj4+Pj4+PiBrZXlDZXJ0U2lnbiBrZXkgdXNhZ2UgYW5kIGhhcyB0
aGUgQ0EgYml0IHNldCB0byB0cnVlLg0KPj4+Pj4gDQo+Pj4+PiBIaSBFcmljLA0KPj4+Pj4gDQo+
Pj4+PiBBbGxvd2luZyBDQSBjZXJ0aWZpY2F0ZXMgd2l0aCB0aGUgZGlnaXRhbFNpZ25hdHVyZSBr
ZXkgdXNhZ2UgZmxhZw0KPj4+Pj4gZW5hYmxlZCBkZWZlYXRzIHRoZSBwdXJwb3NlIG9mIHRoZSBu
ZXcgS2NvbmZpZy4gIFBsZWFzZSB1cGRhdGUgdGhlDQo+Pj4+PiBhYm92ZSBkZWZpbml0aW9uIHRv
IGV4Y2x1ZGUgdGhlIGRpZ2l0YWxTaWduYXR1cmUga2V5IHVzYWdlIGZsYWcgYW5kDQo+Pj4+PiBt
b2RpZnkgdGhlIGNvZGUgYWNjb3JkaW5nbHkuDQo+Pj4+IA0KPj4+PiBXaXRoaW4gdjIsIHRoZSBy
ZXF1ZXN0IHdhcyBtYWRlIHRvIGFsbG93IEludGVybWVkaWF0ZSBDQSBjZXJ0aWZpY2F0ZXMgdG8g
YmUgDQo+Pj4+IGxvYWRlZCBkaXJlY3RseS4gIFRoZSBJbnRlcm1lZGlhdGUgQ0EgcmVmZXJlbmNl
ZCB3YXMgdGhlIG9uZSB1c2VkIGJ5IGtlcm5lbC5vcmcuICANCj4+Pj4gVGhpcyBJbnRlcm1lZGlh
dGUgQ0EgY29udGFpbnMgYm90aCBkaWdpdGFsU2lnbmF0dXJlIGFuZCBrZXlDZXJ0U2lnbi4gIElm
IHRoZSBjb2RlIA0KPj4+PiBpcyBjaGFuZ2VkIHRvIGV4Y2x1ZGUgdGhpcyBjZXJ0aWZpY2F0ZSwg
bm93IHRoZSByb290IENBIGhhcyB0byBiZSBsb2FkZWQgYWdhaW4uICBJcyB0aGF0IA0KPj4+PiB0
aGUgaW50ZW50Pw0KPj4+IA0KPj4+IFRoYXQgZGVmaW5pdGVseSB3YXMgbm90IHRoZSBpbnRlbnQu
ICBOb3Igd291bGQgaXQgYWRkcmVzcyB0aGUgaXNzdWUgb2YNCj4+PiBhIHBhcnRpY3VsYXIgaW50
ZXJtZWRpYXRlIENBIGNlcnRpZmljYXRlIGhhdmluZyBib3RoIGtleUNlcnRTaWduIGFuZA0KPj4+
IGRpZ2l0YWxTaWduYXR1cmUuDQo+PiANCj4+IFNvcnJ5LCBJ4oCZbSBub3QgZm9sbG93aW5nLiAg
V2h5IGlzIGl0IGFuIGlzc3VlIHRoYXQgYW4gaW50ZXJtZWRpYXRlIENBIGNlcnRpZmljYXRlIGNv
bnRhaW5zIA0KPj4gYm90aCBrZXlDZXJ0U2lnbiBhbmQgZGlnaXRhbFNpZ25hdHVyZT8gV2h5IHdv
dWxkIHdlIHdhbnQgdG8gZXhjbHVkZSBhbiBJbnRlcm1lZGlhdGUNCj4+IENBIGNlcnQgbGlrZSB0
aGUgb25lIHVzZWQgb24ga2VybmVsLm9yZz8NCj4gDQo+IEkgbXVzdCBiZSBtaXNzaW5nIHNvbWV0
aGluZy4gIElzbid0IHRoZSBwdXJwb3NlIG9mICJrZXlVc2FnZSIgdG8NCj4gbWluaW1pemUgaG93
IGEgY2VydGlmaWNhdGUgbWF5IGJlIHVzZWQ/ICAgV2h5IHdvdWxkIHdlIHdhbnQgdGhlIHNhbWUN
Cj4gY2VydGlmaWNhdGUgdG8gYmUgdXNlZCBmb3IgYm90aCBjZXJ0aWZpY2F0ZSBzaWduaW5nIGFu
ZCBjb2RlIHNpZ25pbmc/DQoNCkV2ZXJ5IDNyZCBwYXJ0eSBpbnRlcm1lZGlhdGUgQ0EgSSBoYXZl
IGxvb2tlZCBhdCBzbyBmYXIgY29udGFpbnMgYm90aCBzZXQuIE1vc3QgaGF2ZSBDUkxTaWduIHNl
dC4gIA0KVHlwaWNhbGx5IHRoZSByb290IENBIGNvbnRhaW5zIGtleUNlcnRTaWduIGFuZCBDUkxT
aWduLCBidXQgc29tZSBhbHNvIGhhdmUgZGlnaXRhbFNpZ25hdHVyZSANCnNldC4gIEZpbmRpbmcg
YSAzcmQgcGFydHkgSW50ZXJtZWRpYXRlIENBIHdpdGhvdXQgZGlnaXRhbFNpZ25hdHVyZSBzZXQg
aXMgcHJvYmFibHkgZ29pbmcgdG8gYmUgDQpjaGFsbGVuZ2luZyBhbmQgd2lsbCBzZXZlcmVseSBs
aW1pdCB1c2FnZS4NCg0K
