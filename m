Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B252540B9C5
	for <lists+linux-integrity@lfdr.de>; Tue, 14 Sep 2021 23:15:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234251AbhINVQe (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 14 Sep 2021 17:16:34 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:52922 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231690AbhINVQd (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 14 Sep 2021 17:16:33 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18EKxObV017546;
        Tue, 14 Sep 2021 21:14:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-type : mime-version;
 s=corp-2021-07-09; bh=o6lasaFB70OZrrluNrdiojqzSw3ER+VpTJ3AZx9PuUc=;
 b=HO0MEgHiRnZsBSQWhOM5ckJU+fh8LtCt9aCTD9t8yz0qGvkXeayOiG3ikv0W5oG+pQWx
 /V9LoeKLjZTqB84v4sJ+T37Ko8SR1pdtLqRfVuqZpEgcTORbrSmJ6itiFRvHQT8iXj8l
 QH0rjgXDOoSJbpCsXiOQIVpYydiuen9bJJCHD/Fb8BSrtT+VQtYKRa2vcO4OFTFd4w0g
 xlYBvomfxpH2lSKz29+FT5gD8zGj4igf4mvPuRPuqCjxt6UeIO8UbJ2aItGTKTaBpD/H
 IvPkXUJZzeN5ubKW3h5bxONXr71EzJseDws3XZauPChWMZpVBGPxocftJgV7ZJgRdEBt 7w== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-type : mime-version;
 s=corp-2020-01-29; bh=o6lasaFB70OZrrluNrdiojqzSw3ER+VpTJ3AZx9PuUc=;
 b=me0zSGe2pml8MupAADBbDp2eML8Qj4iqwc+5kBI/9MlVWEuaZrHW+NATZwj54gaHe+3X
 2B3lY615iwgDVqnuboeo4Jo1pcYDoghqOfZEwKKT3K+1olThfnjEsFdYX4kC5NIewVLO
 aWNxFTnUH8hgSMkobCiQg92ZV3spsQkqPpfph5NuwNLi6Aixgb+LxUnqCM6BkBlS9YeZ
 LmGuhHw+WNVB8aN0TSmQoEKW8NbBrGa/KHz5DJ0IdoI2KZIvhFCyoQ58B8Pk1DKXsdx8
 9nPpBpuh9OcWUo7tGrDZfp2iNK2iyKRbtO/ML8C3mFnY4/+WO7Ab5a4Sb8y4mgLUK3G3 sg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3b2p8taxhk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Sep 2021 21:14:37 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 18ELAOTa097270;
        Tue, 14 Sep 2021 21:14:36 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
        by aserp3020.oracle.com with ESMTP id 3b0m96w3as-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Sep 2021 21:14:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TAdX4onQThUCZy2HtgOm4ANQEpR9PI7khmFpdmqT/q4HW9OkmNEeyo9oOat5e2/mS61CsEoIZaNyjfpikr+PEIeAIQyXddqP3uT6YpsS7O/o0iwINPL5T7jtlHfTicQKl1IKZDncpO+jUg9AGpub9lGWIfjHw4L+8ASN7IxVAtED7pRLYqfNVEDQ82jBSl7rGh7oSTwxWkvOx0Gc81IutUpb5Mz8RJ1qiO4legfzWq9RM7Cp4dBCTMJBl8wqZr0hpSijN/aW7hgZWqEkLnvIw0Kx/wsJ1w83BpEUXd3RtB9byzEMAT5L57rcZxprs1qRUjLCB0nPFzrFpfg65k6tkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=o6lasaFB70OZrrluNrdiojqzSw3ER+VpTJ3AZx9PuUc=;
 b=TfNV6hlgAS4ZqkQUa6EuZvA80biCcTmDts4oHT2zWy2uZl9dEcYhmFudV3L6NIVObrjE+E084kRinC3CpCXrC6z4oo9PFZ8h25tqY0PlcvEcEVq3+HPERDqjCb0EeARtUzJLZGLfglJIcN4uxsrPvdbL3e0e3xhJJeUQihQkkX9YNLpcbr9jaxFWP8h38LRFv64DL4AG4/Uus3BGMNqzul0JD8ZMgiuZ1pgQQcNx7rpUDHKeI8kW36z6ZEwpEkBRjH4+c0WuwL09KDafNoJyOq9wYo4Zrq0wbujixFndkgcARAHEnHBmjY0Ga2bAVHwTkWGn48JHiKFZ0kxB3hfRKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o6lasaFB70OZrrluNrdiojqzSw3ER+VpTJ3AZx9PuUc=;
 b=b8lJ908wTillQrNtlNYXvgcq/cELy9vbywv4Nsy7PktmfP5LIBiQ6JIpYECATEmhNF9yTL5yzayBiUARqQfezTEf13tdfvYAgPxftF8f3lpNLIFAPlhiHxRvoCoPi8ubmcNshXuGiQ64DpvPqEFxoFWegONKpjvDGvtdBBNa0bM=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from CH2PR10MB4150.namprd10.prod.outlook.com (2603:10b6:610:ac::13)
 by CH0PR10MB4908.namprd10.prod.outlook.com (2603:10b6:610:cb::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14; Tue, 14 Sep
 2021 21:14:35 +0000
Received: from CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::340c:c4d9:1efa:5bc7]) by CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::340c:c4d9:1efa:5bc7%8]) with mapi id 15.20.4500.019; Tue, 14 Sep 2021
 21:14:35 +0000
