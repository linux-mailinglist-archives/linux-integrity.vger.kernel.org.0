Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDAB967BA8A
	for <lists+linux-integrity@lfdr.de>; Wed, 25 Jan 2023 20:17:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235225AbjAYTRj (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 25 Jan 2023 14:17:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbjAYTRi (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 25 Jan 2023 14:17:38 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 469F6301BD
        for <linux-integrity@vger.kernel.org>; Wed, 25 Jan 2023 11:17:37 -0800 (PST)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30PJ4xT8004437;
        Wed, 25 Jan 2023 19:17:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=3zlJ+N1cN309f/aCTXC8ZLR0x8vR87sMf6MNkDs2IU0=;
 b=gZMFNFrKZWR4E+sG4prqZoyAAd7Dl4lclkY9ldjgZ9A2x8Nl6RZD/QUCi1XcsHOB8ROA
 w1IuzaqzovYvdh6cA778RJPvzG7YJ2S0sFFkTWpLL5YsPH70Q4Up/f1t+qmIBVJbEGY+
 Fv8M/MnzcILG9hGOpAGpuPlImqeI7gBNDTY91xQsInLzTXYt6ZJtg6rdaBT/8ewnuWzn
 ttr4fY2rbIpad6mdVCLsqGUw1F67LnTQtewHjmwP4pcjomKDzl+Xe3YH8bfhhfPSQ9rU
 eAQ3nmbswD3sNBeVNfLB7QqAQwj6VyI5b7HBoIl191ScrvNkJHby1xD2MHoZ7BoqwE6R uQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3na9vd0x1s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 25 Jan 2023 19:17:20 +0000
Received: from m0098417.ppops.net (m0098417.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 30PJAd0w001186;
        Wed, 25 Jan 2023 19:17:20 GMT
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.11])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3na9vd0x1f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 25 Jan 2023 19:17:20 +0000
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
        by ppma03dal.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 30PGfQhh006944;
        Wed, 25 Jan 2023 19:17:19 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([9.208.130.101])
        by ppma03dal.us.ibm.com (PPS) with ESMTPS id 3n87p7fu6n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 25 Jan 2023 19:17:19 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
        by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 30PJHIc57471772
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 25 Jan 2023 19:17:18 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EE3BD58045;
        Wed, 25 Jan 2023 19:17:17 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1F8D058052;
        Wed, 25 Jan 2023 19:17:17 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.18.164])
        by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Wed, 25 Jan 2023 19:17:17 +0000 (GMT)
Message-ID: <a5ef0f7a7c7b7c955833fb5d1eae7239c3d2d219.camel@linux.ibm.com>
Subject: Re: [PATCH ima-evm-utils v3 03/11] Compile the UML kernel and
 download it in Github Actions
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Roberto Sassu <roberto.sassu@huaweicloud.com>,
        dmitry.kasatkin@gmail.com
Cc:     linux-integrity@vger.kernel.org, vt@altlinux.org, pvorel@suse.cz,
        stefanb@linux.ibm.com, Roberto Sassu <roberto.sassu@huawei.com>
Date:   Wed, 25 Jan 2023 14:17:16 -0500
In-Reply-To: <20230125085030.1568256-4-roberto.sassu@huaweicloud.com>
References: <20230125085030.1568256-1-roberto.sassu@huaweicloud.com>
         <20230125085030.1568256-4-roberto.sassu@huaweicloud.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: zUfwdKIexEoVZz8Yfd4eRG2osQfLDO_S
X-Proofpoint-ORIG-GUID: nIWXzE6SyiGCQ9dtP8AFi9HoeTMrOk_0
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-25_12,2023-01-25_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 suspectscore=0 phishscore=0 mlxlogscore=999 clxscore=1015 spamscore=0
 adultscore=0 priorityscore=1501 malwarescore=0 bulkscore=0 mlxscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301250169
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, 2023-01-25 at 09:50 +0100, Roberto Sassu wrote:
> From: Roberto Sassu <roberto.sassu@huawei.com>
> 
> Add a build job, prerequisite of the existing job, to compile the UML
> kernel and upload it and the signing key to a cache. Github configuration
> should have two variables: LINUX_URL, the full URL of the kernel
> repository; LINUX_BRANCH, the branch to check out as fallback if the kernel
> repository does not have the same branch name as the one being pushed for
> ima-evm-utils. See:
> 
> https://docs.github.com/en/actions/learn-github-actions/variables
> 
> for directions on how to define those variables.
> 
> If the two variables are not defined, the default values are:
> 
> LINUX_URL=https://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity.git
> LINUX_BRANCH=next-integrity
> 
> If there is a cache hit (same kernel commit and same kernel configuration),
> next time the UML kernel will not be rebuilt. To use the cache, it is
> necessary to install zstd in the container. Add this dependency to
> ci/fedora.sh.
> 
> The cache can be managed at the following URL:
> 
> https://github.com/<username>/ima-evm-utils/actions/caches
> 
> The page also offers the possibility to clean the cache, to force
> rebuilding the kernel.
> 
> Add a new entry in the testing matrix, for the fedora-latest container
> image, to run the tests with the UML kernel. The entry differs from the
> others for the new environment variable TST_ENV, set to 'um', and
> TST_KERNEL set to '../linux', as the tests will be executed from the
> tests/ directory in ima-evm-utils.
> 
> Add a new volume to the container, /dev/shm from the host, as it is
> required for running the UML kernel.
> 
> Extend the existing job with steps to download the UML kernel and signing
> key from the cache. The new steps are executed only if the matrix entry has
> TST_ENV set.
> 
> Finally, pass TST_ENV and TST_KERNEL to the tests. A test should also
> propagate these variables to the new environment, by passing them to the
> kernel command line.
> 
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>

