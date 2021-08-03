Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F5FC3DF606
	for <lists+linux-integrity@lfdr.de>; Tue,  3 Aug 2021 21:54:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240366AbhHCTya (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 3 Aug 2021 15:54:30 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:6246 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240365AbhHCTy3 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 3 Aug 2021 15:54:29 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 173JVWs2000503;
        Tue, 3 Aug 2021 19:53:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 subject : from : in-reply-to : date : cc : content-transfer-encoding :
 message-id : references : to : mime-version; s=corp-2021-07-09;
 bh=nZwd3feBAN//hpHMlP7FCkE2T/dYuKQSqSBBO6Yb3FE=;
 b=zjqV+BV1eTbaNWGnumWybjIki107N8zPyIEAuwZdF0Jn/l/xf8WmszV8Dk/Z3M/BjTlB
 KrqsQC3H8IgOeZEmCasZ53Vhiqsglslh4P6LRy0NntvfyVIiTl9KnWjfDLQEYrvMk3LC
 VGkkhJuXisseGq2GCGZgZELj3dHhAqwOxv2V4S/fZwsV5Z9PK6zlLlG/fGYaZmetFXZP
 88ZPDDD7M6iAD7ol4DwXGzKYr/jfh9TFLF7vNxE6MegytVt0jm4BeWMTUD16sVFx0CIL
 BYiMXXktz9s6N0HLN/qy1DJI9YgaNhj/BlQjalj0S+lIq0EwvLyZjTI2hNA0W11l3snF XQ== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 subject : from : in-reply-to : date : cc : content-transfer-encoding :
 message-id : references : to : mime-version; s=corp-2020-01-29;
 bh=nZwd3feBAN//hpHMlP7FCkE2T/dYuKQSqSBBO6Yb3FE=;
 b=icrmbsJPKIKUS1tghMJ41qoHW9gCQsHur3psjyhjXSPrhJKmk9NNdAa3UUE8HYcT4VEZ
 SqwOZqbj178JhKm+835nu2WJw6J1Km5Q55xY3o3spx8K6BTayG70HlIDDTQ0fdsEDfiV
 As+IFjYqjt5DwVCk+YTXSDCoR+qtp7eUi86u/jqKd7DCH06aeQPnLlis2e25PzBkXOhj
 wiePHRzsaIqCl+m8L6i9e2WLZjlIjpxfRdF+MzmoH1mEKuIYoA9ht033sxL0vFKFpIeb
 zAeck35mdNRIC8E6RmKyu0noFI5VbI9MkEq5CwPea3UUBICtG2S/kEjc/Z3WH4dTNcc6 kw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3a6cntmm3f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 03 Aug 2021 19:53:00 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 173JTtJt040789;
        Tue, 3 Aug 2021 19:52:59 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2173.outbound.protection.outlook.com [104.47.55.173])
        by aserp3020.oracle.com with ESMTP id 3a4xb79uhs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 03 Aug 2021 19:52:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KSq6vhOQmDsVcGxfsSh2btg8Rr+hX5tNgi0YepU56TtliwFD0tQsCB+t///c7YIPTux8QLv7Gkar8Wx4Xqaz3jOniVxbENCX03lIIbRGNuE6FdxrLmumXfbevpr8hdIVjWfQHvdY1f6Dibf/m1mnT2JQkqfFVoziJV9krcZ59MrRNgmJsoblH8xVFdM3/spm1KyKObTZYg8luWcnG/4jfpNNKzm7DV0k9Js+WARXa4Y1AOLITAFtGcy3WQaZfg71x4tgAnQxMXIuC0Ccdw/nDR3PFgl05k/ACNk5EdEWWS6M7hoarmn4BJmO4KqrSMEzD2BI8FMd6NyMxnzED6iVGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nZwd3feBAN//hpHMlP7FCkE2T/dYuKQSqSBBO6Yb3FE=;
 b=TWsBOOKE94RAs5VU2rZojIZXPbdnr5kw3RF6qFEPXr3nSC+mUgKk9sQeecwVjtABmG28dCZHIQ9HV4w/XA7RtzNF7J4BCHtuY9LRJBUbsO4waapEHbiCftzFWBIonMuYYRIVxSsgweoJjZl4HGOvcF9S3gPQBKFfcTrY/XHEkXVMHP5wNFokIiFNdXT+BF5uxws7uEEOv4pd3CbqH/5htJruTwBdAWBCataHU/hTxmzBOFwSZcI/RleCZf0zVKUHp3h1IqFPT0QjvOfsJ2NDRJd3IBkmwdIsFc0EJ7VNbzDXIy+FAzozUtsG6isj9uEMZliesxJBmrWRMk7EOc3pzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nZwd3feBAN//hpHMlP7FCkE2T/dYuKQSqSBBO6Yb3FE=;
 b=HD7bJOOZUTlopCh5ksZHMjrtA4PoFKlLYe7VAc2iCs5eDAOWrF9aAmrl3Wh7Ky5T6YOHp6BLhJLh81H4lFCAlnZqZtlctpwM92XO/phZOU1JEzUHm15iWek8wggteIORHBJunAaY4VprFyQEUJGphIE0fziZ1Kxz1vhZ+lMcr3s=
