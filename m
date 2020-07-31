Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 767AE234D95
	for <lists+linux-integrity@lfdr.de>; Sat,  1 Aug 2020 00:33:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726804AbgGaWdL (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 31 Jul 2020 18:33:11 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:58772 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726119AbgGaWdL (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 31 Jul 2020 18:33:11 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06VMX59Y115341;
        Fri, 31 Jul 2020 18:33:05 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 32mt8j2j8w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 31 Jul 2020 18:33:05 -0400
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 06VMX46T115293;
        Fri, 31 Jul 2020 18:33:04 -0400
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 32mt8j2j5w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 31 Jul 2020 18:33:04 -0400
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 06VMUhN9010768;
        Fri, 31 Jul 2020 22:32:47 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma03ams.nl.ibm.com with ESMTP id 32gcpx7qfw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 31 Jul 2020 22:32:47 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 06VMWjP934210186
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 31 Jul 2020 22:32:45 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 25BCA11C075;
        Fri, 31 Jul 2020 22:32:45 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D330F11C073;
        Fri, 31 Jul 2020 22:32:43 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.38.42])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 31 Jul 2020 22:32:43 +0000 (GMT)
Message-ID: <8c9e64a3b461fb20cda761ef0fc0728a55448937.camel@linux.ibm.com>
Subject: Re: [ima-evm-utils: PATCH 5/5] ima-evm-utils: travis: openssl gost
 engine
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Vitaly Chikunov <vt@altlinux.org>, Petr Vorel <pvorel@suse.cz>
Cc:     linux-integrity@vger.kernel.org,
        Bruno Meneguele <bmeneg@redhat.com>
Date:   Fri, 31 Jul 2020 18:32:42 -0400
In-Reply-To: <20200731210653.p5m4efy52melqwgs@altlinux.org>
References: <20200731182408.696931-1-zohar@linux.ibm.com>
         <20200731182408.696931-6-zohar@linux.ibm.com>
         <20200731185633.kqgcz4dwfa4ruyld@altlinux.org>
         <20200731201808.GA27841@dell5510>
         <20200731202638.x5mnkz7hcpgbveu2@altlinux.org>
         <20200731204044.GC27841@dell5510>
         <20200731210653.p5m4efy52melqwgs@altlinux.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-12.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-31_09:2020-07-31,2020-07-31 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 impostorscore=0 priorityscore=1501 spamscore=0 clxscore=1015 adultscore=0
 mlxlogscore=999 phishscore=0 lowpriorityscore=0 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007310160
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Sat, 2020-08-01 at 00:06 +0300, Vitaly Chikunov wrote:
> On Fri, Jul 31, 2020 at 10:40:44PM +0200, Petr Vorel wrote:
> > And when using suggested branch openssl_1_1_0, it also fails on
> > make install
> > $ ./tests/install-gost-engine.sh
> > OpenSSL 1.1.1g  21 Apr 2020
> > Cloning into 'engine'...
> > remote: Enumerating objects: 63, done.
> > remote: Counting objects: 100% (63/63), done.
> > remote: Compressing objects: 100% (40/40), done.
> > remote: Total 2738 (delta 33), reused 32 (delta 21), pack-reused
> > 2675
> > Receiving objects: 100% (2738/2738), 2.48 MiB | 2.09 MiB/s, done.
> > Resolving deltas: 100% (1735/1735), done.
> > -- The C compiler identification is GNU 10.1.1
> > -- Detecting C compiler ABI info
> > -- Detecting C compiler ABI info - done
> > -- Check for working C compiler: /usr/bin/cc - skipped
> > -- Detecting C compile features
> > -- Detecting C compile features - done
> > -- Found OpenSSL: /usr/lib64/libcrypto.so (found suitable version
> > "1.1.1g", minimum required is "1.1")
> > -- Check if the system is big endian
> > -- Searching 16 bit integer
> > -- Looking for sys/types.h
> > -- Looking for sys/types.h - found
> > -- Looking for stdint.h
> > -- Looking for stdint.h - found
> > -- Looking for stddef.h
> > -- Looking for stddef.h - found
> > -- Check size of unsigned short
> > -- Check size of unsigned short - done
> > -- Searching 16 bit integer - Using unsigned short
> > -- Check if the system is big endian - little endian
> > -- LITTLE_ENDIAN
> > -- Configuring done
> > -- Generating done
> > -- Build files have been written to: /home/pvorel/install/src/ima-
> > evm-utils.git/engine
> > make: *** No rule to make target 'install'.  Stop.
> 
> It seems this branch does not have install target. I think,
> 
> - `engine/bin/gost.so` should be moved in platform dependent engines
> dir,
> for example for debian9 it's `/usr/lib/x86_64-linux-gnu/engines-1.1/`
> (found with strace).
> 
> - Or, just keep it as is, but `OPENSSL_ENGINES` env should be set to
> `/home/pvorel/install/src/ima-evm-utils.git/engine/bin/`.
> 
> - Or even better, Bionic (which is supported by Travis) should have
>   gost-engine already in the libengine-gost-openssl1.1 package.
> 
>   In that case `.travis.yml` should have `dist: bionic`.
>     https://docs.travis-ci.com/user/reference/bionic/

Yes, for the internal git repo I made this change.   The internal
travis support for bionic is different than the external travis.   I'll
post what I have as an RFC.
 
> 
> 
> > => It'd be good to fix this and add some test with SSL=openssl
> > variable.
> > But the branch would have to be updated time to time.
> > 
> > BTW do you plan to test other crypto libraries?

Mikhail Novosyolov posted a patch for libressl, but didn't followup
with v2.   The openssl code version/release sections need to be cleaned
up for libressl some more for libressl.

For matrix testing, it would be nice for the package names and versions
to be included in the output.

Mimi

