Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B56E03FD0EE
	for <lists+linux-integrity@lfdr.de>; Wed,  1 Sep 2021 03:53:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241699AbhIABxb (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 31 Aug 2021 21:53:31 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:43906 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241698AbhIABx3 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 31 Aug 2021 21:53:29 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 17VNai26006211;
        Wed, 1 Sep 2021 01:51:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 subject : from : in-reply-to : date : cc : content-transfer-encoding :
 message-id : references : to : mime-version; s=corp-2021-07-09;
 bh=QiEyI3BoKXSfJXRKutrXbdhk5LC4ycW6P5o/2YtRCQY=;
 b=MWCTdokYB41Og3J221zlxM0WDN9h9XAQwiaDHSVL/oJNp1WIpIyDd7GFuttjRuSkUg6/
 0elbgwi+FRMR8dYJUOq2yjdvaw0cFESMKyVvea4uuQcDkLCKJaDBp49r4ceIuP6/O3Cx
 vGyir7vGadsvvmpu9HIUN0gfQ+FlSfdsrf0zfTLTJvc+wgqjpQduBsY4SIcN01Nu8Zvi
 6yQvBVY5fWcBSFcS/Q7nq0QVkLpWdDhurAEh6wglvTDHCqO3T22McHjPCwOVk4lECcg+
 Q7uzZLAQJ37utGfXvWN770Wr60Yl+EmR9dXPKPM49k9zGfE6N5RhbFXNDI5JtWWINIiO Og== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 subject : from : in-reply-to : date : cc : content-transfer-encoding :
 message-id : references : to : mime-version; s=corp-2020-01-29;
 bh=QiEyI3BoKXSfJXRKutrXbdhk5LC4ycW6P5o/2YtRCQY=;
 b=GbTArznUKtWpohAE8AcIYYjPD45B7e2V4e6OxzYLxXV/24pCSNniz8VvpjwIQsbT9XST
 EAMraIdZo+3h0Lb0ypW7wYL0ZLuJa0RdruLtflppgn0Y0ZeHN8hVNl/W+UUamP/3tr6K
 ovI1Sum0/2jMrfD50OO5fdeRtdlbSAhWQrG/cZAopHMzSjTPi+WMq8xFokZ77UCVoe/i
 J8mWYqeWAMqJXtO3iaPw/vNsvcM7F9OIvLSTt4Nv5NGMu5WzUpZVA0TLuTMMvvFnOZKg
 PZpPwOeztmGT4ksWE4uGEj8TXMxWz1pXv34bJh5JLg9SnYaqWrmZWSV5/MhFd03MY30z ig== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3asf66jw0s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 01 Sep 2021 01:51:45 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 1811jdMn195652;
        Wed, 1 Sep 2021 01:51:44 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
        by aserp3020.oracle.com with ESMTP id 3aqcy5sk04-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 01 Sep 2021 01:51:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QRuIwaSfzbr+YgfTwwa9i0COdfbbYgPbLuCsjlXtfcUawEn/aYt5fUMrl8XtzIqNIMSqnnriQjruS5do2z3bEKKwFDxxkca6mToO7edIlwmh4H4wDNCfcBtmB9JwJudEUegs4ytcgUSoEpxMzJ54s0s9To16L07S62h/o6OicZJUVH5c16aYQBRrd2XtRREAZiCmkvr2mAWBaboqrh4ZeEh9VtDP3nH6eohAD52P5tHJeapXeIMKBTz//aygk/I58us2N7pepivh349dNCi4HFwIg2nBZ47GCwpj+e2onVgS5GrD3AgIQ7mSrNdXrOXPzb3xRDuFvFS49uRzm1ZuqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=QiEyI3BoKXSfJXRKutrXbdhk5LC4ycW6P5o/2YtRCQY=;
 b=KCvGGY5aKiVPp4BWKHNqfrLEyaBG1WNzQTFFw1RLwfh0cwJcZBx5eTyAf3saKzohGxy8VDT99eDC12yBJ8s5OYNH+yiXqG9GwxhCGHr5EVqrO2hxduoXOxabtUQavNMQmeRFXMu2TJ7VSoDkcxW8jHaL2O0TcwQRds+ovhF21BtbP8FpbxfFcWAajz2KEhQT4lZYzXO4iY6MI9Z91dMLrxDFmISqKkvopY1nNU4D2YDdA5tWxTYw6p4EQ6Lh/43LQAyBSooW4yo3W9LWZgnw9CXd8hB4JfflzasklN6AMti/SskDLAieUv4fBzNaM4Ug9fygyhJtNOq3zTeOz/SlJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QiEyI3BoKXSfJXRKutrXbdhk5LC4ycW6P5o/2YtRCQY=;
 b=CpmEZa3GneRvjstZBLYO/KMF3rj3UA1BVZsAVE33og1SqxmEoq5DHvT5jLskR8sQjE/sK1GZrPK+KoMy6byY1mvdIX/u3bG5sDP9vAaVwvvqWCs7Qeme1SbOXkS7sCJg2xwYrTfDN3A6w+za7DyMDRgqWT89e3K0F2uim3nzvWY=
Authentication-Results: linux.vnet.ibm.com; dkim=none (message not signed)
 header.d=none;linux.vnet.ibm.com; dmarc=none action=none
 header.from=oracle.com;
Received: from CH2PR10MB4150.namprd10.prod.outlook.com (2603:10b6:610:ac::13)
 by CH2PR10MB4149.namprd10.prod.outlook.com (2603:10b6:610:a7::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.19; Wed, 1 Sep
 2021 01:51:42 +0000
Received: from CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::340c:c4d9:1efa:5bc7]) by CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::340c:c4d9:1efa:5bc7%6]) with mapi id 15.20.4457.025; Wed, 1 Sep 2021
 01:51:42 +0000
