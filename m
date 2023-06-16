Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C606B732B12
	for <lists+linux-integrity@lfdr.de>; Fri, 16 Jun 2023 11:08:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232664AbjFPJIT (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 16 Jun 2023 05:08:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344085AbjFPJIC (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 16 Jun 2023 05:08:02 -0400
Received: from frasgout13.his.huawei.com (unknown [14.137.139.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4728835B3
        for <linux-integrity@vger.kernel.org>; Fri, 16 Jun 2023 02:06:14 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.18.147.228])
        by frasgout13.his.huawei.com (SkyGuard) with ESMTP id 4QjCfx4Kz7z9y5Hn
        for <linux-integrity@vger.kernel.org>; Fri, 16 Jun 2023 16:55:37 +0800 (CST)
Received: from roberto-ThinkStation-P620 (unknown [10.204.63.22])
        by APP2 (Coremail) with SMTP id GxC2BwAn0znsJYxkJOFAAw--.16257S2;
        Fri, 16 Jun 2023 10:05:55 +0100 (CET)
Message-ID: <f77e5c007738619f1ed084c3e1599294bfbf01c1.camel@huaweicloud.com>
Subject: Re: [PATCH v2 ima-evm-utils 0/4] Simple EVM HMAC calculation tests
From:   Roberto Sassu <roberto.sassu@huaweicloud.com>
To:     Mimi Zohar <zohar@linux.ibm.com>, dmitry.kasatkin@gmail.com
Cc:     linux-integrity@vger.kernel.org, vt@altlinux.org, pvorel@suse.cz,
        stefanb@linux.ibm.com, paul@paul-moore.com, casey@schaufler-ca.com,
        Roberto Sassu <roberto.sassu@huawei.com>
Date:   Fri, 16 Jun 2023 11:05:42 +0200
In-Reply-To: <44039a0f827e23f5714ac2461c86af494510f81c.camel@linux.ibm.com>
References: <20230605165554.1965238-1-roberto.sassu@huaweicloud.com>
         <44039a0f827e23f5714ac2461c86af494510f81c.camel@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: GxC2BwAn0znsJYxkJOFAAw--.16257S2
X-Coremail-Antispam: 1UD129KBjvJXoW7KFyUtr1ftr1xGrWxtF1DKFg_yoW8Ww1kpa
        y5Kw1Yyrn8t3WxAwn3uw4xXayS9wsYqr45Xr93J3s7A3W5Ja4vqr40qF1UWa47KFn7GF1j
        vr4jgr1fua4UAFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUgCb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxV
        AFwI0_Gr1j6F4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
        6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
        Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY
        6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17
        CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF
        0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Wr1j6rW3Jr
        1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsG
        vfC2KfnxnUUI43ZEXa7IU1zuWJUUUUU==
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQAKBF1jj469wgABsO
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        MAY_BE_FORGED,PDS_RDNS_DYNAMIC_FP,RDNS_DYNAMIC,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, 2023-06-14 at 15:29 -0400, Mimi Zohar wrote:
> Hi Roberto,
> 
> On Mon, 2023-06-05 at 18:55 +0200, Roberto Sassu wrote:
> > From: Roberto Sassu <roberto.sassu@huawei.com>
> > 
> > Add two simple tests to check whether or not the HMAC calculated by the
> > kernel and evmctl matches. Do the tests for a regular file, and for a
> > directory successfully transmuted with Smack.
> > 
> > Also add two bug fixes to include the filesystem UUID and the inode
> > generation in the HMAC calculation, and the new option --hmackey to specify
> > an alternate location of the HMAC key.
> 
> The main purpose for having a "Simple EVM HMAC" test is to ensure that
> nothing breaks.
> 
> "evmctl --hmac" was only enabled in debug mode, since the hmac key was
> not exposed to userspace.  It was never really used.  With the ability
> of creating an encrypted key based  on user-provided decrypted data,
> verifying the EVM hmac is now feasible.  This is the justification for
> "Add --hmackey option for evmctl".

Ok, will add it.

> The initial test should work with either SELinux or smack extended
> attributes.  None of the CI tests have SELinux or Smack enabled, except
> for the UFI kernel.  Verifying the EVM hmac with an SELinux extended
> attribute is not being tested.  On my local machine, the EVM HMAC with
> SELinux xattr is failing.  Is this related to SELinux returning
> different lengths in the kernel vs. userspace?  Whatever the reason, it
> needs to be fixed.

If you used setfattr without \0 for the value at the end, that is
likely the reason. The correct way should be to use chcon.

> The prereqs needed for running the Smack transmute test should not
> prevent running the first test.

Ok.

Thanks

Roberto

