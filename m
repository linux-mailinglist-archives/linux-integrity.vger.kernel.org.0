Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E4D56678C3
	for <lists+linux-integrity@lfdr.de>; Thu, 12 Jan 2023 16:13:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229639AbjALPNw (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 12 Jan 2023 10:13:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230462AbjALPMx (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 12 Jan 2023 10:12:53 -0500
Received: from frasgout13.his.huawei.com (frasgout13.his.huawei.com [14.137.139.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F09145AC44
        for <linux-integrity@vger.kernel.org>; Thu, 12 Jan 2023 07:02:27 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.18.147.227])
        by frasgout13.his.huawei.com (SkyGuard) with ESMTP id 4Nt6ym41vhz9v7Yx
        for <linux-integrity@vger.kernel.org>; Thu, 12 Jan 2023 22:54:40 +0800 (CST)
Received: from roberto-ThinkStation-P620 (unknown [10.204.63.22])
        by APP2 (Coremail) with SMTP id GxC2BwCnemHvIMBjyJSNAA--.53757S2;
        Thu, 12 Jan 2023 16:02:14 +0100 (CET)
Message-ID: <ebfca979a1e303ce64f17d252844e172008c40a4.camel@huaweicloud.com>
Subject: Re: [PATCH ima-evm-utils v2 4/9] Add support for UML in functions.sh
From:   Roberto Sassu <roberto.sassu@huaweicloud.com>
To:     Stefan Berger <stefanb@linux.ibm.com>, zohar@linux.ibm.com,
        dmitry.kasatkin@gmail.com
Cc:     linux-integrity@vger.kernel.org, vt@altlinux.org, pvorel@suse.cz,
        Roberto Sassu <roberto.sassu@huawei.com>
Date:   Thu, 12 Jan 2023 16:01:39 +0100
In-Reply-To: <8d15733c-67bc-ce58-0724-fa5a9cdc905e@linux.ibm.com>
References: <20230112122426.3759938-1-roberto.sassu@huaweicloud.com>
         <20230112122426.3759938-5-roberto.sassu@huaweicloud.com>
         <8d15733c-67bc-ce58-0724-fa5a9cdc905e@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: GxC2BwCnemHvIMBjyJSNAA--.53757S2
X-Coremail-Antispam: 1UD129KBjvJXoWxXw4rKw13Aw4DXryUur4DJwb_yoWrZF1Dp3
        9rWFy5KFn7Ja47Z34ag3y5X3Wftr48Ar18Zr9xX3s8Zwn0krn7tr4IvF4ag348Wr1Yva10
        vay0qw4fGw1DK37anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUgGb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxV
        AFwI0_Gr1j6F4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
        6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
        Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY
        6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17
        CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF
        0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_WFyUJVCq3w
        CI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnI
        WIevJa73UjIFyTuYvjxUrR6zUUUUU
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgAPBF1jj4OIwAAEs3
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, 2023-01-12 at 10:00 -0500, Stefan Berger wrote:
> On 1/12/23 07:24, Roberto Sassu wrote:
> > From: Roberto Sassu <roberto.sassu@huawei.com>
> > 
> > Add the new functions _run_user_mode(), _exit_user_mode(),
> > _init_user_mode() and _cleanup_user_mode() to run the tests inside a system
> > booted with the UML kernel.
> > 
> > A typical structure of a script with tests is:
> > 
> > trap cleanup SIGINT SIGTERM SIGSEGV EXIT
> > 
> > _cleanup() {
> > 	<test cleanup>
> > }
> > 
> > cleanup() {
> > 	_cleanup_user_mode _cleanup
> > 	_report_exit_and_cleanup
> > }
> > 
> > <tests implementations>
> > 
> > _run_user_mode ../linux $PWD/$(basename $0) "env_var1=$env_var1 ..."
> > 
> > _exit_user_mode ../linux
> > 
> > _init_user_mode
> > 
> > <tests init>
> > 
> > <tests call>
> > 
> > If the UML_MODE environment variable is not set to 1, ignore the UML kernel
> > execution and initialization requests, and perform the cleanup in the
> > current environment. Ignore the same also if the script is already run in
> > the UML environment, to avoid loops. Instead, for cleanup, do it only in
> > the UML environment and skip it in the host environment.
> > 
> > Signal to the host environment failures of tests run in the UML environment
> > with an unclean shutdown of the UML kernel.
> > 
> > Add haveged and systemd as dependencies for the tests in ci/fedora.sh,
> > respectively for initializing the random number generator and for shutting
> > down the system in the environment created by the UML kernel.
> > 
> > Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> > ---
> >   ci/fedora.sh       |  4 ++-
> >   tests/functions.sh | 79 +++++++++++++++++++++++++++++++++++++++++++++-
> >   2 files changed, 81 insertions(+), 2 deletions(-)
> > 
> > diff --git a/ci/fedora.sh b/ci/fedora.sh
> > index e60de7981c60..198034a34e3c 100755
> > --- a/ci/fedora.sh
> > +++ b/ci/fedora.sh
> > @@ -45,7 +45,9 @@ yum -y install \
> >   	vim-common \
> >   	wget \
> >   	which \
> > -	zstd
> > +	zstd \
> > +	haveged \
> > +	systemd
> >   
> >   yum -y install docbook5-style-xsl || true
> >   yum -y install swtpm || true
> > diff --git a/tests/functions.sh b/tests/functions.sh
> > index 8f6f02dfcd95..98829d94fae1 100755
> > --- a/tests/functions.sh
> > +++ b/tests/functions.sh
> > @@ -267,6 +267,16 @@ _report_exit_and_cleanup() {
> >     [ $testsfail -gt 0 ] && echo -n "$RED" || echo -n "$NORM"
> >     echo " FAIL: $testsfail"
> >     echo "$NORM"
> > +  # Signal failure to UML caller with an unclean shutdown.
> > +  if [ -n "$UML_MODE" ] && [ "$UML_MODE" -eq 1 ] && [ $$ -eq 1 ]; then
> > +    if [ -z "$(which poweroff)" ]; then
> > +      echo "Warning: cannot properly shutdown system"
> > +    fi
> > +
> > +    if [ $testsfail -eq 0 ]; then
> > +      poweroff -f
> > +    fi
> > +  fi
> >     if [ $testsfail -gt 0 ]; then
> >       exit "$FAIL"
> >     elif [ $testspass -gt 0 ]; then
> > @@ -312,4 +322,71 @@ _softhsm_teardown() {
> >     rm -rf "${SOFTHSM_SETUP_CONFIGDIR}"
> >     unset SOFTHSM_SETUP_CONFIGDIR SOFTHSM2_CONF PKCS11_KEYURI \
> >       EVMCTL_ENGINE OPENSSL_ENGINE OPENSSL_KEYFORM
> > -}
> > \ No newline at end of file
> > +}
> > +
> > +# Syntax: _run_user_mode <UML binary> <init> <additional kernel parameters>
> > +_run_user_mode() {
> > +  if [ -z "$UML_MODE" ] || [ "$UML_MODE" -ne 1 ]; then
> > +    return
> > +  fi
> > +
> > +  if [ $$ -eq 1 ]; then
> > +    return
> > +  fi
> > +
> > +  expect_pass $1 rootfstype=hostfs rw init=$2 quiet mem=256M $3
> > +}
> > +
> > +# Syntax: _exit_user_mode <UML binary>
> > +_exit_user_mode() {
> > +  if [ -z "$UML_MODE" ] || [ "$UML_MODE" -ne 1 ]; then
> > +    return
> > +  fi
> > +
> > +  if [ $$ -eq 1 ]; then
> > +    return
> > +  fi
> > +
> > +  if [ -f "$1" ]; then
> > +    exit $OK
> > +  fi
> > +}
> > +
> > +# Syntax: _init_user_mode
> > +_init_user_mode() {
> > +  if [ -z "$UML_MODE" ] || [ "$UML_MODE" -ne 1 ]; then
> > +    return
> > +  fi
> > +
> > +  if [ $$ -ne 1 ]; then
> > +    return
> > +  fi
> > +
> > +  mount -t proc proc /proc
> > +  mount -t sysfs sysfs /sys
> > +  mount -t securityfs securityfs /sys/kernel/security
> > +
> > +  if [ -n "$(which haveged 2> /dev/null)" ]; then
> > +    $(which haveged) -w 1024 &> /dev/null
> > +  fi
> 
> What's different when it's missing?

The boot time is longer, if I remember correctly.

Thanks

Roberto

> > +
> > +  pushd $PWD > /dev/null
> > +}
> > +
> > +# Syntax: _cleanup_user_mode <cleanup function>
> > +_cleanup_user_mode() {
> > +  if [ -z "$UML_MODE" ] || [ "$UML_MODE" -ne 1 ]; then
> > +    $1
> > +    return
> > +  fi
> > +
> > +  if [ $$ -ne 1 ]; then
> > +    return
> > +  fi
> > +
> > +  $1
> > +
> > +  umount /sys/kernel/security
> > +  umount /sys
> > +  umount /proc
> > +}
> 
> Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>

