Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D6EB2E5425
	for <lists+linux-integrity@lfdr.de>; Fri, 25 Oct 2019 21:15:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726792AbfJYTPg (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 25 Oct 2019 15:15:36 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:35516 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725897AbfJYTPf (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 25 Oct 2019 15:15:35 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x9PJCJZo029017
        for <linux-integrity@vger.kernel.org>; Fri, 25 Oct 2019 15:15:34 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2vv42u5skv-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Fri, 25 Oct 2019 15:15:34 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Fri, 25 Oct 2019 20:15:32 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 25 Oct 2019 20:15:30 +0100
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x9PJFTGC56688726
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 25 Oct 2019 19:15:29 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 47E21A405B;
        Fri, 25 Oct 2019 19:15:29 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8A9C1A404D;
        Fri, 25 Oct 2019 19:15:28 +0000 (GMT)
Received: from dhcp-9-31-103-196.watson.ibm.com (unknown [9.31.103.196])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 25 Oct 2019 19:15:28 +0000 (GMT)
Subject: Re: [PATCH] tpm: Add major_version sysfs file
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Jerry Snitselaar <jsnitsel@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-integrity@vger.kernel.org
Date:   Fri, 25 Oct 2019 15:15:28 -0400
In-Reply-To: <20191025184522.5txabdikcrn2dgvj@cantor>
References: <20191025142847.14931-1-jsnitsel@redhat.com>
         <1572027516.4532.41.camel@linux.ibm.com>
         <20191025184522.5txabdikcrn2dgvj@cantor>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19102519-0008-0000-0000-00000327A0B9
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19102519-0009-0000-0000-00004A46D912
Message-Id: <1572030928.4532.57.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-10-25_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1910250173
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, 2019-10-25 at 11:45 -0700, Jerry Snitselaar wrote:
> On Fri Oct 25 19, Mimi Zohar wrote:
> >On Fri, 2019-10-25 at 07:28 -0700, Jerry Snitselaar wrote:
> >> Easily determining what TCG version a tpm device implements
> >> has been a pain point for userspace for a long time, so
> >> add a sysfs file to report the tcg version of a tpm device.
> >
> >Use "TCG" uppercase consistently.

And "TPM"

> > 
> >>
> >> Cc: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> >> Cc: Peter Huewe <peterhuewe@gmx.de>
> >> Cc: Jason Gunthorpe <jgg@ziepe.ca>
> >> Cc: linux-integrity@vger.kernel.org
> >> Signed-off-by: Jerry Snitselaar <jsnitsel@redhat.com>
> >
> >thanks!
> >
> >Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
> >
> >FYI, on my system(s) the new file is accessible as
> >/sys/class/tpm/tpm0/version_major.  Does this need to be documented
> >anywhere?
> >
> >
> 
> Yes, there should be an entry added to
> Documentation/ABI/stable/sysfs-class-tpm.
> I will fix that up and the TCG not being uppercase in a v2.
> 
> Should Documentation/ABI/stable/sysfs-class-tpm updated in
> some way to reflect that those are all links under device
> now and not actually there.

The importance is that there is a common file that can be used by
userspace applications, instead of having to search for it, not that
it is a link per-se.

Mimi

