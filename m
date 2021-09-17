Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF78F40EEF4
	for <lists+linux-integrity@lfdr.de>; Fri, 17 Sep 2021 03:55:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242482AbhIQB5N (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 16 Sep 2021 21:57:13 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:36192 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230135AbhIQB5M (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 16 Sep 2021 21:57:12 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18H0mEgM026739;
        Fri, 17 Sep 2021 01:55:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 subject : from : in-reply-to : date : cc : content-transfer-encoding :
 message-id : references : to : mime-version; s=corp-2021-07-09;
 bh=L8eenIjXgbCAfKm3fDxvVkZxRuSiwT5PUAfJFdXaCNA=;
 b=f8IlWhww9iKt5dpbLI3S/KysoYlFbl1wNatwV+iVzeTf6RSUupeMQIFPmceprcu9R1qy
 WXf9I7iKDixeQLB1Bugc/IQtb4nVANolwevdhrds8b9ownQiG+yIFZXJAANbvhhdef0f
 PAzqXamJmhIBLJSOdDtg8yfQQClPBZsxXVtD3VTZgbrqvlThO5TQEzKq6RkkE56taGEh
 6ovwR9xOIvm7E8syaALreCs8LeOfYoG5jo+JMhpkjQM7H6xzwm63nG/wx8P26BEZIq0N
 pwB/ZApoUsB9eHUsL6VINJ8WlsbMcUieaqyr4zc+Bwc9kS62wJoOKmRinpCIrqueephl tw== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 subject : from : in-reply-to : date : cc : content-transfer-encoding :
 message-id : references : to : mime-version; s=corp-2020-01-29;
 bh=L8eenIjXgbCAfKm3fDxvVkZxRuSiwT5PUAfJFdXaCNA=;
 b=hu/sweQeMjqiP+SZb9B2gIBhkbuXKGryzZKfjBUDEjRwHR6ZtaBkbcIxqmtPrZP8LLm0
 Y4B7r7vGM5KgrHVoOQyBQJ6I1AkyhOeeOEnCd3FTtcq+qxXMJupFFzhsEF1AiGMLt1vk
 Nu1u4/z5r/E2exEb4efQgBv0DjZD+Sqm7ZzJA58kBtAvHE2dtyqICIe7trklRZ0uncu/
 iX/9CLnQCoS48dCqwXDNEmD5oKRJP9SKjTLI9wja8KpXqc8566wlX+pGmGyNChbRaKYQ
 crjXCrzEIV4FdU7/XEdORzqif+V/2s/C0rUW3jJ6ED0XJyW5sSpOvkYef9OBGHfXCTk2 Jg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3b3jy7nsw4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 Sep 2021 01:55:14 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 18H1oem5195670;
        Fri, 17 Sep 2021 01:55:14 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2176.outbound.protection.outlook.com [104.47.57.176])
        by aserp3030.oracle.com with ESMTP id 3b0jggypsh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 Sep 2021 01:55:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j+s/vIBrzogcWQSh7kOrurCTlhBui3l7M6jIR+w9mDQBh0qiSzR02AXrlU1b9rAoRb3ki55GJ2kaL/td3Wni6t2YNG3sWmrrUEt7oWvbxce9mtB2+KdxQIPe3EmdKqqtzg+n1QXC+ibwW7oPy3Cgty097PXFW3eRr9YUGLBFY4JlujbfF7Cu6PUB2R8FKmwp8E5poHj2qxHC23GKceDVk5n0IahqeKL6a34b2SGgwK0BNe+AHBY64tGli80asqVmNqN4tVJ6wSiA1WGFjWtgtGje36DW4t7+sKvSYrTGD7bV/2iqoD++HPu0p3NcHMrrvrN6JHaHIWP4IkJs20UNCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=L8eenIjXgbCAfKm3fDxvVkZxRuSiwT5PUAfJFdXaCNA=;
 b=CY8e7uyTNJc6niRqussPXZOfRKnlO6U8NNp0qqbiGdNvKnq8lGlRyVqCb7vv+JYAm9NNUAdtu69vbAppmA0LH0DmgNdB26Wr+HdI09D7GQTXyIzpc/He/gy/r1cIOYzrYdln86r1bQ56LQeJNStXSTjjwFf7+8t6FRWPC7xh6YgxPAMJCOhw6iMBHi6ivRsMa9Rupm1XrteMSi2T9G3ikHkjQ+2QDtaNnb+3rxDvWUtl2mFSWRG0hrQFlrDC2CAkJxIS7BDWjQOir/syeK21zFd7Wz0CmyazQ475D1OWWnoMHAXoY/FDjTL+MlwGJOE9HSVMDjE+n9iKzVfP0f+rdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L8eenIjXgbCAfKm3fDxvVkZxRuSiwT5PUAfJFdXaCNA=;
 b=0E7Ba5l/IUuHMlzyhPvh8Peyv4+g/3lazuTSgFUzvNbhAmXTV7bg2pDBPVaKJF4E3VCSiyONd5SDCjEhoxriJbBzWLYaUg9wl9CM6JPnbIOOpmF2qJoN1AfGzLEFz4zLCVC8X+MrOdNn9RerbqH6VTMzyB98DWzBLtTBaek5I4Y=
Authentication-Results: linux.vnet.ibm.com; dkim=none (message not signed)
 header.d=none;linux.vnet.ibm.com; dmarc=none action=none
 header.from=oracle.com;
Received: from CH2PR10MB4150.namprd10.prod.outlook.com (2603:10b6:610:ac::13)
 by CH0PR10MB4844.namprd10.prod.outlook.com (2603:10b6:610:c0::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.16; Fri, 17 Sep
 2021 01:55:11 +0000
Received: from CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::340c:c4d9:1efa:5bc7]) by CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::340c:c4d9:1efa:5bc7%8]) with mapi id 15.20.4523.016; Fri, 17 Sep 2021
 01:55:11 +0000
