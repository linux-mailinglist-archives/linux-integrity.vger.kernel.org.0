Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E88D274B4B6
	for <lists+linux-integrity@lfdr.de>; Fri,  7 Jul 2023 17:55:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229755AbjGGPz2 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 7 Jul 2023 11:55:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229665AbjGGPz2 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 7 Jul 2023 11:55:28 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5846FB
        for <linux-integrity@vger.kernel.org>; Fri,  7 Jul 2023 08:55:25 -0700 (PDT)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 367Fl4rR003816;
        Fri, 7 Jul 2023 15:55:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=P0zwdwkAOLd1bfwdZdOgwq014ydUifkKY71uTwZW+FA=;
 b=tes+DVVcdpG03Dn9Tw31BP0INQMgQgPrqGYLaTj1h7SplXB1UFaTi2PJG8ftcMCU9QYD
 Eo6tNMrKDEAkydvDEIeNqfA9c/vcDi0nmNRH90iGATG5RwK+/l/sYhJN10wOczAjk9v9
 zlUaS6pJMh8DIXK5jg2G3MCvv3iB3HZiL0bU70G1b+tzrUqI0psdKZ6RgRR62hC2CgwV
 1Qqu8pX/n9JstY/P+eFIX9aeaBlQ9/8Anh++F9CKPPARd9m0W2Rw3yI6JL5JpHkCSEmo
 zV4cZs97P0uN1XQn4ZN9rRvDH5Wt+z2ZgsWNrlrytmax/wZ+U4Z628UbRR5PHdxBpP5L 7Q== 
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com [169.53.41.122])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rpnnd85e7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 07 Jul 2023 15:55:08 +0000
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
        by ppma04dal.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 367FUH4T029960;
        Fri, 7 Jul 2023 15:55:07 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([9.208.129.120])
        by ppma04dal.us.ibm.com (PPS) with ESMTPS id 3rjbs6emu4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 07 Jul 2023 15:55:07 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
        by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 367Ft6Mc4784750
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 7 Jul 2023 15:55:06 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1D7445806A;
        Fri,  7 Jul 2023 15:55:06 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 519575805A;
        Fri,  7 Jul 2023 15:55:05 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.61.7.157])
        by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Fri,  7 Jul 2023 15:55:05 +0000 (GMT)
Message-ID: <37d03d69a89c344089b4e9d6e5b7b685f1c62cda.camel@linux.ibm.com>
Subject: Re: [PATCH 00/10] ima: measure events between kexec load and execute
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Tushar Sugandhi <tusharsu@linux.microsoft.com>, noodles@fb.com,
        bauermann@kolabnow.com, kexec@lists.infradead.org,
        linux-integrity@vger.kernel.org
Cc:     code@tyhicks.com, nramas@linux.microsoft.com, paul@paul-moore.com
Date:   Fri, 07 Jul 2023 11:55:04 -0400
In-Reply-To: <20230703215709.1195644-1-tusharsu@linux.microsoft.com>
References: <20230703215709.1195644-1-tusharsu@linux.microsoft.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-22.el8) 
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: lyKgLXBeezkCvf8PEscJrRWHsi9hkB42
X-Proofpoint-ORIG-GUID: lyKgLXBeezkCvf8PEscJrRWHsi9hkB42
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-07_10,2023-07-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 malwarescore=0 phishscore=0 spamscore=0 clxscore=1015 suspectscore=0
 adultscore=0 mlxlogscore=999 lowpriorityscore=0 priorityscore=1501
 mlxscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2307070144
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, 2023-07-03 at 14:56 -0700, Tushar Sugandhi wrote:
> The current Kernel behavior is IMA measurements snapshot is taken at
> kexec 'load' and not at kexec 'execute'.  IMA log is then carried
> over to the new Kernel after kexec 'execute'.
> 
> Some devices can be configured to call kexec 'load' first, and followed
> by kexec 'execute' after some time. (as opposed to calling 'load' and
> 'execute' in one single kexec command).  In such scenario, if new IMA
> measurements are added between kexec 'load' and kexec 'execute', the
> TPM PCRs are extended with the IMA events between 'load' and 'execute';
> but those IMA events are not carried over to the new kernel after kexec
> soft reboot.  This results in mismatch between TPM PCR quotes and the
> actual IMA measurements list after the device boots into the new kexec
> image.  This mismatch results in the remote attestation failing for that
> device.
> 
> This patch series proposes a solution to solve this problem by allocating
> the necessary buffer at kexec 'load' time, and populating the buffer
> with the IMA measurements at kexec 'execute' time. 

