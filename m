Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72257251E95
	for <lists+linux-integrity@lfdr.de>; Tue, 25 Aug 2020 19:42:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726580AbgHYRmi (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 25 Aug 2020 13:42:38 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:2110 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726119AbgHYRma (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 25 Aug 2020 13:42:30 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 07PHVkMg119397;
        Tue, 25 Aug 2020 13:42:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=YaEteyqYhXWEEFt5cfVRUCG9Bu1VG3wqjnkN65nMqUU=;
 b=oHzfQuFHJc2IeY8KZsVVlhLHqj2OMy70BTA+F3OMcrOxPDIAyO+EAS2fJ5q16Ts+xsIf
 SkZ2VoL1DDsssHMt6y6Zy3MVlwyCY3OYZRVuC8Kp4SJEPocEfxvKdnvTF7LIH0zElxk1
 Yu6HGgvBATpY5tsfyz2VXxzEDm0YSXLxHUK3/8bafDK2gq+NAfH6Q1CVBW+HL9GzYwkx
 PEhZTyelB5mefmatnWDEpuVLO4eEW8wgbco3S6tHv+A+bvIGqrroa5QuJrV29/OP94AP
 e8NG4rpBATZcGzSRBf/M3JCPnToqbpuXOQKgsffCpiyOVOXY06P7kxiZ2QBRTNwIo4xj CQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3356u68s7g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 Aug 2020 13:42:21 -0400
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 07PHW9b2121391;
        Tue, 25 Aug 2020 13:42:21 -0400
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3356u68s71-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 Aug 2020 13:42:21 -0400
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 07PHbpeV010599;
        Tue, 25 Aug 2020 17:42:19 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma03ams.nl.ibm.com with ESMTP id 332ujkup8c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 Aug 2020 17:42:19 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 07PHgHj511010526
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 Aug 2020 17:42:17 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 399674C04E;
        Tue, 25 Aug 2020 17:42:17 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A48D14C04A;
        Tue, 25 Aug 2020 17:42:14 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.103.4])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 25 Aug 2020 17:42:14 +0000 (GMT)
Message-ID: <49f8a616d80344c539b512f8b83590ea281ee54d.camel@linux.ibm.com>
Subject: Re: [PATCH] IMA: Handle early boot data measurement
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        stephen.smalley.work@gmail.com, casey@schaufler-ca.com
Cc:     tyhicks@linux.microsoft.com, tusharsu@linux.microsoft.com,
        sashal@kernel.org, jmorris@namei.org,
        linux-integrity@vger.kernel.org, selinux@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Tue, 25 Aug 2020 13:42:13 -0400
In-Reply-To: <307617de-b42d-ac52-6e9e-9e0d16bbc20e@linux.microsoft.com>
References: <20200821231230.20212-1-nramas@linux.microsoft.com>
         <a7ea2da1f895ee3db4697c00804160acb6db656e.camel@linux.ibm.com>
         <307617de-b42d-ac52-6e9e-9e0d16bbc20e@linux.microsoft.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-12.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-25_08:2020-08-25,2020-08-25 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 lowpriorityscore=0 spamscore=0 mlxscore=0 phishscore=0 bulkscore=0
 adultscore=0 suspectscore=0 priorityscore=1501 clxscore=1015
 impostorscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2006250000 definitions=main-2008250129
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, 2020-08-25 at 08:46 -0700, Lakshmi Ramasubramanian wrote:
> On 8/25/20 8:40 AM, Mimi Zohar wrote:
> > On Fri, 2020-08-21 at 16:12 -0700, Lakshmi Ramasubramanian wrote:
> > > The current implementation of early boot measurement in
> > > the IMA subsystem is very specific to asymmetric keys. It does not
> > > handle early boot measurement of data from other subsystems such as
> > > Linux Security Module (LSM), Device-Mapper, etc. As a result data,
> > > provided by these subsystems during system boot are not measured by IMA.
> > > 
> > > Update the early boot key measurement to handle any early boot data.
> > > Refactor the code from ima_queue_keys.c to a new file ima_queue_data.c.
> > > Rename the kernel configuration CONFIG_IMA_QUEUE_EARLY_BOOT_KEYS to
> > > CONFIG_IMA_QUEUE_EARLY_BOOT_DATA so it can be used for enabling any
> > > early boot data measurement. Since measurement of asymmetric keys is
> > > the first consumer of early boot measurement, this kernel configuration
> > > is enabled if IMA_MEASURE_ASYMMETRIC_KEYS and SYSTEM_TRUSTED_KEYRING are
> > > both enabled.
> > > 
> > > Update the IMA hook ima_measure_critical_data() to utilize early boot
> > > measurement support.
> > 
> > Please limit the changes in this patch to renaming the functions and/or
> > files.  For example, adding "measure_payload_hash" should be a separate
> > patch, not hidden here.
> > 
> 
> Thanks for the feedback Mimi.
> 
> I'll split this into 2 patches:
> 
> PATCH 1: Rename files + rename CONFIG
> PATCH 2: Update IMA hook to utilize early boot data measurement.

I'm referring to introducing the "measure_payload_hash" flag.  I assume
this is to indicate whether the buffer should be hashed or not.  

Example 1: ima_alloc_key_entry() and ima_alloc_data_entry(0 comparison
> -static struct ima_key_entry *ima_alloc_key_entry(struct key *keyring,
> -                                                const void *payload,
> -                                                size_t payload_len)
> -{


> +static struct ima_data_entry *ima_alloc_data_entry(const char *event_name,
> +                                                  const void *payload,
> +                                                  size_t payload_len,
> +                                                  const char *event_data,
> +                                                  enum ima_hooks func,
> +                                                  bool measure_payload_hash)  <====
> +{

Example 2:  
diff --git a/security/integrity/ima/ima_asymmetric_keys.c b/security/integrity/ima/ima_asymmetric_keys.c
index a74095793936..65423754765f 100644
--- a/security/integrity/ima/ima_asymmetric_keys.c
+++ b/security/integrity/ima/ima_asymmetric_keys.c
@@ -37,9 +37,10 @@ void ima_post_key_create_or_update(struct key *keyring, struct key *key,
        if (!payload || (payload_len == 0))
                return;
 
-       if (ima_should_queue_key())
-               queued = ima_queue_key(keyring, payload, payload_len);
-
+       if (ima_should_queue_data())
+               queued = ima_queue_data(keyring->description, payload,
+                                       payload_len, keyring->description,
+                                       KEY_CHECK, false);   <===
        if (queued)
                return;

But in general, as much as possible function and file name changes
should be done independently of other changes.

thanks,

Mimi

