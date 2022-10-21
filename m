Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F19A1607927
	for <lists+linux-integrity@lfdr.de>; Fri, 21 Oct 2022 16:04:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231244AbiJUOEp (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 21 Oct 2022 10:04:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231285AbiJUOEo (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 21 Oct 2022 10:04:44 -0400
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCB4A36DCA;
        Fri, 21 Oct 2022 07:04:36 -0700 (PDT)
Received: (Authenticated sender: nicolas.bouchinet@clip-os.org)
        by mail.gandi.net (Postfix) with ESMTPSA id EA0A260006;
        Fri, 21 Oct 2022 14:04:29 +0000 (UTC)
Date:   Fri, 21 Oct 2022 16:04:28 +0200
From:   Nicolas Bouchinet <nicolas.bouchinet@clip-os.org>
To:     =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>
Cc:     linux-integrity@vger.kernel.org, philippe.trebuchet@ssi.gouv.fr,
        zohar@linux.ibm.com, dmitry.kasatkin@gmail.com,
        paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com,
        casey@schaufler-ca.com, davem@davemloft.net, lucien.xin@gmail.com,
        vgoyal@redhat.com, omosnace@redhat.com, mortonm@chromium.org,
        nicolas.bouchinet@ssi.gouv.fr, cgzones@googlemail.com,
        linux-security-module@vger.kernel.org, brauner@kernel.org,
        keescook@chromium.org
Subject: Re: [PATCH] evm: Correct inode_init_security hooks behaviors
Message-ID: <Y1Km7D8zq8Yxjtl4@archlinux>
References: <Y1FTSIo+1x+4X0LS@archlinux>
 <200a6140-78bc-d7df-11f3-93c1e8da969b@digikod.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200a6140-78bc-d7df-11f3-93c1e8da969b@digikod.net>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Mickaël, thanks for you review,

On Thu, Oct 20, 2022 at 05:14:16PM +0200, Mickaël Salaün wrote:
> 
> On 20/10/2022 15:55, Nicolas Bouchinet wrote:
> > From: Nicolas Bouchinet <nicolas.bouchinet@ssi.gouv.fr>
> > 
> > Fixes a NULL pointer dereference occuring in the
> 
> As pointed out by checkpatch.pl, there is a typo.
Taken into account.
> 
> 
> > `evm_protected_xattr_common` function of the EVM LSM. The bug is
> > triggered if a `inode_init_security` hook returns 0 without initializing
> > the given `struct xattr` fields (which is the case of BPF) and if no
> > other LSM overrides thoses fields after. This also leads to memory
> > leaks.
> 
> Could you give more details how to trigger this bug and to test this fix?
To trigger the bug, I configured a fedora VM using mkinitcpio because fedora
has every tool to configure EVM. I then injected the archlinux dracut module tree
(/usr/lib/dracut/modules.d) in it.

The only thing to do next is to configure IMA/EVM enough for it to be enabled at boot.
You may follow this https://en.opensuse.org/SDB:Ima_evm#EVM_Protection_Using_HMACs
tutorial up to the end of the "Creation of Kernel Master Key and EVM HMAC key" part.

Next, regenerate your initrd using dracut and its integrity module
`dracut --add integrity /PATH/TO/initrd --force --verbose` and reboot.

Here is the stacktrace you should get:

```
[  OK  ] Finished dracut-pre-pivot.…dracut pre-pivot and cleanup hook.
[   38.159571] BUG: kernel NULL pointer dereference, address: 0000000000000000
[   38.160155] #PF: supervisor read access in kernel mode
[   38.160567] #PF: error_code(0x0000) - not-present page
[   38.160988] PGD 0 P4D 0
[   38.161209] Oops: 0000 [#1] PREEMPT SMP NOPTI
[   38.161548] CPU: 0 PID: 1 Comm: systemd Not tainted 5.19.9-200.fc36.x86_64 #1
[   38.162112] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 0.0.0 02/06/2015
[   38.162713] RIP: 0010:strlen+0x0/0x20
[   38.163002] Code: b6 07 38 d0 74 14 48 83 c7 01 84 c0 74 05 48 39 f7 75 ec 31 c0 c3 cc cc cc cc 48 89 f8 c3 cc cc cc cc 0f 1f 84 00 00 00 00 00 <80> 3f 00 74 14 48 89 f8 48 83 c0 01 80 38 00 75 f7 48 29 f8 c3 cc
[   38.164380] RSP: 0018:ffffc9000001fcf8 EFLAGS: 00010246
[   38.164770] RAX: 0000000000000000 RBX: ffffc9000001fd78 RCX: ffffc9000001fd78
[   38.165280] RDX: ffffc9000001fd90 RSI: 0000000000000000 RDI: 0000000000000000
[   38.165813] RBP: 0000000000000000 R08: ffffc9000001fd80 R09: ffffc9000001fd88
[   38.166308] R10: 0000000000000000 R11: 0000000000000000 R12: ffff8880061c18c8
[   38.166772] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
[   38.167238] FS:  00007f59e2addb40(0000) GS:ffff88803d400000(0000) knlGS:0000000000000000
[   38.167871] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   38.168322] CR2: 0000000000000000 CR3: 000000000322e002 CR4: 0000000000370ef0
[   38.168876] Call Trace:
[   38.169088]  <TASK>
[   38.169246]  evm_protected_xattr_common+0x1a/0xb0
[   38.169610]  evm_inode_init_security+0x32/0xb0
[   38.169983]  security_inode_init_security+0xd3/0x130
[   38.170373]  ? shmem_encode_fh+0x90/0x90
[   38.170676]  shmem_symlink+0x7c/0x290
[   38.170948]  vfs_symlink+0x5d/0xe0
[   38.171229]  do_symlinkat+0xf7/0x110
[   38.171487]  __x64_sys_symlink+0x37/0x40
[   38.171779]  do_syscall_64+0x58/0x80
[   38.172071]  ? syscall_exit_to_user_mode+0x17/0x40
[   38.172462]  ? do_syscall_64+0x67/0x80
[   38.172738]  ? syscall_exit_to_user_mode+0x17/0x40
[   38.173116]  ? do_syscall_64+0x67/0x80
[   38.173405]  ? do_syscall_64+0x67/0x80
[   38.173672]  entry_SYSCALL_64_after_hwframe+0x63/0xcd
[   38.174021] RIP: 0033:0x7f59e35f405b
[   38.174309] Code: f0 ff ff 73 01 c3 48 8b 0d c2 4d 0f 00 f7 d8 64 89 01 48 83 c8 ff c3 0f 1f 84 00 00 00 00 00 f3 0f 1e fa b8 58 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 95 4d 0f 00 f7 d8 64 89 01 48
[   38.175713] RSP: 002b:00007ffc5960eb28 EFLAGS: 00000246 ORIG_RAX: 0000000000000058
[   38.176310] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f59e35f405b
[   38.176879] RDX: 000055cef7249570 RSI: 000055cbaba83260 RDI: 000055cbaba54ac0
[   38.177393] RBP: 000055cbaba5e9d0 R08: 000055cbabac04b0 R09: 0000000000000000
[   38.177968] R10: 00007ffc5960e849 R11: 0000000000000246 R12: 000055cbaba54ac0
[   38.178558] R13: 000055cbaba5e9d0 R14: 000055cbab9fae00 R15: 0000000000000001
[   38.179148]  </TASK>
[   38.179341] Modules linked in: dm_crypt crct10dif_pclmul crc32_pclmul crc32c_intel ghash_clmulni_intel serio_raw virtio_scsi qemu_fw_cfg
[   38.180224] CR2: 0000000000000000
[   38.180501] ---[ end trace 0000000000000000 ]---
[   38.180879] RIP: 0010:strlen+0x0/0x20
[   38.181177] Code: b6 07 38 d0 74 14 48 83 c7 01 84 c0 74 05 48 39 f7 75 ec 31 c0 c3 cc cc cc cc 48 89 f8 c3 cc cc cc cc 0f 1f 84 00 00 00 00 00 <80> 3f 00 74 14 48 89 f8 48 83 c0 01 80 38 00 75 f7 48 29 f8 c3 cc
[   38.182565] RSP: 0018:ffffc9000001fcf8 EFLAGS: 00010246
[   38.182944] RAX: 0000000000000000 RBX: ffffc9000001fd78 RCX: ffffc9000001fd78
[   38.183491] RDX: ffffc9000001fd90 RSI: 0000000000000000 RDI: 0000000000000000
[   38.184035] RBP: 0000000000000000 R08: ffffc9000001fd80 R09: ffffc9000001fd88
[   38.184556] R10: 0000000000000000 R11: 0000000000000000 R12: ffff8880061c18c8
[   38.185141] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
[   38.185724] FS:  00007f59e2addb40(0000) GS:ffff88803d400000(0000) knlGS:0000000000000000
[   38.186311] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   38.186775] CR2: 0000000000000000 CR3: 000000000322e002 CR4: 0000000000370ef0
[   38.187804] Kernel panic - not syncing: Attempted to kill init! exitcode=0x00000009
[   38.188443] Kernel Offset: disabled
[   38.188705] ---[ end Kernel panic - not syncing: Attempted to kill init! exitcode=0x00000009 ]---
```

> 
> 
> > 
> > Adds a `call_int_hook_xattr` macro that fetches and feed the
> > `new_xattrs` array with every called hook xattr values.
> > 
> > Adds a `evm_init_hmacs` function which init the EVM hmac using every
> > entry of the array contrary to `evm_init_hmac`.
> > 
> > Fixes the `evm_inode_init_security` function to use `evm_init_hmacs`.
> > 
> > The `MAX_LSM_EVM_XATTR` value has been raised to 5 which gives room for
> > SMACK, SELinux, Apparmor, BPF and IMA/EVM security attributes.
> > 
> > Changes the default return value of the `inode_init_security` hook
> > definition to `-EOPNOTSUPP`.
> > 
> > Changes the hook documentation to match the behavior of the LSMs using
> > it (only xattr->value is initialised with kmalloc and thus is the only
> > one that should be kfreed by the caller).
> > 
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Nicolas Bouchinet <nicolas.bouchinet@ssi.gouv.fr>
> > ---
> >   include/linux/lsm_hook_defs.h       |  2 +-
> >   include/linux/lsm_hooks.h           |  4 ++--
> >   security/integrity/evm/evm.h        |  2 ++
> >   security/integrity/evm/evm_crypto.c | 23 ++++++++++++++++++++++-
> >   security/integrity/evm/evm_main.c   | 11 ++++++-----
> >   security/security.c                 | 29 ++++++++++++++++++++++++++---
> >   6 files changed, 59 insertions(+), 12 deletions(-)
> > 
> > diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
> > index 806448173033..e5dd0c0f6345 100644
> > --- a/include/linux/lsm_hook_defs.h
> > +++ b/include/linux/lsm_hook_defs.h
> > @@ -111,7 +111,7 @@ LSM_HOOK(int, 0, path_notify, const struct path *path, u64 mask,
> >   	 unsigned int obj_type)
> >   LSM_HOOK(int, 0, inode_alloc_security, struct inode *inode)
> >   LSM_HOOK(void, LSM_RET_VOID, inode_free_security, struct inode *inode)
> > -LSM_HOOK(int, 0, inode_init_security, struct inode *inode,
> > +LSM_HOOK(int, -EOPNOTSUPP, inode_init_security, struct inode *inode,
> >   	 struct inode *dir, const struct qstr *qstr, const char **name,
> >   	 void **value, size_t *len)
> >   LSM_HOOK(int, 0, inode_init_security_anon, struct inode *inode,
> > diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
> > index 84a0d7e02176..95aff9383de1 100644
> > --- a/include/linux/lsm_hooks.h
> > +++ b/include/linux/lsm_hooks.h
> > @@ -229,8 +229,8 @@
> >    *	This hook is called by the fs code as part of the inode creation
> >    *	transaction and provides for atomic labeling of the inode, unlike
> >    *	the post_create/mkdir/... hooks called by the VFS.  The hook function
> > - *	is expected to allocate the name and value via kmalloc, with the caller
> > - *	being responsible for calling kfree after using them.
> > + *	is expected to allocate the value via kmalloc, with the caller
> > + *	being responsible for calling kfree after using it.
> >    *	If the security module does not use security attributes or does
> >    *	not wish to put a security attribute on this particular inode,
> >    *	then it should return -EOPNOTSUPP to skip this processing.
> > diff --git a/security/integrity/evm/evm.h b/security/integrity/evm/evm.h
> > index f8b8c5004fc7..a2f9886e924d 100644
> > --- a/security/integrity/evm/evm.h
> > +++ b/security/integrity/evm/evm.h
> > @@ -60,6 +60,8 @@ int evm_calc_hash(struct dentry *dentry, const char *req_xattr_name,
> >   		  struct evm_digest *data);
> >   int evm_init_hmac(struct inode *inode, const struct xattr *xattr,
> >   		  char *hmac_val);
> > +int evm_init_hmacs(struct inode *inode, const struct xattr *xattrs,
> > +		  char *hmac_val);
> >   int evm_init_secfs(void);
> >   #endif
> > diff --git a/security/integrity/evm/evm_crypto.c b/security/integrity/evm/evm_crypto.c
> > index 708de9656bbd..e5a34306cab6 100644
> > --- a/security/integrity/evm/evm_crypto.c
> > +++ b/security/integrity/evm/evm_crypto.c
> > @@ -347,7 +347,6 @@ static int evm_is_immutable(struct dentry *dentry, struct inode *inode)
> >   	return rc;
> >   }
> > -
> 
> This kind of cosmetic change should not be part of this patch.
Removed, thanks.
> 
> 
> >   /*
> >    * Calculate the hmac and update security.evm xattr
> >    *
> > @@ -385,6 +384,28 @@ int evm_update_evmxattr(struct dentry *dentry, const char *xattr_name,
> >   	return rc;
> >   }
> > +int evm_protected_xattr(const char *req_xattr_name);
> > +
> > +int evm_init_hmacs(struct inode *inode, const struct xattr *lsm_xattrs,
> > +		  char *hmac_val)
> > +{
> > +	struct shash_desc *desc;
> > +
> > +	desc = init_desc(EVM_XATTR_HMAC, HASH_ALGO_SHA1);
> > +	if (IS_ERR(desc)) {
> > +		pr_info("init_desc failed\n");
> > +		return PTR_ERR(desc);
> > +	}
> > +
> > +	for (int i = 0; lsm_xattrs[i].value != NULL; i++) {
> > +		if (evm_protected_xattr(lsm_xattrs[i].name))
> > +			crypto_shash_update(desc, lsm_xattrs[i].value, lsm_xattrs[i].value_len);
> > +	}
> > +	hmac_add_misc(desc, inode, EVM_XATTR_HMAC, hmac_val);
> > +	kfree(desc);
> > +	return 0;
> > +}
> > +
> >   int evm_init_hmac(struct inode *inode, const struct xattr *lsm_xattr,
> >   		  char *hmac_val)
> >   {
> > diff --git a/security/integrity/evm/evm_main.c b/security/integrity/evm/evm_main.c
> > index 2e6fb6e2ffd2..bb071c55d656 100644
> > --- a/security/integrity/evm/evm_main.c
> > +++ b/security/integrity/evm/evm_main.c
> > @@ -284,6 +284,8 @@ static int evm_protected_xattr_common(const char *req_xattr_name,
> >   	int found = 0;
> >   	struct xattr_list *xattr;
> > +	if (!req_xattr_name)
> > +		return found;
> >   	namelen = strlen(req_xattr_name);
> >   	list_for_each_entry_lockless(xattr, &evm_config_xattrnames, list) {
> >   		if (!all_xattrs && !xattr->enabled)
> > @@ -305,7 +307,7 @@ static int evm_protected_xattr_common(const char *req_xattr_name,
> >   	return found;
> >   }
> > -static int evm_protected_xattr(const char *req_xattr_name)
> > +int evm_protected_xattr(const char *req_xattr_name)
> >   {
> >   	return evm_protected_xattr_common(req_xattr_name, false);
> >   }
> > @@ -835,14 +837,13 @@ void evm_inode_post_setattr(struct dentry *dentry, int ia_valid)
> >    * evm_inode_init_security - initializes security.evm HMAC value
> >    */
> >   int evm_inode_init_security(struct inode *inode,
> > -				 const struct xattr *lsm_xattr,
> > +				 const struct xattr *lsm_xattrs,
> >   				 struct xattr *evm_xattr)
> >   {
> >   	struct evm_xattr *xattr_data;
> >   	int rc;
> > -	if (!(evm_initialized & EVM_INIT_HMAC) ||
> > -	    !evm_protected_xattr(lsm_xattr->name))
> > +	if (!(evm_initialized & EVM_INIT_HMAC))
> >   		return 0;
> >   	xattr_data = kzalloc(sizeof(*xattr_data), GFP_NOFS);
> > @@ -850,7 +851,7 @@ int evm_inode_init_security(struct inode *inode,
> >   		return -ENOMEM;
> >   	xattr_data->data.type = EVM_XATTR_HMAC;
> > -	rc = evm_init_hmac(inode, lsm_xattr, xattr_data->digest);
> > +	rc = evm_init_hmacs(inode, lsm_xattrs, xattr_data->digest);
> >   	if (rc < 0)
> >   		goto out;
> > diff --git a/security/security.c b/security/security.c
> > index 14d30fec8a00..47012c118536 100644
> > --- a/security/security.c
> > +++ b/security/security.c
> > @@ -30,7 +30,7 @@
> >   #include <linux/msg.h>
> >   #include <net/flow.h>
> > -#define MAX_LSM_EVM_XATTR	2
> > +#define MAX_LSM_EVM_XATTR	5
> 
> I looks like AppArmor is not using the inode_init_security hook. There
> should be a comment explaining why this number is correct, and a runtime
> check (given that a static_assert call is not possible in this case) to make
> sure this is correct at boot time, maybe in security_init().

Your right, sorry for this, I took this into account and removed AppArmor from the count.
> 
> 
> >   /* How many LSMs were built into the kernel? */
> >   #define LSM_COUNT (__end_lsm_info - __start_lsm_info)
> > @@ -746,6 +746,29 @@ static int lsm_superblock_alloc(struct super_block *sb)
> >   	RC;							\
> >   })
> > +#define call_int_hook_xattr(XATTRS, FUNC, IRC, ...) ({		\
> > +	int RC = IRC;						\
> > +	int i = 0;						\
> > +	do {							\
> > +		struct security_hook_list *P;			\
> > +								\
> > +		hlist_for_each_entry(P, &security_hook_heads.FUNC, list) { \
> > +			RC = P->hook.FUNC(__VA_ARGS__);		\
> > +			if (RC == -EOPNOTSUPP)			\
> > +				continue;			\
> > +			if (RC != 0 && RC != IRC)		\
> > +				break;				\
> > +			if (i >= MAX_LSM_EVM_XATTR) {		\
> 
> You can use `if (WARN_ON_ONCE(i >= MAX_LSM_EVM_XATTR))` instead.
Neat, done.
> 
> 
> > +				RC = -ENOMEM;			\
> > +				break;				\
> > +			}					\
> > +			XATTRS++;				\
> > +			i++;					\
> > +		}						\
> > +	} while (0);						\
> > +	RC;							\
> > +})
> 
> The content of this macro can be included in its only caller:
> security_inode_init_security().
Casey and Paul also asked for this, taken into account.
> 
> 
> > +
> >   /* Security operations */
> >   int security_binder_set_context_mgr(const struct cred *mgr)
> > @@ -1103,7 +1126,7 @@ int security_inode_init_security(struct inode *inode, struct inode *dir,
> >   				     dir, qstr, NULL, NULL, NULL);
> >   	memset(new_xattrs, 0, sizeof(new_xattrs));
> >   	lsm_xattr = new_xattrs;
> > -	ret = call_int_hook(inode_init_security, -EOPNOTSUPP, inode, dir, qstr,
> > +	ret = call_int_hook_xattr(lsm_xattr, inode_init_security, -EOPNOTSUPP, inode, dir, qstr,
> >   						&lsm_xattr->name,
> >   						&lsm_xattr->value,
> >   						&lsm_xattr->value_len);
> > @@ -1111,7 +1134,7 @@ int security_inode_init_security(struct inode *inode, struct inode *dir,
> >   		goto out;
> >   	evm_xattr = lsm_xattr + 1;
> > -	ret = evm_inode_init_security(inode, lsm_xattr, evm_xattr);
> > +	ret = evm_inode_init_security(inode, new_xattrs, evm_xattr);
> >   	if (ret)
> >   		goto out;
> >   	ret = initxattrs(inode, new_xattrs, fs_data);
> 
> This looks good overall.

Thanks for your time,

Best regards,

Nicolas Bouchinet
