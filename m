Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 436AF530D55
	for <lists+linux-integrity@lfdr.de>; Mon, 23 May 2022 12:41:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233659AbiEWJ7x (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 23 May 2022 05:59:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233896AbiEWJ7n (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 23 May 2022 05:59:43 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9A34302;
        Mon, 23 May 2022 02:59:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4B213B80EB4;
        Mon, 23 May 2022 09:59:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3167EC385A9;
        Mon, 23 May 2022 09:59:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653299980;
        bh=xllwVvxa/zTtheTg1NgvcRi8ov009dxPWjGecps7DxQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZMsleth+k/LOoxGbiXcaxOHO+9D6U34bsUs9u5/aMf2p6dnxKzdct9/HgpUY0T4O3
         ExSE2uCr5FiVOsPTd35IsQ4JX61K+3o7pHUr/BH3EEyGGz8xCMVjalqATVv4R+MXTl
         U2MWwKxAJlhPkA+wDA9SUgMIHeGFLDePTrLJA/EjIr+85KaQtbqDKOqNcXqlrZ93Xf
         xEbay21Gvn7rGNVRXOLysSpQkGc2kbZ/CKDXHQPzenFPTLwXIM2gZCDjiuBprxCOib
         gsKoXAOQJH64+0BxUss5Mcd/Y0uCr60xi2frtgkZATuzvTB0ix/ltJHrC5wNuc4ZSx
         Yf3YD/VNhcOow==
Date:   Mon, 23 May 2022 11:59:32 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     "Serge E. Hallyn" <serge@hallyn.com>
Cc:     Stefan Berger <stefanb@linux.ibm.com>,
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
Message-ID: <20220523095932.adr2r26o2obch4r5@wittgenstein>
References: <20220420140633.753772-1-stefanb@linux.ibm.com>
 <20220420140633.753772-14-stefanb@linux.ibm.com>
 <20220522182426.GA24765@mail.hallyn.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220522182426.GA24765@mail.hallyn.com>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Sun, May 22, 2022 at 01:24:26PM -0500, Serge Hallyn wrote:
> On Wed, Apr 20, 2022 at 10:06:20AM -0400, Stefan Berger wrote:
> > Add a pointer to ima_namespace to the user_namespace and initialize
> > the init_user_ns with a pointer to init_ima_ns. We need a pointer from
> > the user namespace to its associated IMA namespace since IMA namespaces
> > are piggybacking on user namespaces.
> > 
> > Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
> > Acked-by: Christian Brauner <brauner@kernel.org>
> > Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
> > 
> > ---
> > v11:
> >  - Added lost A-b from Christian back
> >  - Added sentence to patch description explaining why we need the pointer
> > 
> > v9:
> >  - Deferred implementation of ima_ns_from_user_ns() to later patch
> > ---
> >  include/linux/ima.h            | 2 ++
> >  include/linux/user_namespace.h | 4 ++++
> >  kernel/user.c                  | 4 ++++
> >  3 files changed, 10 insertions(+)
> > 
> > diff --git a/include/linux/ima.h b/include/linux/ima.h
> > index 426b1744215e..fcb60a44e05f 100644
> > --- a/include/linux/ima.h
> > +++ b/include/linux/ima.h
> > @@ -14,6 +14,8 @@
> >  #include <crypto/hash_info.h>
> >  struct linux_binprm;
> >  
> > +extern struct ima_namespace init_ima_ns;
> > +
> >  #ifdef CONFIG_IMA
> >  extern enum hash_algo ima_get_current_hash_algo(void);
> >  extern int ima_bprm_check(struct linux_binprm *bprm);
> > diff --git a/include/linux/user_namespace.h b/include/linux/user_namespace.h
> > index 33a4240e6a6f..019e8cf7b633 100644
> > --- a/include/linux/user_namespace.h
> > +++ b/include/linux/user_namespace.h
> > @@ -36,6 +36,7 @@ struct uid_gid_map { /* 64 bytes -- 1 cache line */
> >  #define USERNS_INIT_FLAGS USERNS_SETGROUPS_ALLOWED
> >  
> >  struct ucounts;
> > +struct ima_namespace;
> >  
> >  enum ucount_type {
> >  	UCOUNT_USER_NAMESPACES,
> > @@ -99,6 +100,9 @@ struct user_namespace {
> >  #endif
> >  	struct ucounts		*ucounts;
> >  	long ucount_max[UCOUNT_COUNTS];
> > +#ifdef CONFIG_IMA_NS
> 
> It's probably worth putting a comment here saying that user_ns does not
> pin ima_ns.
> 
> That the only time the ima_ns will be freed is when user_ns is freed,
> and only time it will be changed is when user_ns is freed, or during
> ima_fs_ns_init() (under smp_load_acquire) during a new mount.
> 
> > +	struct ima_namespace	*ima_ns;
> 
> So, if I create a new user_ns with a new ima_ns, and in there I
> create a new user_ns again, it looks like ima_ns will be NULL in
> the new user_ns?  Should it not be set to the parent->ima_ns?
> (which would cause trouble for the way it's currently being
> freed...)

Would also work and wouldn't be difficult to do imho.
