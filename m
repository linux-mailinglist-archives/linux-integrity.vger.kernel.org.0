Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 065ED239D8F
	for <lists+linux-integrity@lfdr.de>; Mon,  3 Aug 2020 04:53:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726944AbgHCCxw (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 2 Aug 2020 22:53:52 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:15258 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725820AbgHCCxv (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 2 Aug 2020 22:53:51 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0732VOxP048845;
        Sun, 2 Aug 2020 22:53:47 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 32p0x392cv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 02 Aug 2020 22:53:47 -0400
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 0732VQVJ049077;
        Sun, 2 Aug 2020 22:53:46 -0400
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0b-001b2d01.pphosted.com with ESMTP id 32p0x392ck-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 02 Aug 2020 22:53:46 -0400
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0732p6QU024810;
        Mon, 3 Aug 2020 02:53:45 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma03fra.de.ibm.com with ESMTP id 32nyyd07xt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 03 Aug 2020 02:53:45 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0732rgvw33030536
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 3 Aug 2020 02:53:43 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BBF954C046;
        Mon,  3 Aug 2020 02:53:42 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8C50B4C04A;
        Mon,  3 Aug 2020 02:53:41 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.0.172])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon,  3 Aug 2020 02:53:41 +0000 (GMT)
Message-ID: <c28c63ca748236c0db4594d2ddc2f5b63cd75528.camel@linux.ibm.com>
Subject: Re: [ima-evm-utils: PATCH 5/5] ima-evm-utils: travis: openssl gost
 engine
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Petr Vorel <pvorel@suse.cz>, Vitaly Chikunov <vt@altlinux.org>
Cc:     linux-integrity@vger.kernel.org,
        Bruno Meneguele <bmeneg@redhat.com>
Date:   Sun, 02 Aug 2020 22:53:40 -0400
In-Reply-To: <20200731204044.GC27841@dell5510>
References: <20200731182408.696931-1-zohar@linux.ibm.com>
         <20200731182408.696931-6-zohar@linux.ibm.com>
         <20200731185633.kqgcz4dwfa4ruyld@altlinux.org>
         <20200731201808.GA27841@dell5510>
         <20200731202638.x5mnkz7hcpgbveu2@altlinux.org>
         <20200731204044.GC27841@dell5510>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-12.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-03_01:2020-07-31,2020-08-03 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 spamscore=0
 lowpriorityscore=0 priorityscore=1501 bulkscore=0 malwarescore=0
 mlxlogscore=946 phishscore=0 adultscore=0 mlxscore=0 clxscore=1015
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008030012
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, 2020-07-31 at 22:40 +0200, Petr Vorel wrote:
> > Petr,
> > On Fri, Jul 31, 2020 at 10:18:08PM +0200, Petr Vorel wrote:
> > > > > +++ b/tests/install-gost-engine.sh
> > > > > @@ -0,0 +1,10 @@
> > > > > +#!/bin/sh
> > > > > +
> > > > > +openssl version
> > > > > +
> > > > > +git clone https://github.com/gost-engine/engine.git
> > > > gost-engine master branch corresponds to openssl-3.0 which is
> > > > probably
> > > > not on Travis systems yet. I think branch `openssl_1_1_0`
> > > > should be used.
> > > >   git clone --branch openssl_1_1_0 
> > > > https://github.com/gost-engine/engine.git
> > > FYI: it work on current setup.
> > > https://travis-ci.org/github/pevik/ima-evm-utils/builds/713815774
> > I think `install-gost-engine.sh` is not executed in this line:
> >   257 $ if [ "${SSL}" = "openssl" ]; then ./tests/install-gost-
> > engine.sh; openssl version; fi   0.00s
> 
> Good catch!
> $ ./tests/install-gost-engine.sh
> OpenSSL 1.1.1g  21 Apr 2020
> fatal: destination path 'engine' already exists and is not an empty
> directory.
> CMake Error at
> /usr/share/cmake/Modules/FindPackageHandleStandardArgs.cmake:165
> (message):
>   Could NOT find OpenSSL, try to set the path to OpenSSL root folder
> in the
>   system variable OPENSSL_ROOT_DIR: Found unsuitable version
> "1.1.1g", but
>   required is at least "3.0" (found /usr/lib64/libcrypto.so, )
> Call Stack (most recent call first):
>   /usr/share/cmake/Modules/FindPackageHandleStandardArgs.cmake:456
> (_FPHSA_FAILURE_MESSAGE)
>   /usr/share/cmake/Modules/FindOpenSSL.cmake:486
> (find_package_handle_standard_args)
>   CMakeLists.txt:11 (find_package)
> 
> -- Configuring incomplete, errors occurred!
> See also "/home/pvorel/install/src/ima-evm-
> utils.git/engine/CMakeFiles/CMakeOutput.log".
> make: *** No rule to make target 'install'.  Stop.
> 
> And when using suggested branch openssl_1_1_0, it also fails on make
> install
> $ ./tests/install-gost-engine.sh
> OpenSSL 1.1.1g  21 Apr 2020
> Cloning into 'engine'...
> remote: Enumerating objects: 63, done.
> remote: Counting objects: 100% (63/63), done.
> remote: Compressing objects: 100% (40/40), done.
> remote: Total 2738 (delta 33), reused 32 (delta 21), pack-reused 2675
> Receiving objects: 100% (2738/2738), 2.48 MiB | 2.09 MiB/s, done.
> Resolving deltas: 100% (1735/1735), done.
> -- The C compiler identification is GNU 10.1.1
> -- Detecting C compiler ABI info
> -- Detecting C compiler ABI info - done
> -- Check for working C compiler: /usr/bin/cc - skipped
> -- Detecting C compile features
> -- Detecting C compile features - done
> -- Found OpenSSL: /usr/lib64/libcrypto.so (found suitable version
> "1.1.1g", minimum required is "1.1")
> -- Check if the system is big endian
> -- Searching 16 bit integer
> -- Looking for sys/types.h
> -- Looking for sys/types.h - found
> -- Looking for stdint.h
> -- Looking for stdint.h - found
> -- Looking for stddef.h
> -- Looking for stddef.h - found
> -- Check size of unsigned short
> -- Check size of unsigned short - done
> -- Searching 16 bit integer - Using unsigned short
> -- Check if the system is big endian - little endian
> -- LITTLE_ENDIAN
> -- Configuring done
> -- Generating done
> -- Build files have been written to: /home/pvorel/install/src/ima-
> evm-utils.git/engine
> make: *** No rule to make target 'install'.  Stop.
> 
> => It'd be good to fix this and add some test with SSL=openssl
> variable.
> But the branch would have to be updated time to time.
> 
> BTW do you plan to test other crypto libraries?

Thanks, Vitaly, Petr, for catching this.  SSL isn't define yet.   The
test should be removed.  If/when libressl is added, it would look like:

-     - env: TSS=ibmtss
-     - env: TSS=tpm2-tss
+     - env: TSS=ibmtss SSL=openssl
+     - env: TSS=ibmtss SSL=libressl;
+     - env: TSS=tpm2-tss SSL=openssl
 
 before_install:
+   - if [ "${SSL}" = "libressl" ]; then
+        ./tests/install-libressl.sh;
+     fi

Mimi

