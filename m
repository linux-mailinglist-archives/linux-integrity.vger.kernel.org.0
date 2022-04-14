Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDD0F50195F
	for <lists+linux-integrity@lfdr.de>; Thu, 14 Apr 2022 19:00:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241161AbiDNRC5 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 14 Apr 2022 13:02:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241898AbiDNRCO (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 14 Apr 2022 13:02:14 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A826F94FE;
        Thu, 14 Apr 2022 09:37:02 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 23EEsMZM014133;
        Thu, 14 Apr 2022 16:36:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=fOvbf2eLzqNMjpB+MJA0GQnN+aZ5EONJiwva4UY+S3o=;
 b=GXVaeiMJ9jF5z9MTgoymCMrpGUeWUKLNFL7e8bU9dunfLdV3zN4zWyBYlomuClNypn0N
 Oi0auh/4ewPcbTqz1O34m4+9bTffxft3oCWjuoCO6LJdd9nsTjWxJsxcFY+faQY24PLz
 Q0MC1k5aFBJZ9Qoc+1NaRGIa5sXZfGaUIWU+dJJk1/vHs1Pc2FRNidLbuVGLGbrVwhZ3
 VAu9FV/Rm8PVIqkQoFFwffcJN2Dv6GZQr5m6nG3aAJpER5iHYxus4w7YRAJa85PJyHNk
 7+df5xXbMT2Nk9jQvlp8rcwsTtn5S5iw5LYRGnkA1gGoXTyEOfr/8ZuRR2gO1PfIKHrx qQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com with ESMTP id 3fb2pu5k60-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 Apr 2022 16:36:09 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23EGHSY3028528;
        Thu, 14 Apr 2022 16:36:07 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam08lp2041.outbound.protection.outlook.com [104.47.73.41])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fb0k4y99y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 Apr 2022 16:36:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iV1HOVxkcQDIRQxZ7mYuyIqNx5x28I5kyzxijXWfMm8gtkwhPIikRV0oMJnUK2kcs8o+d/W3Ywx4JvLsTD7FlABlTKFyxP7OY3XDQu+sdVMmHyjnbnVy2K5sIwfDgRkJMrVcWs8L3rgyP9vDC2m3e2z/tSh1lIhdRQHc+CNog1RcFpP0UhryWZTegdsVhCtABKDwWMUPjPBijxLAzKAoUuucdOzCF58nKKbpNJQTgTq5nbGi7XLsXDxUbYVmL6cV7UX6mW4q3wDskpEPNzcFhIFrIoyX/THGA8QXnkzRAQvupTCdiFhrxAWsTKzn9mfX9nKzcSf/GmPSzJtFRMlEMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fOvbf2eLzqNMjpB+MJA0GQnN+aZ5EONJiwva4UY+S3o=;
 b=f/6HMNoaoMpl0qQIMM86yhCzEI1XaMPHBrDRBOMiiQimg6CWHw97+Mb8gvGwG7MhyqZ787nqDAh5R5X7WIAiqW+TW1K5oMOxqqvzH1sKnMA9bEYZfiDkGPWVubSPPESINOdbIUxhMHW6eoYKS4/Ao66HGIG8je4NQZy/4ygRTORAUXD8kgmUp9Ugc+hF02LvjBL8+/2sxaiDcco0GvN/eSjjm/NMFNJB9MiF4PPSQAO83Zgy3S+fp6JPuVVmGZgZIOCBl+saMB010EZTc++UOe8tvAJVYXxGJs9a2LPbh9pTFICSUrDkGgEsXeaFp7jioPoxgsgYgDjc2Zbi5L+Meg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fOvbf2eLzqNMjpB+MJA0GQnN+aZ5EONJiwva4UY+S3o=;
 b=dFsthHdJR0wevFCexm/qka9IxiHIiHEGAx/+TzFoy/CATUZtbQVlvNO4jcuGt0jQJi+A8jGmO/5Pdh0bHHsKpTEN7Lxwu9XC4yH3+ADRrSxNJDqYNlnvVTnd0e7w1eN6MCZgxEBN69IbKu+u8Lloouc0h/w7e/9QMd+9bBwnaqA=
