Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C23C3FBB24
	for <lists+linux-integrity@lfdr.de>; Mon, 30 Aug 2021 19:41:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238263AbhH3Rlq (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 30 Aug 2021 13:41:46 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:3160 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238247AbhH3Rlp (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 30 Aug 2021 13:41:45 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 17UGhbAV019528;
        Mon, 30 Aug 2021 17:40:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 subject : from : in-reply-to : date : cc : content-transfer-encoding :
 message-id : references : to : mime-version; s=corp-2021-07-09;
 bh=wIwK4BR3I48F0fiFMkaf/e5RWAgJLQB6QYF/3GYy8zc=;
 b=Jh6NvgTKzGpPa93CypgEjRd3mMFVPzUSkkkqrnM7aDfE3MmMhYD04h8MGztgycX+xqVT
 mFVFcA2uJR9bxHoj85/N6wrEUrzkMIOBgI0hKru2NShLvuEW/7Dt5CWKHTZaF9cNdAbW
 cxOegdcy2LUhowdYfpPgj/8q9rKmt0FjqpLdx3aOCZOkx5mP97NZ747Yi7pAfnUr94eL
 HObSvm5Gii2ST7N44gu8lkw30Wgee0EWGIV/5t9GAtf/4VGCknW2h5YODVkI2uo3qTlP
 0uUfgNWLexlcrz4xg3F/HdtviSZvbmoWKsBbkMtqkrr1mY3FpxIoGPbnvmIl5A3y6ZHO BQ== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 subject : from : in-reply-to : date : cc : content-transfer-encoding :
 message-id : references : to : mime-version; s=corp-2020-01-29;
 bh=wIwK4BR3I48F0fiFMkaf/e5RWAgJLQB6QYF/3GYy8zc=;
 b=anKHZnnCCs0KYlnERYRIjh4b7/2qqMQA884U7E4OGWfvr5Nmdyv4pm+nZECcWZvztyXp
 fjAQ1L4mklZLYoySJNqw3ZMg4VWI14wpzrLM1PiX/1KFjLiWUTnmxEpMBuxksCnIqYRy
 s/msrS7dj6HCPUxACmZmzRd3ONwW9aigTGjyK7nWpuGLJSTXz2DxVA/CgsD9l4qpcSmq
 SGkpfvPAXwl18di2jCBEdtTPn81nC79XsQYQDEaNo9y1G3LPPgoYNBrq75S7vqglWqlv
 3BHt7i5YZhWc2vksAjkQY8PIESEu/VSLVbtvdJ/PXx8yWPvVUGHUXLE/hHMyPWnMtYOL yg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3arc1a28rf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 30 Aug 2021 17:40:08 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17UHQSlY115612;
        Mon, 30 Aug 2021 17:40:07 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
        by userp3030.oracle.com with ESMTP id 3arpf2qqmw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 30 Aug 2021 17:40:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=doX/O6AWgNuOnTifMWI4LxJ2D7yi0PdRjAU6FrvWjfGGD+bZvbtmxz/J9VLoG+1TQrwPQjXaJC2t3ss+Ajet/imkX1f92mFCJuL1EcQ6sEP9zzA5m0iKoQskxN+N5Q8W8PUJhdReHr4uQjb+vIVn7HqHJqqFUTpyMsuXBhwHYV9EG3EEdTXqAu1v0v30XgpcXinaMZOGPO4iFXcX5Vq0X/DuKSQ6HjF1LOaA+pnwbGSm5tujOLEF+psGej5JvCNapSy3HEkHDibGEoW/Rd0gvnwoVoVeLA0DhUtS2a0U5xC64ReVIyL2l8IYNbnbC/44WuCp4UsrfuCeKgkvfQMPYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wIwK4BR3I48F0fiFMkaf/e5RWAgJLQB6QYF/3GYy8zc=;
 b=hMxLeF0OzkIQpJmftirZQKYBZwfbZMspX2iCiEWOm0/ZIn4Zb64yL0bDYhgHYHn/EvFafCcEjsBDR/1gwlcFgpean4Ll2zthS8Px7Rp4dAS6Dho7aJlQQWfNkNyDlPgeWYkeqzo0RFtZFYkoXiTc3c1xQYt56NHERRG9lNGtKxUK38SfgkryHL9IFVipj/4TRkcXm9h9Llh4Q4ZDx7rynrn5n+0UUatbcBcyHwT6/K0+Bk0ooaqcJvrD8lPnjXG4+WelO91XZlkdwc3w3XLXXGG/c8QswFkq+5wmXINNCm42WjWo0bxR2iq2XZs+zYj6mnWsVp49ppJ9RxZSazayxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wIwK4BR3I48F0fiFMkaf/e5RWAgJLQB6QYF/3GYy8zc=;
 b=W/0xc7HbR85vntg55a1TB5dULnkSFIOwRN7jXSOogK9V/hazggEMZ9KvUHBJ82G95ri7nQ64LtaOoLhD1YvBZYK4PGNP3OvdeUT7wnsYvfRj4k/ODrl4P3mxDMZRYsufCkxY2//GSYDXKt9aKos6+m3S4+4EFPMkUsqzDonXekQ=
Authentication-Results: linux.vnet.ibm.com; dkim=none (message not signed)
 header.d=none;linux.vnet.ibm.com; dmarc=none action=none
 header.from=oracle.com;
Received: from CH2PR10MB4150.namprd10.prod.outlook.com (2603:10b6:610:ac::13)
 by CH0PR10MB5115.namprd10.prod.outlook.com (2603:10b6:610:c4::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.20; Mon, 30 Aug
 2021 17:40:02 +0000
Received: from CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::340c:c4d9:1efa:5bc7]) by CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::340c:c4d9:1efa:5bc7%6]) with mapi id 15.20.4457.024; Mon, 30 Aug 2021
 17:40:02 +0000
