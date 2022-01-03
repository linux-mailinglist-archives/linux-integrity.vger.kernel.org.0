Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 799D948380F
	for <lists+linux-integrity@lfdr.de>; Mon,  3 Jan 2022 21:44:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229527AbiACUoq (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 3 Jan 2022 15:44:46 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:7284 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229478AbiACUop (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 3 Jan 2022 15:44:45 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 203GhW5b001880;
        Mon, 3 Jan 2022 20:44:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=d7Rppfjf2xK3qs9W3EXgtV0sz6zBM9e4EQyVooPXVHw=;
 b=cqwM3Wj8Fr9RdulST/wJx0ZLar9kIwwk6rfLNBKQF1XKOOO+QkK2HcI/LnKI3/6Rki25
 kQgQfYjRDwTo8m79xQU7ydlcs9ptJcqYnbNLva9MFj7zZVPzAgfe70k8o8plwnraMJNQ
 QvAw4pS/dWXN6rwyXj7lB75YtMEaJn7GjpCdYjUcnGgK5TqcJ76s+kBNYGTrONyA+Y+t
 eS95uP1Dx40tTD+kz+SESXi8m+hg0NfbAfL39ER3SLSlVTmtPvF9fYnyP6rvcat/PZ6U
 NwfQwK9hvMvrAAstbT07FO3sEqZGTwJIIen77yn29FYiOKR8tbrHWcaPxi7N0VgwFVCe Pw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3dc4wvk3jh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 03 Jan 2022 20:44:43 +0000
Received: from m0098393.ppops.net (m0098393.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 203KhOCS004977;
        Mon, 3 Jan 2022 20:44:42 GMT
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3dc4wvk3j5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 03 Jan 2022 20:44:42 +0000
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 203KgL2p001628;
        Mon, 3 Jan 2022 20:44:40 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma03fra.de.ibm.com with ESMTP id 3daek9465m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 03 Jan 2022 20:44:40 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 203KibAv17629542
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 3 Jan 2022 20:44:37 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C5D82A4040;
        Mon,  3 Jan 2022 20:44:37 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2516CA404D;
        Mon,  3 Jan 2022 20:44:37 +0000 (GMT)
Received: from sig-9-65-85-84.ibm.com (unknown [9.65.85.84])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon,  3 Jan 2022 20:44:36 +0000 (GMT)
Message-ID: <44da7e73335cd70ec847e02c305b5f42014ab37b.camel@linux.ibm.com>
Subject: Re: [oss-security] IMA gadgets
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Vitaly Chikunov <vt@altlinux.org>
Cc:     linux-integrity@vger.kernel.org,
        Florian Weimer <fweimer@redhat.com>,
        "Dmitry V. Levin" <ldv@altlinux.org>
Date:   Mon, 03 Jan 2022 15:44:36 -0500
In-Reply-To: <20220102224413.575bcx4s5rclw4vz@altlinux.org>
References: <87wnkp8kmj.fsf@oldenburg.str.redhat.com>
         <20211228153909.3ueeb25vrxvcmhk3@altlinux.org>
         <d767f176dcdbc50a71f716e3ad9704763b5be537.camel@linux.ibm.com>
         <20220102224413.575bcx4s5rclw4vz@altlinux.org>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: kHqvlfRaLoihQv4gG7AiJCJLVyZiTfC2
X-Proofpoint-ORIG-GUID: 6BY-ZShsAqAUIwDChUuxeZrL6V1PCmTC
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-03_08,2022-01-01_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 mlxscore=0
 suspectscore=0 adultscore=0 bulkscore=0 mlxlogscore=999 spamscore=0
 priorityscore=1501 lowpriorityscore=0 clxscore=1011 phishscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2201030140
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, 2022-01-03 at 01:44 +0300, Vitaly Chikunov wrote:
> Hi,
> 
> On Tue, Dec 28, 2021 at 11:13:11AM -0500, Mimi Zohar wrote:
> > On Tue, 2021-12-28 at 18:39 +0300, Vitaly Chikunov wrote:
> > > 
> > > JFYI, there was a small discussion in oss-security [1] about IMA. Yes,
> > > it does not touch EVM in case of SUID. But the fact that filenames are
> > > never tracked in IMA/EVM does look like a major problem indeed.
> > > 
> > > Thanks,
> > 
> > Thanks, Vitaly, for forwarding the oss-security link to the discussion.
> > 
> > When I responded in a different thread[1], I mentioned protecting file
> > metadata is not IMA's responsibility, but EVM's.  I left out mentioning
> > file signatures provide provenance, which a hash does not.
> > 
> > As for the filename not being protected, that is a known issue as well,
> > which was discussed at 2018 Linux Storage, Filesystem, and Memory-
> > Management Summit [2].
> > Dmitry Kasatkin years ago proposed protecting
> > the directory structure, but that support was limited to the first
> > directory level, not all the way up to the tree root.
> 
> That's interesting. But protecting directory with xattr seems to have
> bad consequences, besides it's harder to calculate, it will be
> impossible to install additional binaries to the dir (like upgrading
> single package on the system). (If I understood correctly the idea.)

The proposed support was for directory hashes, not signatures, based on
the getdents syscall.  Only in ima-evm-utils v1.4 was the experimental
code for calculating the directory hash removed.

> 
> What if we combine filename hash and directory inode number to the EVM
> signature?

Another approach could be based on Allison Henderson's 2018 LSF/MM talk
titled "XFS parent pointers" https://lwn.net/Articles/753480/, as
pointed out by Boaz Harrosh.

thanks,

Mimi