Received: from CH2PR10MB4150.namprd10.prod.outlook.com (2603:10b6:610:ac::13)
 by BN0PR10MB5366.namprd10.prod.outlook.com (2603:10b6:408:12b::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.29; Thu, 14 Apr
 2022 16:36:05 +0000
Received: from CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::7ded:5b3:a28f:2e55]) by CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::7ded:5b3:a28f:2e55%7]) with mapi id 15.20.5144.030; Thu, 14 Apr 2022
 16:36:05 +0000
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
        Roberto Sassu <roberto.sassu@huawei.com>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        "pvorel@suse.cz" <pvorel@suse.cz>, "tiwai@suse.de" <tiwai@suse.de>,
        "keyrings@vger.kernel.org" <keyrings@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>
Subject: Re: [PATCH 4/7] KEYS: Introduce a builtin root of trust key flag
Thread-Topic: [PATCH 4/7] KEYS: Introduce a builtin root of trust key flag
Thread-Index: AQHYSVkvRBwH8IpE9UCisTSasA/N5azmGp0AgAANAACAABh+AIAACxSAgAAU5ICAADUngIAESlAAgATJOgA=
Date:   Thu, 14 Apr 2022 16:36:05 +0000
Message-ID: <B67D99B1-1DF9-4146-9147-08B2C4A72FEA@oracle.com>
References: <20220406015337.4000739-1-eric.snowberg@oracle.com>
 <20220406015337.4000739-5-eric.snowberg@oracle.com>
 <4fbef0889d6f286c7fcd317db099b4857e1b2fa3.camel@linux.ibm.com>
 <EF1544D5-54E8-4D47-82F8-F9337CA7AEA0@oracle.com>
 <b8965652274b49ba7c6f67cad6d42965cf984b42.camel@linux.ibm.com>
 <16DDA7F1-95BA-4279-BE4E-9F713A905B36@oracle.com>
 <986199739ff8bd730b9aabe8882e245946d3d9e9.camel@linux.ibm.com>
 <BFA04505-F4BC-4CF8-B813-EE81DBD90E09@oracle.com>
 <6798c67d748ecdc92455a8be8c63fb55e243368a.camel@linux.ibm.com>
