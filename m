Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E23F5461B89
	for <lists+linux-integrity@lfdr.de>; Mon, 29 Nov 2021 17:08:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344642AbhK2QL0 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 29 Nov 2021 11:11:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231803AbhK2QJW (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 29 Nov 2021 11:09:22 -0500
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [IPv6:2607:fcd0:100:8a00::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05899C0423B1
        for <linux-integrity@vger.kernel.org>; Mon, 29 Nov 2021 06:10:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1638195031;
        bh=/49uNFks2C499W3VwIdU10mSCnwMD/npdbEhg8wEux8=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=rjk2PfYOBvO3D8CkVBYIIyaRL7LFYyHv3Cg3mU5AueHnduQdBWVatkdhrgRv/Xt7f
         2TZeWILHAl2mSMTmFU6HPs8jN8rUAgR0UdJHENLhz1dkweInPCtOpFNmJ98Yb7eF3c
         cVq+q+JcQqmDebQVqThkMCNNv804T9yofv1H8VBM=
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id B55271280640;
        Mon, 29 Nov 2021 09:10:31 -0500 (EST)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id bl67K9LT_UuO; Mon, 29 Nov 2021 09:10:31 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1638195031;
        bh=/49uNFks2C499W3VwIdU10mSCnwMD/npdbEhg8wEux8=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=rjk2PfYOBvO3D8CkVBYIIyaRL7LFYyHv3Cg3mU5AueHnduQdBWVatkdhrgRv/Xt7f
         2TZeWILHAl2mSMTmFU6HPs8jN8rUAgR0UdJHENLhz1dkweInPCtOpFNmJ98Yb7eF3c
         cVq+q+JcQqmDebQVqThkMCNNv804T9yofv1H8VBM=
Received: from jarvis.int.hansenpartnership.com (unknown [IPv6:2601:5c4:4300:c551::c447])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 65C1712804CF;
        Mon, 29 Nov 2021 09:10:30 -0500 (EST)
Message-ID: <a74b18c1aee2b14426cc12e2fd336716c447f070.camel@HansenPartnership.com>
Subject: Re: [RFC 3/3] ima: make the integrity inode cache per namespace
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Stefan Berger <stefanb@linux.ibm.com>,
        "Serge E. Hallyn" <serge@hallyn.com>
Cc:     linux-integrity@vger.kernel.org, containers@lists.linux.dev,
        Mimi Zohar <zohar@linux.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        krzysztof.struczynski@huawei.com,
        Roberto Sassu <roberto.sassu@huawei.com>,
        Michael Peters <mpeters@redhat.com>,
        Luke Hinds <lhinds@redhat.com>,
        Lily Sturmann <lsturman@redhat.com>,
        Patrick Uiterwijk <puiterwi@redhat.com>,
        Christian Brauner <christian@brauner.io>
Date:   Mon, 29 Nov 2021 09:10:29 -0500
In-Reply-To: <70b81e62-46af-9d39-3dcb-4cfbae645175@linux.ibm.com>
References: <20211127164549.2571457-1-James.Bottomley@HansenPartnership.com>
         <20211127164549.2571457-4-James.Bottomley@HansenPartnership.com>
         <20211129045834.GB20606@mail.hallyn.com>
         <755446b10c8415fd469b814535c4a12964af3264.camel@HansenPartnership.com>
         <70b81e62-46af-9d39-3dcb-4cfbae645175@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, 2021-11-29 at 08:53 -0500, Stefan Berger wrote:
> On 11/29/21 07:50, James Bottomley wrote:
> > On Sun, 2021-11-28 at 22:58 -0600, Serge E. Hallyn wrote:
> > > On Sat, Nov 27, 2021 at 04:45:49PM +0000, James Bottomley wrote:
> > > > Currently we get one entry in the IMA log per unique file
> > > > event.  So, if you have a measurement policy and it measures a
> > > > particular binary it will not get measured again if it is
> > > > subsequently executed. For Namespaced IMA, the correct
> > > > behaviour
> > > > seems to be to log once per inode per namespace (so every
> > > > unique
> > > > execution in a namespace gets a separate log entry).  Since
> > > > logging
> > > > once per inode per namespace is
> > > I suspect I'll need to do a more in depth reading of the existing
> > > code, but I'll ask the lazy question anyway (since you say "the
> > > correct behavior seems to be") - is it actually important that
> > > files which were appraised under a parent namespace's policy
> > > already
> > > should be logged again?
> > I think so.  For a couple of reasons, assuming the namespace
> > eventually
> > gets its own log entries, which the next incremental patch proposed
> > to
> > do by virtualizing the securityfs entries.  If you don't do this:
> 
> To avoid duplicate efforts, an implementation of a virtualized 
> securityfs is in this series here:
> 
> https://github.com/stefanberger/linux-ima-namespaces/commits/v5.15%2Bimans.20211119.v3
> 
> It starts with 'securityfs: Prefix global variables with secruityfs_'

That's quite a big patch series.  I already actually implemented this
as part of the RFC for getting the per namespace measurement log.  The
attached is basically what I did.

Most of the time we don't require namespacing the actual virtualfs
file, because it's world readable.  IMA has a special requirement in
this regard because the IMA files should be readable (and writeable
when we get around to policy updates) by the admin of the namespace but
their protection is 0640 or 0440.  I thought the simplest solution
would be to make an additional flag that coped with the permissions and
a per-inode flag way of making the file as "accessible by userns
admin".  Doing something simple like this gives a much smaller
diffstat:

 fs/stat.c                |    8 ++++++++
 include/linux/fs.h       |    1 +
 include/linux/security.h |    2 +-
 kernel/capability.c      |    6 ++++--
 security/inode.c         |    6 ++++--
 5 files changed, 18 insertions(+), 5 deletions(-)

The full diff is below so you can see how I did it.  There's a sort of
serendipity bit where it turns out the next i_flag entry is at bit 17
meaning it can be overloaded on the mode which is a u16, but other than
that I think it's pretty clean.

James

---

diff --git a/fs/stat.c b/fs/stat.c
index 28d2020ba1f4..2025dfea6720 100644
--- a/fs/stat.c
+++ b/fs/stat.c
@@ -49,6 +49,14 @@ void generic_fillattr(struct user_namespace *mnt_userns, struct inode *inode,
 	stat->nlink = inode->i_nlink;
 	stat->uid = i_uid_into_mnt(mnt_userns, inode);
 	stat->gid = i_gid_into_mnt(mnt_userns, inode);
+	if (inode->i_flags & S_NSUSER) {
+		struct user_namespace *ns = current_user_ns();
+
+		if (uid_eq(stat->uid, GLOBAL_ROOT_UID))
+			stat->uid = ns->owner;
+		if (gid_eq(stat->gid, GLOBAL_ROOT_GID))
+			stat->gid = ns->group;
+	}
 	stat->rdev = inode->i_rdev;
 	stat->size = i_size_read(inode);
 	stat->atime = inode->i_atime;
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 1cb616fc1105..8bebac8463ac 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2249,6 +2249,7 @@ struct super_operations {
 #define S_ENCRYPTED	(1 << 14) /* Encrypted file (using fs/crypto/) */
 #define S_CASEFOLD	(1 << 15) /* Casefolded file */
 #define S_VERITY	(1 << 16) /* Verity file (using fs/verity/) */
+#define S_NSUSER	(1 << 17) /* uid/gid changes with user_ns */
 
 /*
  * Note that nosuid etc flags are inode-specific: setting some file-system
diff --git a/include/linux/security.h b/include/linux/security.h
index bbf44a466832..1cfe8832f5e0 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -1919,7 +1919,7 @@ static inline void security_audit_rule_free(void *lsmrule)
 
 #ifdef CONFIG_SECURITYFS
 
-extern struct dentry *securityfs_create_file(const char *name, umode_t mode,
+extern struct dentry *securityfs_create_file(const char *name, unsigned int mode,
 					     struct dentry *parent, void *data,
 					     const struct file_operations *fops);
 extern struct dentry *securityfs_create_dir(const char *name, struct dentry *parent);
diff --git a/kernel/capability.c b/kernel/capability.c
index 46a361dde042..54907ffa4947 100644
--- a/kernel/capability.c
+++ b/kernel/capability.c
@@ -506,8 +506,10 @@ bool capable_wrt_inode_uidgid(struct user_namespace *mnt_userns,
 {
 	struct user_namespace *ns = current_user_ns();
 
-	return ns_capable(ns, cap) &&
-	       privileged_wrt_inode_uidgid(ns, mnt_userns, inode);
+	if (ns_capable(ns, cap) &&
+	    privileged_wrt_inode_uidgid(ns, mnt_userns, inode))
+		return true;
+	return (inode->i_flags & S_NSUSER) && ns_capable(ns, cap);
 }
 EXPORT_SYMBOL(capable_wrt_inode_uidgid);
 
diff --git a/security/inode.c b/security/inode.c
index 6c326939750d..917514ddfce4 100644
--- a/security/inode.c
+++ b/security/inode.c
@@ -104,7 +104,7 @@ static struct file_system_type fs_type = {
  * If securityfs is not enabled in the kernel, the value %-ENODEV is
  * returned.
  */
-static struct dentry *securityfs_create_dentry(const char *name, umode_t mode,
+static struct dentry *securityfs_create_dentry(const char *name, unsigned int mode,
 					struct dentry *parent, void *data,
 					const struct file_operations *fops,
 					const struct inode_operations *iops)
@@ -112,6 +112,7 @@ static struct dentry *securityfs_create_dentry(const char *name, umode_t mode,
 	struct dentry *dentry;
 	struct inode *dir, *inode;
 	int error;
+	unsigned int flags = mode & 0xffff0000;
 
 	if (!(mode & S_IFMT))
 		mode = (mode & S_IALLUGO) | S_IFREG;
@@ -147,6 +148,7 @@ static struct dentry *securityfs_create_dentry(const char *name, umode_t mode,
 	inode->i_mode = mode;
 	inode->i_atime = inode->i_mtime = inode->i_ctime = current_time(inode);
 	inode->i_private = data;
+	inode->i_flags = flags;
 	if (S_ISDIR(mode)) {
 		inode->i_op = &simple_dir_inode_operations;
 		inode->i_fop = &simple_dir_operations;
@@ -197,7 +199,7 @@ static struct dentry *securityfs_create_dentry(const char *name, umode_t mode,
  * If securityfs is not enabled in the kernel, the value %-ENODEV is
  * returned.
  */
-struct dentry *securityfs_create_file(const char *name, umode_t mode,
+struct dentry *securityfs_create_file(const char *name, unsigned int mode,
 				      struct dentry *parent, void *data,
 				      const struct file_operations *fops)
 {

