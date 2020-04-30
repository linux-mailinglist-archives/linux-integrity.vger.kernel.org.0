Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD2B61BFFB7
	for <lists+linux-integrity@lfdr.de>; Thu, 30 Apr 2020 17:09:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726440AbgD3PJF (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 30 Apr 2020 11:09:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726350AbgD3PJE (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 30 Apr 2020 11:09:04 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C386CC035494
        for <linux-integrity@vger.kernel.org>; Thu, 30 Apr 2020 08:09:04 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id h11so2333275plr.11
        for <linux-integrity@vger.kernel.org>; Thu, 30 Apr 2020 08:09:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=eDnD9IRIQN5g5WsjAy+4pyw6YtLUp83s4No4obkJnAc=;
        b=OpLONVg3vRRdaSTUT4onP2yxoUat1xvbw+y+tzNZF5y58o8qCqxj4ujKUEAtaaapXm
         Wxa9oXUf8fvRyKbYTc2+sP6KXSyNYR9YMH1feCntR15TaSm7TQ4gGvIB6Aiue3PLNdqf
         6L7p3Uv8TUpQEVM6GnkJP29IA5CbPJVamPkYSuiXpCMQ0Qg6iqOXFGvlBPf5NZTPKYML
         dZPxaSrsXC3DqUDvUx8/QgPJQtLz9NPosfSV3Npa8PvJKyGM5qphacebxAaECUBlHeKW
         ezQtz+ElIRaxnexv7qs8POPxSwDi9u7DKVssIuDfrrYKD+WDf0Q8QMMDeX6u4v8L9oal
         58zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=eDnD9IRIQN5g5WsjAy+4pyw6YtLUp83s4No4obkJnAc=;
        b=bm3d0QExSbXC0r4J39MrkfUckwd3RRFbbIP8wc+wyPy1rzG/c3MuEzDFgSu1u97hUM
         yjKQkZxCGpE2B/JJTv8Z12YgOMaWThzwco0Bc5LL4S6nN3/SKHtZ9r8ezqslrZSOLFye
         kO9vjbg3KUedZ2Zw+ZFHnMMJFBaqRgjXDo5FBSy+47MW5atlFwnURZOVufuZZv8fOMfR
         BaZbXomymUpQO4l1/DNzdw3l/cOMVsc0Man8Td62ptt6P/76jteEX6C82KxBqtc81gnR
         +E/nSr9DxejiyLwoJc4YLY4Gj+n7GRqNAJz7FUF0WLVUJyzA1G9NhBKndUTTloPFTfo2
         rl9Q==
X-Gm-Message-State: AGi0PuYucT1fpvkNA2UBjRhDfSZXctGmbF3a9OooyVf5Er+p9JUxU8e1
        ScV8QHqovZ3ZHoVcvT/Hxw==
X-Google-Smtp-Source: APiQypJZDlJYrXNPbUfvryIIOyhmONswgkJPRR6dPku1KPyNvH8SPAk+CXKTbSJAYM8srF7hRLY9Dg==
X-Received: by 2002:a17:90a:e382:: with SMTP id b2mr3512666pjz.110.1588259344235;
        Thu, 30 Apr 2020 08:09:04 -0700 (PDT)
Received: from madhuparna-HP-Notebook ([2402:3a80:d32:dd79:2591:468a:ee81:9c85])
        by smtp.gmail.com with ESMTPSA id m129sm137719pga.47.2020.04.30.08.09.00
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 30 Apr 2020 08:09:03 -0700 (PDT)
From:   Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>
X-Google-Original-From: Madhuparna Bhowmik <change_this_user_name@gmail.com>
Date:   Thu, 30 Apr 2020 20:38:57 +0530
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, jmorris@namei.org,
        serge@hallyn.com, linux-integrity@vger.kernel.org,
        Matthew Garrett <mjg59@google.com>
Subject: Re: Fwd: a8d5875ce5 ("Default enable RCU list lockdep debugging with
 .."): WARNING: suspicious RCU usage
Message-ID: <20200430150857.GA30198@madhuparna-HP-Notebook>
References: <5ea3a0e3.ruR9Zw9VIGN+NGIb%lkp@intel.com>
 <CAD=jOEYd-pAQMo3hukx6AhXN7CbH8yGLVLHe2=92wCq-HWS++Q@mail.gmail.com>
 <1588035506.16086.25.camel@linux.ibm.com>
 <20200428112349.GA19116@madhuparna-HP-Notebook>
 <1588078741.5195.6.camel@linux.ibm.com>
 <20200429100432.GB3465@madhuparna-HP-Notebook>
 <20200429224058.GA21975@paulmck-ThinkPad-P72>
 <20200430130713.GA27353@madhuparna-HP-Notebook>
 <1588253550.5167.26.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1588253550.5167.26.camel@linux.ibm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, Apr 30, 2020 at 09:32:30AM -0400, Mimi Zohar wrote:
> On Thu, 2020-04-30 at 18:37 +0530, Madhuparna Bhowmik wrote:
> > On Wed, Apr 29, 2020 at 03:40:58PM -0700, Paul E. McKenney wrote:
> > > You do of course need the code to use the RCU variants of list_add*().
> > > And also list_for_each_entry_rcu(), as in the current code.
> > > 
> > > There are several options, none of them perfect:
> > > 
> > > 1.	Add (not otherwise needed) calls to rcu_read_lock() and
> > > 	rcu_read_unlock() and leave list_for_each_entry_rcu() unchanged.
> > > 
> > > 2.	Add "true" for the optional fourth argument to
> > > 	list_for_each_entry_rcu().  This will suppress the complaints,
> > > 	but would (incorrectly) continue to do so should this code change
> > > 	so as to be able to delete form this list.
> > > 
> > > 3.	Switch from list_for_each_entry_rcu() to its lockless counterpart,
> > > 	list_for_each_entry_lockless().  This is simiar to #2 above, but
> > > 	at least the name lets people know that something unusual is up.
> > > 
> > > If it was my code, I would take door #3.  ;-)
> > >
> > Thanks a lot for your inputs on this. I will send a patch soon.
> 
> Please remember to expand the "mutex" comment in evm_write_xattrs() to
> reflect the reason why using list_for_each_entry_lockless() is safe.
> 
Sure.

Thank you,
Madhuparna
> 
> Mimi
