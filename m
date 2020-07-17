Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BA132242F0
	for <lists+linux-integrity@lfdr.de>; Fri, 17 Jul 2020 20:11:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726256AbgGQSLh (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 17 Jul 2020 14:11:37 -0400
Received: from linux.microsoft.com ([13.77.154.182]:60054 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726205AbgGQSLg (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 17 Jul 2020 14:11:36 -0400
Received: from sequoia (162-237-133-238.lightspeed.rcsntx.sbcglobal.net [162.237.133.238])
        by linux.microsoft.com (Postfix) with ESMTPSA id 1B3F420B4909;
        Fri, 17 Jul 2020 11:11:35 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 1B3F420B4909
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1595009495;
        bh=2Pzs4CmdDfnklLSKLq/qkdid1cilbcCSYYl7lLHXGe8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mUU+5r9vVToweMQMPxEGv6yqTVSMaTYsYxEx7SRIAnhU+jY0WVAMStyXuuXe5TEWH
         gBXzbDKupNrVFU9HYirgAi2f+BA6YjG0a17Wfn2UzlHC/ZD6EBWE2FSgWUAqlEoqB/
         OC5H9KsJwGW8pNp7776zHDJDSZZt4gMWkd0wAckE=
Date:   Fri, 17 Jul 2020 13:11:33 -0500
From:   Tyler Hicks <tyhicks@linux.microsoft.com>
To:     Nayna <nayna@linux.vnet.ibm.com>, Mimi Zohar <zohar@linux.ibm.com>
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
Message-ID: <20200717181133.GM3673@sequoia>
References: <20200709061911.954326-1-tyhicks@linux.microsoft.com>
 <20200709061911.954326-8-tyhicks@linux.microsoft.com>
 <76d2b27b-3b59-1852-046a-b1718c62b167@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <76d2b27b-3b59-1852-046a-b1718c62b167@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 2020-07-17 13:40:22, Nayna wrote:
> 
> On 7/9/20 2:19 AM, Tyler Hicks wrote:
> > The "appraise_flag" option is only appropriate for appraise actions
> > and its "blacklist" value is only appropriate when
> > CONFIG_IMA_APPRAISE_MODSIG is enabled and "appraise_flag=blacklist" is
> > only appropriate when "appraise_type=imasig|modsig" is also present.
> > Make this clear at policy load so that IMA policy authors don't assume
> > that other uses of "appraise_flag=blacklist" are supported.
> > 
> > Fixes: 273df864cf74 ("ima: Check against blacklisted hashes for files with modsig")
> > Signed-off-by: Tyler Hicks <tyhicks@linux.microsoft.com>
> > Cc: Nayna Jain <nayna@linux.ibm.com>
> > ---
> > 
> > * v3
> >    - New patch
> > 
> >   security/integrity/ima/ima_policy.c | 13 ++++++++++++-
> >   1 file changed, 12 insertions(+), 1 deletion(-)
> > 
> > diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
> > index 81da02071d41..9842e2e0bc6d 100644
> > --- a/security/integrity/ima/ima_policy.c
> > +++ b/security/integrity/ima/ima_policy.c
> > @@ -1035,6 +1035,11 @@ static bool ima_validate_rule(struct ima_rule_entry *entry)
> >   		return false;
> >   	}
> > +	/* Ensure that combinations of flags are compatible with each other */
> > +	if (entry->flags & IMA_CHECK_BLACKLIST &&
> > +	    !(entry->flags & IMA_MODSIG_ALLOWED))
> > +		return false;
> > +
> >   	return true;
> >   }
> > @@ -1371,8 +1376,14 @@ static int ima_parse_rule(char *rule, struct ima_rule_entry *entry)
> >   				result = -EINVAL;
> >   			break;
> >   		case Opt_appraise_flag:
> > +			if (entry->action != APPRAISE) {
> > +				result = -EINVAL;
> > +				break;
> > +			}
> > +
> >   			ima_log_string(ab, "appraise_flag", args[0].from);
> > -			if (strstr(args[0].from, "blacklist"))
> > +			if (IS_ENABLED(CONFIG_IMA_APPRAISE_MODSIG) &&
> > +			    strstr(args[0].from, "blacklist"))
> >   				entry->flags |= IMA_CHECK_BLACKLIST;
> 
> If IMA_APPRAISE_MODSIG is disabled, it will allow the following rule to
> load, which is not as expected.
> 
> "appraise func=xxx_CHECK appraise_flag=blacklist appraise_type=imasig"
> 
> Missing is the "else" condition to immediately reject the policy rule.

Thanks for the review. You're right. This change is needed:

diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index 9842e2e0bc6d..cf3ddb38dfa8 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -1385,6 +1385,8 @@ static int ima_parse_rule(char *rule, struct ima_rule_entry *entry)
 			if (IS_ENABLED(CONFIG_IMA_APPRAISE_MODSIG) &&
 			    strstr(args[0].from, "blacklist"))
 				entry->flags |= IMA_CHECK_BLACKLIST;
+			else
+				result = -EINVAL;
 			break;
 		case Opt_permit_directio:
 			entry->flags |= IMA_PERMIT_DIRECTIO;


Making this change does not conflict with any later patches in the
series.

Mimi, I've rebased and force pushed to my fixup branch with this change,
for your comparison:

 https://git.kernel.org/pub/scm/linux/kernel/git/tyhicks/linux.git/log/?h=next-integrity-testing-fixup

Tyler

> 
> Thanks & Regards,
> 
>      - Nayna
> 
