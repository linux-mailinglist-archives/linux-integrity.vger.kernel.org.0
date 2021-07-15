Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07A5B3C9F09
	for <lists+linux-integrity@lfdr.de>; Thu, 15 Jul 2021 15:02:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232367AbhGONEy (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 15 Jul 2021 09:04:54 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:52052 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229679AbhGONEy (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 15 Jul 2021 09:04:54 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16FCokGd062790;
        Thu, 15 Jul 2021 09:01:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=zFbgJGx+CqVzz+WIXONEAmjUciIduLLlbaoOjh3OLp0=;
 b=l8oG2GNE5IpxcnXbTJ8z6PJ7pdDNTZAUkN1vhgQ/WGqy7o4MM9KsYPbPm03dpn9IHD8E
 iI1w3DF6FnwHozQaS/tmWD9tVtyCYvppyEThV+pEd4Ek6Vt0AlTynIQ3p+4aEPIP7AYl
 245+44W1EymTbUi9Z+TNXxmGtVw/qhCOwN802MQHPE7MB9JGWvX7sd+ezPk78U4W07b+
 HP12BNyGH28mu7oVm53JjMdZWs/o4yT1Q3XLYTi70+YCVgY5vPscn1leL1dMi2wSiFeg
 0LMeMxuHPsF3vwMXmHyv/jYA5wVCLmpg+2eupFYvl1e0xvqfCtqVKzixmY6pyhMm+UWr og== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 39tgsg0r4j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 15 Jul 2021 09:01:56 -0400
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 16FCpdGq066670;
        Thu, 15 Jul 2021 09:01:55 -0400
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 39tgsg0r32-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 15 Jul 2021 09:01:55 -0400
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 16FD1kPk017341;
        Thu, 15 Jul 2021 13:01:53 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma03ams.nl.ibm.com with ESMTP id 39q368a91d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 15 Jul 2021 13:01:53 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 16FCxfiI36962628
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 15 Jul 2021 12:59:41 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D4ECEA4067;
        Thu, 15 Jul 2021 13:01:50 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 54BABA4054;
        Thu, 15 Jul 2021 13:01:49 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.117.215])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 15 Jul 2021 13:01:49 +0000 (GMT)
Message-ID: <5996b8f9deb4aba43f025844a7415f2069c1e7e2.camel@linux.ibm.com>
Subject: Re: [PATCH ima-evm-utils v4] ima-evm-utils: Support SM2 algorithm
 for sign and verify
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Tianjia Zhang <tianjia.zhang@linux.alibaba.com>,
        Petr Vorel <pvorel@suse.cz>
Cc:     Stefan Berger <stefanb@linux.ibm.com>,
        Vitaly Chikunov <vt@altlinux.org>,
        linux-integrity@vger.kernel.org,
        Jia Zhang <zhang.jia@linux.alibaba.com>,
        "YiLin . Li" <YiLin.Li@linux.alibaba.com>
