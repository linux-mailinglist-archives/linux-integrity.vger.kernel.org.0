Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4037723C3F9
	for <lists+linux-integrity@lfdr.de>; Wed,  5 Aug 2020 05:25:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725904AbgHEDZY (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 4 Aug 2020 23:25:24 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:19786 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725864AbgHEDZY (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 4 Aug 2020 23:25:24 -0400
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 07533LNV150015;
        Tue, 4 Aug 2020 23:25:17 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 32qcf1u8fr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 04 Aug 2020 23:25:17 -0400
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 07533WAv150504;
        Tue, 4 Aug 2020 23:25:17 -0400
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0a-001b2d01.pphosted.com with ESMTP id 32qcf1u8fc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 04 Aug 2020 23:25:17 -0400
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0753PFEt028243;
        Wed, 5 Aug 2020 03:25:15 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma02fra.de.ibm.com with ESMTP id 32n018adaf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 05 Aug 2020 03:25:15 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0753NkR162587312
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 5 Aug 2020 03:23:46 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0F2E2AE045;
        Wed,  5 Aug 2020 03:25:13 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 119F5AE04D;
        Wed,  5 Aug 2020 03:25:10 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.44.248])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed,  5 Aug 2020 03:25:09 +0000 (GMT)
Message-ID: <4b9d2715d3ef3c8f915ef03867cfb1a39c0abc54.camel@linux.ibm.com>
Subject: Re: [PATCH v6 1/4] IMA: Add func to measure LSM state and policy
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        stephen.smalley.work@gmail.com, casey@schaufler-ca.com
Cc:     tyhicks@linux.microsoft.com, sashal@kernel.org, jmorris@namei.org,
        linux-integrity@vger.kernel.org, selinux@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Tue, 04 Aug 2020 23:25:08 -0400
In-Reply-To: <20200805004331.20652-2-nramas@linux.microsoft.com>
References: <20200805004331.20652-1-nramas@linux.microsoft.com>
         <20200805004331.20652-2-nramas@linux.microsoft.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-12.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-05_03:2020-08-03,2020-08-05 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 adultscore=0
 mlxlogscore=999 priorityscore=1501 spamscore=0 malwarescore=0 mlxscore=0
 lowpriorityscore=0 phishscore=0 bulkscore=0 clxscore=1011 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008050026
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Lakshmi,

There's still  a number of other patch sets needing to be reviewed
before my getting to this one.  The comment below is from a high level.

On Tue, 2020-08-04 at 17:43 -0700, Lakshmi Ramasubramanian wrote:
> Critical data structures of security modules need to be measured to
> enable an attestation service to verify if the configuration and
> policies for the security modules have been setup correctly and
> that they haven't been tampered with at runtime. A new IMA policy is
> required for handling this measurement.
> 
> Define two new IMA policy func namely LSM_STATE and LSM_POLICY to
> measure the state and the policy provided by the security modules.
> Update ima_match_rules() and ima_validate_rule() to check for
> the new func and ima_parse_rule() to handle the new func.

I can understand wanting to measure the in kernel LSM memory state to
make sure it hasn't changed, but policies are stored as files.  Buffer
measurements should be limited  to those things that are not files.

Changing how data is passed to the kernel has been happening for a
while.  For example, instead of passing the kernel module or kernel
image in a buffer, the new syscalls - finit_module, kexec_file_load -
pass an open file descriptor.  Similarly, instead of loading the IMA
policy data, a pathname may be provided.

Pre and post security hooks already exist for reading files.   Instead
of adding IMA support for measuring the policy file data, update the
mechanism for loading the LSM policy.  Then not only will you be able
to measure the policy, you'll also be able to require the policy be
signed.

Mimi

