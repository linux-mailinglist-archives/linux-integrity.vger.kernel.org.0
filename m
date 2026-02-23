Return-Path: <linux-integrity+bounces-8544-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ENKYFvzSnGkJLAQAu9opvQ
	(envelope-from <linux-integrity+bounces-8544-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Mon, 23 Feb 2026 23:21:48 +0100
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 02BE817E399
	for <lists+linux-integrity@lfdr.de>; Mon, 23 Feb 2026 23:21:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9F1AF3015B57
	for <lists+linux-integrity@lfdr.de>; Mon, 23 Feb 2026 22:21:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABE903783C9;
	Mon, 23 Feb 2026 22:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="CSZuTDLt"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C81213783DC
	for <linux-integrity@vger.kernel.org>; Mon, 23 Feb 2026 22:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771885303; cv=pass; b=lsTDiH62UQUCP6wmTPLdD81Tjm8vnU7ZnsF0+J3UwW8TmSLljWYk/Na5BWoQt+LGWcChaDcmGyEKJWOwaqP+3PWKWCNuATVT1R/rs5iTXc5uzE7PnV5AtI4v8uDbpvrGcdVsBYBsMu0KvinC1h0E6Nvui1XvidLYatAQSLCuYJg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771885303; c=relaxed/simple;
	bh=laA8fxKUOs+Cw7EhbSLmhA3l6QzLfOUFVFuQ38rQLqQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X+gG2TtzOz6rfFYo+cyttx0FETQWAJJeXmFBH37QMBi4pooxFXfiK4Y6XYj2p1sse5Gn/MPDupWMImuEBSD2LfohijpwCtG14DzBt7acF3E2iYBlCjqKNYbt5pJhAxwDQReTJYgSudSvbe5n9jzLfNL57Gx/ldoJexQjLjJh5Zs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=CSZuTDLt; arc=pass smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-35851eadc17so2726804a91.2
        for <linux-integrity@vger.kernel.org>; Mon, 23 Feb 2026 14:21:41 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771885301; cv=none;
        d=google.com; s=arc-20240605;
        b=Gy6qRD4TthRhbJSA/LmWRkCR1VElFB4zxb1vk8uStiFn5vwRt0pZipMaFX0wFBK+3n
         ZjRkTC63/hog95tUBveADwPj47yiNoh3nNxhtmtpYqEKgg3VcB+7lXSd1HWpzKYzaX0O
         sfEKEdx4O4zpkuSJkSLbDW8qyIeD0GmB/NQPLa4NERTs3UfMzSVJDhvXP3LRM+oR++tv
         Jsk92XZ968Cki2WI3X8HgO8KhlBu9SvOQykB1nu6a7l+m6m+AHmqWtsAUBp0CyMfKmZA
         TX6WLsmjUfhoSybjLS6UJdBGCwfs1lK2RNgZfef0qdc/eknB7CJmEgTLrdpDq2mbitVT
         Q10g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=k9ZYfImaDpyTe2L1+2pEtc6yTABcUBTwYO7vVYurX8o=;
        fh=u6tumrvcOCPYB5NHsh9wwMOUv9c7HxKRS548osDigyg=;
        b=IZf4O5+VZNvH6NnewqyUK44wrk2VfM0mxSP1OliteqVaRq+zr0inZyAL5umw2deTHl
         bsrgChG2H+IN5KKpe8SgxQGASnwBzmXRPmcJounwwiaqNhjSOZk90FTi9LubulReNJ9d
         6Pg7gAr3g93QlUop1R81rPB2KThEo20yGrlzLvz9IM3AqrjwV9yJ3+5X3CPtDA11UK0M
         ERp1J4vvJXO+npEwNPI1sYS+5xTd6TJnzPP+B1g1VZqefDKIEDkHBfC3e2pAqcA8MPew
         mKhVoGuuahpGPtoFSICc1sNOJKDhLB9DiIZkXJ9BiQxSHcK0MrUySzQKYGK9UOrqRjkH
         njPQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1771885301; x=1772490101; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k9ZYfImaDpyTe2L1+2pEtc6yTABcUBTwYO7vVYurX8o=;
        b=CSZuTDLt22UDdxVqNRHk0BvF8nUM5UfBRwe4Uxyi4a+mE/iwe803jR5iN3CHGpRJZR
         +N9/vcbV+OT/trIi/0KyeVgobl2NBvdBXSvNbkllMzXUp02ba7IyJmQEyQjfY4P8BmqL
         oK1qN8nlmBECXM02OXCowJ7hX8JrHqAi67bdM13E3SCXTu1VBoej2T49757ojsgWWbTi
         /xksj1wJqb9xAKaq9EfBKOWp37fuhfBxP92oo7hpP0uzdnBnhwrzaEWPEIcHjDo4hhDM
         lvhahe2Mei4ot98C0QgSdJn33e41ILmeDh5uGtsWQtxKZKEqO9aleiuB3aUKTp/d88Th
         4OrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771885301; x=1772490101;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=k9ZYfImaDpyTe2L1+2pEtc6yTABcUBTwYO7vVYurX8o=;
        b=Ndl6giPA3B1PXXQHlOcPuRxdAdUxpEp8glBKa30v76dNsOfhPwxA3ZA47EjDQmwk/n
         eZVtaMkK7sgX/mbDSy0AL9pyjkpSmar40OzRvXWfjQnwqFEgMbA2C/2Sl0eOylaV5SNs
         RG+EYsGfjk7V6ywWCnEdASlighQ9c+o/m2TVPXMrrKYcCDMGTvOOqnX9he4zUu+ZXQ9p
         zpla3W7HHJ9iFuxYUpt2h51a+PrToiGMfns5y6/JLFB7D/AhacDp1v6JEoWaV8uJHW4l
         xUsyVKhJH8NlehJLr5bqiU11z3A4Rc/3DLHgL4Ez1TOyJX+4BYqdApM0o/N/96PqEOwK
         JDcw==
X-Forwarded-Encrypted: i=1; AJvYcCWcaI/Ys3uqQXAVXXnLZRoXbm7bSYV8cUivJBSfJkU2m4UX/nZQK8LhK48SKn3VjjKTygg/ErophunZEDt5Pas=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPP+DMtZtadLfB4fyT/2OYW6jOz0JpU1hxzRckmKrYed6uDRBT
	/44LHuXb106EaRnQ84Oeo9UqAcLKcn20YboSvOtwJeKflFG99vNkFk7D7/pWUduf/urmmopNDsM
	vbGu6kFK0UnzLaT0I7cji0OqztVJkcjg+Ll7tKoQb
X-Gm-Gg: ATEYQzyPXn+7luUnghbUxkZaUoPn+R+OeYHer5T16yIOTmaKFzd0qWqzlDADJcpDDvp
	CIe8IPbuULKrY8hDX1G5yGRSKAZSkLe6boPPRYoL5NZQK2hQIHk5NS6IFGx3BnLLPnWOf3kKHRG
	+pCQTthSoZzNGMEP/CRtNxnBa5LLkYFKf9exHaCHar1UnIq3Bolz8TlAHKBoQw0982ENn8taIpp
	KP4PwHp6wa2qR9nnugMRH20JxDZTVt4TOiy6seSDOC+TQomQYkYVOGSN9e8I5ZQP+/JGK2s6DPw
	CEVGQo+bEaarJ1XIhA==
X-Received: by 2002:a17:90b:3d46:b0:356:2fee:92cb with SMTP id
 98e67ed59e1d1-358ae80a6b5mr7566836a91.8.1771885301191; Mon, 23 Feb 2026
 14:21:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260220195405.30612-1-danieldurning.work@gmail.com> <9229d70d-aa7a-459f-b005-695e99888783@schaufler-ca.com>
In-Reply-To: <9229d70d-aa7a-459f-b005-695e99888783@schaufler-ca.com>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 23 Feb 2026 17:21:29 -0500
X-Gm-Features: AaiRm52qgdM1-bPMDqdvit-s0syTJEbYBD7y07LXgBdLcQeQROdMVa1XCyRpsj4
Message-ID: <CAHC9VhSp+X8YNocS7sDz+UyhdJh2yY8CRoi6dwV1eOGdCu9f9w@mail.gmail.com>
Subject: Re: [PATCH] lsm: move inode IS_PRIVATE checks to individual LSMs
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: danieldurning.work@gmail.com, linux-security-module@vger.kernel.org, 
	selinux@vger.kernel.org, linux-integrity@vger.kernel.org, 
	stephen.smalley.work@gmail.com, jmorris@namei.org, serge@hallyn.com, 
	john.johansen@canonical.com, zohar@linux.ibm.com, roberto.sassu@huawei.com, 
	dmitry.kasatkin@gmail.com, mic@digikod.net, takedakn@nttdata.co.jp, 
	penguin-kernel@i-love.sakura.ne.jp
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[paul-moore.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[paul-moore.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8544-lists,linux-integrity=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,namei.org,hallyn.com,canonical.com,linux.ibm.com,huawei.com,digikod.net,nttdata.co.jp,i-love.sakura.ne.jp];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[paul@paul-moore.com,linux-integrity@vger.kernel.org];
	DKIM_TRACE(0.00)[paul-moore.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-integrity];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,mail.gmail.com:mid,schaufler-ca.com:email,paul-moore.com:url,paul-moore.com:dkim]
X-Rspamd-Queue-Id: 02BE817E399
X-Rspamd-Action: no action

On Fri, Feb 20, 2026 at 4:13=E2=80=AFPM Casey Schaufler <casey@schaufler-ca=
.com> wrote:
> On 2/20/2026 11:54 AM, danieldurning.work@gmail.com wrote:
> > From: Daniel Durning <danieldurning.work@gmail.com>
> >
> > Move responsibility of bypassing S_PRIVATE inodes to the
> > individual LSMs. Originally the LSM framework would skip calling
> > the hooks on any inode that was marked S_PRIVATE. This would
> > prevent the LSMs from controlling access to any inodes marked as
> > such (ie. pidfds). We now perform the same IS_PRIVATE checks
> > within the LSMs instead. This is consistent with the general goal
> > of deferring as much as possible to the individual LSMs.
>
> Um ... ick?
>
> Sure, we generally want the LSMs to be responsible for their own
> decisions, but that doesn't look like the point to me. What appears
> to be the issue is that pidfs isn't using S_PRIVATE in a way that
> conveys the necessary information to the LSMs.

First off, consider this the annual reminder for everyone to *please*
trim their replies when discussing things on-list.  Everything is
archived on lore, we're not losing anything, and it makes things *so*
much easier to read if we don't have to skim over the entire email to
make sure we haven't missed any comments.

Now, back to the S_PRIVATE issue ...

I was the one who first suggested (it may have been on the SELinux
list, or in an off-list discussion, not sure?) that moving the
S_PRIVATE check into the individual LSMs was a way to work around the
issue with pidfd/pidfs, so please don't blame Daniel for this, he has
been doing good work trying to solve a rather ugly problem.

> > This reorganization enables the LSMs to eventually implement
> > checks or labeling for some specific S_PRIVATE inodes like pidfds.
>
> We could consider these or similar changes when that eventuality occurs.

To be clear, that time is now, that is just a dependency of that which
needs to be sorted out first.

> I would strongly suggest that this is a pidfs issue, not an LSM
> infrastructure issue.

I'm not going to argue with that, and perhaps that is a good next
step: send a quick RFC patch to the VFS folks, with the LSM list CC'd,
that drops setting the S_PRIVATE flag to see if they complain too
loudly.  Based on other threads, Christian is aware that we are
starting to look at better/proper handling of pidfds/pidfs so he may
be open to dropping S_PRIVATE since it doesn't really have much impact
outside of the LSM, but who knows; the VFS folks have been growing a
bit more anti-LSM as of late.

diff --git a/fs/pidfs.c b/fs/pidfs.c
index 318253344b5c..4cec73b4cbcf 100644
--- a/fs/pidfs.c
+++ b/fs/pidfs.c
@@ -921,7 +921,7 @@ static int pidfs_init_inode(struct inode *inode, void *=
data)
       const struct pid *pid =3D data;

       inode->i_private =3D data;
-       inode->i_flags |=3D S_PRIVATE | S_ANON_INODE;
+       inode->i_flags |=3D S_ANON_INODE;
       /* We allow to set xattrs. */
       inode->i_flags &=3D ~S_IMMUTABLE;
       inode->i_mode |=3D S_IRWXU;

--=20
paul-moore.com

