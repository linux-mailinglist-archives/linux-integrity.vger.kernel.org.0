Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C61E026E46C
	for <lists+linux-integrity@lfdr.de>; Thu, 17 Sep 2020 20:48:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726328AbgIQSsf (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 17 Sep 2020 14:48:35 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:60846 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726501AbgIQSqT (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 17 Sep 2020 14:46:19 -0400
X-Greylist: delayed 2066 seconds by postgrey-1.27 at vger.kernel.org; Thu, 17 Sep 2020 14:46:17 EDT
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 08HI1wBt172560;
        Thu, 17 Sep 2020 14:11:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : date : in-reply-to : references : content-type : mime-version
 : content-transfer-encoding; s=pp1;
 bh=qY5e9UVjq+2zreMlkUsa7zFIJUYuBG6BNZQ91VjcNxQ=;
 b=eMgn2KgPNWA9nIIZD8MvmDOmih+cF1gI8wMRVYjBUBr6/TK972AtarkaOxawugjQle2N
 ZEmi2y1tDcL+Sur3hhMN2r1Eja6unkLShQrts04jQdgGwndgD9kzO4MqVUnbR9fD8kMr
 AlxrkGT62Hmm+3wLF5gz88GHpwJltnsdRNYVf3kbp7OY/YydDUegBQFfA8DA2zIY8yjR
 BXXA8VpdBXgZOodeZ8Uawv9tAwQ9GaB/SawwBeYGRfYxa64hAL96cP7kRxroLJyHcm72
 D2n6xjxs+NZaNMzqUsYsowJQAz0gjayPWKevmjCKWesEEf/5zt7OLk9GVVInuGMurDdO 7Q== 
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0b-001b2d01.pphosted.com with ESMTP id 33mc4eh8qt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 17 Sep 2020 14:11:37 -0400
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 08HI7TQa026049;
        Thu, 17 Sep 2020 18:11:35 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma04fra.de.ibm.com with ESMTP id 33k64s97wq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 17 Sep 2020 18:11:35 +0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 08HIBWXM32899520
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 17 Sep 2020 18:11:32 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8313F42052;
        Thu, 17 Sep 2020 18:11:32 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 06F9642042;
        Thu, 17 Sep 2020 18:11:32 +0000 (GMT)
Received: from sig-9-65-208-105.ibm.com (unknown [9.65.208.105])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 17 Sep 2020 18:11:31 +0000 (GMT)
Message-ID: <2ba01c4961b2b967bb314e2d618a92e91d4fe511.camel@linux.ibm.com>
Subject: Re: LSM that blocks execution of the code from the anonymous pages
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Igor Zhbanov <i.zhbanov@omprussia.ru>,
        linux-integrity <linux-integrity@vger.kernel.org>
Date:   Thu, 17 Sep 2020 14:11:31 -0400
In-Reply-To: <5f166ecd-38e4-a808-c377-683aabf6bf65@omprussia.ru>
References: <5f166ecd-38e4-a808-c377-683aabf6bf65@omprussia.ru>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-12.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-17_13:2020-09-16,2020-09-17 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 lowpriorityscore=0 mlxlogscore=999 bulkscore=0 clxscore=1015
 suspectscore=8 phishscore=0 adultscore=0 mlxscore=0 malwarescore=0
 spamscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2006250000 definitions=main-2009170130
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Igor,

Sorry for the delay in responding.

On Thu, 2020-09-03 at 19:20 +0300, Igor Zhbanov wrote:
> Hello!
> 
> Earlier in the therad "Should mprotect(..., PROT_EXEC) be checked by IMA?"
> we've discussed whether IMA should intercept making executable of anonymous
> pages.
> 
> I've implemented simple LSM that blocks execution of the code from anonymous
> pages, like: mmap(RW) + read_unsigned_code_from_file() + mprotect(RX).
> 
> Currently it uses hooks similar to selinux_mmap_file() and
> selinux_file_mprotect() to restrict any privileged processes (any uid is 0,
> or any gid is 0 or any capability is set) from executing of anonymous unsigned
> code.
> 
> The IMA module is specializing in file-backed (non-anonymous) code integrity
> measurement while allowing execution of arbitrary anonymous code. In
> conjunction with my LSM it would be possible to be sure that any code that is
> executed on a device is trusted.
> 
> This would prevent malware payloads from being downloaded and executed in
> both file-backed and anonymous memory. For example, there is even a framework
> for making of filless malware:
> https://www.prodefence.org/fireelf-fileless-linux-malware-framework/
> Also there is an article about execution of ELFs from memory:
> https://magisterquis.github.io/2018/03/31/in-memory-only-elf-execution.html
> https://blog.fbkcs.ru/elf-in-memory-execution/
> 
> So it could be an independent LSM or extension of the LSM IMA functionality.
> 
> Also I'm thinking about extending working modes to:
> 1) no anonomous code for privileged processes (as currently),
> 2) no anonomous code for all processes,
> 3) no anonomous code for all processes with xattr-based exceptions (may be
>     with xattr value signing)
> 
> I've found that some applications like browsers are using anonymous code
> pages for JavaScript JIT code. Also some processes are using libffi that also
> modifies to code. But it looks like it's possible to rebuild libffi with
> trampoline support (PaX compatibility mode) to avoid altering the code pages.
> Also QML-based application also use JS JIT. (And may be python scripts too.)
> 
> So for some (mostly unprivileged processes) we would need to make the
> exceptions. But for most of the privileged system services (that is a good
> target for attack because of their ptivileges) there is no need in code pages
> modification, so the proposed functionality could be used to protect them,
> as well as in embedded world where could be no user processes with JIT at all.
> 
> So IMA with this LSM would ensure that all the code that is executes is
> trusted, signed and verified.
> 
> What do you think?

Preventing malware payloads from being downloaded and executed as
either file-backed or from anonymous memory is really important.  As
long as IMA has the ability to define a system wide integrity policy,
it doesn't make a difference whether blocking anonymous pages is part
of IMA or as a separate LSM.

If it's a separate LSM, then IMA would delegate responsibility for
enforcing the IMA policy to the LSM.

thanks,

Mimi

