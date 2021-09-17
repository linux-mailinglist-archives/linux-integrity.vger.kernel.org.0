Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FAE840EF10
	for <lists+linux-integrity@lfdr.de>; Fri, 17 Sep 2021 04:01:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242598AbhIQCDP (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 16 Sep 2021 22:03:15 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:65532 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242509AbhIQCDO (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 16 Sep 2021 22:03:14 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18H0S2GN012125;
        Fri, 17 Sep 2021 02:01:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 subject : from : in-reply-to : date : cc : content-transfer-encoding :
 message-id : references : to : mime-version; s=corp-2021-07-09;
 bh=K0gW9Y7ZDjkOw0I8Yq9tYju1kSfK9eh3rVZbYyaIIrk=;
 b=OR+uYs/UiyJG9hv2uZhfbRnbhCHztiFa0IZfC3xme/hNAFIGW0fYla/mIQb7S2lkheR5
 P0K3dYFCPVKiqgG602ZQSWTbTS3rPgHUF4q0Ik7nvvQMswEQjmT/r+FhQ4iNvqGgVNgx
 +NLA7ldlQe3KqpjypkZgPXBi8CO2pnC0NflsY0Osph8g2ozRpFSTGCGHAChJW+N6cHt1
 kbh5mBWu/90T0+XU807H2QF6eQMcWhOqmoyH6C/KaU2upaSHk1LCA7Z+Wr0B4k8gZZ6Z
 W+lerrPMwzQGqA02jeeEHakFJrTyvLRMVqut/AozyuF1HTQfkqMkXFeUVgRMJlbf8TYA mg== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 subject : from : in-reply-to : date : cc : content-transfer-encoding :
 message-id : references : to : mime-version; s=corp-2020-01-29;
 bh=K0gW9Y7ZDjkOw0I8Yq9tYju1kSfK9eh3rVZbYyaIIrk=;
 b=p8p04RSct+00EahhPVH94o5qlSlKDoo7RXB1DPLccUKzGZYRhidJ80TXnsylh6fJjDZx
 /rW5BA3MEXQkXuz4lfqSYf6WPBd1VYUuzIO4tPn6yUptU1xqSJ2tvwHQxd2fS04GiHTS
 5/RvNz/iusaNarrHfquF5xWQQdTtmGSTqV1eGUEaKMTDabvECCr6BHGzzYcz3QfVd4e7
 bwDz9q7uNQkPXg8FAO+MIFkhKd35BBTDxN1bPmNgmc5Gb31W6J1VkcEmyjMnUrSy+vMX
 T1I+elga4QfElv3AOCBvyWYgvTNvEUR/JiOHu//IKzFc6MAGZJF9Ktvw3XVbzeg8e+WQ pQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3b3vj147dj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 Sep 2021 02:01:29 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 18H21Kbe025374;
        Fri, 17 Sep 2021 02:01:28 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2172.outbound.protection.outlook.com [104.47.55.172])
        by userp3030.oracle.com with ESMTP id 3b0hk03yj8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 Sep 2021 02:01:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mF1MoW2QY32lNZoUg5en5rZTmUh2h6+u5QwoZc1eFgWLQGAiDI5W4txMpbtGvXYUp/aykuOk5YY1gS8wXKvoZbGP5dDIsOUfKI5Q08nN0S8iMz2BXQ4Ytl80YREQ9+1CdYtk2eKUAZoxCcdyJSkCKthb+41Mrie3MPKm5Ta5NsaSsHlQ01ZdAeQfsCoNzPz0kRkz4IWYb2jegXYOjk/5xXFzBq4XpC7lkgEvKa9qiAQtm3nVYSvi7WPdgEaxuefI3y3Rq0QAxmIDQFJNEa7gWLZZd8/Mq6gVu2QAlxkUSvstW82IB8Q5Zn19xAgkJbEXKX7Eh+WFFnebD8iou1oQkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=K0gW9Y7ZDjkOw0I8Yq9tYju1kSfK9eh3rVZbYyaIIrk=;
 b=FQ5MMO4IwBULD4TdMYfyc7/f4EisKL3oDOoyD83bi57u3wed3gBlH7oVSNrDMcYxAdNUdQ8t8hLneFsQxEj5+XOSVl3aqL9suQBJWE6LIu2Lz4dRWxih01xIKscXpJk/igNUNjw7nb++CiYd80aZiWAOp0NXTyrDCjiS+Rl27nc//qlZnW8qL/nVRIqtCOKwkyfVpEbK3ueAwck79jUClNXBGXjINh1QlYzCZj2ZIgquSR2O3RDYSxjL6A8PQoqomLGx/3e72bvITxnDedBkj7E+Bn2eXEvKmckWOA3FpA3MxnwNjT7+jMExViiTySJBKp6pReP5hxMqZUm6sntMlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K0gW9Y7ZDjkOw0I8Yq9tYju1kSfK9eh3rVZbYyaIIrk=;
 b=HE6M7kNF8/qK7RMyTPCdP35cBuUhvgoc5aAqSWIw2XZvsej9TnuTQ9ewIYXBIAlD1RUNsvEy+2V37xB8U7L4i5OOzOl4cO0TQ6GryRWVdGK9Axq35yG6jQxfzKY85TDvtMezC6wYW9pKvAeyzqU2SodWFRD9L61zvwM6zKwf+ks=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=oracle.com;
Received: from CH2PR10MB4150.namprd10.prod.outlook.com (2603:10b6:610:ac::13)
 by CH0PR10MB5321.namprd10.prod.outlook.com (2603:10b6:610:c9::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14; Fri, 17 Sep
 2021 02:01:06 +0000
Received: from CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::340c:c4d9:1efa:5bc7]) by CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::340c:c4d9:1efa:5bc7%8]) with mapi id 15.20.4523.016; Fri, 17 Sep 2021
 02:01:06 +0000
