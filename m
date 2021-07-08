Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15DA93C1BDD
	for <lists+linux-integrity@lfdr.de>; Fri,  9 Jul 2021 01:18:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229627AbhGHXVT (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 8 Jul 2021 19:21:19 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:7368 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229553AbhGHXVS (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 8 Jul 2021 19:21:18 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 168NAesj014725;
        Thu, 8 Jul 2021 23:18:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 subject : from : in-reply-to : date : cc : content-transfer-encoding :
 message-id : references : to : mime-version; s=corp-2020-01-29;
 bh=qUzKPhhgySKxxTAarSP234RPKYFMsr/ve3ht9BerGME=;
 b=DfKTw29hHyNRPhrymG5p/hhs8tB52yBUj3exhqZZ2Tg8zewvM8obfAYnOF9qyBi7P9mC
 sHL0NVANZXtN3jWELFAcp/FML0+PGp2vQcgcOsmRR8rewtrcIQi115E4QNzfPCjveUus
 T7ulVreBLJBJPPjUC1wnBdlbjkL/7Eoys8Smz1zeixBA2s9lo4mWyy+7PCLm0qlQ/vVN
 tVpXaLbZG1+lj3PYGcABvntZ+CItEK2lrsrweXGJdl0i2R9lLL0sNQ1r+S2HcOGeKinn
 e+GUmbO/FRV8usyBfZM9hrzoaFTLLhnqzbxG/IlQghwJR0JsQ202Bk5DunyeIttCcrGE Zw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 39npbyj6ds-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 08 Jul 2021 23:18:03 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 168NAR60081902;
        Thu, 8 Jul 2021 23:18:02 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2106.outbound.protection.outlook.com [104.47.55.106])
        by aserp3020.oracle.com with ESMTP id 39jfqdvx9r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 08 Jul 2021 23:18:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bMfkovlt1rVOuvykDEz58JWtw8BRv5KgaL/nHi+cSOjizHThNPy6wQUoqKKC+HY7VRdpUFw22D5WiUOR5lA33VlBlqDAzHcCT7U/95Odo+pIA1AaSG6QE03KkdeN+bY6oxH23MRx3HKOWWY0xxt3Ev2e54Yc2Mlyj/24S5Y8GzQqty09vidOmCZbHHz5v79/itCyXk85KSLqypVguyXvvXP6AHFdKEtsjlpgCcAB0eqhZif1QmAbshIB6R7OWzLDUN7L5Xcl1Pr06rR4+9T81HJwCoi7JDyz8f76hxxlLQDCIv7/i2h9XOQIFoILFO6I+RIR0keaUB3LMqRJeY3qWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qUzKPhhgySKxxTAarSP234RPKYFMsr/ve3ht9BerGME=;
 b=PniPjoAs9iVgDVAeOWJV6v2OFKFqGfPZeuo3ueMUHozTWRAA6wLvPskxHY2LWx4rQHa8XZTQfkut6bXlveqJzAXL9tVamcb1NBpaTh9p3MJdV/jcefd/dWFSCmveN9DEgH39kY/6wval3Cl8lN4SWn1gqT6+kPO9HLhukWMXKTxhVvZ8hZiXAtMgeu+iNWArSNNyodv2xcIIr1zTvjQtccYIXbAE8Vg2neqNagn8FyeqvfcPSF4VhnXo+ShckYo5q4bMjf0GlNJqvKTjQMxb7ih4s83ERTZJdyzZ2mXN6sMedn5iWJSGrN2w1cPBl6nFbjxL5LvNqWoSzQiT9wwggQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qUzKPhhgySKxxTAarSP234RPKYFMsr/ve3ht9BerGME=;
 b=OZMr5qxeAIGLtPHORXNfUrW8UkQtzSRdqLx1RkdOxoXWLVH8GfStV0iK2qecbZOLm+iG+/eSofQuG47w038w/LDJBGQR5IobzZQ+5i/fJ+b1C9XFvv8kvDoKuqewyt/yToZTHFkBY+Pl0fj5lBTTL0S3lgDsrlm+225bE2TrsnE=
Authentication-Results: linux.ibm.com; dkim=none (message not signed)
 header.d=none;linux.ibm.com; dmarc=none action=none header.from=oracle.com;
Received: from CH2PR10MB4150.namprd10.prod.outlook.com (2603:10b6:610:ac::13)
 by CH0PR10MB5193.namprd10.prod.outlook.com (2603:10b6:610:c4::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.22; Thu, 8 Jul
 2021 23:17:59 +0000
Received: from CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::a890:e571:de3a:7197]) by CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::a890:e571:de3a:7197%8]) with mapi id 15.20.4287.027; Thu, 8 Jul 2021
 23:17:59 +0000
