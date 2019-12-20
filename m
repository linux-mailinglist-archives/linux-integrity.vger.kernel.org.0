Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1D114127C3B
	for <lists+linux-integrity@lfdr.de>; Fri, 20 Dec 2019 15:04:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727498AbfLTOEd (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 20 Dec 2019 09:04:33 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:26990 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727474AbfLTOEd (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 20 Dec 2019 09:04:33 -0500
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xBKDwkKM113347
        for <linux-integrity@vger.kernel.org>; Fri, 20 Dec 2019 09:04:32 -0500
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2x0wb1maux-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Fri, 20 Dec 2019 09:04:32 -0500
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Fri, 20 Dec 2019 14:04:29 -0000
Received: from b06avi18626390.portsmouth.uk.ibm.com (9.149.26.192)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 20 Dec 2019 14:04:27 -0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id xBKE3hC936897118
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 20 Dec 2019 14:03:43 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BA6A1AE055;
        Fri, 20 Dec 2019 14:04:26 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F0E96AE056;
        Fri, 20 Dec 2019 14:04:25 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.154.31])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 20 Dec 2019 14:04:25 +0000 (GMT)
Subject: Re: [PATCH v1 - RFC] ima: export the measurement list when needed
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Janne Karhunen <janne.karhunen@gmail.com>,
        linux-integrity@vger.kernel.org,
        linux-security-module <linux-security-module@vger.kernel.org>
Cc:     kgold@linux.ibm.com, david.safford@gmail.com, monty.wiseman@ge.com
Date:   Fri, 20 Dec 2019 09:04:25 -0500
In-Reply-To: <20191220074929.8191-1-janne.karhunen@gmail.com>
References: <20191220074929.8191-1-janne.karhunen@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19122014-0008-0000-0000-00000342EF8B
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19122014-0009-0000-0000-00004A630D4B
Message-Id: <1576850665.5241.52.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-20_03:2019-12-17,2019-12-20 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 impostorscore=0
 lowpriorityscore=0 adultscore=0 spamscore=0 clxscore=1015
 priorityscore=1501 mlxlogscore=999 phishscore=0 malwarescore=0
 suspectscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1912200111
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

[Cc'ing LSM mailing list for a wider audience]

On Fri, 2019-12-20 at 09:49 +0200, Janne Karhunen wrote:
> Some systems can end up carrying lots of entries in the ima
> measurement list. Since every entry is using a bit of kernel
> memory, add a new Kconfig variable to allow the sysadmin to
> define the maximum measurement list size and the location
> of the exported list.
> 
> The list is written out in append mode, so the system will
> keep writing new entries as long as it stays running or runs
> out of space. File is also automatically truncated on startup.
> 
> Signed-off-by: Janne Karhunen <janne.karhunen@gmail.com>

Continually adding new measurements, without limiting or removing the
measurement list seems to becoming more of an issue.

From Dave Safford's TLV patch description[1]:
    A second goal of the [TLV] patch set is to test the more radical
    idea of being able to copy the measurement list data out of the
    kernel. The data is verifiable with the TPM PCR value, and need not
    be kept in kernel memory. In some cases, this "memory leak" can
    grow large enough to cause issues, and this is a test of a
    potential way to solve that problem.

The TLV version automatically removed the measurement list the first
time the measurement list was read, which sounded very odd to me.  In
an offline discussion, Dave further clarified that reading the
measurement list should be similar to how a trusted userspace
application reads kernel messages.  The difference being kernel
messages are stored in a circular buffer and may be dropped.  In the
IMA measurement list case, the measurement list would grow until the
trusted userspace application gets around to reading the measurement
list. 

Should the kernel be involved in writing the IMA measurement list to a
file or, as Dave suggested, this should be delegated to a userspace
application?
 
Mimi

[1] https://lore.kernel.org/linux-integrity/BCA04D5D9A3B764C9B7405BBA4
D4A3C002569222@ALPMBAPA12.e2k.ad.ge.com/

