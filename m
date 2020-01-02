Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0547A12EAE2
	for <lists+linux-integrity@lfdr.de>; Thu,  2 Jan 2020 21:37:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725790AbgABUhD (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 2 Jan 2020 15:37:03 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:26676 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725783AbgABUhD (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 2 Jan 2020 15:37:03 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 002KWXSZ128300
        for <linux-integrity@vger.kernel.org>; Thu, 2 Jan 2020 15:37:01 -0500
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2x88jk9kp9-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Thu, 02 Jan 2020 15:37:01 -0500
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Thu, 2 Jan 2020 20:36:59 -0000
Received: from b06avi18626390.portsmouth.uk.ibm.com (9.149.26.192)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 2 Jan 2020 20:36:57 -0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 002KaAUQ35717624
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 2 Jan 2020 20:36:10 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 74B36AE053;
        Thu,  2 Jan 2020 20:36:56 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E09EEAE045;
        Thu,  2 Jan 2020 20:36:55 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.148.97])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu,  2 Jan 2020 20:36:55 +0000 (GMT)
Subject: Re: IMA's use of the audit rule code
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Casey Schaufler <casey@schaufler-ca.com>,
        linux-integrity@vger.kernel.org
Date:   Thu, 02 Jan 2020 15:36:55 -0500
In-Reply-To: <28459dc3-1b5e-b3e0-7139-2a5dcb46476b@schaufler-ca.com>
References: <a6c15a35-a8cb-7589-7960-a19e788b6c45.ref@schaufler-ca.com>
         <a6c15a35-a8cb-7589-7960-a19e788b6c45@schaufler-ca.com>
         <1577992707.5874.110.camel@linux.ibm.com>
         <28459dc3-1b5e-b3e0-7139-2a5dcb46476b@schaufler-ca.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 20010220-4275-0000-0000-000003942FBF
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20010220-4276-0000-0000-000038A8134F
Message-Id: <1577997415.5874.122.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2020-01-02_06:2020-01-02,2020-01-02 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 priorityscore=1501 bulkscore=0 clxscore=1015 impostorscore=0 phishscore=0
 mlxscore=0 malwarescore=0 spamscore=0 adultscore=0 mlxlogscore=999
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-2001020165
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, 2020-01-02 at 12:21 -0800, Casey Schaufler wrote:
> On 1/2/2020 11:18 AM, Mimi Zohar wrote:
> > On Thu, 2020-01-02 at 09:06 -0800, Casey Schaufler wrote:
> >> IMA refines security_audit_rule_init to security_filter_rule_init.
> >> I need to understand what, if any, relationship there is between
> >> IMA's use of the audit rule mechanisms and the audit system's use.
> >> Is this simple code reuse, or is there some interaction between IMA
> >> and audit?
> >>
> >> I'm trying to sort out the problem of audit rules when
> >> there are multiple security modules. It looks as if there is also a
> >> problem for integrity rules, but it looks different. The "easy"
> >> change for audit doesn't fit with what's in IMA. If there's no
> >> interaction between the IMA and audit use of the rule infrastructure
> >> it's reasonable to fix them separately. If there is interaction
> >> things get messy.
> > They're both comparing rules with LSM labels.  In IMA's case, the LSM
> > labels are used to identify which files are in/out of the IMA policy -
> > "measurement", "appraisal", and "audit".  I'm not sure how different
> > this is than the audit subsystem.
> 
> On a system that has both SELinux and Smack the audit admin might
> want to set a rule on the label "system_u:object_r:something_t".
> The LSM infrastructure can't tell if this is an SELinux label or a
> Smack label, as it's valid for both. This is easily handled by
> keeping an array of pointers for LSM checks, with a value set for
> any module that wants to look for that label.
>  
> IMA uses a very different data representation for its events than
> audit does, making it much less obvious how to go about retaining
> the security module to IMA event mapping. I'm looking at options.

IMA converts the labels to an LSM value on initialization, or when the
LSM policy is updated, by calling security_filter_rule_init(), a
pseudonym for security_audit_rule_init().  I would assume audit is
doing something similar.

Mimi