Authentication-Results: linux.ibm.com; dkim=none (message not signed)
 header.d=none;linux.ibm.com; dmarc=none action=none header.from=oracle.com;
Received: from CH2PR10MB4150.namprd10.prod.outlook.com (2603:10b6:610:ac::13)
 by CH2PR10MB3877.namprd10.prod.outlook.com (2603:10b6:610:9::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.25; Tue, 3 Aug
 2021 19:52:57 +0000
Received: from CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::1d17:4a7d:92cc:8fc3]) by CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::1d17:4a7d:92cc:8fc3%7]) with mapi id 15.20.4373.026; Tue, 3 Aug 2021
 19:52:57 +0000
Content-Type: text/plain; charset=utf-8
Subject: Re: [PATCH RFC v2 00/12] Enroll kernel keys thru MOK
From:   Eric Snowberg <eric.snowberg@oracle.com>
In-Reply-To: <820cd72cd77c4716bff2bf344c64d7bcb59fc4d3.camel@linux.ibm.com>
Date:   Tue, 3 Aug 2021 13:52:49 -0600
Cc:     keyrings@vger.kernel.org, linux-integrity@vger.kernel.org,
        dhowells@redhat.com, dwmw2@infradead.org,
        herbert@gondor.apana.org.au, davem@davemloft.net,
        jarkko@kernel.org, jmorris@namei.org, serge@hallyn.com,
        keescook@chromium.org, gregkh@linuxfoundation.org,
        torvalds@linux-foundation.org, scott.branden@broadcom.com,
        weiyongjun1@huawei.com, nayna@linux.ibm.com, ebiggers@google.com,
        ardb@kernel.org, nramas@linux.microsoft.com, lszubowi@redhat.com,
        linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        James.Bottomley@HansenPartnership.com, pjones@redhat.com,
        glin@suse.com, "konrad.wilk@oracle.com" <konrad.wilk@oracle.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <2BBC3A71-6E0D-47A2-842A-11C279A5DC56@oracle.com>
References: <20210726171319.3133879-1-eric.snowberg@oracle.com>
 <820cd72cd77c4716bff2bf344c64d7bcb59fc4d3.camel@linux.ibm.com>
To:     Mimi Zohar <zohar@linux.ibm.com>
X-Mailer: Apple Mail (2.3273)
X-ClientProxiedBy: BYAPR07CA0053.namprd07.prod.outlook.com
 (2603:10b6:a03:60::30) To CH2PR10MB4150.namprd10.prod.outlook.com
 (2603:10b6:610:ac::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.16.177.128] (184.60.195.210) by BYAPR07CA0053.namprd07.prod.outlook.com (2603:10b6:a03:60::30) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.15 via Frontend Transport; Tue, 3 Aug 2021 19:52:53 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b67d1d85-9944-4090-67e9-08d956b849f7
