Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE3A467C6A6
	for <lists+linux-integrity@lfdr.de>; Thu, 26 Jan 2023 10:10:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233508AbjAZJKA (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 26 Jan 2023 04:10:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236732AbjAZJJ7 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 26 Jan 2023 04:09:59 -0500
Received: from frasgout12.his.huawei.com (frasgout12.his.huawei.com [14.137.139.154])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2D513E60B
        for <linux-integrity@vger.kernel.org>; Thu, 26 Jan 2023 01:09:57 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.18.147.228])
        by frasgout12.his.huawei.com (SkyGuard) with ESMTP id 4P2ZT82RLrz9xtV0
        for <linux-integrity@vger.kernel.org>; Thu, 26 Jan 2023 17:01:48 +0800 (CST)
Received: from roberto-ThinkStation-P620 (unknown [10.204.63.22])
        by APP2 (Coremail) with SMTP id GxC2BwDnbmVMQ9JjdtTIAA--.57168S2;
        Thu, 26 Jan 2023 10:09:41 +0100 (CET)
Message-ID: <5fb96b900cb734a6dfa53b5d83bac2b5b3baf64d.camel@huaweicloud.com>
Subject: Re: [PATCH ima-evm-utils v3 03/11] Compile the UML kernel and
 download it in Github Actions
From:   Roberto Sassu <roberto.sassu@huaweicloud.com>
To:     Mimi Zohar <zohar@linux.ibm.com>, dmitry.kasatkin@gmail.com
Cc:     linux-integrity@vger.kernel.org, vt@altlinux.org, pvorel@suse.cz,
        stefanb@linux.ibm.com, Roberto Sassu <roberto.sassu@huawei.com>
Date:   Thu, 26 Jan 2023 10:09:14 +0100
In-Reply-To: <a5ef0f7a7c7b7c955833fb5d1eae7239c3d2d219.camel@linux.ibm.com>
References: <20230125085030.1568256-1-roberto.sassu@huaweicloud.com>
         <20230125085030.1568256-4-roberto.sassu@huaweicloud.com>
         <a5ef0f7a7c7b7c955833fb5d1eae7239c3d2d219.camel@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: GxC2BwDnbmVMQ9JjdtTIAA--.57168S2
