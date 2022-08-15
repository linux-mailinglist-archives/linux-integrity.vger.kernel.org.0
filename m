Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F2B8594E86
	for <lists+linux-integrity@lfdr.de>; Tue, 16 Aug 2022 04:15:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233410AbiHPCO7 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 15 Aug 2022 22:14:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233397AbiHPCOn (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 15 Aug 2022 22:14:43 -0400
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF6B9124F12
        for <linux-integrity@vger.kernel.org>; Mon, 15 Aug 2022 15:23:26 -0700 (PDT)
Received: by mail-ot1-x32e.google.com with SMTP id q39-20020a056830442700b0063889adc0ddso5443891otv.1
        for <linux-integrity@vger.kernel.org>; Mon, 15 Aug 2022 15:23:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=Od/WtxWU/hG7cayEb9yttUI4uowdTPL5jW1oUuhbz5s=;
        b=Hr6JXMlZM+yAc+MP5E0RxuerjvW4s8BwdySf30VoGpHydf/a9FeScjfvDKFEBhnr3l
         Ok3VBz9nDJQsIM4Gl071nCmBcvPx5rogNqNDNFPg6F4JfwrYFA0UXQqLfyxtTY4f08LQ
         6F6B57mwShKhqAWOcBfRih8tUBo97TO0mV+gkWpM6TpEbm5CGJKygc6FFMjFKqKo8PWy
         ivKeVCWxPH4WmbFR+ci5JPD8SLc21THep1ipA3wDCuiY+W+q1JYBQQDfUWsyTgtY8HRQ
         kfDsoK0+dD4r4KqTCze8kqYtnMIsM0bLLFOSCL+jEZk2ADcoUjotaEdBPfsoQAkeH2eC
         /8Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=Od/WtxWU/hG7cayEb9yttUI4uowdTPL5jW1oUuhbz5s=;
        b=RV4GiNaJWKdn30x8dEpLClDpjulmZ3tfdaoTZFvOfLxn3sTd64nJiquXB1GTlOZRDL
         y3OAw6j2y2vQUeFlasUigKfMSLqi8ic1DF91GUzNsNaHTmDiIsEiqZZPEBBOMaXTpsD2
         4gt1Ze5T7jnEAaRKjljnc6+qLe4+ZHqX7K3zQPPVE6StwxcO/A9l+wjDROIgOstjNgLt
         Ce8LbRsEhnoW0kJyFdrKvKJj6S6IVZZwHNXb3t6+azNCagQcrkJBW4/xgRmSYeS+oJk5
         f1RVegmhWS2ob7CsOMfuj79+LUXod5PPxfrogs/HVLg6Su930vJ3NFkG2gVVfdMVAV2a
         l6UA==
X-Gm-Message-State: ACgBeo2rEwcxDk2jPEBPxKV3GTQipRL8w9AKBp03FG80Qkagvc9KjOtH
        17mSAg0KYP6oqGgg/7cMnSN5o3B59+CfmxVOL8Yr
X-Google-Smtp-Source: AA6agR7xd7aPmm4NRvVn7LlU2oxjvprg18ESlFmKHXayJE24TNjNjTDLJIG6or3DKDB8ksyKUaSTyFn7hok6UFnMEjY=
X-Received: by 2002:a05:6830:449e:b0:638:c72b:68ff with SMTP id
 r30-20020a056830449e00b00638c72b68ffmr565288otv.26.1660602200754; Mon, 15 Aug
 2022 15:23:20 -0700 (PDT)
MIME-Version: 1.0
References: <ffbb5ff1-cec7-3dad-7330-31fdfb67fecc@huawei.com>
 <cc760579-36f4-fe32-3526-bb647efd438c@huawei.com> <CAHC9VhRCt9UKih_VzawKr9dL5oZ7fgOoiU5edLp3hGZ2LkhAYw@mail.gmail.com>
 <649f9797ae80907aa72a8c0418a71df9eacdd1f5.camel@linux.ibm.com>
In-Reply-To: <649f9797ae80907aa72a8c0418a71df9eacdd1f5.camel@linux.ibm.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 15 Aug 2022 18:23:10 -0400
Message-ID: <CAHC9VhTO2YDF8paeYfPDj2aAdiNGCDxziHTY2Sa_5C=yup+P_w@mail.gmail.com>
Subject: Re: Race conditioned discovered between ima_match_rules and ima_update_lsm_update_rules
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     "Guozihua (Scott)" <guozihua@huawei.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        selinux@vger.kernel.org,
        "xiujianfeng@huawei.com" <xiujianfeng@huawei.com>,
        luhuaxin <luhuaxin1@huawei.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Sun, Aug 14, 2022 at 2:30 PM Mimi Zohar <zohar@linux.ibm.com> wrote:
>
> Hi Scott, Paul,
>
> On Tue, 2022-08-09 at 12:24 -0400, Paul Moore wrote:
> > On Sun, Aug 7, 2022 at 11:19 PM Guozihua (Scott) <guozihua@huawei.com> wrote:
> > >
> > > On 2022/8/8 11:02, Guozihua (Scott) wrote:
> > > > Hi Community,
> > > >
> > > > Recently we discovered a race condition while updating SELinux policy
> > > > with IMA lsm rule enabled. Which would lead to extra files being measured.
> > > >
> > > > While SELinux policy is updated, the IDs for object types and such would
> > > > be changed, and ima_lsm_update_rules would be called.
> > > >
> > > > There are no lock applied in ima_lsm_update_rules. If user accesses a
> > > > file during this time, ima_match_rules will be matching rules based on
> > > > old SELinux au_seqno resulting in selinux_audit_rule_match returning
> > > > -ESTALE.
> > > >
> > > > However, in ima_match_rules, this error number is not handled, causing
> > > > IMA to think the LSM rule is also a match, leading to measuring extra
> > > > files.
> >
> > ...
> >
> > > > Is this the intended behavior? Or is it a good idea to add a lock for
> > > > LSM rules during update?
> >
> > I'm not the IMA expert here, but a lot of effort has been into the
> > SELinux code to enable lockless/RCU SELinux policy access and I
> > *really* don't want to have to backtrack on that.
>
> IMA initially updated it's reference to the SELinux label ids lazily.
> More recently IMA refreshes the LSM label ids based on
> register_blocking_lsm_notifier().  As a result of commit 9ad6e9cb39c6
> ("selinux: fix race between old and new sidtab"), -ESTALE is now being
> returned.

To be clear, are you seeing this only started happening after commit
9ad6e9cb39c6?  If that is the case, I would suggest a retry loop
around ima_filter_rule_match() when -ESTALE is returned.  I believe
that should resolve the problem, if not please let us know.

-- 
paul-moore.com