Date:   Thu, 15 Jul 2021 09:01:48 -0400
In-Reply-To: <2af3724d-1fdd-1e98-1119-7ef86c2ee912@linux.alibaba.com>
References: <20210714130152.25751-1-tianjia.zhang@linux.alibaba.com>
         <422b37b533ed6e24d783f323f7d4e22736f0e4bd.camel@linux.ibm.com>
         <YO/YFAEWN5VzYIsQ@pevik>
         <2af3724d-1fdd-1e98-1119-7ef86c2ee912@linux.alibaba.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-16.el8) 
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: kudA-IHqEfH2S4QroLWJbjE3w8WqkhGC
X-Proofpoint-ORIG-GUID: rekO8ClCihwcJr3cND3TXbxmXKSHahXL
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-15_07:2021-07-14,2021-07-15 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 mlxlogscore=999 lowpriorityscore=0 malwarescore=0 adultscore=0 mlxscore=0
 spamscore=0 clxscore=1015 priorityscore=1501 bulkscore=0 impostorscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2107150090
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, 2021-07-15 at 20:24 +0800, Tianjia Zhang wrote:
> 
> On 7/15/21 2:39 PM, Petr Vorel wrote:
> > Hi Mimi, Tianjia,
> > 
> >> Hi Tianjia,
> > 
> >> On Wed, 2021-07-14 at 21:01 +0800, Tianjia Zhang wrote:
> > 
> >>> index 5b07711..a0001b0 100644
> >>> --- a/.travis.yml
> >>> +++ b/.travis.yml
> >>> @@ -93,4 +93,4 @@ before_install:
> >>>   script:
> >>>       - INSTALL="${DISTRO%%:*}"
> >>>       - INSTALL="${INSTALL%%/*}"
> >>> -    - $CONTAINER run $CONTAINER_ARGS -t ima-evm-utils /bin/sh -c "if
> >>> [ \"$VARIANT\" ]; then ARCH=\"$ARCH\" ./ci/$INSTALL.$VARIANT.sh; fi
> >>> && ARCH=\"$ARCH\" CC=\"$CC\" TSS=\"$TSS\" ./ci/$INSTALL.sh && if [ !
> >>> \"$VARIANT\" ]; then which tpm_server || which swtpm ||
> >>> ./tests/install-swtpm.sh; fi && CC=\"$CC\" VARIANT=\"$VARIANT\"
> >>> ./build.sh"
> >>> +    - $CONTAINER run $CONTAINER_ARGS -t ima-evm-utils /bin/sh -c "if
> >>> [ \"$VARIANT\" ]; then ARCH=\"$ARCH\" ./ci/$INSTALL.$VARIANT.sh; fi
> >>> && ARCH=\"$ARCH\" CC=\"$CC\" TSS=\"$TSS\" ./ci/$INSTALL.sh && if [ !
> >>> \"$VARIANT\" ]; then which tpm_server || which swtpm ||
> >>> ./tests/install-swtpm.sh; fi && ./tests/install-openssl3.sh &&
> >>> CC=\"$CC\" VARIANT=\"$VARIANT\" ./build.sh"
> > 
> >> With "install-openssl3.sh", installing openssl 3.0 is being done for
> >> every distro matrix rule.  This needs to be limited to a specific
> >> instance.  Petr, please correct if I'm wrong, I assume a new variable
> >> needs to be defined, similar to "TSS".
> > +1
> > 
> >> A similar change would need to be made in ci.yml.
> > +1
> > 
> >>> new file mode 100755
> >>> index 0000000..21adb6f
> >>> --- /dev/null
> >>> +++ b/tests/install-openssl3.sh
> >>> @@ -0,0 +1,15 @@
> >>> +#!/bin/sh
> >>> +
> >>> +set -ex
> >>> +
> >>> +# The latest version in July 2021
> >>> +wget --no-check-certificate https://github.com/openssl/openssl/archive/refs/tags/openssl-3.0.0-beta1.tar.gz
> >>> +tar --no-same-owner -xvzf openssl-3.0.0-beta1.tar.gz
> > 
> >> Petr said,  "Although it appears there is no distro which would have
> >> openssl 3.0 [1],
> >> Debian actually have 3.0.0~~beta1-1 in experimental [2]. openSUSE has slightly
> >> older version openssl-3.0.0-alpha16 [3]. I suppose we update soon to beta1 as
> >> well.
> >> Using distro packages would be probably faster to run in CI than install from git."
> >> I guess, whether the openssl 3.0 source code is from the distro or from
> >> openssl, it needs to be compiled from source.
> > 
> >> Perhaps limiting compiling openssl 3.0 to those distros with the source
> >> package is simpler than defining a new travis.yml variable, as
> >> suggested above.  Petr?
> > It'll be slower, but why not. It might be better not cover only Debian.
> > But IMHO there should be at least some distros tested with regular openssl 1.1.x
> > (or which particular version it have) which means some runs will be added to the
> > matrix. But there should be a balance between test coverity and time required
> > for tests to be run (we don't want to end up like u-boot [1] :)).
> 
> > [1] https://github.com/u-boot/u-boot/runs/3073277277
> > 
> 
> evmctl itself relies on openssl version 1.1.1 or lower. I guess, openssl 
> 3.0 needs to be compiled and install to a non-standard path, such as 
> /opt/openssl, otherwise it will affect the subsequent compilation of 
> evmctl in build.sh. 

Compiling evmctl with the new version of openssl will eventually need
to be done. but that isn't required for your patch.

> Of course, compile openssl 3.0 from source code. 
> must to limit the number of instances to avoid excessively increasing 
> the time-consuming in CI. Is that right?

It's more than just "time consuming".   There needs to be a balance
between testing with the distro openssl version and testing with the
new openssl version, without going overboard with the number of tests.

thanks,

Mimi