In-Reply-To: <6798c67d748ecdc92455a8be8c63fb55e243368a.camel@linux.ibm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3608.120.23.2.7)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b59f454e-6a36-4308-b79d-08da1e34df2a
x-ms-traffictypediagnostic: BN0PR10MB5366:EE_
x-microsoft-antispam-prvs: <BN0PR10MB5366567BDC80BFA50B213A2B87EF9@BN0PR10MB5366.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +wH2GiFCEVSEP1YrvxxUTJk5VjzYyiEshFEjhK2UMeO7NRGA2oBTELTb3jAJrloEegDvwtSrzKOM6F8ktTuir1eCFHXMMefhvUq++WQMXrilIDWFD4oXd0UqA8Oh06epp/sWAJh53DTWViVISVMr2NBMjCLdnE/Jc8yeVUGYDpF1ywryzb7mkGovr1y6HSHaSKGQ/tKsGm5Lxiv6Yn7UqHOatWl9rh0VyKAAZ3PNoVu5LN8XCtrzUYa17oAucFNnIOQeNJzu0ExWJWtc6B8EtTOYSj9gEjAJvGN9bu4Ic4o//2p+A9dUE+xWHg2nW52kbxxFwC0yL1ZItGG7lh+2xnyXRSFW+aMEejlSzY+xTidQHEpjO8cVtUh5UqzzHstsLLANtcQzr0Ssbc0WyGAUOKk2roSVYlBRRl6QnIvGfmbEBs0JvSKt8TkOKPls7ZvHc3sfN6t7BE8Ta9J/dkfmgZVI4tBSY8tbiCULFDcwc8ws7s1cU+ORsgJDZLwH6aFNMahXOOs3VxMQr4+5pqBAXi+BJJclTrMkYhYoskZqnq56kZhGe3i2BhB+rCcReCOt2D49yoJ66Aq14VgZtAzWSoHG1d+B8Jvu0Qbg4dNWigtN5enMV/kQi7RP+zZExO4oyykiYCumlJyDlFwg0TQ7a/yrH5vmF/sTyk/yZvkrCzl0RVepJV7m9ehJcOZf8ArzKpWPyZeGf++D4/6ToM4mK8bW1aHPzl7Yvfyb9KsfgpoQeZDH5JxdDkM9n69A6aT/
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4150.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(122000001)(38070700005)(38100700002)(7416002)(54906003)(5660300002)(6916009)(6486002)(316002)(508600001)(44832011)(71200400001)(8676002)(64756008)(66476007)(4326008)(66446008)(66556008)(66946007)(8936002)(76116006)(91956017)(26005)(186003)(83380400001)(2616005)(6506007)(86362001)(53546011)(36756003)(2906002)(33656002)(6512007)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cllMSlpQQVVUcFh6cGpmb2g4cUtpenJIQnlPR2hTTlMrVzdmTEFCbVVEUUlC?=
 =?utf-8?B?TmtacWl6T3BiM2hLY3VXdERqL2JDSmgrMzhLcW40UGE0UkcxK28yRzRqTHRB?=
 =?utf-8?B?cDYwZnFsYXRIdEs4aDRqRmVqNDU0SGpzVGNxNXRkWXZwWW5nVmp5aWE4VkdJ?=
 =?utf-8?B?Z2Z4bXZ3Zk5jY0s2aXB6MjhqQnJzbm83NitJWjVLL3UwL08vYXQyS2NHMkJU?=
 =?utf-8?B?VFN5V0Q1UGhKNWZ3QytEQytId3h3N3lLVHA2bWVnU09IdWRDYXdYeXBmcUQz?=
 =?utf-8?B?azArNUpDTG9Qb3pSN0UweU5nM29ianJVV2xwKzNycVRESHVjVjF1NWhPYlFa?=
 =?utf-8?B?V09hSHlKYlRxZVVsY3RDNVI3c1dRdGdHekR4anJaNHlXZEhlcUYrb3FYNmhk?=
 =?utf-8?B?bm4zMFBaREx5SUVBQnFaZkx6NVFKUWpFc1VjYTY1dGY5L2Rva2YzTmVvNXpr?=
 =?utf-8?B?MEM3T3ZEVzR0cDlWNVJPdEMrTnQ0TU10a01Sak5YWnFLL2ROV09ka3VYOEVu?=
 =?utf-8?B?Mys3bEhQcVJJTEVWNDFGdTlBWHMwMUpoeURHa0hhVDd6NjBmMnl1Y2IydWhV?=
 =?utf-8?B?bmk2UDdLeEVTVjJiNlpIUGkrTkFRekRtUkZHQmJVNU8rUCtuWC84S3pKZE1S?=
 =?utf-8?B?cHJjQk01eE96NWdvY2xINHo4NlFjV2dwc09uV0hRa3hvdTNPR1Q3L3hKWnJx?=
 =?utf-8?B?TEV2Q3BXMG94bDY3NkhzQk40WnIzandVRmNIajlPSHVBU0M4R2YvRUZYQTdi?=
 =?utf-8?B?cFlQY2Q3RXFLZXI5YXdLVEppa2MwQXlDTVZNV0lFWW9sRHAwR0RQbGNvTVAr?=
 =?utf-8?B?Y01mdGtNZWpnMWsvN2RiVnozQWVqTy8zcStTVzBZUS93TDJleE5obnZuS2Iw?=
 =?utf-8?B?KzFFYnorZ2VSRE1tWEI0cTNWM1MxU1pXRXhZMWhUMldtSWNoYmVZTkFPSXZE?=
 =?utf-8?B?UWVOMHhsVGU3WkRJYlJEbzdFVW5vYmVTWnVLME5FaVk4S3Y2UmlqZVdkS21x?=
 =?utf-8?B?OFBzQUtJei9DN1FpSUREckVQRkc0Q0RGaGNaQk55UFZoOExzcjhBamFvb21F?=
 =?utf-8?B?YTNoQUhjcG5tM29UelltYjZNTjBSSlM4Ui9kOEg1WjRhRFZsOFc3Y2N5RDFT?=
 =?utf-8?B?ckpMSUFOOHBCSHVGVjh0TjgwalVpMGhlYmMwUmhvYnkydW1MT2drdENvbFBM?=
 =?utf-8?B?NlhxZ0dwVWRNYzV5cDVvNi9LdUFEMWFHT3czWDBGU2kwR042azJFVWh0NFhV?=
 =?utf-8?B?cytpOGF0blpMSXgvK282Z3FpOGZyTU9RS2Y2OUVhQnBYaDdNVllSdHZXY0Ry?=
 =?utf-8?B?Y01aYWMySWFKSktGVm5Pdk11Q3pxOVdwWkdTYkdaaC9KTUQ5bUZyblZsai84?=
 =?utf-8?B?cjZKWk9hc0JEN0NSRkhWRjVDSTJnR1FWUVlwMGtLTThSRXM5aVlJMjAvY21x?=
 =?utf-8?B?WWVpaEQxQTY2ZHZWTjZVSm1WUGRQY1FFNjFSa0l0RG14dElqdFMwamVqbnFo?=
 =?utf-8?B?alBRVEZaUG50aUtwTFp3djR3djdFeUUzc2Q3M3ZrOFhaWWhuY3hyV2ZjbHI3?=
 =?utf-8?B?bDJEK0ZwVjFsRzdtSDkwUlM1cHF1d1V1V3dJVTJLZXNjL3hqdER5Zld5WDZW?=
 =?utf-8?B?Mm5xUXR4SUQwWCtRMzZNeG9iSitQVXBTdFJrR25aT1lvVk9lWmsySC9zUTcv?=
 =?utf-8?B?TmY1WHpYL3YrVVovSmJUbmlabFhzeWJhU1FRbi9VUmNzU0tFdU1zYzhrN3Vq?=
 =?utf-8?B?Z3FWMERzQWJkRkkrMXNoZXYrS3hFR2w0WDIzRzFSZzk2R25QRVhQYkppVktp?=
 =?utf-8?B?b0RMRXNMdzVGMTlxV1VnSnYybnFSR3UycHlpeUg4cG1TU2h3SmdULzJEQS9K?=
 =?utf-8?B?eXIrbWEwdGpWazdiS3VLaVpFQjhjRmZnWnp5SHoyQ0laL2ZybDl1NGpHOTlu?=
 =?utf-8?B?ZUdZblBGakJsZkVSY2RML2RBYU9BbFQ4TFdBNXl5aWJ4ZUNSZFRrUVp3bVQv?=
 =?utf-8?B?WXhEalRVOUQxQmxWMzZUVVp4R25acWdYR1YvcmFVN0d3ME1iQi9KV0Y2V3hY?=
 =?utf-8?B?RmdSekFwMDljdWt6NWYzbzd5Z1ZFbVNKN0MxV2NSenZjYXBVM3p2ZDBXVklj?=
 =?utf-8?B?S0lONGdoOFgyU2tGKy9SNHhkOFRHaWxBK1VOS1BlQzVJTVA2cGdhYVdoNnV0?=
 =?utf-8?B?dUhxaVlURlNUL1lDeWRQZDhERlB1SWpGSlBMNkdkMjB4aHpPTzJoaFdlN2ZF?=
 =?utf-8?B?VWxRZ1lTZHZrVGxnUnpuZHplY3JMTUlHT1VuaDY2MzlKYVVLRGpQU1lia3VP?=
 =?utf-8?B?eXNGZU92RENEODdVWlhuRHY5bTFYZG5RZDdmcXJKSVRHOUZjOWtGTXJON004?=
 =?utf-8?Q?yQRf/Bep6j3kY9Q8=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2BB32F4E556C09438F3DB1A913FAD644@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4150.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b59f454e-6a36-4308-b79d-08da1e34df2a
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Apr 2022 16:36:05.6972
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tmMyLz3r44JZYGrc+ALP+HVWagPSY2KHvfJJ7xh9xS2WRIyze7EO/x8GB1cMxQiW1hSH/anP/rheqbN0YVZWLw61HCU27g+0cjjIQDCI3hU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5366
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-04-14_04:2022-04-14,2022-04-14 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0 mlxscore=0
 bulkscore=0 phishscore=0 spamscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204140087