Thanks, Tushar.   Depending on the IMA policy, the above problem
statement is correct, but not all policies are affected by it.  It's
also unclear why so much needs to change.  Instead of copying the
measurement list at kexec 'load',  using the existing method and simply
copying them at kexec 'exec' would suffice.

Also as mentioned in comment on 3/10, the ordering of this patch set is
not bisect safe.  If the same method of copying the measurement list
was used, changing from copying at  kexec 'load'  to kexec 'exec' could
be done in the same patch.

Mimi

> 
> The solution includes:
>  - addition of new functionality to allocate a buffer to hold IMA
>    measurements at kexec 'load', 
> 
>  - ima functionality to suspend and resume measurements as needed during
>    buffer copy at kexec 'execute',
> 
>  - ima functionality for mapping the measurement list from the current
>    Kernel to the subsequent one, 
> 
>  - necessary changes to the kexec_file_load syscall, enabling it to call
>    the ima functions
> 
>  - registering a reboot notifier which gets called during kexec 'execute',
> 
>  - and removal of deprecated functions.
> 
> The modifications proposed in this series ensure the integrity of the ima
> measurements is preserved across kexec soft reboots, thus significantly
> improving the security of the Kernel post kexec soft reboots.
> 
> There were previous attempts to fix this issue [1], [2], [3].  But they
> were not merged into the mainline Kernel.  
> 
> We took inspiration from the past work [1] and [2] while working on this
> patch series.
> 
> References:
> -----------
> 
> [1] [PATHC v2 5/9] ima: on soft reboot, save the measurement list
> https://lore.kernel.org/lkml/1472596811-9596-6-git-send-email-zohar@linux.vnet.ibm.com/
> 
> [2] PATCH v2 4/6] kexec_file: Add mechanism to update kexec segments.
> https://lkml.org/lkml/2016/8/16/577
> 
> [3] [PATCH 1/6] kexec_file: Add buffer hand-over support
> https://lore.kernel.org/linuxppc-dev/1466473476-10104-6-git-send-email-bauerman@linux.vnet.ibm.com/T/
> 
> Tushar Sugandhi (10):
>   ima: implement function to allocate buffer at kexec load
>   ima: implement function to populate buffer at kexec execute
>   ima: allocate buffer at kexec load to hold ima measurements
>   ima: implement functions to suspend and resume measurements
>   kexec: implement functions to map and unmap segment to kimage
>   ima: update buffer at kexec execute with ima measurements
>   ima: remove function ima_dump_measurement_list
>   ima: implement and register a reboot notifier function to update kexec
>     buffer
>   ima: suspend measurements while the kexec buffer is being copied
>   kexec: update kexec_file_load syscall to call ima_kexec_post_load
> 
>  include/linux/ima.h                |   3 +
>  include/linux/kexec.h              |  13 ++
>  kernel/kexec_core.c                |  72 +++++++++-
>  kernel/kexec_file.c                |   7 +
>  kernel/kexec_internal.h            |   1 +
>  security/integrity/ima/ima.h       |   4 +
>  security/integrity/ima/ima_kexec.c | 211 +++++++++++++++++++++++------
>  security/integrity/ima/ima_queue.c |  32 +++++
>  8 files changed, 295 insertions(+), 48 deletions(-)
> 


