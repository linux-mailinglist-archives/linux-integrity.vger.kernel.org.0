Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 516B720D415
	for <lists+linux-integrity@lfdr.de>; Mon, 29 Jun 2020 21:13:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730685AbgF2TEz (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 29 Jun 2020 15:04:55 -0400
Received: from linux.microsoft.com ([13.77.154.182]:48704 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730681AbgF2TEy (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 29 Jun 2020 15:04:54 -0400
Received: from sequoia (162-237-133-238.lightspeed.rcsntx.sbcglobal.net [162.237.133.238])
        by linux.microsoft.com (Postfix) with ESMTPSA id AEAE920B4901;
        Mon, 29 Jun 2020 07:16:16 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com AEAE920B4901
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1593440177;
        bh=v+wyGBDonImB9MBWCw9EMxRuWEDmYg128Fe9bnY0g6c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eVgVYnscENhuNhNQTyhZbFymcwHwtaCB1JVO/5//WlJM4Nv5RhfXHxEmzNS8HBHRk
         p5XfObD9Ymg9erl91qvwxM3XsQMB/o/hLnkyCgNzIHXK+B6Dg2Bykqevr0UVq7cUGd
         ArzJcUXJf0dxujES9z46s7zXvQxC856nBBvZzEaE=
Date:   Mon, 29 Jun 2020 09:16:14 -0500
From:   Tyler Hicks <tyhicks@linux.microsoft.com>
To:     Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Prakhar Srivastava <prsriva02@gmail.com>,
        linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: Re: [PATCH v2 09/11] ima: Move validation of the keyrings
 conditional into ima_validate_rule()
Message-ID: <20200629141614.GD4694@sequoia>
References: <20200626223900.253615-1-tyhicks@linux.microsoft.com>
 <20200626223900.253615-10-tyhicks@linux.microsoft.com>
 <0e7012e7-e1df-466d-9d51-a691f779570a@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0e7012e7-e1df-466d-9d51-a691f779570a@linux.microsoft.com>
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 2020-06-27 16:49:46, Lakshmi Ramasubramanian wrote:
> On 6/26/20 3:38 PM, Tyler Hicks wrote:
> 
> > Use ima_validate_rule() to ensure that the combination of a hook
> > function and the keyrings conditional is valid and that the keyrings
> > conditional is not specified without an explicit KEY_CHECK func
> > conditional. This is a code cleanup and has no user-facing change.
> 
> In addition to checking for func=KEY_CHECK and the keyrings conditional, the
> patch also validates the flags for other IMA hooks (such as
> KEXEC_KERNEL_CHECK, POLICY_CHECK, etc.) Would be good to mention that in the
> patch description.

It actually doesn't do any additional validation of other IMA hooks at
this time. That check on entry->flags is an allowlist of every possible
conditional flag except IMA_KEYRINGS. The ima_parse_rule() function is
already validating all of these conditional flags.

Tyler

> 
>  -lakshmi
> 
> > 
> > Signed-off-by: Tyler Hicks <tyhicks@linux.microsoft.com>
> > ---
> > 
> > * v2
> >    - Allowed IMA_DIGSIG_REQUIRED, IMA_PERMIT_DIRECTIO,
> >      IMA_MODSIG_ALLOWED, and IMA_CHECK_BLACKLIST conditionals to be
> >      present in the rule entry flags for non-buffer hook functions.
> > 
> >   security/integrity/ima/ima_policy.c | 13 +++++++++++--
> >   1 file changed, 11 insertions(+), 2 deletions(-)
> > 
> > diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
> > index 8cdca2399d59..43d49ad958fb 100644
> > --- a/security/integrity/ima/ima_policy.c
> > +++ b/security/integrity/ima/ima_policy.c
> > @@ -1000,6 +1000,15 @@ static bool ima_validate_rule(struct ima_rule_entry *entry)
> >   		case KEXEC_KERNEL_CHECK:
> >   		case KEXEC_INITRAMFS_CHECK:
> >   		case POLICY_CHECK:
> > +			if (entry->flags & ~(IMA_FUNC | IMA_MASK | IMA_FSMAGIC |
> > +					     IMA_UID | IMA_FOWNER | IMA_FSUUID |
> > +					     IMA_INMASK | IMA_EUID | IMA_PCR |
> > +					     IMA_FSNAME | IMA_DIGSIG_REQUIRED |
> > +					     IMA_PERMIT_DIRECTIO |
> > +					     IMA_MODSIG_ALLOWED |
> > +					     IMA_CHECK_BLACKLIST))
> > +				return false;
> > +
> >   			break;
> >   		case KEXEC_CMDLINE:
> >   			if (entry->action & ~(MEASURE | DONT_MEASURE))
> > @@ -1027,7 +1036,8 @@ static bool ima_validate_rule(struct ima_rule_entry *entry)
> >   		default:
> >   			return false;
> >   		}
> > -	}
> > +	} else if (entry->flags & IMA_KEYRINGS)
> > +		return false;
> >   	return true;
> >   }
> > @@ -1209,7 +1219,6 @@ static int ima_parse_rule(char *rule, struct ima_rule_entry *entry)
> >   			keyrings_len = strlen(args[0].from) + 1;
> >   			if ((entry->keyrings) ||
> > -			    (entry->func != KEY_CHECK) ||
> >   			    (keyrings_len < 2)) {
> >   				result = -EINVAL;
> >   				break;
> > 
