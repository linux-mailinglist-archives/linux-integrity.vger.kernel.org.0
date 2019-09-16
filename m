Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 26198B43D0
	for <lists+linux-integrity@lfdr.de>; Tue, 17 Sep 2019 00:13:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729108AbfIPWNL (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 16 Sep 2019 18:13:11 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:34438 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727719AbfIPWNL (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 16 Sep 2019 18:13:11 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x8GM2MqO054375
        for <linux-integrity@vger.kernel.org>; Mon, 16 Sep 2019 18:13:09 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2v2h81khju-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Mon, 16 Sep 2019 18:13:09 -0400
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Mon, 16 Sep 2019 23:13:08 +0100
Received: from b06avi18626390.portsmouth.uk.ibm.com (9.149.26.192)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 16 Sep 2019 23:13:04 +0100
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x8GMCcq642664314
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 16 Sep 2019 22:12:38 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E69394C046;
        Mon, 16 Sep 2019 22:13:03 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 60F084C040;
        Mon, 16 Sep 2019 22:13:03 +0000 (GMT)
Received: from dhcp-9-31-103-196.watson.ibm.com (unknown [9.31.103.196])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 16 Sep 2019 22:13:03 +0000 (GMT)
Subject: Re: [GIT PULL] integrity subsystem updates for v5.4
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-security-module <linux-security-module@vger.kernel.org>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Date:   Mon, 16 Sep 2019 18:13:02 -0400
In-Reply-To: <CAHk-=whuzoK+sP+feizU520p7ChHqdX8pmwyCnnKTyUNJKngZA@mail.gmail.com>
References: <1568237365.5783.39.camel@linux.ibm.com>
         <CAHk-=whuzoK+sP+feizU520p7ChHqdX8pmwyCnnKTyUNJKngZA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19091622-0028-0000-0000-0000039DCB45
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19091622-0029-0000-0000-0000246041D0
Message-Id: <1568671982.4975.145.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-09-16_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1909160210
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, 2019-09-16 at 13:38 -0700, Linus Torvalds wrote:
> On Wed, Sep 11, 2019 at 2:29 PM Mimi Zohar <zohar@linux.ibm.com> wrote:
> >
> > The major feature in this pull request is IMA support for measuring
> > and appraising appended file signatures.  In addition are a couple of
> > bug fixes and code cleanup to use struct_size().
> 
> How is the file signature any different from (and/or better than) the
> fs-verity support?
> 
> The fs-verity support got fairly extensively discussed, and is
> apparently going to actually be widely used by Android, and it an
> independent feature of any security model.
> 
> What does the IMA version bring to the table?

IMA currently defines a system wide policy for measuring, verifying a
file's integrity (both mutable/immutable files) against known good
values, and adding audit records containing the file hashes.  The
policy isn't hard coded in the kernel, allowing people/companies to
configure it as desired for their specific use case.

Support for appended signatures already exists in the kernel for
kernel modules.  This pull request adds IMA support for appended
signatures in order to verify the kexec kernel image on OpenPOWER, as
part of Secure and Trusted boot enablement.  This would allow distros
to sign kernel images similar to how they currently sign kernel
modules.

IMA verifies file signatures up front, before allowing access to the
file.  fs-verity verifies the signature of the Merkle tree (and other
info), but does not verify the file data at the time of first use.
 There are pros and cons to each of these approaches.

Mimi

