Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FFF0477356
	for <lists+linux-integrity@lfdr.de>; Thu, 16 Dec 2021 14:40:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234468AbhLPNki (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 16 Dec 2021 08:40:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229821AbhLPNki (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 16 Dec 2021 08:40:38 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D101C061574;
        Thu, 16 Dec 2021 05:40:38 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 98A1661DEB;
        Thu, 16 Dec 2021 13:40:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF470C36AE0;
        Thu, 16 Dec 2021 13:40:30 +0000 (UTC)
Date:   Thu, 16 Dec 2021 14:40:27 +0100
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Stefan Berger <stefanb@linux.vnet.ibm.com>
Cc:     linux-integrity@vger.kernel.org, zohar@linux.ibm.com,
        serge@hallyn.com, containers@lists.linux.dev,
        dmitry.kasatkin@gmail.com, ebiederm@xmission.com,
        krzysztof.struczynski@huawei.com, roberto.sassu@huawei.com,
        mpeters@redhat.com, lhinds@redhat.com, lsturman@redhat.com,
        puiterwi@redhat.com, jejb@linux.ibm.com, jamjoom@us.ibm.com,
        linux-kernel@vger.kernel.org, paul@paul-moore.com, rgb@redhat.com,
        linux-security-module@vger.kernel.org, jmorris@namei.org,
        Stefan Berger <stefanb@linux.ibm.com>,
        James Bottomley <James.Bottomley@HansenPartnership.com>
Subject: Re: [PATCH v7 10/14] securityfs: Extend securityfs with namespacing
 support
Message-ID: <20211216134027.33sprdmhol2tbctf@wittgenstein>
References: <20211216054323.1707384-1-stefanb@linux.vnet.ibm.com>
 <20211216054323.1707384-11-stefanb@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211216054323.1707384-11-stefanb@linux.vnet.ibm.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, Dec 16, 2021 at 12:43:19AM -0500, Stefan Berger wrote:
> From: Stefan Berger <stefanb@linux.ibm.com>
> 
> Extend 'securityfs' for support of IMA namespacing so that each
> IMA (user) namespace can have its own front-end for showing the currently
> active policy, the measurement list, number of violations and so on.
> 
> Drop the addition dentry reference to enable simple cleanup of dentries
> upon umount.
> 
> Prevent mounting of an instance of securityfs in another user namespace
> than it belongs to. Also, prevent accesses to directories when another
> user namespace is active than the one that the instance of securityfs
> belongs to.
> 
> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
> Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>
> ---
>  security/inode.c | 37 ++++++++++++++++++++++++++++++++++---
>  1 file changed, 34 insertions(+), 3 deletions(-)
> 
> diff --git a/security/inode.c b/security/inode.c
> index fee01ff4d831..a0d9f086e3d5 100644
> --- a/security/inode.c
> +++ b/security/inode.c
> @@ -26,6 +26,29 @@
>  static struct vfsmount *init_securityfs_mount;
>  static int init_securityfs_mount_count;
>  
> +static int securityfs_permission(struct user_namespace *mnt_userns,
> +				 struct inode *inode, int mask)
> +{
> +	int err;
> +
> +	err = generic_permission(&init_user_ns, inode, mask);
> +	if (!err) {
> +		if (inode->i_sb->s_user_ns != current_user_ns())
> +			err = -EACCES;

I really think the correct semantics is to grant all callers access
whose user namespace is the same as or an ancestor of the securityfs
userns. It's weird to deny access to callers who are located in an
ancestor userns.

For example, a privileged process on the host should be allowed to setns
to the userns of an unprivileged container and inspect its securityfs
instance.

We're mostly interested to block such as scenarios where two sibling
unprivileged containers are created in the initial userns and an fd
proxy or something funnels a file descriptor from one sibling container
to the another one and the receiving sibling container can use readdir()
or openat() on this fd. (I'm not even convinced that this is actually a
problem but stricter semantics at the beginning can't hurt. We can
always relax this later.)
