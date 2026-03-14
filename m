Return-Path: <linux-integrity+bounces-8994-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gHvBLgxZtWl5zgAAu9opvQ
	(envelope-from <linux-integrity+bounces-8994-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Sat, 14 Mar 2026 13:48:12 +0100
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3030428D347
	for <lists+linux-integrity@lfdr.de>; Sat, 14 Mar 2026 13:48:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B63CA302AC11
	for <lists+linux-integrity@lfdr.de>; Sat, 14 Mar 2026 12:47:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 743B72264C7;
	Sat, 14 Mar 2026 12:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SLrjb/7e"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3CD95C613
	for <linux-integrity@vger.kernel.org>; Sat, 14 Mar 2026 12:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773492474; cv=none; b=K+uPhBZAX28dbmJBv2014h2qElrm7ii/e7USqArVdbMEHhjjItmReKPqqdxrGCnp1Pu+FEw8ka6IUfjv67rJ+QNa9Aqcb7XJQIMIOtTGPI4ZWaciDQ8qfYhiDAYJrkza1jgB4O0plv0UC2WpnjhvUCH2IVKWYN+uVU1HY15BGcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773492474; c=relaxed/simple;
	bh=fA+lyYP+110atZU61RzhzGbte3ZkKDvt1ynoLWRnNes=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=M3t9hZtruc7QYA1YZonCMXjkXRsTY/321PB5GnXP0/SkmPK9DPzwy25da4ZImMMmewWrzFTblgEV8qkaFPuAHZ0ukD6T7xs1MJAAk9hYisyQWAG02bBy+aFbXerU5tv9oVVsDHRZsxb9xLGehKqb4fdxGHHEnvsLahT2LHNrCq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SLrjb/7e; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4852e09e23dso26171385e9.0
        for <linux-integrity@vger.kernel.org>; Sat, 14 Mar 2026 05:47:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773492470; x=1774097270; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vaFmVkPTbLRBufh3Qs4dGizBfbZxXt2RQDq/b/ikJHk=;
        b=SLrjb/7ehi9mvnV2lp8cG6GHoo8DoxbKPQA9OfghINpA2cBulLrDFt0cTBop6qCybZ
         Z74tVSY/x1UMCAkrib7HuJvcTIzN7xYqE9UVpD7QR9zFnOL+qAT8tSwBj6FArLhw+luj
         4Tiqt0fBcpROCkc3zTYes+EsNyt39+15GaJuCcJe1dvPSmRlVT1nXxGC2GpPnjal9WDI
         zKcwhYmsjtVhq1yVY3Yl65iSqGFjp7eQ2BIV+XnXSNN4DoPQCCTuwNWvGC4UJ+zpUhO6
         C4aIF2gapzA3Db7q9kstfSnrhu043ksiaU+NBR9xrEacnxH3dLPVsi2tsquwp1R5tuEF
         f72g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773492470; x=1774097270;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vaFmVkPTbLRBufh3Qs4dGizBfbZxXt2RQDq/b/ikJHk=;
        b=NLMiWVcidPnRzuiKM68ou2gIKcXZuZ5Wz/cTeJ3v7Y8AuDX24nKi6mQ5FXcl1ivTlr
         gCScfprmRbLT2p+lfFNdBy80rxOviKkL0Z9sjZEu4sJwvIyFSF6cLtquV2mk30ORA4pc
         89t2WQ1mT8X5HeNW29gAHhHR6hqH0baTcqvaqdEoTLD9kDWHDx6RtgJQ5mhMtBUIVlEU
         A6H8UD+7NFBTxcej0sN/LNyb6oZ0071sJVTdAGmBCQSpmbbtgknfuSKsIAPVVfZHwSmV
         iZSHbiNOJpx9uLcZdOsDzWOyuOtdsqvlxU0qSwpKMklvcctyoWWcLUnpambAUw/f8Z7Q
         HsEQ==
X-Forwarded-Encrypted: i=1; AJvYcCUrncWapjzMtRlC0HKQbD/oPcL9IC9SfsghcsLZ0fEzVZmGYSEJ2ILKfS+U877T4bejXdr8FaZmXCWXgzUJhjQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRcDWlXe3VcioF5eTES9KsyuxDKC6pbDdeq5AHJZ6cf2kANQI+
	PqRcFuNgueZeAyJhuhscRhoeLJCpx33WQU40vcGfliy0CDia4Ohc6b6T
X-Gm-Gg: ATEYQzznrmPm6fBhjK560C5k5PBiRGMGzupiFXpLi7xOSFpUsNBBuXjU8/GS0jr/N85
	Meu7//KpmnTt5dHYS9NT0/s3vbvJvPe8IBHVBz0MfK12OsDjr4rJrxKytMj9Pgx3dnZt5nEvesl
	T2aPJeyKAe1g2Fq3PFRFpP871jbpY7SN/61MzfwEKvgNz+45300ohZgnwbsdzTFwZciZErYyRN2
	qM+IMVPX+OwkWuUa25fp265tieBNwVulxwXqqTpcrGJcfAXAQjy2N99LexzCN7eQAq2qWLmsqns
	EtV92caNV8WYWHIIDQjkj3H9oLvkpVsoTbyxDbusWVi6zDkZ/8WEoPA0DSEDr9hbQmZj4mu0xtz
	prLdJ0Qawo55LrapgWMH7m7sFHMoLHl+/CRZ7n+KLHGxoMsh0sgiXcOmTr2wM1X2+9q0VccwwSU
	pXbL26QCVEJldDOiK4rHdnhLWIN/lxx+8NrSIN3kIzU5RDvgOkY1icYfr1oyhw/OnX
X-Received: by 2002:a05:600c:8b83:b0:477:54f9:6ac2 with SMTP id 5b1f17b1804b1-4855648f5a3mr104574955e9.0.1773492469891;
        Sat, 14 Mar 2026 05:47:49 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4854e2537c3sm281121385e9.15.2026.03.14.05.47.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Mar 2026 05:47:49 -0700 (PDT)
Date: Sat, 14 Mar 2026 12:47:48 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Jeff Layton <jlayton@kernel.org>
Cc: Ryusuke Konishi <konishi.ryusuke@gmail.com>, Viacheslav Dubeyko
 <slava@dubeyko.com>, Christian Brauner <brauner@kernel.org>, Mimi Zohar
 <zohar@linux.ibm.com>, Roberto Sassu <roberto.sassu@huawei.com>, Dmitry
 Kasatkin <dmitry.kasatkin@gmail.com>, Eric Snowberg
 <eric.snowberg@oracle.com>, Paul Moore <paul@paul-moore.com>, James Morris
 <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>,
 linux-nilfs@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v2 1/2] nilfs2: fix 64-bit division operations in
 nilfs_bmap_find_target_in_group()
