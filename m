Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 405C460F574
	for <lists+linux-integrity@lfdr.de>; Thu, 27 Oct 2022 12:39:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234898AbiJ0Kjo (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 27 Oct 2022 06:39:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235205AbiJ0Kjl (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 27 Oct 2022 06:39:41 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98BB464F8
        for <linux-integrity@vger.kernel.org>; Thu, 27 Oct 2022 03:39:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 53657B82570
        for <linux-integrity@vger.kernel.org>; Thu, 27 Oct 2022 10:39:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F071DC43143
        for <linux-integrity@vger.kernel.org>; Thu, 27 Oct 2022 10:39:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666867172;
        bh=Wfmr4jp4HWW9KkLYlH5RdoT/CI548D6X9rUf/WCpVQg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=oKsgT1PjuIzr/x0ppB0HfU/AtoiNBThShImmM38C5H93pDCWBAbimk9ZdSxe+v1Ao
         c5Za/d03Pe04V0A6ttVg3AQbrDvVHq2DI9aiKLGCYlJ0rbaI3UKLsI604/AuM29vns
         a53S8WjbgDiSJrVGMjyloI8yttBzQoIz1HZKwgjiaEtIFb6o/gtOhaxIMkisAaIH44
         HUxrJfxrb4+O/jCIpxIC+sKyKsIjvcTuuwNMRFtxsCDUQfbysPRgeVMGgjLEiEHcGl
         MW+51kq5URuTrJaRT6sMR7hIqE2JTcPSI4C7ryCUplTQ/3d+cqpMh1s8Yly1cxHHiG
         +HjbAmS8YvrRw==
Received: by mail-lj1-f169.google.com with SMTP id o4so1736193ljp.8
        for <linux-integrity@vger.kernel.org>; Thu, 27 Oct 2022 03:39:31 -0700 (PDT)
X-Gm-Message-State: ACrzQf0Co48qDA2mYotmefuJDMcHnV5IEbV1y3moJA6PE4efr0B5PUtB
        V7k85bZdaF8ovHWYWGYHo/fESqNMJUIMPwBZuaSljg==
X-Google-Smtp-Source: AMsMyM5lSj/2LnLqo7T20znVrmI7UobT8m/3WPr8d4g5QIvgeQkhIyhha+FrrV0RKJldTOKLM0u9mHBI8oYzZVC6HQ8=
X-Received: by 2002:a2e:9107:0:b0:277:2e85:79d4 with SMTP id
 m7-20020a2e9107000000b002772e8579d4mr455368ljg.425.1666867169899; Thu, 27 Oct
 2022 03:39:29 -0700 (PDT)
MIME-Version: 1.0
References: <20221021164626.3729012-1-roberto.sassu@huaweicloud.com>
 <CAADnVQJHDboosqTy5LTHJtJaWJCWn9rv09jmd_sMgeV_OVQjGg@mail.gmail.com>
 <d7a17e482b7bbf945c92443b45de73f56afea08a.camel@huaweicloud.com>
 <bb7a5986f3d25706269d0fec9906ea73c174b808.camel@huaweicloud.com>
 <CAADnVQL1a2pPAJqzj6oUwupxxfaW38KQswzppAZeZPzmTFhjMg@mail.gmail.com>
 <98353f6c82d3dabdb0d434d7ecf0bfc5295015ad.camel@huaweicloud.com>
 <ffbdcfbe-0c63-2ced-62e3-a7248b7a24f0@schaufler-ca.com> <CAADnVQLAXsZRNytPHG0KhYKar3K+=7bq2KPQG77VFOKbnTPHmg@mail.gmail.com>
 <34357c96-fe58-ffe5-e464-4bded8f119d5@huaweicloud.com> <CAADnVQKD5e9vKsSo1TPeBm5hr6j4GzQeHqRURoBJyB++VOwHCw@mail.gmail.com>
In-Reply-To: <CAADnVQKD5e9vKsSo1TPeBm5hr6j4GzQeHqRURoBJyB++VOwHCw@mail.gmail.com>
From:   KP Singh <kpsingh@kernel.org>
Date:   Thu, 27 Oct 2022 12:39:19 +0200
X-Gmail-Original-Message-ID: <CACYkzJ4ak4=qPNQxVckvn3c8CZpXkXSLSyYa_HCU-RJNyuLoZg@mail.gmail.com>
Message-ID: <CACYkzJ4ak4=qPNQxVckvn3c8CZpXkXSLSyYa_HCU-RJNyuLoZg@mail.gmail.com>
Subject: Re: [RFC][PATCH] bpf: Check xattr name/value pair from bpf_lsm_inode_init_security()
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Roberto Sassu <roberto.sassu@huaweicloud.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>,
        Paul Moore <paul@paul-moore.com>,
        James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>, bpf <bpf@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        nicolas.bouchinet@clip-os.org, Mimi Zohar <zohar@linux.ibm.com>,
        linux-integrity <linux-integrity@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, Oct 26, 2022 at 7:14 PM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Wed, Oct 26, 2022 at 1:42 AM Roberto Sassu
> <roberto.sassu@huaweicloud.com> wrote:
> >
> > On 10/26/2022 8:37 AM, Alexei Starovoitov wrote:
> > > On Tue, Oct 25, 2022 at 7:58 AM Casey Schaufler <casey@schaufler-ca.com> wrote:
> > >>
> > >> On 10/25/2022 12:43 AM, Roberto Sassu wrote:
> > >>> On Mon, 2022-10-24 at 19:13 -0700, Alexei Starovoitov wrote:
> > >>>> I'm looking at security_inode_init_security() and it is indeed messy.
> > >>>> Per file system initxattrs callback that processes kmalloc-ed
> > >>>> strings.
> > >>>> Yikes.
> > >>>>
> > >>>> In the short term we should denylist inode_init_security hook to
> > >>>> disallow attaching bpf-lsm there. set/getxattr should be done
> > >>>> through kfuncs instead of such kmalloc-a-string hack.
> > >>> Inode_init_security is an example. It could be that the other hooks are
> > >>> affected too. What happens if they get arbitrary positive values too?
> > >>
> > >> TL;DR - Things will go cattywampus.
> > >>
> > >> The LSM infrastructure is an interface that has "grown organically",
> > >> and isn't necessarily consistent in what it requires of the security
> > >> module implementations. There are cases where it assumes that the
> > >> security module hooks are well behaved, as you've discovered. I have
> > >> no small amount of fear that someone is going to provide an eBPF
> > >> program for security_secid_to_secctx(). There has been an assumption,
> > >> oft stated, that all security modules are going to be reviewed as
> > >> part of the upstream process. The review process ought to catch hooks
> > >> that return unacceptable values. Alas, we've lost that with BPF.
> > >>
> > >> It would take a(nother) major overhaul of the LSM infrastructure to
> > >> make it safe against hooks that are not well behaved. From what I have
> > >> seen so far it wouldn't be easy/convenient/performant to do it in the
> > >> BPF security module either. I personally think that BPF needs to
> > >> ensure that the eBPF implementations don't return inappropriate values,
> > >> but I understand why that is problematic.
> > >
> > > That's an accurate statement. Thank you.
> > >
> > > Going back to the original question...
> > > We fix bugs when we discover them.
> > > Regardless of the subsystem they belong to.
> > > No finger pointing.
> >
> > I'm concerned about the following situation:
> >
> > struct <something> *function()
> > {
> >
> >         ret = security_*();
> >         if (ret)
> >                 return ERR_PTR(ret);
> >
> > }
> >
> > int caller()
> > {
> >         ptr = function()
> >         if (IS_ERR(ptr)
> >                 goto out;
> >
> >         <use of invalid pointer>
> > }
> >
> > I quickly found an occurrence of this:
> >
> > static int lookup_one_common()
> > {
> >
> > [...]
> >
> >         return inode_permission();
> > }
> >
> > struct dentry *try_lookup_one_len()
> > {
> >
> > [...]
> >
> >          err = lookup_one_common(&init_user_ns, name, base, len, &this);
> >          if (err)
> >                  return ERR_PTR(err);
> >
> >
> > Unfortunately, attaching to inode_permission causes the kernel
> > to crash immediately (it does not happen with negative return
> > values).
> >
> > So, I think the fix should be broader, and not limited to the
> > inode_init_security hook. Will try to see how it can be fixed.
>
> I see. Let's restrict bpf-lsm return values to IS_ERR_VALUE.
> Trivial verifier change.

Thanks, yes this indeed is an issue. We need to do a few things:

1. Restrict some hooks that we know the BPF LSM will never need.
2. A verifier function that checks return values of LSM
hooks.
For most LSK hooks IS_ERR_VALUE is fine, however, there are some hooks
like *xattr hooks that use a return value of 1 to indicate a
capability check is required which might need special handling.
