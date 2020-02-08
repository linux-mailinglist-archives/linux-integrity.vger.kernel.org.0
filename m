Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0712515682C
	for <lists+linux-integrity@lfdr.de>; Sun,  9 Feb 2020 00:44:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727543AbgBHXoD (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sat, 8 Feb 2020 18:44:03 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:14720 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727502AbgBHXoC (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sat, 8 Feb 2020 18:44:02 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 018Nd229113788
        for <linux-integrity@vger.kernel.org>; Sat, 8 Feb 2020 18:44:01 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2y1tpa1eyp-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Sat, 08 Feb 2020 18:44:01 -0500
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Sat, 8 Feb 2020 23:43:59 -0000
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Sat, 8 Feb 2020 23:43:55 -0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 018NhslV49414178
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 8 Feb 2020 23:43:54 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E3F8E4203F;
        Sat,  8 Feb 2020 23:43:53 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 421DA42042;
        Sat,  8 Feb 2020 23:43:52 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.161.21])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Sat,  8 Feb 2020 23:43:52 +0000 (GMT)
Subject: Re: [RFC PATCH 0/2] ima: uncompressed module appraisal support
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Eric Snowberg <eric.snowberg@oracle.com>
Cc:     Nayna <nayna@linux.vnet.ibm.com>, dmitry.kasatkin@gmail.com,
        jmorris@namei.org, serge@hallyn.com, dhowells@redhat.com,
        geert@linux-m68k.org, gregkh@linuxfoundation.org,
        nayna@linux.ibm.com, tglx@linutronix.de, bauerman@linux.ibm.com,
        mpe@ellerman.id.au, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Roberto Sassu <roberto.sassu@huawei.com>
Date:   Sat, 08 Feb 2020 18:43:51 -0500
In-Reply-To: <C25E5885-F00B-48C0-AEF1-FA3014B2FDA6@oracle.com>
References: <20200206164226.24875-1-eric.snowberg@oracle.com>
         <5c246616-9a3a-3ed2-c1f9-f634cef511c9@linux.vnet.ibm.com>
         <09D68C13-75E2-4BD6-B4E6-F765B175C7FD@oracle.com>
         <1581087096.5585.597.camel@linux.ibm.com>
         <330BDFAC-E778-4E9D-A2D2-DD81B745F6AB@oracle.com>
         <1581097201.5585.613.camel@linux.ibm.com>
         <764C5FC8-DF0C-4B7A-8B5B-FD8B83F31568@oracle.com>
         <1581100125.5585.623.camel@linux.ibm.com>
         <992E95D5-D4B9-4913-A36F-BB47631DFE0A@oracle.com>
         <1581101672.5585.628.camel@linux.ibm.com>
         <C25E5885-F00B-48C0-AEF1-FA3014B2FDA6@oracle.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 20020823-0028-0000-0000-000003D8C941
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20020823-0029-0000-0000-0000249D3114
Message-Id: <1581205431.5585.645.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-08_08:2020-02-07,2020-02-08 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 spamscore=0 impostorscore=0 lowpriorityscore=0 malwarescore=0 bulkscore=0
 clxscore=1015 mlxlogscore=999 mlxscore=0 suspectscore=0 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002080190
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, 2020-02-07 at 14:38 -0700, Eric Snowberg wrote:
> > On Feb 7, 2020, at 11:54 AM, Mimi Zohar <zohar@linux.ibm.com> wrote:
> > 
> > On Fri, 2020-02-07 at 11:45 -0700, Eric Snowberg wrote:
> >> 
> >>> On Feb 7, 2020, at 11:28 AM, Mimi Zohar <zohar@linux.ibm.com> wrote:
> >>> 
> >>> On Fri, 2020-02-07 at 10:49 -0700, Eric Snowberg wrote:
> >>>> 
> >>>>> On Feb 7, 2020, at 10:40 AM, Mimi Zohar <zohar@linux.ibm.com> wrote:
> >>>>> 
> >>>>>> $ insmod ./foo.ko
> >>>>>> insmod: ERROR: could not insert module ./foo.ko: Permission denied
> >>>>>> 
> >>>>>> last entry from audit log:
> >>>>>> type=INTEGRITY_DATA msg=audit(1581089373.076:83): pid=2874 uid=0
> >>>>>> auid=0 ses=1 subj=unconfined_u:unconfined_r:unconfined_t:s0-
> >>>>>> s0:c0.c1023 op=appraise_data cause=invalid-signature comm="insmod"
> >>>>>> name="/root/keys/modules/foo.ko" dev="dm-0" ino=10918365
> >>>>>> res=0^]UID="root" AUID=“root"
> >>>>>> 
> >>>>>> This is because modsig_verify() will be called from within
> >>>>>> ima_appraise_measurement(), 
> >>>>>> since try_modsig is true.  Then modsig_verify() will return
> >>>>>> INTEGRITY_FAIL.
> >>>>> 
> >>>>> Why is it an "invalid signature"?  For that you need to look at the
> >>>>> kernel messages.  Most likely it can't find the public key on the .ima
> >>>>> keyring to verify the signature.
> >>>> 
> >>>> It is invalid because the module has not been ima signed. 
> >>> 
> >>> With the IMA policy rule "appraise func=MODULE_CHECK
> >>> appraise_type=imasig|modsig", IMA first tries to verify the IMA
> >>> signature stored as an xattr and on failure then attempts to verify
> >>> the appended signatures.
> >>> 
> >>> The audit message above indicates that there was a signature, but the
> >>> signature validation failed.
> >>> 
> >> 
> >> I do have  CONFIG_IMA_APPRAISE_MODSIG enabled.  I believe the audit message above 
> >> is coming from modsig_verify in security/integrity/ima/ima_appraise.c.
> > 
> > Right, and it's calling:
> > 
> > 	rc = integrity_modsig_verify(INTEGRITY_KEYRING_IMA, modsig);
> > 
> > It's failing because it is trying to find the public key on the .ima
> > keyring.  Make sure that the public needed to validate the kernel
> > module is on the IMA keyring (eg. keyctl show %keyring:.ima).
> > 
> 
> I know that will validate the module properly, but that is not what I’m 
> trying to solve here. I thought the point of adding “|modsig” to the
> ima policy was to tell ima it can either validate against an ima keyring OR 
> default back to the kernel keyring.  This is what happens with the compressed
> module.  There isn’t anything in the ima keyring to validate the compressed
> modules and it loads when I add “|modsig”.

"modsig" has nothing to do with keyrings.  The term "modsig" is
juxtaposed to "imasig".  "modsig" refers to kernel module appended
signature. 

> 
> The use case I’m trying to solve is when someone boots with ima_policy=secure_boot.

As the secure_boot policy rules are replaced once a custom policy is
loaded, the "secure_boot" policy should probably be deprecated.  I
highly recommend using the more recent build time and architecture
specific run time policy rules, which persist after loading a custom
policy. 

> If their initramfs contains compressed modules with appended signatures the
> system boots.  If they use the same ima policy with an initramfs that contains
> uncompressed modules, it doesn't boot.  I thought the point of adding “|modsig”
> was to help with the initramfs problem, since it is difficult to ima sign
> things within it.

There have been a number of attempts to address the CPIO problem of
not being able to include security extended attributes in the
initramfs.  If you're interested in solving that problem, then review
and comment on Roberto Sassu's patches[1].

Mimi

[1] https://lkml.org/lkml/2019/5/23/415

