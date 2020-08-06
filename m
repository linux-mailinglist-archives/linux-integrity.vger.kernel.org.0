Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A924F23DD53
	for <lists+linux-integrity@lfdr.de>; Thu,  6 Aug 2020 19:09:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729229AbgHFRIW (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 6 Aug 2020 13:08:22 -0400
Received: from linux.microsoft.com ([13.77.154.182]:56788 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729357AbgHFRGf (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 6 Aug 2020 13:06:35 -0400
Received: from sequoia (162-237-133-238.lightspeed.rcsntx.sbcglobal.net [162.237.133.238])
        by linux.microsoft.com (Postfix) with ESMTPSA id 05EBF20B4908;
        Thu,  6 Aug 2020 08:46:37 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 05EBF20B4908
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1596728798;
        bh=KG2C6RbvLQBgLP+0NWNVA/7hHclgHh703Y6EXT9pNkY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aXAMg6wcqdwOoZdGIULELD41c4SAJhF4XYK8WNDNhmldx9W/PmQVnJb83CT/mqp4d
         ZDHRVzKvbhts3VJKMjZBX1Psyz0BOoN18dI37/BVFR2LwW3pQHbIZ6M7Z/hrydcRF4
         OtV0jXI+OHmzpKsa8SVpRidB/XRbUFc2MJ9rhfhg=
Date:   Thu, 6 Aug 2020 10:46:36 -0500
From:   Tyler Hicks <tyhicks@linux.microsoft.com>
To:     Nayna <nayna@linux.vnet.ibm.com>
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        Tushar Sugandhi <tusharsu@linux.microsoft.com>,
        Nayna Jain <nayna@linux.ibm.com>, linux-kernel@vger.kernel.org,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: Re: [PATCH 1/2] ima: Pre-parse the list of keyrings in a KEY_CHECK
 rule
Message-ID: <20200806154636.GB55159@sequoia>
References: <20200727140831.64251-1-tyhicks@linux.microsoft.com>
 <20200727140831.64251-2-tyhicks@linux.microsoft.com>
 <8f749594-1214-9f2d-4614-d360772a2ab6@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8f749594-1214-9f2d-4614-d360772a2ab6@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 2020-08-06 11:34:43, Nayna wrote:
> 
> On 7/27/20 10:08 AM, Tyler Hicks wrote:
> > The ima_keyrings buffer was used as a work buffer for strsep()-based
> > parsing of the "keyrings=" option of an IMA policy rule. This parsing
> > was re-performed each time an asymmetric key was added to a kernel
> > keyring for each loaded policy rule that contained a "keyrings=" option.
> > 
> > An example rule specifying this option is:
> > 
> >   measure func=KEY_CHECK keyrings=a|b|c
> > 
> > The rule says to measure asymmetric keys added to any of the kernel
> > keyrings named "a", "b", or "c". The size of the buffer size was
> > equal to the size of the largest "keyrings=" value seen in a previously
> > loaded rule (5 + 1 for the NUL-terminator in the previous example) and
> > the buffer was pre-allocated at the time of policy load.
> > 
> > The pre-allocated buffer approach suffered from a couple bugs:
> > 
> > 1) There was no locking around the use of the buffer so concurrent key
> >     add operations, to two different keyrings, would result in the
> >     strsep() loop of ima_match_keyring() to modify the buffer at the same
> >     time. This resulted in unexpected results from ima_match_keyring()
> >     and, therefore, could cause unintended keys to be measured or keys to
> >     not be measured when IMA policy intended for them to be measured.
> > 
> > 2) If the kstrdup() that initialized entry->keyrings in ima_parse_rule()
> >     failed, the ima_keyrings buffer was freed and set to NULL even when a
> >     valid KEY_CHECK rule was previously loaded. The next KEY_CHECK event
> >     would trigger a call to strcpy() with a NULL destination pointer and
> >     crash the kernel.
> > 
> > Remove the need for a pre-allocated global buffer by parsing the list of
> > keyrings in a KEY_CHECK rule at the time of policy load. The
> > ima_rule_entry will contain an array of string pointers which point to
> > the name of each keyring specified in the rule. No string processing
> > needs to happen at the time of asymmetric key add so iterating through
> > the list and doing a string comparison is all that's required at the
> > time of policy check.
> > 
> > In the process of changing how the "keyrings=" policy option is handled,
> > a couple additional bugs were fixed:
> > 
> > 1) The rule parser accepted rules containing invalid "keyrings=" values
> >     such as "a|b||c", "a|b|", or simply "|".
> > 
> > 2) The /sys/kernel/security/ima/policy file did not display the entire
> >     "keyrings=" value if the list of keyrings was longer than what could
> >     fit in the fixed size tbuf buffer in ima_policy_show().
> > 
> > Fixes: 5c7bac9fb2c5 ("IMA: pre-allocate buffer to hold keyrings string")
> > Fixes: 2b60c0ecedf8 ("IMA: Read keyrings= option from the IMA policy")
> > Signed-off-by: Tyler Hicks <tyhicks@linux.microsoft.com>
> > ---
> >   security/integrity/ima/ima_policy.c | 138 +++++++++++++++++++---------
> >   1 file changed, 93 insertions(+), 45 deletions(-)
> > 
> > diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
> > index 07f033634b27..c328cfa0fc49 100644
> > --- a/security/integrity/ima/ima_policy.c
> > +++ b/security/integrity/ima/ima_policy.c
> > @@ -59,6 +59,11 @@ enum policy_types { ORIGINAL_TCB = 1, DEFAULT_TCB };
> >   enum policy_rule_list { IMA_DEFAULT_POLICY = 1, IMA_CUSTOM_POLICY };
> > +struct ima_rule_opt_list {
> > +	size_t count;
> > +	char *items[];
> > +};
> > +
> >   struct ima_rule_entry {
> >   	struct list_head list;
> >   	int action;
> > @@ -78,7 +83,7 @@ struct ima_rule_entry {
> >   		int type;	/* audit type */
> >   	} lsm[MAX_LSM_RULES];
> >   	char *fsname;
> > -	char *keyrings; /* Measure keys added to these keyrings */
> > +	struct ima_rule_opt_list *keyrings; /* Measure keys added to these keyrings */
> >   	struct ima_template_desc *template;
> >   };
> > @@ -206,10 +211,6 @@ static LIST_HEAD(ima_policy_rules);
> >   static LIST_HEAD(ima_temp_rules);
> >   static struct list_head *ima_rules = &ima_default_rules;
> > -/* Pre-allocated buffer used for matching keyrings. */
> > -static char *ima_keyrings;
> > -static size_t ima_keyrings_len;
> > -
> >   static int ima_policy __initdata;
> >   static int __init default_measure_policy_setup(char *str)
> > @@ -253,6 +254,72 @@ static int __init default_appraise_policy_setup(char *str)
> >   }
> >   __setup("ima_appraise_tcb", default_appraise_policy_setup);
> > +static struct ima_rule_opt_list *ima_alloc_rule_opt_list(const substring_t *src)
> > +{
> > +	struct ima_rule_opt_list *opt_list;
> > +	size_t count = 0;
> > +	char *src_copy;
> > +	char *cur, *next;
> > +	size_t i;
> > +
> > +	src_copy = match_strdup(src);
> > +	if (!src_copy)
> > +		return NULL;
> 
> The caller of this function checks for IS_ERR(..) and not
> IS_ERR_OR_NULL(..). Shouldn't it return ERR_PTR(-EINVAL) instead of NULL ?

Yes! Thank you for catching this.

I switched this function to returning an ERR_PTR() towards the end of my
development for this series and missed this particular return.

I'll send out a v2 ASAP.

Tyler

> 
> Thanks & Regards,
> 
>     - Nayna
