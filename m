Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 397B95F45BD
	for <lists+linux-integrity@lfdr.de>; Tue,  4 Oct 2022 16:39:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229877AbiJDOj4 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 4 Oct 2022 10:39:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229717AbiJDOjw (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 4 Oct 2022 10:39:52 -0400
X-Greylist: delayed 1177 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 04 Oct 2022 07:39:47 PDT
Received: from frasgout11.his.huawei.com (frasgout11.his.huawei.com [14.137.139.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D7E2DF35
        for <linux-integrity@vger.kernel.org>; Tue,  4 Oct 2022 07:39:45 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.18.147.228])
        by frasgout11.his.huawei.com (SkyGuard) with ESMTP id 4Mhfp3314rz9v7Vl;
        Tue,  4 Oct 2022 22:14:03 +0800 (CST)
Received: from roberto-ThinkStation-P620 (unknown [10.204.63.22])
        by APP1 (Coremail) with SMTP id LxC2BwA3L5MDQTxj4XuZAA--.43765S2;
        Tue, 04 Oct 2022 15:19:53 +0100 (CET)
Message-ID: <f3ec924e5617b78488c51402fe6fdae66d4a41f6.camel@huaweicloud.com>
Subject: Re: [PATCH v5 2/2] ima: Handle -ESTALE returned by
 ima_filter_rule_match()
From:   Roberto Sassu <roberto.sassu@huaweicloud.com>
To:     Mimi Zohar <zohar@linux.ibm.com>,
        "Guozihua (Scott)" <guozihua@huawei.com>,
        dmitry.kasatkin@gmail.com, paul@paul-moore.com, jmorris@namei.org,
        serge@hallyn.com
Cc:     linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Janne Karhunen <janne.karhunen@gmail.com>
Date:   Tue, 04 Oct 2022 16:19:44 +0200
In-Reply-To: <5e304b17fe709d2b2f30b991d5ffc4711d27a075.camel@linux.ibm.com>
References: <20220921125804.59490-1-guozihua@huawei.com>
         <20220921125804.59490-3-guozihua@huawei.com>
         <ce948f9e5639345026679b31a818cc12a247ce60.camel@linux.ibm.com>
         <77c9c86b-85a6-aa87-e084-59a70bb47167@huawei.com>
         <f321c638bf5572088a8c5e4d7027c3a797bdd568.camel@linux.ibm.com>
         <7ac3e330-e77c-95d8-7d3b-29e243b57251@huawei.com>
         <5e304b17fe709d2b2f30b991d5ffc4711d27a075.camel@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: LxC2BwA3L5MDQTxj4XuZAA--.43765S2
X-Coremail-Antispam: 1UD129KBjvdXoWrur1xAFykXF18uw4kur4xtFb_yoWftFg_ur
        ZayFykAw4UJFZ7Ja9xKrWYqrWfKFyj9rn8AryrKwnxJrn5ZF4xWrs5urnFyr4kGa4vq3sx
        Grs7Aa43Awsa9jkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUboxYFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E6xAIw20E
        Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
        A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWUJVWUCwA2z4x0Y4vE2Ix0cI8IcVCY1x02
        67AKxVWUJVW8JwA2z4x0Y4vEx4A2jsIE14v26r4j6F4UM28EF7xvwVC2z280aVCY1x0267
        AKxVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
        x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
        0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_
        Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1V
        AY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAI
        cVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWrZr1j6s0DMI
        IF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCTnI
        WIevJa73UjIFyTuYvjxUrR6zUUUUU
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgAPBF1jj3-SdAABsg
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, 2022-09-28 at 10:11 -0400, Mimi Zohar wrote:
> On Sat, 2022-09-24 at 14:05 +0800, Guozihua (Scott) wrote:
> 
> > I might have overlooked something, but if I understands the code 
> > correctly, we would be copying the same rule over and over again
> > till 
> > the loop ends in that case. ima_lsm_update_rule() would replace the
> > rule 
> > node on the rule list without updating the rule in place. Although 
> > synchronize_rcu() should prevent a UAF, the rule in
> > ima_match_rules() 
> > would not be updated. Meaning SELinux would always return -ESTALE
> > before 
> > we copy and retry as we keep passing in the outdated rule entry.
> 
> After reviewing this patch set again, the code looks fine.  The
> commit
> message is still a bit off, but I've pushed the patch set out to
> next-
> integrity-testing, waiting for some Reviewed-by/Tested-by tags.

The patches look ok for me. For both:

Reviewed-by: Roberto Sassu <roberto.sassu@huawei.com>

Roberto

