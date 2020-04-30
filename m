Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F5AE1C0262
	for <lists+linux-integrity@lfdr.de>; Thu, 30 Apr 2020 18:25:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726859AbgD3QZp (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 30 Apr 2020 12:25:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:35398 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726860AbgD3QZp (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 30 Apr 2020 12:25:45 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A321F20873;
        Thu, 30 Apr 2020 16:25:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588263944;
        bh=os4gyJyASyV9Bl1//dDXxv3YvH/j3vKkp6g69zvRTVo=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=Uen/x7p2E9/c4pH6LftTDc+ScUsz4cz5/91wrw5F60WJFHX50qQ28cakvaCcleFhM
         n08l65mcjivWWuYcsiAq3uV5koXl25ln+h9e6b44Zk+6OPGTNrqg5IxHKIhc7ZLMRr
         Z2AuDpKbTXd8hBUBx2DVQwION0auHo23cLEwNePY=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 7C1403522697; Thu, 30 Apr 2020 09:25:44 -0700 (PDT)
Date:   Thu, 30 Apr 2020 09:25:44 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     madhuparnabhowmik10@gmail.com
Cc:     zohar@linux.ibm.com, jmorris@namei.org, serge@hallyn.com,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, joel@joelfernandes.org,
        frextrite@gmail.com, linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [PATCH] integrity: evm: Fix RCU list related warnings.
Message-ID: <20200430162544.GT7560@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200430160205.17798-1-madhuparnabhowmik10@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200430160205.17798-1-madhuparnabhowmik10@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, Apr 30, 2020 at 09:32:05PM +0530, madhuparnabhowmik10@gmail.com wrote:
> From: Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>
> 
> This patch fixes the following warning and few other
> instances of traversal of evm_config_xattrnames list:
> 
> [   32.848432] =============================
> [   32.848707] WARNING: suspicious RCU usage
> [   32.848966] 5.7.0-rc1-00006-ga8d5875ce5f0b #1 Not tainted
> [   32.849308] -----------------------------
> [   32.849567] security/integrity/evm/evm_main.c:231 RCU-list traversed in non-reader section!!
> 
> Since entries are only added to the list and never deleted,
> use list_For_each_entry_lockless() instead of
> list_for_each_entry_rcu() for traversing the list.
> Also, add a relevant comment in evm_secfs.c to indicate this fact.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Suggested-by: Paul E. McKenney <paulmck@kernel.org>
> Signed-off-by: Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>

From an RCU viewpoint:

Acked-by: Paul E. McKenney <paulmck@kernel.org>

> ---
>  security/integrity/evm/evm_crypto.c | 2 +-
>  security/integrity/evm/evm_main.c   | 4 ++--
>  security/integrity/evm/evm_secfs.c  | 9 ++++++++-
>  3 files changed, 11 insertions(+), 4 deletions(-)
> 
> diff --git a/security/integrity/evm/evm_crypto.c b/security/integrity/evm/evm_crypto.c
> index 35682852ddea..b2dc87da5f50 100644
> --- a/security/integrity/evm/evm_crypto.c
> +++ b/security/integrity/evm/evm_crypto.c
> @@ -207,7 +207,7 @@ static int evm_calc_hmac_or_hash(struct dentry *dentry,
>  	data->hdr.length = crypto_shash_digestsize(desc->tfm);
>  
>  	error = -ENODATA;
> -	list_for_each_entry_rcu(xattr, &evm_config_xattrnames, list) {
> +	list_for_each_entry_lockless(xattr, &evm_config_xattrnames, list) {
>  		bool is_ima = false;
>  
>  		if (strcmp(xattr->name, XATTR_NAME_IMA) == 0)
> diff --git a/security/integrity/evm/evm_main.c b/security/integrity/evm/evm_main.c
> index d361d7fdafc4..0d36259b690d 100644
> --- a/security/integrity/evm/evm_main.c
> +++ b/security/integrity/evm/evm_main.c
> @@ -97,7 +97,7 @@ static int evm_find_protected_xattrs(struct dentry *dentry)
>  	if (!(inode->i_opflags & IOP_XATTR))
>  		return -EOPNOTSUPP;
>  
> -	list_for_each_entry_rcu(xattr, &evm_config_xattrnames, list) {
> +	list_for_each_entry_lockless(xattr, &evm_config_xattrnames, list) {
>  		error = __vfs_getxattr(dentry, inode, xattr->name, NULL, 0);
>  		if (error < 0) {
>  			if (error == -ENODATA)
> @@ -228,7 +228,7 @@ static int evm_protected_xattr(const char *req_xattr_name)
>  	struct xattr_list *xattr;
>  
>  	namelen = strlen(req_xattr_name);
> -	list_for_each_entry_rcu(xattr, &evm_config_xattrnames, list) {
> +	list_for_each_entry_lockless(xattr, &evm_config_xattrnames, list) {
>  		if ((strlen(xattr->name) == namelen)
>  		    && (strncmp(req_xattr_name, xattr->name, namelen) == 0)) {
>  			found = 1;
> diff --git a/security/integrity/evm/evm_secfs.c b/security/integrity/evm/evm_secfs.c
> index 39ad1038d45d..cfc3075769bb 100644
> --- a/security/integrity/evm/evm_secfs.c
> +++ b/security/integrity/evm/evm_secfs.c
> @@ -232,7 +232,14 @@ static ssize_t evm_write_xattrs(struct file *file, const char __user *buf,
>  		goto out;
>  	}
>  
> -	/* Guard against races in evm_read_xattrs */
> +	/*
> +	 * xattr_list_mutex guards against races in evm_read_xattrs().
> +	 * Entries are only added to the evm_config_xattrnames list
> +	 * and never deleted. Therefore, the list is traversed
> +	 * using list_for_each_entry_lockless() without holding
> +	 * the mutex in evm_calc_hmac_or_hash(), evm_find_protected_xattrs()
> +	 * and evm_protected_xattr().
> +	 */
>  	mutex_lock(&xattr_list_mutex);
>  	list_for_each_entry(tmp, &evm_config_xattrnames, list) {
>  		if (strcmp(xattr->name, tmp->name) == 0) {
> -- 
> 2.17.1
> 