Content-Type: text/plain; charset=utf-8
Subject: Re: [PATCH v6 12/13] integrity: Trust MOK keys if MokListTrustedRT
 found
From:   Eric Snowberg <eric.snowberg@oracle.com>
In-Reply-To: <20210916221922.xjplaobua2iss2bn@redhat.com>
Date:   Thu, 16 Sep 2021 20:00:54 -0600
Cc:     keyrings@vger.kernel.org,
        linux-integrity <linux-integrity@vger.kernel.org>,
        Mimi Zohar <zohar@linux.ibm.com>,
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
        James.Bottomley@HansenPartnership.com,
        "konrad.wilk@oracle.com" <konrad.wilk@oracle.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <9C5B2B68-5F03-472F-8B17-E0A716C85CF2@oracle.com>
References: <20210914211416.34096-1-eric.snowberg@oracle.com>
 <20210914211416.34096-13-eric.snowberg@oracle.com>
 <20210916221922.xjplaobua2iss2bn@redhat.com>
To:     Peter Jones <pjones@redhat.com>
X-Mailer: Apple Mail (2.3273)
X-ClientProxiedBy: BYAPR21CA0004.namprd21.prod.outlook.com
 (2603:10b6:a03:114::14) To CH2PR10MB4150.namprd10.prod.outlook.com
 (2603:10b6:610:ac::13)
