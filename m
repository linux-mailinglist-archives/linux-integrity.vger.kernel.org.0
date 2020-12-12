Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 451762D8728
	for <lists+linux-integrity@lfdr.de>; Sat, 12 Dec 2020 15:49:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439184AbgLLOsZ (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sat, 12 Dec 2020 09:48:25 -0500
Received: from linux.microsoft.com ([13.77.154.182]:54782 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726332AbgLLOsZ (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sat, 12 Dec 2020 09:48:25 -0500
Received: from sequoia (162-237-133-238.lightspeed.rcsntx.sbcglobal.net [162.237.133.238])
        by linux.microsoft.com (Postfix) with ESMTPSA id 43A5A20B717A;
        Sat, 12 Dec 2020 06:47:43 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 43A5A20B717A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1607784464;
        bh=7rvIg+C95XPCYPYAFneW2aePc3XSRuDLvoT56+NKeXk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QyUnRFPbnGYZvrLptKN9jY69HTvpMS5CaqSR1McFATSNefU01LhoR1c6hd8dXKIJQ
         MMIg+HlhiHyKnFXTTaHduplkzZL3G0b4QGqGFy/f9X/kVNE4nhaWgabmYy/Z99HLfc
         xEsur1DspVNmTLo24MDo1f3yDpVmFNcVoUc53a0k=
Date:   Sat, 12 Dec 2020 08:47:41 -0600
From:   Tyler Hicks <tyhicks@linux.microsoft.com>
To:     Tushar Sugandhi <tusharsu@linux.microsoft.com>
Cc:     zohar@linux.ibm.com, stephen.smalley.work@gmail.com,
        casey@schaufler-ca.com, agk@redhat.com, snitzer@redhat.com,
        gmazyland@gmail.com, paul@paul-moore.com, sashal@kernel.org,
        jmorris@namei.org, nramas@linux.microsoft.com,
        linux-integrity@vger.kernel.org, selinux@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, dm-devel@redhat.com
Subject: Re: [PATCH v8 4/8] IMA: add policy rule to measure critical data
Message-ID: <20201212144741.GH4951@sequoia>
References: <20201211235807.30815-1-tusharsu@linux.microsoft.com>
 <20201211235807.30815-5-tusharsu@linux.microsoft.com>
 <20201212002500.GF4951@sequoia>
 <7e137e37-c195-1d16-05ef-56c2645fcc84@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7e137e37-c195-1d16-05ef-56c2645fcc84@linux.microsoft.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 2020-12-11 17:17:22, Tushar Sugandhi wrote:
> 
> 
> On 2020-12-11 4:25 p.m., Tyler Hicks wrote:
> > On 2020-12-11 15:58:03, Tushar Sugandhi wrote:
> > > A new IMA policy rule is needed for the IMA hook
> > > ima_measure_critical_data() and the corresponding func CRITICAL_DATA for
> > > measuring the input buffer. The policy rule should ensure the buffer
> > > would get measured only when the policy rule allows the action. The
> > > policy rule should also support the necessary constraints (flags etc.)
> > > for integrity critical buffer data measurements.
> > > 
> > > Add a policy rule to define the constraints for restricting integrity
> > > critical data measurements.
> > > 
> > > Signed-off-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>
> > > ---
> > >   Documentation/ABI/testing/ima_policy |  2 +-
> > >   security/integrity/ima/ima_policy.c  | 34 ++++++++++++++++++++++++----
> > >   2 files changed, 31 insertions(+), 5 deletions(-)
> > > 
> > > diff --git a/Documentation/ABI/testing/ima_policy b/Documentation/ABI/testing/ima_policy
> > > index e35263f97fc1..6ec7daa87cba 100644
> > > --- a/Documentation/ABI/testing/ima_policy
> > > +++ b/Documentation/ABI/testing/ima_policy
> > > @@ -32,7 +32,7 @@ Description:
> > >   			func:= [BPRM_CHECK][MMAP_CHECK][CREDS_CHECK][FILE_CHECK]MODULE_CHECK]
> > >   			        [FIRMWARE_CHECK]
> > >   				[KEXEC_KERNEL_CHECK] [KEXEC_INITRAMFS_CHECK]
> > > -				[KEXEC_CMDLINE] [KEY_CHECK]
> > > +				[KEXEC_CMDLINE] [KEY_CHECK] [CRITICAL_DATA]
> > >   			mask:= [[^]MAY_READ] [[^]MAY_WRITE] [[^]MAY_APPEND]
> > >   			       [[^]MAY_EXEC]
> > >   			fsmagic:= hex value
> > > diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
> > > index a09d1a41a290..07116ff35c25 100644
> > > --- a/security/integrity/ima/ima_policy.c
> > > +++ b/security/integrity/ima/ima_policy.c
> > > @@ -85,6 +85,7 @@ struct ima_rule_entry {
> > >   	} lsm[MAX_LSM_RULES];
> > >   	char *fsname;
> > >   	struct ima_rule_opt_list *keyrings; /* Measure keys added to these keyrings */
> > > +	struct ima_rule_opt_list *data_source; /* Measure data from this source */
> > 
> > Argh, there are still some more instances of data_source sneaking into
> > this patch too early instead of waiting until the next patch.
> > 
> I kept it purposefully in this patch so that the
> "case CRITICAL_DATA:" could be properly defined.
> 
> Also, my impression was rule->data_source is not part of the user facing
> policy.
> 
> Whereas IMA_DATA_SOURCE, Opt_data_source, data_source=%s are.
> That's why they are part of Patch #5.
> 
> Patch #5 IMA: limit critical data measurement based on a label
> 
> > >   	struct ima_template_desc *template;
> > >   };
> > > @@ -479,6 +480,12 @@ static bool ima_match_rule_data(struct ima_rule_entry *rule,
> > >   		opt_list = rule->keyrings;
> > >   		break;
> > > +	case CRITICAL_DATA:
> > > +		if (!rule->data_source)
> > > +			return true;
> > > +
> > > +		opt_list = rule->data_source;
> > > +		break;
> > 
> > I guess this case should unconditionally return true in this patch and
> > then the include this additional logic in the next patch.
> > 
> > Sorry, I missed these on my last review.
> > 
> No worries.
> 
> As I mentioned above, I kept it purposefully in this patch since
> my impression was rule->data_source is not part of the user facing
> policy.
> 
> But I can simply return true here as you suggested, and move the logic to
> the next patch.

I understand the thinking that it isn't harmful in this patch but I
think it is a bit cleaner to introduce the data_source policy language
element and all of its backend support in the same patch. Please move it
to the next patch. Thanks!

Tyler

> 
> +	case CRITICAL_DATA:
> +		if (!rule->data_source)
> +			return true;
> +
> +		opt_list = rule->data_source;
> +		break;
> 
> 
> ~Tushar
> 
