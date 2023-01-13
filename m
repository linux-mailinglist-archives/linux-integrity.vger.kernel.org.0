Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 997A1669455
	for <lists+linux-integrity@lfdr.de>; Fri, 13 Jan 2023 11:38:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241313AbjAMKi2 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 13 Jan 2023 05:38:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241306AbjAMKhs (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 13 Jan 2023 05:37:48 -0500
Received: from frasgout12.his.huawei.com (frasgout12.his.huawei.com [14.137.139.154])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C0B01AA0B;
        Fri, 13 Jan 2023 02:35:58 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.18.147.228])
        by frasgout12.his.huawei.com (SkyGuard) with ESMTP id 4Ntd0p03Kqz9xGZ1;
        Fri, 13 Jan 2023 18:28:10 +0800 (CST)
Received: from roberto-ThinkStation-P620 (unknown [10.204.63.22])
        by APP1 (Coremail) with SMTP id LxC2BwC3PAjkM8Fj60SSAA--.55533S2;
        Fri, 13 Jan 2023 11:35:28 +0100 (CET)
Message-ID: <7e8af24bc175b425777c1e689c26562dc743bfd5.camel@huaweicloud.com>
Subject: Re: [PATCH v7 0/6] evm: Do HMAC of multiple per LSM xattrs for new
 inodes
From:   Roberto Sassu <roberto.sassu@huaweicloud.com>
To:     Paul Moore <paul@paul-moore.com>
Cc:     mark@fasheh.com, jlbec@evilplan.org, joseph.qi@linux.alibaba.com,
        zohar@linux.ibm.com, dmitry.kasatkin@gmail.com, jmorris@namei.org,
        serge@hallyn.com, stephen.smalley.work@gmail.com,
        eparis@parisplace.org, casey@schaufler-ca.com,
        ocfs2-devel@oss.oracle.com, reiserfs-devel@vger.kernel.org,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        linux-kernel@vger.kernel.org, keescook@chromium.org,
        nicolas.bouchinet@clip-os.org,
        Roberto Sassu <roberto.sassu@huawei.com>
Date:   Fri, 13 Jan 2023 11:35:13 +0100
In-Reply-To: <CAHC9VhS0SnEb46-FBpn2JpC2dJ7OnkeJ2EtLBvVvkOLdfFmcbg@mail.gmail.com>
References: <20221201104125.919483-1-roberto.sassu@huaweicloud.com>
         <CAHC9VhS0SnEb46-FBpn2JpC2dJ7OnkeJ2EtLBvVvkOLdfFmcbg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: LxC2BwC3PAjkM8Fj60SSAA--.55533S2
X-Coremail-Antispam: 1UD129KBjvJXoW7CFW8WF18ZFW5ury8Ar1UWrg_yoW8CFWUpa
        9xt3Wagr4kWFyUKr43A3yjk3yUGr4fGF13X34fK34jyrnxuFn2gF1xGayrua4DJrn3u3sY
        vFW3W3sru3Z5u3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkjb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxV
        AFwI0_Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
        x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
        0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l42xK82IYc2Ij
        64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x
        8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE
        2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42
        xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIE
        c7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07UZ18PUUUUU=
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQAQBF1jj4eOnQAAsw
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, 2023-01-12 at 12:15 -0500, Paul Moore wrote:
> On Thu, Dec 1, 2022 at 5:42 AM Roberto Sassu
> <roberto.sassu@huaweicloud.com> wrote:
> > From: Roberto Sassu <roberto.sassu@huawei.com>
> > 
> > One of the major goals of LSM stacking is to run multiple LSMs side by side
> > without interfering with each other. The ultimate decision will depend on
> > individual LSM decision.
> > 
> > Several changes need to be made to the LSM infrastructure to be able to
> > support that. This patch set tackles one of them: gives to each LSM the
> > ability to specify one or multiple xattrs to be set at inode creation
> > time and, at the same time, gives to EVM the ability to access all those
> > xattrs and calculate the HMAC on them.
> 
> ...
> 
> > The patch set has been tested with both the SElinux and Smack test suites.
> > Below, there is the summary of the test results:
> > 
> > SELinux Test Suite result (without patches):
> > Files=73, Tests=1346, 225 wallclock secs ( 0.43 usr  0.23 sys +  6.11 cusr 58.70 csys = 65.47 CPU)
> > Result: FAIL
> > Failed 4/73 test programs. 13/1346 subtests failed.
> > 
> > SELinux Test Suite result (with patches):
> > Files=73, Tests=1346, 225 wallclock secs ( 0.44 usr  0.22 sys +  6.15 cusr 59.94 csys = 66.75 CPU)
> > Result: FAIL
> > Failed 4/73 test programs. 13/1346 subtests failed.
> 
> Can you provide some more information on which of the
> selinux-testsuite tests failed?  That shouldn't be happening and I'm a
> little concerned that these test failures, even if unrelated to your
> work here, could be masking failures which are related.

Uhm, my virtual machine has been used for many tests and was not clean.
This time, I installed a fresh Fedora 37 and compiled the kernel with
the same configuration as the shipped kernel.

Everything works now:

All tests successful.
Files=74, Tests=1363, 210 wallclock secs ( 0.42 usr  0.11 sys +  6.66
cusr 22.33 csys = 29.52 CPU)
Result: PASS

Roberto

