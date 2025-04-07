Return-Path: <linux-integrity+bounces-5632-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A3FDA7DB0E
	for <lists+linux-integrity@lfdr.de>; Mon,  7 Apr 2025 12:25:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A29611889F2E
	for <lists+linux-integrity@lfdr.de>; Mon,  7 Apr 2025 10:25:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C389B2309A3;
	Mon,  7 Apr 2025 10:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="h5KuDKWu"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EF1C230BF9
	for <linux-integrity@vger.kernel.org>; Mon,  7 Apr 2025 10:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744021525; cv=none; b=GTK5RPWH13GLYN1kfDhtcxZm9djIi2cY9Ykymd2t6o3so8ogi1vaglXNQUxqzOQtokN7tar973a9NllsPtrDQHV5EcO51ku14XtPLgyDlddCTpJwC3wldCUFm/B00UUh4Qq8nvJO+pvHwXSStoTG6GBGwHHTyLdftaJJlGd8JVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744021525; c=relaxed/simple;
	bh=vSDemQYLMUHcIJkwJO9z5VQsVFcRzmyxRV+CEHYxJHg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=LBU10YP2QRcZdcRx52S4zRGKsj6YFEOU9odVTdP+pPXWPmtMmJ0ABibXxWCccN1Vf+4C0kkzj+jyU5m52gEQwVwgjQ/BMKaOBpn7PkqboE1dmn5feCSU3XCCdppK8/n5UjQhUa6WlK90Sy+Gs6gNRVIyXIV5slSUDov6va+sHk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=h5KuDKWu; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20250407102515euoutp011cd2c7dbaafde30ef5c53c710f7465bc~0AlPkjLHj1377113771euoutp01P
	for <linux-integrity@vger.kernel.org>; Mon,  7 Apr 2025 10:25:15 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20250407102515euoutp011cd2c7dbaafde30ef5c53c710f7465bc~0AlPkjLHj1377113771euoutp01P
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1744021515;
	bh=b3jgyVp1WjN2SrubGqhVVTXB2JDlKhP+xrKg9JphgZ4=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=h5KuDKWullgi+IaAkSRDP9tCbqgTDw4z+IVG4ZfQdQWISQd6ETSjbL52gTUSgdF41
	 2wA2lmlPJgN5tFs7jO6kO7ELxmz29qnTRR2ic4MWFgK+DmEQRHbEvynGcUcdu7cEVF
	 S1R5eXD+N12ZspGHgzmf8vDdcryY+oEkkAXitMQ4=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTP id
	20250407102514eucas1p2aef29515258e8838adfaf55e376ecd90~0AlPMhH8R2818528185eucas1p2M;
	Mon,  7 Apr 2025 10:25:14 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
	eusmges3new.samsung.com (EUCPMTA) with SMTP id 25.51.20397.A08A3F76; Mon,  7
	Apr 2025 11:25:14 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20250407102514eucas1p1b297b7b6012a5ece4ccdca8e0e2c7956~0AlOy9QZ71016810168eucas1p1J;
	Mon,  7 Apr 2025 10:25:14 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
	eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20250407102514eusmtrp219560910c2e30d5fd2b8b60a88672a1d~0AlOx593Q0851708517eusmtrp2g;
	Mon,  7 Apr 2025 10:25:14 +0000 (GMT)
X-AuditID: cbfec7f5-ed1d670000004fad-03-67f3a80aee56
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
	eusmgms2.samsung.com (EUCPMTA) with SMTP id 2B.EE.19654.A08A3F76; Mon,  7
	Apr 2025 11:25:14 +0100 (BST)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20250407102512eusmtip1209425bd8b7d21207fdae8bf927b7790~0AlNlkBQ82831628316eusmtip1n;
	Mon,  7 Apr 2025 10:25:12 +0000 (GMT)
