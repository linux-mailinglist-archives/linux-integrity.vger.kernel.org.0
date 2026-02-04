Return-Path: <linux-integrity+bounces-8444-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uOPtEWg9g2kPkQMAu9opvQ
	(envelope-from <linux-integrity+bounces-8444-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Wed, 04 Feb 2026 13:36:56 +0100
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7834CE5DF4
	for <lists+linux-integrity@lfdr.de>; Wed, 04 Feb 2026 13:36:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 47E423005163
	for <lists+linux-integrity@lfdr.de>; Wed,  4 Feb 2026 12:36:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8E603F23A0;
	Wed,  4 Feb 2026 12:36:34 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from frasgout12.his.huawei.com (frasgout12.his.huawei.com [14.137.139.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96A9A24DFF3;
	Wed,  4 Feb 2026 12:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770208594; cv=none; b=uACnV36OwRwJrqC1kwNLjYdCD4xgmffbL8wbkv0rRk+OjjP5azk4DUp+kvR/twc83R12TNAnb3Be0PQw2phiKxw5Flih/qXpgPkOd2TVIQz9D/Pt8/2JNhArENZgiDXdJSZ5mvD/Pd/M7lT+cSkDonJ/A3EvZFLdo/iMN1frR1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770208594; c=relaxed/simple;
	bh=sWQufUt4Wl8FLh8zolfcswlckPOBFwgWTQYpLXo+15E=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hToVfQnNQSL9vbyotQYaUavaQ2q2WtYAAe0jW8B94lIPtHGbe13fFro3WgXa3qGHgmoHBa5kjtE2Q2dltOMH4637oQ7DN57PeAhYSk78eMVm8JAJ0AjLUlKIeLjapRQftE3B8Li7r5cS8lUjnzegkRkk7/xwN86tA+XL1RuhDAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.224.196])
	by frasgout12.his.huawei.com (SkyGuard) with ESMTPS id 4f5fsk53y5zvbBV;
	Wed,  4 Feb 2026 20:33:46 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.27])
	by mail.maildlp.com (Postfix) with ESMTP id DF2AF40565;
	Wed,  4 Feb 2026 20:36:24 +0800 (CST)
Received: from [10.204.63.22] (unknown [10.204.63.22])
	by APP2 (Coremail) with SMTP id GxC2BwCHn2o6PYNpHysyAw--.45535S2;
	Wed, 04 Feb 2026 13:36:24 +0100 (CET)
Message-ID: <c449523aef301a6b199e06d4c3fbf7587d1218c5.camel@huaweicloud.com>
Subject: Re: [PATCH v5 3/3] ima: Use kstat.ctime as a fallback change
 detection for stacked fs
From: Roberto Sassu <roberto.sassu@huaweicloud.com>
To: Frederick Lawler <fred@cloudflare.com>, Mimi Zohar
 <zohar@linux.ibm.com>,  Roberto Sassu <roberto.sassu@huawei.com>, Dmitry
 Kasatkin <dmitry.kasatkin@gmail.com>, Eric Snowberg
 <eric.snowberg@oracle.com>, Paul Moore <paul@paul-moore.com>, James Morris
 <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, "Darrick J.
 Wong" <djwong@kernel.org>, Christian Brauner <brauner@kernel.org>, Josef
 Bacik <josef@toxicpanda.com>, Jeff Layton <jlayton@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org, 
	linux-security-module@vger.kernel.org, kernel-team@cloudflare.com