Content-Type: text/plain; charset=utf-8
Subject: Re: [PATCH v4 00/12] Enroll kernel keys thru MOK
From:   Eric Snowberg <eric.snowberg@oracle.com>
In-Reply-To: <89a37802-1423-6b1c-c0ef-6f84e544ac33@linux.vnet.ibm.com>
Date:   Tue, 31 Aug 2021 19:51:30 -0600
Cc:     James Bottomley <James.Bottomley@HansenPartnership.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        David Howells <dhowells@redhat.com>, keyrings@vger.kernel.org,
        linux-integrity <linux-integrity@vger.kernel.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>, keescook@chromium.org,
        gregkh@linuxfoundation.org, torvalds@linux-foundation.org,
        scott.branden@broadcom.com, weiyongjun1@huawei.com,
        nayna@linux.ibm.com, ebiggers@google.com, ardb@kernel.org,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        lszubowi@redhat.com, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org,
        linux-security-module@vger.kernel.org, pjones@redhat.com,
        "konrad.wilk@oracle.com" <konrad.wilk@oracle.com>,
        Patrick Uiterwijk <patrick@puiterwijk.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <D5553DD8-7CD4-4D78-A9D6-FC22BA16181B@oracle.com>
References: <20210819002109.534600-1-eric.snowberg@oracle.com>
 <fcb30226f378ef12cd8bd15938f0af0e1a3977a2.camel@kernel.org>
 <f76fcf41728fbdd65f2b3464df0821f248b2cba0.camel@linux.ibm.com>
 <91B1FE51-C6FC-4ADF-B05A-B1E59E20132E@oracle.com>
 <e7e251000432cf7c475e19c56b0f438b92fec16e.camel@linux.ibm.com>
 <cedc77fefdf22b2cec086f3e0dd9cc698db9bca2.camel@kernel.org>
 <bffb33a3-d5b5-f376-9d7d-706d38357d1a@linux.vnet.ibm.com>
 <9526a4e0be9579a9e52064dd590a78c6496ee025.camel@linux.ibm.com>
 <9067ff7142d097698b827f3c1630a751898a76bf.camel@kernel.org>
 <bc37d1da3ef5aae16e69eeda25d6ce6fe6a51a77.camel@HansenPartnership.com>
 <10bc1017-2b45-43f3-ad91-d09310b24c2c@linux.vnet.ibm.com>
 <D07DE64F-FE8B-4020-8EC2-94C3C0F9920A@oracle.com>
 <89a37802-1423-6b1c-c0ef-6f84e544ac33@linux.vnet.ibm.com>
