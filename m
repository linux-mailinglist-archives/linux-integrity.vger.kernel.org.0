Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76F8F20A739
	for <lists+linux-integrity@lfdr.de>; Thu, 25 Jun 2020 23:08:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390936AbgFYVIu (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 25 Jun 2020 17:08:50 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:53250 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2390477AbgFYVIu (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 25 Jun 2020 17:08:50 -0400
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05PL4HCF110362;
        Thu, 25 Jun 2020 17:08:46 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 31ux03x6my-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 25 Jun 2020 17:08:46 -0400
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 05PL6XGV120740;
        Thu, 25 Jun 2020 17:08:45 -0400
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0a-001b2d01.pphosted.com with ESMTP id 31ux03x6m8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 25 Jun 2020 17:08:45 -0400
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 05PL5SNv003858;
        Thu, 25 Jun 2020 21:08:43 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma03fra.de.ibm.com with ESMTP id 31uusgh2x0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 25 Jun 2020 21:08:43 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 05PL8e8U61538610
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 25 Jun 2020 21:08:40 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B16EB11C04A;
        Thu, 25 Jun 2020 21:08:40 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 55EC511C058;
        Thu, 25 Jun 2020 21:08:39 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.142.225])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 25 Jun 2020 21:08:39 +0000 (GMT)
Message-ID: <1593119318.27152.396.camel@linux.ibm.com>
Subject: Re: [PATCH 03/12] ima: Free the entire rule when deleting a list of
 rules
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Tyler Hicks <tyhicks@linux.microsoft.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
Cc:     James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        Prakhar Srivastava <prsriva02@gmail.com>,
        linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org
Date:   Thu, 25 Jun 2020 17:08:38 -0400
In-Reply-To: <1593119238.27152.395.camel@linux.ibm.com>
References: <20200623003236.830149-1-tyhicks@linux.microsoft.com>
         <20200623003236.830149-4-tyhicks@linux.microsoft.com>
         <1593119238.27152.395.camel@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-25_16:2020-06-25,2020-06-25 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 clxscore=1015
 lowpriorityscore=0 phishscore=0 impostorscore=0 cotscore=-2147483648
 bulkscore=0 adultscore=0 mlxlogscore=999 mlxscore=0 priorityscore=1501
 spamscore=0 suspectscore=2 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2006250124
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, 2020-06-25 at 17:07 -0400, Mimi Zohar wrote:
> On Mon, 2020-06-22 at 19:32 -0500, Tyler Hicks wrote:
> > Use ima_free_rule() to fix memory leaks of allocated ima_rule_entry
> > members, such as .fsname and .keyrings, when deleting a list of rules.
> > 
> > This fixes a memory leak seen when loading by a valid rule that contains
> > an additional piece of allocated memory, such as an fsname, followed by
> > an invalid rule that triggers a policy load failure:
> > 
> >  # echo -e "dont_measure fsname=securityfs\nbad syntax" > \
> >     /sys/kernel/security/ima/policy
> >  -bash: echo: write error: Invalid argument
> >  # echo scan > /sys/kernel/debug/kmemleak
> >  # cat /sys/kernel/debug/kmemleak
> >  unreferenced object 0xffff9bab67ca12c0 (size 16):
> >    comm "tee", pid 684, jiffies 4295212803 (age 252.344s)
> >    hex dump (first 16 bytes):
> >      73 65 63 75 72 69 74 79 66 73 00 6b 6b 6b 6b a5  securityfs.kkkk.
> >    backtrace:
> >      [<00000000adc80b1b>] kstrdup+0x2e/0x60
> >      [<00000000d504cb0d>] ima_parse_add_rule+0x7d4/0x1020
> >      [<00000000444825ac>] ima_write_policy+0xab/0x1d0
> >      [<000000002b7f0d6c>] vfs_write+0xde/0x1d0
> >      [<0000000096feedcf>] ksys_write+0x68/0xe0
> >      [<0000000052b544a2>] do_syscall_64+0x56/0xa0
> >      [<000000007ead1ba7>] entry_SYSCALL_64_after_hwframe+0x44/0xa9
> > 
> > Fixes: f1b08bbcbdaf ("ima: define a new policy condition based on the filesystem name")
> > Fixes: 2b60c0ecedf8 ("IMA: Read keyrings= option from the IMA policy")
> > Signed-off-by: Tyler Hicks <tyhicks@linux.microsoft.com>
> 
> Your decision, but you might consider squashing this patch with 3/12.
>  Everything all together in one patch.

Oops, that was the comment for 4/12.

Mimi
