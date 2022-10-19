Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF572603A33
	for <lists+linux-integrity@lfdr.de>; Wed, 19 Oct 2022 08:56:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229645AbiJSG4i (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 19 Oct 2022 02:56:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbiJSG4h (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 19 Oct 2022 02:56:37 -0400
Received: from frasgout13.his.huawei.com (frasgout13.his.huawei.com [14.137.139.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ACBB74E00;
        Tue, 18 Oct 2022 23:56:36 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.18.147.227])
        by frasgout13.his.huawei.com (SkyGuard) with ESMTP id 4MshF607dCz9xrq3;
        Wed, 19 Oct 2022 14:50:18 +0800 (CST)
Received: from roberto-ThinkStation-P620 (unknown [10.204.63.22])
        by APP2 (Coremail) with SMTP id GxC2BwAnrgR5n09jwF4JAA--.26227S2;
        Wed, 19 Oct 2022 07:56:04 +0100 (CET)
Message-ID: <00bf4f189e4ec3b98130451f40e77ead8f28179e.camel@huaweicloud.com>
Subject: Re: [PATCH 4/9] ima: Move ima_file_free() into LSM
From:   Roberto Sassu <roberto.sassu@huaweicloud.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Christian Brauner <brauner@kernel.org>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        Paul Moore <paul@paul-moore.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>, Petr Vorel <pvorel@suse.cz>,
        Jonathan McDowell <noodles@fb.com>,
        Borislav Petkov <bp@suse.de>, Takashi Iwai <tiwai@suse.de>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        =?ISO-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
        KP Singh <kpsingh@kernel.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        John Johansen <john.johansen@canonical.com>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Date:   Wed, 19 Oct 2022 08:55:49 +0200
In-Reply-To: <202210181126.E58AB4A0F@keescook>
References: <20221013222702.never.990-kees@kernel.org>
         <20221013223654.659758-4-keescook@chromium.org>
         <20221018150213.7n4sv7rtsh6lshd5@wittgenstein>
         <1b41c633bbd31b82b02fdbae718f2f11ac862181.camel@huaweicloud.com>
         <202210181126.E58AB4A0F@keescook>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: GxC2BwAnrgR5n09jwF4JAA--.26227S2
X-Coremail-Antispam: 1UD129KBjvdXoWrZr4ktw48CFyDGr13Aw1DWrg_yoWfXFb_GF
        WjyrZ2yFn8JF1kKanavFW3Gr4DWrWUXr4Yvw4fJrnxZw4Svw47XFs7CF93C3WrJw4av3Zx
        Ja4avayxta17tjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUb78YFVCjjxCrM7AC8VAFwI0_Xr0_Wr1l1xkIjI8I6I8E6xAIw20E
        Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
        A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWUJVWUCwA2z4x0Y4vE2Ix0cI8IcVCY1x02
        67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIE14v26r1j6r4UM28EF7xvwVC2z280aVCY1x0267
        AKxVW8JVW8Jr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2
        j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7x
        kEbVWUJVW8JwACjcxG0xvEwIxGrwACI402YVCY1x02628vn2kIc2xKxwCF04k20xvY0x0E
        wIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E74
        80Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIxAIcVC0
        I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04
        k26cxKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY
        1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU13rcDUUUUU==
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQAKBF1jj4RlmgAAsF
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, 2022-10-18 at 11:29 -0700, Kees Cook wrote:
> On Tue, Oct 18, 2022 at 05:32:40PM +0200, Roberto Sassu wrote:
> > I also did this work before. In my implementation, I created a new
> > security hook called security_file_pre_free().
> > 
> > https://github.com/robertosassu/linux/commit/692c9d36fff865435b23b3cb765d31f3584f6263
> > 
> > If useful, the whole patch set is available at:
> > 
> > https://github.com/robertosassu/linux/commits/ima-evm-lsm-v1-devel-v3
> 
> Ah, lovely! Can you pick this back up and run with it? I mainly did
> these a proof-of-concept, but it looks like you got further.

It was some time ago. If I remember correctly, I got to the point of
running IMA/EVM and passing basic tests.

Will take a look at your patches and comments, and integrate in mines
if something is missing.

Will also send again the prerequisite patch set.

Roberto

