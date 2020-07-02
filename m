Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F4CE212F5E
	for <lists+linux-integrity@lfdr.de>; Fri,  3 Jul 2020 00:17:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726150AbgGBWRA (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 2 Jul 2020 18:17:00 -0400
Received: from linux.microsoft.com ([13.77.154.182]:33104 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726121AbgGBWQ7 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 2 Jul 2020 18:16:59 -0400
Received: from sequoia (162-237-133-238.lightspeed.rcsntx.sbcglobal.net [162.237.133.238])
        by linux.microsoft.com (Postfix) with ESMTPSA id 3454E20B717A;
        Thu,  2 Jul 2020 15:16:58 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 3454E20B717A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1593728218;
        bh=oF/uy0h2kLORBOaWz4SneoVrme6PATdmsVREbyRum0g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PFMZdTTFgv5iNVM4ImGmNBoS/pvR9L0heXpZKAZMOxhPhktoVwM67LJRd8IGKuMp+
         hsVbe/ezG63jAQaTHYIibsgW44l4YWhhShkGXgLfJnP5lJ695+dZFexJkvSWwrLoXu
         EKLjodVxz2+a49rtE8yf+rCbSjRVinzD7f3Lub6c=
Date:   Thu, 2 Jul 2020 17:16:56 -0500
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
Message-ID: <20200702221656.GH4694@sequoia>
References: <20200626223900.253615-1-tyhicks@linux.microsoft.com>
 <20200626223900.253615-10-tyhicks@linux.microsoft.com>
 <1593558449.5057.12.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1593558449.5057.12.camel@linux.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 2020-06-30 19:07:29, Mimi Zohar wrote:
> On Fri, 2020-06-26 at 17:38 -0500, Tyler Hicks wrote:
> > Use ima_validate_rule() to ensure that the combination of a hook
> > function and the keyrings conditional is valid and that the keyrings
> > conditional is not specified without an explicit KEY_CHECK func
> > conditional. This is a code cleanup and has no user-facing change.
> > 
> > Signed-off-by: Tyler Hicks <tyhicks@linux.microsoft.com>
> > ---
> > 
> > * v2
> >   - Allowed IMA_DIGSIG_REQUIRED, IMA_PERMIT_DIRECTIO,
> >     IMA_MODSIG_ALLOWED, and IMA_CHECK_BLACKLIST conditionals to be
> >     present in the rule entry flags for non-buffer hook functions.
> > 
> >  security/integrity/ima/ima_policy.c | 13 +++++++++++--
> >  1 file changed, 11 insertions(+), 2 deletions(-)
> > 
> > diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
> > index 8cdca2399d59..43d49ad958fb 100644
> > --- a/security/integrity/ima/ima_policy.c
> > +++ b/security/integrity/ima/ima_policy.c
> > @@ -1000,6 +1000,15 @@ static bool ima_validate_rule(struct ima_rule_entry *entry)
> >  		case KEXEC_KERNEL_CHECK:
> >  		case KEXEC_INITRAMFS_CHECK:
> >  		case POLICY_CHECK:
> > +			if (entry->flags & ~(IMA_FUNC | IMA_MASK | IMA_FSMAGIC |
> > +					     IMA_UID | IMA_FOWNER | IMA_FSUUID |
> > +					     IMA_INMASK | IMA_EUID | IMA_PCR |
> > +					     IMA_FSNAME | IMA_DIGSIG_REQUIRED |
> > +					     IMA_PERMIT_DIRECTIO |
> > +					     IMA_MODSIG_ALLOWED |
> > +					     IMA_CHECK_BLACKLIST))
> 
> Other than KEYRINGS, this patch should continue to behave the same.
>  However, this list gives the impressions that all of these flags are
> permitted on all of the above flags, which isn't true.
> 
> For example, both IMA_MODSIG_ALLOWED & IMA_CHECK_BLACKLIST are limited
> to appended signatures, meaning KERNEL_CHECK and KEXEC_KERNEL_CHECK.

Just to clarify, are both IMA_MODSIG_ALLOWED and IMA_CHECK_BLACKLIST
limited to KEXEC_KERNEL_CHECK, KEXEC_INITRAMFS_CHECK, and MODULE_CHECK?
That's what ima_hook_supports_modsig() suggests.

>  Both should only be allowed on APPRAISE action rules.

For completeness, it looks like DONT_APPRAISE should not be allowed.

> IMA_PCR should be limited to MEASURE action rules.

It looks like DONT_MEASURE should not be allowed.

> IMA_DIGSIG_REQUIRED should be limited to APPRAISE action rules.

It looks like DONT_APPRAISE should not be allowed.

> 
> > +				return false;
> > +
> >  			break;
> >  		case KEXEC_CMDLINE:
> >  			if (entry->action & ~(MEASURE | DONT_MEASURE))
> > @@ -1027,7 +1036,8 @@ static bool ima_validate_rule(struct ima_rule_entry *entry)
> >  		default:
> >  			return false;
> >  		}
> > -	}
> > +	} else if (entry->flags & IMA_KEYRINGS)
> > +		return false;
> 
> IMA_MODSIG_ALLOWED and IMA_CHECK_BLACKLIST need to be added here as
> well.

That makes sense.

Tyler

> 
> Mimi
> 
> >  
> >  	return true;
> >  }
> > @@ -1209,7 +1219,6 @@ static int ima_parse_rule(char *rule, struct ima_rule_entry *entry)
> >  			keyrings_len = strlen(args[0].from) + 1;
> >  
> >  			if ((entry->keyrings) ||
> > -			    (entry->func != KEY_CHECK) ||
> >  			    (keyrings_len < 2)) {
> >  				result = -EINVAL;
> >  				break;