X-MS-TrafficTypeDiagnostic: CH2PR10MB3877:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH2PR10MB387755E36F764E9591D848E687F09@CH2PR10MB3877.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LwUOB3rxmUWjBu38H+rt0f2lEPl9+0LorfYmlN53s2BrU/IYMtyCavs4IuX9VGPhEF2QBXXwtuQOvdq5r/1EpqmCxYAhEExrrSjajSNdh9IDz05LUECCwqjrbS0350i7Eu9Os6kSMJSDrr5DfNNtWJDgXGnQoprN+rAtHv4CmN5JFkdprdWXPkeCpiPiURrDwmXhrJmpC+xijX5CghQF/yJA46Yrch/Wdfkj1ktazDL1L2e6QmpSzg+0TNi1LX5Mby8nTpFKVs/F4lgvAwpDRdoNoQJ/9toAfQRD8NeMR3K0Gws9t1+Bv4Y1h48utcQnS+dOdQ13ZUdPtUkDrotTL4i35cx8GFAYCW0KNvELMttpuC03eduFCQwD7e2snpgawXVBDqwLJp7gnfV7FFZtGpjUUMyAxfAbfDke07MXWnt2odc6pAtwivDBE6f/+vAVRfs22oTsbWUiyL0B0p3toYWXNHC7uor6nOnrK1f1IGWnsi1OYckCziPf3AxulSZq0NNVLUeIPNa40GTUkltTv4Ou4oWdG4gSLYyOehxZSHwrY3wqt40VJvryC9JQrGH8LJMPNxH0yhkQrVot4z+mTKHnQv7OoVC2NZYLM5dzZUGdcZIJlwyVGutkrIrVcUUyZ+iovH/qaRjeWV9qqyYirScfRR06wLxHNhzOxqum1cLvdB+iVNFCaJM0XeioV0s2j+2kI8h1BRNJLJvEtckdmHPthQaKvi5+YMoKaDzlM14=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4150.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(136003)(346002)(366004)(396003)(39860400002)(107886003)(26005)(186003)(86362001)(478600001)(83380400001)(316002)(6666004)(4326008)(38350700002)(38100700002)(44832011)(52116002)(2906002)(66946007)(8676002)(66476007)(36756003)(8936002)(66556008)(6486002)(7416002)(33656002)(16576012)(5660300002)(6916009)(2616005)(53546011)(956004)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?em10M2VhcldBYU9YYWdISFJwYTJkaUVXaTNreGp1eG52ZmVDckxVUWFMSzBW?=
 =?utf-8?B?SDkzL3dMaHkrd2N0aWxXaHFjMCs4UnlDV1E1V2Y3T0FrK2IyWEtSV0h1RXNG?=
 =?utf-8?B?NWp4SzdVdzh6NzRxeUR5WllXWnBLSnpKNFFGbVRQcEl0NDNGMERJZlNUTjhm?=
 =?utf-8?B?QmNwckpKelR6bDNyMUptVkNzM0NCM3pxN2RONVJVeG8zZVNsT3M5Q1FaZHdR?=
 =?utf-8?B?ZzhyUEZDcDUyYTlYdmNLaERVZ0Q3aU8zSFBuTmZGNmpRaytsU0xLcnJ4TWdH?=
 =?utf-8?B?RXQ0VHBLM3V5QjljK29la1lRYlJhd21BY0k2Sk5jVmdsN3ViRWRkb1hMZWdF?=
 =?utf-8?B?bGhFcE1wZ3V0b09XQ29BTlFaaHZ3dDR2U1ZJWmZLRGRjYWxobzFENUZtcDRP?=
 =?utf-8?B?a09pdjIzRVFCT1VSamx5RkpXLzd4MUlVQlRmMjhMNk5ZQi9qNjZ6RW1EZkNW?=
 =?utf-8?B?bDBLY2EzM01MSGlTcEQ3VHYxWmx0USt2SnZSYXM3cVRncXNtcFpKZlVRbG1N?=
 =?utf-8?B?eEIraFZWWHdURnVJUzExQnplS3E0b3VFZlhxbC95YnFVZkQrOENraFFab3c1?=
 =?utf-8?B?d0xXeG82V3NaaC9OSkphcExBa0E0MVA1VS8xMHRGQjFnU3YyUWJPUVIrUkV4?=
 =?utf-8?B?UGpRWS9GVmUyOHBOQ0VvV0FhM005ZWZOdkE0SXh6T1YrT3FZZ09GYkpVVlpW?=
 =?utf-8?B?NWl2L2pDQVJZRVRESWV5ZDJDSTRFS1JNVURlczlON0FMRTg1RjlxVnQ5RGdS?=
 =?utf-8?B?N0ZWQW5wK2xCazZud2srcEZZRU9iTFNSZndqN3UydXh2eDA0OXJXT2QrMVpK?=
 =?utf-8?B?SEE4WG5IbmJnYnMyWXV3aSs2VlRHMWdVUzVFSUNKRGtyaTRwR1VzeThQRWI1?=
 =?utf-8?B?SE1zb0owU1IrZUtDSjdCaGd3eUtnWXdCOGpNUHNJSkUzV1FDa2xPZ0piYXlh?=
 =?utf-8?B?V0FmUTE2RDdyckhhQWxqSXAvMENMV2xkdkZxZExMZnZoRStoeHIxOTJaWkhs?=
 =?utf-8?B?WFJFTkhveCtOL0tIeldlYkxQWlB2OXJCMmh6RjlkSU5pMTNUZ3RZbzBidUJG?=
 =?utf-8?B?RUhhQVpwT3dCVGhlclJYNnQ2bWNoK2FaTVNKeVMwSnExMHpxc0xtbndxMjFF?=
 =?utf-8?B?N0FnWFV2alJjenRodEpwRDdOSjZTZGJMcFFGNjY1RUlOK3NUb2xyRHFCbHFK?=
 =?utf-8?B?amhSci9NT2FMaTNRTlpBbmJ6eE9CNEZkTEpjY2RUYUdjSjVoOC80b3cybENq?=
 =?utf-8?B?OGxaQVlrTmFZNmRkbzdrTG4vd3IvUnVaNzQ3Q2F6UG5KWW91WWEzRXY1Vmox?=
 =?utf-8?B?d0dZVWYyZGNDbXZQNDFuZXlTK2psbitUU2tHZEtHTUZoMUk2Qzd1Qy80N3Rn?=
 =?utf-8?B?UU9PamRDaUNNdFBxZGlMcVh6ZTd6cHoya2dvUVJEclBwNkVnSm53VjhHSG9n?=
 =?utf-8?B?QlJsYnM3cGlLOVFWTFVFWGdDSW93RXBPREhCbGlVUGk5bjlkVUxvMzBQOWhE?=
 =?utf-8?B?Z1l1WThwMnorbjBYbTFDZEpyWFdCUUx2WkpRUFZvcDlTTnFHS09JZC8vU0g2?=
 =?utf-8?B?THg2emhRUXRrZE9vTXhId29JaWkxZXNRYkhzSzFlaHVvRmlqa2crVUJoNEZ0?=
 =?utf-8?B?bmFuQzU5Z0ovaG41TVMyTGFEN1VYelJKMTJSZitIMStNWWM2OEw4UlpaL1dz?=
 =?utf-8?B?YWZWSlRjSEt6VDhab3lKQzlHWWFDVDlnN3p6K1prd29KOThET2c4Q05zcnlw?=
 =?utf-8?Q?7VRlMq0jNszyztc393ekpuMyLZ7PIA7aJiiFNew?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b67d1d85-9944-4090-67e9-08d956b849f7
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4150.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2021 19:52:56.7713
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Fey7klPo+xpaxX7+UUv0oub9Wkr+hhcAaigm8DUJeDY1uyU4ck5Plx9AyC2SGRDg0ynq6qZV1xtRxpzqzIJR98fOeIotXJ1ikH/L/EDqU3Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB3877
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10065 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 malwarescore=0
 bulkscore=0 spamscore=0 adultscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108030124