Date: Wed, 04 Feb 2026 13:36:09 +0100
In-Reply-To: <20260130-xfs-ima-fixup-v5-3-57e84ea91712@cloudflare.com>
References: <20260130-xfs-ima-fixup-v5-0-57e84ea91712@cloudflare.com>
	 <20260130-xfs-ima-fixup-v5-3-57e84ea91712@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3-0ubuntu1 
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-CM-TRANSID:GxC2BwCHn2o6PYNpHysyAw--.45535S2
X-Coremail-Antispam: 1UD129KBjvJXoWxXw1kKryftw1fGFyDuw1DAwb_yoWrtry7pa
	1q9F1UKr48GFy2kFs7C3ZFka1Fg3yFgFyUW345K3W0yF13Z3Wjqr9xAryYvr90qrWYyw1x
	tFZYyr13Cw4qv3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvjb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWUJVW8JwA2z4x0Y4vEx4A2jsIEc7CjxV
	AFwI0_Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AF
	wI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
	xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5
	MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I
	0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWU
	JVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUoY
	FADUUUU
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgAOBGmCux4MagAAsg
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8444-lists,linux-integrity=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[16];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[huaweicloud.com];
	FREEMAIL_TO(0.00)[cloudflare.com,linux.ibm.com,huawei.com,gmail.com,oracle.com,paul-moore.com,namei.org,hallyn.com,kernel.org,toxicpanda.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[roberto.sassu@huaweicloud.com,linux-integrity@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.989];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[linux-integrity];
	DBL_BLOCKED_OPENRESOLVER(0.00)[cloudflare.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7834CE5DF4
X-Rspamd-Action: no action

On Fri, 2026-01-30 at 16:39 -0600, Frederick Lawler wrote:
> IMA performs unnecessary measurements on files in stacked file systems
> that do not set kstat.change_cookie to an inode's i_version.
>=20
> For example: TMPFS (upper) is stacked onto XFS (lower).
> Actions files result in re-measurement because commit 1cf7e834a6fb
> ("xfs: switch to multigrain timestamps") introduced multigrain
> timestamps into XFS which changed the kstat.change_cookie semantics
> to no longer supply an i_version to compare against in
> integrity_inode_attributes_changed(). Once the inode is in TMPFS,
> the change detection behavior operates as normal because TMPFS updates
> kstat.change_cookie to the i_version.
>=20
> Instead, fall back onto a ctime comparison. This also gives file systems
> that do not support i_version an opportunity avoid the same behavior,
> as they're more likely to have ctime support.
>=20
> timespec64_to_ns() is chosen to avoid adding extra storage to
> integrity_inode_attributes by leveraging the existing version field.

Correct me if I'm wrong, but this issue seems to me xfs-specific. In
that case, maybe it is better to remove the stacked filesystem part,
which might be misleading.

Thanks

Roberto

> Link: https://lore.kernel.org/all/aTspr4_h9IU4EyrR@CMGLRV3
> Fixes: 1cf7e834a6fb ("xfs: switch to multigrain timestamps")
> Suggested-by: Jeff Layton <jlayton@kernel.org>
> Signed-off-by: Frederick Lawler <fred@cloudflare.com>
> ---
>  include/linux/integrity.h         |  6 +++++-
>  security/integrity/ima/ima_api.c  | 11 ++++++++---
>  security/integrity/ima/ima_main.c |  2 +-
>  3 files changed, 14 insertions(+), 5 deletions(-)
>=20
> diff --git a/include/linux/integrity.h b/include/linux/integrity.h
> index 382c783f0fa3ae4a938cdf9559291ba1903a378e..ec2c94907f417c4a71ecce29a=
c79edac9bc2c6f8 100644
> --- a/include/linux/integrity.h
> +++ b/include/linux/integrity.h
> @@ -10,6 +10,7 @@
>  #include <linux/fs.h>
>  #include <linux/iversion.h>
>  #include <linux/kernel.h>
> +#include <linux/time64.h>
> =20
>  enum integrity_status {
>  	INTEGRITY_PASS =3D 0,
> @@ -58,6 +59,9 @@ integrity_inode_attrs_stat_changed
>  	if (stat->result_mask & STATX_CHANGE_COOKIE)
>  		return stat->change_cookie !=3D attrs->version;
> =20
> +	if (stat->result_mask & STATX_CTIME)
> +		return timespec64_to_ns(&stat->ctime) !=3D (s64)attrs->version;
> +
>  	return true;
>  }
> =20
> @@ -84,7 +88,7 @@ integrity_inode_attrs_changed(const struct integrity_in=
ode_attributes *attrs,
>  	 * only for IMA if vfs_getattr_nosec() fails.
>  	 */
>  	if (!file || vfs_getattr_nosec(&file->f_path, &stat,
> -				       STATX_CHANGE_COOKIE,
> +				       STATX_CHANGE_COOKIE | STATX_CTIME,
>  				       AT_STATX_SYNC_AS_STAT))
>  		return !IS_I_VERSION(inode) ||
>  		       !inode_eq_iversion(inode, attrs->version);
> diff --git a/security/integrity/ima/ima_api.c b/security/integrity/ima/im=
a_api.c
> index c35ea613c9f8d404ba4886e3b736c3bab29d1668..e47d6281febc15a0ac1bd2ea1=
d28fea4d0cd5c58 100644
> --- a/security/integrity/ima/ima_api.c
> +++ b/security/integrity/ima/ima_api.c
> @@ -272,10 +272,15 @@ int ima_collect_measurement(struct ima_iint_cache *=
iint, struct file *file,
>  	 * to an initial measurement/appraisal/audit, but was modified to
>  	 * assume the file changed.
>  	 */
> -	result =3D vfs_getattr_nosec(&file->f_path, &stat, STATX_CHANGE_COOKIE,
> +	result =3D vfs_getattr_nosec(&file->f_path, &stat,
> +				   STATX_CHANGE_COOKIE | STATX_CTIME,
>  				   AT_STATX_SYNC_AS_STAT);
> -	if (!result && (stat.result_mask & STATX_CHANGE_COOKIE))
> -		i_version =3D stat.change_cookie;
> +	if (!result) {
> +		if (stat.result_mask & STATX_CHANGE_COOKIE)
> +			i_version =3D stat.change_cookie;
> +		else if (stat.result_mask & STATX_CTIME)
> +			i_version =3D timespec64_to_ns(&stat.ctime);
> +	}
>  	hash.hdr.algo =3D algo;
>  	hash.hdr.length =3D hash_digest_size[algo];
> =20
> diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/i=
ma_main.c
> index 8cb17c9d446caaa5a98f5ec8f027c17ba7babca8..776db158b0bd8a0d053729ac0=
cc15af8b6020a98 100644
> --- a/security/integrity/ima/ima_main.c
> +++ b/security/integrity/ima/ima_main.c
> @@ -199,7 +199,7 @@ static void ima_check_last_writer(struct ima_iint_cac=
he *iint,
>  					    &iint->atomic_flags);
>  		if ((iint->flags & IMA_NEW_FILE) ||
>  		    vfs_getattr_nosec(&file->f_path, &stat,
> -				      STATX_CHANGE_COOKIE,
> +				      STATX_CHANGE_COOKIE | STATX_CTIME,
>  				      AT_STATX_SYNC_AS_STAT) ||
>  		    integrity_inode_attrs_stat_changed(&iint->real_inode,
>  						       &stat)) {
>=20


