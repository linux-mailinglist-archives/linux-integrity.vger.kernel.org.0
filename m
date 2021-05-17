Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC91B386D5B
	for <lists+linux-integrity@lfdr.de>; Tue, 18 May 2021 00:58:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239007AbhEQW76 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 17 May 2021 18:59:58 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:28866 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232416AbhEQW75 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 17 May 2021 18:59:57 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 14HMr71X001770;
        Mon, 17 May 2021 22:57:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-type : mime-version;
 s=corp-2020-01-29; bh=WEqfNBuz2NvN2enjjK99CH6XuUXsryMsCv0p+lcO18g=;
 b=CXe4sPKoOm3U+Two9xHRGW/OGVj/Z5YZ6b0mV6k+15S22ss+6CN3K8pWqf+EPWemaabD
 MAm/7rNnHsTFaTP+GCzFbqOClJZmB2IHubN0k0xUT4N3cuDeIdmJipPabTiymG1O7tAn
 wTqZcp6EIlMhIyXoRRXb/lTck3C09zJ5SnHEiwZG1G6I6s3lercDUYjWl7cijVooDGWF
 Vm4IBZKKeYlv/YDP+zrrSDCTaxL+Dqlyth5118DOAx4kGPqg4o9a24DrJL94g/VohdUI
 GE0hA9N/6tMv95K4wpNVYsw9pJsxdD/qNPd9CP17CMPyTm2Mc7debH6cm1DjUtHrZ/+R DQ== 
Received: from oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 38kffu0dat-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 17 May 2021 22:57:49 +0000
Received: from aserp3030.oracle.com (aserp3030.oracle.com [127.0.0.1])
        by pps.podrdrct (8.16.0.36/8.16.0.36) with SMTP id 14HMvn1A061638;
        Mon, 17 May 2021 22:57:49 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam08lp2176.outbound.protection.outlook.com [104.47.73.176])
        by aserp3030.oracle.com with ESMTP id 38j4bbhswf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 17 May 2021 22:57:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KBCQrvuupjWxgqb9i8d2TzsQC/V95MxmtiHEoisiOY+Ph1+4V2N8MSzYNldA1Jp29Q3LS4NHtezc4MNLH+C8bxQC2+A/9+eiT2luomEvyteelfO5bamwAi1gKoq/PFvLJ9PBPWdHeDpZAcQhmaO/C09TnZofPsLEjyD0RdrsdS7/cdPjVESai9S5llkg/PwNCSImu+QB/FtfTN5WIHlr2mhie9KtMwxmDB5Ou216P8JnIXQYEzegSezuJwjmrIDOlsQxkCOd8vh9IN2TOc6EhIplHcJfbTgo/4o1shlAeEAxIbmUFvXl04mdWamVrHJj5qcozt3UsZYT/Q1gpfYKUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WEqfNBuz2NvN2enjjK99CH6XuUXsryMsCv0p+lcO18g=;
 b=NMXEEM1nlqXcT/eU8GEG9o3ph0T00S6XQLK7LVXk9Zc6ZzwNgIbGxCtnHTsdVgcjFcEj8UI/dTHM7rmaOVr4S91Ipy2ud4l5zBW336D/j1ZLusb0hs9RoNHZtIr/Sn3Fxw1dQLvJPaghBBp8Kq1xJ7hwr0JxI8MXWkigQACvmY63eFCLWCBX4LzI1rkmT9YKydnll6B8jvvvip9VNIZpIfv2qjZq+yCDFBTz2ZvwjpLE9XX1UnwjEBQCnhdYkNNxYSSySGHwHmSJtjOwF3vSXs2Yq5v5OHJdmsqiimRUSp6la6ESctSQs9u/C1rFBe/F52Oo37dHyqoqzy5nEdfQJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WEqfNBuz2NvN2enjjK99CH6XuUXsryMsCv0p+lcO18g=;
 b=AHq4QFOhrnZgxKr9CX6hIzUDP6+4mOaMAV34m3xGRHFA2ggyDGldcvCfdv+NQQB0qOFhWK2c/ipqjqm3v6UqvjfMEFgwWAxJhS6yMrGQn/TLiJAcRtoZxigQuVDkWlyTv1+5lJl3FAp+wMRMPDKLK5YgN28gx1DaEWks17x6R/c=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from CH2PR10MB4150.namprd10.prod.outlook.com (2603:10b6:610:ac::13)
 by CH2PR10MB4328.namprd10.prod.outlook.com (2603:10b6:610:7e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.26; Mon, 17 May
 2021 22:57:47 +0000
Received: from CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::99fc:aabb:5cff:b177]) by CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::99fc:aabb:5cff:b177%3]) with mapi id 15.20.4129.031; Mon, 17 May 2021
 22:57:47 +0000
