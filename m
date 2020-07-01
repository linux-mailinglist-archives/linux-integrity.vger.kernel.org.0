Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA8982100F7
	for <lists+linux-integrity@lfdr.de>; Wed,  1 Jul 2020 02:29:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725947AbgGAA33 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 30 Jun 2020 20:29:29 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:60194 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725930AbgGAA32 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 30 Jun 2020 20:29:28 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06103Cui003802;
        Tue, 30 Jun 2020 20:29:12 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 31ycjagr6t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 30 Jun 2020 20:29:12 -0400
Received: from m0098414.ppops.net (m0098414.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 0610HYUc048543;
        Tue, 30 Jun 2020 20:29:12 -0400
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0b-001b2d01.pphosted.com with ESMTP id 31ycjagr6c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 30 Jun 2020 20:29:12 -0400
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0610Gn9V032016;
        Wed, 1 Jul 2020 00:29:10 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma06ams.nl.ibm.com with ESMTP id 31wwch3y1n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 01 Jul 2020 00:29:10 +0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0610T8IR55246888
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 1 Jul 2020 00:29:08 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E648042041;
        Wed,  1 Jul 2020 00:29:07 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 666004203F;
        Wed,  1 Jul 2020 00:29:06 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.162.223])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed,  1 Jul 2020 00:29:06 +0000 (GMT)
Message-ID: <1593563340.5057.14.camel@linux.ibm.com>
Subject: Re: [PATCH v2 00/11] ima: Fix rule parsing bugs and extend
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
        kexec@lists.infradead.org, Casey Schaufler <casey@schaufler-ca.com>
Date:   Tue, 30 Jun 2020 20:29:00 -0400
In-Reply-To: <20200626223900.253615-1-tyhicks@linux.microsoft.com>
References: <20200626223900.253615-1-tyhicks@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-06-30_06:2020-06-30,2020-06-30 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 impostorscore=0 mlxlogscore=999 lowpriorityscore=0 spamscore=0
 priorityscore=1501 phishscore=0 suspectscore=2 adultscore=0
 cotscore=-2147483648 bulkscore=0 clxscore=1015 mlxscore=0 classifier=spam
 adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006300167
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, 2020-06-26 at 17:38 -0500, Tyler Hicks wrote:
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
> I envision patches 1-6 going to stable. The series is ordered in a way
> that has all the fixes up front, followed by cleanups, followed by the
> feature patch. The breakdown of patches looks like so:
> 
>  Memory leak fixes: 1-3
>  Parser strictness fixes: 4-6
>  Code cleanups made possible by the fixes: 7-10
>  Extend KEXEC_CMDLINE rule support: 11
> 
> Perhaps the most logical ordering for code review is:
> 
>  1, 2, 3, 7, 8, 4, 5, 6, 9, 10, 11
> 
> If you'd like me to re-order or split up the series, just let me know.
> Thanks for considering these patches!
> 
> * Series-wide v2 changes
>   - Rebased onto next-integrity-testing
>   - Squashed patches 2 and 3 from v1
>     + Updated this cover letter to account for changes to patch index
>       changes
>     + See patch 2 for specific code changes

Other than the comment on 9/11 the patch set looks good.

thanks!

Mimi