From:   Eric Snowberg <eric.snowberg@oracle.com>
To:     keyrings@vger.kernel.org, linux-integrity@vger.kernel.org,
        zohar@linux.ibm.com, dhowells@redhat.com, dwmw2@infradead.org,
        herbert@gondor.apana.org.au, davem@davemloft.net,
        jarkko@kernel.org, jmorris@namei.org, serge@hallyn.com
Cc:     eric.snowberg@oracle.com, keescook@chromium.org,
        gregkh@linuxfoundation.org, torvalds@linux-foundation.org,
        scott.branden@broadcom.com, weiyongjun1@huawei.com,
        nayna@linux.ibm.com, ebiggers@google.com, ardb@kernel.org,
        nramas@linux.microsoft.com, lszubowi@redhat.com,
        linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        James.Bottomley@HansenPartnership.com, pjones@redhat.com,
        konrad.wilk@oracle.com
Subject: [PATCH v6 00/13] Enroll kernel keys thru MOK
Date:   Tue, 14 Sep 2021 17:14:03 -0400
Message-Id: <20210914211416.34096-1-eric.snowberg@oracle.com>
X-Mailer: git-send-email 2.18.4
Content-Type: text/plain
X-ClientProxiedBy: SN7PR04CA0165.namprd04.prod.outlook.com
 (2603:10b6:806:125::20) To CH2PR10MB4150.namprd10.prod.outlook.com
 (2603:10b6:610:ac::13)