To:     Nayna <nayna@linux.vnet.ibm.com>, Mimi Zohar <zohar@linux.ibm.com>
X-Mailer: Apple Mail (2.3273)
X-ClientProxiedBy: BYAPR05CA0069.namprd05.prod.outlook.com
 (2603:10b6:a03:74::46) To CH2PR10MB4150.namprd10.prod.outlook.com
 (2603:10b6:610:ac::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2606:b400:2001:91:8000::7d4] (2606:b400:8024:1010::17c6) by BYAPR05CA0069.namprd05.prod.outlook.com (2603:10b6:a03:74::46) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.11 via Frontend Transport; Wed, 1 Sep 2021 01:51:35 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f98b9516-4a0d-4112-7b9c-08d96ceb0bd6
X-MS-TrafficTypeDiagnostic: CH2PR10MB4149:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH2PR10MB4149FAEABDFE0F9D8CBAF0A987CD9@CH2PR10MB4149.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mP3P5B9U9SPLgvRspjkoTL4GJQXm43WKh+uTswvkjnwuOUDuUUPUp++B09LRLCxdsnFPQoJF9iVGtdwsQCvYeUQoEcliTFHxqhUR89zDn+2QjcSyiKldmx2og9I4D0u3hGo1Az/FXuZFnI+lPwBEx0VEVOnZAHWh8XU1yTyRapRGO63W0fEXDnNn0xc+DsN0cdqSVHH6pkyjMQRZfO0NCDnQnp/SpYw/3zDCXeMs6Jo7t90oWHIamuXLm6G/9TwieJQw8ypfhMk0YgZ8T01ZKKu9oTQO580nGWqIoPyAIuigasbEHqVgvOT5uiiiEyzbddekklX5/RyMEJnY01trjobEapqp7Bnj+i8xLzgPGsx+wWFc4ocKGe080WPL9QgXhxP1L4qkgq2X6EWK/8DihaZyR6uCFLp4m10QlQc7ot34b1oX/QfScJeHj59KusLJ7xiBCYjg4XVQxIoojTZUJaHsiSLWZqJ0pp8/IeSfj2DBaSCwubV6597oi1YgUCzQS9493uthZZRuJy/0cufNuMn9De8/pPUqlA51Wybp1NlWaONOIK1YO5RgPArBjTrwdTuNGCDOT9dG2+Kd66LYlT1R8bKJloSGOU4eL/BDBFzEz9gI+Hp8L8k2qEm1m6/CQjojC7kEAfi1xRcbqo+8Em9s0+tb6zstYveE30vuCId13gLVL7wsMsFd8qUIvkV8PjF16one/Oug6/9vTFY6yw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4150.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(54906003)(316002)(44832011)(53546011)(2616005)(110136005)(86362001)(8936002)(186003)(36756003)(38100700002)(8676002)(5660300002)(6486002)(6666004)(2906002)(83380400001)(52116002)(33656002)(66946007)(66556008)(66476007)(7416002)(4326008)(508600001)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V0lGRnBEcDZNTlNqUG1aaEJ6L0ZnUXIwR0UwdHo2dXhGNmxHM01mME9RTXFI?=
 =?utf-8?B?dDdFZnBPSU1HZG9sMnc5NG5PT3A1VnVOcmI3UXRtemRMR3ZnV0tMTVljOUJ2?=
 =?utf-8?B?VE1YSVhLK0R0WjJFTU9XMnllaUFPT2FLUVp1K25WU0c1bHd4a3o1b3NCWE5V?=
 =?utf-8?B?MDNGUjUrWXFQcDNueFN3Q0lJYUw4WEt3VURkaytaQ2ZmeGxjWGM1cXUxU0VZ?=
 =?utf-8?B?WDFzMmJENGJCRnpMVFZCNHl1d1VIL0h6cUlhS1J1RmlGbko4cXdwNC9LU1dy?=
 =?utf-8?B?aFB3VC8zZGRTeC9oRFRpT2NzWFVBTWJPSmI2VmN5ZEo4SGpyZTlmWHh0WjRq?=
 =?utf-8?B?aEJaZnJ4MmJSb0pBV0RPeEZYbFVUYWhBRTdUTXNXakN5NlNVQVh1ZXBobzNm?=
 =?utf-8?B?TWppc0E5VU92R2JNSnRIenMxb0gydFcrMG9XUjJCUjdJaHhnTkdyNExsNkpW?=
 =?utf-8?B?KzBwUVZFVEprS0wvdktlRHpLRWVEWkQ0czVwUER5dEdZSys0VDFpUVIwa3dZ?=
 =?utf-8?B?dDZMdWdiM2VVRGV3WCtBcEcyQkR3YVNmYVYxRFBxaUcrd1plVTNTcXhuR3Rl?=
 =?utf-8?B?aUQ5cjNXQVU0N0lFRno1SllzWDA0TU9nMzI5aG4vRG1KVDBNcVlyN2dOeDJh?=
 =?utf-8?B?SDE2K1ZmZ0NEc1UxTE9MdDRYY1NhQk5GT2pMcU50OVJNZVhZdERrQXZSRFpz?=
 =?utf-8?B?d2xNa0hLZHRhTGQzc3RGNldzL3VBM24rNlNneWNlc3c2TmVnaHJLSFk3alNx?=
 =?utf-8?B?N0pSOXYzeU4ybkMwKzFlVkFpREU0SHRBNEFYaVp2UkVtZ053K3JzMFl4eUNo?=
 =?utf-8?B?bkZIZ0p0UFNEOWtPRHVoZW01SlEwQmNuYVRJMEZrRStrYURKelI3UVhUdStW?=
 =?utf-8?B?MjJZYzAwckRxRUNWY1Z2L3Q2Kyt5ZkxTWjQzMmdyS04wamFFeWlCWCtYc0FE?=
 =?utf-8?B?blh4bXRuMUNPYWZUUUwxeVdUQlJWT29pZnRuazd0cmgrZmh3MjlZbXc0QmVk?=
 =?utf-8?B?c3RqYytLV1VCamRKb1NkeG9HVk1uczQ4Tnk5eklqSFVaVUI4MnF0YzNxRWtx?=
 =?utf-8?B?c3p1TU9xVlBqbmttRVd2ZGRyd3VqSVFLdm9WUHV6TGE2dWRJa0JGRkdSQjZK?=
 =?utf-8?B?cHJKTDhHOEM5b1AxMG8rQXpYeTU2Q0ExejBETlBIZTFTY0gwMDdhTjh2dVJh?=
 =?utf-8?B?RVdPS1ZRN0IzeXI0TzVKdC85ZW1KdmJwSFV2L3RXNzVLR0FkdktLaGNNb1Bx?=
 =?utf-8?B?cjVyVFUzS2V0ZXlWOVc3blI3TlZVMlk3eFl3Kzlnb0hUUzM2UEZJNzVLUDF2?=
 =?utf-8?B?cUpEdEpodVJWNmNDRExvQVMzZVdZUW5aYnZSbkNzS0lpd2JXMWNpd2IzcStH?=
 =?utf-8?B?SHA4T1RyT2RFM2dmL0xJcXdESEtJMWRoU2pxbVpYVEdMYURYNWFRdm1qcEd5?=
 =?utf-8?B?cFhRcVFJRFNFZDhJWUFra0QxS0ZpNlIzYjYzU0lINEIwcHZoSHRQbzViZWpO?=
 =?utf-8?B?RlI4VWFSWEhXaWRqRmFJeVJKcVJrbENjMDV0VEZ1ZVdlTDh1ZVRVaXJHdExS?=
 =?utf-8?B?T0Ficm5CSHhNUHFFL0w2MnJxT0tyb1hRU0hJZUs2dmZVZmVqNmYxVjlXVHU2?=
 =?utf-8?B?NmVKQU90MHlNc3NXSjE1Y0RsM242N0hzZDVrLzNpRVhjdUpuTzJOeXBZK1I2?=
 =?utf-8?B?OWhIV1BZUmZKdElqSDNlWU5QQXArVWt2ZzZRbXpjWVd3Q0JBLzc3bmExc210?=
 =?utf-8?B?OFhKNk1QeG5CWnFGdzJsNHYrcTNDenRtT1R3MFE2Y21wcm41TUVaQ3FXRFRw?=
 =?utf-8?B?dFBzYVRtalZWREY3UXRSQT09?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f98b9516-4a0d-4112-7b9c-08d96ceb0bd6
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4150.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2021 01:51:42.4880
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: biUx4l+FNj5m7pV5Ratl+pWjjYHs7/T5HHSFaM14XBXTtz6Jhq+wO4kE02ZB+/ZCl2kkf4PZ2nqSb7c00dDIod4EckWcf/dhLXQNymUK53k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4149
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10093 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0
 phishscore=0 mlxscore=0 malwarescore=0 mlxlogscore=999 bulkscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2109010009
