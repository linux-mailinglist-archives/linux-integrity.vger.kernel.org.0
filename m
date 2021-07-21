Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A3C13D0739
	for <lists+linux-integrity@lfdr.de>; Wed, 21 Jul 2021 05:12:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231544AbhGUCbs (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 20 Jul 2021 22:31:48 -0400
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130]:53060 "EHLO
        out30-130.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231806AbhGUC2I (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 20 Jul 2021 22:28:08 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04400;MF=tianjia.zhang@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0UgTWl8M_1626836920;
Received: from B-455UMD6M-2027.local(mailfrom:tianjia.zhang@linux.alibaba.com fp:SMTPD_---0UgTWl8M_1626836920)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 21 Jul 2021 11:08:41 +0800
Subject: Re: [PATCH ima-evm-utils v6] ima-evm-utils: Support SM2/3 algorithm
 for sign and verify
To:     Petr Vorel <pvorel@suse.cz>
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
        Vitaly Chikunov <vt@altlinux.org>,
        Stefan Berger <stefanb@linux.ibm.com>,
        linux-integrity@vger.kernel.org,
        Jia Zhang <zhang.jia@linux.alibaba.com>,
        "YiLin . Li" <YiLin.Li@linux.alibaba.com>
References: <20210720075153.17158-1-tianjia.zhang@linux.alibaba.com>
 <YPbSnDejnYcqY2Ib@pevik>
From:   Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
Message-ID: <f0f48952-7c71-c147-f804-81cf67a1b301@linux.alibaba.com>
Date:   Wed, 21 Jul 2021 11:08:39 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <YPbSnDejnYcqY2Ib@pevik>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Petr,

On 7/20/21 9:41 PM, Petr Vorel wrote:
> Hi Tianjia,
> 
> few notes below, feel free to completely ignore it.
> 
> ...
>> diff --git a/.github/workflows/ci.yml b/.github/workflows/ci.yml
>> index 088c041..b890481 100644
>> --- a/.github/workflows/ci.yml
>> +++ b/.github/workflows/ci.yml
>> @@ -17,6 +17,7 @@ jobs:
>>                 ARCH: i386
>>                 TSS: tpm2-tss
>>                 VARIANT: i386
>> +              COMPILE_SSL: openssl-3
> I'd either put here value openssl-3.0.0-beta1 and pass it to
> ./tests/install-openssl3.sh or put value as true. Because why define version in
> yaml and also in the script? (sooner or later these two will not match).
> 

This is a good way, I will follow you.

>>             # cross compilation builds
>>             - container: "debian:stable"
>> @@ -51,6 +52,7 @@ jobs:
>>               env:
>>                 CC: clang
>>                 TSS: ibmtss
>> +              COMPILE_SSL: openssl-3
> 
>>             - container: "opensuse/leap"
>>               env:
>> @@ -61,6 +63,7 @@ jobs:
>>               env:
>>                 CC: gcc
>>                 TSS: ibmtss
>> +              COMPILE_SSL: openssl-3
> 
>>             - container: "ubuntu:xenial"
>>               env:
>> @@ -115,6 +118,7 @@ jobs:
>>           INSTALL="${INSTALL%%/*}"
>>           if [ "$VARIANT" ]; then ARCH="$ARCH" ./ci/$INSTALL.$VARIANT.sh; fi
>>           ARCH="$ARCH" CC="$CC" TSS="$TSS" ./ci/$INSTALL.sh
>> +        if [ "$COMPILE_SSL" ]; then ./tests/install-openssl3.sh; fi
> 
>>       - name: Build swtpm
>>         run: |
>> @@ -128,5 +132,8 @@ jobs:
>>       - name: Compiler version
>>         run: $CC --version
> 
>> +    - name: Default OpenSSL version
>> +      run: openssl version
> you should run this only on native build:
> 
>           run: [ "$VARIANT" != "cross-compile" ] && openssl version
> 
> Also aren't ve interested at the version which is actually being used for
> compilation?
> 
> Also we don't print this info for Travis CI.
> 

It's just to facilitate troubleshooting when CI fails. This is not 
necessary, and it seems useless now, I will delete.

>> +
>>       - name: Compile
>>         run: CC="$CC" VARIANT="$VARIANT" ./build.sh
>> diff --git a/.travis.yml b/.travis.yml
>> index 7a76273..a73f20e 100644
>> --- a/.travis.yml
>> +++ b/.travis.yml
>> @@ -9,7 +9,7 @@ matrix:
>>       include:
>>           # 32 bit build
>>           - os: linux
>> -          env: DISTRO=debian:stable VARIANT=i386 ARCH=i386 TSS=tpm2-tss
>> +          env: DISTRO=debian:stable VARIANT=i386 ARCH=i386 TSS=tpm2-tss COMPILE_SSL: openssl-3
>>             compiler: gcc
> 
>>           # cross compilation builds
>> @@ -32,7 +32,7 @@ matrix:
> 
>>           # glibc (gcc/clang)
>>           - os: linux
>> -          env: DISTRO=opensuse/tumbleweed TSS=ibmtss CONTAINER=podman CONTAINER_ARGS="--runtime=/usr/bin/runc --network=host"
>> +          env: DISTRO=opensuse/tumbleweed TSS=ibmtss CONTAINER=podman CONTAINER_ARGS="--runtime=/usr/bin/runc --network=host" COMPILE_SSL: openssl-3
>>             compiler: clang
> 
>>           - os: linux
>> @@ -40,7 +40,7 @@ matrix:
>>             compiler: gcc
> 
>>           - os: linux
>> -          env: DISTRO=ubuntu:groovy TSS=ibmtss
>> +          env: DISTRO=ubuntu:groovy TSS=ibmtss COMPILE_SSL: openssl-3
>>             compiler: gcc
> 
>>           - os: linux
>> @@ -97,4 +97,4 @@ before_install:
>>   script:
>>       - INSTALL="${DISTRO%%:*}"
>>       - INSTALL="${INSTALL%%/*}"
>> -    - $CONTAINER run $CONTAINER_ARGS -t ima-evm-utils /bin/sh -c "if [ \"$VARIANT\" ]; then ARCH=\"$ARCH\" ./ci/$INSTALL.$VARIANT.sh; fi && ARCH=\"$ARCH\" CC=\"$CC\" TSS=\"$TSS\" ./ci/$INSTALL.sh && if [ ! \"$VARIANT\" ]; then which tpm_server || which swtpm || if which tssstartup; then ./tests/install-swtpm.sh; fi; fi && CC=\"$CC\" VARIANT=\"$VARIANT\" ./build.sh"
>> +    - $CONTAINER run $CONTAINER_ARGS -t ima-evm-utils /bin/sh -c "if [ \"$VARIANT\" ]; then ARCH=\"$ARCH\" ./ci/$INSTALL.$VARIANT.sh; fi && ARCH=\"$ARCH\" CC=\"$CC\" TSS=\"$TSS\" ./ci/$INSTALL.sh && if [ "$COMPILE_SSL" ]; then ./tests/install-openssl3.sh; fi && if [ ! \"$VARIANT\" ]; then which tpm_server || which swtpm || if which tssstartup; then ./tests/install-swtpm.sh; fi; fi && CC=\"$CC\" VARIANT=\"$VARIANT\" ./build.sh"
>> diff --git a/src/libimaevm.c b/src/libimaevm.c
>> index 19f1041..8e96157 100644
> ...
>> --- a/tests/gen-keys.sh
>> +++ b/tests/gen-keys.sh
>> @@ -131,6 +131,31 @@ for m in \
>>       fi
>>   done
> 
>> +# SM2, If openssl 3.0 is installed, gen SM2 keys using
>> +if [ -x /opt/openssl3/bin/openssl ]; then
>> +  (PATH=/opt/openssl3/bin:$PATH LD_LIBRARY_PATH=/opt/openssl3/lib
>> +  for curve in sm2; do
> I'd just export PATH and LD_LIBRARY_PATH than wrap them in ().

Direct export PATH and LD_LIBRARY_PATH will affect the following 
commands. If add other commands after this code block in the future, it 
will cause potential problems. Of course, this file will not affect it 
now. If you export PATH and LD_LIBRARY_PATH directly in sign_verify.test 
script, there will cause error.

>> +    if [ "$1" = clean ] || [ "$1" = force ]; then
>> +      rm -f test-$curve.cer test-$curve.key test-$curve.pub
>> +    fi
>> +    if [ "$1" = clean ]; then
>> +      continue
>> +    fi
>> +    if [ ! -e test-$curve.key ]; then
>> +      log openssl req -verbose -new -nodes -utf8 -days 10000 -batch -x509 \
>> +        -sm3 -sigopt "distid:1234567812345678" \
>> +        -config test-ca.conf \
>> +        -copy_extensions copyall \
>> +        -newkey $curve \
>> +        -out test-$curve.cer -outform DER \
>> +        -keyout test-$curve.key
>> +      if [ -s test-$curve.key ]; then
>> +        log openssl pkey -in test-$curve.key -out test-$curve.pub -pubout
>> +      fi
>> +    fi
>> +  done)
>> +fi
> ...
> 
>> --- /dev/null
>> +++ b/tests/install-openssl3.sh
>> @@ -0,0 +1,17 @@
>> +#!/bin/sh

will change to #!/bin/bash

>> +
>> +set -ex
>> +
>> +# 3.0.0-beta1 is the latest version in July 2021
> I'd define a variable and use it.
> version="openssl-3.0.0-beta1"
> 

Good way.

> 
> Kind regards,
> Petr
> 
>> +wget --no-check-certificate https://github.com/openssl/openssl/archive/refs/tags/openssl-3.0.0-beta1.tar.gz
>> +tar --no-same-owner -xzf openssl-3.0.0-beta1.tar.gz
>> +cd openssl-openssl-3.0.0-beta1
>> +
>> +./Configure --prefix=/opt/openssl3 --openssldir=/opt/openssl3/ssl
>> +make -j$(nproc)
>> +# only install apps and library
>> +sudo make install_sw
>> +
>> +cd ..
>> +rm -rf openssl-3.0.0-beta1.tar.gz
>> +rm -rf openssl-openssl-3.0.0-beta1
> ...
> 

Best regards,
Tianjia
