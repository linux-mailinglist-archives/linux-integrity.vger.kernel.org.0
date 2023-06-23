Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8EE073B671
	for <lists+linux-integrity@lfdr.de>; Fri, 23 Jun 2023 13:43:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229847AbjFWLn0 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 23 Jun 2023 07:43:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjFWLnZ (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 23 Jun 2023 07:43:25 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFD331987
        for <linux-integrity@vger.kernel.org>; Fri, 23 Jun 2023 04:43:24 -0700 (PDT)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35NBWlJn007952;
        Fri, 23 Jun 2023 11:43:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=iHJIxOTxLzHeYvlHeUyXWZywlgGaDxxmdRi4xOt280o=;
 b=UIOEmYDy1cSFCjsbpPue9+TdjpJ1lV2wubrU9VTbYrI5Lji4fEAH2H0f8rdmBSnlNSmw
 P5/qNxtByStyyhwNiTOSW7iNbsbCVCDneyNXMPPqwJtPIElG+d4JZim0GHxWZ1svJ7zN
 EbKSQrRNSK5LODe68XWJ6vF7BIXL+Z6SAqxHMYOcOhjtElMnrlARnki1xif0FbMfioFc
 PLO199P0hnQwcdM58odtNsIwXlW6UUDvxcZnLArz4aHCEMzbFaoWTYRQSH0G1p/u4MRQ
 TIZ92m4MExtXdZ2+brf9a/TUiNKYzRezKdT7gXMg8nf3AAe7qyVSb78RZjsjt6Mc9YBm dA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rdam1g734-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 23 Jun 2023 11:43:03 +0000
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 35NBZBpJ018006;
        Fri, 23 Jun 2023 11:43:02 GMT
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com [169.53.41.122])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rdam1g72s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 23 Jun 2023 11:43:02 +0000
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
        by ppma04dal.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 35NBTCVh010772;
        Fri, 23 Jun 2023 11:43:02 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([9.208.130.99])
        by ppma04dal.us.ibm.com (PPS) with ESMTPS id 3r94f77g07-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 23 Jun 2023 11:43:01 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
        by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 35NBh0LP21299562
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 23 Jun 2023 11:43:00 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7968A5803F;
        Fri, 23 Jun 2023 11:43:00 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8D3C458055;
        Fri, 23 Jun 2023 11:42:59 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.61.58.24])
        by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Fri, 23 Jun 2023 11:42:59 +0000 (GMT)
Message-ID: <1f125e9153369f757749f0825e41a4685b9fe005.camel@linux.ibm.com>
Subject: Re: [PATCH v3 ima-evm-utils 4/4] Add simple tests to check EVM HMAC
 calculation
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Roberto Sassu <roberto.sassu@huaweicloud.com>,
        dmitry.kasatkin@gmail.com
Cc:     linux-integrity@vger.kernel.org, vt@altlinux.org, pvorel@suse.cz,
        stefanb@linux.ibm.com, paul@paul-moore.com, casey@schaufler-ca.com,
        Roberto Sassu <roberto.sassu@huawei.com>
Date:   Fri, 23 Jun 2023 07:42:59 -0400
In-Reply-To: <20230616192358.314906-5-roberto.sassu@huaweicloud.com>
References: <20230616192358.314906-1-roberto.sassu@huaweicloud.com>
         <20230616192358.314906-5-roberto.sassu@huaweicloud.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-22.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: H-OZ41l9sHIHup1IgRy73iAmgXxwNNzs
X-Proofpoint-ORIG-GUID: rAii8RHER4j4ZJigod6HxZvwfnj75nB5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-23_06,2023-06-22_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 clxscore=1015
 priorityscore=1501 bulkscore=0 phishscore=0 malwarescore=0 suspectscore=0
 adultscore=0 mlxlogscore=780 impostorscore=0 mlxscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2306230105
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Roberto,

