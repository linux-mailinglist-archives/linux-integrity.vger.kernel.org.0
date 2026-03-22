Return-Path: <linux-integrity+bounces-9026-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YIwnCvL5v2nICAQAu9opvQ
	(envelope-from <linux-integrity+bounces-9026-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Sun, 22 Mar 2026 15:17:22 +0100
X-Original-To: lists+linux-integrity@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 94BA12E9999
	for <lists+linux-integrity@lfdr.de>; Sun, 22 Mar 2026 15:17:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7620C30073FD
	for <lists+linux-integrity@lfdr.de>; Sun, 22 Mar 2026 14:17:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 467D52DF3FD;
	Sun, 22 Mar 2026 14:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LWUlYzmM"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 231B31A682B;
	Sun, 22 Mar 2026 14:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774189039; cv=none; b=mNxduDcg7uWw8DJ4iB6K+DKooIz9N98wlqIdkk7qBaX7BfO8u3N90WLKfGk0JpH/1kRmVTQllOUNUrFbtddhPMDQIZpF1WDQ5Z5PhHjoOkYDGiTjNSiR5v/Q0q9vHmsRG6mo7K1qWAnj3zoLjHJqkz+x37A8+fyy9OevTgqHOvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774189039; c=relaxed/simple;
	bh=uL3y1n/5xs4hBoDhl/sWONCOW2Xvzld3GyVrrNfzD/g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HK9A6PfNN3VU/biWm3xkYK0x6tVBsz9CqwO3dTTrQ3CUAEq7B/Plo3+bzIxGCTP3pvZjs1Oq/wEsS5joisjplV2AoZ2fTVD/SYwNA2rMP+hbpApkAkICXWIW5yK+f8tP5t1SzPKbdR/vIdeuBaIwC8RCvC3J8WJzxgQkYehfFOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LWUlYzmM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45A02C19424;
	Sun, 22 Mar 2026 14:17:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774189038;
	bh=uL3y1n/5xs4hBoDhl/sWONCOW2Xvzld3GyVrrNfzD/g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LWUlYzmMprcPtvsNtcoqQsdisQe1Xqgwo/i1bCtqPF3+enJhLJVVatxij3NnY/L1Y
	 FoY2gXd8z4Mnjsd3LRXCglcug7A2R+BhU9NQKVke+CVLcCr7Rm3rFIihNOvvaIKozv
	 HtnVZxFuYUH81xwhYH/lhUDnPGeczimGv49BRKnP8lCQtSMlhAo9dvXV62eG8Oosj6
	 zL8OqLDRuZE08lXu0AS/BKg4RbMN6Jb7xq8Yed2w33eQqsOIfrFnlqnaIqBqWkP/lq
	 2eu+kMv92WMuvKU14ciMDzeTHWwiLP2pqpkqaGULOu3g2L8HQT2s9piB2PwL2yP/gd
	 1kzmanwc294mw==
Date: Sun, 22 Mar 2026 07:17:16 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Shigeru Yoshida <syoshida@redhat.com>
Cc: Mimi Zohar <zohar@linux.ibm.com>,
	Roberto Sassu <roberto.sassu@huawei.com>,
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
	Eric Snowberg <eric.snowberg@oracle.com>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	syzbot+6ed94e81a1492fe1d512@syzkaller.appspotmail.com,
	linux-integrity@vger.kernel.org,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ima: abort file hash computation on fatal signal
Message-ID: <20260322141716.GB2183@quark>
References: <20260322111019.2815601-1-syoshida@redhat.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260322111019.2815601-1-syoshida@redhat.com>
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9026-lists,linux-integrity=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[linux.ibm.com,huawei.com,gmail.com,oracle.com,paul-moore.com,namei.org,hallyn.com,syzkaller.appspotmail.com,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ebiggers@kernel.org,linux-integrity@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-integrity,6ed94e81a1492fe1d512];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,appspotmail.com:email]
X-Rspamd-Queue-Id: 94BA12E9999
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sun, Mar 22, 2026 at 08:10:19PM +0900, Shigeru Yoshida wrote:
> ima_calc_file_hash_atfm() and ima_calc_file_hash_tfm() compute a hash
> over the entire file contents without checking for pending fatal
> signals. When a very large file is being hashed during mmap (via
> ima_file_mmap), the computation can take an extended period. If a
> coredump is initiated by another thread in the same thread group during
> this time, the dumper thread waits in coredump_wait() for all other
> threads to exit. However, the hashing thread cannot exit until the hash
> loop completes, resulting in a hung task.
> 
> Add fatal_signal_pending() checks to both the ahash and shash file
> hashing loops so that the computation is aborted promptly when SIGKILL
> is received.
> 
> Fixes: 3323eec921ef ("integrity: IMA as an integrity service provider")
> Reported-by: syzbot+6ed94e81a1492fe1d512@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=6ed94e81a1492fe1d512
> Tested-by: syzbot+6ed94e81a1492fe1d512@syzkaller.appspotmail.com
> Signed-off-by: Shigeru Yoshida <syoshida@redhat.com>
> ---
>  security/integrity/ima/ima_crypto.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/security/integrity/ima/ima_crypto.c b/security/integrity/ima/ima_crypto.c
> index aff61643415d..7b721b9c944f 100644
> --- a/security/integrity/ima/ima_crypto.c
> +++ b/security/integrity/ima/ima_crypto.c
> @@ -17,6 +17,7 @@
>  #include <linux/crypto.h>
>  #include <linux/scatterlist.h>
>  #include <linux/err.h>
> +#include <linux/sched/signal.h>
>  #include <linux/slab.h>
>  #include <crypto/hash.h>
>  
> @@ -416,6 +417,12 @@ static int ima_calc_file_hash_atfm(struct file *file,
>  
>  		if (rbuf[1])
>  			active = !active; /* swap buffers, if we use two */
> +
> +		if (fatal_signal_pending(current)) {
> +			ahash_wait(ahash_rc, &wait);
> +			rc = -EINTR;
> +			goto out3;
> +		}

I think you'll need to rebase onto
https://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity.git/log/?h=next-integrity
since there is a patch queued up that removes ima_calc_file_hash_atfm().
So only ima_calc_file_hash_tfm() will need to be updated.

- Eric

