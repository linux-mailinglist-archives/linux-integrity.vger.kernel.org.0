Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0CD167B382
	for <lists+linux-integrity@lfdr.de>; Wed, 25 Jan 2023 14:37:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229827AbjAYNhX (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 25 Jan 2023 08:37:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229806AbjAYNhW (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 25 Jan 2023 08:37:22 -0500
Received: from frasgout13.his.huawei.com (frasgout13.his.huawei.com [14.137.139.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 459E94E507
        for <linux-integrity@vger.kernel.org>; Wed, 25 Jan 2023 05:37:19 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.18.147.227])
        by frasgout13.his.huawei.com (SkyGuard) with ESMTP id 4P24SF3kVrz9xFGc
        for <linux-integrity@vger.kernel.org>; Wed, 25 Jan 2023 21:29:17 +0800 (CST)
Received: from roberto-ThinkStation-P620 (unknown [10.204.63.22])
        by APP2 (Coremail) with SMTP id GxC2BwA3CF96MNFjPTfFAA--.15158S2;
        Wed, 25 Jan 2023 14:37:04 +0100 (CET)
Message-ID: <e839e333e9d529de587e4f5b72d1cfa7793cf3c5.camel@huaweicloud.com>
Subject: Re: [PATCH ima-evm-utils v3 05/11] Add support for creating a new
 testing environment in functions.sh
From:   Roberto Sassu <roberto.sassu@huaweicloud.com>
To:     zohar@linux.ibm.com, dmitry.kasatkin@gmail.com
Cc:     linux-integrity@vger.kernel.org, vt@altlinux.org, pvorel@suse.cz,
        stefanb@linux.ibm.com, Roberto Sassu <roberto.sassu@huawei.com>
Date:   Wed, 25 Jan 2023 14:36:41 +0100
In-Reply-To: <20230125085030.1568256-6-roberto.sassu@huaweicloud.com>
References: <20230125085030.1568256-1-roberto.sassu@huaweicloud.com>
         <20230125085030.1568256-6-roberto.sassu@huaweicloud.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: GxC2BwA3CF96MNFjPTfFAA--.15158S2
X-Coremail-Antispam: 1UD129KBjvJXoWxZF18Cr15Wr4fZrWxCw47XFb_yoWrCFy7p3
        4DWF1YkF1ktFy7t3sxWF4SqFyfJrW8Ar1jyFZrJws0vw45Jr92yFsak3W3K3sF9rZYvF4F
        v3yFqw4fCr1DKrJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQAIBF1jj4gQ0wABs2
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, 2023-01-25 at 09:50 +0100, Roberto Sassu wrote:
> From: Roberto Sassu <roberto.sassu@huawei.com>
> 
> Add the new functions _run_env(), _exit_env(), _init_env() and
> _cleanup_env() to run the tests inside a new environment specified with the
> TST_ENV environment variable.
> 
> A typical structure of a script with tests is:
> 
> trap '_report_exit_and_cleanup _cleanup_env cleanup' \
>     SIGINT SIGTERM SIGSEGV EXIT
> 
> cleanup() {
> 	<test cleanup>
> }
> 
> <tests implementations>
> 
> _run_env "$TST_KERNEL" "$PWD/$(basename "$0")" "env_var1=$env_var1 ..."
> 
> _exit_env "$TST_KERNEL"
> 
> _init_env
> 
> <tests init>
> 
> <tests call>
> 
> If TST_ENV is not set or empty, don't create a new testing environment and
> perform the cleanup in the current environment. Don't create a new testing
> environment also if the script is already executed in a new environment, to
> avoid loops. Instead, for cleanup, do it in the new environment and skip it
> in the host environment (if the cleanup function is passed to
> _cleanup_env()).
> 
> Signal to the creator of the environment failures of tests or of the script
> itself run in the new environment (if the exit code is 1 ($FAIL) or 99
> ($HARDFAIL)) with an unclean shutdown of the system.
> 
> Add haveged and systemd as dependencies for the tests in ci/fedora.sh,
> respectively for initializing the random number generator and for shutting
> down the system in the new environment.
> 
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> ---
>  ci/fedora.sh       |  4 ++-
>  tests/functions.sh | 83 ++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 86 insertions(+), 1 deletion(-)
> 
> diff --git a/ci/fedora.sh b/ci/fedora.sh
> index e60de7981c60..198034a34e3c 100755
> --- a/ci/fedora.sh
> +++ b/ci/fedora.sh
> @@ -45,7 +45,9 @@ yum -y install \
>  	vim-common \
>  	wget \
>  	which \
> -	zstd
> +	zstd \
> +	haveged \
> +	systemd
>  
>  yum -y install docbook5-style-xsl || true
>  yum -y install swtpm || true
> diff --git a/tests/functions.sh b/tests/functions.sh
> index cf83ad21562f..9dc9b96d1d7a 100755
> --- a/tests/functions.sh
> +++ b/tests/functions.sh
> @@ -271,6 +271,17 @@ _report_exit_and_cleanup() {
>    [ $testsfail -gt 0 ] && echo -n "$RED" || echo -n "$NORM"
>    echo " FAIL: $testsfail"
>    echo "$NORM"
> +  # Signal failure to the testing environment creator with an unclean shutdown.
> +  if [ -n "$TST_ENV" ] && [ $$ -eq 1 ]; then
> +    if [ -z "$(command -v poweroff)" ]; then
> +      echo "Warning: cannot properly shutdown system"
> +    fi
> +
> +    if [ $testsfail -eq 0 ] && [ $exit_code -ne "$FAIL" ] &&
> +       [ $exit_code -ne "$HARDFAIL" ]; then
> +      poweroff -f
> +    fi

I need to resend this patch.

Having $exit_code equal to $FAIL or $HARDFAIL is a legitimate case if a
negative test was invoked as the last with expect_fail().

$exit_code should be checked only if no test was executed.

Roberto

> +  fi
>    if [ $testsfail -gt 0 ]; then
>      exit "$FAIL"
>    elif [ $testspass -gt 0 ]; then
> @@ -319,3 +330,75 @@ _softhsm_teardown() {
>    unset SOFTHSM_SETUP_CONFIGDIR SOFTHSM2_CONF PKCS11_KEYURI \
>      EVMCTL_ENGINE OPENSSL_ENGINE OPENSSL_KEYFORM
>  }
> +
> +# Syntax: _run_env <kernel> <init> <additional kernel parameters>
> +_run_env() {
> +  if [ -z "$TST_ENV" ]; then
> +    return
> +  fi
> +
> +  if [ $$ -eq 1 ]; then
> +    return
> +  fi
> +
> +  if [ "$TST_ENV" = "um" ]; then
> +    expect_pass "$1" rootfstype=hostfs rw init="$2" quiet mem=2048M "$3"
> +  else
> +    echo $RED"Testing environment $TST_ENV not supported"$NORM
> +    exit "$FAIL"
> +  fi
> +}
> +
> +# Syntax: _exit_env <kernel>
> +_exit_env() {
> +  if [ -z "$TST_ENV" ]; then
> +    return
> +  fi
> +
> +  if [ $$ -eq 1 ]; then
> +    return
> +  fi
> +
> +  exit "$OK"
> +}
> +
> +# Syntax: _init_env
> +_init_env() {
> +  if [ -z "$TST_ENV" ]; then
> +    return
> +  fi
> +
> +  if [ $$ -ne 1 ]; then
> +    return
> +  fi
> +
> +  mount -t tmpfs tmpfs /tmp
> +  mount -t proc proc /proc
> +  mount -t sysfs sysfs /sys
> +  mount -t securityfs securityfs /sys/kernel/security
> +
> +  if [ -n "$(command -v haveged 2> /dev/null)" ]; then
> +    $(command -v haveged) -w 1024 &> /dev/null
> +  fi
> +
> +  pushd "$PWD" > /dev/null || exit "$FAIL"
> +}
> +
> +# Syntax: _cleanup_env <cleanup function>
> +_cleanup_env() {
> +  if [ -z "$TST_ENV" ]; then
> +    $1
> +    return
> +  fi
> +
> +  if [ $$ -ne 1 ]; then
> +    return
> +  fi
> +
> +  $1
> +
> +  umount /sys/kernel/security
> +  umount /sys
> +  umount /proc
> +  umount /tmp
> +}