X-Proofpoint-ORIG-GUID: HhnvTPbSaSWvsZHDP2faP3Tdc3PJEf9m
X-Proofpoint-GUID: HhnvTPbSaSWvsZHDP2faP3Tdc3PJEf9m
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

DQoNCj4gT24gQXByIDExLCAyMDIyLCBhdCA5OjMwIEFNLCBNaW1pIFpvaGFyIDx6b2hhckBsaW51
eC5pYm0uY29tPiB3cm90ZToNCj4gDQo+IE9uIEZyaSwgMjAyMi0wNC0wOCBhdCAyMTo1OSArMDAw
MCwgRXJpYyBTbm93YmVyZyB3cm90ZToNCj4+PiBPbiBBcHIgOCwgMjAyMiwgYXQgMTI6NDkgUE0s
IE1pbWkgWm9oYXIgPHpvaGFyQGxpbnV4LmlibS5jb20+IHdyb3RlOg0KPj4+IA0KPj4+IE9uIEZy
aSwgMjAyMi0wNC0wOCBhdCAxNzozNCArMDAwMCwgRXJpYyBTbm93YmVyZyB3cm90ZToNCj4+Pj4g
DQo+Pj4+PiBPbiBBcHIgOCwgMjAyMiwgYXQgMTA6NTUgQU0sIE1pbWkgWm9oYXIgPHpvaGFyQGxp
bnV4LmlibS5jb20+IHdyb3RlOg0KPj4+Pj4gDQo+Pj4+PiBPbiBGcmksIDIwMjItMDQtMDggYXQg
MTU6MjcgKzAwMDAsIEVyaWMgU25vd2Jlcmcgd3JvdGU6DQo+Pj4+Pj4gDQo+Pj4+Pj4+IE9uIEFw
ciA4LCAyMDIyLCBhdCA4OjQwIEFNLCBNaW1pIFpvaGFyIDx6b2hhckBsaW51eC5pYm0uY29tPiB3
cm90ZToNCj4+Pj4+Pj4gDQo+Pj4+Pj4+IE9uIFR1ZSwgMjAyMi0wNC0wNSBhdCAyMTo1MyAtMDQw
MCwgRXJpYyBTbm93YmVyZyB3cm90ZToNCj4+Pj4+Pj4+IA0KPj4+Pj4+Pj4gVGhlIGZpcnN0IHR5
cGUgb2Yga2V5IHRvIHVzZSB0aGlzIGlzIFguNTA5LiAgV2hlbiBhIFguNTA5IGNlcnRpZmljYXRl
DQo+Pj4+Pj4+PiBpcyBzZWxmIHNpZ25lZCwgaGFzIHRoZSBrZXJuQ2VydFNpZ24gS2V5IFVzYWdl
IHNldCBhbmQgY29udGFpbnMgdGhlDQo+Pj4+Pj4+PiBDQSBiaXQgc2V0IHRoaXMgbmV3IGZsYWcg
aXMgc2V0Lg0KPj4+Pj4+Pj4gDQo+Pj4+Pj4+PiBTaWduZWQtb2ZmLWJ5OiBFcmljIFNub3diZXJn
IDxlcmljLnNub3diZXJnQG9yYWNsZS5jb20+DQo+Pj4+Pj4+PiANCj4+Pj4+Pj4+IGRpZmYgLS1n
aXQgYS9pbmNsdWRlL2xpbnV4L2tleS5oIGIvaW5jbHVkZS9saW51eC9rZXkuaA0KPj4+Pj4+Pj4g
aW5kZXggN2ZlYmM0ODgxMzYzLi45N2Y2YTFmODZhMjcgMTAwNjQ0DQo+Pj4+Pj4+PiAtLS0gYS9p
bmNsdWRlL2xpbnV4L2tleS5oDQo+Pj4+Pj4+PiArKysgYi9pbmNsdWRlL2xpbnV4L2tleS5oDQo+
Pj4+Pj4+PiBAQCAtMjMwLDYgKzIzMCw3IEBAIHN0cnVjdCBrZXkgew0KPj4+Pj4+Pj4gI2RlZmlu
ZSBLRVlfRkxBR19ST09UX0NBTl9JTlZBTCAgNyAgICAgICAvKiBzZXQgaWYga2V5IGNhbiBiZSBp
bnZhbGlkYXRlZCBieSByb290IHdpdGhvdXQgcGVybWlzc2lvbiAqLw0KPj4+Pj4+Pj4gI2RlZmlu
ZSBLRVlfRkxBR19LRUVQICAgICAgICAgICAgOCAgICAgICAvKiBzZXQgaWYga2V5IHNob3VsZCBu
b3QgYmUgcmVtb3ZlZCAqLw0KPj4+Pj4+Pj4gI2RlZmluZSBLRVlfRkxBR19VSURfS0VZUklORyAg
ICAgOSAgICAgICAvKiBzZXQgaWYga2V5IGlzIGEgdXNlciBvciB1c2VyIHNlc3Npb24ga2V5cmlu
ZyAqLw0KPj4+Pj4+Pj4gKyNkZWZpbmUgS0VZX0ZMQUdfQlVJTFRJTl9ST1QgICAgMTAgICAgICAv
KiBzZXQgaWYga2V5IGlzIGEgYnVpbHRpbiBSb290IG9mIFRydXN0IGtleSAqLw0KPj4+Pj4+Pj4g
DQo+Pj4+Pj4+PiAvKiB0aGUga2V5IHR5cGUgYW5kIGtleSBkZXNjcmlwdGlvbiBzdHJpbmcNCj4+
Pj4+Pj4+ICAqIC0gdGhlIGRlc2MgaXMgdXNlZCB0byBtYXRjaCBhIGtleSBhZ2FpbnN0IHNlYXJj
aCBjcml0ZXJpYQ0KPj4+Pj4+Pj4gQEAgLTI5MCw2ICsyOTEsNyBAQCBleHRlcm4gc3RydWN0IGtl
eSAqa2V5X2FsbG9jKHN0cnVjdCBrZXlfdHlwZSAqdHlwZSwNCj4+Pj4+Pj4+ICNkZWZpbmUgS0VZ
X0FMTE9DX0JZUEFTU19SRVNUUklDVElPTiAgICAgMHgwMDA4ICAvKiBPdmVycmlkZSB0aGUgY2hl
Y2sgb24gcmVzdHJpY3RlZCBrZXlyaW5ncyAqLw0KPj4+Pj4+Pj4gI2RlZmluZSBLRVlfQUxMT0Nf
VUlEX0tFWVJJTkcgICAgICAgICAgICAweDAwMTAgIC8qIGFsbG9jYXRpbmcgYSB1c2VyIG9yIHVz
ZXIgc2Vzc2lvbiBrZXlyaW5nICovDQo+Pj4+Pj4+PiAjZGVmaW5lIEtFWV9BTExPQ19TRVRfS0VF
UCAgICAgICAgICAgICAgIDB4MDAyMCAgLyogU2V0IHRoZSBLRUVQIGZsYWcgb24gdGhlIGtleS9r
ZXlyaW5nICovDQo+Pj4+Pj4+PiArI2RlZmluZSBLRVlfQUxMT0NfQlVJTFRfSU5fUk9UICAgICAg
ICAgIDB4MDA0MCAgLyogQWRkIGJ1aWx0aW4gcm9vdCBvZiB0cnVzdCBrZXkgKi8NCj4+Pj4+Pj4g
DQo+Pj4+Pj4+IFNpbmNlIHRoZSBjb25jZXB0IG9mIHJvb3Qgb2YgdHJ1c3QgaXMgbm90IGdlbmVy
aWMsIGJ1dCBsaW1pdGVkIHRvDQo+Pj4+Pj4+IHNwZWNpZmljIGtleXJpbmdzLCB0aGUgcm9vdCBD
QSBjZXJ0aWZpY2F0ZSBzaWduaW5nIGtleXMgb24gdGhlDQo+Pj4+Pj4+ICJtYWNoaW5lIiBrZXly
aW5nIG5lZWQgdG8gYmUgaWRlbnRpZmllZC4gIFNpbWlsYXIgdG8gdGhlDQo+Pj4+Pj4+IEtFWV9B
TExPQ19CVUlMVF9JTi9LRVlfRkxBR19CVUlMVElOLCBuZXcgZmxhZ3MNCj4+Pj4+Pj4gS0VZX0FM
TE9DX01BQ0hJTkUvS0VZX0ZMQUdfTUFDSElORSBzaG91bGQgYmUgZGVmaW5lZCBpbnN0ZWFkLg0K
Pj4+Pj4+IA0KPj4+Pj4+IEnigJltIG9wZW4gdG8gcmVuYW1pbmcgdGhlc2UsIGhvd2V2ZXIgdGhp
cyBuYW1lIGNoYW5nZSBzZWVtcyBjb25mdXNpbmcgdG8gbWUuICANCj4+Pj4+PiBUaGlzIGZsYWcg
Z2V0cyBzZXQgd2hlbiB0aGUgWC41MDkgY2VydGlmaWNhdGUgY29udGFpbnMgdGhlIHRocmVlIENB
IHJlcXVpcmVtZW50cyANCj4+Pj4+PiBpZGVudGlmaWVkIGFib3ZlLiAgVGhlIHJlbWFpbmluZyBr
ZXlzIGluIHRoZSBtYWNoaW5lIGtleXJpbmcgY2FuIGJlIHVzZWQgZm9yIA0KPj4+Pj4+IGFueXRo
aW5nIGVsc2UuDQo+Pj4+PiANCj4+Pj4+IFJlbmFtaW5nIHRoZSBmbGFnIHRvIEtFWV9BTExPQ19N
QUNISU5FL0tFWV9GTEFHX01BQ0hJTkUgZGlmZmVyZW50aWF0ZXMNCj4+Pj4+IGJldHdlZW4gdGhl
ICJidWlsdGluIiBrZXlzIGZyb20gdGhlICJtYWNoaW5lIiBrZXlzLiAgVGhlIHRydXN0IG1vZGVs
cw0KPj4+Pj4gYXJlIHZlcnkgZGlmZmVyZW50Lg0KPj4+PiANCj4+Pj4gSXNu4oCZdCB0aGUgdHJ1
c3QgbW9kZWwgdGhlIHNhbWUgZm9yIG1hY2hpbmUgYW5kIHNlY29uZGFyeSBrZXlzPyAgQm90aCBh
cmUgc3VwcGxpZWQgYnkgDQo+Pj4+IHRoZSBlbmQtdXNlci4gVGhhdCBpcyB3aHkgSeKAmW0gY29u
ZnVzZWQgYnkgbmFtaW5nIHNvbWV0aGluZyBfTUFDSElORSB3aGVuIGl0IGFwcGxpZXMgDQo+Pj4+
IHRvIG1vcmUgdGhhbiBvbmUga2V5cmluZy4NCj4+PiANCj4+PiBUcnVlIGJvdGggYXJlIHN1cHBs
aWVkIGJ5IHRoZSBlbmQtdXNlciwgYnV0IHRoZSB0cnVzdCBtb2RlbHMgYXJlDQo+Pj4gZGlmZmVy
ZW50Lg0KPj4gDQo+PiBJIHRoaW5rIEkgbmVlZCBtb3JlIGluZm9ybWF0aW9uIGhlcmUsIEnigJlt
IG5vdCBzZWVpbmcgaG93IHRoZXkgYXJlIGRpZmZlcmVudCB0cnVzdCANCj4+IG1vZGVscy4NCj4g
DQo+IEluIG9yZGVyIHRvIGRpc2N1c3MgdHJ1c3QgbW9kZWxzLCB3ZSBuZWVkIHRvIHVuZGVyc3Rh
bmQgdGhlIGRpZmZlcmVudA0KPiB1c2UtY2FzZXMgdGhhdCBhcmUgYmVpbmcgZGlzY3Vzc2VkIGhl
cmUgd2l0aG91dCBldmVyIGhhdmluZyBiZWVuDQo+IGV4cGxpY2l0bHkgc3RhdGVkLiAgSGVyZSBh
cmUgYSBmZXc6DQo+IC0gQWxsb3cgdXNlcnMgdG8gc2lnbiB0aGVpciBvd24ga2VybmVsIG1vZHVs
ZXMuDQo+IC0gQWxsb3cgdXNlcnMgdG8gc2VsZWN0aXZlbHkgYXV0aG9yaXplIDNyZCBwYXJ0eSBj
ZXJ0aWZpY2F0ZXMgdG8gdmVyaWZ5DQo+IGtlcm5lbCBtb2R1bGVzLg0KPiAtIEZyb20gYW4gSU1B
IHBlcnNwZWN0aXZlLCBhbGxvdyB1c2VycyB0byBzaWduIGZpbGVzIHdpdGhpbiB0aGVpciBvd24N
Cj4gc29mdHdhcmUgcGFja2FnZXMuDQo+IA0KPiBFYWNoIG9mIHRoZSBhYm92ZSB1c2UtY2FzZXMg
bmVlZHMgdG8gYmUgaW5kZXBlbmRlbnRseSBjb25maWd1cmFibGUsDQo+IHRob3JvdWdobHkgZXhw
bGFpbmVkLCBhbmQgZW5mb3JjZWQuDQoNCknigJltIHN0aWxsIGNvbmZ1c2VkIGJ5IHRoZSByZXF1
ZXN0IGhlcmUuICBBbGwgdGhlc2UgdXNlIGNhc2VzIGNhbiBiZSBkb25lIA0KdG9kYXkgd2l0aCBp
bnNlcnQtc3lzLWNlcnQuICBUYWtlIHRoZSwgIiBhbGxvdyB1c2VyIHRvIHNpZ24gdGhlaXIgb3du
IGtlcm5lbCANCm1vZHVsZXMiIHVzZSBjYXNlLiAgVXNpbmcgaW5zZXJ0LXN5cy1jZXJ0LCBhbnkg
dHlwZSBvZiBrZXkgY2FuIGJlIGFkZGVkIA0KdG8gdGhlIGJ1aWx0aW4gdHJ1c3RlZCBrZXlyaW5n
LCBpdCBkb2VzbuKAmXQgbmVlZCB0byBiZSBzZWxmIHNpZ25lZCwgdGhlcmUgYXJlIA0Kbm8gcmVz
dHJpY3Rpb25zIG9uIGZpZWxkcyBpbiB0aGUgY2VydGlmaWNhdGUuICBUaGUgc2FtZSBhcHByb2Fj
aCBjYW4gYmUgdXNlZCANCnRvIGFsbG93IHVzZXJzIHRvIGltYSBzaWduIHRoZWlyIG93biBmaWxl
cy4gQW55IGtleSBjYW4gYmUgYWRkZWQsIGl0IGRvZXNu4oCZdCANCm5lZWQgdG8gYmUgYSBDQS4g
VGhlIHNhbWUgZ29lcyBmb3IgM3JkIHBhcnR5IHNpZ25lZCBtb2R1bGVzLg0KDQpUaGlzIHNlcmll
cyBkb2VzbuKAmXQgZW5hYmxlIGtleXMgdG8gYmUgdXNlZCBmb3IgYW55IG5ldyBwdXJwb3NlIHRo
YW4gd2hhdCANCmNhbiBiZSBkb25lIHRvZGF5LiAgSW4gZmFjdCBpdCBsaW1pdHMgaG93IHN5c3Rl
bSBrZXlzIG1heSBiZSB1c2VkLiBJdCBkb2VzIA0KdGhpcyBieSBhZGRpbmcgYSBuZXcgcmVzdHJp
Y3Rpb24uICBUaGUgbmV3IHJlc3RyaWN0aW9uIGVuZm9yY2VzIHRoZSBDQSANCnJlcXVpcmVtZW50
cyBpbWEgZXhwZWN0cy4gVGhpcyByZXN0cmljdGlvbiBpcyBlbmZvcmNlZCBvbiBhbGwga2V5cmlu
Z3MgaW1hIA0KcmVmZXJlbmNlcyAoYnVpbHRpbiBvciBzZWNvbmRhcnkpLiAgU2luY2UgdGhlIG1h
Y2hpbmUga2V5cmluZyBpcyBsaW5rZWQgdG8gDQp0aGUgc2Vjb25kYXJ5LCBpdCBtYXkgbm93IGJl
IHVzZWQsIHNpbmNlIHRoZSBDQSByZXN0cmljdGlvbiBpbWEgZXhwZWN0cyB3aWxsIA0KYmUgZW5m
b3JjZWQuDQoNCg==
