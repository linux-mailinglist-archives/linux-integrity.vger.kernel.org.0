Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50DF92A972C
	for <lists+linux-integrity@lfdr.de>; Fri,  6 Nov 2020 14:43:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727353AbgKFNnW (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 6 Nov 2020 08:43:22 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:31222 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726708AbgKFNnW (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 6 Nov 2020 08:43:22 -0500
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0A6DbTfk095718;
        Fri, 6 Nov 2020 08:43:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=TuBf/6UR73LWJaaVgiNYfCFd4f2OcwVJWUGa7qux3W8=;
 b=P2aQctbngYEygPUfbBejgF4uBkI+2owNKPFizEnVbWI8yj5I4pVB2QYMGg8Of87AAK+u
 lnvtyC0dY/Ku9fMTAR2mNH3Z7E+YsQEf1fTNQMz8tmGwqaPwwuT6Y5MR8wYejazz4ae/
 XiC2ztPd3oE8vf+MgNa0Rk/mxOnn+dfrfp2FiDqoKauc80IhxFAIW2r7M+C20qUq5Vjs
 hQNiToMNM3z+R/kMw5k8uKC37ADY5MMpvqLdXFdduv5IV+8aP33IjJoFh15UeL1VnMSy
 L4vjgwI9/sLRb6ROMHv5BRdT4QN8Naxi54eKipZCEJuafmNNNgvj2bFD0txDNT2BM2G1 zg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 34m7teu97j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 06 Nov 2020 08:43:15 -0500
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 0A6D4svQ096378;
        Fri, 6 Nov 2020 08:43:14 -0500
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0a-001b2d01.pphosted.com with ESMTP id 34m7teu93m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 06 Nov 2020 08:43:14 -0500
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0A6Dh9jT015155;
        Fri, 6 Nov 2020 13:43:09 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma01fra.de.ibm.com with ESMTP id 34jbyttffn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 06 Nov 2020 13:43:08 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0A6Dh6YD6423102
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 6 Nov 2020 13:43:06 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7FE93A4060;
        Fri,  6 Nov 2020 13:43:06 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B31CAA405C;
        Fri,  6 Nov 2020 13:43:02 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.77.67])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri,  6 Nov 2020 13:43:02 +0000 (GMT)
Message-ID: <6d835878af2f11c837633510775742e57a1506eb.camel@linux.ibm.com>
Subject: Re: [PATCH v5 4/7] IMA: add policy to measure critical data
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Tushar Sugandhi <tusharsu@linux.microsoft.com>,
        stephen.smalley.work@gmail.com, casey@schaufler-ca.com,
        agk@redhat.com, snitzer@redhat.com, gmazyland@gmail.com,
        paul@paul-moore.com
Cc:     tyhicks@linux.microsoft.com, sashal@kernel.org, jmorris@namei.org,
        nramas@linux.microsoft.com, linux-integrity@vger.kernel.org,
        selinux@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, dm-devel@redhat.com
Date:   Fri, 06 Nov 2020 08:43:01 -0500
In-Reply-To: <20201101222626.6111-5-tusharsu@linux.microsoft.com>
References: <20201101222626.6111-1-tusharsu@linux.microsoft.com>
         <20201101222626.6111-5-tusharsu@linux.microsoft.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-12.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-06_04:2020-11-05,2020-11-06 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 impostorscore=0
 clxscore=1015 mlxscore=0 malwarescore=0 mlxlogscore=999 priorityscore=1501
 suspectscore=0 lowpriorityscore=0 bulkscore=0 spamscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011060092
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Tushar,

On Sun, 2020-11-01 at 14:26 -0800, Tushar Sugandhi wrote:
> System administrators should be able to choose which kernel subsystems
> they want to measure the critical data for. To enable that, an IMA policy
> option to choose specific kernel subsystems is needed. This policy option
> would constrain the measurement of the critical data to the given kernel
> subsystems.

Measuring critical data should not be dependent on the source of the
critical data.   This patch needs to be split up.  The "data sources"
should be move to it's own separate patch.  This patch should be
limited to adding the policy code needed for measuring criticial data. 
Limiting critical data sources should be the last patch in this series.

thanks,

Mimi

> 
> Add a new IMA policy option - "data_sources:=" to the IMA func 
> CRITICAL_DATA to allow measurement of various kernel subsystems. This
> policy option would enable the system administrators to limit the
> measurement to the subsystems listed in "data_sources:=", if the 
> subsystem measures its data by calling ima_measure_critical_data().
> 
> Limit the measurement to the subsystems that are specified in the IMA
> policy - CRITICAL_DATA+"data_sources:=". If "data_sources:=" is not
> provided with the func CRITICAL_DATA, measure the data from all the
> supported kernel subsystems.
> 
> Signed-off-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>

