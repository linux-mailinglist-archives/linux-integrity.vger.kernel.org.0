Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 26057B664C
	for <lists+linux-integrity@lfdr.de>; Wed, 18 Sep 2019 16:41:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731341AbfIROlN (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 18 Sep 2019 10:41:13 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:61396 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725902AbfIROlN (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 18 Sep 2019 10:41:13 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x8IEOm3W113805
        for <linux-integrity@vger.kernel.org>; Wed, 18 Sep 2019 10:41:12 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2v3m8me2gs-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Wed, 18 Sep 2019 10:40:58 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Wed, 18 Sep 2019 15:40:36 +0100
Received: from b06avi18626390.portsmouth.uk.ibm.com (9.149.26.192)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 18 Sep 2019 15:40:33 +0100
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x8IEe6ax15794500
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 18 Sep 2019 14:40:06 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1AD7611C05B;
        Wed, 18 Sep 2019 14:40:32 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4D3C611C04C;
        Wed, 18 Sep 2019 14:40:31 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.196.20])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 18 Sep 2019 14:40:31 +0000 (GMT)
Subject: Re: IMA on remote file systems
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     "Theodore Y. Ts'o" <tytso@mit.edu>,
        James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     Janne Karhunen <janne.karhunen@gmail.com>,
        Chuck Lever <chuck.lever@oracle.com>,
        linux-integrity@vger.kernel.org
Date:   Wed, 18 Sep 2019 10:40:30 -0400
In-Reply-To: <20190918123724.GJ6762@mit.edu>
References: <C867A0BA-1ACF-4600-8179-3E15A098846C@oracle.com>
         <CAE=Ncrb=rh0LeDjnGYGuGJVPXG3Y1UpjD5Tw41s0zyOAaL1NKg@mail.gmail.com>
         <1BF68F78-FA8E-4633-9AB4-AB6E0B10DCB8@oracle.com>
         <CAE=NcrYjzdBCB7aK6bL+C+W8N-QJyuPF0RvFqCmsK_S90oyvxg@mail.gmail.com>
         <20190917124533.GD6762@mit.edu>
         <1568732169.11799.18.camel@HansenPartnership.com>
         <20190918123724.GJ6762@mit.edu>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19091814-0012-0000-0000-0000034D9A0E
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19091814-0013-0000-0000-000021881885
Message-Id: <1568817630.16709.86.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-09-18_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1909180144
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, 2019-09-18 at 08:37 -0400, Theodore Y. Ts'o wrote:
> On Tue, Sep 17, 2019 at 09:56:09AM -0500, James Bottomley wrote:
> > > There seems to be a philosophical debate about this.  Some IMA folks
> > > have claimed that you want to know at the time of the binary being
> > > executed, whether or not it is corrupt or not.  Their concern is that
> > > if you can make a binary crash when it pages in some page of memory,,,,
> >
> > That's not my recollection of the IMA position.
> 
> I had *several* conversations with IMA folks, including Mimi, who very
> carefully explained to me why fs-verity was bad from a security
> perspective.  

There are use cases where you want to fail immediately, but that is
dependent on the use case (eg. critical industrial control systems).
 I'm not sure why you're bringing this up now, as we've already agreed
there are different use cases with different requirements, even on the
same system.

IMA doesn't hard code policy in the kernel, but is based on a single,
centralized policy, which contains measurement, appraisal, and audit
rules.  The same file hash, or in this case fs-verity's hash, could be
included in the measurement list, used to extended TPM, and added to
the audit log, as an IMA-audit record.

Mimi

