Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 584FA221520
	for <lists+linux-integrity@lfdr.de>; Wed, 15 Jul 2020 21:29:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726634AbgGOT3M (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 15 Jul 2020 15:29:12 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:65278 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726479AbgGOT3J (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 15 Jul 2020 15:29:09 -0400
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06FJ3WQJ110720;
        Wed, 15 Jul 2020 15:29:04 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 327u1jx6bb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Jul 2020 15:29:04 -0400
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 06FJ3PsK110421;
        Wed, 15 Jul 2020 15:29:03 -0400
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 327u1jx6ah-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Jul 2020 15:29:03 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 06FJPmIW032598;
        Wed, 15 Jul 2020 19:29:01 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma04ams.nl.ibm.com with ESMTP id 329nmyh0xb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Jul 2020 19:29:01 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 06FJSxvF63242466
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 15 Jul 2020 19:28:59 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 83ABB11C04A;
        Wed, 15 Jul 2020 19:28:59 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EFE7F11C04C;
        Wed, 15 Jul 2020 19:28:58 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.155.184])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 15 Jul 2020 19:28:58 +0000 (GMT)
Message-ID: <1594841338.12900.330.camel@linux.ibm.com>
Subject: Re: [PATCH 6/6] ima-evm-utils: define a basic hash_info.h file
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Bruno Meneguele <bmeneg@redhat.com>
Cc:     linux-integrity@vger.kernel.org, Petr Vorel <pvorel@suse.cz>,
        Vitaly Chikunov <vt@altlinux.org>
Date:   Wed, 15 Jul 2020 15:28:58 -0400
In-Reply-To: <20200715175829.GG3720@glitch>
References: <1594088791-27370-1-git-send-email-zohar@linux.ibm.com>
         <1594088791-27370-7-git-send-email-zohar@linux.ibm.com>
         <20200715175829.GG3720@glitch>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-15_12:2020-07-15,2020-07-15 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 malwarescore=0
 spamscore=0 priorityscore=1501 clxscore=1015 mlxlogscore=999
 suspectscore=0 phishscore=0 bulkscore=0 impostorscore=0 mlxscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007150147
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, 2020-07-15 at 14:58 -0300, Bruno Meneguele wrote:
> Hi Mimi,
> 
> On Mon, Jul 06, 2020 at 10:26:31PM -0400, Mimi Zohar wrote:
> > Some older system kernel header packages don't necessarily include
> > hash_info.h.
> > 
> > Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
> > ---
> >  src/Makefile.am   |  2 +-
> >  src/hash_info.gen | 43 +++++++++++++++++++++++++++++++++++++++++++
> >  2 files changed, 44 insertions(+), 1 deletion(-)
> > 
> > diff --git a/src/Makefile.am b/src/Makefile.am
> > index 36652427a8ec..9bbff5034ef4 100644
> > --- a/src/Makefile.am
> > +++ b/src/Makefile.am
> > @@ -34,5 +34,5 @@ endif
> >  
> >  AM_CPPFLAGS = -I$(top_srcdir) -include config.h
> >  
> > -CLEANFILES = hash_info.h
> > +CLEANFILES = hash_info.h tmp_hash_info.h
> >  DISTCLEANFILES = @DISTCLEANFILES@
> > diff --git a/src/hash_info.gen b/src/hash_info.gen
> > index 54532ca5b847..5f7a97fb3117 100755
> > --- a/src/hash_info.gen
> > +++ b/src/hash_info.gen
> > @@ -18,11 +18,54 @@ KERNEL_HEADERS=$1
> >  HASH_INFO_H=uapi/linux/hash_info.h
> >  HASH_INFO=$KERNEL_HEADERS/include/$HASH_INFO_H
> >  
> > +TMPHASHINFO="./tmp_hash_info.h"
> > +gen_hashinfo() {
> > +cat << __EOF__ >$TMPHASHINFO
> > +/* SPDX-License-Identifier: GPL-2.0+ WITH Linux-syscall-note */
> > +/*
> > + * Hash Info: Hash algorithms information
> > + *
> > + * Copyright (c) 2013 Dmitry Kasatkin <d.kasatkin@samsung.com>
> > + *
> > + * This program is free software; you can redistribute it and/or modify it
> > + * under the terms of the GNU General Public License as published by the Free
> > + * Software Foundation; either version 2 of the License, or (at your option)
> > + * any later version.
> > + *
> > + */
> > +
> > +enum hash_algo {
> > +	HASH_ALGO_MD4,
> > +	HASH_ALGO_MD5,
> > +	HASH_ALGO_SHA1,
> > +	HASH_ALGO_RIPE_MD_160,
> > +	HASH_ALGO_SHA256,
> > +	HASH_ALGO_SHA384,
> > +	HASH_ALGO_SHA512,
> > +	HASH_ALGO_SHA224,
> > +	HASH_ALGO_RIPE_MD_128,
> > +	HASH_ALGO_RIPE_MD_256,
> > +	HASH_ALGO_RIPE_MD_320,
> > +	HASH_ALGO_WP_256,
> > +	HASH_ALGO_WP_384,
> > +	HASH_ALGO_WP_512,
> > +	HASH_ALGO_TGR_128,
> > +	HASH_ALGO_TGR_160,
> > +	HASH_ALGO_TGR_192,
> > +	HASH_ALGO_SM3_256,
> > +	HASH_ALGO__LAST
> > +};
> > +__EOF__
> 
> Just a minor point on HASH_ALGO_SM3_256:
> 
> The old kernels that didn't export hash_info.h uapi didn't support
> HASH_ALGO_SM3_256 as well. Wouldn't it be better to also not include it
> in the tmp_hash_info considering it'll be used only by those running
> older kernels without SM3 support?
> 
> Keeping it won't cause any issues though. So I'm fine with it either
> way.

I was debating which version to use, but couldn't decide.

For distros that probably is true, but I'm not sure about embedded.
 Commit ceecb28d3b52 ("ima-evm-utils: add SM3 to pkey_hash_algo
algorithm list") updated pkey_hash_algo[].

As it doesn't hurt, let's just keep it.

Mimi

