Return-Path: <linux-integrity+bounces-8451-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OBJsNYe4g2lwtQMAu9opvQ
	(envelope-from <linux-integrity+bounces-8451-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Wed, 04 Feb 2026 22:22:15 +0100
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id F15A1ECB40
	for <lists+linux-integrity@lfdr.de>; Wed, 04 Feb 2026 22:22:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 649ED300460F
	for <lists+linux-integrity@lfdr.de>; Wed,  4 Feb 2026 21:22:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B965338BF67;
	Wed,  4 Feb 2026 21:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="YakFmS/P"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6089B353EF6
	for <linux-integrity@vger.kernel.org>; Wed,  4 Feb 2026 21:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770240130; cv=none; b=OMwuSLamrimBwSHfKNmvwP0f1ybiZR16rs9/vImzmM8Pd2MwLdS/QYXE36ljyMWCtNbzTH+MCNr2Ul5i9RnLyYJ/97gcPSuCHH/Dqii7C9QkFbbsYXJwUH3nNr342ouHhWjrdmkxYhrK8ti+wuOay6cTbVxNL0C5uZ6jPN3tNs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770240130; c=relaxed/simple;
	bh=BMkEm1h0yqxGL79B9vL9ribwfVgXcsFGW6l8FQV73ZU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LAKH9vym/aliM9D36jpmUWCLDIPvMLEzdQ43mW1iprYKEHi/u8IX2LBjUkvBlUO/TsBV6FqzAeAm9vGUQ4p8M9g7ChuB1nZrcJAlLFr61sAt31PAo+supGVKZpqpcm0CLSuq/dNgVHDWor+b4zDYGwuya36vlXVJcteXE3fStxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=YakFmS/P; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-7cfd53a8c31so775699a34.1
        for <linux-integrity@vger.kernel.org>; Wed, 04 Feb 2026 13:22:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1770240129; x=1770844929; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xhRyIcVh982aeUAhunNuQefxD1ERKdFkk0A876qdfz8=;
        b=YakFmS/PLZP+mmelh4iJYQBXZTskkLhJ9CC8uGTQKa0wCSWnqlSzhb4VP3qg1786mk
         W6mOD/ROc5OvTrH5Tkr63RUAiAWzRSRdC+wZYwojJpMwqhRVGv38ZJT9+PvkQlx19MB5
         5gPWYcmUfy6m6gfv2+pSoh+6dX/iXvQq4EGTN7WGc2WpVQ1A7BGCJheGgISpNHoOjPHm
         uGWhW8V8qSML4r2VC0Cs8ZKFGA0Bl+/OGIKj7PSIpxSYdZmqRbXXrNRCUbkFfp6GHWGI
         BVPqg/2xZhfuWZLOTdz6LvwIHpWTgMs6BDpZmU7UJRXSE6CBq/XAfTuct96qJk6n3blp
         RJAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770240129; x=1770844929;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xhRyIcVh982aeUAhunNuQefxD1ERKdFkk0A876qdfz8=;
        b=oKmj4eAMmPEzlgnzqj2LVR934lf1zmr4EuelwtkvkxxQDF8OeMiMeAn5YBwR44J7zj
         +XFfWkoe7CBpOl5OE3SJEMkGTRuOiMeU1XzR5Bzt2+M6udxztkYHS9+8JapBCQUFB6sF
         XShkBVVG9DOc96bQpILojz217brUyc3DAs5SFVyrDMIXZIfQ9w/w1F+d6UWUPOYnbhvU
         tRNGOiikszB8rBPAowyi7fU/VJSlbPtzlwr+1ZuPAcozcPM+DDd/aoz4Aus0N4KrxW6q
         ctX57IWUu+fNtWoYzf5kzOJMhXIz/lyPTSkcyhegjqYM8NAhJT4CF+GsTs9SeGyvp50C
         kWHw==
X-Forwarded-Encrypted: i=1; AJvYcCVjpV12Qk0T6J2hP4h2bYM9aYdHUIYSwNZ6n3C1BhAS8FkoeXbfpZBx/t7p5+N91uQr3f4E/mm8Ju7ywjC3jMc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUb8tMmcjNpjzytAYRhzo+ygKjLpoHKPjsMX7m0ecUPWvXsdEY
	AsZN+Sbp30CxzwpVaQHolNFh6yjMi3utZ02AOeI0EDOzyZ+EUrnFtV5GEXTXMVdEPpw=
X-Gm-Gg: AZuq6aIfqlkUifEWIh+5FzJDe2GJH1wMjrjw5bH7rnSxvfX9DeU61fdBVqcf83h7KH5
	Mc5tQxMm4UxMIrHs4flNbtSFaKSJWe3aEzcbFozJ1UmKaQkTMbAqLpdlefILZ1pp7+tk02N/vo5
	WwL7kGviwuUnBsCyyGuC74BGmdAaD2UBXoFM0JLIH/ivIcmvik1cqWLhplZcQCd/b/VITDnlvr9
	KL7CO8jxS5yNyW61rk8E3JQesVzsg1XAD/QiAvFKoY48pbaSzKMe6Qe/I/Iz3RPUL42RdNtnUUH
	571apN9LwtzRVnqBBKckbUz5gUYwMRAxYOdnYAxs7stfTxkvd4huk3dl9VzzCjo1nXU7SpcWfjz
	GrePBpNWPuW/7bg+fZqrvR6nNoQgNYqHLzVveLotiMxFqkntkNsBQVgJvbtmJ86WhJpnR
X-Received: by 2002:a05:6808:140a:b0:441:c8a2:ba26 with SMTP id 5614622812f47-462e9ee6fd0mr407092b6e.7.1770240129136;
        Wed, 04 Feb 2026 13:22:09 -0800 (PST)
Received: from CMGLRV3 ([2a09:bac5:947d:1b37::2b6:4e])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-462d67cf821sm1999909b6e.15.2026.02.04.13.22.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Feb 2026 13:22:08 -0800 (PST)
Date: Wed, 4 Feb 2026 15:22:06 -0600
From: Frederick Lawler <fred@cloudflare.com>
To: Roberto Sassu <roberto.sassu@huaweicloud.com>
Cc: Mimi Zohar <zohar@linux.ibm.com>,
	Roberto Sassu <roberto.sassu@huawei.com>,
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
	Eric Snowberg <eric.snowberg@oracle.com>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	Josef Bacik <josef@toxicpanda.com>,
	Jeff Layton <jlayton@kernel.org>, linux-kernel@vger.kernel.org,
	linux-integrity@vger.kernel.org,
	linux-security-module@vger.kernel.org, kernel-team@cloudflare.com
Subject: Re: [PATCH v5 3/3] ima: Use kstat.ctime as a fallback change
 detection for stacked fs
Message-ID: <aYO4fj0Uw0aUWXOX@CMGLRV3>
References: <20260130-xfs-ima-fixup-v5-0-57e84ea91712@cloudflare.com>
 <20260130-xfs-ima-fixup-v5-3-57e84ea91712@cloudflare.com>
 <c449523aef301a6b199e06d4c3fbf7587d1218c5.camel@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c449523aef301a6b199e06d4c3fbf7587d1218c5.camel@huaweicloud.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-7.16 / 15.00];
	WHITELIST_DMARC(-7.00)[cloudflare.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[cloudflare.com,reject];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[cloudflare.com:s=google09082023];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8451-lists,linux-integrity=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[linux.ibm.com,huawei.com,gmail.com,oracle.com,paul-moore.com,namei.org,hallyn.com,kernel.org,toxicpanda.com,vger.kernel.org,cloudflare.com];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fred@cloudflare.com,linux-integrity@vger.kernel.org];
	DKIM_TRACE(0.00)[cloudflare.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-integrity];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[cloudflare.com:email,cloudflare.com:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: F15A1ECB40
X-Rspamd-Action: no action

On Wed, Feb 04, 2026 at 01:36:09PM +0100, Roberto Sassu wrote:
> On Fri, 2026-01-30 at 16:39 -0600, Frederick Lawler wrote:
> > IMA performs unnecessary measurements on files in stacked file systems
> > that do not set kstat.change_cookie to an inode's i_version.
> > 
> > For example: TMPFS (upper) is stacked onto XFS (lower).
> > Actions files result in re-measurement because commit 1cf7e834a6fb
> > ("xfs: switch to multigrain timestamps") introduced multigrain
> > timestamps into XFS which changed the kstat.change_cookie semantics
> > to no longer supply an i_version to compare against in
> > integrity_inode_attributes_changed(). Once the inode is in TMPFS,
> > the change detection behavior operates as normal because TMPFS updates
> > kstat.change_cookie to the i_version.
> > 
> > Instead, fall back onto a ctime comparison. This also gives file systems
> > that do not support i_version an opportunity avoid the same behavior,
> > as they're more likely to have ctime support.
> > 
> > timespec64_to_ns() is chosen to avoid adding extra storage to
> > integrity_inode_attributes by leveraging the existing version field.
> 
> Correct me if I'm wrong, but this issue seems to me xfs-specific. In
> that case, maybe it is better to remove the stacked filesystem part,
> which might be misleading.

I'm using XFS because that's a clear example, but as Jeff pointed out in
an earlier email, there's too many file systems to account for. It's
clear from Jeff's prior email[1] that the intention is to stop using
change cookie for change detection for more file systems in favor
of multigrain ctime.

The stacked part is important because AFAIK, if not on stacked file system
the check in process_measurement() line 329 is skipped because
of the last_writer check doing the atomic read on the write count.

That said, I think Mimi pointed out in an email [2] where multi-grain
file systems are impacted regardless of stacked fs or not due to the last
writer check.

I don't recall coming across that in my tests, but perhaps I did that
specific test wrong? To be sure, I created the C program, and on the VM,
created a XFS disk, mounted it on loopback, ran the rdwr program on
"somefile" multiple times, and only got 1 audit log for it, until I
mutated it with touch, and only got 2 hits: original + after mutation
after running the program multiple times. 

I'm not sure what's going on there, so I'll look into that a bit more,
but so far the impact is stacked file systems & multigrain ctime AFAIK.

[1]: https://lore.kernel.org/all/75618d9f454aece9a991d74eaf7ae5160828e901.camel@kernel.org/
[2]: https://lore.kernel.org/all/69540ac3aca536db948b6585b7076946a12ebe36.camel@linux.ibm.com/

> 
> Thanks
> 
> Roberto
> 
> > Link: https://lore.kernel.org/all/aTspr4_h9IU4EyrR@CMGLRV3
> > Fixes: 1cf7e834a6fb ("xfs: switch to multigrain timestamps")
> > Suggested-by: Jeff Layton <jlayton@kernel.org>
> > Signed-off-by: Frederick Lawler <fred@cloudflare.com>
> > ---
> >  include/linux/integrity.h         |  6 +++++-
> >  security/integrity/ima/ima_api.c  | 11 ++++++++---
> >  security/integrity/ima/ima_main.c |  2 +-
> >  3 files changed, 14 insertions(+), 5 deletions(-)
> > 
> > diff --git a/include/linux/integrity.h b/include/linux/integrity.h
> > index 382c783f0fa3ae4a938cdf9559291ba1903a378e..ec2c94907f417c4a71ecce29ac79edac9bc2c6f8 100644
> > --- a/include/linux/integrity.h
> > +++ b/include/linux/integrity.h
> > @@ -10,6 +10,7 @@
> >  #include <linux/fs.h>
> >  #include <linux/iversion.h>
> >  #include <linux/kernel.h>
> > +#include <linux/time64.h>
> >  
> >  enum integrity_status {
> >  	INTEGRITY_PASS = 0,
> > @@ -58,6 +59,9 @@ integrity_inode_attrs_stat_changed
> >  	if (stat->result_mask & STATX_CHANGE_COOKIE)
> >  		return stat->change_cookie != attrs->version;
> >  
> > +	if (stat->result_mask & STATX_CTIME)
> > +		return timespec64_to_ns(&stat->ctime) != (s64)attrs->version;
> > +
> >  	return true;
> >  }
> >  
> > @@ -84,7 +88,7 @@ integrity_inode_attrs_changed(const struct integrity_inode_attributes *attrs,
> >  	 * only for IMA if vfs_getattr_nosec() fails.
> >  	 */
> >  	if (!file || vfs_getattr_nosec(&file->f_path, &stat,
> > -				       STATX_CHANGE_COOKIE,
> > +				       STATX_CHANGE_COOKIE | STATX_CTIME,
> >  				       AT_STATX_SYNC_AS_STAT))
> >  		return !IS_I_VERSION(inode) ||
> >  		       !inode_eq_iversion(inode, attrs->version);
> > diff --git a/security/integrity/ima/ima_api.c b/security/integrity/ima/ima_api.c
> > index c35ea613c9f8d404ba4886e3b736c3bab29d1668..e47d6281febc15a0ac1bd2ea1d28fea4d0cd5c58 100644
> > --- a/security/integrity/ima/ima_api.c
> > +++ b/security/integrity/ima/ima_api.c
> > @@ -272,10 +272,15 @@ int ima_collect_measurement(struct ima_iint_cache *iint, struct file *file,
> >  	 * to an initial measurement/appraisal/audit, but was modified to
> >  	 * assume the file changed.
> >  	 */
> > -	result = vfs_getattr_nosec(&file->f_path, &stat, STATX_CHANGE_COOKIE,
> > +	result = vfs_getattr_nosec(&file->f_path, &stat,
> > +				   STATX_CHANGE_COOKIE | STATX_CTIME,
> >  				   AT_STATX_SYNC_AS_STAT);
> > -	if (!result && (stat.result_mask & STATX_CHANGE_COOKIE))
> > -		i_version = stat.change_cookie;
> > +	if (!result) {
> > +		if (stat.result_mask & STATX_CHANGE_COOKIE)
> > +			i_version = stat.change_cookie;
> > +		else if (stat.result_mask & STATX_CTIME)
> > +			i_version = timespec64_to_ns(&stat.ctime);
> > +	}
> >  	hash.hdr.algo = algo;
> >  	hash.hdr.length = hash_digest_size[algo];
> >  
> > diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
> > index 8cb17c9d446caaa5a98f5ec8f027c17ba7babca8..776db158b0bd8a0d053729ac0cc15af8b6020a98 100644
> > --- a/security/integrity/ima/ima_main.c
> > +++ b/security/integrity/ima/ima_main.c
> > @@ -199,7 +199,7 @@ static void ima_check_last_writer(struct ima_iint_cache *iint,
> >  					    &iint->atomic_flags);
> >  		if ((iint->flags & IMA_NEW_FILE) ||
> >  		    vfs_getattr_nosec(&file->f_path, &stat,
> > -				      STATX_CHANGE_COOKIE,
> > +				      STATX_CHANGE_COOKIE | STATX_CTIME,
> >  				      AT_STATX_SYNC_AS_STAT) ||
> >  		    integrity_inode_attrs_stat_changed(&iint->real_inode,
> >  						       &stat)) {
> > 
> 

