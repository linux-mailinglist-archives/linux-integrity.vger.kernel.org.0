Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A973E6C740A
	for <lists+linux-integrity@lfdr.de>; Fri, 24 Mar 2023 00:33:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231299AbjCWXd4 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 23 Mar 2023 19:33:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231231AbjCWXdz (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 23 Mar 2023 19:33:55 -0400
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DADE2241CB
        for <linux-integrity@vger.kernel.org>; Thu, 23 Mar 2023 16:33:51 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id p15so275969ybl.9
        for <linux-integrity@vger.kernel.org>; Thu, 23 Mar 2023 16:33:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1679614431;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I4UQt9s0uViyb6ofhmfjXLpk2tpOHMTrFO4xtiTE1F0=;
        b=B/0sSV7njn/GnbdGsZmwGqohjHyQKCvOu/6lA3UnCwY5crL557lHVTU44KJxZHT7yP
         aPP+W3L7LsThfn1d73iOPDaxJ4xaogwioYx8PIMl/sbmCYK2QpbhQ/C3TGah4c41AH7d
         34VK1xWYZtimyZLICoxE+b9Eqs8qV62zR0LZst+Hl5muiDzrsbLT4VjJQjVnxo20RgOx
         QS6XgqmI6PTjN2jji+M23xYUJA5aMnZhcnEc1UWcg8cyTAqJUozNTyGh4D0U2mOYANmT
         m2TjS6e7s7ht3ZDMN60F3ByMAURAMBiNlLvT9cSW4f6JHrOJwK9tvY7F3QFHQYSulqjZ
         TNsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679614431;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I4UQt9s0uViyb6ofhmfjXLpk2tpOHMTrFO4xtiTE1F0=;
        b=DR9lcm2qT/Atfl1YoGNzSWGRcRG0yIoI+QJWTc0ADB2DPo+m+VUUafV2mUuSIUyaNk
         vKAfxthZ0FD6KM278ogN2Yo12DH83kcxxHbMItLqOkeddT20RH7zGGpzN3DqPBBlmtvf
         idO/ev7rJb0Y4d/ZaVzDN0Ve8Qz4caVEir9jlJEqrrf0h6c7oIBlRxLe0UgybT2lmUNP
         YcLciaWx8/1W02tMe7lVhMPSgsBK1CIeWWtv/qe8TdlIQz/wlkr+5qF6yTdMxc+Dj6gv
         6EfDFBDmqS/CrDE5utFcaJ0irTVy+pMxktYqMPkdRRiITiPQmFFvMrgke4gv01zJg3ls
         U0HA==
X-Gm-Message-State: AAQBX9fXI7EAZClEw/nkmwP2J1hd5Cq/g4iOiP0aPOxn0yWesij5jlp8
        jbWSpkO/bTa7f/EfRxLpZRCYgbD5TQ/vjnB2T830
X-Google-Smtp-Source: AKy350Ythv2mrmo7XSEuLMBIjFRTDHgBFPhqt6X4Wf9cwlS+qXqGx6EuJGwGC9z42MtKE37zO8JrjgFxkcxJXq4nSaI=
X-Received: by 2002:a25:abee:0:b0:b68:7a4a:5258 with SMTP id
 v101-20020a25abee000000b00b687a4a5258mr211351ybi.3.1679614430992; Thu, 23 Mar
 2023 16:33:50 -0700 (PDT)
MIME-Version: 1.0
References: <20230314081720.4158676-1-roberto.sassu@huaweicloud.com> <20230314081720.4158676-2-roberto.sassu@huaweicloud.com>
In-Reply-To: <20230314081720.4158676-2-roberto.sassu@huaweicloud.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 23 Mar 2023 19:33:40 -0400
Message-ID: <CAHC9VhS1htA=cFqbc3KJsrZ3by6_m=f3Bd0sTbztC=qMZEvedA@mail.gmail.com>
Subject: Re: [PATCH v8 1/6] reiserfs: Switch to security_inode_init_security()
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
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, Mar 14, 2023 at 4:18=E2=80=AFAM Roberto Sassu
<roberto.sassu@huaweicloud.com> wrote:
>
> From: Roberto Sassu <roberto.sassu@huawei.com>
>
> In preparation for removing security_old_inode_init_security(), switch to
> security_inode_init_security(). Commit 572302af1258 ("reiserfs: Add missi=
ng
> calls to reiserfs_security_free()") fixed possible memory leaks and anoth=
er
> issue related to adding an xattr at inode creation time.
>
> Define the initxattrs callback reiserfs_initxattrs(), to populate the
> name/value/len triple in the reiserfs_security_handle() with the first
> xattr provided by LSMs. Make a copy of the xattr value, as
> security_inode_init_security() frees it.
>
> After the call to security_inode_init_security(), remove the check for
> returning -EOPNOTSUPP, as security_inode_init_security() changes it to
> zero.
>
> Multiple xattrs are currently not supported, as the
> reiserfs_security_handle structure is exported to user space. As a
> consequence, even if EVM is invoked, it will not provide an xattr (if it
> is not the first to set it, its xattr will be discarded; if it is the
> first, it does not have xattrs to calculate the HMAC on).
>
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> Reviewed-by: Casey Schaufler <casey@schaufler-ca.com>
> Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
> ---
>  fs/reiserfs/xattr_security.c | 23 ++++++++++++++++++-----
>  1 file changed, 18 insertions(+), 5 deletions(-)

Merged into lsm/next, thanks.

--=20
paul-moore.com
