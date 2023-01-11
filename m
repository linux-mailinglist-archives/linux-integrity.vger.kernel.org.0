Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58F72665DDE
	for <lists+linux-integrity@lfdr.de>; Wed, 11 Jan 2023 15:28:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238831AbjAKO2R (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 11 Jan 2023 09:28:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239539AbjAKO1l (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 11 Jan 2023 09:27:41 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8BA01EC4B
        for <linux-integrity@vger.kernel.org>; Wed, 11 Jan 2023 06:26:08 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id z4-20020a17090a170400b00226d331390cso17330140pjd.5
        for <linux-integrity@vger.kernel.org>; Wed, 11 Jan 2023 06:26:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=j0t2bn4nZtdh7DYNiHghgOiJ5/dQ9do1qFUNd17Ho0Q=;
        b=Gy4Mryka1zuuoKtaVN8MVkw7dRGJo1zKk8dXXcAaFhsufGRUkcyaoY9eEylCpjBRoA
         tc9oSd+PPBOUqYbDEv3hZKPjcdo0RESO3HlfLycCfVqINLxYWX90Pw0nnC0gLLS1Lkcr
         c8EEaRcUHhd+/RBgerhwWCc2y/KbqpucELD83s89s40YDId/3CuVFxAqasNQJAzY7rz/
         zZJCROGm5h4+YlAL9YviW/7Oor0mkuUi8vKBd09fFQtcmcO3oAAcpRX3XABhJr5a0NdI
         jU4Cbvcyh3hhX0Q3f8XfLMU5lGqBjEtJ7/dRxSIgdJBHr4XdJio8fEs7VP7qh0EOLd9l
         g5pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=j0t2bn4nZtdh7DYNiHghgOiJ5/dQ9do1qFUNd17Ho0Q=;
        b=o1OV+/EmD+8F9+wOrZN7hJ3AJV4kVosjoWBBD0/ezbIBLpaWRdipVX0Gdi+A4F0YfL
         VT7ANXd7LiRItPOiQVQIUINxLOaXL64y5MVnm3pKMz124khnDpaHrx/o0f7TiCAQ65A4
         6ymwKv2SIXaBHyXA41BMXaRYKhT/tlcF4dcoGEBf3XlDJRZk6HBhv7wc6FFsLheDJ0pQ
         DgeszAE3x3JZxGvkf2hJpIzlNSH6NcW8PLErXdomy8KKbEqy/vu1DnWqdP0GDi1wCcZb
         4bRAput9SO116DZAXe94Mh90Vp2z5DA4Ff/Z2STEqYjIv7pmM/oH9RmAyXAf6xkTfmdA
         J1nw==
X-Gm-Message-State: AFqh2krXclOsAC5xqwvkwKCQM5MIgm0gqCi0wZxYfBMxaUNjXYB070UI
        C6N03jSUdgfb8Pn91M2vc1OEgVH5yDRb6hm0KU7V
X-Google-Smtp-Source: AMrXdXtesEwVv45pauhHUrlC1hMdCovkRhk98mmpCmIArBxsYtbrASQb9FOY34shKM97pdStAwTTTawAfp1LlKVzuZY=
X-Received: by 2002:a17:902:7d83:b0:193:2c1b:3371 with SMTP id
 a3-20020a1709027d8300b001932c1b3371mr1314817plm.56.1673447168187; Wed, 11 Jan
 2023 06:26:08 -0800 (PST)
MIME-Version: 1.0
References: <20221221141007.2579770-1-roberto.sassu@huaweicloud.com>
 <CAHC9VhQUAuF-Fan72j7BOqOdLE=B=mJpJ_GpR5p5cUmXruYT=Q@mail.gmail.com> <4b8688ee3d533d989196004d5f9f2c7eb4093f8b.camel@huaweicloud.com>
In-Reply-To: <4b8688ee3d533d989196004d5f9f2c7eb4093f8b.camel@huaweicloud.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 11 Jan 2023 09:25:56 -0500
Message-ID: <CAHC9VhSamRVpgrDrSuc2dsbbw3-pvjDi9BsFWoWssHkAD2W5vA@mail.gmail.com>
Subject: Re: [PATCH v2] security: Restore passing final prot to ima_file_mmap()
To:     Roberto Sassu <roberto.sassu@huaweicloud.com>
Cc:     zohar@linux.ibm.com, jmorris@namei.org, serge@hallyn.com,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, viro@zeniv.linux.org.uk,
        Roberto Sassu <roberto.sassu@huawei.com>,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, Jan 11, 2023 at 4:31 AM Roberto Sassu
<roberto.sassu@huaweicloud.com> wrote:
> On Fri, 2023-01-06 at 16:14 -0500, Paul Moore wrote:
> > On Wed, Dec 21, 2022 at 9:10 AM Roberto Sassu
> > <roberto.sassu@huaweicloud.com> wrote:
> > > From: Roberto Sassu <roberto.sassu@huawei.com>
> > >
> > > Commit 98de59bfe4b2f ("take calculation of final prot in
> > > security_mmap_file() into a helper") moved the code to update prot with the
> > > actual protection flags to be granted to the requestor by the kernel to a
> > > helper called mmap_prot(). However, the patch didn't update the argument
> > > passed to ima_file_mmap(), making it receive the requested prot instead of
> > > the final computed prot.
> > >
> > > A possible consequence is that files mmapped as executable might not be
> > > measured/appraised if PROT_EXEC is not requested but subsequently added in
> > > the final prot.
> > >
> > > Replace prot with mmap_prot(file, prot) as the second argument of
> > > ima_file_mmap() to restore the original behavior.
> > >
> > > Cc: stable@vger.kernel.org
> > > Fixes: 98de59bfe4b2 ("take calculation of final prot in security_mmap_file() into a helper")
> > > Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> > > ---
> > >  security/security.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/security/security.c b/security/security.c
> > > index d1571900a8c7..0d2359d588a1 100644
> > > --- a/security/security.c
> > > +++ b/security/security.c
> > > @@ -1666,7 +1666,7 @@ int security_mmap_file(struct file *file, unsigned long prot,
> > >                                         mmap_prot(file, prot), flags);
> > >         if (ret)
> > >                 return ret;
> > > -       return ima_file_mmap(file, prot);
> > > +       return ima_file_mmap(file, mmap_prot(file, prot));
> > >  }
> >
> > This seems like a reasonable fix, although as the original commit is
> > ~10 years old at this point I am a little concerned about the impact
> > this might have on IMA.  Mimi, what do you think?
> >
> > Beyond that, my only other comment would be to only call mmap_prot()
> > once and cache the results in a local variable.  You could also fix up
> > some of the ugly indentation crimes in security_mmap_file() while you
> > are at it, e.g. something like this:
>
> Hi Paul
>
> thanks for the comments. With the patch set to move IMA and EVM to the
> LSM infrastructure we will be back to calling mmap_prot() only once,
> but I guess we could do anyway, as the patch (if accepted) would be
> likely backported to stable kernels.

I think there is value in fixing this now and keeping it separate from
the IMA-to-LSM work as they really are disjoint.

-- 
paul-moore.com
