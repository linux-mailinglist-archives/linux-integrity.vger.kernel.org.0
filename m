Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83F754B26DA
	for <lists+linux-integrity@lfdr.de>; Fri, 11 Feb 2022 14:12:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350448AbiBKNMB (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 11 Feb 2022 08:12:01 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:44578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350451AbiBKNMB (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 11 Feb 2022 08:12:01 -0500
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFC47F69
        for <linux-integrity@vger.kernel.org>; Fri, 11 Feb 2022 05:11:58 -0800 (PST)
Received: by mail-il1-x132.google.com with SMTP id z7so6806761ilb.6
        for <linux-integrity@vger.kernel.org>; Fri, 11 Feb 2022 05:11:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7Y2G8AlF6Ncyxq64QoVe4HHceu9Q6Y6j+1knE8xr79k=;
        b=PDd/NUgnyMl0IPdr2l+PEy0J+VSrp+cpJ/egTOtYonQ6B6I8pU4OrlhS00SJXlRXZI
         Qeq2qepgDTaSC0OO/FPfTgdS1vIgmYmpR8xO4kIgb/jcOGKx2wIRWjFmW5oIK8Krv6aR
         rwCgv6ZnlgjIMkGy+f2OKP1+ypX4xS1caGo4k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7Y2G8AlF6Ncyxq64QoVe4HHceu9Q6Y6j+1knE8xr79k=;
        b=ax9ASF+8oir4lqCQEG3V4myQZdG/1g+wfSR3LRKiesCE10AsQ7BD0ALtYyCVhFaF55
         CwluGY394wUYB8ASIxn0Q6LFtLHP7wNLnCv5ivnzns9KEKzz/t9yfw32+jbuK2llXeA2
         vX3e2M0dVxZlg6vdrfm6r9UUHogZlG8QN0Du7YBG1SWiTyPByNBn8RCcdbsirs+y5Mkh
         /kWbFASL1riaxkqmcweBHHKRcXPqWJFnXmvYO3wlmzURZsKkYrZ3NaT4+rJxjuykYY+G
         /UQFN55jZXLCnEUDLt1be1jdr0+IeLXJ/Eeeg9Do2yzhO2qjFpa+ZAiaVEOpw6iUJT9H
         OnMw==
X-Gm-Message-State: AOAM531N2Hy4I00Ai8AfocKEfARvHLyLEbnZlPo78NynNrPT6QGq0de+
        +rhDDopX8Sz3aqmZxYyk2ciKMCJ0ESBV55Ogfrqcuw==
X-Google-Smtp-Source: ABdhPJwcC9ywc3Spihk7RbD5O7xNxHxMEcbEIUGne7QB9t2HjV1Twx1cR0RDE3cDFxfvXUapBKqnsYZ3Nn30iAF9rhA=
X-Received: by 2002:a05:6e02:1a47:: with SMTP id u7mr896831ilv.33.1644585118126;
 Fri, 11 Feb 2022 05:11:58 -0800 (PST)
MIME-Version: 1.0
References: <20220211104828.4061334-1-roberto.sassu@huawei.com>
 <f9ccc9be6cc084e9cab6cd75e87735492d120002.camel@linux.ibm.com> <3d0bdb4599e340a78b06094797e42bc9@huawei.com>
In-Reply-To: <3d0bdb4599e340a78b06094797e42bc9@huawei.com>
From:   Florent Revest <revest@chromium.org>
Date:   Fri, 11 Feb 2022 14:11:47 +0100
Message-ID: <CABRcYm+Mdtgqo-8uf3ys4XnuVrJ0xgsSwFD9VKeJdHJwxmN7Sg@mail.gmail.com>
Subject: Re: [PATCH] ima: Calculate digest in ima_inode_hash() if not available
To:     Roberto Sassu <roberto.sassu@huawei.com>
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
        "shuah@kernel.org" <shuah@kernel.org>,
        "ast@kernel.org" <ast@kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "andrii@kernel.org" <andrii@kernel.org>,
        "kpsingh@kernel.org" <kpsingh@kernel.org>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Florent Revest <revest@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, Feb 11, 2022 at 1:58 PM Roberto Sassu <roberto.sassu@huawei.com> wrote:
>
> > From: Mimi Zohar [mailto:zohar@linux.ibm.com]
> > Sent: Friday, February 11, 2022 1:41 PM
> > Hi Roberto,
> >
> > On Fri, 2022-02-11 at 11:48 +0100, Roberto Sassu wrote:
> > > __ima_inode_hash() checks if a digest has been already calculated by
> > > looking for the integrity_iint_cache structure associated to the passed
> > > inode.
> > >
> > > Users of ima_file_hash() and ima_inode_hash() (e.g. eBPF) might be
> > > interested in obtaining the information without having to setup an IMA
> > > policy so that the digest is always available at the time they call one of
> > > those functions.
> >
> > Things obviously changed, but the original use case for this interface,
> > as I recall, was a quick way to determine if a file had been accessed
> > on the system.

I believe we were the main users of this and I can confirm we are no
longer using this interface to determine if a file has been accessed.

> Hi Mimi
>
> thanks for the info. I was not sure if I should export a new
> function or reuse the existing one. In my use case, just calculating
> the digest would be sufficient.

It would actually be nice for us too, sometimes we attach to hooks
just before the hash is calculated and being able to calculate the
hash would be helpful.

> For finding whether a file was accessed (assuming that it matches
> the policy), probably bpf_ima_inode_hash() is not anyway too reliable.
> If integrity_iint_cache is evicted from the memory, it would report
> that the inode was not accessed even if it was.

I agree indeed, we'd have better ways to do this now.

> Thanks
>
> Roberto
>
> HUAWEI TECHNOLOGIES Duesseldorf GmbH, HRB 56063
> Managing Director: Li Peng, Zhong Ronghua
>
> > --
> > thanks,
> >
> > Mimi
>
