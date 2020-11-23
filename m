Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD6DE2C14BF
	for <lists+linux-integrity@lfdr.de>; Mon, 23 Nov 2020 20:50:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730593AbgKWTt2 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 23 Nov 2020 14:49:28 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:16350 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728973AbgKWTt2 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 23 Nov 2020 14:49:28 -0500
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0ANJVUjP007843;
        Mon, 23 Nov 2020 14:49:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=0B9RKFIVUN2IsJ5nGG5ET35xVEvhvmpf5VR3A1EdtVw=;
 b=PTQJX6vRLuNFFGrSSIFWnCHNJkByX+ZN1uZnD1tNeGuMLztS6t21jN1wZh9xahrH2ALf
 nW1WE8XL39qmM+zhmEaxvBw6R0jWWE79RmCRBb9bZlfhQas8u/L2owlqKk9OMALNCOVr
 4Us4ic23o1mb1ftuKBZ4TJ8rkcMoLUnuJNVcA0jwaZSPzuASPiFT/eL10kgbmfT7pWzQ
 uKTM45/rFQPjmoxXRZ74gw0UEkihMXmlYkJOAQxfZeHkrSa30SRGHh+5PU1l2qZUmRK1
 GIFOx7Fr0MbchyYXF2FrHUkQWXRyRhF21F+lWS34u6vhVGhC2GRaLBvfOfUp/emzfJgo nQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 34ygtt4m2m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 23 Nov 2020 14:49:19 -0500
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 0ANJVerJ008563;
        Mon, 23 Nov 2020 14:49:18 -0500
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 34ygtt4m20-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 23 Nov 2020 14:49:18 -0500
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0ANJluVM026535;
        Mon, 23 Nov 2020 19:49:16 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma03ams.nl.ibm.com with ESMTP id 34xth8aurd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 23 Nov 2020 19:49:16 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0ANJnENL49152498
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 23 Nov 2020 19:49:14 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2D37952051;
        Mon, 23 Nov 2020 19:49:14 +0000 (GMT)
Received: from sig-9-65-241-175.ibm.com (unknown [9.65.241.175])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id E380E52057;
        Mon, 23 Nov 2020 19:49:10 +0000 (GMT)
Message-ID: <7990c489ed6fb3ae36978820400b7cf60c55c126.camel@linux.ibm.com>
Subject: Re: [PATCH v6 0/8] IMA: support for measuring kernel integrity
 critical data
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Tushar Sugandhi <tusharsu@linux.microsoft.com>,
        stephen.smalley.work@gmail.com, casey@schaufler-ca.com,
        agk@redhat.com, snitzer@redhat.com, gmazyland@gmail.com,
        paul@paul-moore.com, tyhicks@linux.microsoft.com,
        sashal@kernel.org, jmorris@namei.org, nramas@linux.microsoft.com,
        linux-integrity@vger.kernel.org, selinux@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, dm-devel@redhat.com
Date:   Mon, 23 Nov 2020 14:49:10 -0500
In-Reply-To: <20201123171800.GA6407@duo.ucw.cz>
References: <20201119232611.30114-1-tusharsu@linux.microsoft.com>
         <20201120124657.GA31468@duo.ucw.cz>
         <aadf6e35-39bc-74d4-6ca3-d708860738a5@linux.microsoft.com>
         <20201122210031.GA26756@amd>
         <d82ad1cac36e948c904300548c64244c145589ee.camel@linux.ibm.com>
         <20201123171800.GA6407@duo.ucw.cz>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-12.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-23_17:2020-11-23,2020-11-23 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 clxscore=1015
 mlxscore=0 impostorscore=0 malwarescore=0 mlxlogscore=999 suspectscore=3
 bulkscore=0 spamscore=0 phishscore=0 lowpriorityscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011230124
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, 2020-11-23 at 18:18 +0100, Pavel Machek wrote:
> > > Basically every other data structure in kernel is "critical" by your
> > > definition, and you can't really measure them all; some of them change
> > > rather often. Going piecemeal does not really help here.
> > 
> > Agreed, measuring data structures that change is not really applicable.
> > However, measuring data structures that once initialized don't change,
> > does make sense (similar concept to __ro_after_init).  The attestation
> > server doesn't need to know anything about the measurement, other than
> > more than a single measurement is indicative of a problem.
> 
> So, why not simply measure everything that is ro_after_init?

I guess we could, but the original discussion, a long time ago prior to
LSM stacking, was limited to measuring the LSM hooks.

Mimi