Content-Type: text/plain; charset=us-ascii
Subject: Re: [PATCH v6 00/13] Enroll kernel keys thru MOK
From:   Eric Snowberg <eric.snowberg@oracle.com>
In-Reply-To: <7e83a42f-22ff-350a-2017-d286b1b1b02c@linux.vnet.ibm.com>
Date:   Thu, 16 Sep 2021 19:55:00 -0600
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
        James.Bottomley@HansenPartnership.com, pjones@redhat.com,
        "konrad.wilk@oracle.com" <konrad.wilk@oracle.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <37D6AC4A-372D-497A-AF97-CEA03EFC9BBA@oracle.com>
References: <20210914211416.34096-1-eric.snowberg@oracle.com>
 <7e83a42f-22ff-350a-2017-d286b1b1b02c@linux.vnet.ibm.com>
To:     Nayna <nayna@linux.vnet.ibm.com>
X-Mailer: Apple Mail (2.3273)
X-ClientProxiedBy: SN4PR0401CA0046.namprd04.prod.outlook.com
 (2603:10b6:803:2a::32) To CH2PR10MB4150.namprd10.prod.outlook.com
 (2603:10b6:610:ac::13)
MIME-Version: 1.0
Received: from [IPv6:2606:b400:2001:92:8000::a1d] (2606:b400:8024:1010::17c6) by SN4PR0401CA0046.namprd04.prod.outlook.com (2603:10b6:803:2a::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14 via Frontend Transport; Fri, 17 Sep 2021 01:55:05 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bf4506ba-250c-4390-aa5a-08d9797e2edd
X-MS-TrafficTypeDiagnostic: CH0PR10MB4844:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH0PR10MB484476C3686792F90D02C92C87DD9@CH0PR10MB4844.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dHUoXgxh/z/tkWfveQQnIkEu21PuYr4FplyfJedsoiqgwwkjUFyPbLejnIFPfU3Di5c3qvBgGhcVtc0xZS6kO/GIgI0WOR4j1nqxEAxghBUOgZ7on9zsayWJgIzn+eszXuczof6dKAQgXtTF5IJGUnYsgCUNyvkTi1hhaPHtSFo6wjnUpaJ4xqtjQHULUdJa37qa2IThuHmTagE5Z85ft62dylYslGAiY+CUrfmaL+3Fii2twOi7A2x+RumZ+JZ6nMSsg1g156xfZ9/Frle6ohy6eVaUAo1XPEzJgiZ+mWD3aHmfHF8EwSco2PW0aGJBpw6Wea0dY7tsJEMBOlSg6pqc19XTqhFoQaXVv6pDSiJkxjIuktPPG+y9BRmw5H5rDRUWkiaapMCcG7W2Vi2XreauoBGBh6wctpRW1sDXMsiYnB+K5ko9Hq4o9jsC7oxkqOPqfHGxG1+/KgvJr+TYaE+AU7A7TIi1OwVCm+p5yJzIBzSxlMHyW68EzzQakjLKXNnpqkh9EHs8smcHms4ApIqk8yuRFU14XhVnV/NFnpxq2FcdpLMBHVqwSf6dLieLZb3cHiQVZZ/OqGrLzCaqf7Tvf2qbyZv7Q5wNqLaIk6l4uw92EJjzOVufGaIQk8cy3eE93nuLM5EZnobJCs/TdClwzE0/WaF55OoGdZieWKBzT7SXgksCySMqP2u/8FJSeh19YkeoBQUbQ5qXjlnxJg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4150.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(33656002)(86362001)(83380400001)(6486002)(36756003)(6666004)(38100700002)(107886003)(4326008)(5660300002)(53546011)(186003)(8676002)(8936002)(2616005)(52116002)(316002)(54906003)(66556008)(7416002)(2906002)(66476007)(66946007)(6916009)(508600001)(44832011)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?BJ6k5RoFrjtlJoq1JqiIM99N3+NcW1NqCwlpQ8NFIv7iXmQ2yT3IPmD26k9P?=
 =?us-ascii?Q?+FpFJG12Ve/bNpOYh0wDYkGST4WHtVojeeP5bA+wyhQhKnF9OsaoTtgOdXbK?=
 =?us-ascii?Q?C7u685w/8kglIT1LF51eZM3Ij2cm5A9kddQ7I7MXjp6Hlm3cQZf6+kUgUEgc?=
 =?us-ascii?Q?1u1imiR3/lZL5xId6A3p8pw4P73IWBgrBbd2H/xvtOEPus7fjM0U+BiMRriX?=
 =?us-ascii?Q?kaAUBEzLOTkI5LUdVMONgWcUPcO9Kh07i+rqrf90d1dt+bCOWI4qbVCPE8gr?=
 =?us-ascii?Q?B/086+/0UraIOtBIInynY+w39cTNv3Ra2BdtjlL6KfJUpni500TmGG/0oTo6?=
 =?us-ascii?Q?GZjjSOV/yZqxpTe1gZgABN8KGDnGlW3qdP2YTMPVfDBUueUq48vnw2vtIlGn?=
 =?us-ascii?Q?RgPCw69Xi6ljIYylu2kBBdc9aAnva+utAQg1oVx66FrcC4bDBefjEdvPVxcA?=
 =?us-ascii?Q?3BlhLi24/87x5GWk3B+OSJfH1hL3+EvDavtIj8cvXg6Y7d2RZwA1ko5qSRHL?=
 =?us-ascii?Q?HpxTkJsRMDBuP2jqPsVVpQ8TuwbFnx50VLR1ZfOEc7B2iPsYVq5FCgHa1Jli?=
 =?us-ascii?Q?UcQz3NqH7FowXO40F10UPj05Lv2T06c0W+9YVBdZyaAS5T6F2qoPMZ4eQord?=
 =?us-ascii?Q?xbokXasdksz6SzJrAMzOTBtROVPXTBblknhE9v0+Vhb+CpMKLWazzof0We5F?=
 =?us-ascii?Q?EvJcqVGNpHSH+eb8Nllbfu8lwEklctYQ4sJvCwNtijffECMhmDHKCZLyD2Ad?=
 =?us-ascii?Q?3h1h3DXhESoifjE1RDbmUApvYzAfJGxMpi8sWCWuvQqEj7sA2yf4Xtm5omzg?=
 =?us-ascii?Q?SChrbx123KV+QnZxbvrHbadHmppNc3YwfU6lMcxrxzmSpZe/H99bTKNgGVf8?=
 =?us-ascii?Q?/YQ61s/QF81jWuoaN4mMp66NhI6FXeQaTHb5IpKOmMkysmLycMZ+DNPyx3XH?=
 =?us-ascii?Q?2r6/lm/e1zGA3rOdHMWbYulqNoKmGyi/DVTekO4vtf7qvGZRauC2UYMF9r8O?=
 =?us-ascii?Q?RLjA9m+4vNie83KJQCdKYo/nP6WNUMWHIeltIMrR+H4IuxKTzu4+dsQkHYnK?=
 =?us-ascii?Q?PhPIHx7jI+h3pAutPwBkUv8uwZJbxwVcLK1ocCRKz8BGXcLDpMEqCxMpg8ka?=
 =?us-ascii?Q?Ur6JuaVnVrqUhqp13JeqZ2JJ4Oj/IycCEvZ7ANBhvO5yu0lBX1D263h9Vtml?=
 =?us-ascii?Q?o0GW76Jfyng7Y4jZ5oOT1PfsQKgCdFU17/Cbjs9vdbFTYOy21pu5U4lrBmvk?=
 =?us-ascii?Q?zwvPpWnlMQMK5zjqY5sMyrfg14nt/Jdj3qiGG8qokvnigW4Hy8P/OjnrCvbc?=
 =?us-ascii?Q?bkCrrIUZ7nIrTCd7KvudeFMUM3GouauEqcUyiRmqYaUe6A=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf4506ba-250c-4390-aa5a-08d9797e2edd
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4150.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2021 01:55:11.1891
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XTzMCZxVW8G6KymepVbY/xGmxfxAHlzPW3kheH3waSaAKyUEfaURUvYtxgZZqNTfXU5MWzQbTvbRBvmIkufFy28vHjw7/h7WiXaf7GQJPAk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB4844
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10109 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0
 mlxlogscore=999 adultscore=0 bulkscore=0 spamscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109030001 definitions=main-2109170010
X-Proofpoint-GUID: rNj8B_LUWm-sNFLxOfjAsU9Qestxp808
X-Proofpoint-ORIG-GUID: rNj8B_LUWm-sNFLxOfjAsU9Qestxp808
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


> On Sep 16, 2021, at 2:03 PM, Nayna <nayna@linux.vnet.ibm.com> wrote:
>=20
>=20
> On 9/14/21 5:14 PM, Eric Snowberg wrote:
>> Back in 2013 Linus requested a feature to allow end-users to have the
>> ability "to add their own keys and sign modules they trust". This was
>> his *second* order outlined here [1]. There have been many attempts
>> over the years to solve this problem, all have been rejected.  Many
>> of the failed attempts loaded all preboot firmware keys into the kernel,
>> including the Secure Boot keys. Many distributions carry one of these
>> rejected attempts [2], [3], [4]. This series tries to solve this problem
>> with a solution that takes into account all the problems brought up in
>> the previous attempts.
>>=20
>> On UEFI based systems, this series introduces a new Linux kernel keyring
>> containing the Machine Owner Keys (MOK) called machine. It also defines
>> a new MOK variable in shim. This variable allows the end-user to decide
>> if they want to load MOK keys into the machine keyring. Mimi has suggest=
ed
>> that only CA keys contained within the MOK be loaded into the machine
>> keyring. All other certs will load into the platform keyring instead.
>>=20
>> By default, nothing changes; MOK keys are not loaded into the machine
>> keyring.  They are only loaded after the end-user makes the decision
>> themselves.  The end-user would set this through mokutil using a new
>> --trust-mok option [5]. This would work similar to how the kernel uses
>> MOK variables to enable/disable signature validation as well as use/igno=
re
>> the db. Any kernel operation that uses either the builtin or secondary
>> trusted keys as a trust source shall also reference the new machine
>> keyring as a trust source.
>>=20
>> Secure Boot keys will never be loaded into the machine keyring.  They
>> will always be loaded into the platform keyring.  If an end-user wanted
>> to load one, they would need to enroll it into the MOK.
>>=20
>> Steps required by the end user:
>>=20
>> Sign kernel module with user created key:
>> $ /usr/src/kernels/$(uname -r)/scripts/sign-file sha512 \
>>    machine_signing_key.priv machine_signing_key.x509 my_module.ko
>>=20
>> Import the key into the MOK
>> $ mokutil --import machine_signing_key.x509
>>=20
>> Setup the kernel to load MOK keys into the .machine keyring
>> $ mokutil --trust-mok
>>=20
>> Then reboot, the MokManager will load and ask if you want to trust the
>> MOK key and enroll the MOK into the MOKList.  Afterwards the signed kern=
el
>> module will load.
>=20
> machine_signing_key.x509 appears to be a code-signing, self-signed key.  =
It's not a CA key, but the intent of the patchset is to load only CA keys t=
o .machine keyring.
>=20
> Shouldn't there be two steps: one to load the CA key into MOK, and a seco=
nd one to load the code-signing key which is signed by this CA ?

I think that would depend on how the end-user wants to do things. If they=20
are just looking to quickly self-sign their own kernel module, I doubt they=
=20
would go through the effort of having two keys.  This is what I tried to=20
document in the example above.=20

If they do want to use multiple keys, nothing in this approach prevents it.
Their CA will be loaded into the machine keyring.  Now that the machine=20
keyring is a new trust source,  they could simply load their intermediate=20
or leaf cert signed by their CA into the secondary trusted keyring. Afterwa=
rds
their signed kernel module would load.


