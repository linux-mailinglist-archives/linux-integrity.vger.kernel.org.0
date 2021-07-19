Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3311F3CD51B
	for <lists+linux-integrity@lfdr.de>; Mon, 19 Jul 2021 14:51:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231417AbhGSMKl (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 19 Jul 2021 08:10:41 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:8888 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231282AbhGSMKk (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 19 Jul 2021 08:10:40 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16JCYQ9n037487;
        Mon, 19 Jul 2021 08:51:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=tfE8wmSDPQ9K9riQZVWaO/TgxQUQS8wGGK2q5yCAWBY=;
 b=D7lTv/TAtdvv6KJZ/Qfa7ohgPox/yz0T5hXjnpIyL8o3nnIzBU8cZi7efKbkY8QNxxZp
 FdbuKBGrvRv3KDG920vyMqjPv1M8C9SsgKburSTi7kPVwxn4Edp0FPTOg/2gTT74uoGB
 mq/bFNrLFuBLGAkpn3d5JhyI/Jnunw+tPQi0MGTDR3huBKcK2U/Xo8SQcGXaK9AqmOde
 IV91WtCC9NvPMBJKvjY5GuLVuqY1uv9mVU6xN7DHscsIl93a5OdSMqmDmU+2+GeHGibT
 Ckh+6ylbyo4e4m+41bMo2WaTTBVOyvencUUzy2EEQqTM8dztrBV+q6y7admqh/2xkkt8 1g== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 39w97v92hm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 19 Jul 2021 08:51:16 -0400
Received: from m0098394.ppops.net (m0098394.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 16JCZCwb041057;
        Mon, 19 Jul 2021 08:51:15 -0400
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 39w97v92gv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 19 Jul 2021 08:51:15 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 16JCilgF012748;
        Mon, 19 Jul 2021 12:51:13 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma04ams.nl.ibm.com with ESMTP id 39upu88qa8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 19 Jul 2021 12:51:13 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 16JCmqGr19726698
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 19 Jul 2021 12:48:52 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D9BD952051;
        Mon, 19 Jul 2021 12:51:10 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.28.163])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 4BAE95204F;
        Mon, 19 Jul 2021 12:51:09 +0000 (GMT)
Message-ID: <1aa1a53101d9eeb6c358bb65677a8b733c19e663.camel@linux.ibm.com>
Subject: Re: [PATCH ima-evm-utils v5] ima-evm-utils: Support SM2/3 algorithm
 for sign and verify
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Petr Vorel <pvorel@suse.cz>,
        Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
Cc:     Vitaly Chikunov <vt@altlinux.org>,
        Stefan Berger <stefanb@linux.ibm.com>,
        linux-integrity@vger.kernel.org,
        Jia Zhang <zhang.jia@linux.alibaba.com>,
        "YiLin . Li" <YiLin.Li@linux.alibaba.com>
Date:   Mon, 19 Jul 2021 08:51:08 -0400
In-Reply-To: <YPQqhTPLTafjLCXP@pevik>
References: <20210716092237.17153-1-tianjia.zhang@linux.alibaba.com>
         <f7c05b2618125cb0887ee0302c1197a8c8f49864.camel@linux.ibm.com>
         <7921ca60-8818-b641-3e28-6ffd957f8a1b@linux.alibaba.com>
         <YPQqhTPLTafjLCXP@pevik>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-16.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: -BEDXqgBxzLc2B1assKUfpAky0kKal1K
X-Proofpoint-ORIG-GUID: wqHy0sdILRDJocCD7B6SdtHxTcbEJats
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-19_05:2021-07-19,2021-07-19 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 phishscore=0 impostorscore=0 clxscore=1015 mlxscore=0
 suspectscore=0 spamscore=0 mlxlogscore=999 bulkscore=0 priorityscore=1501
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2107190072
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi - 

On Sun, 2021-07-18 at 15:20 +0200, Petr Vorel wrote:
> > On 7/17/21 12:39 AM, Mimi Zohar wrote:
> > > On Fri, 2021-07-16 at 17:22 +0800, Tianjia Zhang wrote:
> > > > diff --git a/.github/workflows/ci.yml b/.github/workflows/ci.yml
> > > > index 088c041..17407ff 100644
> > > > --- a/.github/workflows/ci.yml
> > > > +++ b/.github/workflows/ci.yml
> > > > @@ -17,6 +17,7 @@ jobs:
> > > >                 ARCH: i386
> > > >                 TSS: tpm2-tss
> > > >                 VARIANT: i386
> > > > +              OPENSSL3: true
> > > >             # cross compilation builds
> > > >             - container: "debian:stable"
> > > > @@ -51,6 +52,7 @@ jobs:
> > > >               env:
> > > >                 CC: clang
> > > >                 TSS: ibmtss
> > > > +              OPENSSL3: true
> 
> > > I haven't had a chance to look at the entire patch, but defining
> > > OPENSSL3 kind of stood out.  Just as "CC" and "TSS" are generic, I'd
> > > prefer something more generic here.   In the past there was a request
> > > to support Libressl, which never materialized.
> 
> 
> > I agree that it is appropriate to use a generic variable name. I am thinking
> > of 'CRYPTOGRAPHY' or 'CRYPPTO_LIBRARY'. Are there any better suggestions?
> How about COMPILE_OPENSSL? Because that's the current purpose.

Hm, wondering if it makes sense to generalize this further, including
Vitaly's suggestion?

In this case, the generic name would be "SSL"  (e.g. "SSL=openssl"). 
Prefixing a generic name with "COMPILE_[TSS|CC|SSL]=<tag|commit>" would
indicate compiling the application from source.

thanks,

Mimi