Content-Type: text/plain; charset=utf-8
Subject: Re: [PATCH v4 00/12] Enroll kernel keys thru MOK
From:   Eric Snowberg <eric.snowberg@oracle.com>
In-Reply-To: <10bc1017-2b45-43f3-ad91-d09310b24c2c@linux.vnet.ibm.com>
Date:   Mon, 30 Aug 2021 11:39:49 -0600
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
Message-Id: <D07DE64F-FE8B-4020-8EC2-94C3C0F9920A@oracle.com>
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
To:     Nayna <nayna@linux.vnet.ibm.com>, Mimi Zohar <zohar@linux.ibm.com>
X-Mailer: Apple Mail (2.3273)
X-ClientProxiedBy: BYAPR05CA0092.namprd05.prod.outlook.com
 (2603:10b6:a03:e0::33) To CH2PR10MB4150.namprd10.prod.outlook.com
 (2603:10b6:610:ac::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2606:b400:2001:91:8000::f0] (2606:b400:8024:1010::17c6) by BYAPR05CA0092.namprd05.prod.outlook.com (2603:10b6:a03:e0::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.10 via Frontend Transport; Mon, 30 Aug 2021 17:39:55 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3092e5d4-40ac-4526-59d6-08d96bdd31ab
X-MS-TrafficTypeDiagnostic: CH0PR10MB5115:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH0PR10MB5115245DF52E4A2A75A1D3E287CB9@CH0PR10MB5115.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OVu3Y23GaXBwwQWTQoYFgArpf7EsRW0hg0VcOsxchY5kGs/shqvKHb+cUw0rTgACsVofYFXKDs63aDHdkUfxXkt90YZ0ykFu6iMhlGn48FYiiMs9KCE3MvtXoPWMaueM8B4HEZfjsHZINVaFxojCPt2xdYr/1hk2cMcwTDZbDA+GSCvxjWEkOuzPLGZCCAPW1zfd7hEz9VChaTXVN98Inhgk1YM/4YvM7isFyreg/6oRx+ibC5jw2zHewDWeuSW7pd0ZuEXDl5owHhRC4IJTwDX3tKk9YpVpXEgBkN8+uqRgAirtxkmohN5UnuaiKlUyrMg01/G8thbVyCkwQwEjxW69Vb2MwDEFapydDUjMU9tTfgS33wuY2sFJ0HcD7AthYYyj9Hh5McytT/T8EG/+hXo886I7Q72iTL4AeLjQU29uhaeMxZHeHix4lSxYULTPTe6iS4ZobdYS4vOWUXQChwhTjSB7RgcAZXjN27BKVRAQDWTr1f4x3W7/NAoaE/XhfXcOEx2bC5JGptagt0EqdweHYVImruFAoAdjGFRnLnr0wWvbxkbfuXWfXiqAt8WC9AKAm8pJD9dg/wXIQFXhf5j+ydzkf+UffPBbztldKGX1Y+XJ5cu3yiC7vQhMSsOvItPLY3y0E0BP2jeL0LaycXj0TyxWlWizJE3c5lQexRScmjLKJspTicmFRVXrtJdhZ3pppjGoBbxmLC11l0mRyQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4150.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(33656002)(52116002)(7416002)(186003)(6666004)(36756003)(44832011)(53546011)(8676002)(508600001)(38100700002)(6486002)(8936002)(83380400001)(316002)(86362001)(66556008)(66476007)(110136005)(5660300002)(54906003)(2906002)(2616005)(4326008)(66946007)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M05EUFBwaWNWak1mTTh1VE5WZzR5M3UxMVV2bjV3MEcyZGxQU3pjWmdLYnJa?=
 =?utf-8?B?cTg4V2tFcC93cU9mclF1L1hHK3BHVEJxN3ZsVy8zeDVrbXJHSkVUczRnVDR0?=
 =?utf-8?B?RWRYL3l6SzFQUVNBanBEUTc2TEQrY2RTeUpOcE9SbEc5Z0l2aHo3dFY5bTR4?=
 =?utf-8?B?bkFZZ1djL1JtSU9STjVIZkRCQ1c0QzF1S3EwanFQSDh5WGpWTTRQN2NQaEs5?=
 =?utf-8?B?MDNyZ290VWpNWGRXRUczUE9ZWFR4aldHWmFsOGN4Rkl3dW5MeHhTQ2Y1enRL?=
 =?utf-8?B?N3Z2Q3JiZFUrVnc1OG5XY25ZUWVIbSszVzhqdW9ZYVJ3Z1ArS0tzWFJWQ0ZY?=
 =?utf-8?B?elF4bTkvcGw0cysrUmhQUm02MXdiaG83dVRuS3gxQUZCNzhWUTkyL09JMHhE?=
 =?utf-8?B?dHhzOVRFUXFqZFcrVytqd1ozS0lkRGorRlRqRVJuTkwvejUybU9oVHJza0g0?=
 =?utf-8?B?aG0zbkJFSFRMYVdleW9yN2RzN0I1Qkw2Q0RLWG1PRzYrRC92MjBtWkIvdHZo?=
 =?utf-8?B?NDcxd0dQNmd6TWdYQ0VmS3QwUHNiQ0hVdEFmMGFlK1I0QmFyN2QrQitYdTZh?=
 =?utf-8?B?SDkyKzgzcXVjNldEZFFDVDJGdUFXYmpTUFlJeHFreFU1R2RlOHZrZWxkL1hH?=
 =?utf-8?B?RVpxRkNmSk9HcTJqVXRVYTFuNEkwUE1GckhzbXhQcWVQMWphQlZEYkZFelRh?=
 =?utf-8?B?dnNDc0h6YkgyUDA5aWhJczdLN1cyV3lVMUZOUmhVcDVOSlZRVTRERGk3MTBh?=
 =?utf-8?B?N2xrOFVibkhrYWxvakRYZER0WG10ZCtSMTVrSysrUlY1ZVZSbXV4dGZWQlg3?=
 =?utf-8?B?elhJTEdXSUVnRjVEWUFZVDBNYWtoRWxkWXB5N3h1N08wNlM5am5JT1JqZTEr?=
 =?utf-8?B?c1YxMTRMMDh0RFlxWVpoSjV0eGVuRXltYVBuMmk3VWZveWN4LytFSHRPcjBp?=
 =?utf-8?B?TTkvbDZ5L291MW40SVZtQWZMMkJWcTNBRW1iVzBuMjd3Y3k1RTBzbjJzTEZs?=
 =?utf-8?B?Qkh4ZXBtM29ZWFJhdEdSYm1Cc2Z5ZTZSRkZoTnZ3TXR0aVJQeGZFS3JGeUhW?=
 =?utf-8?B?SFdZUVp3N29lcXdqdm9VTDVKYmJ5bnh1dmVibGxvZFFkTWtOSHl2UmN6QWNF?=
 =?utf-8?B?VXpnTkx4WDhiOHFQWFM2a0RlUEZtWlFYeFkrYW5La3RYN2NVT0VZNWJSMHU2?=
 =?utf-8?B?bHBrM3JReGpJeDU1WkxqWEo3VHowS2NScTBUWE55eXdTMDNBOUFoMUc1R1J5?=
 =?utf-8?B?THhUYzEwNlhvTWxJcGh1Y0xZR205ZXdkN3g0RzBNYjZDVkJ5MVFJM0JQWTdB?=
 =?utf-8?B?TzhtcXptL2d4WnYrM2R0VFAxRjZQOVdtSGZBbTkzWjVKbS9GbXNtWmc3MGw4?=
 =?utf-8?B?eUt6OGJjZU9SNHQvNUdHZEUzcEsvcTM0cUxOc05RL0xoVDV5R0RPbDRzUW9Z?=
 =?utf-8?B?T09qZHBJRTh0YmFNNEg5V1J4OTQzdkpCNklwcGx1NjNzMmh5K1o5MXpMQzVh?=
 =?utf-8?B?eU5zRU1HSmUyeVhrWGYwYXJIWnRLZDFuUGNncFNqalRUOWNpU1pUck5BM1Bq?=
 =?utf-8?B?TjRMbksxNkpuL25iY2oyeENzRnVWT0pxTmpsaFJGbG9Ma1kreWFmMm9GWEgz?=
 =?utf-8?B?bUYwNzFlNmszVzlmU1NFU1poVkZuRnZWd0dyYzVUdVhVbUVLcTZiTHMwS1FU?=
 =?utf-8?B?NkN4MGpDZkRuQmZIMVBUMkZUVUVBVUVXU0E3dkgzdTJ2aEJ3bUh5V01oYlBG?=
 =?utf-8?B?VTBMdzhTOHhoemkwMWdLQVJPei91NjhLeGJ1cGxNdHVydkN5UWdnMElOY3JX?=
 =?utf-8?B?SXdCSlgzcmFIaGlQMkF5dz09?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3092e5d4-40ac-4526-59d6-08d96bdd31ab
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4150.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2021 17:40:01.8408
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CZm+o5ipU4GcwVd3cRiMGNrd04QhK8GM6q13U7P/9RFhpxzC/dxMtW46IzJ4Tm2Hjnfd8/TnP9qMm760gP2FXIkZu0nPZ/XjfqEAvge5ZIk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5115
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10092 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 phishscore=0
 spamscore=0 mlxlogscore=999 adultscore=0 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108300118
X-Proofpoint-GUID: 1Dh3sSc4eXh-bXHUFBlU0ZMLaaZbuV_6
X-Proofpoint-ORIG-GUID: 1Dh3sSc4eXh-bXHUFBlU0ZMLaaZbuV_6
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


> On Aug 27, 2021, at 2:44 PM, Nayna <nayna@linux.vnet.ibm.com> wrote:
> On 8/25/21 6:27 PM, James Bottomley wrote:
>>=20
>> Remember, a CA cert is a self signed cert with the CA:TRUE basic
>> constraint.  Pretty much no secure boot key satisfies this (secure boot
>> chose deliberately NOT to use CA certificates, so they're all some type
>> of intermediate or leaf), so the design seems to be only to pick out
>> the CA certificates you put in the MOK keyring.  Adding the _ca suffix
>> may deflect some of the "why aren't all my MOK certificates in the
>> keyring" emails ...
>=20
>=20
> My understanding is the .system_ca keyring should not be restricted only
> to self-signed CAs (Root CA). Any cert that can qualify as Root or
> Intermediate CA with Basic Constraints CA:TRUE should be allowed. In
> fact, the intermediate CA certificates closest to the leaf nodes would be
> best.

With an intermediate containing CA:TRUE, the intermediate cert would not=20
be self signed. Just for my clarification, does this mean I should remove
the check that validates if it is self signed and instead somehow check if=
=20
the CA flag is set?  Wouldn=E2=80=99t this potentially allow improperly sig=
ned certs=20
into this new keyring?

