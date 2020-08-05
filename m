Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6A1723CD10
	for <lists+linux-integrity@lfdr.de>; Wed,  5 Aug 2020 19:19:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728276AbgHERTe (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 5 Aug 2020 13:19:34 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:55616 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728329AbgHERSR (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 5 Aug 2020 13:18:17 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 075CWTU4055929;
        Wed, 5 Aug 2020 08:57:09 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 32qrujyvus-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 05 Aug 2020 08:57:08 -0400
Received: from m0098404.ppops.net (m0098404.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 075CWVpf056073;
        Wed, 5 Aug 2020 08:57:08 -0400
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0a-001b2d01.pphosted.com with ESMTP id 32qrujyvu3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 05 Aug 2020 08:57:08 -0400
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 075Cv6Md006291;
        Wed, 5 Aug 2020 12:57:06 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma06fra.de.ibm.com with ESMTP id 32mynhanre-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 05 Aug 2020 12:57:05 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 075Cv3Rx61080026
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 5 Aug 2020 12:57:03 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C005AA4040;
        Wed,  5 Aug 2020 12:57:03 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CE60BA4053;
        Wed,  5 Aug 2020 12:57:00 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.95.205])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed,  5 Aug 2020 12:57:00 +0000 (GMT)
Message-ID: <31d00876438d2652890ab8bf6ba2e80f554ca7a4.camel@linux.ibm.com>
Subject: Re: [PATCH v6 1/4] IMA: Add func to measure LSM state and policy
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Stephen Smalley <stephen.smalley.work@gmail.com>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        casey@schaufler-ca.com
Cc:     tyhicks@linux.microsoft.com, sashal@kernel.org, jmorris@namei.org,
        linux-integrity@vger.kernel.org, selinux@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Wed, 05 Aug 2020 08:56:59 -0400
In-Reply-To: <f88bf25e-37ef-7f00-6162-215838961bb0@gmail.com>
References: <20200805004331.20652-1-nramas@linux.microsoft.com>
         <20200805004331.20652-2-nramas@linux.microsoft.com>
         <4b9d2715d3ef3c8f915ef03867cfb1a39c0abc54.camel@linux.ibm.com>
         <f88bf25e-37ef-7f00-6162-215838961bb0@gmail.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-12.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-05_09:2020-08-03,2020-08-05 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 phishscore=0 bulkscore=0 malwarescore=0 impostorscore=0 priorityscore=1501
 spamscore=0 mlxscore=0 mlxlogscore=999 clxscore=1015 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008050102
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, 2020-08-05 at 08:46 -0400, Stephen Smalley wrote:
> On 8/4/20 11:25 PM, Mimi Zohar wrote:
> 
> > Hi Lakshmi,
> > 
> > There's still  a number of other patch sets needing to be reviewed
> > before my getting to this one.  The comment below is from a high level.
> > 
> > On Tue, 2020-08-04 at 17:43 -0700, Lakshmi Ramasubramanian wrote:
> > > Critical data structures of security modules need to be measured to
> > > enable an attestation service to verify if the configuration and
> > > policies for the security modules have been setup correctly and
> > > that they haven't been tampered with at runtime. A new IMA policy is
> > > required for handling this measurement.
> > > 
> > > Define two new IMA policy func namely LSM_STATE and LSM_POLICY to
> > > measure the state and the policy provided by the security modules.
> > > Update ima_match_rules() and ima_validate_rule() to check for
> > > the new func and ima_parse_rule() to handle the new func.
> > I can understand wanting to measure the in kernel LSM memory state to
> > make sure it hasn't changed, but policies are stored as files.  Buffer
> > measurements should be limited  to those things that are not files.
> > 
> > Changing how data is passed to the kernel has been happening for a
> > while.  For example, instead of passing the kernel module or kernel
> > image in a buffer, the new syscalls - finit_module, kexec_file_load -
> > pass an open file descriptor.  Similarly, instead of loading the IMA
> > policy data, a pathname may be provided.
> > 
> > Pre and post security hooks already exist for reading files.   Instead
> > of adding IMA support for measuring the policy file data, update the
> > mechanism for loading the LSM policy.  Then not only will you be able
> > to measure the policy, you'll also be able to require the policy be
> > signed.
> 
> To clarify, the policy being measured by this patch series is a 
> serialized representation of the in-memory policy data structures being 
> enforced by SELinux.  Not the file that was loaded.  Hence, this 
> measurement would detect tampering with the in-memory policy data 
> structures after the policy has been loaded.  In the case of SELinux, 
> one can read this serialized representation via /sys/fs/selinux/policy.  
> The result is not byte-for-byte identical to the policy file that was 
> loaded but can be semantically compared via sediff and other tools to 
> determine whether it is equivalent.

Thank you for the clarification.   Could the policy hash be included
with the other critical data?  Does it really need to be measured
independently?

Mimi

