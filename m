Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 833D72BAF4C
	for <lists+linux-integrity@lfdr.de>; Fri, 20 Nov 2020 16:52:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728332AbgKTPtg (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 20 Nov 2020 10:49:36 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:56590 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728320AbgKTPtg (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 20 Nov 2020 10:49:36 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0AKF5Vwj110532;
        Fri, 20 Nov 2020 10:49:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=LXHxzZl79d/48T/rQQacXvVSsfNSE7G5+2LE7Q57eKo=;
 b=I8SSCr9YTv2WeKix3NeKWxs+8xdgcnKnPpjkIjXxWD/RbF2FT2+4Aj4Q4J088qxubchR
 GSDRPdVCwKsBHMPonxZ+Ak18Guh0DmB4Lxsg2W7xl6YmdiVq1osZM10iksibK51jqoHf
 0n5AJxFxPMUivyvpLfoBlBDjbg7IKV5IjRTAQyp1BGwrLu+omq1i6w7lByyHLg82pNSW
 2Y6FqsszwsigZGtBktys5qpuTzyVhvhqujUKQBm2Qd0dO40mkpdYHyYTihFmUeQvfn0D
 zegiRb5IpfxxD2dJGnzfdKnSArMn7Rf4Mg7kSM4ukj9ZmRRAPLJ7Vv6wWuY1wRsUXkX9 2g== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 34xd1kr363-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 20 Nov 2020 10:49:30 -0500
Received: from m0098394.ppops.net (m0098394.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 0AKF5s3J113261;
        Fri, 20 Nov 2020 10:49:29 -0500
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com with ESMTP id 34xd1kr34k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 20 Nov 2020 10:49:29 -0500
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0AKFloc2012106;
        Fri, 20 Nov 2020 15:49:27 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma06ams.nl.ibm.com with ESMTP id 34w4yfj8rg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 20 Nov 2020 15:49:27 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0AKFnO0Q60490060
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 20 Nov 2020 15:49:24 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9C95311C050;
        Fri, 20 Nov 2020 15:49:24 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 58FD111C058;
        Fri, 20 Nov 2020 15:49:21 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.96.125])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 20 Nov 2020 15:49:21 +0000 (GMT)
Message-ID: <4634c6c12b2452849f73ed2d5a4d168707e0ac9a.camel@linux.ibm.com>
Subject: Re: [PATCH v6 8/8] selinux: measure state and hash of the policy
 using IMA
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Tushar Sugandhi <tusharsu@linux.microsoft.com>,
        stephen.smalley.work@gmail.com, casey@schaufler-ca.com,
        agk@redhat.com, snitzer@redhat.com, gmazyland@gmail.com,
        paul@paul-moore.com
Cc:     tyhicks@linux.microsoft.com, sashal@kernel.org, jmorris@namei.org,
        nramas@linux.microsoft.com, linux-integrity@vger.kernel.org,
        selinux@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, dm-devel@redhat.com
Date:   Fri, 20 Nov 2020 10:49:20 -0500
In-Reply-To: <20201119232611.30114-9-tusharsu@linux.microsoft.com>
References: <20201119232611.30114-1-tusharsu@linux.microsoft.com>
         <20201119232611.30114-9-tusharsu@linux.microsoft.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-12.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-20_07:2020-11-20,2020-11-20 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 phishscore=0 clxscore=1015 suspectscore=0 bulkscore=0
 lowpriorityscore=0 adultscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011200104
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Tushar, Lakshmi,

On Thu, 2020-11-19 at 15:26 -0800, Tushar Sugandhi wrote:
> From: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
> 
> IMA measures files and buffer data such as keys, command line arguments
> passed to the kernel on kexec system call, etc. While these measurements
> enable monitoring and validating the integrity of the system, it is not
> sufficient. 

The above paragraph would make a good cover letter introduction.

> In-memory data structures maintained by various kernel
> components store the current state and policies configured for
> the components. 

Various data structures, policies and state stored in kernel memory
also impact the  integrity of the system.

The 2nd paragraph could provide examples of such integrity critical
data.

This patch set introduces a new IMA hook named
ima_measure_critical_data() to measure kernel integrity critical data.

thanks,

Mimi