On Fri, 2023-06-16 at 21:23 +0200, Roberto Sassu wrote:
> From: Roberto Sassu <roberto.sassu@huawei.com>
> 
> Add a simple test to ensure that the kernel and evmctl provide the same
> result for the HMAC calculation. Do it with SELinux or Smack, whichever is
> available (if the UML kernel is used, the test is done with both LSMs).
> 
> Also add another test to evaluate the HMAC on a directory for which Smack
> added the SMACK64TRANSMUTE xattr.
> 
> The second test fails without the kernel patch 'smack: Set the
> SMACK64TRANSMUTE xattr in smack_inode_init_security()', as Smack uses
> __vfs_setxattr() to set SMACK64TRANSMUTE, which does not go through EVM,
> and makes the HMAC invalid.
> 
> Require (unless the UML kernel is used) that the TST_EVM_CHANGE_MODE
> environment variable is set to 1, so that users acknowledge that they are
> initializing EVM with a well-known HMAC key, which can introduce obvious
> security concerns.
> 
> Finally, enable SELinux, the EVM additional xattrs, and encrypted keys with
> user-decrypted data in the kernel configuration for CI, and set
> TST_EVM_CHANGE_MODE to 1 in the Github Action workflow.
> 
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>

The simple SELinux and Smack tests are working properly without kernel
changes.  Even the Smack transmute test is working is proplery
returning an error message, but is followed by a kernel panic.

Possibly missing patches:
 - smack: Set the SMACK64TRANSMUTE xattr in smack_inode_init_security

   14.620000][    T1] Kernel panic - not syncing: Attempted to kill
init! exitcode=0x00000100
[   14.620000][    T1] CPU: 0 PID: 1 Comm: evm_hmac.test Not tainted
6.4.0-rc2-dont-use-g95526d13038c #1
[   14.620000][    T1] Stack:
[   14.620000][    T1]  60900a17 e1803be0 e1803c20 606f7598
[   14.620000][    T1]  63240701 60043a50 60900a17 00000000
[   14.620000][    T1]  60dfc308 00000000 e1803c60 60762e4b
[   14.620000][    T1] Call Trace:
[   14.620000][    T1]  [<6072ad82>] ? _printk+0x0/0x98
[   14.620000][    T1]  [<6072274d>] show_stack.cold+0x9d/0xf4
[   14.620000][    T1]  [<606f7598>] ? dump_stack_print_info+0xd8/0xf0
[   14.620000][    T1]  [<60043a50>] ? um_set_signals+0x0/0x60
[   14.620000][    T1]  [<60762e4b>] dump_stack_lvl+0x66/0x9a
[   14.620000][    T1]  [<607715d0>] ? _raw_spin_unlock_irq+0x0/0x60
[   14.620000][    T1]  [<60762e9d>] dump_stack+0x1e/0x20
[   14.620000][    T1]  [<6072429d>] panic+0x1a6/0x3a6
[   14.620000][    T1]  [<607240f7>] ? panic+0x0/0x3a6
[   14.620000][    T1]  [<600aec6a>] ? lock_release+0xca/0x180
[   14.620000][    T1]  [<60043a50>] ? um_set_signals+0x0/0x60
[   14.620000][    T1]  [<60764fe0>] ?
debug_lockdep_rcu_enabled+0x0/0x50
[   14.620000][    T1]  [<60043a9f>] ? um_set_signals+0x4f/0x60
[   14.620000][    T1]  [<60764fe0>] ?
debug_lockdep_rcu_enabled+0x0/0x50
[   14.620000][    T1]  [<60043a50>] ? um_set_signals+0x0/0x60
[   14.620000][    T1]  [<60064d79>] ? exit_signals+0x139/0x500
[   14.620000][    T1]  [<60771210>] ? _raw_spin_lock_irq+0x0/0xd0
[   14.620000][    T1]  [<607715d0>] ? _raw_spin_unlock_irq+0x0/0x60
[   14.620000][    T1]  [<607249c0>] make_task_dead.cold+0x0/0x9d
[   14.620000][    T1]  [<600557e7>] do_group_exit+0x47/0xe0
[   14.620000][    T1]  [<6004a0f0>] ? get_fp_registers+0x0/0x80
[   14.620000][    T1]  [<6005589a>] sys_exit_group+0x1a/0x20
[   14.620000][    T1]  [<600302a0>] handle_syscall+0xa0/0xd0
[   14.620000][    T1]  [<60046969>] handle_trap+0xe9/0x1a0
[   14.620000][    T1]  [<6004a0f0>] ? get_fp_registers+0x0/0x80
[   14.620000][    T1]  [<6004709f>] userspace+0x29f/0x530
[   14.620000][    T1]  [<6002c374>] new_thread_handler+0xb4/0xc0
./functions.sh: line 72:  8546 Aborted                 (core dumped)
"$@"
=================================
 Run with FAILEARLY=1 ./evm_hmac.test _cleanup_env cleanup
 To stop after first failure

-- 
thanks,

Mimi

