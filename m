Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 659F7480B20
	for <lists+linux-integrity@lfdr.de>; Tue, 28 Dec 2021 17:13:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235639AbhL1QNY (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 28 Dec 2021 11:13:24 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:4814 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S235159AbhL1QNY (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 28 Dec 2021 11:13:24 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1BSFCVNu006099;
        Tue, 28 Dec 2021 16:13:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=CY/iHcuqIuOJhmjBuEoca5VupyhmKyENXIeab4oTWzQ=;
 b=l1dFH0SEHPaN/EwJ4bLU5okUayHlHYLvdt+N+tMw/8pfK9tmDXgTC86zFzTtm9YhAGu+
 xnS5Da799NvjjCZgWZcYtPbTUbm3SNsOo8zlpp/k/SafgOEHc/g5HyvAZrWO3bjFKP78
 m57ZJkREAjc7bHX/P5fDUXXPZrExmIuOEJldd/3yFpSMWyecvF16HDIr1xNQANQlyasI
 Xx06fk7HVBxQws1101Y7QSn5YkyKZw2Ng2SAovWpABfLLrIdGK9YWRtLDipwwPbmtgVk
 +WCJpfUYtR8q5cMDuRJu2LncroJ5VW/7fuTPfMSsyuACQQGZ9gRNpMx/ntNwFSjB57AM WQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3d850uh3fs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 28 Dec 2021 16:13:18 +0000
Received: from m0098413.ppops.net (m0098413.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1BSFkk9B018688;
        Tue, 28 Dec 2021 16:13:17 GMT
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3d850uh3f9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 28 Dec 2021 16:13:17 +0000
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1BSG8Jlg008324;
        Tue, 28 Dec 2021 16:13:15 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma03fra.de.ibm.com with ESMTP id 3d5tx9gkya-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 28 Dec 2021 16:13:15 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1BSGDD4O37159354
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 28 Dec 2021 16:13:13 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E23164C063;
        Tue, 28 Dec 2021 16:13:12 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5389D4C050;
        Tue, 28 Dec 2021 16:13:12 +0000 (GMT)
Received: from sig-9-65-69-73.ibm.com (unknown [9.65.69.73])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 28 Dec 2021 16:13:12 +0000 (GMT)
Message-ID: <d767f176dcdbc50a71f716e3ad9704763b5be537.camel@linux.ibm.com>
Subject: Re: [oss-security] IMA gadgets
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Vitaly Chikunov <vt@altlinux.org>, linux-integrity@vger.kernel.org
Cc:     Florian Weimer <fweimer@redhat.com>
Date:   Tue, 28 Dec 2021 11:13:11 -0500
In-Reply-To: <20211228153909.3ueeb25vrxvcmhk3@altlinux.org>
References: <87wnkp8kmj.fsf@oldenburg.str.redhat.com>
         <20211228153909.3ueeb25vrxvcmhk3@altlinux.org>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: tdzOiblkNr-ZANnbRzk6GTSHJSPfdnI0
X-Proofpoint-ORIG-GUID: vtPCUGyuQaTTCLq8wr7tiotVhr-_ziH1
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-28_08,2021-12-28_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 priorityscore=1501 lowpriorityscore=0 impostorscore=0 phishscore=0
 mlxscore=0 adultscore=0 mlxlogscore=999 clxscore=1011 spamscore=0
 bulkscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112280074
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, 2021-12-28 at 18:39 +0300, Vitaly Chikunov wrote:
> Mimi,
> 
> JFYI, there was a small discussion in oss-security [1] about IMA. Yes,
> it does not touch EVM in case of SUID. But the fact that filenames are
> never tracked in IMA/EVM does look like a major problem indeed.
> 
> Thanks,

Thanks, Vitaly, for forwarding the oss-security link to the discussion.

When I responded in a different thread[1], I mentioned protecting file
metadata is not IMA's responsibility, but EVM's.  I left out mentioning
file signatures provide provenance, which a hash does not.

As for the filename not being protected, that is a known issue as well,
which was discussed at 2018 Linux Storage, Filesystem, and Memory-
Management Summit [2].  Dmitry Kasatkin years ago proposed protecting
the directory structure, but that support was limited to the first
directory level, not all the way up to the tree root.

[1] https://lore.kernel.org/kernel-hardening/e91d238422f8df139acf84cc2df6ddb4fd300b87.camel@linux.ibm.com/
[2] https://lwn.net/Articles/753276/  (2nd to last paragraph).

thanks,

Mimi

> 
> [1] https://www.openwall.com/lists/oss-security/2021/11/30/1
> 
> On Tue, Nov 30, 2021 at 09:16:20PM +0100, Florian Weimer wrote:
> > There's an idea floating around that you can take an established Linux
> > distribution, create IMA signatures for all installed files in its
> > packages, and use those signatures to lock out bad content at run time
> > using IMA verification in the kernel.
> > 
> > I do not think this works in the sense that it can detect serve for more
> > than just detecting file corruption (as an unsigned hash would).  First
> > of all, there is the issue that IMA signatures (at least as they exist
> > in RPM today) are content-only and do not cover file permissions or file
> > capabilities.  This means an attacker can turn any binary into a SUID
> > binary.  The signatures do not cover these file attributes, so they will
> > still verify.
> > 
> > The signatures do not cover the file names, either.  Therefore, an
> > attacker can take a file and put it into a difference place in a file
> > system.  For example, there's a debug-shell.service file that, when
> > dropped into the right directory, will open a root shell on /dev/tty9.
> > This may seem a bit silly, but I think the intent behind the IMA
> > signatures is to combine them with remote attestation, and make
> > (remote) interaction with devices in places without physical security
> > trustworthy.
> > 
> > Another example is /usr/share/perl5/vendor_perl/App/cpanminus.pod from a
> > typical distribution of the App::cpanminus package.  If this is dropped
> > into /etc/sysconfig/run-parts, after a while, the system will download
> > untrusted code over the network and execute it, as far as I can see.
> > (CPAN does not seem to be authenticated.)  The file does nothing when
> > parsed by perl on the command line, but bash will try to run it and
> > invoke a cpan shell command that triggers the download and code
> > execution.  I don't think this kind of file type confusion is addressed
> > by the proposed trusted_for system call, either.
> > 
> > I'm sure there are many gadgets like this.  These two are just the first
> > examples I found.
> > 
> > So in short, I don't really see how IMA signatures shipped as part of
> > all distribution packages, on all files, can provide value beyond that
> > of the hash that the already contain.
> > 
> > Thanks,
> > Florian


