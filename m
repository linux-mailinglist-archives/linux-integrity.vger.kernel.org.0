Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C617A1BD8FC
	for <lists+linux-integrity@lfdr.de>; Wed, 29 Apr 2020 12:04:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726457AbgD2KEk (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 29 Apr 2020 06:04:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726345AbgD2KEk (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 29 Apr 2020 06:04:40 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5926AC03C1AD
        for <linux-integrity@vger.kernel.org>; Wed, 29 Apr 2020 03:04:40 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id v2so665494plp.9
        for <linux-integrity@vger.kernel.org>; Wed, 29 Apr 2020 03:04:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=eecAU/rt9RZknTnm/PAmmN8SMXp6BryKeJ9nWNcdGRI=;
        b=ePmnNTXMGHjiW6NFQrS8b1RTYzXxRgy4Zjcd324h1xe5C6jJSY2VNE5nN9EXAlCRcG
         9g0yHLyEtHRXZPovkM7hPxtzQMVE1f6/QeBuEaw9OZLi0qWbd7l7Nz0dA6sN6+ONnNqP
         68wYyG6qiN63vAbjKppUrwtME4RlVAd/5vmO5gjOGlqQs0LFq1TOxw3DOPCuma5W9Jsv
         rwAmhQPVN89ZHQDyCSWfi3CKBHnVX+FzWxZ6zZ5Srz4B/YNBTUebK197l5gERvWebH8B
         +ugKGfLbtnuNUzwCuOklCHxKP/tse/TbRVtIPTETSw4fVwsOrSApfQqvL4w/bFYgnTbx
         k8Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=eecAU/rt9RZknTnm/PAmmN8SMXp6BryKeJ9nWNcdGRI=;
        b=GWnjgiYT9Ydc3Q0+Hgz+UDP9NNNRTOFDzKzjj1IaYf/W0byhFWbVIxnGy1Yuu0jgf0
         WdY1LvXeLG343eVfhwCu9LlQ7ueCzPusfqx1PcDDyLNvACyRP1GycS44L313fuRRFNfh
         weqHUyKgMRaIaIGHFgZ1S0DDU5G/LKa1DmnnReJKy5CIsQYU9gSi+E19GTtpnDDDpdQv
         lalDTlnbBPSMVWvSfKDDz2MCSd90kAd/fVbMD+UhH3bWSaA2ZBzEXs1e+W4IGIwTzm+c
         52b69IsVBl8d6il545u2uFdnqBDhdzsqLAHOldHZOfCn6xFMdLtAMB4M0/C8WPwEgUEY
         stZg==
X-Gm-Message-State: AGi0PuY0pK3eyuaElleFe+/r/q4P6+pwacvBY2fbiQXR7n61My5N5g4n
        6Rjpsf3M2576HIgjMfy50g==
X-Google-Smtp-Source: APiQypI7Tu7Glo2467+EyF45f/x9HpKfOrHY6a6/tlUKGw8w0uKIB8qli9TVnGoqhRpvJ8KpTAEp2A==
X-Received: by 2002:a17:90a:8a09:: with SMTP id w9mr2243621pjn.95.1588154679702;
        Wed, 29 Apr 2020 03:04:39 -0700 (PDT)
Received: from madhuparna-HP-Notebook ([2402:3a80:13a5:c7ca:2591:468a:ee81:9c85])
        by smtp.gmail.com with ESMTPSA id i128sm749978pfc.149.2020.04.29.03.04.36
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 29 Apr 2020 03:04:38 -0700 (PDT)
From:   Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>
X-Google-Original-From: Madhuparna Bhowmik <change_this_user_name@gmail.com>
Date:   Wed, 29 Apr 2020 15:34:33 +0530
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>,
        jmorris@namei.org, serge@hallyn.com,
        linux-integrity@vger.kernel.org, Matthew Garrett <mjg59@google.com>
Subject: Re: Fwd: a8d5875ce5 ("Default enable RCU list lockdep debugging with
 .."): WARNING: suspicious RCU usage
Message-ID: <20200429100432.GB3465@madhuparna-HP-Notebook>
References: <5ea3a0e3.ruR9Zw9VIGN+NGIb%lkp@intel.com>
 <CAD=jOEYd-pAQMo3hukx6AhXN7CbH8yGLVLHe2=92wCq-HWS++Q@mail.gmail.com>
 <1588035506.16086.25.camel@linux.ibm.com>
 <20200428112349.GA19116@madhuparna-HP-Notebook>
 <1588078741.5195.6.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1588078741.5195.6.camel@linux.ibm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, Apr 28, 2020 at 08:59:01AM -0400, Mimi Zohar wrote:
> On Tue, 2020-04-28 at 16:53 +0530, Madhuparna Bhowmik wrote:
> > On Mon, Apr 27, 2020 at 08:58:26PM -0400, Mimi Zohar wrote:
> > > [Cc'ing Matthew Garrett)
> > > 
> > > Hi Madhuparna,
> > > 
> > > On Sat, 2020-04-25 at 16:33 +0530, Madhuparna Bhowmik wrote:
> > > > Hi,
> > > > 
> > > > This is regarding the warning reported by kernel test bot regarding
> > > > suspicious RCU usage.
> > > > Using a simple git grep, I can only see the following usage of RCU:
> > > > 
> > > > evm_crypto.c:   list_for_each_entry_rcu(xattr, &evm_config_xattrnames,
> > > > list) {
> > > > evm_main.c:     list_for_each_entry_rcu(xattr, &evm_config_xattrnames,
> > > > list) {
> > > > evm_main.c:     list_for_each_entry_rcu(xattr, &evm_config_xattrnames,
> > > > list) {
> > > > evm_secfs.c:    list_add_tail_rcu(&xattr->list, &evm_config_xattrnames);
> > > > 
> > > > So, the evm_config_xattrnames list is traversed using
> > > > list_for_each_entry_rcu() but without the protection of rcu_read_lock()?
> > > > If these are not really RCU read-side CS, and other locks are held then
> > > > there is no need to use list_for_each_entry_rcu().
> > > > And maybe we can completely remove the usage of rcu primitives here.
> > > > Or if there is a bug and rcu_read_lock() should be held, please let me know
> > > > and I can try fixing this.
> > > 
> > > Thank you for forwarding this report.  The list of EVM xattrs is
> > > protected by the xattr_list_mutex, which is used when reading or
> > > appending to the EVM list itself.  Entries in the list can not be
> > > removed.
> > >
> > Hi Mimi,
> > 
> > Thank you for your reply.
> > So, if the list is protected by xattr_list mutex and it is used during
> > both reading and writing to the list, can we remove the usage of RCU
> > here? 
> 
> I should have said the mutex is used when cat'ing the securityfs file
> (security/integrity/evm/evm_xattrs) and when adding to the list, but
> not in the above cases when walking the list.
>
> > Since the read side critical section is already protected by the
> > xattr_list mutex, we do not need list_for_each_entry_rcu() to read the
> > list. Also, we can just simply add to the list using list_add_tail(),
> > RCU primitives are not really required here.
> > 
> > Please let me know is this is fine, and I can send a patch removing the
> > usage of RCU here.
> 
> Matthew, please correct me if I'm wrong, the reason it is safe, is not
> because there is a mutex, but because entries are never removed from
> the list.
>
Alright, I understood the case here. So entries are only added to the
tail of the list and never deleted. And that's why it is safe for
readers and writers to execute concurrently even without the mutex.

However, RCU would still complain if no lock or rcu_read_lock is not
held.

Should I cc Paul McKenney about this case, he is the RCU Maintainer and
usually replies pretty fast.
He would be able to correctly suggest how to fix the RCU usage here.

Let me know if this is okay.

Thank you,
Madhuparna

> Mimi
> 
> > > The examples, above, are all readers, which walk the EVM xattr list in
> > > order to calculate or verify a file's security.evm xattr.
> 
> 