Content-Type: text/plain; charset=utf-8
Subject: Re: [PATCH RFC 00/12] Enroll kernel keys thru MOK
From:   Eric Snowberg <eric.snowberg@oracle.com>
In-Reply-To: <490941a5197bf4bcf0d6f95610085ee4d46ed9bb.camel@linux.ibm.com>
Date:   Thu, 8 Jul 2021 17:17:52 -0600
Cc:     keyrings@vger.kernel.org,
        linux-integrity <linux-integrity@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>, keescook@chromium.org,
        gregkh@linuxfoundation.org, torvalds@linux-foundation.org,
        scott.branden@broadcom.com, weiyongjun1@huawei.com,
        nayna@linux.ibm.com, ebiggers@google.com, ardb@kernel.org,
        nramas@linux.microsoft.com, lszubowi@redhat.com,
        linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        James.Bottomley@HansenPartnership.com, pjones@redhat.com,
        glin@suse.com, "konrad.wilk@oracle.com" <konrad.wilk@oracle.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <839EF700-7A2C-4282-AF97-768FAD1A9957@oracle.com>
References: <20210707024403.1083977-1-eric.snowberg@oracle.com>
 <42b787dd3a20fe37c4de60daf75db06e409cfb6d.camel@linux.ibm.com>
 <5BFB3C52-36D4-47A5-B1B8-977717C555A0@oracle.com>
 <886f30dcf7b3d48644289acc3601c2f0207b19b6.camel@linux.ibm.com>
 <D34A6328-91CA-4E1E-845C-FAC9B424819B@oracle.com>
 <c0cf7f883a9252c17427f1f992e4973e78481304.camel@linux.ibm.com>
 <21EFCB58-2D89-4D30-8DA2-B952A7E1B1BD@oracle.com>
 <490941a5197bf4bcf0d6f95610085ee4d46ed9bb.camel@linux.ibm.com>
To:     Mimi Zohar <zohar@linux.ibm.com>
X-Mailer: Apple Mail (2.3273)
X-ClientProxiedBy: SJ0PR13CA0080.namprd13.prod.outlook.com
 (2603:10b6:a03:2c4::25) To CH2PR10MB4150.namprd10.prod.outlook.com
 (2603:10b6:610:ac::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.16.177.128] (184.60.195.210) by SJ0PR13CA0080.namprd13.prod.outlook.com (2603:10b6:a03:2c4::25) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.12 via Frontend Transport; Thu, 8 Jul 2021 23:17:56 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 80ef64ca-a6c9-40c9-3665-08d94266a02a
X-MS-TrafficTypeDiagnostic: CH0PR10MB5193:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH0PR10MB519349389342AA306A38599C87199@CH0PR10MB5193.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8oQnxmLrqYUMlT/svMY988GYKvM0arMAkUjC9bp0U0lp6bnu1rpeAIKBNJT0WG2v8l2X+CBUuCVtPvJRLlLT6v2QD/xCewhukEnI+CkYOvkH73CuwuKfUHxpyaw/b83xaGbp2gsC3W8ie6/aFNvfooYQcdm2mfDwt8pyEHq1689kWMLsfc5fhtu6DtzWOf533DAhhDpPwwdDmw5dE3jgUjCrgdxYxHn8MtLyENdA477L7l2cLK7MC0ttKwJhOuXuJjKerOoNdxYDgEUpXIoetuugLhETGlyBhpQFAM6Jgs1x+7NFwuAnukyoxPcvectDf2+GsavpnGLe/ryi5TJOUVczazzAkTLJ3r3vfg6YWg1cn8PZ2jdB9DTMGd0dsCeJPgnC3SvlVIh7js1SgD8NUjWntQgkilGykNziT1b2i4sC/syyug1K3fc85pk5PN5RCLoZsXs1AdQwMia4iTkb+38WMRfjyDSiKs7o/7waSHEu8JJwzlkiC8Z9HQfMT7qbQHihEBnXbcFqGRksS4asTUBZmGDyUMKX0Al8eXXHnYhGJiudcsNTf87ZCZiaKKifPvjR4kafLwTs8ETVz6j8/SX4qidTPOPTC112nqP1IIC07rqjsF7HNf2bGCW43A/4KJH9OmWh+98C6P2UpIYlpy8mvNA43Mlce3ZUz47kwKdo0LR+YpeyfQgxbCObo9MbC9R+ihL63nChwWTNZhl1Jw4qqkl6y7kvxkIT9cdqIdE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4150.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(396003)(376002)(39860400002)(346002)(366004)(54906003)(6916009)(86362001)(316002)(66946007)(2906002)(53546011)(7416002)(26005)(107886003)(16576012)(5660300002)(6486002)(478600001)(38100700002)(36756003)(38350700002)(52116002)(66556008)(66476007)(6666004)(33656002)(4326008)(8936002)(44832011)(956004)(83380400001)(8676002)(186003)(2616005)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TEIxb3hRNmhlSXlTWm1mYkticDZMWlZkdkFqL20yanMrWi9CaWxQVWVTM2xI?=
 =?utf-8?B?ODRaS20xUmpiaU9tRzA5WW1EQ2g3eUthc3hBN3BKYmN3ZkxXNmN1bGJyQURx?=
 =?utf-8?B?d2xKKzUzaE1vVzFXZFlyWUxhblNhMTVwY29wb1lSTGRXYVdueFE2RzNwaXVy?=
 =?utf-8?B?SVZWZ2tiY1UvOGVpaHhuY1I1UkVjcDhGSjcvcm1McDZhSUo5OCtyTEVWRXRr?=
 =?utf-8?B?MExmKytKWk1OL3pwYzFNUHBsZWRPaW9HK05sdTdOVUdJQ2Z4NmRqNnRib2Nl?=
 =?utf-8?B?TXhKc3BGZUJPMjllRzV1N3B1NmtHSzhPd0pJNnlBcURVMHJ1UktzbXpXUmN3?=
 =?utf-8?B?QVFiaTdwNzZNNGhZTGI5RTc4aUx5aG1ZZVNlOUc4Y2tYd2tNczI0NFFVUU5o?=
 =?utf-8?B?aFk1K01NL1VUVmtKTmZwMVQrYSs5U0w5ZTFCTFdPT01UZitIUmJqZ2FyMjJy?=
 =?utf-8?B?TTBmV2JseGJHS0ZDdXVhTWIwU0k4bVB0T1VOUThRekFLZ2xocCtacGF3U3pp?=
 =?utf-8?B?R2tnQVluTE41Q0Rwcmd3Tit6d29hMmRJY1phdlBjMnVhWEd3ZXBvUmVPbmE3?=
 =?utf-8?B?L3lEaWp0ZVlUcHd5ZHpsZTZLMGxyZytpaGNWbDAvc0FENWMybWsvVEgxemtR?=
 =?utf-8?B?UUMyVGVzSkEwQ3YzMm10Nk5lQkdlQXhlU1lrQXM0VUYzNU5zYUlsWUVNb2po?=
 =?utf-8?B?OHF5djVBWExETGc5eGZlUkJKR0lseEEwbFVjMnZSeGh4VDNoQ1hUbG1CKzV0?=
 =?utf-8?B?RnAwdDRVS0drVmlyUDZZbnRvR0RZT0k5VUFuOSswZDJEdWN5a1ErUnBGNDA4?=
 =?utf-8?B?Z0c1cnVWc0RZWXVEYXY1MkM1UXZTWDFBSlJETXZzLy9OOE1QOW5mS3EzV29q?=
 =?utf-8?B?VFdOVXo4L2YxME5LaFdVZmh1WnM0d1FoMTUzNjRTdDlNOEptdk12Zzh0bW1i?=
 =?utf-8?B?YzU2dk40aTFqaFFicWRZb1lmMEduSU5Na2QxRVF4ZFBYMFJCTnhaRWIwdk0v?=
 =?utf-8?B?cjVlaGFPUXdaWEhlZkpqSkNnVWZRQmg3WjFYSGJyWXR3ckNRTklCYnkzeWs3?=
 =?utf-8?B?Z0NKd0lIUWg0Q3BBcktFODBXR0o1RWZ3NzJGekJXcHZVbWJESUtweTYyK3Za?=
 =?utf-8?B?alIwOURmY0tjQUFLaUdzK1hpTW05ZVBBZGc2amdNTnBpMnBzSnhDdjdWZU1F?=
 =?utf-8?B?cGZ4azAzcksxWkhqdVRoaVo1RnVlVkhOY2xBeE96Ym9IbnR5bEo0Nmo3OWJT?=
 =?utf-8?B?RlRqMnloMEszMjdaWWJ6cVpNNE1rT05MMXEzbkJOSGFOU2FvUkIwVm0yRDYv?=
 =?utf-8?B?QkRSajRpbE5NbUJhaDdhRHloWUdyOUc3OTJoUE5rMkh6R20vWFdJbE44VUhV?=
 =?utf-8?B?RE5KRStuejM3OWtqTW5XL1g2RXZHc0MvNllnOHQxZS9CU3BNaHNLcU9acGs5?=
 =?utf-8?B?TEV5Lzc5Nzl2MkNxVW90YWxkMmowbmFlbkFseWV1STRZelZLK0FrSHRqYkpC?=
 =?utf-8?B?MlpTckxSR0xReExQUUJ2UEZEREJlN2FqbzFtMEpwOVE5Q1VKSjZCZFlyd0ZS?=
 =?utf-8?B?UHM5UE5IOWEzaUhwdVFzTUhFN253VGVGbEVmclh0ekU0UWdaM1RvZFo1Y2hS?=
 =?utf-8?B?dW5lUnlKbTQ2cTc5YTBLZ2JHb2lJaURXcEkxTC92ekNUazlCVmNpM3RGQjE0?=
 =?utf-8?B?RmxsdnBkSkRCWmtQOHJjbHFnbDhrZUtObTdNZ2pyWStPVzJ6QVBMNFh6SzNn?=
 =?utf-8?Q?ZV/BWSV1j7ONm5a0dQQGNhsyrH9cLmcKsOU3eCc?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80ef64ca-a6c9-40c9-3665-08d94266a02a
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4150.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2021 23:17:59.3243
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cHOh+Xrpphx4mqtig2X1iSyLhLCda1dbAP1kcWqxW67eviOh98Q22pqR4M+thphtYJpcfwgX+3yZHndEuY3/JXxmRYnj/6lUv+JsuhmKE4U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5193
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10039 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0 phishscore=0
 mlxscore=0 bulkscore=0 malwarescore=0 adultscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2107080118
X-Proofpoint-GUID: Mmcc6SehXgBVWq9eu99T1TsggKHOslyc
X-Proofpoint-ORIG-GUID: Mmcc6SehXgBVWq9eu99T1TsggKHOslyc
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


> On Jul 8, 2021, at 1:31 PM, Mimi Zohar <zohar@linux.ibm.com> wrote:
>=20
> On Thu, 2021-07-08 at 11:59 -0600, Eric Snowberg wrote:
>>=20
>>> Asumming a
>>> function similar to "restrict_link_by_builtin_and_secondary_trusted" is
>>> defined to include the MOK keyring, the CA keys in the MOK db would be
>>> loaded onto the MOK keyring, the other keys that meet the secondary
>>> keyring restriction would be loaded directly onto the secondary
>>> keyring[1], and as you currently have, the remaining keys onto the
>>> platform keyring.
>>>=20
>>> This eliminates the exemption needed for loading keys onto the
>>> secondary keyring.  The MOK keyring, containing just CA keys, becomes a
>>> new trust source.
>>=20
>> I just want to make sure I understand. If we kept the .mok keyring aroun=
d,=20
>> we would store it into the system_keyring code, just like the platform=20
>> keyring is stored.  This would allow the move exemption code to be remov=
ed.
>> If the mok keyring is a new trust source, whenever the secondary keyring=
=20
>> is referenced in verify_ code, the mok keyring will be checked too.  If=
=20
>> I have this right, let me know and I=E2=80=99ll work on a v2.  Thanks.
>=20
> All the firmware keys are loaded onto the "platform" keyring, without
> any restriction.  Your reference point should be the "builtin" and
> "secondary" keyrings, not the "platform" keyring.
>=20
> Changes:
> - defining a new keyring restriction which only allows CA keys to be
> loaded onto the MOK keyring.
> - defining a new keyring restriction something along the lines of
> "restrict_link_by_builtin_mok_and_secondary_trusted()".
>=20
> In the case of "restrict_link_by_builtin_and_secondary_trusted()", it's
> based on a build time option.  In the case of MOK, it might be both a
> build time and runtime firmware variable option.  There are quite a few
> permutations that will somehow need to be addressed:  secondary keyring
> not defined, but MOK keyring defined, and the reverse.
>=20
> Once all the CA keys in the MOK db are loaded onto the MOK keyring,

To avoid confusion with the new keyring name, would it be more appropriate=
=20
to change what we are calling the .mok keyring to the .trusted_platform=20
keyring instead? Or just leave it as .mok?

> there will be no need for moving keys to the secondary keyring.  The
> secondary keyring restriction will just work.  The main question is
> whether there will need to be two passes.   One pass to first load all
> the CA keys onto the MOK keyring.  A second pass to load the keys onto
> the secondary keyring, based on the keyring restriction, and the
> remaining ones onto the "platform" keyring to avoid the regression.
>=20
> [Once the CA keys are loaded onto the MOK keyring, userspace will be
> able to load certificates, signed by a key on the MOK keyring, onto the
> secondary keyring.]

Other than that, I think I got it, I=E2=80=99ll start working on a v2.  Tha=
nks.