Message-ID: <20260314124748.1ccdf93b@pumpkin>
In-Reply-To: <20260313-iino-u64-v2-1-f9abda2464d5@kernel.org>
References: <20260313-iino-u64-v2-0-f9abda2464d5@kernel.org>
	<20260313-iino-u64-v2-1-f9abda2464d5@kernel.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8994-lists,linux-integrity=lfdr.de];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[17];
	FREEMAIL_CC(0.00)[gmail.com,dubeyko.com,kernel.org,linux.ibm.com,huawei.com,oracle.com,paul-moore.com,namei.org,hallyn.com,vger.kernel.org,intel.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[davidlaightlinux@gmail.com,linux-integrity@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-integrity];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email,dubeyko.com:email]
X-Rspamd-Queue-Id: 3030428D347
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, 13 Mar 2026 14:45:20 -0400
Jeff Layton <jlayton@kernel.org> wrote:

> With the change to make inode->i_ino a u64, the build started failing on
> 32-bit ARM with:
> 
>     ERROR: modpost: "__aeabi_uldivmod" [fs/nilfs2/nilfs2.ko] undefined!
> 
> Fix this by using the 64-bit division interfaces in
> nilfs_bmap_find_target_in_group().
> 
> Fixes: 998a59d371c2 ("treewide: fix missed i_ino format specifier conversions")
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202603100602.KPxiClIO-lkp@intel.com/
> Reviewed-by: Viacheslav Dubeyko <slava@dubeyko.com>
> Acked-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>  fs/nilfs2/bmap.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/nilfs2/bmap.c b/fs/nilfs2/bmap.c
> index 824f2bd91c167965ec3a660202b6e6c5f1fe007e..abcf5252578ad24f694bfccf525893674bfcb4bc 100644
> --- a/fs/nilfs2/bmap.c
> +++ b/fs/nilfs2/bmap.c
> @@ -455,11 +455,14 @@ __u64 nilfs_bmap_find_target_in_group(const struct nilfs_bmap *bmap)
>  {
>  	struct inode *dat = nilfs_bmap_get_dat(bmap);
>  	unsigned long entries_per_group = nilfs_palloc_entries_per_group(dat);
> -	unsigned long group = bmap->b_inode->i_ino / entries_per_group;

Are you sure entries_per_group can be more than 32 bits?
It looks like something that will be the same size on 32 and 64bit.

> +	unsigned long group;
> +	u32 index;
> +
> +	group = div_u64(bmap->b_inode->i_ino, entries_per_group);

You don't need the full 64 by 64 divide.
IIRC there are both div_u64_u32() and div_u64_ulong().

> +	div_u64_rem(bmap->b_inode->i_ino, NILFS_BMAP_GROUP_DIV, &index);

NILFD_BMAP_GROUP_DIV is 8 (and probably has to be a power of 2).
So:
	index = bmap->b_inode->i_ino & (NILFS_BMAP_GROUP_DIV - 1);
is the same and likely much faster to calculate.
(The compiler will have done that optimisation before.)

	David


>  
>  	return group * entries_per_group +
> -		(bmap->b_inode->i_ino % NILFS_BMAP_GROUP_DIV) *
> -		(entries_per_group / NILFS_BMAP_GROUP_DIV);
> +	       index * (entries_per_group / NILFS_BMAP_GROUP_DIV);
>  }
>  
>  static struct lock_class_key nilfs_bmap_dat_lock_key;
> 


