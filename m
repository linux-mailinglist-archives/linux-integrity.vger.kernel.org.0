Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D56C71A7E96
	for <lists+linux-integrity@lfdr.de>; Tue, 14 Apr 2020 15:42:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732607AbgDNNlg (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 14 Apr 2020 09:41:36 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:28548 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732574AbgDNNl0 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 14 Apr 2020 09:41:26 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03EDXRp2009621
        for <linux-integrity@vger.kernel.org>; Tue, 14 Apr 2020 09:41:22 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 30b6sg59dm-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Tue, 14 Apr 2020 09:41:22 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Tue, 14 Apr 2020 14:40:46 +0100
Received: from b06avi18626390.portsmouth.uk.ibm.com (9.149.26.192)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 14 Apr 2020 14:40:43 +0100
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 03EDeA2H46727520
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Apr 2020 13:40:10 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 192B84204D;
        Tue, 14 Apr 2020 13:41:16 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BE55442041;
        Tue, 14 Apr 2020 13:41:14 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.80.236.92])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 14 Apr 2020 13:41:14 +0000 (GMT)
Subject: Re: [PATCH 0/2] support to read and tune appraise mode in runtime
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Tianjia Zhang <tianjia.zhang@linux.alibaba.com>,
        dmitry.kasatkin@gmail.com, jmorris@namei.org, serge@hallyn.com,
        zhangliguang@linux.alibaba.com
Cc:     linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, Nayna Jain <nayna@linux.ibm.com>
Date:   Tue, 14 Apr 2020 09:41:14 -0400
In-Reply-To: <a767d0e0-6c57-254a-3c95-f78026e80c1d@linux.alibaba.com>
References: <20200409033907.102833-1-tianjia.zhang@linux.alibaba.com>
         <1586814958.7311.92.camel@linux.ibm.com>
         <a767d0e0-6c57-254a-3c95-f78026e80c1d@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 20041413-4275-0000-0000-000003BFBABE
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20041413-4276-0000-0000-000038D52DA2
Message-Id: <1586871674.7311.189.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-14_06:2020-04-14,2020-04-14 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 spamscore=0 bulkscore=0 malwarescore=0 clxscore=1015 mlxscore=0
 phishscore=0 adultscore=0 priorityscore=1501 impostorscore=0
 mlxlogscore=999 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2003020000 definitions=main-2004140112
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, 2020-04-14 at 11:36 +0800, Tianjia Zhang wrote:
> 
> On 2020/4/14 5:55, Mimi Zohar wrote:
> > On Thu, 2020-04-09 at 11:39 +0800, Tianjia Zhang wrote:
> >> Support the read and write operations of ima_appraise by adding a
> >> securifyfs file 'appraise_mode'.
> >>
> >> In order to tune appraise mode in runtime, writing a PKCS#7 signature
> >> corresponding the signed content is required. The content should be off,
> >> enforce, log or fix. Given a simple way to archive this:
> >>
> >> $ echo -n off > mode
> >> $ openssl smime -sign -nocerts -noattr -binary \
> >>      -in mode -inkey <system_trusted_key> \
> >>      -signer <cert> -outform der -out mode.p7s
> >> $ sudo cat mode.p7s \
> >>      > /sys/kernel/security/ima/appraise_mode
> >>
> >> Note that the signing key must be a trust key located in
> >> system trusted keyring. So even the root privilege cannot
> >> simply disable the enforcement.
> > 
> > There are major problems with disabling IMA appraisal.  This patch set
> > proposes disabling IMA appraisal without even providing the motivation
> > for such support.
> > 
> > A lot of effort went into preventing custom IMA policies from
> > disabling appraising the kexec or kernel module signatures.  In
> > addition, the "lockdown" patch set was upstreamed permitting IMA
> > signature verification.  This patch set would break both of these
> > features.
> > 
> > IMA relies on its own keyring for verifying file signatures, not the
> > builtin or secondary trusted kernel keyrings.
> > 
> > Two methods already exist - xattr and appended signatures - for
> > verifying file signatures.  This patch set assumes creating and
> > signing a file, which is then written to a securityfs file.  Like for
> > loading a custom IMA policy, instead of cat'ing the file, write the
> > pathname to the securityfs file.
> > 
> > If you must define a new IMA method for verifying file signatures,
> > then it needs to be generic and added to ima_appraise_measurement().
> >   (Refer to the new IMA appended signature support.)
> > 
> > Mimi
> > 
> >>
> >> Tianjia Zhang (2):
> >>    ima: support to read appraise mode
> >>    ima: support to tune appraise mode in runtime
> >>
> >>   security/integrity/ima/ima_fs.c | 134 +++++++++++++++++++++++++++++++-
> >>   1 file changed, 133 insertions(+), 1 deletion(-)
> >>
> 
> Thanks for your suggestion, the way to close the appraise mode here is 
> indeed a bit rude, I will reconsider again according to your suggestions.
> 
> In addition, [PATCH 1/2] ima: support to read appraise mode, by the way, 
> see if this patch is acceptable.

My comments were not meant as suggestions, but as an explanation as to
how IMA works.  More details follow.

IMA is based on policy.  That decision was made a long time ago.  It
allowed distros to configure IMA, allowing customers to experiment
with it.  You have one opportunity to totally change the boot time
policy rules, by loading a custom policy.  After that, rules may only
be added.

There is no valid reason for "turning off" the policy once it has been
enabled.  It breaks existing expectations.

Mimi

