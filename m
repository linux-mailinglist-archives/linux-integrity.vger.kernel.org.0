Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CCD84F9BCE
	for <lists+linux-integrity@lfdr.de>; Fri,  8 Apr 2022 19:35:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238217AbiDHRhb (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 8 Apr 2022 13:37:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233784AbiDHRh3 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 8 Apr 2022 13:37:29 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAD7CDA6E1;
        Fri,  8 Apr 2022 10:35:21 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 238Ev4eo000752;
        Fri, 8 Apr 2022 17:34:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=5vFIRECd8IcN7nckxj5zFMXLyU7OknWcLSgI7Pbe+OA=;
 b=TvPnxUanfYNftB9V9rEe/HWtBGcQi3u5Y8SSjAwZlqz0cVzxwEWWx0+UcVKt3ZD6yF8H
 fNH1GR3BdatDHp4RiikUSBeuSbRVv1sjkh564tQhwzEzeGxRX8q86gx6f+9gy2LGr+PL
 5WcQhs7BmnHI2Ko7rYx+byW5qOfwqvqFE949TJJdxFfZ9ebpohCvSeIrMC4dvzMh+7Ys
 r4AiXs2BYmBIN/4MZLYNrD+mqr/dGY82Dl3nRqRQHfwxDFr8oNxPHodRXOVl/PWWEBA/
 N0h2uut5Fo3NI/aGjD9iaoBBYjLqcML84oy7XO+wSDBQ6HGcX/6mIYmTlOHvgGYrCqkO 4A== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com with ESMTP id 3f6e3syqm8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 08 Apr 2022 17:34:52 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 238HVxET032726;
        Fri, 8 Apr 2022 17:34:51 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2177.outbound.protection.outlook.com [104.47.58.177])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3f97tuvk4f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 08 Apr 2022 17:34:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jCWQ+El1qWTzVkI6/3Ff3sM+2DSd7Qym0VBerq9qp6yxxzl+vkn7NESWDHZEIoxy290hYLJkvwwu7pKIAmzroFW0VFwTHkGgA7DPGPn5FBwMYfoArHvrvjTas+QCEqbS0Q5SijgW01eDm0XIwQuQ27qRLbi1eBxHBsTfveQGC9jDSOCRzi2oJ2LbM1ntdaF7X8PMYODIbG0ln+X1KIlF/vrYRmmpwUejy8HmRd6GIar8hTp5+qU7SWHspHJrGpVHmPsBhSF1qyWX1fAoe/4BCB/P8cr7qjlb6Dyx1P12IS9wztT0LB3VSWMN3Sd6/lXnJjUL2iTth6saHEv8c/FVJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5vFIRECd8IcN7nckxj5zFMXLyU7OknWcLSgI7Pbe+OA=;
 b=PVHrO+rkZEE62DCp7xjeNm2KCjEx/n3a/2zy+RFf0zhfAabadjEcw+TSD/W7BKTwyPLYQyvG5ppl4PL6vK6REyeM9E7XitLv6CkyYN3FVoNPTs7iysy9ZJuixLXiyACgp6mTPHFOCYba2Ea4F2k9BtbZe8hBlnO0j483okC77bHsNfAWGA8rfiDkgcFrI18BWXPR4P5RQtRES/8Yvf0736PZxO3DiBE+wMcn9W0VLJgUB9WdWj3+Ka9gNFskkI2CIuBLou4SbtL8EUlNoTzkMBKQBPazQ+sP62cClMFJk9PbZwn4UTjQPWLKOXv/IPZPkZryX7AQpgr6VIVazIK9NQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5vFIRECd8IcN7nckxj5zFMXLyU7OknWcLSgI7Pbe+OA=;
 b=y7/kw0AOVvQw/IP8K/ECwhBIQCYxeAmKTMNpGrix1mEMP7smsPW8tH9WicF3DVA3NIXhS4mljm9Pl0CvTW5YDyMRZ02YvUID4u+NKGt/0rEKOL/HOkKPcMw/zIHLVPcNjgR+wXcTDTPTXxnaq5d9GqewlYhEtV29voGpyH118zg=
