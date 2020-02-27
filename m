Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C8C20170FA4
	for <lists+linux-integrity@lfdr.de>; Thu, 27 Feb 2020 05:28:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728397AbgB0E2W (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 26 Feb 2020 23:28:22 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:55060 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728221AbgB0E2V (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 26 Feb 2020 23:28:21 -0500
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01R4O1rm081497
        for <linux-integrity@vger.kernel.org>; Wed, 26 Feb 2020 23:28:20 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2ydxrdd3n0-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Wed, 26 Feb 2020 23:28:20 -0500
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Thu, 27 Feb 2020 04:28:19 -0000
Received: from b06avi18878370.portsmouth.uk.ibm.com (9.149.26.194)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 27 Feb 2020 04:28:18 -0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 01R4SHQ738207852
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 Feb 2020 04:28:17 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 28DC111C04A;
        Thu, 27 Feb 2020 04:28:17 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A624211C052;
        Thu, 27 Feb 2020 04:28:16 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.172.231])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 27 Feb 2020 04:28:16 +0000 (GMT)
Subject: Re: [PATCH] ima-evm-utils: Fix compatibility with LibreSSL
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Mikhail Novosyolov <m.novosyolov@rosalinux.ru>,
        linux-integrity@vger.kernel.org
Date:   Wed, 26 Feb 2020 23:28:14 -0500
In-Reply-To: <fac0bebb-22ce-77f9-bac9-7ca5f76d1ca1@rosalinux.ru>
References: <63ba8482-0085-f2d3-dbb9-70bb81990f07@rosalinux.ru>
         <1582638298.10443.196.camel@linux.ibm.com>
         <fac0bebb-22ce-77f9-bac9-7ca5f76d1ca1@rosalinux.ru>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 20022704-0020-0000-0000-000003ADF7A3
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20022704-0021-0000-0000-000022061512
Message-Id: <1582777694.10443.286.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-26_09:2020-02-26,2020-02-26 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 phishscore=0
 malwarescore=0 clxscore=1015 mlxlogscore=999 impostorscore=0 adultscore=0
 spamscore=0 mlxscore=0 lowpriorityscore=0 suspectscore=1
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002270031
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, 2020-02-26 at 12:51 +0300, Mikhail Novosyolov wrote:
> Hello Mimi, thanks for feedback.
> 25.02.2020 16:44, Mimi Zohar пишет:
> > On Sun, 2020-02-16 at 14:10 +0300, Mikhail Novosyolov wrote:
> >> LibreSSL in most cases can be used as a drop-in replacement of OpenSSL.
> >> Commit 07d799cb6c37 "ima-evm-utils: Preload OpenSSL engine via '--engine' option"
> >> added OpenSSL-specific functions: "engines" were removed from LibreSSL long ago.
> >> Instead of requiring to attach GOST support via an external library ("engine"),
> >> LibreSSL has build-in implementation of GOST.
> >
> > OpenSSL had a builtin support for GOST, which was dropped.  From the
> > OpenSSL news "Changes between 1.0.2h and 1.1.0":
> >
> >     The GOST engine was out of date and therefore it has been removed. An up
> >     to date GOST engine is now being maintained in an external repository.
> >     See:     https://wiki.openssl.org/index.php/Binaries    .  Libssl still retains
> >     support for GOST ciphersuites (these are only activated if a GOST engine
> >     is present).
> >
> > Please update the patch description to reflect the reason for OpenSSL
> > dropping GOST builtin support, while LibreSSL continues to build it
> > in.

> The reasons why OpenSSL decided to do it are out of my scope, I can
> just write that OpenSSL had GOST, then dropped it, then gost-engine
> appeared as an OpenSSL plugin and that LibreSSL has GOST built in
> and dropped engines API after forking from OpenSSL. Will it be OK?

The question is whether LibreSSL is using the back level version of
GOST that OpenSSL dropped or has it been updated?  The patch
description should be updated accordingly.

 
> >> diff --git a/src/evmctl.c b/src/evmctl.c
> >> index 3d2a10b..f6507c1 100644
> >> --- a/src/evmctl.c
> >> +++ b/src/evmctl.c
> >> @@ -62,7 +62,10 @@
> >>  #include <openssl/hmac.h>
> >>  #include <openssl/err.h>
> >>  #include <openssl/rsa.h>
> >> +/* LibreSSL removed engines */
> >> +#ifndef LIBRESSL_VERSION_NUMBER
> >>  #include <openssl/engine.h>
> >> +#endif
> >
> > According to the LibreSSL wiki, both OpenSSL and LibreSSL may be
> > installed on the same system in separate directories.  Instead of
> > using LIBRESSL_VERSION_NUMBER, consider defining an autotools option.
> 
> LibreSSL can be used either as a drop in replacement of OpenSSL or
> can be installed to a separate prefix.
> 
> What do you suggest to do with an autotools option? To define a
> prefix where libssl/libcrypto is, e.g. /usr or /opt/libressl? It may
> be useful. But, in my experience of building curl and other programs
> with LibreSSL from a custom prefix, any heaurestics in configure.ac
> cause much more troubles than profit, I had to hack curl's
> configure.ac to stop it from picking OpenSSL.
> 
> Right now the only line which detect libcrypto is
> "PKG_CHECK_MODULES(LIBCRYPTO, [libcrypto >= 0.9.8 ])". If we make an
> autotools option, we will have to somehow handle situation when
> headers and/or pkgconfig files are not in the prefix, like curl does
> (https://github.com/curl/curl/blob/master/configure.ac#L1642). Let's
> avoid such a bicycle. I had to hack it to build curl with libressl,
> and many people on the Internet complain that it works incorrectly
> in case of cross-compilation. The same problems will occure in ima-
> evm-utils.
> 
> Right now I build ima-evm-utils like this:
> export LIBCRYPTO_CFLAGS="$(pkg-config --cflags-only-I --libs-only-L
> libressl-libcrypto)"
> ...where libressl-libcrypto is a not upstream name of the *.pc file,
> I renamed it from libcrypto.pc to libressl-libcrypto.pc. It works
> perfectly. There is no need in inventing a bicycle in configure.ac,
> I am pretty sure.

Somehow this information needs to be conveyed to others.  Perhaps it
could be hidden behind an "--enable-libressl" option.  Minimally
please include this in the patch description.  

Mimi

