Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 46ADA4C0E4
	for <lists+linux-integrity@lfdr.de>; Wed, 19 Jun 2019 20:37:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726109AbfFSShP (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 19 Jun 2019 14:37:15 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:56668 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726449AbfFSShN (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 19 Jun 2019 14:37:13 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5JIWmZ9024163
        for <linux-integrity@vger.kernel.org>; Wed, 19 Jun 2019 14:37:12 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2t7rn4mx7u-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Wed, 19 Jun 2019 14:37:12 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Wed, 19 Jun 2019 19:37:09 +0100
Received: from b06avi18626390.portsmouth.uk.ibm.com (9.149.26.192)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 19 Jun 2019 19:37:08 +0100
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x5JIawso35062266
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 Jun 2019 18:36:58 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 349D5A4040;
        Wed, 19 Jun 2019 18:37:07 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 92462A404D;
        Wed, 19 Jun 2019 18:37:06 +0000 (GMT)
Received: from dhcp-9-31-103-88.watson.ibm.com (unknown [9.31.103.88])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 19 Jun 2019 18:37:06 +0000 (GMT)
Subject: Re: [PATCH 2/3] IMA:Define a new template field buf
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     prakhar srivastava <prsriva02@gmail.com>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Date:   Wed, 19 Jun 2019 14:37:06 -0400
In-Reply-To: <CAEFn8qK9Tg99PA_=Ukm=CwSE6ajjUL2FxLs0ZiVdGLvG_baK_A@mail.gmail.com>
References: <20190617183507.14160-1-prsriva02@gmail.com>
         <20190617183507.14160-3-prsriva02@gmail.com>
         <1560952466.3975.40.camel@linux.ibm.com>
         <CAEFn8qK9Tg99PA_=Ukm=CwSE6ajjUL2FxLs0ZiVdGLvG_baK_A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19061918-4275-0000-0000-00000343D828
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19061918-4276-0000-0000-000038540473
Message-Id: <1560969426.3975.64.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-19_12:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906190151
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, 2019-06-19 at 11:08 -0700, prakhar srivastava wrote:
> <snip>
> > >       if (iint->measured_pcrs & (0x1 << pcr))
> > > diff --git a/security/integrity/ima/ima_init.c b/security/integrity/ima/ima_init.c
> > > index 993d0f1915ff..c8591406c0e2 100644
> > > --- a/security/integrity/ima/ima_init.c
> > > +++ b/security/integrity/ima/ima_init.c
> > > @@ -50,7 +50,7 @@ static int __init ima_add_boot_aggregate(void)
> > >       struct ima_template_entry *entry;
> > >       struct integrity_iint_cache tmp_iint, *iint = &tmp_iint;
> > >       struct ima_event_data event_data = {iint, NULL, boot_aggregate_name,
> > > -                                         NULL, 0, NULL};
> > > +                                         NULL, 0, NULL, NULL, 0};
> > >       int result = -ENOMEM;
> > >       int violation = 0;
> > >       struct {
> > >
> >
> > These changes shouldn't be necessary.  Please rebase these patches on
> > top of the latest next-queued-testing branch (git remote update).  "IMA: support for per
> > policy rule template formats" is still changing.
> >
> > Minor nit.  When re-posting the patches please update the patch titles
> > so that there is a space between the subsystem name and the patch
> > title (eg. "ima: define ...").
> >
> I believe the above event_data changes are needed, to store/read the
> buffer length and buffer itself. The only exception will be if needed will be to
> remove ima-buf as a template instead used a template_fmt in the policy
> with KEXEC_CMDLINE from the "IMA: support for per
>  policy rule template formats" is still changing.".
> In my view even ima-buf is needed as it simplifies the usage.
> 
> Please let me know if I misunderstood your comment.

The tip of next-queued-testing branch is commit 687d57f90461 ("IMA:
support for per policy rule template formats").  The current code is:

        struct ima_event_data event_data = { .iint = iint,
                                             .filename = boot_aggregate_name };

Mimi

