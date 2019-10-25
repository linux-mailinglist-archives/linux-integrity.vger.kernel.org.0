Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BB3D9E5485
	for <lists+linux-integrity@lfdr.de>; Fri, 25 Oct 2019 21:42:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725852AbfJYTmw (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 25 Oct 2019 15:42:52 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:58070 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726754AbfJYTmv (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 25 Oct 2019 15:42:51 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x9PJXbKS023290
        for <linux-integrity@vger.kernel.org>; Fri, 25 Oct 2019 15:42:51 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2vv3avgh08-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Fri, 25 Oct 2019 15:42:50 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Fri, 25 Oct 2019 20:42:48 +0100
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 25 Oct 2019 20:42:44 +0100
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x9PJghpi57671886
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 25 Oct 2019 19:42:43 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B317711C04C;
        Fri, 25 Oct 2019 19:42:43 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0989111C050;
        Fri, 25 Oct 2019 19:42:43 +0000 (GMT)
Received: from dhcp-9-31-103-196.watson.ibm.com (unknown [9.31.103.196])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 25 Oct 2019 19:42:42 +0000 (GMT)
Subject: Re: [PATCH] tpm: Add major_version sysfs file
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>, linux-kernel@vger.kernel.org,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Peter Huewe <peterhuewe@gmx.de>,
        linux-integrity@vger.kernel.org
Date:   Fri, 25 Oct 2019 15:42:42 -0400
In-Reply-To: <20191025193243.GI23952@ziepe.ca>
References: <20191025142847.14931-1-jsnitsel@redhat.com>
         <1572027516.4532.41.camel@linux.ibm.com>
         <20191025184522.5txabdikcrn2dgvj@cantor> <20191025193243.GI23952@ziepe.ca>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19102519-0016-0000-0000-000002BDA382
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19102519-0017-0000-0000-0000331EEEAF
Message-Id: <1572032562.4532.74.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-10-25_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1910250177
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, 2019-10-25 at 16:32 -0300, Jason Gunthorpe wrote:
> On Fri, Oct 25, 2019 at 11:45:22AM -0700, Jerry Snitselaar wrote:
> > On Fri Oct 25 19, Mimi Zohar wrote:
> > Yes, there should be an entry added to
> > Documentation/ABI/stable/sysfs-class-tpm.
> > I will fix that up and the TCG not being uppercase in a v2.
> > 
> > Should Documentation/ABI/stable/sysfs-class-tpm updated in
> > some way to reflect that those are all links under device
> > now and not actually there.
> 
> Applications should not use the link version, that path was a
> mistake. The link is for compatability with old userspace.

Are you suggesting that userspace has to search for the device info? 
That makes no sense.

Mimi

