Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C3B18C092F
	for <lists+linux-integrity@lfdr.de>; Fri, 27 Sep 2019 18:08:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727872AbfI0QIS (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 27 Sep 2019 12:08:18 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:39144 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727273AbfI0QIR (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 27 Sep 2019 12:08:17 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x8RFvILT098761
        for <linux-integrity@vger.kernel.org>; Fri, 27 Sep 2019 12:08:16 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2v9n1a1eyd-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Fri, 27 Sep 2019 12:08:16 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Fri, 27 Sep 2019 17:08:14 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 27 Sep 2019 17:08:12 +0100
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x8RG8Brx51904738
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 27 Sep 2019 16:08:11 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EEE7C4C040;
        Fri, 27 Sep 2019 16:08:10 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 47C984C046;
        Fri, 27 Sep 2019 16:08:10 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.141.201])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 27 Sep 2019 16:08:10 +0000 (GMT)
Subject: Re: [GIT PULL] integrity subsystem updates for v5.4
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-security-module <linux-security-module@vger.kernel.org>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Date:   Fri, 27 Sep 2019 12:08:09 -0400
In-Reply-To: <1568671982.4975.145.camel@linux.ibm.com>
References: <1568237365.5783.39.camel@linux.ibm.com>
         <CAHk-=whuzoK+sP+feizU520p7ChHqdX8pmwyCnnKTyUNJKngZA@mail.gmail.com>
         <1568671982.4975.145.camel@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19092716-0016-0000-0000-000002B15DC2
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19092716-0017-0000-0000-000033123110
Message-Id: <1569600489.10820.77.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-09-27_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1909270144
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, 2019-09-16 at 18:13 -0400, Mimi Zohar wrote:
> On Mon, 2019-09-16 at 13:38 -0700, Linus Torvalds wrote:
> > On Wed, Sep 11, 2019 at 2:29 PM Mimi Zohar <zohar@linux.ibm.com> wrote:
> > >
> > > The major feature in this pull request is IMA support for measuring
> > > and appraising appended file signatures.  In addition are a couple of
> > > bug fixes and code cleanup to use struct_size().
> > 
> > How is the file signature any different from (and/or better than) the
> > fs-verity support?
> > 
> > The fs-verity support got fairly extensively discussed, and is
> > apparently going to actually be widely used by Android, and it an
> > independent feature of any security model.
> > 
> > What does the IMA version bring to the table?
> 
> IMA currently defines a system wide policy for measuring, verifying a
> file's integrity (both mutable/immutable files) against known good
> values, and adding audit records containing the file hashes.  The
> policy isn't hard coded in the kernel, allowing people/companies to
> configure it as desired for their specific use case.
> 
> Support for appended signatures already exists in the kernel for
> kernel modules.  This pull request adds IMA support for appended
> signatures in order to verify the kexec kernel image on OpenPOWER, as
> part of Secure and Trusted boot enablement.  This would allow distros
> to sign kernel images similar to how they currently sign kernel
> modules.
> 
> IMA verifies file signatures up front, before allowing access to the
> file.  fs-verity verifies the signature of the Merkle tree (and other
> info), but does not verify the file data at the time of first use.
>  There are pros and cons to each of these approaches.

My writing tends to be brief, hopefully concise.  I assume if you had
further questions you would have asked.

This pull request contained a lot of refactoring of the existing
appended signature verification code, so that IMA could retain the
existing framework of calculating the file hash once, storing it in
the IMA measurement list and extending the TPM, verifying the file's
integrity based on a file hash or signature (eg. xattrs), and adding
an audit record containing the file hash, all based on policy.  (The
IMA support for appended signatures patch set was posted and reviewed
11 times.)

The support for appended signature paves the way for adding other
signature verification methods, such as fs-verity, based on a single
system-wide policy.  The file hash used for verifying the signature
and the signature, itself, can be included in the IMA measurement
list.

Originally, IMA & EVM were limited to local kernel file systems, based
on i_version, but have been extended to support filesystems that don't
support i_version and for FUSE.  There are additional discussions for
extending IMA to support remote filesystems (eg. IETF NFS draft).  IMA
by itself isn't enough, since the remote file isn't pinned in memory,
but will need to be dependent on fs-verity.

Nayna Jain re-posted a patch set (v6) titled "powerpc: Enabling IMA
arch specific secure boot policies".  The changes are based on Michael
Ellerman's review.

thanks,

Mimi

