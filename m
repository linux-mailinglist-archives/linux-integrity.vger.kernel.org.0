Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3ADC32C0C0C
	for <lists+linux-integrity@lfdr.de>; Mon, 23 Nov 2020 14:57:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730868AbgKWNlz (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 23 Nov 2020 08:41:55 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:12500 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730860AbgKWNly (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 23 Nov 2020 08:41:54 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0ANDUufe054615;
        Mon, 23 Nov 2020 08:41:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=chruBFvNGuRKqGj1QlVcNgCM3MgDyhdklfyEEoguCso=;
 b=KDWosr6ETemK3ES0X7OImUBDAMYVrUJXyDtAw+McGitSFqiW79RoD1OO/p5N/eZI7dI7
 KLTSRnbkUvG9ew8bgURQHTYzOSOeiFxLWuFjFOLsRHwvYGk27QDts5UP9gd5MNgn0Qxj
 Q8zqo6P9X3vZ5jLqmP1MzcSar6dTPd9rt6yB2FHYIzP7Rm7736YzZ85ZRd607sI0STbP
 957diyHohUedqpRg2/Y2Q7Z1GNnXkcU+Z6ZVNMCqSTHkrXJyYUJbvESETsarEUMOZuzw
 HweWMWAoMjNwxgiNrZ4N191kJ+cdQXCO8N1ynSir1tS/fPJlWlMUoKSq4WTLcjVScut/ Kg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 34yq4759xa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 23 Nov 2020 08:41:44 -0500
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 0ANDUugv054630;
        Mon, 23 Nov 2020 08:41:44 -0500
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0b-001b2d01.pphosted.com with ESMTP id 34yq4759wf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 23 Nov 2020 08:41:44 -0500
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0ANDaNsS019241;
        Mon, 23 Nov 2020 13:41:42 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma02fra.de.ibm.com with ESMTP id 350cvrr2ws-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 23 Nov 2020 13:41:42 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0ANDfd4761342026
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 23 Nov 2020 13:41:39 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9722011C04A;
        Mon, 23 Nov 2020 13:41:39 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8FB5F11C052;
        Mon, 23 Nov 2020 13:41:36 +0000 (GMT)
Received: from sig-9-65-241-175.ibm.com (unknown [9.65.241.175])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 23 Nov 2020 13:41:36 +0000 (GMT)
Message-ID: <d82ad1cac36e948c904300548c64244c145589ee.camel@linux.ibm.com>
Subject: Re: [PATCH v6 0/8] IMA: support for measuring kernel integrity
 critical data
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Pavel Machek <pavel@ucw.cz>,
        Tushar Sugandhi <tusharsu@linux.microsoft.com>
Cc:     stephen.smalley.work@gmail.com, casey@schaufler-ca.com,
        agk@redhat.com, snitzer@redhat.com, gmazyland@gmail.com,
        paul@paul-moore.com, tyhicks@linux.microsoft.com,
        sashal@kernel.org, jmorris@namei.org, nramas@linux.microsoft.com,
        linux-integrity@vger.kernel.org, selinux@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, dm-devel@redhat.com
Date:   Mon, 23 Nov 2020 08:41:35 -0500
In-Reply-To: <20201122210031.GA26756@amd>
References: <20201119232611.30114-1-tusharsu@linux.microsoft.com>
         <20201120124657.GA31468@duo.ucw.cz>
         <aadf6e35-39bc-74d4-6ca3-d708860738a5@linux.microsoft.com>
         <20201122210031.GA26756@amd>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-12.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-23_09:2020-11-23,2020-11-23 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 bulkscore=0
 phishscore=0 mlxlogscore=999 impostorscore=0 adultscore=0
 priorityscore=1501 malwarescore=0 suspectscore=3 spamscore=0
 lowpriorityscore=0 clxscore=1011 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2009150000 definitions=main-2011230088
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Pavel,

On Sun, 2020-11-22 at 22:00 +0100, Pavel Machek wrote:
> Hi!
> 
> > >How is it supposed to be useful?
> > >
> > >I'm pretty sure there are critical data that are not measured by
> > >proposed module... and that are written under normal circumstances.
> > >
> > The goal of this series is to introduce the IMA hook
> > measure_critical_data() and the necessary policies to use it; and
> > illustrate that use with one example (SELinux). It is not scalable to
> > identify and update all the critical data sources to use the proposed
> > module at once.
> > 
> > A piecemeal approach to add more critical data measurement in subsequent
> > patches would be easy to implement and review.
> 
> Basically every other data structure in kernel is "critical" by your
> definition, and you can't really measure them all; some of them change
> rather often. Going piecemeal does not really help here.

Agreed, measuring data structures that change is not really applicable.
However, measuring data structures that once initialized don't change,
does make sense (similar concept to __ro_after_init).  The attestation
server doesn't need to know anything about the measurement, other than
more than a single measurement is indicative of a problem.

Mimi

> Example of critical data structure: page table entries for process I
> own.



