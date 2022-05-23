Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FDC453107B
	for <lists+linux-integrity@lfdr.de>; Mon, 23 May 2022 15:20:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235593AbiEWMmK (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 23 May 2022 08:42:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235586AbiEWMmJ (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 23 May 2022 08:42:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6266011C23;
        Mon, 23 May 2022 05:42:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E521E61319;
        Mon, 23 May 2022 12:42:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76ABEC385AA;
        Mon, 23 May 2022 12:42:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653309727;
        bh=9lBIyTSOtY/yGLBODsoRnmVV+xqjg/4hX6o/WsAsCfc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ugvrIskpD7GM77Xnwf1rnAE8Dktxpjw87tjSywen6XLTPqn6muwiNFtD3bT8BI5vt
         yTDPvCx+UEjvPNIMCl1p3HEIG6SLOw/wBZjMCtzhbxjDVe9+zC0fbt1ey5ZAts9eAP
         /eDtjE/fKMPODYfXy837+S2Q+wwYLmT84alBFm23TuPm5jEISv7/kXepCnJGJtUREG
         uqRP5hORcfKLlGSN7DLbd3pi5nshsuXS9tnnESPhR+ciDaBPrn326XfgW0PJG4kWpB
         /hagaYmSM+RWhqq47CC+sfzszZ91rHfsqBoZ5YEvXemzv6qM1hbU6yQJqW/Jl3Zakd
         2zucgZznTZ3xw==
Date:   Mon, 23 May 2022 14:41:59 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Stefan Berger <stefanb@linux.ibm.com>
Cc:     "Serge E. Hallyn" <serge@hallyn.com>,
        linux-integrity@vger.kernel.org, zohar@linux.ibm.com,
        christian.brauner@ubuntu.com, containers@lists.linux.dev,
        dmitry.kasatkin@gmail.com, ebiederm@xmission.com,
        krzysztof.struczynski@huawei.com, roberto.sassu@huawei.com,
        mpeters@redhat.com, lhinds@redhat.com, lsturman@redhat.com,
        puiterwi@redhat.com, jejb@linux.ibm.com, jamjoom@us.ibm.com,
        linux-kernel@vger.kernel.org, paul@paul-moore.com, rgb@redhat.com,
        linux-security-module@vger.kernel.org, jmorris@namei.org,
        jpenumak@redhat.com
Subject: Re: [PATCH v12 13/26] userns: Add pointer to ima_namespace to
 user_namespace
Message-ID: <20220523124159.zsbp2gonh2dum4jm@wittgenstein>
References: <20220420140633.753772-1-stefanb@linux.ibm.com>
 <20220420140633.753772-14-stefanb@linux.ibm.com>
 <20220522182426.GA24765@mail.hallyn.com>
 <20220523095932.adr2r26o2obch4r5@wittgenstein>
 <e1df20d5-a6c9-d30c-3671-46f7a8742bc0@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e1df20d5-a6c9-d30c-3671-46f7a8742bc0@linux.ibm.com>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, May 23, 2022 at 07:31:29AM -0400, Stefan Berger wrote:
> 
> 
> On 5/23/22 05:59, Christian Brauner wrote:
> > On Sun, May 22, 2022 at 01:24:26PM -0500, Serge Hallyn wrote:
> > > On Wed, Apr 20, 2022 at 10:06:20AM -0400, Stefan Berger wrote:
> > > > Add a pointer to ima_namespace to the user_namespace and initialize
> > > > the init_user_ns with a pointer to init_ima_ns. We need a pointer from
> > > > the user namespace to its associated IMA namespace since IMA namespaces
> > > > are piggybacking on user namespaces.
> > > > 
> > > > Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
> > > > Acked-by: Christian Brauner <brauner@kernel.org>
> > > > Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
> > > > 
> > > > ---
> > > > v11:
> > > >   - Added lost A-b from Christian back
> > > >   - Added sentence to patch description explaining why we need the pointer
> > > > 
> > > > v9:
> > > >   - Deferred implementation of ima_ns_from_user_ns() to later patch
> > > > ---
> > > >   include/linux/ima.h            | 2 ++
> > > >   include/linux/user_namespace.h | 4 ++++
> > > >   kernel/user.c                  | 4 ++++
> > > >   3 files changed, 10 insertions(+)
> > > > 
> > > > diff --git a/include/linux/ima.h b/include/linux/ima.h
> > > > index 426b1744215e..fcb60a44e05f 100644
> > > > --- a/include/linux/ima.h
> > > > +++ b/include/linux/ima.h
> > > > @@ -14,6 +14,8 @@
> > > >   #include <crypto/hash_info.h>
> > > >   struct linux_binprm;
> > > > +extern struct ima_namespace init_ima_ns;
> > > > +
> > > >   #ifdef CONFIG_IMA
> > > >   extern enum hash_algo ima_get_current_hash_algo(void);
> > > >   extern int ima_bprm_check(struct linux_binprm *bprm);
> > > > diff --git a/include/linux/user_namespace.h b/include/linux/user_namespace.h
> > > > index 33a4240e6a6f..019e8cf7b633 100644
> > > > --- a/include/linux/user_namespace.h
> > > > +++ b/include/linux/user_namespace.h
> > > > @@ -36,6 +36,7 @@ struct uid_gid_map { /* 64 bytes -- 1 cache line */
> > > >   #define USERNS_INIT_FLAGS USERNS_SETGROUPS_ALLOWED
> > > >   struct ucounts;
> > > > +struct ima_namespace;
> > > >   enum ucount_type {
> > > >   	UCOUNT_USER_NAMESPACES,
> > > > @@ -99,6 +100,9 @@ struct user_namespace {
> > > >   #endif
> > > >   	struct ucounts		*ucounts;
> > > >   	long ucount_max[UCOUNT_COUNTS];
> > > > +#ifdef CONFIG_IMA_NS
> > > 
> > > It's probably worth putting a comment here saying that user_ns does not
> > > pin ima_ns.
> > > 
> > > That the only time the ima_ns will be freed is when user_ns is freed,
> > > and only time it will be changed is when user_ns is freed, or during
> > > ima_fs_ns_init() (under smp_load_acquire) during a new mount.
> > > 
> > > > +	struct ima_namespace	*ima_ns;
> > > 
> > > So, if I create a new user_ns with a new ima_ns, and in there I
> > > create a new user_ns again, it looks like ima_ns will be NULL in
> > > the new user_ns?  Should it not be set to the parent->ima_ns?
> > > (which would cause trouble for the way it's currently being
> > > freed...)
> > 
> > Would also work and wouldn't be difficult to do imho.
> 
> We previously decide to create an ima_namespace when securityfs is mounted.
> This now also applies to nested containers where an IMA namespace is first
> configured with the hash and template to use in a particular container and
> then activated. If no configuration is done it will inherit the hash and
> template from the first ancestor that has been configure when it is
> activated. So the same steps and behavior applies to *all* containers, no
> difference at any depth of nesting. Besides that, we don't want nested
> containers to share policy and logs but keep them isolated from each other,
> or do we not?
> 
> Further, how should it work if we were to apply this even to the first
> container? Should it just inherit the &init_ima_namespace and we'd have no
> isolation at all? Why would we start treating containers at deeper nesting
> levels differently?

Valid points. I understood Serge as suggesting an implementation detail
change not a design change but might misunderstand him here.

# Currently

1. create new userns -> imans set to NULL
2. mount securityfs and configure imans -> set imans to &new_ima_ns

When 2. hasn't been done then we find the relevant imans by walking
the userns hierarchy upwards finding the first parent userns that has a
non-NULL imans.

# Serge's suggestion

1. create new userns -> imans is set to parent imans
2. mount securityfs and configure imans -> replace parent with &new_ima_ns

So when 2. hasn't been done we don't need to walk the userns hierarchy
upwards. We always find the relevant imans directly. Some massaging
would be needed in process_measurement() probably but it wouldn't need
to change semantics per se.

But I think I misunderstood something in any case. So looking at an
example like ima_post_path_mknod(). You seem to not call into
ima_must_appraise() if the caller's userns doesn't have an imans
enabled. I somehow had thought that the same logic applied as in
process_measurement. But if it isn't then it might make sense to keep
the current implementation.
