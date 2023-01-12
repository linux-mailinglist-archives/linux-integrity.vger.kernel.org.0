Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DBF8667AE3
	for <lists+linux-integrity@lfdr.de>; Thu, 12 Jan 2023 17:31:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235956AbjALQb1 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 12 Jan 2023 11:31:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238076AbjALQaJ (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 12 Jan 2023 11:30:09 -0500
Received: from frasgout12.his.huawei.com (frasgout12.his.huawei.com [14.137.139.154])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9710B7F6
        for <linux-integrity@vger.kernel.org>; Thu, 12 Jan 2023 08:29:17 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.18.147.228])
        by frasgout12.his.huawei.com (SkyGuard) with ESMTP id 4Nt8v026zDz9v7H5
        for <linux-integrity@vger.kernel.org>; Fri, 13 Jan 2023 00:21:32 +0800 (CST)
Received: from roberto-ThinkStation-P620 (unknown [10.204.63.22])
        by APP1 (Coremail) with SMTP id LxC2BwD3gAxJNcBjOQGPAA--.18804S2;
        Thu, 12 Jan 2023 17:29:04 +0100 (CET)
Message-ID: <faad3f8a6356ec8be90a66ce9bd80d40576f3cc2.camel@huaweicloud.com>
Subject: Re: [PATCH ima-evm-utils v2 8/9] Use in-place built fsverity binary
 instead of installing it
From:   Roberto Sassu <roberto.sassu@huaweicloud.com>
To:     Stefan Berger <stefanb@linux.ibm.com>, zohar@linux.ibm.com,
        dmitry.kasatkin@gmail.com
Cc:     linux-integrity@vger.kernel.org, vt@altlinux.org, pvorel@suse.cz,
        Roberto Sassu <roberto.sassu@huawei.com>
Date:   Thu, 12 Jan 2023 17:28:30 +0100
In-Reply-To: <b2081222-c8d7-0bc2-1e0a-368258c8a1c9@linux.ibm.com>
References: <20230112122426.3759938-1-roberto.sassu@huaweicloud.com>
         <20230112122426.3759938-9-roberto.sassu@huaweicloud.com>
         <42a75a49-31c8-4987-2b0d-83fef07d6cde@linux.ibm.com>
         <d6b9a9084c887372157e2deea29c20c9520ea63b.camel@huaweicloud.com>
         <b2081222-c8d7-0bc2-1e0a-368258c8a1c9@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: LxC2BwD3gAxJNcBjOQGPAA--.18804S2
X-Coremail-Antispam: 1UD129KBjvJXoW7AF4kAr4rZrW8ZFyDtryrJFb_yoW8CFW3pa
        17t3WjkFsYqF1UAr18Ka9Fya4IkrW8tr1UZr1UX347ZFyvvr4Dtr1Ivr4rWrs7trWUXr1S
        kw4FvFnag3WDArJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUgKb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxV
        AFwI0_Gr1j6F4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
        6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
        Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY
        6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17
        CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF
        0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Wr1j6rW3Jr
        1lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBI
        daVFxhVjvjDU0xZFpf9x07UQzVbUUUUU=
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgAPBF1jj4OKOQAAsI
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, 2023-01-12 at 11:26 -0500, Stefan Berger wrote:
> 
> On 1/12/23 11:20, Roberto Sassu wrote:
> > On Thu, 2023-01-12 at 11:11 -0500, Stefan Berger wrote:
> > > On 1/12/23 07:24, Roberto Sassu wrote:
> > > > From: Roberto Sassu <roberto.sassu@huawei.com>
> > > > 
> > > > Instead of making changes to the system, use in-place built fsverity binary
> > > > by adding ../fsverity-utils to the PATH variable, so that the binary can be
> > > > found with the 'which' command.
> > > > 
> > > > Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> > > 
> > > Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
> > > 
> > > > ---
> > > >    tests/fsverity.test       | 2 +-
> > > >    tests/install-fsverity.sh | 2 +-
> > > >    2 files changed, 2 insertions(+), 2 deletions(-)
> > > > 
> > > > diff --git a/tests/fsverity.test b/tests/fsverity.test
> > > > index 84312aa08a30..e05978be7ea6 100755
> > > > --- a/tests/fsverity.test
> > > > +++ b/tests/fsverity.test
> > > > @@ -30,7 +30,7 @@
> > > >    # custom policy rules might take precedence.
> > > >    
> > > >    cd "$(dirname "$0")" || exit 1
> > > > -PATH=../src:$PATH
> > > > +PATH=../src:../fsverity-utils:$PATH
> > > >    source ./functions.sh
> > > >    
> > > >    # Base VERBOSE on the environment variable, if set.
> > > > diff --git a/tests/install-fsverity.sh b/tests/install-fsverity.sh
> > > > index 418fc42f472b..d00674c0d3a2 100755
> > > > --- a/tests/install-fsverity.sh
> > > > +++ b/tests/install-fsverity.sh
> > > > @@ -2,6 +2,6 @@
> > > >    
> > > >    git clone https://git.kernel.org/pub/scm/linux/kernel/git/ebiggers/fsverity-utils.git
> > > >    cd fsverity-utils
> > > > -CC=gcc make -j$(nproc) && sudo make install
> > > > +CC=gcc make -j$(nproc)
> > > >    cd ..
> > > >    rm -rf fsverity-utils
> > 
> > Argh... same problem.
> > 
> > Will just delete the last two lines. It is just for CI.
> 
> Must be skipping tests when the tool is not found

Yes, it does:

SKIP: fsverity is not installed
PASS: 0 SKIP: 0 FAIL: 0

Roberto

