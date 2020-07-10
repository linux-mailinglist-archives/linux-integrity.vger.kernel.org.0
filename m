Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D188821BDDE
	for <lists+linux-integrity@lfdr.de>; Fri, 10 Jul 2020 21:42:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728049AbgGJTmp (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 10 Jul 2020 15:42:45 -0400
Received: from linux.microsoft.com ([13.77.154.182]:33250 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726908AbgGJTmo (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 10 Jul 2020 15:42:44 -0400
Received: from sequoia (162-237-133-238.lightspeed.rcsntx.sbcglobal.net [162.237.133.238])
        by linux.microsoft.com (Postfix) with ESMTPSA id 1865420B4908;
        Fri, 10 Jul 2020 12:42:43 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 1865420B4908
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1594410163;
        bh=63GnlMtecE6BiaHswYBO/QVyHrUs379BtYxjHINyyr4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hl4DsaIPiEnT2meObPBtEGfyVG3+A2UyEmhEdOgxEOxR8y7D5X7FGEPAvkxBgLyZz
         7qBhQYzUg7Klj+adqGgd3QKhDZf6uv8YMPQo1TybV9I6G+kQIjbYz3+PBoRvIB/im1
         ii0PS+mr6b7AV/FBFpk2qzo/Jbdn14bjgRmderUw=
Date:   Fri, 10 Jul 2020 14:42:34 -0500
From:   Tyler Hicks <tyhicks@linux.microsoft.com>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Casey Schaufler <casey@schaufler-ca.com>,
        linux-audit@redhat.com
Subject: Re: [PATCH] ima: Rename internal audit rule functions
Message-ID: <20200710194234.GA7254@sequoia>
References: <20200629153037.337349-1-tyhicks@linux.microsoft.com>
 <1593466203.5085.62.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1593466203.5085.62.camel@linux.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 2020-06-29 17:30:03, Mimi Zohar wrote:
> [Cc'ing the audit mailing list]
> 
> On Mon, 2020-06-29 at 10:30 -0500, Tyler Hicks wrote:
> > 
> > diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
> > index ff2bf57ff0c7..5d62ee8319f4 100644
> > --- a/security/integrity/ima/ima.h
> > +++ b/security/integrity/ima/ima.h
> > @@ -419,24 +419,24 @@ static inline void ima_free_modsig(struct modsig *modsig)
> >  /* LSM based policy rules require audit */
> >  #ifdef CONFIG_IMA_LSM_RULES
> >  
> > -#define security_filter_rule_init security_audit_rule_init
> > -#define security_filter_rule_free security_audit_rule_free
> > -#define security_filter_rule_match security_audit_rule_match
> > +#define ima_audit_rule_init security_audit_rule_init
> > +#define ima_audit_rule_free security_audit_rule_free
> > +#define ima_audit_rule_match security_audit_rule_match
> 
> Instead of defining an entirely new method of identifying files, IMA
> piggybacks on top of the existing audit rule syntax.  IMA policy rules
> "filter" based on this information.
> 
> IMA already audits security/integrity related events.  Using the word
> "audit" here will make things even more confusing than they currently
> are.  Renaming these functions as ima_audit_rule_XXX provides no
> benefit.  At that point, IMA might as well call the
> security_audit_rule prefixed function names directly.  As a quick fix,
> rename them as "ima_filter_rule".
> 
> The correct solution would probably be to rename these prefixed
> "security_audit_rule" functions as "security_filter_rule", so that
> both the audit subsystem and IMA could use them.

There doesn't seem to be any interest, from the audit side, in re-using
these. I don't quite understand why they would want to use them since
they're just simple wrappers around the security_audit_rule_*()
functions.

I'll go the "quick fix" route of renaming them as ima_filter_rule_*().

Tyler

> 
> Mimi
