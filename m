Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 54F06B5034
	for <lists+linux-integrity@lfdr.de>; Tue, 17 Sep 2019 16:18:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726494AbfIQOSk (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 17 Sep 2019 10:18:40 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:42864 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726439AbfIQOSk (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 17 Sep 2019 10:18:40 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x8HEAKnw065185
        for <linux-integrity@vger.kernel.org>; Tue, 17 Sep 2019 10:18:37 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2v2xs2806t-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Tue, 17 Sep 2019 10:18:37 -0400
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Tue, 17 Sep 2019 15:18:35 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 17 Sep 2019 15:18:33 +0100
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x8HEIWxl9109670
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Sep 2019 14:18:32 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C0D7AA4051;
        Tue, 17 Sep 2019 14:18:31 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EE0F0A4053;
        Tue, 17 Sep 2019 14:18:30 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.80.228.70])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 17 Sep 2019 14:18:30 +0000 (GMT)
Subject: Re: IMA on remote file systems
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     "Theodore Y. Ts'o" <tytso@mit.edu>,
        Janne Karhunen <janne.karhunen@gmail.com>
Cc:     Chuck Lever <chuck.lever@oracle.com>,
        linux-integrity@vger.kernel.org
Date:   Tue, 17 Sep 2019 10:18:30 -0400
In-Reply-To: <20190917124533.GD6762@mit.edu>
References: <C867A0BA-1ACF-4600-8179-3E15A098846C@oracle.com>
         <CAE=Ncrb=rh0LeDjnGYGuGJVPXG3Y1UpjD5Tw41s0zyOAaL1NKg@mail.gmail.com>
         <1BF68F78-FA8E-4633-9AB4-AB6E0B10DCB8@oracle.com>
         <CAE=NcrYjzdBCB7aK6bL+C+W8N-QJyuPF0RvFqCmsK_S90oyvxg@mail.gmail.com>
         <20190917124533.GD6762@mit.edu>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19091714-0020-0000-0000-0000036E27D1
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19091714-0021-0000-0000-000021C3CCAF
Message-Id: <1568729910.4975.200.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-09-17_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1909170138
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, 2019-09-17 at 08:45 -0400, Theodore Y. Ts'o wrote:
> On Tue, Sep 17, 2019 at 09:30:31AM +0300, Janne Karhunen wrote:

> > Could the fs-verity be plugged in as a measurement mechanism in the
> > IMA? So rather than calling a hash function, call verity to measure
> > and add new set of IMA hooks to report violations that arise after
> > execution? IMA policy logic and functionality would be pretty much
> > unchanged.
> 
> That is the plan, and it's not hard to do.  The question which I've
> raised is when should we do it, given that some people believe that
> pulling the entire file into memory and checksumming it at exec or
> open time is a feature, not a bug.
> 
> Should we use the fs-verity merkel tree root hash as the measurement
> function unconditionally if it is present?  Or does IMA want to have
> some kind of tuning knob; and if so, should it be on a per-file system
> basis, or globally, etc. etc.  Those are IMA design questions, and
> I'll let the IMA folks decide what they want to do.

IMA doesn't hard code policy in the kernel, but is based on a single,
centralized policy, which contains measurement, appraisal, and audit
rules.  Just as the new IMA appended signature support (kernel module
signature format)[1] contains a new "appraise_type=imasig|modsig"
option, there would be a similar option for fs-verity.

Mimi

[1] Included in the v5.4 pull request.

