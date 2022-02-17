Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4C3B4BBCCB
	for <lists+linux-integrity@lfdr.de>; Fri, 18 Feb 2022 17:01:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237427AbiBRP7a (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 18 Feb 2022 10:59:30 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:39488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231565AbiBRP7J (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 18 Feb 2022 10:59:09 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 552785F8D6;
        Fri, 18 Feb 2022 07:58:52 -0800 (PST)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21IFqqCf014970;
        Fri, 18 Feb 2022 15:58:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-type : mime-version;
 s=corp-2021-07-09; bh=NUJR5VgETGgo3lendu01lxVQtM0cAcyUJ0OEVrhh6oI=;
 b=k3XjAwBFaa5sEeMqv0bXVtLiSY+73L1mrFCQ5N6mnbzENQVEdWXo+U7SqB8XrDcvvei7
 s9izcIbiTlfrZax1nwwAV9/hOcP75epTH8VnTbj11CwYgK8tI8ziW4RpeqM8HrurwRpE
 9CNmroHzTMt9L+vOLJvJzU/3EVdnc0K1lbZIuxUX8VBKNZFd5gRb1pFvH2TxOalXrrDS
 eC4w0Xj0MXAy9rx/+Vn0Oa4Vgkzu+aH/ZEt5vULoh4QrGKOEwCt86v7qF93/XAMQMq5D
 LKxi8yhgtmXjE20GNmtvfpQg14Gp6pzZjhjr9Ld9QKgLbglOR08RNxyFUASwJeenJ1Vw 6A== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3e8n3fh6wc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 18 Feb 2022 15:58:08 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 21IFuend062755;
        Fri, 18 Feb 2022 15:58:06 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
        by aserp3030.oracle.com with ESMTP id 3e9bre20v3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 18 Feb 2022 15:58:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WrKA710zmncfXzANZq9668MvjrNOLhQ03asqoLVEQDAOMb0joYZNimWfPRLzHzfLePG8ro9AxChri/IL4BeHBsbMeKl052CM0kGkTYEC8ZzHAUjecknV8Ecjra553Y8vmo/Y5Sbxy6W3qxNdxx5BxwRv+pwLOPMro3hGqnTMT8I4QR6C22HGqoRk/lvLqAiVlClOnlxkw5gVVdquH6L9xljGV8Pz1jKVEi5KW53LzrPB+p6lSQMM6WpzcZZ9mjS4h1fXcmYKrRm1lb0WUG8oPvf0GPKV0dc5lSlEirjxAP9kE91p2cBHEhwj9XqFi6JUOMtVW14hk2v+Lb7rqN2kJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NUJR5VgETGgo3lendu01lxVQtM0cAcyUJ0OEVrhh6oI=;
 b=oKFnBFE2J1chbHyfs38ytqaCzsouVx2W1CL477Xvu8f/6SHKLIRFnCq9fqsi7vJPivUDvVApRSCz6O8vUeaB4rIMODWs7D15AylOAQp/aB3yrA0BYHpaz/S1MIYf64QuuQUghJso4rZWGh6O0TYyVFwe/cYlavrH+tvpvnaCiqUknPi7oQa+7E3uo2/DM/lwZ0PdRGwmnRXcXmkp/3tcHssCE1xAJV/S+rPYvzNZeIzcLP+hZsVG7mLVQlUN/fobsC7RiftuTtRRdadAYOriUDOcej0pY4B8KyHEOP9tFCSfxFf8t5IyUJlPWcJWptJvAZyl7l1mbyQbMHO0ZHcQ9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NUJR5VgETGgo3lendu01lxVQtM0cAcyUJ0OEVrhh6oI=;
 b=IfA9ivXvkryjSA3bioAlddGcsOGM8WAMfdca5DBUuowtwotg5TaXHgpT9Vcwfe34UgdfaHRCOB9dby4SZvyWqBfT/oPfwc2k5o1NY5rJ4sIIv2yuFTL1qp6toFQ3FnDGkOpLzgQlEOnHP4ZuhXH/odY72CR7dz0t3vsL7tKxtig=
Received: from BY5PR10MB3793.namprd10.prod.outlook.com (2603:10b6:a03:1f6::14)
 by DS7PR10MB5312.namprd10.prod.outlook.com (2603:10b6:5:3a9::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.16; Fri, 18 Feb
 2022 15:58:04 +0000
Received: from BY5PR10MB3793.namprd10.prod.outlook.com
 ([fe80::398e:10a4:6887:4e18]) by BY5PR10MB3793.namprd10.prod.outlook.com
 ([fe80::398e:10a4:6887:4e18%5]) with mapi id 15.20.4995.022; Fri, 18 Feb 2022
 15:58:04 +0000
From:   Ross Philipson <ross.philipson@oracle.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-integrity@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-crypto@vger.kernel.org, kexec@lists.infradead.org
Cc:     iommu@lists.linux-foundation.org, ross.philipson@oracle.com,
        dpsmith@apertussolutions.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, hpa@zytor.com, luto@amacapital.net,
        nivedita@alum.mit.edu, kanth.ghatraju@oracle.com,
        trenchboot-devel@googlegroups.com
Subject: [PATCH v5 00/12] x86: Trenchboot secure dynamic launch Linux kernel support
Date:   Wed, 16 Feb 2022 22:54:33 -0500
Message-Id: <1645070085-14255-1-git-send-email-ross.philipson@oracle.com>
X-Mailer: git-send-email 1.8.3.1
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0288.namprd03.prod.outlook.com
 (2603:10b6:a03:39e::23) To BY5PR10MB3793.namprd10.prod.outlook.com
 (2603:10b6:a03:1f6::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b3680a79-d269-4b5c-4ee2-08d9f2f77248
X-MS-TrafficTypeDiagnostic: DS7PR10MB5312:EE_
X-Microsoft-Antispam-PRVS: <DS7PR10MB5312BCF5F6DCAA88AB70E977E6379@DS7PR10MB5312.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3968;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jcs51eQUBCio4ZdGfCmzMbWTJiWdB6xl1TnuE3uHiNl6OldX3iMnX2w1sBXAqXY/swHAGFBtUAz7guNF122NPe5FVxQ6x6EAkjvxDkLuq7stGH6QCMMDVjFv5nqyKCCX1+FzPdQlPnZki07cfmcVfNVDC7kkoymQzmFPbhxreUf6uDXBf7P2qbzCaO6cJcjkHoF7rB+A3WcaXiBZSKG8xnB8iaT68TCtrSKdjiKbIj1hdda9uocNJFTEtxblTGvdnMOj1NqUfrgGHrPDDGhUiSaHe1jo1pKYHsUHMQ7qOde73I54PUKVF/J8u4kL7OhELgujYQ9831a9ksDW97ww1qb0sDM5A3nBNonoYAIAsWHEHwELEMOCvce1iSmbb66OJAqkYPWbrxIPHjZ+9wKQ5w/KPNuPQvO6C98ETXCZ3cpuOvaKF8TU58HFYl3GF+RrIOSk3E3CNCx0ANlMCPXvHzkem0MB0wkKOqEXrW/rSPiddExJQm9lOpNZ0bCqtB9f/0XxaBfEaOjAgHzCwGS5aG1lGcDv7zaRPJZWfavUZXP31t08NdRPve/AJ0M+9v9P3oVckewDR9NKs3b6pZItysxaduEIvjbSM25n5kb0yzCn2jOYwhzQQzi7aM6BjfNbgOl04dB837+eIkK0J5SXcuGaJGKsmGdpb/eaHXiLXo2Xho+GvMN65rLg4v51j+7yKhw9Mxt1mQkzhPnIgpiV6jK/pNuJz8cI4TQdhqP7Kg+5fTIKX5KD8B/krKJtWQzwMCZrnGMisgvnlkVCxfl/KG3wF94j/i0BXJ5KQc9g7gZutVx5lvJt9FXF4tnayaObt2iGpZBgD9Xu1AYOidaIyQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB3793.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(44832011)(26005)(186003)(8676002)(4326008)(38350700002)(38100700002)(66476007)(66946007)(66556008)(508600001)(2616005)(6486002)(316002)(966005)(7416002)(36756003)(6666004)(5660300002)(8936002)(83380400001)(2906002)(6512007)(6506007)(52116002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?sMz6XhWlZeGuZsAtAM0AXc0EoMAGiPt7CngasAcNAdlC5oGcmINdf096R3Xy?=
 =?us-ascii?Q?HM+j0/UKsHCctlmvHd9cUXoLcqKvnI4LzIGu8g3ScS/A/yOpmPwBHixjYN5r?=
 =?us-ascii?Q?t0lrsAXG7pJP8yebZy/nqv2UKtQ7eDdvcAyTCXaarWfAtdRrb/OcYYIzXJU5?=
 =?us-ascii?Q?ulvvpGGyuqiM7BoBygvvxuS/4vNOL1JiOkJmk+KW1Pgxom3efI4Dg8Xp3/rK?=
 =?us-ascii?Q?rtJeu26CddCVeM9Ybun4/7TaTaezrVxMTeaqh3hbw1JWzsj7Ju6qTVuLJHHI?=
 =?us-ascii?Q?yCtppIqlk14q10FWHWt7oKJbfYP+dUdrmXceEZ51Dt/MLs895E3TeZxqWwtO?=
 =?us-ascii?Q?uREeR5h2LF7WpX546qmYKXDszglyddm48dfXvyD78htS7I6wPpTJu+VAsvgh?=
 =?us-ascii?Q?nAWlg4XPJozgyN3Inl7uUlpWH7wKZ/KAS0rJlDprQm1f42cNFV+9bDK7+iDZ?=
 =?us-ascii?Q?vJpZx92YDxiCEnI8qehT57DChWnvzMIECPu76LuF0IA+rkV1xfmrHNGD7c/q?=
 =?us-ascii?Q?DUiartmJ/jAeI0PdV/q6O9bra1maK+JEv1rCOyZvr/dFvCSP0qTZIPBGt2LS?=
 =?us-ascii?Q?Jag70d1ax/rVomtupNCmMr2SUSNasWm3dMQ8QxUDoUDz01QY0CKNoth3Z9T3?=
 =?us-ascii?Q?XnZApYrblZOg/0zLH+dSlfL+k8RoASomf3R34Hkb27GdIeekud1TFq1OZSdw?=
 =?us-ascii?Q?+DMoSRPhBGn7J0OFp2n12iMWFO6EiGPLKYdtwxmFtZz/Xq7wan4RNJvRawMu?=
 =?us-ascii?Q?6o+wmQux6oPNpcgxhsIL3oyvkkFqxf+7FIbWtYYwg3GK4RVRAAP7G+svk9E7?=
 =?us-ascii?Q?WnrZJoP9ZNgbiQUeuzId3kUqIQ/m4WAttsBHsJn86FVHAGh/u4NUAJcUPpXI?=
 =?us-ascii?Q?4jk8ElRurFgbDX2NkK3tThdhLkBa1KZBXyJ6r5oAlssGM6//ssdDS+8CvVUK?=
 =?us-ascii?Q?F1Fo/hs8u1JKhHa/WDPLVXr6Wq9gKsthSrJGLUBxTezhFpmtx0M4xTE2jC3p?=
 =?us-ascii?Q?rjRJQv5sdP1e2QSub2u2PndexAylMoP3hcJZiWCVnSPfm5ePJHKJOp4ep/+R?=
 =?us-ascii?Q?SA5twDMum1MNg1rowQ/729udq4rlpMgk0iCIXLPQq5ZCaYhr8KaVZsbx0iym?=
 =?us-ascii?Q?jDLtogE3PuOQezuGQEEEX6gdJ70GbByXIgrOoV9kO3CDS5riHspHJAnoO6X3?=
 =?us-ascii?Q?GYtmw0SU1liUX5CshykoitGRkjTFOWJfrVMKN3J20DsVPFgLkwfhq7Zk2n5g?=
 =?us-ascii?Q?kQ+dGxHdNP2JR4O2MKg8dx8v75/RhB75fFyAyqRXctHZSQ2Wr0qJlb2a4BKF?=
 =?us-ascii?Q?nBkyGAIg50Fta8C/9eI+zUL+lTAJNR/QQOg98okApvC7dmS998e486gneh2z?=
 =?us-ascii?Q?+Npnp23QikXoKXUgh7Klu/2zbAdofkU7rD6ihZUCFxxYzqok367Rcq5+4bcI?=
 =?us-ascii?Q?zF2usOJCgKy/WPNE1tgXXq7AfFgW9UTWjrTNc5n9JlAmBZrNLaxiriH5KM6O?=
 =?us-ascii?Q?bsX2yVcwKyREzbufRdDPAPqCgKlr1TjyVJn9sf6+8sEeC50+LDkPfh2UXMHa?=
 =?us-ascii?Q?Ppk8jcqboFU1LcQO3/wduWTRUmxKtaYEYN3mOHAXTlsV16TzONkq/m05yb2v?=
 =?us-ascii?Q?JKw2of4K4qdjXIU42ub+r9h6tUIiHQZYW+xBeBwCzGmbfvPNDmHf+HGVx13V?=
 =?us-ascii?Q?6bWF0Q=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3680a79-d269-4b5c-4ee2-08d9f2f77248
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB3793.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2022 15:58:04.0477
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KdlnzKZsij4eM20JjQToY8fEuXUB4n0+EbKZWJ7nJt1h04BGioR/uVWXmUdQ8yWswKL+NIxyRN+bsETscZGU19gkPuVE3ANkdrmsoG7y9VE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5312
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10261 signatures=677564
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 phishscore=0
 suspectscore=0 mlxscore=0 mlxlogscore=999 malwarescore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202180103
X-Proofpoint-GUID: npSRhxYTHQSMcXSAPlanSYffmBtlmLOf
X-Proofpoint-ORIG-GUID: npSRhxYTHQSMcXSAPlanSYffmBtlmLOf
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DATE_IN_PAST_24_48,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

The larger focus of the TrenchBoot project (https://github.com/TrenchBoot) is to
enhance the boot security and integrity in a unified manner. The first area of
focus has been on the Trusted Computing Group's Dynamic Launch for establishing
a hardware Root of Trust for Measurement, also know as DRTM (Dynamic Root of
Trust for Measurement). The project has been and continues to work on providing
a unified means to Dynamic Launch that is a cross-platform (Intel and AMD) and
cross-architecture (x86 and Arm), with our recent involvment in the upcoming
Arm DRTM specification. The order of introducing DRTM to the Linux kernel
follows the maturity of DRTM in the architectures. Intel's Trusted eXecution
Technology (TXT) is present today and only requires a preamble loader, e.g. a
boot loader, and an OS kernel that is TXT-aware. AMD DRTM implementation has
been present since the introduction of AMD-V but requires an additional
component that is AMD specific and referred to in the specification as the
Secure Loader, which the TrenchBoot project has an active prototype in
development. Finally Arm's implementation is in specification development stage
and the project is looking to support it when it becomes available.

This patchset provides detailed documentation of DRTM, the approach used for
adding the capbility, and relevant API/ABI documentation. In addition to the
documentation the patch set introduces Intel TXT support as the first platform
for Linux Secure Launch.

A quick note on terminology. The larger open source project itself is called
TrenchBoot, which is hosted on Github (links below). The kernel feature enabling
the use of Dynamic Launch technology is referred to as "Secure Launch" within
the kernel code. As such the prefixes sl_/SL_ or slaunch/SLAUNCH will be seen
in the code. The stub code discussed above is referred to as the SL stub.

The Secure Launch feature starts with patch #2. Patch #1 was authored by Arvind
Sankar. There is no further status on this patch at this point but
Secure Launch depends on it so it is included with the set.

Links:

The TrenchBoot project including documentation:

https://github.com/trenchboot

Intel TXT is documented in its own specification and in the SDM Instruction Set volume:

https://www.intel.com/content/dam/www/public/us/en/documents/guides/intel-txt-software-development-guide.pdf
https://software.intel.com/en-us/articles/intel-sdm

AMD SKINIT is documented in the System Programming manual:

https://www.amd.com/system/files/TechDocs/24593.pdf

GRUB2 pre-launch support patchset (WIP):

https://lists.gnu.org/archive/html/grub-devel/2020-05/msg00011.html

Thanks
Ross Philipson and Daniel P. Smith

Changes in v2:

 - Modified 32b entry code to prevent causing relocations in the compressed
   kernel.
 - Dropped patches for compressed kernel TPM PCR extender.
 - Modified event log code to insert log delimiter events and not rely
   on TPM access.
 - Stop extending PCRs in the early Secure Launch stub code.
 - Removed Kconfig options for hash algorithms and use the algorithms the
   ACM used.
 - Match Secure Launch measurement algorithm use to those reported in the
   TPM 2.0 event log.
 - Read the TPM events out of the TPM and extend them into the PCRs using
   the mainline TPM driver. This is done in the late initcall module.
 - Allow use of alternate PCR 19 and 20 for post ACM measurements.
 - Add Kconfig constraints needed by Secure Launch (disable KASLR
   and add x2apic dependency).
 - Fix testing of SL_FLAGS when determining if Secure Launch is active
   and the architecture is TXT.
 - Use SYM_DATA_START_LOCAL macros in early entry point code.
 - Security audit changes:
   - Validate buffers passed to MLE do not overlap the MLE and are
     properly laid out.
   - Validate buffers and memory regions used by the MLE are
     protected by IOMMU PMRs.
 - Force IOMMU to not use passthrough mode during a Secure Launch.
 - Prevent KASLR use during a Secure Launch.

Changes in v3:

 - Introduce x86 documentation patch to provide background, overview
   and configuration/ABI information for the Secure Launch kernel
   feature.
 - Remove the IOMMU patch with special cases for disabling IOMMU
   passthrough. Configuring the IOMMU is now a documentation matter
   in the previously mentioned new patch.
 - Remove special case KASLR disabling code. Configuring KASLR is now
   a documentation matter in the previously mentioned new patch.
 - Fix incorrect panic on TXT public register read.
 - Properly handle and measure setup_indirect bootparams in the early
   launch code.
 - Use correct compressed kernel image base address when testing buffers
   in the early launch stub code. This bug was introduced by the changes
   to avoid relocation in the compressed kernel.
 - Use CPUID feature bits instead of CPUID vendor strings to determine
   if SMX mode is supported and the system is Intel.
 - Remove early NMI re-enable on the BSP. This can be safely done later
   on the BSP after an IDT is setup.

Changes in v4:
 - Expand the cover letter to provide more context to the order that DRTM
   support will be added.
 - Removed debug tracing in TPM request locality funciton and fixed
   local variable declarations.
 - Fixed missing break in default case in slmodule.c.
 - Reworded commit messages in patches 1 and 2 per suggestions.

Changes in v5:
 - Comprehensive documentation rewrite.
 - Use boot param loadflags to communicate Secure Launch status to
   kernel proper.
 - Fix incorrect check of X86_FEATURE_BIT_SMX bit.
 - Rename the alternate details and authorities PCR support.
 - Refactor the securityfs directory and file setup in slmodule.c.
 - Misc. cleanup from internal code reviews.
 - Use reverse fir tree format for variables.

Arvind Sankar (1):
  x86/boot: Place kernel_info at a fixed offset

Daniel P. Smith (2):
  x86: Add early SHA support for Secure Launch early measurements
  x86: Secure Launch late initcall platform module

Ross Philipson (9):
  Documentation/x86: Secure Launch kernel documentation
  x86: Secure Launch Kconfig
  x86: Secure Launch main header file
  x86: Secure Launch kernel early boot stub
  x86: Secure Launch kernel late boot stub
  x86: Secure Launch SMP bringup support
  kexec: Secure Launch kexec SEXIT support
  reboot: Secure Launch SEXIT support on reboot paths
  tpm: Allow locality 2 to be set when initializing the TPM for Secure
    Launch

 Documentation/security/index.rst                   |   1 +
 Documentation/security/launch-integrity/index.rst  |  10 +
 .../security/launch-integrity/principles.rst       | 313 ++++++++++
 .../launch-integrity/secure_launch_details.rst     | 552 +++++++++++++++++
 .../launch-integrity/secure_launch_overview.rst    | 214 +++++++
 Documentation/x86/boot.rst                         |  21 +
 arch/x86/Kconfig                                   |  34 +
 arch/x86/boot/compressed/Makefile                  |   3 +
 arch/x86/boot/compressed/early_sha1.c              |  97 +++
 arch/x86/boot/compressed/early_sha1.h              |  17 +
 arch/x86/boot/compressed/early_sha256.c            |   7 +
 arch/x86/boot/compressed/head_64.S                 |  37 ++
 arch/x86/boot/compressed/kernel_info.S             |  53 +-
 arch/x86/boot/compressed/kernel_info.h             |  12 +
 arch/x86/boot/compressed/sl_main.c                 | 556 +++++++++++++++++
 arch/x86/boot/compressed/sl_stub.S                 | 685 +++++++++++++++++++++
 arch/x86/boot/compressed/vmlinux.lds.S             |   6 +
 arch/x86/include/asm/realmode.h                    |   3 +
 arch/x86/include/uapi/asm/bootparam.h              |   1 +
 arch/x86/kernel/Makefile                           |   2 +
 arch/x86/kernel/asm-offsets.c                      |  19 +
 arch/x86/kernel/reboot.c                           |  10 +
 arch/x86/kernel/setup.c                            |   3 +
 arch/x86/kernel/slaunch.c                          | 536 ++++++++++++++++
 arch/x86/kernel/slmodule.c                         | 493 +++++++++++++++
 arch/x86/kernel/smpboot.c                          |  86 +++
 arch/x86/realmode/rm/header.S                      |   3 +
 arch/x86/realmode/rm/trampoline_64.S               |  37 ++
 drivers/char/tpm/tpm-chip.c                        |   9 +-
 drivers/iommu/intel/dmar.c                         |   4 +
 include/linux/slaunch.h                            | 532 ++++++++++++++++
 kernel/kexec_core.c                                |   4 +
 lib/crypto/sha256.c                                |   8 +
 lib/sha1.c                                         |   4 +
 34 files changed, 4367 insertions(+), 5 deletions(-)
 create mode 100644 Documentation/security/launch-integrity/index.rst
 create mode 100644 Documentation/security/launch-integrity/principles.rst
 create mode 100644 Documentation/security/launch-integrity/secure_launch_details.rst
 create mode 100644 Documentation/security/launch-integrity/secure_launch_overview.rst
 create mode 100644 arch/x86/boot/compressed/early_sha1.c
 create mode 100644 arch/x86/boot/compressed/early_sha1.h
 create mode 100644 arch/x86/boot/compressed/early_sha256.c
 create mode 100644 arch/x86/boot/compressed/kernel_info.h
 create mode 100644 arch/x86/boot/compressed/sl_main.c
 create mode 100644 arch/x86/boot/compressed/sl_stub.S
 create mode 100644 arch/x86/kernel/slaunch.c
 create mode 100644 arch/x86/kernel/slmodule.c
 create mode 100644 include/linux/slaunch.h

-- 
1.8.3.1

