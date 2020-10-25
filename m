Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF406297FE8
	for <lists+linux-integrity@lfdr.de>; Sun, 25 Oct 2020 04:36:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1766935AbgJYDgI (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sat, 24 Oct 2020 23:36:08 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:46686 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1762952AbgJYDgI (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sat, 24 Oct 2020 23:36:08 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 09P3Vfpa048417;
        Sat, 24 Oct 2020 23:36:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=f6c5YRP6wKJcOYJ6F1ufzms6nMkKE3xLN5sdbD90VrM=;
 b=ifGNjgOfwjK1lmoqls57eVdLtj/Yf467Q0wCDEkYt1lhwjQmoGtW5Y4U6Wqhk9BgHybN
 7l4P4rkWHWQ/GWthPn+0d+1LfExETAE/tvj+FRIuMp+Gd7/gj1wPRjungRpEwgO5/6DX
 hkBexZu3pvdOl87pLN1I4GziQC/M1WJIyGC7++M3LgDCQo+I9zdLadMsVRQkefsJk0Nk
 ElWlEHZUMZeS5LuYUejdm2Z0N64h0VcDQTgeIiiTMWWgFduAkFDZvNOKsJRqMDaF2mXX
 gKFm4s63cTNeUgYcBRgI7Y4+5F6d5//Ln4DsD+jFwSteTH63QLj2J4TCSJu419KD98wM EQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 34d0xs8qmy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 24 Oct 2020 23:36:02 -0400
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 09P3a2NB060532;
        Sat, 24 Oct 2020 23:36:02 -0400
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0a-001b2d01.pphosted.com with ESMTP id 34d0xs8qmj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 24 Oct 2020 23:36:02 -0400
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 09P3UBRi027808;
        Sun, 25 Oct 2020 03:35:59 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma05fra.de.ibm.com with ESMTP id 34cbw88e5h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 25 Oct 2020 03:35:59 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 09P3ZvoH37159234
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 25 Oct 2020 03:35:57 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 86DDAA4065;
        Sun, 25 Oct 2020 03:35:57 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 23FCEA405B;
        Sun, 25 Oct 2020 03:35:54 +0000 (GMT)
Received: from sig-9-65-192-162.ibm.com (unknown [9.65.192.162])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Sun, 25 Oct 2020 03:35:53 +0000 (GMT)
Message-ID: <2c7da61fbeb17c577253b117829b3bd544d8cf44.camel@linux.ibm.com>
Subject: Re: [PATCH v4 0/6] IMA: Infrastructure for measurement of critical
 kernel data
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Tushar Sugandhi <tusharsu@linux.microsoft.com>,
        stephen.smalley.work@gmail.com, casey@schaufler-ca.com,
        agk@redhat.com, snitzer@redhat.com, gmazyland@gmail.com
Cc:     tyhicks@linux.microsoft.com, sashal@kernel.org, jmorris@namei.org,
        nramas@linux.microsoft.com, linux-integrity@vger.kernel.org,
        selinux@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, dm-devel@redhat.com
Date:   Sat, 24 Oct 2020 23:35:53 -0400
In-Reply-To: <20200923192011.5293-1-tusharsu@linux.microsoft.com>
References: <20200923192011.5293-1-tusharsu@linux.microsoft.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-12.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.737
 definitions=2020-10-25_01:2020-10-23,2020-10-25 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 spamscore=0
 adultscore=0 suspectscore=3 impostorscore=0 mlxscore=0 priorityscore=1501
 malwarescore=0 bulkscore=0 lowpriorityscore=0 clxscore=1015
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2010250022
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Tushar,

On Wed, 2020-09-23 at 12:20 -0700, Tushar Sugandhi wrote:
> There are several kernel components that contain critical data which if
> accidentally or maliciously altered, can compromise the security of the
> kernel. Example of such components would include LSMs like SELinux, or
> AppArmor; or device-mapper targets like dm-crypt, dm-verity etc.

^"the integrity of the system."

This cover letter needs to be re-written from a higher perspective,
explaining what is meant by "critical data" (e.g. kernel subsystem
specific information only stored in kernel memory).

> 
> Many of these components do not use the capabilities provided by kernel
> integrity subsystem (IMA), and thus they don't use the benefits of
> extended TPM PCR quotes and ultimately the benefits of remote attestation.

True, up until recently IMA only measured files, nothing else.  Why is
this paragraph needed?  What new information is provided?

> This series bridges this gap, so that potential kernel components that
> contain data critical to the security of the kernel could take advantage
> of IMA's measuring and quoting abilities - thus ultimately enabling
> remote attestation for their specific data.

Perhaps, something more along the lines, "This patch set defines a new
IMA hook named ... to measure critical data."

> 
> System administrators may want to pick and choose which kernel
> components they would want to enable for measurements, quoting, and
> remote attestation. To enable that, a new IMA policy is introduced.

Reverse the order of this paragraph and the following one, describing
the new feature and only afterwards explaining how it may be
constrained.

> 
> And lastly, the functionality is exposed through a function
> ima_measure_critical_data(). The functionality is generic enough to
> measure the data of any kernel component at run-time. To ensure that
> only data from supported sources are measured, the kernel component
> needs to be added to a compile-time list of supported sources (an
> "allowed list of components"). IMA validates the source passed to
> ima_measure_critical_data() against this allowed list at run-time.

This patch set must include at least one example of measuring critical
data, before it can be upstreamed.  Tushar, please coordinate with
Lakshmi and Raphael.

thanks,

Mimi

