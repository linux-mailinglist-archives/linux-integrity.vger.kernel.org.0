Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 89EA7199AC8
	for <lists+linux-integrity@lfdr.de>; Tue, 31 Mar 2020 18:04:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730286AbgCaQEf (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 31 Mar 2020 12:04:35 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:12466 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731410AbgCaQEe (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 31 Mar 2020 12:04:34 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02VG3cxd068999
        for <linux-integrity@vger.kernel.org>; Tue, 31 Mar 2020 12:04:33 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0b-001b2d01.pphosted.com with ESMTP id 303uj3eu0u-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Tue, 31 Mar 2020 12:04:33 -0400
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Tue, 31 Mar 2020 17:04:16 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 31 Mar 2020 17:04:13 +0100
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 02VG4RwJ52953192
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 31 Mar 2020 16:04:27 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 72C7D52054;
        Tue, 31 Mar 2020 16:04:27 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.186.34])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id B1AE652063;
        Tue, 31 Mar 2020 16:04:26 +0000 (GMT)
Subject: Re: [PATCH v8 1/2] ima-evm-utils: Add some tests for evmctl
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Vitaly Chikunov <vt@altlinux.org>
Cc:     Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-integrity@vger.kernel.org
Date:   Tue, 31 Mar 2020 12:04:26 -0400
In-Reply-To: <20200331151444.o3ginofakm6byiu5@altlinux.org>
References: <20200327042515.22315-1-vt@altlinux.org>
         <20200327042515.22315-2-vt@altlinux.org>
         <1585664724.5188.572.camel@linux.ibm.com>
         <20200331151444.o3ginofakm6byiu5@altlinux.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 20033116-0020-0000-0000-000003BF06BD
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20033116-0021-0000-0000-00002217A82F
Message-Id: <1585670666.5188.589.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-03-31_05:2020-03-31,2020-03-31 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 suspectscore=0
 impostorscore=0 adultscore=0 mlxlogscore=999 lowpriorityscore=0
 malwarescore=0 bulkscore=0 priorityscore=1501 phishscore=0 clxscore=1015
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2003310141
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, 2020-03-31 at 18:14 +0300, Vitaly Chikunov wrote:
> Mimi,
> 
> On Tue, Mar 31, 2020 at 10:25:24AM -0400, Mimi Zohar wrote:
> > > +# For hard errors
> > > +red_always() {
> > > +  echo $@ $RED
> > 
> > A few functions - "red_always", "red_if_failure", "color_restore" -
> >  use "$@", but none of the function callers pass any parameters.  Is
> > there a reason for the "$@" or just something left over from
> > debugging?
> 
> It was to pass `-n` I think, but it is never needed in the end.
> 
> > > +  if [ "$chash" ] && [ "$chash" != "$hash" ]; then
> > > +    red_always
> > 
> > Only when "ima_hash.test" is invoked directly, the output is colored
> > red.  Really confusing.
> 
> Non-TTY output is never colored to not clutter log files.
> But logic is to color the errors in red.
> 
> So it thought as 'always red', _when_ there is colored output (TTY).
> 
> And it's "always" in contract to "red if failure" - which make text
> red only when the test is expected to pass (thus, this is real error
> condition), when the test is expected to fail there is no point to
> color it red, because it's not real error (to not confuse user).
> 
> Because it is unconditional (in that sense) is it named "red always".
> 
> I can rename it to something like `color_red'. And rename
> `red_if_failure' to `color_red_on_failure'.

Sure, and add a short comment - "Non-TTY output is never colored".

> 
> > Nice!  The code is very concisely written.
> > 
> > Reviewing this patch would be a lot easier, if it was broken up into
> > smaller pieces.  For example, and this is only an example, the initial
> > patch could define the base ima_hash.test, a subsequent patch could
> > add coloring for the base ima_hash.test, another patch could introduce
> > "make check" and add its coloring.  There's all sorts of ways to break
> > up this patch to simplify review.
> 
> This would make following commits to change code which is already
> committed in previous commits. 

Nothing is committed yet.  I pushed it out in order for others to
review and comment, not only your patches, but mine as well.

> This would make editing code extra hard.
> Especially, when tests was reworked a lot.
> 
> Also, I don't think splitting coloring into separate patch improves
> review. Instead, we can just remember the rule that (real) errors are 
> going to be printed in red.
> 
> For example, if we prefix every error message with word "ERROR:" - why
> it would be easier to review if we split adding this prefix to every
> message in a separate commit?
> 
> Red color, similarly to uppercase "ERROR", just improves visibility of
> errors. (Which is useful, because there is really a lot of tests).

Trust me, I understand breaking up patches to simplify review is a lot
of work.  It's one of the hardest things to teach newbies and explain
to them why it is necessary and why a clean history is worthwhile, but
you know how to do it.  These were just suggestions, just as
separating the two tests was just a suggestion.

BTW, in case it got lost along the way, I really do appreciate your
help.

Thanks!

Mimi

