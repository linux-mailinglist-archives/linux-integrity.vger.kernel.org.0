Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9D8D4155A14
	for <lists+linux-integrity@lfdr.de>; Fri,  7 Feb 2020 15:51:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727144AbgBGOvu (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 7 Feb 2020 09:51:50 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:58222 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726867AbgBGOvt (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 7 Feb 2020 09:51:49 -0500
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 017Eln86036330
        for <linux-integrity@vger.kernel.org>; Fri, 7 Feb 2020 09:51:48 -0500
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2y0nruan9f-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Fri, 07 Feb 2020 09:51:47 -0500
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Fri, 7 Feb 2020 14:51:44 -0000
Received: from b06avi18626390.portsmouth.uk.ibm.com (9.149.26.192)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 7 Feb 2020 14:51:40 -0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 017EojeT38863280
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 7 Feb 2020 14:50:45 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9CCC74C044;
        Fri,  7 Feb 2020 14:51:38 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 015AF4C040;
        Fri,  7 Feb 2020 14:51:37 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.80.201.239])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri,  7 Feb 2020 14:51:36 +0000 (GMT)
Subject: Re: [RFC PATCH 0/2] ima: uncompressed module appraisal support
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Eric Snowberg <eric.snowberg@oracle.com>,
        Nayna <nayna@linux.vnet.ibm.com>
Cc:     dmitry.kasatkin@gmail.com, jmorris@namei.org, serge@hallyn.com,
        dhowells@redhat.com, geert@linux-m68k.org,
        gregkh@linuxfoundation.org, nayna@linux.ibm.com,
        tglx@linutronix.de, bauerman@linux.ibm.com, mpe@ellerman.id.au,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Fri, 07 Feb 2020 09:51:36 -0500
In-Reply-To: <09D68C13-75E2-4BD6-B4E6-F765B175C7FD@oracle.com>
References: <20200206164226.24875-1-eric.snowberg@oracle.com>
         <5c246616-9a3a-3ed2-c1f9-f634cef511c9@linux.vnet.ibm.com>
         <09D68C13-75E2-4BD6-B4E6-F765B175C7FD@oracle.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 20020714-4275-0000-0000-0000039EF3C5
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20020714-4276-0000-0000-000038B323FD
Message-Id: <1581087096.5585.597.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-07_01:2020-02-07,2020-02-07 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 bulkscore=0
 mlxlogscore=999 adultscore=0 phishscore=0 lowpriorityscore=0
 priorityscore=1501 suspectscore=0 clxscore=1015 spamscore=0 malwarescore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002070113
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, 2020-02-06 at 14:40 -0700, Eric Snowberg wrote:

<snip>

> Currently the upstream code will fail if the module is uncompressed.
>  If you compress the same module it will load with the current
> upstream code.
> 
> > Lastly, there is nothing in these patches that indicate that the
> kernel modules being compressed/uncompressed is related to the
> signature verification.
> > 
> 
> Basically if you have the following setup:
> 
> Kernel built with CONFIG_IMA_ARCH_POLICY or kernel booted with
> module.sig_enforce=1 along with the following ima policy:
> 
> appraise func=MODULE_CHECK appraise_type=imasig|modsig

Enabling CONFIG_IMA_ARCH_POLICY or module.sig_enforce=1 behave totally
differently.  CONFIG_IMA_ARCH_POLICY coordinates between the IMA
signature verification and the original module_sig_check()
verification.  Either one signature verification method is enabled or
the other, but not both.

The existing IMA x86 arch policy has not been updated to support
appended signatures.

To understand what is happening, we need to analyze each scenario
separately.

- If CONFIG_MODULE_SIG is configured or enabled on the boot command
line ("module.sig_enforce = 1"), then the IMA arch x86 policy WILL NOT
require an IMA signature.

- If CONFIG_MODULE_SIG is NOT configured or enabled on the boot
command line, then the IMA arch x86 policy WILL require an IMA
signature.

- If CONFIG_MODULE_SIG is configured or enabled on the boot command
line, the IMA arch x86 policy is not configured, and the above policy
rule is defined, an appended signature will be verified by both IMA
and module_sig_check().
  
> 
> If you have a module foo.ko that contains a valid appended signature
> but is not ima signed, it will fail to load.

That would only happen in the second scenario or in the last scenario
if the key is not found.

> Now if the end user simply compresses the same foo.ko, making it
> foo.ko.xz.  The module will load.

This implies that CONFIG_MODULE_SIG is configured or enabled on the
boot command line, like the first scenario described above, or in the
last scenario and the key is found.

> 
> Modules can be loaded thru two different syscalls, finit_module and
> init_module.  The changes added in [1] work if you use the
> init_module syscall.  My change adds support when the finit_module
> syscall gets used instead.

With the IMA arch x86 policy, without CONFIG_MODULE_SIG configured or
enabled on the boot command line, IMA will prevent the init_module()
syscall.  This is intentional.

Your second patch (2/2) changes the arch x86 policy rule to allow
appended signatures.  The reason for any other changes needs to be
clearer.  I suggest you look at the audit log and kernel messages, as
well as the kexec selftests, to better understand what is happening.

Mimi

