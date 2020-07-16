Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 234BF222AD7
	for <lists+linux-integrity@lfdr.de>; Thu, 16 Jul 2020 20:21:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729559AbgGPSVB (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 16 Jul 2020 14:21:01 -0400
Received: from linux.microsoft.com ([13.77.154.182]:59484 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729544AbgGPSVA (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 16 Jul 2020 14:21:00 -0400
Received: from sequoia (162-237-133-238.lightspeed.rcsntx.sbcglobal.net [162.237.133.238])
        by linux.microsoft.com (Postfix) with ESMTPSA id E7AF320B4909;
        Thu, 16 Jul 2020 11:20:58 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com E7AF320B4909
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1594923659;
        bh=EQouyNC75DO1HsNnhD3+10RmroB00VBujwUdao5crR4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AlLWGc9gUvnMB7UwGwCLpIAYfC/XPdwoLPOvLh6rcFv5LPR3FS5XoPECUgTkm7EDV
         GZFBRU2hU43W3bR8QI6OCDTpA9RJJjsTj3/x9YcZe2qcVfig3fvqBRZS1OyvjsY5n6
         Ug7JdAKvuWBseNKYHxSWIy8kwFBFxbBs3qjJIVCs=
Date:   Thu, 16 Jul 2020 13:20:57 -0500
From:   Tyler Hicks <tyhicks@linux.microsoft.com>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        Prakhar Srivastava <prsriva02@gmail.com>,
        linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Nayna Jain <nayna@linux.ibm.com>
Subject: Re: [PATCH v3 07/12] ima: Fail rule parsing when
 appraise_flag=blacklist is unsupportable
Message-ID: <20200716182057.GE3673@sequoia>
References: <20200709061911.954326-1-tyhicks@linux.microsoft.com>
 <20200709061911.954326-8-tyhicks@linux.microsoft.com>
 <1594923290.12900.376.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1594923290.12900.376.camel@linux.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 2020-07-16 14:14:50, Mimi Zohar wrote:
> On Thu, 2020-07-09 at 01:19 -0500, Tyler Hicks wrote:
> > The "appraise_flag" option is only appropriate for appraise actions
> > and its "blacklist" value is only appropriate when
> > CONFIG_IMA_APPRAISE_MODSIG is enabled and "appraise_flag=blacklist" is
> > only appropriate when "appraise_type=imasig|modsig" is also present.
> > Make this clear at policy load so that IMA policy authors don't assume
> > that other uses of "appraise_flag=blacklist" are supported.
> 
> The code looks correct, but this patch description could be written at
> a higher level.  Perhaps it just needs to be prefixed with something
> like this:
> 
> Verifying that a file hash is not blacklisted is currently only
> supported for files with appended signatures (modsig).  In the future,
> this might change.  For now, ...

That makes sense. I'm not up to speed on the intent behind the blacklist
feature or where it may go in the future so I didn't think to add
anything along those lines.

If you are happy with the rest of the series, please feel free to append
this to the commit message. Otherwise, I can add it if I need to submit
a new revision of the series.

Tyler

> 
> Mimi
> 
> > 
> > Fixes: 273df864cf74 ("ima: Check against blacklisted hashes for files with modsig")
> > Signed-off-by: Tyler Hicks <tyhicks@linux.microsoft.com>
> > Cc: Nayna Jain <nayna@linux.ibm.com>
> 
> > ---
> > 
> > * v3
> >   - New patch
> > 
> >  security/integrity/ima/ima_policy.c | 13 ++++++++++++-
> >  1 file changed, 12 insertions(+), 1 deletion(-)
> > 
> > diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
> > index 81da02071d41..9842e2e0bc6d 100644
> > --- a/security/integrity/ima/ima_policy.c
> > +++ b/security/integrity/ima/ima_policy.c
> > @@ -1035,6 +1035,11 @@ static bool ima_validate_rule(struct ima_rule_entry *entry)
> >  		return false;
> >  	}
> >  
> > +	/* Ensure that combinations of flags are compatible with each other */
> > +	if (entry->flags & IMA_CHECK_BLACKLIST &&
> > +	    !(entry->flags & IMA_MODSIG_ALLOWED))
> > +		return false;
> > +
> >  	return true;
> >  }
> >  
> > @@ -1371,8 +1376,14 @@ static int ima_parse_rule(char *rule, struct ima_rule_entry *entry)
> >  				result = -EINVAL;
> >  			break;
> >  		case Opt_appraise_flag:
> > +			if (entry->action != APPRAISE) {
> > +				result = -EINVAL;
> > +				break;
> > +			}
> > +
> >  			ima_log_string(ab, "appraise_flag", args[0].from);
> > -			if (strstr(args[0].from, "blacklist"))
> > +			if (IS_ENABLED(CONFIG_IMA_APPRAISE_MODSIG) &&
> > +			    strstr(args[0].from, "blacklist"))
> >  				entry->flags |= IMA_CHECK_BLACKLIST;
> >  			break;
> >  		case Opt_permit_directio:
