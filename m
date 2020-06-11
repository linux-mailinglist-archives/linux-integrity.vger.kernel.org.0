Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 295151F5FEC
	for <lists+linux-integrity@lfdr.de>; Thu, 11 Jun 2020 04:19:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726441AbgFKCTY (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 10 Jun 2020 22:19:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726163AbgFKCTY (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 10 Jun 2020 22:19:24 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68239C08C5C1
        for <linux-integrity@vger.kernel.org>; Wed, 10 Jun 2020 19:19:22 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id d15so2807573edm.10
        for <linux-integrity@vger.kernel.org>; Wed, 10 Jun 2020 19:19:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YLqWW0R38/Z8PvUhsNci04vzswKiWQOvW+gGqv0nQGo=;
        b=ERxOC+8sNWQJskSMx3stg22jmrva1f8keD8J09i7UzdOcEXkK0n6mndH+NiPAXfX5X
         yS0VoaPH8YMLbq9FcNPiSsFhrFp+tj8uzFBz6tjX+fORNNgCgwmopXdBlP0f12QSBe18
         FR272BnybQ6mzTw2hCoeJRbP5xTRc1Fs2SoBRDWHed+ViHVPh+bHeJ/iBweWRHuiztJT
         XoJYGxvP5vRVRakFdb1s+TGZjhSItRlGZki3i1+AO6lX1WsWN5/IbEkvKYSGRSfntlXx
         u5Bs/HwUMt0ArlKTRqVOxh0+ZxBtzUe+ysUFf+COPUeQOCzOpsjmoUUquqBtg7u+v24o
         pVbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YLqWW0R38/Z8PvUhsNci04vzswKiWQOvW+gGqv0nQGo=;
        b=Gj2U/AH7ZpuXtuCL5E+bi26PsRkzLbPCdr2Ck5QCumkUp7bkqb9zoMn5Og4gImK9lp
         cKLatPBfmH9JDjKm5umzg7eT+mdxMFdUddyYK3/A24y3MIHerNqxzvEEGBeWNLDYpSzM
         KEr5+m+OPyMHOrkvNuRNnf+kob7J/HhBuYNFbUIM9E2GT6scC8NZYBif7zMT4O2pcfe1
         gdP55Zdbu/hNYcG2y4EuOl7B8SKsa+L15EPy8Ow9a1weNZXoJb3GtSJ4i6UBXfqK7n/m
         +BrtdHte9wAyo2A+OUmv8p+B93tzC4Xhab2oe2UV9I/uU79Vbho8xxwdZeR066acE6vk
         IGrw==
X-Gm-Message-State: AOAM533yB/fG36gDfXxspPeXmKwjbIqGDnwjk8BmkSUs6erPuagFCOW9
        LTMpLQrid5Qj5moFp+BINXWOlo1YY/SP/DN6jTwH
X-Google-Smtp-Source: ABdhPJx4K3nSbSZ4Yqt038h06TxmyoVYplISHIXhvrr/n3PL3cOiKIIx0iPc+IzcO+GSCsswHksOCSDbxryz5RDEjVg=
X-Received: by 2002:a05:6402:3ca:: with SMTP id t10mr5177275edw.128.1591841961040;
 Wed, 10 Jun 2020 19:19:21 -0700 (PDT)
MIME-Version: 1.0
References: <20200611000400.3771-1-nramas@linux.microsoft.com>
 <CAHC9VhTZb_evUcdygs6MHP73Bi_r3esxV6+Ko6VDpncfmLYEZw@mail.gmail.com> <5cc042be-a3cf-ae39-c4f5-e474d02c0613@linux.microsoft.com>
In-Reply-To: <5cc042be-a3cf-ae39-c4f5-e474d02c0613@linux.microsoft.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 10 Jun 2020 22:19:10 -0400
Message-ID: <CAHC9VhRAc3oCUhZmwbup6ivN3A_AMiBDxgjME_Ly75qY_doLVw@mail.gmail.com>
Subject: Re: [PATCH 1/2] integrity: Add errno field in audit message
To:     Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Cc:     zohar@linux.ibm.com, sgrubb@redhat.com, rgb@redhat.com,
        linux-integrity@vger.kernel.org, linux-audit@redhat.com,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, Jun 10, 2020 at 9:58 PM Lakshmi Ramasubramanian
<nramas@linux.microsoft.com> wrote:
> On 6/10/20 6:45 PM, Paul Moore wrote:
>
> Hi Paul,
>
> > I'm sorry I didn't get a chance to mention this before you posted this
> > patch, but for the past several years we have been sticking with a
> > policy of only adding new fields to the end of existing records;
> > please adjust this patch accordingly.  Otherwise, this looks fine to
> > me.
> >
> >>          audit_log_untrustedstring(ab, get_task_comm(name, current));
> >>          if (fname) {
> >>                  audit_log_format(ab, " name=");
> >> --
>
> Steve mentioned that since this new field "errno" is not a searchable
> entry, it can be added anywhere in the audit log message.

Steve and I have a different opinion on this issue.  I won't rehash
the long argument or drag you into it, but I will just say that the
*kernel* has had a policy of only adding fields to the end of existing
records unless under extreme cases (this is not an extreme case).

> But I have no problem moving this to the end of the audit record.

Great, please do that.  Thank you.

-- 
paul moore
www.paul-moore.com
