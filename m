Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9505602F28
	for <lists+linux-integrity@lfdr.de>; Tue, 18 Oct 2022 17:08:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229919AbiJRPIF (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 18 Oct 2022 11:08:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229775AbiJRPIF (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 18 Oct 2022 11:08:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BF02C3574;
        Tue, 18 Oct 2022 08:08:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CCB9F615AB;
        Tue, 18 Oct 2022 15:08:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47443C433D7;
        Tue, 18 Oct 2022 15:07:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666105683;
        bh=slRde/SJHhsCQe4oq+YTcbRGFc/BuD3pTR0zuPQ4uBQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=In5dBJJEPh+dGa4roXNDd6Xks03NLhpX0J98eVIiyFeZFE6pz6Py0np2joZPVSifI
         ilJvwF7SthyHl3TWhG5QcaqiPe1KK2b8OAeOGvZ9ayA7JevXZYNBtAeOddCv2UmGrY
         cYUvtNVZQNq7sYBBvjTj0I4t/jmsf6gCr6Fh+6o0r9bWEv3QMs9RBAF6DDXUDCFd48
         lRkmi/0tJiV8BUAzu5MpG5GJj2tJILfU9VYievKFzDPoiwEs2k4+vGsmULRpCDWy50
         rU6FOiyggYnTdx6G5BQrNxcRCSOvUEnnV3jkn0cl4WzlIxYSctkt6JSgCGR4e7WhrG
         A7kfJpXKqgzFA==
Date:   Tue, 18 Oct 2022 17:07:51 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        Paul Moore <paul@paul-moore.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>, Borislav Petkov <bp@suse.de>,
        Jonathan McDowell <noodles@fb.com>,
        Takashi Iwai <tiwai@suse.de>, Petr Vorel <pvorel@suse.cz>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>,
        KP Singh <kpsingh@kernel.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        John Johansen <john.johansen@canonical.com>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH 3/9] ima: Move xattr hooks into LSM
Message-ID: <20221018150751.3qsbehcnli4c4g4o@wittgenstein>
References: <20221013222702.never.990-kees@kernel.org>
 <20221013223654.659758-3-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221013223654.659758-3-keescook@chromium.org>
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, Oct 13, 2022 at 03:36:48PM -0700, Kees Cook wrote:
> Move the xattr IMA hooks into normal LSM layer. As with SELinux and
> Smack, handle calling cap_inode_setxattr() internally.
> 
> Cc: Mimi Zohar <zohar@linux.ibm.com>
> Cc: Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
> Cc: Paul Moore <paul@paul-moore.com>
> Cc: James Morris <jmorris@namei.org>
> Cc: "Serge E. Hallyn" <serge@hallyn.com>
> Cc: Borislav Petkov <bp@suse.de>
> Cc: Jonathan McDowell <noodles@fb.com>
> Cc: Takashi Iwai <tiwai@suse.de>
> Cc: Petr Vorel <pvorel@suse.cz>
> Cc: linux-integrity@vger.kernel.org
> Cc: linux-security-module@vger.kernel.org
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---

I like that changes obviously but in general, does IMA depend on being
called _after_ all other LSMs or is this just a historical artifact?
