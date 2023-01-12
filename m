Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 065EB6679D6
	for <lists+linux-integrity@lfdr.de>; Thu, 12 Jan 2023 16:51:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240459AbjALPvR (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 12 Jan 2023 10:51:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240469AbjALPux (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 12 Jan 2023 10:50:53 -0500
Received: from frasgout13.his.huawei.com (frasgout13.his.huawei.com [14.137.139.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A00C6B1B3
        for <linux-integrity@vger.kernel.org>; Thu, 12 Jan 2023 07:39:52 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.18.147.227])
        by frasgout13.his.huawei.com (SkyGuard) with ESMTP id 4Nt7nn6QyTz9xFgL
        for <linux-integrity@vger.kernel.org>; Thu, 12 Jan 2023 23:31:57 +0800 (CST)
Received: from roberto-ThinkStation-P620 (unknown [10.204.63.22])
        by APP1 (Coremail) with SMTP id LxC2BwCHCwerKcBjJdqOAA--.53983S2;
        Thu, 12 Jan 2023 16:39:30 +0100 (CET)
Message-ID: <24f997512ddf7c366ca232ca8487d9b3dc795bd1.camel@huaweicloud.com>
Subject: Re: [PATCH ima-evm-utils v2 6/9] Add tests for EVM portable
 signatures
From:   Roberto Sassu <roberto.sassu@huaweicloud.com>
To:     Stefan Berger <stefanb@linux.ibm.com>, zohar@linux.ibm.com,
        dmitry.kasatkin@gmail.com
Cc:     linux-integrity@vger.kernel.org, vt@altlinux.org, pvorel@suse.cz,
        Roberto Sassu <roberto.sassu@huawei.com>
Date:   Thu, 12 Jan 2023 16:38:55 +0100
In-Reply-To: <bc08eaf9-1282-f6b3-3c7a-1242aacfe9e1@linux.ibm.com>
References: <20230112122426.3759938-1-roberto.sassu@huaweicloud.com>
         <20230112122426.3759938-7-roberto.sassu@huaweicloud.com>
         <bc08eaf9-1282-f6b3-3c7a-1242aacfe9e1@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: LxC2BwCHCwerKcBjJdqOAA--.53983S2
X-Coremail-Antispam: 1UD129KBjvJXoW3Wr47ZF4xAr4DKw13JrWUJwb_yoWxAw1Upa
        y8X3WYkF93tF9Fyry7KF42yr1ftr4FyF15Cwn8Xw45A3s8Xr1Iyr4IkFW5WFZ3WrWrWr10
        v3W0q34xWw4DJaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUgCb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxV
        AFwI0_Gr1j6F4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
        6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
        Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY
        6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17
        CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF
        0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Wr1j6rW3Jr
        1lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsG
        vfC2KfnxnUUI43ZEXa7IU1zuWJUUUUU==
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgAPBF1jj4OJcQABsC
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, 2023-01-12 at 10:22 -0500, Stefan Berger wrote:
> 
> On 1/12/23 07:24, Roberto Sassu wrote:
> > From: Roberto Sassu <roberto.sassu@huawei.com>
> > 
> > Verify that operations on files with EVM portable signatures succeed and
> > that the new kernel patch set does not break the existing kernel integrity
> > expectations. Build and install mount-idmapped for ci/fedora.sh, to
> > additionally test idmapped mounts.
> > 
> > To run the tests, pass the path of the kernel private key with the
> > TST_KEY_PATH environment variable. If not provided, the script searches the
> > key in /lib/modules/$(uname -r)/source/certs/signing_key.pem and in the
> > current directory. Root privileges are required to mount the image,
> > configure IMA/EVM and set xattrs.
> > 
> > Set UML_MODE to 1, to relaunch the script in a new environment after
> > booting an UML kernel. The UML kernel must be named 'linux' and placed in
> > the ima-evm-utils directory.
> > 
> > Alternatively, set the TST_EVM_CHANGE_MODE variable to 1, to change the
> > current EVM mode, if a test needs a different one. Otherwise, execute only
> > the tests compatible with the current EVM mode.
> > 
> > Also set the EVM_ALLOW_METADATA_WRITES flag in the EVM mode, before
> > launching the script, to run the check_evm_revalidate() test. Execute:
> > 
> > echo 4 > /sys/kernel/security/evm
> > 
> > The last two environment variables above affect which tests will run the
> > next time the script is executed. Without setting UML_MODE to 1, changes to
> > the current EVM mode will be irreversibly done in the host. Next time,
> > unless the host is rebooted, only tests compatible with the last EVM mode
> > set will run. The others will be skipped.
> > 
> > With the UML kernel, this problem does not arise as, every time the UML
> > kernel is executed, it will create a clean environment with no flags set in
> > the EVM mode.
> > 
> > Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> > ---
> >   build.sh                        |    5 +
> >   ci/fedora.sh                    |    7 +-
> >   tests/Makefile.am               |    2 +-
> >   tests/install-mount-idmapped.sh |    7 +
> >   tests/portable_signatures.test  | 1173 +++++++++++++++++++++++++++++++
> >   5 files changed, 1192 insertions(+), 2 deletions(-)
> >   create mode 100755 tests/install-mount-idmapped.sh
> >   create mode 100755 tests/portable_signatures.test
> > 
> > diff --git a/build.sh b/build.sh
> > index 4e2f1bb7353b..0920599b2780 100755
> > --- a/build.sh
> > +++ b/build.sh
> > @@ -114,6 +114,11 @@ if [ $ret -eq 0 ]; then
> >   		grep "skipped" tests/fsverity.log  && \
> >   		   grep "skipped" tests/fsverity.log | wc -l
> >   	fi
> > +	if [ -f tests/portable_signatures.log ]; then
> > +		[ -n "$CI" ] && cat tests/portable_signatures.log || tail tests/portable_signatures.log
> > +		grep "skipped" tests/portable_signatures.log  && \
> > +		   grep "skipped" tests/portable_signatures.log | wc -l
> > +	fi
> >   	exit 0
> >   fi
> >   
> > diff --git a/ci/fedora.sh b/ci/fedora.sh
> > index 198034a34e3c..3f75d2e1ddbd 100755
> > --- a/ci/fedora.sh
> > +++ b/ci/fedora.sh
> > @@ -47,7 +47,11 @@ yum -y install \
> >   	which \
> >   	zstd \
> >   	haveged \
> > -	systemd
> > +	systemd \
> > +	keyutils \
> > +	e2fsprogs \
> > +	acl \
> > +	libcap
> >   
> >   yum -y install docbook5-style-xsl || true
> >   yum -y install swtpm || true
> > @@ -59,3 +63,4 @@ fi
> >   yum -y install softhsm || true
> >   
> >   ./tests/install-fsverity.sh
> > +./tests/install-mount-idmapped.sh
> > diff --git a/tests/Makefile.am b/tests/Makefile.am
> > index 305082483f36..421fac577b55 100644
> > --- a/tests/Makefile.am
> > +++ b/tests/Makefile.am
> > @@ -2,7 +2,7 @@ check_SCRIPTS =
> >   TESTS = $(check_SCRIPTS)
> >   
> >   check_SCRIPTS += ima_hash.test sign_verify.test boot_aggregate.test \
> > -		 fsverity.test
> > +		 fsverity.test portable_signatures.test
> >   
> >   clean-local:
> >   	-rm -f *.txt *.out *.sig *.sig2
> > diff --git a/tests/install-mount-idmapped.sh b/tests/install-mount-idmapped.sh
> > new file mode 100755
> > index 000000000000..e9768e2fbf7a
> > --- /dev/null
> > +++ b/tests/install-mount-idmapped.sh
> > @@ -0,0 +1,7 @@
> > +#!/bin/sh
> > +
> > +git clone https://github.com/brauner/mount-idmapped.git
> > +cd mount-idmapped
> > +gcc -o mount-idmapped mount-idmapped.c
> > +cd ..
> > +rm -rf mount-idmapped
> 
> Where did you just install the executable to? It looks to me like it was removed.

Right, my mistake. Will fix it.

> > diff --git a/tests/portable_signatures.test b/tests/portable_signatures.test
> > new file mode 100755
> > index 000000000000..a6d79c929281
> > --- /dev/null
> > +++ b/tests/portable_signatures.test
> > @@ -0,0 +1,1173 @@
> > +#!/bin/bash
> > +# SPDX-License-Identifier: GPL-2.0
> > +#
> > +# Copyright (C) 2022-2023 Roberto Sassu <roberto.sassu@huawei.com>
> > +#
> > +# Check if operations on files with EVM portable signatures succeed.
> > +
> > +trap cleanup SIGINT SIGTERM SIGSEGV EXIT
> > +
> > +# Base VERBOSE on the environment variable, if set.
> > +VERBOSE="${VERBOSE:-0}"
> > +TST_EVM_CHANGE_MODE="${TST_EVM_CHANGE_MODE:-0}"
> > +UML_MODE="${UML_MODE:-0}"
> > +
> > +# From security/integrity/evm/evm.h in kernel source directory.
> > +let "EVM_INIT_HMAC=0x0001"
> > +let "EVM_INIT_X509=0x0002"
> > +let "EVM_ALLOW_METADATA_WRITES=0x0004"
> > +let "EVM_SETUP_COMPLETE=0x80000000"
> > +
> > +cd "$(dirname "$0")"
> > +export PATH=$PWD/../src:$PWD/../mount-idmapped:$PATH
> > +export LD_LIBRARY_PATH=$LD_LIBRARY_PATH
> > +. ./functions.sh
> > +_require evmctl
> > +
> > +_cleanup() {> +	if [ "$loop_mounted" = "1" ]; then
> 
> These global variables make it quite a bit tricky even though it's 'just a test case'. They
> could clash with variables elsewhere. Maybe prefix them with 'g_' if you don't want to
> pass them as parameters into the function, which I would think is yet more preferable.

Ok.

Thanks

Roberto

> > +		popd > /dev/null
> > +
> > +		if [ -n "$mountpoint_idmapped" ]; then
> > +			umount $mountpoint_idmapped
> > +		fi
> > +
> > +		umount $mountpoint
> > +	fi
> > +
> > +	if [ -n "$dev" ]; then
> > +		losetup -d $dev
> > +	fi
> > +
> > +	if [ -n "$image" ]; then
> > +		rm -f $image
> > +	fi
> > +
> > +	if [ -n "$key_path_der" ]; then
> > +		rm -f $key_path_der
> > +	fi
> > +
> > +	if [ -n "$mountpoint" ]; then
> > +		rm -Rf $mountpoint
> > +	fi
> > +
> > +	if [ -n "$mountpoint_idmapped" ]; then
> > +		rm -Rf $mountpoint_idmapped
> > +	fi
> > +}
> > +
> > +cleanup() {
> > +	_cleanup_user_mode _cleanup
> > +	_report_exit_and_cleanup
> > +}
> > +
> > +get_xattr() {
> > +	format="hex"
> 
> Don't want to use 'local format=....' to avoid clashes with possibly global variables of same name?
> 
> I would also urge to consider using shellcheck on shell script files. It helps a bit.
> 
> For now I leave it at these comment.
> 
>     Stefan

