Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F21A9223264
	for <lists+linux-integrity@lfdr.de>; Fri, 17 Jul 2020 06:31:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726026AbgGQEbv (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 17 Jul 2020 00:31:51 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:11628 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725300AbgGQEbv (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 17 Jul 2020 00:31:51 -0400
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06H42ODm166954;
        Fri, 17 Jul 2020 00:31:44 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 32792xvu7e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 17 Jul 2020 00:31:44 -0400
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 06H436Yn168882;
        Fri, 17 Jul 2020 00:31:44 -0400
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 32792xvu5c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 17 Jul 2020 00:31:44 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 06H4U3D9020944;
        Fri, 17 Jul 2020 04:31:37 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma04ams.nl.ibm.com with ESMTP id 329nmyjgaq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 17 Jul 2020 04:31:37 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 06H4UCbl64160158
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 Jul 2020 04:30:12 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9365E4203F;
        Fri, 17 Jul 2020 04:31:35 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0E81342041;
        Fri, 17 Jul 2020 04:31:34 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.163.162])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 17 Jul 2020 04:31:33 +0000 (GMT)
Message-ID: <1594960293.27397.2.camel@linux.ibm.com>
Subject: Re: [PATCH v3 00/12] ima: Fix rule parsing bugs and extend
 KEXEC_CMDLINE rule support
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Tyler Hicks <tyhicks@linux.microsoft.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
Cc:     James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        Prakhar Srivastava <prsriva02@gmail.com>,
        linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Janne Karhunen <janne.karhunen@gmail.com>,
        Eric Biederman <ebiederm@xmission.com>,
        kexec@lists.infradead.org,
        Casey Schaufler <casey@schaufler-ca.com>,
        Nayna Jain <nayna@linux.ibm.com>
Date:   Fri, 17 Jul 2020 00:31:33 -0400
In-Reply-To: <20200709061911.954326-1-tyhicks@linux.microsoft.com>
References: <20200709061911.954326-1-tyhicks@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-16_11:2020-07-16,2020-07-16 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_spam_definite policy=outbound score=100 suspectscore=0
 mlxlogscore=-1000 priorityscore=1501 lowpriorityscore=0 clxscore=1015
 adultscore=0 impostorscore=0 spamscore=100 malwarescore=0 bulkscore=0
 mlxscore=100 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007170025
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, 2020-07-09 at 01:18 -0500, Tyler Hicks wrote:
> This series ultimately extends the supported IMA rule conditionals for
> the KEXEC_CMDLINE hook function. As of today, there's an imbalance in
> IMA language conditional support for KEXEC_CMDLINE rules in comparison
> to KEXEC_KERNEL_CHECK and KEXEC_INITRAMFS_CHECK rules. The KEXEC_CMDLINE
> rules do not support *any* conditionals so you cannot have a sequence of
> rules like this:
> 
>  dont_measure func=KEXEC_KERNEL_CHECK obj_type=foo_t
>  dont_measure func=KEXEC_INITRAMFS_CHECK obj_type=foo_t
>  dont_measure func=KEXEC_CMDLINE obj_type=foo_t
>  measure func=KEXEC_KERNEL_CHECK
>  measure func=KEXEC_INITRAMFS_CHECK
>  measure func=KEXEC_CMDLINE
> 
> Instead, KEXEC_CMDLINE rules can only be measured or not measured and
> there's no additional flexibility in today's implementation of the
> KEXEC_CMDLINE hook function.
> 
> With this series, the above sequence of rules becomes valid and any
> calls to kexec_file_load() with a kernel and initramfs inode type of
> foo_t will not be measured (that includes the kernel cmdline buffer)
> while all other objects given to a kexec_file_load() syscall will be
> measured. There's obviously not an inode directly associated with the
> kernel cmdline buffer but this patch series ties the inode based
> decision making for KEXEC_CMDLINE to the kernel's inode. I think this
> will be intuitive to policy authors.
> 
> While reading IMA code and preparing to make this change, I realized
> that the buffer based hook functions (KEXEC_CMDLINE and KEY_CHECK) are
> quite special in comparison to longer standing hook functions. These
> buffer based hook functions can only support measure actions and there
> are some restrictions on the conditionals that they support. However,
> the rule parser isn't enforcing any of those restrictions and IMA policy
> authors wouldn't have any immediate way of knowing that the policy that
> they wrote is invalid. For example, the sequence of rules above parses
> successfully in today's kernel but the
> "dont_measure func=KEXEC_CMDLINE ..." rule is incorrectly handled in
> ima_match_rules(). The dont_measure rule is *always* considered to be a
> match so, surprisingly, no KEXEC_CMDLINE measurements are made.
> 
> While making the rule parser more strict, I realized that the parser
> does not correctly free all of the allocated memory associated with an
> ima_rule_entry when going down some error paths. Invalid policy loaded
> by the policy administrator could result in small memory leaks.
> 
> I envision patches 1-7 going to stable. The series is ordered in a way
> that has all the fixes up front, followed by cleanups, followed by the
> feature patch. The breakdown of patches looks like so:
> 
>  Memory leak fixes: 1-3
>  Parser strictness fixes: 4-7
>  Code cleanups made possible by the fixes: 8-11
>  Extend KEXEC_CMDLINE rule support: 12

Thanks, Tyler.  This is a really nice patch set.  The patches are now
in the "next-integrity-testing" branch.

Mimi
