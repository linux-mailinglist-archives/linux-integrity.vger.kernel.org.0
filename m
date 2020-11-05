Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBAF72A73CE
	for <lists+linux-integrity@lfdr.de>; Thu,  5 Nov 2020 01:31:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728403AbgKEAbg (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 4 Nov 2020 19:31:36 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:47334 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726608AbgKEAbg (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 4 Nov 2020 19:31:36 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0A502iGx158963;
        Wed, 4 Nov 2020 19:31:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=yivi4zlLHJOmQkJ8XdvyMwcE+ckYUunTAHKNhQqH+8g=;
 b=TDHeMx/CqCLpyk6SwlWTb36CYRYLC3672MmKlSQkhEo2YUzAOhTqYPg0nnrXjIOiXDXb
 AsjfVwPFb+AkV8saJ1W0VacgExviQ3s4LeBDWL9H+5Y/60gzoMN8itnEJ9EEpsw4tbI1
 bngRCX+j5L4iJNfnJ8K1itkFMK6Vsl1a+Jl4U1Wnh9k/x29TB/4LDyXxYWfc8dsiisP+
 QwyQtYDQT1j2TCY53EJdVW9W6CvJ/0oG6V/fa3EydoMaO997okQz6k4+7tdnqFmwxVPN
 TmT05mOsx5zEgcywZIkKypEu8jpv1EejTG9w+qLmElLO+Y5MokWZnYi5RxT/pdFu2Swq 7w== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 34m5db1w17-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 04 Nov 2020 19:31:28 -0500
Received: from m0098414.ppops.net (m0098414.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 0A50MOuk033654;
        Wed, 4 Nov 2020 19:31:28 -0500
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0b-001b2d01.pphosted.com with ESMTP id 34m5db1w0h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 04 Nov 2020 19:31:28 -0500
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0A50SmCG017451;
        Thu, 5 Nov 2020 00:31:26 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma04ams.nl.ibm.com with ESMTP id 34h01ucnp4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 05 Nov 2020 00:31:26 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0A50VN499962206
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 5 Nov 2020 00:31:24 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D44434C04A;
        Thu,  5 Nov 2020 00:31:23 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3EAF34C04E;
        Thu,  5 Nov 2020 00:31:20 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.13.183])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu,  5 Nov 2020 00:31:20 +0000 (GMT)
Message-ID: <c840953db2937296c8d77d5d3b4e1274bf990e46.camel@linux.ibm.com>
Subject: Re: [PATCH v5 0/7] IMA: Infrastructure for measurement of critical
 kernel data
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Tushar Sugandhi <tusharsu@linux.microsoft.com>,
        stephen.smalley.work@gmail.com, casey@schaufler-ca.com,
        agk@redhat.com, snitzer@redhat.com, gmazyland@gmail.com,
        paul@paul-moore.com
Cc:     tyhicks@linux.microsoft.com, sashal@kernel.org, jmorris@namei.org,
        nramas@linux.microsoft.com, linux-integrity@vger.kernel.org,
        selinux@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, dm-devel@redhat.com
Date:   Wed, 04 Nov 2020 19:31:19 -0500
In-Reply-To: <20201101222626.6111-1-tusharsu@linux.microsoft.com>
References: <20201101222626.6111-1-tusharsu@linux.microsoft.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-12.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-04_17:2020-11-04,2020-11-04 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxlogscore=999
 clxscore=1011 phishscore=0 lowpriorityscore=0 suspectscore=0 spamscore=0
 priorityscore=1501 bulkscore=0 mlxscore=0 impostorscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011040171
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Tushar,

Measuring "critical kernel data" is not a new infrastructure, simply a
new IMA hook.   Please update the above Subject line to "support for
measuring critical kernel data".

On Sun, 2020-11-01 at 14:26 -0800, Tushar Sugandhi wrote:
> There are several kernel subsystems that contain critical data which if
> accidentally or maliciously altered, can compromise the integrity of the
> system. Examples of such subsystems would include LSMs like SELinux, or
> AppArmor; or device-mapper targets like dm-crypt, dm-verity etc. 
> "critical data" in this context is kernel subsystem specific information
> that is stored in kernel memory. Examples of critical data could be
> kernel in-memory r/o structures, hash of the memory structures, or
> data that represents a linux kernel subsystem state.

This is a bit better, but needs to be much clearer.  Please define
"critical data", not by example, but by describing "what" critical
kernel data is.  "There are several kernel subsystems ...."  is an
example of "how" it would be used, not a definition.  Without a clear
definition it will become a dumping ground for measuring anything
anyone wants to measure.  As a result, it may be abused.

> 
> This patch set defines a new IMA hook namely CRITICAL_DATA, and a
> function ima_measure_critical_data() - to measure the critical data. 

The name of the IMA hook is ima_measure_critical_data.  This is similar
to the LSM hooks, which are prefixed with "security_".  (For a full
list of LSM hooks, refer to lsm_hook_defs.h.)

> Kernel subsystems can use this functionality, to take advantage of IMA's
> measuring and quoting abilities - thus ultimately enabling remote
> attestation for the subsystem specific information stored in the kernel
> memory.
> 
> The functionality is generic enough to measure the data of any kernel
> subsystem at run-time. To ensure that only data from supported sources
> are measured, the kernel subsystem needs to be added to a compile-time
> list of supported sources (an "allowed list of components"). IMA
> validates the source passed to ima_measure_critical_data() against this
> allowed list at run-time.

Yes, this new feature is generic, but one of the main goals of IMA is
to measure and attest to the integrity of the system, not to measure
and attest to random things.

> 
> System administrators may want to pick and choose which kernel
> subsystem information they would want to enable for measurements,
> quoting, and remote attestation. To enable that, a new IMA policy is
> introduced.

^may want to limit the critical data being measured, quoted and
attested.
^ a new IMA policy condition is defined.

> 
> This patch set also addresses the need for the kernel subsystems to
> measure their data before a custom IMA policy is loaded - by providing
> a builtin IMA policy.

^for measuring kernel critical data early, before a custom IMA policy
...

> 
> And lastly, the use of the overall functionality is demonstrated by
> measuring the kernel in-memory data for one such subsystem - SeLinux.

The purpose isn't to demonstrate the "overall functionality", but to
provide an initial caller of the new IMA hook.

thanks,

Mimi

