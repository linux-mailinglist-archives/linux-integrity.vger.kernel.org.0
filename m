Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F276C6A8812
	for <lists+linux-integrity@lfdr.de>; Thu,  2 Mar 2023 18:44:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229586AbjCBRof (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 2 Mar 2023 12:44:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229719AbjCBRo2 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 2 Mar 2023 12:44:28 -0500
Received: from frasgout13.his.huawei.com (frasgout13.his.huawei.com [14.137.139.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F0FB2ED68
        for <linux-integrity@vger.kernel.org>; Thu,  2 Mar 2023 09:44:23 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.18.147.228])
        by frasgout13.his.huawei.com (SkyGuard) with ESMTP id 4PSJCz2q0Cz9v7Ys
        for <linux-integrity@vger.kernel.org>; Fri,  3 Mar 2023 01:35:43 +0800 (CST)
Received: from roberto-ThinkStation-P620 (unknown [10.204.63.22])
        by APP2 (Coremail) with SMTP id GxC2BwCHU1pk4ABkQZVkAQ--.9866S2;
        Thu, 02 Mar 2023 18:44:09 +0100 (CET)
Message-ID: <7b67bc78e355d4c3541d03e1dd707f75342ca28c.camel@huaweicloud.com>
Subject: Re: [PATCH ima-evm-utils v6] Add tests for MMAP_CHECK and
 MMAP_CHECK_REQPROT hooks
From:   Roberto Sassu <roberto.sassu@huaweicloud.com>
To:     Mimi Zohar <zohar@linux.ibm.com>, dmitry.kasatkin@gmail.com
Cc:     linux-integrity@vger.kernel.org, vt@altlinux.org, pvorel@suse.cz,
        stefanb@linux.ibm.com, Roberto Sassu <roberto.sassu@huawei.com>
Date:   Thu, 02 Mar 2023 18:44:01 +0100
In-Reply-To: <0407924e1ad9223eed20c9cc1e3ccf685519656c.camel@linux.ibm.com>
References: <20230301100822.232187-1-roberto.sassu@huaweicloud.com>
         <0407924e1ad9223eed20c9cc1e3ccf685519656c.camel@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: GxC2BwCHU1pk4ABkQZVkAQ--.9866S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Cr1rtr15XF1rGr4kArykGrg_yoW8Wr1rpa
        1Yqa1qkFWvyFyrZw1Iy34Yqr48tw4IkF1UArn5trW8Z3sYyFnayr1xtFW3Wr93Jr93Ar1F
        va1Fv3Wavr4vgFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUgGb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxV
        AFwI0_Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
        x7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
        0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_
        Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1V
        AY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAI
        cVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWrJr0_WFyUJw
        CI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnI
        WIevJa73UjIFyTuYvjxUOyCJDUUUU
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgAEBF1jj4YlTAAAsc
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, 2023-03-02 at 12:20 -0500, Mimi Zohar wrote:
> Hi Roberto,
> 
> > diff --git a/tests/mmap_check.test b/tests/mmap_check.test
> > new file mode 100755
> > index 00000000000..3a42fec179e
> > --- /dev/null
> > +++ b/tests/mmap_check.test
> > @@ -0,0 +1,407 @@
> > +#!/bin/bash
> > +# SPDX-License-Identifier: GPL-2.0
> > +#
> > +# Copyright (C) 2022-2023 Roberto Sassu <roberto.sassu@huawei.com>
> > +#
> > +# Check the behavior of MMAP_CHECK and MMAP_CHECK_REQPROT
> > +
> > +trap '_report_exit_and_cleanup _cleanup_env cleanup' SIGINT SIGTERM SIGSEGV EXIT
> > +
> > +PATCHES=(
> > +'ima: Align ima_file_mmap() parameters with mmap_file LSM hook'
> > +'ima: Introduce MMAP_CHECK_REQPROT hook'
> > +)
> > +
> > +(( ret_invalid_rule=1 ))
> > +(( ret_rule_overlap=2 ))
> > +(( ret_same_rule_exists=4 ))
> 
> New to v6 is the defintiion of these variables.   Is there a reason for
> defining them here as opposed to in check_load_ima_rule(), where they
> could be defined as local?   Here they're global and should be in upper
> case like the the variables below.  

Ok, will make them in upper case.

> > +
> > +(( EVM_INIT_HMAC=0x0001 ))
> > +(( EVM_INIT_X509=0x0002 ))
> 
> Is there a reason for initializing these variables differently than
> those below?  For example, EVM_INIT_HMAC could be define as
> EVM_INIT_HMAC=$((0x0001)).

Oh, I took them from evm.h. I can initialize those above in the same
way.

Thanks

Roberto

> +# Base VERBOSE on the environment variable, if set.
> > +VERBOSE="${VERBOSE:-0}"
> > +
> > +# Errors defined in test_mmap
> > +ERR_SETUP=1
> > +ERR_TEST=2

