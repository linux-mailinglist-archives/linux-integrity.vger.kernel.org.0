Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8880423CC2D
	for <lists+linux-integrity@lfdr.de>; Wed,  5 Aug 2020 18:28:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727022AbgHEQ1i (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 5 Aug 2020 12:27:38 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:51340 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726854AbgHEQZf (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 5 Aug 2020 12:25:35 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 075FCMQe159374;
        Wed, 5 Aug 2020 11:17:32 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 32qvn5wm3h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 05 Aug 2020 11:17:31 -0400
Received: from m0098417.ppops.net (m0098417.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 075FCTrZ160219;
        Wed, 5 Aug 2020 11:17:31 -0400
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 32qvn5wm26-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 05 Aug 2020 11:17:31 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 075FG2rA017045;
        Wed, 5 Aug 2020 15:17:29 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma04ams.nl.ibm.com with ESMTP id 32n0184h78-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 05 Aug 2020 15:17:28 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 075FHQA927722030
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 5 Aug 2020 15:17:26 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 65909A404D;
        Wed,  5 Aug 2020 15:17:26 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D9037A4040;
        Wed,  5 Aug 2020 15:17:24 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.95.205])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed,  5 Aug 2020 15:17:24 +0000 (GMT)
Message-ID: <27b7772ef645e10d1fe3cbe56a02d02f42f75db5.camel@linux.ibm.com>
Subject: Re: [PATCH v6 1/4] IMA: Add func to measure LSM state and policy
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Stephen Smalley <stephen.smalley.work@gmail.com>
Cc:     Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Tyler Hicks <tyhicks@linux.microsoft.com>, sashal@kernel.org,
        James Morris <jmorris@namei.org>,
        linux-integrity@vger.kernel.org,
        SElinux list <selinux@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Date:   Wed, 05 Aug 2020 11:17:24 -0400
In-Reply-To: <CAEjxPJ7d1yg659OCU6diXXGqegc_jSzO4ZPhkRqQtJnRn-kC0g@mail.gmail.com>
References: <20200805004331.20652-1-nramas@linux.microsoft.com>
         <20200805004331.20652-2-nramas@linux.microsoft.com>
         <4b9d2715d3ef3c8f915ef03867cfb1a39c0abc54.camel@linux.ibm.com>
         <f88bf25e-37ef-7f00-6162-215838961bb0@gmail.com>
         <31d00876438d2652890ab8bf6ba2e80f554ca7a4.camel@linux.ibm.com>
         <CAEjxPJ6X+Cqd5QtZBmNm2cujwbg-STfRF7_8i=Ny8yuc6z9BwQ@mail.gmail.com>
         <b7df114e8e0d276e66575b6970a1e459d1dd4196.camel@linux.ibm.com>
         <CAEjxPJ7d1yg659OCU6diXXGqegc_jSzO4ZPhkRqQtJnRn-kC0g@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-12.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-05_10:2020-08-03,2020-08-05 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 spamscore=0
 priorityscore=1501 lowpriorityscore=0 phishscore=0 malwarescore=0
 adultscore=0 suspectscore=0 impostorscore=0 mlxlogscore=999 bulkscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008050124
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, 2020-08-05 at 10:27 -0400, Stephen Smalley wrote:
> On Wed, Aug 5, 2020 at 9:20 AM Mimi Zohar <zohar@linux.ibm.com> wrote:
> > On Wed, 2020-08-05 at 09:03 -0400, Stephen Smalley wrote:
> > > On Wed, Aug 5, 2020 at 8:57 AM Mimi Zohar <zohar@linux.ibm.com> wrote:
> > > > On Wed, 2020-08-05 at 08:46 -0400, Stephen Smalley wrote:
> > > > > On 8/4/20 11:25 PM, Mimi Zohar wrote:
> > > > > 
> > > > > > Hi Lakshmi,
> > > > > > 
> > > > > > There's still  a number of other patch sets needing to be reviewed
> > > > > > before my getting to this one.  The comment below is from a high level.
> > > > > > 
> > > > > > On Tue, 2020-08-04 at 17:43 -0700, Lakshmi Ramasubramanian wrote:
> > > > > > > Critical data structures of security modules need to be measured to
> > > > > > > enable an attestation service to verify if the configuration and
> > > > > > > policies for the security modules have been setup correctly and
> > > > > > > that they haven't been tampered with at runtime. A new IMA policy is
> > > > > > > required for handling this measurement.
> > > > > > > 
> > > > > > > Define two new IMA policy func namely LSM_STATE and LSM_POLICY to
> > > > > > > measure the state and the policy provided by the security modules.
> > > > > > > Update ima_match_rules() and ima_validate_rule() to check for
> > > > > > > the new func and ima_parse_rule() to handle the new func.
> > > > > > I can understand wanting to measure the in kernel LSM memory state to
> > > > > > make sure it hasn't changed, but policies are stored as files.  Buffer
> > > > > > measurements should be limited  to those things that are not files.
> > > > > > 
> > > > > > Changing how data is passed to the kernel has been happening for a
> > > > > > while.  For example, instead of passing the kernel module or kernel
> > > > > > image in a buffer, the new syscalls - finit_module, kexec_file_load -
> > > > > > pass an open file descriptor.  Similarly, instead of loading the IMA
> > > > > > policy data, a pathname may be provided.
> > > > > > 
> > > > > > Pre and post security hooks already exist for reading files.   Instead
> > > > > > of adding IMA support for measuring the policy file data, update the
> > > > > > mechanism for loading the LSM policy.  Then not only will you be able
> > > > > > to measure the policy, you'll also be able to require the policy be
> > > > > > signed.
> > > > > 
> > > > > To clarify, the policy being measured by this patch series is a
> > > > > serialized representation of the in-memory policy data structures being
> > > > > enforced by SELinux.  Not the file that was loaded.  Hence, this
> > > > > measurement would detect tampering with the in-memory policy data
> > > > > structures after the policy has been loaded.  In the case of SELinux,
> > > > > one can read this serialized representation via /sys/fs/selinux/policy.
> > > > > The result is not byte-for-byte identical to the policy file that was
> > > > > loaded but can be semantically compared via sediff and other tools to
> > > > > determine whether it is equivalent.
> > > > 
> > > > Thank you for the clarification.   Could the policy hash be included
> > > > with the other critical data?  Does it really need to be measured
> > > > independently?
> > > 
> > > They were split into two separate functions because we wanted to be
> > > able to support using different templates for them (ima-buf for the
> > > state variables so that the measurement includes the original buffer,
> > > which is small and relatively fixed-size, and ima-ng for the policy
> > > because it is large and we just want to capture the hash for later
> > > comparison against known-good).  Also, the state variables are
> > > available for measurement always from early initialization, whereas
> > > the policy is only available for measurement once we have loaded an
> > > initial policy.
> > 
> > Ok, measuring the policy separately from other critical data makes
> > sense.  Instead of measuring the policy, which is large, measure the
> > policy hash.
> 
> I think that was the original approach.  However, I had concerns with
> adding code to SELinux to compute a hash over the policy versus
> leaving that to IMA's existing policy and mechanism.  If that's
> preferred I guess we can do it that way but seems less flexible and
> duplicative.

Whether IMA or SELinux calculates the in memory policy hash, it should
not impact the original purpose of this patch set - measuring critical
state.  It's unclear whether this patch set needs to be limited to LSM
critical state.

Measuring the in memory policy, if needed, should be a separate patch
set.

Mimi

