Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CE588865C9
	for <lists+linux-integrity@lfdr.de>; Thu,  8 Aug 2019 17:30:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725535AbfHHPaE (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 8 Aug 2019 11:30:04 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:46752 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733153AbfHHPaD (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 8 Aug 2019 11:30:03 -0400
Received: by mail-pl1-f195.google.com with SMTP id c2so43664699plz.13
        for <linux-integrity@vger.kernel.org>; Thu, 08 Aug 2019 08:30:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-transfer-encoding:content-language;
        bh=Bnxyj484MxFpbRpJvXiIurT0MJsNB9VhgXelA7t9rBo=;
        b=WY/PONVcZkzgteWtYEjnMfMf4Rk5B3MF6IiFqBhk2vXgIrvEy2b6idTLRsmitmaeD3
         XTX5NfWYDghgbHTL/ZXka2rBvLKf4wVOtc6GlG+ZVDY6mgxdWOD5i4eJMpGANeifK+FZ
         3kjQC9vG3eLho3jiUXvRAyWh1/84xV81vMGXb8R/yhvxzR3e5oAMkLduXkx7C0TjyuVy
         nriq7Bffj9gWgE7AdTVWsP/ZdFtP3gkx/X+/rHtk/8aWT8dzT0rw98o8H7IUyLCzvvl7
         AGCD2/F+N6cB6QOH7EVR3iv8VKrUxcJe2VhbmEOxnZDNT3xB8cRgPQZKurC3Gf7FL7D0
         gchw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=Bnxyj484MxFpbRpJvXiIurT0MJsNB9VhgXelA7t9rBo=;
        b=F40sIdd0aZ4S9XIzpyYAyTdSTkL7kJpr1vT2hnQUJqeNtMGMJMtE+CwiAct2pHwdVt
         4m3fHh+hDsh+quVeb3kz22140/QHqdWmBX8RxBgWPyiAPD0lrWhiOPBiSv5gdl3cT22/
         LitjYX0Q2Y0WOvvpH8nmkfPXZBLkxvFe9HhhCkn6+9/lT/1zMyTtYXuCt/evrS8wv1yj
         urW2L5B0aw2O+HTAu4oDYq1TEwyFh/k1/Kf7D6M/kVsX8ud/he+e+GW6vCOcGt0Bzs39
         drhM3YprS0zTQxNPD2eRuaaXmave1MEvU6dRse35Royx9tWa4JHCJDgb2KydVs5S6DMq
         wlDg==
X-Gm-Message-State: APjAAAXXdiR2QnnsT5hFbDYV3k/0hGlNRXGZap0kcDgHEQ9xjvAry8wv
        gKDesX/mRdHmjDQNWHMushLPeqlwhkROdA==
X-Google-Smtp-Source: APXvYqyKGTO+l3swgNfB93rziY5FbTuY6mqSvDShvOLOPkCb04yVnvsph+wBAVLS4bG9KX3OR79Nkw==
X-Received: by 2002:a17:902:aa95:: with SMTP id d21mr13778950plr.185.1565278201682;
        Thu, 08 Aug 2019 08:30:01 -0700 (PDT)
Received: from nebulus.mtv.corp.google.com ([2620:15c:211:200:5404:91ba:59dc:9400])
        by smtp.googlemail.com with ESMTPSA id h12sm2957180pje.12.2019.08.08.08.30.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 08 Aug 2019 08:30:01 -0700 (PDT)
Subject: Re: [PATCH v13 2/5] Add flags option to get xattr method paired to
 __vfs_getxattr
To:     Stephen Smalley <sds@tycho.nsa.gov>,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>,
        linux-integrity@vger.kernel.org
References: <20190731165803.4755-1-salyzyn@android.com>
 <20190731165803.4755-3-salyzyn@android.com>
From:   Mark Salyzyn <salyzyn@android.com>
Message-ID: <70218c28-f340-c17d-fb46-c74f63a58bcf@android.com>
Date:   Thu, 8 Aug 2019 08:29:59 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190731165803.4755-3-salyzyn@android.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

I have been told privately that this patch should be pulled out of the 
overlayfs series, and independently approved. In effect by security 
focus (the filesystem folks generally ignore patches that are related to 
overlayfs or are security related).

Once accepted, we can _then_ get on with the fixes for overlayfs (or any 
other unionfs that needs this) under separate cover.

Does the flags option to __vfs_getxattr deal with your (Stephen Smalley) 
concerns about attack surface (the flag is passed 
programmatically/internally and resides only on the randomized stack)?

Sincerely -- Mark

On 7/31/19 9:57 AM, Mark Salyzyn wrote:
> Add a flag option to get xattr method that could have a bit flag of
> XATTR_NOSECURITY passed to it.  XATTR_NOSECURITY is generally then
> set in the __vfs_getxattr path.
>
> This handles the case of a union filesystem driver that is being
> requested by the security layer to report back the data that is the
> target label or context embedded into wrapped filesystem's xattr.
>
> For the use case where access is to be blocked by the security layer.
>
> The path then could be security(dentry) ->
> __vfs_getxattr(dentry...XATTR_NOSECUIRTY) ->
> handler->get(dentry...XATTR_NOSECURITY) ->
> __vfs_getxattr(lower_dentry...XATTR_NOSECUIRTY) ->
> lower_handler->get(lower_dentry...XATTR_NOSECUIRTY)
> which would report back through the chain data and success as
> expected, but the logging security layer at the top would have the
> data to determine the access permissions and report back the target
> context that was blocked.
>
> Without the get handler flag, the path on a union filesystem would be
> the errant security(dentry) -> __vfs_getxattr(dentry) ->
> handler->get(dentry) -> vfs_getxattr(lower_dentry) -> nested ->
> security(lower_dentry, log off) -> lower_handler->get(lower_dentry)
> which would report back through the chain no data, and -EACCES.
>
> For selinux for both cases, this would translate to a correctly
> determined blocked access. In the first corrected case a correct avc
> log would be reported, in the second legacy case an incorrect avc log
> would be reported against an uninitialized u:object_r:unlabeled:s0
> context making the logs cosmetically useless for audit2allow.
>
> This patch series is inert and is the wide-spread addition of the
> flags option for xattr functions, and a replacement of _vfs_getxattr
> with __vfs_getxattr(...XATTR_NOSECURITY).
>
> Signed-off-by: Mark Salyzyn <salyzyn@android.com>
> Cc: Miklos Szeredi <miklos@szeredi.hu>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: Vivek Goyal <vgoyal@redhat.com>
> Cc: Eric W. Biederman <ebiederm@xmission.com>
> Cc: Amir Goldstein <amir73il@gmail.com>
> Cc: Randy Dunlap <rdunlap@infradead.org>
> Cc: Stephen Smalley <sds@tycho.nsa.gov>
> Cc: linux-unionfs@vger.kernel.org
> Cc: linux-doc@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Cc: kernel-team@android.com
> Cc: Eric Van Hensbergen <ericvh@gmail.com>
> Cc: Latchesar Ionkov <lucho@ionkov.net>
> Cc: Dominique Martinet <asmadeus@codewreck.org>
> Cc: David Howells <dhowells@redhat.com>
> Cc: Chris Mason <clm@fb.com>
> Cc: Josef Bacik <josef@toxicpanda.com>
> Cc: David Sterba <dsterba@suse.com>
> Cc: Jeff Layton <jlayton@kernel.org>
> Cc: Sage Weil <sage@redhat.com>
> Cc: Ilya Dryomov <idryomov@gmail.com>
> Cc: Steve French <sfrench@samba.org>
> Cc: Tyler Hicks <tyhicks@canonical.com>
> Cc: Jan Kara <jack@suse.com>
> Cc: Theodore Ts'o <tytso@mit.edu>
> Cc: Andreas Dilger <adilger.kernel@dilger.ca>
> Cc: Jaegeuk Kim <jaegeuk@kernel.org>
> Cc: Chao Yu <yuchao0@huawei.com>
> Cc: Bob Peterson <rpeterso@redhat.com>
> Cc: Andreas Gruenbacher <agruenba@redhat.com>
> Cc: David Woodhouse <dwmw2@infradead.org>
> Cc: Richard Weinberger <richard@nod.at>
> Cc: Dave Kleikamp <shaggy@kernel.org>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Tejun Heo <tj@kernel.org>
> Cc: Trond Myklebust <trond.myklebust@hammerspace.com>
> Cc: Anna Schumaker <anna.schumaker@netapp.com>
> Cc: Mark Fasheh <mark@fasheh.com>
> Cc: Joel Becker <jlbec@evilplan.org>
> Cc: Joseph Qi <joseph.qi@linux.alibaba.com>
> Cc: Mike Marshall <hubcap@omnibond.com>
> Cc: Martin Brandenburg <martin@omnibond.com>
> Cc: Alexander Viro <viro@zeniv.linux.org.uk>
> Cc: Phillip Lougher <phillip@squashfs.org.uk>
> Cc: Darrick J. Wong <darrick.wong@oracle.com>
> Cc: linux-xfs@vger.kernel.org
> Cc: Hugh Dickins <hughd@google.com>
> Cc: David S. Miller <davem@davemloft.net>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Mathieu Malaterre <malat@debian.org>
> Cc: Ernesto A. Fernández <ernesto.mnd.fernandez@gmail.com>
> Cc: Vyacheslav Dubeyko <slava@dubeyko.com>
> Cc: v9fs-developer@lists.sourceforge.net
> Cc: linux-afs@lists.infradead.org
> Cc: linux-btrfs@vger.kernel.org
> Cc: ceph-devel@vger.kernel.org
> Cc: linux-cifs@vger.kernel.org
> Cc: samba-technical@lists.samba.org
> Cc: ecryptfs@vger.kernel.org
> Cc: linux-ext4@vger.kernel.org
> Cc: linux-f2fs-devel@lists.sourceforge.net
> Cc: linux-fsdevel@vger.kernel.org
> Cc: cluster-devel@redhat.com
> Cc: linux-mtd@lists.infradead.org
> Cc: jfs-discussion@lists.sourceforge.net
> Cc: linux-nfs@vger.kernel.org
> Cc: ocfs2-devel@oss.oracle.com
> Cc: devel@lists.orangefs.org
> Cc: reiserfs-devel@vger.kernel.org
> Cc: linux-mm@kvack.org
> Cc: netdev@vger.kernel.org
> Cc: linux-security-module@vger.kernel.org
> Cc: stable@vger.kernel.org # 4.4, 4.9, 4.14 & 4.19
> ---
> v13 - added flags to __vfs_getxattr call, and moved all the security
>        code from vfs_getxattr into it.
>
> v12 - Added back to patch series as get xattr with flag option.
>
> v11 - Squashed out of patch series and replaced with per-thread flag
>        solution.
>
> v10 - Added to patch series as __get xattr method.
> ---
>   fs/9p/acl.c                       |  3 ++-
>   fs/9p/xattr.c                     |  3 ++-
>   fs/afs/xattr.c                    |  6 +++---
>   fs/btrfs/xattr.c                  |  3 ++-
>   fs/ceph/xattr.c                   |  3 ++-
>   fs/cifs/xattr.c                   |  2 +-
>   fs/ecryptfs/inode.c               |  6 ++++--
>   fs/ecryptfs/mmap.c                |  2 +-
>   fs/ext2/xattr_trusted.c           |  2 +-
>   fs/ext2/xattr_user.c              |  2 +-
>   fs/ext4/xattr_security.c          |  2 +-
>   fs/ext4/xattr_trusted.c           |  2 +-
>   fs/ext4/xattr_user.c              |  2 +-
>   fs/f2fs/xattr.c                   |  4 ++--
>   fs/fuse/xattr.c                   |  4 ++--
>   fs/gfs2/xattr.c                   |  3 ++-
>   fs/hfs/attr.c                     |  2 +-
>   fs/hfsplus/xattr.c                |  3 ++-
>   fs/hfsplus/xattr_trusted.c        |  3 ++-
>   fs/hfsplus/xattr_user.c           |  3 ++-
>   fs/jffs2/security.c               |  3 ++-
>   fs/jffs2/xattr_trusted.c          |  3 ++-
>   fs/jffs2/xattr_user.c             |  3 ++-
>   fs/jfs/xattr.c                    |  5 +++--
>   fs/kernfs/inode.c                 |  3 ++-
>   fs/nfs/nfs4proc.c                 |  6 ++++--
>   fs/ocfs2/xattr.c                  |  9 +++++---
>   fs/orangefs/xattr.c               |  3 ++-
>   fs/overlayfs/super.c              |  8 ++++---
>   fs/posix_acl.c                    |  2 +-
>   fs/reiserfs/xattr_security.c      |  3 ++-
>   fs/reiserfs/xattr_trusted.c       |  3 ++-
>   fs/reiserfs/xattr_user.c          |  3 ++-
>   fs/squashfs/xattr.c               |  2 +-
>   fs/xattr.c                        | 36 +++++++++++++++----------------
>   fs/xfs/xfs_xattr.c                |  3 ++-
>   include/linux/xattr.h             |  9 ++++----
>   include/uapi/linux/xattr.h        |  5 +++--
>   mm/shmem.c                        |  3 ++-
>   net/socket.c                      |  3 ++-
>   security/commoncap.c              |  6 ++++--
>   security/integrity/evm/evm_main.c |  3 ++-
>   security/selinux/hooks.c          | 11 ++++++----
>   security/smack/smack_lsm.c        |  5 +++--
>   44 files changed, 119 insertions(+), 81 deletions(-)
>
> diff --git a/fs/9p/acl.c b/fs/9p/acl.c
> index 6261719f6f2a..cb14e8b312bc 100644
> --- a/fs/9p/acl.c
> +++ b/fs/9p/acl.c
> @@ -214,7 +214,8 @@ int v9fs_acl_mode(struct inode *dir, umode_t *modep,
>   
>   static int v9fs_xattr_get_acl(const struct xattr_handler *handler,
>   			      struct dentry *dentry, struct inode *inode,
> -			      const char *name, void *buffer, size_t size)
> +			      const char *name, void *buffer, size_t size,
> +			      int flags)
>   {
>   	struct v9fs_session_info *v9ses;
>   	struct posix_acl *acl;
> diff --git a/fs/9p/xattr.c b/fs/9p/xattr.c
> index ac8ff8ca4c11..5cfa772452fd 100644
> --- a/fs/9p/xattr.c
> +++ b/fs/9p/xattr.c
> @@ -139,7 +139,8 @@ ssize_t v9fs_listxattr(struct dentry *dentry, char *buffer, size_t buffer_size)
>   
>   static int v9fs_xattr_handler_get(const struct xattr_handler *handler,
>   				  struct dentry *dentry, struct inode *inode,
> -				  const char *name, void *buffer, size_t size)
> +				  const char *name, void *buffer, size_t size,
> +				  int flags)
>   {
>   	const char *full_name = xattr_full_name(handler, name);
>   
> diff --git a/fs/afs/xattr.c b/fs/afs/xattr.c
> index 5552d034090a..e6509c21f08a 100644
> --- a/fs/afs/xattr.c
> +++ b/fs/afs/xattr.c
> @@ -334,7 +334,7 @@ static const struct xattr_handler afs_xattr_yfs_handler = {
>   static int afs_xattr_get_cell(const struct xattr_handler *handler,
>   			      struct dentry *dentry,
>   			      struct inode *inode, const char *name,
> -			      void *buffer, size_t size)
> +			      void *buffer, size_t size, int flags)
>   {
>   	struct afs_vnode *vnode = AFS_FS_I(inode);
>   	struct afs_cell *cell = vnode->volume->cell;
> @@ -361,7 +361,7 @@ static const struct xattr_handler afs_xattr_afs_cell_handler = {
>   static int afs_xattr_get_fid(const struct xattr_handler *handler,
>   			     struct dentry *dentry,
>   			     struct inode *inode, const char *name,
> -			     void *buffer, size_t size)
> +			     void *buffer, size_t size, int flags)
>   {
>   	struct afs_vnode *vnode = AFS_FS_I(inode);
>   	char text[16 + 1 + 24 + 1 + 8 + 1];
> @@ -397,7 +397,7 @@ static const struct xattr_handler afs_xattr_afs_fid_handler = {
>   static int afs_xattr_get_volume(const struct xattr_handler *handler,
>   			      struct dentry *dentry,
>   			      struct inode *inode, const char *name,
> -			      void *buffer, size_t size)
> +			      void *buffer, size_t size, int flags)
>   {
>   	struct afs_vnode *vnode = AFS_FS_I(inode);
>   	const char *volname = vnode->volume->name;
> diff --git a/fs/btrfs/xattr.c b/fs/btrfs/xattr.c
> index 95d9aebff2c4..1e522e145344 100644
> --- a/fs/btrfs/xattr.c
> +++ b/fs/btrfs/xattr.c
> @@ -353,7 +353,8 @@ ssize_t btrfs_listxattr(struct dentry *dentry, char *buffer, size_t size)
>   
>   static int btrfs_xattr_handler_get(const struct xattr_handler *handler,
>   				   struct dentry *unused, struct inode *inode,
> -				   const char *name, void *buffer, size_t size)
> +				   const char *name, void *buffer, size_t size,
> +				   int flags)
>   {
>   	name = xattr_full_name(handler, name);
>   	return btrfs_getxattr(inode, name, buffer, size);
> diff --git a/fs/ceph/xattr.c b/fs/ceph/xattr.c
> index 37b458a9af3a..edb7eb9ae83e 100644
> --- a/fs/ceph/xattr.c
> +++ b/fs/ceph/xattr.c
> @@ -1171,7 +1171,8 @@ int __ceph_setxattr(struct inode *inode, const char *name,
>   
>   static int ceph_get_xattr_handler(const struct xattr_handler *handler,
>   				  struct dentry *dentry, struct inode *inode,
> -				  const char *name, void *value, size_t size)
> +				  const char *name, void *value, size_t size,
> +				  int flags)
>   {
>   	if (!ceph_is_valid_xattr(name))
>   		return -EOPNOTSUPP;
> diff --git a/fs/cifs/xattr.c b/fs/cifs/xattr.c
> index 9076150758d8..7f71c06ce631 100644
> --- a/fs/cifs/xattr.c
> +++ b/fs/cifs/xattr.c
> @@ -199,7 +199,7 @@ static int cifs_creation_time_get(struct dentry *dentry, struct inode *inode,
>   
>   static int cifs_xattr_get(const struct xattr_handler *handler,
>   			  struct dentry *dentry, struct inode *inode,
> -			  const char *name, void *value, size_t size)
> +			  const char *name, void *value, size_t size, int flags)
>   {
>   	ssize_t rc = -EOPNOTSUPP;
>   	unsigned int xid;
> diff --git a/fs/ecryptfs/inode.c b/fs/ecryptfs/inode.c
> index 18426f4855f1..c710c7533729 100644
> --- a/fs/ecryptfs/inode.c
> +++ b/fs/ecryptfs/inode.c
> @@ -1018,7 +1018,8 @@ ecryptfs_getxattr_lower(struct dentry *lower_dentry, struct inode *lower_inode,
>   		goto out;
>   	}
>   	inode_lock(lower_inode);
> -	rc = __vfs_getxattr(lower_dentry, lower_inode, name, value, size);
> +	rc = __vfs_getxattr(lower_dentry, lower_inode, name, value, size,
> +			    XATTR_NOSECURITY);
>   	inode_unlock(lower_inode);
>   out:
>   	return rc;
> @@ -1103,7 +1104,8 @@ const struct inode_operations ecryptfs_main_iops = {
>   
>   static int ecryptfs_xattr_get(const struct xattr_handler *handler,
>   			      struct dentry *dentry, struct inode *inode,
> -			      const char *name, void *buffer, size_t size)
> +			      const char *name, void *buffer, size_t size,
> +			      int flags)
>   {
>   	return ecryptfs_getxattr(dentry, inode, name, buffer, size);
>   }
> diff --git a/fs/ecryptfs/mmap.c b/fs/ecryptfs/mmap.c
> index cffa0c1ec829..2362be3e3b4d 100644
> --- a/fs/ecryptfs/mmap.c
> +++ b/fs/ecryptfs/mmap.c
> @@ -422,7 +422,7 @@ static int ecryptfs_write_inode_size_to_xattr(struct inode *ecryptfs_inode)
>   	}
>   	inode_lock(lower_inode);
>   	size = __vfs_getxattr(lower_dentry, lower_inode, ECRYPTFS_XATTR_NAME,
> -			      xattr_virt, PAGE_SIZE);
> +			      xattr_virt, PAGE_SIZE, XATTR_NOSECURITY);
>   	if (size < 0)
>   		size = 8;
>   	put_unaligned_be64(i_size_read(ecryptfs_inode), xattr_virt);
> diff --git a/fs/ext2/xattr_trusted.c b/fs/ext2/xattr_trusted.c
> index 49add1107850..8d313664f0fa 100644
> --- a/fs/ext2/xattr_trusted.c
> +++ b/fs/ext2/xattr_trusted.c
> @@ -18,7 +18,7 @@ ext2_xattr_trusted_list(struct dentry *dentry)
>   static int
>   ext2_xattr_trusted_get(const struct xattr_handler *handler,
>   		       struct dentry *unused, struct inode *inode,
> -		       const char *name, void *buffer, size_t size)
> +		       const char *name, void *buffer, size_t size, int flags)
>   {
>   	return ext2_xattr_get(inode, EXT2_XATTR_INDEX_TRUSTED, name,
>   			      buffer, size);
> diff --git a/fs/ext2/xattr_user.c b/fs/ext2/xattr_user.c
> index c243a3b4d69d..712b7c95cc64 100644
> --- a/fs/ext2/xattr_user.c
> +++ b/fs/ext2/xattr_user.c
> @@ -20,7 +20,7 @@ ext2_xattr_user_list(struct dentry *dentry)
>   static int
>   ext2_xattr_user_get(const struct xattr_handler *handler,
>   		    struct dentry *unused, struct inode *inode,
> -		    const char *name, void *buffer, size_t size)
> +		    const char *name, void *buffer, size_t size, int flags)
>   {
>   	if (!test_opt(inode->i_sb, XATTR_USER))
>   		return -EOPNOTSUPP;
> diff --git a/fs/ext4/xattr_security.c b/fs/ext4/xattr_security.c
> index 197a9d8a15ef..50fb71393fb6 100644
> --- a/fs/ext4/xattr_security.c
> +++ b/fs/ext4/xattr_security.c
> @@ -15,7 +15,7 @@
>   static int
>   ext4_xattr_security_get(const struct xattr_handler *handler,
>   			struct dentry *unused, struct inode *inode,
> -			const char *name, void *buffer, size_t size)
> +			const char *name, void *buffer, size_t size, int flags)
>   {
>   	return ext4_xattr_get(inode, EXT4_XATTR_INDEX_SECURITY,
>   			      name, buffer, size);
> diff --git a/fs/ext4/xattr_trusted.c b/fs/ext4/xattr_trusted.c
> index e9389e5d75c3..64bd8f86c1f1 100644
> --- a/fs/ext4/xattr_trusted.c
> +++ b/fs/ext4/xattr_trusted.c
> @@ -22,7 +22,7 @@ ext4_xattr_trusted_list(struct dentry *dentry)
>   static int
>   ext4_xattr_trusted_get(const struct xattr_handler *handler,
>   		       struct dentry *unused, struct inode *inode,
> -		       const char *name, void *buffer, size_t size)
> +		       const char *name, void *buffer, size_t size, int flags)
>   {
>   	return ext4_xattr_get(inode, EXT4_XATTR_INDEX_TRUSTED,
>   			      name, buffer, size);
> diff --git a/fs/ext4/xattr_user.c b/fs/ext4/xattr_user.c
> index d4546184b34b..b7301373820e 100644
> --- a/fs/ext4/xattr_user.c
> +++ b/fs/ext4/xattr_user.c
> @@ -21,7 +21,7 @@ ext4_xattr_user_list(struct dentry *dentry)
>   static int
>   ext4_xattr_user_get(const struct xattr_handler *handler,
>   		    struct dentry *unused, struct inode *inode,
> -		    const char *name, void *buffer, size_t size)
> +		    const char *name, void *buffer, size_t size, int flags)
>   {
>   	if (!test_opt(inode->i_sb, XATTR_USER))
>   		return -EOPNOTSUPP;
> diff --git a/fs/f2fs/xattr.c b/fs/f2fs/xattr.c
> index b32c45621679..76559da8dfba 100644
> --- a/fs/f2fs/xattr.c
> +++ b/fs/f2fs/xattr.c
> @@ -24,7 +24,7 @@
>   
>   static int f2fs_xattr_generic_get(const struct xattr_handler *handler,
>   		struct dentry *unused, struct inode *inode,
> -		const char *name, void *buffer, size_t size)
> +		const char *name, void *buffer, size_t size, int flags)
>   {
>   	struct f2fs_sb_info *sbi = F2FS_SB(inode->i_sb);
>   
> @@ -79,7 +79,7 @@ static bool f2fs_xattr_trusted_list(struct dentry *dentry)
>   
>   static int f2fs_xattr_advise_get(const struct xattr_handler *handler,
>   		struct dentry *unused, struct inode *inode,
> -		const char *name, void *buffer, size_t size)
> +		const char *name, void *buffer, size_t size, int flags)
>   {
>   	if (buffer)
>   		*((char *)buffer) = F2FS_I(inode)->i_advise;
> diff --git a/fs/fuse/xattr.c b/fs/fuse/xattr.c
> index 433717640f78..d1ef7808304e 100644
> --- a/fs/fuse/xattr.c
> +++ b/fs/fuse/xattr.c
> @@ -176,7 +176,7 @@ int fuse_removexattr(struct inode *inode, const char *name)
>   
>   static int fuse_xattr_get(const struct xattr_handler *handler,
>   			 struct dentry *dentry, struct inode *inode,
> -			 const char *name, void *value, size_t size)
> +			 const char *name, void *value, size_t size, int flags)
>   {
>   	return fuse_getxattr(inode, name, value, size);
>   }
> @@ -199,7 +199,7 @@ static bool no_xattr_list(struct dentry *dentry)
>   
>   static int no_xattr_get(const struct xattr_handler *handler,
>   			struct dentry *dentry, struct inode *inode,
> -			const char *name, void *value, size_t size)
> +			const char *name, void *value, size_t size, int flags)
>   {
>   	return -EOPNOTSUPP;
>   }
> diff --git a/fs/gfs2/xattr.c b/fs/gfs2/xattr.c
> index bbe593d16bea..a9db067a99c1 100644
> --- a/fs/gfs2/xattr.c
> +++ b/fs/gfs2/xattr.c
> @@ -588,7 +588,8 @@ static int __gfs2_xattr_get(struct inode *inode, const char *name,
>   
>   static int gfs2_xattr_get(const struct xattr_handler *handler,
>   			  struct dentry *unused, struct inode *inode,
> -			  const char *name, void *buffer, size_t size)
> +			  const char *name, void *buffer, size_t size,
> +			  int flags)
>   {
>   	struct gfs2_inode *ip = GFS2_I(inode);
>   	struct gfs2_holder gh;
> diff --git a/fs/hfs/attr.c b/fs/hfs/attr.c
> index 74fa62643136..08222a9c5d31 100644
> --- a/fs/hfs/attr.c
> +++ b/fs/hfs/attr.c
> @@ -115,7 +115,7 @@ static ssize_t __hfs_getxattr(struct inode *inode, enum hfs_xattr_type type,
>   
>   static int hfs_xattr_get(const struct xattr_handler *handler,
>   			 struct dentry *unused, struct inode *inode,
> -			 const char *name, void *value, size_t size)
> +			 const char *name, void *value, size_t size, int flags)
>   {
>   	return __hfs_getxattr(inode, handler->flags, value, size);
>   }
> diff --git a/fs/hfsplus/xattr.c b/fs/hfsplus/xattr.c
> index bb0b27d88e50..381c2aaedbc8 100644
> --- a/fs/hfsplus/xattr.c
> +++ b/fs/hfsplus/xattr.c
> @@ -839,7 +839,8 @@ static int hfsplus_removexattr(struct inode *inode, const char *name)
>   
>   static int hfsplus_osx_getxattr(const struct xattr_handler *handler,
>   				struct dentry *unused, struct inode *inode,
> -				const char *name, void *buffer, size_t size)
> +				const char *name, void *buffer, size_t size,
> +				int flags)
>   {
>   	/*
>   	 * Don't allow retrieving properly prefixed attributes
> diff --git a/fs/hfsplus/xattr_trusted.c b/fs/hfsplus/xattr_trusted.c
> index fbad91e1dada..54d926314f8c 100644
> --- a/fs/hfsplus/xattr_trusted.c
> +++ b/fs/hfsplus/xattr_trusted.c
> @@ -14,7 +14,8 @@
>   
>   static int hfsplus_trusted_getxattr(const struct xattr_handler *handler,
>   				    struct dentry *unused, struct inode *inode,
> -				    const char *name, void *buffer, size_t size)
> +				    const char *name, void *buffer,
> +				    size_t size, int flags)
>   {
>   	return hfsplus_getxattr(inode, name, buffer, size,
>   				XATTR_TRUSTED_PREFIX,
> diff --git a/fs/hfsplus/xattr_user.c b/fs/hfsplus/xattr_user.c
> index 74d19faf255e..4d2b1ffff887 100644
> --- a/fs/hfsplus/xattr_user.c
> +++ b/fs/hfsplus/xattr_user.c
> @@ -14,7 +14,8 @@
>   
>   static int hfsplus_user_getxattr(const struct xattr_handler *handler,
>   				 struct dentry *unused, struct inode *inode,
> -				 const char *name, void *buffer, size_t size)
> +				 const char *name, void *buffer, size_t size,
> +				 int flags)
>   {
>   
>   	return hfsplus_getxattr(inode, name, buffer, size,
> diff --git a/fs/jffs2/security.c b/fs/jffs2/security.c
> index c2332e30f218..e6f42fe435af 100644
> --- a/fs/jffs2/security.c
> +++ b/fs/jffs2/security.c
> @@ -50,7 +50,8 @@ int jffs2_init_security(struct inode *inode, struct inode *dir,
>   /* ---- XATTR Handler for "security.*" ----------------- */
>   static int jffs2_security_getxattr(const struct xattr_handler *handler,
>   				   struct dentry *unused, struct inode *inode,
> -				   const char *name, void *buffer, size_t size)
> +				   const char *name, void *buffer, size_t size,
> +				   int flags)
>   {
>   	return do_jffs2_getxattr(inode, JFFS2_XPREFIX_SECURITY,
>   				 name, buffer, size);
> diff --git a/fs/jffs2/xattr_trusted.c b/fs/jffs2/xattr_trusted.c
> index 5d6030826c52..9dccaae549f5 100644
> --- a/fs/jffs2/xattr_trusted.c
> +++ b/fs/jffs2/xattr_trusted.c
> @@ -18,7 +18,8 @@
>   
>   static int jffs2_trusted_getxattr(const struct xattr_handler *handler,
>   				  struct dentry *unused, struct inode *inode,
> -				  const char *name, void *buffer, size_t size)
> +				  const char *name, void *buffer, size_t size,
> +				  int flags)
>   {
>   	return do_jffs2_getxattr(inode, JFFS2_XPREFIX_TRUSTED,
>   				 name, buffer, size);
> diff --git a/fs/jffs2/xattr_user.c b/fs/jffs2/xattr_user.c
> index 9d027b4abcf9..c0983a3e810b 100644
> --- a/fs/jffs2/xattr_user.c
> +++ b/fs/jffs2/xattr_user.c
> @@ -18,7 +18,8 @@
>   
>   static int jffs2_user_getxattr(const struct xattr_handler *handler,
>   			       struct dentry *unused, struct inode *inode,
> -			       const char *name, void *buffer, size_t size)
> +			       const char *name, void *buffer, size_t size,
> +			       int flags)
>   {
>   	return do_jffs2_getxattr(inode, JFFS2_XPREFIX_USER,
>   				 name, buffer, size);
> diff --git a/fs/jfs/xattr.c b/fs/jfs/xattr.c
> index db41e7803163..5c79a35bf62f 100644
> --- a/fs/jfs/xattr.c
> +++ b/fs/jfs/xattr.c
> @@ -925,7 +925,7 @@ static int __jfs_xattr_set(struct inode *inode, const char *name,
>   
>   static int jfs_xattr_get(const struct xattr_handler *handler,
>   			 struct dentry *unused, struct inode *inode,
> -			 const char *name, void *value, size_t size)
> +			 const char *name, void *value, size_t size, int flags)
>   {
>   	name = xattr_full_name(handler, name);
>   	return __jfs_getxattr(inode, name, value, size);
> @@ -942,7 +942,8 @@ static int jfs_xattr_set(const struct xattr_handler *handler,
>   
>   static int jfs_xattr_get_os2(const struct xattr_handler *handler,
>   			     struct dentry *unused, struct inode *inode,
> -			     const char *name, void *value, size_t size)
> +			     const char *name, void *value, size_t size,
> +			     int flags)
>   {
>   	if (is_known_namespace(name))
>   		return -EOPNOTSUPP;
> diff --git a/fs/kernfs/inode.c b/fs/kernfs/inode.c
> index f3f3984cce80..89db24ce644e 100644
> --- a/fs/kernfs/inode.c
> +++ b/fs/kernfs/inode.c
> @@ -309,7 +309,8 @@ int kernfs_xattr_set(struct kernfs_node *kn, const char *name,
>   
>   static int kernfs_vfs_xattr_get(const struct xattr_handler *handler,
>   				struct dentry *unused, struct inode *inode,
> -				const char *suffix, void *value, size_t size)
> +				const char *suffix, void *value, size_t size,
> +				int flags)
>   {
>   	const char *name = xattr_full_name(handler, suffix);
>   	struct kernfs_node *kn = inode->i_private;
> diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
> index 39896afc6edf..5e6a58685cd0 100644
> --- a/fs/nfs/nfs4proc.c
> +++ b/fs/nfs/nfs4proc.c
> @@ -7203,7 +7203,8 @@ static int nfs4_xattr_set_nfs4_acl(const struct xattr_handler *handler,
>   
>   static int nfs4_xattr_get_nfs4_acl(const struct xattr_handler *handler,
>   				   struct dentry *unused, struct inode *inode,
> -				   const char *key, void *buf, size_t buflen)
> +				   const char *key, void *buf, size_t buflen,
> +				   int flags)
>   {
>   	return nfs4_proc_get_acl(inode, buf, buflen);
>   }
> @@ -7228,7 +7229,8 @@ static int nfs4_xattr_set_nfs4_label(const struct xattr_handler *handler,
>   
>   static int nfs4_xattr_get_nfs4_label(const struct xattr_handler *handler,
>   				     struct dentry *unused, struct inode *inode,
> -				     const char *key, void *buf, size_t buflen)
> +				     const char *key, void *buf, size_t buflen,
> +				     int flags)
>   {
>   	if (security_ismaclabel(key))
>   		return nfs4_get_security_label(inode, buf, buflen);
> diff --git a/fs/ocfs2/xattr.c b/fs/ocfs2/xattr.c
> index 385f3aaa2448..06e615642422 100644
> --- a/fs/ocfs2/xattr.c
> +++ b/fs/ocfs2/xattr.c
> @@ -7245,7 +7245,8 @@ int ocfs2_init_security_and_acl(struct inode *dir,
>    */
>   static int ocfs2_xattr_security_get(const struct xattr_handler *handler,
>   				    struct dentry *unused, struct inode *inode,
> -				    const char *name, void *buffer, size_t size)
> +				    const char *name, void *buffer, size_t size,
> +				    int flags)
>   {
>   	return ocfs2_xattr_get(inode, OCFS2_XATTR_INDEX_SECURITY,
>   			       name, buffer, size);
> @@ -7317,7 +7318,8 @@ const struct xattr_handler ocfs2_xattr_security_handler = {
>    */
>   static int ocfs2_xattr_trusted_get(const struct xattr_handler *handler,
>   				   struct dentry *unused, struct inode *inode,
> -				   const char *name, void *buffer, size_t size)
> +				   const char *name, void *buffer, size_t size,
> +				   int flags)
>   {
>   	return ocfs2_xattr_get(inode, OCFS2_XATTR_INDEX_TRUSTED,
>   			       name, buffer, size);
> @@ -7343,7 +7345,8 @@ const struct xattr_handler ocfs2_xattr_trusted_handler = {
>    */
>   static int ocfs2_xattr_user_get(const struct xattr_handler *handler,
>   				struct dentry *unused, struct inode *inode,
> -				const char *name, void *buffer, size_t size)
> +				const char *name, void *buffer, size_t size,
> +				int flags)
>   {
>   	struct ocfs2_super *osb = OCFS2_SB(inode->i_sb);
>   
> diff --git a/fs/orangefs/xattr.c b/fs/orangefs/xattr.c
> index bdc285aea360..ef4180bff7bb 100644
> --- a/fs/orangefs/xattr.c
> +++ b/fs/orangefs/xattr.c
> @@ -541,7 +541,8 @@ static int orangefs_xattr_get_default(const struct xattr_handler *handler,
>   				      struct inode *inode,
>   				      const char *name,
>   				      void *buffer,
> -				      size_t size)
> +				      size_t size,
> +				      int flags)
>   {
>   	return orangefs_inode_getxattr(inode, name, buffer, size);
>   
> diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
> index b368e2e102fa..a7b21f2ea2dd 100644
> --- a/fs/overlayfs/super.c
> +++ b/fs/overlayfs/super.c
> @@ -854,7 +854,7 @@ static unsigned int ovl_split_lowerdirs(char *str)
>   static int __maybe_unused
>   ovl_posix_acl_xattr_get(const struct xattr_handler *handler,
>   			struct dentry *dentry, struct inode *inode,
> -			const char *name, void *buffer, size_t size)
> +			const char *name, void *buffer, size_t size, int flags)
>   {
>   	return ovl_xattr_get(dentry, inode, handler->name, buffer, size);
>   }
> @@ -919,7 +919,8 @@ ovl_posix_acl_xattr_set(const struct xattr_handler *handler,
>   
>   static int ovl_own_xattr_get(const struct xattr_handler *handler,
>   			     struct dentry *dentry, struct inode *inode,
> -			     const char *name, void *buffer, size_t size)
> +			     const char *name, void *buffer, size_t size,
> +			     int flags)
>   {
>   	return -EOPNOTSUPP;
>   }
> @@ -934,7 +935,8 @@ static int ovl_own_xattr_set(const struct xattr_handler *handler,
>   
>   static int ovl_other_xattr_get(const struct xattr_handler *handler,
>   			       struct dentry *dentry, struct inode *inode,
> -			       const char *name, void *buffer, size_t size)
> +			       const char *name, void *buffer, size_t size,
> +			       int flags)
>   {
>   	return ovl_xattr_get(dentry, inode, name, buffer, size);
>   }
> diff --git a/fs/posix_acl.c b/fs/posix_acl.c
> index 84ad1c90d535..cd55621e570b 100644
> --- a/fs/posix_acl.c
> +++ b/fs/posix_acl.c
> @@ -832,7 +832,7 @@ EXPORT_SYMBOL (posix_acl_to_xattr);
>   static int
>   posix_acl_xattr_get(const struct xattr_handler *handler,
>   		    struct dentry *unused, struct inode *inode,
> -		    const char *name, void *value, size_t size)
> +		    const char *name, void *value, size_t size, int flags)
>   {
>   	struct posix_acl *acl;
>   	int error;
> diff --git a/fs/reiserfs/xattr_security.c b/fs/reiserfs/xattr_security.c
> index 20be9a0e5870..eedfa07a4fd0 100644
> --- a/fs/reiserfs/xattr_security.c
> +++ b/fs/reiserfs/xattr_security.c
> @@ -11,7 +11,8 @@
>   
>   static int
>   security_get(const struct xattr_handler *handler, struct dentry *unused,
> -	     struct inode *inode, const char *name, void *buffer, size_t size)
> +	     struct inode *inode, const char *name, void *buffer, size_t size,
> +	     int flags)
>   {
>   	if (IS_PRIVATE(inode))
>   		return -EPERM;
> diff --git a/fs/reiserfs/xattr_trusted.c b/fs/reiserfs/xattr_trusted.c
> index 5ed48da3d02b..2d11d98605dd 100644
> --- a/fs/reiserfs/xattr_trusted.c
> +++ b/fs/reiserfs/xattr_trusted.c
> @@ -10,7 +10,8 @@
>   
>   static int
>   trusted_get(const struct xattr_handler *handler, struct dentry *unused,
> -	    struct inode *inode, const char *name, void *buffer, size_t size)
> +	    struct inode *inode, const char *name, void *buffer, size_t size,
> +	    int flags)
>   {
>   	if (!capable(CAP_SYS_ADMIN) || IS_PRIVATE(inode))
>   		return -EPERM;
> diff --git a/fs/reiserfs/xattr_user.c b/fs/reiserfs/xattr_user.c
> index a573ca45bacc..2a59d85c69c9 100644
> --- a/fs/reiserfs/xattr_user.c
> +++ b/fs/reiserfs/xattr_user.c
> @@ -9,7 +9,8 @@
>   
>   static int
>   user_get(const struct xattr_handler *handler, struct dentry *unused,
> -	 struct inode *inode, const char *name, void *buffer, size_t size)
> +	 struct inode *inode, const char *name, void *buffer, size_t size,
> +	 int flags)
>   {
>   	if (!reiserfs_xattrs_user(inode->i_sb))
>   		return -EOPNOTSUPP;
> diff --git a/fs/squashfs/xattr.c b/fs/squashfs/xattr.c
> index e1e3f3dd5a06..d8d58c990652 100644
> --- a/fs/squashfs/xattr.c
> +++ b/fs/squashfs/xattr.c
> @@ -204,7 +204,7 @@ static int squashfs_xattr_handler_get(const struct xattr_handler *handler,
>   				      struct dentry *unused,
>   				      struct inode *inode,
>   				      const char *name,
> -				      void *buffer, size_t size)
> +				      void *buffer, size_t size, int flags)
>   {
>   	return squashfs_xattr_get(inode, handler->flags, name,
>   		buffer, size);
> diff --git a/fs/xattr.c b/fs/xattr.c
> index 90dd78f0eb27..71f887518d6f 100644
> --- a/fs/xattr.c
> +++ b/fs/xattr.c
> @@ -281,7 +281,7 @@ vfs_getxattr_alloc(struct dentry *dentry, const char *name, char **xattr_value,
>   		return PTR_ERR(handler);
>   	if (!handler->get)
>   		return -EOPNOTSUPP;
> -	error = handler->get(handler, dentry, inode, name, NULL, 0);
> +	error = handler->get(handler, dentry, inode, name, NULL, 0, 0);
>   	if (error < 0)
>   		return error;
>   
> @@ -292,32 +292,20 @@ vfs_getxattr_alloc(struct dentry *dentry, const char *name, char **xattr_value,
>   		memset(value, 0, error + 1);
>   	}
>   
> -	error = handler->get(handler, dentry, inode, name, value, error);
> +	error = handler->get(handler, dentry, inode, name, value, error, 0);
>   	*xattr_value = value;
>   	return error;
>   }
>   
>   ssize_t
>   __vfs_getxattr(struct dentry *dentry, struct inode *inode, const char *name,
> -	       void *value, size_t size)
> +	       void *value, size_t size, int flags)
>   {
>   	const struct xattr_handler *handler;
> -
> -	handler = xattr_resolve_name(inode, &name);
> -	if (IS_ERR(handler))
> -		return PTR_ERR(handler);
> -	if (!handler->get)
> -		return -EOPNOTSUPP;
> -	return handler->get(handler, dentry, inode, name, value, size);
> -}
> -EXPORT_SYMBOL(__vfs_getxattr);
> -
> -ssize_t
> -vfs_getxattr(struct dentry *dentry, const char *name, void *value, size_t size)
> -{
> -	struct inode *inode = dentry->d_inode;
>   	int error;
>   
> +	if (flags & XATTR_NOSECURITY)
> +		goto nolsm;
>   	error = xattr_permission(inode, name, MAY_READ);
>   	if (error)
>   		return error;
> @@ -339,7 +327,19 @@ vfs_getxattr(struct dentry *dentry, const char *name, void *value, size_t size)
>   		return ret;
>   	}
>   nolsm:
> -	return __vfs_getxattr(dentry, inode, name, value, size);
> +	handler = xattr_resolve_name(inode, &name);
> +	if (IS_ERR(handler))
> +		return PTR_ERR(handler);
> +	if (!handler->get)
> +		return -EOPNOTSUPP;
> +	return handler->get(handler, dentry, inode, name, value, size, flags);
> +}
> +EXPORT_SYMBOL(__vfs_getxattr);
> +
> +ssize_t
> +vfs_getxattr(struct dentry *dentry, const char *name, void *value, size_t size)
> +{
> +	return __vfs_getxattr(dentry, dentry->d_inode, name, value, size, 0);
>   }
>   EXPORT_SYMBOL_GPL(vfs_getxattr);
>   
> diff --git a/fs/xfs/xfs_xattr.c b/fs/xfs/xfs_xattr.c
> index 3123b5aaad2a..cafc99c48e20 100644
> --- a/fs/xfs/xfs_xattr.c
> +++ b/fs/xfs/xfs_xattr.c
> @@ -18,7 +18,8 @@
>   
>   static int
>   xfs_xattr_get(const struct xattr_handler *handler, struct dentry *unused,
> -		struct inode *inode, const char *name, void *value, size_t size)
> +		struct inode *inode, const char *name, void *value, size_t size,
> +		int flags)
>   {
>   	int xflags = handler->flags;
>   	struct xfs_inode *ip = XFS_I(inode);
> diff --git a/include/linux/xattr.h b/include/linux/xattr.h
> index 6dad031be3c2..e5c191b30818 100644
> --- a/include/linux/xattr.h
> +++ b/include/linux/xattr.h
> @@ -30,10 +30,10 @@ struct xattr_handler {
>   	const char *prefix;
>   	int flags;      /* fs private flags */
>   	bool (*list)(struct dentry *dentry);
> -	int (*get)(const struct xattr_handler *, struct dentry *dentry,
> +	int (*get)(const struct xattr_handler *handler, struct dentry *dentry,
>   		   struct inode *inode, const char *name, void *buffer,
> -		   size_t size);
> -	int (*set)(const struct xattr_handler *, struct dentry *dentry,
> +		   size_t size, int flags);
> +	int (*set)(const struct xattr_handler *handler, struct dentry *dentry,
>   		   struct inode *inode, const char *name, const void *buffer,
>   		   size_t size, int flags);
>   };
> @@ -46,7 +46,8 @@ struct xattr {
>   	size_t value_len;
>   };
>   
> -ssize_t __vfs_getxattr(struct dentry *, struct inode *, const char *, void *, size_t);
> +ssize_t __vfs_getxattr(struct dentry *, struct inode *, const char *, void *,
> +		       size_t, int);
>   ssize_t vfs_getxattr(struct dentry *, const char *, void *, size_t);
>   ssize_t vfs_listxattr(struct dentry *d, char *list, size_t size);
>   int __vfs_setxattr(struct dentry *, struct inode *, const char *, const void *, size_t, int);
> diff --git a/include/uapi/linux/xattr.h b/include/uapi/linux/xattr.h
> index c1395b5bd432..1216d777d210 100644
> --- a/include/uapi/linux/xattr.h
> +++ b/include/uapi/linux/xattr.h
> @@ -17,8 +17,9 @@
>   #if __UAPI_DEF_XATTR
>   #define __USE_KERNEL_XATTR_DEFS
>   
> -#define XATTR_CREATE	0x1	/* set value, fail if attr already exists */
> -#define XATTR_REPLACE	0x2	/* set value, fail if attr does not exist */
> +#define XATTR_CREATE	 0x1	/* set value, fail if attr already exists */
> +#define XATTR_REPLACE	 0x2	/* set value, fail if attr does not exist */
> +#define XATTR_NOSECURITY 0x4	/* get value, do not involve security check */
>   #endif
>   
>   /* Namespaces */
> diff --git a/mm/shmem.c b/mm/shmem.c
> index 626d8c74b973..34d3818b4424 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -3206,7 +3206,8 @@ static int shmem_initxattrs(struct inode *inode,
>   
>   static int shmem_xattr_handler_get(const struct xattr_handler *handler,
>   				   struct dentry *unused, struct inode *inode,
> -				   const char *name, void *buffer, size_t size)
> +				   const char *name, void *buffer, size_t size,
> +				   int flags)
>   {
>   	struct shmem_inode_info *info = SHMEM_I(inode);
>   
> diff --git a/net/socket.c b/net/socket.c
> index 6a9ab7a8b1d2..6b0fea92dd02 100644
> --- a/net/socket.c
> +++ b/net/socket.c
> @@ -300,7 +300,8 @@ static const struct dentry_operations sockfs_dentry_operations = {
>   
>   static int sockfs_xattr_get(const struct xattr_handler *handler,
>   			    struct dentry *dentry, struct inode *inode,
> -			    const char *suffix, void *value, size_t size)
> +			    const char *suffix, void *value, size_t size,
> +			    int flags)
>   {
>   	if (value) {
>   		if (dentry->d_name.len + 1 > size)
> diff --git a/security/commoncap.c b/security/commoncap.c
> index f4ee0ae106b2..378a2f66a73d 100644
> --- a/security/commoncap.c
> +++ b/security/commoncap.c
> @@ -297,7 +297,8 @@ int cap_inode_need_killpriv(struct dentry *dentry)
>   	struct inode *inode = d_backing_inode(dentry);
>   	int error;
>   
> -	error = __vfs_getxattr(dentry, inode, XATTR_NAME_CAPS, NULL, 0);
> +	error = __vfs_getxattr(dentry, inode, XATTR_NAME_CAPS, NULL, 0,
> +			       XATTR_NOSECURITY);
>   	return error > 0;
>   }
>   
> @@ -586,7 +587,8 @@ int get_vfs_caps_from_disk(const struct dentry *dentry, struct cpu_vfs_cap_data
>   
>   	fs_ns = inode->i_sb->s_user_ns;
>   	size = __vfs_getxattr((struct dentry *)dentry, inode,
> -			      XATTR_NAME_CAPS, &data, XATTR_CAPS_SZ);
> +			      XATTR_NAME_CAPS, &data, XATTR_CAPS_SZ,
> +			      XATTR_NOSECURITY);
>   	if (size == -ENODATA || size == -EOPNOTSUPP)
>   		/* no data, that's ok */
>   		return -ENODATA;
> diff --git a/security/integrity/evm/evm_main.c b/security/integrity/evm/evm_main.c
> index f9a81b187fae..921c8f2afcaf 100644
> --- a/security/integrity/evm/evm_main.c
> +++ b/security/integrity/evm/evm_main.c
> @@ -100,7 +100,8 @@ static int evm_find_protected_xattrs(struct dentry *dentry)
>   		return -EOPNOTSUPP;
>   
>   	list_for_each_entry_rcu(xattr, &evm_config_xattrnames, list) {
> -		error = __vfs_getxattr(dentry, inode, xattr->name, NULL, 0);
> +		error = __vfs_getxattr(dentry, inode, xattr->name, NULL, 0,
> +				       XATTR_NOSECURITY);
>   		if (error < 0) {
>   			if (error == -ENODATA)
>   				continue;
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 74dd46de01b6..b0822da0658f 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -552,7 +552,8 @@ static int sb_finish_set_opts(struct super_block *sb)
>   			goto out;
>   		}
>   
> -		rc = __vfs_getxattr(root, root_inode, XATTR_NAME_SELINUX, NULL, 0);
> +		rc = __vfs_getxattr(root, root_inode, XATTR_NAME_SELINUX, NULL,
> +				    0, XATTR_NOSECURITY);
>   		if (rc < 0 && rc != -ENODATA) {
>   			if (rc == -EOPNOTSUPP)
>   				pr_warn("SELinux: (dev %s, type "
> @@ -1378,12 +1379,14 @@ static int inode_doinit_use_xattr(struct inode *inode, struct dentry *dentry,
>   		return -ENOMEM;
>   
>   	context[len] = '\0';
> -	rc = __vfs_getxattr(dentry, inode, XATTR_NAME_SELINUX, context, len);
> +	rc = __vfs_getxattr(dentry, inode, XATTR_NAME_SELINUX, context, len,
> +			    XATTR_NOSECURITY);
>   	if (rc == -ERANGE) {
>   		kfree(context);
>   
>   		/* Need a larger buffer.  Query for the right size. */
> -		rc = __vfs_getxattr(dentry, inode, XATTR_NAME_SELINUX, NULL, 0);
> +		rc = __vfs_getxattr(dentry, inode, XATTR_NAME_SELINUX, NULL, 0,
> +				    XATTR_NOSECURITY);
>   		if (rc < 0)
>   			return rc;
>   
> @@ -1394,7 +1397,7 @@ static int inode_doinit_use_xattr(struct inode *inode, struct dentry *dentry,
>   
>   		context[len] = '\0';
>   		rc = __vfs_getxattr(dentry, inode, XATTR_NAME_SELINUX,
> -				    context, len);
> +				    context, len, XATTR_NOSECURITY);
>   	}
>   	if (rc < 0) {
>   		kfree(context);
> diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
> index 4c5e5a438f8b..158b35772be1 100644
> --- a/security/smack/smack_lsm.c
> +++ b/security/smack/smack_lsm.c
> @@ -292,7 +292,8 @@ static struct smack_known *smk_fetch(const char *name, struct inode *ip,
>   	if (buffer == NULL)
>   		return ERR_PTR(-ENOMEM);
>   
> -	rc = __vfs_getxattr(dp, ip, name, buffer, SMK_LONGLABEL);
> +	rc = __vfs_getxattr(dp, ip, name, buffer, SMK_LONGLABEL,
> +			    XATTR_NOSECURITY);
>   	if (rc < 0)
>   		skp = ERR_PTR(rc);
>   	else if (rc == 0)
> @@ -3442,7 +3443,7 @@ static void smack_d_instantiate(struct dentry *opt_dentry, struct inode *inode)
>   			} else {
>   				rc = __vfs_getxattr(dp, inode,
>   					XATTR_NAME_SMACKTRANSMUTE, trattr,
> -					TRANS_TRUE_SIZE);
> +					TRANS_TRUE_SIZE, XATTR_NOSECURITY);
>   				if (rc >= 0 && strncmp(trattr, TRANS_TRUE,
>   						       TRANS_TRUE_SIZE) != 0)
>   					rc = -EINVAL;


