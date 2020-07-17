Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34DFA2240CF
	for <lists+linux-integrity@lfdr.de>; Fri, 17 Jul 2020 18:52:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726634AbgGQQwC (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 17 Jul 2020 12:52:02 -0400
Received: from linux.microsoft.com ([13.77.154.182]:50252 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726221AbgGQQwB (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 17 Jul 2020 12:52:01 -0400
Received: from sequoia (162-237-133-238.lightspeed.rcsntx.sbcglobal.net [162.237.133.238])
        by linux.microsoft.com (Postfix) with ESMTPSA id CDBD820B4909;
        Fri, 17 Jul 2020 09:51:59 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com CDBD820B4909
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1595004720;
        bh=DvmxoacjIGDf6VIRgClmLxCafLoC/7gOChzuge/MVtY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EuINBWJbNpWg6k/gjnYp/WbOQPAps/m7HqKNWwVayongOuF+/ZK6lRsFNyxP4WMnW
         AxhowkF5ihAYf8r94NgcDasSd1Qre9U60xxyNphXuXDgFGLf85kOACuulIuJObgGR7
         tBacQSIoHH/dh22jKXb0kN9fHxCM4xq+Y6EMAWUE=
Date:   Fri, 17 Jul 2020 11:51:57 -0500
From:   Tyler Hicks <tyhicks@linux.microsoft.com>
To:     Konsta Karsisto <konsta.karsisto@gmail.com>,
        Mimi Zohar <zohar@linux.ibm.com>
Cc:     linux-integrity@vger.kernel.org,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        Prakhar Srivastava <prsriva02@gmail.com>,
        linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: Re: [PATCH v3 08/12] ima: Shallow copy the args_p member of
 ima_rule_entry.lsm elements
Message-ID: <20200717165157.GL3673@sequoia>
References: <20200709061911.954326-1-tyhicks@linux.microsoft.com>
 <20200709061911.954326-9-tyhicks@linux.microsoft.com>
 <CAAEqDhD-wCGY7ykjSsNgCri4ykWPi9cP3j1zoQPWddB4r92Kqw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAEqDhD-wCGY7ykjSsNgCri4ykWPi9cP3j1zoQPWddB4r92Kqw@mail.gmail.com>
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 2020-07-17 18:35:03, Konsta Karsisto wrote:
> Hi,
> 
> Found one glitch with this change, see below:
> 
> On Thu, Jul 9, 2020 at 9:22 AM Tyler Hicks <tyhicks@linux.microsoft.com> wrote:
> >
> > The args_p member is a simple string that is allocated by
> > ima_rule_init(). Shallow copy it like other non-LSM references in
> > ima_rule_entry structs.
> >
> > There are no longer any necessary error path cleanups to do in
> > ima_lsm_copy_rule().
> >
> > Signed-off-by: Tyler Hicks <tyhicks@linux.microsoft.com>
> > ---
> >
> > * v3
> >   - No change
> > * v2
> >   - Adjusted context to account for ima_lsm_copy_rule() directly calling
> >     ima_lsm_free_rule() and the lack of explicit reference ownership
> >     transfers
> >   - Added comment to ima_lsm_copy_rule() to document the args_p
> >     reference ownership transfer
> >
> >  security/integrity/ima/ima_policy.c | 16 +++++++---------
> >  1 file changed, 7 insertions(+), 9 deletions(-)
> >
> > diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
> > index 9842e2e0bc6d..b02e1ffd10c9 100644
> > --- a/security/integrity/ima/ima_policy.c
> > +++ b/security/integrity/ima/ima_policy.c
> > @@ -300,10 +300,13 @@ static struct ima_rule_entry *ima_lsm_copy_rule(struct ima_rule_entry *entry)
> >                         continue;
> >
> >                 nentry->lsm[i].type = entry->lsm[i].type;
> > -               nentry->lsm[i].args_p = kstrdup(entry->lsm[i].args_p,
> > -                                               GFP_KERNEL);
> > -               if (!nentry->lsm[i].args_p)
> > -                       goto out_err;
> > +               nentry->lsm[i].args_p = entry->lsm[i].args_p;
> > +               /*
> > +                * Remove the reference from entry so that the associated
> > +                * memory will not be freed during a later call to
> > +                * ima_lsm_free_rule(entry).
> > +                */
> > +               entry->lsm[i].args_p = NULL;
> 
> This assignment necessitates a change in the code below...
> 
> >                 security_filter_rule_init(nentry->lsm[i].type,
> >                                           Audit_equal,
> > @@ -314,11 +317,6 @@ static struct ima_rule_entry *ima_lsm_copy_rule(struct ima_rule_entry *entry)
> >                                 (char *)entry->lsm[i].args_p);
> 
> ... you should refer to nentry->lsm[i].args_p here!
> 
> Other than that,
> 
> Reviewed-by: Konsta Karsisto <konsta.karsisto@gmail.com>

Thank you, Konsta. You're exactly right about the required change.
Without it, the pr_warn() in the error path will always attempt to print
a NULL pointer.

Mimi, the following change (along with adding Konsta's Reviewed-by)
needs to be made to this patch in next-integrity-testing:

diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index b02e1ffd10c9..330a4e216349 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -314,7 +314,7 @@ static struct ima_rule_entry *ima_lsm_copy_rule(struct ima_rule_entry *entry)
 					  &nentry->lsm[i].rule);
 		if (!nentry->lsm[i].rule)
 			pr_warn("rule for LSM \'%s\' is undefined\n",
-				(char *)entry->lsm[i].args_p);
+				(char *)nentry->lsm[i].args_p);
 	}
 	return nentry;
 }

It will then cause the next patch in the series to not apply but the
fixup is minor.

Let me know if you are alright with doing these changes yourself or if
you'd like me to submit a new series revision.

If you do this rebase work in next-integrity-testing yourself, I've
prepared a copy branch of next-integrity-testing with all of the
necessary changes for you to compare against:

 https://git.kernel.org/pub/scm/linux/kernel/git/tyhicks/linux.git/log/?h=next-integrity-testing-fixup

My apologies for the trouble.

Tyler

> 
> 
> Konsta
> 
> >         }
> >         return nentry;
> > -
> > -out_err:
> > -       ima_lsm_free_rule(nentry);
> > -       kfree(nentry);
> > -       return NULL;
> >  }
> >
> >  static int ima_lsm_update_rule(struct ima_rule_entry *entry)
> > --
> > 2.25.1
> >
