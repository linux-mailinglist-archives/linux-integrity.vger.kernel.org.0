Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2DA28155D08
	for <lists+linux-integrity@lfdr.de>; Fri,  7 Feb 2020 18:40:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727028AbgBGRkM (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 7 Feb 2020 12:40:12 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:56368 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727114AbgBGRkM (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 7 Feb 2020 12:40:12 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 017Hd4Vm027216
        for <linux-integrity@vger.kernel.org>; Fri, 7 Feb 2020 12:40:11 -0500
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2y0mppmj2e-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Fri, 07 Feb 2020 12:40:11 -0500
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Fri, 7 Feb 2020 17:40:09 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 7 Feb 2020 17:40:05 -0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 017He3kU49479916
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 7 Feb 2020 17:40:03 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C40724C052;
        Fri,  7 Feb 2020 17:40:03 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 441914C040;
        Fri,  7 Feb 2020 17:40:02 +0000 (GMT)
Received: from dhcp-9-31-103-165.watson.ibm.com (unknown [9.31.103.165])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri,  7 Feb 2020 17:40:02 +0000 (GMT)
Subject: Re: [RFC PATCH 0/2] ima: uncompressed module appraisal support
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Eric Snowberg <eric.snowberg@oracle.com>
Cc:     Nayna <nayna@linux.vnet.ibm.com>, dmitry.kasatkin@gmail.com,
        jmorris@namei.org, serge@hallyn.com, dhowells@redhat.com,
        geert@linux-m68k.org, gregkh@linuxfoundation.org,
        nayna@linux.ibm.com, tglx@linutronix.de, bauerman@linux.ibm.com,
        mpe@ellerman.id.au, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Fri, 07 Feb 2020 12:40:01 -0500
In-Reply-To: <330BDFAC-E778-4E9D-A2D2-DD81B745F6AB@oracle.com>
References: <20200206164226.24875-1-eric.snowberg@oracle.com>
         <5c246616-9a3a-3ed2-c1f9-f634cef511c9@linux.vnet.ibm.com>
         <09D68C13-75E2-4BD6-B4E6-F765B175C7FD@oracle.com>
         <1581087096.5585.597.camel@linux.ibm.com>
         <330BDFAC-E778-4E9D-A2D2-DD81B745F6AB@oracle.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 20020717-0008-0000-0000-00000350C7B9
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20020717-0009-0000-0000-00004A715FB8
Message-Id: <1581097201.5585.613.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-07_04:2020-02-07,2020-02-07 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 mlxlogscore=999 clxscore=1015 suspectscore=3 lowpriorityscore=0
 adultscore=0 malwarescore=0 impostorscore=0 phishscore=0 mlxscore=0
 bulkscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002070130
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, 2020-02-07 at 09:57 -0700, Eric Snowberg wrote:
> > On Feb 7, 2020, at 7:51 AM, Mimi Zohar <zohar@linux.ibm.com> wrote:
> > 
> > On Thu, 2020-02-06 at 14:40 -0700, Eric Snowberg wrote:
> > 
> > <snip>
> > 
> >> Currently the upstream code will fail if the module is uncompressed.
> >> If you compress the same module it will load with the current
> >> upstream code.
> >> 
> >>> Lastly, there is nothing in these patches that indicate that the
> >> kernel modules being compressed/uncompressed is related to the
> >> signature verification.
> >>>  
> >> 
> >> Basically if you have the following setup:
> >> 
> >> Kernel built with CONFIG_IMA_ARCH_POLICY or kernel booted with
> >> module.sig_enforce=1 along with the following ima policy:
> >> 
> >> appraise func=MODULE_CHECK appraise_type=imasig|modsig
> > 
> > Enabling CONFIG_IMA_ARCH_POLICY or module.sig_enforce=1 behave totally
> > differently.  CONFIG_IMA_ARCH_POLICY coordinates between the IMA
> > signature verification and the original module_sig_check()
> > verification.  Either one signature verification method is enabled or
> > the other, but not both.
> > 
> > The existing IMA x86 arch policy has not been updated to support
> > appended signatures.
> 
> That is not what I’m seeing.  Appended signatures mostly work.  They just
> don’t work thru the finit_module system call.
> 
> > To understand what is happening, we need to analyze each scenario
> > separately.
> > 
> > - If CONFIG_MODULE_SIG is configured or enabled on the boot command
> > line ("module.sig_enforce = 1"), then the IMA arch x86 policy WILL NOT
> > require an IMA signature.
> 
> All tests below are without my change
> x86 booted with module.sig_enforce=1
> 
> empty ima policy

Sure, in this example the IMA arch x86 policy is not configured and
there is no custom IMA policy - no IMA.

> $ cat /sys/kernel/security/ima/policy

On a real system, you would want to require a signed IMA policy.

> $ insmod ./foo.ko.xz   <— loads ok
> $ rmmod foo
> $ unxz ./foo.ko.xz
> $ insmod ./foo.ko      <— loads ok
> $ rmmod foo
> 
> add in module appraisal 

Sure, the current system 

> $ echo "appraise func=MODULE_CHECK appraise_type=imasig|modsig" >
> /sys/kernel/security/ima/policy
> 
> $ insmod ./foo.ko.xz   <— loads ok
> $ rmmod foo

Sure, CONFIG_MODULE_SIG is configured or enabled on the boot command
line ("module.sig_enforce = 1").  IMA won't prevent the init_module()
syscall.

> 
> $ insmod ./foo.ko
> insmod: ERROR: could not insert module ./foo.ko: Permission denied
> 
> last entry from audit log:
> type=INTEGRITY_DATA msg=audit(1581089373.076:83): pid=2874 uid=0
> auid=0 ses=1 subj=unconfined_u:unconfined_r:unconfined_t:s0-
> s0:c0.c1023 op=appraise_data cause=invalid-signature comm="insmod"
> name="/root/keys/modules/foo.ko" dev="dm-0" ino=10918365
> res=0^]UID="root" AUID=“root"
> 
> This is because modsig_verify() will be called from within
> ima_appraise_measurement(), 
> since try_modsig is true.  Then modsig_verify() will return
> INTEGRITY_FAIL.

Why is it an "invalid signature"?  For that you need to look at the
kernel messages.  Most likely it can't find the public key on the .ima
keyring to verify the signature.

Mimi