Message-ID: <32c1e996-ac34-496f-933e-a266b487da1a@samsung.com>
Date: Mon, 7 Apr 2025 12:25:11 +0200
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7] KEYS: Add a list for unreferenced keys
To: Jarkko Sakkinen <jarkko@kernel.org>, keyrings@vger.kernel.org
Cc: Jarkko Sakkinen <jarkko.sakkinen@opinsys.com>, stable@vger.kernel.org,
	David Howells <dhowells@redhat.com>, Lukas Wunner <lukas@wunner.de>, Ignat
	Korchagin <ignat@cloudflare.com>, Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>, Peter Huewe <peterhuewe@gmx.de>,
	Jason Gunthorpe <jgg@ziepe.ca>, Paul Moore <paul@paul-moore.com>, James
	Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, James
	Bottomley <James.Bottomley@HansenPartnership.com>, Mimi Zohar
	<zohar@linux.ibm.com>, linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
	linux-security-module@vger.kernel.org
Content-Language: en-US
From: Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <20250407023918.29956-1-jarkko@kernel.org>
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01Sf1CTZRzv2d69e7dr9jJAnhhIzuAOlSGm8XSSB2XdW9dRncllHsjQ14Hx
	wzap9K9FMHJgrP3hYKNc87jICwQaO5JAQ2Bz4OahErDJ7rh544cEtKwGF8bLO4v/Pt/P9/P5
	fr7f5x6CK67BY4mi0tO0slReLMWFmG0w5EoRNgcVu9rHE1CjuxJDv1WsYKhmNg71fenkofY6
	ApmGNADpQzqAGuodALVeucRBnd4KHPkmQxzkcA3y0Z2rjTharJ3C0XRAgjx6A4bme0N85L7t
	4iNz+xRAX6uH8Mwoasmkwynr9+McanEpj7JdT6RGuw9TF/ROnOq4fA6ndJbrgKr96xg1cqsV
	p1p6pgG10HsPp4IdW6j6ahuP6gx6sHee+UCYcZwuLvqYVqbuzxcW3l1uwU4NH/q05/EkTw36
	X9MCAQHJPdDg8PO0QEiIyWYAZ87pAVv8AaDX2s1niyCA13wj2BOLI1AZbnwHoP0HZ9iyBKCj
	8hucUYnI/dCoq1pzEARGPg8ffPUeS0fAmw3+9UHRZAL0TdTzGRy5Jm9r6+IxOIrMgjeM5zFm
	Jpds4sF/7mvWRVwyBk74L3IYjJNpUDuvXc8SkOlwRWMIaxLg550mLmOG5KoAzjVbeOzaB+CA
	/S5gcSSctVv5LI6Dj39ihjKGagDNK75woQNQHZgIO/ZBr2sZZ87hksnwytVUls6Cno4FwNCQ
	3ATH5iPYJTZBvc3AZWkR/EIjZtVJ0Ghv/S/2l9sjXB2QGje8i3HDmcYN5xj/zzUD7DKIoctV
	JQpa9UIp/YlMJS9RlZcqZMfKSjrA2n8dWrU/6gLNs0uyPsAhQB+ABFcaJXrJ+btCLDouP3OW
	VpYdVZYX06o+ICEwaYzIcq1KISYV8tP0hzR9ilY+6XIIQayag295NLZ3R8G+CrHsTGpvC53x
	MCF2c3/D+UZr8hsuU+FHWqfbLxvcPLwzqbF64OKNlBLrm0UFwwsnsvgCT9P25byumb1IE5EY
	Ny3pPyGLHeg2x794su2BP/Dc8MEcyVD7mKHmyDjicWixJSb3KUtkfPeOg5zVPVOFGT/Oa+N3
	H/7sz7Rp15FXQedkOuGNXrzTpk2pmwtubfE6LriB/ucmnX7r368kuU3feryybYq6iaPvHkjO
	qZzLfD174eTNFXPrrV21M5fyRfe2jT6MOJT3tC8hS5I7mhmf+7L67O6uwejUsd7s+29PORPt
	GkXPr6GC/Oj0SVv2+06J6dm3Aju1OWVVUkxVKE/bzlWq5P8CdAPWnB4EAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprDKsWRmVeSWpSXmKPExsVy+t/xu7pcKz6nG8w8wm4x53wLi8W7pt8s
	Ft2vZCwO9Z1itdjYz2Ex+3Qbo8WknxMYLWbOOMFosW79YiaLrXea2Czu3/vJZHHi3DF2i8u7
	5rBZfOh5xGbx4rm0xe1J01ks3u77yW5x/sI5dosFGx8xWsxtOM3mIOLxcfYENo8tK28yeXz4
	GOex7YCqx7XdkR7TJp1i89i0qpPNY8KiA4wePd+TPS6dXcfmsXbvC0aP9/uusnl83iTnMaN9
	G6vH1s+3WQL4o/RsivJLS1IVMvKLS2yVog0tjPQMLS30jEws9QyNzWOtjEyV9O1sUlJzMstS
	i/TtEvQyrvxay1JwJrRi7/97rA2MR1y7GDk5JARMJE48b2HvYuTiEBJYyihx8etqdoiEjMTJ
	aQ2sELawxJ9rXWwQRe8ZJZbe3QiW4BWwk5g1oZWli5GDg0VAReLpxBCIsKDEyZlPWEBsUQF5
	ifu3ZoDNFAYq37BhB1iriICjxOFZvSwgM5kFlrNKfL6ynA0kISRgJrF1+UIwm1lAXOLWk/lM
	IDabgKFE19susDingLnE77bp7BA1ZhJdW7sYIWx5ieats5knMArNQnLHLCSjZiFpmYWkZQEj
	yypGkdTS4tz03GIjveLE3OLSvHS95PzcTYzAZLLt2M8tOxhXvvqod4iRiYPxEKMEB7OSCK/l
	qU/pQrwpiZVVqUX58UWlOanFhxhNgWExkVlKNDkfmM7ySuINzQxMDU3MLA1MLc2MlcR52a6c
	TxMSSE8sSc1OTS1ILYLpY+LglGpgWnnH/us/sRcRwYwfz+r+ERFdHjyd8caPNOZlW1Wvzl91
	nGdB7LN8PqZNHOJbtAW+lH4zrRGvyDq4/nlDBOPhjl8SAn4Bd9ysLcQf5Qf8PuGy6Op3wQWS
	sq6xDeIH7wRUW3PkSfH7/jnYHnCk+8SGWdvXWTaWqX3P1vgi6zbbfMnypgiV9dUSOppe5zMO
	RxV1rbn2X/B031Gxr+eydn2b5r9i1pMrJUWP3jQvEXv4ZmaAzYoTi+OTA3ec8N99tExC4XJH
	hs/RW4vM7rff3XV8oVHucdGGsj9G28rj9128nLP6ukvplKrLScJ2YSfetp532tGq+nTth8Nf
	Ft3IDKv//2WCNoeSbZGf+M3Iag/B10osxRmJhlrMRcWJAPsw/hivAwAA