MIME-Version: 1.0
Received: from localhost.us.oracle.com (148.87.23.5) by SN7PR04CA0165.namprd04.prod.outlook.com (2603:10b6:806:125::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14 via Frontend Transport; Tue, 14 Sep 2021 21:14:32 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7be6bdeb-6d7a-42b0-2044-08d977c4a6e3
X-MS-TrafficTypeDiagnostic: CH0PR10MB4908:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH0PR10MB4908C55697F727216FAA9BAF87DA9@CH0PR10MB4908.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gNKA3Mw55uTOSJfN0Bw4qDM4xudvePFtBN5dNXsV5Ybnsy5dYRi0uvOvLXNMziEu7J8mQIvYjdTHbIo5k/KJva+b6Go1WbGwsDHb4tyAhuQZzDvynszKTx7MEsU863TDw4rTxQ06EEr62KjnvOXkBFCyHKtlaxRcwqTh3uyeZGH8OFB7QVwwpP2KFnRogwsr9/GP7yg1DP4dtrV2cENMEn2cCQgGJBk+oQYu8xqjKZpHxiMzOVR4y/SHe5pA0hoTrOXzHZHQn8x8LOoEWa/C1Xfo3eL8F//iECrXmtfLeq5U8dntONgGQ0y4uuLnHQnmtub+bw3PYU3jNIb//INJL48yIZzq8eylJdThj+VUFLo/1FRUGKfNqbQYA3nIQN7SZ0DdbY9f/PF1qEKe21ctUUfOvRjEk+QbaT1l0NCh0COtcq7oHFDk8S9WDeDA70AqA3+cjIi8vZcE/87m1+X3uCUruxABUliY3/qxB+5qOka3ZWhmb4KLKbJvA8hOStsm6xU17nJSHxEpdV7/TwbYMIICnFdWP8ZMfEJw2qTlyRDlfIje3MezzQrUU2KV5BXKDvfPRB0EnGqjBlxonxcs5MpnvLOy+x7n8ZASjmQKIX+EGPuhsIRQVCyPiTXBYixVY46lrwxzahsz+8vlf9H0k7oB+jC4NPJFVuv3rzaOn8NkjyzqMNyXNNnVNUfUMATJDLGtw05OBGSZAZINdCctX7Bd+dBd/w30iPUTLAkVAkS54rLgY0gHfmb1unsCnz6ZjKxFT4XXRnRsrxMdlA2TUe1HF+xXN4pGheoEu4gMNYym8zsXRgSiigsnsiMAJl3vq3TfKPp8HSLI2lyoHpkh7Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4150.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(396003)(376002)(39860400002)(136003)(346002)(6486002)(4326008)(966005)(6666004)(2906002)(44832011)(7416002)(36756003)(66556008)(2616005)(8936002)(66946007)(52116002)(921005)(956004)(478600001)(86362001)(38100700002)(107886003)(38350700002)(26005)(83380400001)(1076003)(8676002)(66476007)(7696005)(5660300002)(316002)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?DHe/lKjj/6qZedBIO9PdPSY81aaztB1AdqfPe6k+I8wVBQHwEz8jPzdGO7fp?=
 =?us-ascii?Q?cepN2Ebpdv+9ZRKSg6vKafB7Wqsioqsw02RhbXlJBrP36WvjU3gVw/AARHgi?=
 =?us-ascii?Q?hriX+BxBIfxLol6v+sOWszCP5LQKz4bp2EhhJq+2NPJHnujK7apXEpIfDlEN?=
 =?us-ascii?Q?R6byjkCH0sZMUhEFD0r4LOPAZWe1gso5yMQrtLCQ8+oJzpDnoJjd9+TONl14?=
 =?us-ascii?Q?E9tqkQr6sjzif+OebnVZha8zj88yELVWBfCzzhfPJPQoMAHU5zOTy1O8H2ln?=
 =?us-ascii?Q?FhEC8OA0XMWL06uAlFSInmmw8fqVR6iBdkCa4n3wlJAEJwaZqE55XcobGGXc?=
 =?us-ascii?Q?G5un0nLIqR97HatERQU1auAWEsewb5j682FIjryzFIlv2wwzb7ZB4hcBxnCo?=
 =?us-ascii?Q?w+ZsQkK6EWbS6ihqu9ejQ3WcpsRRx/RgEJbWXrCOrzIXSihayMD6CpA4lZVu?=
 =?us-ascii?Q?aBkSouNOPW+gI8dwIuxNzlhGmtHAREcp6mbNdj8V3dFs8P6lreq/har29sSv?=
 =?us-ascii?Q?E6ASvWN3CQWLDZcXx5GWREsSpsFb8EOojDLWWsDruM7wglq3++vnCVMtKBb3?=
 =?us-ascii?Q?TT2WV2ahprlD4aXcvRyAHBwkHi4UCOsDOyKZSRM0dg0gUa+sF8gu2Oa/rd7u?=
 =?us-ascii?Q?Kd66G60oVjyWqQo8u4Jyy6SO2IKZ8uLId57cMFBeXtUA+OPCX1w/4AMnP5sk?=
 =?us-ascii?Q?UWXFZ1faHoGPGj5mICvCX47hDF5XLUY5iQA2W0RnCmokT4dtux4Pko8jJrja?=
 =?us-ascii?Q?USeygeYzhg8wke/BTYqfa+R73kljBV25Z8YHax8IUXb1G3ggO/OuVdALNwvx?=
 =?us-ascii?Q?Ar7nNR6A7H9PeQl4woIVNEPGDYYRCtFx48d7Fd7dB2FoDeVm0AVxgsyQWWXE?=
 =?us-ascii?Q?ecxdHCEpmrN09dGKMHlpzAzJ6aSpC4zMv9znQECsqg8gCSVUOWGLZ16k0MYI?=
 =?us-ascii?Q?Shus9v5K8p1gr+A0ndHopeKQtX1liCzTXHzXpGf3krT/YOxD6IdK9r7V1gMR?=
 =?us-ascii?Q?9Fsxc7ITJjvqKbDiq5wrcA8yT5nuUEfeu8V2UcewUcbsdPfIAQ1AIjR84i4R?=
 =?us-ascii?Q?Jqd2SSmmyNNw0nl6CGAfYvKM0m0WS2t9gaiAVN2Os9bKkQJcuLFhKlT4h/+Z?=
 =?us-ascii?Q?+beRb7RkV1kccYcuuIGt9OIsPcrMpQFkavjp9w1Su5pPA6WWoH04FXujLx3v?=
 =?us-ascii?Q?VpS6HGpTZ509AvnAajyDntQp5I1BIeuslnKZFJWHhqUmlXdh7qsA06s+tAT+?=
 =?us-ascii?Q?SRgKTCHCWaOdWnDu8/4EZp7bGBb2CYik33fYR09Y/MaFyvx6v6k8jwcyVxb6?=
 =?us-ascii?Q?QeDQhDW8cprmX0FfVzmMY/Ng?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7be6bdeb-6d7a-42b0-2044-08d977c4a6e3
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4150.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2021 21:14:34.8496
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /BCvY5vcb+KpTNwUvb1qcx3vBYgIlGaNey7RDfgNm+65TJwNyCH6Jp+FgBuvBIJijBt7LQwVk9yZEH11SIqdSbpGVSQzP3zLc6HpKJsYLo4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB4908
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10107 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 malwarescore=0
 adultscore=0 mlxscore=0 mlxlogscore=999 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109030001
 definitions=main-2109140123
X-Proofpoint-GUID: LtkJIAsP4RneYtC1-iTeXfxDsIGLkpzz
X-Proofpoint-ORIG-GUID: LtkJIAsP4RneYtC1-iTeXfxDsIGLkpzz
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Back in 2013 Linus requested a feature to allow end-users to have the 
ability "to add their own keys and sign modules they trust". This was
his *second* order outlined here [1]. There have been many attempts 
over the years to solve this problem, all have been rejected.  Many 
of the failed attempts loaded all preboot firmware keys into the kernel,
including the Secure Boot keys. Many distributions carry one of these 
rejected attempts [2], [3], [4]. This series tries to solve this problem 
with a solution that takes into account all the problems brought up in 
the previous attempts.

On UEFI based systems, this series introduces a new Linux kernel keyring 
containing the Machine Owner Keys (MOK) called machine. It also defines
a new MOK variable in shim. This variable allows the end-user to decide 
if they want to load MOK keys into the machine keyring. Mimi has suggested 
that only CA keys contained within the MOK be loaded into the machine 
keyring. All other certs will load into the platform keyring instead.

By default, nothing changes; MOK keys are not loaded into the machine
keyring.  They are only loaded after the end-user makes the decision 
themselves.  The end-user would set this through mokutil using a new 
--trust-mok option [5]. This would work similar to how the kernel uses 
MOK variables to enable/disable signature validation as well as use/ignore 
the db. Any kernel operation that uses either the builtin or secondary 
trusted keys as a trust source shall also reference the new machine 
keyring as a trust source.

Secure Boot keys will never be loaded into the machine keyring.  They
will always be loaded into the platform keyring.  If an end-user wanted 
to load one, they would need to enroll it into the MOK.

Steps required by the end user:

Sign kernel module with user created key:
$ /usr/src/kernels/$(uname -r)/scripts/sign-file sha512 \
   machine_signing_key.priv machine_signing_key.x509 my_module.ko

Import the key into the MOK
$ mokutil --import machine_signing_key.x509

Setup the kernel to load MOK keys into the .machine keyring
$ mokutil --trust-mok

Then reboot, the MokManager will load and ask if you want to trust the
MOK key and enroll the MOK into the MOKList.  Afterwards the signed kernel
module will load.

I have included links to both the mokutil [5] and shim [6] changes I
have made to support this new functionality.

[1] https://marc.info/?l=linux-kernel&m=136185386310140&w=2
[2] https://lore.kernel.org/lkml/1479737095.2487.34.camel@linux.vnet.ibm.com/
[3] https://lore.kernel.org/lkml/1556221605.24945.3.camel@HansenPartnership.com/
[4] https://lore.kernel.org/linux-integrity/1e41f22b1f11784f1e943f32bf62034d4e054cdb.camel@HansenPartnership.com/
[5] https://github.com/esnowberg/mokutil/tree/0.3.0-mokvars-v2
[6] https://github.com/esnowberg/shim/tree/mokvars-v2

Eric Snowberg (13):
  integrity: Introduce a Linux keyring called machine
  integrity: Do not allow machine keyring updates following init
  KEYS: CA link restriction
  integrity: restrict INTEGRITY_KEYRING_MACHINE to restrict_link_by_ca
  integrity: add new keyring handler for mok keys
  KEYS: Rename get_builtin_and_secondary_restriction
  KEYS: add a reference to machine keyring
  KEYS: Introduce link restriction for machine keys
  KEYS: integrity: change link restriction to trust the machine keyring
  KEYS: link secondary_trusted_keys to machine trusted keys
  integrity: store reference to machine keyring
  integrity: Trust MOK keys if MokListTrustedRT found
  integrity: Only use machine keyring when uefi_check_trust_mok_keys is
    true

 certs/system_keyring.c                        | 44 +++++++++-
 crypto/asymmetric_keys/restrict.c             | 40 +++++++++
 include/crypto/public_key.h                   |  5 ++
 include/keys/system_keyring.h                 | 14 +++
 security/integrity/Kconfig                    | 12 +++
 security/integrity/Makefile                   |  1 +
 security/integrity/digsig.c                   | 23 ++++-
 security/integrity/integrity.h                | 17 +++-
 .../platform_certs/keyring_handler.c          | 17 +++-
 .../platform_certs/keyring_handler.h          |  5 ++
 security/integrity/platform_certs/load_uefi.c |  4 +-
 .../platform_certs/machine_keyring.c          | 85 +++++++++++++++++++
 12 files changed, 257 insertions(+), 10 deletions(-)
 create mode 100644 security/integrity/platform_certs/machine_keyring.c


base-commit: 6880fa6c56601bb8ed59df6c30fd390cc5f6dd8f
-- 
2.18.4