MIME-Version: 1.0
Received: from [IPv6:2606:b400:2001:92:8000::a1d] (2606:b400:8024:1010::17c6) by BYAPR21CA0004.namprd21.prod.outlook.com (2603:10b6:a03:114::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.8 via Frontend Transport; Fri, 17 Sep 2021 02:00:59 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 86e51c84-2f35-4835-d201-08d9797f0254
X-MS-TrafficTypeDiagnostic: CH0PR10MB5321:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH0PR10MB5321F5A7E421681976E60F3D87DD9@CH0PR10MB5321.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wClnQPQGFscObLvglSTJE8TveNY0DvBg8qMQvk+G1cOBAebhSy0Q2iMn5EyAkp9lntb7/y1hkahvYM5lZEcrxrXsR9y3CamBKjYTGKuG/rzM7/CmgKCHY7L/Xrp9hjpjgjBGx7viOv51V8slJjGTr4OXvKyVOoKAhJ110oSSXP5nrmscOWNr3/MW91T+IZ991qbGYz1CaFg6S5mtnx0kYpIIuv4bccweSrKovtS6nHC0Ken2Ykk6STLo14g1mkrKpv/Zc7kPBFt36vtqgNPfWruczSB+A7CmR0B6FXYZBY9HCcVPx5R2g0QQA4bqB821xSUwgnboCzR8qmzBBdVpeeUO3D/s7Xh2Ms90chgFVxZwLZRgfdnbPwNYRHV3Y+TLSaXoZ0JVXZoBIVwmKi4cDUD6GwOeLC10K2uFxI7E16PtmjJJ4aBT7kPKuFr2IfjoH91iDj1XVVe0cGKCgDVg1HP7iPBh1P/hdDmUiOq0qyzZqG+yIZgq3YpGUzi2x6c22nQBgN0kOBpTSS9nYmrQRbpsMCjYD7/bnrefSpe9KUzK9dGvotJLjDfoqRQXrzpttOeqr68WEQGPpgrlFExeF038zTEqQlleCihF8nppxd8pmrYW72wNSiIlIzP/xskP/eqztWE7QFdOpdm1DNBZMy7CdO3QKOMGHocDy2qV8SYSYcMtSkhsC5x57bLgC+vLAhdF9WWtl3jXEMSXbtakJg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4150.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(66946007)(66476007)(66556008)(6666004)(2616005)(107886003)(6916009)(53546011)(83380400001)(7416002)(86362001)(316002)(54906003)(5660300002)(38100700002)(6486002)(4326008)(44832011)(36756003)(33656002)(8936002)(52116002)(2906002)(508600001)(186003)(8676002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bGkrUmpRQyt4NlNoMFFNaVNtOHRjclB5dHRTajhIclo2aVdtSkduVnJaZngx?=
 =?utf-8?B?YnEzSmRvQTR1YW1PMzVYVHcwOXkwWksyZWZPaU5VaWZnekk3SVU4VkFKRC95?=
 =?utf-8?B?a3k3TFNTWU1WTzd6MzVrVUYzZXpBcm5BT3AzQmNBSWtlVS9IQkxvUkQ5TlZT?=
 =?utf-8?B?dExNQ2pyT0lnKzgvdkRkbWt2WWNlRE1Nak8rRm1MTTVtaEZnZnFVZVUvNGYr?=
 =?utf-8?B?bEk1TUZacnVjSTFQRmxqV0NLdWwyYmkwenl2SkxsRWpNRjljMXRQbWREL0Yy?=
 =?utf-8?B?TVc2Yy9oSVJJdXRtVTBzL2pWaU5HSTIxVzBEczdwMVpHQjJVOG9IQkU4dnBs?=
 =?utf-8?B?UVEwSGtWTDJ6ZnVad1ZvRENVNCtJKzhtUEhLYWY3YThSUzZDV2lkcXRVWjJr?=
 =?utf-8?B?N2xaYTFsTitBNzJTMWlUTzVzVWFVMjhKNlB5UHVTbkFNWkJXRlhrZEZlZ3Nr?=
 =?utf-8?B?bGtWTHBibVRHam1tZG1UN0dYUjRSdHpHb0lwMDFCME56K0hFSTNrVmpDcmlQ?=
 =?utf-8?B?bEZaNkFOa2F6ajB2d2FKejhZSDF2a29UUEhjTEVMWmVmOFdudkFYOVJ2MXBu?=
 =?utf-8?B?TEwzQXZHbFhWWUZHRzYzWU5Ud2Q4QmY1YW91WDUzMWlESmg1UGpWcXNqL1h2?=
 =?utf-8?B?aXNpdVhyUnJJdXJSZE1YTk9iNnk5Z3V6RW9uOVg5bzJKYWpFdHpaWU43UnNy?=
 =?utf-8?B?ZFR5RG9PVkRqMGdIeWw3dWxSSDkxbmZveVl4dXNUelllTnlienlGOFFKMVo2?=
 =?utf-8?B?VkRVOWpIQ0wranZVQllWR3IvRmg4b1U2eFlHR3FrVTFLVi9MaFZGM1hJeTdo?=
 =?utf-8?B?dTV5QVBiY0pCVlpXK25ETFdrblRRKzR1RjNmbkxNdzBKdnVjQzFPMjVJVGdk?=
 =?utf-8?B?Z00yakVLcitlVXNnWFBTTDZpZC8yOVRJcDM2VG1tbHRVL01CMVNPNHpEM25L?=
 =?utf-8?B?N3hIMzFXMDBJL0FscEQ0Nm5WbXhrUk84QXB4b2dRdndxcldOZFYzcXBWVExk?=
 =?utf-8?B?S0xLYWRJeWoyQXZPd1I1OElVdnZ2WUplTTVkSDNOL2RiZjc4dzE5TFF3RTdY?=
 =?utf-8?B?aUtUdHdMdnN6dVR5VFV0eWVySU9GVzI3cHp0V25INjJwYkRiWndET3JRa2pX?=
 =?utf-8?B?VlB3dHA0c2pRYTNzUUN2RkZkUUo1aUhVV05tbWwwSWg5aG52WDNMTHBDMHRx?=
 =?utf-8?B?QXR4akR3emFreWptVlcyamtsVWVNR0orWGQrUDFScFVSenE0YmcvY1o2cEhB?=
 =?utf-8?B?U1JiRjMreDlzY1pxeVZwL01naG0yQjc0ZlpVTE5jck5zTSszNU9IeFovY0xm?=
 =?utf-8?B?MGsxcGNhRHgza0ZVWkhSeExQQm9jTzdWdXlCekg4K0gwSVBZVU5nRjQvU0FZ?=
 =?utf-8?B?d1drbDg3ZFFHK2x3K2grVk5XaWI3TzNnV1lkNEg1cFozZFV1OEp1RnE1c1pD?=
 =?utf-8?B?eEZ4TXphNDBOUzFVL1NubkVGYWFtKzFUZEVQNzFWeitWZ2xrdzUzdWdhZmlu?=
 =?utf-8?B?YUxHbDUxeklra3RpZ3VSTTZVcUdlUEZFVnhQdHIyMGkvM1VMdk9vRU1UeGlo?=
 =?utf-8?B?amJPN2hJQ0NzVlpxL3ltemR6Y0RvdWhSR0RZVVd4VmdGdnVMd1lRT3orS3Yr?=
 =?utf-8?B?T3c2d2h2RWtoU01TSkdnZU9oOUt2M0JUMGRrZ2theXpWK2dES09JU0lBUWJU?=
 =?utf-8?B?SERocEg5bUxTeFR5cXRwaGdNSjd2M2k4QjR1TlB4aW10QXZIWnEzeEFsOVVE?=
 =?utf-8?B?TFJ6d2pCL1RCUEQ0S3MwelpHb0FLV3ZUNmgzQXpnUjZUT0kzWFVnMDdYQkJH?=
 =?utf-8?B?cFF6TFcwSm1Lc1dNcWlYUT09?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86e51c84-2f35-4835-d201-08d9797f0254
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4150.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2021 02:01:05.8308
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FnSMqIC/VarL7gL4E9IWM8+24s/6JjACmv4OtTG+Y5wNhcfPCGkdCxEX2riJDbPChEdbFm0NEu7PxS5Y8Wfihn0pk+9fpZwB+91rLcEUwhU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5321
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10109 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 phishscore=0
 mlxlogscore=999 suspectscore=0 spamscore=0 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109030001
 definitions=main-2109170011
X-Proofpoint-ORIG-GUID: r0hMA5mmmxVxzC8kiyherf1KjcOUirbb
X-Proofpoint-GUID: r0hMA5mmmxVxzC8kiyherf1KjcOUirbb
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


> On Sep 16, 2021, at 4:19 PM, Peter Jones <pjones@redhat.com> wrote:
>=20
> On Tue, Sep 14, 2021 at 05:14:15PM -0400, Eric Snowberg wrote:
>> +/*
>> + * Try to load the MokListTrustedRT UEFI variable to see if we should t=
rust
>> + * the mok keys within the kernel. It is not an error if this variable
>> + * does not exist.  If it does not exist, mok keys should not be truste=
d
>> + * within the machine keyring.
>> + */
>> +static __init bool uefi_check_trust_mok_keys(void)
>> +{
>> +	efi_status_t status;
>> +	unsigned int mtrust =3D 0;
>> +	unsigned long size =3D sizeof(mtrust);
>> +	efi_guid_t guid =3D EFI_SHIM_LOCK_GUID;
>> +	u32 attr;
>> +
>> +	status =3D efi.get_variable(L"MokListTrustedRT", &guid, &attr, &size, =
&mtrust);
>=20
> This should use efi_mokvar_entry_find("MokListTrustedRT") instead,
> similar to how load_moklist_certs() does.  It's a *much* more reliable
> mechanism.  We don't even need to fall back to checking for the
> variable, as any version of shim that populates this supports the config
> table method.

I=E2=80=99ll change this in v7, thanks.

