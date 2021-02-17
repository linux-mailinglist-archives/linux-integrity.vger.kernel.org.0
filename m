Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FD6E31E09E
	for <lists+linux-integrity@lfdr.de>; Wed, 17 Feb 2021 21:40:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233948AbhBQUkN (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 17 Feb 2021 15:40:13 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:12424 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S231372AbhBQUkM (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 17 Feb 2021 15:40:12 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 11HKVZEm004928;
        Wed, 17 Feb 2021 15:39:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=Uv/VsbMkjDDcE/fG4/p2xFwjYLvP0biQL5L8n3jQGw4=;
 b=HDFEw+c8kIc6tB4lBKuV0qY/wJnRauBhZSEz2g3X8J7lBkcLhMMONwuX9adJyXYU17UL
 +Fb3JOI3PEInd1Mz1WB5I1MltUutGGwdE3g0oTr53gy53K+BrXqb6B98dPyMM+gHx3qV
 OhxZSCqUI/c3GqsAwYzUXTCQLlMZgSQsBtAqGikLeTCo22K8TSD2XHpg/f6g63FzLa4U
 LIK/use1dVwJTK0h/d31MofMhk2X6aR1K9vInbXmZTNcBEcj1EQH1IPcr6/KnwtQ/pAY
 tObyJVKkx2fi2xbmgJPNpZUHMwKpEU+rHC1ry+ExWvhnhhAS5xAVEi/kfb3E7caj7R9I 4Q== 
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0b-001b2d01.pphosted.com with ESMTP id 36s9h7se06-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 17 Feb 2021 15:39:27 -0500
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 11HKcumW018411;
        Wed, 17 Feb 2021 20:39:25 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma05fra.de.ibm.com with ESMTP id 36p6d8j3c9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 17 Feb 2021 20:39:25 +0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 11HKdBsF36438464
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 17 Feb 2021 20:39:11 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0F84042045;
        Wed, 17 Feb 2021 20:39:23 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3511142041;
        Wed, 17 Feb 2021 20:39:21 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.163.42.84])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 17 Feb 2021 20:39:20 +0000 (GMT)
Message-ID: <bb4356d779720b8fa9c342647132cfeec938c296.camel@linux.ibm.com>
Subject: Re: [PATCH v2] IMA: support for duplicate data measurement
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Tushar Sugandhi <tusharsu@linux.microsoft.com>
Cc:     tyhicks@linux.microsoft.com, sashal@kernel.org, jmorris@namei.org,
        nramas@linux.microsoft.com, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Wed, 17 Feb 2021 15:39:19 -0500
In-Reply-To: <5236e03f-9be4-f7f3-ec6c-29f00c16dc18@linux.microsoft.com>
References: <20210217024649.23405-1-tusharsu@linux.microsoft.com>
         <ab197aa9719b4218ab497b55f0bc78a0dadc83dd.camel@linux.ibm.com>
         <5236e03f-9be4-f7f3-ec6c-29f00c16dc18@linux.microsoft.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-14.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-02-17_16:2021-02-16,2021-02-17 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 bulkscore=0
 phishscore=0 mlxlogscore=999 spamscore=0 priorityscore=1501
 impostorscore=0 suspectscore=0 lowpriorityscore=0 clxscore=1015
 adultscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2009150000 definitions=main-2102170148
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, 2021-02-17 at 10:53 -0800, Tushar Sugandhi wrote:
> Thanks for the feedback Mimi.
> Appreciate it.
> 
> On 2021-02-17 7:03 a.m., Mimi Zohar wrote:
> > Hi Tushar,
> > 
> > The Subject line could be improved.  Perhaps something like - "IMA:
> > support for duplicate measurement records"
> > 
> Will do.
> 
> > On Tue, 2021-02-16 at 18:46 -0800, Tushar Sugandhi wrote:
> >> IMA does not measure duplicate data since TPM extend is a very expensive
> >> operation.  However, in some cases, the measurement of duplicate data
> >> is necessary to accurately determine the current state of the system.
> >> Eg, SELinux state changing from 'audit', to 'enforcing', and back to
> >> 'audit' again.  In this example, currently, IMA will not measure the
> >> last state change to 'audit'.  This limits the ability of attestation
> >> services to accurately determine the current state of the measurements
> >> on the system.
> > 
> > This patch description is written from your specific usecase
> > perspective, but it impacts file and buffer data measurements as well,
> > not only critical data measurements.  In all of these situations, with
> > this patch a new measurement record is added/appended to the
> > measurement list.  Please re-write the patch description making it more
> > generic.
> > 
> > For example, I would start with something like, "IMA does not include
> > duplicate file, buffer or critical data measurement records ..."
> > 
> Agreed.
> I will generalize the description further and send the v3 for review.

It would be good to boot with the ima_policy=tcb policy with/without
your patch and account for the different number of measurements.   Are
all the differences related to duplicate measurements - original file
hash -> new file hash -> original file hash - similar to what you
described.

thanks,

Mimi