X-Proofpoint-ORIG-GUID: mpOg2x-csJO8tSUcJJJJRvymQJzxNHEl
X-Proofpoint-GUID: mpOg2x-csJO8tSUcJJJJRvymQJzxNHEl
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


> On Aug 3, 2021, at 11:01 AM, Mimi Zohar <zohar@linux.ibm.com> wrote:
>=20
> On Mon, 2021-07-26 at 13:13 -0400, Eric Snowberg wrote:
>=20
>> When the kernel boots, if MokListTrustedRT is set and
>> EFI_VARIABLE_NON_VOLATILE is not set, the MokListRT is loaded into the
>> mok keyring instead of the platform keyring. Mimi has suggested that
>> only CA keys or keys that can be vouched for by other kernel keys be
>> loaded into this keyring. All other certs will load into the platform
>> keyring instead.
>=20
> I suggested only loading the CA keys stored in the MOK db onto the MOK
> keyring.  Like the builtin trusted keyring, the MOK keyring would also
> be linked to the secondary keyring.   Assuming the secondary keyring is
> defined, all other properly signed MOK db keys  - signed by keys on the
> builtin, secondary or MOK keyring - would be loaded onto the secondary
> keyring.
>=20
> As previously discussed, this might require reading the MOK db twice -
> once to load the CA keys on the MOK keyring, a second time to load the
> remaining properly signed keys onto the secondary keyring.

I=E2=80=99m only loading CA keys or keys that can be vouched for by other k=
ernel=20
keys into the new mok keyring.  Currently, I=E2=80=99m not doing another pa=
ss.  I=20
could add another pass, but it would not solve the issue with someone tryin=
g=20
to load an intermediate CA along with a leaf cert.  This would require yet=
=20
a third pass.  I wasn=E2=80=99t sure if this added complexity was necessary=
. =20

Currently, any CA contained within the MOK db would now be trusted by the=20
kernel.  Someone using a kernel with the secondary keyring enabled could=20
load the intermediate and leaf certs themselves following boot.  Taking=20
this into account, if you=E2=80=99d like to see two passes, let me know and=
 I=E2=80=99ll add=20
that in v3.  If a second pass is done, do you really want these additional=
=20
keys added to the secondary keyring or should they go into the mok keyring
instead?  I was under the impression the secondary should be empty until a
user adds their own keys into it. Thanks.

