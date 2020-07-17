Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 361F5224416
	for <lists+linux-integrity@lfdr.de>; Fri, 17 Jul 2020 21:19:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728401AbgGQTTF (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 17 Jul 2020 15:19:05 -0400
Received: from linux.microsoft.com ([13.77.154.182]:44786 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727999AbgGQTTD (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 17 Jul 2020 15:19:03 -0400
Received: from sequoia (162-237-133-238.lightspeed.rcsntx.sbcglobal.net [162.237.133.238])
        by linux.microsoft.com (Postfix) with ESMTPSA id 23F0320B4909;
        Fri, 17 Jul 2020 12:19:02 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 23F0320B4909
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1595013543;
        bh=936Ej6PwFgQOfbt701DNQeezvUrKmHxPwTEHqq6hXKU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=f3Zr5ZsIOFvcx46qNgCltlwYHhR1HuHpLu7UBhvo7kY++ksbg3hh1nnnporsU+NLW
         6ZaKBg0zGqm6Z6qYYUvNaKNFOKdve4DjJAdILc5lICYPNZ5BFLjafTv7O9Viqdfmyu
         fmjlG458XsKqhcWkEZXTvjA1TlIxzc4ebD8SroSg=
Date:   Fri, 17 Jul 2020 14:18:58 -0500
From:   Tyler Hicks <tyhicks@linux.microsoft.com>
To:     Nayna <nayna@linux.vnet.ibm.com>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Prakhar Srivastava <prsriva02@gmail.com>,
        linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: Re: [PATCH v3 06/12] ima: Fail rule parsing when the KEY_CHECK hook
 is combined with an invalid cond
Message-ID: <20200717191858.GN3673@sequoia>
References: <20200709061911.954326-1-tyhicks@linux.microsoft.com>
 <20200709061911.954326-7-tyhicks@linux.microsoft.com>
 <336cc947-1f70-0286-6506-6df3d1d23a1d@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <336cc947-1f70-0286-6506-6df3d1d23a1d@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 2020-07-17 14:56:46, Nayna wrote:
> 
> On 7/9/20 2:19 AM, Tyler Hicks wrote:
> > The KEY_CHECK function only supports the uid, pcr, and keyrings
> > conditionals. Make this clear at policy load so that IMA policy authors
> > don't assume that other conditionals are supported.
> > 
> > Fixes: 5808611cccb2 ("IMA: Add KEY_CHECK func to measure keys")
> > Signed-off-by: Tyler Hicks <tyhicks@linux.microsoft.com>
> > Reviewed-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
> > ---
> > 
> > * v3
> >    - Added Lakshmi's Reviewed-by
> >    - Adjust for the indentation change introduced in patch #4
> > * v2
> >    - No change
> > 
> >   security/integrity/ima/ima_policy.c | 7 +++++++
> >   1 file changed, 7 insertions(+)
> > 
> > diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
> > index 1c64bd6f1728..81da02071d41 100644
> > --- a/security/integrity/ima/ima_policy.c
> > +++ b/security/integrity/ima/ima_policy.c
> > @@ -1023,6 +1023,13 @@ static bool ima_validate_rule(struct ima_rule_entry *entry)
> >   		if (entry->action & ~(MEASURE | DONT_MEASURE))
> >   			return false;
> > 
> > +		if (entry->flags & ~(IMA_FUNC | IMA_UID | IMA_PCR |
> > +				     IMA_KEYRINGS))
> > +			return false;
> > +
> > +		if (ima_rule_contains_lsm_cond(entry))
> > +			return false;
> > +
> >   		break;
> >   	default:
> >   		return false;
> 
> Should there be a check for IMA_MEASURE_ASYMMETRIC_KEYS in Opt_keyrings in
> ima_parse_rule() to return immediately if not enabled ?

I didn't notice that "keyrings=" could be disabled at build time. I
think you're right that something like what I have below would be a good idea.

@Lakshmi, do you agree?

diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index 81da02071d41..bd687560f88e 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -1212,6 +1212,11 @@ static int ima_parse_rule(char *rule, struct ima_rule_entry *entry)
 		case Opt_keyrings:
 			ima_log_string(ab, "keyrings", args[0].from);
 
+			if (!IS_ENABLED(CONFIG_IMA_MEASURE_ASYMMETRIC_KEYS)) {
+				result = -EINVAL;
+				break;
+			}
+
 			keyrings_len = strlen(args[0].from) + 1;
 
 			if ((entry->keyrings) ||

Tyler

> 
> Thanks & Regards,
> 
>      - Nayna
> 