From:   Eric Snowberg <eric.snowberg@oracle.com>
To:     keyrings@vger.kernel.org, linux-integrity@vger.kernel.org
Cc:     dhowells@redhat.com, dwmw2@infradead.org,
        dmitry.kasatkin@gmail.com, eric.snowberg@oracle.com,
        jmorris@namei.org, jarkko@kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, zohar@linux.ibm.com,
        torvalds@linux-foundation.org, serge@hallyn.com,
        James.Bottomley@HansenPartnership.com, pjones@redhat.com,
        glin@suse.com
Subject: [RFC PATCH 0/3] Add additional MOK vars
Date:   Mon, 17 May 2021 18:57:11 -0400
Message-Id: <20210517225714.498032-1-eric.snowberg@oracle.com>
X-Mailer: git-send-email 2.18.4
Content-Type: text/plain
X-Originating-IP: [148.87.23.5]
X-ClientProxiedBy: SN6PR16CA0059.namprd16.prod.outlook.com
 (2603:10b6:805:ca::36) To CH2PR10MB4150.namprd10.prod.outlook.com
 (2603:10b6:610:ac::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.us.oracle.com (148.87.23.5) by SN6PR16CA0059.namprd16.prod.outlook.com (2603:10b6:805:ca::36) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25 via Frontend Transport; Mon, 17 May 2021 22:57:45 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 191d7af3-50b0-40c0-b0f7-08d919873013
X-MS-TrafficTypeDiagnostic: CH2PR10MB4328:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH2PR10MB4328C1FFD3BE30BBC1A0B1AD872D9@CH2PR10MB4328.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1gmsF7s5CwUESw3tolAyDm2rPcl8vnHFptShfq+lh2/yBupmH+AmguBaNjjP4IBwLyyCX6KVvfofJMnRdP0bt/g8ADA2738GbKpKGr9v2zPmH7ekKwvaZjuRcRcDBh/1+tvt0YD/O3N5htDzrNaE11a2/3T3tFsKnTdaE7lHCSj6FPAu1MCKIAc83zE4UgUosf4dlLswO7obOP/6mhR9rHuEUyDu9fOZnRThKzHIAgUvGgcJkQ4l0T9tMZnB6ii7SWrUGf+g037LEPfysGvvbGQbWTaLi5E3DMZq5sz5LTVTxDebbYN8u7bCSRiLFZPpGGP2ymNseqzSh/xmp5OcCJOfe+W6hIkHoZ0NojHRFbIHVqhSnT3UeOsw5MPHmqLCc74ptw65jGiIFTyiB+lzbKJVmSmYcOpiYiRFSA7gnAqGlZAfEz5gbQRybjev9c8wPOJATbnM9Fk42GN6GYBJiJlBM4Zmpl2LeIA1cgJSjPaFtBJTijiHujGsJtz62ps4jSo22SuSgRkz10W51zX2E9kpLGG1Zt3c0J/DADvmEY8lMmUHN+9k5aXvW5zx6PlIFZVDnXSEBvP7L5+fZSG30OmnDjeoHh1qSgmsk8hoovu9XfYkPzoBf4ndK7izH7goyXRi+BlUHu2VS9dL5a6JId1QrghsaIrNL/OxyzleYsAcIdN5Z0n7nymqRkN2iNLJgLf3J9Iwg4dtufw5Q4DAx+WOcx3Ys8FcuAS43UJW4IaVG2qKNLrGfchwQgxsB3l95CD0NK/fs0SjyWBgifJb4CelviGYBjuZKTTLI+u405pYECfxfzm4NMuc9uvEk/7k
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4150.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(39860400002)(376002)(366004)(136003)(396003)(52116002)(7696005)(66476007)(5660300002)(66556008)(316002)(36756003)(966005)(66946007)(86362001)(6666004)(8936002)(6486002)(38100700002)(2906002)(44832011)(38350700002)(26005)(186003)(4326008)(83380400001)(8676002)(1076003)(956004)(7416002)(2616005)(16526019)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?7pBSld8p/FlaWBJCOsQs1uurPmgFkeL1FAaeBmbXAlg0eiKXywCO1BDT+PrO?=
 =?us-ascii?Q?6DsiqiKUKmImwDxMqrXhwP07ZjJzn7du/p1w2e+0/0KGbCbBtUmCIO0Kri8r?=
 =?us-ascii?Q?K0tNx3PwqZkEwe/1np5EUOzisi1we7kKMsWJUUotJPveookYCIZvO50iQmhs?=
 =?us-ascii?Q?gVsh1h27sg/L4Vqn76CW+E+LQv8pYKWDMjK0wyuph7eGsxxOOucKbiV7i51P?=
 =?us-ascii?Q?cdUlpfwLqxrDXxw1/4saj0g8Gl6LBrRCLcanZkkhmFZP4ziVqUajX/iH7Qt5?=
 =?us-ascii?Q?Wnojk+IRAWxR1qemMMKCNiUVsR5F4d7SRnuu4nbXNcTj3T85FlHvVCC7C2dW?=
 =?us-ascii?Q?bu9KAYM1jaqDW7xe3Wttaf0GUPA/2mUMaODmSSVeahmOyHmLWSRJcjZSZMj0?=
 =?us-ascii?Q?O02EPd663gXR8ENqVGqvtwtRmg2lTBcc0yUWcciajm3+yMDRkSlF8ZGLvhLg?=
 =?us-ascii?Q?cz2C8331DZoPzySxVEi3VyWXrLMoqeTdzoChQkSWvwrZXgQvvABzK9OUUBHy?=
 =?us-ascii?Q?C/rRVXjAt9e0UZV9pZ6KrZvrjL2YgSbH22CG3ozy7JICXHQOiZIgxSzStshd?=
 =?us-ascii?Q?SuvFkEipBaAOh82Z44+Sts0oQVB7e/9QoQyOar+PSUsVR03X7zBG3G3Y0Q8e?=
 =?us-ascii?Q?3XL4Dvsekv4Rqi2bASnVcreZXxtD4L6X0YuLWy+OzvexMNZcEanq0aU6T+Du?=
 =?us-ascii?Q?KPa8T2JDHtjp1sB/KAMu7GS3uQYDvYZ7+OaiXQuXbw0QS7jbGbxB2d7BR7Aj?=
 =?us-ascii?Q?gg6eum42+H5b2CQtXiPs3PcPMmQ+KJcU8pHsQaazdHGpb6Vd3yW9VQV/zHPi?=
 =?us-ascii?Q?eOfK3f9NtOYDTPAg0QqCqidUYbjUdNzYga0NuSnR8tnvAA4NsugOfB7isF70?=
 =?us-ascii?Q?VGNTpzuACGK9vFq0uFn0SttiwRBDQv1kIpOiocOqqvAe1kAZ6BdKoOluB9o+?=
 =?us-ascii?Q?75CHGxnGjBKhLcqLW4NAYXjfcMXIQ2MrOLMUU39lv8/VkOMPb8WI0lzmJqxZ?=
 =?us-ascii?Q?a0g4sm09yHtMoFVhpHMUgH7c6rhtJVeKHmthjuUWwZEdf8RBy06+ZRZuh8Tq?=
 =?us-ascii?Q?HfnQaSlWGIiPRBNm1f1jWTwzdozB1TxagWCEZZcQ/qfklz/n4nSYZpkDTNag?=
 =?us-ascii?Q?J8LNs7hjWfSW4Brd1Qk7dn3sQ2SNk+gYJNm6CsZ/4dpQM3CtuNZty7ft96Ye?=
 =?us-ascii?Q?JAMpsnhGxWBeVuo5WKr0g+s2cC44FIdmS18yH2gRHFZ+3B8nBt7Oz+osNE3x?=
 =?us-ascii?Q?pPvGMUpZQpEbXI362J43DJzYbU2zzXS42/ZpkY3WVSfB83nYRo3hvo/RRyhN?=
 =?us-ascii?Q?YcaqLiVSHa7B6SBUhAmAQzU7?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 191d7af3-50b0-40c0-b0f7-08d919873013
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4150.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2021 22:57:46.9324
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oept78uT5/g5Evhfw+hfxdH1tPbhxZl4Gfy0c90c2wKmC8O/4te953XojO9zC1HJxinbp21ZytmxlQXjzpay5jEtSd45rZgNwoVFIonoAQ0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4328
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9987 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 spamscore=0
 phishscore=0 bulkscore=0 suspectscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2105170162
X-Proofpoint-ORIG-GUID: 6DH7cretXP63TG7GxYMRsFSEMBg8wiw2
X-Proofpoint-GUID: 6DH7cretXP63TG7GxYMRsFSEMBg8wiw2
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

This series is being sent as an RFC. I am looking for feedback; if
adding additional MOK variables would be an acceptable solution to help
downstream Linux distros solve some of the problems we are facing?

Currently, pre-boot keys are not trusted within the Linux boundary [1].
Pre-boot keys include UEFI Secure Boot DB keys and MOKList keys. These
keys are loaded into the platform keyring and can only be used for kexec.
If an end-user wants to use their own key within the Linux trust
boundary, they must either compile it into the kernel themselves or use
the insert-sys-cert script. Both options present a problem. Many
end-users do not want to compile their own kernels. With the
insert-sys-cert option, there are missing upstream changes [2].  Also,
with the insert-sys-cert option, the end-user must re-sign their kernel
again with their own key, and then insert that key into the MOK db.
Another problem with insert-sys-cert is that only a single key can be
inserted into a compressed kernel.

Having the ability to insert a key into the Linux trust boundary opens
up various possibilities.  The end-user can use a pre-built kernel and
sign their own kernel modules.  It also opens up the ability for an
end-user to more easily use digital signature based IMA-appraisal.  To
get a key into the ima keyring, it must be signed by a key within the
Linux trust boundary.

Downstream Linux distros try to have a single signed kernel for each
architecture.  Each end-user may use this kernel in entirely different
ways.  Some downstream kernels have chosen to always trust platform keys
within the Linux trust boundary.  In addition, most downstream kernels
do not have an easy way for an end-user to use digital signature based
IMA-appraisal.

This series adds two new MOK variables to shim. The first variable
allows the end-user to decide if they want to trust keys contained
within the platform keyring within the Linux trust boundary. By default,
nothing changes; platform keys are not trusted within the Linux kernel.
They are only trusted after the end-user makes the decision themself.
The end-user would set this through mokutil using a new --trust-platform
option [3]. This would work similar to how the kernel uses MOK variables
to enable/disable signature validation as well as use/ignore the db.

The second MOK variable allows a downstream Linux distro to make
better use of the IMA architecture specific Secure Boot policy.  This
IMA policy is enabled whenever Secure Boot is enabled.  By default, this 
new MOK variable is not defined.  This causes the IMA architecture 
specific Secure Boot policy to be disabled.  Since this changes the 
current behavior, it is placed behind a new Kconfig option.  Kernels
built with IMA_UEFI_ARCH_POLICY enabled would  allow the end-user
to enable this through mokutil using a new --ima-sb-enable option [3].
This gives the downstream Linux distro the capability to offer the
IMA architecture specific Secure Boot policy option, while giving
the end-user the ability to decide if they want to use it.

I have included links to both the mokutil [3] and shim [4] changes I
made to support this new functionality.

Thank you and looking forward to hearing your reviews.

[1] https://lore.kernel.org/lkml/1556221605.24945.3.camel@HansenPartnership.com/
[2] https://lore.kernel.org/patchwork/cover/902768/
[3] https://github.com/esnowberg/mokutil/tree/0.3.0-mokvars
[4] https://github.com/esnowberg/shim/tree/mokvars

Eric Snowberg (3):
  keys: Add ability to trust the platform keyring
  keys: Trust platform keyring if MokTrustPlatform found
  ima: Enable IMA SB Policy if MokIMAPolicy found

 certs/system_keyring.c                        | 19 ++++++++-
 include/keys/system_keyring.h                 | 10 +++++
 security/integrity/ima/Kconfig                |  8 ++++
 security/integrity/ima/ima_efi.c              | 24 ++++++++++++
 .../platform_certs/platform_keyring.c         | 39 +++++++++++++++++++
 5 files changed, 99 insertions(+), 1 deletion(-)

-- 
2.18.4

