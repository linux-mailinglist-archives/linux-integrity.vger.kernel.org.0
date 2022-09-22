Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95D1C5E6B7F
	for <lists+linux-integrity@lfdr.de>; Thu, 22 Sep 2022 21:08:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232305AbiIVTH7 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 22 Sep 2022 15:07:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232278AbiIVTH6 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 22 Sep 2022 15:07:58 -0400
Received: from mail-oa1-x33.google.com (mail-oa1-x33.google.com [IPv6:2001:4860:4864:20::33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92D4C100A83
        for <linux-integrity@vger.kernel.org>; Thu, 22 Sep 2022 12:07:56 -0700 (PDT)
Received: by mail-oa1-x33.google.com with SMTP id 586e51a60fabf-1280590722dso15307500fac.1
        for <linux-integrity@vger.kernel.org>; Thu, 22 Sep 2022 12:07:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=2E/C7DbYFbgaIr08r5WQJJ8lH65h8Rlpzk3fsg7D9e8=;
        b=Sc2t84MYNifRdpTZz6LHCdTHbGpHtePPoew2qsdF9HHe8gStsU2qKwHjLQmE1+oPPg
         I1EurkRBUsiV216mZSYCjX649kwgi5p9dGPj50oSNxaH8t9N5Lyt/GsKj+zklmLR6qEr
         6R4aHXhiCm/iktm0j/EoGmNd0poPj6lF+d3aisz2dZom3AWJS8ZfcYs8qIfw2l7FOMBe
         HWJ3KinBwLAunUH38CmELQ+uYEnv7YZf9KTUM3+NhHM3aV3rTSVddlmYen3IgFOvDILn
         1pehVy8LfZjvBTsHHkBR3BUiOkMUko7Ppki5o5o9Li47YyyXPlz3/ARUMXM7puPuP26M
         yXxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=2E/C7DbYFbgaIr08r5WQJJ8lH65h8Rlpzk3fsg7D9e8=;
        b=oiYekxF1zSLTlFhtkRIdbLJxmXyraitU9vNlL04V2SS6WUww1spZZRcldTtj4V/3Bj
         /oDX6sdUDEtuTYHGwa1DYg1I4GMHUt6xnsfExulq2pH+H39HNkpmXJCQQ5tuDfiCNt4E
         izSxoOklrUbVTuFzchYaLuT2JzOH2923t3WyDBYpIQdRJX7l1J29QAFEIE+i2TVA6jFh
         /J5z8WtvaNRMeMXoj9kSbIdsJFRDAOv9JqpjCONttZZQTZZH0xS7tDgp4PDx3Qn2S/Qk
         emjoqQE+L3jjHSXzR4ND+NzrBKC7P5TdgRFZsBoc0mlYlFIiaNwjfD262+oCROACVx0l
         gScA==
X-Gm-Message-State: ACrzQf3OGiB5/x2+EyXzo11uXdleA/eVd8CS65CWAQLQsUONQFfhSs/r
        UPuT3k7wkU5TFu2BfssjoUxO/9XaH/scsASCsdrV
X-Google-Smtp-Source: AMsMyM6d9RAgQ5lrUQAwZbu3DJT1/UNg9egieC9LHbxthXW7OebfrM1G5JLCjS1iPUbSyY1utPnUyQOKNNFWojmurr0=
X-Received: by 2002:a05:6870:600c:b0:12d:9e19:9860 with SMTP id
 t12-20020a056870600c00b0012d9e199860mr2966449oaa.172.1663873675323; Thu, 22
 Sep 2022 12:07:55 -0700 (PDT)
MIME-Version: 1.0
References: <20220922151728.1557914-1-brauner@kernel.org> <d74030ae-4b9a-5b39-c203-4b813decd9eb@schaufler-ca.com>
 <CAHk-=whLbq9oX5HDaMpC59qurmwj6geteNcNOtQtb5JN9J0qFw@mail.gmail.com> <16ca7e4c-01df-3585-4334-6be533193ba6@schaufler-ca.com>
In-Reply-To: <16ca7e4c-01df-3585-4334-6be533193ba6@schaufler-ca.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 22 Sep 2022 15:07:44 -0400
Message-ID: <CAHC9VhQRST66pVuNM0WGJsh-W01mDD-bX=GpFxCceUJ1FMWrmg@mail.gmail.com>
Subject: Re: [RFC PATCH 00/29] acl: add vfs posix acl api
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, Seth Forshee <sforshee@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Al Viro <viro@zeniv.linux.org.uk>,
        v9fs-developer@lists.sourceforge.net, linux-cifs@vger.kernel.org,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, Sep 22, 2022 at 2:54 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
> On 9/22/2022 10:57 AM, Linus Torvalds wrote:
> > On Thu, Sep 22, 2022 at 9:27 AM Casey Schaufler <casey@schaufler-ca.com> wrote:
> >> Could we please see the entire patch set on the LSM list?
> > While I don't think that's necessarily wrong, I would like to point
> > out that the gitweb interface actually does make it fairly easy to
> > just see the whole patch-set.
> >
> > IOW, that
> >
> >   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/idmapping.git/log/?h=fs.acl.rework
> >
> > that Christian pointed to is not a horrible way to see it all. Go to
> > the top-most commit, and it's easy to follow the parent links.
>
> I understand that the web interface is fine for browsing the changes.
> It isn't helpful for making comments on the changes. The discussion
> on specific patches (e.g. selinux) may have impact on other parts of
> the system (e.g. integrity) or be relevant elsewhere (e.g. smack). It
> can be a real problem if the higher level mailing list (the LSM list
> in this case) isn't included.

This is probably one of those few cases where Casey and I are in
perfect agreement.  I'd much rather see the patches hit my inbox than
have to go hunting for them and then awkwardly replying to them (and
yes, I know there are ways to do that, I just personally find it
annoying).  I figure we are all deluged with email on a daily basis
and have developed mechanisms to deal with that in a sane way, what is
29 more patches on the pile?

-- 
paul-moore.com
