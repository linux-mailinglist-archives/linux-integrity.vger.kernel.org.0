Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 318AF4F9970
	for <lists+linux-integrity@lfdr.de>; Fri,  8 Apr 2022 17:28:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237583AbiDHPak (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 8 Apr 2022 11:30:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237588AbiDHPai (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 8 Apr 2022 11:30:38 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B14DC11BCED;
        Fri,  8 Apr 2022 08:28:25 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 238F4028005378;
        Fri, 8 Apr 2022 15:27:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=n7+Vo89raFFu+cHvZZPoyy876CsTqtvS8NFK766iYkg=;
 b=yAx2fE3so5aDVY87+ok9tidNm4HlXGCNcxIs2UZ/Co8Du6DcVqexWfyuXi90S956mz7Z
 1OSRuUInulzx4aYpKA459x+llxzZKLx+W/Rfq3+5k8vCtudec4LDNUHr1d73PXOqtShO
 X06AuJAtLWK2UMG7h+BjYaocoKltUy7fevdoankwp+bFQgTlgNWLZftpOWvIBa5blhz/
 Xn4RzuQwMxPFczTpK3fyaEyguIM/cTtUQfHJF4nhfVukNdOqE2PtcTkT3Jnvk6KbW7Oh
 SswDOMUcBS07TZIRpBFIChBVO1kUs7Ybu8v0A/mAtdcShgmYUHn7AJZHIw+dpIoz9NcF pQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com with ESMTP id 3f6d937fjt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 08 Apr 2022 15:27:32 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 238FL6vw036455;
        Fri, 8 Apr 2022 15:27:31 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam08lp2048.outbound.protection.outlook.com [104.47.73.48])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3f9805d16k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 08 Apr 2022 15:27:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jVkrF5CpaPErFdx1YKqWJqLmIJl1AGy06fqsn5SalJK7rWm4Re12v8SUxgNOX43F4DGjUFb9pow+6w4cRo8mwoqJVg40n+E7dCr8ONmkVrXYvkgari+CSys4bkjmELDsQPEJaCxocUKS2t/oZC32Urjn0wP3rQYug9ilbJHkLiSJma9Alhh8scMsHQbtPjnylqm3NmGp/bOzfupPtlpVpTpDuv+33HS7odCanXwhNqRg7JDIlQ7Sk4MsT29OPj8xdEE0q+HLpMy9wiG26cOh+aiCAZEBMC4XA0vO22McxyY6ytjbiBpiQWthvgMPdmzad1CwTExdgI884EDjIt6f1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n7+Vo89raFFu+cHvZZPoyy876CsTqtvS8NFK766iYkg=;
 b=FSCqW4iCRe7WZqEK2MhqyMciu8sBlGT4kP6HdIAtqGstWlLqCBbZCXEhxkQWNwXoTdDEFRJF+mFECAU8khhFpssxI1hh4fXZImRDN6e5xoq0tgXsnty/jQNJuWPuOX/+YXDkBCXHtbyiFJKzaPf3STArKvZ7m1AGrUvv/pq11S7b+icAax0KMfSm0xUtZCIgfOghv3Cw1AYNquJ0x3LL67jfBqp5L+btRs+DE64bf0/ldbb9bi7Dw54IVp+vChkosTIJbgoPeQmGf7tmXJTU9Mh3cRe7k0TsOsEsyuQSb/rR1PnAcohbIfd3KQSal8C6V5eL3MBCF9LSTLN0ibZeLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n7+Vo89raFFu+cHvZZPoyy876CsTqtvS8NFK766iYkg=;
 b=ckv/k4pRzEujShbTcq2IJKwnTCGJYAsly9Q5EbkUIJ3LFcmiHftiWB8ueTghHPervskS2lAz89irqCXOW4bKgqfJbakw1jZW/eTISB1GSAffv8mXZA5ztKZ2MGxYZcsL+pCYvymNBvpw3L1jXEHXmXrjQb6uveTz9TR6EmxFeos=
Received: from CH2PR10MB4150.namprd10.prod.outlook.com (2603:10b6:610:ac::13)
 by DM6PR10MB2635.namprd10.prod.outlook.com (2603:10b6:5:b2::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.26; Fri, 8 Apr
 2022 15:27:29 +0000
Received: from CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::7ded:5b3:a28f:2e55]) by CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::7ded:5b3:a28f:2e55%7]) with mapi id 15.20.5144.022; Fri, 8 Apr 2022
 15:27:28 +0000
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
Thread-Index: AQHYSVkvRBwH8IpE9UCisTSasA/N5azmGp0AgAANAAA=
Date:   Fri, 8 Apr 2022 15:27:28 +0000
Message-ID: <EF1544D5-54E8-4D47-82F8-F9337CA7AEA0@oracle.com>
References: <20220406015337.4000739-1-eric.snowberg@oracle.com>
 <20220406015337.4000739-5-eric.snowberg@oracle.com>
 <4fbef0889d6f286c7fcd317db099b4857e1b2fa3.camel@linux.ibm.com>
In-Reply-To: <4fbef0889d6f286c7fcd317db099b4857e1b2fa3.camel@linux.ibm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3608.120.23.2.7)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d91596a3-db05-45c9-42ac-08da19744ae3
x-ms-traffictypediagnostic: DM6PR10MB2635:EE_
x-microsoft-antispam-prvs: <DM6PR10MB26355C6D87565AC6D1050F8E87E99@DM6PR10MB2635.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OUc+Z3/xUfPLu4atJ++6z6eYjTQadmAQhJ7zZBepUaXI4alDh+OaNrphlx539eL9r5YYoFqbyhEJMYlek70TM9hf7DvmZX0HFaEaqUQtB2K1PmMOH+vbItysWXoQNoh0SFK8BO1eumnbmT/062+FuLjdx4uTJ2RznssfAxhBFQddCeo4AJvwWYbG6GTAihpBc4JoUntC83juxBp7d+QZ/zZP/SfAnGw6QZdPx/YHkMfE+VbSHrBD5mtZs58/Bnsd2Mn0DmJ/hy0xx2UPc249dwz6YMpGPf3VveW843Conawo5EnoDEIECtu7O070kQy0aCG3cBqaCiixf4ba/DDyT9fVVzDFyzJQFbupG8AQ1bmfE2eSG0dlcU20RN/nA+6zQbicVYhg7B2AqlqsUGbhFoJwmQpyHpTAfjSZv7pd3E/iyMm/tEP0QVnMxRkxpheB9SMkzEAe2TNUKOEEIIsyIT87QD5uza7Eh58FgIUgzNrPHw1UMLrCUpx4kkHRbCtkGE/AnfCXE5y9Bv1SXR/GG7myN5B440bpvjr/5yS14okLNt14L1/N8Am1g4uIgUbUpQodPCnCJ3uzPQYXObzJc6TVU90q8mg/x9Bphd5a0fpV6wcLNX9GFLTm7Q9mUrQLSs3zdZ16Y9eGxoJLX6iK94S75YroTgkoOx2Z6ADfAq7tUhuD4yiFpStD/c7gmw7D95wSkIGmzv7mBxTuY1KT4QslRPPbXD+bBkGzcB7bWxA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4150.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(508600001)(8676002)(6512007)(2906002)(6506007)(53546011)(316002)(76116006)(66946007)(66556008)(66446008)(66476007)(4326008)(64756008)(6916009)(71200400001)(86362001)(54906003)(6486002)(122000001)(91956017)(38070700005)(186003)(2616005)(26005)(83380400001)(38100700002)(33656002)(5660300002)(36756003)(44832011)(8936002)(7416002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MUY3aUtsZUlld0oxalArYkhBcG54eFVmeUtGd1E4aFZGOGtCZWNCTTJCVDJR?=
 =?utf-8?B?WkpRckUwWlhHM292V0RXTENmUVNPcEJWeGtsdTNPQU15aFYwM0xVcG55NWZP?=
 =?utf-8?B?bC9tM3F4c2QrTmg1K1YvNEIrSGxiY09JbDVNcGhOZlBJMVgyYVBrSk92bVkv?=
 =?utf-8?B?d2F5S3NlNzhlak5WWXFzc2RRdFYxVE54MUQ3WjdSaU53Ylc4YXJ5WnUyYXJ2?=
 =?utf-8?B?RFl3Nno4ZHRKSk16R0JCNm1ENVdhTkh2R01DNGZ3dzdoWE53ZkY2cmFwQ1BO?=
 =?utf-8?B?MUdMQ3hQZFRJNmgvdHZwK2dvVWRwNEFyTy9DZXROcEpNL1JKckE4QWM5UzNk?=
 =?utf-8?B?ekdGNlc1d2NaYkdkVXZFeWlqWGtiNGVST29oOVN2eld1eFRadzFnQlowUUNn?=
 =?utf-8?B?TlFlVHJPRUN6MXdESGlzSzJZc3B1bDdPcXNidjV3ZG1vSThZN1BZTGxDTHZO?=
 =?utf-8?B?dldXUTZPNVhRcVppWHpUV1JzeHZzcVRZOW1GTXN0WWtKL1ZHUVdhREJSL09G?=
 =?utf-8?B?MVlET3lvM0pJeER5WFFVc09sRlVwUC9jVG9XVmROcDFyaW9tempHZVVJcnd5?=
 =?utf-8?B?WmZIUkNqSkFXcjQ4UW5iNmkzckNzdytUZVZGYlh6MjYwVm1lNnpUQW5ibHNq?=
 =?utf-8?B?WFlGb1RUWlRsdElSSjBLbVA4eU1IZXNwbXNIdG1tTW5jM0VGWDFvc2dsdVVn?=
 =?utf-8?B?RG9OajJjVWRwRzN3VWxlZUV1bHd4ZER3ejBtelFTSncxYW5LcjFjKzlJcmtx?=
 =?utf-8?B?bnJRYk12VUUvdlhWcVJxZDFLR2VtZ2U2WEFxQTNETnFBdStGYmNHcWxnelVM?=
 =?utf-8?B?RER2OHRuVUU4MFN1SGV6cDVHNjl2T0hEMk02dnBJK3FtNlVyd2puVS80eDEv?=
 =?utf-8?B?Q1R0TXdyTmt0amdVQTB5cS9ydlNYUG94U0Vlb00zTXhacDczRDJpbjFrb3J4?=
 =?utf-8?B?akdXVjRoaHdLU285UDA1SjVZZTR4akN5a1NBMGx2MmZtS2RwRU96eUIwMmFU?=
 =?utf-8?B?SGRCTDBoVFlNZFhMMEFrWGYxdzdENUVuV0VGUkt4NnlDT1B0OWxTZ01wd3JQ?=
 =?utf-8?B?TVNUMzNLSHcvTGhJSitPZndVNVg1UGxEeEpQcSsyZDdLcmlHL3dvTXlpRWs0?=
 =?utf-8?B?NEZhTGc2b01Ba3ZXbFFVdGVZT1B0UGE5c2hjbWxOb2gyUnNtb2pqY3dvMEFG?=
 =?utf-8?B?T2dOUWt0bEFtejROcGV4aHQyaENjbXFvSllGNUFHL08wY1k5dDBmWWJvU1pU?=
 =?utf-8?B?VGZud1c0Y0w4T2pWRzFwZktBa0pYZjZKR2ZRVkpubVBxMmZ6OVVyd2Q1bDl2?=
 =?utf-8?B?b0JIcFpwMmhNanEzbDV3K1ZsNklkczhoMnVCSzl2c1c3ZG5XbDRQazdrd0h3?=
 =?utf-8?B?SVpEN2M5QWdDRlBTVXh0STg0aCtJMG1LK1BOQlBqR2NjdksxR2VBNnVQZUh3?=
 =?utf-8?B?NDZTZWZlVEJueDIrdzU2RUtBWEU4WlNuZDBrcWtFenVJUDZoZEJQd1pjNEpy?=
 =?utf-8?B?RXE1TjRJSU92MGRrUkFNZTY3eU9GU1VOQVRJdDZSbjZCcEg0ZGRmbDZLQVJ2?=
 =?utf-8?B?K0JPVnR0MVp6dFFwR3c5d0NQRDdycjAwM1VuTTVyNmZreWxsSjQ0WGhZRmdK?=
 =?utf-8?B?OFhweC94amR5VWhQODVtY2pUR0duOXVpM1hsYStVd1RpYzQrMHpDSkFBTUFW?=
 =?utf-8?B?czd5UmJ5TkZyeDQxK1lzbmZZVnFFYWdXS0l5T0FkMVpEKzRod1ZUdi9mSG5E?=
 =?utf-8?B?NDFHMCtRN01hTHVzTXlGaEN5WUNQQ0poKzE0cVJROEFRTkdwQUJHWnNPckJt?=
 =?utf-8?B?dWNwRU5XNGh3MHRod2R5YTMvaVBjNmJJNUc4QWIrb3dOKzN0QnlNZzdTdGFh?=
 =?utf-8?B?YTRxUG8zQ3NVZ3ZVeFplaDYzV1Z4bFRKSnNySnR3WXFqTFpOQ3haeTdwUFpE?=
 =?utf-8?B?REFpbUxtZGRkVnFaZTVYRWVjQXhBSmdESWtwd0lMNm1OQWJGVnNuL0NvTUlL?=
 =?utf-8?B?aStCcmMvVDEvQ0R3QXFRR0laY08wRTVrekJ0VnZpVTBMd3ZsZ0Z5d1g2YVNF?=
 =?utf-8?B?TXlTV1VVRVIxMU5xNC84aUE4VlhyMWRubkplNHd2Nmk3QURhV0ZHTVZSRWt1?=
 =?utf-8?B?TSsrNGtyVTRORTAyUENsZ3RTY20zcjR1VHNtck5tcWtHMnJHZ3QxSGFzOFVZ?=
 =?utf-8?B?ZEdTOFRlQmlEaFNGMjB5dWJhL0tXb1dCUzdrWXhMelgycXZkbXlML2w4SG0v?=
 =?utf-8?B?c3ZpdXZyWjNaUU0zUHZEMlV3NFR6MkVQczBMTWFOYkh2RGVRLzZtTFZXQWxP?=
 =?utf-8?B?OGNjN2pjR0FyNlFERjFaMlRMUUZnaDdzK1BlSHZXdlg1SHV3VExsTTZTTmtR?=
 =?utf-8?Q?Hd3oOv8TSXy8Wlg0=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5CA81369E2BCFD4F82777D709A8B5739@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4150.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d91596a3-db05-45c9-42ac-08da19744ae3
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Apr 2022 15:27:28.8873
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Q61FihiW2Uj2f6o9BJ8dY4utyNwYWjQA5p+TKgaySshCmQ6eUw9V7XwXosG65D5PrEdvAA0CEcI60ZVe4NMFWBq85qWcSflKciQAtx67quI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB2635
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.425,18.0.858
 definitions=2022-04-08_05:2022-04-08,2022-04-08 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 adultscore=0
 suspectscore=0 spamscore=0 mlxlogscore=999 bulkscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204080076
X-Proofpoint-ORIG-GUID: Z1um-upnRQ7ni9eoZg1XlTdkWbLnUwrc
X-Proofpoint-GUID: Z1um-upnRQ7ni9eoZg1XlTdkWbLnUwrc
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

DQoNCj4gT24gQXByIDgsIDIwMjIsIGF0IDg6NDAgQU0sIE1pbWkgWm9oYXIgPHpvaGFyQGxpbnV4
LmlibS5jb20+IHdyb3RlOg0KPiANCj4gT24gVHVlLCAyMDIyLTA0LTA1IGF0IDIxOjUzIC0wNDAw
LCBFcmljIFNub3diZXJnIHdyb3RlOg0KPj4gDQo+PiBUaGUgZmlyc3QgdHlwZSBvZiBrZXkgdG8g
dXNlIHRoaXMgaXMgWC41MDkuICBXaGVuIGEgWC41MDkgY2VydGlmaWNhdGUNCj4+IGlzIHNlbGYg
c2lnbmVkLCBoYXMgdGhlIGtlcm5DZXJ0U2lnbiBLZXkgVXNhZ2Ugc2V0IGFuZCBjb250YWlucyB0
aGUNCj4+IENBIGJpdCBzZXQgdGhpcyBuZXcgZmxhZyBpcyBzZXQuDQo+PiANCj4+IFNpZ25lZC1v
ZmYtYnk6IEVyaWMgU25vd2JlcmcgPGVyaWMuc25vd2JlcmdAb3JhY2xlLmNvbT4NCj4+IA0KPj4g
ZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGludXgva2V5LmggYi9pbmNsdWRlL2xpbnV4L2tleS5oDQo+
PiBpbmRleCA3ZmViYzQ4ODEzNjMuLjk3ZjZhMWY4NmEyNyAxMDA2NDQNCj4+IC0tLSBhL2luY2x1
ZGUvbGludXgva2V5LmgNCj4+ICsrKyBiL2luY2x1ZGUvbGludXgva2V5LmgNCj4+IEBAIC0yMzAs
NiArMjMwLDcgQEAgc3RydWN0IGtleSB7DQo+PiAjZGVmaW5lIEtFWV9GTEFHX1JPT1RfQ0FOX0lO
VkFMCTcJLyogc2V0IGlmIGtleSBjYW4gYmUgaW52YWxpZGF0ZWQgYnkgcm9vdCB3aXRob3V0IHBl
cm1pc3Npb24gKi8NCj4+ICNkZWZpbmUgS0VZX0ZMQUdfS0VFUAkJOAkvKiBzZXQgaWYga2V5IHNo
b3VsZCBub3QgYmUgcmVtb3ZlZCAqLw0KPj4gI2RlZmluZSBLRVlfRkxBR19VSURfS0VZUklORwk5
CS8qIHNldCBpZiBrZXkgaXMgYSB1c2VyIG9yIHVzZXIgc2Vzc2lvbiBrZXlyaW5nICovDQo+PiAr
I2RlZmluZSBLRVlfRkxBR19CVUlMVElOX1JPVAkxMAkvKiBzZXQgaWYga2V5IGlzIGEgYnVpbHRp
biBSb290IG9mIFRydXN0IGtleSAqLw0KPj4gDQo+PiAJLyogdGhlIGtleSB0eXBlIGFuZCBrZXkg
ZGVzY3JpcHRpb24gc3RyaW5nDQo+PiAJICogLSB0aGUgZGVzYyBpcyB1c2VkIHRvIG1hdGNoIGEg
a2V5IGFnYWluc3Qgc2VhcmNoIGNyaXRlcmlhDQo+PiBAQCAtMjkwLDYgKzI5MSw3IEBAIGV4dGVy
biBzdHJ1Y3Qga2V5ICprZXlfYWxsb2Moc3RydWN0IGtleV90eXBlICp0eXBlLA0KPj4gI2RlZmlu
ZSBLRVlfQUxMT0NfQllQQVNTX1JFU1RSSUNUSU9OCTB4MDAwOAkvKiBPdmVycmlkZSB0aGUgY2hl
Y2sgb24gcmVzdHJpY3RlZCBrZXlyaW5ncyAqLw0KPj4gI2RlZmluZSBLRVlfQUxMT0NfVUlEX0tF
WVJJTkcJCTB4MDAxMAkvKiBhbGxvY2F0aW5nIGEgdXNlciBvciB1c2VyIHNlc3Npb24ga2V5cmlu
ZyAqLw0KPj4gI2RlZmluZSBLRVlfQUxMT0NfU0VUX0tFRVAJCTB4MDAyMAkvKiBTZXQgdGhlIEtF
RVAgZmxhZyBvbiB0aGUga2V5L2tleXJpbmcgKi8NCj4+ICsjZGVmaW5lIEtFWV9BTExPQ19CVUlM
VF9JTl9ST1QJCTB4MDA0MCAgLyogQWRkIGJ1aWx0aW4gcm9vdCBvZiB0cnVzdCBrZXkgKi8NCj4g
DQo+IFNpbmNlIHRoZSBjb25jZXB0IG9mIHJvb3Qgb2YgdHJ1c3QgaXMgbm90IGdlbmVyaWMsIGJ1
dCBsaW1pdGVkIHRvDQo+IHNwZWNpZmljIGtleXJpbmdzLCB0aGUgcm9vdCBDQSBjZXJ0aWZpY2F0
ZSBzaWduaW5nIGtleXMgb24gdGhlDQo+ICJtYWNoaW5lIiBrZXlyaW5nIG5lZWQgdG8gYmUgaWRl
bnRpZmllZC4gIFNpbWlsYXIgdG8gdGhlDQo+IEtFWV9BTExPQ19CVUlMVF9JTi9LRVlfRkxBR19C
VUlMVElOLCBuZXcgZmxhZ3MNCj4gS0VZX0FMTE9DX01BQ0hJTkUvS0VZX0ZMQUdfTUFDSElORSBz
aG91bGQgYmUgZGVmaW5lZCBpbnN0ZWFkLg0KDQpJ4oCZbSBvcGVuIHRvIHJlbmFtaW5nIHRoZXNl
LCBob3dldmVyIHRoaXMgbmFtZSBjaGFuZ2Ugc2VlbXMgY29uZnVzaW5nIHRvIG1lLiAgDQpUaGlz
IGZsYWcgZ2V0cyBzZXQgd2hlbiB0aGUgWC41MDkgY2VydGlmaWNhdGUgY29udGFpbnMgdGhlIHRo
cmVlIENBIHJlcXVpcmVtZW50cyANCmlkZW50aWZpZWQgYWJvdmUuICBUaGUgcmVtYWluaW5nIGtl
eXMgaW4gdGhlIG1hY2hpbmUga2V5cmluZyBjYW4gYmUgdXNlZCBmb3IgDQphbnl0aGluZyBlbHNl
LiAgUGx1cyB0aGlzIGZsYWcgY2FuIGJlIHNldCBmb3Iga2V5cyBsb2FkZWQgaW50byB0aGUgc2Vj
b25kYXJ5IHRydXN0ZWQgDQprZXlyaW5nICg2dGggcGF0Y2ggaW4gdGhlIHNlcmllcykuICBXaGVu
IGFuIGludGVybWVkaWF0ZSBDQSBnZXRzIGxvYWRlZCBpbnRvIHRoZSANCnNlY29uZGFyeSwgdGhl
IGZsYWcgaXMgc2V0IGFzIHdlbGwuDQoNCg==