X-Proofpoint-GUID: A7esnxOvf8NT_YCPa_UNyRDNSt6zHANw
X-Proofpoint-ORIG-GUID: A7esnxOvf8NT_YCPa_UNyRDNSt6zHANw
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


> On Aug 31, 2021, at 6:52 PM, Nayna <nayna@linux.vnet.ibm.com> wrote:
>=20
>=20
> On 8/30/21 1:39 PM, Eric Snowberg wrote:
>>> On Aug 27, 2021, at 2:44 PM, Nayna <nayna@linux.vnet.ibm.com> wrote:
>>> On 8/25/21 6:27 PM, James Bottomley wrote:
>>>> Remember, a CA cert is a self signed cert with the CA:TRUE basic
>>>> constraint.  Pretty much no secure boot key satisfies this (secure boo=
t
>>>> chose deliberately NOT to use CA certificates, so they're all some typ=
e
>>>> of intermediate or leaf), so the design seems to be only to pick out
>>>> the CA certificates you put in the MOK keyring.  Adding the _ca suffix
>>>> may deflect some of the "why aren't all my MOK certificates in the
>>>> keyring" emails ...
>>>=20
>>> My understanding is the .system_ca keyring should not be restricted onl=
y
>>> to self-signed CAs (Root CA). Any cert that can qualify as Root or
>>> Intermediate CA with Basic Constraints CA:TRUE should be allowed. In
>>> fact, the intermediate CA certificates closest to the leaf nodes would =
be
>>> best.
>> With an intermediate containing CA:TRUE, the intermediate cert would not
>> be self signed. Just for my clarification, does this mean I should remov=
e
>> the check that validates if it is self signed and instead somehow check =
if
>> the CA flag is set?  Wouldn=E2=80=99t this potentially allow improperly =
signed certs
>> into this new keyring?
>>=20
> In this model, we are relying on the admin to ensure the authenticity of =
the certificate(s) being loaded onto the new keyring. It is similar to trus=
ting the admin to enable the variable and add keys to MOK. Following are th=
e checks that must pass before adding it to .system_ca keyring.
>=20
> 1. Check against revocation_list.
> 2. Check Basic Constraints: CA=3DTRUE.
> 3. Check keyUsage =3D keyCertSign.

Originally I thought the request to only load CA certs into this new keyrin=
g=20
was so root of trust could be validated for the entire chain.  If a portion
of the model now relies on the admin to ensure authenticity, and the comple=
te
chain is not needed, why not have the admin also check for #2 and #3? Meani=
ng,
when the Kconfig option is enabled and the new MokListTrustedRT UEFI is set=
,=20
whatever the admin has placed in the MOKList goes into this new keyring.

