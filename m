Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99C7E46D398
	for <lists+linux-integrity@lfdr.de>; Wed,  8 Dec 2021 13:47:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233662AbhLHMub (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 8 Dec 2021 07:50:31 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:44632 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232041AbhLHMua (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 8 Dec 2021 07:50:30 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 5B86ACE2164;
        Wed,  8 Dec 2021 12:46:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52D33C00446;
        Wed,  8 Dec 2021 12:46:49 +0000 (UTC)
Date:   Wed, 8 Dec 2021 13:46:45 +0100
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Stefan Berger <stefanb@linux.ibm.com>
Cc:     linux-integrity@vger.kernel.org, zohar@linux.ibm.com,
        serge@hallyn.com, containers@lists.linux.dev,
        dmitry.kasatkin@gmail.com, ebiederm@xmission.com,
        krzysztof.struczynski@huawei.com, roberto.sassu@huawei.com,
        mpeters@redhat.com, lhinds@redhat.com, lsturman@redhat.com,
        puiterwi@redhat.com, jejb@linux.ibm.com, jamjoom@us.ibm.com,
        linux-kernel@vger.kernel.org, paul@paul-moore.com, rgb@redhat.com,
        linux-security-module@vger.kernel.org, jmorris@namei.org,
        James Bottomley <James.Bottomley@HansenPartnership.com>
Subject: Re: [PATCH v4 11/16] securityfs: Only use
 simple_pin_fs/simple_release_fs for init_user_ns
Message-ID: <20211208124645.rrt2zs5kq4qzftw5@wittgenstein>
References: <20211207202127.1508689-1-stefanb@linux.ibm.com>
 <20211207202127.1508689-12-stefanb@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211207202127.1508689-12-stefanb@linux.ibm.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, Dec 07, 2021 at 03:21:22PM -0500, Stefan Berger wrote:
> To prepare for virtualization of SecurityFS, use simple_pin_fs and
> simpe_release_fs only when init_user_ns is active.
> 
> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
> Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>
> ---
>  security/inode.c | 30 +++++++++++++++++++++---------
>  1 file changed, 21 insertions(+), 9 deletions(-)
> 
> diff --git a/security/inode.c b/security/inode.c
> index 6c326939750d..1a720b2c566d 100644
> --- a/security/inode.c
> +++ b/security/inode.c
> @@ -21,9 +21,10 @@
>  #include <linux/security.h>
>  #include <linux/lsm_hooks.h>
>  #include <linux/magic.h>
> +#include <linux/user_namespace.h>
>  
> -static struct vfsmount *mount;
> -static int mount_count;
> +static struct vfsmount *securityfs_mount;
> +static int securityfs_mount_count;

Maybe better:

static struct vfsmount *init_securityfs_mount;
static int init_securityfs_mount_count;

gets a bit long but gets the meaning across better plus it's a global so
not really an issue imho if it's long.

Otherwise, looks good.
Acked-by: Christian Brauner <christian.brauner@ubuntu.com>
