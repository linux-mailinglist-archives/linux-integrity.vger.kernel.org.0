Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D3DA21A3829
	for <lists+linux-integrity@lfdr.de>; Thu,  9 Apr 2020 18:41:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726846AbgDIQlo (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 9 Apr 2020 12:41:44 -0400
Received: from linux.microsoft.com ([13.77.154.182]:60572 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726583AbgDIQlo (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 9 Apr 2020 12:41:44 -0400
Received: from [10.137.106.115] (unknown [131.107.174.243])
        by linux.microsoft.com (Postfix) with ESMTPSA id 4300320B4737;
        Thu,  9 Apr 2020 09:41:41 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 4300320B4737
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1586450501;
        bh=Mpb/G/NVTOIhERILOATwSbhjL5r8uqx4pyEEjF7Z0SA=;
        h=From:Subject:To:Cc:References:Date:In-Reply-To:From;
        b=qkmKi+2l8XDp2qnTd2nU9WNUzjlc+K67NP6dvv3L7gFH/t2WtxOdu+RIW5nvC2qp0
         Npvf2YJuVRIh7HkOP4QE29w/rYbzeLOGzfxrfoi21zI662i8YMqHetZSwP44hFYjV6
         rvrOAtSNmtfaOaXynH1AhkAhrkvCogVyTGBOuw8I=
From:   Deven Bowers <deven.desai@linux.microsoft.com>
Subject: Re: [RFC PATCH v2 03/12] security: add ipe lsm policy parser and
 policy loading
To:     Jann Horn <jannh@google.com>
Cc:     agk@redhat.com, Jens Axboe <axboe@kernel.dk>, snitzer@redhat.com,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        linux-integrity@vger.kernel.org,
        linux-security-module <linux-security-module@vger.kernel.org>,
        dm-devel@redhat.com, linux-block@vger.kernel.org,
        tyhicks@linux.microsoft.com,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Sasha Levin <sashal@kernel.org>,
        jaskarankhurana@linux.microsoft.com, nramas@linux.microsoft.com,
        mdsakib@linux.microsoft.com,
        kernel list <linux-kernel@vger.kernel.org>
References: <20200406221439.1469862-1-deven.desai@linux.microsoft.com>
 <20200406221439.1469862-4-deven.desai@linux.microsoft.com>
 <CAG48ez2FfRK-ivZ0cJ4k-UqKfduQS_b2WCcD5Aj45sJKAqS58Q@mail.gmail.com>
Message-ID: <cf3ea4c8-19c8-d859-21a2-c6eb4c1755f3@linux.microsoft.com>
Date:   Thu, 9 Apr 2020 09:41:40 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CAG48ez2FfRK-ivZ0cJ4k-UqKfduQS_b2WCcD5Aj45sJKAqS58Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


On 4/7/2020 8:39 AM, Jann Horn wrote:
> On Tue, Apr 7, 2020 at 12:14 AM<deven.desai@linux.microsoft.com>  wrote:
> [...]
>> Adds the policy parser and the policy loading to IPE, along with the
>> related sysfs and securityfs entries.
> [...]
>> diff --git a/security/ipe/ipe-parse.c b/security/ipe/ipe-parse.c
> [...]
>> +/* Internal Type Definitions */
>> +enum property_priority {
>> +       other = 0,
>> +       action = 1,
>> +       op = 2,
>> +       default_action = 3,
>> +       policy_ver = 4,
>> +       policy_name = 5,
>> +};
>> +
>> +struct token {
>> +       struct list_head        next_tok;
>> +       const char              *key;
>> +       enum property_priority  key_priority;
>> +       const char              *val;
>> +};
>> +
> [...]
>> +/**
>> + * ipe_free_policy: Deallocate an ipe_policy structure.
>> + * @pol: Policy to free.
>> + */
>> +void ipe_free_policy(struct ipe_policy *pol)
>> +{
>> +       size_t i;
>> +       struct ipe_rule *ptr;
>> +       struct ipe_rule_table *op;
>> +       struct list_head *l_ptr, *l_next;
>> +
>> +       if (IS_ERR_OR_NULL(pol))
>> +               return;
>> +
>> +       for (i = 0; i < ARRAY_SIZE(pol->ops); ++i) {
>> +               op = &pol->ops[i];
>> +
>> +               list_for_each_safe(l_ptr, l_next, &op->rules) {
>> +                       ptr = list_entry(l_ptr, struct ipe_rule, next);
>> +                       list_del(l_ptr);
>> +                       ipe_free_rule(ptr);
>> +               }
>> +       }
>> +
>> +       kfree(pol->policy_name);
>> +       kfree(pol);
>> +       pol = NULL;
> What is this assignment supposed to do?

Apologies, it's a useless statement. I occasionally forget to strip this
pattern throughout my code. It's supposed to help avoid double-free
but ultimately it's useless.

>> +}
> [...]
>> diff --git a/security/ipe/ipe-policy.c b/security/ipe/ipe-policy.c
> [...]
>> +/**
>> + * ipe_is_active_policy: Determine if @policy is the currently active policy.
>> + * @policy: Policy to check if it's the active policy.
>> + *
>> + * NOTE: If this attribute is needed to be consistent over a critical section,
>> + *       do not use this function, as it does not hold the read lock over the
>> + *       entirety of the critical section.
>> + *
>> + * Return:
>> + * true - @policy is the active policy
>> + * false - @policy is not the active policy
>> + */
>> +bool ipe_is_active_policy(const struct ipe_policy *policy)
>> +{
>> +       bool result;
>> +
>> +       rcu_read_lock();
>> +
>> +       result = rcu_dereference(ipe_active_policy) == policy;
>> +
>> +       rcu_read_unlock();
> You're not actually accessing the pointer, so you can use rcu_access_pointer()
> and get rid of the rcu_read_lock()/rcu_read_unlock(). Then this helper turns
> into a one-liner.
Got it. There's several places it looks like I did this. I'll fix it all.
>> +       return result;
>> +}
>> +
>> +/**
>> + * ipe_update_active_policy: Determine if @old is the active policy, and update
>> + *                          the active policy if necessary.
>> + * @old: The previous policy that the update is trying to replace.
>> + * @new: The new policy attempting to replace @old.
>> + *
>> + * If @old is not the active policy, nothing will be done.
>> + *
>> + * Return:
>> + * 0 - OK
>> + * -EBADMSG - Invalid Policy
>> + */
>> +int ipe_update_active_policy(const struct ipe_policy *old,
>> +                            const struct ipe_policy *new)
>> +{
>> +       int rc = 0;
>> +       const struct ipe_policy *curr_policy = NULL;
>> +
>> +       /* no active policy, safe to update */
>> +       if (!ipe_active_policy)
> This should be rcu_access_pointer().
Got it.
>> +               return 0;
> [...]
>> +}
> [...]
>> diff --git a/security/ipe/ipe-secfs.c b/security/ipe/ipe-secfs.c
> [...]
>> +/**
>> + * alloc_callback: Callback given to verify_pkcs7_signature function to set
>> + *                the inner content reference and parse the policy.
>> + * @ctx: "ipe_policy_node" to set inner content, size and parsed policy of.
>> + * @data: Start of PKCS#7 inner content.
>> + * @len: Length of @data.
>> + * @asn1hdrlen: Unused.
>> + *
>> + * Return:
>> + * 0 - OK
>> + * ERR_PTR(-EBADMSG) - Invalid policy syntax
>> + * ERR_PTR(-ENOMEM) - Out of memory
>> + */
>> +static int alloc_callback(void *ctx, const void *data, size_t len,
>> +                         size_t asn1hdrlen)
>> +{
>> +       char *cpy = NULL;
>> +       struct ipe_policy *pol = NULL;
>> +       struct ipe_policy_node *n = (struct ipe_policy_node *)ctx;
>> +
>> +       n->content = (const u8 *)data;
>> +       n->content_size = len;
>> +
>> +       if (len == 0)
>> +               return -EBADMSG;
>> +
>> +       cpy = kzalloc(len + 1, GFP_KERNEL);
>> +       if (!cpy)
>> +               return -ENOMEM;
>> +
>> +       (void)strncpy(cpy, data, len);
> Shouldn't this just be memcpy()?
Good point. It won't ever be null terminated because of the
signature format, so it's effectively memcpy. I'll change it.
>> +       pol = ipe_parse_policy(cpy);
>> +       if (IS_ERR(pol)) {
>> +               kfree(cpy);
>> +               return PTR_ERR(pol);
>> +       }
>> +
>> +       n->parsed = pol;
>> +       kfree(cpy);
>> +       return 0;
>> +}
> [...]
>> +static ssize_t ipe_secfs_new_policy(struct file *f, const char __user *data,
>> +                                   size_t len, loff_t *offset)
>> +{
>> +       ssize_t rc = 0;
>> +       u8 *cpy = NULL;
>> +       ssize_t written = 0;
>> +
>> +       if (!ns_capable(current_user_ns(), CAP_MAC_ADMIN))
>> +               return -EPERM;
> Use file_ns_capable(f, &init_user_ns, CAP_MAC_ADMIN) instead, both here and
> elsewhere.
Thanks.
>> +       cpy = kzalloc(len, GFP_KERNEL);
>> +       if (!cpy) {
>> +               rc = -ENOMEM;
>> +               goto err;
>> +       }
>> +
>> +       written = simple_write_to_buffer(cpy, len, offset, data, len);
>> +       if (written < 0) {
>> +               rc = written;
>> +               goto err;
>> +       }
> This should probably be memdup_user() instead of
> kzalloc()+simple_write_to_buffer()?
I wasn't aware of memdup_user. I'll change it next iteration.
>> +       rc = ipe_build_policy_secfs_node(cpy, written);
>> +err:
>> +       kfree(cpy);
>> +       return rc < 0 ? rc : written;
>> +}
>> +
>> +/**
>> + * retrieve_backed_dentry: Retrieve a dentry with a backing inode, identified
>> + *                        by @name, under @parent.
>> + * @name: Name of the dentry under @parent.
>> + * @parent: The parent dentry to search under for @name.
>> + * @size: Length of @name.
>> + *
>> + * This takes a reference to the returned dentry. Caller needs to call dput
>> + * to drop the reference.
>> + *
>> + * Return:
>> + * valid dentry - OK
>> + * ERR_PTR - Error, see lookup_one_len_unlocked
>> + * NULL - No backing inode was found
>> + */
>> +static struct dentry *retrieve_backed_dentry(const char *name,
>> +                                            struct dentry *parent,
>> +                                            size_t size)
>> +{
>> +       int rc = 0;
>> +       struct dentry *tmp = NULL;
>> +
>> +       tmp = lookup_one_len_unlocked(name, parent, size);
>> +       if (IS_ERR(tmp)) {
>> +               rc = PTR_ERR(tmp);
>> +               goto out;
>> +       }
> You could just "return tmp;" here.
>
>> +
>> +       if (!d_really_is_positive(tmp))
>> +               goto out1;
> And here "return NULL;".
>
>> +       return tmp;
>> +out1:
>> +       tmp = NULL;
> This just sets a variable that is never read again to NULL?
Thanks, I'll fix these up.
>> +out:
>> +       return rc == 0 ? NULL : ERR_PTR(rc);
>> +}
>> +
>> +/**
>> + * ipe_secfs_del_policy: Delete a policy indicated by the name provided by
>> + *                      @data
>> + * @f: Unused.
>> + * @data: Buffer containing the policy id to delete.
>> + * @len: Length of @data.
>> + * @offset: Offset into @data.
>> + *
>> + * NOTE: Newlines are treated as part of the name, if using echo to test,
>> + * use -n to prohibit the silent addition of a newline.
>> + *
>> + * Return:
>> + * > 0 - OK
>> + * -ENOMEM - Out of memory
>> + * -EPERM - Policy is active
>> + * -ENOENT - Policy does not exist
>> + * -EPERM - if a MAC subsystem is enabled, missing CAP_MAC_ADMIN
>> + * Other - See retrieve_backed_dentry
>> + */
>> +static ssize_t ipe_secfs_del_policy(struct file *f, const char __user *data,
>> +                                   size_t len, loff_t *offset)
>> +{
>> +       ssize_t rc = 0;
>> +       char *id = NULL;
>> +       ssize_t written = 0;
>> +       struct dentry *raw = NULL;
>> +       struct dentry *content = NULL;
>> +       struct inode *policy_i = NULL;
>> +       struct dentry *policy_root = NULL;
>> +       struct inode *policies_root = NULL;
>> +       const struct ipe_policy *target = NULL;
>> +
>> +       if (!ns_capable(current_user_ns(), CAP_MAC_ADMIN))
>> +               return -EPERM;
>> +
>> +       id = kzalloc(len, GFP_KERNEL);
>> +       if (!id) {
>> +               rc = -ENOMEM;
>> +               goto out;
>> +       }
>> +
>> +       written = simple_write_to_buffer(id, len, offset, data, len);
>> +       if (written < 0) {
>> +               rc = written;
>> +               goto out;
>> +       }
>> +
>> +       policies_root = d_inode(ipe_policies_root);
>> +
>> +       policy_root = retrieve_backed_dentry(id, ipe_policies_root, written);
>> +       if (IS_ERR_OR_NULL(policy_root)) {
>> +               rc = IS_ERR(policy_root) ? PTR_ERR(policy_root) : -ENOENT;
>> +               goto out;
>> +       }
>> +
>> +       policy_i = d_inode(policy_root);
>> +
>> +       /* if the found dentry matches boot policy, fail */
>> +       if (boot_policy_node == policy_root) {
>> +               rc = -EACCES;
>> +               goto out1;
>> +       }
>> +
>> +       target = ((struct ipe_policy_node *)policy_i->i_private)->parsed;
>> +
>> +       /* fail if it's the active policy */
>> +       if (ipe_is_active_policy(target)) {
>> +               rc = -EPERM;
>> +               goto out1;
>> +       }
> Why can it not become the active policy after this check?
Ah, good catch. (The test suite just caught this as well). So this needs to
be synchronized with the active policy  functions. I'm pretty sure I should
just move the policy lock from the activation functions to be locked &
unlocked here. That'll enforce that both are checked in blocking sections.
>> +       raw = retrieve_backed_dentry(IPE_FULL_CONTENT, policy_root,
>> +                                    strlen(IPE_FULL_CONTENT));
>> +       if (IS_ERR_OR_NULL(raw)) {
>> +               rc = IS_ERR(raw) ? PTR_ERR(raw) : -ENOENT;
>> +               goto out1;
>> +       }
>> +
>> +       content = retrieve_backed_dentry(IPE_INNER_CONTENT, policy_root,
>> +                                        strlen(IPE_INNER_CONTENT));
>> +       if (IS_ERR_OR_NULL(content)) {
>> +               rc = IS_ERR(content) ? PTR_ERR(content) : -ENOENT;
>> +               goto out2;
>> +       }
>> +
>> +       inode_lock(policies_root);
>> +       ipe_free_policy_node(policy_i->i_private);
>> +       policy_i->i_private = NULL;
>> +       inode_unlock(policies_root);
>> +
>> +       dput(raw);
>> +       dput(content);
>> +       dput(policy_root);
>> +       securityfs_remove(raw);
>> +       securityfs_remove(content);
>> +       securityfs_remove(policy_root);
>> +
>> +       kfree(id);
>> +       return written;
>> +out2:
>> +       dput(raw);
>> +out1:
>> +       dput(policy_root);
>> +out:
>> +       kfree(id);
>> +       return rc;
>> +}
>> +
>> +/**
>> + * ipe_secfs_rd_policy: Read the raw content (full enveloped PKCS7) data of
>> + *                     the policy stored within the file's parent inode.
>> + * @f: File representing the securityfs entry.
>> + * @data: User mode buffer to place the raw pkcs7.
>> + * @len: Length of @data.
>> + * @offset: Offset into @data.
>> + *
>> + * Return:
>> + * > 0 - OK
>> + * -ENOMEM - Out of memory
>> + */
>> +static ssize_t ipe_secfs_rd_policy(struct file *f, char __user *data,
>> +                                  size_t size, loff_t *offset)
>> +{
>> +       ssize_t rc = 0;
>> +       size_t avail = 0;
>> +       u8 *buffer = NULL;
>> +       struct inode *root = NULL;
>> +       const struct ipe_policy_node *node = NULL;
>> +
>> +       root = d_inode(f->f_path.dentry->d_parent);
>> +
>> +       inode_lock_shared(root);
>> +       node = (const struct ipe_policy_node *)root->i_private;
>> +
>> +       avail = node->data_len;
>> +       buffer = kmemdup(node->data, avail, GFP_KERNEL);
>> +       if (!buffer) {
>> +               rc = -ENOMEM;
>> +               goto cleanup;
>> +       }
>> +
>> +       rc = simple_read_from_buffer(data, size, offset, buffer, avail);
>> +cleanup:
>> +       inode_unlock_shared(root);
> Same thing as in ipe_secfs_rd_content(): simple_read_from_buffer() needlessly
> within locked section, buffer not freed.
I don't know how I missed such an obvious memleak. I'll remove the 
unnecessary
kmemdup.
>> +
>> +       return rc;
>> +}
>> +
>> +/**
>> + * ipe_secfs_ud_policy: Update a policy in place with a new PKCS7 policy.
>> + * @f: File representing the securityfs entry.
>> + * @data: Buffer user mode to place the raw pkcs7.
>> + * @len: Length of @data.
>> + * @offset: Offset into @data.
>> + *
>> + * Return:
>> + * 0 - OK
>> + * -EBADMSG - Invalid policy format
>> + * -ENOMEM - Out of memory
>> + * -EPERM - if a MAC subsystem is enabled, missing CAP_MAC_ADMIN
>> + * -EINVAL - Incorrect policy name for this node, or version is < current
>> + */
>> +static ssize_t ipe_secfs_ud_policy(struct file *f, const char __user *data,
>> +                                  size_t len, loff_t *offset)
>> +{
>> +       ssize_t rc = 0;
>> +       u8 *cpy = NULL;
>> +       ssize_t written = 0;
>> +       struct inode *root = NULL;
>> +       struct crypto_shash *tfm = NULL;
>> +       struct ipe_policy_node *new = NULL;
>> +       struct ipe_policy_node *old = NULL;
>> +
>> +       if (!ns_capable(current_user_ns(), CAP_MAC_ADMIN))
>> +               return -EPERM;
>> +
>> +       cpy = kzalloc(len, GFP_KERNEL);
>> +       if (!cpy) {
>> +               rc = -ENOMEM;
>> +               goto out;
>> +       }
>> +
>> +       written = simple_write_to_buffer(cpy, len, offset, data, len);
>> +       if (written < 0) {
>> +               rc = written;
>> +               goto out;
>> +       }
> You'd probably be better off just doing memdup_user() here.
> simple_write_to_buffer() only makes sense if you have a buffer that can be
> continuously updated with multiple writes.
Thanks, I'll fix it.
>> +       new = ipe_alloc_policy_node(cpy, len);
>> +       if (IS_ERR(new)) {
>> +               rc = PTR_ERR(new);
>> +               goto out;
>> +       }
>> +
>> +       tfm = crypto_alloc_shash("sha1", 0, 0);
>> +       if (IS_ERR(tfm))
>> +               goto out2;
>> +
>> +       root = d_inode(f->f_path.dentry->d_parent);
>> +       inode_lock(root);
>> +
>> +       old = (struct ipe_policy_node *)root->i_private;
>> +
>> +       if (strcmp(old->parsed->policy_name, new->parsed->policy_name)) {
>> +               rc = -EINVAL;
>> +               goto out3;
>> +       }
>> +
>> +       if (!ipe_is_valid_policy(old->parsed, new->parsed)) {
>> +               rc = -EINVAL;
>> +               goto out3;
>> +       }
>> +
>> +       rc = ipe_update_active_policy(old->parsed, new->parsed);
>> +       if (rc != 0)
>> +               goto out3;
>> +
>> +       ipe_audit_policy_load(new->parsed, new->data, new->data_len, tfm);
>> +       swap(root->i_private, new);
>> +
>> +       inode_unlock(root);
>> +       kfree(cpy);
>> +       ipe_free_policy_node(new);
>> +       crypto_free_shash(tfm);
>> +
>> +       return written;
>> +out3:
>> +       inode_unlock(root);
>> +       ipe_free_policy_node(new);
>> +out2:
>> +       crypto_free_shash(tfm);
>> +out:
>> +       kfree(cpy);
>> +       return rc;
>> +}
> [...]
>> +static ssize_t ipe_secfs_rd_content(struct file *f, char __user *data,
>> +                                   size_t size, loff_t *offset)
>> +{
>> +       ssize_t rc = 0;
>> +       size_t avail = 0;
>> +       u8 *buffer = NULL;
>> +       struct inode *root = NULL;
>> +       const struct ipe_policy_node *node = NULL;
>> +
>> +       root = d_inode(f->f_path.dentry->d_parent);
>> +
>> +       inode_lock(root);
>> +       node = (const struct ipe_policy_node *)root->i_private;
>> +
>> +       avail = node->content_size;
>> +       buffer = kmemdup(node->content, avail, GFP_KERNEL);
>> +       if (!buffer) {
>> +               rc = -ENOMEM;
>> +               goto cleanup;
>> +       }
>> +
>> +       rc = simple_read_from_buffer(data, size, offset, buffer, avail);
>> +cleanup:
>> +       inode_unlock(root);
> Why are you nod doing the simple_read_from_buffer() after inode_unlock()?
> The way you're doing it now, there isn't really a point in the kmemdup() at
> all...
> Also, you'll have to free the buffer before returning.
I don't know how I missed such an obvious memleak. I'll remove the 
unnecessary
kmemdup.
>
>> +       return rc;
>> +}
> [...]
>> diff --git a/security/ipe/ipe-sysfs.c b/security/ipe/ipe-sysfs.c
> [...]
>> +static int ipe_switch_active_policy(struct ctl_table *table, int write,
>> +                                   void __user *buffer, size_t *lenp,
>> +                                   loff_t *ppos)
>> +{
>> +       int rc = 0;
>> +       char *id = NULL;
>> +       size_t size = 0;
>> +
>> +       if (write) {
>> +               id = kzalloc((*lenp) + 1, GFP_KERNEL);
>> +               if (!id)
>> +                       return -ENOMEM;
>> +
>> +               table->data = id;
>> +               table->maxlen = (*lenp) + 1;
>> +
>> +               rc = proc_dostring(table, write, buffer, lenp, ppos);
>> +               if (rc != 0)
>> +                       goto out;
>> +
>> +               rc = ipe_set_active_policy(id, strlen(id));
>> +       } else {
>> +               rcu_read_lock();
>> +               size = strlen(rcu_dereference(ipe_active_policy)->policy_name);
> Can't `ipe_active_policy` be NULL here?
>
>> +               rcu_read_unlock();
>> +
>> +               id = kzalloc(size + 1, GFP_KERNEL);
> The `+ 1` seems unnecessary.
This is actually necessary. size would point to the string without 
nullterm. strncpy
below is due to if the active policy changes: if it's bigger, then we 
truncate, if it's
smaller, we'll exit early. Either way, it's guaranteed to be null 
terminated.

Later, in proc_dostring, strlen is called, and as a result KASAN catches 
an OOB
read without the +1.
>
>> +               if (!id)
>> +                       return -ENOMEM;
>> +
>> +               rcu_read_lock();
>> +               strncpy(id, rcu_dereference(ipe_active_policy)->policy_name,
>> +                       size);
>> +               rcu_read_unlock();
>> +
>> +               table->data = id;
>> +               table->maxlen = size;
>> +
>> +               rc = proc_dostring(table, write, buffer, lenp, ppos);
>> +       }
>> +out:
>> +       kfree(id);
>> +       return rc;
>> +}
>> +
>> +#endif /* CONFIG_SECURITYFS */
> [...]
>> diff --git a/security/ipe/ipe.c b/security/ipe/ipe.c
> [...]
>> +
>> +/**
>> + * strict_parse: Kernel command line parameter to enable strict parsing of
>> + *              IPE policies - causing unrecognized properties to fail
>> + *              parsing. This breaks backwards compatibility of IPE policies,
>> + *              when enabled.
> I guess the backwards compatibility stuff is referring to an out-of-tree version
> of this series that you've already shipped?
Actually no. The backwards compatibility stuff is intended to help 
divorcing kernel updates from policy updates.
At the moment, the default behavior of IPE is to ignore any lines that 
do not parse successfully. This allows policies
written for newer versions of IPE to parse and apply successfully. Thus, 
policy can be updated without a dependency
on the kernel being updated.

If that behavior isn't desirable, then you can enable this sysctl / 
kernel command line parameter to cause the
unrecognized lines to error fatally.  Operationally, I see merits to 
both methods, at the cost of what boils down
to an if statement, so I kept this as a configurable option.
>
>> + * This is also controlled by the sysctl, "ipe.strict_parse".
>> + */
> (Also, same thing as in the other patch re sysctls and kernel command line
> parameters for the same feature.)
Yes, I am going to strip out all this.