X-CMS-MailID: 20250407102514eucas1p1b297b7b6012a5ece4ccdca8e0e2c7956
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20250407102514eucas1p1b297b7b6012a5ece4ccdca8e0e2c7956
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20250407102514eucas1p1b297b7b6012a5ece4ccdca8e0e2c7956
References: <20250407023918.29956-1-jarkko@kernel.org>
	<CGME20250407102514eucas1p1b297b7b6012a5ece4ccdca8e0e2c7956@eucas1p1.samsung.com>

On 07.04.2025 04:39, Jarkko Sakkinen wrote:
> From: Jarkko Sakkinen <jarkko.sakkinen@opinsys.com>
>
> Add an isolated list of unreferenced keys to be queued for deletion, and
> try to pin the keys in the garbage collector before processing anything.
> Skip unpinnable keys.
>
> Use this list for blocking the reaping process during the teardown:
>
> 1. First off, the keys added to `keys_graveyard` are snapshotted, and the
>     list is flushed. This the very last step in `key_put()`.
> 2. `key_put()` reaches zero. This will mark key as busy for the garbage
>     collector.
> 3. `key_garbage_collector()` will try to increase refcount, which won't go
>     above zero. Whenever this happens, the key will be skipped.
>
> Cc: stable@vger.kernel.org # v6.1+
> Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@opinsys.com>

