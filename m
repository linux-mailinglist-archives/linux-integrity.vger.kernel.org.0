Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2CAF31567B
	for <lists+linux-integrity@lfdr.de>; Tue,  9 Feb 2021 20:07:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233481AbhBITFi (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 9 Feb 2021 14:05:38 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:10256 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233046AbhBISzB (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 9 Feb 2021 13:55:01 -0500
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 119Is5NB159419;
        Tue, 9 Feb 2021 13:54:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=KsS616KzO5Bal73MlGgUUqj7I48GoUA7L3FoYTnLe3c=;
 b=riAh0b+njCigF5vrxymDSQ+qpDL4sOeRCOhai0zcuZ4sc5VshVO0TZi6u81bIPDRLQRz
 WvAE0Rh495jliu3Uxy01g5m5YxbWFNliiB34SmeXB+8B5VUj/k/HYvCH46dF2aAKhro1
 BIh8o3LucKz6z9rxG1CPqko/oef3CjD88a0N2YlALe52o9cZNBzhYEf2FaQ+5IPP7vTF
 h9mjbKRWxk1Tk9Ikp15lerXMj4zqRLZ5ppBussdvJoYVClCIeYORFzi+jLvo4pgDVSkD
 BKZ4RLFTwRF698LvSMN++SQ/5MqwFzNFjgYT/2DEPnx1AdxxVWgZXgiaZYZnt+3s+krx 8w== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 36kycu99a9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 09 Feb 2021 13:54:14 -0500
Received: from m0098417.ppops.net (m0098417.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 119IsDIT160458;
        Tue, 9 Feb 2021 13:54:13 -0500
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0a-001b2d01.pphosted.com with ESMTP id 36kycu994f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 09 Feb 2021 13:54:13 -0500
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 119IkxF4012350;
        Tue, 9 Feb 2021 18:54:01 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma02fra.de.ibm.com with ESMTP id 36hjr89x4s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 09 Feb 2021 18:54:00 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 119IrwJH27394458
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 9 Feb 2021 18:53:58 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A1BCF5204E;
        Tue,  9 Feb 2021 18:53:58 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.79.210])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 75F275204F;
        Tue,  9 Feb 2021 18:53:56 +0000 (GMT)
Message-ID: <38ba5889d517ee010a6bf370f8892059dd7d3bfe.camel@linux.ibm.com>
Subject: Re: [PATCH 0/3] support for duplicate measurement of integrity
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
Date:   Tue, 09 Feb 2021 13:53:55 -0500
In-Reply-To: <c5ecccbe-9e23-f297-8a79-2a9dd62a40fb@linux.microsoft.com>
References: <20210130004519.25106-1-tusharsu@linux.microsoft.com>
         <27f73411fc1d6ce6dd16a29344d729d9aa760250.camel@linux.ibm.com>
         <27a4592c3b75861d2b9c8fb1511f593aa987222c.camel@linux.ibm.com>
         <c5ecccbe-9e23-f297-8a79-2a9dd62a40fb@linux.microsoft.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-14.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.737
 definitions=2021-02-09_05:2021-02-09,2021-02-09 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 lowpriorityscore=0 mlxlogscore=999 spamscore=0 impostorscore=0 bulkscore=0
 malwarescore=0 phishscore=0 clxscore=1015 adultscore=0 priorityscore=1501
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102090086
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, 2021-02-09 at 10:23 -0800, Tushar Sugandhi wrote:
> > On Mon, 2021-02-08 at 15:22 -0500, Mimi Zohar wrote:
> >> On Fri, 2021-01-29 at 16:45 -0800, Tushar Sugandhi wrote:
> >>> IMA does not measure duplicate buffer data since TPM extend is a very
> >>> expensive operation.  However, in some cases for integrity critical
> >>> data, the measurement of duplicate data is necessary to accurately
> >>> determine the current state of the system.  Eg, SELinux state changing
> >>> from 'audit', to 'enforcing', and back to 'audit' again.  In this
> >>> example, currently, IMA will not measure the last state change to
> >>> 'audit'.  This limits the ability of attestation services to accurately
> >>> determine the current state of the integrity critical data on the
> >>> system.
> >>>
> >>> This series addresses this gap by providing the ability to measure
> >>> duplicate entries for integrity critical data, driven by policy.
> >>
> >> The same reason for re-measuring buffer data is equally applicable to
> >> files.  In both cases, the file or the buffer isn't re-measured if it
> >> already exists in the htable.   Please don't limit this patch set to
> >> just buffer data.
> > 
> Agreed.  I wasn't sure if you wanted the support for files, or other 
> buffer measurement scenarios, except critical data.  So I started the 
> implementation with supporting just critical data.  Happy to extend it 
> to files and other buffer measurement scenarios as you suggested.
> 
> > Instead of making the change on a per measurement rule basis, disabling
> > "htable" would be the simplest way of forcing re-measurements.  All
> > that would be needed is a new Kconfig (e.g. CONFIG_IMA_DISABLE_HTABLE)
> > and the associated test in ima_add_template_entry().
> > 
> Agreed.  Earlier I wasn't sure if you wanted allow_dup support for all 
> the scenarios.  Now that it is clear,  I will implement it as you 
> suggested.  Thank you so much for the pointers.  Appreciate it.

There are two different solutions - per measurement rule, disabling
htable - being discussed.   Disabling htable requires miminumal
changes.  Which version are you thinking of implementing?

thanks,

Mimi

