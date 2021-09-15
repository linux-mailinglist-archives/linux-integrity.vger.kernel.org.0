Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 909D740CED5
	for <lists+linux-integrity@lfdr.de>; Wed, 15 Sep 2021 23:29:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232252AbhIOVbA (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 15 Sep 2021 17:31:00 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:1076 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232127AbhIOVa7 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 15 Sep 2021 17:30:59 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18FJxTJ2009459;
        Wed, 15 Sep 2021 21:28:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 subject : from : in-reply-to : date : cc : content-transfer-encoding :
 message-id : references : to : mime-version; s=corp-2021-07-09;
 bh=wgtXPA8ZC3QIKQVQbMROxms0QAK+Q9d1ANOFkH/AHms=;
 b=OPnOFHyvq9FZwukXChkuwD3jQk9tb16Ryl/t8zwVcSHnZztTLEj0s2Slq330n8fhu3X9
 6n+g9hmGRxGz8nXUNtza1Z29mr7eydpZTTPw7oqxwSOhu75jBtzYgHMcMuyhzaq8eLI3
 TxvMWg2daoyAGEWp9NNadz8Ki5hrI8iQb7/ByGU77kZxFzcFa95wccJkoyTxW4bePEoe
 iFaMLOLJV2459+jSSm2f9Z9oVPrcbsEvqHyQrD3mgTeKLkmVG4fCTQcL2RU7Zk1UsQUd
 l/H+QQzCljLKop4VN6kBoOcPwJTx61X1InKBM6wThSiQXhf8S7EO3yTR9MlXOYBDf6YO UQ== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 subject : from : in-reply-to : date : cc : content-transfer-encoding :
 message-id : references : to : mime-version; s=corp-2020-01-29;
 bh=wgtXPA8ZC3QIKQVQbMROxms0QAK+Q9d1ANOFkH/AHms=;
 b=sJs3SBsP7qNKuWF0i340ONjR5aBeqI4onmUADY0KbCEB0958tbWLhSxmuhSTuocuQrFM
 2DOrOWqJoNPzFpVVINV9RZ4Kd1c4A0OKZhSgSxeRk9bkooO/4O3SFlAeLLam2ibFgYIB
 8mjbW8A1rhFZ4tM4Nks7kcwoXvQ89JNyOyLMVaIvDKZYV8Yh0AnfJSIowMhXIp5NTh7q
 K/HQFBF5EJRmvMR363+Pkt7VllvSTGVPS8t4w4GjN4A/ht9VG8hSxsL3kOZdnAfQ0KRd
 AvWJrs+4Xhe82LbgyZNIMLOn9OTBJ73Rq8oF3uFlUfOj8FkwUTMKK1QtoSGf6g4v9ojC Vw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3b3jysh9vd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 15 Sep 2021 21:28:52 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 18FLKbFk165926;
        Wed, 15 Sep 2021 21:28:51 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2171.outbound.protection.outlook.com [104.47.57.171])
        by aserp3030.oracle.com with ESMTP id 3b0jgf6p9v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 15 Sep 2021 21:28:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bLtiJnXT/S+pUX0jKrnoEKH58FtRBcxdMfVgP0rcgK48+xeKzT3T/9M/gZ8/nYXBg9qZiRfI+8tE9sp23b5snBPuF23KJkMYhEwCYagTLnHRGpXr9vNL4GyKekZtmXNM/P0j5QapVqIKLzL6ueq6NP5bEh5EIfKRtamxl+FCQWSrPfoF6PM0E7hNnA2LzuN3MtmD6vcaYrXUPDg/H7fao8QiSM3zfdQ+zM1UdkH7iyCZX8Qu0KagdqO0YOmBgTANhVBf8Vg0t5jG0YwxtikDoGNZ5Et5/e45AkXZCwELeoxs8d63gwujcwfnb0XgzYj7jOCX/M1raUsmGXAL6zOgjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=wgtXPA8ZC3QIKQVQbMROxms0QAK+Q9d1ANOFkH/AHms=;
 b=DJSfaFTSM4c0ew2PIjTMY6d9yZfw8Z0d8SIRRqBSnBa4kzxAio25YIsF7+rgp3ns+CLJXPcKakJrCit5xyqPHRblMEy7yvb9F6MFi3BWIM8yKj0Fc+4OffvcweAeUyqb4fcOqHRT/E8VB8rM1MiT7xaf5CpGiy81/INN19hmUIddBeZXG23BirsNl+soUjtRZ6Fc4cSaEd3nuKuL6B39SWbohOLZmt3qKj6ldxvjcWB/50tlXWlMQCnIGZK9M0MWjkiCLkf4yuseJ0DtFYrY1rC5o9N4/OHY3QEcglpCbTGczhItJuXmSrBUINBxJdzf/jZY4GWhPRnYnTFZZTmGog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wgtXPA8ZC3QIKQVQbMROxms0QAK+Q9d1ANOFkH/AHms=;
 b=W9SNuLnbl7uSEPutJeEah0Okw2p20VSNcf+1nyVEQD4I1jkXazb4pcwSNJQC/h8S1QZ5dthWootSUBQXocJ9tt5mN/vsl38mVjsYQVfNh9bjFSSNjW6a/m1RzEnD+YRH1LDsWVo1GdmE7kz2frAtXi9qe4nn0YPSmQ2RKkS9S10=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from MN2PR10MB4157.namprd10.prod.outlook.com (2603:10b6:208:1dc::18)
 by BLAPR10MB5362.namprd10.prod.outlook.com (2603:10b6:208:333::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14; Wed, 15 Sep
 2021 21:28:49 +0000
Received: from MN2PR10MB4157.namprd10.prod.outlook.com
 ([fe80::4cbc:9b8c:abfe:2a06]) by MN2PR10MB4157.namprd10.prod.outlook.com
 ([fe80::4cbc:9b8c:abfe:2a06%7]) with mapi id 15.20.4523.014; Wed, 15 Sep 2021
 21:28:49 +0000
Content-Type: text/plain; charset=us-ascii
Subject: Re: [PATCH v6 00/13] Enroll kernel keys thru MOK
From:   Eric Snowberg <eric.snowberg@oracle.com>
In-Reply-To: <bee0ebc354a651ea5b263897f9b155dc604fa7c5.camel@kernel.org>
Date:   Wed, 15 Sep 2021 15:28:39 -0600
Cc:     keyrings@vger.kernel.org, linux-integrity@vger.kernel.org,
        zohar@linux.ibm.com, dhowells@redhat.com, dwmw2@infradead.org,
        herbert@gondor.apana.org.au, davem@davemloft.net,
        jmorris@namei.org, serge@hallyn.com, keescook@chromium.org,
        gregkh@linuxfoundation.org, torvalds@linux-foundation.org,
        scott.branden@broadcom.com, weiyongjun1@huawei.com,
        nayna@linux.ibm.com, ebiggers@google.com, ardb@kernel.org,
        nramas@linux.microsoft.com, lszubowi@redhat.com,
        linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        James.Bottomley@HansenPartnership.com, pjones@redhat.com,
        "konrad.wilk@oracle.com" <konrad.wilk@oracle.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <A02EE1DA-12BE-4998-ACE6-2D74FF380297@oracle.com>
References: <20210914211416.34096-1-eric.snowberg@oracle.com>
 <bee0ebc354a651ea5b263897f9b155dc604fa7c5.camel@kernel.org>
To:     Jarkko Sakkinen <jarkko@kernel.org>
X-Mailer: Apple Mail (2.3273)
X-ClientProxiedBy: SA0PR11CA0185.namprd11.prod.outlook.com
 (2603:10b6:806:1bc::10) To MN2PR10MB4157.namprd10.prod.outlook.com
 (2603:10b6:208:1dc::18)
MIME-Version: 1.0
Received: from [IPv6:2606:b400:2001:91:8000::b8f] (2606:b400:8024:1010::17c6) by SA0PR11CA0185.namprd11.prod.outlook.com (2603:10b6:806:1bc::10) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14 via Frontend Transport; Wed, 15 Sep 2021 21:28:44 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3e85c1eb-a4b5-4e38-9cab-08d9788fcea0
X-MS-TrafficTypeDiagnostic: BLAPR10MB5362:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BLAPR10MB5362BD4729DFAF65E0AFFFA487DB9@BLAPR10MB5362.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NjfbkeBoDJImlRkSddvN4koTiZx9rrvigucSQ35TQ2edRRFhNxqYzQukAjtdOvr20eSuAX/ikYuphyiL9uc9OEkrT73ZPjhnsr9bJhVkG+iWMVV3916Sh2tqFpjZbArSxEX/P+LBwyY6YwhTyAQvpg3HxUX0bKbzJDYcixt8AP5dkE1azZj9YXEFAHE6ZfzQ1LvfSHeRg6WdwykRn0hkVD0jgYUeh03cHej9RLXpAziOtRoHOYS2YCmm21zUP05j+QT2Q6k/kpmCu8WKo9yxDub0ImYAxPYqrHiJlXsDyrUvbbZvsEQIfXJmuA3HSCPRs5M7N/MOfxltmJ5LHKbPNmZpgPXwjc4TWaVC2EKPOUvFm7eIZ+dWTj9TNDqEr+x1np8zJ5TyaL1ZH+fTGLATX26KgIjf+FvKFSPKnhU+WnwDlBtzLCzQoSmRKYJndoV8U9MJe2mkfPdaE0wmnpPTY8FJW4vBtvZGs97kVn4q7+mCm879J7G59ZzbK7k1SO5NJXQ+hz1dsy7NrBcPeLfpK7c4IimYADpdLSCkewJBgQOkgQ5m8j4GhtkrbngxXCLqRhkCP6Ro7FPv7aSV68tG2p2Pw8sGcX1Bwkob9/LGWCNuOp3hI2sVqRYfc9YG5BgUlj56M9qCYeMTmA4c4+f7FpVPAzyz8yZ88w/1WyHrXEfrNi8rI3tnW3DidroDVmQUmZsohppGROe7diQ554SOWnpu3lKRiEMp9wwZkc/91DPHgSLawgiLuyY0AS6V8SOQwC2NGcPFVzAhGjinmpNBWh2TgkKq04Y9/Dv8HvCjv4gsJpZ4Ai7RQPD1eX5pF9NVsvhGR5clQTVtBnu3bpqXgQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4157.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(136003)(366004)(376002)(346002)(39860400002)(83380400001)(33656002)(966005)(478600001)(52116002)(6666004)(6486002)(2906002)(86362001)(107886003)(2616005)(186003)(4326008)(8676002)(8936002)(316002)(44832011)(5660300002)(36756003)(66556008)(66946007)(66476007)(6916009)(53546011)(38100700002)(7416002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?S4bSIb3oQVDimH654MCzEzgD8FICX8LTz4xoZqmWPP8ETFAOLsJ4j/NInluk?=
 =?us-ascii?Q?LndJtcWa9PmDeB1wVQ2xV9VDpdy7oX91hy6D0Zq+OZrS9DNuN8wsd1bPPlhc?=
 =?us-ascii?Q?KThTGEEsmkPDTniYfh+nXZcXDP6KqF/qs/KtuQ+UStiIBHfBStzrYuvWSg6D?=
 =?us-ascii?Q?2NJi8+eN8y/YSk1mHbFGRWeYj+s0lgE+FONzvTNpItctxgs9gdXZLHpoibsw?=
 =?us-ascii?Q?5tSICDmU5hMD1kF+4372IMqTOKAjAgyHyMpRg52aUh1dwEXH2blH5h++ZgIM?=
 =?us-ascii?Q?621/6Vr7a9xly04PwTYu8O+VVy96FVz+E61ecqH4w0PalAcNUMa1uqelSFMl?=
 =?us-ascii?Q?RsrDrn/G8wE4TSLZBTB9b8FGgnKSe5cvtdYNkW3ZLYB6nLsNLPjM2jUlLJV2?=
 =?us-ascii?Q?WnlOaRJDgSN+PPcG7dJVXIxWPD6ixSvhePlSJAIjHEaay4KWusDIXoSl+yrW?=
 =?us-ascii?Q?1zUh9kc1M9KzXCMf93oNBxD8zMg8CjCaChV8QoeMnnHOBIis7LIqNb5pF4ZH?=
 =?us-ascii?Q?3zYMS/YKcknMvjcaSwG34l1k4TKB0gSLjXWbm/3no8hCrL4Y3KLs6Rtt8Gmo?=
 =?us-ascii?Q?el78JP+6DVXgY1EiP/SppBp3lLhkxUAq6BRd8PhmNzbTynY1Og5GoE9BeZMG?=
 =?us-ascii?Q?7doJwUw6lbe4w7C9pNyLU2xOC0BP2eYUQ5WGe7Gre2Mv4TwTP9WvLppWXwzS?=
 =?us-ascii?Q?MEPOoX15YZZm7w+xlJNoG0fcm4mWC1qUbtFyg/tyMpmanheANhYyD9EHzsGj?=
 =?us-ascii?Q?4CpHky75TSPdJk1+HKQcR7lxJvSNudappX5ej2xy9iG78W5oBh2J2VHub2SF?=
 =?us-ascii?Q?i47bljliY3aUG42ZOJsrPSSScIN7wVuPeg8JMVF6RcTAAsiU6dDTAlB5FskH?=
 =?us-ascii?Q?lKlUwWY1XfLlWnhfMiePPCilUIRjEEGYM5xfhZ4ziiy1CHrE9CEuTsSD9zaJ?=
 =?us-ascii?Q?v+WTurva92l2caEDUSsPw3zKrKuHuqkWFpAsYGVsxwcH05kKGtMlXrvWAQ3C?=
 =?us-ascii?Q?r7UxyM4Q5cstiuZrdSTJc0OzcmJMQTHuQlV/gV7NqFL+RF03lo4W/aUruJnK?=
 =?us-ascii?Q?8bX0wc+9Ln2QXlBtM3iINOBUtJJ85RAwl6uFgTrS+N9NE6IKwJf1lZ+YPIJ2?=
 =?us-ascii?Q?cCc3SWZVVLJRDqHDxwKeuvYy63Gn/cTYyHEo7KL+8ow7ls69/IRm+/sIm4qp?=
 =?us-ascii?Q?sEU3AJK0VY6cR6LCF9gzVMAzQhTUMWdrPQIULVYpDAyKeCYn/ojFs2h2PJW3?=
 =?us-ascii?Q?UuN1y5ygXdGCOg/Z1WRQ2zuxK2lPsCnvTgin4OkAUgPV+r7Xk8rGGUj1TDbK?=
 =?us-ascii?Q?waq2d9qzKC9K0hru81LTxZv9qmr9BGSFHWdr7fzRdLJAxA=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e85c1eb-a4b5-4e38-9cab-08d9788fcea0
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4157.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2021 21:28:49.5011
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KLgdzxy7M5gIQTMJQIFVnV3XFQt6sj8QbVblvVCeQsguHzwd2k6bDZ+vnutQmdXkmTtlQhHtKmdzARWTtuDI12A1q5BqzMa+xi3m0Oyk6WU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5362
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10108 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0
 mlxlogscore=999 adultscore=0 bulkscore=0 spamscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109030001 definitions=main-2109150123
X-Proofpoint-GUID: TokkM_9nLXReEnly-k1dGbRS95gO7PQY
X-Proofpoint-ORIG-GUID: TokkM_9nLXReEnly-k1dGbRS95gO7PQY
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


> On Sep 15, 2021, at 11:57 AM, Jarkko Sakkinen <jarkko@kernel.org> wrote:
>=20
> On Tue, 2021-09-14 at 17:14 -0400, Eric Snowberg wrote:
>> Back in 2013 Linus requested a feature to allow end-users to have the=20
>> ability "to add their own keys and sign modules they trust". This was
>> his *second* order outlined here [1]. There have been many attempts=20
>> over the years to solve this problem, all have been rejected.  Many=20
>> of the failed attempts loaded all preboot firmware keys into the kernel,
>> including the Secure Boot keys. Many distributions carry one of these=20
>> rejected attempts [2], [3], [4]. This series tries to solve this problem=
=20
>> with a solution that takes into account all the problems brought up in=20
>> the previous attempts.
>>=20
>> On UEFI based systems, this series introduces a new Linux kernel keyring=
=20
>> containing the Machine Owner Keys (MOK) called machine. It also defines
>> a new MOK variable in shim. This variable allows the end-user to decide=
=20
>> if they want to load MOK keys into the machine keyring. Mimi has suggest=
ed=20
>> that only CA keys contained within the MOK be loaded into the machine=20
>> keyring. All other certs will load into the platform keyring instead.
>>=20
>> By default, nothing changes; MOK keys are not loaded into the machine
>> keyring.  They are only loaded after the end-user makes the decision=20
>> themselves.  The end-user would set this through mokutil using a new=20
>> --trust-mok option [5]. This would work similar to how the kernel uses=20
>> MOK variables to enable/disable signature validation as well as use/igno=
re=20
>> the db. Any kernel operation that uses either the builtin or secondary=20
>> trusted keys as a trust source shall also reference the new machine=20
>> keyring as a trust source.
>>=20
>> Secure Boot keys will never be loaded into the machine keyring.  They
>> will always be loaded into the platform keyring.  If an end-user wanted=
=20
>> to load one, they would need to enroll it into the MOK.
>>=20
>> Steps required by the end user:
>>=20
>> Sign kernel module with user created key:
>> $ /usr/src/kernels/$(uname -r)/scripts/sign-file sha512 \
>>   machine_signing_key.priv machine_signing_key.x509 my_module.ko
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
>>=20
>> I have included links to both the mokutil [5] and shim [6] changes I
>> have made to support this new functionality.
>=20
> How hard it is to self-compile shim and boot it with QEMU (I
> do not know even the GIT location of Shim)?

It is not hard, that is the setup I use for my testing.  Upstream shim=20
is located here [1].  Or you can use my repo which contains the necessary
changes [2].

[1] https://github.com/rhboot/shim
[2] https://github.com/esnowberg/shim/tree/mokvars-v2