This patch landed in today's linux-next as commit b0d023797e3e ("keys: 
Add a list for unreferenced keys"). In my tests I found that it triggers 
the following lockdep issue:

================================
WARNING: inconsistent lock state
6.15.0-rc1-next-20250407 #15630 Not tainted
--------------------------------
inconsistent {SOFTIRQ-ON-W} -> {IN-SOFTIRQ-W} usage.
ksoftirqd/3/32 [HC0[0]:SC1[1]:HE1:SE0] takes:
c13fdd68 (key_serial_lock){+.?.}-{2:2}, at: key_put+0x74/0x128
{SOFTIRQ-ON-W} state was registered at:
   lock_acquire+0x134/0x384
   _raw_spin_lock+0x38/0x48
   key_alloc+0x2fc/0x4d8
   keyring_alloc+0x40/0x90
   system_trusted_keyring_init+0x50/0x7c
   do_one_initcall+0x68/0x314
   kernel_init_freeable+0x1c0/0x224
   kernel_init+0x1c/0x12c
   ret_from_fork+0x14/0x28
irq event stamp: 234
hardirqs last  enabled at (234): [<c0cb7060>] 
_raw_spin_unlock_irqrestore+0x5c/0x60
hardirqs last disabled at (233): [<c0cb6dd0>] 
_raw_spin_lock_irqsave+0x64/0x68
softirqs last  enabled at (42): [<c013bcd8>] handle_softirqs+0x328/0x520
softirqs last disabled at (47): [<c013bf10>] run_ksoftirqd+0x40/0x68

other info that might help us debug this:
  Possible unsafe locking scenario:

        CPU0
        ----
   lock(key_serial_lock);
   <Interrupt>
     lock(key_serial_lock);

  *** DEADLOCK ***

1 lock held by ksoftirqd/3/32:
  #0: c137c040 (rcu_callback){....}-{0:0}, at: rcu_core+0x4d0/0x14a4

stack backtrace:
CPU: 3 UID: 0 PID: 32 Comm: ksoftirqd/3 Not tainted 
6.15.0-rc1-next-20250407 #15630 PREEMPT
Hardware name: Samsung Exynos (Flattened Device Tree)
Call trace:
  unwind_backtrace from show_stack+0x10/0x14
  show_stack from dump_stack_lvl+0x68/0x88
  dump_stack_lvl from print_usage_bug.part.0+0x24c/0x270
  print_usage_bug.part.0 from mark_lock.part.0+0xc20/0x129c
  mark_lock.part.0 from __lock_acquire+0xafc/0x2970
  __lock_acquire from lock_acquire+0x134/0x384
  lock_acquire from _raw_spin_lock+0x38/0x48
  _raw_spin_lock from key_put+0x74/0x128
  key_put from put_cred_rcu+0x20/0xd0
  put_cred_rcu from rcu_core+0x478/0x14a4
  rcu_core from handle_softirqs+0x130/0x520
  handle_softirqs from run_ksoftirqd+0x40/0x68
  run_ksoftirqd from smpboot_thread_fn+0x17c/0x330
  smpboot_thread_fn from kthread+0x138/0x25c
  kthread from ret_from_fork+0x14/0x28
Exception stack(0xf090dfb0 to 0xf090dff8)
...

To fix this issue I had to change all calls around key_serial_lock and 
key_graveyard_lock spinlocks with the irqsave/irqrestore variants (in 
security/keys/key.c and security/keys/gc.c), but I'm not sure if this is 
desired solution.