Received: from CH2PR10MB4150.namprd10.prod.outlook.com (2603:10b6:610:ac::13)
 by BL0PR10MB2865.namprd10.prod.outlook.com (2603:10b6:208:72::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.26; Fri, 8 Apr
 2022 17:34:48 +0000
Received: from CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::7ded:5b3:a28f:2e55]) by CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::7ded:5b3:a28f:2e55%7]) with mapi id 15.20.5144.022; Fri, 8 Apr 2022
 17:34:48 +0000
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
Thread-Index: AQHYSVkvRBwH8IpE9UCisTSasA/N5azmGp0AgAANAACAABh+AIAACxSA
Date:   Fri, 8 Apr 2022 17:34:48 +0000
Message-ID: <16DDA7F1-95BA-4279-BE4E-9F713A905B36@oracle.com>
References: <20220406015337.4000739-1-eric.snowberg@oracle.com>
 <20220406015337.4000739-5-eric.snowberg@oracle.com>
 <4fbef0889d6f286c7fcd317db099b4857e1b2fa3.camel@linux.ibm.com>
 <EF1544D5-54E8-4D47-82F8-F9337CA7AEA0@oracle.com>
 <b8965652274b49ba7c6f67cad6d42965cf984b42.camel@linux.ibm.com>
In-Reply-To: <b8965652274b49ba7c6f67cad6d42965cf984b42.camel@linux.ibm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3608.120.23.2.7)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2eeec3ce-308a-4caa-af2b-08da1986149d
x-ms-traffictypediagnostic: BL0PR10MB2865:EE_
x-microsoft-antispam-prvs: <BL0PR10MB2865204FBC2F5C326F35FF1587E99@BL0PR10MB2865.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PbXN6PoJbUWpdgEK/I/8RbjAwGVW/FSpA/LiTnfZJ8biZISuP/6vOodOYzlJ+V977n42ejQSf6/MLzX1r+ea6Jz6XZszkLICBI883kFpSg04FE7jKuMA+AIdzlxyf396R049Ks99RZZ46tUgMajfUHHCAISfiHh93Sy7lG1/00rXy/rRQRMzJZjDs0GbWK4y96o2ftMRseXbCyfgBO+NohUfQ+PuZ9QN1mGbpMvK18x3irD+82ms53zp7PdXjO8TwsVZGU6MEsqDv33OLsv8HOIG+coJfvNrXr2peQ7B/5Mn7ivcATyZDCWZBm/S/C1zIf31YjhLiUxj8HEaZcL/X1/U+1fV5h1Iy31qGJBhkVeCta69NVZeTSZtKK1lrmj2chQs/ky2KmepQKUpkdAHV9VVkYZQgARnm6acbkhcBZK7bJzA8N2Nn/olkethSE9v6mcT20x4hrTAtFtI7OJiCqGAHeVtn6MsHZDeQls31tr3Lq3hsKmnoPn6TmvuvLm8vp0IzEbHzlsAWw0hiKBQJUAXL0/YLtxQ1HuWsYMFUzPZqh7RGWblJ8iyPjndQnCXFW5dyUSNvDQQICp272zeLOT0WH2/Uh4m2aK1rmwsTCnJfwX3YA0FG8WFfENngYQrkM9Fg+Fg4CUp8MM38KS4rg+8eB5h41BrPdBNgsp/FdSePdh8sylTqEAuneobvCdOZC3qzOme6Xi8fA6LwgBrnTtyltZvSj3N2b/6UC0SjFQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4150.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(33656002)(2616005)(7416002)(86362001)(8936002)(2906002)(54906003)(36756003)(6916009)(316002)(26005)(186003)(6512007)(71200400001)(66946007)(66476007)(66556008)(66446008)(122000001)(4326008)(8676002)(76116006)(91956017)(64756008)(508600001)(83380400001)(44832011)(53546011)(38100700002)(6506007)(5660300002)(6486002)(38070700005)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cTg0bkpSd3VDSHAxWHZHMjZQTHFhUW5HS2RTNmpCUkp5ZC9xV2pXaWg1N213?=
 =?utf-8?B?SEV4UStBYmlhNVFzWXIvTWMvSGQrTE5lN1NTK1hFUHc0WkV6U0hqaStEdzM3?=
 =?utf-8?B?Yk5kYmhBUDJDSXJnN0hnQUNoWU5PaGlQeDNWak5oeWwrU1BFY3dLclYrYmhu?=
 =?utf-8?B?R2tMcnZpYisxK0FuM3dnUkFCT1R5TXlKdExQMmRndTRDdFR4V0tvQkZFWmNQ?=
 =?utf-8?B?SmJoSHVvdGY0dTNQQ1dVeTJrVW1RMm5YZUc4NDE1bnRVeVJpWG5ab2tocGtv?=
 =?utf-8?B?SDQvOW15N1VCOUY1T0VBcklvVlpuZ1VrWHIxTWNmbWFtd3lYZXg2akwvVURw?=
 =?utf-8?B?MEVCYzRnOTBacVo4RThtYnRuU0Z1c2oyY3FUWDE5RnZVYVhjeElkSzNGbHlF?=
 =?utf-8?B?MmV6TTZUcTl1OXd0aEZ3T3hzc05OSmVvWE4wSjAwaUJ1eG9JUjJTYjlWZXhi?=
 =?utf-8?B?YytKUkJLRjdzL3VSTFVDT290cGMzaEpqdkV5VkhWVzBUQmN4a0xBOXdpYUFU?=
 =?utf-8?B?bmpRNmpGUjJBQU9XL1BNemd2MHdrQ3pIcjZSQjNTYjZLRVVMQXZqeWt5TTU5?=
 =?utf-8?B?aEx1VytWZ0tkZlRlNWVrSHhsVmZKbGp4UkE5L2N6TVVXTGtCb0Rlb0FDN21N?=
 =?utf-8?B?aGFKN2hJYlJYSFZBMFJhUmtnZ3h3OFg4ZzFKVktvZUNUaWRZY2R3U01JcUJO?=
 =?utf-8?B?QktPOFl3S1lIQkZWclo0OUk0M1M2eFJXeHpDTUFML3BsdDJqVFpXQ0lkelNk?=
 =?utf-8?B?b25ScTluSmc1eGhFeC9ZdUJRSU1CcUEzd0xvV0l2enNtQ3JtelFlVWR2QWpw?=
 =?utf-8?B?OGdPZmorU20zd0VDTUFFUmZ6R2Q1Q08zVmFpanc4eDZ2T1dPTnNvSFE2MUJ6?=
 =?utf-8?B?eXo0aXpYUC9ST2dWOXZSeVBQTllmSXdpOC9NWGx5ZDVKN2F2aE5YM21VMFRY?=
 =?utf-8?B?YmVFSUZCbWgrTkU3TG9OY2xUYm9URUt1RXNQZ3dMV1VZVng2YjE3dFNMeDFP?=
 =?utf-8?B?blBuZUtnWExGb2x5UUVyN2I3UXN6VFJ1MktmdFN4MXdLQnd6cUJEbGhFek5G?=
 =?utf-8?B?VWVFTzBFZTByUnFWRUhCT2JhSTM0eElVWll3VmtpTVErYm1WU28zUkpPb09X?=
 =?utf-8?B?MVliWDNGN2ZJdTdBd3ZYOForNVRwYmY2WWsra0Q3RnYzelFtTm00aEw5Y1J0?=
 =?utf-8?B?UDFOclJmd0ZHTXZSTitNSDRSNU5KdENaV1NCbHBQMzQ0cU1NTE1xY1JuMU9p?=
 =?utf-8?B?T0ExZjI4YjQ2TzVSNzYvL1I4YkJLSmRZOGVBc21xd2NoTmY0YjJQUk5jbk0y?=
 =?utf-8?B?cDJkWUpFaURqNGoveWFTYXNWM0dmZUdWSkdZNWpWVDlVS0wxVlVYL1BrME1R?=
 =?utf-8?B?aHdBbURJN3BCd3YzNE9CMGNjbEp5VFFPNDNtdzZreVZzV2trY1RYSllia05v?=
 =?utf-8?B?eHIvUXlmLzBOVEdpZzVWcXFBOVZERGNPY0ZPRDgxUTM2eGRrMnZJOVJmNHFv?=
 =?utf-8?B?dU5uekJnVXhNcytJMXliaEE2Qk1aWTNwV2p3RVBKbXIvTk93dnVkdXZDZVJ6?=
 =?utf-8?B?dHpPVlFZYU1OZDkzZ0crbHJaSWpFVERrLzlNV1VaT0xrZmY4cUJvcjVmdnBQ?=
 =?utf-8?B?cmhnbGlUaGt2dDNSYVI3MXY5OVQwOUJxai82Q0FCR2pEUTNrd2xzNzFiMWha?=
 =?utf-8?B?TG1oZVJvb0FheG9keVczaDBDY3VLV09yRHFHTVBHMWNuK1lZSGwzU2VtL1NQ?=
 =?utf-8?B?Y3ltbndvZExvNkNEcGhZZmJOcTVNNkMzV1dFYzlmbXBkY0h0T0MzNHUrc1Ux?=
 =?utf-8?B?V29vT1V5aTRwTXVpSTZpbVZUcmoxZzd3YTFjVlhQZGloVWNDNHg0T2h0WmFG?=
 =?utf-8?B?YXNDaVVwazFWbzFEV3FBbjZKeWhmYUZGQzhCQm1iOEhqZ3Znc2hsOG4vak9h?=
 =?utf-8?B?Q25yN1AzYlBtTTJmS1EvVTdUalF6T01PcEE5V1RHQ0dJeFNoUWE3SCtQMHd2?=
 =?utf-8?B?V1FGOWFxU21uK1BXVm8xVDBnbUNNZXNXODMya1ltelc3OVlwZ3VERi9NWFBl?=
 =?utf-8?B?U29RV0N4a290elRyVWp1bktrTllTZEg4aUdOL3pUaGh3QnVkWHJvbkVQL2ky?=
 =?utf-8?B?QSsrSStnTFNmYjRiY0xqYko3SHdXc1htdHpvTlZzK0JiaGI0OUVUOGVpVUVs?=
 =?utf-8?B?djVpM3l3b0JtSkdCUnVNTmkweWk2RTIzSkNiaWw4RzBDNm9udnhkNVhobUtW?=
 =?utf-8?B?MW5ZanNISWs1cElEdGxRUTZGRFU5d0hxdEo4a2hvc2N4RnhvMkpJbXRjQ1Jo?=
 =?utf-8?B?MjVQUGhqa2F1RlFvaG1DcDdjeVYrVEFsUk9xb3FGNzgxR29ZTm5ya0ZkVUtm?=
 =?utf-8?Q?LTIkIRfME3pVmGgY=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2C36C7CAC6598E489377582D3830EEBA@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4150.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2eeec3ce-308a-4caa-af2b-08da1986149d
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Apr 2022 17:34:48.7442
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KWppwZlZV0phYshZ6ITMMW2vOE+1XTBy4Ti2XdG47LL085aCoqUIGy+ZPrRczz3iLcdPHs6S0Xy5GEkJSck4ahtEkE5iM+/wVdWJKeX4KKg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR10MB2865
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.425,18.0.858
 definitions=2022-04-08_05:2022-04-08,2022-04-08 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 mlxscore=0 suspectscore=0 bulkscore=0 adultscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204080089
