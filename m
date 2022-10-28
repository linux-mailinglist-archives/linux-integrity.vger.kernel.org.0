Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7115610F54
	for <lists+linux-integrity@lfdr.de>; Fri, 28 Oct 2022 13:05:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230216AbiJ1LFl (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 28 Oct 2022 07:05:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231139AbiJ1LFb (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 28 Oct 2022 07:05:31 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 937E740BE1
        for <linux-integrity@vger.kernel.org>; Fri, 28 Oct 2022 04:05:02 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29S9ZfDi021921;
        Fri, 28 Oct 2022 11:04:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2022-7-12;
 bh=rW0vHt80yWd0Es38mbS+594UYLSfGLyoWXHDOfWWH9Q=;
 b=VgN3BJfIS8nFptDnfZcbYWOA143OVNzUvHbAK/qr3mebyEbwvKvsykHtRg1C5ii+RGm3
 xBVafknqEQDCDM/M7Y75QMF7NUnIEo3OlCgIOjja9mQw0quE+BMdVKQCJjSUJPrxPedU
 buuvlBVd2eyPbDVRMTtSnEWOU5V6f9b9VB7icfhfi7/eGpBykJbPoOjPk7TfT2ISGUgE
 ooJ6cPVj61+hbZU/UlxQY20tH5gIQTjJE1SgI3TsUnoUaCreUfm00JKdG+23zY2YcabA
 +ulGQDgg3UQjB0Sf17p7s9Z/dq6BgRbYbiVVjhxUeO9fX0jOYJHWii6f5OwFFxckQl/1 Jw== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kfagv4tr7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Oct 2022 11:04:57 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 29S9cDPK017455;
        Fri, 28 Oct 2022 11:04:57 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2175.outbound.protection.outlook.com [104.47.55.175])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3kfaghfdn7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Oct 2022 11:04:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DAIuFemxecPkv2ApE8qi73F0LMBxgaSPznh+CiFQN3q4tuHdjJOTKlhDRPsU6a9HH5GMhHSCxHFrnb9bl/pZEz7aa7KyussCJ8NRyKooEj6TdGThXwY2N9Hhhn1CNkLto/ICF4KM7mkbEGCpY4PCZsg8ZkIDP4OyVkglGFJep6zF3TnHzersVr3cTDgYjZnpQATnuQb27WvROC3Ex4vvb6uS9iEC7aHyA28VOSlL+AmaCdZeoNJWcsACY55vcf3gjmDQ6WtfFIze9+bXhY3d+7W3FPXp9C5zbOOYaoFLCj23bqo24jjKMCPV2GrT10Ty0y8ikL175WF0vXgDr48NOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rW0vHt80yWd0Es38mbS+594UYLSfGLyoWXHDOfWWH9Q=;
 b=A3GRSfMulNjdUo0VlqQ7Wiu8FHJ2KhQyjrgw7XBgWG4DuX0oyP8axFoJhfTpDjjsib55jPiI60QJYC6jE/b4O0hW+7zl2Gd07RWsoL5lC61aXleetDo9QeTKtmkc9BS8PlDEWR1pM1EKZQwy1+PlmaINh3dRUkcWlZN7VSJG227dXrV4+XD5pkzyyR6S4SQmgpPBg4AWEitTOV9HdzD2ssOOX2sNQczRq1L/Q6hQV6XOk8BDJMmUAmNk8eQT8Gw8to8gKra7Wb+SrAMMlU2x9DkSmlNGvXwcc82RQPKaWBbpkbjTFBzsOFlv2peKYUE//pP8IPSE088uHi0kRqRYcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rW0vHt80yWd0Es38mbS+594UYLSfGLyoWXHDOfWWH9Q=;
 b=Jr0uWlVOQOroHWP4zbe3XJP/9ZyaScFmza1uMed5XM9ym6WO2wU9b6BzIvI9LNZYNY83Acsr/eUwJNqxaeTmtqMirX3DcV1iDAQK7IAFJ6YGSd++2O0ysH6AvAG4g1X2y0Jjcuw8GuKUrXYY3P8z+b/k0ZirsiHPOcvWylR22jk=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MW5PR10MB5689.namprd10.prod.outlook.com
 (2603:10b6:303:19a::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.28; Fri, 28 Oct
 2022 11:04:54 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::3809:e335:4589:331e]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::3809:e335:4589:331e%7]) with mapi id 15.20.5769.015; Fri, 28 Oct 2022
 11:04:54 +0000
