Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A33A7251C73
	for <lists+linux-integrity@lfdr.de>; Tue, 25 Aug 2020 17:40:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726514AbgHYPkm (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 25 Aug 2020 11:40:42 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:45510 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725998AbgHYPkl (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 25 Aug 2020 11:40:41 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 07PFXQ0U074972;
        Tue, 25 Aug 2020 11:40:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=yMwbzI8DRQBhwKsLR3tDH4EBDq3DYbqddm2fcfs2stY=;
 b=gs1qaOpXwCoRLJYPUasHUPKNgeEvBc4nTuoqTkYPYQO8GQjZVfgakx1Ib3gRzaSAfBQB
 /AXw62eFumZHayBlTIdPNx/igqu7rCeVQg0Jy0cLd9e6YRFvcFiM6Nm3mwyHcF2lVdYc
 rldfMcWLygj64pVKliErC6nLdTuSeOG3Rv/iPyrJ2B29yhNwBa8gNzelpWTrJUaUr0kq
 Fl+hyzHabMdd8GNUfYzyP/WOdGETjAU3uET2xvZXrOLkQPJ/gKxl/F7bAbMxZDZA6Y7V
 u9iSXMBVMXwCbvWKrh0ZRxESxZUbedm0LRE/92F9X3txd++53gnxo4EXrErEEIA5b8Wj ew== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3355bh0ef1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 Aug 2020 11:40:35 -0400
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 07PFXewI076532;
        Tue, 25 Aug 2020 11:40:35 -0400
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3355bh0ee2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 Aug 2020 11:40:34 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 07PFSBnS003009;
        Tue, 25 Aug 2020 15:40:32 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma04ams.nl.ibm.com with ESMTP id 33498u9gxj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 Aug 2020 15:40:32 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 07PFeTCg24576316
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 Aug 2020 15:40:30 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D66AEA405B;
        Tue, 25 Aug 2020 15:40:29 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8EEF7A4065;
        Tue, 25 Aug 2020 15:40:27 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.103.4])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 25 Aug 2020 15:40:27 +0000 (GMT)
Message-ID: <a7ea2da1f895ee3db4697c00804160acb6db656e.camel@linux.ibm.com>
Subject: Re: [PATCH] IMA: Handle early boot data measurement
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        stephen.smalley.work@gmail.com, casey@schaufler-ca.com
Cc:     tyhicks@linux.microsoft.com, tusharsu@linux.microsoft.com,
        sashal@kernel.org, jmorris@namei.org,
        linux-integrity@vger.kernel.org, selinux@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Tue, 25 Aug 2020 11:40:26 -0400
In-Reply-To: <20200821231230.20212-1-nramas@linux.microsoft.com>
References: <20200821231230.20212-1-nramas@linux.microsoft.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-12.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-25_05:2020-08-25,2020-08-25 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 suspectscore=0
 mlxscore=0 mlxlogscore=931 bulkscore=0 lowpriorityscore=0 impostorscore=0
 priorityscore=1501 adultscore=0 malwarescore=0 spamscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008250114
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, 2020-08-21 at 16:12 -0700, Lakshmi Ramasubramanian wrote:
> The current implementation of early boot measurement in
> the IMA subsystem is very specific to asymmetric keys. It does not
> handle early boot measurement of data from other subsystems such as
> Linux Security Module (LSM), Device-Mapper, etc. As a result data,
> provided by these subsystems during system boot are not measured by IMA.
> 
> Update the early boot key measurement to handle any early boot data.
> Refactor the code from ima_queue_keys.c to a new file ima_queue_data.c.
> Rename the kernel configuration CONFIG_IMA_QUEUE_EARLY_BOOT_KEYS to
> CONFIG_IMA_QUEUE_EARLY_BOOT_DATA so it can be used for enabling any
> early boot data measurement. Since measurement of asymmetric keys is
> the first consumer of early boot measurement, this kernel configuration
> is enabled if IMA_MEASURE_ASYMMETRIC_KEYS and SYSTEM_TRUSTED_KEYRING are
> both enabled.
> 
> Update the IMA hook ima_measure_critical_data() to utilize early boot
> measurement support.

Please limit the changes in this patch to renaming the functions and/or
files.  For example, adding "measure_payload_hash" should be a separate
patch, not hidden here.

Mimi