Thanks, Roberto.   Just a couple of comments/questions below.

> ---
>  .github/workflows/ci.yml | 99 +++++++++++++++++++++++++++++++++++++++-
>  ci/fedora.sh             |  3 +-
>  2 files changed, 99 insertions(+), 3 deletions(-)
> 
> diff --git a/.github/workflows/ci.yml b/.github/workflows/ci.yml
> index d2afdfe15467..110c8065237b 100644
> --- a/.github/workflows/ci.yml
> +++ b/.github/workflows/ci.yml
> @@ -3,7 +3,79 @@ name: "distros"
>  on: [push, pull_request]
>  
>  jobs:
> +  build:
> +    runs-on: ubuntu-latest
> +    outputs:
> +      LINUX_SHA: ${{ steps.last-commit.outputs.LINUX_SHA }}
> +    name: build
> +    timeout-minutes: 100
> +    strategy:
> +      fail-fast: false
> +
> +    steps:
> +      - uses: actions/checkout@v3
> +
> +      - name: Determine last kernel commit
> +        id: last-commit
> +        shell: bash
> +        run: |
> +          mkdir linux-integrity
> +          pushd linux-integrity
> +          git init
> +          LINUX_URL=${{ vars.LINUX_URL }}
> +          if [ -z "$LINUX_URL" ]; then
> +              LINUX_URL=https://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity.git
> +          fi
> +          LINUX_BRANCH=${{ vars.LINUX_BRANCH }}
> +          if [ -z "$LINUX_BRANCH" ]; then
> +              LINUX_BRANCH=next-integrity
> +          fi
> +          git remote add origin $LINUX_URL
> +          LINUX_SHA=$(git ls-remote origin $GITHUB_REF_NAME | awk '{print $1}')
> +          [ -z "$LINUX_SHA" ] && LINUX_SHA=$(git ls-remote origin $LINUX_BRANCH | awk '{print $1}')
> +          echo "LINUX_SHA=$LINUX_SHA" >> $GITHUB_OUTPUT
> +          popd
> +
> +      - name: Cache UML kernel
> +        id: cache-linux
> +        uses: actions/cache@v3
> +        with:
> +          path: linux
> +          key: linux-${{ steps.last-commit.outputs.LINUX_SHA }}-${{ hashFiles('**/config-uml') }}
> +
> +      - name: Cache signing key
> +        id: cache-key
> +        uses: actions/cache@v3
> +        with:
> +          path: signing_key.pem
> +          key: signing_key.pem-${{ steps.last-commit.outputs.LINUX_SHA }}-${{ hashFiles('**/config-uml') }}
> +
> +      - name: Compile UML kernel
> +        if: steps.cache-linux.outputs.cache-hit != 'true' || steps.cache-key.outputs.cache-hit != 'true'
> +        shell: bash
> +        run: |
> +          if [ "$DEVTOOLSET" = "yes" ]; then
> +                  source /opt/rh/devtoolset-10/enable
> +          fi
> +          if [ "$ARCH" = "i386" ]; then
> +                  CROSS_COMPILE_OPT="CROSS_COMPILE=i686-linux-gnu-"
> +          fi
> +          pushd linux-integrity
> +          git pull --depth 1 origin ${{ steps.last-commit.outputs.LINUX_SHA }}
> +          make ARCH=um olddefconfig
> +          ./scripts/kconfig/merge_config.sh -m .config ../config-uml

merge_config.sh supports merging multiple config files.  To simplify
review, instead of having all the Kconfigs defined in config-uml,
consider grouping them based on topic.  For example one file could
contain integrity, IMA and EVM, while another file could contain
debugging info.

Is it absolutely necessary to do now, no, but going forward it would be
nice.  For example, any changes specifically needed for virtual
machines, could be defined in a separate file.

> +          # Update manually, to specify ARCH=um
> +          make ARCH=um olddefconfig
> +          # Make everything built-in
> +          make ARCH=um localyesconfig

Updating the .config is happening so many times.  Previously it worked
without the additional "localyesconfig", why is it necessary now?

> +          make ARCH=um $CROSS_COMPILE_OPT -j$(nproc)
> +          chmod +x linux
> +          cp linux ..
> +          cp certs/signing_key.pem ..
> +          popd
> +
>    job:
> +    needs: build
>      runs-on: ubuntu-latest
>  
>      strategy:

