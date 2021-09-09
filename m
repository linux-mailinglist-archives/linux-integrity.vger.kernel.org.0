Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26687405C66
	for <lists+linux-integrity@lfdr.de>; Thu,  9 Sep 2021 19:54:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237575AbhIIRzL (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 9 Sep 2021 13:55:11 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:10172 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237254AbhIIRzJ (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 9 Sep 2021 13:55:09 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 189HhtCE016777;
        Thu, 9 Sep 2021 17:53:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 subject : from : in-reply-to : date : cc : content-transfer-encoding :
 message-id : references : to : mime-version; s=corp-2021-07-09;
 bh=ExOo73jffZVe8/2BuXEAdBc51Bj/wGfb2n32ulALTYg=;
 b=jXEKZcUKtzXv57XKhHT/0qct3NwJCRPmnFRpDlzJELvX48XgT4oHX0SZQuQojiKkc5W2
 3EIHl0FVziAEziPA7zy9Js4ASZEohPqc2jpeSlb4TFN9iqIO2TfVXKL6/sDmpphNqulO
 Qipfa8y/1bmg6fPE/IyISMNscf5k31FPan0PqLyV2KVLrBk3Cs2HI2cUQtBlOmbVuYiN
 D3suOZ1R3CDpRrXQmco+ezEekAAIonyGaKtodgm5KvrSGFGHU5/rE4cH8Ev6NFRUzAWQ
 86+RS5Gy/jOb/gYhTmu1iC0CU+yRDgdmG/9YSjt5aA9XDpgQVJxHsM+u01rGxdnlvbqN wA== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 subject : from : in-reply-to : date : cc : content-transfer-encoding :
 message-id : references : to : mime-version; s=corp-2020-01-29;
 bh=ExOo73jffZVe8/2BuXEAdBc51Bj/wGfb2n32ulALTYg=;
 b=iATLzJbX1Gn2LOOtI3c076XNf07xnwCMs0oqv48jv24d6F5iJNyg/hYwwDw1gVg7Dwfs
 9jgTQrrlbAGRWYnzwc97EIRBBkGeIojtTPi1LwAeICWN7FtpXSyhkxUARwjebU4PPHuR
 VSV1CLtGrkIJYNxLNk3mTGdNB5gXFmEi1CuQ7IIWgLGyq44Gi0CmbiEDeH8zbkYxCefb
 81xYi5J7hKpNaXp5m0Vg30l/JTBHlojX0M3V3XuhCZZh9XL0v4eptc8E9UfOqxQE5Ggp
 TSJXkmEYgZW/pQuzyyE+5ClLpFvW8YIwTNFoYRWswYZIZvUuzqRXYGxIihg7Yy31Bfdr Tg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3aydrsj1xq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 09 Sep 2021 17:53:28 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 189Hk918055050;
        Thu, 9 Sep 2021 17:53:26 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2172.outbound.protection.outlook.com [104.47.58.172])
        by aserp3020.oracle.com with ESMTP id 3axcpp3c1k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 09 Sep 2021 17:53:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dCiDXMN+QUyT5G1nHyG3Llrxe/vE7zcaXqQVWCWXFVM6a+5hvQqcgc7g+g3yAT2hP4IyEa1tPZnNXhm3Zzcs2ho8keFV12py64ZmGqf4EXF9tEOLUVZhLL/+YIePJMa21JATEEbmghwf9Yz7YjbeN7/qIxzSBbJ2IPfcbUhpjNpP629Op7bdB9Q4zgud1xgRkPSVHzDEsO/XsaXukhGZb/Gvp8DtXf2iT5bMiOsxwj8T28qACbSPkZ17wzvgYEGzrBLyObd9PfgLsgMcts07AO80N+s7hpyIk/AWX4qOBMJ+hzMC/jXN/n5m8pBCs9R/5Ra+jT4YrpeG/IMf14xlYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=ExOo73jffZVe8/2BuXEAdBc51Bj/wGfb2n32ulALTYg=;
 b=UY88hJqVRUECZFfpbmz4esyk2XP9H3s/KINut9rdjrzcacck4jPFkRfvTCDu37UmU55anqD/tAW1LguepvILiPnqnI8wmdURG8yvM18/tAMJTZC5fhcqgorFfFsLS2kqW45Mhp3ZeBur/tlv7I+vF+8/RJVEMTifNdl7eQZjUbQXAnjM5w8NOvce/zJigH+46xCtPx4RZQ/ajF+JPLXwmorV5FN/dlikuTh99Tkopy0gj7szdQlT2TXKKqY7HQiF2fYtCjqL44aKno7EL0QCshamk+HOmBkGbjxPMPyOyAmjHltlV/ufuC4SZq0JRopzokT/UVQBmkv/2N5s10gKtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ExOo73jffZVe8/2BuXEAdBc51Bj/wGfb2n32ulALTYg=;
 b=OBxIgSJNmZUcMswaN4wUEZOm0x3LDZdfbmcoFpQ2+ClPQ6BvBKUnikXrYO2FZQS/wb6HvuTlJGU+FqRVKsBSRL2mvz2QLxqUh09++ZPiN5F01L0nt5MZc+MQMYoGK2Hkf4H6CGi9maNSP0c95YTGmZCBJii/1Zm7qw29gIKZlMQ=
Authentication-Results: linux.ibm.com; dkim=none (message not signed)
 header.d=none;linux.ibm.com; dmarc=none action=none header.from=oracle.com;
Received: from CH2PR10MB4150.namprd10.prod.outlook.com (2603:10b6:610:ac::13)
 by CH0PR10MB4891.namprd10.prod.outlook.com (2603:10b6:610:c1::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14; Thu, 9 Sep
 2021 17:53:25 +0000
Received: from CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::340c:c4d9:1efa:5bc7]) by CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::340c:c4d9:1efa:5bc7%8]) with mapi id 15.20.4500.016; Thu, 9 Sep 2021
 17:53:24 +0000
Content-Type: text/plain; charset=utf-8
Subject: Re: [PATCH v5 04/12] integrity: restrict INTEGRITY_KEYRING_MACHINE to
 restrict_link_by_ca
From:   Eric Snowberg <eric.snowberg@oracle.com>
In-Reply-To: <c5d8d846cd03a97344700f8ce4f038cdc3e3b8fd.camel@linux.ibm.com>
Date:   Thu, 9 Sep 2021 11:53:14 -0600
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
        "konrad.wilk@oracle.com" <konrad.wilk@oracle.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <B34345FD-38F9-4722-B046-E250ACBD5B8C@oracle.com>
References: <20210907160110.2699645-1-eric.snowberg@oracle.com>
 <20210907160110.2699645-5-eric.snowberg@oracle.com>
 <c5d8d846cd03a97344700f8ce4f038cdc3e3b8fd.camel@linux.ibm.com>
To:     Mimi Zohar <zohar@linux.ibm.com>
X-Mailer: Apple Mail (2.3273)
X-ClientProxiedBy: SA9PR13CA0073.namprd13.prod.outlook.com
 (2603:10b6:806:23::18) To CH2PR10MB4150.namprd10.prod.outlook.com
 (2603:10b6:610:ac::13)
MIME-Version: 1.0
Received: from [IPv6:2606:b400:2001:91:8000::70a] (2606:b400:8024:1010::17c6) by SA9PR13CA0073.namprd13.prod.outlook.com (2603:10b6:806:23::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.8 via Frontend Transport; Thu, 9 Sep 2021 17:53:19 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 51ed3254-1f03-4b13-e6ef-08d973bab87e
X-MS-TrafficTypeDiagnostic: CH0PR10MB4891:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH0PR10MB4891340598CE868B20BA96FE87D59@CH0PR10MB4891.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JTWFJaw5XU4SSTOYWPWTQHYXw4prZxmj9U5bDUvBRxuQVOKwVu8Yd6lIHoZk9KvZzAZSJJAbnO+D8Bi9QmKIc0iMolQPjYZHi5RvVtWAt4weJS86kTWXgMi5NkH4eIJZsmSen62KxFKHxqNDp4Xb4rsb+fc3o+D/jgEOZ0vL2oX/yTlAEtf1JimFbmQOzeldbrAo69sN+ehNlygtQ9YheZ/rSXSZ9SSih1XedA/CZVWeYL6sN4PaBdNm4YSzpYgmoqrFvonbxPYFC+/ZTIL4cmG2rRSez8H78wjVYftGF8SKhJb0kYyyJOC3YqIs2URW5b67YIFuB3tgOwTyfAOE/G9L4LNxlvI1TB5XnYz8vkwrcNdy2+2TTIy4EJMXTL+mjNtWghl7EjRvimnvkv5sIzFvqNfrECAsgeRGp978EHzVV1BI/Oj0s8hMeCk782rKmqpD19KVv2xa0/JUKW7V+54OuzSx9oNHaEKiePNt6PiATaA2VQpQBpeRAAsnY3hBsamXWGHBrivIc9BljoDDwXNg5xJzOUHxjff0uY7bXk1MkqKt53rDfudxwiRrCsKcuHlU/H1sxvQs2qr9wSY7BuigfJW0EPYfV8hWaSY5EyiJ1MScDawwk9C/Co91w5isbDl3bOv1wIg5Bsuy+cAUaiklwFKSXJE90gmExOt9uMdVzEWRR4rY00FRxHk39st01SXm8KVrbxiYjIiA7juy0w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4150.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(8676002)(6666004)(4326008)(2906002)(86362001)(8936002)(186003)(83380400001)(107886003)(38100700002)(5660300002)(36756003)(316002)(7416002)(54906003)(52116002)(53546011)(6486002)(508600001)(44832011)(6916009)(66946007)(66556008)(66476007)(2616005)(33656002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S2pMTkU0VHFTam5WQ2lCNFpzQmNPMUIxVndMa1k2UlNoOU5ZN3hnZ3I1TVVl?=
 =?utf-8?B?ZkRuVGJkZWlNbDJZN2lPVVZ1eS9wVk4xT3Zsb1d6RThORCtFaTdnOHNrTUlG?=
 =?utf-8?B?eXNjMmVaeis5OGoyQVpXN2hVMGRpVXcvTEFFQmtjdXZIYVpWekEvcWlOTkQ5?=
 =?utf-8?B?SitpUFJHck5hcWQ3b0NlSEllamZLamc3Vi9RQ0djTUhOdGpiaUtGZDNMRHY5?=
 =?utf-8?B?dkFkRStxWGw3dlZhNCtIanVrSEVVSWRLNVBqYjZsU1JUZXgvLzNUaVNYK0Rm?=
 =?utf-8?B?ZVpDL1BPLzZQdmFHZDdLWnJWSVFnMWp1cDBTcHN0UVV3aDd6MEQ0cmpJaFk3?=
 =?utf-8?B?cmg3M00yeWcycUtrVTZzK29TU0lTQUdiT3lPa2F0VnRBZkxWZHpnQUpyM3N3?=
 =?utf-8?B?R2hsdDJyQVJ5K2ZkUjAxSWJ6QmlqcWJocmJndlg5ZHJSeHVrWlcvZHJrODlP?=
 =?utf-8?B?Y3RrcllpbkVPY3VoalQ0NTQvUUhiaktvRkpRTC85UVB1VzBKajgvWUV3cVU5?=
 =?utf-8?B?L25ENjQzcUhGT3gvV2pNWXBLRUFzb05TMWdLQyttT0hmQ3NWcWtxd1FBYVBF?=
 =?utf-8?B?ZHkyV3JoVi9YU0E0U0UwREFOc2ZVREpSdzR4ckh5b1FiU0p3ZWNHZG5IZlVu?=
 =?utf-8?B?WlVrVTRCYyszV3lQR1hSZDg0V2sxQk9weHlYWjFYMXFBYWNxVVM0ZlhTdndk?=
 =?utf-8?B?dGR5aVFpcm9aYzZBU2xVVGhoclJkWDFuZjRmMjBscCtrQXhzZTdKbWphOEw1?=
 =?utf-8?B?SFlFVVhHcWdzUE40ZFJubmMzWlNtV0NEakxPNHZFdnp4V2JZRWRHUFBxTktz?=
 =?utf-8?B?OGFOOEZFZUdyZkE0dEoxKzhoYXAwSkMrcEJkc3hDZzZmclBwamRnSWM5VDZ6?=
 =?utf-8?B?cVUzRTVmYzBHWi9DU2VzajVzblNOZ3JDR3lyWXBERVUwWUdYN0VJTElKVTI1?=
 =?utf-8?B?dHVrcWxGSVZsL3o3REthOFFNaG9iVS83d0lONHZuSEpNZHY0Q1M5K3RRRW9R?=
 =?utf-8?B?ck1LVDdHZFpSd3ZPR0Z4MXhFNXNGMStLMEYwS1g0dk9ZUWJEemtNdGJDeTV1?=
 =?utf-8?B?aGkwY0xCZmNlcnhFc3ZvTzYwSzlQNEwraUNsZnB0UE5hdDVUS2M2b0xRL1Rh?=
 =?utf-8?B?cGRmLzduVXVyQ25URkxzSHdiMHVZYVd4Z3Fkd0h4djNjenNVQ0VzNVhOOUNY?=
 =?utf-8?B?RFNaWXo2ejQ4RGthN094UjQwOCtzM0g2TFN4bjdiMGZDMUw5eFBIM0c1TlYz?=
 =?utf-8?B?eXc1VVdVTkxRS3FWVlQ4cGZLSm9QTHJwT2JSQnN3QXUwZVM1TWFWaXI4QUla?=
 =?utf-8?B?RGVPL0NwUkM0d2FLTTlUTGdRY2pFRkhxUDFDN0Y3V3ZlVmRyYUZwZzFvRm9u?=
 =?utf-8?B?TVdpQThUdjZzV0RGT1h1ZWlPUTVkSzcvTk1idUo5bHg1SUtWVG5UVTQxdUto?=
 =?utf-8?B?Tmw0L00xQ0ZUS2tmQ3czU0FXVEh3d3c1YmZVQmNxSXk0UHNCM3hjSnBxZDRt?=
 =?utf-8?B?VFBWcjVINkZxbGVxUWoyVXFjMjlOdTNKZlF3MWsyaWpseFNKM3lrM2tRYUVi?=
 =?utf-8?B?NDJVTG5XdURBRWxoOHp3d0F2b1NPL1ZFbXF0MktNa2xZZCttbVVWcnE0bzh1?=
 =?utf-8?B?V1cwRFZIUmVaMTNDbVY5bTBZNzgzaUtDaWxueHZmM1dXY1BpVUc5NFFmUHB2?=
 =?utf-8?B?ekNlUDdQbmlxODlVWm51YkpDOFFKd3ZWM25lUDhtcUxmU1p3TWErdVdIaHdo?=
 =?utf-8?B?cXo4T3NUTUtoeDBxMUM0MXRyNWd6clhnRE40VU4zMVJTQ3V4T2FsQ2hwMlVl?=
 =?utf-8?B?NDZvT0gyamlnbHJMcDBtUT09?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51ed3254-1f03-4b13-e6ef-08d973bab87e
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4150.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2021 17:53:24.8321
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ofuKxr5YYoOvZ42BcfO5yNsVQ3swveo/yQjfA13EWYf/mvABQWObYXc1uRv/hzP6iGAAGsq+nPLLcD8ph/VPacPMWUSmo8UiIa8JsIhPqls=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB4891
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10102 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0
 malwarescore=0 spamscore=0 mlxscore=0 phishscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109030001 definitions=main-2109090108
X-Proofpoint-GUID: ljiqw82lcF1DmLrhw2ZJz9Q67YneoMAY
X-Proofpoint-ORIG-GUID: ljiqw82lcF1DmLrhw2ZJz9Q67YneoMAY
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


> On Sep 9, 2021, at 11:25 AM, Mimi Zohar <zohar@linux.ibm.com> wrote:
>=20
> On Tue, 2021-09-07 at 12:01 -0400, Eric Snowberg wrote:
>> Set the restriction check for INTEGRITY_KEYRING_MACHINE keys to
>> restrict_link_by_ca.  This will only allow CA keys into the machine
>> keyring.
>>=20
>> Signed-off-by: Eric Snowberg <eric.snowberg@oracle.com>
>=20
> Normally the new function, in this case the restriction, and usage
> should be defined together.  Any reason why 3/12 and 4/12 are two
> separate patches? =20

I split them since they cross subsystems.

> I would squash them together.

But I can squash them together in the next round.

>=20
>> ---
>> v1: Initial version
>> v2: Added !IS_ENABLED(CONFIG_INTEGRITY_TRUSTED_KEYRING check so mok
>>    keyring gets created even when it isn't enabled
>> v3: Rename restrict_link_by_system_trusted_or_ca to restrict_link_by_ca
>> v4: removed unnecessary restriction->check set
>> v5: Rename to machine keyring
>> ---
>> security/integrity/digsig.c | 8 ++++++--
>> 1 file changed, 6 insertions(+), 2 deletions(-)
>>=20
>> diff --git a/security/integrity/digsig.c b/security/integrity/digsig.c
>> index 5a75ac2c4dbe..2b75bbbd9e0e 100644
>> --- a/security/integrity/digsig.c
>> +++ b/security/integrity/digsig.c
>> @@ -132,14 +132,18 @@ int __init integrity_init_keyring(const unsigned i=
nt id)
>> 		goto out;
>> 	}
>>=20
>> -	if (!IS_ENABLED(CONFIG_INTEGRITY_TRUSTED_KEYRING))
>> +	if (!IS_ENABLED(CONFIG_INTEGRITY_TRUSTED_KEYRING) && id !=3D INTEGRITY=
_KEYRING_MACHINE)
>=20
> Over 80 chars, please split the line

I thought the 80 char limit was relaxed?  But if it hasn=E2=80=99t
I can change this too.  Thanks.