X-Proofpoint-ORIG-GUID: KfuQVvqFJ5Bv5CdPFKv3J7LLwckO1Aka
X-Proofpoint-GUID: KfuQVvqFJ5Bv5CdPFKv3J7LLwckO1Aka
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

DQoNCj4gT24gQXByIDgsIDIwMjIsIGF0IDEwOjU1IEFNLCBNaW1pIFpvaGFyIDx6b2hhckBsaW51
eC5pYm0uY29tPiB3cm90ZToNCj4gDQo+IE9uIEZyaSwgMjAyMi0wNC0wOCBhdCAxNToyNyArMDAw
MCwgRXJpYyBTbm93YmVyZyB3cm90ZToNCj4+IA0KPj4+IE9uIEFwciA4LCAyMDIyLCBhdCA4OjQw
IEFNLCBNaW1pIFpvaGFyIDx6b2hhckBsaW51eC5pYm0uY29tPiB3cm90ZToNCj4+PiANCj4+PiBP
biBUdWUsIDIwMjItMDQtMDUgYXQgMjE6NTMgLTA0MDAsIEVyaWMgU25vd2Jlcmcgd3JvdGU6DQo+
Pj4+IA0KPj4+PiBUaGUgZmlyc3QgdHlwZSBvZiBrZXkgdG8gdXNlIHRoaXMgaXMgWC41MDkuICBX
aGVuIGEgWC41MDkgY2VydGlmaWNhdGUNCj4+Pj4gaXMgc2VsZiBzaWduZWQsIGhhcyB0aGUga2Vy
bkNlcnRTaWduIEtleSBVc2FnZSBzZXQgYW5kIGNvbnRhaW5zIHRoZQ0KPj4+PiBDQSBiaXQgc2V0
IHRoaXMgbmV3IGZsYWcgaXMgc2V0Lg0KPj4+PiANCj4+Pj4gU2lnbmVkLW9mZi1ieTogRXJpYyBT
bm93YmVyZyA8ZXJpYy5zbm93YmVyZ0BvcmFjbGUuY29tPg0KPj4+PiANCj4+Pj4gZGlmZiAtLWdp
dCBhL2luY2x1ZGUvbGludXgva2V5LmggYi9pbmNsdWRlL2xpbnV4L2tleS5oDQo+Pj4+IGluZGV4
IDdmZWJjNDg4MTM2My4uOTdmNmExZjg2YTI3IDEwMDY0NA0KPj4+PiAtLS0gYS9pbmNsdWRlL2xp
bnV4L2tleS5oDQo+Pj4+ICsrKyBiL2luY2x1ZGUvbGludXgva2V5LmgNCj4+Pj4gQEAgLTIzMCw2
ICsyMzAsNyBAQCBzdHJ1Y3Qga2V5IHsNCj4+Pj4gI2RlZmluZSBLRVlfRkxBR19ST09UX0NBTl9J
TlZBTAk3CS8qIHNldCBpZiBrZXkgY2FuIGJlIGludmFsaWRhdGVkIGJ5IHJvb3Qgd2l0aG91dCBw
ZXJtaXNzaW9uICovDQo+Pj4+ICNkZWZpbmUgS0VZX0ZMQUdfS0VFUAkJOAkvKiBzZXQgaWYga2V5
IHNob3VsZCBub3QgYmUgcmVtb3ZlZCAqLw0KPj4+PiAjZGVmaW5lIEtFWV9GTEFHX1VJRF9LRVlS
SU5HCTkJLyogc2V0IGlmIGtleSBpcyBhIHVzZXIgb3IgdXNlciBzZXNzaW9uIGtleXJpbmcgKi8N
Cj4+Pj4gKyNkZWZpbmUgS0VZX0ZMQUdfQlVJTFRJTl9ST1QJMTAJLyogc2V0IGlmIGtleSBpcyBh
IGJ1aWx0aW4gUm9vdCBvZiBUcnVzdCBrZXkgKi8NCj4+Pj4gDQo+Pj4+IAkvKiB0aGUga2V5IHR5
cGUgYW5kIGtleSBkZXNjcmlwdGlvbiBzdHJpbmcNCj4+Pj4gCSAqIC0gdGhlIGRlc2MgaXMgdXNl
ZCB0byBtYXRjaCBhIGtleSBhZ2FpbnN0IHNlYXJjaCBjcml0ZXJpYQ0KPj4+PiBAQCAtMjkwLDYg
KzI5MSw3IEBAIGV4dGVybiBzdHJ1Y3Qga2V5ICprZXlfYWxsb2Moc3RydWN0IGtleV90eXBlICp0
eXBlLA0KPj4+PiAjZGVmaW5lIEtFWV9BTExPQ19CWVBBU1NfUkVTVFJJQ1RJT04JMHgwMDA4CS8q
IE92ZXJyaWRlIHRoZSBjaGVjayBvbiByZXN0cmljdGVkIGtleXJpbmdzICovDQo+Pj4+ICNkZWZp
bmUgS0VZX0FMTE9DX1VJRF9LRVlSSU5HCQkweDAwMTAJLyogYWxsb2NhdGluZyBhIHVzZXIgb3Ig
dXNlciBzZXNzaW9uIGtleXJpbmcgKi8NCj4+Pj4gI2RlZmluZSBLRVlfQUxMT0NfU0VUX0tFRVAJ
CTB4MDAyMAkvKiBTZXQgdGhlIEtFRVAgZmxhZyBvbiB0aGUga2V5L2tleXJpbmcgKi8NCj4+Pj4g
KyNkZWZpbmUgS0VZX0FMTE9DX0JVSUxUX0lOX1JPVAkJMHgwMDQwICAvKiBBZGQgYnVpbHRpbiBy
b290IG9mIHRydXN0IGtleSAqLw0KPj4+IA0KPj4+IFNpbmNlIHRoZSBjb25jZXB0IG9mIHJvb3Qg
b2YgdHJ1c3QgaXMgbm90IGdlbmVyaWMsIGJ1dCBsaW1pdGVkIHRvDQo+Pj4gc3BlY2lmaWMga2V5
cmluZ3MsIHRoZSByb290IENBIGNlcnRpZmljYXRlIHNpZ25pbmcga2V5cyBvbiB0aGUNCj4+PiAi
bWFjaGluZSIga2V5cmluZyBuZWVkIHRvIGJlIGlkZW50aWZpZWQuICBTaW1pbGFyIHRvIHRoZQ0K
Pj4+IEtFWV9BTExPQ19CVUlMVF9JTi9LRVlfRkxBR19CVUlMVElOLCBuZXcgZmxhZ3MNCj4+PiBL
RVlfQUxMT0NfTUFDSElORS9LRVlfRkxBR19NQUNISU5FIHNob3VsZCBiZSBkZWZpbmVkIGluc3Rl
YWQuDQo+PiANCj4+IEnigJltIG9wZW4gdG8gcmVuYW1pbmcgdGhlc2UsIGhvd2V2ZXIgdGhpcyBu
YW1lIGNoYW5nZSBzZWVtcyBjb25mdXNpbmcgdG8gbWUuICANCj4+IFRoaXMgZmxhZyBnZXRzIHNl
dCB3aGVuIHRoZSBYLjUwOSBjZXJ0aWZpY2F0ZSBjb250YWlucyB0aGUgdGhyZWUgQ0EgcmVxdWly
ZW1lbnRzIA0KPj4gaWRlbnRpZmllZCBhYm92ZS4gIFRoZSByZW1haW5pbmcga2V5cyBpbiB0aGUg
bWFjaGluZSBrZXlyaW5nIGNhbiBiZSB1c2VkIGZvciANCj4+IGFueXRoaW5nIGVsc2UuDQo+IA0K
PiBSZW5hbWluZyB0aGUgZmxhZyB0byBLRVlfQUxMT0NfTUFDSElORS9LRVlfRkxBR19NQUNISU5F
IGRpZmZlcmVudGlhdGVzDQo+IGJldHdlZW4gdGhlICJidWlsdGluIiBrZXlzIGZyb20gdGhlICJt
YWNoaW5lIiBrZXlzLiAgVGhlIHRydXN0IG1vZGVscw0KPiBhcmUgdmVyeSBkaWZmZXJlbnQuDQoN
CklzbuKAmXQgdGhlIHRydXN0IG1vZGVsIHRoZSBzYW1lIGZvciBtYWNoaW5lIGFuZCBzZWNvbmRh
cnkga2V5cz8gIEJvdGggYXJlIHN1cHBsaWVkIGJ5IA0KdGhlIGVuZC11c2VyLiBUaGF0IGlzIHdo
eSBJ4oCZbSBjb25mdXNlZCBieSBuYW1pbmcgc29tZXRoaW5nIF9NQUNISU5FIHdoZW4gaXQgYXBw
bGllcyANCnRvIG1vcmUgdGhhbiBvbmUga2V5cmluZy4NCg0KPj4gUGx1cyB0aGlzIGZsYWcgY2Fu
IGJlIHNldCBmb3Iga2V5cyBsb2FkZWQgaW50byB0aGUgc2Vjb25kYXJ5IHRydXN0ZWQgDQo+PiBr
ZXlyaW5nICg2dGggcGF0Y2ggaW4gdGhlIHNlcmllcykuICBXaGVuIGFuIGludGVybWVkaWF0ZSBD
QSBnZXRzIGxvYWRlZCBpbnRvIHRoZSANCj4+IHNlY29uZGFyeSwgdGhlIGZsYWcgaXMgc2V0IGFz
IHdlbGwuDQo+IA0KPiBQbGVhc2UgaW5jbHVkZSBhIGZ1bGwgZXhwbGFuYXRpb24gd2l0aCB0aGUg
bW90aXZhdGlvbiBpbiB0aGUgcGF0Y2gNCj4gZGVzY3JpcHRpb24gYXMgdG8gd2h5IHN1cHBvcnQg
Zm9yIGludGVybWVkaWFyeSBDQXMgaXMgcmVxdWlyZWQgZm9yIHRoZQ0KPiAiZW5kLXVzZXIiIHVz
ZSBjYXNlLg0KDQpPaywgSSBjYW4gYWRkIGl0LiAgSSB0aG91Z2h0IHRoaXMgd2FzIGFuIGV4cGVj
dGF0aW9uLCBiYXNlZCBvbiB0aGUgaGVscCBzZWN0aW9uIG9mDQpJTUFfS0VZUklOR1NfUEVSTUlU
X1NJR05FRF9CWV9CVUlMVElOX09SX1NFQ09OREFSWToNCg0KIiBJbnRlcm1lZGlhdGUga2V5cyBi
ZXR3ZWVuIHRob3NlIHRoZSBrZXJuZWwgaGFzIGNvbXBpbGVkIGluIGFuZCB0aGUgDQogSU1BIGtl
eXMgdG8gYmUgYWRkZWQgbWF5IGJlIGFkZGVkIHRvIHRoZSBzeXN0ZW0gc2Vjb25kYXJ5IGtleXJp
bmcsDQogcHJvdmlkZWQgdGhleSBhcmUgdmFsaWRseSBzaWduZWQgYnkgYSBrZXkgYWxyZWFkeSBy
ZXNpZGVudCBpbiB0aGUNCiBidWlsdC1pbiBvciBzZWNvbmRhcnkgdHJ1c3RlZCBrZXlyaW5ncy4i
DQoNCg==
