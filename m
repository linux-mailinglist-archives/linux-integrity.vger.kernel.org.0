Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AACB6B14D7
	for <lists+linux-integrity@lfdr.de>; Wed,  8 Mar 2023 23:16:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230205AbjCHWQk (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 8 Mar 2023 17:16:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230221AbjCHWQj (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 8 Mar 2023 17:16:39 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B2C084F71
        for <linux-integrity@vger.kernel.org>; Wed,  8 Mar 2023 14:16:38 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id p20so19067078plw.13
        for <linux-integrity@vger.kernel.org>; Wed, 08 Mar 2023 14:16:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1678313798;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tkhViH9kdWNjYXwKnPEs08Xl3095dV6IZ6LM3uHmPgg=;
        b=bPXrjsfNIA8aCilQN80V8tZJJRnYiUaUiYYE6WDP0poZXHmgRnngHO4Lb96J8qrY8s
         0UFv5K7lMRJloKD0tWGMmVKDB1rB7L2PYgY245lC/cGDS2TdHabWAHsD74tYHk7XWX+9
         ctSErcrpU4ra1h7MNt4j2JB1T46qH5KSu8XZMjjoIq7fVYdLws67bRDNtSSAyq5ddIEU
         URzRfvXhHoHE7mhDjTIo/KgBW+4k4yBsfFL5q4a+jwiG/cTxuGsLWCziz32JVyllZ+pC
         DZbdjHIIJFo9Zy6iaSLyCS5thVAOwak49iMLSnuOr6HQ+YCMlQc6/QjcnOmMkEQALnF5
         7qLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678313798;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tkhViH9kdWNjYXwKnPEs08Xl3095dV6IZ6LM3uHmPgg=;
        b=xR76Fk0g8XJNObBb9EQXPpjdjte1v/s6TyMWy+bpYZ/hXwQInEY97JcjMz4ui1UMUP
         GIelpvZhS6tHCUKkXQN/rhgGTyyU2QriSPT7Wv4g33Ue8+KoJJAKX1jY4juKAAE+mPaa
         87kuojNE7G7qDfjZviRtQennaDy248QFbl2H7h75P5LYtB1yx298grzHha49MgGk2dYB
         jKAFcUbN2adnvMT18f0Smmaj0alh07MVJlysm6mvvk59qUVltnf/0p5UCtrcuzpOr1Xw
         P7BFhjbtRQ7thLP5d9duXWcA8t/Adnm6wxv5RbU69g3quIIRGd1SFc5GXrCLkiSYxMMH
         awKQ==
X-Gm-Message-State: AO0yUKUj8NJeYByl/r1IBQN4YcWlMbr3kxvhWPAkiZG024SEGYyW9jdw
        /k7RSdgPD3KbbcVEVweigJzlG4KY07ls9KIzTt+H
X-Google-Smtp-Source: AK7set++0GvPRL/fArYHKN0SqlsLssuQ2AVagfsEuJmq+L5qFprSO0qSDic4f0ylWLwNIoHyQ3gpdgkwfLpUMJ7FI+Y=
X-Received: by 2002:a17:903:2587:b0:19a:9f86:adab with SMTP id
 jb7-20020a170903258700b0019a9f86adabmr7646529plb.7.1678313797868; Wed, 08 Mar
 2023 14:16:37 -0800 (PST)
MIME-Version: 1.0
References: <20221201104125.919483-1-roberto.sassu@huaweicloud.com>
In-Reply-To: <20221201104125.919483-1-roberto.sassu@huaweicloud.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 8 Mar 2023 17:16:26 -0500
Message-ID: <CAHC9VhTRT=o9Rv+EhZ4aab1FDCyTNa7XEYuhuOiSEkWh0Cdrnw@mail.gmail.com>
Subject: Re: [PATCH v7 0/6] evm: Do HMAC of multiple per LSM xattrs for new inodes
To:     Roberto Sassu <roberto.sassu@huaweicloud.com>
Cc:     mark@fasheh.com, jlbec@evilplan.org, joseph.qi@linux.alibaba.com,
        zohar@linux.ibm.com, dmitry.kasatkin@gmail.com, jmorris@namei.org,
        serge@hallyn.com, stephen.smalley.work@gmail.com,
        eparis@parisplace.org, casey@schaufler-ca.com,
        ocfs2-devel@oss.oracle.com, reiserfs-devel@vger.kernel.org,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        linux-kernel@vger.kernel.org, keescook@chromium.org,
        nicolas.bouchinet@clip-os.org,
        Roberto Sassu <roberto.sassu@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, Dec 1, 2022 at 5:42=E2=80=AFAM Roberto Sassu
<roberto.sassu@huaweicloud.com> wrote:
>
> From: Roberto Sassu <roberto.sassu@huawei.com>
>
> One of the major goals of LSM stacking is to run multiple LSMs side by si=
de
> without interfering with each other. The ultimate decision will depend on
> individual LSM decision.
>
> Several changes need to be made to the LSM infrastructure to be able to
> support that. This patch set tackles one of them: gives to each LSM the
> ability to specify one or multiple xattrs to be set at inode creation
> time and, at the same time, gives to EVM the ability to access all those
> xattrs and calculate the HMAC on them.

Hi Roberto,

The v7 draft of this patchset had some good discussion, and based on a
quick read of the comments it looks like everyone was eventually
satisfied that the v7 draft was good and no further changes were
necessary, is that correct or do you have an updated draft of this
patchset?

--=20
paul-moore.com
