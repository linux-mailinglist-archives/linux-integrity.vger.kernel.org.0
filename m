Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90B2A1BF8E8
	for <lists+linux-integrity@lfdr.de>; Thu, 30 Apr 2020 15:07:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726577AbgD3NHW (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 30 Apr 2020 09:07:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726550AbgD3NHW (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 30 Apr 2020 09:07:22 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13ADAC035494
        for <linux-integrity@vger.kernel.org>; Thu, 30 Apr 2020 06:07:22 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id d17so2731757pgo.0
        for <linux-integrity@vger.kernel.org>; Thu, 30 Apr 2020 06:07:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=CcVOTUYol0NCgULvl93TmX1ODnAfanF8/D5ynsHeXO8=;
        b=jnmysYTHWuWQMez91pp9vQPxJIvh1v5dTJlMMKpJ6U8AasVD66vOc41n5cgO6ihkZE
         /8EQzscpopSW1UXVFcjpjGr+lzb0T39CQ3XX2zQIf5f2/otYxnrg0pLzbtalGRLFVGrq
         LOKDF4P0POqTgN0zzDoc7orDdehuifhheADoD2GNNNXOTqNOxVcoZUfub2BRAScmKvfc
         OsbhO7u6mKlGN5Nhi2E9mB73lCACQB/iRXX0vBSPlTu80Q+pHnQN2wE9YPP3d/yVSmJY
         z0Y4Vri4K7vRZRTbMrHW3q/rUjj7XW8YKAMB1LbUMdI1bkeITPsY5IfdpokHLfKWqOAS
         B9+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=CcVOTUYol0NCgULvl93TmX1ODnAfanF8/D5ynsHeXO8=;
        b=eWUq99zK+cx+zmiW7++GO2Q6x4gGjNd3rUBKozq4G7cGxqkT8WmitQfIpWtLCUuYhI
         RRWmDgEETwXieJF7UefO6P4wnGCpT2E8MxtdaR4v7m8mfvd82P11WmlW+nfkGUzwQ2he
         SMRq98YegNakwlB1kSnQB52X68hrkFEJQlnW+7qDPMe2iMgmnCaDw+BqB+efG5Aav6+a
         Q3AA4HTvtt+ZPASCQc+nhJmeg4/dpQIgaPWt/E7JkW3NghnYCJDPwDhpldpc/lgrxWBB
         dl45FVkQc/1AEhAb58PwVQu4bTgRc5c7ZAq9DswZaLYyCXcHej0e9YbCMFZIPrHO0XHs
         O+ZQ==
X-Gm-Message-State: AGi0PuaPmdM3C9NIHicyoFjJ9XmuFTBrwFIvtyeDGcsG70IyxZh/w9iJ
        xOMHV+tNJQWiUPfQZGf3DXBB1Js=
X-Google-Smtp-Source: APiQypIxMtu6bn/ynfrXeUUIIO4f6UqwLoSoNAtpC3EXsW1YXhj98rxGdOEihC5BIW5rTH5vENZlsQ==
X-Received: by 2002:a62:13:: with SMTP id 19mr3347185pfa.64.1588252041407;
        Thu, 30 Apr 2020 06:07:21 -0700 (PDT)
Received: from madhuparna-HP-Notebook ([2402:3a80:13bf:e3d3:2591:468a:ee81:9c85])
        by smtp.gmail.com with ESMTPSA id d20sm3227366pgl.72.2020.04.30.06.07.16
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 30 Apr 2020 06:07:19 -0700 (PDT)
From:   Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>
X-Google-Original-From: Madhuparna Bhowmik <change_this_user_name@gmail.com>
Date:   Thu, 30 Apr 2020 18:37:13 +0530
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>,
        Mimi Zohar <zohar@linux.ibm.com>, jmorris@namei.org,
        serge@hallyn.com, linux-integrity@vger.kernel.org,
        Matthew Garrett <mjg59@google.com>
Subject: Re: Fwd: a8d5875ce5 ("Default enable RCU list lockdep debugging with
 .."): WARNING: suspicious RCU usage
Message-ID: <20200430130713.GA27353@madhuparna-HP-Notebook>
References: <5ea3a0e3.ruR9Zw9VIGN+NGIb%lkp@intel.com>
 <CAD=jOEYd-pAQMo3hukx6AhXN7CbH8yGLVLHe2=92wCq-HWS++Q@mail.gmail.com>
 <1588035506.16086.25.camel@linux.ibm.com>
 <20200428112349.GA19116@madhuparna-HP-Notebook>
 <1588078741.5195.6.camel@linux.ibm.com>
 <20200429100432.GB3465@madhuparna-HP-Notebook>
 <20200429224058.GA21975@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200429224058.GA21975@paulmck-ThinkPad-P72>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, Apr 29, 2020 at 03:40:58PM -0700, Paul E. McKenney wrote:
> On Wed, Apr 29, 2020 at 03:34:33PM +0530, Madhuparna Bhowmik wrote:
> > On Tue, Apr 28, 2020 at 08:59:01AM -0400, Mimi Zohar wrote:
> > > On Tue, 2020-04-28 at 16:53 +0530, Madhuparna Bhowmik wrote:
> > > > On Mon, Apr 27, 2020 at 08:58:26PM -0400, Mimi Zohar wrote:
> > > > > [Cc'ing Matthew Garrett)
> > > > > 
> > > > > Hi Madhuparna,
> > > > > 
> > > > > On Sat, 2020-04-25 at 16:33 +0530, Madhuparna Bhowmik wrote:
> > > > > > Hi,
> > > > > > 
> > > > > > This is regarding the warning reported by kernel test bot regarding
> > > > > > suspicious RCU usage.
> > > > > > Using a simple git grep, I can only see the following usage of RCU:
> > > > > > 
> > > > > > evm_crypto.c:   list_for_each_entry_rcu(xattr, &evm_config_xattrnames,
> > > > > > list) {
> > > > > > evm_main.c:     list_for_each_entry_rcu(xattr, &evm_config_xattrnames,
> > > > > > list) {
> > > > > > evm_main.c:     list_for_each_entry_rcu(xattr, &evm_config_xattrnames,
> > > > > > list) {
> > > > > > evm_secfs.c:    list_add_tail_rcu(&xattr->list, &evm_config_xattrnames);
> > > > > > 
> > > > > > So, the evm_config_xattrnames list is traversed using
> > > > > > list_for_each_entry_rcu() but without the protection of rcu_read_lock()?
> > > > > > If these are not really RCU read-side CS, and other locks are held then
> > > > > > there is no need to use list_for_each_entry_rcu().
> > > > > > And maybe we can completely remove the usage of rcu primitives here.
> > > > > > Or if there is a bug and rcu_read_lock() should be held, please let me know
> > > > > > and I can try fixing this.
> > > > > 
> > > > > Thank you for forwarding this report.  The list of EVM xattrs is
> > > > > protected by the xattr_list_mutex, which is used when reading or
> > > > > appending to the EVM list itself.  Entries in the list can not be
> > > > > removed.
> > > > >
> > > > Hi Mimi,
> > > > 
> > > > Thank you for your reply.
> > > > So, if the list is protected by xattr_list mutex and it is used during
> > > > both reading and writing to the list, can we remove the usage of RCU
> > > > here? 
> > > 
> > > I should have said the mutex is used when cat'ing the securityfs file
> > > (security/integrity/evm/evm_xattrs) and when adding to the list, but
> > > not in the above cases when walking the list.
> > >
> > > > Since the read side critical section is already protected by the
> > > > xattr_list mutex, we do not need list_for_each_entry_rcu() to read the
> > > > list. Also, we can just simply add to the list using list_add_tail(),
> > > > RCU primitives are not really required here.
> > > > 
> > > > Please let me know is this is fine, and I can send a patch removing the
> > > > usage of RCU here.
> > > 
> > > Matthew, please correct me if I'm wrong, the reason it is safe, is not
> > > because there is a mutex, but because entries are never removed from
> > > the list.
> > >
> > Alright, I understood the case here. So entries are only added to the
> > tail of the list and never deleted. And that's why it is safe for
> > readers and writers to execute concurrently even without the mutex.
> > 
> > However, RCU would still complain if no lock or rcu_read_lock is not
> > held.
> > 
> > Should I cc Paul McKenney about this case, he is the RCU Maintainer and
> > usually replies pretty fast.
> > He would be able to correctly suggest how to fix the RCU usage here.
> > 
> > Let me know if this is okay.
> 
> Apparently, it is not necessary to CC me.  ;-)
>
Surprised!

> You do of course need the code to use the RCU variants of list_add*().
> And also list_for_each_entry_rcu(), as in the current code.
> 
> There are several options, none of them perfect:
> 
> 1.	Add (not otherwise needed) calls to rcu_read_lock() and
> 	rcu_read_unlock() and leave list_for_each_entry_rcu() unchanged.
> 
> 2.	Add "true" for the optional fourth argument to
> 	list_for_each_entry_rcu().  This will suppress the complaints,
> 	but would (incorrectly) continue to do so should this code change
> 	so as to be able to delete form this list.
> 
> 3.	Switch from list_for_each_entry_rcu() to its lockless counterpart,
> 	list_for_each_entry_lockless().  This is simiar to #2 above, but
> 	at least the name lets people know that something unusual is up.
> 
> If it was my code, I would take door #3.  ;-)
>
Thanks a lot for your inputs on this. I will send a patch soon.

Regards,
Madhuparna
> 							Thanx, Paul
