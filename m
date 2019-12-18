Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A39D0124875
	for <lists+linux-integrity@lfdr.de>; Wed, 18 Dec 2019 14:34:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727006AbfLRNe6 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 18 Dec 2019 08:34:58 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:51790 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726998AbfLRNe5 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 18 Dec 2019 08:34:57 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xBIDXM6j108405
        for <linux-integrity@vger.kernel.org>; Wed, 18 Dec 2019 08:34:56 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2wye06ge2b-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Wed, 18 Dec 2019 08:34:56 -0500
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Wed, 18 Dec 2019 13:34:53 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 18 Dec 2019 13:34:50 -0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id xBIDYnFY57409696
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 18 Dec 2019 13:34:50 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DDC7652054;
        Wed, 18 Dec 2019 13:34:49 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.206.168])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 980A152050;
        Wed, 18 Dec 2019 13:34:48 +0000 (GMT)
Subject: Re: [PATCH] integrity: Expose data structures required for
 include/linux/integrity.h
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Florent Revest <revest@chromium.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        linux-integrity@vger.kernel.org
Cc:     jmorris@namei.org, serge@hallyn.com, revest@google.com,
        allison@lohutok.net, armijn@tjaldur.nl, bauerman@linux.ibm.com,
        linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, kpsingh@chromium.org
Date:   Wed, 18 Dec 2019 08:34:47 -0500
In-Reply-To: <2ae5127d76cbf78140fb2d6108c9ec70c7d8ae5d.camel@chromium.org>
References: <20191217134748.198011-1-revest@chromium.org>
         <e9e366d3-6c5d-743b-ffde-6b95b85884a2@schaufler-ca.com>
         <1576624105.4579.379.camel@linux.ibm.com>
         <2ae5127d76cbf78140fb2d6108c9ec70c7d8ae5d.camel@chromium.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19121813-0020-0000-0000-0000039983FD
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19121813-0021-0000-0000-000021F0A6CD
Message-Id: <1576676087.4579.396.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-18_03:2019-12-17,2019-12-18 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0 mlxscore=0
 bulkscore=0 spamscore=0 clxscore=1015 priorityscore=1501 suspectscore=0
 mlxlogscore=964 phishscore=0 adultscore=0 malwarescore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-1910280000
 definitions=main-1912180112
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, 2019-12-18 at 12:03 +0100, Florent Revest wrote:
> On Tue, 2019-12-17 at 18:08 -0500, Mimi Zohar wrote:
> > On Tue, 2019-12-17 at 08:25 -0800, Casey Schaufler wrote:
> > > On 12/17/2019 5:47 AM, Florent Revest wrote:
> > > > From: Florent Revest <revest@google.com>
> > > > 
> > > > include/linux/integrity.h exposes the prototype of
> > > > integrity_inode_get().
> > > > However, it relies on struct integrity_iint_cache which is
> > > > currently
> > > > defined in an internal header, security/integrity/integrity.h.
> > > > 
> > > > To allow the rest of the kernel to use integrity_inode_get,
> > > 
> > > Why do you want to do this?
> > 
> > ditto
> 
> My team works on KRSI (eBPF MAC policies presented at LSS by KP Singh).
> https://lkml.org/lkml/2019/9/10/393 We identified file hashes gathered
> from the integrity subsystem as an interesting field that we could
> potentially someday expose to eBPF programs through helpers.
> 
> One of the reason behind writing KRSI is to replace a custom kernel
> auditing module that currently needs to redefine those structures to
> access them. I imagine other kernel modules could benefit from a file
> hash API too.
> 
> This is the least intrusive patch I could come up with that allows us
> to lookup a hash from an inode. I was surprised to find that
> integrity_inode_get was exposed but not the structures it returns.
> 
> If the community is interested in a different file hash API, I'd be
> happy to iterate on this patch based on your feedback.

There's a major difference between returning just the file hash and
making the integrity_iint_cache structure public.  Peter Moody's
original code queried the cache[1].  Why do you need access to the
structure itself?

FYI, if/when we get to IMA namespacing, the cache structure will
change.

Mimi

[1] ima: add the ability to query ima for the hash of a given file.

> 
> > > >  this patch
> > > > moves the definition of the necessary structures from a private
> > > > header
> > > > to a global kernel header.
> 

