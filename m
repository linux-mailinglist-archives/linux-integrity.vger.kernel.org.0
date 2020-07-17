Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DD5B223267
	for <lists+linux-integrity@lfdr.de>; Fri, 17 Jul 2020 06:34:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726333AbgGQEe0 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 17 Jul 2020 00:34:26 -0400
Received: from linux.microsoft.com ([13.77.154.182]:59642 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725300AbgGQEeZ (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 17 Jul 2020 00:34:25 -0400
Received: from sequoia (162-237-133-238.lightspeed.rcsntx.sbcglobal.net [162.237.133.238])
        by linux.microsoft.com (Postfix) with ESMTPSA id D03D320B4909;
        Thu, 16 Jul 2020 21:34:23 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com D03D320B4909
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1594960464;
        bh=Vbn9Ff2ot+XxjEUmgeVaZLB/JNIZwEipBIWmuEA1DTI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sP+Iz/bYoLxwhCHUS6F7OshqABDmuyHBDVOkmmXr7mo/Pp3QjjAcS2QreT2YiJozZ
         jb/ltXDUi9ubT2wJZ5A2HrlHsC80JN0P/5FpmtJKm8pqF0VBbMLNv45/fEwfKBybf9
         QD/mWVp8nYB1QOO7aFcxtooi7F5NXZVPkbaeeiX0=
Date:   Thu, 16 Jul 2020 23:34:21 -0500
From:   Tyler Hicks <tyhicks@linux.microsoft.com>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        Prakhar Srivastava <prsriva02@gmail.com>,
        linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Janne Karhunen <janne.karhunen@gmail.com>,
        Eric Biederman <ebiederm@xmission.com>,
        kexec@lists.infradead.org,
        Casey Schaufler <casey@schaufler-ca.com>,
        Nayna Jain <nayna@linux.ibm.com>
Subject: Re: [PATCH v3 00/12] ima: Fix rule parsing bugs and extend
 KEXEC_CMDLINE rule support
Message-ID: <20200717043421.GF3673@sequoia>
References: <20200709061911.954326-1-tyhicks@linux.microsoft.com>
 <1594960293.27397.2.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1594960293.27397.2.camel@linux.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 2020-07-17 00:31:33, Mimi Zohar wrote:
> On Thu, 2020-07-09 at 01:18 -0500, Tyler Hicks wrote:
> > This series ultimately extends the supported IMA rule conditionals for
> > the KEXEC_CMDLINE hook function. As of today, there's an imbalance in
> > IMA language conditional support for KEXEC_CMDLINE rules in comparison
> > to KEXEC_KERNEL_CHECK and KEXEC_INITRAMFS_CHECK rules. The KEXEC_CMDLINE
> > rules do not support *any* conditionals so you cannot have a sequence of
> > rules like this:
> > 
> >  dont_measure func=KEXEC_KERNEL_CHECK obj_type=foo_t
> >  dont_measure func=KEXEC_INITRAMFS_CHECK obj_type=foo_t
> >  dont_measure func=KEXEC_CMDLINE obj_type=foo_t
> >  measure func=KEXEC_KERNEL_CHECK
> >  measure func=KEXEC_INITRAMFS_CHECK
> >  measure func=KEXEC_CMDLINE
> > 
> > Instead, KEXEC_CMDLINE rules can only be measured or not measured and
> > there's no additional flexibility in today's implementation of the
> > KEXEC_CMDLINE hook function.
> > 
> > With this series, the above sequence of rules becomes valid and any
> > calls to kexec_file_load() with a kernel and initramfs inode type of
> > foo_t will not be measured (that includes the kernel cmdline buffer)
> > while all other objects given to a kexec_file_load() syscall will be
> > measured. There's obviously not an inode directly associated with the
> > kernel cmdline buffer but this patch series ties the inode based
> > decision making for KEXEC_CMDLINE to the kernel's inode. I think this
> > will be intuitive to policy authors.
> > 
> > While reading IMA code and preparing to make this change, I realized
> > that the buffer based hook functions (KEXEC_CMDLINE and KEY_CHECK) are
> > quite special in comparison to longer standing hook functions. These
> > buffer based hook functions can only support measure actions and there
> > are some restrictions on the conditionals that they support. However,
> > the rule parser isn't enforcing any of those restrictions and IMA policy
> > authors wouldn't have any immediate way of knowing that the policy that
> > they wrote is invalid. For example, the sequence of rules above parses
> > successfully in today's kernel but the
> > "dont_measure func=KEXEC_CMDLINE ..." rule is incorrectly handled in
> > ima_match_rules(). The dont_measure rule is *always* considered to be a
> > match so, surprisingly, no KEXEC_CMDLINE measurements are made.
> > 
> > While making the rule parser more strict, I realized that the parser
> > does not correctly free all of the allocated memory associated with an
> > ima_rule_entry when going down some error paths. Invalid policy loaded
> > by the policy administrator could result in small memory leaks.
> > 
> > I envision patches 1-7 going to stable. The series is ordered in a way
> > that has all the fixes up front, followed by cleanups, followed by the
> > feature patch. The breakdown of patches looks like so:
> > 
> >  Memory leak fixes: 1-3
> >  Parser strictness fixes: 4-7
> >  Code cleanups made possible by the fixes: 8-11
> >  Extend KEXEC_CMDLINE rule support: 12
> 
> Thanks, Tyler.  This is a really nice patch set.  The patches are now
> in the "next-integrity-testing" branch.

Thank you for all the helpful review comments. You know where to find me
if any bugs pop up during testing. :)

Tyler

> 
> Mimi
