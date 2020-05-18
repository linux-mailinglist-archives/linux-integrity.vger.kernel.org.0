Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 886C21D84FF
	for <lists+linux-integrity@lfdr.de>; Mon, 18 May 2020 20:16:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731945AbgERR6s (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 18 May 2020 13:58:48 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:11062 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731953AbgERR6r (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 18 May 2020 13:58:47 -0400
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 04IHWN5m007797;
        Mon, 18 May 2020 13:58:46 -0400
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 312btudkax-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 18 May 2020 13:58:45 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 04IHuMJv014543;
        Mon, 18 May 2020 17:58:42 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma04ams.nl.ibm.com with ESMTP id 313xehg28h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 18 May 2020 17:58:42 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 04IHwedg65339580
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 18 May 2020 17:58:40 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3A97B5204E;
        Mon, 18 May 2020 17:58:40 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.145.145])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id B5FBF52050;
        Mon, 18 May 2020 17:58:39 +0000 (GMT)
Message-ID: <1589824719.5111.126.camel@linux.ibm.com>
Subject: Re: [GIT PULL] integrity subsystem fixes for v5.7
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-integrity <linux-integrity@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Date:   Mon, 18 May 2020 13:58:39 -0400
In-Reply-To: <CAHk-=wh_Zw7ug+iMALAKfQkdyVAUWC0UB0bfRRPMOCC7U5uTFQ@mail.gmail.com>
References: <1589816971.5111.113.camel@linux.ibm.com>
         <CAHk-=wh_Zw7ug+iMALAKfQkdyVAUWC0UB0bfRRPMOCC7U5uTFQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.676
 definitions=2020-05-18_06:2020-05-15,2020-05-18 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 bulkscore=0
 priorityscore=1501 malwarescore=0 mlxscore=0 mlxlogscore=812
 impostorscore=0 spamscore=0 clxscore=1015 cotscore=-2147483648
 lowpriorityscore=0 adultscore=0 phishscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2005180143
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, 2020-05-18 at 10:47 -0700, Linus Torvalds wrote:
> On Mon, May 18, 2020 at 8:49 AM Mimi Zohar <zohar@linux.ibm.com> wrote:
> >
> >   git://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity.git next-integrity.fixes
> 
> No such head.
> 
> It looks like the plain 'fixes' branch has the same commit ID, but
> there's no next-integrity.fixes.

Ugh, that's the name of my local branch.  The remote branch is "fixes"
as you figured out.

> 
> Btw, any chance you could start using signed tags? I've been
> encouraging people to do that even on kernel.org, and we've got fairly
> high coverage these days..

Sure, will figure out how in time for the next open window, if that is
Ok.

Mimi