Date:   Fri, 28 Oct 2022 14:04:48 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     brauner@kernel.org
Cc:     linux-integrity@vger.kernel.org
Subject: [bug report] integrity: implement get and set acl hook
Message-ID: <Y1u3UBCL4ZHiq0oo@kili>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-ClientProxiedBy: ZR0P278CA0089.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:22::22) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR1001MB2365:EE_|MW5PR10MB5689:EE_
X-MS-Office365-Filtering-Correlation-Id: 4dfd7393-00c8-4c3b-06d7-08dab8d43e76
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1bPwtJIXz7iBo0yQQuzW+pf5TeEtPcwc5WrTC5yERilQ7Iah+0Bna0/ARqPcemgHQa7wZ572sTqgLdFJHI1AGSfBcGv7efm9rVtvLu4w6gHEYyqby7P0zNUFUt03ka+f4wWQ2r2IC7ioEFEXVT0YAGOLWfDPwZA1CXwPM/uI7diYZ9HujsVXgyp53yFtGWhWjwJBnH1X78mxKvNSh3t2qnzgN6DjQ8uEPwUSD4PFMDl2I6EWkntsBu6+rOPaI3wmPUQtQhJqVw9IZr1UKTCQDpi6qqngy+TJ+x9MaAGsVKKxIxnR7A1XJqRbHgLVYrlVeqHbUsFJ5ZVGBDiXyPtmvgN7ZbM2jWgF0GwYm54MqZJo1xDoifHrEOo63NhNYHGE8r/ws+1danWI8Kjc1TkP8r24sOW2pVbdLYV8rYDi1AIq+y/uehku7wRo5w3b/NL3nc6QjuR/lv5isRDflhTnMlo2od/jHUleLruI1o2+f4RDdct8r/8flNYel6osT75zrEVyyha/HkMifi7fY/ef2C/GzL5QLLfSAI6UFt0D7EauBExkfvf6k6iTIelDY8XfIO+8NF/UgBO8b7IMZpca0a7NviV/QHYxJ6bBqkxiPmHT9L5LUxdOU8b14GTQS8C5Gn04urRTGIPtw/BYWbwgZXyp4Q6xMugRXKjTGkM5t0+1yVkx2HWDhS0K0P8CL1xHyoJmLPm9m9ODYtQCxFuwfw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(366004)(39860400002)(346002)(396003)(136003)(376002)(451199015)(41300700001)(8936002)(5660300002)(66946007)(66476007)(66556008)(8676002)(6486002)(316002)(33716001)(26005)(478600001)(9686003)(6512007)(4326008)(6506007)(6916009)(2906002)(44832011)(83380400001)(6666004)(86362001)(38100700002)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QlVBMtgBb4xgKjIsEYPFzmoKj9ThKlYuxHDcgsJqpSfmbdY3V5EHVK87DmHn?=
 =?us-ascii?Q?hdH7NZf9cXDggwhjVo8Q4j5zwG5VckUL903lTxiIoXShFJVxOYVPZfynEz3r?=
 =?us-ascii?Q?xNTQhr13UqIca67R8xztEEnj9+55PtxqjT5EEGPhL1XDjFfz+yAMWRXkZJoT?=
 =?us-ascii?Q?Uiwv1mFguhmnAKY2A8eacIBZfTSX7xcMUgZRJ9qXn4eiZZyPM+csw3Bv2Y4s?=
 =?us-ascii?Q?L686NvwHcZlTuhWiiwzE6+CNF3C/Bykkh+0oRNVGNT4Ol+Baptbbbe82LQtw?=
 =?us-ascii?Q?1bcnZbAcz6DAqtdP0+CTTyGefysCYaPDXatI2gtKOfRx0w/wGCNQgH9hpICj?=
 =?us-ascii?Q?P0Etjj4rd/s2OMv4zTFsOfgMH5oS5SQIEVeLL6kp5jcgPbwutsdl9FexkidQ?=
 =?us-ascii?Q?fvsybHJgUc+y/obf6xaCGjs4EZiDzEzAqdnQmxbrtBiI8iiil/X2yhBEr2SL?=
 =?us-ascii?Q?6MXAqF8seA1icSpUWYVV2DeYKKKCjABAyTT/VE8QNJMPstxUqtt32NSoQyMi?=
 =?us-ascii?Q?Vhxb9RBTCNSz7FIspeiVhXSvRGvpyVyiKs46UpB89VrY9liXXE6WPCuW9/zx?=
 =?us-ascii?Q?n8SOnwUrWhrrucKEBlC0zMDapEI7QJujeQ5aYWUJopZX7ge8sAci9pB7JE+P?=
 =?us-ascii?Q?Jt9TJJ7M9hp5fwFpGVz3vtr0Hksepmo8+IJIFg/pBOmq5B83+mfHxLZTaL9M?=
 =?us-ascii?Q?yR0u3Ebgso5eqCAk76nUtstdO7brF9mAngdoN6kLBA3C567bmhv24xcUgpyO?=
 =?us-ascii?Q?ntVI9/h9tYNFhTCvhZtlBDJ9p7fQl3RePteWIG0GHArDPcUSEPQDXyDhXLdJ?=
 =?us-ascii?Q?XItdcWZuGjYqgvPLo5es+ASgIMSFtzgrQ10Zi8XvLioYVIWJyr7aSizQEmsv?=
 =?us-ascii?Q?CHEEokfVz915HKfYVeAstBJanmpLT+72Z6W+O2Ff4ObGFuopct+8I/td1vvX?=
 =?us-ascii?Q?GyI7vpOSr6L43ocqZPB4FoLcRZnqq7wzgUEQ44VAOtQsmPoZu9Um3AAEaTy4?=
 =?us-ascii?Q?Y4BQLR68R89l1VavxwD/PJfWwHOochOOSGELxz2mlN4pQE0fSABYZfkDuRiO?=
 =?us-ascii?Q?pslLky7FV2DHM8t44kTUUfwmA2WtB/Nch3eJnpXSTRzWEDSuQAo83tcaoj8v?=
 =?us-ascii?Q?zhoDeCSeVbA6J9em45cfxkKUXV1xmrXfl2No11J4MQNL/iTlgyNwmOqwnay+?=
 =?us-ascii?Q?vNjlt4NRNUyd0b2LIjvdi35ITlOjgbTH5GCLEUt0jm4lcrFDi4yubg4gNRFf?=
 =?us-ascii?Q?jR0BMcqXBrTy+1TgtpHfv501y7VM5XuZw/Kd/6YU9GeLwXe6fb6r2nZJsdNK?=
 =?us-ascii?Q?BfvMdziovzjcBzO9OhXJ8xWxUNcrUnSLowj2hXwouAQwHWDQkYHRiShycKJ4?=
 =?us-ascii?Q?a2NpJmOAkKCBsHybonvu1us/m8HaIqx5rkXvXZCWI425i+2QdE65kyA7RsI0?=
 =?us-ascii?Q?Pb/5igi/r37KjFgM7kwncTACxXm6kVdaia+CQMdY6xaeadc71RzmUljAu3Wr?=
 =?us-ascii?Q?uC4fQNEI4XJ+kxnlKbrrkYxcF66Mg3Wwr4oRan5B28K+jQQhPoiv9p15G9Wv?=
 =?us-ascii?Q?kLA+yHYIUkAXxUpg1cklfqkTrebo5VQsWk3nPT4pyG89pHaAnGtrztFkcNQe?=
 =?us-ascii?Q?qw=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4dfd7393-00c8-4c3b-06d7-08dab8d43e76
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2022 11:04:54.7783
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bsNG8HQDqSbdNYAXmu6fcAKk2Yjm8lkAmiGnL9ilGtImeQ4Zt1S6zRd3fvFEzhIkzyjBOOzlspbqVnSUGOwLR4b9nAiIj4jrRxBh5t9KlNg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR10MB5689
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-28_06,2022-10-27_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 malwarescore=0
 phishscore=0 mlxlogscore=943 mlxscore=0 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2210280068