> ---
> v7:
> - Fixed multiple definitions (from rebasing, sorry).
> v6:
> - Rebase went wrong in v5.
> v5:
> - Rebased on top of v6.15-rc
> - Updated commit message to explain how spin lock and refcount
>    isolate the time window in key_put().
> v4:
> - Pin the key while processing key type teardown. Skip dead keys.
> - Revert key_gc_graveyard back key_gc_unused_keys.
> - Rewrote the commit message.
> - "unsigned long flags" declaration somehow did make to the previous
>    patch (sorry).
> v3:
> - Using spin_lock() fails since key_put() is executed inside IRQs.
>    Using spin_lock_irqsave() would neither work given the lock is
>    acquired for /proc/keys. Therefore, separate the lock for
>    graveyard and key_graveyard before reaping key_serial_tree.
> v2:
> - Rename key_gc_unused_keys as key_gc_graveyard, and re-document the
>    function.
> ---
>   include/linux/key.h      |  7 ++-----
>   security/keys/gc.c       | 40 ++++++++++++++++++++++++----------------
>   security/keys/internal.h |  5 +++++
>   security/keys/key.c      |  7 +++++--
>   4 files changed, 36 insertions(+), 23 deletions(-)
>
> diff --git a/include/linux/key.h b/include/linux/key.h
> index ba05de8579ec..c50659184bdf 100644
> --- a/include/linux/key.h
> +++ b/include/linux/key.h
> @@ -195,10 +195,8 @@ enum key_state {
>   struct key {
>   	refcount_t		usage;		/* number of references */
>   	key_serial_t		serial;		/* key serial number */
> -	union {
> -		struct list_head graveyard_link;
> -		struct rb_node	serial_node;
> -	};
> +	struct list_head	graveyard_link; /* key->usage == 0 */
> +	struct rb_node		serial_node;
>   #ifdef CONFIG_KEY_NOTIFICATIONS
>   	struct watch_list	*watchers;	/* Entities watching this key for changes */
>   #endif
> @@ -236,7 +234,6 @@ struct key {
>   #define KEY_FLAG_ROOT_CAN_INVAL	7	/* set if key can be invalidated by root without permission */
>   #define KEY_FLAG_KEEP		8	/* set if key should not be removed */
>   #define KEY_FLAG_UID_KEYRING	9	/* set if key is a user or user session keyring */
> -#define KEY_FLAG_FINAL_PUT	10	/* set if final put has happened on key */
>   
>   	/* the key type and key description string
>   	 * - the desc is used to match a key against search criteria
> diff --git a/security/keys/gc.c b/security/keys/gc.c
> index f27223ea4578..0a3beb68633c 100644
> --- a/security/keys/gc.c
> +++ b/security/keys/gc.c
> @@ -189,6 +189,7 @@ static void key_garbage_collector(struct work_struct *work)
>   	struct rb_node *cursor;
>   	struct key *key;
>   	time64_t new_timer, limit, expiry;
> +	unsigned long flags;
>   
>   	kenter("[%lx,%x]", key_gc_flags, gc_state);
>   
> @@ -206,21 +207,35 @@ static void key_garbage_collector(struct work_struct *work)
>   
>   	new_timer = TIME64_MAX;
>   
> +	spin_lock_irqsave(&key_graveyard_lock, flags);
> +	list_splice_init(&key_graveyard, &graveyard);
> +	spin_unlock_irqrestore(&key_graveyard_lock, flags);
> +
> +	list_for_each_entry(key, &graveyard, graveyard_link) {
> +		spin_lock(&key_serial_lock);
> +		kdebug("unrefd key %d", key->serial);
> +		rb_erase(&key->serial_node, &key_serial_tree);
> +		spin_unlock(&key_serial_lock);
> +	}
> +
>   	/* As only this function is permitted to remove things from the key
>   	 * serial tree, if cursor is non-NULL then it will always point to a
>   	 * valid node in the tree - even if lock got dropped.
>   	 */
>   	spin_lock(&key_serial_lock);
> +	key = NULL;
>   	cursor = rb_first(&key_serial_tree);
>   
>   continue_scanning:
> +	key_put(key);
>   	while (cursor) {
>   		key = rb_entry(cursor, struct key, serial_node);
>   		cursor = rb_next(cursor);
> -
> -		if (test_bit(KEY_FLAG_FINAL_PUT, &key->flags)) {
> -			smp_mb(); /* Clobber key->user after FINAL_PUT seen. */
> -			goto found_unreferenced_key;
> +		/* key_get(), unless zero: */
> +		if (!refcount_inc_not_zero(&key->usage)) {
> +			key = NULL;
> +			gc_state |= KEY_GC_REAP_AGAIN;
> +			goto skip_dead_key;
>   		}
>   
>   		if (unlikely(gc_state & KEY_GC_REAPING_DEAD_1)) {
> @@ -274,6 +289,7 @@ static void key_garbage_collector(struct work_struct *work)
>   		spin_lock(&key_serial_lock);
>   		goto continue_scanning;
>   	}
> +	key_put(key);
>   
>   	/* We've completed the pass.  Set the timer if we need to and queue a
>   	 * new cycle if necessary.  We keep executing cycles until we find one
> @@ -286,6 +302,10 @@ static void key_garbage_collector(struct work_struct *work)
>   		key_schedule_gc(new_timer);
>   	}
>   
> +	spin_lock(&key_graveyard_lock);
> +	list_splice_init(&key_graveyard, &graveyard);
> +	spin_unlock(&key_graveyard_lock);
> +
>   	if (unlikely(gc_state & KEY_GC_REAPING_DEAD_2) ||
>   	    !list_empty(&graveyard)) {
>   		/* Make sure that all pending keyring payload destructions are
> @@ -328,18 +348,6 @@ static void key_garbage_collector(struct work_struct *work)
>   	kleave(" [end %x]", gc_state);
>   	return;
>   
> -	/* We found an unreferenced key - once we've removed it from the tree,
> -	 * we can safely drop the lock.
> -	 */
> -found_unreferenced_key:
> -	kdebug("unrefd key %d", key->serial);
> -	rb_erase(&key->serial_node, &key_serial_tree);
> -	spin_unlock(&key_serial_lock);
> -
> -	list_add_tail(&key->graveyard_link, &graveyard);
> -	gc_state |= KEY_GC_REAP_AGAIN;
> -	goto maybe_resched;
> -
>   	/* We found a restricted keyring and need to update the restriction if
>   	 * it is associated with the dead key type.
>   	 */
> diff --git a/security/keys/internal.h b/security/keys/internal.h
> index 2cffa6dc8255..4e3d9b322390 100644
> --- a/security/keys/internal.h
> +++ b/security/keys/internal.h
> @@ -63,9 +63,14 @@ struct key_user {
>   	int			qnbytes;	/* number of bytes allocated to this user */
>   };
>   
> +extern struct list_head key_graveyard;
> +extern spinlock_t key_graveyard_lock;
> +
>   extern struct rb_root	key_user_tree;
>   extern spinlock_t	key_user_lock;
>   extern struct key_user	root_key_user;
> +extern struct list_head	key_graveyard;
> +extern spinlock_t	key_graveyard_lock;
>   
>   extern struct key_user *key_user_lookup(kuid_t uid);
>   extern void key_user_put(struct key_user *user);
> diff --git a/security/keys/key.c b/security/keys/key.c
> index 7198cd2ac3a3..7511f2017b6b 100644
> --- a/security/keys/key.c
> +++ b/security/keys/key.c
> @@ -22,6 +22,8 @@ DEFINE_SPINLOCK(key_serial_lock);
>   
>   struct rb_root	key_user_tree; /* tree of quota records indexed by UID */
>   DEFINE_SPINLOCK(key_user_lock);
> +LIST_HEAD(key_graveyard);
> +DEFINE_SPINLOCK(key_graveyard_lock);
>   
>   unsigned int key_quota_root_maxkeys = 1000000;	/* root's key count quota */
>   unsigned int key_quota_root_maxbytes = 25000000; /* root's key space quota */
> @@ -658,8 +660,9 @@ void key_put(struct key *key)
>   				key->user->qnbytes -= key->quotalen;
>   				spin_unlock_irqrestore(&key->user->lock, flags);
>   			}
> -			smp_mb(); /* key->user before FINAL_PUT set. */
> -			set_bit(KEY_FLAG_FINAL_PUT, &key->flags);
> +			spin_lock_irqsave(&key_graveyard_lock, flags);
> +			list_add_tail(&key->graveyard_link, &key_graveyard);
> +			spin_unlock_irqrestore(&key_graveyard_lock, flags);
>   			schedule_work(&key_gc_work);
>   		}
>   	}

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland


