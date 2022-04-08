Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCB144F9F6E
	for <lists+linux-integrity@lfdr.de>; Sat,  9 Apr 2022 00:00:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239936AbiDHWCm (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 8 Apr 2022 18:02:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbiDHWCk (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 8 Apr 2022 18:02:40 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28F391EAE4;
        Fri,  8 Apr 2022 15:00:34 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 238ISae1024458;
        Fri, 8 Apr 2022 21:59:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=MWsdfpU8UxogwfE5E2NVYgC1sQAH6FmcYj2EDcTNDHg=;
 b=X+QQZru6HhPjLssPFJCLFY+NN6TK/bnyAJilQXlX76uno2n+jCmDo8GJPwtP+0Vu3ca5
 Bqs5SAXfihXYC4FdUWiV2cL7FL6LECRs+NUcEaGSd0B2cTyyRYzjimZtQX0FC7K7n6N1
 Lu/0bJv8JRZdl7DZ0Ppyje98JdZhpKrVJLv7coNJcYJi7PxvaTljgcepFdpiH1OC94kC
 07ZKSfLlSD675V8iWnUHioYJ1QwHTjbtSqV6Lc97ubeJ0XJP9Cj4iKjYSxGjtq5CQjJp
 /P514AMaVuKlVucgA+CPHs93MS9V/HiQrLedTxP2BqOKwCnSVjTK2wiQnQU/vqbMgTPS sg== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com with ESMTP id 3f6f1tgpn0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 08 Apr 2022 21:59:54 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 238Lv9fi011486;
        Fri, 8 Apr 2022 21:59:53 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam08lp2043.outbound.protection.outlook.com [104.47.73.43])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3f974fv1dc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 08 Apr 2022 21:59:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M+4OHj1XdnTtX/Xb8fvKNVEiEiOgVd0msCn5OxNOOUyOJCLi3aI6Jn2tEtvNWafghENP4qY5cLgto/cuYgfX82nixDpeiGRRl4EBGJgO5b3HZwLbIYslFqj6pf2LOcl2VebGgxfjcYoHocqiNBH5kApqf63WUoCo8a7JhgVsdcZ9Rl59xNx4g36Vn6oE/lLLDZZyx7Y69ttgOOG4Gv5X8C+7fQ6w2pMf5FwfnVOU+oxL4ruNYZCCZiNKMM/YpbrW15uQi/zGmkfkWpqv5IxdwKKndDQmbnoAFb6Nww8p4gBi5DpvQS+tNx0cWAOqzCp81vR0xzdo9UqHRTk7DUh0zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MWsdfpU8UxogwfE5E2NVYgC1sQAH6FmcYj2EDcTNDHg=;
 b=oYE02DOeYPbanEMOKbUVTijL5pelxbrRCcUoesfKiiDE2ntA+Xz24ogW/fN2v2Bwul2Igc/GjT/7Ch43vsXZTFyxLRFRyOniO9sey2gkd8iyVHCgPMPyQcd2w7YG0dCam8QrjBLBGw2po7BMBdbhuK0vObVCBNy3nseJGdI4ZBmbpvhF+i11WD86Z8h+KosjmpIIWCSo4OSavjsULH8zciS31Dz9VorEz+hxH6d3x7ntWcJZBRfUg/E8JgL2Eb87Y2VcGNmevc1GcW/zAWjinTuNGTATindVNh1lkmfBVFvgoAqdMsJpxBtstSZ1M6avU88rpQwdvm/nhscrW0ysSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MWsdfpU8UxogwfE5E2NVYgC1sQAH6FmcYj2EDcTNDHg=;
 b=Eo/P/XYHqDMVo9t9HLQTWy1kdH1vEJmiTunJzA1XhIy7KUO3fcRR2S/AQkxnYr4SIXfas8kJ+RifHPnuXzGb8VN7zekm5cxLYLBSdSYIhy7jNkLwgM63/6eGeJVsywQeYcWpYBcVLT9QOn5Y2IccKAL47qET+UbyBLWJ8GdnLLk=
Received: from CH2PR10MB4150.namprd10.prod.outlook.com (2603:10b6:610:ac::13)
 by BN6PR10MB2019.namprd10.prod.outlook.com (2603:10b6:404:101::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.26; Fri, 8 Apr
 2022 21:59:50 +0000
Received: from CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::7ded:5b3:a28f:2e55]) by CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::7ded:5b3:a28f:2e55%7]) with mapi id 15.20.5144.022; Fri, 8 Apr 2022
 21:59:50 +0000
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
Thread-Index: AQHYSVkvRBwH8IpE9UCisTSasA/N5azmGp0AgAANAACAABh+AIAACxSAgAAU5ICAADUngA==
Date:   Fri, 8 Apr 2022 21:59:49 +0000
Message-ID: <BFA04505-F4BC-4CF8-B813-EE81DBD90E09@oracle.com>
References: <20220406015337.4000739-1-eric.snowberg@oracle.com>
 <20220406015337.4000739-5-eric.snowberg@oracle.com>
 <4fbef0889d6f286c7fcd317db099b4857e1b2fa3.camel@linux.ibm.com>
 <EF1544D5-54E8-4D47-82F8-F9337CA7AEA0@oracle.com>
 <b8965652274b49ba7c6f67cad6d42965cf984b42.camel@linux.ibm.com>
 <16DDA7F1-95BA-4279-BE4E-9F713A905B36@oracle.com>
 <986199739ff8bd730b9aabe8882e245946d3d9e9.camel@linux.ibm.com>
In-Reply-To: <986199739ff8bd730b9aabe8882e245946d3d9e9.camel@linux.ibm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3608.120.23.2.7)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: af08d5f4-7453-4234-0f8c-08da19ab1a74
x-ms-traffictypediagnostic: BN6PR10MB2019:EE_
x-microsoft-antispam-prvs: <BN6PR10MB201979E98FAFA694C1E6DDA687E99@BN6PR10MB2019.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TrON1X4v7Ya0jleZsFwlvlfg1XWK1pwi5AvhWsXVYS67Ype/hUtsZn3IUha2czlQQ+ZyYpJBueu19Sagb0MKAL/nqou4yuBMxDs/0kClbc5pyHlvanovnR3E3Ym5MmefFT+pRfG1jc59C7dkUjB5A0GVx93dRufzh8PQr4S56KAevzetqrfL/t4qmpAd60o85hs3LYPsmtWogFXuOMZRh5p5xTAwgWj/IEnWfl1vQnG4VbvLC/gpCbm+Q04dnGCJqHFQp4C9o1Pm31uXLgPE4UAHOl0zA+3MgY0O6hAzAvD/GJhZ52QbmSVrJJgo+zobTWVSlHKAZILh99FhLnQjBg5ACmz4v33FyHWh5yBPCR9Fh1t43r8MawD+pRCfRlyMsq8QhJwP+L9Gu7TUqS0rRDbkcDtW8AQ7k+C/hYcGmPFW4xA5lKcpNtNLP9aTCZaVdcAbLde613UvSD1lfE2tO7hdeSc/JgaG8gq6mpZrejY4YyI9wBkA/Ch8j40syvViDhYSGF3WU2EIAoYdR/BillArRnyYWxdV/BokJDakvrbwCusRh9Yna1Ddx1VmWo5OWhCtnrFeEMPjrtzCE/s+smq7k9wv+1bQTkUSxpPgiyoOfQdMARa32gQRGi4sLjuIcDBXxX5dIprS3pz2sCEtOYeO5pk6Ycbi7Y8zx/kb09+SweoBEjsMdtjFx82LgHL4uwDsWsoE291SxmJSp4tBBnFQEvK4EtLK+eE3H6vF5y4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4150.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(2616005)(44832011)(26005)(186003)(33656002)(316002)(8676002)(71200400001)(8936002)(5660300002)(7416002)(83380400001)(36756003)(6916009)(54906003)(86362001)(38100700002)(6506007)(6512007)(122000001)(6486002)(76116006)(66946007)(66556008)(66446008)(64756008)(91956017)(508600001)(53546011)(4326008)(66476007)(38070700005)(2906002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WHg3cm53RHlBejNXNjJHTFJaTitaNzZpcXNmUmxCemhaeDZZQ1FrNGRDS0ZL?=
 =?utf-8?B?Y2tqRXRQR2FJdDhLa0k1Z1hBVkZJSGV1YXVwbFU5cDNGMHB2Nk1RVE5DQXkv?=
 =?utf-8?B?LzVjUXFVczdSdEc5aDNLLzlOYStVSjlCN0Z1RzFZZGJUUjVraEVVR3JmSEtF?=
 =?utf-8?B?TEZFVms3emlWVVA4R3BkcFc0czFYREdVVUhaTU5UaC9zaDlvZDJOMTB6blFO?=
 =?utf-8?B?dCsrSDU1Q1UvRms1RmhsZm1saTlkYmpaVEtHZllCQXlhOW4xMmpGUGtxRWk0?=
 =?utf-8?B?ZVZTUEVZWExFTUtjTEpzVUk4TCtoenowUWs0L0Z6a01DWDlvanc2WGNYcFQ3?=
 =?utf-8?B?dTJ4dnJHK3RvZnd2Y2UyRXJ4SVBhTE9QbnZBcURHZEh6a1dwaml1ZDJxWWlY?=
 =?utf-8?B?dnU4S3VxdllUVUZLZ1JSTmtOSjZQSmQ3Njg5ZU1udFAzdE43KzAwR2NqTUZ3?=
 =?utf-8?B?dWNnVDBQR0M3OUpYb2lSMDM1Q1hiS3FQNVBHR2ZZdWJ2S3ZqM1NoMmlKbkdG?=
 =?utf-8?B?MzFNdDd1MW9IOVZJeXRpODU2cW9GcFphZ1lFRElSRjljOWZvOXJrZXhtMERV?=
 =?utf-8?B?WWtFUk83Q2xxd295Z0pKQmc2cnRta1pDbWFDVGlRUGtaYXBjNXpISnM4Y2Vx?=
 =?utf-8?B?amdCNnlhQjdWUFhxL3YwSjFvNXBUdGFpS3pJc3ZuOUFkamtGblBqMGV6eWNk?=
 =?utf-8?B?RnZuakVHQm0vbHdnYThGL25SblZRU1FFWDlMcmRIZEdLQ0IyU00yTEU1ZGVW?=
 =?utf-8?B?T0hBOXdNOGZjQk1iL0V5WlZaRkY2V0lwRTVTdWV4cmJPRkYyY2dXTFpxWU5n?=
 =?utf-8?B?YlVENzhwdjFYUUFHU2ljOUtHaWdVWWU0TUxmZGFzM1lOOHFFejBva3M1cy96?=
 =?utf-8?B?bERyTXl6dmVnWTFSLzVhT0YyUVJFWjhyWTRJWm5ZYUNJU0xOWVNsRnVkeFlr?=
 =?utf-8?B?RVVFT3FXN2QxZUhadVJXZTNXNWNZaEZCR3Y2WW5mM29Lc3ZDcjZRSGYxcUpH?=
 =?utf-8?B?SlZmbzFDeHdtZ1laL1hTMVFHdWlKMUY0dDBGZThmNTBSM0kyOFdCaXZjdlNF?=
 =?utf-8?B?elV6UWVlM1lZY1RjVmVmNlQxNVZleTVDUlY5Z0pvYnRtWDZzb2dWY1UzSEZR?=
 =?utf-8?B?b0tQVWZvOHFNVDNGcWlBUFI4THpROE0xV0FaN2VwS2RTOVZROU5LRm82SUlv?=
 =?utf-8?B?RWk0TEN5eHFzZWs0Tk5vRGtYdzRtNW5uS1plaUxiQnVaVGNSbk9hZDNwbmhi?=
 =?utf-8?B?NTFmOGt2ZVRTd2JpdEdnZmdTamd3TEdIRHJpVEgvOWMvU1ZHRzRYM2ZXVzkv?=
 =?utf-8?B?QWY3SjBNcDVIY2tFTDZOQ3JqS1RpeWR5OHdVSFNpaHFpbTNTQ0QxTHc1YzdK?=
 =?utf-8?B?am03SEJtWU1MV0J1QktMVEZFcVo2akM3TXdLOFUwR3YvWGhQYWdHVFU1Zk1K?=
 =?utf-8?B?R3FobDVzc3dQV2JvYmlGMG5VNStqZDlZd3J3aFZGSFZRRWdrZTlEcCsxN0pv?=
 =?utf-8?B?akZEdTdJWjhuWGdEY1FVT1gzWWdRMUZxakx3VGU2RVhTUnM2Zk9QelZNTkdK?=
 =?utf-8?B?bTVkckpHQkM1b3dHUGlDNXBFTENuMTc4QkRMSE9kdnIyRzFjQU9LcXo0Nzkv?=
 =?utf-8?B?UTBkdnhSKzhPbHRzZ0puaGNFSDJMbnQyM0dFMVNtQTNidUlJd2FreGdHK0JJ?=
 =?utf-8?B?SmNrdWlhVVBNcUxRMXYxV1dHbFpPaEsrWHFVWmZrOEEzNkJvT3hxUklYWlQ5?=
 =?utf-8?B?K3BLTWFYSWVqcEJkRFZObGtENFpFRUNzNW8xdnVMWDNoLzFCS0FvM3JzUkhq?=
 =?utf-8?B?ZUhUYVdJZjQxVk9yM3pMeGlqRk1VM08xaHlCeFRLY0pVckxMYjdESGt2Vm8r?=
 =?utf-8?B?MVhnaVEyY3paNDNwdWVDRHlIbEtsNzNWV2JrejlaYkg0THBJUFRWUi82aGFI?=
 =?utf-8?B?Y2c2allaSGVlN0p3cHpMZEhleFUxcVAwalMzWUpRb0RyTTNFUnRBK0trYkN4?=
 =?utf-8?B?bk9HcnZ2dEYvUU9RM3Fzb2ViazRHM3NSRzE5QngyNmNQd2prbkgvSk1wWlJ1?=
 =?utf-8?B?dGJnR3c1ZStRZHhhR1Z1aFM5eWExZGVRRisxVGlZSkUrUTJiVEs4NTVBci9B?=
 =?utf-8?B?RlVtaDkyUkFoaXRWTS9ySGI4UjZ0WUdMNVBMak5OT2VyNW1WazM1c1JPUmkz?=
 =?utf-8?B?RkFLM1ZRei9HME9XNVk0QXdFaGJDRFkrT05mcEphM2o1UXVwTHZ1TzFuY1dV?=
 =?utf-8?B?LzdZK2JOcy9RR3RMYnlNYk5Sb25WVENGMThvcmlwNUhrWm00T0pVT2pRZHVP?=
 =?utf-8?B?RUxsdGdaaXlSWGw2RnYyUFYxY3hONWdvUjZIVk1vdlN3YU8yR2lwOEIvR0xB?=
 =?utf-8?Q?/jYaOZfpOP1143og=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BFC2634D4962D44B99E6234EBCD5A317@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4150.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af08d5f4-7453-4234-0f8c-08da19ab1a74
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Apr 2022 21:59:49.9793
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Jio4oKsJUSnyCZJFgTYGJ4y/e2lQRTQOc07t911LqeokBiFC9G97K2xb0lfSc2B0kKcW1Xx56tVKdwOU7ubS0hgjxLk1zlfQ74guuS5YehI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR10MB2019
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.425,18.0.858
 definitions=2022-04-08_08:2022-04-08,2022-04-08 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 malwarescore=0
 mlxlogscore=999 suspectscore=0 adultscore=0 bulkscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204080112
X-Proofpoint-ORIG-GUID: 9ulcxzbMDaMSQN0oEhgkurB1rBe-lXTn
X-Proofpoint-GUID: 9ulcxzbMDaMSQN0oEhgkurB1rBe-lXTn
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

DQoNCj4gT24gQXByIDgsIDIwMjIsIGF0IDEyOjQ5IFBNLCBNaW1pIFpvaGFyIDx6b2hhckBsaW51
eC5pYm0uY29tPiB3cm90ZToNCj4gDQo+IE9uIEZyaSwgMjAyMi0wNC0wOCBhdCAxNzozNCArMDAw
MCwgRXJpYyBTbm93YmVyZyB3cm90ZToNCj4+IA0KPj4+IE9uIEFwciA4LCAyMDIyLCBhdCAxMDo1
NSBBTSwgTWltaSBab2hhciA8em9oYXJAbGludXguaWJtLmNvbT4gd3JvdGU6DQo+Pj4gDQo+Pj4g
T24gRnJpLCAyMDIyLTA0LTA4IGF0IDE1OjI3ICswMDAwLCBFcmljIFNub3diZXJnIHdyb3RlOg0K
Pj4+PiANCj4+Pj4+IE9uIEFwciA4LCAyMDIyLCBhdCA4OjQwIEFNLCBNaW1pIFpvaGFyIDx6b2hh
ckBsaW51eC5pYm0uY29tPiB3cm90ZToNCj4+Pj4+IA0KPj4+Pj4gT24gVHVlLCAyMDIyLTA0LTA1
IGF0IDIxOjUzIC0wNDAwLCBFcmljIFNub3diZXJnIHdyb3RlOg0KPj4+Pj4+IA0KPj4+Pj4+IFRo
ZSBmaXJzdCB0eXBlIG9mIGtleSB0byB1c2UgdGhpcyBpcyBYLjUwOS4gIFdoZW4gYSBYLjUwOSBj
ZXJ0aWZpY2F0ZQ0KPj4+Pj4+IGlzIHNlbGYgc2lnbmVkLCBoYXMgdGhlIGtlcm5DZXJ0U2lnbiBL
ZXkgVXNhZ2Ugc2V0IGFuZCBjb250YWlucyB0aGUNCj4+Pj4+PiBDQSBiaXQgc2V0IHRoaXMgbmV3
IGZsYWcgaXMgc2V0Lg0KPj4+Pj4+IA0KPj4+Pj4+IFNpZ25lZC1vZmYtYnk6IEVyaWMgU25vd2Jl
cmcgPGVyaWMuc25vd2JlcmdAb3JhY2xlLmNvbT4NCj4+Pj4+PiANCj4+Pj4+PiBkaWZmIC0tZ2l0
IGEvaW5jbHVkZS9saW51eC9rZXkuaCBiL2luY2x1ZGUvbGludXgva2V5LmgNCj4+Pj4+PiBpbmRl
eCA3ZmViYzQ4ODEzNjMuLjk3ZjZhMWY4NmEyNyAxMDA2NDQNCj4+Pj4+PiAtLS0gYS9pbmNsdWRl
L2xpbnV4L2tleS5oDQo+Pj4+Pj4gKysrIGIvaW5jbHVkZS9saW51eC9rZXkuaA0KPj4+Pj4+IEBA
IC0yMzAsNiArMjMwLDcgQEAgc3RydWN0IGtleSB7DQo+Pj4+Pj4gI2RlZmluZSBLRVlfRkxBR19S
T09UX0NBTl9JTlZBTAk3CS8qIHNldCBpZiBrZXkgY2FuIGJlIGludmFsaWRhdGVkIGJ5IHJvb3Qg
d2l0aG91dCBwZXJtaXNzaW9uICovDQo+Pj4+Pj4gI2RlZmluZSBLRVlfRkxBR19LRUVQCQk4CS8q
IHNldCBpZiBrZXkgc2hvdWxkIG5vdCBiZSByZW1vdmVkICovDQo+Pj4+Pj4gI2RlZmluZSBLRVlf
RkxBR19VSURfS0VZUklORwk5CS8qIHNldCBpZiBrZXkgaXMgYSB1c2VyIG9yIHVzZXIgc2Vzc2lv
biBrZXlyaW5nICovDQo+Pj4+Pj4gKyNkZWZpbmUgS0VZX0ZMQUdfQlVJTFRJTl9ST1QJMTAJLyog
c2V0IGlmIGtleSBpcyBhIGJ1aWx0aW4gUm9vdCBvZiBUcnVzdCBrZXkgKi8NCj4+Pj4+PiANCj4+
Pj4+PiAJLyogdGhlIGtleSB0eXBlIGFuZCBrZXkgZGVzY3JpcHRpb24gc3RyaW5nDQo+Pj4+Pj4g
CSAqIC0gdGhlIGRlc2MgaXMgdXNlZCB0byBtYXRjaCBhIGtleSBhZ2FpbnN0IHNlYXJjaCBjcml0
ZXJpYQ0KPj4+Pj4+IEBAIC0yOTAsNiArMjkxLDcgQEAgZXh0ZXJuIHN0cnVjdCBrZXkgKmtleV9h
bGxvYyhzdHJ1Y3Qga2V5X3R5cGUgKnR5cGUsDQo+Pj4+Pj4gI2RlZmluZSBLRVlfQUxMT0NfQllQ
QVNTX1JFU1RSSUNUSU9OCTB4MDAwOAkvKiBPdmVycmlkZSB0aGUgY2hlY2sgb24gcmVzdHJpY3Rl
ZCBrZXlyaW5ncyAqLw0KPj4+Pj4+ICNkZWZpbmUgS0VZX0FMTE9DX1VJRF9LRVlSSU5HCQkweDAw
MTAJLyogYWxsb2NhdGluZyBhIHVzZXIgb3IgdXNlciBzZXNzaW9uIGtleXJpbmcgKi8NCj4+Pj4+
PiAjZGVmaW5lIEtFWV9BTExPQ19TRVRfS0VFUAkJMHgwMDIwCS8qIFNldCB0aGUgS0VFUCBmbGFn
IG9uIHRoZSBrZXkva2V5cmluZyAqLw0KPj4+Pj4+ICsjZGVmaW5lIEtFWV9BTExPQ19CVUlMVF9J
Tl9ST1QJCTB4MDA0MCAgLyogQWRkIGJ1aWx0aW4gcm9vdCBvZiB0cnVzdCBrZXkgKi8NCj4+Pj4+
IA0KPj4+Pj4gU2luY2UgdGhlIGNvbmNlcHQgb2Ygcm9vdCBvZiB0cnVzdCBpcyBub3QgZ2VuZXJp
YywgYnV0IGxpbWl0ZWQgdG8NCj4+Pj4+IHNwZWNpZmljIGtleXJpbmdzLCB0aGUgcm9vdCBDQSBj
ZXJ0aWZpY2F0ZSBzaWduaW5nIGtleXMgb24gdGhlDQo+Pj4+PiAibWFjaGluZSIga2V5cmluZyBu
ZWVkIHRvIGJlIGlkZW50aWZpZWQuICBTaW1pbGFyIHRvIHRoZQ0KPj4+Pj4gS0VZX0FMTE9DX0JV
SUxUX0lOL0tFWV9GTEFHX0JVSUxUSU4sIG5ldyBmbGFncw0KPj4+Pj4gS0VZX0FMTE9DX01BQ0hJ
TkUvS0VZX0ZMQUdfTUFDSElORSBzaG91bGQgYmUgZGVmaW5lZCBpbnN0ZWFkLg0KPj4+PiANCj4+
Pj4gSeKAmW0gb3BlbiB0byByZW5hbWluZyB0aGVzZSwgaG93ZXZlciB0aGlzIG5hbWUgY2hhbmdl
IHNlZW1zIGNvbmZ1c2luZyB0byBtZS4gIA0KPj4+PiBUaGlzIGZsYWcgZ2V0cyBzZXQgd2hlbiB0
aGUgWC41MDkgY2VydGlmaWNhdGUgY29udGFpbnMgdGhlIHRocmVlIENBIHJlcXVpcmVtZW50cyAN
Cj4+Pj4gaWRlbnRpZmllZCBhYm92ZS4gIFRoZSByZW1haW5pbmcga2V5cyBpbiB0aGUgbWFjaGlu
ZSBrZXlyaW5nIGNhbiBiZSB1c2VkIGZvciANCj4+Pj4gYW55dGhpbmcgZWxzZS4NCj4+PiANCj4+
PiBSZW5hbWluZyB0aGUgZmxhZyB0byBLRVlfQUxMT0NfTUFDSElORS9LRVlfRkxBR19NQUNISU5F
IGRpZmZlcmVudGlhdGVzDQo+Pj4gYmV0d2VlbiB0aGUgImJ1aWx0aW4iIGtleXMgZnJvbSB0aGUg
Im1hY2hpbmUiIGtleXMuICBUaGUgdHJ1c3QgbW9kZWxzDQo+Pj4gYXJlIHZlcnkgZGlmZmVyZW50
Lg0KPj4gDQo+PiBJc27igJl0IHRoZSB0cnVzdCBtb2RlbCB0aGUgc2FtZSBmb3IgbWFjaGluZSBh
bmQgc2Vjb25kYXJ5IGtleXM/ICBCb3RoIGFyZSBzdXBwbGllZCBieSANCj4+IHRoZSBlbmQtdXNl
ci4gVGhhdCBpcyB3aHkgSeKAmW0gY29uZnVzZWQgYnkgbmFtaW5nIHNvbWV0aGluZyBfTUFDSElO
RSB3aGVuIGl0IGFwcGxpZXMgDQo+PiB0byBtb3JlIHRoYW4gb25lIGtleXJpbmcuDQo+IA0KPiBU
cnVlIGJvdGggYXJlIHN1cHBsaWVkIGJ5IHRoZSBlbmQtdXNlciwgYnV0IHRoZSB0cnVzdCBtb2Rl
bHMgYXJlDQo+IGRpZmZlcmVudC4NCg0KSSB0aGluayBJIG5lZWQgbW9yZSBpbmZvcm1hdGlvbiBo
ZXJlLCBJ4oCZbSBub3Qgc2VlaW5nIGhvdyB0aGV5IGFyZSBkaWZmZXJlbnQgdHJ1c3QgDQptb2Rl
bHMuDQoNCj4gIEluIG9uZSBjYXNlIHRoZSBjZXJ0aWZpY2F0ZXMgYXJlIGNvbWluZyBpbmRpcmVj
dGx5IGZyb20NCj4gZmlybXdhcmUsDQoNCkFueSBrZXJuZWwgc2lnbmVkIGJ5IGEgY2VydCBpbiB0
aGUgTW9rTGlzdCB3aWxsIGJvb3QuICBUaGUgdmVyeSB0aGluZyB0aGUgbWFjaGluZSANCmtleXJp
bmcgY29udGFpbnMuDQoNCkZvciBleGFtcGxlLCBpZiBhIHVzZXIgaGFzIGEgY2VydCAoQ0EgYml0
IHNldCBmYWxzZSwga2V5Q2VydFNpZ24gbm90IHNldCwgYW5kIGl0IGlzbuKAmXQgDQpzZWxmIHNp
Z25lZCksIHRoZXkgY2FuIHVzZSBpbnNlcnQtc3lzLWNlcnQgdG8gZ2V0IGl0IGludG8gdGhlaXIg
a2VybmVsLiAgVGhleSBjYW4gdGhlbiANCnNpZ24gdGhlIGtlcm5lbCB3aXRoIGFueSBrZXkgaW4g
dGhlaXIgTW9rTGlzdC4gIFdoeSB3b3VsZCB3ZSB3YW50IHRvIHRyZWF0IHRoaXMga2V5IA0KZGlm
ZmVyZW50IGlmIGl0IHdhcyBpbmplY3RlZCBpbnRvIHRoZSBrZXJuZWwgdmVyc2VzIGNvbWluZyBp
biB0aHJvdWdoIHRoZSBtYWNoaW5lIA0Ka2V5cmluZz8gDQoNCkkgY2FuIHNlZSB0aGUgZGVzaXJl
IHRvIGhhdmUgYSByb290IG9mIHRydXN0IGFsbCB0aGUgd2F5IGJhY2sgdG8gdGhlIHJvb3QgQ0Eu
ICBXaGF0IA0KSSBjYW7igJl0IHNlZSBpcyBpZiB3ZSBpZ25vcmUgdGhpcyBmb3IgY2VydGFpbiBr
ZXlyaW5ncy4NCg0KPiB3aGlsZSBpbiB0aGUgb3RoZXIgY2FzZSB0aGUgY2VydGlmaWNhdGVzIHdv
dWxkIGJlIGxpbWl0ZWQgdG8NCj4gY2VydGlmaWNhdGVzIHNpZ25lZCBieSB0aGUgaW5pdGlhbCBm
aXJtd2FyZSBjZXJ0aWZpY2F0ZXMuICBMb2FkaW5nIG9ubHkNCj4gcm9vdC1DQSBzaWduaW5nIGtl
eSBjZXJ0aWZpY2F0ZXMgb250byB0aGUgIm1hY2hpbmUiIGtleXJpbmcgaGlnaGxpZ2h0cw0KPiBh
bmQgZW5mb3JjZXMgdGhlIGRpZmZlcmVudCB0eXBlcyBvZiB0cnVzdC4NCg0KSWYgdGhlIHJvb3Qt
Q0EgY2VydCBtdXN0IGNvbnRhaW4ga2V5Q2VydFNpZ24sIEkgZG9u4oCZdCBzZWUgdGhlIHBvaW50
IGluIGxvYWRpbmcgb25seSANCnJvb3QtQ0EgY2VydHMgZWl0aGVyLiBXaHkgd291bGQgd2Ugd2Fu
dCB0byBwcmV2ZW50ICBhIGNvZGUgc2lnbmluZyBjZXJ0IHdpdGggdGhlIA0KQ0EgYml0IHNldCBm
cm9tIGxvYWRpbmcgaW50byB0aGUgbWFjaGluZSBrZXlyaW5nPyAgQSBjb2RlIHNpZ25pbmcgY2Vy
dCBzaG91bGQgYmUgDQphbGxvd2VkIHRvIHZhbGlkYXRlIGEga2VybmVsIG1vZHVsZSwgYnV0IEl0
IHNob3VsZCBub3QgYmUgYWxsb3dlZCB0byB2YWxpZGF0ZSBvdGhlcg0KY2VydHMuDQoNCg==
