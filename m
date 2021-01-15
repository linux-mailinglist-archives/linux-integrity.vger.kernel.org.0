Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4ACA82F7AD4
	for <lists+linux-integrity@lfdr.de>; Fri, 15 Jan 2021 13:56:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387547AbhAOMzo (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 15 Jan 2021 07:55:44 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:57162 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387432AbhAOMzh (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 15 Jan 2021 07:55:37 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 10FChZkS069087;
        Fri, 15 Jan 2021 07:54:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=zr8ucYm/euG5aZ/Crxkx/ZKJSlbjbnPNJdYEzl/ZSRM=;
 b=aXcegOv87io7bFkwnJuL0pg8eHaQjh9qE/7XDrZMn0hPDf9YZ9CXmdw8R7sKxvq5V4NS
 V/f8fgoM6mvrlTvZ9toRlVI6yPPgS+K6Wq9dFylsdsiLKLTJhsqR9303KIUZoTUfMiMk
 mN73IHQEcWbmhZ1sMaPKy1tSGZDv0x7+ydrnUYjbAmdxAg8LRTBmtroV/FgIXDgd38tl
 GCorkH93Mr6+giSfYjGQ95q6oSDMul+U2KndiK2nR8NU9cH+2eBOcz50z+0bwTrSCuSE
 jGYwq02jQZWnA2C+dE2VjrQ7uaYjXi1YaMHPf1rDvsMgixCO6SrPOLC9wceAQcKF7R51 Tg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 363ba808u9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 15 Jan 2021 07:54:52 -0500
Received: from m0098394.ppops.net (m0098394.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 10FCspkm150385;
        Fri, 15 Jan 2021 07:54:51 -0500
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0a-001b2d01.pphosted.com with ESMTP id 363ba808t1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 15 Jan 2021 07:54:51 -0500
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 10FCrcRI016803;
        Fri, 15 Jan 2021 12:54:49 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma05fra.de.ibm.com with ESMTP id 35y448c04e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 15 Jan 2021 12:54:49 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 10FCsfKd27656698
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 15 Jan 2021 12:54:41 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C723C5204F;
        Fri, 15 Jan 2021 12:54:46 +0000 (GMT)
Received: from sig-9-65-220-78.ibm.com (unknown [9.65.220.78])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 7B1D05204E;
        Fri, 15 Jan 2021 12:54:43 +0000 (GMT)
Message-ID: <5189c15054885863b1b5cb86a43bec09725d8650.camel@linux.ibm.com>
Subject: Re: [PATCH v10 0/8] IMA: support for measuring kernel integrity
 critical data
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Tushar Sugandhi <tusharsu@linux.microsoft.com>,
        stephen.smalley.work@gmail.com, casey@schaufler-ca.com,
        agk@redhat.com, snitzer@redhat.com, gmazyland@gmail.com,
        paul@paul-moore.com
Cc:     tyhicks@linux.microsoft.com, sashal@kernel.org, jmorris@namei.org,
        nramas@linux.microsoft.com, linux-integrity@vger.kernel.org,
        selinux@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, dm-devel@redhat.com
Date:   Fri, 15 Jan 2021 07:54:42 -0500
In-Reply-To: <20210108040708.8389-1-tusharsu@linux.microsoft.com>
References: <20210108040708.8389-1-tusharsu@linux.microsoft.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-14.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2021-01-15_07:2021-01-15,2021-01-15 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 phishscore=0 priorityscore=1501 suspectscore=0 adultscore=0
 clxscore=1015 mlxscore=0 impostorscore=0 mlxlogscore=999 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101150077
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, 2021-01-07 at 20:07 -0800, Tushar Sugandhi wrote:
> IMA measures files and buffer data such as keys, command-line arguments
> passed to the kernel on kexec system call, etc.  While these measurements
> are necessary for monitoring and validating the integrity of the system,
> they are not sufficient.  Various data structures, policies, and states
> stored in kernel memory also impact the integrity of the system.
> Several kernel subsystems contain such integrity critical data -
> e.g.  LSMs like SELinux, AppArmor etc.  or device-mapper targets like
> dm-crypt, dm-verity, dm-integrity etc.  These kernel subsystems help
> protect the integrity of a system.  Their integrity critical data is not
> expected to change frequently during run-time.  Some of these structures
> cannot be defined as __ro_after_init, because they are initialized later.
> 
> For a given system, various external services/infrastructure tools
> (including the attestation service) interact with it - both during the
> setup and during rest of the system run-time.  They share sensitive data
> and/or execute critical workload on that system.  The external services
> may want to verify the current run-time state of the relevant kernel
> subsystems before fully trusting the system with business critical
> data/workload.  For instance, verifying that SELinux is in "enforce" mode
> along with the expected policy, disks are encrypted with a certain
> configuration, secure boot is enabled etc.
> 
> This series provides the necessary IMA functionality for kernel
> subsystems to ensure their configuration can be measured:
>   - by kernel subsystems themselves,
>   - in a tamper resistant way,
>   - and re-measured - triggered on state/configuration change.
> 
> This patch set:
>   - defines a new IMA hook ima_measure_critical_data() to measure
>     integrity critical data,
>   - limits the critical data being measured based on a label,
>   - defines a builtin critical data measurement policy,
>   - and includes an SELinux consumer of the new IMA critical data hook.

Thanks Tushar, Lakshmi.  This patch set is queued in the next-
integrity-testing branch.

Mimi

