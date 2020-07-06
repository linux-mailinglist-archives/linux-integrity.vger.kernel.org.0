Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3477421582B
	for <lists+linux-integrity@lfdr.de>; Mon,  6 Jul 2020 15:18:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729198AbgGFNSs (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 6 Jul 2020 09:18:48 -0400
Received: from linux.microsoft.com ([13.77.154.182]:37354 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729072AbgGFNSs (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 6 Jul 2020 09:18:48 -0400
Received: from sequoia (162-237-133-238.lightspeed.rcsntx.sbcglobal.net [162.237.133.238])
        by linux.microsoft.com (Postfix) with ESMTPSA id 6913520B717A;
        Mon,  6 Jul 2020 06:18:47 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 6913520B717A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1594041528;
        bh=f6pqwPgURJsUukw0OzBzkWGxCYgCy9yL+9G336sxsg0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UUT7vs3OB1AfZN8zireRKfp/s6vIG1eklB2XXox3Un1iQ/71CST+p4YPnh/noPO4s
         qqjf581qVhqHRsmxe/fwt2L4cVrlo16dwpSWSHGaFXHs5qAcpaszsntJYJRQjVL1/w
         6dTp9HX986whh3++TYJQTJFAi5oE0c+jZIUsiCu4=
Date:   Mon, 6 Jul 2020 08:18:45 -0500
From:   Tyler Hicks <tyhicks@linux.microsoft.com>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        Prakhar Srivastava <prsriva02@gmail.com>,
        linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: Re: [PATCH v2 09/11] ima: Move validation of the keyrings
 conditional into ima_validate_rule()
Message-ID: <20200706131845.GI4694@sequoia>
References: <20200626223900.253615-1-tyhicks@linux.microsoft.com>
 <20200626223900.253615-10-tyhicks@linux.microsoft.com>
 <1593558449.5057.12.camel@linux.ibm.com>
 <20200702221656.GH4694@sequoia>
 <1593785732.23056.16.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1593785732.23056.16.camel@linux.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 2020-07-03 10:15:32, Mimi Zohar wrote:
> On Thu, 2020-07-02 at 17:16 -0500, Tyler Hicks wrote:
> > On 2020-06-30 19:07:29, Mimi Zohar wrote:
> > > On Fri, 2020-06-26 at 17:38 -0500, Tyler Hicks wrote:
> > > > Use ima_validate_rule() to ensure that the combination of a hook
> > > > function and the keyrings conditional is valid and that the keyrings
> > > > conditional is not specified without an explicit KEY_CHECK func
> > > > conditional. This is a code cleanup and has no user-facing change.
> > > > 
> > > > Signed-off-by: Tyler Hicks <tyhicks@linux.microsoft.com>
> > > > ---
> > > > 
> > > > * v2
> > > >   - Allowed IMA_DIGSIG_REQUIRED, IMA_PERMIT_DIRECTIO,
> > > >     IMA_MODSIG_ALLOWED, and IMA_CHECK_BLACKLIST conditionals to be
> > > >     present in the rule entry flags for non-buffer hook functions.
> > > > 
> > > >  security/integrity/ima/ima_policy.c | 13 +++++++++++--
> > > >  1 file changed, 11 insertions(+), 2 deletions(-)
> > > > 
> > > > diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
> > > > index 8cdca2399d59..43d49ad958fb 100644
> > > > --- a/security/integrity/ima/ima_policy.c
> > > > +++ b/security/integrity/ima/ima_policy.c
> > > > @@ -1000,6 +1000,15 @@ static bool ima_validate_rule(struct ima_rule_entry *entry)
> > > >  		case KEXEC_KERNEL_CHECK:
> > > >  		case KEXEC_INITRAMFS_CHECK:
> > > >  		case POLICY_CHECK:
> > > > +			if (entry->flags & ~(IMA_FUNC | IMA_MASK | IMA_FSMAGIC |
> > > > +					     IMA_UID | IMA_FOWNER | IMA_FSUUID |
> > > > +					     IMA_INMASK | IMA_EUID | IMA_PCR |
> > > > +					     IMA_FSNAME | IMA_DIGSIG_REQUIRED |
> > > > +					     IMA_PERMIT_DIRECTIO |
> > > > +					     IMA_MODSIG_ALLOWED |
> > > > +					     IMA_CHECK_BLACKLIST))
> > > 
> > > Other than KEYRINGS, this patch should continue to behave the same.
> > >  However, this list gives the impressions that all of these flags are
> > > permitted on all of the above flags, which isn't true.
> > > 
> > > For example, both IMA_MODSIG_ALLOWED & IMA_CHECK_BLACKLIST are limited
> > > to appended signatures, meaning KERNEL_CHECK and KEXEC_KERNEL_CHECK.
> > 
> > Just to clarify, are both IMA_MODSIG_ALLOWED and IMA_CHECK_BLACKLIST
> > limited to KEXEC_KERNEL_CHECK, KEXEC_INITRAMFS_CHECK, and MODULE_CHECK?
> > That's what ima_hook_supports_modsig() suggests.
> 
> Theoretically that is true, but I have no idea how you would append a
> signature to the kexec boot command line.  The only users of appended
> signatures are currently kernel modules and the kexec'ed kernel image.

The discrepancy was with KEXEC_INITRAMFS_CHECK, not KEXEC_CMDLINE. I now
see that there's no support for initramfs signature verification in the
kexec code so I'll assume that ima_hook_supports_modsig() is wrong and
limit IMA_MODSIG_ALLOWED and IMA_CHECK_BLACKLIST to the
KEXEC_KERNEL_CHECK and MODULE_CHECK actions, as you originally
suggested.

Tyler

> 
> > 
> > >  Both should only be allowed on APPRAISE action rules.
> > 
> > For completeness, it looks like DONT_APPRAISE should not be allowed.
> 
> Good point.  
> 
> > 
> > > IMA_PCR should be limited to MEASURE action rules.
> > 
> > It looks like DONT_MEASURE should not be allowed.
> 
> The TPM PCR isn't a file attribute.
> 
> > 
> > > IMA_DIGSIG_REQUIRED should be limited to APPRAISE action rules.
> > 
> > It looks like DONT_APPRAISE should not be allowed.
> 
> Right, in all of these cases the DONT_XXXX isn't applicable.
> 
> Mimi