X-Proofpoint-ORIG-GUID: 9TT2hdBGRuuJ4Oz92-Fb6LV0CLPg5fmr
X-Proofpoint-GUID: 9TT2hdBGRuuJ4Oz92-Fb6LV0CLPg5fmr
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hello Christian Brauner,

The patch e61b135f7bfe: "integrity: implement get and set acl hook"
from Sep 22, 2022, leads to the following Smatch static checker
warning:

	security/integrity/evm/evm_main.c:687 evm_inode_set_acl()
	warn: duplicate check 'evm_status' (previous on line 661)

security/integrity/evm/evm_main.c
    649 int evm_inode_set_acl(struct user_namespace *mnt_userns, struct dentry *dentry,
    650                       const char *acl_name, struct posix_acl *kacl)
    651 {
    652         enum integrity_status evm_status;
    653 
    654         /* Policy permits modification of the protected xattrs even though
    655          * there's no HMAC key loaded
    656          */
    657         if (evm_initialized & EVM_ALLOW_METADATA_WRITES)
    658                 return 0;
    659 
    660         evm_status = evm_verify_current_integrity(dentry);
    661         if ((evm_status == INTEGRITY_PASS) ||
    662             (evm_status == INTEGRITY_NOXATTRS))
    663                 return 0;

If evm_status == INTEGRITY_PASS then this function returns here.

    664 
    665         /* Exception if the HMAC is not going to be calculated. */
    666         if (evm_hmac_disabled() && (evm_status == INTEGRITY_NOLABEL ||
    667             evm_status == INTEGRITY_UNKNOWN))
    668                 return 0;
    669 
    670         /*
    671          * Writing other xattrs is safe for portable signatures, as portable
    672          * signatures are immutable and can never be updated.
    673          */
    674         if (evm_status == INTEGRITY_FAIL_IMMUTABLE)
    675                 return 0;
    676 
    677         if (evm_status == INTEGRITY_PASS_IMMUTABLE &&
    678             !evm_inode_set_acl_change(mnt_userns, dentry, acl_name, kacl))
    679                 return 0;
    680 
    681         if (evm_status != INTEGRITY_PASS &&
                    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^
Always true.

    682             evm_status != INTEGRITY_PASS_IMMUTABLE)

It feels like if evm_inode_set_acl_change() fails then it should trigger
this audit message.  In other words just delete the if statement and
always call integrity_audit_msg().

    683                 integrity_audit_msg(AUDIT_INTEGRITY_METADATA, d_backing_inode(dentry),
    684                                     dentry->d_name.name, "appraise_metadata",
    685                                     integrity_status_msg[evm_status],
    686                                     -EPERM, 0);
--> 687         return evm_status == INTEGRITY_PASS ? 0 : -EPERM;
                       ^^^^^^^^^^^^^^^^^^^^^^^^^^^^
This is harmless dead code.  Just "return -EPERM;"

    688 }

regards,
dan carpenter
