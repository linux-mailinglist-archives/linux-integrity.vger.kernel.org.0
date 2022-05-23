Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DB0753149B
	for <lists+linux-integrity@lfdr.de>; Mon, 23 May 2022 18:25:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237000AbiEWOZG (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 23 May 2022 10:25:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237080AbiEWOZG (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 23 May 2022 10:25:06 -0400
Received: from mail.hallyn.com (mail.hallyn.com [178.63.66.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D927580C8;
        Mon, 23 May 2022 07:25:02 -0700 (PDT)
Received: by mail.hallyn.com (Postfix, from userid 1001)
        id 609E07DD; Mon, 23 May 2022 09:25:00 -0500 (CDT)
Date:   Mon, 23 May 2022 09:25:00 -0500
From:   "Serge E. Hallyn" <serge@hallyn.com>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Stefan Berger <stefanb@linux.ibm.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
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
Message-ID: <20220523142500.GA1599@mail.hallyn.com>
References: <20220420140633.753772-1-stefanb@linux.ibm.com>
 <20220420140633.753772-14-stefanb@linux.ibm.com>
 <20220522182426.GA24765@mail.hallyn.com>
 <20220523095932.adr2r26o2obch4r5@wittgenstein>
 <e1df20d5-a6c9-d30c-3671-46f7a8742bc0@linux.ibm.com>
 <20220523124159.zsbp2gonh2dum4jm@wittgenstein>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220523124159.zsbp2gonh2dum4jm@wittgenstein>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, May 23, 2022 at 02:41:59PM +0200, Christian Brauner wrote:
> On Mon, May 23, 2022 at 07:31:29AM -0400, Stefan Berger wrote:
> > 
> > 
> > On 5/23/22 05:59, Christian Brauner wrote:
> > > On Sun, May 22, 2022 at 01:24:26PM -0500, Serge Hallyn wrote:
> > > > On Wed, Apr 20, 2022 at 10:06:20AM -0400, Stefan Berger wrote:
> > > > > Add a pointer to ima_namespace to the user_namespace and initialize
> > > > > the init_user_ns with a pointer to init_ima_ns. We need a pointer from
> > > > > the user namespace to its associated IMA namespace since IMA namespaces
> > > > > are piggybacking on user namespaces.
> > > > > 
> > > > > Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
> > > > > Acked-by: Christian Brauner <brauner@kernel.org>
> > > > > Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
> > > > > 
> > > > > ---
> > > > > v11:
> > > > >   - Added lost A-b from Christian back
> > > > >   - Added sentence to patch description explaining why we need the pointer
> > > > > 
> > > > > v9:
> > > > >   - Deferred implementation of ima_ns_from_user_ns() to later patch
> > > > > ---
> > > > >   include/linux/ima.h            | 2 ++
> > > > >   include/linux/user_namespace.h | 4 ++++
> > > > >   kernel/user.c                  | 4 ++++
> > > > >   3 files changed, 10 insertions(+)
> > > > > 
> > > > > diff --git a/include/linux/ima.h b/include/linux/ima.h
> > > > > index 426b1744215e..fcb60a44e05f 100644
> > > > > --- a/include/linux/ima.h
> > > > > +++ b/include/linux/ima.h
> > > > > @@ -14,6 +14,8 @@
> > > > >   #include <crypto/hash_info.h>
> > > > >   struct linux_binprm;
> > > > > +extern struct ima_namespace init_ima_ns;
> > > > > +
> > > > >   #ifdef CONFIG_IMA
> > > > >   extern enum hash_algo ima_get_current_hash_algo(void);
> > > > >   extern int ima_bprm_check(struct linux_binprm *bprm);
> > > > > diff --git a/include/linux/user_namespace.h b/include/linux/user_namespace.h
> > > > > index 33a4240e6a6f..019e8cf7b633 100644
> > > > > --- a/include/linux/user_namespace.h
> > > > > +++ b/include/linux/user_namespace.h
> > > > > @@ -36,6 +36,7 @@ struct uid_gid_map { /* 64 bytes -- 1 cache line */
> > > > >   #define USERNS_INIT_FLAGS USERNS_SETGROUPS_ALLOWED
> > > > >   struct ucounts;
> > > > > +struct ima_namespace;
> > > > >   enum ucount_type {
> > > > >   	UCOUNT_USER_NAMESPACES,
> > > > > @@ -99,6 +100,9 @@ struct user_namespace {
> > > > >   #endif
> > > > >   	struct ucounts		*ucounts;
> > > > >   	long ucount_max[UCOUNT_COUNTS];
> > > > > +#ifdef CONFIG_IMA_NS
> > > > 
> > > > It's probably worth putting a comment here saying that user_ns does not
> > > > pin ima_ns.
> > > > 
> > > > That the only time the ima_ns will be freed is when user_ns is freed,
> > > > and only time it will be changed is when user_ns is freed, or during
> > > > ima_fs_ns_init() (under smp_load_acquire) during a new mount.
> > > > 
> > > > > +	struct ima_namespace	*ima_ns;
> > > > 
> > > > So, if I create a new user_ns with a new ima_ns, and in there I
> > > > create a new user_ns again, it looks like ima_ns will be NULL in
> > > > the new user_ns?  Should it not be set to the parent->ima_ns?
> > > > (which would cause trouble for the way it's currently being
> > > > freed...)
> > > 
> > > Would also work and wouldn't be difficult to do imho.
> > 
> > We previously decide to create an ima_namespace when securityfs is mounted.
> > This now also applies to nested containers where an IMA namespace is first
> > configured with the hash and template to use in a particular container and
> > then activated. If no configuration is done it will inherit the hash and
> > template from the first ancestor that has been configure when it is
> > activated. So the same steps and behavior applies to *all* containers, no
> > difference at any depth of nesting. Besides that, we don't want nested
> > containers to share policy and logs but keep them isolated from each other,
> > or do we not?
> > 
> > Further, how should it work if we were to apply this even to the first
> > container? Should it just inherit the &init_ima_namespace and we'd have no
> > isolation at all? Why would we start treating containers at deeper nesting
> > levels differently?
> 
> Valid points. I understood Serge as suggesting an implementation detail
> change not a design change but might misunderstand him here.
> 
> # Currently
> 
> 1. create new userns -> imans set to NULL
> 2. mount securityfs and configure imans -> set imans to &new_ima_ns
> 
> When 2. hasn't been done then we find the relevant imans by walking
> the userns hierarchy upwards finding the first parent userns that has a
> non-NULL imans.

Ah, right, thanks Christian.

But so the code - I think where the ima_ns is defined in the user_ns
struct, needs to make this clear.  Just something like

	// Pointer to ima_ns which this user_ns created.  Can be null.
	// Access checks will walk the userns->parent chain and check
	// against all active ima_ns's.  Note that when the user_ns is
	// freed, the ima_ns is guaranteed to be free-able.
	struct ima_namespace	*ima_ns;

> # Serge's suggestion
> 
> 1. create new userns -> imans is set to parent imans
> 2. mount securityfs and configure imans -> replace parent with &new_ima_ns
> 
> So when 2. hasn't been done we don't need to walk the userns hierarchy
> upwards. We always find the relevant imans directly. Some massaging
> would be needed in process_measurement() probably but it wouldn't need
> to change semantics per se.
> 
> But I think I misunderstood something in any case. So looking at an
> example like ima_post_path_mknod(). You seem to not call into
> ima_must_appraise() if the caller's userns doesn't have an imans
> enabled. I somehow had thought that the same logic applied as in
> process_measurement. But if it isn't then it might make sense to keep
> the current implementation.
