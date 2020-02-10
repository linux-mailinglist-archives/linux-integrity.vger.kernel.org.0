Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 313521580A0
	for <lists+linux-integrity@lfdr.de>; Mon, 10 Feb 2020 18:09:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727587AbgBJRJ2 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 10 Feb 2020 12:09:28 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:24430 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728000AbgBJRJ2 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 10 Feb 2020 12:09:28 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01AH910o156445
        for <linux-integrity@vger.kernel.org>; Mon, 10 Feb 2020 12:09:27 -0500
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2y1umrx4kn-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Mon, 10 Feb 2020 12:09:27 -0500
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Mon, 10 Feb 2020 17:09:24 -0000
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 10 Feb 2020 17:09:20 -0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 01AH9JaV54722608
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 10 Feb 2020 17:09:19 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 37CC7AE053;
        Mon, 10 Feb 2020 17:09:19 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 74A1FAE051;
        Mon, 10 Feb 2020 17:09:17 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.140.79])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 10 Feb 2020 17:09:17 +0000 (GMT)
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
Date:   Mon, 10 Feb 2020 12:09:16 -0500
In-Reply-To: <0F13CB66-6962-44AC-A20D-CCBD82B43625@oracle.com>
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
         <1581205431.5585.645.camel@linux.ibm.com>
         <0F13CB66-6962-44AC-A20D-CCBD82B43625@oracle.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 20021017-0012-0000-0000-000003859095
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20021017-0013-0000-0000-000021C20928
Message-Id: <1581354556.5585.827.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-10_06:2020-02-10,2020-02-10 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 bulkscore=0
 spamscore=0 priorityscore=1501 clxscore=1015 impostorscore=0
 malwarescore=0 phishscore=0 suspectscore=0 mlxscore=0 mlxlogscore=999
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002100129
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, 2020-02-10 at 09:34 -0700, Eric Snowberg wrote:
> > On Feb 8, 2020, at 4:43 PM, Mimi Zohar <zohar@linux.ibm.com> wrote:
> > 
> > On Fri, 2020-02-07 at 14:38 -0700, Eric Snowberg wrote:
> >>> On Feb 7, 2020, at 11:54 AM, Mimi Zohar <zohar@linux.ibm.com> wrote:
> >>> 
> >>> On Fri, 2020-02-07 at 11:45 -0700, Eric Snowberg wrote:
> >>>> 
> >>>>> On Feb 7, 2020, at 11:28 AM, Mimi Zohar <zohar@linux.ibm.com> wrote:
> >>>>> 
> >>>>> On Fri, 2020-02-07 at 10:49 -0700, Eric Snowberg wrote:
> >>>>>> 
> >>>>>>> On Feb 7, 2020, at 10:40 AM, Mimi Zohar <zohar@linux.ibm.com> wrote:
> >>>>>>> 
> >>>>>>>> $ insmod ./foo.ko
> >>>>>>>> insmod: ERROR: could not insert module ./foo.ko: Permission denied
> >>>>>>>> 
> >>>>>>>> last entry from audit log:
> >>>>>>>> type=INTEGRITY_DATA msg=audit(1581089373.076:83): pid=2874 uid=0
> >>>>>>>> auid=0 ses=1 subj=unconfined_u:unconfined_r:unconfined_t:s0-
> >>>>>>>> s0:c0.c1023 op=appraise_data cause=invalid-signature comm="insmod"
> >>>>>>>> name="/root/keys/modules/foo.ko" dev="dm-0" ino=10918365
> >>>>>>>> res=0^]UID="root" AUID=“root"
> >>>>>>>> 
> >>>>>>>> This is because modsig_verify() will be called from within
> >>>>>>>> ima_appraise_measurement(), 
> >>>>>>>> since try_modsig is true.  Then modsig_verify() will return
> >>>>>>>> INTEGRITY_FAIL.
> >>>>>>> 
> >>>>>>> Why is it an "invalid signature"?  For that you need to look at the
> >>>>>>> kernel messages.  Most likely it can't find the public key on the .ima
> >>>>>>> keyring to verify the signature.
> >>>>>> 
> >>>>>> It is invalid because the module has not been ima signed. 
> >>>>> 
> >>>>> With the IMA policy rule "appraise func=MODULE_CHECK
> >>>>> appraise_type=imasig|modsig", IMA first tries to verify the IMA
> >>>>> signature stored as an xattr and on failure then attempts to verify
> >>>>> the appended signatures.
> >>>>> 
> >>>>> The audit message above indicates that there was a signature, but the
> >>>>> signature validation failed.
> >>>>> 
> >>>> 
> >>>> I do have  CONFIG_IMA_APPRAISE_MODSIG enabled.  I believe the audit message above 
> >>>> is coming from modsig_verify in security/integrity/ima/ima_appraise.c.
> >>> 
> >>> Right, and it's calling:
> >>> 
> >>> 	rc = integrity_modsig_verify(INTEGRITY_KEYRING_IMA, modsig);
> >>> 
> >>> It's failing because it is trying to find the public key on the .ima
> >>> keyring.  Make sure that the public needed to validate the kernel
> >>> module is on the IMA keyring (eg. keyctl show %keyring:.ima).
> >>> 
> >> 
> >> I know that will validate the module properly, but that is not what I’m 
> >> trying to solve here. I thought the point of adding “|modsig” to the
> >> ima policy was to tell ima it can either validate against an ima keyring OR 
> >> default back to the kernel keyring.  This is what happens with the compressed
> >> module.  There isn’t anything in the ima keyring to validate the compressed
> >> modules and it loads when I add “|modsig”.
> > 
> > "modsig" has nothing to do with keyrings.  The term "modsig" is
> > juxtaposed to "imasig".  "modsig" refers to kernel module appended
> > signature. 
> 
> Ok, understood, “modsig” refers to strictly kernel module appended signatures
> without regard to the keyring that verifies it.  Since there are inconsistencies
> here, would you consider something like my first patch?  It will verify an 
> uncompressed kernel module containing an appended signature  when the public key
> is contained within the kernel keyring instead of the ima keyring.  Why force a 
> person to add the same keys into the ima keyring for validation?  Especially when
> the kernel keyring is now used to verify appended signatures in the compressed
> modules.

Different use case scenarios have different requirements.  Suppose for
example that the group creating the kernel image is not the same as
using it.  The group using the kernel image could sign all files,
including kernel modules (imasig), with their own private key. Only
files that they signed would be permitted.  Your proposal would break
the current expectations, allowing kernel modules signed by someone
else to be loaded.

Mimi

