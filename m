Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82FDA1BEC1F
	for <lists+linux-integrity@lfdr.de>; Thu, 30 Apr 2020 00:41:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726775AbgD2Wk7 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 29 Apr 2020 18:40:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:43978 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726164AbgD2Wk7 (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 29 Apr 2020 18:40:59 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 837CB2076B;
        Wed, 29 Apr 2020 22:40:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588200058;
        bh=GhRnBsL+QK5V4gns4od1NEKF+gKG9sEUwUDysp/f7GY=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=hL8RMH+4Qxq658WNmRV8+pBggUmcTmquGi8g1ejMr8fssWz+Oxc9cENef4zDslJi2
         w8GHrHvxQ7grG0WALO4s0ZDgGdvJfapF55bODA0tp4aKRKsiFV6YASQkk55IxVfmHo
         GDhJZZTVcDsaxUFPBazpHr+JyWLBq24DANFSm3Tw=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 5C6E1352250D; Wed, 29 Apr 2020 15:40:58 -0700 (PDT)
Date:   Wed, 29 Apr 2020 15:40:58 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>
Cc:     Mimi Zohar <zohar@linux.ibm.com>, jmorris@namei.org,
        serge@hallyn.com, linux-integrity@vger.kernel.org,
        Matthew Garrett <mjg59@google.com>
Subject: Re: Fwd: a8d5875ce5 ("Default enable RCU list lockdep debugging with
 .."): WARNING: suspicious RCU usage
Message-ID: <20200429224058.GA21975@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <5ea3a0e3.ruR9Zw9VIGN+NGIb%lkp@intel.com>
 <CAD=jOEYd-pAQMo3hukx6AhXN7CbH8yGLVLHe2=92wCq-HWS++Q@mail.gmail.com>
 <1588035506.16086.25.camel@linux.ibm.com>
 <20200428112349.GA19116@madhuparna-HP-Notebook>
 <1588078741.5195.6.camel@linux.ibm.com>
 <20200429100432.GB3465@madhuparna-HP-Notebook>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200429100432.GB3465@madhuparna-HP-Notebook>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, Apr 29, 2020 at 03:34:33PM +0530, Madhuparna Bhowmik wrote:
> On Tue, Apr 28, 2020 at 08:59:01AM -0400, Mimi Zohar wrote:
> > On Tue, 2020-04-28 at 16:53 +0530, Madhuparna Bhowmik wrote:
> > > On Mon, Apr 27, 2020 at 08:58:26PM -0400, Mimi Zohar wrote:
> > > > [Cc'ing Matthew Garrett)
> > > > 
> > > > Hi Madhuparna,
> > > > 
> > > > On Sat, 2020-04-25 at 16:33 +0530, Madhuparna Bhowmik wrote:
> > > > > Hi,
> > > > > 
> > > > > This is regarding the warning reported by kernel test bot regarding
> > > > > suspicious RCU usage.
> > > > > Using a simple git grep, I can only see the following usage of RCU:
> > > > > 
> > > > > evm_crypto.c:   list_for_each_entry_rcu(xattr, &evm_config_xattrnames,
> > > > > list) {
> > > > > evm_main.c:     list_for_each_entry_rcu(xattr, &evm_config_xattrnames,
> > > > > list) {
> > > > > evm_main.c:     list_for_each_entry_rcu(xattr, &evm_config_xattrnames,
> > > > > list) {
> > > > > evm_secfs.c:    list_add_tail_rcu(&xattr->list, &evm_config_xattrnames);
> > > > > 
> > > > > So, the evm_config_xattrnames list is traversed using
> > > > > list_for_each_entry_rcu() but without the protection of rcu_read_lock()?
> > > > > If these are not really RCU read-side CS, and other locks are held then
> > > > > there is no need to use list_for_each_entry_rcu().
> > > > > And maybe we can completely remove the usage of rcu primitives here.
> > > > > Or if there is a bug and rcu_read_lock() should be held, please let me know
> > > > > and I can try fixing this.
> > > > 
> > > > Thank you for forwarding this report.  The list of EVM xattrs is
> > > > protected by the xattr_list_mutex, which is used when reading or
> > > > appending to the EVM list itself.  Entries in the list can not be
> > > > removed.
> > > >
> > > Hi Mimi,
> > > 
> > > Thank you for your reply.
> > > So, if the list is protected by xattr_list mutex and it is used during
> > > both reading and writing to the list, can we remove the usage of RCU
> > > here? 
> > 
> > I should have said the mutex is used when cat'ing the securityfs file
> > (security/integrity/evm/evm_xattrs) and when adding to the list, but
> > not in the above cases when walking the list.
> >
> > > Since the read side critical section is already protected by the
> > > xattr_list mutex, we do not need list_for_each_entry_rcu() to read the
> > > list. Also, we can just simply add to the list using list_add_tail(),
> > > RCU primitives are not really required here.
> > > 
> > > Please let me know is this is fine, and I can send a patch removing the
> > > usage of RCU here.
> > 
> > Matthew, please correct me if I'm wrong, the reason it is safe, is not
> > because there is a mutex, but because entries are never removed from
> > the list.
> >
> Alright, I understood the case here. So entries are only added to the
> tail of the list and never deleted. And that's why it is safe for
> readers and writers to execute concurrently even without the mutex.
> 
> However, RCU would still complain if no lock or rcu_read_lock is not
> held.
> 
> Should I cc Paul McKenney about this case, he is the RCU Maintainer and
> usually replies pretty fast.
> He would be able to correctly suggest how to fix the RCU usage here.
> 
> Let me know if this is okay.

Apparently, it is not necessary to CC me.  ;-)

You do of course need the code to use the RCU variants of list_add*().
And also list_for_each_entry_rcu(), as in the current code.

There are several options, none of them perfect:

1.	Add (not otherwise needed) calls to rcu_read_lock() and
	rcu_read_unlock() and leave list_for_each_entry_rcu() unchanged.

2.	Add "true" for the optional fourth argument to
	list_for_each_entry_rcu().  This will suppress the complaints,
	but would (incorrectly) continue to do so should this code change
	so as to be able to delete form this list.

3.	Switch from list_for_each_entry_rcu() to its lockless counterpart,
	list_for_each_entry_lockless().  This is simiar to #2 above, but
	at least the name lets people know that something unusual is up.

If it was my code, I would take door #3.  ;-)

							Thanx, Paul
