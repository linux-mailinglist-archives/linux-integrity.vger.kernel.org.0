Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCD5F20D151
	for <lists+linux-integrity@lfdr.de>; Mon, 29 Jun 2020 20:41:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728436AbgF2Skk (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 29 Jun 2020 14:40:40 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:60072 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728391AbgF2Skf (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 29 Jun 2020 14:40:35 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05TGXkNW147767;
        Mon, 29 Jun 2020 12:57:45 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 31ydjwpppk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 29 Jun 2020 12:57:45 -0400
Received: from m0098396.ppops.net (m0098396.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 05TGYWfM152459;
        Mon, 29 Jun 2020 12:57:44 -0400
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0a-001b2d01.pphosted.com with ESMTP id 31ydjwppnf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 29 Jun 2020 12:57:44 -0400
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 05TGexbZ020434;
        Mon, 29 Jun 2020 16:57:42 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma06fra.de.ibm.com with ESMTP id 31wwcgs7qb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 29 Jun 2020 16:57:42 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 05TGveue39518286
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 29 Jun 2020 16:57:40 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 31AA811C04C;
        Mon, 29 Jun 2020 16:57:40 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 57B4411C04A;
        Mon, 29 Jun 2020 16:57:39 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.137.220])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 29 Jun 2020 16:57:39 +0000 (GMT)
Message-ID: <1593449858.5085.24.camel@linux.ibm.com>
Subject: Re: [PATCH v3 2/2] IMA: Add audit log for failure conditions
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Paul Moore <paul@paul-moore.com>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Cc:     sgrubb@redhat.com, rgb@redhat.com, linux-integrity@vger.kernel.org,
        linux-audit@redhat.com, linux-kernel@vger.kernel.org
Date:   Mon, 29 Jun 2020 12:57:38 -0400
In-Reply-To: <CAHC9VhRQru30WtA-CMeqq=0GBtZ-Ut20ecHwpYfbEu5qCFqgDg@mail.gmail.com>
References: <20200618211012.2823-1-nramas@linux.microsoft.com>
         <20200618211012.2823-2-nramas@linux.microsoft.com>
         <1592942295.5389.9.camel@linux.ibm.com>
         <39d66bdc-55be-984a-42a0-34d0a011e0fb@linux.microsoft.com>
         <CAHC9VhRQru30WtA-CMeqq=0GBtZ-Ut20ecHwpYfbEu5qCFqgDg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-06-29_18:2020-06-29,2020-06-29 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 adultscore=0 impostorscore=0 phishscore=0 mlxlogscore=999 malwarescore=0
 priorityscore=1501 spamscore=0 mlxscore=0 cotscore=-2147483648 bulkscore=0
 suspectscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2006290106
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, 2020-06-25 at 15:14 -0400, Paul Moore wrote:
> On Wed, Jun 24, 2020 at 1:25 PM Lakshmi Ramasubramanian
> <nramas@linux.microsoft.com> wrote:
> >
> > On 6/23/20 12:58 PM, Mimi Zohar wrote:
> >
> > Hi Steve\Paul,
> >
> > >> Sample audit messages:
> > >>
> > >> [    6.303048] audit: type=1804 audit(1592506281.627:2): pid=1 uid=0
> > >> auid=4294967295 ses=4294967295 subj=kernel op=measuring_key
> > >> cause=ENOMEM comm="swapper/0" name=".builtin_trusted_keys" res=0
> > >> errno=-12
> > >
> > > My only concern is that auditing -ENOMEM will put additional memory
> > > pressure on the system.  I'm not sure if this is a concern and, if so,
> > > how it should be handled.
> >
> > Do you have any concerns with respect to adding audit messages in low
> > memory conditions?
> 
> Assuming the system is not completely toast, the allocation failure
> could be a very transient issue; I wouldn't worry too much about it.

There was a major clean up of removing ENOMEM error messages through
out the kernel a while ago by Wolfram Sang.  The subject lines
included "don't print error when allocating XXX fails".  As it turns
out, they were being removed because "kmalloc will print enough
information in case of failure."  It had nothing to do with memory
pressure on the system.

Thanks, Paul.  I think we're good.

Mimi

