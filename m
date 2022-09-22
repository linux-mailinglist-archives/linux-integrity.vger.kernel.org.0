Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0A135E6946
	for <lists+linux-integrity@lfdr.de>; Thu, 22 Sep 2022 19:13:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231853AbiIVRNF (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 22 Sep 2022 13:13:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231715AbiIVRNE (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 22 Sep 2022 13:13:04 -0400
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3148F85AB
        for <linux-integrity@vger.kernel.org>; Thu, 22 Sep 2022 10:13:02 -0700 (PDT)
Received: by mail-oi1-x234.google.com with SMTP id m81so13223354oia.1
        for <linux-integrity@vger.kernel.org>; Thu, 22 Sep 2022 10:13:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=E+TB2xzVAtYs6oaIse1U5u4O3jFfIFDg2n9/h4J23mQ=;
        b=hZwYPcIhPeAjNOgItciD6P9tQ2CqjPnqBrXDktESEwoXCcVDeVfNPsErYWqpWrsniG
         emJGQAVsUQAWy6njKsrQ2VUhs9vgoM7JyAMz0gUPIMI9SekHZnEHQdrnzurl63Jdjzjq
         M0L6ts87GZvSQcU6DthLVlAn+RbgpF6sLcPB3dvkGg+CB+7znpVOhPoVoM+BjrAt530W
         UNYv7/J8TnX5H7T8Ea00pVmC2dCCBodKY0KE2dSHDTYxB0oRqYYYBeWWxxZpJNOIQTWV
         P9amwW24/C/svcfizPh4Hy+/rQzaJjh/LSCcKk1XXBjC+2XxzEqvo7gu82fGu7R2xntH
         g2Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=E+TB2xzVAtYs6oaIse1U5u4O3jFfIFDg2n9/h4J23mQ=;
        b=KTnqWSaIhQ0JC1QOyR3sbw0WfqHk++gyyuNSeMskU/OnqJUfhaQaczVBajNayrvTxd
         /UKbMMiF59KrUFy3u3NjhrSBFQObDrkTlSw9cSwdgXMLGNJDFWl/zyIfJ5l31S3xXg54
         Rx9XtAtj7+RvXyAvaUOE5fk1ocj6jo6lzGfiOu9NJFsZe+Jd7Ni8cPMtNwwYMsVaIgQY
         GrcR78Ei6aLvupCKHd0Qq/XhixW2K40CrR2gn/xj5CBz/HcLyqFOaEoqNqrJOPf/Z4Vd
         hCZQFMnUeeTwDK2iApknhiXIj7bga0qh9rWACGzHc5vxJ3LoXyIpKkVb58qjySmcZVOP
         /uTQ==
X-Gm-Message-State: ACrzQf3VjzdqqFuWRL/h0C2QOQX9DF2OYxPXvNVUklQqcErWcrTIlGgE
        Vn77NfmKqVPJrBzA7jCArRUTRnQz9RynSUK6KdMFFTzV4g==
X-Google-Smtp-Source: AMsMyM7Kcj4ytM/Duu+9JyKTa042/nUxS8fy5KKBHgIY9wFm1ChYMIJYieo4kz+flxi9gRCBYGjfeh14xGVJrgDj2zo=
X-Received: by 2002:a05:6808:144b:b0:350:a06a:f8cb with SMTP id
 x11-20020a056808144b00b00350a06af8cbmr6995563oiv.51.1663866782132; Thu, 22
 Sep 2022 10:13:02 -0700 (PDT)
MIME-Version: 1.0
References: <20220922151728.1557914-1-brauner@kernel.org> <d74030ae-4b9a-5b39-c203-4b813decd9eb@schaufler-ca.com>
In-Reply-To: <d74030ae-4b9a-5b39-c203-4b813decd9eb@schaufler-ca.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 22 Sep 2022 13:12:51 -0400
Message-ID: <CAHC9VhRnztLTg=YbavwCdY6PZKDppwzybTOpDmsCRmrxnQjz_g@mail.gmail.com>
Subject: Re: [RFC PATCH 00/29] acl: add vfs posix acl api
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, Seth Forshee <sforshee@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
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

On Thu, Sep 22, 2022 at 12:27 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
> On 9/22/2022 8:16 AM, Christian Brauner wrote:
> > From: "Christian Brauner (Microsoft)" <brauner@kernel.org>
>
> Could we please see the entire patch set on the LSM list?
> ( linux-security-module@vger.kernel.org )
> It's really tough to judge the importance of adding a new
> LSM hook without seeing both how it is called and how the
> security modules are expected to fulfill it. In particular,
> it is important to see how a posix acl is different from
> any other xattr.

Yes, exactly.  I understand the desire to avoid dumping a large~ish
patchset on a lot of lists, but it's really hard to adequately review
something when you only see a small fraction of the overall change.

-- 
paul-moore.com