X-Coremail-Antispam: 1UD129KBjvJXoWxKr1ftrWrZw15Wr48Jr43KFg_yoWxGF4rpr
        WYka45Kr4kXa47AwsF9ryruFWrt397Jr17G34xJ34rAF1DAFyvvFs2kFW5uFnFvrWxKF47
        ZayFgFy2kw48ZaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUgmb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxV
        AFwI0_Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
        x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
        0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_
        Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1V
        AY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAI
        cVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWrZr1j6s0DMI
        IF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2
        KfnxnUUI43ZEXa7IU1zuWJUUUUU==
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgAJBF1jj4QctQABsS
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, 2023-01-25 at 14:17 -0500, Mimi Zohar wrote:
> On Wed, 2023-01-25 at 09:50 +0100, Roberto Sassu wrote:
> > From: Roberto Sassu <roberto.sassu@huawei.com>
> > 
> > Add a build job, prerequisite of the existing job, to compile the UML
> > kernel and upload it and the signing key to a cache. Github configuration
> > should have two variables: LINUX_URL, the full URL of the kernel
> > repository; LINUX_BRANCH, the branch to check out as fallback if the kernel
> > repository does not have the same branch name as the one being pushed for
> > ima-evm-utils. See:
> > 
> > https://docs.github.com/en/actions/learn-github-actions/variables
> > 
> > for directions on how to define those variables.
> > 
> > If the two variables are not defined, the default values are:
> > 
> > LINUX_URL=https://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity.git
> > LINUX_BRANCH=next-integrity
> > 
> > If there is a cache hit (same kernel commit and same kernel configuration),
> > next time the UML kernel will not be rebuilt. To use the cache, it is
> > necessary to install zstd in the container. Add this dependency to
> > ci/fedora.sh.
> > 
> > The cache can be managed at the following URL:
> > 
> > https://github.com/<username>/ima-evm-utils/actions/caches
> > 
> > The page also offers the possibility to clean the cache, to force
> > rebuilding the kernel.
> > 
> > Add a new entry in the testing matrix, for the fedora-latest container
> > image, to run the tests with the UML kernel. The entry differs from the
> > others for the new environment variable TST_ENV, set to 'um', and
> > TST_KERNEL set to '../linux', as the tests will be executed from the
> > tests/ directory in ima-evm-utils.
> > 
> > Add a new volume to the container, /dev/shm from the host, as it is
> > required for running the UML kernel.
> > 
> > Extend the existing job with steps to download the UML kernel and signing
> > key from the cache. The new steps are executed only if the matrix entry has
> > TST_ENV set.
> > 
> > Finally, pass TST_ENV and TST_KERNEL to the tests. A test should also
> > propagate these variables to the new environment, by passing them to the
> > kernel command line.
> > 
> > Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> 
> Thanks, Roberto.   Just a couple of comments/questions below.
> 
> > ---
> >  .github/workflows/ci.yml | 99 +++++++++++++++++++++++++++++++++++++++-
> >  ci/fedora.sh             |  3 +-
> >  2 files changed, 99 insertions(+), 3 deletions(-)
> > 
> > diff --git a/.github/workflows/ci.yml b/.github/workflows/ci.yml
> > index d2afdfe15467..110c8065237b 100644
> > --- a/.github/workflows/ci.yml
> > +++ b/.github/workflows/ci.yml
> > @@ -3,7 +3,79 @@ name: "distros"
> >  on: [push, pull_request]
> >  
> >  jobs:
> > +  build:
> > +    runs-on: ubuntu-latest
> > +    outputs:
> > +      LINUX_SHA: ${{ steps.last-commit.outputs.LINUX_SHA }}
> > +    name: build
> > +    timeout-minutes: 100
> > +    strategy:
> > +      fail-fast: false
> > +
> > +    steps:
> > +      - uses: actions/checkout@v3
> > +
> > +      - name: Determine last kernel commit
> > +        id: last-commit
> > +        shell: bash
> > +        run: |
> > +          mkdir linux-integrity
> > +          pushd linux-integrity
> > +          git init
> > +          LINUX_URL=${{ vars.LINUX_URL }}
> > +          if [ -z "$LINUX_URL" ]; then
> > +              LINUX_URL=https://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity.git
> > +          fi
> > +          LINUX_BRANCH=${{ vars.LINUX_BRANCH }}
> > +          if [ -z "$LINUX_BRANCH" ]; then
> > +              LINUX_BRANCH=next-integrity
> > +          fi
> > +          git remote add origin $LINUX_URL
> > +          LINUX_SHA=$(git ls-remote origin $GITHUB_REF_NAME | awk '{print $1}')
> > +          [ -z "$LINUX_SHA" ] && LINUX_SHA=$(git ls-remote origin $LINUX_BRANCH | awk '{print $1}')
> > +          echo "LINUX_SHA=$LINUX_SHA" >> $GITHUB_OUTPUT
> > +          popd
> > +
> > +      - name: Cache UML kernel
> > +        id: cache-linux
> > +        uses: actions/cache@v3
> > +        with:
> > +          path: linux
> > +          key: linux-${{ steps.last-commit.outputs.LINUX_SHA }}-${{ hashFiles('**/config-uml') }}
> > +
> > +      - name: Cache signing key
> > +        id: cache-key
> > +        uses: actions/cache@v3
> > +        with:
> > +          path: signing_key.pem
> > +          key: signing_key.pem-${{ steps.last-commit.outputs.LINUX_SHA }}-${{ hashFiles('**/config-uml') }}
> > +
> > +      - name: Compile UML kernel
> > +        if: steps.cache-linux.outputs.cache-hit != 'true' || steps.cache-key.outputs.cache-hit != 'true'
> > +        shell: bash
> > +        run: |
> > +          if [ "$DEVTOOLSET" = "yes" ]; then
> > +                  source /opt/rh/devtoolset-10/enable
> > +          fi
> > +          if [ "$ARCH" = "i386" ]; then
> > +                  CROSS_COMPILE_OPT="CROSS_COMPILE=i686-linux-gnu-"
> > +          fi
> > +          pushd linux-integrity
> > +          git pull --depth 1 origin ${{ steps.last-commit.outputs.LINUX_SHA }}
> > +          make ARCH=um olddefconfig
> > +          ./scripts/kconfig/merge_config.sh -m .config ../config-uml
> 
> merge_config.sh supports merging multiple config files.  To simplify
> review, instead of having all the Kconfigs defined in config-uml,
> consider grouping them based on topic.  For example one file could
> contain integrity, IMA and EVM, while another file could contain
> debugging info.
> 
> Is it absolutely necessary to do now, no, but going forward it would be
> nice.  For example, any changes specifically needed for virtual
> machines, could be defined in a separate file.

Ok. Actually, virtual machines work with the same configuration.

I added this at the bottom of config-uml to exclude unneeded drivers:

CONFIG_DRM=n
CONFIG_USB=n
CONFIG_SOUND=n

Since this would apply to both cases, I could just rename config-uml to
config-test.

Also, it seems that the correct way to generate the kernel
configuration at the beginning is 'make defconfig' not 'make
olddefconfig', which in my system takes the config from /boot.

> > +          # Update manually, to specify ARCH=um
> > +          make ARCH=um olddefconfig
> > +          # Make everything built-in
> > +          make ARCH=um localyesconfig
> 
> Updating the .config is happening so many times.  Previously it worked
> without the additional "localyesconfig", why is it necessary now?

It ensures that everything is built-in, since we are not installing
kernel modules.

Roberto

> > +          make ARCH=um $CROSS_COMPILE_OPT -j$(nproc)
> > +          chmod +x linux
> > +          cp linux ..
> > +          cp certs/signing_key.pem ..
> > +          popd
> > +
> >    job:
> > +    needs: build
> >      runs-on: ubuntu-latest
> >  
> >      strategy:

